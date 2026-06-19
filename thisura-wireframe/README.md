# Thisura Wireframe — Journey-by-Journey Lo-Fi Builder

A helper that turns your project's planning docs into low-fidelity wireframes — built **one user journey at a time**, so each one is reviewable before the next. It works in two stages: first it maps the flow on a **FigJam board** (the bit you walk a client through), and then — once a flow is signed off — it can generate polished lo-fi screens as **components in Figma Design** for you to map manually.

---

## What is it?

Thisura Wireframe is a Claude skill you run inside Cursor. Point it at a Figma file, hand it the project docs, and it wireframes the product **journey by journey**.

- **Stage 1 — Flow Map (FigJam):** each journey becomes its own FigJam **Section**, filled with greyscale **screen boxes** (a titled box listing the key elements on the screen), wired with **native FigJam connectors**, **decision diamonds** and **start/end terminators**, and annotated with **sticky notes** for dev hand-off. After each journey it **audits its own work against your docs, fixes what's off, then stops and asks you to review** before moving on.
- **Stage 2 — Lo-Fi Components (Figma Design):** once a journey's flow is agreed, the skill can generate polished lo-fi screens as **components** in a Figma Design file. You then instance and map those components against the FigJam journeys yourself.

The point: instead of hand-drawing every screen and wiring every arrow on a pixel canvas (which gets disorganized fast), you get a clean, native flow map for verification first — and only invest in polished screens once the flow is right.

---

## Why FigJam for the flow map?

A flow map is a diagramming job, not a pixel-layout job. On a Figma Design canvas the old approach fought the tool — hand-drawn arrows that didn't reflow, full 1440×1024 frames scattered across thousands of pixels, a decision diamond floating in empty space. FigJam does the hard parts natively:

- **Connectors** attach to boxes, auto-route, reflow when you move things, and carry labels.
- **Real flowchart shapes** — diamonds for decisions, pills for start/end.
- **Stickies** for hand-off notes; **Sections** to group journeys; **tables** for the screen registry.
- **Screen boxes** instead of device frames — nothing to overflow or shrink, far tighter spacing.

Polished, shippable-looking lo-fi screens are still useful — they just belong in Stage 2, after the flow is agreed.

---

## What it produces

### Stage 1 (FigJam) — per in-scope journey
- **A Section named after the journey** — its own non-overlapping region of the board.
- **Greyscale screen boxes** — a titled box (`Screen — state`) with a short bullet list of the meaningful elements (CTAs, nav, title, key fields, error/empty messages). Real copy only where it carries meaning; filler is summarized as a `(placeholder)` bullet.
- **A mapped flow** — start/end terminators, decision diamonds at branches, and **labeled connectors** showing every path, including back/cancel/skip and the routes into error/empty states.
- **Sticky annotations** — color-coded notes (Navigation / State / Content / Interaction) placed by the relevant box.
- **A self-audit per journey** — checked back against the PRD, Themes & Epics, and User Journey map, with issues fixed *before* it asks you to look.

### Stage 2 (Figma Design) — on request, after sign-off
- **A component per screen** at exact device size (mobile 375×812, desktop 1440×1024), with **state variants** where needed, built from consistent element specs — placed in a library area for you to map against the journeys.

Behind both stages, two things keep recurring screens consistent:

- **A `🗂 Screen Index`** — the registry of every screen and element, which journey reveals each, and its status. The source of truth, so the skill never "remembers" a screen from chat — it reads it.
- **A `🧩 Master Screens`** area — one canonical master per screen; each journey's copy is *derived* from its master, so the same screen never drifts between journeys.

### How recurring screens work (read this — it's the important bit)

A screen isn't owned by one journey. The same Home (say) shows up in several journeys, and each may add to it. The skill keeps **one master** of each screen with the full, latest content; each journey shows a copy with the elements revealed *so far*, and anything a later journey will add shown as a deferred `(later) … reveals in: …` bullet. When a later journey **changes** something an earlier one already showed, the skill updates the master and **ripples** the change to every affected journey, then re-surfaces them for re-review — never silently. If you **hand-edit** a box in FigJam, it detects it and asks whether to make it canonical or keep it as a local override — it never overwrites your edit.

