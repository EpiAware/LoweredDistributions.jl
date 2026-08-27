# The return path: a lowering back to a `Distributions.Distribution`.
#
# `lower` is many-to-one. It keeps a delay's mean and squared coefficient of
# variation and discards everything else, including which family the delay came
# from, so the family cannot be recovered from a lowering alone. Two verbs would
# be one too many for that: the single `lowering_to_distribution` recovers the
# lowering's own law exactly, and naming a target family as a second argument is
# the explicit request to project onto it.

@doc """
A phase-type law as a `Distributions.Distribution`.

Wraps a [`PhaseType`](@ref)'s `(α, S)` so a lowering can be sampled and
evaluated directly. The density is `α' exp(S t) s`, where `s = -S 1` collects
the per-phase exit rates, and the survival is `α' exp(S t) 1`.

Returned by [`lowering_to_distribution`](@ref) whenever the lowering's law has
no named `Distributions.jl` family. A homogeneous chain comes back as a `Gamma`
and a single phase as an `Exponential` instead, since those names are exact.

# Fields

  - `pt`: the [`PhaseType`](@ref) whose law this is.

# See also

  - [`lowering_to_distribution`](@ref): the verb that returns this.
"""
struct PhaseTypeDist{P <: PhaseType} <: ContinuousUnivariateDistribution
    "The phase-type representation whose law this distribution is."
    pt::P
end

Base.minimum(::PhaseTypeDist) = 0.0
Base.maximum(::PhaseTypeDist) = Inf
Distributions.insupport(::PhaseTypeDist, x::Real) = x >= 0

function Base.show(io::IO, d::PhaseTypeDist)
    print(io, "PhaseTypeDist(", length(d.pt.α), " phases)")
    return nothing
end

# The per-phase exit rates: each row's shortfall against its own diagonal.
_exit_rates(pt::PhaseType) = -pt.S * ones(eltype(pt.S), length(pt.α))

function Distributions.pdf(d::PhaseTypeDist, t::Real)
    t < 0 && return zero(float(t))
    return only(transpose(d.pt.α) * _matrix_exp(d.pt.S .* t) * _exit_rates(d.pt))
end

Distributions.logpdf(d::PhaseTypeDist, t::Real) = log(pdf(d, t))

function Distributions.ccdf(d::PhaseTypeDist, t::Real)
    t < 0 && return one(float(t))
    surv = transpose(d.pt.α) * _matrix_exp(d.pt.S .* t)
    return sum(surv)
end

Distributions.cdf(d::PhaseTypeDist, t::Real) = 1 - ccdf(d, t)

# Moments from the fundamental matrix: `m1 = α' (-S)^-1 1` and
# `m2 = 2 α' (-S)^-2 1`. The dense solve is confined here — the named-family
# branches of `lowering_to_distribution` never reach it, and `ErlangChain`
# moments below are closed form.
function _phase_moments(pt::PhaseType)
    N = -pt.S
    ones_v = ones(eltype(pt.S), length(pt.α))
    m1v = N \ ones_v
    m1 = only(transpose(pt.α) * m1v)
    m2 = 2 * only(transpose(pt.α) * (N \ m1v))
    return m1, m2 - m1^2
end

Statistics.mean(d::PhaseTypeDist) = first(_phase_moments(d.pt))
Statistics.var(d::PhaseTypeDist) = last(_phase_moments(d.pt))

# Sample by walking the phases: draw a start from `α`, hold an exponential time
# in each phase, and jump until the exit competes successfully.
function Base.rand(rng::AbstractRNG, d::PhaseTypeDist)
    pt = d.pt
    k = length(pt.α)
    phase = rand(rng, Distributions.Categorical(collect(pt.α ./ sum(pt.α))))
    total = 0.0
    while true
        rate = -pt.S[phase, phase]
        rate > 0 || return total
        total += randexp(rng) / rate
        weights = [i == phase ? 0.0 : max(pt.S[phase, i], 0.0) for i in 1:k]
        moved = sum(weights)
        rand(rng) * rate >= moved && return total
        phase = rand(rng, Distributions.Categorical(weights ./ moved))
    end
end

