# Concrete AbstractChainTrick representations. All three canonicalise to a
# PhaseType(α, S): a single Coxian conversion (ErlangChain -> Coxian -> the
# general absorbing-CTMC sub-generator view) so a backend (the Catalyst
# extension, or a later ODE/MTK one) can consume one shape regardless of which
# fit produced it.

"""
An exact or moment-matched Erlang chain: [`compartment_stages`](@ref) wrapped
as an [`AbstractChainTrick`](@ref).

# See also

  - [`compartment_stages`](@ref): builds the wrapped stage vector.
  - [`phase_type`](@ref): the adaptive fit that returns this for `c² ≤ 1`.
"""
struct ErlangChain{S <: AbstractVector{<:ChainStage}} <: AbstractChainTrick
    "The per-step stages, in chain order."
    stages::S
end

ErlangChain(d::Distribution; kwargs...) = ErlangChain(compartment_stages(d; kwargs...))

function Base.show(io::IO, e::ErlangChain)
    k = sum(s.stages for s in e.stages)
    print(io, "ErlangChain(", k, " compartment", k == 1 ? "" : "s", ")")
    return nothing
end

"""
A Coxian phase-type: `stages` exponential phases visited in order, each
absorbing with probability `1 - probs[i]` instead of continuing to phase `i +
1` (`probs[end]` is ignored — the last phase always absorbs on exit).

A sequential (never-branching) chain like this can only reach a squared
coefficient of variation `c² ≤ 1` (the same regime as [`ErlangChain`](@ref),
which it generalises to heterogeneous per-phase rates); an over-dispersed `c² >
1` delay needs the branching a general [`PhaseType`](@ref) allows (see
[`phase_type`](@ref)).

# See also

  - [`PhaseType`](@ref): `PhaseType(::Coxian)` gives the canonical
    `(α, S)` embedding.
"""
struct Coxian{R <: AbstractVector{<:Real}, P <: AbstractVector{<:Real}} <:
       AbstractChainTrick
    "Per-phase exit rate."
    rates::R
    "Per-phase probability of continuing to the next phase."
    probs::P

    function Coxian(rates::R, probs::P) where
            {R <: AbstractVector{<:Real}, P <: AbstractVector{<:Real}}
        k = length(rates)
        length(probs) == k ||
            throw(ArgumentError("rates and probs must have the same length"))
        k >= 1 || throw(ArgumentError("a Coxian needs at least one phase"))
        all(>=(0), rates) ||
            throw(ArgumentError("Coxian rates must be non-negative"))
        all(p -> 0 <= p <= 1, probs) ||
            throw(ArgumentError("Coxian probs must lie in [0, 1]"))
        return new{R, P}(rates, probs)
    end
end

# Concatenate an ErlangChain's stages into one Coxian: every sub-compartment
# continues on (prob 1) except the very last, which always absorbs. The rate
# element type is carried through from the stages so a differentiated rate
# survives (an ErlangChain built from an AD dual lowers to a dual-carrying
# Coxian, then PhaseType); the continue/absorb probabilities are structural
# (exactly 1 or 0) and stay `Float64`.
function Coxian(e::ErlangChain)
    T = mapreduce(s -> typeof(s.rate), promote_type, e.stages)
    rates = T[]
    for s in e.stages
        append!(rates, fill(s.rate, s.stages))
    end
    k = length(rates)
    probs = [i < k ? one(T) : zero(T) for i in 1:k]
    return Coxian(rates, probs)
end

function Base.show(io::IO, c::Coxian)
    print(io, "Coxian(", length(c.rates), " phases)")
    return nothing
end

"""
A general phase-type distribution: an initial distribution `α` over
transient phases plus a sub-generator `S` (the absorbing continuous-time
Markov chain of a finite mixture / chain of exponential phases).

`α` sums to one; `S` has non-positive diagonal, non-negative off-diagonal, and
row sums `≤ 0` (the shortfall `-sum(S[i, :])` is phase `i`'s exit rate to the
absorbing state).

# See also

  - [`Coxian`](@ref), [`ErlangChain`](@ref): narrower representations this
    type generalises; both convert here via `PhaseType(::Coxian)` /
    `PhaseType(::ErlangChain)`.
  - [`phase_type`](@ref): the adaptive fit that returns this for `c² > 1`.
"""
struct PhaseType{A <: AbstractVector{<:Real}, M <: AbstractMatrix{<:Real}} <:
       AbstractChainTrick
    "Initial distribution over phases."
    α::A
    "Sub-generator over the transient phases."
    S::M

    function PhaseType(α::A, S::M) where
            {A <: AbstractVector{<:Real}, M <: AbstractMatrix{<:Real}}
        k = length(α)
        size(S) == (k, k) || throw(ArgumentError(
            "S must be $(k)x$(k) for $(k) phases; got $(size(S))"))
        isapprox(sum(α), 1; atol = 1e-8) ||
            throw(ArgumentError("α must sum to one; got sum = $(sum(α))"))
        all(x -> x >= -1e-9, α) ||
            throw(ArgumentError("α entries must be non-negative"))
        _validate_subgenerator(S)
        return new{A, M}(α, S)
    end
end

# A sub-generator: non-negative off-diagonals, negative diagonals, and row
# sums <= 0 (the shortfall leaks to the absorbing state).
function _validate_subgenerator(S::AbstractMatrix)
    n = size(S, 1)
    for i in 1:n
        S[i, i] < 0 ||
            throw(ArgumentError("S[$i, $i] must be negative; got $(S[i, i])"))
        rowsum = zero(eltype(S))
        for j in 1:n
            if i != j
                S[i, j] >= -1e-9 || throw(ArgumentError(
                    "off-diagonal sub-generator rates must be " *
                    "non-negative; S[$i, $j] = $(S[i, j])"))
                rowsum += S[i, j]
            end
        end
        rowsum <= -S[i, i] + 1e-6 || throw(ArgumentError(
            "sub-generator row $i sums to more than its exit rate allows: " *
            "off-diagonal sum $rowsum > $(-S[i, i])"))
    end
    return nothing
end

function PhaseType(c::Coxian)
    k = length(c.rates)
    T = promote_type(eltype(c.rates), eltype(c.probs))
    α = zeros(T, k)
    α[1] = one(T)
    S = zeros(T, k, k)
    for i in 1:k
        S[i, i] = -c.rates[i]
        i < k && (S[i, i + 1] = c.rates[i] * c.probs[i])
    end
    return PhaseType(α, S)
end

PhaseType(e::ErlangChain) = PhaseType(Coxian(e))
PhaseType(p::PhaseType) = p

function Base.show(io::IO, p::PhaseType)
    print(io, "PhaseType(", length(p.α), " phases)")
    return nothing
end
