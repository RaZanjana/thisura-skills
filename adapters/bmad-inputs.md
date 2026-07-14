# BMAD / WDS input map (internal — do not show this file to designers)

**Audience:** the agent running `thisura-wireframe` or `thisura-hifi`.  
**Purpose:** find planning docs the project already produced. Prefer auto-discovery; only ask the designer when something is missing. Speak to them in plain language (see Voice in each SKILL.md).

When a skill is installed alone under `~/.claude/skills/<skill>/`, use the **copy** at `adapters/bmad-inputs.md` inside that skill folder (kept in sync with this repo-root file).

---

## 1. Find the project folders

From the open workspace / project root:

1. Read `_bmad/bmm/config.yaml` if present → note `planning_artifacts`, `implementation_artifacts`, `output_folder`, `project_knowledge`.
2. Read `_bmad/wds/config.yaml` if present → note `output_folder`, `design_artifacts`.
3. If configs are missing, still try the **common defaults** below.

| Role | Config key | Common default |
|------|------------|----------------|
| Planning docs | `planning_artifacts` | `_bmad-output/planning-artifacts/` |
| Stories / sprint | `implementation_artifacts` | `_bmad-output/implementation-artifacts/` |
| WDS / scenarios | `output_folder` (WDS) | `_bmad-output/` |
| Design extras | `design_artifacts` | `design-artifacts/` |
| Extra docs | `project_knowledge` | `docs/` |

Also scan: project root, `docs/`, and any path the designer pastes.

---

## 2. Slot → what to look for (precedence order)

For each slot, use the **first match that exists**. Confirm the list with the designer in plain words before drawing.

### PRD (required for Wireframe + HiFi)

| Priority | Look for |
|----------|----------|
| 1 | `{planning_artifacts}/**/prd.md` (prefer `status: final` in frontmatter if several) |
| 2 | `{planning_artifacts}/**/*prd*.md` |
| 3 | `{output_folder}/**/prd.md` |
| 4 | Designer-attached / pasted path (Markdown, PDF, Word, Excel) |

**Say to designer:** “your PRD” / “the requirements doc”.

### Epics & stories (feature coverage — was “Themes & Epics”)

| Priority | Look for |
|----------|----------|
| 1 | `{planning_artifacts}/**/epics*.md`, `**/epic*.md`, folders named `epics` / `stories` |
| 2 | Story files under `{implementation_artifacts}/` (for coverage + HiFi unit of work) |
| 3 | Legacy **Themes & Epics** Excel / Word / PDF the designer attaches |
| 4 | If Excel has multiple sheets → **ask which worksheet** (never guess) |

**Say to designer:** “your epics and stories” (from planning). Only say “Themes & Epics” if that’s the file they actually have.

### Journeys / scenarios (Wireframe spine — was “User Journey file”)

| Priority | Look for |
|----------|----------|
| 1 | `{output_folder}/**/C-UX-Scenarios/00-ux-scenarios.md` + sibling scenario folders |
| 2 | `{output_folder}/**/C-UX-Scenarios/**/*.md` |
| 3 | `{planning_artifacts}/**/EXPERIENCE.md` → **Key Flows** / journey sections |
| 4 | Files matching `*journey*`, `*scenario*`, `*user-flow*` under planning / docs |
| 5 | Designer-attached journey doc |

**Say to designer:** “your journeys” / “your scenarios”.  
**Precedence:** WDS scenario pack beats EXPERIENCE.md Key Flows when both exist (use EXPERIENCE for interaction detail — see UX detail).

### UX detail (optional)

| Priority | Look for |
|----------|----------|
| 1 | `{planning_artifacts}/**/EXPERIENCE.md` + `DESIGN.md` (from `bmad-ux`) |
| 2 | WDS / Freya page specs under scenario page folders (`C-UX-Scenarios/**/pages/**/*.md`) |
| 3 | Any file named like `*ux*spec*`, `*ux-design*` |
| 4 | None → lean on PRD + journeys and **say so** |

**Say to designer:** “extra UX notes” / “how screens should behave” — not “UX Specification artifact”.

### Product brief (HiFi — nice-to-have for foundations)

| Priority | Look for |
|----------|----------|
| 1 | `{output_folder}/**/A-Product-Brief/**/*.md` |
| 2 | `{planning_artifacts}/**/*brief*.md` |
| 3 | Brand / CI PDF or link from the designer |

### Trigger map / personas (HiFi — nice-to-have)

| Priority | Look for |
|----------|----------|
| 1 | `{output_folder}/**/B-Trigger-Map/**/*.md` |
| 2 | `{planning_artifacts}/**/*trigger*`, `*persona*` |

