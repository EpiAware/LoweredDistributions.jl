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
# directly rather than via `compartment_stages`/`ErlangChain`: `ChainStage`
# stores its rate in a concrete `Float64` field, which is deliberate for the
# structural chain representation but is a wall for an AD dual. Going straight
# to `(α, S)` keeps the element type of `m`, so this branch differentiates.
# `k` is the same `round(1 / c²)` moment match `compartment_stages` performs,
# so the fitted chain has the same shape. The rate is recomputed from the
# moments (`k / m`) rather than read off an exact leaf's scale (`1 / θ`), so
# for an exact Exponential/Erlang the two can differ in the last ulp; they
# agree to floating-point tolerance, which the equivalence tests check.
function _erlang_phase_type(m::Real, scv::Real)
    scv <= 1 || throw(ArgumentError(
        "an Erlang chain needs c² ≤ 1 (under-dispersed); got $scv"))
    k = max(round(Int, inv(scv)), 1)
    rate = k / m
    T = typeof(rate)
    α = [j == 1 ? one(T) : zero(T) for j in 1:k]
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
