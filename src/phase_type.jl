# The adaptive phase-type fit. Supersedes CensoredDistributions.jl's
# `_moment_stage` (which threw for an over-dispersed c² > 1 leaf): the c² ≤ 1
# branch delegates straight to `compartment_stages`'s moment matching (so that
# fit is not duplicated), and c² > 1 gets a genuine phase-type fit instead of
# an error.

"""
Adaptively fit a phase-type representation to `d` by matching its first two
moments.

Under-dispersed or exactly-dispersed (`c² = var(d) / mean(d)² ≤ 1`) delays fit
an [`ErlangChain`](@ref) exactly on the mean (the same moment match
[`compartment_stages`](@ref) performs). Over-dispersed delays (`c² > 1`) fit a
two-phase hyperexponential [`PhaseType`](@ref) (a mixture of two Exponentials)
by the balanced-means method: with `p = (1 + sqrt((c² - 1) / (c² + 1))) / 2`,
rates `λ₁ = 2p / mean(d)` and `λ₂ = 2(1 - p) / mean(d)` give a mixture with
`p`/`1 - p` phase weights that matches `mean(d)` and `c²` exactly. A sequential
chain (an [`ErlangChain`](@ref) or [`Coxian`](@ref)) cannot reach `c² > 1` —
only a branching (mixture) structure can, hence the different representation.

# Examples

```@example
using LoweredDistributions, Distributions

phase_type(Gamma(2.5, 1.0))     # c² = 0.4 ≤ 1 -> ErlangChain
phase_type(Gamma(0.5, 1.0))     # c² = 2 > 1   -> PhaseType (hyperexponential)
```

# See also

  - [`ErlangChain`](@ref), [`PhaseType`](@ref): the two representations this
    returns.
  - [`lower`](@ref): dispatches here for the over-dispersed case.
"""
function phase_type(d::Distribution)
    m, scv = _two_moments(d, "phase_type")
    scv <= 1 && return ErlangChain(compartment_stages(d; moment_match = true))
    return _hyperexponential_fit(m, scv)
end

# The `(mean, c²)` pair every two-moment fit reads, with the shared finite,
# positive guard. `caller` names the entry point in the error message.
function _two_moments(d::Distribution, caller::String)
    m = mean(d)
    v = var(d)
    (isfinite(m) && isfinite(v) && m > 0 && v > 0) || throw(ArgumentError(
        "$caller needs a finite positive mean and variance; got " *
        "mean = $m, var = $v for $(typeof(d))."))
    return m, v / m^2
end

# The canonical PhaseType of an Erlang chain fitted to `(m, scv)`, built
# directly as `(α, S)` rather than via `compartment_stages`/`ErlangChain`: the
# canonical form is a dense `k x k` sub-generator, so there is no reason to
# route through the compact chain representation and back. It keeps the element
# type of `m`, so this branch carries an AD dual (as does the `ErlangChain`
# path now that `ChainStage` is parametric on its rate — see `chain_stage.jl`).
# `k` is the same `round(1 / c²)` moment match `compartment_stages` performs,
# so the fitted chain has the same shape. The rate is recomputed from the
# moments (`k / m`) rather than read off an exact leaf's scale (`1 / θ`), so
# for an exact Exponential/Erlang the two can differ in the last ulp; they
# agree to floating-point tolerance, which the equivalence tests check.
#
# The one thing this form costs that `ErlangChain` does not: an explicit
# `k x k` sub-generator. An `ErlangChain` stores the same chain in a single
# `ChainStage` (`k` as an `Int`), so its memory does not grow with `k` at all,
# whereas `S` here is dense and `k` scales as `1 / c²` — a tight delay
# (`Normal(5, 0.001)`, `c² = 4e-8`) asks for 25 million phases and would
# exhaust memory before it ever returned. `max_phases` turns that into an
# actionable error instead of an `OutOfMemoryError`; a caller who genuinely
# wants a huge chain can raise it.
function _erlang_phase_type(m::Real, scv::Real, max_phases::Int)
    scv <= 1 || throw(ArgumentError(
        "an Erlang chain needs c² ≤ 1 (under-dispersed); got $scv"))
    phases = inv(scv)
    (isfinite(phases) && phases <= max_phases + 0.5) || throw(ArgumentError(
        "the canonical Erlang fit needs $(isfinite(phases) ?
            string(round(Int, phases)) : "infinitely many") phases for " *
        "c² = $scv, above the max_phases = $max_phases limit. The " *
        "sub-generator is dense (k x k), so this would allocate a matrix of " *
        "that size squared. Raise `max_phases` if you really want it, or " *
        "lower the distribution with `lower(dist)`, whose `ErlangChain` " *
        "stores the phase count rather than the matrix."))
    k = max(round(Int, phases), 1)
    return _fixed_erlang_phase_type(m, k)
end

# A `k`-stage Erlang chain as a canonical `PhaseType(α, S)`, its rate matched to
# the mean `m` (`rate = k / m`). The phase count `k` is supplied, not derived
# from the distribution's dispersion, so the α/S dimension does not depend on
# the value being lowered — the AD-stable building block behind the
# `phases`-keyword `lower`. Only the rate carries an AD dual; the structure is
# constant, so it differentiates on every backend.
function _fixed_erlang_phase_type(m::Real, k::Int)
    rate = k / m
    T = typeof(rate)
    # `zeros` + `setindex!` rather than a comprehension: on the Julia LTS,
    # inference does not prove the comprehension's element type, so `α` comes
    # back as `AbstractVector` and the whole method infers
    # `PhaseType{A, Matrix{T}} where A` — type-UNstable on exactly the release
    # the package supports and the AD backends care about. Building the array
    # explicitly pins `Vector{T}` on every supported version.
    α = zeros(T, k)
    α[1] = one(T)
    S = zeros(T, k, k)
    for i in 1:k
        S[i, i] = -rate
        i < k && (S[i, i + 1] = rate)
    end
    return PhaseType(α, S)
end

# The balanced-means two-moment hyperexponential fit (Whitt 1982): exact for
# any c² > 1. Verified by direct moment calculation in the test suite.
function _hyperexponential_fit(m::Real, scv::Real)
    scv > 1 || throw(ArgumentError(
        "the hyperexponential fit needs c² > 1 (over-dispersed); got $scv"))
    p = (1 + sqrt((scv - 1) / (scv + 1))) / 2
    λ1 = 2p / m
    λ2 = 2(1 - p) / m
    α = [p, 1 - p]
    S = [-λ1 zero(λ1); zero(λ2) -λ2]
    return PhaseType(α, S)
end
