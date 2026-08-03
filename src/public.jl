# Public API declarations for Julia 1.11+ (public but not exported).

# The distribution-lowering abstract-type hierarchy. `AbstractLowering` is the
# root every lowered representation subtypes; `AbstractChainTrick` is the
# phase-type branch (`ErlangChain`, `Coxian`, `PhaseType`). The
# Catalyst/SciMLBase/AlgebraicPetri/JumpProcesses weak-dependency extensions,
# and any downstream package building its own lowering, dispatch on these, but
# the exported surface stays to the concrete, user-facing names.
public AbstractLowering, AbstractChainTrick

# The refit verbs. `update(lowered, params)` rebuilds a lowering with new
# continuous parameters while holding its structure fixed; `parameters` is the
# read-back pair. Public but NOT exported, matching ComposedDistributions'
# choice for its own `update` (CD#221): several packages in this ecosystem
# carry an `update`-shaped verb, and exporting a same-named generic from more
# than one of them makes a bare `update` ambiguous under `using` both. Callers
# qualify — `LoweredDistributions.update(...)`.
public update, parameters
