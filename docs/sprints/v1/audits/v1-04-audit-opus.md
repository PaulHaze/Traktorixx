## Audit: last commit 1aaab69 — Implement v1-04 deck waveforms
_Scope: Task 04 — Waveforms (from `docs/sprints/v1/04_Waveforms.md`)_

Branch `v1-04` maps to exactly one sprint file: `docs/sprints/v1/04_Waveforms.md`. Files audited: `skin/deck.xml`, `skin/skin.xml` (sprint doc read for scope/status only). Parser behaviour below was checked against the Mixxx `2.5` branch sources (`legacyskinparser.cpp`, `waveformsignalcolors.cpp`, `waveformmark.cpp`, `woverview.cpp`, `tooltips.cpp`, `dlgprefwaveformdlg.ui`, `waveformwidgetfactory.cpp`).

**Load status:** the installed copy matches the repo (both `deck.xml` written 17:18). The last Traktorixx load in `mixxx.log` was at 17:10:36, so it ran the pre-commit skeleton. This commit has not been loaded in Mixxx yet, which is consistent with the sprint's "awaiting verification" status.

### Scope match

- **Delivered:** a scrolling `<Visual>` and an `<Overview>` per deck, with a cue mark, numbered hotcue marks via `DefaultMark` `%1`, a back-to-start button, a reserved key slot, and spectral colours.
- **Pending (correctly unchecked):** comparing waveform types in Preferences, checking click/drag, and a clean `mixxx.log`.
- **Acceptance criterion "Every Traktor waveform feature Mixxx can't match is listed in Findings" is thin.** The only "can't match" item, playhead position, is actually matchable (see W5).
- **No scope creep:** info, transport and beatgrid are still placeholders.

### Critical

**C1. No `<SignalColor>` on either widget, so Mixxx throws away the low/mid/high colours and logs a warning.** `skin/deck.xml:20-35` (Visual) and `skin/deck.xml:69-78` (Overview)
- In `WaveformSignalColors::setup()` (Mixxx 2.5), a missing `SignalColor` leaves `m_signalColor` invalid. Neither `if` branch fires, so it calls `fallBackDefaultColor()`. That function:
  1. logs `qWarning "WaveformSignalColors::fallBackDefaultColor - Skin does not provide valid signal colors, using default color..."`;
  2. sets `m_signalColor = Qt::green`;
  3. calls `fallBackFromSignalColor()`, which **overwrites** `m_lowColor`/`m_midColor`/`m_highColor` with shades of green.
- **Effect:** the red/green/blue set on `SignalLowColor`/`SignalMidColor`/`SignalHighColor` is lost for the Filtered, HSV and Simple waveform types and the Filtered/HSV overview types. Only the RGB renderers keep the intended colours, because the `SignalRGB*` colours are read separately.
- This breaks the scope item "Traktor-like spectral colouring" for every non-RGB type the sprint asks the owner to compare. It also guarantees a new warning (Overview Rule 4; task "`mixxx.log` clean"), two per deck.
- **Fix:** add `<SignalColor>` to both `<Visual>` and `<Overview>`, e.g. `<SignalColor>#4387f5</SignalColor>` (or a palette variable, see W6).

### Warning

**W1. The overview's colours are incomplete, so the default overview ignores the skin palette.** `skin/deck.xml:75-76`
- The overview sets only `SignalLowColor` and `SignalHighColor`: no `SignalMidColor` and no `SignalRGB*Color`.
- `WOverview` defaults to `Type::RGB` (`woverview.cpp`, `m_type(Type::RGB)`). With the `SignalRGB*` tags missing, `WaveformSignalColors` falls back to pure `Qt::red`/`Qt::green`/`Qt::blue`, not the skin's `#f04b3a`/`#54c45e`/`#4387f5`.
- The Filtered overview type has no mid colour either (and C1 replaces low/high anyway).
- **Fix:** give the overview the same colour block as the `<Visual>`: `SignalColor`, `SignalMidColor` and all three `SignalRGB*Color` tags.

**W2. `<Align>center|top</Align>` puts mark labels at the bottom, not the top.** `skin/deck.xml:37`, `:44`, `:80`, `:87`
- `decodeAlignmentFlags()` (`waveformmark.cpp`) maps `center` to `AlignHCenter | AlignVCenter`, then `top` adds `AlignTop`.
- `vflags` ends up as `VCenter|Top`, which isn't a single flag, so it falls back to the default `AlignBottom`.
- Every cue and hotcue label renders at the bottom. In `traktor_dj_deck.png` the numbered flags sit at the top of both the waveform and the overview.
- **Fix:** use `hcenter|top`. `right|top` may come closer to Traktor's flag-beside-the-line look; confirm visually.

**W3. `PlayedOverlayColor` is opaque, so the played part of the overview is painted out.** `skin/deck.xml:78`
- `WOverview::paintEvent` calls `drawWaveformPixmap()` and then `drawPlayedOverlay()`, which `fillRect`s `[0, playPos]` with this colour.
- With opaque `#333333`, everything left of the play position becomes a flat grey block. Traktor only dims the played part.
- **Fix:** use a translucent ARGB value, e.g. `#80000000`, or drop the tag (the default is transparent).

