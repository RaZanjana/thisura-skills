# Style Guide — layout construction (shared, Foundations step)

The Style Guide page MUST be built with **Figma auto-layout and hug/fill sizing throughout**.
Do **NOT** absolute-position elements with guessed `x/y` and fixed `width/height` — that is what
crops frames and leaves huge gaps. Every container either **hugs its contents** or **fills its
parent**. Never leave a frame at Figma's default 100×100.

## Why (the failure this prevents)
Hand-positioned frames get left at default width (100px) while their content is ~1200px → the
section clips to a sliver. Fixed-height rows clip tall display type. Rows spaced by guessed
offsets leave dead space. Auto-layout + hug eliminates all three by definition.

## ⚠️ #1 recurring bug — height collapse (READ THIS)
The most common failure here is a container left at a **fixed tiny height (~10px)** while its
children are much taller — the children then overflow downward and **overlap the next section**.
It keeps happening to cards, grids, and cells.

Hard rules to prevent it:
- **Every** container's **vertical sizing = HUG CONTENTS**. Never type a fixed height, never leave
  a frame at ~10px. Width may be fixed/fill; **height is hug** unless a swatch/box that is meant to
  be a fixed size.
- Children must be **real auto-layout children that flow** (stacked by the layout), **not**
  absolutely placed at `y=96, y=125, …`. If you find yourself setting child `y` offsets, the parent
  isn't a proper auto-layout — fix the parent, don't position children.
- **Verify after building each block:** its height must ≈ the sum of its children (e.g. a colour
  card ≈ **169px**, not 10). If any frame is ~10px tall with taller content inside, it collapsed —
  set it to hug and rebuild it.

## Page shell
- Page frame `🎨 Style Guide`: **vertical auto-layout**; width fixed **1280** (1200 content + 40 padding each side); padding **64**; item spacing **64**; fill = neutral-50/canvas; **Clip content OFF**.
- Title block (top): vertical auto-layout, hug — H1 title + caption line.
- Each **Section**: vertical auto-layout, **width = Fill container**, item spacing **24** — a header label (overline) then the section body. Hug height. Clip content OFF.

## Colour card grid
- Grid: **horizontal auto-layout with WRAP**, width Fill, **height HUG**, horizontal + vertical gap **16**, align start. (With wrapping, the grid height must hug to all rows — never a fixed small height.)
- Card: **vertical auto-layout**, fixed width **200**, **height HUG**, gap **8**. The swatch, name,
  value and alias are **flow children** of this auto-layout (do not place them at fixed `y`). A
  correct card is **≈169px tall**; if it renders ~10px, its height was wrongly fixed — set to hug.
  - Swatch chip: width Fill (≈200) × height **88** (fixed, intentional), corner radius `radius/md`, **1px border** (`Theme/border`) so white/light chips stay visible on a light page.
  - Token-name text: width **Fill**, single line, **do not fix-width-clip**; if a token can exceed 200, raise card width or let the text wrap (height auto).
  - Value + alias: smaller, `muted-foreground`.
- Place pairs (`primary` / `primary-foreground`) adjacent.
- **Dark mode:** split the chip into a 2-cell horizontal auto-layout (left = Light value, right = Dark value), each labelled `L`/`D`.

## Brand ramps (documented even though they're Primitives)
- Per brand colour: a vertical auto-layout (hug) — ramp label, then the ramp.
- Ramp: **horizontal auto-layout, hug**, gap 0; each step = vertical auto-layout (hug): a **96×56** chip + step number + resolved hex below. Because the ramp hugs, it never clips.

## Alpha & opacity
- **Each swatch cell = vertical auto-layout, HUG HEIGHT**: the swatch box (fixed, e.g. **140×64**)
  on top, the label below, gap **8**. Do **not** give the cell or its row a fixed short height —
  if you do, the label overflows and overlaps the next block (this is a real bug to avoid). The
  cell must hug so its full height (≈90px) is reserved.
