# 03 · Colours and font

**Status:** Not started
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

- [ ] Sample the palette and record it, with names, in `style.qss`
- [ ] Skin variables for colours the XML needs
- [ ] Find the fonts bundled with Mixxx 2.5, pick one and set base sizes
- [ ] Apply to the skeleton
- [ ] `mixxx.log` clean

## Acceptance criteria

- Side by side with `traktor_full_with_library.png`, the skeleton's backgrounds and
  dividers read as the same dark Traktor tone.
- Placeholder text is easy to read at arm's length on a dark screen.
- The palette and font are written down in one place.

## Findings
