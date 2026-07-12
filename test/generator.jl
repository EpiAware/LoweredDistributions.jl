@testitem "_generator(::CTMC) returns Q and a first-state indicator" begin
    using LoweredDistributions

    m = ctmc(:a => (:b => 1.0), :b => (:a => 0.5))
    gen = LoweredDistributions._generator(m)
    @test gen.Q === m.Q
    @test gen.u0 == [1.0, 0.0]
end

@testitem "_generator(::AbstractChainTrick) extends S with an absorbing state" begin
    using LoweredDistributions, Distributions

    chain = lower(Gamma(3.0, 1.5))         # ErlangChain, 3 compartments
    gen = LoweredDistributions._generator(chain)
    @test size(gen.Q) == (4, 4)
    pt = PhaseType(chain)
    @test gen.Q[1:3, 1:3] == pt.S
    # Every row sums to zero: a full generator, not a bare sub-generator.
    for i in 1:4
        @test sum(gen.Q[i, :]) ≈ 0 atol = 1e-10
    end
    @test gen.u0 == [1.0, 0.0, 0.0, 0.0]
end
