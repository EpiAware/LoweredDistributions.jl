# [Extending LoweredDistributions](@id extending)

Most extensions belong in your own package, not in this one.
`lower` dispatches on ordinary Julia types, and every backend entry point is a stub function you can add a method to from anywhere, so you do not need to be inside this repository to extend it.
This page covers how to do that, and when we would instead host the extension here.

The lowering type hierarchy is locked.
[`AbstractLowering`](@ref), [`AbstractChainTrick`](@ref) and the four concrete representations ([`ErlangChain`](@ref), [`Coxian`](@ref), [`PhaseType`](@ref), [`CTMC`](@ref)) are the whole set, and neither extension point below adds a new one.

## Giving a distribution an exact lowering

[`lower`](@ref) dispatches on the `Distribution`'s type, with a moment-matched [`phase_type`](@ref) fit as the fallback (`lower(d::Distribution) = phase_type(d)` in `src/lower.jl`).
A distribution with a known exact chain representation gets its own method, following `lower(d::Gamma)` and `lower(d::Exponential)`:

```julia
LoweredDistributions.lower(d::MyDistribution) = ErlangChain(d; kwargs...)
```

This is ordinary Julia dispatch on your own type, so it needs no extension mechanism.
Add the method wherever `MyDistribution` is defined.

## Adding a backend from your own package

This is the path we expect most people to take, and the one we prefer.

Each backend entry point is a stub function declared and exported here with no method attached — [`ode_problem`](@ref), [`petri_net`](@ref), [`jump_problem`](@ref), [`reaction_system`](@ref), [`linear_chain_reactions`](@ref).
They are part of the public API before any backend package is loaded, precisely so a downstream package can supply the method.

From your own package:

1. Take `LoweredDistributions` as a dependency, and your target backend as a `[weakdeps]` entry in *your* `Project.toml`.
2. Register an extension in your `[extensions]` table, gated on both.
3. In that extension, add a method to the relevant stub dispatching on [`AbstractLowering`](@ref), or on a narrower type if the backend only applies to one branch of the hierarchy.

Your method receives the canonical view every backend shares.
Build on the public surface: [`PhaseType`](@ref) gives you `(α, S)`, [`CTMC`](@ref) gives you the state set and transition rates, and [`lower`](@ref)`(dist, PhaseType)` gets you the canonical form in one type-stable step.

!!! note "The shared generator is currently internal"
    The four in-tree backends build on `_generator(m)` (`src/generator.jl`), which returns the full state-space generator `Q` and a default initial condition for any [`AbstractLowering`](@ref) uniformly.
    It is not exported and not marked `public`, so an out-of-tree extension should not depend on it.
    If your backend genuinely needs the full generator rather than the phase-type view, please open an issue — that is a signal we should promote it to the public API rather than a reason to reach into internals.

If your extension is useful to you alone, or is specific to your modelling stack, keeping it in your package is the right end state.
It stays on your release cycle and we do not gate your changes.

## When we would host it instead

We would take a backend in-tree when it has general utility — a widely used simulation or inference package that most users of this one would reasonably expect to work out of the box, rather than a bridge to a specific project's stack.

Open an issue first.
The question is whether the backend is general enough to justify us carrying it, not whether the code is good.

If we agree to host it, `ext/LoweredDistributionsSciMLBaseExt.jl` is the shortest of the four and the best template.
It wraps `_generator`'s `Q`/`u0` as an `ODEProblem` in about a dozen lines.
The in-tree checklist is then:

1. Add the target package as a `[weakdeps]` entry and register the extension in `[extensions]` in this package's `Project.toml`.
2. Declare and export a stub function with a docstring in `src/`.
3. Write `ext/LoweredDistributions<Backend>Ext.jl`, building on `_generator`, or on [`PhaseType`](@ref)/[`CTMC`](@ref) directly if the backend needs the phase-type view rather than the full generator.
4. Add a tutorial under `docs/src/getting-started/tutorials/`, mirroring the existing four backend tutorials, and register it in `docs/pages.jl`.
5. Check the new backend's output against the source distribution on the same delay every other backend tutorial uses.
