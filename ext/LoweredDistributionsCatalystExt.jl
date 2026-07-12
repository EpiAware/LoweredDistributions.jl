module LoweredDistributionsCatalystExt

# Catalyst.jl bridge: turns any AbstractChainTrick's canonical PhaseType(α, S)
# view into Catalyst Reactions, so a lowered delay can be slotted onto a
# transition of a reaction network. Ported and generalised from
# CensoredDistributions.jl's `CensoredDistributionsCatalystExt` (which built
# reactions straight off an Erlang `(rate, stages)` chain); routing through
# `PhaseType` here means the SAME builder covers ErlangChain, Coxian, and a
# genuinely branching PhaseType (the over-dispersed hyperexponential fit),
# rather than one builder per representation.

import LoweredDistributions: linear_chain_reactions, reaction_system
using LoweredDistributions: AbstractChainTrick, PhaseType, lower
using Distributions: Distribution
using Catalyst: Catalyst, Reaction, ReactionSystem, @species, default_t

function _phase_species(k::Int, prefix::Symbol)
    t = default_t()
    return Any[(@species $(Symbol(prefix, j))(t))[1] for j in 1:k]
end

# Build the entry (from -> each phase), internal (phase -> phase, off-diagonal
# S), and exit (phase -> to, the row shortfall) reactions for a canonical
# phase-type.
#
# Every entry reaction consumes the SAME `from` species, so Catalyst's
# mass-action semantics make them race: an individual is routed to phase `j`
# with probability `rate_j / sum(rate)`. To reproduce `α_j` exactly, every
# entry rate must share one common factor `μ`, giving
# `(α_j μ) / (μ sum(α)) = α_j` (μ cancels). Scaling each rate by phase `j`'s
# OWN exit rate instead (i.e. `α_j * (-S[j, j])`) would let the entry race be
# biased by relative phase speed rather than α — wrong whenever more than one
# phase has α_j > 0 (the branching / hyperexponential case). `μ = -S[1, 1]`
# (phase 1's own exit rate, always > 0 by the PhaseType sub-generator
# invariant) is an arbitrary-but-fixed positive reference; for a Coxian/
# ErlangChain (single-entry α = [1, 0, ...]) this reduces to the original
# CensoredDistributions.jl convention (entry rate = phase 1's exit rate)
# exactly, since only the j = 1 term is ever built.
function _phasetype_reactions(pt::PhaseType, from, to, prefix::Symbol)
    k = length(pt.α)
    species = _phase_species(k, prefix)
    μ = -pt.S[1, 1]
    entry = Reaction[]
    for j in 1:k
        pt.α[j] > 0 &&
            push!(entry, Reaction(pt.α[j] * μ, [from], [species[j]]))
    end
    isempty(entry) && throw(ArgumentError(
        "the phase-type has no phase with positive initial probability"))
    internal = Reaction[]
    for i in 1:k, j in 1:k

        i == j && continue
        pt.S[i, j] > 0 &&
            push!(internal, Reaction(pt.S[i, j], [species[i]], [species[j]]))
    end
    for i in 1:k
        exit_rate = -sum(pt.S[i, :])
        exit_rate > 0 && push!(internal, Reaction(exit_rate, [species[i]], [to]))
    end
    return (species = species, reactions = vcat(entry, internal),
        entry = entry, internal = internal)
end

function linear_chain_reactions(
        chain::AbstractChainTrick, from, to; prefix::Symbol = :stage)
    return _phasetype_reactions(PhaseType(chain), from, to, prefix)
end

function linear_chain_reactions(
        dist::Distribution, from, to; prefix::Symbol = :stage)
    return linear_chain_reactions(lower(dist), from, to; prefix)
end

function reaction_system(
        chain::AbstractChainTrick, from, to;
        prefix::Symbol = :stage, name::Symbol = :lowered)
    built = linear_chain_reactions(chain, from, to; prefix)
    return ReactionSystem(built.reactions, default_t(); name)
end

function reaction_system(dist::Distribution, from, to; kwargs...)
    return reaction_system(lower(dist), from, to; kwargs...)
end

end
