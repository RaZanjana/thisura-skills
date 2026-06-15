# Thisura Style Guide — Figma Design-Token & Style-Guide Builder

A little helper that turns a Figma file into a clean, dev-ready design system — variables, styles, and a bound style guide — so hand-off stops being a copy-paste chore.

---

## What is Thisura?

Thisura is a Claude skill you run inside Cursor. Point it at a Figma file and it sets up a proper two-tier token system (raw values → semantic tokens), the matching text and shadow styles, and a self-documenting **Style Guide** page. The whole thing is named to **Tailwind v4** standards, themed with **shadcn** for web and **Gluestack** for mobile.

The point: instead of hand-building variables and a style guide every project, you run one command, answer a few questions, and get a consistent, bound, hand-off-ready file every time.

---

## What it produces

After a run, your Figma file will have:

- **A `Primitives` collection** — the raw material: Tailwind colour ramps, raw pixel values, and an `opacity/*` scale. Tokens are *unscoped* (plumbing, referenced not picked) — except opacity, which you apply directly. Raw Tailwind ramps aren't shown in the style guide, but your **brand ramps are documented** there.
- **A `Colors` collection** — two groups: `Theme` (the platform set — shadcn roles like `background`/`primary`/`muted-foreground` for web, or Gluestack scales like `primary/500`/`typography/900` for mobile) and `Other` (extra colours **plus alpha colours** for overlays, scrims, and shadow tint). Light mode always, Dark if needed.
- **A `Breakpoints` collection** — everything responsive, with device modes (web: Large Desktop / Standard Desktop / Tablet / Mobile; mobile app: Tablet / Mobile): spacing, radius, and typography. The values **genuinely change per mode**.
- **Local styles** — text styles with font/size/weight **bound to variables** (line-height set as a % so it scales), plus **soft, low-opacity shadow** effect styles tinted from an alpha colour.
- **A `🎨 Style Guide` page** — a **swatch-grid of colour cards** (grouped by role), brand ramps, alpha/opacity on a checkerboard, type ramp, per-breakpoint tables for type/spacing/radius, and shadow specimens — all bound to the tokens. This is your dev contract, and you can **refresh it anytime** (see below) without hand-editing.

---

## When to use it

Reach for Thisura whenever you're starting the token/style-guide groundwork on a Figma file. For example:

- **New project, building the foundation** — you've got a fresh file and need variables + a style guide before screens start.
- **Web app** → it themes with shadcn. **Mobile app** → it themes with Gluestack. Same skill, you just tell it which.
- **Client *has* a brand guide** → it pulls the colours/fonts from the document and fills in the rest.
- **Client *has no* brand guide** → it proposes a palette and font, you approve, and it builds a Tailwind-structured brand ramp for you.
- **You want a proper dev hand-off** — the bound style-guide page is made for exactly this.

If you're setting up tokens by hand right now, that's the moment to let Thisura do it instead.

---

## What it does *not* do

Worth knowing up front so you're not waiting on something that isn't coming:

- It **doesn't build components, screens, or layouts.**
- It **doesn't write code** (React, NativeWind, CSS — none of it).
- It **doesn't make UX calls** beyond proposing a palette/tokens.
- It **only touches the Figma file you point it at** — nothing else.

If you ask it for something off this list, it'll stop, tell you nicely, and offer to carry on with the token setup. It won't half-do the wrong thing.

---

## Prerequisites

A few things need to be in place first:

