# [Getting started](@id getting-started)

`LoweredDistributions` maps a delay distribution onto the dynamical system it
is equivalent to.
A `Gamma(3, 1.5)` waiting time is also three exponential compartments in
series; [`lower`](@ref) is the bridge between the two views, and four package
extensions turn the result into the object a simulation or inference backend
wants.
This page is the quickstart; the tutorial takes one distribution through every
backend.

## Installation

```julia
using Pkg
Pkg.add("LoweredDistributions")
```

Load the package:

```julia
using LoweredDistributions
```

## A first example

[`lower`](@ref) is the package's entry point.

```@example quickstart
using LoweredDistributions, Distributions

lower(Gamma(3.0, 1.5))
```

A `Gamma(3, 1.5)` delay is exactly three exponential compartments in series,
each left at rate `1/1.5`, so it lowers to an [`ErlangChain`](@ref).
An `Exponential` is memoryless, so it lowers to a two-state [`CTMC`](@ref)
instead, and a distribution with no exact chain representation is fitted by
matching its first two moments (see [`phase_type`](@ref)).

Every phase-type lowering converts to the canonical `PhaseType(α, S)` view,
which is the single shape the backends consume.

```@example quickstart
PhaseType(lower(Gamma(3.0, 1.5))).S
```

## Which backend do I want?

Four package extensions turn any lowering into a backend object.
Loading the backend package activates the matching extension.

| Backend | Entry point | Gives you |
|:--|:--|:--|
| SciMLBase | [`ode_problem`](@ref) | The linear forward-Kolmogorov ODE: deterministic occupancy probabilities through time |
| Catalyst | [`reaction_system`](@ref) | A reaction network, so a lowered delay can be spliced onto a transition of a larger model |
| JumpProcesses | [`jump_problem`](@ref) | Exact stochastic simulation of one individual moving through the states |
| AlgebraicPetri | [`petri_net`](@ref) | A `LabelledPetriNet` for the AlgebraicJulia ecosystem |

[Lowering a distribution to a dynamical system](@ref lowering-backends) runs
all four on the same delay and checks each against the distribution it came
from.

## Learning more

- Want the full interface? See the [Public API](@ref public-api).
- Want to report a problem or ask a question? Open an issue or start a
  discussion on the [GitHub repository](https://github.com/EpiAware/LoweredDistributions.jl).
