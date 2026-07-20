# Core lowering-hot-path benchmarks: the adaptive `lower` dispatch, the
# type-stable canonical `lower(dist, PhaseType)` form, the CTMC builder and
# its matrix-exponential transition probability (the closest thing this
# package has to a `logpdf`-style scoring hot path — every representation
# canonicalises to a phase-type and is scored the same way), and the three
# backend bridges (Catalyst, JumpProcesses, SciMLBase) that turn a lowering
# into a framework-native problem. Bridge benchmarks measure construction
# only, not simulation — the same three deps the main `test/` environment
# already resolves, so this suite carries no extra dependency weight.

using Catalyst
using JumpProcesses
using SciMLBase

# --- lower: the adaptive dispatch, both branches of the c² split ---

let
    exp_d = Exponential(2.0)
    erlang_g = Gamma(3.0, 1.5)      # c² = 1/3 ≤ 1 -> ErlangChain
    h2_g = Gamma(0.5, 1.0)          # c² = 2 > 1   -> PhaseType (hyperexponential)
    SUITE["Lowering"] = BenchmarkGroup()
    SUITE["Lowering"]["lower(Exponential)"] = @benchmarkable lower($exp_d)
    SUITE["Lowering"]["lower(Gamma, Erlang branch)"] = @benchmarkable lower($erlang_g)
    SUITE["Lowering"]["lower(Gamma, PhaseType branch)"] = @benchmarkable lower($h2_g)
end

# --- lower(dist, PhaseType): the type-stable canonical form, both branches ---

let
    erlang_g = Gamma(3.0, 1.5)
    h2_g = Gamma(0.5, 1.0)
    SUITE["Lowering"]["canonical(Erlang branch)"] = @benchmarkable lower(
        $erlang_g, PhaseType)
    SUITE["Lowering"]["canonical(PhaseType branch)"] = @benchmarkable lower(
        $h2_g, PhaseType)
    SUITE["Lowering"]["canonical(fixed phases)"] = @benchmarkable lower(
        $erlang_g, PhaseType; phases = 5)
end

# --- Evaluation: the CTMC builder + matrix-exponential transition
# probability, and the phase-type survival read off (α, S) directly ---
# (this package's closest analogue to a `logpdf`-style scoring hot path).

let
    pt = lower(Gamma(0.5, 1.0), PhaseType)
    S = pt.S
    SUITE["Evaluation"] = BenchmarkGroup()
    SUITE["Evaluation"]["ctmc builder + transition_probability"] = @benchmarkable transition_probability(
        m, 5.0) setup=(m = ctmc(
        :well => (:ill => 0.2), :ill => (:well => 0.3, :dead => 0.1)))
    SUITE["Evaluation"]["phase-type matrix_exp"] = @benchmarkable LoweredDistributions._matrix_exp(
        $S)
end

# --- Bridges: turn a lowering into a framework-native problem
# (construction only — no simulation/solve) ---

let
    g = Gamma(3.0, 1.5)
    tspan = (0.0, 5.0)
    SUITE["Bridges"] = BenchmarkGroup()
    SUITE["Bridges"]["reaction_system (Catalyst)"] = @benchmarkable reaction_system(
        $g, :onset, :outcome)
    SUITE["Bridges"]["jump_problem (JumpProcesses)"] = @benchmarkable jump_problem(
        $g, $tspan)
    SUITE["Bridges"]["ode_problem (SciMLBase)"] = @benchmarkable ode_problem(
        lower($g), $tspan)
end