### Architecture (HiFi — needed for token / framework mapping)

| Priority | Look for |
|----------|----------|
| 1 | `{planning_artifacts}/**/architecture*.md` |
| 2 | `{planning_artifacts}/**/*architecture*` |

**Say to designer:** “the architecture notes” (web vs mobile, design-system choice).

### Sprint order / next story (HiFi)

| Priority | Look for |
|----------|----------|
| 1 | `{implementation_artifacts}/**/sprint-status*`, `**/sprint*` |
| 2 | Story files in sprint order under `{implementation_artifacts}/` |
| 3 | Ask: “Which story should we build next?” |

Tag every HiFi screen + build-log row with the **story id/name** (e.g. `2.3` or filename).

### Implementation readiness (HiFi — nice-to-have)

| Priority | Look for |
|----------|----------|
| 1 | `{planning_artifacts}/**/*readiness*` |
| 2 | Skip if missing — do **not** block foundations or first story |

### Brand / reference site (HiFi)

Ask only if not in brief / DESIGN.md: brand manual path, live or reference URL.

### Wireframe status (Thisura-owned; HiFi reads it)

| Path | Purpose |
|------|---------|
| `{design_artifacts}/wireframe-status.md` | Preferred |
| `design-artifacts/wireframe-status.md` | Default if no config |
| `{planning_artifacts}/design-artifacts/wireframe-status.md` | Fallback |

---

## 3. Discovery procedure (both skills)

1. Resolve folders (§1).  
2. Fill every slot (§2); record path + short label for each hit.  
3. **Confirm once** with the designer, e.g.  
   > “I found your PRD, epics & stories, and these journeys: Onboarding, Checkout, … I’ll use those. Sound right?”  
4. Ask **only for gaps** (missing required slots, multi-sheet Excel worksheet, FigJam/Figma URL, surface scope, state depth).  
5. Bundle remaining questions in **one** short round (≤3). Never drip-feed.  
6. If a **required** slot is empty after asking → stop and say which planning step is still needed (in plain language). Do **not** invent requirements.

---

## 4. Wireframe-specific rules

**Required before drawing:** PRD + epics/stories (or legacy Themes & Epics) + journeys/scenarios.  
**Optional:** UX detail.  
**FigJam URL** required for Mode A (or offer to create a board).

When a journey is **signed off**, create or update `wireframe-status.md`:

```markdown
# Wireframe status

Updated: YYYY-MM-DD

| Journey | Flow (FigJam) | Lo-fi components |
|---------|---------------|------------------|
| Onboarding | approved | not started |
| Checkout | in review | — |
```

Also note the FigJam board URL at the top if known.

Parse docs using the same meaning as before: journeys = spine; PRD = rules/states; epics/stories = coverage. In audits, treat “T&E” / “Themes & Epics” as **epics & stories**.

---

## 5. HiFi-specific rules — tiered start

Do **not** require every BMAD doc before any work. Use tiers:

### Tier A — start Foundations (tokens + Style Guide)

**Need:** brand or brief visual direction (or DESIGN.md) **and** architecture (or designer pick: web shadcn / mobile Gluestack).  
**Nice:** Product Brief, Trigger Map.

### Tier B — start first story screens

**Need:** Tier A done (or already in file) + **that story’s** file + PRD (for non-goals / scope).  
**Nice:** readiness report, full epic set.

### Tier C — best quality

**Also have:** journeys/scenarios, approved wireframe (check `wireframe-status.md`), DESIGN.md + EXPERIENCE.md, reference site.

If `wireframe-status.md` shows journeys **not approved** for screens in the next story → warn in plain language and offer to wait or continue anyway (designer’s call).

If **DESIGN.md** exists → map its colours/type into Figma variables; don’t invent a competing palette.

---

## 6. Designer language cheat sheet

| Internal | Say |
|----------|-----|
| planning_artifacts | “your planning folder” / “the docs from planning” |
| implementation_artifacts | “your story files” / “the sprint list” |
| C-UX-Scenarios | “your journeys” / “your scenarios” |
| Themes & Epics | “epics and stories” (unless their file is literally named that) |
| User Journey file | “journey doc” / “scenarios” |
| DESIGN.md / EXPERIENCE.md | “your UX design notes” / “how it should look and behave” |
| wireframe-status | “which journeys you’ve already signed off” |
| Auto-discovery / adapter | “I’ll look for your project docs” |
| preceded-by / gate | “best after planning / journeys are ready” |
