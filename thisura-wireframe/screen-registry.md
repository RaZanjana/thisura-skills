# Screen registry — identity, snapshots, reveal & cross-journey protocols (read before drawing)

This is what keeps recurring screens **consistent across journeys**, and it works the same in both
modes (FigJam flow map and Figma Design components). A screen is **not owned by one journey** — the
same logical screen recurs, and each journey can add to it. To stop the wireframes drifting into N
slightly-different copies of "Home", the skill **does not redraw screens from memory**. It maintains
an explicit **Screen Registry** that lives in the file, keeps **one canonical master per screen**,
and **derives** each journey's view of that screen from the master. The skill executes against the
registry; it never recalls a screen.

> In **Mode A (FigJam)** a master/snapshot is a **screen box** (`createShapeWithText`). In
> **Mode B (Figma Design)** the same screen is realized as a lo-fi **component**. The registry,
> IDs, reveal logic and protocols below are identical across modes — only the rendered node type
> differs.

> The one rule that makes this work: **the registry + masters are the source of truth, not the
> chat.** Read them at the start of every run. If a value isn't in the registry, it isn't known —
> don't invent it.

## Core model
- **Screen** — a logical screen with a **stable ID** (`SCR-HOME`, `SCR-CHECKOUT`, …). Identity is
  the ID, **never the name** (two "Details" screens are different IDs). Different **surface** =
  different screen (`SCR-HOME-M` mobile vs `SCR-DASH-ADMIN-D` desktop) — never force one master
  across surfaces.
- **Element** — a slot on a screen (`SCR-HOME/cta-primary`, `SCR-HOME/promo-section`) with a stable
  ID, an **owning journey** (the *first* journey, in file order, that reveals it), and an optional
  list of **also-used-by** journeys.
- **Master** — one fully-revealed representation per screen, holding the **latest canonical
  content** (every element that any journey ever reveals), lives in the `🧩 Master Screens`
  reference Section. Not part of any journey flow. In FigJam it's a **master box**; in Figma Design
  it's the screen's **component**.
- **Snapshot** — a journey's view of a screen: a **clone of the master** with not-yet-revealed
  elements shown as **placeholders** and the step's **state** applied. Snapshots are what the flow
  connectors point at.

## Phase 1 pre-pass (build the registry BEFORE drawing anything)
Analyse **all** journeys + docs together (not journey-by-journey) and produce:
1. **Screen list** — every unique screen with its stable ID, name, surface, and the journeys it
   appears in.
2. **Element list per screen** — every element the screen will *ever* have across all journeys,
   each with a stable element ID and its **owning (reveal) journey** decided by **file order**
   (earliest journey that needs it owns the reveal).
3. **Reveal map** — per screen, per journey: which elements are revealed (owning journey ≤ this
   journey) vs placeholder (owning journey later).
4. **State map** — which states each screen needs and in which journey/step.
Show this back as the **approval gate** (`🗂 Screen Index` preview). Only after approval does
drawing start. Placeholders are only possible because this pre-pass already knows what later
journeys will add.

## Snapshot derivation rule (deterministic — no guessing)
For a screen `S`, journey `J` (file-order rank `r(J)`), state `st`:
```
snapshot(S, J, st) =
  clone(master(S))                           # identical content + element list
  for each element e in S:
     reveal e   if r(ownerJourney(e)) <= r(J)  AND e not deprecated
     else placeholder(e)                       # listed but greyed → screen content stays stable
  apply state st
```
Because every snapshot starts from the same master and every element is **listed from the first
snapshot** (as placeholder or real), shared elements are identical by construction and **revealing
is an in-place swap, never an insert** — a screen's content stays stable across its snapshots.
Drift is structurally impossible, not something to "remember".

## Placeholder convention
A placeholder is a not-yet-revealed element kept **listed but visibly deferred** so the screen's
content is stable across journeys:
- **FigJam (Mode A):** a greyed bullet in the screen box, tagged with what it becomes and its
  owning journey — e.g. `• (later) Checkout CTA (reveals in: Purchase)`. The slot stays in the box,
  so the box content doesn't change shape when the element is later revealed.
- **Figma Design (Mode B):** the **reserved slot** at the element's footprint — a `#F5F5F5` box,
  1px `#CCCCCC` dashed border, a small Flow-Circular caption naming what it becomes and its owning
  journey. It holds the exact space so nothing reflows on reveal.

