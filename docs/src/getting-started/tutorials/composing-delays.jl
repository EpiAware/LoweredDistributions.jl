md"""
# [Composing delays](@id composing-delays)

The [lowering overview](@ref lowering-backends) and the per-backend pages each lowered a single `Distributions.Distribution`.
The input side composes too, in two ways this page covers in turn: `ConvolvedDistributions.convolved` builds the delay that is the *sum* of independent delays, and `ComposedDistributions.sequential` builds a chain of named steps (with a [ModifiedDistributions](https://github.com/EpiAware/ModifiedDistributions.jl) leaf along the way).
Both land on the same phase-type shape, so `lower` folds either one into the series chain that feeds the same backends.
"""

using LoweredDistributions
using Distributions
using ConvolvedDistributions
using LinearAlgebra
using CairoMakie
using AlgebraOfGraphics
using DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)
set_theme!(theme_latexfonts(); fontsize = 14)

function phasetype_density(pt::PhaseType, ts)
    s = -pt.S * ones(length(pt.α))
    return [only(transpose(pt.α) * exp(pt.S * t) * s) for t in ts]
end

delay = convolved(Gamma(2.0, 1.5), Exponential(3.0))
serial = lower(delay)

# `Gamma(2, ...)` is two Erlang phases and the `Exponential` is one, so the convolution is a three-phase chain, and its mean is the sum of the parts.

length(serial.α), mean(delay)

#-

-sum(transpose(serial.α) * inv(Matrix(serial.S)))    # the lowered mean

# Plotting the two components against their convolution shows the usual convolution shape: the sum sits to the right of, and is wider than, either component.
# Overlaying the lowered phase-type density on the convolution's own density is the faithfulness check: the two Erlang phases and the one exponential phase both lower exactly, so the curves coincide.

ts = 0.0:0.05:20.0
components_df = vcat(
    DataFrame(t = collect(ts), density = pdf.(Gamma(2.0, 1.5), ts),
        kind = "Gamma(2, 1.5)"),
    DataFrame(t = collect(ts), density = pdf.(Exponential(3.0), ts),
        kind = "Exponential(3)"),
    DataFrame(t = collect(ts), density = pdf(delay, collect(ts)),
        kind = "Convolved sum")
)
draw(
    data(components_df) *
    mapping(:t, :density, color = :kind) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay", ylabel = "Density")
)

pt = PhaseType(serial)
faithful_df = vcat(
    DataFrame(t = collect(ts), density = pdf(delay, collect(ts)),
        kind = "Convolved sum (exact)"),
    DataFrame(t = collect(ts), density = phasetype_density(pt, ts),
        kind = "Lowered (series phase-type)")
)
draw(
    data(faithful_df) *
    mapping(:t, :density, color = :kind, linestyle = :kind) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay", ylabel = "Density")
)

md"""
## Backend-ready, and faithful

The composed delay is an `AbstractLowering` like any other, so every backend from the [per-backend pages](@ref lowering-backends) takes it unchanged.
Here the ODE view: both components lower exactly, so the absorbed mass reproduces the convolution's own CDF.
"""

using SciMLBase
using OrdinaryDiffEqTsit5

prob = ode_problem(serial, (0.0, 20.0))
sol = solve(prob, Tsit5())
round(sol(6.0)[end]; digits = 6), round(cdf(delay, 6.0); digits = 6)

# The same agreement holds across the whole time axis, not just at one checkpoint.

ode_df = vcat(
    DataFrame(t = collect(ts), value = [sol(t)[end] for t in ts],
        kind = "Absorbed mass (ODE)"),
    DataFrame(t = collect(ts), value = cdf(delay, collect(ts)),
        kind = "Exact convolution CDF")
)
draw(
    data(ode_df) *
    mapping(:t, :value, color = :kind, linestyle = :kind) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Time", ylabel = "Probability")
)

md"""
## A composed tree, with a modified leaf

[ComposedDistributions.jl](https://github.com/EpiAware/ComposedDistributions.jl) builds trees of named steps rather than a flat tuple of components, and [ModifiedDistributions.jl](https://github.com/EpiAware/ModifiedDistributions.jl) wraps individual leaves (a rescale, a weight, a hazard modifier).
LoweredDistributions hosts the lowering bridge for both directly (`LoweredDistributionsComposedDistributionsExt` and `LoweredDistributionsModifiedDistributionsExt`, LD#51), so `lower` reaches into a composed tree and folds a modified leaf into the same phase-type shape, no different from lowering a bare `Distributions.Distribution`.

A `Sequential` chain of two named steps is again a convolution of its steps, so it is a natural second route to the same kind of object `convolved` builds above.
Here the second step is `affine`-rescaled rather than bare: an affine transform with no shift is an exact rescale of a phase-type (see `LoweredDistributionsModifiedDistributionsExt`), so the whole tree still lowers exactly.
"""

using ComposedDistributions
using ModifiedDistributions

incubation = Gamma(2.0, 1.0)
reporting = affine(Gamma(1.0, 1.0); scale = 2.0)
tree = sequential(:incubation => incubation, :reporting => reporting)

tree_lowered = lower(tree)
length(tree_lowered.α)

# `observed_distribution` is ComposedDistributions' own reading of what a `Sequential` chain observes: the convolution of its steps.
# It is built independently of `lower` (through `ConvolvedDistributions.convolved` under the hood, not through this package), so comparing the two is a real check that the LD-hosted bridge agrees with ComposedDistributions' own semantics, not a tautology.

tree_observed = observed_distribution(tree)
typeof(tree_observed)

#-

pt_tree = PhaseType(tree_lowered)
tree_df = vcat(
    DataFrame(t = collect(ts), density = pdf(tree_observed, collect(ts)),
        kind = "Tree's observed_distribution"),
    DataFrame(t = collect(ts), density = phasetype_density(pt_tree, ts),
        kind = "Lowered (ComposedDistributions bridge)")
)
draw(
    data(tree_df) *
    mapping(:t, :density, color = :kind, linestyle = :kind) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay", ylabel = "Density")
)

# The two means agree to the same precision as the density curves.

mean(tree_observed), -sum(transpose(pt_tree.α) * inv(Matrix(pt_tree.S)))

md"""
## What refuses

`Difference` and `Product` are not sums of delays — a difference has signed support, a product is not a convolution — so neither is phase-type representable, and `lower` refuses them explicitly rather than return a silent moment-matched approximation.
The same is true of a `Sequential` chain built from a leaf the modifier bridge itself refuses (a non-zero `shift`, a `Weighted` leaf, a hazard modifier on a non-Exponential base): `lower` raises rather than silently drop the part it cannot represent.
"""
