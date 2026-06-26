# Thisura HiFi — High-Fidelity Figma Design Builder

A Claude skill that takes your project from **requirements to production-ready, hand-off Figma
screens** — token-driven, component-based, responsive, and accessibility-checked. It sets up your
design tokens and style guide, builds components as they're needed, then assembles desktop +
mobile screens **one story at a time**, stopping for your review each round.

---

## What is Thisura HiFi?

It's the **last design stage** of a larger planning pipeline. Once your project has a brief, PRD,
architecture, and epics & stories (the BMAD/WDS planning artifacts), HiFi turns each story into a
real, bound, accessible Figma screen — and keeps everything traceable back to the requirements.

It runs the whole HiFi workflow:

1. **Foundations & tokens** — sets up your Primitives → Colors → Breakpoints variables, bound text
   and shadow styles, and a self-documenting **Style Guide** page. *(This is the old
   `thisura-style-guide` workflow, now folded in as the first phase — you don't run a separate
   skill for it.)*
2. **Components on demand** — builds only what the current story needs, with variants, interaction
   states, slots, and token bindings — and reuses aggressively.
3. **Screens** — assembles each story's desktop + mobile screens from component instances, with
   global chrome, the states the acceptance criteria call for, flow annotations, and a WCAG AA
   contrast check.

Between every story it **detects the edits you made by hand in Figma**, absorbs them, and (if
they're a general rule) promotes them to a standard applied everywhere thereafter — all tracked in
a **build-log** that acts as the workflow's memory.

---

## What it produces

| Output | Where |
|---|---|
| **Figma file with 4 pages** | Cover · 🎨 Style Guide · 🧩 Components · 🟦 Drafts |
| **Token system** | Figma variables — Primitives / Colors / Breakpoints + text & shadow styles |
| **Component library** | The `🧩 Components` board, labelled for handoff |
| **HiFi screens** | `🟦 Drafts` — desktop + mobile per story, annotated |
| **Build log** | `…/design-artifacts/figma-build-log.md` — standards, registry, story log, open items |

---

## When to use it

- You've finished planning (brief → PRD → architecture → epics & stories) and you're ready to
  **design the actual screens**.
- You want the **token + style-guide foundation set up and then screens built on top** — in one
  workflow.
- You're **continuing** a HiFi file — building the next story, with your manual edits respected.

Need **lo-fi wireframes / journey flow maps** first? That's a different skill — `thisura-wireframe`.

---

## What it does *not* do

- It **doesn't do lo-fi wireframes or flow maps** (use `thisura-wireframe`).
- It **doesn't write application code.**
- It **doesn't invent requirements** — it works from your real project docs, and won't build
  anything the PRD lists as a non-goal.
- It **only touches the Figma file you point it at.**

Ask it for something off this list and it'll stop, say so nicely, and offer to carry on with the
HiFi build.

---

## Prerequisites

1. **Cursor** (any model; tuned for Claude).
2. **Figma MCP connected — the write/authoring kind** (a read-only MCP can look but not build).
3. **Edit access** to the target Figma file.
4. **The upstream planning artifacts exist** — brief, trigger map, UX scenarios, PRD, architecture,
   epics & stories (produced by the BMAD/WDS skills). If any are missing, produce them first.
5. Values map to **Tailwind v4** — if the code repo is open, it matches the exact values devs ship.

---

## Setup (one command)

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

It drops the skill into `~/.claude/skills/`. **Restart Cursor**, then type `/` in the Agent chat to
confirm **thisura-hifi** shows up.

> **To update later:** run the same command again and restart Cursor.

---

## How to use it

Point it at your Figma file and your planning docs:

```
Use /thisura-hifi to build the HiFi screens for this project in this Figma file: [paste Figma URL]
```

It **pauses and asks a few setup questions first** (on purpose — it won't guess): confirms the
inputs exist, locks your breakpoints / theme / framework / icons / content policy, and confirms the
plan. Then it builds the tokens + style guide, stops for your review, and starts the per-story
loop — building one story, screenshotting it, and **waiting for your sign-off before the next**.

**Per-story prompt:**

> "Detect any manual changes I made and absorb them. Then build Story 2.3 desktop + mobile from
> components, content from [reference] rewritten to our narrative, cover the AC states, annotate
> desktop CTAs, AA audit to 0, update the build log, screenshot, and stop for review."

### Continuing later

Re-invoke on the same file. It reads the build log + the file live, reconciles your manual edits,
and either builds the next story or refreshes the foundations — without redoing finished work.

---

## Migrating from thisura-style-guide

The standalone `thisura-style-guide` skill is **superseded by this skill** — its entire workflow is
Phase 1 here, and it produces the same token system and Style Guide page. If you only need the
tokens + style guide (no components or screens), just stop after the Foundations phase / its review
gate.

---

*Built as a reusable Claude skill for the UI/UX team. Plan it, then build it — hand off cleaner files.*
