# Tests for the ConvolvedDistributions lowering bridge (the weakdep extension).
# ConvolvedDistributions is pinned in the test env's [sources], so the extension
# loads and `lower(::Convolved)` is available here.

# Mean of a phase-type: α'(-S)⁻¹1. No such accessor lives in the package, so the
# tests compute it directly to check the convolution's mean.
@testitem "Convolved lowers to a series phase-type chain" begin
    using LoweredDistributions, Distributions, ConvolvedDistributions
    using LinearAlgebra

    ptmean(p) = -sum(transpose(p.α) * inv(Matrix(p.S)))

    # Gamma(2) is a 2-phase Erlang, Exponential a single phase -> a 3-phase
    # convolution, and the mean is the sum of the component means.
    c = convolved(Gamma(2.0, 1.5), Exponential(3.0))
    p = lower(c)
    @test p isa PhaseType
    @test length(p.α) == 3
    @test ptmean(p)≈mean(Gamma(2.0, 1.5)) + mean(Exponential(3.0)) rtol=1e-6

    # Three components fold in series too.
    c3 = convolved(Exponential(1.0), Exponential(2.0), Gamma(3.0, 1.0))
    p3 = lower(c3)
    @test length(p3.α) == 1 + 1 + 3
    @test ptmean(p3)≈1.0 + 2.0 + mean(Gamma(3.0, 1.0)) rtol=1e-6

    # The type-stable entry point returns the same structural convolution.
    @test lower(c, PhaseType).S == p.S
end

@testitem "Convolved bridge refuses Difference and Product" begin
    using LoweredDistributions, Distributions, ConvolvedDistributions

    # A modifier bears either a convolution (lowers) or something that is not a
    # sum of delays (refuses) — never a silent moment-matched approximation.
    @test_throws ArgumentError lower(
        difference(Gamma(2.0, 1.0), Exponential(1.0)))
    @test_throws ArgumentError lower(
        product(Gamma(2.0, 1.0), Exponential(1.0)))
end

@testitem "lowered Convolved is backend-ready and differentiable" begin
    using LoweredDistributions, Distributions, ConvolvedDistributions
    using SciMLBase, ForwardDiff, LinearAlgebra

    # The lowered phase-type feeds the backend extensions like any other
    # AbstractLowering.
    p = lower(convolved(Gamma(2.0, 1.0), Exponential(1.5)))
    @test ode_problem(p, (0.0, 1.0)) isa SciMLBase.ODEProblem

    # A component rate differentiates straight through the convolution:
    # d/dθ mean(convolved(Gamma(2, θ), Exponential(1.5))) = d/dθ (2θ + 1.5) = 2.
    θmean(θ) = begin
        pp = lower(convolved(Gamma(2.0, θ), Exponential(1.5)))
        -sum(transpose(pp.α) * inv(Matrix(pp.S)))
    end
    @test ForwardDiff.derivative(θmean, 1.0)≈2.0 rtol=1e-5
end
