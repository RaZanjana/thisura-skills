# The per-story loop (CRITICAL) + manual-change absorption

**Run this loop for every story. Do not batch stories. Do not proceed without a review.** A token,
component, or layout decision made wrong in story 1 silently replicates into every screen that
reuses it — catching it at the story boundary is cheap; 20 screens later it is not.

```
┌─ 1. DETECT manual changes ─────────────────────────────────────────────┐
│   Inspect the file (pages, components, screen positions, recent edits). │
│   Reconcile against the build log. Absorb the stakeholder's edits.      │
├─ 2. READ the story ────────────────────────────────────────────────────┤
│   ACs, designer notes, closed/open decisions, scope/non-goals.          │
├─ 3. GATHER content ────────────────────────────────────────────────────┤
│   Extract from reference; rewrite to the narrative; in-scope only.      │
├─ 4. COMPONENTS (components.md) ─────────────────────────────────────────┤
│   Reuse / extend / create on the board.                                 │
├─ 5. BUILD desktop → mobile beside it (screens.md) ─────────────────────┤
│   Bind breakpoint mode + tokens + spacing; chrome; states.              │
├─ 6. ANNOTATE + CLIP checks (desktop) ──────────────────────────────────┤
├─ 7. AA AUDIT → fix to 0 failures (accessibility.md) ───────────────────┤
├─ 8. UPDATE the build log (build-log.md) ───────────────────────────────┤
├─ 9. ★ REVIEW with stakeholder (screenshot) — get sign-off ★ ───────────┤
│      Apply requested fixes. Absorb any manual edits back into memory.   │
└─ 10. ONLY THEN → next story ───────────────────────────────────────────┘
```

The agent treats **"proceed" as the only gate to the next story** — never assume sign-off.

---

## Manual-change absorption (Standard #12 — runs at step 1 every story)
The stakeholder **will** edit Figma directly — swap a placeholder logo for the real asset,
reposition frames, recolour, restructure a component. Find and absorb these **without being told**,
every story.

1. **Detect.** Inspect pages, component structure, and screen positions; diff against the build
   log's recorded state **and the `thisura` `sharedPluginData` fingerprints** on masters/frames
   (a node whose live state ≠ its fingerprint = a manual edit). Look for new/renamed/replaced
   components, moved frames, recoloured fills, restructured props, detached instances, added
   sections. When resuming a fresh session, follow the fuller protocol in `continue-resume.md`.
2. **Interpret.** Classify each change: asset swap, layout convention, scope edit, fix, or standard
   violation. **Report what changed and get the user's promote-vs-override call before absorbing.**
3. **Absorb into memory (the build log):**
   - **Registry** — update the affected component/screen rows + node ids.
   - **Standards** — if the change expresses a *general rule* ("mobile sits right of desktop", "use
     the official logo"), **promote it to a numbered standard** so it applies everywhere thereafter.
   - **Change/story log** — note what changed and why.
4. **Propagate.** Apply the implied rule to existing and future work (reposition all mobiles, swap
   the logo everywhere via the component master, etc.).

> **Why memory lives in the build log:** Standards #1–N are literally past defects/decisions
> promoted into rules. Re-reading the log at the start of every step is how the system stops
> repeating mistakes. A manual edit is **authoritative** — never silently overwrite it; promote it
> or keep it as a recorded override.

## Reviewing every generation
After each step and each story, produce a **`get_screenshot`** (server render — it shows image
fills; the plugin screenshot does not) of what changed and present it. The stakeholder confirms it
matches ACs / brand / narrative, checks scope, makes any manual edits, and approves before the
agent proceeds.
