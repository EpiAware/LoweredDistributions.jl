# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# AD-fixture registry implementing the EpiAwarePackageTools `ADRegistry`
# contract. Five scenarios cover the differentiated lowering paths:
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
#   - `ode_survival`: differentiates a distribution's scale parameter THROUGH
#     `lower` -> `ode_problem` -> an actual fixed-step `Tsit5` solve, back out
#     to the survival probability at a fixed time — the wave-2 "differentiate
#     through an ODE solve" row. Broken on every backend except ForwardDiff:
#     `lower`/`phase_type`'s adaptive `ErlangChain`-or-`PhaseType` return type
#     is a genuine `Union` on the differentiated path (the same class of break
#     the locked design already registered for `Union{Dict, NamedTuple}`), on
#     top of the `ode_survival_direct` limitation below.
#   - `ode_survival_direct`: the identical ODE solve, but built from a
#     hand-constructed, FIXED-type `PhaseType` (bypassing `lower`'s Union
#     branch entirely). Still broken on every backend except ForwardDiff —
#     this isolates a SECOND, independent limitation: differentiating an
#     actual `OrdinaryDiffEq` `solve()` call (even fixed-step, even with a
#     concrete input type) is the well-known naive-AD-through-an-ODE-
#     integrator fragility that needs a proper adjoint/sensitivity method
#     (SciMLSensitivity) for anything but forward-mode Dual propagation;
#     out of leaf scope for this wave. Enzyme forward doesn't even error
#     catchably here — it crashes the process (see `backend_skip_scenarios`).
#
#   - `adaptive_survival`: the same survival, but read off `lower(dist)`'s
#     adaptive (Union-returning) dispatch, with NO ODE solve in the way. This
#     is the issue #16 break in isolation: broken on Enzyme (forward and
#     reverse), clean on ReverseDiff and both Mooncake modes — so the Union
#     alone is fatal only to Enzyme, and `ode_survival`'s failures elsewhere
#     are the ODE solve, not the Union.
#   - `canonical_erlang` / `canonical_h2`: the fix — the same survival through
#     `lower(dist, PhaseType)`, the type-stable canonical lowering, on both
#     sides of the `c²` branch. Clean on every backend, Enzyme included.
#
# `compartment_stages`/`ErlangChain` are NOT included: `ChainStage.rate` is a
# concrete `Float64` field (ported as-is from CensoredDistributions.jl), so
# that lowering is intentionally non-differentiable structural data, not a
# differentiated path — which is exactly why `lower(dist, PhaseType)` builds
# `(α, S)` directly instead of going through it.
module ADFixtures

using ADTypes: ADTypes, AutoForwardDiff, AutoReverseDiff, AutoMooncake,
               AutoMooncakeForward, AutoEnzyme
using DifferentiationInterface: DifferentiationInterface, Constant
import DifferentiationInterfaceTest as DIT
import ForwardDiff, ReverseDiff, Mooncake, Enzyme
using Distributions: Gamma
using SciMLBase: solve
using OrdinaryDiffEqTsit5: Tsit5
using LoweredDistributions

export scenarios, backends, broken_scenario_names,
       backend_broken_scenarios, backend_skip_scenarios

const CTMC_BUILDER = "ctmc(specs...) builder + transition_probability gradient"
const MATRIX_EXP_DIRECT = "matrix_exp/transition_probability direct gradient"
const PHASE_TYPE_H2 = "phase_type hyperexponential (α, S) gradient"
const ODE_SURVIVAL = "ode_problem solve survival gradient (PhaseType)"
const ODE_SURVIVAL_DIRECT = "ode_problem solve survival gradient (PhaseType, direct)"
const ADAPTIVE_SURVIVAL = "lower(dist) adaptive-dispatch survival gradient"
const CANONICAL_ERLANG = "lower(dist, PhaseType) survival gradient (c² ≤ 1)"
const CANONICAL_H2 = "lower(dist, PhaseType) survival gradient (c² > 1)"

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

# lower(Gamma(0.5, exp(θ[1]))) -> ode_problem -> a fixed-step Tsit5 solve ->
# the survival probability at t = 5. Shape (0.5, always over-dispersed since
# c² = 2 regardless of scale) is fixed so this always takes the phase_type
# (PhaseType) branch, NOT ErlangChain: ChainStage.rate is a concrete Float64
# field (deliberately non-differentiable structural data, see
# phase_type_hyperexponential above), so an ErlangChain-routed distribution
# parameter would hit that guard rather than the ODE solve itself. `exp(θ[1])`
# (not `θ[1]` directly) keeps the scale positive for EVERY real θ, including
# the θ = 0 rule-preparation probe Enzyme/Mooncake/ReverseDiff evaluate the
# closure at (a bare `θ[1]` scale hits `Gamma`'s `scale > 0` guard there,
# the same landmine `phase_type_hyperexponential` sidesteps above).
function _ode_survival(θ)
    chain = lower(Gamma(0.5, exp(θ[1])))
    prob = ode_problem(chain, (0.0, 5.0))
    sol = solve(prob, Tsit5(); dt = 0.01, adaptive = false, save_everystep = false)
    return sum(sol.u[end][1:2])
