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
    import LoweredDistributions: AbstractChainTrick

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

@testitem "one-argument lower(d) differentiates on the Erlang path" begin
    using LoweredDistributions, Distributions, ForwardDiff, LinearAlgebra

    # The AD suite differentiates this on every backend; this main-suite guard
    # checks the Erlang path (c² ≤ 1) via one-argument lower(d) on ForwardDiff,
    # which the concrete-Float64 ChainStage rate used to block outright (issue
    # #73). The gradient must agree with the type-stable canonical lowering.
    # The package's matrix exponential (AD-friendly, unlike Base `exp` on a
    # dual-valued matrix) gives the phase-type survival P(T > t) = sum(α'e^{St}).
    _mexp = LoweredDistributions._matrix_exp
    survival(pt, t) = sum(transpose(pt.α) * _mexp(pt.S .* t))
    adaptive(shape) = θ -> survival(PhaseType(lower(Gamma(shape, exp(θ)))), 5.0)
    canonical(shape) = θ -> survival(lower(Gamma(shape, exp(θ)), PhaseType), 5.0)

    # Integer shape (exact Erlang) and non-integer shape (moment-matched, still
    # c² ≤ 1); the literal shape fixes the structure so lower(d) folds concrete.
    for shape in (3.0, 2.5)
        g = ForwardDiff.derivative(adaptive(shape), log(1.5))
        gref = ForwardDiff.derivative(canonical(shape), log(1.5))
        @test g≈gref rtol=1e-8
    end
end

@testitem "lower(dist, PhaseType) rejects a distribution with no finite moments" begin
    using LoweredDistributions, Distributions

    @test_throws ArgumentError lower(Cauchy(0.0, 1.0), PhaseType)
end

@testitem "lower(dist, PhaseType) caps the phase count instead of exhausting memory" begin
    using LoweredDistributions, Distributions

    # A near-deterministic delay needs k = round(1 / c²) phases, and the
    # canonical form holds a dense k x k sub-generator: Normal(5, 0.001) has
    # c² = 4e-8, so it would ask for 25 million phases (and hundreds of
    # terabytes) before returning. The cap turns that into an error naming the
    # limit, rather than an OutOfMemoryError.
    @test_throws ArgumentError lower(Normal(5.0, 0.001), PhaseType)
    @test_throws ArgumentError lower(Gamma(1.0e6, 1.0e-6), PhaseType)

    # The chain is still built when the caller opts into it.
    tight = lower(Normal(5.0, 0.5), PhaseType; max_phases = 200)
    @test length(tight.α) == 100          # c² = 0.01 -> 100 phases
    @test size(tight.S) == (100, 100)

    # ... and rejected when the cap is set below what the fit needs.
    @test_throws ArgumentError lower(Normal(5.0, 0.5), PhaseType; max_phases = 50)

    # The over-dispersed branch is always two phases, so the cap never bites.
    @test length(lower(Gamma(0.5, 1.0), PhaseType; max_phases = 1).α) == 2
end

@testitem "lower(dist, PhaseType) keeps the distribution's element type" begin
    using LoweredDistributions, Distributions, Test

    # Type stability is not a Float64-only claim: the canonical form carries
    # whatever element type the moments have, which is what lets an AD dual
    # through (the ADFixtures canonical scenarios differentiate this path on
    # every backend).
    pt32 = @inferred lower(Gamma(3.0f0, 1.5f0), PhaseType)
    @test pt32 isa PhaseType{Vector{Float32}, Matrix{Float32}}
    @test eltype(pt32.S) === Float32
end

@testitem "a canonically-lowered PhaseType feeds the backends" begin
    using LoweredDistributions, Distributions, SciMLBase, OrdinaryDiffEqTsit5

    # The point of the canonical form is that it is still a lowering: it must
    # drive the backend extensions exactly as the adaptive one does. The ODE's
    # absorbed mass is the CDF of the distribution it came from.
    d = Gamma(3.0, 1.5)
    prob = ode_problem(lower(d, PhaseType), (0.0, 10.0))
    sol = solve(prob, Tsit5(); abstol = 1e-10, reltol = 1e-10)
    for t in (1.0, 4.0, 9.0)
        @test sol(t)[end]≈cdf(d, t) atol=1e-6
    end
    @test sum(sol(6.0))≈1.0 atol=1e-8
end

@testitem "lower(dist, PhaseType; phases) fixes the compartment count" begin
    using LoweredDistributions, Distributions, LinearAlgebra

    ptmean(pt) = -sum(transpose(pt.α) * inv(pt.S))

    # `phases` fixes k and matches the mean; the k-stage Erlang has k phases and
    # mean k / rate = mean(dist).
    p = lower(Gamma(3.0, 1.5), PhaseType; phases = 5)
    @test p isa PhaseType{Vector{Float64}, Matrix{Float64}}
    @test length(p.α) == 5
    @test ptmean(p) ≈ mean(Gamma(3.0, 1.5))

    # The count is independent of the distribution's own dispersion: a Gamma the
    # adaptive fit would give a different k, an Exponential, and a near-
    # degenerate Normal (whose adaptive fit would ask for 25M phases) all give
    # exactly the requested count.
    @test length(lower(Gamma(0.5, 1.0), PhaseType; phases = 5).α) == 5
    @test length(lower(Exponential(2.0), PhaseType; phases = 5).α) == 5
    @test length(lower(Normal(5.0, 0.001), PhaseType; phases = 3).α) == 3

    # A positive integer is required, and the fixed-count path is type-stable.
    @test_throws ArgumentError lower(Gamma(3.0, 1.5), PhaseType; phases = 0)
    @test (@inferred lower(Gamma(3.0, 1.5), PhaseType; phases = 4)) isa
          PhaseType{Vector{Float64}, Matrix{Float64}}
end
