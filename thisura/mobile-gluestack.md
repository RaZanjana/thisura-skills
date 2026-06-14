# Mobile semantics — Gluestack theming

Used when **platform = mobile**. Build the `Semantics` collection to **mirror Gluestack UI v2's
token system exactly**, so each Figma variable name equals the NativeWind class root the devs
type (`bg-background-0`, `text-typography-900`, `border-outline-200`). No normalization to
role names — the 1:1 match is the whole point of the hand-off.

Source exact values from the project's `gluestack-ui-provider/config.ts` (the `light` / `dark`
`vars()` blocks) if a repo is open — that's what ships. Otherwise use Gluestack v2 defaults and
convert to hex.

## Contents
1. Color scales (Light + Dark)
2. Radius (NativeWind / Tailwind)
3. Typography (local text styles)
4. Extended group
5. Mapping rule

---

## 1. Color scales

Gluestack colors are **numeric scales per role**, mode-swapped via the provider's light/dark
`vars()`. Create each as a semantic variable group aliasing the Primitive color ramps. Light
mode always; Dark mode as a second mode only if in scope.

Scales (each with steps `0, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`):

```
primary/0…950          secondary/0…950        tertiary/0…950
background/0…950        typography/0…950        outline/0…950
error/0…950            success/0…950          warning/0…950          info/0…950
indicator/primary  indicator/info  indicator/error   (single-value indicators)
```

Naming: `primary/500`, `background/0`, `typography/900`, `outline/200`, etc. — matching the
`--color-{role}-{step}` variables and their `{role}-{step}` utility roots.

**Binding to primitives:** alias each step to the nearest Tailwind primitive (or the brand ramp
for `primary`). Typical neutral mapping: `background/0 → white`, `background/950 → near-black`,
`typography/900 → neutral/900`, `typography/0 → white`, `outline/200 → neutral/200`. State roles
map to their hues: `error → red`, `success → green`, `warning → amber`, `info → blue`. For Dark
mode, re-point the same semantic steps to the inverted primitives per the provider's dark block
(Gluestack commonly flips the scale so `background-0` darkens, `typography` lightens).

Keep Gluestack's convention that the scale itself is semantic (step 0 = lightest surface / step
950 = darkest), rather than adding separate role-name tokens.

## 2. Radius — NativeWind / Tailwind scale

Gluestack styles via NativeWind, so radius follows the **Tailwind radius scale** (not shadcn's
`--radius` model). Create radius tokens aliasing `px/*` primitives:

```
radius/none = 0
radius/xs   = 2px
radius/sm   = 4px
radius/md   = 6px
radius/lg   = 8px
radius/xl   = 12px
radius/2xl  = 16px
radius/3xl  = 24px
radius/full = 9999px
```
(Confirm exact values against the project's Tailwind/NativeWind version; add `px/*` primitives
for any value not already present, e.g. `px/2`, `px/6`.)

## 3. Typography — local text styles

Mirror Gluestack's `Text` / `Heading` **size scale** as local text styles, bound to the type
primitives:

- Sizes: `2xs, xs, sm, md, lg, xl, 2xl, 3xl, 4xl, 5xl, 6xl` (Gluestack's `size` prop values).
- Name styles to match usage, e.g. `Heading/2xl`, `Heading/xl`, `Text/md`, `Text/sm`,
  `Text/2xs`, plus weight variants the kit uses.
- Bind `font-size`, `line-height`, `weight`, and the font family variable from Primitives.
- Map Gluestack's `fontSize` / `lineHeight` / `fontWeight` tokens to the type primitives so the
  scale has one source of truth.

## 4. Extended group

Create `semantic/extended/` as a labelled, **empty** placeholder for project-specific additions
(custom roles, extra brand scales, semantic aliases). Don't pre-fill — just establish the group.

## 5. Mapping rule (validation)

Every Gluestack scale step → a Primitive alias. Light and (optional) Dark resolve with no unbound
references. Names spelled exactly as Gluestack's `{role}-{step}`, so dev inspect shows the real
NativeWind token root.
