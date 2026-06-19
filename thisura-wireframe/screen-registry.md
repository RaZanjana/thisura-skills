# Screen registry — identity, snapshots, reveal & cross-journey protocols (read before drawing)

This is what keeps recurring screens **consistent across journeys**. A screen is **not owned by one
journey** — the same logical screen recurs, and each journey can add to it. To stop the wireframes
drifting into N slightly-different copies of "Home", the skill **does not redraw screens from
memory**. It maintains an explicit **Screen Registry** that lives in the Figma file, keeps **one
canonical master per screen**, and **derives** each journey's view of that screen from the master.
The skill executes against the registry; it never recalls a screen.

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
- **Master** — one fully-revealed frame per screen, holding the **latest canonical content** (every
  element that any journey ever reveals), lives in a reference section. Not part of any journey
  flow.
- **Snapshot** — a journey's view of a screen: a **duplicate of the master** with not-yet-revealed
  elements shown as **placeholders** and the step's **state** applied. Snapshots are what the flow
  arrows point at.

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
  duplicate(master(S))                       # identical skeleton + shared elements
  for each element e in S:
     reveal e   if r(ownerJourney(e)) <= r(J)  AND e not deprecated
     else placeholder(e)                       # reserved slot, not removed → no reflow
  apply state st
```
Because every snapshot starts from the same master skeleton and every element **slot exists from
the first snapshot** (as placeholder or real), shared elements are identical by construction and
**revealing is an in-place swap, never an insert** — the layout never shifts between a screen's
snapshots. Drift and reflow are structurally impossible, not something to "remember".

## Placeholder convention
A placeholder is the **reserved slot** for a not-yet-revealed element: a `#F5F5F5` box at the
element's real footprint, 1px `#CCCCCC` dashed border, a small Flow-Circular caption naming what it
will become and its owning journey (e.g. *"Checkout CTA · reveals in Journey: Purchase"*). It holds
the exact space the real element will occupy so nothing moves on reveal.

## Storage (where the registry lives)
- **`🗂 Screen Index`** frame on the wireframes page — human-readable: each screen's ID, name,
  surface, element list with owning journey + status (placeholder / revealed / deprecated /
  override), and a master link. This is the readable source of truth and the Phase 1 approval
  artifact. **Render it as a structured table, not a single text node:** a vertical **auto-layout**
  frame with a header row and **one row per screen**, each row an auto-layout set of cells
  (ID / name / surface / elements / owning journey / status), every cell its own **auto-height**
  text node, the frame **hugging** its content. A single concatenated text blob (which overflows and
  can't be read) is the failure to avoid.
- **Machine-readable tag** on each master/snapshot frame via `sharedPluginData`
  (namespace `thisura`, keys `screenId`, `elementId`, `ownerJourney`, `status`, `state`) **if the
  MCP exposes plugin data**. If it doesn't, rely on the `🗂 Screen Index` + a strict frame-naming
  convention (below) as the fallback registry.
- **Master section** — `🧩 Master Screens`, a reference Section holding one master per screen,
  outside the journey Sections.

## Frame naming (registry-aware)
- Master: `[MASTER] {Screen} ({surface})` — e.g. `[MASTER] Home (mobile)`.
- Snapshot: `{Screen} — {state}` inside the journey Section (journey implied by Section), tagged
  with `screenId`. The same screen across journeys shares `screenId` but lives as a separate
  snapshot frame in each Section.

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