# Mobile — Gluestack theming (Colors + Breakpoints)

Platform = mobile. Build `Colors` and `Breakpoints`, mirroring **Gluestack UI v2** so each Figma
variable name equals the NativeWind class root (`bg-background-0`, `text-typography-900`). Every
token aliases a Primitive. Source exact values from `gluestack-ui-provider/config.ts` if a repo is open.

---

## Colors collection  (modes: Light [+ Dark])

### Theme/  — Gluestack numeric scales (mirror exactly; alias `tailwind colors/*` or `brand*/*`)
Steps `0, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`.
```
Theme/primary/0…950   Theme/secondary/0…950   Theme/tertiary/0…950
Theme/background/0…950  Theme/typography/0…950   Theme/outline/0…950
Theme/error/0…950  Theme/success/0…950  Theme/warning/0…950  Theme/info/0…950
Theme/indicator/primary  Theme/indicator/info  Theme/indicator/error
```
Typical aliasing: `background/0 → white`, `background/950 → neutral/950`, `typography/900 → neutral/900`,
`typography/0 → white`, `outline/200 → neutral/200`, `error → red/*`, `success → green/*`,
`warning → amber/*`, `info → blue/*`. Dark re-points per the provider's dark block.

### Other/  — labelled empty placeholder. Don't pre-fill.

---

## Breakpoints collection  (modes — values VARY per mode)
Mobile apps use two modes: **Tablet** (≥768) · **Mobile** (<768). No `breakpoint` group.
Everything dimensional aliases `px/*`.

### typography/size  (alias px; display shrinks, body constant)
Mirror Gluestack's `size` scale; per-mode values:
| size | Tablet | Mobile |
|---|---|---|
| 6xl | 48 | 36 |
| 5xl | 40 | 32 |
| 4xl | 34 | 28 |
| 3xl | 30 | 24 |
| 2xl | 24 | 22 |
| xl | 20 | 20 |
| lg | 18 | 18 |
| md (base) | 16 | 16 |
| sm | 14 | 14 |
| xs / 2xs | 12 / 10 | 12 / 10 |

### typography/weight, typography/font  (constant)
`weight/{…}` (raw numbers per Gluestack fontWeight); `font/{…}` (family strings).
**Line-height is NOT a variable** — set as a % in each text style (Phase 4).

### spacing/  (Tailwind-named, alias px) — ≤16px constant; ≥24px step down (Mobile ×0.85 vs Tablet)
`6 (24)→20 · 8 (32)→28 · 10 (40)→32 · 12 (48)→40 · 16 (64)→56 · 20 (80)→68 · 24 (96)→80` (Mobile column; Tablet = base).

### radius/  — NativeWind / Tailwind scale, alias px; gentle step-down on Mobile (radii ≥12px)
`none 0 · xs 2 · sm 4 · md 6 · lg 8 · xl 12 · 2xl 16 · 3xl 24 · full 9999` (Tablet base; Mobile eases large radii, e.g. `3xl 24 → 20`).

---

## Local styles
- **Text styles** (`Heading/2xl`, `Text/md`, `Text/2xs`, …): bind family/size/weight to the
  `typography/*` variables. **Set line-height as a %** in the style (headings ~120–130%, body ~150%).
- **Effect styles** — shadow scale; bind shadow color to a `Colors` variable.

## Validation
Theme mirrors Gluestack `{role}-{step}` and aliases colors; spacing/radius/type **differ per mode**;
text styles bound with % line-height; Style Guide shows the per-breakpoint table; names match Gluestack + Tailwind.