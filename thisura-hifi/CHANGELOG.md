# Changelog — thisura-hifi

All notable changes to this skill are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this skill adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Versions are tagged in git as `hifi-vX.Y.Z`.

## [Unreleased]

## [1.2.1] — 2026-07-14

### Added
- **No em dashes in generated artifacts** (Standard #28): never write `—` or `–` into UI copy,
  labels, annotations, stickies, or designer chat; use commas, periods, or parentheses.
  Documented in Voice, `screens.md`, and `build-log.md`.

## [1.2.0] — 2026-07-14

### Added
- **BMAD/WDS doc auto-find** via `adapters/bmad-inputs.md` — discovers PRD, architecture, stories,
  DESIGN.md, and wireframe status before asking the designer to hunt for files.
- **Tiered start:** Foundations (tokens) vs first-story screens vs “best quality” extras — no longer
  blocks on a full ten-doc checklist.
- Reads **`wireframe-status.md`** from Wireframe sign-off; warns if journeys aren’t approved yet.
- Prefers **DESIGN.md** colours/type when present; tags screens with BMAD **story ids**.
- Designer-friendly README rewrite.

### Changed
- Step 0 intake: confirm auto-found docs in plain language; only ask for gaps.
- Voice table: translate BMAD/path jargon for designers.

## [1.1.0] — 2026-06-29

### Added
- **`components.md` — Responsive auto-layout contract (Standards #25–#27):** shell patterns for
  Input/Select/Textarea/Checkbox; never stub-height `resize(w, 10)`; text FILL property order;
  board-section hug rules; post-create zero-width scan + screenshot gate.
- **`screens.md` — Layout verification gate** before AA/review (child order, zero-width scan,
  field grid, mobile CTA width, screenshot).
- **`troubleshooting.md`:** rows for vertical letter-stack text, footer-above-form, collapsed board
  section, textarea `NONE` auto-resize, checkbox label clip.
- **`build-log.md`:** Standards #25 (no placeholder-height auto-layout), #26 (text FILL contract),
  #27 (layout verification gate).

### Changed
- Promoted HES Story 2.7 layout-incident learnings into enforceable standards so component masters
  stay responsive before screen assembly.

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

[Unreleased]: https://github.com/RaZanjana/thisura-skills/compare/hifi-v1.2.0...HEAD
[1.2.0]: https://github.com/RaZanjana/thisura-skills/releases/tag/hifi-v1.2.0
[1.1.0]: https://github.com/RaZanjana/thisura-skills/releases/tag/hifi-v1.1.0
[1.0.0]: https://github.com/RaZanjana/thisura-skills/releases/tag/hifi-v1.0.0
