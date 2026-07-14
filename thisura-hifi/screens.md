# Phase 3 — Screens

**Goal:** assemble the story's screen(s), **desktop + mobile**, from instances — accurate, in
scope, accessible, annotated.

Read `figma-use` and `figma-generate-design` before composing.

---

## Build order
1. **Create the screen frame** and **bind the breakpoint mode** (Desktop frame → Desktop mode,
   Mobile frame → Mobile mode — Standard #16).
2. **Place global chrome** — Header + Footer as **instances**; every page has both (Standard #17).
3. **Compose from instances**; fill slots/props with **in-scope, accurate** content — extracted
   from the reference and **rewritten to the project's narrative**; author net-new only within
   scope (the PRD non-goals are binding). **No em dashes (`—`) or en dashes (`–`) in any
   generated UI copy, labels, annotations, or layer names shown to reviewers** (Standard #28);
   use commas, periods, or parentheses.
4. **One semantic text style per role across breakpoints** — the mode resizes it; never swap styles
   per breakpoint (Standard #19).
5. **Cover the AC-required states**: loading / empty / error / success / validation / focus /
   reduced-motion — whatever the story's acceptance criteria call for.
6. **Clip-content OFF** around shadows / outside-strokes (Standard #7).
7. **Place the mobile frame directly to the right of desktop**, aligned at the top (Standard #15).
8. **Annotate** desktop CTAs/links (see below), run the **AA audit** (`accessibility.md`) to 0
   failures, **update the build log** (`build-log.md`), and **stamp the screen frame** with a
   `thisura` `sharedPluginData` fingerprint (story, status, a hash of content/bindings) so manual
   edits are detectable on resume — see `continue-resume.md`.

## Annotations (user-flow)
On **desktop** frames only, annotate every CTA / card / linking section with its destination route
via Figma Dev-Mode annotations (`node.annotations`) — even if the destination page doesn't exist
yet. Annotate the **specific node**. Annotate global nav/footer **once on the component masters**.
Mobile mirrors desktop. (Standard #20.) This makes the intended flow explicit for devs and
surfaces any out-of-scope link immediately.

## Images, maps & assets
- **Verify the real file type before upload** (extensions lie); upload with the correct
  `Content-Type`. Figma caches by **content hash** — a failed decode sticks; **re-encode/convert**
  to change the bytes if an image renders blank. Verify with `get_screenshot` (Standard #22).
- **Maps:** pick a library (e.g. MapLibre GL JS), use a static style image as the design
  background, build markers as a component with type variants, differentiate special markers, and
  keep previews view-only if filtering lives elsewhere (Standard #21).
- Don't add assets that imply non-goals.

## Layout verification gate (Standard #27 — before AA and review)

Screens are assembled from instances — **if a master is broken, every screen breaks.** After
composing each screen (and after any layout fix pass), verify:

1. **Child order & heights** — screen frame children: `Header` → `Content` → `Footer`; `Content`
   height must hug the form/body (not ~10–150px while fields visually overflow).
2. **Zero-width text scan** — no `TEXT` with meaningful copy and `width < 8px` (intro, labels,
   errors, privacy line, textarea values).
3. **Field grid** — desktop: two-column rows use `HORIZONTAL` + equal `layoutGrow`; mobile: rows
   `VERTICAL`; controls `layoutSizingHorizontal FILL` + `layoutAlign STRETCH`.
4. **CTA width** — primary submit `FILL` on mobile, `HUG` acceptable on desktop unless full-width
   is specified.
5. **`get_screenshot`** desktop + mobile — confirm no letter-stacks, no footer-in-the-middle, no
   overlapping fields.

If a defect traces to a component master, **fix the master on the Components board first**, then
re-check all instances (Standard #25–#26, `components.md`).

## Definition of done (per screen)
- [ ] Manual changes detected & absorbed at story start (`per-story-loop.md`).
- [ ] Desktop + mobile built; mobile beside desktop; breakpoint mode bound.
- [ ] Composed from instances; slots/props populated with in-scope content.
- [ ] No em dashes (`—`) or en dashes (`–`) in generated copy, annotations, or labels (Standard #28).
- [ ] Tokens + spacing bound; one text style per role across breakpoints.
- [ ] Required states covered; clip-content correct around shadows/rings.
- [ ] Global chrome present (header + footer).
- [ ] Desktop CTAs/links annotated.
- [ ] Layout verification gate passed (zero-width scan + screenshot; Standard #27).
- [ ] WCAG AA audit: 0 failures (image/gradient text verified).
- [ ] Build log updated (registry + story log + open items).
- [ ] **Reviewed with stakeholder; explicit sign-off received.**

> **Why this order:** chrome + tokens + instances first guarantees consistency; annotations + AA
> before "done" prevent flow ambiguity and accessibility debt.
