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
