# FigJam flow — board structure, screen boxes, symbols, connectors & stickies

How each journey is laid out on a **FigJam board**, mapped with flowchart shapes + native
connectors, and annotated with stickies. Read before drawing. The two non-negotiables:
**journeys never overlap**, and **boxes + connectors + symbols look identical across every
journey**.

> This is **Mode A** (the flow map). For the polished Figma Design components (Mode B), see
> `lofi-components.md`.

## Why this is simpler than a design canvas
FigJam connectors **attach to nodes and auto-route**, so they reflow when a box moves and you never
hand-draw orthogonal paths. Decisions and terminators are **real shapes**. That deletes the whole
class of "diagonal line / crossing arrow / redraw-after-move / floating diamond" failures. Keep the
map lo-fi and let the tool do the routing.

## Board & Section structure
- **One FigJam board** (`figma.com/board/...`). FigJam has a single implicit page — **never call
  `figma.createPage()`**; organize everything with Sections.
- **`🗂 Screen Index`** — a FigJam **table** at the top of the board: the readable registry
  (ID / screen / surface / elements+states / owning journey / status). Built in Phase 1, it's the
  approval artifact. See `screen-registry.md`.
- **`🧩 Master Screens`** reference Section — one canonical **master box** per screen, outside the
  journey flow. Journey snapshots are clones of these; not connected by flow connectors.
- **One FigJam Section per journey**, named **exactly after the journey** (file order, top to
  bottom). The Section contains that journey's **snapshot boxes** (cloned from masters), flowchart
  symbols, connectors and sticky annotations.
- Optional **legend block** (a text node + a few sample shapes): the symbol key + greyscale/sticky
  conventions + the placeholder convention, so reviewers read the board correctly.

Layout order down the board: `🗂 Screen Index` → `🧩 Master Screens` → journey Sections.

## Screen box (the lo-fi "screen")
A screen is a **`createShapeWithText`** node — **not** a polished frame. Keep it a whiteboard box
that's instantly understandable.
- **Shape:** `ROUNDED_RECTANGLE` (or `SQUARE`). Greyscale only — fill **white** `#FFFFFF`, stroke
  **gray** `#B3B3B3`, text **dark** `#1E1E1E` (use the `white` preset from
  `create-shape-with-text`). Reserve color for symbols + stickies, not screens.
- **Text content (all in `shape.text.characters`):** a **title line** = `{Screen} — {state}`,
  then a short **bulleted list of the key elements** on that screen (the meaningful ones — CTAs,
  nav, title, key fields, the empty/error message). Example:
  ```
  Workspace — idle
  • Top nav: LikiFin POC · Agent Workspace
  • Case panel: "Waiting for inbound call…"
  • Live transcript (empty)
  • SOP suggestions (empty)
  ```
- **Real copy only on meaningful elements** (CTA/nav/title/field labels/error+empty messages),
  short (≤ ~80 chars per line). Don't write paragraphs; summarize filler as a single bullet
  (e.g. "• Body copy (placeholder)"). No greeking font is needed in FigJam — a "(placeholder)"
  bullet is enough.
- **Size with `fitShapeToText`** (from `create-shape-with-text`) — never hardcode box size, or the
  text clips. Keep boxes a consistent base width across the board (e.g. ~280–340 wide) so the map
  reads evenly; let height grow to fit bullets.
- **Placeholder elements** (an element a later journey will reveal): show as a greyed bullet
  prefixed and tagged, e.g. `• (later) Checkout CTA — reveals in: Purchase`. See the placeholder
  convention in `screen-registry.md`. The box still lists the slot so the screen's content is
  stable across journeys.
- **State** lives in the title (`— idle`, `— empty`, `— error`, `— loading`) and in the bullets
  (what the state shows). One box per state that the journey needs.
- **Tag** each box via `sharedPluginData` (namespace `thisura`: `screenId`, `state`, `status`) so
  the registry can find it later; fall back to strict naming if plugin data is unavailable.

## Flowchart symbols (consistent FigJam shapes)
Use real FigJam shapes so the map reads as a flow. Apply the coordinated fill/stroke/text presets
from `create-shape-with-text` (always set all three).
- **Terminator (Start / End)** — `ROUNDED_RECTANGLE`, label "Start" / "End". `lightGreen` preset
  for Start, `lightRed` for End. Each journey begins with a **Start** placed just before its first
  box and connected into it; it ends with **End** placed just after the terminal box(es) and
  connected from them — never floating, never unconnected.
