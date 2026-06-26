# Phase 1 — Foundations & Tokens (the design-system story)

**Goal:** a layered, fully-bound token system + bound `🎨 Style Guide` page — the foundation every
component and screen is built on. This is usually the design-system story (e.g. "Design System &
CI Tokens") and is the **first review gate**.

This phase folds the whole token-builder workflow into HiFi. Build in this order, reading the
referenced files before each block:

```
Primitives → Colors → Breakpoints → Local styles → Style Guide page → Validation
```

Always read `primitives.md`; then **either** `web-shadcn.md` **or** `mobile-gluestack.md` (per the
locked platform); and read `style-guide-layout.md` before building the page.

---

## Sub-phase 1 — Primitives (no modes)
Per `primitives.md`: `tailwind colors/*` ramps, one `brand*/*` ramp per brand colour, the raw
`px/*` scale, and the `opacity/*` scale. **Unscope every variable** — except `opacity/*`, which is
scoped to opacity (the one applied-directly exception).

## Sub-phase 2 — Colors (modes: Light [+ Dark])
Per the platform file. `Theme/…` = the platform set, aliasing `tailwind colors/*` or `brand*/*`.
`Other/…` holds the **alpha colours** (`Other/overlay/*`, standalone with baked alpha) **plus
project-specific role tokens** the brief/PRD imply — e.g. a dedicated **CTA** colour or
**accent/transition** surfaces — so brand-colour discipline is structural, not manual. Every
`Other` token still aliases a primitive/brand ramp, never a raw value. Add `Dark` only if dark
mode is in scope.

## Sub-phase 3 — Breakpoints (responsive modes)
Per the platform file: `spacing/*`, `radius/*`, `typography/*` that vary per mode. **Create only
the modes the project's locked breakpoints need** (Step 0 decision) — e.g. Desktop 1440 + Mobile
390 → Standard Desktop + Mobile. No `breakpoint` group.

## Sub-phase 4 — Local styles
- **Text styles** — bind family → `typography/font/*`, size → `typography/size/*`, weight →
  `typography/weight/*`. Set **line-height as a %** in the style (headings ~120–130%, body ~150%).
  One semantic style per role, reused across breakpoints (the mode resolves the size — Standard #19).
- **Effect (shadow) styles** — Tailwind v4 shadow scale: **black at low alpha (~0.05–0.25), most as
  two stacked layers** (tight contact + soft ambient), never 100%. Bind the shadow colour to
  `Other/overlay/shadow`. Source exact offset/blur/spread from Tailwind v4 (`shadow-xs … shadow-2xl`).

## Sub-phase 5 — Style Guide page (read `style-guide-layout.md` first)
**Build the entire page with Figma auto-layout + hug/fill sizing — never absolute x/y with guessed
widths/heights.** Follow `style-guide-layout.md` exactly. Page `🎨 Style Guide`, rendered from
tokens + styles: theme-colour **card grid** grouped by category; **brand ramps** (50→950);
**alpha + opacity** swatches on a checkerboard; **typography** specimens + per-breakpoint table;
**spacing & radius** compact per-breakpoint tables with visual bars/boxes; **shadow** specimen
boxes. Every specimen bound to its variable/style. **Run the sizing checklist in
`style-guide-layout.md` before finishing.**

## Sub-phase 6 — Validation
Primitives unscoped (except `opacity/*`); Colors/Breakpoints reference them; per-mode values
differ where specified; text styles variable-bound with % line-height; shadows low-alpha and
bound; brand ramps documented; project role tokens (CTA/transition) present. Run the layout sizing
checklist. Then **screenshot the Style Guide and stop for the stakeholder to confirm
palette/type/spacing** before any component is built.

---

## Sourcing rule (design-first vs repo-open)
If the project's code repo is open, pull exact token values from its Tailwind / shadcn / Gluestack
build so Figma matches what devs ship. With no repo (design-first), use canonical Tailwind v4
values, and note that the file should be re-run against the repo once the theme is scaffolded.

## Refresh mode (foundations only)
If the file already has `Primitives`/`Colors`/`Breakpoints` and a `🎨 Style Guide` page, don't
recreate them: read the current variables and styles live, then **rebuild the Style Guide page
from `style-guide-layout.md`** (identical structure, updated values) and report what changed
(new/renamed/removed tokens). This is the foundations equivalent of the per-story manual-change
absorption in `per-story-loop.md`.

> **Why tokens first:** binding everything to variables makes theming, responsive sizing, and
> global edits one-change operations — and prevents the "wrong-name → black text" class of bugs
> (verify names — Standard #2). Project-specific role tokens make brand discipline structural.
