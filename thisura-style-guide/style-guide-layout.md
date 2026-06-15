# Style Guide — layout construction (shared, Phase 5)

The Style Guide page MUST be built with **Figma auto-layout and hug/fill sizing throughout**.
Do **NOT** absolute-position elements with guessed `x/y` and fixed `width/height` — that is what
crops frames and leaves huge gaps. Every container either **hugs its contents** or **fills its
parent**. Never leave a frame at Figma's default 100×100.

## Why (the failure this prevents)
Hand-positioned frames get left at default width (100px) while their content is ~1200px → the
section clips to a sliver. Fixed-height rows clip tall display type. Rows spaced by guessed
offsets leave dead space. Auto-layout + hug eliminates all three by definition.

## Page shell
- Page frame `🎨 Style Guide`: **vertical auto-layout**; width fixed **1280** (1200 content + 40 padding each side); padding **64**; item spacing **64**; fill = neutral-50/canvas; **Clip content OFF**.
- Title block (top): vertical auto-layout, hug — H1 title + caption line.
- Each **Section**: vertical auto-layout, **width = Fill container**, item spacing **24** — a header label (overline) then the section body. Hug height. Clip content OFF.

## Colour card grid
- Grid: **horizontal auto-layout with WRAP**, width Fill, horizontal + vertical gap **16**, align start.
- Card: **vertical auto-layout, hug**, fixed width **200**, gap **8**.
  - Swatch chip: width Fill (≈200) × height **88**, corner radius `radius/md`, **1px border** (`Theme/border`) so white/light chips stay visible on a light page.
  - Token-name text: width **Fill**, single line, **do not fix-width-clip**; if a token can exceed 200, raise card width or let the text wrap (height auto).
  - Value + alias: smaller, `muted-foreground`.
- Place pairs (`primary` / `primary-foreground`) adjacent.
- **Dark mode:** split the chip into a 2-cell horizontal auto-layout (left = Light value, right = Dark value), each labelled `L`/`D`.

## Brand ramps (documented even though they're Primitives)
- Per brand colour: a vertical auto-layout (hug) — ramp label, then the ramp.
- Ramp: **horizontal auto-layout, hug**, gap 0; each step = vertical auto-layout (hug): a **96×56** chip + step number + resolved hex below. Because the ramp hugs, it never clips.

## Alpha & opacity
- Behind the swatches, a **checkerboard** fill (tile pattern or image) so transparency reads.
- Alpha colours: horizontal auto-layout (wrap), each swatch **140×64** + label below.
- Opacity scale: horizontal auto-layout, the base colour at each `opacity/*` step + label below.

## Typography specimens
- Each row: **horizontal auto-layout, width Fill, HUG HEIGHT** (never a fixed height — display
  type is 60–72px tall and will clip otherwise), vertical-align center, distribution
  space-between: left = the sample text set in that **text style** (hug), right = the style name
  (`muted-foreground`, hug). Row gap **8–12**.

## Tables (type / spacing / radius per breakpoint)
- Build as a vertical auto-layout of **row frames**; each row = **horizontal auto-layout, hug
  height (~28px)**, with fixed-width cells (token ≈180, each value ≈80) and a **bold header row**.
  Row gap 0–4 — **never 100**.
- **Spacing table:** add a visual cell — a rectangle whose **width = the spacing value** (in the
  reference mode), so the scale reads at a glance.
- **Radius table:** add a visual cell — a small square with that **corner radius** applied.

## Shadow specimens
- Each: a **surface box ≈160×96** (`Theme/card` fill, radius `lg`) with the **effect style
  applied**, label below. Horizontal auto-layout with WRAP, gap **≥32** so shadows don't clip
  neighbours; Clip content OFF. (Don't render only labels — include the actual shadowed box.)

## Sizing checklist — must all pass before finishing
- [ ] Page, every section, every grid/row/table uses **auto-layout**.
- [ ] **No frame left at the default 100×100**; every container hugs or fills.
- [ ] Typography rows **hug height** (no clipped display type).
- [ ] Table rows are compact (hug height), **not** 100px-spaced; spacing/radius have **visual specimens**.
- [ ] Shadow specimens include the **actual shadowed box**, not just a label.
- [ ] Card/label text is never fix-width-clipped (hug or wrap; card wide enough).
- [ ] **Clip content OFF** on sections; light chips carry a border.

## Update mode
When refreshing, rebuild the page with these exact rules so structure/layout stay identical —
only values change. Don't patch the old absolute-positioned page; regenerate it cleanly.
