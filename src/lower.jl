# The lower(dist) dispatch table: Distribution -> AbstractLowering.

"""
    lower(dist::Distribution)

Lower a `Distribution` to a backend-agnostic dynamical-systems representation
(an [`AbstractLowering`](@ref)).

  - `Exponential` lowers to a two-state degenerate [`CTMC`](@ref) (`on ->
    absorbed` at the exponential's rate) — the trivial case of the CTMC fast
    path.
  - `Gamma` (including integer-shape Erlang) lowers to an [`ErlangChain`](@ref)
    when `c² = var / mean² ≤ 1` (always true for `shape ≥ 1`), and to a
    [`phase_type`](@ref) fit otherwise.
  - Any other `Distribution` lowers via the adaptive [`phase_type`](@ref) fit.

Which representation comes back therefore depends on `dist`'s value, not only
on its type, so this method's return type is a `Union`. When the structural
parameter is fixed — the usual fitting case, where the phase count is held
constant and only the continuous rate is inferred — the branch is decided at
compile time, the `Union` folds to that one concrete type, and `lower(dist)`
differentiates on every backend (Enzyme included). Fix the structural
parameter and the result carries an AD dual through its rate. When the
structural parameter itself varies at runtime the `Union` is genuine; reach
for `lower(dist, PhaseType)` below, the unconditionally type-stable form.

# Arguments

  - `dist`: the `Distribution` to lower.

# Examples

```@example
using LoweredDistributions, Distributions

lower(Exponential(2.0))               # CTMC(2 states)
lower(Gamma(3.0, 1.5))                # ErlangChain(3 compartments)
lower(Gamma(0.5, 1.0))                # PhaseType(2 phases), c² = 2 > 1
```

# See also

  - [`AbstractLowering`](@ref), [`AbstractChainTrick`](@ref): the hierarchy.
  - [`ctmc`](@ref), [`ErlangChain`](@ref), [`phase_type`](@ref): the
    representations this dispatches to.
"""
function lower(d::Exponential)
    rate = inv(scale(d))
    return ctmc(:on => (:absorbed => rate))
end

function lower(d::Gamma)
    scv = 1 / shape(d)
    scv <= 1 && return ErlangChain(compartment_stages(d; moment_match = true))
    # Build the hyperexponential PhaseType directly rather than via
    # `phase_type(d)`, whose own `Union{ErlangChain, PhaseType}` return type
    # would leak into this branch: with a fixed (constant) shape each branch
    # here is then a single concrete type, so the whole method folds to that
    # type and differentiates under Enzyme (see the AD-stability note below).
    return _hyperexponential_fit(mean(d), scv)
end

lower(d::Distribution) = phase_type(d)

"""
    lower(dist::Distribution, ::Type{PhaseType}; max_phases = 1_000)

Lower `dist` to the canonical [`PhaseType`](@ref) `(α, S)` form, whatever its
dispersion — the type-stable lowering, and the one to differentiate through.

`lower(dist)` picks its representation from `dist`'s value (an
[`ErlangChain`](@ref) for `c² ≤ 1`, a [`PhaseType`](@ref) for `c² > 1`, a
[`CTMC`](@ref) for an `Exponential`), so its return type is a `Union` that
only resolves at runtime. With a fixed structural parameter that `Union` folds
to a single concrete branch and `lower(dist)` itself differentiates on every
backend — an [`ErlangChain`](@ref) now carries its rate's element type through
to the canonical `(α, S)`, so the `c² ≤ 1` branch takes an AD dual too. This
method is for when the structure varies at runtime (the `Union` is then
genuine, and Enzyme cannot analyse it), or when you want the canonical
`(α, S)`, or a fixed phase count via `phases`, directly. It always returns the
same concrete type regardless of the value, so it never depends on the branch
folding, and differentiates on every backend the package tests (ForwardDiff,
ReverseDiff, both Mooncake modes, both Enzyme modes).

The fit is the same two-moment fit `lower` performs — an Erlang chain of
`round(1 / c²)` phases for `c² ≤ 1`, the balanced-means hyperexponential for
`c² > 1` — so the phase-type agrees with `PhaseType(lower(dist))` to
floating-point tolerance wherever that conversion exists. It is not always
bit-identical: for an exact Exponential/Erlang leaf, `compartment_stages`
reads the rate straight off the distribution's scale (`1 / θ`), while this
method recomputes it from the moments (`k / mean(dist)`), which can differ in
the last unit in the last place. The structure — phase count, chain shape,
matched mean — is the same.

What the canonical form does cost is memory. It holds an explicit `k × k`
sub-generator, where the `c² ≤ 1` fit needs `k = round(1 / c²)` phases, so a
tight (near-deterministic) delay asks for a very large dense matrix:
`Normal(5, 0.001)` has `c² = 4e-8`, hence 25 million phases. An
[`ErlangChain`](@ref) stores the same chain as a phase *count* and does not
grow with `k` at all. `max_phases` caps the fit so that case raises an
actionable error rather than exhausting memory; raise it if a long chain is
genuinely wanted.

# Arguments

  - `dist`: the `Distribution` to lower.
  - `PhaseType`: the [`PhaseType`](@ref) type itself, selecting the canonical
    form.

# Keyword Arguments

  - `phases`: fix the Erlang phase count instead of deriving it from the
    distribution's dispersion. With `phases = k` the result is always a
    `k`-stage Erlang whose rate matches `mean(dist)` (`rate = k / mean`), so the
    phase count — and hence the `(α, S)` dimension — is **independent of the
    distribution's value**. This is the AD-stable path for fitting under
    Turing: the number of compartments is a discrete quantity you cannot
    differentiate through, so fix it and infer only the (continuous) rate; the
    result then differentiates on every backend, Enzyme included. The default
    (`nothing`) keeps the adaptive two-moment fit, whose phase count
    `round(1 / c²)` *does* depend on the value and so steps discontinuously as
    a parameter crosses a rounding boundary. When set, `phases` overrides
    `max_phases`.
  - `max_phases`: the largest Erlang phase count to build a sub-generator for
    (default `1_000`, a `1_000 × 1_000` matrix). Only the `c² ≤ 1` branch can
    reach it; the `c² > 1` hyperexponential fit is always two phases. Ignored
    when `phases` is set.

# Examples

```@example
using LoweredDistributions, Distributions

lower(Gamma(3.0, 1.5), PhaseType)     # PhaseType(3 phases), was an ErlangChain
lower(Gamma(0.5, 1.0), PhaseType)     # PhaseType(2 phases), c² = 2 > 1
lower(Gamma(3.0, 1.5), PhaseType; phases = 5)   # a fixed 5-phase Erlang
lower(Exponential(2.0), PhaseType)    # PhaseType(1 phase), was a CTMC
```

# See also

  - [`lower`](@ref): the adaptive dispatch this canonicalises.
  - [`phase_type`](@ref): the two-moment fit both share.
  - [Fitting a lowered distribution under AD, stably](@ref fitting-ad-stable):
    the `phases` keyword worked through a Turing recipe, with the failure
    modes this method's `Union`-avoidance and `max_phases` guard against.
"""
function lower(d::Distribution, ::Type{PhaseType};
        phases::Union{Nothing, Int} = nothing, max_phases::Int = 1_000)
    if phases !== nothing
        phases >= 1 || throw(ArgumentError(
            "phases must be a positive integer; got $phases"))
        return _fixed_erlang_phase_type(mean(d), phases)
    end
    m, scv = _two_moments(d, "lower(dist, PhaseType)")
    scv <= 1 && return _erlang_phase_type(m, scv, max_phases)
    return _hyperexponential_fit(m, scv)
end
