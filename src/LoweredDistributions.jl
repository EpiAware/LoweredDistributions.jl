"""
    LoweredDistributions

A distribution-lowering hub: [`lower`](@ref) maps a `Distributions`
`Distribution` onto a backend-agnostic dynamical-systems representation, an
[`AbstractLowering`](@ref).

Two branches populate the hierarchy:

  - the phase-type branch, [`AbstractChainTrick`](@ref) — [`ErlangChain`](@ref),
    [`Coxian`](@ref), and [`PhaseType`](@ref), all built from a finite
    absorbing Markov chain over exponential phases, and all convertible to the
    canonical `PhaseType(α, S)` view;
  - the memoryless generator, [`CTMC`](@ref), built with [`ctmc`](@ref).

[`lower`](@ref) dispatches a `Distribution` to one of these; [`phase_type`](@ref)
is the adaptive two-moment fit ([`ErlangChain`](@ref) for `c² ≤ 1`,
[`PhaseType`](@ref) for `c² > 1`) `lower` uses for anything without an exact
lowering. Four weak-dependency extensions turn any [`AbstractLowering`](@ref)
into a backend object: Catalyst.jl (reaction-network `Reaction`s via
[`linear_chain_reactions`](@ref), or a full `ReactionSystem` via
[`reaction_system`](@ref)), SciMLBase.jl (the linear forward-Kolmogorov
`ODEProblem` via [`ode_problem`](@ref)), AlgebraicPetri.jl
(a `LabelledPetriNet` via [`petri_net`](@ref)), and JumpProcesses.jl
(an exact-simulation `JumpProblem` via [`jump_problem`](@ref)).

```@example
using LoweredDistributions, Distributions

lower(Exponential(2.0))
lower(Gamma(3.0, 1.5))
```
"""
module LoweredDistributions

# All genuine module-scope `using`/`import` statements live here, in
# the main module file, rather than scattered across included files.
using Distributions: Distribution, Exponential, Gamma, scale, shape
using DocStringExtensions: @template, DOCSTRING, EXPORTS, IMPORTS,
                           TYPEDEF, TYPEDFIELDS, TYPEDSIGNATURES
using LinearAlgebra: I
using Statistics: mean, var

# Register the standard EpiAware docstring conventions before any
# docstrings are defined (see src/docstrings.jl).
include("docstrings.jl")

# --- Locked type hierarchy --------------------------------------------------

@doc """
Root of the distribution-lowering hierarchy.

A backend-agnostic dynamical-systems representation that [`lower`](@ref)
produces from a `Distributions.Distribution`. [`CTMC`](@ref) subtypes this
directly; the phase-type representations subtype it through
[`AbstractChainTrick`](@ref).
"""
abstract type AbstractLowering end

@doc """
Phase-type branch of [`AbstractLowering`](@ref).

Representations built from a finite absorbing Markov chain over exponential
phases: [`ErlangChain`](@ref), [`Coxian`](@ref), and [`PhaseType`](@ref). Every
concrete subtype converts to the canonical `PhaseType(α, S)` view (see
`PhaseType(::AbstractChainTrick)` methods), which is what a downstream backend
(e.g. the Catalyst extension) consumes.
"""
abstract type AbstractChainTrick <: AbstractLowering end

include("chain_stage.jl")
include("chain_tricks.jl")
include("phase_type.jl")
include("convolve.jl")
include("ctmc.jl")
include("lower.jl")
include("update.jl")
include("reaction_compartments.jl")
include("generator.jl")
include("ode.jl")
include("petri.jl")
include("jump.jl")

export lower
export update, parameters
export ChainStage, compartment_stages
export ErlangChain, Coxian, PhaseType, phase_type
export CTMC, ctmc, transition_probability, state_index
export linear_chain_reactions, reaction_system
export ode_problem
export petri_net
export jump_problem

# Public API - functions that are part of the public interface but not
# exported (Julia 1.11+).
@static if VERSION >= v"1.11"
    include("public.jl")
end

end # module LoweredDistributions
