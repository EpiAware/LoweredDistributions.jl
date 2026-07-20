# Structure-preserving parameter edits for lowered objects.
#
# `update` rebuilds a lowering with new CONTINUOUS parameters while keeping its
# STRUCTURE — phase count, transition topology, state set — fixed. It is pure
# (no `update!`: the structure lives in the type, so a functional rebuild is
# the right model and the AD-friendly one), type-stable, and allocation-light,
# so it is the operation a gradient-based fitting loop runs inside the
# differentiated region: `lower` once to choose the structure, then `update`
# the continuous parameters under the sampler. `parameters` is the read-back
# pair, with `update(l, parameters(l)) == l`.
#
# Two input shapes:
#   - a `NamedTuple` (ergonomic, per-type keys);
#   - a flat `AbstractVector` (the fitting primitive, whose `eltype` carries the
#     AD dual). Each lowered type documents ONE canonical flat ordering, which
#     the DistributionsInference reconstruct/parameter_rows bridge reuses.

@doc """
The continuous parameters of a lowered object as a `NamedTuple`, its structure
held fixed. Paired with [`update`](@ref): `update(l, parameters(l)) == l`.

The keys are per lowered type:

  - [`ErlangChain`](@ref), [`Coxian`](@ref), [`CTMC`](@ref): `(; rates)` — the
    per-stage / per-phase / per-transition rates. For a `CTMC` these are the
    existing (structurally present) off-diagonal rates only, in row-major order.
  - [`PhaseType`](@ref): `(; α, S)` — the raw initial distribution and
    sub-generator entries.

# Arguments

  - `l`: the lowered object to read parameters from.

# See also

  - [`update`](@ref): the structure-preserving rebuild this inverts.
"""
function parameters end

@doc """
Rebuild a lowered object with new continuous `params`, preserving its structure
(phase count, transition topology, state set). Pure — it returns a new object
of the same concrete type and never mutates `l`.

`params` is either a `NamedTuple` matching [`parameters`](@ref)'s keys for `l`'s
type, or a flat `AbstractVector` in that type's canonical order:

  - [`ErlangChain`](@ref) / [`Coxian`](@ref): the rates, in stage / phase order.
  - [`CTMC`](@ref): the existing off-diagonal transition rates, row-major
    (state `i` outer, `j` inner, skipping absent transitions). Editing an
    existing transition is a parameter change; introducing a new one is a
    structural change and needs a fresh `lower`, not `update`.
  - [`PhaseType`](@ref): `[α; vec(S)]` — the initial distribution followed by
    the column-major sub-generator entries.

The `eltype` of a flat vector flows into the rebuilt object, so a differentiated
parameter carries straight through; this is the AD-stable form for fitting. The
rebuild goes through the object's own constructor, so its validity checks (a
`PhaseType`'s `α` summing to one and `S` being a sub-generator, a `CTMC`'s rows
summing to zero) still apply — `update` enforces nothing beyond them.

# Arguments

  - `l`: the lowered object whose structure to preserve.
  - `params`: a `NamedTuple` or flat `AbstractVector` of new continuous values.

# Examples

```@example
using LoweredDistributions, Distributions

e = lower(Gamma(3.0, 1.0))          # a 3-stage ErlangChain, structure fixed
update(e, [0.5])                    # same structure, new per-stage rate
parameters(e)                       # (; rates = [...])
```

# See also

  - [`parameters`](@ref): the read-back pair, `update(l, parameters(l)) == l`.
  - [`lower`](@ref): chooses the structure `update` then holds fixed.
"""
function update end

# --- ErlangChain: one rate per ChainStage, in stage order --------------------

parameters(e::ErlangChain) = (; rates = [s.rate for s in e.stages])

function update(e::ErlangChain, rates::AbstractVector)
    n = length(e.stages)
    length(rates) == n || throw(ArgumentError(
        "an ErlangChain with $n stage(s) needs $n rate(s); got " *
        "$(length(rates))"))
    stages = [ChainStage(s.name, rates[i], s.stages)
              for (i, s) in enumerate(e.stages)]
    return ErlangChain(stages)
end

update(e::ErlangChain, nt::NamedTuple) = update(e, nt.rates)

