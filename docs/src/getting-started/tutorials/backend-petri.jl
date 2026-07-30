md"""
# [AlgebraicPetri: the Petri-net view](@id backend-petri)

`petri_net` returns a `LabelledPetriNet` alongside the name-indexed rate and initial-condition `Dict`s that AlgebraicPetri's own `vectorfield` needs (it indexes by species and transition name, not by position).
It starts from the same `Gamma(3, 1.5)` lowering as the other backends — see [Lowering a distribution to a dynamical system](@ref lowering-backends).

This backend's demo runs in its own environment: the package keeps one at `test/algebraic_petri`, and the demo below runs against it.

If you are reading this as a downloaded script rather than building the docs, this section needs a checked-out copy of the repository (it resolves paths relative to the package source).
"""

using LoweredDistributions
using Distributions
using CairoMakie
using AlgebraOfGraphics
using DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)
set_theme!(theme_latexfonts(); fontsize = 14)

d = Gamma(3.0, 1.5)

petri_env = joinpath(pkgdir(LoweredDistributions), "test", "algebraic_petri")
petri_script = joinpath(pkgdir(LoweredDistributions), "docs",
    "algebraic_petri", "demo.jl")

# The demo script itself, printed from the file that is about to be run, so the page cannot drift from the code:

print(read(petri_script, String))

# And its real output, from a subprocess against that isolated environment.
# `read` throws on a non-zero exit, so a broken demo fails the docs build rather than silently printing nothing.

setup = `$(Base.julia_cmd()) --project=$petri_env -e "using Pkg; Pkg.instantiate()"`
demo = `$(Base.julia_cmd()) --project=$petri_env $petri_script`

read(setup, String) #hide
demo_output = read(demo, String)
demo_lines = split(demo_output, '\n')
traj_lines = filter(l -> startswith(l, "TRAJ,"), demo_lines)
print(join(filter(l -> !startswith(l, "TRAJ,"), demo_lines), '\n'))

md"""
The transitions are the chain's interior hops plus its exit, the rates are all the same per-stage rate `1/1.5`, and `du` at time zero shows the mass draining out of the first compartment into the second — the same generator the ODE and jump backends read, in Petri-net clothing.

## The vectorfield reproduces the same trajectory

The demo script also integrates `vectorfield(built.petri_net)` forward (a plain fixed-step RK4, since the isolated environment carries no ODE solver of its own — see the demo source above) and prints the result as `TRAJ` rows, parsed back here into a `DataFrame` for plotting.
"""

traj_df = reduce(vcat,
    let parts = split(line, ',')
        DataFrame(t = parse(Float64, parts[2]), place = parts[3],
            value = parse(Float64, parts[4]))
    end
    for line in traj_lines)

places_by_order = sort(unique(traj_df.place);
    by = s -> parse(Int, replace(s, "state" => "")))
absorbed = places_by_order[end]
traj_df.label = [p == absorbed ? "absorbed" : p for p in traj_df.place]

draw(
    data(traj_df) *
    mapping(:t, :value, color = :label) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Time", ylabel = "Occupancy probability")
)

# The absorbed place is the Petri net's own view of the CDF: plotting it against the exact `Gamma(3, 1.5)` CDF is the same faithfulness check the ODE page makes, reached through the mass-action vectorfield instead of the linear Kolmogorov ODE.

absorbed_df = @rsubset(traj_df, :place == absorbed)
cdf_df = vcat(
    DataFrame(t = absorbed_df.t, value = absorbed_df.value,
        kind = "Absorbed mass (Petri vectorfield)"),
    DataFrame(t = absorbed_df.t, value = cdf.(d, absorbed_df.t),
        kind = "Exact Gamma CDF")
)
draw(
    data(cdf_df) *
    mapping(:t, :value, color = :kind, linestyle = :kind) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Time", ylabel = "Probability")
)
