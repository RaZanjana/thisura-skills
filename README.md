# Thisura Skills

A small collection of reusable [Agent Skills](https://www.anthropic.com/news/skills) for our UI/UX workflow. One command installs them — no project, no repo to keep open, no setup.

## What's inside

| Skill | What it does |
|-------|--------------|
| [`thisura/`](./thisura) | Builds a Figma design-token system (Primitives → Semantics), local styles, and a bound Style Guide page for dev hand-off. Tailwind v4 naming; shadcn for web, Gluestack for mobile. See its [README](./thisura/README.md). |

More skills may be added as sibling folders over time.

## Install (designers — no repo needed)

Paste this into Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

That's the whole install. It drops Thisura into `~/.claude/skills/` (creating the folder if it doesn't exist) and works with any model you use in Cursor — Claude, GPT, or Gemini. Then **restart Cursor** and type `/thisura` in the Agent chat to confirm it loaded.

You don't need a Cursor project open, a git repo, or the Claude app installed — the skill lives at the OS level and loads on every launch.

> **Re-running the same command updates the skill** to the latest version. That's also how you pull updates later — just run it again and restart Cursor.

<details>
<summary>Manual install (optional)</summary>

If you'd rather not run the script:

```bash
git clone https://github.com/RaZanjana/thisura-skills.git
cp -r thisura-skills/thisura ~/.claude/skills/        # copy
# or symlink so git pull keeps it fresh:
ln -s "$(pwd)/thisura-skills/thisura" ~/.claude/skills/thisura
```
Cursor also reads `.agents/skills/` and per-project `.claude/skills/` — any of those work.
</details>

## Using a skill

Each skill has its own README with prerequisites and a sample prompt. For Thisura:

```
Use /thisura and generate a style guide for the project in this Figma file: [paste Figma URL]
```

It'll ask a few setup questions, then build everything. Full details in [`thisura/README.md`](./thisura/README.md).

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