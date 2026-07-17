# Series composition (convolution) of phase-types. A sum of independent delays
# is itself phase-type: run the first phase-type to absorption, then enter the
# next by its own initial distribution. Shared machinery behind the
# ConvolvedDistributions lowering bridge (and, later, the Sequential composer
# bridge) — both fold a sequence of component phase-types into one.

"""
    _convolve_phase_types(pts)

Fold an iterable of [`PhaseType`](@ref)s into the single `PhaseType` of their
convolution — the delay of passing through each in turn. Exact rather than
fitted: the convolution of phase-types is a phase-type, carrying
`sum(length(p.α) for p in pts)` phases.
"""
_convolve_phase_types(pts) = reduce(_convolve_two, pts)

# Pairwise series composition of `p` then `q`. With `p`'s exit-rate vector
# `s = -S_p 1` (each phase's rate to absorption), the composite generator is
# block-upper-triangular — `p`'s phases, then `q`'s, with `s α_q'` routing `p`'s
# absorption into `q`'s initial distribution:
#
#     S = [ S_p   s α_q' ]     α = [ α_p ; 0 ]
#         [ 0     S_q    ]
#
# `p`'s phases now leak into `q` rather than to absorption, so every row sum
# stays ≤ 0 and the block is a valid sub-generator. All blocks are promoted to a
# common element type, so a differentiated component rate carries straight
# through (no concrete-Float64 field truncates an AD dual).
function _convolve_two(p::PhaseType, q::PhaseType)
    T = promote_type(eltype(p.α), eltype(p.S), eltype(q.α), eltype(q.S))
    Sp, Sq = T.(p.S), T.(q.S)
    αp, αq = T.(p.α), T.(q.α)
    kp, kq = length(αp), length(αq)
    exit_p = -(Sp * ones(T, kp))
    S = [Sp exit_p*transpose(αq);
         zeros(T, kq, kp) Sq]
    α = vcat(αp, zeros(T, kq))
    return PhaseType(α, S)
end