- Alpha row: horizontal auto-layout with WRAP, **hug height**, gap 16. Each swatch box sits on a
  **checkerboard** fill so transparency reads.
- Opacity scale: same pattern — horizontal auto-layout, each cell vertical-hug (box + label), the
  base colour at each `opacity/*` step. Put a clear gap (≥24) between the alpha row and the
  opacity row so they never collide.

## Typography specimens
- Each row: **horizontal auto-layout, width Fill, HUG HEIGHT** (never a fixed height — display
  type is 60–72px tall and will clip otherwise), vertical-align center, distribution
  **space-between**: the sample text set in that **text style** on the **LEFT**, the style-name
  label (`muted-foreground`) on the **far right**. Row gap **8–12**.
- **Left-align the sample text** — text-align LEFT, hug width, starting at the row's left edge
  (x=0). Do **NOT** centre it. (The earlier build centred the sample at x≈197 — wrong.)

## Tables (type / spacing / radius per breakpoint) — FIXED COLUMN GRID
Tabular data must line up. The failure to avoid: letting value cells **hug** (so each row's
columns start at a different x) or **centring** content (so nothing aligns). Rules:
- Define the columns **once** and reuse the **identical widths** for the header row and every data
  row: **Token col fixed ≈200**, then one **fixed-width column per breakpoint (≈110 each)**. Cells
  are **fixed width — not hug**, so columns align vertically down the whole table.
- **Left-align** every cell's text at the same inset. The **header labels sit in the same fixed
  columns** as the data (so "Tablet" is directly above the Tablet values). Bold header row.
- Table = vertical auto-layout of rows; each row = horizontal auto-layout, **hug height (~28–32px)**,
  gap 0–4. **Never** 100px row spacing.
- **Spacing table:** inside each fixed-width value cell, put the number **then** a bar (rectangle,
  height ~10) whose width = the value, **capped to the cell width**. The bar lives inside the fixed
  cell, so it never shifts the columns. (Don't size the cell to the bar.)
- **Radius table:** inside each fixed-width value cell, a **fixed small box (e.g. 28×28)** with that
  **corner radius** applied + the number. Same box size every row so columns stay aligned.

## Shadow specimens
- Each: a **surface box ≈160×96** (`Theme/card` fill, radius `lg`) with the **effect style
  applied**, label below. Horizontal auto-layout with WRAP, gap **≥32** so shadows don't clip
  neighbours; Clip content OFF. (Don't render only labels — include the actual shadowed box.)

## Sizing checklist — must all pass before finishing
- [ ] Page, every section, every grid/row/table uses **auto-layout**.
- [ ] **No frame collapsed to ~10px**: every card/grid/cell **height ≈ its content** (colour card ≈169, grid hugs all rows). Children flow via auto-layout, never placed at fixed `y`.
- [ ] **No frame left at the default 100×100**; every container hugs or fills.
- [ ] No section overlaps the next (a collapsed card/grid is the usual cause).
- [ ] Typography rows **hug height** (no clipped display type) and the sample text is **left-aligned**, not centred.
- [ ] **Alpha & opacity cells hug height** (swatch + label below) — labels never overlap the next block.
- [ ] Tables use a **fixed shared column grid**: header columns sit directly above their data columns; value cells are fixed-width (not hug); text left-aligned. Spacing bars/radius boxes live **inside** the fixed cells.
- [ ] Table rows are compact (~28–32px), **not** 100px-spaced; spacing/radius show **visual specimens**.
- [ ] Shadow specimens include the **actual shadowed box**, not just a label.
- [ ] Card/label text is never fix-width-clipped (hug or wrap; card wide enough).
- [ ] **Clip content OFF** on sections; light chips carry a border.

## Update / refresh mode
When refreshing, rebuild the page with these exact rules so structure/layout stay identical —
only values change. Don't patch the old absolute-positioned page; regenerate it cleanly.