---

## What you need to give it (input contract)

**Required** — it won't start without these:

- **PRD** — the requirements.
- **Themes & Epics** — the full feature list. **If it's an Excel file with multiple sheets, name the exact worksheet** — it won't guess.
- **User Journey file** — this is the spine; it sets the journey list and the order.

**Optional:**

- **UX Specification** — if you have one, it's used for layout/interaction detail. If not, screens lean on the PRD + journey and it'll say so.

Markdown is ideal, but Excel / PDF / Word read fine.

---

## When to use it

Reach for it at the **wireframe verification** step — after kickoff and scope are documented, before hi-fi design. It earns its keep when:

- The project has more than a handful of screens and several journeys.
- You need a client to see structure and flow quickly to confirm scope (Stage 1).
- The product is mobile, desktop, both, or mixed (e.g. a mobile app **plus** a desktop admin) — it handles the surface split per journey.

For a single-screen change, it's overkill — do that by hand.

---

## What it does *not* do

- It **doesn't build hi-fi UI** you'd ship.
- It **doesn't set up a design system or tokens** — that's [`/thisura-style-guide`](../thisura-style-guide).
- It **doesn't write code.**
- It **won't invent** features, screens, or requirements that aren't in your docs.
- In Stage 2 it **builds components, it doesn't lay them into a flow** — you map them against the FigJam journeys.
- It **only touches the file you point it at.**

Ask it for something off this list and it'll stop, say so nicely, and offer to carry on wireframing.

---

## Prerequisites

