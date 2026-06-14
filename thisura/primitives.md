# Primitives (shared) — Tailwind v4

The `Primitives` collection is single-mode and holds **raw values only** — the one source of
truth that everything else aliases back to. Two groups: colors and dimensions (+ type values).

## Contents
1. Color ramps
2. Brand ramp generation (no brand guide)
3. Raw pixel scale + spacing aliases
4. Type primitives
5. Sourcing rule (read this first)

---

## 0. Sourcing rule — get exact values, don't approximate

Tailwind v4 ships its palette in **oklch**; Figma variables store sRGB/hex. Use **exact** hex
equivalents — never eyeballed approximations. Source priority:

1. **If a repo with Tailwind v4 is open** — derive values from the project's compiled Tailwind
   output (or its `@theme` / config). This guarantees the Figma tokens match what devs ship.
2. **Otherwise** — use Tailwind v4's official published palette (`tailwindcss.com/docs/colors`)
   and convert each oklch value to hex precisely.

Always confirm the project's Tailwind **minor** version, since v4.x has added palettes over time.

---

## 1. Color ramps

Create a ramp per Tailwind color **family**, each with the full step set, named exactly:

```
color/{family}/{step}
```

- **Families** (Tailwind v4): `slate, gray, zinc, neutral, stone, red, orange, amber, yellow,
  lime, green, emerald, teal, cyan, sky, blue, indigo, violet, purple, fuchsia, pink, rose`
  (plus any new v4.x palettes confirmed in the project's version).
- **Steps:** `50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`.
- Anchors that are always exact: `white = #FFFFFF`, `black = #000000`.

Include the full neutral families always (they feed text/border/surface semantics). Include the
accent families the project actually uses — at minimum the brand's nearest hue plus the families
the chosen theme references. Don't bloat the file with unused ramps; add more on request.

## 2. Brand ramp generation (client has NO brand guide, or brand color isn't a Tailwind color)

When a brand primary/secondary isn't a Tailwind color, generate a Tailwind-structured ramp so it
slots into the same system:

```
color/brand/{50…950}      (and color/brand-secondary/… if a secondary exists)
```

Method:
1. Treat the supplied brand hex as the **500** step (or the step that best matches its lightness).
2. Generate the 50→950 ramp in a perceptually uniform space (oklch/LCH), holding hue roughly
   constant and stepping lightness to mirror Tailwind's ramp shape; nudge chroma down at the
   extremes so 50 and 950 don't over-saturate.
3. Keep step count and naming identical to Tailwind families.
4. Show the proposed ramp to the user for approval before writing (per Step 0).

If there's no brand color at all, propose one (with a short rationale) and get approval first.

## 3. Raw pixel scale + spacing aliases

Primitives hold **raw pixel values**; spacing and radius and any dimensional semantic alias them.

Raw px primitives (Tailwind v4 spacing resolves from a 4px base — values are multiples of 4,
plus the half-steps Tailwind defines):

```
px/0=0, px/1=1, px/2=2, px/4=4, px/6=6, px/8=8, px/10=10, px/12=12, px/14=14,
px/16=16, px/20=20, px/24=24, px/28=28, px/32=32, px/40=40, px/48=48, px/56=56,
px/64=64, px/80=80, px/96=96, px/112=112, px/128=128 …
```
(Extend to cover the project's needs; keep names = the literal pixel value.)

**Spacing** uses Tailwind's standard numeric naming and aliases the raw px (no component tokens):

```
spacing/0   → px/0      (0)
spacing/0.5 → px/2      (2)
spacing/1   → px/4      (4)
spacing/1.5 → px/6      (6)
spacing/2   → px/8      (8)
spacing/2.5 → px/10     (10)
spacing/3   → px/12     (12)
spacing/4   → px/16     (16)
spacing/5   → px/20     (20)
spacing/6   → px/24     (24)
spacing/8   → px/32     (32)
spacing/10  → px/40     (40)
spacing/12  → px/48     (48)
spacing/16  → px/64     (64)
spacing/20  → px/80     (80)
spacing/24  → px/96     (96)
…
```
(Tailwind spacing token `n` = `n × 4px`. Add steps the project uses.)

**Radius** is platform-specific — see the platform reference file — but its values also alias the
raw px primitives (create any new px primitives the radius scale needs, e.g. `px/2`, `px/6`).

## 4. Type primitives

Hold raw type values that text styles bind to:

- **Font size** — Tailwind type scale: `font-size/xs=12, sm=14, base=16, lg=18, xl=20, 2xl=24,
  3xl=30, 4xl=36, 5xl=48, 6xl=60, 7xl=72, 8xl=96, 9xl=128` (px).
- **Line height** — Tailwind line-height tokens (`leading/none=1, tight=1.25, snug=1.375,
  normal=1.5, relaxed=1.625, loose=2`) and/or the paired size/line-height defaults.
- **Font weight** — `weight/thin=100 … black=900` as used.
- **Font family** — `font/sans`, `font/mono` (+ `font/serif` if the brand uses one). Set the
  actual family from the brand guide or the approved proposal.

Text styles themselves are local styles (Phase 3), not variables — but they bind to these
primitives so the type system has one source of truth.

---

## Output of this phase
A single `Primitives` collection containing: the needed `color/*` ramps (incl. any `brand`
ramp), the `px/*` raw scale with `spacing/*` aliases, and the type primitives. Nothing in here
is shown as a swatch in the Style Guide — primitives are plumbing.
