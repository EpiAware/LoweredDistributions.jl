@testitem "phase_type fits an ErlangChain for c² ≤ 1" begin
    using LoweredDistributions, Distributions

    d = Gamma(2.5, 1.0)                   # scv = 1/2.5 = 0.4 ≤ 1
    p = phase_type(d)
    @test p isa ErlangChain
    @test p.stages == compartment_stages(d; moment_match = true)
end

@testitem "phase_type fits a two-phase PhaseType for c² > 1" begin
    using LoweredDistributions, Distributions

    d = Gamma(0.5, 1.0)                   # scv = 1/0.5 = 2 > 1
    p = phase_type(d)
    @test p isa PhaseType
    @test length(p.α) == 2

    # The fit exactly reproduces the target mean and c² (balanced-means H2).
    m = mean(d)
    scv = var(d) / m^2
    # mean = sum(α_j / (-S[j,j]))
    fitted_mean = sum(p.α[j] / (-p.S[j, j]) for j in 1:2)
    @test fitted_mean ≈ m
    # E[X²] = sum(α_j * 2 / (-S[j,j])^2); var = E[X²] - mean^2
    ex2 = sum(p.α[j] * 2 / (-p.S[j, j])^2 for j in 1:2)
    fitted_scv = (ex2 - fitted_mean^2) / fitted_mean^2
    @test fitted_scv ≈ scv
end

@testitem "the hyperexponential fit rejects c² ≤ 1" begin
    using LoweredDistributions

    @test_throws ArgumentError LoweredDistributions._hyperexponential_fit(1.0, 0.5)
end
