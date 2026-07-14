md"""
# [Lowering a distribution to a dynamical system](@id lowering-backends)

A delay distribution and a compartmental model are two views of the same
thing.
`Gamma(3, 1.5)` is a waiting time; it is also three exponential compartments
in series, each left at rate `1/1.5`.
`lower` is the bridge: it maps a `Distributions.Distribution` onto a
backend-agnostic dynamical-systems representation, which four package
extensions then turn into the object a simulation or inference backend
actually wants.

This tutorial lowers one distribution and takes it through all four
backends.

## Lowering

Load the package and lower a few distributions.
"""

using LoweredDistributions
using Distributions

lower(Gamma(3.0, 1.5))

# An `Exponential` is memoryless, so it lowers to a two-state
# continuous-time Markov chain (`on -> absorbed`) rather than a chain of
# compartments.

lower(Exponential(2.0))

# A distribution with no exact chain representation is fitted by matching its
# first two moments.
# Under- or exactly-dispersed delays (squared coefficient of variation
# `c² = var / mean² ≤ 1`) fit an `ErlangChain`; a sequential chain cannot
# reach `c² > 1`, so an over-dispersed delay fits a branching (mixture)
# `PhaseType` instead.

lower(LogNormal(0.0, 0.5))      # c² ≈ 0.28 ≤ 1 -> ErlangChain

#-

lower(Gamma(0.5, 1.0))          # c² = 2 > 1    -> PhaseType

# Every phase-type representation converts to the canonical `PhaseType(α, S)`
# view: an initial distribution `α` over transient phases, and a sub-generator
# `S` whose row shortfalls are the exit rates to the absorbing state.
# This is the single shape each backend extension consumes, so the backend
# code does not care which fit produced it.

pt = PhaseType(lower(Gamma(3.0, 1.5)))

#-

pt.S

md"""
## Which backend do I want?

| Backend | Entry point | Gives you |
|:--|:--|:--|
| SciMLBase | `ode_problem` | The linear forward-Kolmogorov ODE `du/dt = Q'u`: deterministic occupancy probabilities through time |
| Catalyst | `reaction_system` | A reaction network, so a lowered delay can be spliced onto a transition of a bigger model |
| JumpProcesses | `jump_problem` | Exact stochastic simulation (Gillespie/Doob) of one individual moving through the states |
| AlgebraicPetri | `petri_net` | A `LabelledPetriNet`, for composing models in the AlgebraicJulia ecosystem |

Each takes the same lowering, so the choice is about what you want to do with
it, not about how the distribution was fitted.
The rest of this page runs all four on the same `Gamma(3, 1.5)` delay.
"""

d = Gamma(3.0, 1.5)
chain = lower(d)

md"""
## SciMLBase: the ODE view

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

md"""
## Catalyst: the reaction-network view

`reaction_system` threads a `from` species, through one species per phase, to
a `to` species.
This is the form to reach for when the delay is one transition inside a larger
model: an Erlang-distributed infectious period in an SIR model, say, where the
`I -> R` transition needs a non-exponential dwell time.
"""

using Catalyst

t = Catalyst.default_t()
@species Infectious(t) Recovered(t)

rs = reaction_system(d, Infectious, Recovered;
    prefix = :Iphase, name = :infectious_period)
Catalyst.reactions(rs)

# Three phases give three phase species and, with the entry reaction from
# `Infectious`, four reactions: `Infectious -> Iphase1`, two interior hops, and
# the exit into `Recovered`.

Catalyst.species(rs)

md"""
## JumpProcesses: the exact stochastic view

`jump_problem` puts a single individual in the entry state and lets it jump
between states at the generator's rates.
Solving with `SSAStepper()` draws one exact sample path of the underlying
Markov chain, so the time it first reaches the absorbing state is one exact
draw from `d`.
"""

using JumpProcesses
using Random
using Statistics

jprob = jump_problem(chain, (0.0, 100.0))
jsol = solve(jprob, SSAStepper())
jsol.u[end]        # the individual has ended in the absorbed compartment

# The absorption time is the first time the last (absorbed) compartment holds
# the individual.

absorption_time(s) = s.t[findfirst(u -> u[end] == 1, s.u)]
absorption_time(jsol)

# One path is a single draw, so draw many and compare their mean and standard
# deviation with the distribution we lowered.
# This is a stochastic check, so it agrees to Monte Carlo error rather than to
# solver tolerance.

Random.seed!(20_260_714)
draws = [absorption_time(solve(jump_problem(chain, (0.0, 100.0)), SSAStepper()))
         for _ in 1:2000]

println("simulated mean = ", round(mean(draws); digits = 3),
    "   Gamma mean = ", round(mean(d); digits = 3))
println("simulated sd   = ", round(std(draws); digits = 3),
    "   Gamma sd   = ", round(std(d); digits = 3))

md"""
## AlgebraicPetri: the Petri-net view

`petri_net` returns a `LabelledPetriNet` alongside the name-indexed rate and
initial-condition `Dict`s that AlgebraicPetri's own `vectorfield` needs (it
indexes by species and transition name, not by position).

This section runs in an isolated environment.
AlgebraicPetri 0.10's own Catalyst extension caps Catalyst at version 13,
which cannot resolve against this package's `Catalyst = "16"` compat, so
AlgebraicPetri and Catalyst never coexist in one environment — the same split
the test suite makes (`test/algebraic_petri`).
The script below lives in `docs/algebraic_petri/demo.jl` and is run here in a
subprocess against `docs/algebraic_petri/Project.toml`, so what you see is its
real output, not a transcript.
"""

petri_env = joinpath(pkgdir(LoweredDistributions), "docs", "algebraic_petri")
petri_script = joinpath(petri_env, "demo.jl")
print(read(petri_script, String))

# Running it in its own environment:

run(`$(Base.julia_cmd()) --project=$petri_env -e "using Pkg; Pkg.instantiate()"`)
print(read(`$(Base.julia_cmd()) --project=$petri_env $petri_script`, String))

md"""
The transitions are the chain's interior hops plus its exit, the rates are all
the same per-stage rate `1/1.5`, and `du` at time zero shows the mass draining
out of the first compartment into the second — the same generator the ODE and
jump backends read, in Petri-net clothing.

## Where next

- [Public API](@ref public-api) for the full interface, including `ctmc` for
  building a chain by hand rather than by lowering a distribution.
- `phase_type` for the two-moment fit on its own, and `compartment_stages` for
  the raw `(rate, stages)` structure behind an `ErlangChain`.
"""
