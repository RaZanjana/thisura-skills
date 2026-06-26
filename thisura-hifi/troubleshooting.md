# Troubleshooting catalogue

Each row is a symptom → likely cause → fix. Promote any recurring one into a numbered standard
(`build-log.md`) and re-check existing work against it.

| Symptom | Likely cause | Fix |
|---|---|---|
| Text renders **black** unexpectedly | Bound to a non-existent variable name (missing prefix) | Verify exact names; rebind; re-audit |
| **Contrast ~4.3–4.4** on tinted band/chip | Muted text on light-gray bg | White card + border + shadow, or darken the text token |
| **Shadow / focus ring invisible** | Hugging parent has clip-content on | Clip-content **off** on ancestors of shadowed / outside-stroke nodes |
| Frame **collapsed to ~10px** | `resize()` reset auto-layout sizing to FIXED | Set `layoutSizing*='HUG'/'FILL'` **after** resize |
| `HUG`/`FILL` throws | Node not yet in an auto-layout parent | `appendChild` first, then set sizing |
| Image fill **renders blank** | Wrong declared type / cached failed decode | Convert / re-encode (new hash), correct Content-Type; verify via `get_screenshot` |
| Slot/child **won't move in instance** | Positions can't be overridden per-instance | Make it responsive in the master (`SCALE` / `STRETCH`) |
| Variants overlap as one node | No layout after `combineAsVariants` | Position children into a grid; resize the set |
| Mobile type wrong / duplicated styles | Swapped styles per breakpoint | Use the **same** style; rely on the breakpoint mode |
| Component created on wrong page | `clone()` / create left it unparented | Move the master onto the Components board; verify the parent |
| `setCurrentPage` error | Sync page setter used | `await figma.setCurrentPageAsync(page)` |
| Out-of-scope feature implied | Stray icon / control | Remove unused assets that imply non-goals |

> Most of these are encoded in the loaded skills (`figma-use`, `figma-generate-library`,
> `figma-generate-design`) and the foundations layout checklist (`style-guide-layout.md`).
> Loading those skills **before** writing is what prevents the failures in the first place.
