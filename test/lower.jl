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

@testitem "lower(dist, PhaseType) is type-stable where lower(dist) is not" begin
    using LoweredDistributions, Distributions, Test

    # The adaptive dispatch's return type is a Union across the c² branches
    # (the AD hazard this canonical form exists to sidestep); the canonical
    # one is a single concrete type for every branch and every family.
    @test !isconcretetype(Base.promote_op(lower, Gamma{Float64}))
    for d in (Gamma(3.0, 1.5), Gamma(0.5, 1.0), Exponential(2.0),
        LogNormal(0.0, 0.5))
        @test (@inferred lower(d, PhaseType)) isa
              PhaseType{Vector{Float64}, Matrix{Float64}}
    end
end

@testitem "lower(dist, PhaseType) matches the adaptive lowering it replaces" begin
    using LoweredDistributions, Distributions

    # c² ≤ 1: the canonical form is the ErlangChain's own canonical view.
    for d in (Gamma(3.0, 1.5), Gamma(2.5, 1.0), LogNormal(0.0, 0.5))
        canonical = lower(d, PhaseType)
        adaptive = PhaseType(lower(d))
        @test canonical.α ≈ adaptive.α
        @test canonical.S ≈ adaptive.S
    end

    # c² > 1: both take the hyperexponential branch, so they agree exactly.
    d = Gamma(0.5, 1.0)
    @test lower(d, PhaseType).α ≈ PhaseType(lower(d)).α
    @test lower(d, PhaseType).S ≈ PhaseType(lower(d)).S
end

@testitem "lower(dist, PhaseType) reproduces the survival function" begin
    using LoweredDistributions, Distributions, LinearAlgebra

    # P(T > t) = sum(α' * exp(S t)) for a phase-type, exact for an Erlang
    # chain (Gamma with integer shape) and for the Exponential, which the
    # adaptive dispatch lowers to a CTMC instead.
    survival(pt, t) = sum(transpose(pt.α) * exp(Matrix(pt.S) .* t))

    for d in (Gamma(3.0, 1.5), Exponential(2.0)), t in (0.5, 2.0, 7.0)

        @test survival(lower(d, PhaseType), t) ≈ ccdf(d, t)
    end

    # The two-moment fits match the mean of the distribution they lower.
    for d in (Gamma(0.5, 1.0), LogNormal(0.0, 0.5))
        pt = lower(d, PhaseType)
        # Phase-type mean: -α' S^-1 1.
        m = sum(transpose(pt.α) * (-inv(Matrix(pt.S))))
        @test m ≈ mean(d)
    end
end

@testitem "lower(dist, PhaseType) rejects a distribution with no finite moments" begin
    using LoweredDistributions, Distributions

    @test_throws ArgumentError lower(Cauchy(0.0, 1.0), PhaseType)
end
