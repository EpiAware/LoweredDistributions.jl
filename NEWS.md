## Unreleased

- **feat:** `update(lowered, dist)` is the shape-preserving companion to
  `lower`/`phase_type` (#54): given an existing lowered value and a new
  `Distribution`, it recomputes only the numeric fields (rates, initial
  distribution, generator entries) from `dist`'s mean, holding the phase
  count / state names / generator topology fixed rather than re-deriving
  them. Covers `PhaseType` and `Coxian` (both AD-safe — generic numeric
  fields), a single-stage `ErlangChain` (not AD-safe — `ChainStage.rate` is
  a concrete `Float64`), and the degenerate two-state `CTMC`
  `lower(::Exponential)` produces; any other shape throws an
  `ArgumentError`. Intended for a differentiated inference loop (e.g.
  sampling `dist`'s parameters under Turing), where re-running `lower`'s
  structural branch (Erlang chain vs hyperexponential, decided by the
  squared coefficient of variation) on every draw risks the represented
  shape silently flipping between draws.

- **feat:** this package now hosts the ComposedDistributions lowering bridge
  (#51/#22): a `ComposedDistributions` weakdep and
  `LoweredDistributionsComposedDistributionsExt` define `lower` for the
  composer types (`Sequential`, `Resolve`, `Compete`, `Shared` fold to a
  phase-type; `Parallel` and `Choose` fold to a joint CTMC), moved verbatim
  from ComposedDistributions' own (now removed) reverse extension. The
  hub-owned ownership split puts the Spec/generator knowledge here rather
  than in ComposedDistributions; functionality is unchanged when both
  packages are loaded together.

This file tracks notes for major releases and significant milestones; GitHub
Releases (auto-generated from merged PRs) cover every release in between.
