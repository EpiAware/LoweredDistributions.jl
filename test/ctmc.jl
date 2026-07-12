@testitem "ctmc assembles a valid generator matrix" begin
    using LoweredDistributions

    m = ctmc(
        :well => (:ill => 0.2),
        :ill => (:well => 0.3, :dead => 0.1))
    @test m isa CTMC
    @test m.states == (:well, :ill, :dead)
    for i in 1:3
        @test sum(m.Q[i, :]) ≈ 0 atol = 1e-10
    end
    @test m.Q[1, 2] == 0.2
    @test m.Q[2, 1] == 0.3
    @test m.Q[2, 3] == 0.1
end

@testitem "ctmc rejects negative rates" begin
    using LoweredDistributions

    @test_throws ArgumentError ctmc(:a => (:b => -0.1))
end

@testitem "ctmc needs at least one spec" begin
    using LoweredDistributions

    @test_throws ArgumentError ctmc()
end

@testitem "transition_probability is a stochastic matrix" begin
    using LoweredDistributions

    m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    P = transition_probability(m, 2.0)
    for i in 1:3
        @test sum(P[i, :]) ≈ 1 atol = 1e-8
        @test all(P[i, :] .>= -1e-10)
    end
    P0 = transition_probability(m, 0.0)
    @test P0 ≈ [1.0 0 0; 0 1 0; 0 0 1] atol = 1e-10
    # The dead state is absorbing.
    @test P[3, 3] ≈ 1 atol = 1e-10
end

@testitem "transition_probability rejects a negative time gap" begin
    using LoweredDistributions

    m = ctmc(:a => (:b => 1.0))
    @test_throws ArgumentError transition_probability(m, -1.0)
end

@testitem "transition_probability matches a two-state analytic solution" begin
    using LoweredDistributions

    λ, μ = 0.4, 0.25
    m = ctmc(:a => (:b => λ), :b => (:a => μ))
    t = 3.0
    P = transition_probability(m, t)
    s = λ + μ
    @test P[1, 1] ≈ (μ + λ * exp(-s * t)) / s atol = 1e-8
    @test P[1, 2] ≈ (λ - λ * exp(-s * t)) / s atol = 1e-8
end

@testitem "state_index finds a state or returns nothing" begin
    using LoweredDistributions

    m = ctmc(:a => (:b => 1.0))
    @test state_index(m, :a) == 1
    @test state_index(m, :b) == 2
    @test state_index(m, :c) === nothing
end

@testitem "ctmc rejects a malformed generator" begin
    using LoweredDistributions

    @test_throws ArgumentError CTMC((:a, :b), [-1.0 2.0; 0.0 0.0])
    @test_throws ArgumentError CTMC((:a, :b), [1.0 -1.0; 1.0 -1.0])
    @test_throws ArgumentError CTMC((:a,), [1.0 0.0; 0.0 1.0])
end
