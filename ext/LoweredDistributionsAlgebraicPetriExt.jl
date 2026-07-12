module LoweredDistributionsAlgebraicPetriExt

# AlgebraicPetri.jl bridge: reads the same full state-space generator
# `ode_problem` (the SciMLBase extension) uses (`_generator`, core) and turns
# it into a `LabelledPetriNet` plus the name-indexed rate/initial-condition
# `Dict`s AlgebraicPetri's own `vectorfield` needs — it indexes `u`/`p` by
# species/transition Symbol name (`u[sname(pn, i)]`, `p[tname(pn, i)]`), not
# position, so a plain positional `Vector` will not work as `u0`/rates here.

import LoweredDistributions: petri_net
using LoweredDistributions: AbstractLowering, _generator, lower
using Distributions: Distribution
using AlgebraicPetri: AlgebraicPetri, LabelledPetriNet

function petri_net(m::AbstractLowering; prefix::Symbol = :state)
    gen = _generator(m)
    Q = gen.Q
    eltype(Q) <: Real || throw(ArgumentError(
        "petri_net needs constant transition rates (a Real element type); " *
        "got $(eltype(Q)). AlgebraicPetri's vectorfield also accepts a " *
        "time/state-varying Function rate per transition, but this " *
        "package's lowerings are always constant-rate (or an AD dual, " *
        "still Real) — a non-Real Q signals something has gone wrong " *
        "upstream, so this is rejected explicitly rather than silently " *
        "passed through."))
    n = size(Q, 1)
    names = [Symbol(prefix, i) for i in 1:n]
    transitions = Pair{Symbol, Pair{Symbol, Symbol}}[]
    rates = Dict{Symbol, eltype(Q)}()
    for i in 1:n, j in 1:n

        i == j && continue
        Q[i, j] > 0 || continue
        tname = Symbol(names[i], :_, names[j])
        push!(transitions, tname => (names[i] => names[j]))
        rates[tname] = Q[i, j]
    end
    isempty(transitions) && throw(ArgumentError(
        "the lowering has no positive-rate transitions to build a Petri " *
        "net from"))
    net = LabelledPetriNet(names, transitions...)
    u0 = Dict(names[i] => gen.u0[i] for i in 1:n)
    return (petri_net = net, rates = rates, u0 = u0)
end

function petri_net(dist::Distribution; kwargs...)
    return petri_net(lower(dist); kwargs...)
end

end
