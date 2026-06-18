# Wireframe spec — parsing, traceability & self-audit (read first)

This file is the **reasoning** half of the skill: how to turn the input docs into a correct,
complete, per-journey screen plan, and how to **audit each journey back against the docs** before
asking the user to review. The skill draws nothing until Phase 1 here is approved.

## The inputs and what to pull from each
- **User Journey file → the spine.** This drives everything. Extract the **ordered list of
  journeys** exactly as they appear (preserve file order — never reorder). For each journey, pull
  its **steps** (the sequence of user actions/decisions) and any **branches** (alternate paths,
  conditions). The journey list is *not* asked of the user — only exclusions are.
- **PRD → requirements & rules.** What each screen must let the user do; field rules, validation,
  permissions, success/error conditions, empty-state behaviour. This is where most **states** come
  from.
- **Themes & Epics → feature scope (coverage).** The full feature inventory. Used to check that
  every in-scope feature a journey touches actually appears as a screen/element. **If Excel, use the
  worksheet the user named — never guess across sheets.** If they didn't name one and the file has
  several, stop and ask.
- **UX Specification (optional) → layout & interaction detail.** Component choices, navigation
  pattern, specific interactions, content structure. If present, prefer it for layout decisions; if
  absent, derive layout from PRD + journey and note the assumption.

## Surface map (mobile / desktop / mixed)
From intake, tag **every journey (and, where a journey spans surfaces, every screen)** with its
device: **mobile** (375×812) or **desktop** (1440×1024). Mixed scopes are normal — e.g. an
end-user **mobile app** plus **admin screens on desktop**. **For a mixed scope, do not ask the
designer which journeys are which** — **infer the surface→journey/screen assignment from the
documents** (PRD wording, T&E feature grouping, journey context, UX Spec) and **present that map
for the designer to review and approve** in Phase 1. A single journey can cross surfaces (e.g. user
submits on mobile, admin approves on desktop); when it does, draw each screen at its own device
size within the one journey Section and make the hand-off arrow between them explicit. Flag any
journey/screen whose surface the docs don't make clear, rather than guessing silently.

## Per-journey screen + state inventory (feeds the registry)
This inventory is the **input to the `screen-registry.md` pre-pass**, which runs over **all
journeys at once** to assign stable screen/element IDs and reveal ownership. A screen recurs across
journeys, so capture screens at the **logical** level (same Home in two journeys = one screen), not
as per-journey copies. For each in-scope journey, list its screens **in flow order**. For each
screen record:
- **Screen name + stable ID** and one-line **purpose**. Same logical screen across journeys shares
  one ID (disambiguate same-named-but-different screens — identity is the ID, not the name).
- **Elements** this journey **introduces or uses** on the screen — so the pre-pass can assign each
  element an **owning (reveal) journey** by file order, and reserve placeholders elsewhere.
- **States to draw** (from the agreed coverage depth) — see taxonomy below.
- **Source trace** — the epic/feature (T&E), requirement (PRD), and journey step each screen **and
  each introduced element** serves. Every screen and element must trace to at least one. No trace →
  probably invented; drop or flag.
- **Surface** — mobile or desktop (a recurring screen on a different surface is a different ID).
Present grouped by journey, in file order, as part of the **Screen Index** approval gate **before
drawing.**

## State / edge-case taxonomy
Default "key states": **populated (happy)**, **empty**, **error**. Full set (when the user picks
deep coverage): **empty · loading · populated/success · error · validation · permission-denied ·
offline**. Only create a state if the journey/PRD implies it exists — don't pad screens with states
the product doesn't have. Branch points in the journey (a decision: logged in? has items? role?)
become **decision diamonds** in the flow (see `flowboard-layout.md`), each branch leading to its
own screen/state.

## Copy rule (what gets real text)
Real, plausible **English** copy goes only on elements that **carry meaning** for understanding the
flow: primary/secondary CTAs, nav labels, screen titles, key headings, form field labels, critical
content lines, error/empty messages. Everything else — body paragraphs, list filler, secondary
descriptions — is **greeked** (placeholder), set in Flow Circular per `lofi-elements.md`. **Never
invent features, requirements, or screens** that aren't in the inputs; if the docs are thin on a
screen, keep it sparse rather than inventing detail.

## Traceability gate (must hold across the whole set)
- Every **journey** in the User Journey file is either built or explicitly excluded.
- Every **screen** traces back to an epic/requirement/journey step.
- Every **element** traces to an epic/requirement/journey step, and has an **owning (reveal)
  journey** (case 10 in `screen-registry.md`: no reserved slot left unrevealed; no reveal without a
  reserved slot).
- Every screen is **reachable** within its journey flow — no orphans, no dead frames.
- Every in-scope **epic/feature** that a journey touches is represented by at least one
  screen/element.
- **Recurring screens stay consistent:** every snapshot of a screen matches its master on
  shared/revealed elements (consistency is enforced by derivation, see `screen-registry.md`).
- Gaps (a feature with no screen, a journey step with no screen, a screen with no inbound arrow, an
  element with no owner) are surfaced, not silently dropped.

## Per-journey self-audit (run after drawing, BEFORE asking the user to review)
This is the quality gate that replaces a second pair of eyes. After a journey's screens, arrows and
annotations are drawn, check it back against PRD + T&E + User Journey (+ UX Spec) and **fix issues
before involving the user**:
- [ ] **Steps covered** — every step in this journey (from the User Journey file) has a screen.
- [ ] **Flow matches the map** — arrows follow the journey's documented order; branches match the
      documented conditions; no path the journey describes is missing.
- [ ] **States present** — the agreed states exist for each screen that needs them (esp. empty &
      error, the usual misses).
- [ ] **Features represented** — every T&E feature this journey touches appears on a screen.
- [ ] **Copy traces** — meaningful labels reflect the PRD/journey wording; nothing invented.
- [ ] **No orphan / unreachable screen** in the Section; every screen has an inbound connection
      (except the start terminator's first screen).
- [ ] **Snapshots consistent** — each recurring screen's snapshot matches its master on shared/
      revealed elements; not-yet-revealed elements show as placeholders (reserved slots), nothing
      reflowed; any modify/remove of an earlier-revealed element went through the ripple protocol.
- [ ] **Surface correct** — each screen is at its assigned device size.
- [ ] **Annotations resolve** — each Dev Mode annotation is attached to a real node and states a
      real navigation/state/content/interaction note.
Only after every box passes do you stop and hand the journey to the user for review.