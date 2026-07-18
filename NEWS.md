## Unreleased

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

This file tracks notes for major releases and significant milestones; GitHub
Releases (auto-generated from merged PRs) cover every release in between.
