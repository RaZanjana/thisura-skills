# Accessibility — WCAG AA gate (Standard #6)

Accessibility is a **gate before "done"**, not a finishing polish. Run a **variable-resolving
contrast audit** on every screen and fix to **0 failures** before the review.

## Contrast audit (resolving)
Colours are bound to variables/aliases, so a naive check is wrong — you must resolve the alias
chain to real RGB:
1. For each text fill, **follow the alias chain to RGB** (Theme → primitive → hex).
2. Find the **nearest solid ancestor background**, resolve it the same way.
3. Compute the contrast ratio.
4. Require:
   - **≥ 4.5:1** for normal text.
   - **≥ 3:1** for large text (**≥ 24px**, or **≥ 18.66px bold**).
5. **Disabled text is exempt** (WCAG 1.4.3).
6. **Text over images / gradients:** verify against the **worst-case region**, or add a scrim and
   verify against that.

Common near-miss: muted text (~4.3–4.4:1) on a tinted band/chip → put it on a white card with a
border + shadow, or darken the text token.

## Also verify (AA)
- **Visible focus** state on every interactive element (the focus ring from the component states).
- **Keyboard order** is logical.
- **Form labels + error messages** present and associated.
- **Reduced-motion** fallbacks for any motion.

> **Why automated + resolving:** a naive check reads the alias name, not the resolved colour, and
> misses real failures — including the "fell back to black" bug when a variable name is wrong
> (Standard #2). Resolving the chain catches them.
