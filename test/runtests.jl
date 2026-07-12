# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# Main test entry. Discovers `@testitem`s (the managed QA testset under
# `test/package/` plus the package's own unit tests) with TestItemRunner. The
# `:ad`-tagged items live under `test/ad/` with their own environment and run in
# dedicated per-backend CI, so they are excluded here (see test/ad/runtests.jl).
# The `:algebraic_petri`-tagged items live under `test/algebraic_petri/` with
# their own environment too — AlgebraicPetri's own Catalyst weakdep extension
# caps Catalyst at a version incompatible with this package's own Catalyst
# extension, so the two cannot resolve into the main test environment (see
# test/algebraic_petri/runtests.jl).
#
# Filters:
#   skip_quality  — skip the QA testset (fast local iteration)
#   quality_only  — run only the QA testset
#   readme_only   — run only `:readme`-tagged items (README/tutorial tests)

using TestItemRunner

# Restrict discovery to this package's test tree so a nested worktree's items
# are not globbed in. Trailing separator guards against sibling dirs sharing a
# string prefix.
const TEST_ROOT = normpath(@__DIR__) * Base.Filesystem.path_separator
in_this_package(ti) = startswith(normpath(ti.filename), TEST_ROOT)
not_isolated_env(ti) = !(:ad in ti.tags) && !(:algebraic_petri in ti.tags)

if "skip_quality" in ARGS
    @run_package_tests filter = ti -> in_this_package(ti) &&
                                      !(:quality in ti.tags) &&
                                      not_isolated_env(ti)
elseif "quality_only" in ARGS
    @run_package_tests filter = ti -> in_this_package(ti) &&
                                      :quality in ti.tags
elseif "readme_only" in ARGS
    @run_package_tests filter = ti -> in_this_package(ti) &&
                                      :readme in ti.tags
else
    @run_package_tests filter = ti -> in_this_package(ti) &&
                                      not_isolated_env(ti)
end
