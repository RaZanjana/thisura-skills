# Thisura Wireframe

Turn your planning docs into **clear journey maps in FigJam** — one journey at a time — so you and your client can agree on the flow before anyone invests in polished UI.

After a journey is signed off, you can optionally generate **lo-fi screen components** in a Figma Design file to place against those maps.

---

## When to use it

- You’ve finished (or mostly finished) planning: PRD, epics & stories, journeys/scenarios.  
- You need a **client-ready walkthrough** of screens and paths — not pretty UI yet.  
- The product has more than a couple of screens, or spans **mobile, desktop, or both**.

Skip it for a one-screen tweak — that’s faster by hand.

---

## What you’ll get

### Stage 1 — Flow map (FigJam) — default
For each journey you approve into scope:

- Its own **Section** on the board  
- Greyscale **screen boxes** (title + the important bits on that screen)  
- **Arrows**, **decision diamonds**, and **start/end** markers  
- **Sticky notes** for hand-off tips  
- A quick **self-check against your docs** (fixes issues before it asks you to review)

It **stops after each journey** so you can review and refine before the next one.

### Stage 2 — Lo-fi screens (Figma Design) — optional, after sign-off
- A **component per screen** (with useful states), ready for you to instance onto the journey maps yourself  
- It does **not** lay out the full flow in Design — FigJam stays the map

Recurring screens (e.g. Home in several journeys) stay consistent via a **Screen Index** and master copies on the board.

---

## What you need ready

The skill **looks for docs in your project** when you’ve used BMAD / normal planning folders. It then asks: “I found these — sound right?”

| Need | Usually means |
|------|----------------|
| **PRD** | Your requirements doc |
| **Epics & stories** | The feature list from planning (older “Themes & Epics” Excel still works) |
| **Journeys / scenarios** | The paths users take (often from your scenario pack) |
| **FigJam board** | Where the flow map will live (it can create one) |

**Optional:** extra UX notes (how screens should behave / look). Without them, it leans on the PRD + journeys and tells you.

**For Stage 2 only:** a Figma Design file URL.

You also need **Cursor**, a **Figma connection that can write** (not read-only), and edit access to the board/file.

---

## How to run it

### New board / first journey

```
Use /thisura-wireframe to wireframe the journeys for this project in this FigJam board: [Your FigJam board URL]
```

What happens next (in plain terms):

1. It finds (or asks for) your PRD, epics & stories, and journeys.  
2. You confirm devices (mobile / desktop / both) and how many edge-case states to show.  
3. You approve the **list of screens** before anything is drawn.  
4. It draws **the first journey**, checks it, and **waits for your review**.  
5. You say go → next journey. When a journey is signed off, it can note that for later hi-fi work.

### After a journey is approved — lo-fi components

```
/thisura-wireframe — the "Onboarding" flow is approved. Generate the lo-fi screen components in this Figma Design file: [Your Figma Design URL]
```

### Continue later

```
Use /thisura-wireframe on this board: [FigJam URL] — continue with the next journey.
```

If you edited boxes yourself in FigJam, it notices and asks whether to keep your edit as the new default everywhere or only on that journey.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

Restart Cursor, then type `/` and pick **thisura-wireframe**.

---

## What it doesn’t do

- Hi-fi UI, design tokens, or a full design system → use [`/thisura-hifi`](../thisura-hifi)  
- Write app code  
- Invent features that aren’t in your docs  
- Touch files you didn’t point it at  

---

## Quick troubleshooting

| Situation | Try this |
|-----------|----------|
| Won’t start — missing docs | Confirm PRD + epics/stories + journeys (or attach them). For multi-sheet Excel, name the sheet. |
| Skill missing in `/` | Restart Cursor; re-run install if needed. |
| Can’t draw / read-only | Switch to a Figma MCP that **can write**. |
| Gave a Design URL but it wants FigJam | Stage 1 needs `figma.com/board/...`. Design files are for Stage 2. |
| Only one journey appeared | That’s intentional — review it, then continue. |

---

*Hand it the board URL, confirm the docs it found, review one journey at a time.*
