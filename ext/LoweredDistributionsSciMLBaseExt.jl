module LoweredDistributionsSciMLBaseExt

# SciMLBase.jl bridge: `_generator` (core) reads any AbstractLowering's full
# state-space generator; this extension wraps `du/dt = Q' u` as an
# `ODEProblem`. `Q'` is passed as the problem's `p` (SciMLBase parameter
# slot), not closed over, and `u0` is promoted to match its element type
# BEFORE the problem is built — the standard pattern for a Dual/tracked
# parameter (e.g. a distribution rate under AD) to propagate through the
# solver's own state buffers rather than silently truncating back to Float64.

import LoweredDistributions: ode_problem
using LoweredDistributions: AbstractLowering, _generator
using SciMLBase: SciMLBase, ODEFunction, ODEProblem
using LinearAlgebra: mul!

_kolmogorov!(du, u, Qt, t) = mul!(du, Qt, u)

function ode_problem(m::AbstractLowering, tspan; u0 = nothing)
    gen = _generator(m)
    Qt = permutedims(gen.Q)
    u0v = u0 === nothing ? gen.u0 : u0
    T = promote_type(eltype(Qt), eltype(u0v))
    u0v = T.(u0v)
    f = ODEFunction(_kolmogorov!)
    return ODEProblem(f, u0v, tspan, Qt)
end

end
