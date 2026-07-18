# [Getting started](@id getting-started)

`LoweredDistributions` maps a delay distribution onto the dynamical system it is equivalent to.
A `Gamma(3, 1.5)` waiting time is also three exponential compartments in series; [`lower`](@ref) is the bridge between the two views, and four package extensions turn the result into the object a simulation or inference backend wants.
This page is the quickstart; the tutorial takes one distribution through every backend.

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

A `Gamma(3, 1.5)` delay is exactly three exponential compartments in series, each left at rate `1/1.5`, so it lowers to an [`ErlangChain`](@ref).
An `Exponential` is memoryless, so it lowers to a two-state [`CTMC`](@ref) instead, and a distribution with no exact chain representation is fitted by matching its first two moments (see [`phase_type`](@ref)).

Every phase-type lowering converts to the canonical `PhaseType(α, S)` view, which is the single shape the backends consume.

```@example quickstart
PhaseType(lower(Gamma(3.0, 1.5))).S
```

## Which backend do I want?

Four package extensions turn any lowering into a backend object: SciMLBase ([`ode_problem`](@ref)), Catalyst ([`reaction_system`](@ref)), JumpProcesses ([`jump_problem`](@ref)), and AlgebraicPetri ([`petri_net`](@ref)); loading the backend package activates the matching extension.
[Lowering a distribution to a dynamical system](@ref lowering-backends) runs all four on the same delay and checks each against the distribution it came from.

## Learning more

- Want the full interface? See the [Public API](@ref public-api).
- Want the packages LoweredDistributions works alongside? See
  [Related packages](../index.md) on the home page.

## Getting help

For usage questions, ask on the [Julia Discourse](https://discourse.julialang.org)
(the SciML or usage categories) or the [epinowcast community forum](https://community.epinowcast.org),
our home for epidemiological modelling questions.
Please use [GitHub issues](https://github.com/EpiAware/LoweredDistributions.jl/issues)
for bug reports and feature requests only.
