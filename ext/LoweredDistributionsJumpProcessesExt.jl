module LoweredDistributionsJumpProcessesExt

# JumpProcesses.jl bridge: reads the same full state-space generator
# `ode_problem`/`petri_net` use (`_generator`, core) and turns it into a
# `MassActionJump` over per-state population counts, wrapped as a
# `JumpProblem` ready for exact stochastic simulation (`solve(...,
# SSAStepper())`). Unlike `ode_problem`/`petri_net`, which treat `u` as a
# continuous occupation-probability/concentration vector, a jump process
# needs genuine integer population counts — so the default initial condition
# only fires for a deterministic single-state start (every
# ErlangChain/Coxian/CTMC lowering); a mixture-`α` PhaseType needs an
# explicit `u0`.

import LoweredDistributions: jump_problem
using LoweredDistributions: AbstractLowering, _generator, lower
using Distributions: Distribution
using JumpProcesses: DiscreteProblem, Direct, JumpProblem, MassActionJump

function jump_problem(m::AbstractLowering, tspan; u0 = nothing)
    gen = _generator(m)
    Q = gen.Q
    eltype(Q) <: Real || throw(ArgumentError(
        "jump_problem needs constant transition rates (a Real element " *
        "type); got $(eltype(Q))."))
    n = size(Q, 1)
    u0v = if u0 !== nothing
        u0
    else
        all(x -> isapprox(x, round(x); atol = 1e-8), gen.u0) ||
            throw(ArgumentError(
                "the lowering has no single deterministic starting state " *
                "(a mixture initial distribution α); pass an explicit " *
                "`u0` (a Vector{<:Integer} of per-state population counts)."))
        round.(Int, gen.u0)
    end
    rates = eltype(Q)[]
    reactant_stoch = Vector{Pair{Int, Int}}[]
    net_stoch = Vector{Pair{Int, Int}}[]
    for i in 1:n, j in 1:n

        i == j && continue
        Q[i, j] > 0 || continue
        push!(rates, Q[i, j])
        push!(reactant_stoch, [i => 1])
        push!(net_stoch, [i => -1, j => 1])
    end
    isempty(rates) && throw(ArgumentError(
        "the lowering has no positive-rate transitions to build a jump " *
        "process from"))
    maj = MassActionJump(rates, reactant_stoch, net_stoch; scale_rates = false)
    dprob = DiscreteProblem(u0v, tspan)
    return JumpProblem(dprob, Direct(), maj)
end

function jump_problem(dist::Distribution, tspan; kwargs...)
    return jump_problem(lower(dist), tspan; kwargs...)
end

end
