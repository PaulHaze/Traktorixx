# 03 · Colours and font

**Status:** Done
**Branch:** `v1-03`
**Target:** all `target_images/traktor_*.png`

## Goal

One small, named palette and one font, applied as the skin's base look, so every
later sprint just reuses them.

## Scope

- **Palette:** sample colours from the target images: window background, panel
  background, panel border/divider, button face, button active (Traktor blue),
  text primary, text secondary/label, accent orange (deck letter, FX number),
  warning red (playhead), and the deck A/B accents if they differ. Keep it to
  about 12 colours or fewer.
- Write the palette down in one place: skin variables in `skin.xml` where the XML
  needs them, and a commented palette block at the top of `style.qss` (QSS has no
  variables, so reuse the exact hex values).
- **Font:** pick one of the fonts that ship with Mixxx (find out which), chosen for
  readability at small sizes on a dark background. Set the base font family and
  sizes (labels, values, track title) in QSS.
- Apply the base look to the skeleton from sprint 02: backgrounds, dividers and
  placeholder text.

## Out of scope

Styling individual controls (each section's sprint does that), and the library
colours (sprint 12).

## Tasks

- [x] Sample the palette and record it, with names, in `style.qss`
- [x] Skin variables for colours the XML needs
- [x] Find the fonts bundled with Mixxx 2.5, pick one and set base sizes
- [x] Apply to the skeleton
- [x] `mixxx.log` clean

## Acceptance criteria

- Side by side with `traktor_full_with_library.png`, the skeleton's backgrounds and
  dividers read as the same dark Traktor tone.
- Placeholder text is easy to read at arm's length on a dark screen.
- The palette and font are written down in one place.

## Findings

- Sampled the solid-colour frequency peaks in all 12 Traktor reference PNGs,
  then checked the full-window track-info, deck-letter, FX-number and playhead
  regions separately. The palette has nine unique colours; names and exact hex
  values are documented together at the top of `skin/style.qss`.
- The large window/deck/mixer/FX surfaces are `#181818`, transport and beatgrid
  surfaces `#262626`, and dividers black. The target's deck A letter and FX
  numbers use `#fa7242`; deck B's letter is `#a0a0a0`, shared with labels.
  Blue (`#448bf6`), warning red (`#e3423f`) and button face (`#323232`) are reserved
  for the controls introduced by later sprints.
- Matching global XML variables are defined before the templates in `skin.xml`,
  following the [Mixxx variable placement rules](https://github.com/mixxxdj/mixxx/wiki/Creating-Skins#using-variables).
  Deck accents alias existing colours. The current placeholders use QSS; the
  variables are ready for native widget colour tags, including sprint 04's waveforms.
- The installed Mixxx 2.5.6 resources bundle Open Sans (Regular, Semibold, Bold)
  and Ubuntu (Regular, Bold). Its developer startup log confirms both font
  families load. Chose Open Sans, with 14 px base/labels, 16 px values and 18 px
  semibold track titles. QSS documents the `Value` / `TrackTitle` object names
  for later labels. Typography explicitly includes child widgets, per
  [Qt's stylesheet inheritance rules](https://doc.qt.io/qt-6/stylesheet-syntax.html#inheritance),
  and is scoped to the performance area. Library colours remain for sprint 12.
- Primary `#c0c0c0` and secondary `#a0a0a0` text have calculated contrast ratios
  of 8.32:1 and 5.79:1 respectively against the lighter `#262626` panel.
- `xmllint --noout skin/skin.xml skin/deck.xml`, palette consistency checks and
  `git diff --check` passed. The copy installer ran after the final skin edit.
- Owner check still needed: reload the installed skin, compare its neutral
  backgrounds/dividers with `traktor_full_with_library.png`, and judge placeholder
  readability at arm's length. Desktop capture did not expose the Mixxx window,
  so no rendered visual check or physical readability check is claimed.
- Native Mixxx verification was attempted with separate settings and an empty
  library, leaving the owner's running instance untouched. Startup confirmed
  version 2.5.6 and the bundled fonts, but did not reach the skin parser or log
  `Loaded skin "Traktorixx"`. Repeating with the sprint 02 config shape and its
  audio configuration did not resolve this. Consequently the `mixxx.log` task is
  still unchecked; check the owner's log after Reload Skin. The last attempt's
  log is saved locally at `logs/v1-03-load.log` (git-ignored). The isolated
  verification instance was stopped afterwards.
- **Owner check (2026-11-01):** after `install.sh` and reloading the skin, the
  owner approved the colour scheme: backgrounds and dividers match the dark
  Traktor tone, and placeholder text is readable. The owner's `mixxx.log` shows
  `Loaded skin "Traktorixx"` at 17:10:36 with no skin warnings. The only other
  warnings, an `image/png` MIME message and a controller `slotApply`, are
  unrelated to the skin.
