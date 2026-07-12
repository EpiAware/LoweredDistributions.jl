@testitem "lower(::Exponential) is a degenerate two-state CTMC" begin
    using LoweredDistributions, Distributions

    d = Exponential(2.0)
    m = lower(d)
    @test m isa CTMC
    @test m.states == (:on, :absorbed)
    @test m.Q[1, 2] ≈ 0.5
    # The waiting time to absorption IS the Exponential: P(still :on at t) is
    # the Exponential survival function.
    @test transition_probability(m, 3.0)[1, 1] ≈ ccdf(d, 3.0)
end

@testitem "lower(::Gamma) picks ErlangChain for c² ≤ 1" begin
    using LoweredDistributions, Distributions

    m = lower(Gamma(3.0, 1.5))
    @test m isa ErlangChain
    @test m.stages == compartment_stages(Gamma(3.0, 1.5))

    # Non-integer shape but still c² ≤ 1 moment-matches.
    m2 = lower(Gamma(2.5, 1.0))
    @test m2 isa ErlangChain
end

@testitem "lower(::Gamma) picks phase_type for c² > 1" begin
    using LoweredDistributions, Distributions

    d = Gamma(0.5, 1.0)                   # scv = 2 > 1
    m = lower(d)
    p = phase_type(d)
    @test m isa PhaseType
    @test m.α == p.α
    @test m.S == p.S
end

@testitem "lower falls back to phase_type for a general Distribution" begin
    using LoweredDistributions, Distributions

    d = LogNormal(0.0, 0.5)
    @test lower(d) isa AbstractChainTrick
end
