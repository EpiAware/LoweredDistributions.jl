# ModifiedDistributions × LoweredDistributions
#
# Hosted here per the hub-owned decision (#23, re-homed from
# ModifiedDistributions#68): `lower(dist)::AbstractLowering` maps a
# distribution onto a backend-agnostic dynamical-systems representation (a
# `CTMC` or an `AbstractChainTrick` phase-type), and the Spec/generator
# knowledge that mapping needs is LoweredDistributions' domain, so this
# extension reads ModifiedDistributions' public modifier-leaf accessors and
# defines `lower` for them here rather than the other way round.
#
# The bridge is PARTIAL by mathematical necessity: a modifier bears either
# *dynamics* (it lowers) or *observation* (it must be refused, never silently
# approximated). The contract mirrors LoweredDistributions' own throw-on-
# non-integer-Erlang pattern: an explicit `ArgumentError` rather than a wrong
# lowering.
#
#   ✅ Lowers
#     - `Affine` with `shift = 0`: a phase-type is closed under positive
#       rescaling, so `Y = scale · X` divides every transition rate by `scale`.
#     - (`Modified` on an Exponential leaf, below — a constant hazard stays
#       constant under a hazard modification, so the modified leaf is again an
#       Exponential and lowers exactly.)
#
#   ❌ Refused (explicit throw)
#     - `Affine` with `shift ≠ 0`: a deterministic added delay is not
#       phase-type (no finite Markov chain has a deterministic holding time).
#     - `Weighted`: a likelihood weight is pure observation, zero dynamics.
#     - `Transformed` (`thin`/`cumulative`/`series_transform`): a forward series
#       op. `thin` *would* lower as a competing-risk split, but that needs a
#       NoEvent absorbing sink LoweredDistributions' wave-1 API does not expose
#       (see the `thin` branch). `cumulative` and a general series map have no
#       rate-structure image at all.
#     - `Modified` on a non-Exponential leaf: proportional/additive hazards are
#       exact rate-scaling only when the base hazard is constant; on an Erlang
#       (or any non-Exponential) the modified object is not phase-type.
#     - `Modified` under a non-analytic link (logit): discrete-time / needs
#       numeric integration, no CTMC image.
#
# Function owner: LoweredDistributions (`lower`). Type owner:
# ModifiedDistributions (`Affine` / `Weighted` / `Transformed` / `Modified`).
# The extension depends on both, so there is no type piracy.
module LoweredDistributionsModifiedDistributionsExt

import LoweredDistributions: lower
using LoweredDistributions: AbstractLowering, CTMC, ErlangChain, Coxian,
                            PhaseType, ChainStage
using ModifiedDistributions: Affine, Weighted, Transformed, Modified,
                             ThinOp, CumulativeOp, LogLink, IdentityLink,
                             get_dist, get_scale, get_shift, get_effect,
                             get_link, get_op, get_factor
using Distributions: Exponential, scale

# --- Affine: positive rescaling divides every rate --------------------------

# `Y = scale · X + shift`. A pure positive rescaling (`shift = 0`) maps onto the
# lowered representation exactly: a phase-type is closed under time-scaling, so
# multiplying the holding times by `scale` divides every transition rate by
# `scale`. A non-zero `shift` adds a deterministic delay, which no finite
# Markov chain reproduces, so it is refused rather than mis-lowered.
function lower(d::Affine)
    iszero(get_shift(d)) || throw(ArgumentError(
        "lowering an affine transform is exact only for a pure positive " *
        "rescaling (shift = 0). A deterministic shift adds a fixed delay, " *
        "which is not phase-type — no finite Markov chain has a deterministic " *
        "holding time. Got shift = $(get_shift(d)). Erlang-approximate the " *
        "shift explicitly if an approximation is acceptable."))
    return _rescale_rates(lower(get_dist(d)), get_scale(d))
end

# Divide every transition rate of a lowering by `s > 0` (stretch holding times
# by `s`). Each concrete representation keeps its type so a downstream backend
# (e.g. the Catalyst reaction-network bridge) still sees the same structure.
_rescale_rates(l::CTMC, s::Real) = CTMC(l.states, l.Q ./ s)

function _rescale_rates(l::ErlangChain, s::Real)
    return ErlangChain([ChainStage(st.name, st.rate / s, st.stages)
                        for st in l.stages])
end

_rescale_rates(l::Coxian, s::Real) = Coxian(l.rates ./ s, l.probs)

_rescale_rates(l::PhaseType, s::Real) = PhaseType(l.α, l.S ./ s)

