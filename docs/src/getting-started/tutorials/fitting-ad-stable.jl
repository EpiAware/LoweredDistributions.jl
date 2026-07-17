md"""
# [Fitting a lowered distribution under AD, stably](@id fitting-ad-stable)

To fit a lowered delay inside a gradient-based sampler (Turing, say), the
lowering has to be differentiable. Lowering splits into two parts:

  - a **continuous** part — the phase **rate** — which an AD dual flows through
    cleanly;
  - a **discrete** part — the phase **count** `k`. The adaptive fit sets
    `k = round(1 / c²)`: a step function that also changes the `(α, S)` matrix
    dimension. You cannot differentiate through choosing how many compartments
    there are.

So an adaptive lowering that re-derives `k` from a sampled parameter is not
AD-stable — a parameter crossing a rounding boundary steps `k` and the gradient
is undefined there. The recipe is to **fix the count outside the model and
infer only the rate**.
"""

using LoweredDistributions
using Distributions

# `lower(d, PhaseType; phases = k)` builds a fixed `k`-stage Erlang whose rate
# matches `mean(d)`. The structure — and the `(α, S)` dimension — is the same
# whatever the distribution's value, so only the rate carries an AD dual.

lower(Gamma(3.0, 1.5), PhaseType; phases = 5)

md"""
## The gradient exists — even where the adaptive count would step

Differentiate the mean of a fixed-5-phase lowering of `Gamma(α, 1)` with
respect to the shape `α`. The mean is `α`, so the derivative is exactly one —
and it stays exact across `α` values where the *adaptive* count `round(α)`
would jump.
"""

using ForwardDiff
using LinearAlgebra

## Mean of a phase-type: α'(-S)⁻¹1. With `phases` fixed it equals `mean(dist)`.
function fixed_mean(α)
    p = lower(Gamma(α, 1.0), PhaseType; phases = 5)
    return -sum(transpose(p.α) * inv(p.S))
end

ForwardDiff.derivative(fixed_mean, 3.0)   # d/dα mean = 1.0, no step at α = 3.5

md"""
## In a Turing model

Keep `phases` a **constant** — chosen from a point estimate or domain knowledge
— and put a prior on the continuous parameter only:

```julia
@model function fit_delay(y)
    θ ~ LogNormal(0.0, 1.0)                              # continuous — inferred
    delay = lower(Gamma(3.0, θ), PhaseType; phases = 5)  # k fixed at 5
    ## ... use `delay`'s generator / survival in the likelihood for `y` ...
end
```

The sampler differentiates through `θ` on the fixed-`k` structure; `k` never
enters the sampled space, so there is no discrete quantity to differentiate,
and the gradient is defined on every backend the package tests — Enzyme
included.

## The failure modes to avoid

  - **`lower(d)`** (the adaptive dispatch) returns `Union{ErlangChain,
    PhaseType}` — a type-unstable return that breaks Enzyme outright. Use
    `lower(d, PhaseType; phases = k)` on a differentiated path, never the
    one-argument form.
  - **Letting `k` depend on a sampled parameter** — `lower(d, PhaseType)`
    without `phases` re-derives `k = round(1 / c²)` from the value, so the
    dimension steps at rounding boundaries and the gradient is undefined there.
    Fix `k`; infer the rate.
"""
