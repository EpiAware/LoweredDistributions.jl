#!/usr/bin/env julia
# PACKAGE-OWNED — not part of the kit's managed test-infra set.
#
# AlgebraicPetri extension test entry, run in its own isolated environment
# (see test/algebraic_petri/Project.toml for why) — mirrors test/ad's
# isolated-environment pattern. Not part of the main `Pkg.test()` run;
# invoke directly:
#
#   julia --project=test/algebraic_petri test/algebraic_petri/runtests.jl

using TestItemRunner

TestItemRunner.run_tests(@__DIR__)
