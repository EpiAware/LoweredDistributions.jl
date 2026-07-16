# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# Package-specific configuration read by the managed `make.jl`. It drives the
# Literate.jl tutorial pipeline and the README/index link rewrites, and lists
# the linkcheck URLs to ignore. The defaults below build a site with no
# tutorials, so a fresh package needs no edits here; fill these in as the docs
# grow. CensoredDistributions.jl's `docs/make.jl` is a worked example of the
# values these consts take.

# Tutorial source `.jl` files (Literate scripts) under `TUTORIALS_SUBDIR`.
#
# Light tutorials emit `@example` blocks that Documenter runs in-process; keep
# cheap tutorials here.
const LIGHT_TUTORIALS = String[]

# Heavy tutorials (live MCMC fits, multi-backend AD, plotting) are each
# executed once in a fresh subprocess so native/memory state cannot accumulate.
#
# `lowering-backends.jl` is heavy because it loads Catalyst, OrdinaryDiffEq,
# and JumpProcesses, and shells out to the isolated `test/algebraic_petri`
# environment for its Petri-net section (AlgebraicPetri caps Catalyst at 13,
# so it cannot share an environment with this package's Catalyst 16
# extension — see `test/algebraic_petri/Project.toml`).
const HEAVY_TUTORIALS = ["lowering-backends.jl"]

# Where the tutorial `.jl` sources and rendered `.md` pages live, relative to
# `docs/src`.
const TUTORIALS_SUBDIR = joinpath("getting-started", "tutorials")

# Fast-build stubs (`--skip-notebooks`): `"file.md" => "# Heading"` pairs. The
# heading should preserve the tutorial's `@id` (e.g.
# `"# [Title](@id my-anchor)"`) so cross-references from other pages still
# resolve in a fast build.
const TUTORIAL_STUBS = [
    "lowering-backends.md" => "# [Lowering a distribution to a dynamical system](@id lowering-backends)"
]

# Heavy tutorials that always render from their `TUTORIAL_STUBS` heading and
# never execute, independent of `--skip-notebooks` — the escape hatch for a
# heavy tutorial with a problem of its own (e.g. a model that does not
# terminate in reasonable time), so it need not block its siblings from
# running for real. Leave empty; every heavy tutorial with no such problem
# should execute.
const FORCE_STUB_TUTORIALS = String[]

# Regexes for URLs to skip during the (full-build) linkcheck, e.g. a page
# published by a separate workflow that is not yet live.
#
# - the stable docs URL: published by the Documenter deploy workflow, which
#   has not run yet for this brand-new package (no `gh-pages`/`stable` tag),
#   so it 404s until the first real deploy.
# - the GitHub Discussions URL: the managed README's standard "ask a
#   question" link; Discussions is not yet enabled on this repository.
const LINKCHECK_IGNORE = [
    r"^https://lowereddistributions\.epiaware\.org/stable/?$",
    r"^https://github\.com/EpiAware/LoweredDistributions\.jl/discussions/?$"
]

# README -> index.md link rewrites: `from => to` pairs applied line by line,
# e.g. rewriting an absolute docs URL to an in-site `@ref` so links stay within
# the built version.
#
# The README's tutorial link points at the published site; on the generated
# home page it should stay inside the built version, so it is rewritten to the
# tutorial's own `@ref` anchor.
#
# The `CITATION.cff` rewrite this list used to carry is gone. It worked around
# the managed README emitting a repo-relative link that the docs site cannot
# resolve; the kit now emits the absolute GitHub blob URL itself, so the pair
# would never match and the workaround is dead.
const INDEX_REWRITES = [
    "(https://lowereddistributions.epiaware.org/stable/getting-started/tutorials/lowering-backends)" => "(@ref lowering-backends)"
]

# Whether README ```julia blocks become runnable `@example readme` blocks on the
# generated home page. Keep `true` when the README's examples are real, runnable
# code; set `false` when they are illustrative (placeholder names) and must not
# execute.
const README_EXECUTE = true

# README headings whose whole section (heading + body, up to the next heading
# of the same or a higher level) is dropped when generating the home page. The
# managed badge block is always stripped via its `<!-- badges:start/end -->`
# markers; this list is the package-owned hook for omitting any OTHER named
# section from the home page (the managed build hardcodes none). Leave empty to
# keep the whole README — content tables and all.
const INDEX_STRIP_SECTIONS = String[]

# Whether the build generates the benchmark page (`src/benchmarks.md`): the
# package-owned `docs/benchmarks.md` prose hook plus the rendered performance
# history (the timeline published to the repo's `benchmarks` branch). Defaults
# to the `benchmarks` flag the package was scaffolded with; `false` drops the
# page and `make.jl` also omits its `pages.jl` nav entry.
const BENCHMARK_PAGE = false
