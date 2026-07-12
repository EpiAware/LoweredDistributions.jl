# Catalyst reaction-network bridge (stubs; methods in the Catalyst weakdep
# extension, `ext/LoweredDistributionsCatalystExt.jl`). Turning an
# AbstractChainTrick's compartment structure into an actual ODE/CTMC model
# needs a reaction-network framework; Catalyst.jl is kept optional so the core
# stays Distributions-only. This is also the seam a later wave's
# MTK/OrdinaryDiffEq, AlgebraicPetri, or JumpProcesses backend extension can
# dispatch from, alongside or instead of Catalyst.

"""
    linear_chain_reactions(chain::AbstractChainTrick, from, to; prefix = :stage)
    linear_chain_reactions(dist::Distribution, from, to; kwargs...)

Build the Catalyst reactions threading `from`, through one species per phase of
`chain` (or `lower(dist)`), to `to`.

Only defined when Catalyst.jl is loaded (`using Catalyst`); the methods live in
the `LoweredDistributionsCatalystExt` package extension.

The `Distribution` form needs `lower(dist) isa AbstractChainTrick`; a
distribution lowering to a bare [`CTMC`](@ref) (e.g. `lower(::Exponential)`,
the degenerate two-state form) is not a `from -> to` compartment pipe and is
out of scope for this bridge — pass `ErlangChain(dist)` explicitly, or lower it
via [`phase_type`](@ref) / [`compartment_stages`](@ref) directly, for the
Exponential/Erlang case.

# Arguments

  - `chain`: the [`AbstractChainTrick`](@ref) to build reactions for, or a
    `Distribution` that lowers to one.
  - `from`, `to`: the upstream and downstream Catalyst species.

# Keyword Arguments

  - `prefix`: a `Symbol` prefixing the generated sub-compartment species names
    (default `:stage`).

# Examples

```@example
using LoweredDistributions, Distributions, Catalyst

t = Catalyst.default_t()
@species From(t) To(t)
built = linear_chain_reactions(Gamma(3.0, 1.5), From, To; prefix = :I)
length(built.species)
```

# See also

  - [`reaction_system`](@ref): wraps this into a full `ReactionSystem`.
  - [`lower`](@ref), [`AbstractChainTrick`](@ref): produce the `chain` this
    reads.
"""
function linear_chain_reactions end

function linear_chain_reactions(args...; kwargs...)
    throw(ArgumentError("`linear_chain_reactions` needs Catalyst.jl; run " *
                        "`using Catalyst` to load the reaction-network extension."))
end

"""
    reaction_system(chain::AbstractChainTrick, from, to; prefix = :stage, name = :lowered)
    reaction_system(dist::Distribution, from, to; kwargs...)

Build a Catalyst `ReactionSystem` for `chain` (or `lower(dist)`) between the
`from` and `to` species — [`linear_chain_reactions`](@ref) wrapped into a
complete model, ready for the Catalyst/ModelingToolkit ODE, SDE, or jump
conversion.

Only defined when Catalyst.jl is loaded (`using Catalyst`); the method lives in
the `LoweredDistributionsCatalystExt` package extension.

# Arguments

  - `chain`: the [`AbstractChainTrick`](@ref) to build the system for, or a
    `Distribution` that lowers to one (see [`linear_chain_reactions`](@ref) for
    the scope of that form).
  - `from`, `to`: the upstream and downstream Catalyst species.

# Keyword Arguments

  - `prefix`: a `Symbol` prefixing the generated sub-compartment species names
    (default `:stage`).
  - `name`: the `ReactionSystem`'s name (default `:lowered`).

# Examples

```@example
using LoweredDistributions, Distributions, Catalyst

t = Catalyst.default_t()
@species From(t) To(t)
rs = reaction_system(Gamma(3.0, 1.5), From, To; name = :chain)
Catalyst.reactions(rs)
```

# See also

  - [`linear_chain_reactions`](@ref): the lower-level species/reaction builder
    this wraps.
"""
function reaction_system end

function reaction_system(args...; kwargs...)
    throw(ArgumentError("`reaction_system` needs Catalyst.jl; run " *
                        "`using Catalyst` to load the reaction-network extension."))
end
