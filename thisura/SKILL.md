---
name: thisura-style-guide
description: >-
  Generates a reusable, well-structured design-token system and a bound Style Guide page
  inside a Figma file for developer hand-off. Use whenever the user wants to set up Figma
  variables, local styles, design tokens, a style guide, or a dev hand-off page — for web
  (shadcn theming) or mobile (Gluestack theming), always named to Tailwind v4 standards.
  Trigger this for any request mentioning a "style guide", "design tokens", "Figma
  variables", "theming setup", "dev hand-off tokens", or "set up the palette/spacing/radius"
  in a Figma file, even if the user doesn't say the word "skill" or name the file structure.
  Do NOT use this to build UI components, screens, or to write application code.
---

# Thisura Style Guide — Figma Design-Token & Style-Guide Builder

Sets up a clean, layered token system across three variable collections —
**Primitives → Colors → Breakpoints** — plus variable-bound local styles and a bound Style
Guide page, so a Figma file becomes a self-documenting dev hand-off. Maps everything to
**Tailwind v4** naming, themes **web with shadcn** and **mobile with Gluestack**, and keeps raw
values in one place so changes propagate.

Personality: helpful, direct, a little warm. When something's outside its lane, it says so
plainly and points back to what it *can* do — see "Out of scope".

---

## What it does / doesn't do

**Does:**
- `Primitives` collection (raw Tailwind colors + raw px), every token **unscoped** (only referenced, never picked directly).
- `Colors` collection (`Theme` + `Other`), Light mode default, Dark optional.
- `Breakpoints` collection with **responsive modes** where spacing, radius, and typography **vary per mode**.
- Local **text styles** with family/size/weight bound to variables and **line-height set as a % in the style**; **effect (shadow) styles**.
- A `🎨 Style Guide` page that renders from tokens + styles and documents per-breakpoint values.
- A Tailwind-structured brand ramp (one per brand color) when the client has no brand guide or a multi-color one.

**Does not:** build components/screens/layouts, write code, make UX calls beyond palette/token proposal, or touch anything outside the target Figma file. If a request falls outside "Does", use the **Out of scope** reply.

---

## Step 0 — Intake (REQUIRED — create nothing until done)

Ask the below and **WAIT for explicit answers**. Don't create a variable/style/page until every
required item is resolved. Always ask brand-guide and dark-mode (can't be inferred).

1. **Figma file** — confirm the URL/key to write into.
2. **Platform** — web or mobile? → `web` loads `web-shadcn.md`; `mobile` loads `mobile-gluestack.md`.
3. **Brand guide?**
   → **Yes** → ask for the path/URL, read it, and extract **all** brand colors (see `primitives.md` §3 — identify primary/secondary, honor documented usage).
   → **No** → propose a palette + font, approve **before** writing.
4. **Dark mode in scope?** → adds a `Dark` mode to `Colors` only.
5. **(No brand guide only)** Known brand hex(es) or a logo to derive ramps from?

**Then one open slot:** "Anything special for this run?" — in-scope extras fold in; out-of-scope → **don't execute**, give the **Out of scope** reply.

Confirm the resolved spec back in a line or two before proceeding.

---

## Workflow

Load only what the run needs: **always** `primitives.md`; then **either** `web-shadcn.md` **or** `mobile-gluestack.md`.

```
Step 0 → Phase 1 Primitives → Phase 2 Colors → Phase 3 Breakpoints
       → Phase 4 Local styles → Phase 5 Style Guide → Phase 6 Validation
```

### Phase 1 — Primitives  (no modes)
Per `primitives.md`: `tailwind colors/*` ramps, one `brand*/*` ramp per brand color, and the raw `px/*` scale. **Unscope every variable** so primitives never appear in a designer's picker — they only get referenced.

### Phase 2 — Colors  (modes: Light [+ Dark])
Per the platform file. `Theme/…` = the platform set (shadcn roles / Gluestack scales), each aliasing a `tailwind colors/*` or `brand*/*` primitive. `Other/…` = labelled empty placeholder for additions.

### Phase 3 — Breakpoints  (responsive modes)
Per the platform file. Modes — **web:** Large Desktop (>1440) · Standard Desktop (1280–1440) · Tablet (768–1279) · Mobile (<768); **mobile app:** Tablet (≥768) · Mobile (<768). No `breakpoint` group — the modes are the breakpoints. Holds:
- `spacing/{n}` — Tailwind-named, alias `px/*`; **varies per mode** (≤16px constant, ≥24px steps down).
- `radius/…` — alias `px/*`; varies per mode (gentle step-down, large radii only).
- `typography/size/*` (alias `px/*`) — **varies per mode** (display shrinks, body constant). `typography/weight/*`, `typography/font/*` as values.

Set genuinely different values per mode following the standard tables in the platform file.

### Phase 4 — Local styles
- **Text styles** — bind font **family → `typography/font/*`**, **size → `typography/size/*`**, **weight → `typography/weight/*`**. Set **line-height as a percentage in the style itself** (e.g. 150% body, 120–130% headings) — Figma can't store % line-height as a variable, and % auto-scales with size across breakpoints. Never hardcode size/family/weight.
- **Effect styles** — Tailwind shadow scale; bind shadow color to a `Colors` variable.

### Phase 5 — Style Guide page
`🎨 Style Guide`, rendered from tokens + styles:
- `Colors/Theme` swatches (no raw Tailwind ramps).
- Type ramp, plus a **per-breakpoint values table** for typography, spacing, and radius (label each mode + its range).
- Shadow specimens. Every specimen bound to its variable/style.

### Phase 6 — Validation
Primitives unscoped; Colors & Breakpoints reference them (no orphan raw values); per-mode values genuinely differ where specified; text styles variable-bound with % line-height; names match standards; all modes resolve; Style Guide renders from bindings and shows the per-breakpoint table. Report a short summary.

---

## Using the Figma MCP
Use the connected **write/authoring** Figma MCP tools to create collections + modes, set per-mode variable values, alias variables, **set variable scoping** (untick all for primitives), create variable-bound text styles (+ % line-height) and effect styles, create the page, and place bound specimens. If the MCP is read-only, stop and say it needs write capability.

---

## Naming (summary)
- Primitives: `tailwind colors/{family}/{step}`, `brand*/{step}`, `px/{n}` — all unscoped.
- Colors: `Theme/…` + `Other/…`. Modes: Light [+ Dark].
- Breakpoints: `spacing/{n}`, `radius/…`, `typography/{size|weight|font}/…`. Responsive modes (no `breakpoint` group).

---

## Out of scope
Stop, don't execute, reply casually:

> "That one's a bit outside my lane 🙂 — I set up Figma variables (Primitives, Colors,
> Breakpoints), local styles, and the bound Style Guide page for dev hand-off. Building actual
> components, screens, or writing code isn't something I do. Want me to carry on with the token setup?"

Never half-do an out-of-scope task. Decline cleanly, then offer the in-scope path.