# Run by the getting-started tutorial in the isolated `test/algebraic_petri`
# environment (AlgebraicPetri 0.10 caps Catalyst at 13, so it cannot share an
# environment with this package's Catalyst 16 extension). Run it by hand with:
#
#   julia --project=test/algebraic_petri docs/algebraic_petri/demo.jl

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

# A trajectory through the vectorfield, so the calling tutorial can plot it
# alongside the other backends'. This environment has no ODE solver (only
# AlgebraicPetri and Distributions, kept minimal to dodge the Catalyst version
# clash — see the module header), so a plain fixed-step RK4 over the
# `vectorfield` closure is enough: the generator is linear, so RK4 at a small
# step is accurate well past plotting resolution.
species_names = snames(built.petri_net)

function deriv(u::Vector{Float64})
    udict = Dict(species_names[i] => u[i] for i in eachindex(species_names))
    dudict = Dict(n => 0.0 for n in species_names)
    f!(dudict, udict, built.rates, 0.0)
    return [dudict[n] for n in species_names]
end

function rk4_step(u::Vector{Float64}, dt::Float64)
    k1 = deriv(u)
    k2 = deriv(u .+ (dt / 2) .* k1)
    k3 = deriv(u .+ (dt / 2) .* k2)
    k4 = deriv(u .+ dt .* k3)
    return u .+ (dt / 6) .* (k1 .+ 2 .* k2 .+ 2 .* k3 .+ k4)
end

function print_trajectory(; dt::Float64 = 0.01, print_every::Int = 25)
    tspan = 0.0:dt:15.0                  # print_every * dt = 0.25 time units
    u = [built.u0[n] for n in species_names]
    for (i, t) in enumerate(tspan)
        if (i - 1) % print_every == 0
            for (n, v) in zip(species_names, u)
                println("TRAJ,", t, ",", n, ",", v)
            end
        end
        t == last(tspan) && break
        u = rk4_step(u, dt)
    end
    return nothing
end

print_trajectory()
