@testitem "petri_net needs AlgebraicPetri" tags=[:algebraic_petri] begin
    using LoweredDistributions

    @test_throws ArgumentError petri_net(1)
end

@testitem "petri_net builds a LabelledPetriNet for a CTMC" tags=[:algebraic_petri] begin
    using LoweredDistributions, AlgebraicPetri

    m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    built = petri_net(m)
    @test built.petri_net isa AlgebraicPetri.LabelledPetriNet
    @test ns(built.petri_net) == 3           # well, ill, dead
    @test nt(built.petri_net) == 3           # well->ill, ill->well, ill->dead
    @test Set(snames(built.petri_net)) == Set(keys(built.u0))
    @test length(built.rates) == 3
    @test built.u0[Symbol(:state, 1)] == 1.0 # point mass on the first state
end

@testitem "petri_net's vectorfield matches the CTMC generator at t = 0" tags=[:algebraic_petri] begin
    using LoweredDistributions, AlgebraicPetri

    m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    built = petri_net(m)
    f! = vectorfield(built.petri_net)
    du = Dict(k => 0.0 for k in keys(built.u0))
    f!(du, built.u0, built.rates, 0.0)
    # Starting entirely in :well (state1), the instantaneous rate of change
    # matches CTMC's own generator row: d(well)/dt = -0.2, d(ill)/dt = 0.2.
    @test du[Symbol(:state, 1)] ≈ -0.2
    @test du[Symbol(:state, 2)] ≈ 0.2
    @test du[Symbol(:state, 3)] ≈ 0.0
end

@testitem "petri_net builds a LabelledPetriNet for an ErlangChain" tags=[:algebraic_petri] begin
    using LoweredDistributions, Distributions, AlgebraicPetri

    chain = lower(Gamma(3.0, 1.5))          # ErlangChain, 3 compartments
    built = petri_net(chain; prefix = :phase)
    @test ns(built.petri_net) == 4          # 3 compartments + absorbed
    @test nt(built.petri_net) == 3          # 2 interior hops + 1 exit
    rate = compartment_stages(Gamma(3.0, 1.5))[1].rate
    @test all(v -> v ≈ rate, values(built.rates))
end

@testitem "petri_net dispatches a Distribution through lower" tags=[:algebraic_petri] begin
    using LoweredDistributions, Distributions, AlgebraicPetri

    d = Gamma(3.0, 1.5)
    a = petri_net(d)
    b = petri_net(lower(d))
    @test ns(a.petri_net) == ns(b.petri_net)
    @test nt(a.petri_net) == nt(b.petri_net)
end

@testitem "petri_net docstring example: default prefix through vectorfield" tags=[:algebraic_petri] begin
    using LoweredDistributions, Distributions, AlgebraicPetri

    # The exact sequence in src/petri.jl's docstring example (default
    # prefix, `Gamma(3.0, 1.5)`, vectorfield, a Dict `du`, and the `f!` call)
    # — kept in sync with that example so the docstring's "exercised here"
    # claim stays true.
    built = petri_net(Gamma(3.0, 1.5))
    f! = vectorfield(built.petri_net)
    du = Dict(k => 0.0 for k in keys(built.u0))
    f!(du, built.u0, built.rates, 0.0)
    # Starting entirely in the first compartment: mass-action fires the
    # state1 -> state2 transition at rate * u[state1] = rate, so state1 loses
    # exactly what state2 gains; the two empty downstream compartments and
    # the absorbed state have no instantaneous flow yet.
    rate = compartment_stages(Gamma(3.0, 1.5))[1].rate
    @test du[Symbol(:state, 1)] ≈ -rate
    @test du[Symbol(:state, 2)] ≈ rate
    @test du[Symbol(:state, 3)] ≈ 0.0
    @test du[Symbol(:state, 4)] ≈ 0.0  # the absorbed compartment
end

@testitem "petri_net rejects a lowering with no positive-rate transitions" tags=[:algebraic_petri] begin
    using LoweredDistributions, AlgebraicPetri

    # A degenerate single-state CTMC (an isolated, never-exiting state) has
    # no off-diagonal entries to build transitions from.
    m = LoweredDistributions.CTMC((:a,), reshape([0.0], 1, 1))
    @test_throws ArgumentError petri_net(m)
end
