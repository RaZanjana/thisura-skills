# Changelog — thisura-style-guide

All notable changes to this skill are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this skill adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Versions are tagged in git as `style-guide-vX.Y.Z`.

## [Unreleased]

## [1.0.0] — 2026-06-19

First stable release. Builds a layered Figma design-token system and a bound
Style Guide page for dev hand-off (Tailwind v4 naming; shadcn for web,
Gluestack for mobile).

### Added
- Layered token system across three collections — Primitives → Colors → Breakpoints — with variable-bound local styles and a bound Style Guide page.
- Responsive per-mode values and variable-bound text styles, with line-height set as a percentage.
- Multi-brand support.
- Card-grid color section with documented brand ramps, an opacity scale, alpha colors, and soft shadows.
- Style-guide **update mode** to refresh an existing guide after variables or styles change.
- Dedicated layout spec and a self-audit checklist (`style-guide-layout.md`) enforcing auto-layout / hug sizing.
- Design-friendly Voice guidance for clearer, less robotic output.

### Fixed
- Height-collapse on colour cards; added a global hug-height rule plus checks.
- Alpha-swatch overlap, left-aligned type, and fixed-column tables in the generated guide.

[Unreleased]: https://github.com/RaZanjana/thisura-skills/compare/style-guide-v1.0.0...HEAD
[1.0.0]: https://github.com/RaZanjana/thisura-skills/releases/tag/style-guide-v1.0.0
