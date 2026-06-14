# Thisura — Figma Design-Token & Style-Guide Builder

A little helper that turns a Figma file into a clean, dev-ready design system — variables, styles, and a bound style guide — so hand-off stops being a copy-paste chore.

---

## What is Thisura?

Thisura is a Claude skill you run inside Cursor. Point it at a Figma file and it sets up a proper two-tier token system (raw values → semantic tokens), the matching text and shadow styles, and a self-documenting **Style Guide** page. The whole thing is named to **Tailwind v4** standards, themed with **shadcn** for web and **Gluestack** for mobile.

The point: instead of hand-building variables and a style guide every project, you run one command, answer a few questions, and get a consistent, bound, hand-off-ready file every time.

---

## What it produces

After a run, your Figma file will have:

- **A `Primitives` collection** — the raw material: Tailwind color ramps and raw pixel values. (This is plumbing; it's not shown in the style guide.)
- **A `Semantics` collection** — the tokens you actually design with. Web gets shadcn roles (`background`, `primary`, `muted-foreground`, …); mobile gets Gluestack scales (`primary/500`, `background/0`, `typography/900`, …). Light mode always, Dark mode if the project needs it.
- **Local styles** — text styles on the type scale + the Tailwind shadow scale, bound to your variables.
- **A `🎨 Style Guide` page** — colour swatches, type ramp, spacing, radius, and shadows, all bound to the tokens so it updates itself. This is your dev contract.

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

1. **Cursor**, running a **Claude model** (you've already got this on the team account).
2. **Figma MCP connected to Cursor — and it must be the write/authoring kind.** This is the one that trips people up: a read-only Figma MCP can *look* at a file but can't *create* variables and styles. If Thisura says it can't write, this is why.
3. **Edit access** to the target Figma file (you need to be able to write to it).
4. Values map to **Tailwind v4** — if a code repo is open, even better, because Thisura can match the exact values your devs ship.

---

## Setup (Cursor)

One-time setup:

1. Drop the whole `thisura/` folder into your project's skills directory — either `.claude/skills/` or `.agents/skills/`. So you'll end up with:
   ```
   your-project/
   └── .claude/
       └── skills/
           └── thisura/
               ├── SKILL.md
               ├── primitives.md
               ├── web-shadcn.md
               └── mobile-gluestack.md
   ```
2. Cursor discovers skills automatically when it starts — no config needed. (If it was already open, restart or reload it.)
3. To check it loaded: type `/` in the Agent chat and search for **thisura**. If it shows up, you're good.

> Tip: commit the `thisura/` folder to the repo so the whole team gets it automatically — no one has to set it up twice.

---

## How to use it

In the Agent chat, call it and point it at your file:

```
Use /thisura and generate a style guide for the project in this Figma file: [paste Figma URL]
```

That's it. Thisura then **pauses and asks you a few quick questions first** (this is on purpose — it won't guess). Expect:

- **Platform** — web or mobile? (decides shadcn vs Gluestack)
- **Brand guide?** — if yes, it'll ask for the doc path/URL; if no, it'll propose a palette + font for you to approve.
- **Dark mode this project?** — yes adds a Dark mode, no keeps it light-only.
- **Anything special?** — an open slot for extra requests (an extra palette, a specific font, naming tweaks).

Answer those, approve anything it proposes, and it builds everything, then gives you a short summary of what it created. You can also force it anytime by just typing `/thisura` and describing what you want.

**Sample run:**

> **You:** Use /thisura and generate a style guide for the project in this Figma file: figma.com/file/abc123
> **Thisura:** Quick setup first — is this web or mobile? Do you have a brand guide? Dark mode in scope? Anything special for this run?
> **You:** Mobile, no brand guide, light only. Primary should be around #2563EB.
> **Thisura:** Here's the proposed palette + brand ramp from that blue — look good? *(you approve)* …building Primitives, Gluestack semantics, styles, and the Style Guide page.

---

## Customizing & extending

Once Thisura has run, there are three spots you're meant to own and adjust as the project moves. This is the "okay, it's done — what's mine now?" part.

### 1. The `semantic/extended/` group

Thisura only creates the standard theming set (shadcn roles for web, Gluestack scales for mobile). Anything beyond that lands in an empty `semantic/extended/` group that you fill in yourself as needs come up.

**Example:** You set up tokens for a fintech web app. Two sprints later the product needs `success` and `warning` states, plus a `chart-positive` / `chart-negative` pair — none of which are in shadcn's defaults. Instead of messing with the core tokens or dropping in raw hex, you add them under `extended/` and still alias them back to primitives (`green/600`, `amber/500`). One rule to keep: **extended tokens must still point at a primitive, never a raw value** — that's what keeps the system consistent.

### 2. The brand ramp

When there's no brand guide, Thisura builds a full Tailwind-style `color/brand/50…950` ramp from a single brand colour. That's a starting point, not the final word.

**Example:** A client hands you just their logo blue, `#2563EB`. Thisura generates the whole ramp around it and shows it for approval. You think the `900`/`950` end looks a bit muddy for their dark UI, so you nudge those two steps lighter before approving. Totally fine — the ramp is yours to tweak at the approval step (or re-run if you'd rather).

### 3. Sourced vs. fixed values

By default, if a code repo is open, Thisura pulls exact token values from the project's own Tailwind/shadcn/Gluestack build — so your Figma matches exactly what devs ship. If there's no repo, it uses the standard canonical Tailwind v4 values instead.

**Example:** You're designing *before* any code exists (design-first project). No repo to read from, so Thisura uses canonical Tailwind values — perfect for now. Later, once devs scaffold the project with their customized Tailwind theme, you re-run Thisura against the repo so the Figma tokens snap to the real shipped values. Just know which situation you're in: **no repo = canonical values, repo open = matched values.**

---

## Troubleshooting

**Thisura doesn't show up when I type `/`.**
The folder probably isn't in the right place, or Cursor needs a reload. Check it's under `.claude/skills/thisura/` (or `.agents/skills/thisura/`) with `SKILL.md` inside, then restart Cursor.

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
