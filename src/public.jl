# Public API declarations for Julia 1.11+ (public but not exported).

# The distribution-lowering abstract-type hierarchy. `AbstractLowering` is the
# root every lowered representation subtypes; `AbstractChainTrick` is the
# phase-type branch (`ErlangChain`, `Coxian`, `PhaseType`). The
# Catalyst/SciMLBase/AlgebraicPetri/JumpProcesses weak-dependency extensions,
# and any downstream package building its own lowering, dispatch on these, but
# the exported surface stays to the concrete, user-facing names.
public AbstractLowering, AbstractChainTrick
