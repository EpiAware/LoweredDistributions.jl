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

This page is the lowering itself; each backend then has its own page.

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
| [SciMLBase](@ref backend-sciml) | `ode_problem` | The linear forward-Kolmogorov ODE `du/dt = Q'u`: deterministic occupancy probabilities through time |
| [Catalyst](@ref backend-catalyst) | `reaction_system` | A reaction network, so a lowered delay can be spliced onto a transition of a bigger model |
| [JumpProcesses](@ref backend-jump) | `jump_problem` | Exact stochastic simulation (Gillespie/Doob) of one individual moving through the states |
| [AlgebraicPetri](@ref backend-petri) | `petri_net` | A `LabelledPetriNet`, for composing models in the AlgebraicJulia ecosystem |

Each backend page takes the same `Gamma(3, 1.5)` lowering and turns it into
that backend's object, so the choice is about what you want to do with it, not
about how the distribution was fitted.

## Where next

- [Public API](@ref public-api) for the full interface, including `ctmc` for
  building a chain by hand rather than by lowering a distribution.
- `phase_type` for the two-moment fit on its own, and `compartment_stages` for
  the raw `(rate, stages)` structure behind an `ErlangChain`.
"""
