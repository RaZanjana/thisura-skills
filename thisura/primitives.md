# Primitives (shared) — Tailwind v4

The `Primitives` collection is single-mode and holds **raw values only** — the one source of
truth that Colors and Breakpoints alias back to. Just two things live here: Tailwind colors and
raw pixel values.

> **Spacing, radius, and typography are NOT primitives** — they live in the `Breakpoints`
> collection and alias the `px/*` values defined here.

## Contents
1. Sourcing rule
2. Color ramps (`tailwind colors/*`)
3. Brand ramp generation
4. Raw pixel scale (`px/*`)
5. Scoping (important)

---

## 1. Sourcing rule — get exact values, don't approximate
Tailwind v4 ships its palette in **oklch**; Figma variables store sRGB/hex. Use **exact** hex
equivalents. Source priority:
1. If a repo with Tailwind v4 is open — derive from the project's compiled output / `@theme`.
2. Otherwise — use Tailwind v4's official palette (`tailwindcss.com/docs/colors`) and convert oklch→hex precisely.

Confirm the project's Tailwind **minor** version (v4.x has added palettes over time).

## 2. Color ramps — `tailwind colors/*`
Create a ramp per Tailwind family, named exactly:
```
tailwind colors/{family}/{step}
```
- **Families:** `slate, gray, zinc, neutral, stone, red, orange, amber, yellow, lime, green,
  emerald, teal, cyan, sky, blue, indigo, violet, purple, fuchsia, pink, rose` (+ any new v4.x palettes).
- **Steps:** `50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`.
- Always include the neutral families; include the accent families the project actually uses. Add more on request.
- (`white = #FFFFFF`, `black = #000000` as needed.)

## 3. Brand ramp generation (no brand guide, or brand isn't a Tailwind color)
Generate a Tailwind-structured ramp so it slots into the same system:
```
brand/{50…950}     (and brand-secondary/… if a secondary exists)
```
Method:
1. Treat the brand hex as the **500** step (or the step matching its lightness).
2. Build 50→950 in oklch/LCH, hue roughly constant, stepping lightness like Tailwind's ramp; ease chroma at the extremes.
3. Identical step count + naming to Tailwind families.
4. Show the ramp for approval before writing.

If there's no brand color at all, propose one (with rationale) and get approval first.

## 4. Raw pixel scale — `px/*`
The single source of truth for every dimensional token (spacing, radius, font-size) in the
Breakpoints collection. Name each by its literal pixel value:
```
px/0=0, px/1=1, px/2=2, px/4=4, px/6=6, px/8=8, px/10=10, px/12=12, px/14=14, px/16=16,
px/20=20, px/24=24, px/28=28, px/32=32, px/40=40, px/48=48, px/56=56, px/64=64, px/80=80,
px/96=96, px/112=112, px/128=128 …
```
Extend to cover the project's spacing, radius, type-size, and breakpoint needs (e.g. add
`px/640`, `px/768`, `px/1024`, `px/1280`, `px/1536` for web breakpoints).

## 5. Scoping — primitives are plumbing, never picked directly
After creating each Primitive variable, **untick all scopes** (set scope to none). This hides
primitives from the designer's fill / number / radius pickers in the canvas, so designers only
ever apply tokens from `Colors` and `Breakpoints`. Scoping does **not** affect aliasing —
Colors and Breakpoints can still reference these primitives normally.

---

## Output of this phase
A single `Primitives` collection (no modes) containing the `tailwind colors/*` ramps, any
`brand/*` ramp, and the `px/*` raw scale — all unscoped. Nothing here is swatched in the Style
Guide.