## Storage (where the registry lives)
- **`🗂 Screen Index`** — human-readable: each screen's ID, name, surface, element list with owning
  journey + status (placeholder / revealed / deprecated / override), and a master reference. This is
  the readable source of truth and the Phase 1 approval artifact. **Render it as a structured
  table, not a single text node:**
  - **FigJam (Mode A):** a native FigJam **table** (`create-table`) with a header row and one row
    per screen (cells: ID / name / surface / elements / owning journey / status).
  - **Figma Design (Mode B):** a vertical **auto-layout** frame with a header row and one
    auto-layout row per screen, every cell its own **auto-height** text node, the frame **hugging**
    its content.
  A single concatenated text blob (which overflows and can't be read) is the failure to avoid.
- **Machine-readable tag** on each master/snapshot node via `sharedPluginData`
  (namespace `thisura`, keys `screenId`, `elementId`, `ownerJourney`, `status`, `state`) **if the
  MCP exposes plugin data** (it works on FigJam nodes too). If it doesn't, rely on the
  `🗂 Screen Index` + a strict naming convention (below) as the fallback registry.
- **Master section** — `🧩 Master Screens`, a reference Section holding one master per screen,
  outside the journey Sections.
- **Inspection:** read the live board/file before any change. In FigJam use **`get_figjam`**
  (`get_metadata` is design-only and fails on a board); in Figma Design use `get_metadata`.

## Node naming (registry-aware)
- Master: `[MASTER] {Screen} ({surface})` — e.g. `[MASTER] Home (mobile)`.
- Snapshot: `{Screen} ({state})` inside the journey Section (journey implied by Section), tagged
  with `screenId`. The same screen across journeys shares `screenId` but lives as a separate
  snapshot node (box in FigJam / component instance in Figma) in each Section.
  Do not use em dashes in snapshot titles or placeholder bullets.

---

## Cross-journey edge cases & resolutions
Every case below is handled by the registry — none rely on the model remembering.

1. **Additive reveal** (later journey adds an element). → Slot reserved in all snapshots from the
   pre-pass; revealed from its owning journey onward; earlier snapshots keep the placeholder. No
   edit to earlier journeys.
2. **Modify an already-revealed element** (a later journey changes something an earlier journey
   already revealed). → Edits the **master**, so it must ripple to **every** snapshot that reveals
   it, including earlier journeys. Use the **ripple protocol**. Never silent.
3. **Context-dependent content** (screen genuinely differs by entry path / role / data). → This is
   a **state/variant**, *not* a modification. Model as a screen state; one snapshot per variant.
   Keeps "reveal" (what's known yet) separate from "state" (which variant shows).
4. **Element removed / deprecated.** → Mark `deprecated` in the registry; drop from snapshots from
   that point forward; **ripple-flag** earlier snapshots that showed it for re-review.
5. **Screen split / merge** (a journey reveals one screen is really two, or two are one). → Registry
   refactor: new IDs, re-map that journey's arrows, re-review affected journeys. Caught in the
   pre-pass ideally; mid-build, handled as a flagged structural change via the ripple protocol.
6. **Same name, different screen.** → Identity is the **ID**, not the name; the pre-pass
   disambiguates and qualifies names so they never merge by accident.
7. **Same screen, different surface.** → Different surface = **different screen ID + master**.
   Never force one canonical across mobile/desktop.
8. **Element used by multiple journeys.** → Ownership = **first** journey to introduce it (file
   order); later journeys reference the already-revealed element. Registry records `introducedBy` +
   `alsoUsedBy`.
9. **Doc conflict** (journey implies one label/behaviour, PRD says another). → Surfaced in the
   pre-pass; **ask the user**; never silently pick.
10. **Orphaned reservation / impossible reveal** (a reserved slot no journey reveals, or a reveal
    with no reserved slot). → Registry validation flags both **before** drawing.
11. **Manual-edit divergence** (user hand-edits a snapshot in Figma). → **Manual-edit protocol**
    below. Never overwritten, never silently ignored.

## Ripple protocol (cases 2, 4, 5 — changes that reach back into finished journeys)
A canonical change to an already-revealed or shared element is **never applied silently**. The
skill:
1. updates the **master**,
2. lists **every snapshot/journey affected** (all that reveal the changed element),
3. **re-derives** those snapshots from the updated master,
4. **re-surfaces those journeys for re-review**, clearly flagged as touched by a ripple.
This is the one documented exception to "don't touch finished journeys" — changes *can* reach back,
but only **visibly and with re-review**, never quietly.

## Manual-edit protocol (case 11 — respect user edits in Figma)
On every run, before changing anything, compare each snapshot to what the registry says it should
be (via `sharedPluginData` if present, else the `🗂 Screen Index` + naming + a visual diff). If a
snapshot **diverges** because the user hand-edited it, **stop and ask**:
- **Promote** the edit into the **master** → it becomes canonical and **ripples** to all snapshots
  (via the ripple protocol), or
- **Keep as a local override** → record `status: override` on that element/snapshot in the registry
  so the skill **won't "correct" it back** on future runs.
Either way the user's edit is protected. Default to asking; never auto-resolve.

## Registry validation (run in Phase 1 and before each journey)
- [ ] Every screen has a unique stable ID; no two screens share an ID; names disambiguated.
- [ ] Every element has an owning journey that exists and is in scope; `alsoUsedBy` journeys exist.
- [ ] Reveal map consistent: nothing revealed before its owner; every reserved slot is revealed by
      some journey (case 10); every reveal has a reserved slot.
- [ ] Surfaces correct: no master shared across surfaces.
- [ ] Deprecations recorded with the journeys that need ripple-flagging.
- [ ] Overrides recorded so they survive future runs.