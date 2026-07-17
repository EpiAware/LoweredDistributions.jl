md"""
# [JumpProcesses: the exact stochastic view](@id backend-jump)

Start from a lowering — a `Gamma(3, 1.5)` delay as its chain — the same
starting point every backend page uses. See
[Lowering a distribution to a dynamical system](@ref lowering-backends) for
what `lower` does.
"""

using LoweredDistributions
using Distributions

d = Gamma(3.0, 1.5)
chain = lower(d)

md"""
`jump_problem` puts a single individual in the entry state and lets it jump
between states at the generator's rates.
Solving with `SSAStepper()` draws one exact sample path of the underlying
Markov chain, so the time it first reaches the absorbing state is one exact
draw from `d`.
"""

using JumpProcesses
using Random
using Statistics

jprob = jump_problem(chain, (0.0, 100.0))
jsol = solve(jprob, SSAStepper())
jsol.u[end]        # the individual has ended in the absorbed compartment

# The absorption time is the first time the last (absorbed) compartment holds
# the individual.
# A path that has not absorbed by the end of `tspan` has no absorption time at
# all, so say that rather than return a wrong number: for this delay the span
# is more than twenty means, but a heavier-tailed one would need a longer one.

function absorption_time(s)
    i = findfirst(u -> u[end] == 1, s.u)
    i === nothing &&
        error("the individual had not absorbed by the end of tspan; " *
              "extend it and simulate again")
    return s.t[i]
end

absorption_time(jsol)

# One path is a single draw, so draw many and compare their mean and standard
# deviation with the distribution we lowered.
# This is a stochastic check, so it agrees to Monte Carlo error rather than to
# solver tolerance.

Random.seed!(20_260_714)
draws = [absorption_time(solve(jump_problem(chain, (0.0, 100.0)), SSAStepper()))
         for _ in 1:2000]

println("simulated mean = ", round(mean(draws); digits = 3),
    "   Gamma mean = ", round(mean(d); digits = 3))
println("simulated sd   = ", round(std(draws); digits = 3),
    "   Gamma sd   = ", round(std(d); digits = 3))
