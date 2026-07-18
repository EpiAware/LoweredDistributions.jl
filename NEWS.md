## Unreleased

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
