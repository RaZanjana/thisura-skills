# Phase 2 — Components on demand

**Goal:** build only what the current story needs; reuse aggressively. The full library is never
built up front — it grows from real screen needs, story by story.

Read `figma-use` (and `figma-generate-library` for variant/token patterns) before any `use_figma`
write.

---

## Decision order — for every element a story needs
1. **Reuse** an existing component as an instance.
2. **Extend** — add a variant / prop / state by **cloning** an existing variant. Never break live
   instances, never re-point or detach (Standard #8, #14).
3. **Create new** — only if it's genuinely missing — on the `🧩 Components` board.

Check the build-log registry and `search_design_system` first so you don't rebuild something that
already exists.

## Every component must have
- **Variants** for kinds, and **interaction states** per shadcn naming
  (`Default / Hover / Focus / Active / Disabled`, the relevant subset): focus = ring;
  disabled = reduced opacity. (Standard #4.)
- **Props**: `TEXT`, `BOOLEAN`, `INSTANCE_SWAP`, and a **SLOT** for page-supplied content where
  content varies.
- **Bound** fills / text / stroke + spacing / radius — tokens only, no raw values (Standard #1, #3).
- **Responsive internals**: auto-layout with `FILL` / `HUG`; for absolute overlays use constraints
  `SCALE` / `STRETCH` / `MAX` / `MIN`. Slot and child positions **can't be overridden per-instance**,
  so make them responsive in the master.
- **Documentation on the board**: a titled section + a label (name, variants/states, notes) so it
  reads as a handoff artifact (Standard #10, #13).

## Placement & hygiene
- Component **masters live only on the `🧩 Components` board**; screens use **instances** (Standard #13).
- After `clone()` / create, verify the master's parent is the Components board — an unparented
  master ends up on the wrong page (see `troubleshooting.md`).
- After `combineAsVariants`, position the children into a grid and resize the set, or they overlap
  as one node.
- Keep the library free of assets that imply **non-goals** (e.g. a search icon when site search is
  out of scope — Standard #9 / scope guard).

## Components board — organisation pattern (handoff layout, Standard #10)
The board has a **consistent structure** — match it for every new component. **Never drop a bare
master loose at the bottom of the board** (a recurring break: it ignores the rhythm and reads as
unfinished). Always place a new component inside the structure below.

- **Board** (`🧩 Components`): a single **vertical auto-layout** frame, **gap 72**, **padding 48**,
  hug width + height. Sections flow as its children — appended sections seat themselves.
- **Section** (one per component group, e.g. *Icons*, *Button*, *Cards*, *Footer*, *Overlays*,
  *Utility bar*): a **vertical auto-layout**, **gap 20**, hug, transparent fill, clip OFF, containing:
  1. a **heading** text — *Manrope SemiBold 18*, foreground;
  2. an optional **sub-label** text — *Inter Regular 14*, muted-foreground (the one-line description);
  3. **content** holding one **labelled sub-frame per component** (vertical auto-layout, gap 8):
     a **component label** (*Inter SemiBold 14*) + an optional **props/states desc** (*Inter Regular 12*,
     muted) + the **master** (for icons, the small cell is the master with its name label above).
- **Reuse the exact text styles, never re-type fonts/sizes/colours.** The reliable way is to
  **`clone()` an existing board label** (heading / sub / component-label / desc) and only change its
  `.characters` — the clone keeps the bound text style, fill and font (load the font first).
- **Put a new component in the matching existing section** rather than a new one when one fits:
  a new icon → append a cell to the **Icons** row; a new card → add a sub-frame to the **Cards**
  section; only **create a new titled section** for a genuinely new component family (e.g. a utility
  bar). After appending, the board's auto-layout reflows everything — verify no master is left
  parented directly to the board.

## Then
Place instances on the screen (Phase 3) and **screenshot each new component** for the review.
**Stamp the master** with a `thisura` `sharedPluginData` fingerprint (status, variants, a hash of
bound tokens/props) so manual edits are detectable on resume — see `continue-resume.md`.

> **Why on-demand + instances:** building the whole library up front wastes effort and drifts from
> real needs; assembling screens from instances means one component edit propagates everywhere and
> keeps the system DRY.