**W4. The deck's minimum height no longer matches its children; the bottom of the deck may clip at the configured 1024×720 minimum.** `skin/deck.xml:9` vs `:16`, `:24`, `:53`, `:109`, `:117`
- Before this commit, the children's minimum heights summed to exactly the deck's `MinimumSize` of 336: 80 + 120 + 40 + 48 + 48. This commit raises the waveform to 180 and the overview row to 48, giving 80 + 180 + 48 + 48 + 48 = **404**. The explicit `320,336` was left unchanged.
- At the 720 px window minimum from sprint 02, the deck row gets 720 − 220 (library) − 32 (header) − 112 (FX) = **356 px**. That is 48 px short, so about the beatgrid placeholder's height overflows.
- **Fix:** do one of the following:
  - lower the waveform minimum, e.g. 132, so the sum is 356;
  - or set the deck minimum to `320,404`, and either raise the skin minimum to 1024×768 or record the new minimum in Findings (Rule 8; sprint 02 "Configured minimum").

**W5. Findings say the playhead can't be moved, but Mixxx 2.5 has a user setting for it.** `docs/sprints/v1/04_Waveforms.md:59-61`
- Preferences → Waveforms has a **"Play marker position"** slider (`dlgprefwaveformdlg.ui`, `playMarkerPositionSlider`, tooltip *"Moves the play marker position on the waveforms to the left, right or center (default)"*). It is stored as `[Waveform],PlayMarkerPosition` (`waveformwidgetfactory.cpp`).
- It is a user preference, not a skin tag, the same category as the waveform type.
- Also, in `traktor_dj_deck.png` the playhead is at about x=665 in a waveform spanning about 32–1295, which is effectively centred. So the scope's premise ("Traktor puts it left of centre") may not hold for the owner's own setup.
- **Fix:** rewrite the finding:
  - Mixxx can match this via Preferences → Waveforms → Play marker position.
  - The owner's target shows it centred, which is the default.
  - Add both waveform type and play marker position to the recommended-settings finding.

**W6. Waveform colours are hard-coded hex values rather than skin variables (Overview Rule 7).** `skin/deck.xml:27-35`, `:75-78`
- `#f04b3a` appears 3×, `#4387f5` 3×, `#54c45e` 2×. `#666666`, `#444444` and `#333333` are not in the palette.
- Two are near-duplicates of palette colours: `#4387f5` vs `colourActive` `#448bf6`, and `#f04b3a` vs `colourWarning` `#e3423f`.
- Rule 7 says "Shared sizes and colours go in skin variables once sprint 03 defines them". Sprint 03's Findings say the variables are "ready for … sprint 04's waveforms". The `style.qss` header still claims "nine unique colours".
- **Fix:**
  - add `colourWaveLow`/`colourWaveMid`/`colourWaveHigh` (and beat/axes/played-overlay if kept) as `<SetVariable>` in `skin/skin.xml:20-30`;
  - reference them from both widgets;
  - list them in the `style.qss` palette comment;
  - or reuse `colourActive`/`colourWarning` if the small differences aren't intentional.

### Suggestion

**S1. The new `channel` variable is redundant.** `skin/skin.xml:101`, `:112`; `skin/deck.xml:23`, `:72`. `lookupNodeGroup()` reads `<Group>` first and only falls back to `<Channel>`. Using `<Group><Variable name="group"/></Group>` on the `<Visual>` and `<Overview>` drops the second per-deck identifier, which could otherwise drift from `group`.

**S2. QSS still references the old placeholders, and the new widgets are unstyled.** `skin/style.qss:46-47` still lists `WLabel#WaveformPlaceholder` and `WLabel#OverviewPlaceholder`, which this commit removed. `BackToStart` and `OverviewKeySpace` have no rules, so the button will use Qt's default face rather than `colourButton` `#323232`. Fold this into the owner's visual check.

**S3. Confirm what back-to-start should do.** `skin/deck.xml:66`. `start_stop` jumps to the start **and stops**; `start` jumps and keeps the play state. Neither the roadmap nor `GLOSSARY.md` pins this down, so ask the owner which matches their Traktor habit. Also, the `↤` glyph (`:63`) is likely missing from Open Sans and will use a fallback font; fine as a stop-gap until an SVG is drawn.

**S4. The size tags don't fix sizes.** `skin/deck.xml:59`, `:101`
- `setupSize()` only fixes a width when the policy suffix is `f`. `48,me` and `64,me` set **minimum** widths and keep the default horizontal policy. Use `48f,me` / `64f,me` if fixed slots are intended.
- `DeckOverviewRow` (`:53-55`) uses vertical policy `f` with `Min 48`/`Max 56`. A fixed policy pins it to its size hint, so the 56 max does nothing. `<Size>me,48f</Size>` states the intent directly.

### Positive observations

- Uses Mixxx's own `<Visual>` and `<Overview>`, with `TooltipId`s `waveform_display` and `waveform_overview` (both exist in 2.5 `tooltips.cpp`).
- The overview's `playposition` connection with `EmitOnDownPress false` is the standard click-to-seek wiring. `DefaultMark` `%1` gives numbered hotcues on both widgets, as the acceptance criterion asks.
- `SignalRGB*` colours are set on the `<Visual>`, so the RGB waveform types already get the intended palette.
- A key-control slot is reserved on the right of the overview row, as scoped, without building sprint 05 controls.
- `xmllint --noout skin/skin.xml skin/deck.xml` passes.
- The sprint doc is honest: unverified items stay unchecked and Status says "awaiting Mixxx visual verification".

**OBSERVATIONS**
- Current waveform in the deck is very big (not sure if it will be smaller later)

