@testitem "parameters/update round-trip is the identity" begin
    using LoweredDistributions, Distributions

    # update(l, parameters(l)) == l for every lowered type, via the NamedTuple
    # read-back and via the flat AbstractVector primitive.
    erlang = lower(Gamma(3.0, 1.5))
    coxian = Coxian([1.0, 2.0, 3.0], [1.0, 1.0, 0.0])
    pt = lower(Gamma(0.5, 1.0), PhaseType)
    ct = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))

    for l in (erlang, coxian, pt, ct)
        @test update(l, parameters(l)) == l
    end

    # Flat-vector round-trip in each type's canonical order.
    @test update(erlang, parameters(erlang).rates) == erlang
    @test update(coxian, parameters(coxian).rates) == coxian
    @test update(ct, parameters(ct).rates) == ct
    @test update(pt, vcat(pt.α, vec(pt.S))) == pt
end

@testitem "update preserves structure and sets new parameters" begin
    using LoweredDistributions, Distributions

    # ErlangChain: the stage count and names are structure; only the rate moves.
    e = lower(Gamma(3.0, 1.5))
    e2 = update(e, [0.4])
    @test length(e2.stages) == length(e.stages)
    @test e2.stages[1].stages == e.stages[1].stages   # phase count fixed
    @test e2.stages[1].name == e.stages[1].name
    @test e2.stages[1].rate == 0.4
    @test parameters(e2).rates == [0.4]

    # CTMC: editing an existing transition keeps the state set and topology.
    ct = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    ct2 = update(ct, [0.5, 0.6, 0.7])                 # a->b, b->a, b->c order
    @test ct2.states == ct.states
    @test parameters(ct2).rates == [0.5, 0.6, 0.7]
    @test ct2.Q[1, 2] == 0.5
    @test ct2.Q[2, 1] == 0.6
    @test ct2.Q[2, 3] == 0.7
    @test ct2.Q[1, 1] == -0.5                          # diagonal recomputed
    @test ct2.Q[1, 3] == 0.0                           # absent edge stays absent
end

@testitem "update carries the parameter element type" begin
    using LoweredDistributions, Distributions

    # A Float32 rate vector rebuilds a Float32-carrying object (the property that
    # lets an AD dual through — differentiate-through-update covered in the AD
    # suite).
    e = update(lower(Gamma(3.0, 1.0)), Float32[0.5])
    @test e.stages[1].rate isa Float32
    @test PhaseType(e).S isa AbstractMatrix{Float32}

    ct = update(ctmc(:a => (:b => 1.0), :b => (:a => 1.0)), Float32[2.0, 3.0])
    @test eltype(ct.Q) === Float32
end

@testitem "update is type-stable and infers the concrete type" begin
    using LoweredDistributions, Distributions, Test

    e = lower(Gamma(3.0, 1.0))
    @test (@inferred update(e, [0.5])) isa ErlangChain
    pt = lower(Gamma(0.5, 1.0), PhaseType)
    @test (@inferred update(pt, vcat(pt.α, vec(pt.S)))) isa PhaseType
    ct = ctmc(:a => (:b => 1.0), :b => (:a => 1.0))
    @test (@inferred update(ct, [2.0, 3.0])) isa CTMC
end

@testitem "update rejects the wrong number of parameters" begin
    using LoweredDistributions, Distributions

    @test_throws ArgumentError update(lower(Gamma(3.0, 1.0)), [0.5, 0.6])
    ct = ctmc(:a => (:b => 1.0), :b => (:a => 1.0))
    # Too many rates: a new transition is a structural change, not an update.
    @test_throws ArgumentError update(ct, [1.0, 2.0, 3.0])
    pt = lower(Gamma(0.5, 1.0), PhaseType)
    @test_throws ArgumentError update(pt, [1.0])
end

@testitem "update differentiates through on ForwardDiff (per lowered type)" begin
    using LoweredDistributions, Distributions, ForwardDiff, LinearAlgebra

    # Structure fixed outside the differentiated closure; only the continuous
    # parameters carry the dual (the AD suite covers Enzyme forward/reverse and
    # the rest — this is a cheap main-suite guard).
    surv(pt, t) = sum(transpose(pt.α) * LoweredDistributions._matrix_exp(pt.S .* t))

    e = lower(Gamma(3.0, 1.0))
    g_erlang = ForwardDiff.derivative(
        θ -> surv(PhaseType(update(e, [exp(θ)])), 5.0), log(0.7))
    @test isfinite(g_erlang) && g_erlang != 0

    ct = ctmc(:a => (:b => 1.0), :b => (:a => 1.0, :c => 1.0))
    g_ctmc = ForwardDiff.gradient(
        θ -> transition_probability(update(ct, exp.(θ)), 2.0)[1, 3],
        log.([1.0, 1.0, 1.0]))
    @test all(isfinite, g_ctmc) && any(!=(0), g_ctmc)

    pt = lower(Gamma(0.5, 1.0), PhaseType)
    g_pt = ForwardDiff.derivative(
        θ -> surv(update(pt, vcat(pt.α, vec(pt.S) .* exp(θ))), 5.0), 0.0)
    @test isfinite(g_pt) && g_pt != 0
end
