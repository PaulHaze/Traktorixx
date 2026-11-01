# 02 · Layout skeleton

**Status:** Not started
**Branch:** `v1-02`
**Target:** `target_images/traktor_full_with_library.png`

## Goal

The whole window divided into Traktorixx's areas, at roughly Traktor's proportions,
with labelled placeholder blocks and the real Mixxx library.

## Scope

From top to bottom:

1. **Header bar:** a thin strip.
2. **FX row:** FX unit 1 area (left, owned by deck A) | master panel (centre) | FX
   unit 2 area (right, owned by deck B). Each FX side is split in half: one half
   is the unit and the other is reserved empty space for a possible second unit.
3. **Deck row:** deck A | mixer | deck B. Each deck area is split into: info,
   waveform, overview, transport/loop row, and a beatgrid panel area. The beatgrid
   panel area is only a placeholder here. Sprint 07 makes it toggle.
4. **Library:** the real Mixxx library widgets (sidebar + track table + search),
   **always shown**, taking the remaining height.

Sizing:

- At 2560×1600, proportions should resemble the target image: the decks + FX + header
  take roughly the top half and the library the bottom half.
- Choose sensible minimum sizes so the window still works when smaller. Write
  down the minimum window size reached in Findings.
- Use templates for deck A/B (one deck template with a group parameter).

## Out of scope

Colours beyond simple placeholder tints, real controls, the waveform.

## Tasks

- [ ] Header / FX row / deck row / library structure in `skin.xml`
- [ ] Deck template used for `[Channel1]` and `[Channel2]`, with sub-areas
- [ ] FX row halves, with reserved space
- [ ] Mixer placeholder between the decks
- [ ] Real library widget, always visible
- [ ] Check resizing from 2560×1600 down to the minimum
- [ ] `mixxx.log` clean

## Acceptance criteria

- Side by side with the target image, every area is in the right place and roughly
  the right size.
- The library works: you can browse and load a track onto deck A/B (by drag or
  the library's load action).
- Resizing doesn't break the layout, and the minimum size is recorded.
- No skin errors or warnings.

## Findings
