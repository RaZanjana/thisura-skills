# Mobile — Gluestack theming (Colors + Breakpoints)

Used when **platform = mobile**. Build the `Colors` and `Breakpoints` collections, mirroring
**Gluestack UI v2** so each Figma variable name equals the NativeWind class root devs type
(`bg-background-0`, `text-typography-900`). Every token aliases a Primitive. Source exact values
from the project's `gluestack-ui-provider/config.ts` (`light`/`dark` `vars()`) if a repo is open;
otherwise use Gluestack v2 defaults and convert to hex.

---

## Colors collection  (modes: Light [+ Dark if in scope])

Two groups: `Theme` and `Other`.

### Theme/  — Gluestack numeric scales
Mirror Gluestack's `{role}-{step}` scales exactly (no normalization). Each step aliases a
`tailwind colors/*` primitive (or `brand/*` for primary). Steps: `0, 50, 100, 200, 300, 400,
500, 600, 700, 800, 900, 950`.
```
Theme/primary/0…950     Theme/secondary/0…950     Theme/tertiary/0…950
Theme/background/0…950   Theme/typography/0…950     Theme/outline/0…950
Theme/error/0…950   Theme/success/0…950   Theme/warning/0…950   Theme/info/0…950
Theme/indicator/primary  Theme/indicator/info  Theme/indicator/error
```
Typical aliasing: `background/0 → white`, `background/950 → neutral/950`,
`typography/900 → neutral/900`, `typography/0 → white`, `outline/200 → neutral/200`,
`error → red/*`, `success → green/*`, `warning → amber/*`, `info → blue/*`. Dark mode re-points
per the provider's dark block (scale commonly inverts).

### Other/  — placeholder
Labelled, **empty** group for project-specific additions. Don't pre-fill.

---

## Breakpoints collection  (modes: Gluestack breakpoint tokens)

Mobile doesn't use Desktop/Tablet/Mobile — use Gluestack's breakpoint tokens as the modes:
**base, sm, md, lg, xl** (confirm exact px against the project's config). Create all modes with
**identical base values** to start; tune per project. Everything dimensional aliases `px/*`.

### breakpoint/  — token thresholds (constant across modes)
```
breakpoint/base = 0   breakpoint/sm   breakpoint/md   breakpoint/lg   breakpoint/xl
```
(Set exact px from the Gluestack/NativeWind config; alias the matching `px/*`.)

### spacing/  — Tailwind-named, alias px
Same Tailwind scale as web: `spacing/1 → px/4 … spacing/24 → px/96` (token `n` = `n × 4px`).

### radius/  — NativeWind / Tailwind scale, alias px (may differ per mode)
```
radius/none = 0   radius/xs = 2   radius/sm = 4   radius/md = 6   radius/lg = 8
radius/xl = 12    radius/2xl = 16  radius/3xl = 24  radius/full = 9999
```
(Confirm against the project's Tailwind/NativeWind version; add `px/*` as needed.)

### typography/  — sizes alias px; weight/family/line-height as values
Mirror Gluestack's `size` scale (`2xs … 6xl`):
```
typography/size/{2xs … 6xl} → alias px/*
typography/weight/{…}        (raw numbers, per Gluestack fontWeight tokens)
typography/font/{…}          (family strings)
typography/line-height/{…}
```

---

## Local styles (Phase 4)
- **Text styles** — named to Gluestack usage (`Heading/2xl`, `Text/md`, `Text/2xs`, …). **Bind**
  family/size/weight/line-height to the `typography/*` variables. No hardcoded values.
- **Effect styles** — shadow scale; bind shadow color to a `Colors` variable.

## Validation
Theme mirrors Gluestack `{role}-{step}` and aliases tailwind colors; Breakpoints tokens alias px;
Light/Dark + breakpoint modes resolve; text styles are variable-bound; names match Gluestack + Tailwind exactly.