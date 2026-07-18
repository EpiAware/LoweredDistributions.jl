# update(lowered, dist): the shape-preserving companion to lower/phase_type
# (#54). Every method rescales the existing generator to match `dist`'s mean
# exactly, holding phase count / state names / topology fixed — so the same
# shape is reused rather than re-derived from `dist`'s value.

@testitem "update(::PhaseType, ...) on an Erlang-canonical template" begin
    using LoweredDistributions, Distributions

    template = lower(Gamma(3.0, 1.5), PhaseType)   # 3-phase Erlang, mean 4.5
    @test template isa PhaseType
    @test length(template.α) == 3

    updated = update(template, Gamma(3.0, 3.0))    # same shape, new mean 9.0
    @test updated isa PhaseType
    @test updated.α == template.α                  # structure untouched
    @test length(updated.α) == length(template.α)

    # Matches the new mean exactly (α ⋅ (-S)⁻¹ 1).
    m1 = (-updated.S) \ ones(length(updated.α))
    @test sum(updated.α .* m1) ≈ mean(Gamma(3.0, 3.0))

    # Every rate scaled by the same factor, so the shape (c²) is preserved.
    ratio = updated.S ./ template.S
    finite_ratios = filter(isfinite, vec(ratio))
    @test all(r -> isapprox(r, first(finite_ratios); atol = 1e-8), finite_ratios)
end

@testitem "update(::PhaseType, ...) on a hyperexponential template" begin
    using LoweredDistributions, Distributions

    template = phase_type(Gamma(0.5, 1.0))         # c² = 2 > 1 -> PhaseType
    @test template isa PhaseType
    @test length(template.α) == 2

    updated = update(template, Gamma(0.5, 4.0))
    @test updated.α == template.α                  # mixture weight p unchanged

    m1 = (-updated.S) \ ones(2)
    fitted_mean = sum(updated.α .* m1)
    @test fitted_mean ≈ mean(Gamma(0.5, 4.0))

    # c² (the shape) is exactly preserved, not re-derived from the new dist.
    ex2 = sum(updated.α[j] * 2 / (-updated.S[j, j])^2 for j in 1:2)
    fitted_var = ex2 - fitted_mean^2
    @test fitted_var / fitted_mean^2 ≈
          var(Gamma(0.5, 1.0)) / mean(Gamma(0.5, 1.0))^2
end

@testitem "update(::Coxian, ...) rescales rates, keeps probs" begin
    using LoweredDistributions, Distributions

    template = Coxian(lower(Gamma(3.0, 1.5)))      # 3-phase, all continue-prob 1
    updated = update(template, Gamma(3.0, 4.5))

    @test updated.probs == template.probs
    @test length(updated.rates) == length(template.rates)

    p = PhaseType(updated)
    m1 = (-p.S) \ ones(length(p.α))
    @test sum(p.α .* m1) ≈ mean(Gamma(3.0, 4.5))
end

@testitem "update(::ErlangChain, ...) rescales the single stage's rate" begin
    using LoweredDistributions, Distributions

    template = lower(Gamma(3.0, 1.5))              # ErlangChain, 3 stages
    @test template isa ErlangChain

    updated = update(template, Gamma(3.0, 4.5))
    @test length(updated.stages) == 1
    s = only(updated.stages)
    s0 = only(template.stages)
    @test s.stages == s0.stages
    @test s.name == s0.name
    @test s.stages / s.rate ≈ mean(Gamma(3.0, 4.5))
end

@testitem "update(::ErlangChain, ...) refuses a multi-stage chain" begin
    using LoweredDistributions, Distributions

    multi = ErlangChain([ChainStage(:a, 1.0, 2), ChainStage(:b, 1.0, 3)])
    @test_throws ArgumentError update(multi, Gamma(3.0, 1.5))
end

@testitem "update(::CTMC, ...) rescales the degenerate two-state chain" begin
    using LoweredDistributions, Distributions

    template = lower(Exponential(2.0))
    @test template isa CTMC
    @test template.states == (:on, :absorbed)

    updated = update(template, Exponential(5.0))
    @test updated.states == template.states
    @test updated.Q[1, 2] ≈ inv(5.0)
    @test updated.Q[1, 1] ≈ -inv(5.0)

    # Any distribution's mean matches, not only Exponential.
    updated2 = update(template, Gamma(3.0, 2.0))
    @test updated2.Q[1, 2] ≈ inv(mean(Gamma(3.0, 2.0)))
end

@testitem "update(::CTMC, ...) refuses a non-degenerate chain" begin
    using LoweredDistributions, Distributions

    m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    @test_throws ArgumentError update(m, Exponential(2.0))
end

@testitem "update(...) refuses a distribution with no finite positive mean" begin
    using LoweredDistributions, Distributions

    template = lower(Gamma(3.0, 1.5), PhaseType)
    @test_throws ArgumentError update(template, Cauchy(0.0, 1.0))
end
