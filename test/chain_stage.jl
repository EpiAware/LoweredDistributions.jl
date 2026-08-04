@testitem "compartment_stages lowers a single Exp/Erlang leaf" begin
    using LoweredDistributions, Distributions

    es = compartment_stages(Exponential(2.0))
    @test length(es) == 1
    @test es[1].stages == 1
    @test es[1].rate ≈ 0.5
    @test es[1].name == :delay

    gs = compartment_stages(Gamma(3.0, 1.5))
    @test length(gs) == 1
    @test gs[1].stages == 3
    @test gs[1].rate ≈ 1 / 1.5
    @test gs[1].stages / gs[1].rate ≈ mean(Gamma(3.0, 1.5))
end

@testitem "compartment_stages rejects non-Exp/Erlang delays" begin
    using LoweredDistributions, Distributions

    @test_throws ArgumentError compartment_stages(Gamma(2.5, 1.0))
    @test_throws ArgumentError compartment_stages(LogNormal(1.0, 0.5))
    @test_throws ArgumentError compartment_stages(Weibull(2.0, 1.0))
end

@testitem "compartment_stages moment-matches a non-Erlang leaf" begin
    using LoweredDistributions, Distributions

    d = Gamma(2.5, 1.0)
    s = compartment_stages(d; moment_match = true)
    @test length(s) == 1
    k = s[1].stages
    @test k == round(Int, 1 / (var(d) / mean(d)^2))
    @test k / s[1].rate ≈ mean(d)
end

@testitem "compartment_stages moment_match keeps the exact path exact" begin
    using LoweredDistributions, Distributions

    exact = compartment_stages(Gamma(3.0, 1.5))
    matched = compartment_stages(Gamma(3.0, 1.5); moment_match = true)
    @test matched[1].stages == exact[1].stages
    @test matched[1].rate ≈ exact[1].rate
end

@testitem "compartment_stages rejects over-dispersed moment matching" begin
    using LoweredDistributions, Distributions

    # SCV > 1 has no Erlang chain that matches both moments, even under
    # moment_match; phase_type is the entry point that handles this case.
    @test_throws ArgumentError compartment_stages(
        LogNormal(0.0, 1.5); moment_match = true)
end

@testitem "ChainStage carries the rate element type" begin
    using LoweredDistributions, Distributions

    # The rate is stored in a `ChainStage{T}` parametric field, not forced to
    # `Float64`, so a non-Float64 element type flows through — this is what lets
    # an AD dual through the Erlang lowering (issue #73).
    s = compartment_stages(Gamma(3.0f0, 1.5f0))
    @test s[1] isa ChainStage{Float32}
    @test s[1].rate isa Float32

    e = lower(Gamma(3.0f0, 1.5f0))
    @test e isa ErlangChain{Vector{ChainStage{Float32}}}
    # ... and the canonical (α, S) view keeps that element type.
    pt = PhaseType(e)
    @test eltype(pt.α) === Float32
    @test eltype(pt.S) === Float32
end
