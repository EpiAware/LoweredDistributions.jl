@testitem "linear_chain_reactions needs Catalyst" begin
    using LoweredDistributions

    @test_throws ArgumentError linear_chain_reactions(1, 2, 3)
    @test_throws ArgumentError reaction_system(1, 2, 3)
end

@testitem "linear_chain_reactions builds an Erlang chain of reactions" begin
    using LoweredDistributions, Distributions, Catalyst

    t = Catalyst.default_t()
    @species From(t) To(t)
    chain = lower(Gamma(3.0, 1.5))         # ErlangChain, 3 compartments
    built = linear_chain_reactions(chain, From, To; prefix = :I)
    @test length(built.species) == 3
    @test length(built.entry) == 1
    @test length(built.internal) == 3      # 2 interior hops + 1 exit
    @test length(built.reactions) == 4

    # The per-stage rate matches the compartment_stages rate throughout.
    rate = compartment_stages(Gamma(3.0, 1.5))[1].rate
    for rx in built.reactions
        @test rx.rate ≈ rate
    end
end

@testitem "linear_chain_reactions dispatches a Distribution through lower" begin
    using LoweredDistributions, Distributions, Catalyst

    t = Catalyst.default_t()
    @species From(t) To(t)
    # Gamma lowers to an ErlangChain (an AbstractChainTrick); a bare
    # Exponential lowers to a degenerate CTMC instead (see lower(::Exponential))
    # and is out of scope for this reaction-network bridge in wave 1.
    d = Gamma(3.0, 1.5)
    a = linear_chain_reactions(d, From, To)
    b = linear_chain_reactions(lower(d), From, To)
    @test length(a.reactions) == length(b.reactions)
    @test a.reactions[1].rate ≈ b.reactions[1].rate
end

@testitem "linear_chain_reactions handles a branching PhaseType" begin
    using LoweredDistributions, Distributions, Catalyst

    t = Catalyst.default_t()
    @species From(t) To(t)
    d = Gamma(0.5, 1.0)                    # over-dispersed -> PhaseType
    chain = lower(d)
    @test chain isa PhaseType
    built = linear_chain_reactions(chain, From, To)
    @test length(built.species) == 2
    @test length(built.entry) == 2         # both phases have α_j > 0
    @test length(built.internal) == 2      # no off-diagonal hops, 2 exits

    # The entry reactions race for `from`; an individual is routed to phase j
    # with probability rate_j / sum(rate) under Catalyst's mass-action
    # semantics. That must reproduce α exactly — NOT be skewed by each
    # phase's own (different) exit rate, since the two phases here have
    # different rates by construction (a hyperexponential fit).
    entry_rates = [rx.rate for rx in built.entry]
    @test chain.S[1, 1] != chain.S[2, 2]   # phases genuinely differ in rate
    @test entry_rates ./ sum(entry_rates) ≈ chain.α
end

@testitem "linear_chain_reactions entry race is correct when phase 1 has α = 0" begin
    using LoweredDistributions, Distributions, Catalyst

    t = Catalyst.default_t()
    @species From(t) To(t)
    # A hand-built PhaseType where phase 1 is never entered (α[1] = 0) and
    # phase 1's own rate differs from phase 2's — the entry-rate race must
    # still reproduce α exactly, using μ = -S[1, 1] purely as an arbitrary
    # shared positive scale (see the note in the Catalyst ext), not because
    # phase 1 is itself entered.
    α = [0.0, 1.0]
    S = [-5.0 0.0; 0.0 -0.3]
    chain = PhaseType(α, S)
    built = linear_chain_reactions(chain, From, To)
    @test length(built.entry) == 1           # only phase 2 has α_j > 0
    @test built.entry[1].rate ≈ α[2] * (-S[1, 1])
    # Phase 2 alone races (trivially wins with probability 1); the interesting
    # check is that build succeeds and uses the α[1] = 0 case without error.
end

@testitem "reaction_system wraps linear_chain_reactions into a ReactionSystem" begin
    using LoweredDistributions, Distributions, Catalyst

    t = Catalyst.default_t()
    @species From(t) To(t)
    rs = reaction_system(Gamma(3.0, 1.5), From, To; name = :test_chain)
    @test rs isa Catalyst.ReactionSystem
    @test length(Catalyst.reactions(rs)) == 4
end
