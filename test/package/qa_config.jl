# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# QA configuration values the managed `quality.jl` testset reads. Fill in the
# package-specific inputs the shared helpers need; the standard testset logic
# stays in `quality.jl` (managed). Edit freely.

using LoweredDistributions

const QA_CONFIG = (
    # The module under test.
    mod = LoweredDistributions,

    # Path to the isolated JET environment (see test/jet/Project.toml).
    jet_env = joinpath(@__DIR__, "..", "jet"),

    # Per-check Aqua relaxations, e.g. (; ambiguities = false). Empty = all on.
    # `LinearAlgebra` (`_matrix_exp`'s BLAS `*`/identity) and `Statistics`
    # (`phase_type`'s `mean`/`var`) are both genuinely used now the wave-1
    # concrete lowering representations have landed, so `stale_deps` is on.
    aqua = (;),

    # ExplicitImports `ignore`: symbols an extension legitimately imports
    # non-publicly. `_generator` is the internal `AbstractLowering -> (Q, u0)`
    # dispatch both `LoweredDistributionsSciMLBaseExt` and
    # `LoweredDistributionsAlgebraicPetriExt` import from core so they share
    # one numeric dispatch point rather than duplicating it — never exported
    # (it is not part of the public API), so it needs this allowance.
    ei_ignore = (:_generator,),

    # Docstring `crossref_ignore`: upstream names docstrings link to via
    # `[`name`](@ref)`, e.g. (:pdf, :cdf, :logpdf).
    crossref_ignore = (),

    # Extra docstring-format options, e.g.
    # (; exported_only_examples = true, require_field_docs = true).
    docstring = (;),

    # README section-structure check. `path` is the package root (its
    # README.md). Override `required`/`order` to extend or relax the standard
    # section set, e.g.
    #   (; required = vcat(STANDARD_README_SECTIONS, [("Benchmarks",)]))
    # Empty `(;)` uses the standard structure in standard order.
    readme = (; path = joinpath(@__DIR__, "..", "..")),

    # Package extensions to ambiguity-check. Each entry:
    #   (; name = :MyPkgSomeTriggerExt,
    #      triggers = ("SomeTrigger",),       # packages to load first
    #      prefixes = ("MyPkg", "SomeTrigger"),
    #      expect_phantoms = false,    # true if a third party adds phantoms
    #      broken = false)             # true to quarantine a known ambiguity
    # `LoweredDistributionsAlgebraicPetriExt` is deliberately NOT listed here:
    # AlgebraicPetri 0.10's own Catalyst weakdep extension caps Catalyst at
    # "13", incompatible with this package's own `Catalyst = "16"` — the two
    # cannot resolve into one environment, so AlgebraicPetri lives in the
    # isolated `test/algebraic_petri` environment instead (mirroring
    # `test/ad`'s isolated-environment pattern), not this package's main test
    # env this ambiguity check runs in. Checked manually in that isolated env
    # instead (see the wave-2 AlgebraicPetri ext PR description).
    extensions = (
        (; name = :LoweredDistributionsCatalystExt,
            triggers = ("Catalyst",),
            prefixes = ("LoweredDistributions", "Catalyst")),
        (; name = :LoweredDistributionsSciMLBaseExt,
            triggers = ("SciMLBase",),
            prefixes = ("LoweredDistributions", "SciMLBase")),
        (; name = :LoweredDistributionsJumpProcessesExt,
            triggers = ("JumpProcesses",),
            prefixes = ("LoweredDistributions", "JumpProcesses")))
)
