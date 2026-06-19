# Lo-fi components (Mode B) — fidelity, fonts, element specs & naming

**Mode B only.** This runs in a **Figma Design file** (`figma.com/design/...`), **after** a
journey's FigJam flow map (Mode A) is signed off. It produces polished lo-fi screens as
**components** that the designer then maps manually against the FigJam journeys — it does **not**
lay out a flow here.

Because the FigJam flow has already fixed *what* screens exist, *which* elements each has, and
*which* journey reveals each (the registry), Mode B is purely about rendering each registry screen
cleanly as a reusable component. Consistency comes from **fixed specs** + **real components**: the
same element gets the same size, radius, fill and type everywhere.

> Read `screen-registry.md` first — the screen IDs, element list, reveal map and states all come
> from the approved registry. Build only what the registry says; never invent screens or elements.

## What Mode B produces
- A **component per screen** (a Figma component / component set), built at exact device size, with
  the elements the registry lists for that screen.
- **State variants** (empty / loading / populated / error / …) as component-set variants where the
  registry calls for them.
- Components placed in a tidy library area (e.g. a `🧩 Components` page/section), **not** wired into
  a flow — the designer instances and maps them against the FigJam journeys.

## Fidelity — strict low-fidelity, greyscale
This is still **requirements-grade** lo-fi, not visual design. No brand colour, no hi-fi polish.
- Palette only: **white** `#FFFFFF` (canvas/surface), **light grey** `#F5F5F5` (fills/placeholders),
  **mid grey** `#CCCCCC` (borders/dividers), **dark grey** `#333333` (text/icons). Muted text
  `#777777` for secondary.
- **No** shadows, gradients, or decorative elements. No real photos/illustrations — use a grey
  rectangle with a centered "Image" label and a diagonal cross, or a circle for avatars.
- Icons: simple monochrome outline, drawn as basic shapes. Don't design custom iconography.
- Keep structure, hierarchy and flow legible — that's the whole point.
- **Not-yet-revealed elements** (a slot a later journey will fill) are drawn as **reserved
  placeholders**, not omitted — see the placeholder convention in `screen-registry.md`. This keeps
  a screen's layout identical across the journeys that instance it until the owning journey reveals
  the element.

## Fonts (specific, enforced)
- **Inter** — every piece of **meaningful** copy (titles, CTAs, nav labels, field labels, key
  content, error/empty messages). Weights: 600 for titles/headers, 500 for buttons/labels, 400 for
  body-meaningful.
- **Flow Circular** (Dan Ross) — **all placeholder / greeked text** (filler body, secondary
  descriptions, list filler). Its illegible flowing form makes "this is placeholder, not final
  copy" unmistakable, which is exactly what a lo-fi review needs.
- **Availability:** confirm both fonts are in the file before drawing. If **Flow Circular** is
  missing, tell the user and fall back to **Inter Italic at 60% opacity** for greeking (note the
  substitution). Inter is Figma-default and should always be present.

## Rounded, consistent elements
Buttons, cards, inputs, chips, modals and image placeholders are **rounded**. Use a single radius
scale and never mix arbitrary values:
- `radius/sm` **6px** — inputs, chips, small controls.
- `radius/md` **10px** — buttons, list rows, image placeholders.
- `radius/lg` **16px** — cards, sheets, modals.
- `radius/full` — avatars, pills, FABs.

## Element specs (use these exact values everywhere)
| Element | Spec |
|---|---|
| **Button (primary)** | height 44 (mobile) / 40 (desktop), radius `md`, fill `#333333`, label Inter 500 white, horizontal padding 20 |
| **Button (secondary)** | same size/radius, fill white, 1px `#CCCCCC` border, label Inter 500 `#333333` |
| **Input / field** | height 44/40, radius `sm`, fill white, 1px `#CCCCCC` border, label Inter 400 `#333333`, placeholder Flow Circular `#777777`, 12 padding |
| **Top nav (mobile)** | height 56, back chevron left, screen title Inter 600 centered, optional action right |
| **Bottom tab bar (mobile)** | height 64, 3–5 tabs, outline icon + Inter 400 11px label, active tab `#333333` / inactive `#777777` |
| **Top nav (desktop)** | height 64, logo placeholder left, nav links Inter 500 center/right, actions far right |
| **List row** | min height 56, radius `md` if carded, leading icon/avatar + Inter 500 title + Flow Circular subtitle + trailing chevron |
| **Card** | radius `lg`, fill white, 1px `#CCCCCC` border, 16 padding, vertical auto-layout |
| **Modal / sheet** | radius `lg` (top-only for bottom sheets), white, sits on a `#333333` 60% scrim, title Inter 600 + body + actions |
| **Image placeholder** | fill `#F5F5F5`, 1px `#CCCCCC`, radius `md`, centered "Image" label + diagonal cross |
| **Status bar (mobile)** | height 44, simple time/signal/battery glyphs in `#333333` |

