# Thisura Wireframe — Journey-by-Journey Lo-Fi Builder

A helper that turns your project's planning docs into low-fidelity wireframes in Figma — real flow, real labels where they matter, arrows, annotations — built **one user journey at a time** so each one is reviewable before the next.

---

## What is it?

Thisura Wireframe is a Claude skill you run inside Cursor. Point it at a Figma file, hand it the project docs, and it wireframes the product **journey by journey**: each journey becomes its own Figma **Section**, filled with greyscale screens, mapped with flowchart-style arrows, and annotated for dev hand-off. After each journey it **audits its own work against your docs, fixes what's off, then stops and asks you to review** before moving to the next one.

The point: instead of hand-drawing every screen and wiring every arrow after a kickoff, you run one command, answer a few questions, and get a structured lo-fi flow you can walk a client through — without losing control of scope or fidelity.

---

## What it produces

For each in-scope journey, your Figma file gets:

- **A Section named after the journey** — its own non-overlapping region of the canvas, holding everything for that journey.
- **Greyscale lo-fi screens** at the right device size (mobile 375×812, desktop 1440×1024), drawn from consistent element specs so every screen matches. **Real copy only on the elements that carry meaning** (CTAs, nav, titles, field labels, error/empty messages) — everything else is greeked so no one mistakes it for final content.
- **A mapped flow** — proper flowchart symbols (start/end terminators, decision diamonds at branches) and **labeled arrows** showing every path, including back/cancel/skip and the routes into error/empty states.
- **Dev Mode annotations** — categorized notes (Navigation, State, Content, Interaction) attached to the screens for the dev hand-off.
- **A self-audit per journey** — checked back against the PRD, Themes & Epics, and User Journey map, with issues fixed *before* it asks you to look.

Plus, behind the journeys, two things that keep recurring screens consistent:

- **A `🗂 Screen Index`** — the registry of every screen and element, which journey reveals each, and its status. This is the source of truth, so the skill never "remembers" a screen from chat — it reads it.
- **A `🧩 Master Screens`** area — one canonical master per screen; each journey's copy is *derived* from its master, so the same screen never drifts between journeys.

### How recurring screens work (read this — it's the important bit)

A screen isn't owned by one journey. The same Home (say) shows up in several journeys, and each journey may add to it — a button, a section, an image. The skill handles this so it stays clean:

