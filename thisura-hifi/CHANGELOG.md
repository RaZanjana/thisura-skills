# Changelog — thisura-hifi

All notable changes to this skill are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this skill adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Versions are tagged in git as `hifi-vX.Y.Z`.

## [Unreleased]

### Changed
- Token-usage optimization (no behavior change): trimmed the always-on `description`, and added a "reference read map" so only the files a step needs are loaded (e.g. one platform file, not both; resume skips the token specs; no re-reading within a session).

## [1.0.0] — 2026-06-26

First stable release. Runs the full high-fidelity Figma pipeline — tokens →
components → screens — from a project's BMAD/WDS planning artifacts, one story
at a time, with a stakeholder review gate.

### Added
- End-to-end HiFi pipeline: Step 0 orient/setup → Phase 1 Foundations & tokens → per-story loop (components → desktop + mobile screens → annotate → AA → review).
- **Foundations phase folds in the design-token / style-guide builder** (Primitives → Colors → Breakpoints, bound text + shadow styles, and a bound Style Guide page), so no separate style-guide skill is needed.
- Components-on-demand workflow with variants, shadcn interaction states, slots, and token bindings.
- Screen assembly from instances with breakpoint-mode binding, global chrome, AC-required states, and desktop CTA/link annotations.
- Manual-change absorption protocol — detect and absorb the designer's direct Figma edits each story, promoting general rules to numbered standards.
- Stateless **Continue / Resume** protocol (`continue-resume.md`) — pick up an in-progress file (same day or next) without rework: build-log resume index, `sharedPluginData` drift fingerprints on masters/frames, screenshot confirmation, a "what changed" report with promote-vs-override approval, frozen signed-off stories, and an end-of-session checkpoint.
- WCAG AA resolving-contrast audit as a gate, the 23-point standards checklist, and a build-log workflow memory.
- Design-friendly Voice guidance for clearer, less robotic output.

[Unreleased]: https://github.com/RaZanjana/thisura-skills/compare/hifi-v1.0.0...HEAD
[1.0.0]: https://github.com/RaZanjana/thisura-skills/releases/tag/hifi-v1.0.0