- **Screen node** — the **screen box** itself is the process node; don't wrap it in another shape.
- **Decision** — `shapeType = 'DIAMOND'`, condition in `text.characters` (e.g. "Caller
  identified?"), `lightYellow` preset, sized with `fitShapeToText`. Placed **inline at the fork**.
  Outgoing connectors are labeled with the outcomes ("Yes" / "No", "Has items" / "Empty").
- **Off-page / branch marker** — a FigJam **label** node (small lettered/numbered circle) to join
  boxes that are far apart instead of a long connector across the board.
- **Containment:** every shape is sized by `fitShapeToText`, so text never spills. Don't shrink a
  shape below its fitted size.

## Connectors (the no-crossing rules — read carefully)
FigJam auto-routes connectors, but a connector whose endpoints are **far apart or backward will
still run straight over any boxes between them**. Auto-routing is not a substitute for layout
discipline. These rules are what keep the map from turning back into spaghetti:

- Create with `figma.createConnector()`; attach **both endpoints to node IDs**.
- **Set explicit magnets by direction — do NOT default everything to `AUTO`.** `AUTO` lets FigJam
  pick endpoints that often cut across a neighbouring box. Instead:
  - **Forward spine edge (left→right):** start `magnet:'RIGHT'` → end `magnet:'LEFT'`.
  - **Down-branch edge (decision → branch box below):** start `magnet:'BOTTOM'` → end `magnet:'TOP'`.
  - **Box → its pill (below):** start `'BOTTOM'` → end `'TOP'`.
  Explicit magnets keep every edge a clean straight or single-elbow segment.
- `connectorLineType = 'ELBOWED'`, `connectorEndStrokeCap = 'ARROW_LINES'`,
  `connectorStartStrokeCap = 'NONE'`, `strokeWeight = 2`, stroke **black** `#1E1E1E`.
- **Label every connector** via `connector.text.characters` (set `connector.text.fontName` to a
  loaded font first — a new connector's font is invalid by default). NOT `connector.name`.
- **HARD RULE — one grid step.** A real connector may only join **adjacent** cells: the next cell
  right (spine) or the cell directly below (branch). **Never draw a connector that spans more than
  one column/row, and never draw a backward (right→left or bottom→up) connector.** Those are the
  exact edges that cross boxes.
- **Every non-adjacent merge, return, or loop becomes a pill, not a line** — see the next section.
  Examples that MUST be pills, never long lines: a degraded state rejoining the spine far ahead; a
  retry/re-search loop going backward; a "next turn" loop returning to an earlier step.

## Fork / rejoin / loop pills (the anti-spaghetti primitive)
A **pill** is a small labelled anchor (`ROUNDED_RECTANGLE` ~150×64, `lightGray` preset) that
stands in for a connector that would otherwise be long or backward. The linkage is carried by the
**label**, so no physical line crosses the board.
- **Rejoin pill** — closes a branch lane that continues forward to a distant node. Place it just
  **below** the branch box; connect `branchBox (BOTTOM) → pill (TOP)`. Label it with the
  destination, e.g. `→ Call ends · Case Note`, `→ Filler → TTS`.
- **Loop pill** — stands in for any backward edge (retry, re-search, next turn). Place it below the
  box; short `box → pill` connector. Label with the loop, e.g. `↻ Retry / copy text`,
  `↻ Re-search on next delta`, `↻ Next turn → Ingest audio`.
- **Fork pill** (optional) — opens a branch far from its decision; names the source + condition.
- Result: every real connector is short and local; every long/backward relationship is a labelled
  pill. This is the rule that actually removes the crossings — applying it is **not optional**.

## Placement, grid & no-overlap
- **Lay boxes on a simple left→right grid in flow order.** Consistent **column pitch** (box width +
  ~140px gutter, e.g. 460 for 320-wide boxes) and a generous **row gutter (≥ 240px)** between the
  spine row and the branch row so down-branches have clear space.
- **Spine row** = happy/primary path, left→right. **Branch row** = alternate/degraded state boxes,
  each placed **directly below the decision that triggers it** (same column). **Pill row** = rejoin/
  loop pills, directly below their branch box.
- **Before creating a new Section**, call `get_figjam` to read the `x/y/width/height` of what's
  already built. Place the new Section **below the previous one with a ≥160px gutter**.
- **Size each Section to contain its content** (compute max child extent + padding). No box overlaps
  another anywhere in the Section.
- **Boxes are modest (~300–340 wide)**, so a journey fits in a far tighter region than a 1440-frame
  layout. Don't blow rows out to thousands of pixels apart.

## Branching (spine + branch boxes + pills)
Decisions are where flow maps turn to spaghetti. Keep the layout disciplined:
1. **One straight spine for the happy / success path** — the primary outcome of each decision
   continues the spine left→right in one row.
2. **Decisions sit inline at the fork** on the spine; the diamond's `BOTTOM` magnet feeds the
   alternate outcome **straight down** to a branch box in the same column.
3. **Each alternate/degraded state is a box directly below its decision** (never a diagonal
   staircase, never ad-hoc offsets).
4. **A branch never draws a long line back to the spine.** If it continues forward, it ends in a
   **rejoin pill**; if it loops, it ends in a **loop pill** (see above). Fan-in merges (several
   states → one next step) are fine **only when the sources are adjacent** to the target; otherwise
   use rejoin pills.
5. **Verify after drawing:** screenshot and check that **no connector passes over a box**. If one
   does, the edge was too long/backward — replace it with a pill. This check is mandatory before
   the review stop.

## Annotations (stickies)
**Use FigJam stickies** (`createSticky`) for dev hand-off notes — one idea per sticky, placed near
the box/element it annotates. Color-code by category (use the sticky palette from `create-sticky`):
- **Navigation** (`Blue #A8DAFF`) — where this goes / comes from, back behaviour, deep-link entry.
- **State** (`Yellow #FFE299`) — which state this is and what triggers it
  (empty/error/loading/permission/offline).
- **Content** (`Green #B3EFBD`) — what real content replaces a placeholder here.
- **Interaction** (`Violet #D3BDFF`) — gestures, validation rules, disabled conditions, edge
  behaviour.
Keep each sticky short and specific (e.g. *Nav — "Continue" → OTP Verify; back → Sign Up*). Prefix
the category word so notes stay scannable. Default to square stickies; only go `isWideWidth` for
~100+ words. Position stickies after boxes are placed (read actual `sticky.height`; don't assume
240). Keep them in a tidy band near their row rather than scattered.

## Layout / mapping checklist (run per journey)
- [ ] Section named after the journey; placed below the previous with ≥160px gutter; **no overlap**
      with any other Section.
- [ ] Every **screen box** sized with `fitShapeToText` (no clipped text); greyscale `white` preset;
      title `{Screen} — {state}` + key-element bullets; placeholders shown as `(later) … reveals in: …`.
- [ ] Section sized to fully contain its boxes + symbols + stickies; **no two boxes overlap**.
- [ ] All boxes on the fixed grid; spine row + branch row with a **≥240px row gutter**; branch boxes
      **directly below their decision**.
- [ ] Start terminator connected into the first box; End terminator(s) connected from terminal
      box(es); none floating or unconnected.
- [ ] Decision **`DIAMOND`** shapes at every documented branch, condition centered, placed inline at
      the fork; outgoing connectors labeled with outcomes.
- [ ] Connectors use **explicit magnets** (spine `RIGHT→LEFT`; down-branch `BOTTOM→TOP`), `ELBOWED`,
      `ARROW_LINES` end cap, 2px black, **labeled** via `connector.text.characters`.
- [ ] **One-grid-step rule held** — every real connector joins adjacent cells only; **no connector
      spans >1 step and none runs backward**. Every long/backward merge, return, or loop is a
      **rejoin/loop pill**, not a line.
- [ ] **No connector passes over a box** (verified by screenshot). If one does, replace it with a
      pill.
- [ ] Stickies for annotations, color-coded by category, placed in a tidy lane (not scattered);
      `connector.text` and sticky fonts loaded before setting text.
- [ ] Each box/symbol tagged via `sharedPluginData` (`thisura`) or strict naming for the registry.
- [ ] Box + connector + symbol style **identical to prior journeys**.
