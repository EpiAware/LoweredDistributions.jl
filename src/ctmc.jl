# CTMC: the memoryless generator-matrix representation. Ported from
# CensoredDistributions.jl's `composers/recurrent/CTMCStates.jl`, trimmed to
# the leaf-scope surface — the generator type, the `ctmc(specs...)` builder,
# `_matrix_exp`, and `transition_probability`. The `RecurrentStates`
# conversion, the panel/jump-chain `logpdf`, and `rand` stay in the
# semi-Markov composer stack (out of scope for a Distributions-only package).

"""
A continuous-time Markov chain generator over states.

`CTMC` holds a transition-intensity (generator) matrix `Q` over an ordered set
of `states`. Off-diagonal `Q[i, j]` is the `i -> j` transition rate, and each
diagonal is `Q[i, i] = -sum_{j != i} Q[i, j]`. Holding times are exponential,
so the transition-probability matrix is `P(t) = exp(Q t)` in closed form (see
[`transition_probability`](@ref)).

Build it with [`ctmc`](@ref).

# See also

  - [`ctmc`](@ref): the constructor verb.
  - [`transition_probability`](@ref): the `exp(Q t)` kernel.
"""
struct CTMC{St <: Tuple, M <: AbstractMatrix} <: AbstractLowering
    "Ordered state names; the `Q` rows / columns follow this order."
    states::St
    "The generator matrix (rows sum to zero)."
    Q::M

    function CTMC(states::St, Q::M) where {St <: Tuple, M <: AbstractMatrix}
        n = length(states)
        size(Q) == (n, n) || throw(ArgumentError(
            "the generator matrix must be $(n)x$(n) for $(n) states; got " *
            "$(size(Q))"))
        all(s -> s isa Symbol, states) ||
            throw(ArgumentError("every state name must be a Symbol"))
        _validate_generator(Q)
        return new{St, M}(states, Q)
    end
end

# A generator matrix has non-negative off-diagonals and zero-sum rows.
function _validate_generator(Q::AbstractMatrix)
    n = size(Q, 1)
    for i in 1:n
        rowsum = zero(eltype(Q))
        for j in 1:n
            if i != j
                Q[i, j] >= -1e-9 || throw(ArgumentError(
                    "off-diagonal generator rates must be non-negative; " *
                    "Q[$i, $j] = $(Q[i, j])"))
                rowsum += Q[i, j]
            end
        end
        isapprox(Q[i, i], -rowsum; atol = 1e-6) || throw(ArgumentError(
            "generator row $i must sum to zero (diagonal = -sum of " *
            "off-diagonals); got Q[$i, $i] = $(Q[i, i]), -rowsum = $(-rowsum)"))
    end
    return nothing
end

"""
Build a [`CTMC`](@ref) from `from => (to => rate, ...)` transition-rate specs.

Each argument is `from => transitions`, where `transitions` lists the outgoing
`to => rate` edges of state `from` (a single edge or a tuple / NamedTuple of
them). The state order is the order of first appearance (each `from`, then any
`to`-only absorbing states).

!!! warning "Enzyme"
    `ctmc(specs...)` does not differentiate under Enzyme (forward or reverse):
    the heterogeneous `Pair` vararg spec parsing hits an upstream Enzyme
    compiler limitation. ForwardDiff, ReverseDiff, and Mooncake (both modes)
    differentiate it correctly; the plain `_matrix_exp` / `transition_probability`
    kernel differentiates cleanly under every backend including Enzyme (see the
    ADFixtures `:recurrent` scenarios), which isolates the break to this
    builder's spec parsing rather than the matrix exponential.

# Arguments

  - `specs`: `from => transitions` pairs; `transitions` is a single `to =>
    rate` edge or a tuple / NamedTuple of `to => rate` edges (`rate >= 0`).

# Examples

```@example
using LoweredDistributions

model = ctmc(
    :well => (:ill => 0.2),
    :ill => (:well => 0.3, :dead => 0.1))
transition_probability(model, 5.0)
```

# See also

  - [`CTMC`](@ref): the model type.
  - [`transition_probability`](@ref): the `exp(Q t)` kernel.
"""
function ctmc(specs::Pair...)
    isempty(specs) && throw(ArgumentError("ctmc needs at least one state spec"))
    order = Symbol[]
    for (from, transitions) in specs
        from isa Symbol ||
            throw(ArgumentError("each state name must be a Symbol; got $from"))
        from in order || push!(order, from)
        for (to, _rate) in _ctmc_edges(transitions)
            to isa Symbol ||
                throw(ArgumentError("each edge destination must be a Symbol"))
            to in order || push!(order, to)
        end
    end
    states = Tuple(order)
    idx = Dict(s => i for (i, s) in enumerate(states))
    n = length(states)
    T = _ctmc_rate_type(Float64, specs...)
    Q = zeros(T, n, n)::Matrix{T}
    for (from, transitions) in specs
        i = idx[from]
        for (to, rate) in _ctmc_edges(transitions)
            rate >= 0 || throw(ArgumentError(
                "transition rate $(from) -> $(to) must be non-negative; " *
                "got $rate"))
            Q[i, idx[to]] += rate
        end
    end
    for i in 1:n
        Q[i, i] = -sum(Q[i, j] for j in 1:n if j != i; init = zero(T))
    end
    return CTMC(states, Q)
