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

## Then
Place instances on the screen (Phase 3) and **screenshot each new component** for the review.
**Stamp the master** with a `thisura` `sharedPluginData` fingerprint (status, variants, a hash of
bound tokens/props) so manual edits are detectable on resume — see `continue-resume.md`.

> **Why on-demand + instances:** building the whole library up front wastes effort and drifts from
> real needs; assembling screens from instances means one component edit propagates everywhere and
> keeps the system DRY.
