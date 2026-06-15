# Web — shadcn theming (Colors + Breakpoints)

Used when **platform = web**. Build the `Colors` and `Breakpoints` collections. Every token
**aliases a Primitive** — no raw hex/px outside `Primitives`. shadcn defaults are oklch; convert
to hex precisely, or source from the project's `globals.css` if a repo is open.

---

## Colors collection  (modes: Light [+ Dark if in scope])

Two groups: `Theme` and `Other`.

### Theme/  — shadcn role tokens
Names match shadcn exactly so the Figma variable equals the dev's utility root
(`bg-background`, `text-muted-foreground`, …). Each aliases a `tailwind colors/*` primitive
(or `brand/*` for primary).

```
Theme/background            Theme/foreground
Theme/card                  Theme/card-foreground
Theme/popover               Theme/popover-foreground
Theme/primary               Theme/primary-foreground
Theme/secondary             Theme/secondary-foreground
Theme/muted                 Theme/muted-foreground
Theme/accent                Theme/accent-foreground
Theme/destructive
Theme/border   Theme/input   Theme/ring
Theme/chart-1 … Theme/chart-5
Theme/sidebar  Theme/sidebar-foreground  Theme/sidebar-primary  Theme/sidebar-primary-foreground
Theme/sidebar-accent  Theme/sidebar-accent-foreground  Theme/sidebar-border  Theme/sidebar-ring
```
Reference defaults (neutral base; verify + convert): `--radius 0.625rem`, `background oklch(1 0 0)`,
`foreground oklch(0.145 0 0)`, `primary oklch(0.205 0 0)`, `muted oklch(0.97 0 0)`,
`muted-foreground oklch(0.556 0 0)`, `border/input oklch(0.922 0 0)`, `ring oklch(0.708 0 0)`,
`destructive oklch(0.577 0.245 27.325)` … (full set in shadcn theming docs). Dark mode re-points
per shadcn's `.dark` block. Typical aliasing: `background → white`, `foreground → neutral/950`,
`muted → neutral/100`, `muted-foreground → neutral/500`, `border/input → neutral/200`,
`primary → brand/500` (or neutral base), `destructive → red/*`.

### Other/  — placeholder
A labelled, **empty** group for project-specific colors the designer adds later (e.g.
`success`, `warning`, marketing accents). Don't pre-fill — just establish the group.

---

## Breakpoints collection  (modes: Desktop, Tablet, Mobile)

Create all three modes with **identical Desktop values** to start; the designer tunes
Tablet/Mobile per project. Everything dimensional aliases `px/*`.

### breakpoint/  — Tailwind threshold widths (constant across modes)
```
breakpoint/sm = 640    breakpoint/md = 768    breakpoint/lg = 1024
breakpoint/xl = 1280   breakpoint/2xl = 1536
```
(Alias `px/640 … px/1536`. Designers may add per-mode `breakpoint/container`, `/columns`, `/gutter`.)

### spacing/  — Tailwind-named, alias px
```
spacing/0 → px/0, spacing/1 → px/4, spacing/2 → px/8, spacing/3 → px/12, spacing/4 → px/16,
spacing/5 → px/20, spacing/6 → px/24, spacing/8 → px/32, spacing/10 → px/40, spacing/12 → px/48,
spacing/16 → px/64, spacing/20 → px/80, spacing/24 → px/96 …
```
(Token `n` = `n × 4px`. Add steps the project uses.)

### radius/  — shadcn `--radius` model, alias px (may differ per mode)
Figma has no calc, so precompute from `radius/base = 10px` (0.625rem):
```
radius/sm = 6px   radius/md = 8px   radius/lg = 10px   radius/xl = 14px
radius/2xl = 18px  radius/3xl = 22px  radius/4xl = 26px
```
Alias each to the matching `px/*` (add `px/6`, `px/14`, `px/18`, `px/22`, `px/26` as needed).
A smaller `radius/base` on Mobile is a valid per-mode tweak.

### typography/  — sizes alias px; weight/family/line-height as values
```
typography/size/xs → px/12,  sm → px/14,  base → px/16,  lg → px/18,  xl → px/20,
              2xl → px/24, 3xl → px/30, 4xl → px/36, 5xl → px/48, 6xl → px/60 …
typography/weight/{thin=100 … black=900}        (raw numbers)
typography/font/sans, typography/font/mono       (family strings; set from brand/approval)
typography/line-height/{none=1, tight=1.25, snug=1.375, normal=1.5, relaxed=1.625, loose=2}
```
(Sizes vary per mode for responsive type; weight/family/line-height usually constant across modes.)

---

## Local styles (Phase 4)
- **Text styles** — role/size named (`Display/2xl`, `Heading/xl`, `Body/base`, `Label/sm`,
  `Caption/xs`, `Code/sm`). **Bind** font family → `typography/font/*`, size → `typography/size/*`,
  weight → `typography/weight/*`, line-height → `typography/line-height/*`. No hardcoded values,
  so type follows the active Breakpoints mode.
- **Effect styles** — Tailwind shadow scale (`shadow-sm … shadow-2xl`); bind shadow color to a `Colors` variable.

## Validation
Theme aliases tailwind colors; Breakpoints tokens alias px; Light/Dark + Desktop/Tablet/Mobile
resolve; text styles are variable-bound; names match shadcn + Tailwind exactly.