1. **Cursor** (any model; tuned for Claude).
2. **Figma MCP connected to Cursor — the write/authoring kind.** A read-only MCP can look but can't draw.
3. A **FigJam board** for Stage 1 (the skill can create one if you don't have it), and **edit access** to it.
4. For Stage 2: a **Figma Design file** and the fonts **Inter** (default) for meaningful copy + **Flow Circular** (Dan Ross — free on Google Fonts) for placeholder/greeked text. If Flow Circular isn't present, Stage 2 falls back to Inter Italic and tells you. (Stage 1 in FigJam needs no special fonts.)

---

## Setup (one command)

Paste this into Terminal — it installs every Thisura skill:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

It drops the skills into `~/.claude/skills/`, so they're available in Cursor no matter what you're working on. Then **restart Cursor** and type `/` in the Agent chat to confirm **thisura-wireframe** shows up.

> **To update later:** run the same command again and restart Cursor.

<details>
<summary>Manual install (optional)</summary>

```bash
git clone https://github.com/RaZanjana/thisura-skills.git
cp -r thisura-skills/thisura-wireframe ~/.claude/skills/
```
Cursor also reads `.agents/skills/` and per-project `.claude/skills/` if you prefer.
</details>

---

## How to use it

### Starting prompt (new project)

In the Agent chat, call it and point it at your **FigJam board** — that's all you need:

```
Use /thisura-wireframe to wireframe the journeys for this project in this FigJam board: [Your FigJam board URL]
```

You don't put the docs or scope in the prompt. Like `/thisura-style-guide`, it **pauses and asks a few setup questions first** — each with suggested answers to pick from, plus a free-text option:

- **FigJam board** — confirms the board URL (or offers to create one).
- **The docs** — asks you to attach PRD, Themes & Epics, and User Journey (UX Spec optional); **if T&E is Excel, which worksheet**.
- **Surface scope** — mobile / desktop / both / mixed. If it's mixed, you don't sort the journeys yourself — it **works out which journeys are mobile vs desktop from your docs and shows you the map to review and approve**.
- **Journeys to exclude** — it already has the journey list from your file, so it only asks which (if any) to skip.
- **State depth** — happy path + key states, or the full edge-case set (empty / loading / error / success / validation / permission / offline).
- **Anything special?** — an open slot.

Then it shows you the **Screen Index** — every screen, its elements, and which journey reveals each — for approval. Once you're happy, it builds **the first journey's flow map**, audits it, and **stops for your review**. Approve or refine, and it moves to the next.

### Generating polished screens (Stage 2)

Once a journey's flow is signed off, ask for the components in a Figma Design file:

```
/thisura-wireframe — the "Onboarding" flow is approved. Generate the lo-fi screen components in this Figma Design file: [Your Figma Design URL]
```

It reads the approved journey + the registry and builds a component per screen (with state variants), placed in a library area. You then instance and map them against the FigJam journeys.

### Updating prompt (continue or change later)

Re-invoke on the same FigJam board. Continue to the next journey:

```
Use /thisura-wireframe on this board: figma.com/board/abc123 — continue with the next journey.
```

Change something that's already drawn (this triggers the ripple + re-review):

```
/thisura-wireframe — in this board figma.com/board/abc123, the "Home" screen's primary CTA
should read "Start free trial" everywhere it appears. Update it and re-surface affected journeys.
```

It **reads the Screen Index and current board first**, respects any edits you made directly in FigJam (it asks before changing them), and only does what you asked — it won't redraw finished journeys on its own.

**Sample run:**

> **You:** Use /thisura-wireframe to wireframe the journeys for this project in this FigJam board: figma.com/board/abc123
> **Thisura:** Quick setup first — attach your PRD, Themes & Epics, and User Journey (UX Spec optional). If T&E is Excel, which worksheet? Surface scope — mobile / desktop / both / mixed? Any journeys to exclude? State depth — key states or full edge cases?
> **You:** *(attaches docs)* Worksheet "T&E Proposal v3". Mixed — mobile app + desktop admin. Skip "Marketing site". Full edge cases.
> **Thisura:** From the docs, here's how I've split the journeys across surfaces — review and adjust. *(you approve)* And here's the Screen Index — every screen, its elements, and which journey reveals each *(you approve)* … building **Onboarding** first as a flow map in FigJam — then I'll audit it and hand it back for review.

---

## How it keeps quality up

- **One source of truth** — the `🗂 Screen Index` and master screens live in the file, so the skill reads screens rather than recalling them. No "second slightly-different Home" between journeys.
- **Consistency by derivation** — each journey's screens are *derived from a master*, so shared elements can't drift.
- **Traceability** — every screen and element traces back to an epic, requirement, or journey step; every journey is built or explicitly excluded; no orphan screens.
- **Self-audit before you see it** — each journey is checked against PRD + T&E + User Journey and fixed *before* the review stop.
- **Changes never go silent** — modifying something an earlier journey already showed ripples to every affected journey and re-surfaces them for re-review; your manual edits are detected and protected.
- **Native, tidy maps** — FigJam connectors route themselves and reflow when boxes move, so the flow stays clean instead of sprawling into long crossing lines.

---

## Troubleshooting

**It won't start / says it's missing a file.**
All three required docs (PRD, Themes & Epics, User Journey) must be attached. If T&E is a multi-sheet Excel, it also needs the worksheet name.

**`thisura-wireframe` doesn't show up when I type `/`.**
Restart Cursor (skills load on startup). Still missing? Re-run the install command, then check `ls ~/.claude/skills/thisura-wireframe` shows a `SKILL.md`.

**It says it can't write to Figma / it's read-only.**
Your Figma MCP is the read-only kind. It needs the write/authoring one to draw boxes, connectors and stickies.

**I gave it a Figma Design URL but it wanted a FigJam board.**
Stage 1 (the flow map) is built in FigJam. Give it a `figma.com/board/...` URL, or let it create a board. The Figma Design file is for Stage 2 (polished components).

**It only did one journey.**
That's by design — it builds one journey, audits it, and stops for your review. Approve it and it continues to the next.

**It asked questions instead of just drawing.**
The intake routes the whole run. Answer once and it takes over.

---

*Built as a reusable Claude skill for the UI/UX team. Hand it the docs, review one journey at a time in FigJam, then generate polished screen components once the flow is right.*
