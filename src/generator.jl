# Internal: the full state-space generator (states x states, absorption
# included) and a default initial condition for any AbstractLowering. This is
# the shared numeric core `ode_problem` (in the SciMLBase extension) builds
# on; kept dependency-free (no SciMLBase import) so it works without that
# extension loaded, and so the extension itself stays a thin ODEProblem
# wrapper rather than duplicating this dispatch.
#
# A CTMC's own Q already spans every state (absorbing states included). An
# AbstractChainTrick's canonical PhaseType(α, S) only covers the TRANSIENT
# phases (S is a sub-generator, rows summing to <= 0); appending one more
# state for "absorbed", with each phase's shortfall exit rate as its entry,
# turns S into a full generator over `k + 1` states — the same shape a CTMC
# already has. That is what lets `ode_problem` treat every AbstractLowering
# uniformly.

_generator(m::CTMC) = (Q = m.Q, u0 = _onehot(eltype(m.Q), length(m.states), 1))

function _generator(m::AbstractChainTrick)
    pt = PhaseType(m)
    k = length(pt.α)
    T = promote_type(eltype(pt.α), eltype(pt.S))
    Q = zeros(T, k + 1, k + 1)
    Q[1:k, 1:k] .= pt.S
    for i in 1:k
        Q[i, k + 1] = -sum(@view pt.S[i, :])
    end
    u0 = vcat(pt.α, zero(T))
    return (Q = Q, u0 = u0)
end

_onehot(::Type{T}, n::Int, i::Int) where {T} = [j == i ? one(T) : zero(T) for j in 1:n]
