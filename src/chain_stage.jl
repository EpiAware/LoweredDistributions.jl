# Linear-chain trick: an Erlang(k, θ) (integer-shape Gamma) delay is k
# Exponential(θ) sub-stages in series, each leaving at rate 1/θ; an
# Exponential(θ) is the k = 1 case. `compartment_stages` reads that
# `(rate, stages)` structure off a single leaf distribution, ported from
# CensoredDistributions.jl's `linear_chain.jl` (the `Sequential`-chain overload
# stays there — this leaf package has no composer stack to feed it).

"""
A single Erlang stage of a linear-chain delay representation.

An Erlang(``k``, ``\\theta``) delay is `stages = k` Exponential sub-compartments
in series, each leaving at `rate = 1/\\theta`. An Exponential(``\\theta``) delay
is the `stages = 1` case. The mean dwell time is `stages / rate`; `name` records
which step of a chain the stage came from (`:delay` for a single leaf).

# See also

  - [`compartment_stages`](@ref): builds these from a delay.
  - [`ErlangChain`](@ref): the [`AbstractChainTrick`](@ref) wrapping a vector of
    these.
"""
struct ChainStage
    "Step name this stage was extracted from."
    name::Symbol
    "Per-stage exit rate ``1/\\theta``."
    rate::Float64
    "Number of Exponential sub-compartments ``k``."
    stages::Int
end

function Base.show(io::IO, s::ChainStage)
    print(io, "ChainStage(", s.name, ": ", s.stages,
        s.stages == 1 ? " stage @ rate " : " stages @ rate ",
        round(s.rate; digits = 4), ")")
    return nothing
end

# Round an integer-valued float (within tolerance) to an Int, else error: the
# Erlang shape must be a whole number for an exact linear chain.
function _erlang_shape(shape::Real)
    k = round(Int, shape)
    isapprox(shape, k; atol = 1e-8) || throw(ArgumentError(
        "the linear chain trick is exact only for Exponential or Erlang " *
        "(integer-shape Gamma) delays; got shape = $shape (non-integer). " *
        "Use `moment_match = true`, or `phase_type`, for general delays."))
    k >= 1 || throw(ArgumentError("Erlang shape must be ≥ 1, got $shape"))
    return k
end

# Map a single leaf distribution to its `(rate, stages)`. Any other family is
# not exactly representable as a finite linear chain.
_leaf_stage(d::Exponential) = (rate = inv(scale(d)), stages = 1)

function _leaf_stage(d::Gamma)
    k = _erlang_shape(shape(d))
    return (rate = inv(scale(d)), stages = k)
end

function _leaf_stage(d)
    throw(ArgumentError(
        "the linear chain trick needs an Exponential or Erlang " *
        "(integer-shape Gamma) leaf; got $(typeof(d)). Pass " *
        "`moment_match = true` to lower it to the nearest Erlang chain, or " *
        "use `phase_type` for an over-dispersed (c² > 1) delay."))
end

# Lower any leaf to its nearest Erlang `(rate, stages)` by matching the first
# two moments. `phase_type` is the single adaptive-fit entry point that calls
# here for the under/exactly-dispersed (c² ≤ 1) branch; it throws for
# over-dispersed delays (c² > 1, no Erlang chain matches both moments) rather
# than duplicating that fit — see [`phase_type`](@ref) for the c² > 1 case.
function _moment_stage(d)
    m = mean(d)
    v = var(d)
    (isfinite(m) && isfinite(v) && m > 0 && v > 0) || throw(ArgumentError(
        "moment matching needs a finite positive mean and variance; got " *
        "mean = $m, var = $v for $(typeof(d))."))
    scv = v / m^2
    scv <= 1 || throw(ArgumentError(
        "moment matching to an Erlang chain needs squared coefficient of " *
        "variation ≤ 1 (under-dispersed); got $(round(scv; digits = 3)) for " *
        "$(typeof(d)). Use `phase_type` for an over-dispersed delay."))
    k = max(round(Int, inv(scv)), 1)
    return (rate = k / m, stages = k)
end

_is_erlang_shape(::Exponential) = true
_is_erlang_shape(d::Gamma) = isapprox(shape(d), round(shape(d)); atol = 1e-8)
_is_erlang_shape(_) = false

# Pick the `(rate, stages)` for one leaf. The exact Exp/Erlang fast path is
# always tried first, so `moment_match` only changes behaviour when the exact
# lowering would reject.
function _stage(d, moment_match::Bool)
    moment_match || return _leaf_stage(d)
    (d isa Exponential || d isa Gamma) && _is_erlang_shape(d) &&
        return _leaf_stage(d)
    return _moment_stage(d)
end

"""
Lower a delay distribution to its compartment-stage structure.

An `Exponential(θ)` leaf gives one stage at rate ``1/\\theta``; an `Erlang(k,
θ)` leaf (an integer-shape `Gamma`) gives `k` stages at rate ``1/\\theta``.
Exact only for Exponential / Erlang leaves; any other family throws unless
`moment_match = true`, which lowers to the nearest Erlang chain by matching the
mean and squared coefficient of variation `c² = var / mean²` (`stages =
round(1 / c²)`, `rate = stages / mean`). An over-dispersed delay (`c² > 1`)
still throws — see [`phase_type`](@ref) for that case.

# Arguments

  - `d`: an Exp/Erlang delay leaf to lower.

# Keyword Arguments

  - `name`: the [`ChainStage`](@ref) name (default `:delay`).
  - `moment_match`: lower a non-Erlang leaf to the nearest Erlang chain
    instead of throwing (default `false`).

# Examples

```@example
using LoweredDistributions, Distributions

compartment_stages(Gamma(3.0, 1.5))
```

# See also

  - [`ChainStage`](@ref): the per-stage record.
  - [`ErlangChain`](@ref): wraps the returned vector as an
    [`AbstractChainTrick`](@ref).
  - [`phase_type`](@ref): the adaptive fit that also covers `c² > 1`.
"""
function compartment_stages(
        d::Distribution; name::Symbol = :delay, moment_match::Bool = false)
    s = _stage(d, moment_match)
    return [ChainStage(name, Float64(s.rate), s.stages)]
end
