@testitem "jump_problem needs JumpProcesses" begin
    using LoweredDistributions

    @test_throws ArgumentError jump_problem(1, (0.0, 1.0))
end

@testitem "jump_problem builds a JumpProblem for a CTMC" begin
    using LoweredDistributions, JumpProcesses

    m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    prob = jump_problem(m, (0.0, 100.0))
    @test prob isa JumpProcesses.JumpProblem
    sol = solve(prob, SSAStepper())
    # A single individual moving between states: the total population count
    # is conserved at 1 throughout (no births/deaths, only relabelling).
    @test sum(sol.u[end]) == 1
    @test sum(sol.u[1]) == 1
end

@testitem "jump_problem's mass-action structure matches the CTMC generator" begin
    using LoweredDistributions, JumpProcesses

    m = ctmc(:well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1))
    prob = jump_problem(m, (0.0, 1.0))
    # 3 off-diagonal positive entries in Q: well->ill, ill->well, ill->dead.
    @test JumpProcesses.get_num_majumps(prob.massaction_jump) == 3
    @test prob.prob.u0 == [1, 0, 0]
end

@testitem "jump_problem builds a JumpProblem for an ErlangChain" begin
    using LoweredDistributions, Distributions, JumpProcesses

    chain = lower(Gamma(3.0, 1.5))          # ErlangChain, 3 compartments
    prob = jump_problem(chain, (0.0, 100.0))
    @test prob.prob.u0 == [1, 0, 0, 0]      # 3 phases + absorbed
    sol = solve(prob, SSAStepper())
    @test sum(sol.u[end]) == 1
end

@testitem "jump_problem dispatches a Distribution through lower" begin
    using LoweredDistributions, Distributions, JumpProcesses

    d = Gamma(3.0, 1.5)
    a = jump_problem(d, (0.0, 1.0))
    b = jump_problem(lower(d), (0.0, 1.0))
    @test a.prob.u0 == b.prob.u0
    @test JumpProcesses.get_num_majumps(a.massaction_jump) ==
          JumpProcesses.get_num_majumps(b.massaction_jump)
end

@testitem "jump_problem rejects a lowering with no positive-rate transitions" begin
    using LoweredDistributions

    # A degenerate single-state CTMC (an isolated, never-exiting state) has
    # no off-diagonal entries to build transitions from.
    m = LoweredDistributions.CTMC((:a,), reshape([0.0], 1, 1))
    @test_throws ArgumentError jump_problem(m, (0.0, 1.0))
end

@testitem "jump_problem rejects a mixture-α lowering without explicit u0" begin
    using LoweredDistributions, Distributions, JumpProcesses

    d = Gamma(0.5, 1.0)                     # over-dispersed -> PhaseType
    chain = lower(d)
    @test chain isa PhaseType
    @test !isapprox(maximum(chain.α), 1; atol = 1e-8)  # genuinely a mixture
    @test_throws ArgumentError jump_problem(chain, (0.0, 1.0))
end

@testitem "jump_problem accepts an explicit u0 for a mixture-α lowering" begin
    using LoweredDistributions, Distributions, JumpProcesses

    d = Gamma(0.5, 1.0)
    chain = lower(d)
    prob = jump_problem(chain, (0.0, 1.0); u0 = [1, 0, 0])
    @test prob.prob.u0 == [1, 0, 0]
end

@testitem "jump_problem's simulated absorption time matches the distribution mean" begin
    using LoweredDistributions, Distributions, JumpProcesses, Random, Statistics

    # An Exponential(2.0) lowers to a 2-state CTMC (on -> absorbed at rate
    # 0.5); the jump process's own absorption time is one exact draw from
    # Exponential(2.0) itself, so many replicates' sample mean must converge
    # to the distribution's own mean.
    Random.seed!(1234)
    d = Exponential(2.0)
    m = lower(d)
    prob = jump_problem(m, (0.0, 500.0))
    n = 2000
    absorption_times = Vector{Float64}(undef, n)
    for i in 1:n
        sol = solve(prob, SSAStepper())
        j = findfirst(u -> u[2] == 1, sol.u)
        absorption_times[i] = sol.t[j]
    end
    @test isapprox(mean(absorption_times), mean(d); atol = 0.15, rtol = 0.1)
end
