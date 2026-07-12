# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# AD-fixture registry implementing the EpiAwarePackageTools `ADRegistry`
# contract. Three scenarios cover the wave-1 differentiated lowering paths:
#
#   - `ctmc_builder`: rebuilds a CTMC via `ctmc(specs...)` (the heterogeneous
#     Pair-vararg spec parser) each call, then differentiates
#     `transition_probability` through it. Known-broken on Enzyme (forward AND
#     reverse) — an upstream Enzyme compiler limitation on that builder, not on
#     the matrix exponential (see `matrix_exp_direct` below).
#   - `matrix_exp_direct`: the SAME `transition_probability`/`_matrix_exp`
#     kernel, but with `Q` assembled as a plain typed array literal (no
#     `ctmc(specs...)` call). Clean on every backend, including Enzyme — this
#     isolates the Enzyme break to the builder's spec parsing, confirming the
#     locked design's "BLAS matrix exponential differentiates fine" claim.
#   - `phase_type_hyperexponential`: the over-dispersed (c² > 1) two-moment
#     fit, pure smooth arithmetic (no rounding/branching on the AD parameter),
#     clean on every backend.
#
# `compartment_stages`/`ErlangChain` are NOT included: `ChainStage.rate` is a
# concrete `Float64` field (ported as-is from CensoredDistributions.jl), so
# that lowering is intentionally non-differentiable structural data, not a
# differentiated path.
module ADFixtures

using ADTypes: ADTypes, AutoForwardDiff, AutoReverseDiff, AutoMooncake,
               AutoMooncakeForward, AutoEnzyme
using DifferentiationInterface: DifferentiationInterface, Constant
import DifferentiationInterfaceTest as DIT
import ForwardDiff, ReverseDiff, Mooncake, Enzyme
using LoweredDistributions

export scenarios, backends, broken_scenario_names,
       backend_broken_scenarios, backend_skip_scenarios

const CTMC_BUILDER = "ctmc(specs...) builder + transition_probability gradient"
const MATRIX_EXP_DIRECT = "matrix_exp/transition_probability direct gradient"
const PHASE_TYPE_H2 = "phase_type hyperexponential (α, S) gradient"

# ForwardDiff reference gradient for a scenario function.
function _reference(f, θ, contexts)
    return DifferentiationInterface.gradient(
        f, AutoForwardDiff(), θ, contexts...)
end

# Rebuilds Q via `ctmc(specs...)` on every call, so the heterogeneous
# Pair-vararg spec parser is on the differentiated path.
function _ctmc_builder_nll(θ)
    m = ctmc(:well => (:ill => θ[1]), :ill => (:well => θ[2], :dead => θ[3]))
    return transition_probability(m, 5.0)[1, 2]
end

# The same kernel, with Q assembled directly (no `ctmc(specs...)` builder) so
# only `_matrix_exp`/`transition_probability` is exercised.
function _matrix_exp_direct(θ)
    Q = [-θ[1] θ[1] zero(θ[1])
         θ[2] -(θ[2]+θ[3]) θ[3]
         zero(θ[1]) zero(θ[1]) zero(θ[1])]
    m = CTMC((:well, :ill, :dead), Q)
    return transition_probability(m, 5.0)[1, 2]
end

# The over-dispersed phase_type branch: pure smooth arithmetic, no rounding.
# `scv = 1 + exp(θ[1])` is > 1 for EVERY real θ (including θ = 0), so this is
# domain-total: Enzyme's and Mooncake's rule-preparation machinery evaluates a
# differentiated closure at points other than the scenario's declared `x`
# (observed here as a zero-vector probe — `phase_type(LogNormal(0.0, 0.0))`
# throws on its own finite-variance guard, which a domain-restricted scenario
# cannot survive regardless of how that guard is written). Routing straight
# to `_hyperexponential_fit` with an always-valid `scv` avoids that landmine
# while still exercising the exact fit arithmetic `phase_type` uses.
function _phase_type_h2(θ)
    scv = 1 + exp(θ[1])
    p = LoweredDistributions._hyperexponential_fit(2.0, scv)
    return sum(p.S)
end

"""
    scenarios(; with_reference = false, category = :marginal)

The AD gradient scenarios. Each is a `DIT.Scenario{:gradient, :out}` whose
`res1` carries a ForwardDiff reference when `with_reference = true`. Only the
`:marginal` category exists (this package has no latent/marginal split).
"""
function scenarios(; with_reference::Bool = false, category::Symbol = :marginal)
    out = DIT.Scenario{:gradient, :out}[]

    θ1 = [0.2, 0.3, 0.1]
    push!(out,
        DIT.Scenario{:gradient, :out}(_ctmc_builder_nll, θ1;
            name = CTMC_BUILDER,
            res1 = with_reference ? _reference(_ctmc_builder_nll, θ1, ()) : nothing))

    θ2 = [0.2, 0.3, 0.1]
    push!(out,
        DIT.Scenario{:gradient, :out}(_matrix_exp_direct, θ2;
            name = MATRIX_EXP_DIRECT,
            res1 = with_reference ? _reference(_matrix_exp_direct, θ2, ()) : nothing))

    θ3 = [0.5]
    push!(out,
        DIT.Scenario{:gradient, :out}(_phase_type_h2, θ3;
            name = PHASE_TYPE_H2,
            res1 = with_reference ? _reference(_phase_type_h2, θ3, ()) : nothing))

    return out
end

"""
    backends()

The AD backends to test, as `(; name, backend)` named tuples.
"""
function backends()
    return [
        (name = "ForwardDiff", backend = AutoForwardDiff()),
        (name = "ReverseDiff (tape)",
            backend = AutoReverseDiff(compile = false)),
        (name = "Mooncake reverse",
            backend = AutoMooncake(config = nothing)),
        (name = "Mooncake forward", backend = AutoMooncakeForward()),
        (name = "Enzyme reverse",
            backend = AutoEnzyme(
                mode = Enzyme.set_runtime_activity(Enzyme.Reverse))),
        (name = "Enzyme forward",
            backend = AutoEnzyme(
                mode = Enzyme.set_runtime_activity(Enzyme.Forward)))
    ]
end

"Scenario names broken on every backend."
broken_scenario_names() = String[]

"""
    backend_broken_scenarios()

Per-backend broken scenario names. Only [`CTMC_BUILDER`](@ref) is broken, and
only on Enzyme (forward AND reverse): `ctmc(specs...)`'s heterogeneous
`Pair...` spec parsing hits an upstream Enzyme compiler limitation, verified
independent of the matrix exponential itself (see `matrix_exp_direct`, which
is clean on Enzyme).
"""
function backend_broken_scenarios()
    ctmc_builder_broken = Set{String}([CTMC_BUILDER])
    return Dict{String, Set{String}}(
        "ForwardDiff" => Set{String}(),
        "ReverseDiff (tape)" => Set{String}(),
        "Mooncake reverse" => Set{String}(),
        "Mooncake forward" => Set{String}(),
        "Enzyme reverse" => ctmc_builder_broken,
        "Enzyme forward" => ctmc_builder_broken
    )
end

"Per-backend scenario names too unstable to run at all."
backend_skip_scenarios() = Dict{String, Set{String}}()

end # module ADFixtures
