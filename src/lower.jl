# The lower(dist) dispatch table: Distribution -> AbstractLowering.

"""
    lower(dist::Distribution)

Lower a `Distribution` to a backend-agnostic dynamical-systems representation
(an [`AbstractLowering`](@ref)).

  - `Exponential` lowers to a two-state degenerate [`CTMC`](@ref) (`on ->
    absorbed` at the exponential's rate) — the trivial case of the CTMC fast
    path.
  - `Gamma` (including integer-shape Erlang) lowers to an [`ErlangChain`](@ref)
    when `c² = var / mean² ≤ 1` (always true for `shape ≥ 1`), and to a
    [`phase_type`](@ref) fit otherwise.
  - Any other `Distribution` lowers via the adaptive [`phase_type`](@ref) fit.

# Arguments

  - `dist`: the `Distribution` to lower.

# Examples

```@example
using LoweredDistributions, Distributions

lower(Exponential(2.0))               # CTMC(2 states)
lower(Gamma(3.0, 1.5))                # ErlangChain(3 compartments)
lower(Gamma(0.5, 1.0))                # PhaseType(2 phases), c² = 2 > 1
```

# See also

  - [`AbstractLowering`](@ref), [`AbstractChainTrick`](@ref): the hierarchy.
  - [`ctmc`](@ref), [`ErlangChain`](@ref), [`phase_type`](@ref): the
    representations this dispatches to.
"""
function lower(d::Exponential)
    rate = inv(scale(d))
    return ctmc(:on => (:absorbed => rate))
end

function lower(d::Gamma)
    scv = 1 / shape(d)
    scv <= 1 && return ErlangChain(compartment_stages(d; moment_match = true))
    return phase_type(d)
end

lower(d::Distribution) = phase_type(d)
