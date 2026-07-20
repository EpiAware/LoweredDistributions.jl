## Unreleased

- **fix:** one-argument `lower(d)` is now AD-stable on the Erlang path (#73).
  `ChainStage` carries its rate's element type through `Coxian` and
  `PhaseType`, so the `c² ≤ 1` Erlang lowering differentiates on every backend
  (previously only Enzyme, through its native `Float64` tracking; ForwardDiff,
  ReverseDiff and Mooncake hit the concrete `Float64` rate field). And
  `lower(d::Gamma)`'s over-dispersed arm builds the hyperexponential
  `PhaseType` directly rather than through `phase_type`, removing a `Union`
  return that broke Enzyme's type analysis. Differentiating `lower(d)` needs
  the Gamma shape (phase count) held constant — the fitting invariant that the
  phase count is fixed structure — so the docs no longer warn against the
  one-argument form on a differentiated path.

- **feat:** this package now hosts the ModifiedDistributions lowering bridge
  (#51/#23): a `ModifiedDistributions` weakdep and
  `LoweredDistributionsModifiedDistributionsExt` define `lower` for the
  modifier leaves, moved verbatim from ModifiedDistributions' own (now
  removed) reverse extension. The bridge is partial by mathematical
  necessity: `Affine` (pure positive rescaling) and a `Modified` Exponential
  leaf lower exactly, while `Weighted`, a shifted `Affine`, `Transformed`,
  and a `Modified` non-Exponential or non-analytic-link leaf are refused
  with an explicit `ArgumentError` rather than a silent approximation. The
  hub-owned ownership split puts the Spec/generator knowledge here rather
  than in ModifiedDistributions; functionality is unchanged when both
  packages are loaded together.

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
