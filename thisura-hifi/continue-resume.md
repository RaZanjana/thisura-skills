# Continue / Resume — picking up an in-progress HiFi file

Use this whenever the file already has foundations + at least one built story and the user wants to
**carry on without reworking**. It works the same whether you left off minutes or days ago — the
workflow is **stateless and driven by the file + the build log, not by time or session**. "Same
day" and "next day" are identical.

> Never re-run Step 0 setup or rebuild foundations on resume. Don't redraw finished stories.

## What to point at
- The **same Figma file** (URL / `fileKey`).
- The **same build log** (`…/design-artifacts/figma-build-log.md`).

If the build log is missing or stale, fall back to a live inventory + fingerprints + screenshots
(below) and **ask the user to confirm each story's status** before resuming.

## Resume protocol
1. **Confirm targets** — file + build log path. Don't touch Step 0 or foundations.
2. **Read the build log first** — especially the **Screens table = the resume index** (status per
   story: signed-off / in-progress / not-started), the Standards, the registry tables (node ids),
   open items, and the story log.
3. **Take a fresh live inventory** — `get_metadata` on `🧩 Components` + `🟦 Drafts`; read current
   variables/styles; read the **`thisura` `sharedPluginData` fingerprints** on masters + screen
   frames.
4. **Detect drift — three signals:**
   - **Structural** — node-id registry vs live metadata: new / renamed / moved / deleted nodes,
     frame positions.
   - **Content** — compare each master/frame's live state to its stored **fingerprint**: recolour,
     text rewrite, restructured props, **detached instances**, or **raw-value overrides** (a
     hard-coded hex breaking tokens-only is a Standard #1 violation — flag it).
   - **Visual** — `get_screenshot` previously-done screens to confirm.
5. **Classify** each change: asset swap / layout convention / scope edit / fix / standard violation.
6. **★ Report & approve ★** — present a **"what changed since last time"** report. For each edit,
   the user decides:
   - **Promote to a numbered standard** — ripples to all existing + future work; or
   - **Keep as a recorded override** — authoritative, **never reverted**.
   Also **confirm which story to resume**. Do not absorb anything silently.
7. **Absorb + propagate** — update registry rows + node ids; add/renumber standards; apply promoted
   rules across the done screens; record overrides in the build log.
8. **Resume** — re-enter the per-story loop (`per-story-loop.md`) at the **next not-done story** in
   sprint order.

## Frozen vs live
- **Signed-off stories are frozen** — only touched to apply an explicitly **promoted** standard,
  and then **re-shown for re-review**.
- **In-progress story** → continue it.
- **Manual edits are authoritative** — never silently overwritten (promote or keep as override).

## Fingerprints — how detection stays reliable
- On first build **and on every change**, stamp masters + screen frames with `sharedPluginData`
  (namespace `thisura`): e.g. `fingerprint` (a short hash of bound tokens/props + key fills/text),
  `status`, `story`, `updatedBy=thisura`.
- On resume, a node whose **live state ≠ its stored fingerprint** = a manual edit → report it.
- A node missing its `thisura` stamp where one is expected = **added/replaced by the user** → report it.

## End-of-session checkpoint (do this before stopping — Standard #24)
So the next resume is bulletproof:
- **Update the build log** — per-story status, registry node ids, open items, a story-log entry.
- **Re-stamp the `thisura` fingerprint** on every master + screen frame you created or changed.

> **Why fingerprints + a report gate:** structure alone (`get_metadata`) misses recolours and text
> rewrites; the fingerprint catches them, the screenshot confirms them, and the report keeps the
> human in control of promote-vs-override instead of the agent guessing.
