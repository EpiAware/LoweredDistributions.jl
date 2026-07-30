md"""
# [SciMLBase: the ODE view](@id backend-sciml)

Start from a lowering — a `Gamma(3, 1.5)` delay as its chain — the same starting point every backend page uses.
See [Lowering a distribution to a dynamical system](@ref lowering-backends) for what `lower` does.
"""

using LoweredDistributions
using Distributions
using CairoMakie
using AlgebraOfGraphics
using DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)
set_theme!(theme_latexfonts(); fontsize = 14)

d = Gamma(3.0, 1.5)
chain = lower(d)

md"""
`ode_problem` builds the linear ODE over state-occupation probabilities.
`u` carries one entry per transient phase plus a trailing absorbed-mass entry, and `sum(u)` is conserved at one.
Solve it with any OrdinaryDiffEq-compatible algorithm.
"""

using SciMLBase
using OrdinaryDiffEqTsit5

prob = ode_problem(chain, (0.0, 15.0))
sol = solve(prob, Tsit5())
sol.u[end]

# The absorbed mass is not just a curve that goes up: it *is* the CDF of the distribution we lowered.
# For an exact Erlang chain the agreement is to solver tolerance, which is the clearest check that the lowering is faithful.

for t in (1.0, 3.0, 5.0, 10.0)
    println("t = ", t,
        "  absorbed = ", round(sol(t)[end]; digits = 6),
        "  cdf = ", round(cdf(d, t); digits = 6))
end

# Occupancy sums to one at every time, absorbed state included.

round(sum(sol(7.0)); digits = 12)

# Plotting the two curves over a finer grid than the four checkpoints above makes the agreement visible across the whole time axis, not just at four points.

ts = 0.0:0.1:15.0
cdf_df = vcat(
    DataFrame(t = collect(ts), value = [sol(t)[end] for t in ts],
        kind = "Absorbed mass (ODE)"),
    DataFrame(t = collect(ts), value = cdf.(d, ts), kind = "Exact Gamma CDF")
)
draw(
    data(cdf_df) *
    mapping(:t, :value, color = :kind, linestyle = :kind) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Time", ylabel = "Probability")
)

# The ODE state carries one occupancy curve per compartment, not just the absorbed total: plotting all of them shows mass draining forward through the three-phase chain into the absorbing state, the trajectory this backend actually solves for.

n_phases = length(sol.u[1]) - 1
occupancy_df = reduce(vcat,
    DataFrame(t = collect(ts), probability = [sol(t)[i] for t in ts],
        state = i <= n_phases ? "phase $i" : "absorbed")
    for i in 1:(n_phases + 1))
draw(
    data(occupancy_df) *
    mapping(:t, :probability, color = :state) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Time", ylabel = "Occupancy probability")
)