# --- Coxian: one rate per phase; probs are structural (continue/absorb) ------

parameters(c::Coxian) = (; rates = c.rates)

function update(c::Coxian, rates::AbstractVector)
    length(rates) == length(c.rates) || throw(ArgumentError(
        "a Coxian with $(length(c.rates)) phase(s) needs " *
        "$(length(c.rates)) rate(s); got $(length(rates))"))
    return Coxian(rates, c.probs)
end

update(c::Coxian, nt::NamedTuple) = update(c, nt.rates)

# --- PhaseType: raw (α, S) entries -------------------------------------------

parameters(p::PhaseType) = (; α = p.α, S = p.S)

update(p::PhaseType, nt::NamedTuple) = PhaseType(nt.α, nt.S)

function update(p::PhaseType, x::AbstractVector)
    k = length(p.α)
    length(x) == k + k * k || throw(ArgumentError(
        "a PhaseType with $k phase(s) needs $(k + k * k) entries " *
        "([α; vec(S)]); got $(length(x))"))
    α = x[1:k]
    S = reshape(x[(k + 1):(k + k * k)], k, k)
    return PhaseType(α, S)
end

# --- CTMC: existing off-diagonal transition rates, row-major -----------------

# The structurally present off-diagonal positions, row-major (state i outer,
# j inner). "Present" means a non-zero rate in the lowered object's generator;
# a zero off-diagonal is an absent transition and stays absent under `update`.
function _ctmc_transitions(m::CTMC)
    n = length(m.states)
    ix = Tuple{Int, Int}[]
    for i in 1:n, j in 1:n

        i != j && !iszero(m.Q[i, j]) && push!(ix, (i, j))
    end
    return ix
end

parameters(m::CTMC) = (; rates = [m.Q[i, j] for (i, j) in _ctmc_transitions(m)])

function update(m::CTMC, rates::AbstractVector)
    ix = _ctmc_transitions(m)
    length(rates) == length(ix) || throw(ArgumentError(
        "this CTMC has $(length(ix)) transition(s); got $(length(rates)) " *
        "rate(s). `update` edits existing transitions only — a new edge is a " *
        "structural change, so re-`lower` for that."))
    n = length(m.states)
    T = eltype(rates)
    # Rebuild the generator directly (NOT via `ctmc(specs...)`, whose Pair
    # vararg parsing does not differentiate under Enzyme): a plain typed matrix
    # with the diagonal recomputed as the negated row sum keeps every backend.
    Q = zeros(T, n, n)
    for (e, (i, j)) in enumerate(ix)
        Q[i, j] = rates[e]
    end
    for i in 1:n
        Q[i, i] = -sum(Q[i, j] for j in 1:n if j != i; init = zero(T))
    end
    return CTMC(m.states, Q)
end

update(m::CTMC, nt::NamedTuple) = update(m, nt.rates)

# --- Fallback for any future lowering without an update rule -----------------

function update(l::AbstractLowering, params)
    throw(ArgumentError(
        "no `update` rule is defined for a $(typeof(l)) lowering. `update` " *
        "is defined for ErlangChain, Coxian, PhaseType and CTMC; a new " *
        "lowering type needs its own structure-preserving rebuild."))
end

function parameters(l::AbstractLowering)
    throw(ArgumentError(
        "no `parameters` rule is defined for a $(typeof(l)) lowering."))
end

# Value equality for lowered objects. The default `==` falls back to `===`
# (identity) for a struct holding an array, so two lowerings with equal contents
# would compare unequal; these field-wise methods make the `update(l,
# parameters(l)) == l` round-trip expressible, and let callers compare lowered
# objects by value generally.
function Base.:(==)(a::ChainStage, b::ChainStage)
    a.name == b.name && a.rate == b.rate && a.stages == b.stages
end
Base.:(==)(a::ErlangChain, b::ErlangChain) = a.stages == b.stages
Base.:(==)(a::Coxian, b::Coxian) = a.rates == b.rates && a.probs == b.probs
Base.:(==)(a::PhaseType, b::PhaseType) = a.α == b.α && a.S == b.S
Base.:(==)(a::CTMC, b::CTMC) = a.states == b.states && a.Q == b.Q