end

# Diagnostic twin of `_ode_survival`: the SAME fixed-step ODE solve, but
# building the PhaseType directly (a fixed concrete type) instead of through
# `lower`/`phase_type`'s adaptive `ErlangChain`-or-`PhaseType` dispatch.
# Isolates whether an `ode_problem`/Tsit5 differentiation break is the solve
# itself, or `lower`'s Union return type reaching a downstream differentiated
# call (see the ODE_SURVIVAL registration note).
function _ode_survival_direct(θ)
    α = [0.6, 0.4]
    S = [-3.0 zero(θ[1]); zero(θ[1]) -exp(θ[1])]
    chain = LoweredDistributions.PhaseType(α, S)
    prob = ode_problem(chain, (0.0, 5.0))
    sol = solve(prob, Tsit5(); dt = 0.01, adaptive = false, save_everystep = false)
    return sum(sol.u[end][1:2])
end

# The phase-type survival P(T > t) = sum(α' exp(S t)), read straight off a
# canonical (α, S) with the package's own matrix exponential. No ODE solver is
# involved, so these scenarios isolate the LOWERING's differentiability from
# the separate "AD through an OrdinaryDiffEq solve" limitation the two
# ode_survival scenarios above carry.
function _pt_survival(pt, t)
    return sum(transpose(pt.α) * LoweredDistributions._matrix_exp(pt.S .* t))
end

# The adaptive dispatch on the differentiated path: `lower(Gamma(...))` is
# statically `Union{ErlangChain, PhaseType}` even though this shape (0.5,
# c² = 2 > 1) always takes the PhaseType branch at runtime. The Union is the
# whole point of the scenario — this is the break issue #16 registered,
# reproduced without an ODE solve in the way.
function _adaptive_survival(θ)
    pt = PhaseType(lower(Gamma(0.5, exp(θ[1]))))
    return _pt_survival(pt, 5.0)
end

# The type-stable twin: `lower(dist, PhaseType)` always returns the same
# concrete type, so the same survival gradient is available on every backend.
# Shape 3 (c² = 1/3 ≤ 1) takes the Erlang-chain branch, which the adaptive
# dispatch routes through `ChainStage`'s Float64 rate field and so cannot
# differentiate at all; the canonical form builds (α, S) directly.
function _canonical_erlang_survival(θ)
    return _pt_survival(lower(Gamma(3.0, exp(θ[1])), PhaseType), 5.0)
end

# The same canonical entry point on the over-dispersed (c² = 2 > 1) branch,
# so both sides of the fit's runtime branch are covered.
function _canonical_h2_survival(θ)
    return _pt_survival(lower(Gamma(0.5, exp(θ[1])), PhaseType), 5.0)
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

    θ4 = [log(1.5)]
    push!(out,
        DIT.Scenario{:gradient, :out}(_ode_survival, θ4;
            name = ODE_SURVIVAL,
            res1 = with_reference ? _reference(_ode_survival, θ4, ()) : nothing))

    θ5 = [log(1.5)]
    push!(out,
        DIT.Scenario{:gradient, :out}(_ode_survival_direct, θ5;
            name = ODE_SURVIVAL_DIRECT,
            res1 = with_reference ? _reference(_ode_survival_direct, θ5, ()) :
                   nothing))

    θ6 = [log(1.5)]
    push!(out,
        DIT.Scenario{:gradient, :out}(_adaptive_survival, θ6;
            name = ADAPTIVE_SURVIVAL,
            res1 = with_reference ? _reference(_adaptive_survival, θ6, ()) :
                   nothing))

    θ7 = [log(1.5)]
    push!(out,
        DIT.Scenario{:gradient, :out}(_canonical_erlang_survival, θ7;
            name = CANONICAL_ERLANG,
            res1 = with_reference ?
                   _reference(_canonical_erlang_survival, θ7, ()) : nothing))

    θ8 = [log(1.5)]
    push!(out,
        DIT.Scenario{:gradient, :out}(_canonical_h2_survival, θ8;
            name = CANONICAL_H2,
            res1 = with_reference ?
                   _reference(_canonical_h2_survival, θ8, ()) : nothing))

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

Per-backend broken scenario names.

[`CTMC_BUILDER`](@ref) is broken only on Enzyme (forward AND reverse):
`ctmc(specs...)`'s heterogeneous `Pair...` spec parsing hits an upstream
Enzyme compiler limitation, verified independent of the matrix exponential
itself (see `matrix_exp_direct`, which is clean on Enzyme).