end

# Promote the generator element type from the edge rate types, so a
# Dual/tracked rate widens `T` without ever entering an untyped container.
_ctmc_rate_type(T::Type) = T
function _ctmc_rate_type(T::Type, spec::Pair, rest::Pair...)
    for (_to, rate) in _ctmc_edges(spec.second)
        T = promote_type(T, typeof(rate))
    end
    return _ctmc_rate_type(T, rest...)
end

# Normalise a state's transition spec to an iterable of `to => rate` edges.
_ctmc_edges(p::Pair) = (p,)
_ctmc_edges(t::Tuple) = t
_ctmc_edges(nt::NamedTuple) = map(=>, keys(nt), values(nt))

"""
    state_index(m::CTMC, s::Symbol)

The index of state `s` in `m.states`, or `nothing` if `s` is not present.

# Arguments

  - `m`: the [`CTMC`](@ref) model.
  - `s`: the state name to look up.

# Examples

```@example
using LoweredDistributions

m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
state_index(m, :ill)
```
"""
state_index(m::CTMC, s::Symbol) = findfirst(==(s), m.states)

"""
The transition-probability matrix `P(t) = exp(Q t)` of a [`CTMC`](@ref) over a
time gap `t`.

`P[i, j]` is the probability of being in state `j` a time `t` after being in
state `i`, marginalising over every intermediate jump.

# Examples

```@example
using LoweredDistributions

model = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
P = transition_probability(model, 2.0)
sum(P; dims = 2)  # each row sums to one
```

# See also

  - [`CTMC`](@ref): the model type.
"""
function transition_probability(m::CTMC, t::Real)
    t >= 0 || throw(ArgumentError("the time gap must be non-negative; got $t"))
    return _matrix_exp(m.Q .* t)
end

# Matrix exponential via scaling-and-squaring with a Taylor inner series, using
# LinearAlgebra's `*` (BLAS gemm for `Matrix{Float64}`) — proven to
# differentiate correctly at all sizes under Mooncake and Enzyme, so this is
# not rewritten as a BLAS-free loop. The squaring count `s` and the
# convergence break are plain scalar control flow: comparisons and
# `ceil(Int, ...)` on a Dual/TrackedReal already collapse to plain numbers
# under ForwardDiff / ReverseDiff, and Enzyme / Mooncake run the primal pass
# on plain `Float64` regardless, so no extra AD-stripping is needed here.
function _matrix_exp(A::AbstractMatrix)
    n = size(A, 1)
    T = promote_type(eltype(A), Float64)
    nrm = maximum(sum(abs, A; dims = 2))
    s = max(0, ceil(Int, log2(nrm + eps())))
    B = A ./ (2^s)
    E = Matrix{T}(I, n, n)
    term = Matrix{T}(I, n, n)
    for k in 1:30
        term = (term * B) ./ k
        E = E .+ term
        maximum(abs, term) < 1e-15 && break
    end
    for _ in 1:s
        E = E * E
    end
    return E
end

function Base.show(io::IO, m::CTMC)
    print(io, "CTMC(", length(m.states), " states)")
    return nothing
end

function Base.show(io::IO, ::MIME"text/plain", m::CTMC)
    println(io, "CTMC continuous-time Markov chain")
    println(io, "  states: ", join(string.(m.states), ", "))
    for i in 1:length(m.states), j in 1:length(m.states)

        i != j && m.Q[i, j] > 0 &&
            println(io, "  ", m.states[i], " -> ",
                m.states[j], " @ rate ", round(m.Q[i, j]; digits = 4))
    end
    return nothing
end
