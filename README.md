# Thisura Skills

A small collection of reusable [Agent Skills](https://www.anthropic.com/news/skills) for our UI/UX workflow. One command installs them — no project, no repo to keep open, no setup.

## What's inside

| Skill | What it does |
|-------|--------------|
| [`thisura-style-guide/`](./thisura-style-guide) | Builds a Figma design-token system (Primitives, Colors, Breakpoints), local styles, and a bound Style Guide page for dev hand-off. Tailwind v4 naming; shadcn for web, Gluestack for mobile. See its [README](./thisura-style-guide/README.md). |
| [`thisura-wireframe/`](./thisura-wireframe) | Generates low-fidelity wireframes in a Figma file, **one user journey at a time**, from your PRD, Themes & Epics, and User Journey docs. Greyscale screens, flowchart-style arrows, Dev Mode annotations, a Section per journey. Keeps **recurring screens consistent** across journeys via a screen registry + master/snapshot derivation (placeholders reveal as each journey introduces them), with a self-audit and a review stop between journeys. See its [README](./thisura-wireframe/README.md). |

More skills may be added as sibling folders over time.

## Install (designers — no repo needed)

Paste this into Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

That's the whole install. It drops the Thisura skills into `~/.claude/skills/` (creating the folder if it doesn't exist) and works with any model you use in Cursor — Claude, GPT, or Gemini. Then **restart Cursor** and type `/` in the Agent chat to confirm `thisura-style-guide` and `thisura-wireframe` loaded.

You don't need a Cursor project open, a git repo, or the Claude app installed — the skill lives at the OS level and loads on every launch.

> **Re-running the same command updates the skill** to the latest version. That's also how you pull updates later — just run it again and restart Cursor.

<details>
<summary>Manual install (optional)</summary>

If you'd rather not run the script:

```bash
git clone https://github.com/RaZanjana/thisura-skills.git
cp -r thisura-skills/thisura-style-guide ~/.claude/skills/        # copy
cp -r thisura-skills/thisura-wireframe   ~/.claude/skills/
# or symlink so git pull keeps them fresh:
ln -s "$(pwd)/thisura-skills/thisura-style-guide" ~/.claude/skills/thisura-style-guide
ln -s "$(pwd)/thisura-skills/thisura-wireframe"   ~/.claude/skills/thisura-wireframe
```
Cursor also reads `.agents/skills/` and per-project `.claude/skills/` — any of those work.
</details>

## Using a skill

Each skill has its own README with prerequisites and a sample prompt.

Style guide:

```
Use /thisura-style-guide and generate a style guide for the project in this Figma file: [paste Figma URL]
```

Wireframes (it asks for your PRD, Themes & Epics, and User Journey docs as setup questions):

```
Use /thisura-wireframe to wireframe the journeys for this project in this Figma file: [paste Figma URL]
```

Each one asks a few setup questions, then gets to work. Full details in
[`thisura-style-guide/README.md`](./thisura-style-guide/README.md) and
[`thisura-wireframe/README.md`](./thisura-wireframe/README.md).

## Contributing / updating the skill

Maintainers edit the markdown, commit, and push:

```bash
git add .
git commit -m "what changed"
git push
```

Keep changes scoped to one skill per commit where possible, and tag releases (`git tag v1.1.0 && git push --tags`) so people can pin a version.

## License

MIT — see [LICENSE](./LICENSE).