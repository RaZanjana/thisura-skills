# Flowboard layout — placement, flowchart symbols, arrows & annotations

How each journey is laid out on the canvas, mapped with flowchart symbols, and annotated. Read
before drawing. The two non-negotiables: **journeys never overlap**, and **symbols + arrows look
identical across every journey**.

## Page & Section structure
- One page, default name `📐 Lo-Fi Wireframes`.
- **`🗂 Screen Index`** frame at the top of the page — the readable registry (screens, elements,
  owning journey, status), built in Phase 1 and the approval artifact. See `screen-registry.md`.
- **`🧩 Master Screens`** reference Section — one canonical master per screen, outside the journey
  flow. Journey snapshots are derived from these; not connected by flow arrows.
- **One Figma Section per journey**, named **exactly after the journey** (file order, top to
  bottom). The Section contains that journey's **snapshots** (derived from the masters), flowchart
  symbols, arrows and annotations.
- Optional **legend block**: the flowchart symbol key + greyscale/font conventions + the
  placeholder convention, so reviewers read the board correctly.

Layout order down the page: `🗂 Screen Index` → `🧩 Master Screens` → journey Sections.

## No-overlap, no-crop placement (critical)
Sections are placed by **measurement, not guesswork**. The `🗂 Screen Index` and `🧩 Master
Screens` areas sit above the first journey Section and are measured the same way so journeys start
clear of them:
1. Before creating a new Section, call `Figma:get_metadata` on the page (or the last Section /
   reference area) to get the `x/y/width/height` of what's already built.
2. Place the new Section **below the previous one with a fixed gutter of ≥ 240px** (stack journeys
   vertically). Give each Section generous internal padding (≥ 80px) so nothing sits on the edge.
3. **Size the Section to its content** — after drawing, verify the Section's height/width covers all
   its screens + arrows with margin; if a screen or arrow falls outside, the Section is cropping —
   grow it. Never leave a Section at a default size while content overflows.
4. Within a Section, lay the journey's **snapshots** (derived from the masters) **left to right in
   flow order**, in a consistent row (or rows), with a **fixed horizontal gap of ≥ 200px** between
   screens so arrows and labels have room. State variants sit just **below** their happy screen. No
   two screens overlap; nothing is clipped.

## Flowchart symbols (consistent greyscale, fixed style)
Use proper flowchart symbols so the map reads as a flow, not just frames with lines. All symbols:
fill white, 1.5px `#333333` stroke, Inter labels in `#333333`.
- **Terminator (Start / End)** — rounded pill (radius `full`), ~120×48, label "Start" / "End".
  Each journey begins with a Start terminator into its first screen and ends with End terminator(s).
- **Screen node** — the **lo-fi screen frame itself** acts as the process node; don't redraw a
  rectangle around it.
- **Decision** — a **diamond**: a square **rotated 45°** (or a 4-point polygon), ~140×100 bounding
  box, with the condition inside (e.g. "Logged in?"). **Do not use a default `regular-polygon`** —
  that renders as a triangle/pentagon, not a diamond. Outgoing arrows are labeled with the outcomes
  (e.g. "Yes" / "No", "Has items" / "Empty").
- **Connector / off-page** — small circle ~40×40 with a letter (A, B…) to join screens that are far
  apart or continue on another row, instead of a long crossing arrow.
- **Annotation marker** — see Dev Mode annotations below (not a drawn box by default).

## Arrows (one style everywhere)
- Stroke **2px `#333333`**, solid, with a filled triangular arrowhead at the destination.
- Route as straight or right-angle (elbow) lines from the **edge** of the source (screen edge,
  diamond corner) to the destination edge. Keep direction consistent (generally left→right,
  top→bottom).
- **Label every arrow** with the trigger, in Inter 400 11–12px on a small white pad so it stays
  readable over other elements: e.g. `Tap "Continue"`, `Submit`, `Back`, `Yes` / `No`.
- Wire the real paths from the journey: forward actions, **back/cancel/skip** paths, and branch
  outcomes from diamonds. Reach error/empty states with a clearly labeled arrow (e.g.
  `Invalid input →` to the error state) so state coverage is demonstrable.
- Because a Figma **design file has no auto-routing connectors**, arrows are drawn lines that **do
  not re-flow if a frame moves** — so finalize screen placement first, draw arrows last, and if a
  screen is repositioned during review, redraw its arrows.
- **No arrow may cross a screen, card, or symbol frame.** Route connectors through the **reserved
  gutters** — the ≥200px column gaps between screens and the ≥176px row gaps between rows. For a
  branch or return that would otherwise cut across frames, drop the line into the gutter band and
  run it there (as the UJ-1 Degraded branch lines do at the inter-row gutter), or use an **off-page
  connector** circle to jump instead of drawing a long crossing line. Routing a horizontal line at a
  card's vertical mid (through the card body) is the failure to avoid.

## Dev Mode annotations
Attach **native Dev Mode annotations** (`node.annotations`) to the relevant screen or element —
structured, not freeform. Use these categories as a prefix so hand-off notes stay scannable:
- **Navigation** — where this goes / comes from, back behaviour, deep-link entry.
- **State** — which state this is and what triggers it (empty/error/loading/permission/offline).
- **Content** — what real content replaces the greeked placeholder here.
- **Interaction** — gestures, validation rules, disabled conditions, edge behaviour.
Keep each note short and specific (e.g. *Navigation — "Continue" → OTP Verify; back returns to
Sign Up*). If the MCP can't author native annotations, fall back to small drawn callout notes
(numbered pin + text in Inter, `#333333` on `#F5F5F5`) placed beside the screen, and say so.

## Layout / mapping checklist (run per journey)
- [ ] Section named after the journey; placed below the previous with ≥240px gutter; **no overlap**
      with any other Section.
- [ ] Section sized to fully contain its screens + arrows + labels; **nothing cropped**.
- [ ] Screens in flow order, ≥200px gaps; state variants below their happy screen.
- [ ] Start terminator → first screen; End terminator(s) on terminal screens.
- [ ] Decision diamonds at every documented branch (rotated-square diamonds, **not**
      regular-polygons); outgoing arrows labeled with outcomes.
- [ ] Arrows uniform (2px `#333333`, arrowhead), each **labeled with its trigger**; back/cancel/skip
      and error/empty paths wired.
- [ ] **No arrow crosses a screen/card/symbol frame** — connectors run in the gutters or use
      off-page connectors.
- [ ] Symbol + arrow style **identical to prior journeys**.
- [ ] Dev Mode annotations attached, categorized, resolving to real nodes.