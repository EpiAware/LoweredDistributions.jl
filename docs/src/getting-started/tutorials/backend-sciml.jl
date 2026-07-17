md"""
# [SciMLBase: the ODE view](@id backend-sciml)

Start from a lowering — a `Gamma(3, 1.5)` delay as its chain — the same
starting point every backend page uses. See
[Lowering a distribution to a dynamical system](@ref lowering-backends) for
what `lower` does.
"""

using LoweredDistributions
using Distributions

d = Gamma(3.0, 1.5)
chain = lower(d)

md"""
`ode_problem` builds the linear ODE over state-occupation probabilities.
`u` carries one entry per transient phase plus a trailing absorbed-mass
entry, and `sum(u)` is conserved at one.
Solve it with any OrdinaryDiffEq-compatible algorithm.
"""

using SciMLBase
using OrdinaryDiffEqTsit5

prob = ode_problem(chain, (0.0, 15.0))
sol = solve(prob, Tsit5())
sol.u[end]

# The absorbed mass is not just a curve that goes up: it *is* the CDF of the
# distribution we lowered.
# For an exact Erlang chain the agreement is to solver tolerance, which is the
# clearest check that the lowering is faithful.

for t in (1.0, 3.0, 5.0, 10.0)
    println("t = ", t,
        "  absorbed = ", round(sol(t)[end]; digits = 6),
        "  cdf = ", round(cdf(d, t); digits = 6))
end

# Occupancy sums to one at every time, absorbed state included.

round(sum(sol(7.0)); digits = 12)
