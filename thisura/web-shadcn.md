# Web semantics — shadcn theming

Used when **platform = web**. Build the `Semantics` collection from shadcn's token set. Every
token **aliases a Primitive** (or, for the few shadcn provides directly, a primitive you add).
shadcn defaults are oklch — convert to hex precisely, or source from the project's `globals.css`
if a repo is open (preferred, so Figma matches the shipped theme).

## Contents
1. Color tokens (Light + Dark)
2. Radius (`--radius` model)
3. Typography (local text styles)
4. Extended group
5. Mapping rule

---

## 1. Color tokens

Create these semantic color variables. Each has a **Light** value and, if dark mode is in scope,
a **Dark** value (second mode on this collection only). Names match shadcn exactly so the Figma
variable equals the dev's utility root (`bg-background`, `text-muted-foreground`, …):

```
background            foreground
card                  card-foreground
popover               popover-foreground
primary               primary-foreground
secondary             secondary-foreground
muted                 muted-foreground
accent                accent-foreground
destructive
border                input                ring
chart-1  chart-2  chart-3  chart-4  chart-5
sidebar               sidebar-foreground
sidebar-primary       sidebar-primary-foreground
sidebar-accent        sidebar-accent-foreground
sidebar-border        sidebar-ring
```

shadcn's documented default values (neutral base) for reference — verify against the project's
Tailwind/shadcn version and convert oklch→hex exactly:

```
--radius: 0.625rem (10px)
Light: --background oklch(1 0 0); --foreground oklch(0.145 0 0);
       --primary oklch(0.205 0 0); --primary-foreground oklch(0.985 0 0);
       --muted oklch(0.97 0 0); --muted-foreground oklch(0.556 0 0);
       --border/--input oklch(0.922 0 0); --ring oklch(0.708 0 0);
       --destructive oklch(0.577 0.245 27.325); … (full set in shadcn theming docs)
Dark:  re-pointed values per shadcn's .dark block.
```

**Binding to primitives:** point each shadcn token at the nearest primitive. With the neutral
base, `background → white`, `foreground → near-black neutral`, `muted → neutral/100`,
`muted-foreground → neutral/500`, `border/input → neutral/200`, etc. With a **brand** primary,
`primary → color/brand/500` (or the step matching shadcn's primary lightness),
`primary-foreground → near-white`. Keep `destructive` mapped to the red family. The goal: no raw
hex sits in Semantics — every token resolves through Primitives.

`warning` / `warning-foreground` aren't in shadcn's default set; if the project needs them, add
them under the **extended** group (§4), not inline, unless the user asks to treat them as core.

## 2. Radius — shadcn `--radius` model

shadcn derives a small radius scale from one base. Figma has no calc, so **precompute** the
derived px and alias them to `px/*` primitives (create the px primitives as needed):

```
radius/base = 10px        (--radius 0.625rem)
radius/sm  = base × 0.6 = 6px
radius/md  = base × 0.8 = 8px
radius/lg  = base × 1.0 = 10px
radius/xl  = base × 1.4 = 14px
radius/2xl = base × 1.8 = 18px
radius/3xl = base × 2.2 = 22px
radius/4xl = base × 2.6 = 26px
```
If the brand uses a different base radius, set `radius/base` and recompute the scale with the
same multipliers, then re-alias.

## 3. Typography — local text styles

shadcn leans on Tailwind's type utilities + `--font-sans`/`--font-mono`; it doesn't ship a named
type scale. So build **local text styles** on the **Tailwind type scale**, bound to the type
primitives:

- Style names by role and size, e.g. `Display/2xl`, `Heading/xl`, `Heading/lg`, `Body/base`,
  `Body/sm`, `Label/sm`, `Caption/xs`, `Code/sm` (mono).
- Each binds `font-size`, `line-height`, `weight`, and `font/sans` (or `font/mono` for code)
  from Primitives.
- Use Tailwind's size/line-height defaults unless the brand guide specifies otherwise.

## 4. Extended group

Create `semantic/extended/` as a labelled, **empty** placeholder for project-specific tokens the
designer adds later (e.g. `warning`, `success`, marketing accents, custom surfaces). Don't
pre-fill it — just establish the group so additions have a home and stay out of the core set.

## 5. Mapping rule (validation)

Every shadcn token → a Primitive alias. Light and (optional) Dark both resolve. No orphan hex in
Semantics. Names spelled exactly as shadcn's, so dev inspect shows the real utility token.
