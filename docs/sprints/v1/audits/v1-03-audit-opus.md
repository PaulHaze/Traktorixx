## Audit: last commit 1a5e195 — Define Traktor palette and bundled Open Sans base styling

_Scope: Sprint 03 — Colours and font (from `docs/sprints/v1/03_Colours_And_Font.md`)_

Branch `v1-03` maps to exactly one sprint file (`docs/sprints/v1/03_Colours_And_Font.md`). Files audited: `skin/skin.xml`, `skin/style.qss` (the sprint doc in the commit was read as scope context). Commit author: PaulHaze.

**Scope match:** the palette is sampled, named, and recorded in both QSS and XML. Open Sans was chosen from the bundled fonts, base sizes are set, and the skeleton is restyled. Nothing in the commit goes beyond the sprint's scope. The library is left alone (sprint 12), and no individual controls are styled. One acceptance item is still open (see Warning 1).

### Warning

1. **`mixxx.log clean` is unverified, so Overview Rule 4 is still open.** `docs/sprints/v1/03_Colours_And_Font.md:39` leaves the task unchecked. Findings (lines 78–85) say the isolated Mixxx instance never reached the skin parser, so nobody has confirmed that the new QSS parses without warnings. The Status line correctly says "awaiting owner verification". Treat this as a merge blocker: the owner should run `./scripts/install.sh`, Reload Skin, grep `mixxx.log` for `style`/`skin` warnings, then tick the box.

2. **The blanket `color` rule will override XML colour tags on any widget inside the performance area.** `skin/style.qss:28-32` sets `color: #c0c0c0` (and font) on `WWidgetGroup#PerformanceArea *`. Qt stylesheet properties win over a widget's `QPalette`. So any later `<FgColor><Variable name="colourAccentOrange"/></FgColor>` on a `Label`/`Number`-family widget inside `PerformanceArea` will be silently replaced by `#c0c0c0`. That conflicts with the stated purpose of the XML variables (`skin.xml:18-19` "for native widget colour tags"; sprint Findings line 61–62). Painted widgets that take colours from their own XML tags, such as waveform signal/background colours, are not affected. Text-bearing widgets are.
   - The same rule has specificity (1 id, 1 type). Any later selector with only an id (e.g. `#DeckLetterA { color: #fa7242; }`, which is 1 id, 0 types) loses to it. A later rule only wins if it has at least one id and one type and appears after line 32. `style.qss:54-59` already works around this with the `WWidgetGroup#PerformanceArea` prefix.
   - Fix: add a short comment above line 28 stating both rules. Text colour comes from QSS, not `<FgColor>`, and override selectors need `Type#Id` or deeper and must come after the base block. Use the XML colour variables only for non-text native colours (waveforms, overview, marks).

### Suggestion

1. **`WLabel#Value` / `WLabel#TrackTitle` use up the widget's only ObjectName** (`skin/style.qss:22, 33-41`). A Mixxx widget gets one `<ObjectName>`. If sprints 05/09 name the BPM readout `Value`, they can't also give it a specific name like `BpmReadout` for its own colour or size. Consider keying the typography rules on widget type instead (`WNumber`, `WTrackProperty` are both `WLabel` subclasses), or on a shared name prefix that later sprints can extend. This is optional. The sprint asked for value/title sizes, and the current approach works as long as no value widget needs its own name.

2. **The `WLabel#Value *` / `WLabel#TrackTitle *` descendant selectors are dead weight** (`skin/style.qss:34, 38`). `WLabel` has no child widgets, so these halves of the selectors never match. Dropping them keeps the base block shorter. The `*` on line 28 is needed (Qt doesn't inherit stylesheet font/colour by default). These two are not.

3. **The palette now lives in three copies** (QSS comment `style.qss:5-13`, literal hex values in the QSS rules, and `skin.xml:20-30`). Findings line 72 mentions "palette consistency checks", but no check script is committed (`scripts/` holds only `install.sh`). If drift becomes a concern, a few lines of `grep` in `scripts/` that check every hex used in `style.qss` against the `skin.xml` `SetVariable` values would keep later sprints honest. This is low priority while the palette is nine colours.

### Positive observations

- **The palette matches the targets.** I decoded `traktor_full.png`, `traktor_dj_deck.png` and `traktor_full_with_library.png`. Their top performance-area colours are `#181818` (57% / 53%), `#262626` (14% / 20%), `#323232`, `#000000` and `#448bf6`. A vertical profile at deck A (x=400) shows `#181818` for the header/deck surfaces, black divider bands, and `#262626` for the transport/beatgrid rows at the bottom, which is exactly how the commit assigns them. The `#1c1c1c` / `#141414` peaks appear only in the with-library image, so they are library rows and correctly left for sprint 12.
- **The font choice works on both target platforms.** `OpenSans-Semibold.ttf`'s name table has typographic family (ID 16) `Open Sans` and `usWeightClass` 600. So `font-family: "Open Sans"; font-weight: 600` (`style.qss:29, 40`) resolves to the real Semibold face on macOS (CoreText uses the typographic family) and Linux (LateNight's own `style.qss` comment confirms that all Open Sans weights register as "Open Sans" there). Only Windows would need `"Open Sans Semibold"` first, and Windows is not a target. Using 600 rather than LateNight's legacy 500 is correct for Qt 6's `QFont::DemiBold`.
- **The contrast claims check out.** `#c0c0c0` and `#a0a0a0` on `#262626` work out to 8.32:1 and 5.79:1 (WCAG relative luminance), matching the sprint Findings.
- **The XML variables are placed correctly.** They sit at the top of the root `<Children>`, before any `Template`, so `deck.xml` inherits them through the copied template context. The nested `<Variable>` aliases for `colourDeckA`/`colourDeckB` (`skin.xml:29-30`) use the parser's supported `SetVariable` + embedded-variable form. `xmllint --noout skin/skin.xml skin/deck.xml` passes.
- **The scope is held cleanly.** Typography is scoped to `PerformanceArea`, the library is untouched apart from the existing splitter handle, no controls are styled, and the old per-zone debug tints were removed rather than recoloured. Nothing is copied from LateNight or Traktmixxx-RAW. LateNight was only consulted for the font-naming behaviour.

Want me to fix any of these?