1. **Cursor** (any model works — Claude, GPT, or Gemini; the skill is written and tuned for Claude, so that's the smoothest).
2. **Figma MCP connected to Cursor — and it must be the write/authoring kind.** This is the one that trips people up: a read-only Figma MCP can *look* at a file but can't *create* variables and styles. If Thisura says it can't write, this is why.
3. **Edit access** to the target Figma file (you need to be able to write to it).
4. Values map to **Tailwind v4** — if a code repo is open, even better, because Thisura can match the exact values your devs ship.

---

## Setup (one command)

Paste this into Terminal — that's the entire install:

```bash
curl -fsSL https://raw.githubusercontent.com/RaZanjana/thisura-skills/main/install.sh | bash
```

It drops Thisura into `~/.claude/skills/` (creating the folder if it's not there), so it's available in Cursor no matter what you're working on — no project, no repo, no Claude app required. Then **restart Cursor** and type `/` in the Agent chat to confirm **thisura** shows up.

> **To update later:** run the same command again and restart Cursor. It always pulls the latest version.

<details>
<summary>Manual install (optional)</summary>

```bash
git clone https://github.com/RaZanjana/thisura-skills.git
cp -r thisura-skills/thisura-style-guide ~/.claude/skills/
```
Cursor also reads `.agents/skills/` and per-project `.claude/skills/` if you prefer one of those.
</details>

---

## How to use it

In the Agent chat, call it and point it at your file:

```
Use /thisura-style-guide and generate a style guide for the project in this Figma file: [paste Figma URL]
```

That's it. Thisura then **pauses and asks you a few quick questions first** (this is on purpose — it won't guess). Expect:

- **Platform** — web or mobile? (decides shadcn vs Gluestack)
- **Brand guide?** — if yes, it'll ask for the doc path/URL; if no, it'll propose a palette + font for you to approve.
- **Dark mode this project?** — yes adds a Dark mode, no keeps it light-only.
- **Anything special?** — an open slot for extra requests (an extra palette, a specific font, naming tweaks).

Answer those, approve anything it proposes, and it builds everything, then gives you a short summary of what it created. You can also force it anytime by just typing `/thisura-style-guide` and describing what you want.

**Sample run:**

> **You:** Use /thisura-style-guide and generate a style guide for the project in this Figma file: figma.com/file/abc123
> **Thisura:** Quick setup first — is this web or mobile? Do you have a brand guide? Dark mode in scope? Anything special for this run?
> **You:** Mobile, no brand guide, light only. Primary should be around #2563EB.
> **Thisura:** Here's the proposed palette + brand ramp from that blue — look good? *(you approve)* …building Primitives, Gluestack semantics, styles, and the Style Guide page.

### Updating the style guide later

When you tweak variables or styles, you don't rebuild the page by hand. Re-invoke on the same file:

```
/thisura-style-guide — refresh the style guide in this file: [Figma URL]
```

It notices the file already has the collections and a `🎨 Style Guide` page, reads your current
variables and styles live, and **rebuilds the page from the same template** — identical layout,
updated values. It'll also tell you what changed (new/renamed/removed tokens). The variables stay
the single source of truth, so the doc never drifts.

---

## Customizing & extending

Once Thisura has run, there are three spots you're meant to own and adjust as the project moves. This is the "okay, it's done — what's mine now?" part.

### 1. The `Colors / Other` group

Thisura only creates the standard theming set under `Colors/Theme` (shadcn roles for web, Gluestack scales for mobile). Anything beyond that lands in the empty `Colors/Other` group that you fill in yourself as needs come up.

**Example:** You set up tokens for a fintech web app. Two sprints later the product needs `success` and `warning` states, plus a `chart-positive` / `chart-negative` pair — none of which are in shadcn's defaults. Instead of messing with the theme tokens or dropping in raw hex, you add them under `Colors/Other` and still alias them back to the Tailwind primitives (`green/600`, `amber/500`). One rule to keep: **`Other` tokens must still point at a primitive, never a raw value** — that's what keeps the system consistent.

### 2. The brand ramp(s)

Thisura reads the **whole** brand guide, not just the logo. If the guide has several brand colours, it captures all of them — following the guide's documented usage if it states roles, otherwise inferring primary / secondary / tertiary — and builds a full `brand/50…950`, `brand-secondary/50…950`, etc. ramp for each. A single-colour guide (or no guide) just produces `brand/`.

**Example:** A client's guide lists three colours — a logo blue, an orange "accent for CTAs", and a dark slate. Thisura maps blue → `brand/` (primary), orange → `brand-secondary/` (the guide flagged it for CTAs), slate → `brand-tertiary/`, and generates a 50–950 ramp for each, shown for approval. If you think the `900`/`950` end of one looks muddy, nudge those steps before approving — the ramps are yours to tweak.

### 3. Sourced vs. fixed values

By default, if a code repo is open, Thisura pulls exact token values from the project's own Tailwind/shadcn/Gluestack build — so your Figma matches exactly what devs ship. If there's no repo, it uses the standard canonical Tailwind v4 values instead.

**Example:** You're designing *before* any code exists (design-first project). No repo to read from, so Thisura uses canonical Tailwind values — perfect for now. Later, once devs scaffold the project with their customized Tailwind theme, you re-run Thisura against the repo so the Figma tokens snap to the real shipped values. Just know which situation you're in: **no repo = canonical values, repo open = matched values.**

---

## Troubleshooting

**Thisura doesn't show up when I type `/`.**
First, restart Cursor — skills only load on startup. If it's still missing, the install didn't land: re-run the install command, then check the folder exists with `ls ~/.claude/skills/thisura-style-guide` (you should see `SKILL.md` inside).

**It says it can't write to Figma / it's read-only.**
Your Figma MCP is the read-only kind. Thisura needs a **write/authoring** Figma MCP to create variables and styles. Swap to that one in your MCP setup.

**No dark mode got created.**
Dark mode only happens if you say yes during the intake questions. Re-run and answer "yes" to the dark-mode question.

**The colours don't match our code.**
You probably ran it with no repo open, so it used canonical values. Open the project repo and re-run so it sources the real values (see "Sourced vs. fixed values" above).

**It asked me a bunch of questions instead of just doing it.**
That's by design — the intake questions are how it routes the whole run. Answer them once and it takes over from there.

---

*Built as a reusable Claude skill for the UI/UX team. Drop it in, run it, hand off cleaner files.*