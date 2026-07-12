@testitem "ErlangChain wraps compartment_stages" begin
    using LoweredDistributions, Distributions

    e = ErlangChain(Gamma(3.0, 1.5))
    @test e isa AbstractChainTrick
    @test e.stages == compartment_stages(Gamma(3.0, 1.5))
end

@testitem "Coxian rejects mismatched lengths and out-of-range probs" begin
    using LoweredDistributions

    @test_throws ArgumentError Coxian([1.0, 2.0], [0.5])
    @test_throws ArgumentError Coxian([1.0], [1.5])
    @test_throws ArgumentError Coxian([-1.0], [0.5])
end

@testitem "Coxian(::ErlangChain) concatenates stages with forced final absorption" begin
    using LoweredDistributions, Distributions

    e = ErlangChain(Gamma(3.0, 1.5))
    c = Coxian(e)
    @test c isa Coxian
    @test length(c.rates) == 3
    @test all(≈(1 / 1.5), c.rates)
    @test c.probs[1:2] == [1.0, 1.0]
    @test c.probs[3] == 0.0
end

@testitem "PhaseType validates α and the sub-generator" begin
    using LoweredDistributions

    @test_throws ArgumentError PhaseType([0.5, 0.4], [-1.0 0.0; 0.0 -1.0])
    @test_throws ArgumentError PhaseType([1.0], reshape([0.0], 1, 1))
    @test_throws ArgumentError PhaseType([1.0, 0.0], [-1.0 2.0; 0.0 -1.0])
end

@testitem "PhaseType(::Coxian) builds the single-entry canonical embedding" begin
    using LoweredDistributions

    c = Coxian([0.5, 0.3], [0.8, 0.0])
    pt = PhaseType(c)
    @test pt.α == [1.0, 0.0]
    @test pt.S[1, 1] ≈ -0.5
    @test pt.S[1, 2] ≈ 0.5 * 0.8
    @test pt.S[2, 2] ≈ -0.3
    # Row sums are the negative of each phase's absorption rate.
    @test sum(pt.S[1, :]) ≈ -0.5 * (1 - 0.8)
    @test sum(pt.S[2, :]) ≈ -0.3
end

@testitem "PhaseType(::ErlangChain) round-trips through Coxian" begin
    using LoweredDistributions, Distributions

    e = ErlangChain(Exponential(2.0))
    pt = PhaseType(e)
    pt2 = PhaseType(Coxian(e))
    @test pt.α == pt2.α
    @test pt.S == pt2.S
    @test pt.α == [1.0]
    @test pt.S ≈ reshape([-0.5], 1, 1)
end

@testitem "PhaseType(::PhaseType) is the identity" begin
    using LoweredDistributions

    pt = PhaseType([1.0], reshape([-1.0], 1, 1))
    @test PhaseType(pt) === pt
end
