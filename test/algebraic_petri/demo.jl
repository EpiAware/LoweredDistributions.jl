# Run by the getting-started tutorial, nested here rather than under docs/
# because it needs the isolated `test/algebraic_petri` environment it lives
# alongside (AlgebraicPetri 0.10 caps Catalyst at 13, so it cannot share an
# environment with this package's Catalyst 16 extension). Run it by hand with:
#
#   julia --project=test/algebraic_petri test/algebraic_petri/demo.jl

using LoweredDistributions, Distributions, AlgebraicPetri

# The same delay the rest of the tutorial lowers: Gamma(3, 1.5), an exact
# three-compartment Erlang chain.
d = Gamma(3.0, 1.5)
built = petri_net(d)

println("places:      ", snames(built.petri_net))
println("transitions: ", tnames(built.petri_net))
println("rates:       ", sort(collect(built.rates), by = first))
println("u0:          ", sort(collect(built.u0), by = first))

# AlgebraicPetri's own mass-action vectorfield, evaluated at t = 0. All the
# mass starts in the first compartment, so it drains into the second at the
# chain's per-stage rate and nothing else has moved yet.
f! = vectorfield(built.petri_net)
du = Dict(k => 0.0 for k in keys(built.u0))
f!(du, built.u0, built.rates, 0.0)
println("du at t = 0: ", sort(collect(du), by = first))