- It keeps **one master** of each screen with the full, latest content.
- Each journey shows a **snapshot** of that screen — the elements revealed *so far* (by journeys up to this one, in file order), with everything a later journey will add shown as a **reserved placeholder** (a dashed grey slot labelled with what it'll become and which journey reveals it).
- When a later journey **reveals** an element, the placeholder is swapped in place — the layout never shifts.
- If a later journey **changes** something an earlier journey already showed, the skill updates the master and **ripples** the change to every affected journey, then re-surfaces those for your re-review — never silently.
- If you **hand-edit** a screen in Figma, the skill detects it and asks whether to make it canonical (ripple it) or keep it as a local override — it never overwrites your edit.

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
- You need a client to see structure and flow quickly to confirm scope.
- The product is mobile, desktop, both, or mixed (e.g. a mobile app **plus** a desktop admin) — it handles the surface split per journey.

For a single-screen change, it's overkill — do that by hand.

---

## What it does *not* do

- It **doesn't build hi-fi UI, real components, or layouts** you'd ship.
- It **doesn't set up a design system or tokens** — that's [`/thisura-style-guide`](../thisura-style-guide).
- It **doesn't write code.**
- It **won't invent** features, screens, or requirements that aren't in your docs.
- It **only touches the Figma file you point it at.**

Ask it for something off this list and it'll stop, say so nicely, and offer to carry on wireframing.

---

## Prerequisites

1. **Cursor** (any model; tuned for Claude).
2. **Figma MCP connected to Cursor — the write/authoring kind.** A read-only MCP can look but can't draw. If it says it can't write, this is why.
3. **Edit access** to the target Figma file.
4. **Fonts available in the file:** **Inter** (Figma default) for meaningful copy, and **Flow Circular** (Dan Ross — free on Google Fonts) for placeholder/greeked text. If Flow Circular isn't present it falls back to Inter Italic and tells you.

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

In the Agent chat, call it and point it at your file — that's all you need:

```
Use /thisura-wireframe to wireframe the journeys for this project in this Figma file: [Your Figma file]
```

You don't put the docs or scope in the prompt. Like `/thisura-style-guide`, it **pauses and asks a few setup questions first** — each with suggested answers to pick from, plus a free-text option for anything custom:

- **Figma file & page** — confirms the URL and target page (a fresh page, not an existing one).
- **The docs** — asks you to attach PRD, Themes & Epics, and User Journey (UX Spec optional); **if T&E is Excel, which worksheet**.
- **Surface scope** — mobile / desktop / both / mixed. If it's mixed, you don't sort the journeys yourself — it **works out which journeys are mobile vs desktop from your docs and shows you the map to review and approve**.
- **Journeys to exclude** — it already has the journey list from your file, so it only asks which (if any) to skip.
- **State depth** — happy path + key states, or the full edge-case set (empty / loading / error / success / validation / permission / offline).
- **Anything special?** — an open slot.

Mode (fresh build) and review-copy language (English) default — it confirms rather than asks.

Then it shows you the **Screen Index** — every screen, its elements, and which journey reveals each — for approval. Once you're happy, it builds **the first journey**, audits it, and **stops for your review**. Approve or refine, and it moves to the next — and so on through the project.

### Updating prompt (continue or change later)

Re-invoke on the same file. Continue to the next journey:

```
Use /thisura-wireframe on this file: figma.com/file/abc123 — continue with the next journey.
```

Change something that's already drawn (this triggers the ripple + re-review):

```
/thisura-wireframe — in this file figma.com/file/abc123, the "Home" screen's primary CTA
should read "Start free trial" everywhere it appears. Update it and re-surface affected journeys.
```

It **reads the Screen Index and current canvas first**, respects any edits you made directly in Figma (it asks before changing them), and only does what you asked — it won't redraw finished journeys on its own.

**Sample run:**

> **You:** Use /thisura-wireframe to wireframe the journeys for this project in this Figma file: figma.com/file/abc123
> **Thisura:** Quick setup first — attach your PRD, Themes & Epics, and User Journey (UX Spec optional). If T&E is Excel, which worksheet? Surface scope — mobile / desktop / both / mixed? Any journeys to exclude? State depth — key states or full edge cases?
> **You:** *(attaches docs)* Worksheet "T&E Proposal v3". Mixed — mobile app + desktop admin. Skip "Marketing site". Full edge cases.
> **Thisura:** From the docs, here's how I've split the journeys across surfaces (mobile vs desktop) — review and adjust. *(you approve)* And here's the Screen Index — every screen, its elements, and which journey reveals each *(you approve)* … building **Onboarding** first, deriving its screens from the masters — then I'll audit it and hand it back for review.

---

## How it keeps quality up

- **One source of truth** — the `🗂 Screen Index` and master screens live in the file, so the skill reads screens rather than recalling them. No "second slightly-different Home" between journeys.
- **Consistency by derivation** — each journey's screens are *derived from a master*, so shared elements can't drift; revealing a later element is an in-place swap, so layouts don't shift.
- **Traceability** — every screen and element traces back to an epic, requirement, or journey step; every journey is built or explicitly excluded; no orphan screens; no unrevealed placeholder.
- **Self-audit before you see it** — each journey is checked against PRD + T&E + User Journey and fixed *before* the review stop, so your review is about judgement, not catching misses.
- **Changes never go silent** — modifying something an earlier journey already showed ripples to every affected journey and re-surfaces them for re-review; your manual edits are detected and protected.
- **No-overlap canvas** — Sections are placed by measuring what's already there, so journeys never collide and frames don't crop.

---

## Troubleshooting

**It won't start / says it's missing a file.**
All three required docs (PRD, Themes & Epics, User Journey) must be attached. If T&E is a multi-sheet Excel, it also needs the worksheet name.

**`thisura-wireframe` doesn't show up when I type `/`.**
Restart Cursor (skills load on startup). Still missing? Re-run the install command, then check `ls ~/.claude/skills/thisura-wireframe` shows a `SKILL.md`.

**It says it can't write to Figma / it's read-only.**
Your Figma MCP is the read-only kind. It needs the write/authoring one to draw frames and annotations.

**The placeholder text looks like normal italics, not the squiggly font.**
Flow Circular isn't installed in the file, so it fell back to Inter Italic. Add Flow Circular (Google Fonts) to the file and re-run for the intended greeking.

**It only did one journey.**
That's by design — it builds one journey, audits it, and stops for your review. Approve it and it continues to the next.

**It asked questions instead of just drawing.**
The intake routes the whole run. Answer once and it takes over.

---

*Built as a reusable Claude skill for the UI/UX team. Hand it the docs, review one journey at a time, walk the client through a real flow.*