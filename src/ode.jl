# ODE bridge (stub; method in the SciMLBase weakdep extension,
# `ext/LoweredDistributionsSciMLBaseExt.jl`). `SciMLBase.ODEProblem` only,
# never a solver algorithm: a package that wants `ode_problem`'s result
# just needs to `solve` it with whatever OrdinaryDiffEq-compatible algorithm
# it already depends on, so the core stays leaf-scope and this extension
# stays deliberately thin (no OrdinaryDiffEq/ModelingToolkit weakdep, just the
# common structural interface both build on).

"""
    ode_problem(m::AbstractLowering, tspan; u0 = nothing)

Build the linear forward-Kolmogorov ODE `du/dt = Q' u` for `m` as a
`SciMLBase.ODEProblem`, ready to `solve` with any OrdinaryDiffEq-compatible
algorithm.

`u` is the state-occupation probability vector: one entry per state
(`m.states` order) for a `CTMC`, or one entry per transient phase plus a
trailing absorbed-mass entry for an `AbstractChainTrick` (its canonical
[`PhaseType`](@ref) view, extended with the absorbing state). `sum(u)` is
conserved at 1 for every `t`.

Only defined when SciMLBase is loaded (`using SciMLBase`, or any package that
depends on it, e.g. `using OrdinaryDiffEq`); the method lives in the
`LoweredDistributionsSciMLBaseExt` package extension.

# Arguments

  - `m`: the [`AbstractLowering`](@ref) to build the ODE for.
  - `tspan`: the `(t0, t1)` integration span.

# Keyword Arguments

  - `u0`: the initial state-occupation vector. Defaults to a point mass on the
    first state (`CTMC`) or the phase-type's own initial distribution `α`
    (`AbstractChainTrick`, absorbed mass `0`).

# Examples

```@example
using LoweredDistributions, SciMLBase, OrdinaryDiffEqTsit5

model = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
prob = ode_problem(model, (0.0, 5.0))
sol = solve(prob, Tsit5())
sol.u[end]
```

# See also

  - [`lower`](@ref), [`CTMC`](@ref), [`AbstractChainTrick`](@ref): produce the
    `m` this reads.
  - [`reaction_system`](@ref): the Catalyst reaction-network alternative for
    the same lowering.
"""
function ode_problem end

function ode_problem(args...; kwargs...)
    throw(ArgumentError("`ode_problem` needs SciMLBase; run `using SciMLBase` " *
                        "(or `using OrdinaryDiffEq`) to load the ODE extension."))
end
