# # The forms a lowering can take
#
# `lower` returns one of three representations, chosen from the value of the
# distribution you give it.
# This page shows each one, what triggers it, and whether it is exact or
# fitted.
#
# The choice is driven by the squared coefficient of variation, `c² =
# var / mean²`, which measures dispersion relative to an exponential.
# An exponential has `c² = 1`, a tighter delay has `c² < 1`, and a
# heavier-tailed one has `c² > 1`.

using LoweredDistributions, Distributions

# ## Exponential delays lower to a two-state CTMC
#
# An `Exponential` is memoryless, so no chain of compartments is needed: a
# single `on` state leaving to `absorbed` at the rate reproduces it exactly.

lower(Exponential(2.0))

# ## Under- and equally-dispersed delays lower to an `ErlangChain`
#
# When `c² ≤ 1` the delay is at least as tight as an exponential, so it is
# represented as compartments in series.
# A `Gamma` with integer shape is exactly that many compartments, so this
# lowering is exact rather than fitted.

lower(Gamma(3.0, 1.5))

# A non-integer shape still lowers to an `ErlangChain`, but now by matching
# the first two moments rather than exactly.

lower(LogNormal(0.0, 0.5))      # c² ≈ 0.28 ≤ 1

# ## Over-dispersed delays lower to a branching `PhaseType`
#
# When `c² > 1` no chain in series can reproduce the spread, so the fit
# branches instead: a mixture over phases, matching the first two moments.

lower(Gamma(0.5, 1.0))          # c² = 2 > 1

# ## Asking for the canonical form directly
#
# The three forms above are what `lower` picks for you, so its return type is
# a `Union` that only resolves once the value is known.
# Every representation also converts to one canonical `PhaseType(α, S)`: an
# initial distribution `α` over transient phases, and a sub-generator `S`
# whose row shortfalls are the exit rates to the absorbing state.
# This is the shape every backend extension consumes.
#
# Passing `PhaseType` as a second argument returns that canonical form
# directly, in one step and with a single concrete return type.
# This is the form to differentiate through, and the one to reach for when
# the structure varies at runtime.

lower(Gamma(3.0, 1.5), PhaseType)

# Because the return type no longer depends on the value, the over-dispersed
# case looks the same from the outside.

lower(Gamma(0.5, 1.0), PhaseType)

# A fixed phase count is available too, which sidesteps the dispersion
# criterion entirely.

lower(Gamma(3.0, 1.5), PhaseType; phases = 5)

# ## Where `Coxian` fits
#
# [`Coxian`](@ref) is a fourth representation the package carries, but `lower`
# never returns one.
# It is the intermediate hop used when converting an `ErlangChain` to its
# canonical form, and it is available by explicit conversion if you want a
# Coxian view of a chain.

Coxian(lower(Gamma(3.0, 1.5)))

# ## Summary
#
# | Input | `c²` | `lower` returns | Exact or fitted |
# |:--|:--|:--|:--|
# | `Exponential` | `= 1` | [`CTMC`](@ref) | exact |
# | integer-shape `Gamma` | `≤ 1` | [`ErlangChain`](@ref) | exact |
# | other `c² ≤ 1` delays | `≤ 1` | [`ErlangChain`](@ref) | two moments |
# | `c² > 1` delays | `> 1` | [`PhaseType`](@ref) | two moments |
#
# `lower(dist, PhaseType)` returns the canonical `(α, S)` for any of these.
# [`Coxian`](@ref) is reachable by conversion, not from `lower`.
#
# See the [lowering tutorial](@ref lowering-backends) for how faithfully each
# fit reproduces the density it came from, and for the backends that consume
# the canonical form.