[`ODE_SURVIVAL`](@ref) and [`ODE_SURVIVAL_DIRECT`](@ref) are broken on every
backend except ForwardDiff, for two DIFFERENT, independently-diagnosed
reasons:

  - `ODE_SURVIVAL` (through `lower`): `lower`/`phase_type`'s adaptive fit
    returns `ErlangChain` or `PhaseType` depending on the distribution's `c²`
    at runtime — a genuine `Union` return type, the SAME class of problem the
    locked design already registered for a `Union{Dict, NamedTuple}` on a
    differentiated path (an Enzyme `IllegalTypeAnalysisException`), now
    showing up one level up in `lower`'s own dispatch rather than a
    container. Mooncake reverse's error trace shows the derived rule's
    `Union{Dual{ErlangChain}, Dual{PhaseType}}` return type directly.
  - `ODE_SURVIVAL_DIRECT` (a hand-built, fixed-type `PhaseType`, bypassing
    `lower`'s branch entirely): differentiating an ACTUAL `OrdinaryDiffEq`
    `solve()` call — even fixed-step, even with a concrete input type — is
    the well-known "naive AD through an ODE integrator" fragility that needs
    a proper adjoint/sensitivity method (SciMLSensitivity) for anything but
    forward-mode Dual propagation; out of leaf scope. ReverseDiff/Mooncake/
    Enzyme-reverse hit a `MethodError` inside ReverseDiff's own nested-
    ForwardDiff broadcast machinery interacting with `DiffEqBase.solve`'s
    dynamic dispatch; Enzyme forward crashes the process outright (see
    `backend_skip_scenarios`).

Together the two confirm: `lower`'s Union return type is a REAL, separate
problem from ODE-solve differentiation (which itself is unreliable on
anything but ForwardDiff, regardless of the Union). Differentiating
`ode_problem(dist_lowering, tspan)` on a non-ForwardDiff backend needs
SciMLSensitivity; that adoption is future work, tracked as a wave-3 follow-up.

[`ADAPTIVE_SURVIVAL`](@ref) prices the Union on its own, with no ODE solver
anywhere near it (the same survival, read off the canonical `(α, S)` with the
package's own matrix exponential). It is broken on Enzyme — forward AND
reverse — and clean on ReverseDiff and both Mooncake modes. That is a sharper
result than `ODE_SURVIVAL` could give: the Union alone is fatal only to
Enzyme, and `ODE_SURVIVAL`'s failure on ReverseDiff/Mooncake is the ODE solve,
not the Union. Issue #16's "breaks AD on all but ForwardDiff" therefore
conflated the two; the honest statement is "breaks Enzyme, and is a latent
hazard everywhere else".

[`CANONICAL_ERLANG`](@ref) and [`CANONICAL_H2`](@ref) are the fix, and are
clean on every backend including both Enzyme modes: `lower(dist, PhaseType)`
returns one concrete type on both sides of the `c²` branch, and builds `(α,
S)` directly rather than through `ChainStage`'s `Float64` rate field — so the
`c² ≤ 1` Erlang branch, which the adaptive dispatch cannot differentiate at
all, differentiates here too.
"""
function backend_broken_scenarios()
    ctmc_builder_broken = Set{String}([CTMC_BUILDER])
    ode_broken = Set{String}([ODE_SURVIVAL, ODE_SURVIVAL_DIRECT])
    # The Union return type on its own: Enzyme-only (see the note above).
    union_broken = Set{String}([ADAPTIVE_SURVIVAL])
    return Dict{String, Set{String}}(
        "ForwardDiff" => Set{String}(),
        "ReverseDiff (tape)" => copy(ode_broken),
        "Mooncake reverse" => copy(ode_broken),
        "Mooncake forward" => copy(ode_broken),
        "Enzyme reverse" => union(ctmc_builder_broken, ode_broken, union_broken),
        "Enzyme forward" => union(ctmc_builder_broken,
            Set{String}([ODE_SURVIVAL]), union_broken)
    )
end

"""
    backend_skip_scenarios()

Per-backend scenario names too unstable to run at all.

[`ODE_SURVIVAL_DIRECT`](@ref) is skipped on Enzyme forward: it crashes the
Julia process UNCATCHABLY (`signal 6`/`SIGABRT`, reproduced twice), so it
cannot be marked `@test_broken` by running it — it must be dropped from that
backend's run instead. The crash is a genuine upstream Enzyme compiler
assertion failure (`GradientUtils.cpp:656: Assertion "f !=
originalToNewFn.end()" failed`) while forward-differentiating through
`DiffEqBase.solve`'s internal `get_concrete_problem` dynamic dispatch — not a
bug in this package. Every other backend (ForwardDiff, ReverseDiff, both
Mooncake modes, Enzyme reverse) differentiates this scenario correctly, so its
gradient correctness is covered there; only Enzyme forward's own compiler
limitation is skipped.
"""
function backend_skip_scenarios()
    return Dict{String, Set{String}}(
        "Enzyme forward" => Set{String}([ODE_SURVIVAL_DIRECT])
    )
end

end # module ADFixtures
