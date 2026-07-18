md"""
# [AlgebraicPetri: the Petri-net view](@id backend-petri)

`petri_net` returns a `LabelledPetriNet` alongside the name-indexed rate and initial-condition `Dict`s that AlgebraicPetri's own `vectorfield` needs (it indexes by species and transition name, not by position).
It starts from the same `Gamma(3, 1.5)` lowering as the other backends — see [Lowering a distribution to a dynamical system](@ref lowering-backends).

This backend's demo runs in its own environment: the package keeps one at `test/algebraic_petri`, and the demo below runs against it.

If you are reading this as a downloaded script rather than building the docs, this section needs a checked-out copy of the repository (it resolves paths relative to the package source).
"""

using LoweredDistributions

petri_env = joinpath(pkgdir(LoweredDistributions), "test", "algebraic_petri")
petri_script = joinpath(pkgdir(LoweredDistributions), "docs",
    "algebraic_petri", "demo.jl")

# The demo script itself, printed from the file that is about to be run, so the page cannot drift from the code:

print(read(petri_script, String))

# And its real output, from a subprocess against that isolated environment.
# `read` throws on a non-zero exit, so a broken demo fails the docs build rather than silently printing nothing.

setup = `$(Base.julia_cmd()) --project=$petri_env -e "using Pkg; Pkg.instantiate()"`
demo = `$(Base.julia_cmd()) --project=$petri_env $petri_script`

read(setup, String) #hide
print(read(demo, String))

md"""
The transitions are the chain's interior hops plus its exit, the rates are all the same per-stage rate `1/1.5`, and `du` at time zero shows the mass draining out of the first compartment into the second — the same generator the ODE and jump backends read, in Petri-net clothing.
"""
