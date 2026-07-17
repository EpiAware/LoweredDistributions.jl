md"""
# [Composing delays: convolution](@id composing-delays)

The [lowering overview](@ref lowering-backends) and the per-backend pages each
lowered a single `Distributions.Distribution`. The input side composes too.
`ConvolvedDistributions.convolved` builds the delay that is the *sum* of
independent delays, and a sum of delays is again a phase-type — so `lower`
folds the components into one series chain that feeds the same backends.
"""

using LoweredDistributions
using Distributions
using ConvolvedDistributions

delay = convolved(Gamma(2.0, 1.5), Exponential(3.0))
serial = lower(delay)

# `Gamma(2, ...)` is two Erlang phases and the `Exponential` is one, so the
# convolution is a three-phase chain, and its mean is the sum of the parts.

length(serial.α), mean(delay)

#-

using LinearAlgebra
-sum(transpose(serial.α) * inv(Matrix(serial.S)))    # the lowered mean

md"""
## Backend-ready, and faithful

The composed delay is an `AbstractLowering` like any other, so every backend
from the [per-backend pages](@ref lowering-backends) takes it unchanged. Here
the ODE view: both components lower exactly, so the absorbed mass reproduces
the convolution's own CDF.
"""

using SciMLBase
using OrdinaryDiffEqTsit5

prob = ode_problem(serial, (0.0, 20.0))
sol = solve(prob, Tsit5())
round(sol(6.0)[end]; digits = 6), round(cdf(delay, 6.0); digits = 6)

md"""
## What refuses

`Difference` and `Product` are not sums of delays — a difference has signed
support, a product is not a convolution — so neither is phase-type
representable, and `lower` refuses them explicitly rather than return a silent
moment-matched approximation.
"""
