@testitem "Modified extension: loads and Affine-scale lowers" begin
    using LoweredDistributions
    using ModifiedDistributions: affine
    using Distributions

    # The extension loads once ModifiedDistributions is present.
    @test Base.get_extension(LoweredDistributions,
        :LoweredDistributionsModifiedDistributionsExt) !== nothing

    # A pure positive rescaling divides every rate by `scale`. An Exponential
    # leaf lowers to a two-state CTMC; scaling `Y = 3X` of `Exponential(2)` is
    # `Exponential(6)`, so its generator matches lowering the scaled leaf.
    ad = affine(Exponential(2.0); scale = 3.0)
    lowered = lower(ad)
    @test lowered isa CTMC
    @test lowered.Q ≈ lower(Exponential(6.0)).Q

    # A Gamma (integer shape) lowers to an ErlangChain; scaling divides the
    # per-stage rate, matching the scaled Gamma's chain.
    ag = affine(Gamma(3.0, 1.5); scale = 2.0)
    ec = lower(ag)
    @test ec isa ErlangChain
    @test [s.rate for s in ec.stages] ≈
          [s.rate for s in lower(Gamma(3.0, 3.0)).stages]

    # shift = 0 is required: the default affine (scale = 1) is an identity
    # rescaling and still lowers.
    @test lower(affine(Exponential(1.0))).Q ≈ lower(Exponential(1.0)).Q
end

@testitem "Modified extension: Affine-shift is refused" begin
    using LoweredDistributions
    using ModifiedDistributions: affine
    using Distributions

    # A deterministic shift adds a fixed delay, which is not phase-type.
    d = affine(Exponential(2.0); scale = 1.0, shift = 1.0)
    @test_throws ArgumentError lower(d)
end

@testitem "Modified extension: Weighted is refused" begin
    using LoweredDistributions
    using ModifiedDistributions: weight
    using Distributions

    # A likelihood weight carries no dynamics.
    @test_throws ArgumentError lower(weight(Exponential(2.0), 3.0))
    @test_throws ArgumentError lower(weight(Exponential(2.0)))
end

@testitem "Modified extension: forward transforms are refused" begin
    using LoweredDistributions
    using ModifiedDistributions: thin, cumulative, series_transform
    using Distributions

    # thin would lower as a competing-risk split, but that needs a NoEvent
    # sink LoweredDistributions' wave-1 API does not expose, so it is refused
    # (with an informative message) rather than dropping the competing risk.
    err = try
        lower(thin(Exponential(2.0), 0.3))
        nothing
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("NoEvent", err.msg)

    # cumulative and a general series map have no rate-structure image.
    @test_throws ArgumentError lower(cumulative(Exponential(2.0)))
    @test_throws ArgumentError lower(series_transform(Exponential(2.0),
        s -> 2.0 .* s))
end

@testitem "Modified extension: Modified lowers on an Exponential leaf" begin
    using LoweredDistributions
    using ModifiedDistributions: modify
    using Distributions

    # Log link (proportional hazards) on a constant hazard: h* = exp(effect)·λ,
    # so modify(Exponential(2), log 2) has rate 2·(1/2) = 1 -> Exponential(1).
    ml = modify(Exponential(2.0), log(2.0); link = log)
    @test lower(ml).Q ≈ lower(Exponential(1.0)).Q

    # Identity link (additive hazards): h* = λ + effect = 0.5 + 0.5 = 1, again
    # Exponential(1).
    mi = modify(Exponential(2.0), 0.5; link = identity)
    @test lower(mi).Q ≈ lower(Exponential(1.0)).Q
end

@testitem "Modified extension: Modified on a non-Exponential leaf is refused" begin
    using LoweredDistributions
    using ModifiedDistributions: modify
    using Distributions

    # Proportional/additive hazards are exact rate-scaling only for a constant
    # hazard, so a non-Exponential leaf is refused.
    @test_throws ArgumentError lower(modify(Gamma(2.0, 1.0), 0.3; link = log))
    @test_throws ArgumentError lower(
        modify(Gamma(2.0, 1.0), 0.3; link = identity))
end
