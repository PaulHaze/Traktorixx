# Audit Summary: v1-03 — Colours and font

Combined findings of Astra and Opus audits:

## Issues

### 1. Required Mixxx reload, clean-log check and rendered acceptance checks not done  [Critical] · raised by Astra
- **What it is:** The clean-log task is unchecked. The recorded Mixxx run never reached the skin parser. The side-by-side dark-tone comparison and the arm's-length readability check are both left to the owner.
- **Why it matters:** Valid XML, matching palette values and correct QSS syntax can't prove that the skin loads in Mixxx 2.5.6, that it adds no new warnings, or that the rendered skeleton looks and reads right. Astra rates this Critical because the task is mandatory, not because anything is observed broken. The Status line honestly says verification is pending. Astra's verdict: FAIL until this is resolved.
- **Where:** `docs/sprints/v1/03_Colours_And_Font.md:39`, `:74`, `:78`; requirements at `docs/sprints/v1/00_Overview.md:18` and `docs/sprints/v1/03_Colours_And_Font.md:43`.
- **Related:** #2 — Opus raised the log part of this as a Warning. Kept separate, with different severities and a different scope (Astra's also covers the visual checks).
- **Suggested fix:** Reload the installed skin for this commit in Mixxx 2.5.6 and confirm that Traktorixx actually loaded. Inspect that reload's log for skin errors or new warnings. Compare the render with `target_images/traktor_full_with_library.png`, check readability at arm's length, and confirm resizing doesn't clip anything. Record the results, then tick the box and update Status. Fix any real defect found first, and don't count the earlier pre-parser attempt as a test.

### 2. `mixxx.log clean` unverified (Overview Rule 4 open)  [Warning] · raised by Claude (Opus)
- **What it is:** The sprint's log-check box is unticked, and the Findings say the isolated Mixxx instance never reached the skin parser. Nobody has confirmed that the new QSS parses without warnings.
- **Why it matters:** A QSS parse warning would break Rule 4 ("no errors or new warnings"). Opus treats it as a merge blocker but rates it Warning.
- **Where:** `docs/sprints/v1/03_Colours_And_Font.md:39`, `:78-85`.
- **Related:** #1 — same area, raised by Astra at Critical severity.
- **Suggested fix:** Run `./scripts/install.sh`, use Reload Skin, grep `mixxx.log` for `style`/`skin` warnings, then tick the box.

### 3. Blanket text-colour rule will override XML colour tags in the performance area  [Warning] · raised by Claude (Opus)
- **What it is:** `WWidgetGroup#PerformanceArea *` sets `color: #c0c0c0` and the font on every widget inside the performance area. Qt stylesheet values take priority over a widget's palette. So a later `<FgColor><Variable name="colourAccentOrange"/></FgColor>` on a label- or number-type widget would be silently replaced with grey. That conflicts with the stated purpose of the XML colour variables ("for native widget colour tags"). Painted colours like waveform signal and background aren't affected.
- **Why it matters:** It's a hidden trap for later sprints. The rule also has id+type specificity, so a later id-only selector like `#DeckLetterA { color: ... }` loses to it. Only `Type#Id` (or deeper) selectors placed after it win. The commit already works around this at `style.qss:54-59`.
- **Where:** `skin/style.qss:28-32`; `skin/skin.xml:18-19`; sprint Findings lines 61–62.
- **Related:** Astra's coverage table (not a finding) judged the XML-variable setup "implemented" and the descendant selectors correct. That doesn't contradict this entry: Astra assessed what's there now, while this entry is about later use.
- **Suggested fix:** Add a short comment above line 28. It should say that text colour comes from QSS, not `<FgColor>`, and that override selectors need `Type#Id` or deeper and must come after the base block. Keep the XML colour variables for non-text native colours (waveforms, overview, marks).

### 4. `Value` / `TrackTitle` take the widget's only ObjectName  [Suggestion] · raised by Claude (Opus)
- **What it is:** A Mixxx widget gets only one ObjectName. Any widget named `Value` to get the 16px size can't also have its own specific name (such as `BpmReadout`) for its own styling.
- **Why it matters:** This will be a limitation in sprints 05 and 09 if a value widget needs its own colour or size. It works fine until then.
- **Where:** `skin/style.qss:22`, `:33-41`.
- **Related:** Astra's residual-risk note calls the object names "a declared reuse contract, not a current failure". That's a neutral view of the same design, not a finding.
- **Suggested fix:** Optional. Key the typography on widget type (`WNumber`, `WTrackProperty`, both `WLabel` subclasses) or on a name prefix later sprints can extend. Or keep the current approach and accept the limitation.

### 5. `WLabel#Value *` / `WLabel#TrackTitle *` halves never match  [Suggestion] · raised by Claude (Opus)
- **What it is:** Labels have no child widgets, so the `*` descendant part of these two selectors never matches anything.
- **Why it matters:** It's harmless dead code that makes the base block longer. The `*` on line 28 is still needed.
- **Where:** `skin/style.qss:34`, `:38`.
- **Suggested fix:** Delete those two descendant selector halves.

### 6. Palette exists in three copies with no committed drift check  [Suggestion] · raised by Claude (Opus)
- **What it is:** Each colour appears in the QSS comment, in the QSS rules as a literal hex value, and in the `skin.xml` variables. The Findings mention "palette consistency checks", but no script is committed.
- **Why it matters:** Later sprints could change one copy and miss the others. The risk is low while the palette has only nine colours.
- **Where:** `skin/style.qss:5-13`; `skin/skin.xml:20-30`; sprint Findings line 72; `scripts/` holds only `install.sh`.
- **Related:** Astra notes that the duplication is required by the brief and is currently consistent. That agrees on the facts and differs only on whether a check is worth adding.
- **Suggested fix:** If drift becomes a concern, add a few lines of `grep` in `scripts/` that check every QSS hex against the `skin.xml` values. Otherwise defer.

---
**Tally:** 6 issues total (5 from Claude, 1 from Astra). 1 critical, 2 warnings, 3 suggestions.
**Overlaps to judge:** #1 ↔ #2 (same verification gap, rated Critical by Astra and Warning by Opus; Astra's also covers the visual checks).
**Conflicts to resolve:** Severity only: Astra says FAIL/Critical for the missing verification, Opus says Warning/merge blocker. No factual disagreements.

## Auditor notes
- **Astra:** Ran `xmllint` and `git diff --check` (both passed), checked palette consistency, and decoded the reference PNGs with the Python standard library. `#181818` appears 2,273,073 times in `traktor_full_with_library.png`, and all nine colours appear in all three `traktor_*.png` images. Checked the bundled font inventory. Confirmed from the Mixxx 2.5 parser source that the `SetVariable` placement and nested aliases are supported. Did not launch or reload Mixxx.
- **Opus:** Ran `xmllint` (passed). Sampled the reference images, and a deck-A column profile matched the zone-to-colour assignment. Read the font name table: the Semibold face has typographic family "Open Sans" and weight 600, so it resolves on macOS and Linux. Independently confirmed the contrast ratios of 8.32:1 and 5.79:1. Found scope cleanly held, with nothing copied from the reference skins. Did not launch Mixxx.
