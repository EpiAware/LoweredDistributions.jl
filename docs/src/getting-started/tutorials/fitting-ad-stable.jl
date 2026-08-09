md"""
# [Fitting a lowered distribution under AD, stably](@id fitting-ad-stable)

To fit a lowered delay inside a gradient-based sampler (Turing, say), the lowering has to be differentiable.
Lowering splits into two parts:

  - a **continuous** part — the phase **rate** — which an AD dual flows through cleanly;
  - a **discrete** part — the phase **count** `k`. The adaptive fit sets `k = round(1 / c²)`: a step function that also changes the `(α, S)` matrix dimension. You cannot differentiate through choosing how many compartments there are.

So an adaptive lowering that re-derives `k` from a sampled parameter is not AD-stable: a parameter crossing a rounding boundary steps `k` and the gradient is undefined there.
The recipe is to **fix the count outside the model and infer only the rate**.
"""

using LoweredDistributions
using Distributions

# `lower(d, PhaseType; phases = k)` builds a fixed `k`-stage Erlang whose rate matches `mean(d)`.
# The structure, and the `(α, S)` dimension, is the same whatever the distribution's value, so only the rate carries an AD dual.

lower(Gamma(3.0, 1.5), PhaseType; phases = 5)

md"""
## The gradient exists, even where the adaptive count would step

Differentiate the mean of a fixed-5-phase lowering of `Gamma(α, 1)` with respect to the shape `α`.
The mean is `α`, so the derivative is exactly one, and it stays exact across `α` values where the *adaptive* count `round(α)` would jump.
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
## Refitting: `update`, not another `lower`

`phases` is fixed once, above, by the call to `lower`. A fitting loop that
then calls `lower` again for every new candidate value throws that away: it
re-derives `k = round(1 / c²)` from whatever the value happens to be, which
is exactly the non-differentiable step the fixed-`phases` recipe exists to
avoid, and it repeats the extra work of choosing a structure that has
already been chosen.

The structure-preserving alternative is [`update`](@ref): it rebuilds a
lowering with new continuous parameters and the same structure, so it is
the operation to call inside the differentiated region — a sampler, an
optimiser — once `lower` has fixed `phases` outside it.
[`parameters`](@ref) reads the continuous values back out, and
`update(l, parameters(l)) == l` is the round trip between them.
"""

using LoweredDistributions: update, parameters

p = lower(Gamma(3.0, 1.5), PhaseType; phases = 5)
parameters(p)                            # (; α, S) — the continuous values

p2 = update(p, (; α = p.α, S = 2 .* p.S))   # same 5 phases, new rates
update(p2, parameters(p2)) == p2            # the round trip

md"""
`update` takes a flat `AbstractVector` too — the form a sampler actually
carries a proposal in, and the one whose `eltype` an AD dual flows through:
"""

update(p, vcat(p.α, vec(p.S))) == p

md"""
Inside a fitting loop this is the whole difference: `lower` runs once,
outside the loop, to choose `phases`; `update` runs on every iteration,
inside it, to move the continuous parameters without touching the structure
`lower` chose. Re-`lower`ing per iteration instead is both more expensive —
it repeats a decision already made — and, for anything but a hand-fixed
`phases`, reintroduces the rounding-boundary step this page starts from.

## The failure mode to avoid

  - **Letting `k` depend on a sampled parameter**: `lower(d, PhaseType)` without `phases` re-derives `k = round(1 / c²)` from the value, so the dimension steps at rounding boundaries and the gradient is undefined there. Fix `k`; infer the rate with `update`.

## See also

  - `lower(dist, PhaseType)` (Public API) for the full rationale — the type-instability this recipe avoids, and the `max_phases` memory cost fixing `phases` also sidesteps.
  - [`update`](@ref) / [`parameters`](@ref) (Public API) for every lowered type's parameter shape, not just `PhaseType`'s.
"""
