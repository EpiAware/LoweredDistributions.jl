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
    m = mean(d)
    v = var(d)
    (isfinite(m) && isfinite(v) && m > 0 && v > 0) || throw(ArgumentError(
        "phase_type needs a finite positive mean and variance; got " *
        "mean = $m, var = $v for $(typeof(d))."))
    scv = v / m^2
    scv <= 1 && return ErlangChain(compartment_stages(d; moment_match = true))
    return _hyperexponential_fit(m, scv)
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