## Text & auto-layout (the rule that prevents overlap — non-negotiable)
Overlap inside screens comes from fixed-height text boxes and absolutely-positioned children. Never
do either.
- **Every text node uses auto-height** (Figma "Auto height" / vertical `resize`), **never a fixed
  height.** A text box must grow with its content. A paragraph in a fixed 20px box overflows and
  collides with the row below it — this is the #1 layout bug, so treat fixed-height text as
  forbidden.
- **Every container is a vertical auto-layout frame** — screen content stacks, panels, cards, list
  rows, footer regions — with explicit **item spacing** (8–16px) and **padding** (12–16px). Children
  then **reflow** when text grows; they can't overlap. Set the container to **hug** height (or fixed
  device height for the screen frame, with the inner stack hugging).
- **Never absolute-position children at guessed `y` offsets.** If two siblings are 30px apart by
  hard-coded `y` but one holds multi-line text, they will overlap. Spacing comes from auto-layout,
  not coordinates.
- **Copy length:** meaningful copy is a **short label or one-line message** (≤ ~80 chars). Do not
  place explanatory paragraphs (error/empty descriptions, help text) as long real strings — trim to
  one representative line, or greek the remainder in Flow Circular. If a genuine multi-line message
  is required, it still must be an auto-height text node inside an auto-layout container.
- **Shared structural elements use fixed widths** from the spec table (buttons, banners, nav,
  badges) so the *same* element doesn't change size between instances as its text varies — only
  free-flowing body text auto-sizes. (A banner that's 271px in one screen and 332px in another is
  this bug.)

## Layout & device frames
- **Mobile:** 375×812 portrait. Status bar top, native nav (back chevron + centered title), bottom
  tab bar where the journey uses one, safe areas respected.
- **Desktop:** 1440×1024. Top nav, content region, footer where relevant.
- **Screen frames are authored at exact device size — this is a hard invariant.** A desktop screen
  frame is 1440×1024; a mobile one is 375×812. **Never resize a screen frame smaller than its
  device size, and never set a frame's box smaller than its content.** The content stack must fit
  *inside* the frame (e.g. desktop content ≤ ~1392×976 with 24px padding). The recurring catastrophe
  is a screen frame shrunk to a thumbnail (e.g. 605×430) while its content stays full-size
  (1392×976) — the content then overflows the frame. Don't.
- **Parent-contains-children invariant:** every frame's width/height must be **≥ its children's
  bounding box**. A child must never extend past its parent. **This applies to *every* frame**, not
  just screens — badges, callouts and legend blocks must each contain their text (auto-height;
  never a ~10px box with text spilling out).
- If a smaller representation is ever genuinely wanted, **rescale the whole frame including its
  children** (uniform scale), never resize the frame box alone.
- Build each screen with **auto-layout** internally (vertical stack, hug height) so content isn't
  clipped — never absolute-position children at guessed `y` offsets.

## Component & naming conventions
- **Component** = the screen, named `{Screen}` (matching the registry name); use a **component set**
  with a `State` property when the screen has multiple states (`empty` / `loading` / `populated` /
  `error` / …). Tag with `screenId` via `sharedPluginData` so it links back to the registry.
- **State variant** = `State={state}` — keep the **populated** variant first.
- Build elements that recur across screens (buttons, nav, inputs, cards) as their own **shared
  components** so the spec table is enforced by reuse, not redrawn each time.
- Place components in a dedicated library area, not inside a flow.

## Consistency checklist (before finishing a Mode B journey)
- [ ] Every button/input/nav/tab/card matches the spec table — same height, radius, fill, type.
- [ ] **Every text node is auto-height; every container is auto-layout with spacing + padding.**
- [ ] **No element overlaps a sibling** (verify no fixed-height text and no absolute `y` offsets).
- [ ] Meaningful copy is **Inter** and short (≤ ~80 chars); long prose trimmed or greeked in **Flow
      Circular** (or the noted fallback).
- [ ] Shared structural elements (buttons, banners, nav, badges) use **fixed widths** — same size
      across instances.
- [ ] Greyscale only — no stray colour, shadow, or gradient.
- [ ] Image placeholders use the standard grey-cross pattern, not real imagery.
- [ ] **Each screen frame equals its device size** (desktop 1440×1024 / mobile 375×812); content
      fits inside it; **no child's bounding box exceeds its parent frame**.
- [ ] Screens built as **components / component sets**, tagged with `screenId`; states as variants.
- [ ] Naming follows `{Screen}` + `State={state}`; matches the registry.
- [ ] Every screen + element + state traces to the approved registry — nothing invented in Mode B.
