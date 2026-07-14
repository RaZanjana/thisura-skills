# Changelog — thisura-wireframe

All notable changes to this skill are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this skill adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Versions are tagged in git as `wireframe-vX.Y.Z`.

## [Unreleased]

## [1.1.1] — 2026-07-14

### Added
- **No em dashes in generated artifacts:** never write `—` or `–` into FigJam/Figma copy, box
  titles, stickies, connector labels, or designer chat; use commas, periods, or parentheses.
  Naming examples updated to `{Screen} ({state})` and `(reveals in: …)`.

## [1.1.0] — 2026-07-14

### Added
- **BMAD/WDS doc auto-find** via `adapters/bmad-inputs.md` — looks for PRD, epics & stories, and
  journeys/scenarios in the project before asking the designer to attach files.
- Writes/updates **`wireframe-status.md`** when a journey is signed off (so HiFi can see what’s approved).
- Designer-friendly README rewrite (plain language, BMAD-aware “what you need”).

### Changed
- Intake and audits speak in terms of **epics & stories** and **journeys/scenarios** (Themes & Epics /
  User Journey file remain as fallbacks).
- Voice table: translate BMAD/path jargon into designer language.

## [1.0.0] — 2026-06-19

First stable release. Maps a project's user journeys as low-fidelity flow maps
on a FigJam board (one journey at a time), then generates polished lo-fi screen
components in a Figma Design file once a flow is signed off.

### Added
- Journey-by-journey FigJam flow maps: greyscale screen boxes (title + key elements), native connectors, decision diamonds, and start/end terminators.
- Sticky-note hand-off annotations in a dedicated annotation lane, with a Section per journey.
- Branch-screen grid with orthogonal connector routing and path segmenting.
- Figma Design mode: lo-fi screen components with state variants for mapping against signed-off journeys.
- Frame-size invariant and containment checks to keep the layout sound.
- Design-friendly Voice guidance for clearer, less robotic output.

### Changed
- Full wireframe-skill rework with hardened FigJam rules.
- Point cross-references for hi-fi UI / design tokens at `thisura-hifi` (the standalone `thisura-style-guide` skill is retired and folded into `thisura-hifi`'s Foundations phase).
- Token-usage optimization (no behavior change): trimmed the always-on `description`, and made the Workflow load only the current mode's reference files (Mode A skips `lofi-components.md`; Mode B skips the FigJam flow files; no re-reading within a session).

### Fixed
- In-screen text overflow and connector crossings.

[Unreleased]: https://github.com/RaZanjana/thisura-skills/compare/wireframe-v1.1.0...HEAD
[1.1.0]: https://github.com/RaZanjana/thisura-skills/releases/tag/wireframe-v1.1.0
[1.0.0]: https://github.com/RaZanjana/thisura-skills/releases/tag/wireframe-v1.0.0
