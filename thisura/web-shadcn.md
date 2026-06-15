# Web — shadcn theming (Colors + Breakpoints)

Platform = web. Build `Colors` and `Breakpoints`. Every token aliases a Primitive — no raw
hex/px outside `Primitives`. shadcn defaults are oklch; convert to hex precisely, or source from
the project's `globals.css`.

---

## Colors collection  (modes: Light [+ Dark])

### Theme/  — shadcn role tokens (alias `tailwind colors/*` or `brand*/*`)
```
Theme/background  Theme/foreground   Theme/card  Theme/card-foreground
Theme/popover  Theme/popover-foreground   Theme/primary  Theme/primary-foreground
Theme/secondary  Theme/secondary-foreground   Theme/muted  Theme/muted-foreground
Theme/accent  Theme/accent-foreground   Theme/destructive
Theme/border  Theme/input  Theme/ring   Theme/chart-1 … Theme/chart-5
Theme/sidebar  Theme/sidebar-foreground  Theme/sidebar-primary  Theme/sidebar-primary-foreground
Theme/sidebar-accent  Theme/sidebar-accent-foreground  Theme/sidebar-border  Theme/sidebar-ring
```
Defaults (neutral base; verify + convert oklch→hex): `background oklch(1 0 0)`, `foreground oklch(0.145 0 0)`,
`primary oklch(0.205 0 0)`, `muted oklch(0.97 0 0)`, `muted-foreground oklch(0.556 0 0)`,
`border/input oklch(0.922 0 0)`, `ring oklch(0.708 0 0)`, `destructive oklch(0.577 0.245 27.325)` …
Dark re-points per `.dark`. Typical aliasing: `background → white`, `foreground → neutral/950`,
`muted → neutral/100`, `muted-foreground → neutral/500`, `border/input → neutral/200`,
`primary → brand/500`, `destructive → red/*`.

### Other/  — labelled empty placeholder for project-specific colors. Don't pre-fill.

---

## Breakpoints collection  (modes — values VARY per mode)
Modes: **Large Desktop** (>1440) · **Standard Desktop** (1280–1440) · **Tablet** (768–1279) · **Mobile** (<768).
No `breakpoint` group — the modes are the breakpoints. Everything dimensional aliases `px/*`.

### typography/size  (alias px; display shrinks, body constant)
| token | L.Desktop | S.Desktop | Tablet | Mobile |
|---|---|---|---|---|
| 6xl | 72 | 60 | 48 | 36 |
| 5xl | 60 | 48 | 40 | 32 |
| 4xl | 48 | 40 | 34 | 28 |
| 3xl | 40 | 36 | 30 | 24 |
| 2xl | 32 | 28 | 24 | 22 |
| xl | 24 | 22 | 20 | 20 |
| lg | 20 | 18 | 18 | 18 |
| base | 16 | 16 | 16 | 16 |
| sm | 14 | 14 | 14 | 14 |
| xs | 12 | 12 | 12 | 12 |

### typography/weight, typography/font  (constant across modes)
`weight/{thin=100 … black=900}` (raw numbers); `font/sans`, `font/mono` (family strings from brand/approval).
**Line-height is NOT a variable** — set it as a % in each text style (Phase 4).

### spacing/  (Tailwind-named, alias px) — ≤16px constant; ≥24px step down
Rule: Tablet ×0.85, Mobile ×0.70 for tokens ≥24px, rounded to the 4px grid.
| token (S.Desktop) | L.Desktop | S.Desktop | Tablet | Mobile |
|---|---|---|---|---|
| 1–4 (4–16) | = | = | = | = (unchanged) |
| 6 (24) | 24 | 24 | 20 | 16 |
| 8 (32) | 32 | 32 | 28 | 24 |
| 10 (40) | 40 | 40 | 32 | 28 |
| 12 (48) | 48 | 48 | 40 | 32 |
| 16 (64) | 64 | 64 | 56 | 44 |
| 20 (80) | 80 | 80 | 68 | 56 |
| 24 (96) | 96 | 96 | 80 | 68 |

### radius/  — shadcn `--radius` model, alias px; gentle step-down (×0.9 Tablet, ×0.8 Mobile; radii ≥12px only)
Base scale (Desktop): `sm 6 · md 8 · lg 10 · xl 14 · 2xl 18 · 3xl 22 · 4xl 26` (from `radius/base = 10`, 0.625rem).
Small radii (≤10) stay constant; larger ones step down (e.g. `2xl 18 → 16 → 14`).

---

## Local styles
- **Text styles** (`Display/2xl`, `Heading/xl`, `Body/base`, `Label/sm`, `Caption/xs`, `Code/sm`):
  bind family → `typography/font/*`, size → `typography/size/*`, weight → `typography/weight/*`.
  **Set line-height as a %** in the style (e.g. headings 120–130%, body 150%) — % renders correctly
  and auto-scales with the per-mode size.
- **Effect styles** — `shadow-sm … shadow-2xl`; bind shadow color to a `Colors` variable.

## Validation
Theme aliases colors; spacing/radius/type **differ per mode** per the tables; text styles bound with
% line-height; Style Guide shows the per-breakpoint table; names match shadcn + Tailwind.