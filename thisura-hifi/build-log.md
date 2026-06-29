# The build log — workflow memory + standards

The build log is the **durable, shared memory** of the workflow — the single source of truth for
what exists, what's reusable, what's pending, and the rules. **Self-check it at the start and end
of every step** (Standard #18).

Location: `…/design-artifacts/figma-build-log.md`. Keep it concise — necessary details only.

## What the build log holds
- **File link & setup decisions** — the Step 0 locks (breakpoints, theme(s), framework token
  mapping, icon library, content policy) + `fileKey`.
- **Standards** — numbered, promoted from fixes (the list below; append as new rules emerge).
- **Page map** — Cover · Style Guide · Components · Drafts.
- **Brand tokens** — the palette + project role tokens.
- **Foundations summary** — collections, modes, styles created.
- **Screens table** — story → desktop/mobile node ids, **status** (signed-off / in-progress /
  not-started). **This is the resume index** (`continue-resume.md`) — what's frozen vs what's next.
- **Reusable sections** table.
- **Components table** — name, variants/states, node id, status.
- **Story log** — newest first (what was built, decisions, fixes).
- **Open items** — pending decisions / TODOs.
- **Overrides** — recorded manual edits kept as-is (never reverted).
- **Troubleshooting milestones** — notable fixes worth remembering.

> **End-of-session checkpoint (Standard #24):** before stopping, update per-story status + registry
> node ids here **and** re-stamp the `thisura` `sharedPluginData` fingerprint on every master /
> screen frame you created or changed, so the next resume detects drift reliably
> (`continue-resume.md`).

## File page structure (the 4 pages this workflow produces)
| Page | Holds |
|---|---|
| **Cover** | Title / project meta |
| **🎨 Style Guide** | The bound token documentation (Phase 1) |
| **🧩 Components** | All component masters, labelled for handoff |
| **🟦 Drafts** | HiFi screens — desktop + mobile per story, annotated |

## Standards checklist (promote every recurring fix to a numbered rule)
1. Tokens only — never raw hex/px on elements.
2. **Verify variable names before binding** — a wrong name silently falls back to black.
3. Bind spacing variables to all padding/gap (incl. wrap counter-axis spacing).
4. Interaction states on every interactive component (shadcn naming).
5. Desktop + mobile for every key component & screen.
6. WCAG AA validated (resolving contrast audit) before "done".
7. Clip-content OFF around shadows / outside-strokes.
8. Build from instances; extend in place (clone); never break live instances; never detach.
9. Brand-colour discipline (accent/transition only via dedicated tokens).
10. Components page = organised, labelled handoff board.
11. Maintain the build log every story.
12. **Detect & absorb manual changes before every "proceed".**
13. Component masters live only on the Components board; screens use instances.
14. Modify in place only if unused; else add a new variant (don't break screens).
15. Mobile placed directly next to desktop.
16. Bind the breakpoint mode on every screen frame.
17. Every page includes global chrome (header + footer) as instances.
18. Self-check the build log each step.
19. One semantic text style per role across breakpoints (mode resolves size).
20. Annotate CTAs/links on desktop frames only; chrome on masters.
21. Maps: chosen library + style; differentiate special markers.
22. Image uploads: verify real type, correct Content-Type, re-encode to bust a cached bad decode.
23. **Review every step/story with the stakeholder; proceed only on explicit sign-off.**
24. **Checkpoint at end of session** — update the build log + re-stamp `thisura` fingerprints on masters/frames so resume detects drift reliably.
25. **No placeholder-height auto-layout** — never `resize(w, 10)` (or any token height) on a hug
    container; never leave `primaryAxisSizingMode: FIXED` with a stub height on a column that should
    grow. Append children first, then set `AUTO` (HUG) / `FILL` sizing.
26. **Text FILL contract** — multi-line copy: `textAutoResize = HEIGHT` → `layoutAlign = STRETCH` →
    `layoutSizingHorizontal = FILL` → `layoutSizingVertical = HUG`, **only after** the parent has a
    real width. Run the zero-width scan (Standard #27) before marking a component or screen done.
27. **Layout verification gate** — after every component create/extend and every screen compose,
    inspect for: any `TEXT` with `width < 8` (per-character vertical stack); content column hugging
    to ~10px while children overflow; footer sitting above body content; board section squeezed
  below master width. Fix on the **component master first**, then re-check instances. `get_screenshot`
    both the Components board cell and the screen frame.

> **Why:** Standards #1–N are past defects/decisions promoted into rules. The log is how the
> system learns across sessions and agents and stops repeating mistakes.
