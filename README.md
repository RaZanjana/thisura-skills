# Thisura Skills

A small collection of reusable [Claude skills](https://www.anthropic.com/news/skills) for our UI/UX workflow. Clone it, drop a skill into your agent's skills folder, and go.

## What's inside

| Skill | What it does |
|-------|--------------|
| [`thisura/`](./thisura) | Builds a Figma design-token system (Primitives → Semantics), local styles, and a bound Style Guide page for dev hand-off. Tailwind v4 naming; shadcn for web, Gluestack for mobile. See its [README](./thisura/README.md). |

More skills may be added as sibling folders over time.

## Install a skill

These skills work in Cursor, Claude Code, and any agent that supports the Agent Skills standard. Pick one of the two methods:

**Quick copy**
```bash
git clone https://github.com/RaZanjana/thisura-skills.git
cp -r thisura-skills/thisura ~/.claude/skills/        # personal (all projects)
# or into a single project:
cp -r thisura-skills/thisura /path/to/project/.claude/skills/
```

**Symlink (auto-updates with `git pull`)**
```bash
git clone https://github.com/RaZanjana/thisura-skills.git
ln -s "$(pwd)/thisura-skills/thisura" ~/.claude/skills/thisura
```

Cursor also reads `.agents/skills/` — either location works. Restart Cursor after installing, then type `/` in the Agent chat and search for the skill name to confirm it loaded.

## Using a skill

Each skill has its own README with prerequisites and a sample prompt. For Thisura:

```
Use /thisura and generate a style guide for the project in this Figma file: [paste Figma URL]
```

It'll ask a few setup questions, then build everything. Full details in [`thisura/README.md`](./thisura/README.md).

## Updating

- Pull the latest: `git pull`. If you installed via **symlink**, your skill updates automatically. If you **copied**, re-copy the folder.
- Versions are tagged (e.g. `v1.0.0`). Pin to one with `git checkout v1.0.0` if you need stability.

## Contributing

Edit the markdown, commit, and push. Keep changes scoped to one skill per commit where possible, tag releases, and note what changed.

## License

MIT — see [LICENSE](./LICENSE).