function _rescale_rates(l::AbstractLowering, s::Real)
    throw(ArgumentError(
        "no rate-rescaling rule is defined for a $(typeof(l)) lowering; this " *
        "is a gap in the ModifiedDistributions → LoweredDistributions bridge. " *
        "Please report it."))
end

# --- Weighted: a likelihood weight has no dynamics --------------------------

function lower(d::Weighted)
    throw(ArgumentError(
        "a Weighted distribution carries a likelihood weight, not dynamics: " *
        "it rescales logpdf and has no rate-structure image, so it does not " *
        "lower to a dynamical system. Apply the weight at inference time, " *
        "outside the lowered model."))
end

# --- Transformed: forward series ops ----------------------------------------

# A forward-transform op acts on the count series a downstream convolution
# layer produces, not on the delay's rate structure.
#
#   - `thin(d, p)` *does* have a dynamical reading — a competing-risk split,
#     probability `p` into the event chain and `1 - p` into a NoEvent absorbing
#     sink — but LoweredDistributions' wave-1 API exposes no NoEvent /
#     competing-risk (MAPH) sink type: `PhaseType(α, S)` requires `α` to place
#     all mass on event-reaching phases (`sum(α) = 1`), so it cannot carry the
#     `1 - p` mass that never events. So `thin` is refused until that sink
#     lands, rather than silently dropping the competing risk.
#   - `cumulative` (a running sum) and a general `series_transform` map have no
#     rate-structure image at all.
function lower(d::Transformed)
    op = get_op(d)
    if op isa ThinOp
        throw(ArgumentError(
            "lowering thin(d, p = $(get_factor(op))) is not yet supported: it " *
            "needs a NoEvent competing-risk sink in LoweredDistributions. The " *
            "dynamical reading of thinning is a competing-risk split — " *
            "probability p into the event chain, 1 - p into a NoEvent " *
            "absorbing sink — but LoweredDistributions' wave-1 API has no " *
            "NoEvent / competing-risk (MAPH) sink type (PhaseType requires " *
            "the initial distribution to place all mass on event-reaching " *
            "phases). Refusing rather than dropping the 1 - p competing risk."))
    elseif op isa CumulativeOp
        throw(ArgumentError(
            "cumulative() accumulates a downstream count series; a running " *
            "sum is a series operation with no rate-structure image, so it " *
            "does not lower to a dynamical system."))
    else
        throw(ArgumentError(
            "series_transform carries an arbitrary series map ($(typeof(op))); " *
            "an arbitrary map of a count series has no rate-structure image, " *
            "so it does not lower to a dynamical system."))
    end
end

# --- Modified: exact only on a constant-hazard Exponential leaf --------------

# A hazard modification `h*(t) = g⁻¹(g(h(t)) + effect)` is exact rate-scaling
# only when the base hazard `h` is constant, i.e. the leaf is an Exponential.
# There the modified leaf is again an Exponential and lowers exactly:
#
#   - log link (proportional hazards): `h* = exp(effect) · λ`, so the modified
#     leaf is `Exponential(θ · exp(-effect))`;
#   - identity link (additive hazards): `h* = λ + effect` (the constructor
#     forces `effect ≥ 0`, so `h* > 0`), the modified leaf is
#     `Exponential(1 / (λ + effect))`.
#
# On any non-Exponential leaf the base hazard varies with time, so the modified
# object is not phase-type (it would need time-varying rates); that is refused.
# A logit (or any non-log/identity) link is discrete-time / needs numeric
# integration and has no CTMC image.
function lower(d::Modified)
    inner = get_dist(d)
    inner isa Exponential || throw(ArgumentError(
        "lowering a Modified (hazard-modified) distribution is exact only on " *
        "a constant-hazard Exponential leaf: proportional/additive hazards " *
        "are exact rate-scaling only when the base hazard is constant. Got a " *
        "$(typeof(inner)) leaf, whose hazard varies with time, so the " *
        "modified object is not phase-type (it would need time-varying " *
        "rates). Refusing rather than mis-lowering."))
    effect = get_effect(d)
    link = get_link(d)
    θ = scale(inner)
    if link === LogLink
        return lower(Exponential(θ * exp(-effect)))
    elseif link === IdentityLink
        return lower(Exponential(inv(inv(θ) + effect)))
    else
        throw(ArgumentError(
            "lowering a Modified under a $(link) link is not supported: only " *
            "the log (proportional-hazards) and identity (additive-hazards) " *
            "links have a rate-structure image. A logit link is discrete-time " *
            "and other links need numeric cumulative-hazard integration, so " *
            "neither lowers to a CTMC."))
    end
end

end # module
