# Petri-net bridge (stub; method in the AlgebraicPetri weakdep extension,
# `ext/LoweredDistributionsAlgebraicPetriExt.jl`). Reads the same full
# state-space generator `ode_problem` does (see `src/generator.jl`), so a
# lowered distribution has one consistent numeric core feeding every backend
# extension.

"""
    petri_net(m::AbstractLowering; prefix = :state)

Build an `AlgebraicPetri.LabelledPetriNet` for `m`'s full state-space
generator, plus the name-indexed rate and initial-condition `Dict`s
`AlgebraicPetri.vectorfield`'s own mass-action ODE function needs (it indexes
`u`/`p` by species/transition name, not position).

Every off-diagonal generator entry `Q[i, j] > 0` becomes one Petri net
transition `state_i -> state_j` at that constant rate. Only defined when
AlgebraicPetri.jl is loaded (`using AlgebraicPetri`); the method lives in the
`LoweredDistributionsAlgebraicPetriExt` package extension.

AlgebraicPetri's own `vectorfield` also accepts a time/state-varying
`Function` rate per transition (its mass-action kinetics is more general than
this package needs), but every `AbstractLowering`'s generator is constant in
practice — a [`PhaseType`](@ref)'s `S` is type-constrained to
`<: AbstractMatrix{<:Real}` at construction, and a [`CTMC`](@ref)'s `Q` is
runtime-validated the same way by `_validate_generator` — so a
`Function`-valued rate should never reach here. The extension asserts this
explicitly at the entry point rather than relying on either upstream
guarantee alone.

# Arguments

  - `m`: the [`AbstractLowering`](@ref) to build the Petri net for, or a
    `Distribution` that lowers to one.

# Keyword Arguments

  - `prefix`: a `Symbol` prefixing the generated state names (default
    `:state`).

# Examples

```julia
using LoweredDistributions, Distributions, AlgebraicPetri

built = petri_net(Gamma(3.0, 1.5))
f! = vectorfield(built.petri_net)
du = Dict(k => 0.0 for k in keys(built.u0))
f!(du, built.u0, built.rates, 0.0)
```

Not a live `@example`: AlgebraicPetri's own Catalyst weakdep extension caps
Catalyst at a version incompatible with this package's own Catalyst
extension, so the two cannot load in the same doctest session. This exact
sequence — default `prefix`, `vectorfield`, and the `f!` call — is exercised
by name in the isolated `test/algebraic_petri` test environment instead (see
`test/algebraic_petri/petri.jl`).

# See also

  - [`ode_problem`](@ref), [`reaction_system`](@ref): the SciMLBase and
    Catalyst alternatives for the same lowering.
"""
function petri_net end

function petri_net(args...; kwargs...)
    throw(ArgumentError("`petri_net` needs AlgebraicPetri; run " *
                        "`using AlgebraicPetri` to load the Petri-net extension."))
end
