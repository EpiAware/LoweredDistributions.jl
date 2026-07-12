@testitem "ode_problem needs SciMLBase" begin
    using LoweredDistributions

    @test_throws ArgumentError ode_problem(1, (0.0, 1.0))
end

@testitem "ode_problem solves a CTMC to match transition_probability" begin
    using LoweredDistributions, SciMLBase, OrdinaryDiffEqTsit5

    m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    prob = ode_problem(m, (0.0, 5.0))
    sol = solve(prob, Tsit5(); reltol = 1e-10, abstol = 1e-12)
    P = transition_probability(m, 5.0)
    @test sol.u[end] ≈ P[1, :] atol = 1e-6
    # Probability is conserved throughout.
    @test all(t -> isapprox(sum(sol(t)), 1; atol = 1e-6), range(0.0, 5.0; length = 10))
end

@testitem "ode_problem solves an ErlangChain to match the Gamma survival function" begin
    using LoweredDistributions, Distributions, SciMLBase, OrdinaryDiffEqTsit5

    d = Gamma(3.0, 1.5)
    chain = lower(d)
    @test chain isa ErlangChain
    prob = ode_problem(chain, (0.0, 8.0))
    sol = solve(prob, Tsit5(); reltol = 1e-10, abstol = 1e-12)
    for t in range(0.5, 8.0; length = 6)
        survival = sum(sol(t)[1:3])   # the 3 transient compartments
        @test survival ≈ ccdf(d, t) atol = 1e-4
    end
end

@testitem "ode_problem solves a branching PhaseType to match the fitted survival function" begin
    using LoweredDistributions, Distributions, SciMLBase, OrdinaryDiffEqTsit5

    d = Gamma(0.5, 1.0)                    # c² = 2 > 1 -> PhaseType
    chain = lower(d)
    @test chain isa PhaseType
    prob = ode_problem(chain, (0.0, 8.0))
    sol = solve(prob, Tsit5(); reltol = 1e-10, abstol = 1e-12)
    m = mean(d)
    scv = var(d) / m^2
    for t in range(0.1, 8.0; length = 6)
        survival = sum(sol(t)[1:2])
        # The exact survival function of the balanced-means H2 fit:
        # S(t) = α₁ exp(-λ₁ t) + α₂ exp(-λ₂ t).
        p = chain.α[1]
        λ1, λ2 = -chain.S[1, 1], -chain.S[2, 2]
        expected = p * exp(-λ1 * t) + (1 - p) * exp(-λ2 * t)
        @test survival ≈ expected atol = 1e-6
    end
end

@testitem "ode_problem defaults u0 from the lowering, or accepts an override" begin
    using LoweredDistributions, Distributions, SciMLBase, OrdinaryDiffEqTsit5

    chain = lower(Gamma(3.0, 1.5))
    prob = ode_problem(chain, (0.0, 1.0))
    @test prob.u0 ≈ [1.0, 0.0, 0.0, 0.0]   # 3 phases + absorbed

    u0 = [0.0, 1.0, 0.0, 0.0]
    prob2 = ode_problem(chain, (0.0, 1.0); u0 = u0)
    @test prob2.u0 == u0
end
