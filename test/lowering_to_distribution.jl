@testitem "an exact lowering reads back as its named family" begin
    using LoweredDistributions, Distributions

    # The three shapes `lower` emits exactly keep their Distributions.jl name.
    @test lowering_to_distribution(lower(Exponential(2.0))) ==
          Exponential(2.0)

    back = lowering_to_distribution(lower(Gamma(3.0, 1.5)))
    @test back isa Gamma
    @test shape(back) ≈ 3.0
    @test scale(back) ≈ 1.5

    # A single phase is an Exponential however it was built.
    @test lowering_to_distribution(Coxian([0.5], [0.0])) == Exponential(2.0)
end

@testitem "a law with no family name comes back as a PhaseTypeDist" begin
    using LoweredDistributions, Distributions

    # c² > 1 fits a branching PhaseType, which has no named family.
    d = Gamma(0.5, 1.0)
    pd = lowering_to_distribution(lower(d))
    @test pd isa PhaseTypeDist

    # The hyperexponential fit matches both moments exactly, so the wrapper
    # reports the source distribution's own mean and variance.
    @test mean(pd) ≈ mean(d)
    @test var(pd) ≈ var(d)
end

@testitem "PhaseTypeDist behaves as a continuous distribution" begin
    using LoweredDistributions, Distributions, Random

    pd = lowering_to_distribution(lower(Gamma(0.5, 1.0)))

    @test minimum(pd) == 0.0
    @test maximum(pd) == Inf
    @test insupport(pd, 1.0)
    @test !insupport(pd, -1.0)

    # cdf and ccdf are complementary, and the density is non-negative.
    for t in (0.1, 0.5, 1.0, 4.0)
        @test cdf(pd, t) + ccdf(pd, t) ≈ 1
        @test pdf(pd, t) >= 0
        @test logpdf(pd, t) ≈ log(pdf(pd, t))
    end
    @test pdf(pd, -1.0) == 0
    @test ccdf(pd, -1.0) == 1

    # Sampling agrees with the closed-form mean.
    rng = MersenneTwister(42)
    draws = [rand(rng, pd) for _ in 1:50_000]
    @test all(>=(0), draws)
    @test sum(draws) / length(draws)≈mean(pd) rtol=0.05
end

@testitem "projecting onto a named family is idempotent under lower" begin
    using LoweredDistributions, Distributions

    # The honest contract: re-lowering a projection returns the same lowering.
    # `lowering_to_distribution(lower(d), F) == d` is NOT a law and is checked
    # to fail below, because `lower` quantises the phase count.
    for d in (LogNormal(0.0, 0.5), Gamma(2.5, 1.0), Weibull(2.0, 1.0))
        l = lower(d)
        projected = lowering_to_distribution(l, Gamma)
        again = lower(projected)
        @test [s.rate for s in again.stages]≈[s.rate for s in l.stages] rtol=1e-8
        @test [s.stages for s in again.stages] == [s.stages for s in l.stages]
    end

    # The mean survives the round trip; the variance is quantised to 1/k.
    d = Gamma(2.5, 1.0)
    back = lowering_to_distribution(lower(d), Gamma)
    @test mean(back) ≈ mean(d)
    @test !isapprox(var(back), var(d); rtol = 1e-3)
end

@testitem "a target family recovers the source when both moments survive" begin
    using LoweredDistributions, Distributions

    # c² > 1 takes the hyperexponential branch, which preserves mean and
    # variance exactly, so any two-moment-identified family comes back exactly.
    d = Gamma(0.5, 1.0)
    back = lowering_to_distribution(lower(d), Gamma)
    @test mean(back) ≈ mean(d)
    @test var(back) ≈ var(d)

    # An unsupported family says so rather than guessing.
    @test_throws ArgumentError lowering_to_distribution(lower(d), Weibull)
end

