# Thisura Skills

A small collection of reusable [Agent Skills](https://www.anthropic.com/news/skills) for our UI/UX workflow. One command installs them — no project, no repo to keep open, no setup.

## What's inside

| Skill | What it does |
|-------|--------------|
| [`thisura-hifi/`](./thisura-hifi) | Builds **production-ready high-fidelity Figma screens** from your project's planning docs (PRD, architecture, epics & stories), **one story at a time** with a review stop each round. Sets up the design-token system + a bound Style Guide page (the old `thisura-style-guide` workflow, now folded in as its first phase), builds components on demand, then assembles desktop + mobile screens from instances — with breakpoint-mode binding, AC-required states, flow annotations, a WCAG AA contrast audit, manual-edit absorption, and a build-log memory. shadcn for web, Gluestack for mobile; Tailwind v4 naming. See its [README](./thisura-hifi/README.md). |
| [`thisura-wireframe/`](./thisura-wireframe) | Wireframes your product **one user journey at a time**, from your PRD, Themes & Epics, and User Journey docs, in two modes. **Mode A (FigJam):** maps each journey as a low-fidelity flow map on a FigJam board — greyscale screen boxes, native connectors, decision diamonds, sticky-note annotations, a Section per journey. **Mode B (Figma Design):** once a flow is signed off, generates polished lo-fi **screen components** (with state variants) for you to map against the journeys. Keeps **recurring screens consistent** via a screen registry + master/snapshot derivation, with a self-audit and a review stop between journeys. See its [README](./thisura-wireframe/README.md). |

More skills may be added as sibling folders over time.

## Install (designers — no repo needed)

Paste this into Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

The installer opens an **interactive picker** — move with ↑/↓, toggle with space, and press Enter to confirm (everything is selected by default):

```
Select Thisura skills to install:
  ↑/↓ move · space toggle · a = all · enter = confirm

 › [x] all                    — install everything below
   [x] thisura-hifi           — High-fidelity Figma screens from project docs — tokens, components, screens
   [x] thisura-wireframe      — Lo-fi journey wireframes in FigJam, then lo-fi screens in Figma
```

It drops the chosen skills into `~/.claude/skills/` (creating the folder if it doesn't exist) and works with any model you use in Cursor — Claude, GPT, or Gemini. Then **restart Cursor** and type `/` in the Agent chat to confirm they loaded.

You don't need a Cursor project open, a git repo, or the Claude app installed — the skill lives at the OS level and loads on every launch.

> **Re-running the same command updates the skill** to the latest version. That's also how you pull updates later — just run it again and restart Cursor.

To skip the prompt (e.g. in a script), set `THISURA_SKILLS` — `all`, or a comma/space-separated list of skill names:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_SKILLS="thisura-wireframe" bash
```

When the command is piped without a terminal (e.g. CI) and `THISURA_SKILLS` isn't set, it installs everything.

### Pinning a specific version

The installer pulls the tip of `main` by default. To install a specific release instead, set `THISURA_REF` to a git tag:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | THISURA_REF=wireframe-v1.0.0 bash
```

After installing, the printed line shows the version, and you can always check the `version:` field at the top of each skill's `SKILL.md`.

<details>
<summary>Manual install (optional)</summary>

If you'd rather not run the script:

```bash
git clone https://github.com/RaZanjana/thisura-skills.git
cp -r thisura-skills/thisura-hifi      ~/.claude/skills/        # copy
cp -r thisura-skills/thisura-wireframe ~/.claude/skills/
# or symlink so git pull keeps them fresh:
ln -s "$(pwd)/thisura-skills/thisura-hifi"      ~/.claude/skills/thisura-hifi
ln -s "$(pwd)/thisura-skills/thisura-wireframe" ~/.claude/skills/thisura-wireframe
```
Cursor also reads `.agents/skills/` and per-project `.claude/skills/` — any of those work.
</details>

## Using a skill

Each skill has its own README with prerequisites and a sample prompt.

HiFi screens (point it at a **Figma file**; it asks you to confirm your planning docs and lock breakpoints/theme/framework as setup questions, then builds tokens + style guide, then screens story by story):

```
Use /thisura-hifi to build the HiFi screens for this project in this Figma file: [paste Figma URL]
```

Wireframes (point it at a **FigJam board**; it asks for your PRD, Themes & Epics, and User Journey docs as setup questions):

```
Use /thisura-wireframe to wireframe the journeys for this project in this FigJam board: [paste FigJam board URL]
```

Each one asks a few setup questions, then gets to work. Full details in
[`thisura-hifi/README.md`](./thisura-hifi/README.md) and
[`thisura-wireframe/README.md`](./thisura-wireframe/README.md).

## Versioning

Each skill is versioned **independently** using [Semantic Versioning](https://semver.org):

- **MAJOR** — changes that break existing prompts or change the output behavior.
- **MINOR** — new, backward-compatible capability.
- **PATCH** — layout fixes, wording, and bug fixes.

The version lives in two places that should always agree:

1. The `version:` field in each skill's `SKILL.md` (the source of truth).
2. A namespaced git tag — `hifi-vX.Y.Z` / `wireframe-vX.Y.Z`.

Each skill keeps its own history in a `CHANGELOG.md`:
[`thisura-hifi/CHANGELOG.md`](./thisura-hifi/CHANGELOG.md) and
[`thisura-wireframe/CHANGELOG.md`](./thisura-wireframe/CHANGELOG.md).

## Contributing / updating a skill

Maintainers edit the markdown, then cut a release:

```bash
# 1. Make the change (keep it scoped to one skill per commit where possible)
# 2. Bump the `version:` field in that skill's SKILL.md
# 3. Move the entry from "Unreleased" into a new version section in its CHANGELOG.md
git add .
git commit -m "wireframe: <what changed>"
git push

# 4. Tag the release (namespaced per skill) so people can pin it
git tag wireframe-v1.1.0
git push --tags
```

## License

MIT — see [LICENSE](./LICENSE).