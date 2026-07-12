"""
    LoweredDistributions

A distribution-lowering hub: [`lower`](@ref) maps a `Distributions`
`Distribution` onto a backend-agnostic dynamical-systems representation, an
[`AbstractLowering`](@ref).

This package is currently a skeleton: only the root type hierarchy and a stub
[`lower`](@ref) are in place. The concrete lowering representations
(`ErlangChain`, `Coxian`, `PhaseType`, `CTMC`, `SemiMarkov`), their `Spec` and
registry plumbing, the `phase_type(d)` fit dispatch, the recurrent/CTMC port,
and the BLAS-free `_matrix_exp` helper are ported next, once the core's
central data structure (typed `NamedTuple` vs `Dict`, currently under
diagnostic) is settled. `LinearAlgebra`, `Random` and `Statistics` are
dependencies of this package in anticipation of that port, ahead of any code
using them (see `test/package/qa_config.jl` for the temporary Aqua
`stale_deps` relaxation this implies).

```@example
using LoweredDistributions

AbstractChainTrick <: AbstractLowering
```
"""
module LoweredDistributions

# All genuine module-scope `using`/`import` statements live here, in
# the main module file, rather than scattered across included files.
using Distributions: Distribution
using DocStringExtensions: @template, DOCSTRING, EXPORTS, IMPORTS,
                           TYPEDEF, TYPEDFIELDS, TYPEDSIGNATURES

# Register the standard EpiAware docstring conventions before any
# docstrings are defined (see src/docstrings.jl).
include("docstrings.jl")

# --- Locked type hierarchy --------------------------------------------------
#
# TODO: concrete lowering representations are ported next, once the core's
# central data structure (typed `NamedTuple` vs `Dict`) is settled:
#   - `ErlangChain`, `Coxian`, `PhaseType` <: AbstractChainTrick
#   - `CTMC`, `SemiMarkov` <: AbstractLowering (not phase-type)

@doc """
Root of the distribution-lowering hierarchy.

A backend-agnostic dynamical-systems representation that [`lower`](@ref)
produces from a `Distributions.Distribution`. Concrete representations
(ported next) subtype this directly (`CTMC`, `SemiMarkov`) or through the
phase-type branch, [`AbstractChainTrick`](@ref).
"""
abstract type AbstractLowering end

@doc """
Phase-type branch of [`AbstractLowering`](@ref).

Representations built from a finite absorbing Markov chain over exponential
phases. TODO: concrete subtypes `ErlangChain`, `Coxian`, `PhaseType` are
ported next.
"""
abstract type AbstractChainTrick <: AbstractLowering end

"""
    lower(dist::Distribution)

Lower a `Distribution` to a backend-agnostic dynamical-systems representation
(an [`AbstractLowering`](@ref)).

# Arguments

  - `dist`: the `Distribution` to lower.

TODO: stub only — no concrete `AbstractLowering` exists yet. The `phase_type`
fit dispatch and the recurrent/CTMC port land with the concrete
representations, once the core's central data structure is settled.

```@example
using LoweredDistributions, Distributions

try
    lower(Normal())
catch e
    println(sprint(showerror, e))
end
```
"""
function lower(dist::Distribution)
    error("lower(::$(typeof(dist))) is not implemented yet; " *
          "concrete AbstractLowering representations are ported next.")
end

export lower, AbstractLowering, AbstractChainTrick

end # module LoweredDistributions
