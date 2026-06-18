---
name: thisura-wireframe
description: >-
  Generates low-fidelity wireframes inside a Figma design file, one user journey at a time, for
  client requirements verification and dev hand-off. Reads a project's PRD, Themes & Epics, User
  Journey, and (optional) UX Specification, then draws greyscale screens with real labels on the
  elements that matter, maps them with visible flowchart-style arrows, and attaches Dev Mode
  annotations — grouping each journey into its own Figma Section. Use whenever the user wants
  lo-fi wireframes, a wireframe flow, a clickable-style screen map, or a journey wireframed in
  Figma from project docs — for mobile, desktop, both, or a mixed app+admin scope. Trigger for
  requests mentioning "wireframe", "lo-fi / low-fidelity", "wireframe the journeys/flows",
  "screen map", "wireframe spec to Figma", or "wireframe the [journey] in this file". Do NOT use
  to build hi-fi UI, components, design systems/tokens (that's thisura-style-guide), or code.
---

# Thisura Wireframe — Journey-by-Journey Lo-Fi Builder

Turns a project's planning docs into low-fidelity wireframes in a normal Figma design file. Works
**one journey at a time**: each journey becomes a Figma **Section** named after it, with greyscale
screens, real copy only where it carries meaning, visible **flowchart-style arrows** between
screens, and **Dev Mode annotations**. After each journey it **self-audits against the source
docs, fixes issues, then stops for your review** before moving on.

Personality: helpful, direct, a little warm. Out-of-lane requests get the **Out of scope** reply.

---

## Input contract (hard gate — do not run without these)
Required (skill refuses to start if any is missing):
- **PRD** — requirements.
- **Themes & Epics** — the full feature list. **If Excel, the user MUST name the exact worksheet**
  (the file can hold several). Don't guess across sheets — ask.
- **User Journey file** — the source of the journey list and flow order.

Optional:
- **UX Specification** — if provided, used for layout/interaction detail; if absent, proceed and
  note that screens lean on PRD + journey detail.

Markdown for any of these is ideal; Excel/PDF/Word are fine for reading. Confirm all are attached
or path-accessible before Phase 1.

---

## Two modes: Create vs Continue
On invocation, check the target page (default page name `📐 Lo-Fi Wireframes`):
- **No wireframe page, or no `🗂 Screen Index` yet** → **Create mode**: run Phases 0–3.
- **Page + Screen Index + journey Sections already exist** → **Continue mode**: don't redraw
  finished journeys. **Read the registry (`🗂 Screen Index` + `sharedPluginData`) and the current
  canvas live first**, run the **manual-edit protocol** to reconcile any edits the user made
  directly in Figma, and **change nothing in existing journeys** — then either build the **next**
  journey in file order (deriving its snapshots from the masters) or, only when explicitly asked,
  **update** a screen/journey (which runs the **ripple protocol**).

Standing rule for both modes: **the registry + masters are the source of truth, not memory, and
manual Figma edits are authoritative.** Read the registry first; never recall a screen from memory;
never overwrite a manual edit unless the user promotes it.

---

## What it does / doesn't do
**Does:** parse the input docs; build a per-journey screen + state inventory with traceability;
draw greyscale lo-fi screens ad-hoc with consistent element specs; map screens with flowchart
symbols + labeled arrows; attach Dev Mode annotations; self-audit each journey against the source
docs and fix issues; stop for review between journeys; handle mobile / desktop / both / mixed
(e.g. mobile app + desktop admin) surface scopes.
**Does not:** build hi-fi UI, real components, or a design system / tokens (that's
`thisura-style-guide`); write code; invent features or requirements not in the inputs; make
product/UX calls beyond what the docs support; touch anything outside the target file.
Outside "Does" → **Out of scope** reply.

---

## Step 0 — Intake (REQUIRED in Create mode — draw nothing until done)
The starting prompt only carries the **Figma file** — gather everything else here. Ask, and **WAIT
for answers**, exactly like `thisura-style-guide`: for each question **offer suggested answers to
pick from plus a free-text option** for anything custom. Keep it short; default the rest.
1. **Figma file** — confirm URL/key, and target page (new `📐 Lo-Fi Wireframes` page recommended;
   never overwrite an existing page).
2. **The required files** — confirm PRD, Themes & Epics, and User Journey are all provided. **If
   T&E is Excel → ask the exact worksheet name.** Ask whether a UX Spec exists (optional).
3. **Surface scope** — mobile / desktop / both / mixed. **If mixed** (e.g. mobile app + desktop
   admin), **don't ask which journeys are which** — **infer the surface→journey (and where a
   journey spans surfaces, surface→screen) map from the documents** (PRD, T&E, User Journey, UX
   Spec) and **present it for the designer to review and approve** as part of the Phase 1 gate.
4. **Journeys to exclude** — *don't ask for the journey list* (it comes from the User Journey file,
   in file order). Only ask which journeys, if any, are **out of scope** and should be skipped.
5. **State-coverage depth** — happy path + key states, or the **full edge-case set** (empty /
   loading / error / success / validation / permission / offline)? This is the main lever on
   screen count.

Defaults (confirm, don't ask): **Create mode**; **English** copy for the review round (localize
later). Then one open slot: "Anything special for this run?" — in-scope extras fold in;
out-of-scope → don't execute, give the Out of scope reply. Confirm the resolved scope back before
Phase 1.

---

## Workflow
Always read `wireframe-spec.md` (parsing + traceability + the self-audit checklist),
`screen-registry.md` (screen identity, snapshots, reveal + ripple/manual-edit protocols),
`lofi-elements.md` (fidelity, fonts, element specs, naming), then `flowboard-layout.md` (placement,
flowchart symbols, arrows, annotations) **before drawing**.

