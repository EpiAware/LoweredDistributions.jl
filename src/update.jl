# update.jl — the shape-preserving companion to `lower`/`phase_type` (#54).
#
# `lower(dist)`/`phase_type(dist)` may pick their structural representation —
# how many phases, an Erlang chain vs a hyperexponential mixture — from
# `dist`'s VALUE (the squared coefficient of variation decides the branch).
# Re-running that branch on every call inside a differentiated inference loop,
# where `dist`'s parameters are `Dual`/tracked and change on every draw, risks
# the represented structure silently flipping between draws — exactly the
# instability `lower(dist, PhaseType; phases = k)` exists to avoid for the
# canonical form (see `lower.jl`). `update` generalises that fix to every
# lowered type: it takes an existing lowered value as the structural
# template and recomputes only its numeric fields from a new `dist`, holding
# phase count / state names / generator topology fixed.
#
# The rescaling trick this leans on: for any phase-type `(α, S)`, scaling the
# sub-generator `S` by a positive constant `c` is exactly time-rescaling the
# represented delay (`X ~ PhaseType(α, S)` implies `X / c ~ PhaseType(α, c·S)`).
# That holds for ANY `(α, S)`, not just the two canonical fits `lower` builds,
# so matching `dist`'s mean by rescaling `S` by `mean(lowered) / mean(dist)`
# reproduces `dist`'s mean exactly while holding `α` — and hence every
# dispersion/shape statistic (c², skewness, ...) — bit-for-bit fixed. This is
# the same "phases fixed, only the rate inferred" trade-off `lower(dist,
# PhaseType; phases = k)` documents: `dist`'s own dispersion is not re-matched.

"""
    update(lowered::AbstractLowering, dist::Distribution)

Recompute `lowered`'s numeric values — rates, initial distribution, or
generator entries — from `dist`, holding `lowered`'s structure (phase count,
state names, generator topology) fixed.

This is the shape-preserving companion to [`lower`](@ref): matches `dist`'s
mean exactly (the same "phases fixed, only the rate inferred" trade-off
[`lower(dist, PhaseType; phases = k)`](@ref lower) documents — `dist`'s own
dispersion is not re-matched) while reusing `lowered`'s concrete type and
every structural field untouched. Safe inside a hot, differentiated inference
loop (e.g. sampling `dist`'s parameters under Turing) where re-deriving the
structure from `dist`'s value on every draw — what a fresh `lower(dist)` call
does — risks the represented shape silently flipping between draws.

Method coverage matches what [`lower`](@ref)/[`phase_type`](@ref) actually
build: a [`PhaseType`](@ref) or [`Coxian`](@ref) of any shape (both carry
generic numeric fields, so both differentiate); a single-stage
[`ErlangChain`](@ref) (its rate is a concrete `Float64` — see the AD warning
below); and the degenerate two-state [`CTMC`](@ref)
[`lower(::Exponential)`](@ref lower) produces. A `lowered` outside that
surface (a hand-built multi-stage `ErlangChain`, or a `CTMC` built directly
with [`ctmc`](@ref)) throws an `ArgumentError` rather than guessing.

!!! warning "ErlangChain is not AD-safe"
    `ChainStage` stores its rate in a concrete `Float64` field (deliberately —
    see [`phase_type`](@ref)), so `update` on an `ErlangChain` cannot carry an
    AD dual; passing a `dist` with tracked parameters throws. Use
    `lower(dist, PhaseType; phases = k)` for a differentiable path, and
    `update` the resulting [`PhaseType`](@ref) instead.

# Arguments

  - `lowered`: the existing lowered value whose structure to keep.
  - `dist`: the new `Distribution` to match the mean of.

# Examples

```@example
using LoweredDistributions, Distributions

# A PhaseType template built once, then updated on every "draw" without
# re-deriving its structure.
template = lower(Gamma(2.0, 1.0), PhaseType)
update(template, Gamma(2.0, 3.0))
```

# See also

  - [`lower`](@ref), [`phase_type`](@ref): build the structural template this
    updates.
"""
function update end

# --- PhaseType: the general, AD-safe case -----------------------------------

function update(p::PhaseType, dist::Distribution)
    m_new = _update_mean(dist)
    factor = _mean(p) / m_new
    return PhaseType(p.α, factor .* p.S)
end

# The phase-type mean of `p`'s absorption time, α ⋅ (-S)⁻¹ 1 — the expected
# time spent in each phase, weighted by the initial distribution. `p` is
# always the fixed structural template here, never `dist`'s value, so this
# linear solve is plain Float64 and has no bearing on `update`'s
# differentiability: only the later `factor .* p.S` multiply carries `dist`'s
# gradient, a scalar-times-matrix every AD backend handles.
function _mean(p::PhaseType)
    m1 = (-p.S) \ ones(eltype(p.S), length(p.α))
    return sum(p.α .* m1)
end

function _update_mean(dist::Distribution)
    m = mean(dist)
    (isfinite(m) && m > 0) || throw(ArgumentError(
        "update needs dist to have a finite positive mean; got mean = $m " *
        "for $(typeof(dist))."))
    return m
end

# --- Coxian: rescale through the canonical PhaseType(::Coxian) embedding ----

function update(c::Coxian, dist::Distribution)
    m_new = _update_mean(dist)
    factor = _mean(PhaseType(c)) / m_new
    return Coxian(factor .* c.rates, c.probs)
end

# --- ErlangChain: same trick, but NOT AD-safe (ChainStage.rate::Float64) ----

function update(e::ErlangChain, dist::Distribution)
    length(e.stages) == 1 || throw(ArgumentError(
        "update(::ErlangChain, ...) only supports a single-stage chain " *
        "(length(stages) == 1) — this package's own `lower`/`phase_type` " *
        "never build a longer one; got $(length(e.stages))."))
    s = only(e.stages)
    m_new = _update_mean(dist)
    rate = s.stages / m_new
    rate isa AbstractFloat || throw(ArgumentError(
        "update(::ErlangChain, ...) cannot carry a $(typeof(rate)) rate: " *
        "ChainStage stores its rate in a concrete Float64 field, so it " *
        "cannot hold an AD dual. Use `update` on a `PhaseType` (e.g. " *
        "`lower(dist, PhaseType; phases = k)`) for a differentiable path."))
    return ErlangChain([ChainStage(s.name, Float64(rate), s.stages)])
end

# --- CTMC: only the degenerate two-state case lower(::Exponential) builds ---

function update(m::CTMC, dist::Distribution)
    length(m.states) == 2 && m.states == (:on, :absorbed) || throw(ArgumentError(
        "update(::CTMC, ...) only supports the degenerate two-state CTMC " *
        "lower(::Exponential) produces (states = (:on, :absorbed)); got " *
        "$(length(m.states)) states $(m.states). A CTMC built directly with " *
        "`ctmc(...)` has no distribution-driven update."))
    m_new = _update_mean(dist)
    rate = inv(m_new)
    T = typeof(rate)
    Q = zeros(T, 2, 2)
    Q[1, 2] = rate
    Q[1, 1] = -rate
    return CTMC(m.states, Q)
end
