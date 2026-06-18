# Lo-fi elements — fidelity, fonts, element specs & naming

Because screens are drawn **ad-hoc** (no component library), consistency has to come from **fixed
specs**: the same element gets the same size, radius, fill and type everywhere. Treat the tables
below as the source of truth so journey 6 looks identical to journey 1.

## Fidelity — strict low-fidelity, greyscale
This is for **requirements verification**, not visual design. No brand colour, no hi-fi polish.
- Palette only: **white** `#FFFFFF` (canvas/surface), **light grey** `#F5F5F5` (fills/placeholders),
  **mid grey** `#CCCCCC` (borders/dividers), **dark grey** `#333333` (text/icons). Muted text
  `#777777` for secondary.
- **No** shadows, gradients, or decorative elements. No real photos/illustrations — use a grey
  rectangle with a centered "Image" label and a diagonal cross, or a circle for avatars.
- Icons: simple monochrome outline, drawn as basic shapes. Don't design custom iconography.
- Keep structure, hierarchy and flow legible — that's the whole point.
- **Not-yet-revealed elements** (a slot a later journey will fill) are drawn as **reserved
  placeholders**, not omitted — see the placeholder convention in `screen-registry.md`. This keeps
  a screen's layout identical across journeys until the owning journey reveals the element.

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

## Layout & device frames
- **Mobile:** 375×812 portrait. Status bar top, native nav (back chevron + centered title), bottom
  tab bar where the journey uses one, safe areas respected.
- **Desktop:** 1440×1024. Top nav, content region, footer where relevant.
- Build each screen with **auto-layout** internally (vertical stack, hug height) so content isn't
  clipped — never absolute-position children at guessed `y` offsets. A screen frame is fixed to its
  device width/height; its inner content stack hugs.

## Frame naming
- **Section** = the **journey name**, verbatim from the User Journey file.
- **Screen frame** = `{Screen} — {state}` (journey is implied by the Section). Examples:
  `Sign Up — empty`, `Sign Up — error`, `Dashboard — populated`. For cross-surface journeys, suffix
  the surface when ambiguous: `Approval — populated (desktop)`.
- Keep the **happy/populated** state as the first frame in flow order; place state variants
  (empty/error/etc.) adjacent to their happy screen.

## Consistency checklist (before mapping a journey)
- [ ] Every button/input/nav/tab/card matches the spec table — same height, radius, fill, type.
- [ ] Meaningful copy is **Inter**; all filler is **Flow Circular** (or the noted fallback).
- [ ] Greyscale only — no stray colour, shadow, or gradient.
- [ ] Image placeholders use the standard grey-cross pattern, not real imagery.
- [ ] Each screen frame is the correct device size; inner content hugs (nothing clipped).
- [ ] Naming follows `{Screen} — {state}`; Section named after the journey.
