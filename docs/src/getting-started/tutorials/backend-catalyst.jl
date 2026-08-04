md"""
# [Catalyst: the reaction-network view](@id backend-catalyst)

Start from a lowering — a `Gamma(3, 1.5)` delay as its chain — the same starting point every backend page uses.
See [Lowering a distribution to a dynamical system](@ref lowering-backends) for what `lower` does.
"""

using LoweredDistributions
using Distributions

d = Gamma(3.0, 1.5)
chain = lower(d)

md"""
`reaction_system` threads a `from` species, through one species per phase, to a `to` species.
This is the form to reach for when the delay is one transition inside a larger model: an Erlang-distributed infectious period in an SIR model, say, where the `I -> R` transition needs a non-exponential dwell time.
"""

using Catalyst

t = Catalyst.default_t()
@species Infectious(t) Recovered(t)

rs = reaction_system(d, Infectious, Recovered;
    prefix = :Iphase, name = :infectious_period)
Catalyst.reactions(rs)

# Three phases give three phase species and, with the entry reaction from `Infectious`, four reactions: `Infectious -> Iphase1`, two interior hops, and the exit into `Recovered`.

Catalyst.species(rs)

md"""
## The reaction network reproduces the same delay

The entry reaction routes an individual out of `Infectious` at a rate scale internal to the α-race (see `reaction_system`'s docstring), so it models a rate-limited hand-off, useful when the delay is spliced onto a bigger model's own `I -> R` transition.
To check the network reproduces the *delay itself* — starting the clock the moment an individual enters the chain — seed the initial condition directly into the phase species, following `α`, rather than into `Infectious`.
Solving the resulting `ODEProblem` with any OrdinaryDiffEq algorithm then gives the same trajectory the [SciMLBase page](@ref backend-sciml) solves directly from the phase-type, just reached through the reaction network instead.
"""

using OrdinaryDiffEqTsit5
using CairoMakie
using AlgebraOfGraphics
using DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)
set_theme!(theme_latexfonts(); fontsize = 14)

sys = complete(rs)
species = Catalyst.species(sys)
pt = PhaseType(chain)
u0 = [sp => 0.0 for sp in species]
for (j, w) in enumerate(pt.α)
    u0[j + 1] = species[j + 1] => w      # species[1] is Infectious, left at 0
end

oprob = ODEProblem(sys, u0, (0.0, 15.0))
sol = solve(oprob, Tsit5())

ts = 0.0:0.1:15.0
cdf_df = vcat(
    DataFrame(t = collect(ts), value = [sol(t)[end] for t in ts],
        kind = "Recovered(t) (reaction network)"),
    DataFrame(t = collect(ts), value = cdf.(d, ts), kind = "Exact Gamma CDF")
)
draw(
    data(cdf_df) *
    mapping(:t, :value, color = :kind, linestyle = :kind) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Time", ylabel = "Probability")
)

# The species trajectories underneath that curve are the reaction network's own view of mass draining forward through the phases into `Recovered` — the same generator the ODE and jump backends read, in reaction-network clothing.

species_names = string.(species)
trajectory_df = reduce(vcat,
    DataFrame(t = collect(ts), value = [sol(t)[i] for t in ts],
        species = species_names[i])
    for i in eachindex(species))
draw(
    data(trajectory_df) *
    mapping(:t, :value, color = :species) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Time", ylabel = "Occupancy probability")
)
