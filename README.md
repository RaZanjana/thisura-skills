# Thisura Skills

Design helpers you run in **Cursor**. They read your project’s planning docs and draw in **FigJam** / **Figma** — so you spend time reviewing flows and screens, not rebuilding them from scratch.

## The simple pipeline

1. **Plan the product** (with your usual BMAD / planning process) — brief, PRD, journeys, epics & stories.  
2. **Map the journeys** → `/thisura-wireframe` (FigJam flow maps; optional lo-fi screens after sign-off).  
3. **Design the real screens** → `/thisura-hifi` (tokens, components, desktop + mobile, one story at a time).  
4. **Build in code** (your engineering team).

You don’t need to hand-feed every file path. If the project already has planning docs, the skills **look for them** and ask you to confirm.

## What’s inside

| Skill | What you get |
|-------|----------------|
| [**thisura-wireframe**](./thisura-wireframe) | Lo-fi **journey maps in FigJam** (one journey at a time). After you approve a flow, optional **lo-fi screen components** in Figma. |
| [**thisura-hifi**](./thisura-hifi) | **High-fidelity Figma screens**: design tokens + style guide, then components, then desktop + mobile screens — **one story at a time**, with a review stop each round. |

## Install (designers)

Paste this into Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

Pick which skills to install (everything is selected by default), then **restart Cursor**. Type `/` in Agent chat and look for `thisura-wireframe` and `thisura-hifi`.

> Re-run the same command anytime to update. Restart Cursor after updating.

<details>
<summary>Other install options</summary>

Skip the picker (scripts / CI):

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_SKILLS="all" bash
```

Pin a version:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_REF=wireframe-v1.1.0 bash
```

Manual copy or symlink from this repo into `~/.claude/skills/` also works. Cursor also reads `.agents/skills/` and per-project `.claude/skills/`.
</details>

## How to start a session

**Journeys (FigJam):**

```
Use /thisura-wireframe to wireframe the journeys for this project in this FigJam board: [paste board URL]
```

**Hi-fi screens (Figma):**

```
Use /thisura-hifi to build the HiFi screens for this project in this Figma file: [paste Figma URL]
```

Each skill will look for your planning docs, confirm what it found, ask a few short setup questions, then start. Full walkthroughs: [wireframe README](./thisura-wireframe/README.md) · [hifi README](./thisura-hifi/README.md).

## What you need ready

| For wireframe | For hi-fi |
|---------------|-----------|
| PRD | Brand direction (or UX look-and-feel notes) |
| Epics & stories (or an older Themes & Epics file) | Architecture notes *or* tell it web vs mobile |
| Journeys / scenarios | The story you’re designing next + PRD |
| A FigJam board (or let it create one) | A Figma file (or let it create one) |

Best path for hi-fi: journeys already signed off in FigJam first.

## Versioning & contributing

Each skill has its own version and [CHANGELOG](./thisura-wireframe/CHANGELOG.md). Maintainers: keep `adapters/bmad-inputs.md` in sync across the repo root and both skill folders when you change how docs are found.

## License

MIT — see [LICENSE](./LICENSE).
