# Primitives (shared) — Tailwind v4

Single-mode collection holding **raw values only** — the source of truth that Colors and
Breakpoints alias back to. Two things live here: Tailwind colors and raw pixel values.

> Spacing, radius, and typography are NOT primitives — they live in `Breakpoints` and alias `px/*`.

## 1. Sourcing rule
Tailwind v4 ships oklch; Figma stores hex. Use **exact** hex. Priority: (1) a repo's compiled
Tailwind output / `@theme`; (2) the official palette (`tailwindcss.com/docs/colors`), oklch→hex.
Confirm the project's Tailwind minor version (the architecture doc usually states it).

## 2. Color ramps — `tailwind colors/*`
```
tailwind colors/{family}/{step}
```
- Families: `slate, gray, zinc, neutral, stone, red, orange, amber, yellow, lime, green, emerald,
  teal, cyan, sky, blue, indigo, violet, purple, fuchsia, pink, rose` (+ any new v4.x palettes).
- Steps: `50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`.
- Always include neutral families; add accent families the project uses.

## 3. Brand ramps — read the WHOLE brand guide, not just the logo
A brand guide often defines several colors. Capture all of them, don't collapse to one.

**Extraction order:**
1. **Collect every brand swatch** in the guide (named colors, palette pages, hex/RGB callouts) — not only the logo color.
2. **Honor documented usage if present.** If the guide states roles ("primary", "secondary", "accent", "use X for CTAs"), assign by that — it overrides inference.
3. **Otherwise infer roles:**
   - **Primary** = the dominant brand color (logo / most-used / first in the palette).
   - **Secondary** = the next most prominent distinct hue.
   - Remaining distinct colors → tertiary, etc. (skip near-duplicates and pure neutrals already covered by Tailwind grays).
4. **Generate a full 50–950 ramp per brand color**, named:
   ```
   brand/{50…950}            (primary)
   brand-secondary/{50…950}
   brand-tertiary/{50…950}   (and so on)
   ```
   Ramp method: treat the brand hex as the **500** step (or the step matching its lightness); build
   50→950 in oklch/LCH, hue ~constant, stepping lightness like Tailwind's ramp, easing chroma at the extremes.
5. **Confirm with the user** before writing — show the detected colors, their inferred roles, and the ramps.

Single-color guide → just `brand/*` (unchanged). No brand guide → propose primary (+ secondary if wanted), approve, then ramp.

> In HiFi, also create the **project-specific role tokens** the brief/PRD imply (e.g. a dedicated
> CTA colour, accent/transition surfaces). Those live in `Colors/Other` (next file) as semantic
> tokens aliasing these ramps — not as raw values on elements.

## 4. Raw pixel scale — `px/*`
Source of truth for every dimensional token. Name by literal value:
```
px/0, px/1, px/2, px/4, px/6, px/8, px/10, px/12, px/14, px/16, px/18, px/20, px/22, px/24,
px/26, px/28, px/30, px/32, px/34, px/36, px/40, px/48, px/56, px/60, px/64, px/72, px/80, px/96 …
```
Add whatever the responsive spacing/radius/type tables require.

## 5. Opacity scale — `opacity/*`
A Tailwind-standard opacity scale as **number variables**, applied at the layer level (modal
backdrops, disabled states, etc.):
```
opacity/0, opacity/5, opacity/10, opacity/20, opacity/25, opacity/30, opacity/40, opacity/50,
opacity/60, opacity/70, opacity/75, opacity/80, opacity/90, opacity/95, opacity/100
```
Store the percentage value (e.g. `50` = 50%) and **verify the unit on first apply** — Figma's
number-variable units have surprised us before (see line-height). These are **scoped to opacity**
(the one exception to §6's unscoping), since they're applied directly with no token layer above.

> For semi-transparent *colours* (overlays, scrims, shadow tint), use the **alpha colours** in the
> `Colors` collection (`Other/overlay/*`) — Figma can't derive a transparent colour from an
> aliased opaque one, so those are standalone colour variables with baked alpha.

## 6. Scoping — primitives are plumbing
After creating each Primitive, **untick all scopes** so it never appears in a designer's
fill/number/radius picker. Aliasing from Colors/Breakpoints still works regardless of scope.
**Exception:** `opacity/*` is scoped to opacity so designers can apply it directly.

---
**Output:** one `Primitives` collection (no modes): `tailwind colors/*`, `brand*/*`, `px/*`,
`opacity/*`. All unscoped except `opacity/*`. Raw Tailwind ramps are NOT swatched in the Style
Guide — but `brand*/*` ramps **are** documented there.