@doc """
    lowering_to_distribution(l)
    lowering_to_distribution(l, ::Type{F})

Map a lowering back to a `Distributions.Distribution`.

The one-argument form returns the lowering's own law, exactly. A homogeneous
[`ErlangChain`](@ref) is a `Gamma`, a single phase an `Exponential`, and
anything else a [`PhaseTypeDist`](@ref), whose density is closed form.

The two-argument form projects onto the named family `F` by matching the first
two moments. This is the only way back to the family a delay started as:
[`lower`](@ref) keeps a delay's mean and squared coefficient of variation and
nothing else, so `lower(LogNormal(0, 0.5))` and a moment-matched `Gamma` land on
the same chain and the family cannot be read back from it.

[`lowering_to_dist`](@ref) is an alias.

!!! note "The round trip is not the identity"
    `lower` quantises the phase count to `k = round(1 / c²)` when `c² <= 1`, so
    the recovered variance sits on the `1 / k` grid while the mean stays exact.
    `lowering_to_distribution(lower(d), F) == d` does not hold in general, and
    `lower(lowering_to_distribution(lower(d), F)) == lower(d)` does.

# Arguments

  - `l`: the lowering to read back.
  - `F`: a distribution family to project onto. `Exponential`, `Gamma`,
    `LogNormal` and `Normal` invert their moments in closed form; another
    family needs a `_from_moments` method.

# Examples

```@example
using LoweredDistributions, Distributions

lowering_to_distribution(lower(Gamma(3.0, 1.5)))          # Gamma, exact
lowering_to_distribution(lower(Exponential(2.0)))         # Exponential, exact
lowering_to_distribution(lower(Gamma(0.5, 1.0)))          # PhaseTypeDist
lowering_to_distribution(lower(LogNormal(0.0, 0.5)), LogNormal)
```

# See also

  - [`lower`](@ref): the forward direction this reads back.
  - [`PhaseTypeDist`](@ref): the return type when the law has no family name.
"""
function lowering_to_distribution end

# A chain whose stages all share one rate is exactly Gamma(total, 1 / rate).
function lowering_to_distribution(e::ErlangChain)
    rates = [s.rate for s in e.stages]
    k = sum(s.stages for s in e.stages)
    allequal(rates) || return PhaseTypeDist(PhaseType(e))
    return k == 1 ? Exponential(inv(first(rates))) :
           Gamma(k, inv(first(rates)))
end

function lowering_to_distribution(c::Coxian)
    length(c.rates) == 1 && return Exponential(inv(first(c.rates)))
    return PhaseTypeDist(PhaseType(c))
end

function lowering_to_distribution(p::PhaseType)
    length(p.α) == 1 && return Exponential(inv(-only(p.S)))
    return PhaseTypeDist(p)
end

lowering_to_distribution(m::CTMC) = lowering_to_distribution(PhaseType(m))

function lowering_to_distribution(l::AbstractLowering, ::Type{F}) where
    {F <: Distribution}
    d = lowering_to_distribution(l)
    return _from_moments(F, mean(d), var(d))
end

@doc """
    _from_moments(::Type{F}, m, v)

Return the member of family `F` with mean `m` and variance `v`.

Closed form for the families whose two moments identify them uniquely. Add a
method here to make a further family reachable from
[`lowering_to_distribution`](@ref).
"""
function _from_moments(::Type{F}, m, v) where {F <: Distribution}
    throw(ArgumentError(
        "no closed-form moment inversion for $F; add a " *
        "`_from_moments(::Type{$F}, m, v)` method to project onto it"))
end

_from_moments(::Type{Exponential}, m, _) = Exponential(m)
_from_moments(::Type{Gamma}, m, v) = Gamma(m^2 / v, v / m)
_from_moments(::Type{Normal}, m, v) = Normal(m, sqrt(v))

function _from_moments(::Type{LogNormal}, m, v)
    σ² = log1p(v / m^2)
    return LogNormal(log(m) - σ² / 2, sqrt(σ²))
end

@doc """
    lowering_to_dist(l)
    lowering_to_dist(l, ::Type{F})

Alias for [`lowering_to_distribution`](@ref).

Both names bind the same function, so a method added to one is visible through
the other.

# Arguments

  - `l`: the lowering to read back.
  - `F`: a distribution family to project onto.

# Examples

```@example
using LoweredDistributions, Distributions

lowering_to_dist(lower(Gamma(3.0, 1.5)))
lowering_to_dist(lower(LogNormal(0.0, 0.5)), LogNormal)
```

# See also

  - [`lowering_to_distribution`](@ref): the name this aliases.
"""
const lowering_to_dist = lowering_to_distribution
