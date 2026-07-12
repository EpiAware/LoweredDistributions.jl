# JumpProcesses bridge (stub; method in the JumpProcesses weakdep extension,
# `ext/LoweredDistributionsJumpProcessesExt.jl`). Reads the same full
# state-space generator `ode_problem`/`petri_net` do (see `src/generator.jl`),
# so a lowered distribution has one consistent numeric core feeding every
# backend extension.

"""
    jump_problem(m::AbstractLowering, tspan; u0 = nothing)

Build a `JumpProcesses.JumpProblem` that exactly simulates a single
individual jumping between `m`'s states at its generator rates (a
Gillespie/Doob sample path of the underlying continuous-time Markov chain).
Solving it (e.g. with `SSAStepper()`) draws one such path over `tspan`.

Every off-diagonal generator entry `Q[i, j] > 0` becomes one
`JumpProcesses.MassActionJump` transition `state_i -> state_j` at that
constant rate, applied to a per-state population count (`u`, integers), not
the occupation-probability vector `ode_problem` and `petri_net` use.

**Distributional interpretation.** For an `m` produced by [`lower`](@ref)
started from its *default* `u0` (a single individual deterministically in the
first/entry state — every [`ErlangChain`](@ref)/[`Coxian`](@ref)/[`CTMC`](@ref)
lowering, and any [`PhaseType`](@ref) with a one-hot `α`), the chain is
guaranteed to reach the absorbing state, and the time it first does so is one
exact draw from the `Distribution` that `m` lowers. This does NOT hold for an
arbitrary `m`: a hand-built [`ctmc`](@ref) need not have an absorbing state at
all (the simulation then just runs until `tspan` ends), and a `PhaseType` with
a genuine mixture `α` (e.g. from [`phase_type`](@ref)'s hyperexponential fit)
has no single deterministic starting state to default from — an explicit `u0`
there fixes the simulation to start from that one state, giving a draw from
the distribution *conditional on that starting phase*, not from the mixture
itself. To draw an exact mixture sample, sample the starting phase from `α`
yourself (e.g. `rand(Categorical(α))`) and pass the matching one-hot `u0`.

Only defined when JumpProcesses is loaded (`using JumpProcesses`); the method
lives in the `LoweredDistributionsJumpProcessesExt` package extension.

# Arguments

  - `m`: the [`AbstractLowering`](@ref) to build the jump process for, or a
    `Distribution` that lowers to one.
  - `tspan`: the `(t0, t1)` simulation span.

# Keyword Arguments

  - `u0`: the initial per-state population counts (a `Vector{<:Integer}`).
    Defaults to a single individual in the first state, which is what every
    [`ErlangChain`](@ref)/[`Coxian`](@ref)/[`CTMC`](@ref) lowering starts
    from; a general [`PhaseType`](@ref) with a mixture initial distribution
    `α` (e.g. from [`phase_type`](@ref)'s hyperexponential fit) has no single
    deterministic starting state, so it needs an explicit `u0` here — see
    "Distributional interpretation" above for what that `u0` does and does
    not guarantee.

# Examples

```@example
using LoweredDistributions, JumpProcesses

model = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
prob = jump_problem(model, (0.0, 5.0))
sol = solve(prob, SSAStepper())
sol.u[end]
```

# See also

  - [`lower`](@ref), [`CTMC`](@ref), [`AbstractChainTrick`](@ref): produce the
    `m` this reads.
  - [`ode_problem`](@ref), [`petri_net`](@ref): the SciMLBase and
    AlgebraicPetri alternatives for the same lowering.
"""
function jump_problem end

function jump_problem(args...; kwargs...)
    throw(ArgumentError("`jump_problem` needs JumpProcesses; run " *
                        "`using JumpProcesses` to load the jump-process " *
                        "extension."))
end
