module LoweredDistributionsConvolvedDistributionsExt

# ConvolvedDistributions bridge. A `Convolved` is a sum of independent delays,
# and a sum of independent delays lowers exactly to a phase-type chain — the
# convolution of the components' phase-types is itself a phase-type. So
# `lower(::Convolved)` fits each component to its canonical `PhaseType` (the
# AD-safe form) and folds them in series with `_convolve_phase_types`.
#
# `Difference` and `Product` are not sums of delays — a `Difference` has signed
# support and a `Product` is not a convolution — so neither is phase-type
# representable. Both refuse explicitly rather than return a silent
# moment-matched approximation.

import LoweredDistributions: lower
using LoweredDistributions: PhaseType, _convolve_phase_types
using ConvolvedDistributions: Convolved, Difference, Product
using Distributions: components

function _lower_components(c::Convolved; max_phases::Int = 1_000)
    _convolve_phase_types(map(d -> lower(d, PhaseType; max_phases),
        components(c)))
end

"""
    lower(c::Convolved)

Lower a `Convolved` (a sum of independent delays) to the `PhaseType` of their
convolution: each component is lowered to its canonical phase-type and the
components are folded in series. Exact — the convolution of phase-types is a
phase-type — and AD-safe, so a component rate differentiates straight through.
"""
lower(c::Convolved) = _lower_components(c)

# The type-stable entry point mirrors `lower(::Distribution, PhaseType)` but
# keeps the exact structural convolution rather than moment-fitting the whole
# `Convolved` as one opaque distribution.
function lower(c::Convolved, ::Type{PhaseType}; max_phases::Int = 1_000)
    _lower_components(c; max_phases)
end

function lower(::Difference)
    throw(ArgumentError(
        "a Difference of delays has signed support and is not a phase-type; " *
        "LoweredDistributions cannot lower it"))
end

function lower(::Product)
    throw(ArgumentError(
        "a Product of delays is not a convolution and is not a phase-type; " *
        "LoweredDistributions cannot lower it"))
end

end