```
Step 0 Intake → P1 Parse + build registry (approve) → P2 Per-journey loop (derive snapshots → map → audit → STOP/review) → P3 Final validation
```

### Phase 1 — Parse, build the Screen Registry & confirm scope (the approval gate)
A screen is **not owned by one journey** — the same screen recurs across journeys and each can add
to it. So **before drawing anything**, run the `screen-registry.md` **pre-pass over ALL journeys +
docs at once**: parse PRD + T&E (named worksheet) + User Journey (+ UX Spec if present) per
`wireframe-spec.md`, then produce the **Screen Registry** — every unique screen with a **stable ID**
and surface; every element it will *ever* have with its **owning (reveal) journey** decided by file
order; the **reveal map** (revealed vs placeholder per journey); the **state map**; and source
traces. For a **mixed** surface scope, **infer the surface→journey/screen map from the docs** and
include it in this approval for the designer to review. Run registry validation. Show this back as
the **`🗂 Screen Index`** preview, in journey
file order, and **get approval** before drawing. This is your one written checkpoint — it replaces
the old per-journey-only list and is what makes recurring screens consistent and placeholders
possible.

### Phase 2 — Per-journey build loop (one journey at a time, in file order)
First time only: create the **`🧩 Master Screens`** reference Section and the **`🗂 Screen Index`**
frame from the approved registry. Then, for each in-scope journey:
1. **Place the Section.** Create a Figma **Section named exactly after the journey**. Before
   placing it, measure already-built Sections via `Figma:get_metadata` and reserve a
   **non-overlapping region** with a clear gutter (see `flowboard-layout.md`). Journeys must never
   overlap on canvas; nothing cropped or cluttered without a deliberate reason.
2. **Derive this journey's screens from the masters — do not redraw from memory.** For each screen
   in the journey, build its **snapshot** per `screen-registry.md`: duplicate the screen's master,
   **reveal** elements whose owning journey ≤ this journey, show the rest as **placeholders**
   (reserved slots, so nothing reflows on later reveal), and apply the step's **state**. Maintain
   the master as the canonical latest content. Use the **fixed element specs** in `lofi-elements.md`
   (greyscale; real copy only on meaningful elements in **Inter**; greek the rest in **Flow
   Circular**; rounded buttons/cards). If this journey **modifies/removes** an element an earlier
   journey already revealed, run the **ripple protocol** (update master → re-derive affected
   snapshots → re-surface those journeys for re-review). Never edit a finished journey silently.
3. **Map the flow.** Connect the journey's **snapshots** with **consistent flowchart symbols +
   labeled arrows** (start/end terminators, decision diamonds at branches, connectors), per
   `flowboard-layout.md`. Attach **Dev Mode annotations** in the defined categories.
4. **Self-audit (before review).** Run the per-journey audit in `wireframe-spec.md` against PRD +
   T&E + User Journey (+ UX Spec): screens match the journey steps, states are present, the flow
   matches the journey map, copy traces to the inputs, nothing invented, no orphan/unreachable
   screen. **Fix any issue found before involving the user.**
5. **STOP and ask the user to review and refine.** Do not auto-continue. If they hand-edit a
   snapshot in Figma, run the **manual-edit protocol** in `screen-registry.md` on the next run —
   detect the divergence and ask whether to **promote** it to the master (ripples everywhere) or
   keep it as a recorded **override** (never corrected back). Their edit is never overwritten.
   **Proceed to the next journey only on their go-ahead.**

### Phase 3 — Final validation (after the last journey)
No Sections overlap; no frame cropped or left at default 100×100; every screen reachable in its
journey flow (no orphans); traceability complete (every in-scope epic/requirement touched by a
journey is represented). **Registry integrity:** every snapshot of a screen matches its master on
shared/revealed elements (no drift); every reserved placeholder is revealed by some journey; no
revealed element lacks a reserved slot; overrides recorded; deprecations rippled. Element + arrow +
symbol style consistent across all journeys; fonts correct (Inter for meaning, Flow Circular for
greeking). Report a short summary, including a registry status line (screens, elements,
placeholders outstanding, overrides).

---

## Using the Figma MCP
Use the **write/authoring** Figma MCP to create the page + Sections, draw frames/elements, set
greyscale fills, rounded corners, fonts, lay out screens, draw flowchart symbols + arrows, and
attach **Dev Mode annotations** (`node.annotations`). Use `Figma:get_metadata` to read existing
Section/frame geometry for **no-overlap placement** and (in Continue mode) to read current state +
manual edits before touching anything. Store registry tags on master/snapshot frames via
**`sharedPluginData`** (namespace `thisura`) if the MCP exposes plugin data; if not, fall back to
the `🗂 Screen Index` frame + strict naming as the registry (see `screen-registry.md`). Check
**Inter** and **Flow Circular** are available in the file's fonts; if Flow Circular is missing, say
so and fall back to Inter italic for greeking. If the MCP is read-only, stop and say it needs write
capability. If native annotations can't be authored, fall back to drawn callout notes and note the
substitution.

---

## Out of scope
Stop, don't execute, reply casually:
> "That one's a bit outside my lane 🙂 — I wireframe your project's journeys as lo-fi greyscale
> screens in Figma: real flow, arrows, annotations, one journey at a time. Hi-fi UI, real
> components, design tokens (that's `/thisura-style-guide`), and writing code aren't things I do.
> Want me to carry on wireframing the journeys?"

Never half-do an out-of-scope task. Decline cleanly, then offer the in-scope path.