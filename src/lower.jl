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
on its type, so this method's return type is a `Union` — see
`lower(dist, PhaseType)` below for the type-stable form automatic
differentiation needs.

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
    return phase_type(d)
end

lower(d::Distribution) = phase_type(d)

"""
    lower(dist::Distribution, ::Type{PhaseType})

Lower `dist` to the canonical [`PhaseType`](@ref) `(α, S)` form, whatever its
dispersion — the type-stable lowering, and the one to differentiate through.

`lower(dist)` picks its representation from `dist`'s value (an
[`ErlangChain`](@ref) for `c² ≤ 1`, a [`PhaseType`](@ref) for `c² > 1`, a
[`CTMC`](@ref) for an `Exponential`), so its return type is a `Union` that
only resolves at runtime. That `Union` is fine for ordinary use, and every
backend canonicalises to `PhaseType` anyway, but on a differentiated path it
breaks Enzyme outright (forward and reverse), and the `c² ≤ 1` branch cannot
carry an AD dual at all — `ChainStage` stores its rate in a concrete `Float64`
field. This method always returns the same concrete type and never touches
`ChainStage`, so it differentiates on every backend the package tests
(ForwardDiff, ReverseDiff, both Mooncake modes, both Enzyme modes).

The fit is the same two-moment fit `lower` performs — an Erlang chain of
`round(1 / c²)` phases for `c² ≤ 1`, the balanced-means hyperexponential for
`c² > 1` — so the phase-type agrees with `PhaseType(lower(dist))` to
floating-point tolerance wherever that conversion exists. It is not always
bit-identical: for an exact Exponential/Erlang leaf, `compartment_stages`
reads the rate straight off the distribution's scale (`1 / θ`), while this
method recomputes it from the moments (`k / mean(dist)`), which can differ in
the last unit in the last place. The structure — phase count, chain shape,
matched mean — is the same.

# Arguments

  - `dist`: the `Distribution` to lower.
  - `PhaseType`: the [`PhaseType`](@ref) type itself, selecting the canonical
    form.

# Examples

```@example
using LoweredDistributions, Distributions

lower(Gamma(3.0, 1.5), PhaseType)     # PhaseType(3 phases), was an ErlangChain
lower(Gamma(0.5, 1.0), PhaseType)     # PhaseType(2 phases), c² = 2 > 1
lower(Exponential(2.0), PhaseType)    # PhaseType(1 phase), was a CTMC
```

# See also

  - [`lower`](@ref): the adaptive dispatch this canonicalises.
  - [`phase_type`](@ref): the two-moment fit both share.
"""
function lower(d::Distribution, ::Type{PhaseType})
    m, scv = _two_moments(d, "lower(dist, PhaseType)")
    scv <= 1 && return _erlang_phase_type(m, scv)
    return _hyperexponential_fit(m, scv)
end
