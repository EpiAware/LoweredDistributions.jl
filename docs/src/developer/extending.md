# [Extending LoweredDistributions](@id extending)

There are two different ways to extend the package: giving a distribution
family its own exact lowering, and adding a new backend. The lowering type
hierarchy itself — [`AbstractLowering`](@ref), [`AbstractChainTrick`](@ref),
and the four concrete representations ([`ErlangChain`](@ref), [`Coxian`](@ref),
[`PhaseType`](@ref), [`CTMC`](@ref)) — is locked; every lowering is one of
these four, so neither extension point adds a new representation type.

## Giving a distribution an exact lowering

[`lower`](@ref) dispatches on the `Distribution`'s type, with a
moment-matched [`phase_type`](@ref) fit as the fallback
(`lower(d::Distribution) = phase_type(d)` in `src/lower.jl`). A distribution
with a known exact chain representation gets its own method, following
`lower(d::Gamma)` and `lower(d::Exponential)`:

```julia
LoweredDistributions.lower(d::MyDistribution) = ErlangChain(d; kwargs...)
```

This is ordinary Julia dispatch on your own type, so it needs no extension
mechanism — add the method wherever `MyDistribution` is defined.

## Adding a new backend

The four built-in backends (Catalyst, SciMLBase, AlgebraicPetri,
JumpProcesses) each follow the same shape:

1. A stub function with no method, declared and exported in the core
   package — e.g. `function ode_problem end` in `src/ode.jl` — so it is part
   of the public API even before the backend package is loaded.
2. A package extension `ext/LoweredDistributions<Backend>Ext.jl`, gated on
   the backend as a weak dependency, adding the concrete method dispatching
   on [`AbstractLowering`](@ref) (or a narrower type, if the backend only
   applies to one branch of the hierarchy).
3. The extension builds on the internal numeric core every backend shares:
   `_generator(m)` (`src/generator.jl`) returns the full state-space
   generator `Q` and a default initial condition for ANY
   [`AbstractLowering`](@ref) uniformly, whether it came from a phase-type
   fit or a bare [`CTMC`](@ref).

`ext/LoweredDistributionsSciMLBaseExt.jl` is the shortest of the four and the
best template to start from — it wraps `_generator`'s `Q`/`u0` as an
`ODEProblem` in about a dozen lines.

To add a fifth backend:

1. Add the target package as a `[weakdeps]` entry and register the
   extension in `[extensions]` in `Project.toml`.
2. Declare and export a stub function with a docstring in `src/`.
3. Write `ext/LoweredDistributions<Backend>Ext.jl` following the pattern
   above, building on `_generator` (or on [`PhaseType`](@ref)/[`CTMC`](@ref)
   directly, if the backend needs the phase-type view rather than the full
   generator).
4. Add a tutorial under `docs/src/getting-started/tutorials/`, mirroring the
   existing four backend tutorials, and register it in `docs/pages.jl`.
5. Check the new backend's output against the source distribution on the
   same delay every other backend tutorial uses.