@testitem "an absorbing CTMC reads as a phase type, a joint one does not" begin
    using LoweredDistributions, Distributions

    # lower(::Exponential) is a two-state absorbing chain.
    pt = PhaseType(lower(Exponential(2.0)))
    @test length(pt.α) == 1
    @test only(pt.S) ≈ -0.5

    # Two absorbing states is the Parallel / Choose shape: no scalar law.
    joint = ctmc(:a => (:b => 1.0, :c => 1.0))
    @test_throws ArgumentError PhaseType(joint)
end

@testitem "lowering_to_dist is an alias, not a copy" begin
    using LoweredDistributions, Distributions

    @test lowering_to_dist === lowering_to_distribution
    @test lowering_to_dist(lower(Exponential(2.0))) == Exponential(2.0)
end

@testitem "PhaseTypeDist reports its own bounds and a compact show" begin
    using LoweredDistributions, Distributions

    pd = lowering_to_distribution(lower(Gamma(0.5, 1.0)))

    # minimum/maximum are called directly here rather than only through
    # insupport, which the earlier continuous-distribution test already uses.
    @test Base.minimum(pd) == 0.0
    @test Base.maximum(pd) == Inf

    # Nothing else in the package calls `show` on a PhaseTypeDist.
    @test repr(pd) == "PhaseTypeDist(2 phases)"
end

@testitem "a multi-phase Coxian samples by jumping between phases" begin
    using LoweredDistributions, Distributions, Random

    # Phase 1 exits at rate 2.0, splitting 50/50 between absorbing and moving
    # to phase 2 (rate 1.0, always absorbing). That inter-phase move is a
    # branch the earlier hyperexponential (never-branching-back) sampler test
    # cannot reach, and length(c.rates) > 1 takes lowering_to_distribution's
    # Coxian method to PhaseTypeDist rather than the single-phase Exponential.
    c = Coxian([2.0, 1.0], [0.5, 0.0])
    pd = lowering_to_distribution(c)
    @test pd isa PhaseTypeDist

    # mean = 1/2 (phase 1) + 1/2 * 1/1 (half the time, phase 2 too) = 1.0.
    @test mean(pd) ≈ 1.0

    rng = MersenneTwister(1)
    draws = [rand(rng, pd) for _ in 1:20_000]
    @test all(>=(0), draws)
    @test sum(draws) / length(draws) ≈ mean(pd) rtol=0.05
end

@testitem "_from_moments projects onto Exponential, Normal and LogNormal" begin
    using LoweredDistributions, Distributions

    # A c² > 1 lowering has no family name of its own; project it onto the
    # three closed-form families not exercised by the Gamma round-trip tests
    # above.
    l = lower(Gamma(0.5, 1.0))
    m, v = mean(lowering_to_distribution(l)), var(lowering_to_distribution(l))

    exp_back = lowering_to_distribution(l, Exponential)
    @test exp_back isa Exponential
    @test mean(exp_back) ≈ m

    normal_back = lowering_to_distribution(l, Normal)
    @test normal_back isa Normal
    @test mean(normal_back) ≈ m
    @test var(normal_back) ≈ v

    lognormal_back = lowering_to_distribution(l, LogNormal)
    @test lognormal_back isa LogNormal
    @test mean(lognormal_back) ≈ m
    @test var(lognormal_back) ≈ v
end

@testitem "lowering_to_distribution reads a CTMC and a single-phase \
           PhaseType directly" begin
    using LoweredDistributions, Distributions

    # lower(::Exponential) is the only public producer of both shapes, so the
    # CTMC and single-phase PhaseType methods are otherwise only exercised
    # through that composition. Build each input directly instead.
    m = ctmc(:on => (:absorbed => 0.5))
    @test lowering_to_distribution(m) == Exponential(2.0)

    pt = PhaseType([1.0], reshape([-0.5], 1, 1))
    @test lowering_to_distribution(pt) == Exponential(2.0)
end
