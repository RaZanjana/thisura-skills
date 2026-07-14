# Thisura HiFi

Build **production-ready screens in Figma** from your project’s planning docs: design tokens and a style guide first, then components, then **desktop + mobile screens — one story at a time**, with a review stop every round.

This is the step **after** journeys are clear (ideally after [`/thisura-wireframe`](../thisura-wireframe) sign-off).

---

## When to use it

- Planning is in good shape (PRD, stories, and usually brand / architecture notes).  
- You’re ready for **real UI** — not just flow boxes.  
- You’re **continuing** an existing HiFi file and want the next story built without redoing finished work.

Need journey maps first? Use `/thisura-wireframe`.

---

## What you’ll get

| Deliverable | Where |
|-------------|--------|
| Tokens + **Style Guide** | Figma variables + a Style Guide page |
| **Components** as you need them | Components page |
| **Hi-fi screens** (desktop + mobile) | Drafts page, annotated for hand-off |
| Running notes | A build log in your design-artifacts folder |

Each story: build → accessibility check → **you review** → only then the next story.

Your **hand edits in Figma** are noticed next time — it asks whether to make them the new rule everywhere.

---

## What you need ready

The skill **looks for docs in your project** and confirms what it found. You don’t need every planning doc on day one.

### To start tokens & style guide
- Brand direction (brand manual, brief notes, or UX look-and-feel doc)  
- Architecture notes **or** tell it: web vs mobile  

### To build the first screen
- The above (or tokens already in the file)  
- **That story’s** file from the sprint list  
- Your **PRD** (so out-of-scope items stay out)

### For the best result (recommended, not a hard wall)
- Journeys signed off in FigJam  
- UX look-and-feel / behaviour notes  
- A reference or live site for real content  

Also: **Cursor**, a **Figma connection that can write**, and edit access to the file.

---

## How to run it

```
Use /thisura-hifi to build the HiFi screens for this project in this Figma file: [paste Figma URL]
```

What happens next:

1. It finds your planning docs and tells you what it will use.  
2. You lock a few choices (breakpoints, light/dark, web vs mobile, icons).  
3. It builds **tokens + style guide** and pauses for your review.  
4. It builds **one story** (desktop + mobile), checks contrast, and **stops for your sign-off**.  
5. Approve → next story. Come back another day — it picks up where you left off.

### Continue later

Same prompt on the same file. It reads the build log, respects your manual Figma edits, and continues with the next unfinished story.

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

Restart Cursor, then type `/` and pick **thisura-hifi**.

---

## What it doesn’t do

- Lo-fi journey maps → `/thisura-wireframe`  
- Write application code  
- Invent requirements or build things the PRD marks as out of scope  
- Touch any Figma file you didn’t point it at  

---

## Note on the old style-guide skill

The separate `thisura-style-guide` skill is **folded into this one**. If you only need tokens + style guide, stop after that first review — you don’t need a second skill.

---

*Point it at your Figma file, confirm the docs it found, review every story before the next.*
