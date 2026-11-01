# 02 · Layout skeleton

**Status:** Done
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

- [x] Header / FX row / deck row / library structure in `skin.xml`
- [x] Deck template used for `[Channel1]` and `[Channel2]`, with sub-areas
- [x] FX row halves, with reserved space
- [x] Mixer placeholder between the decks
- [x] Real library widget, always visible
- [x] Check resizing from 2560×1600 down to the minimum
- [x] `mixxx.log` clean

## Acceptance criteria

- Side by side with the target image, every area is in the right place and roughly
  the right size.
- The library works: you can browse and load a track onto deck A/B (by drag or
  the library's load action).
- Resizing doesn't break the layout, and the minimum size is recorded.
- No skin errors or warnings.

## Findings

- Added original labelled placeholders for all planned areas. The master and
  mixer use the same 320 px centre column. Each FX side has equal halves, with
  unit 1 on the outer left and unit 2 on the outer right.
- The performance area grows up to 740 px, leaving roughly the lower half for
  the library at 2560×1600. At smaller sizes it can shrink to 480 px. The library
  has a 220 px minimum height and cannot collapse; its sidebar width is adjustable.
- **Configured minimum: 1024×720 skin pixels.** The deck columns have a 320 px
  minimum each. This replaces sprint 01's temporary 640×360 minimum now that the
  actual layout and library need space. The minimum size actually reached by
  resizing is **not yet verified**. Mixxx's UI scale factor also affects the
  resulting screen size.
- The single deck template takes a group parameter. Its native
  `TrackWidgetGroup` provides a library drop target for each deck without adding
  transport controls. The library uses Mixxx's native `SearchBox`,
  `LibrarySidebar` and `Library` widgets. Widget behaviour was checked against the
  [Mixxx 2.5 parser](https://github.com/mixxxdj/mixxx/blob/2.5/src/skin/legacy/legacyskinparser.cpp).
- `xmllint --noout skin/skin.xml skin/deck.xml` and `git diff --check` passed.
  The copy installer ran successfully after the final skin edit.
- An isolated native Mixxx 2.5.6 launch loaded `Traktorixx` with no skin parser
  warnings or errors. The log is saved locally at `logs/v1-02-load.log`
  (git-ignored). Its warnings concern locale, installed Audio Units, the fresh
  settings directory's sampler bank and audio timestamps. Offscreen/safe-mode
  attempts exited before loading the skin; the successful run used normal
  rendering with separate settings and an empty library.
- **Fix after owner check (2026-11-01):** in Mixxx, the FX sides and both decks
  were empty. Only the header, master, mixer and library showed. Cause:
  `WWidgetGroup::setup` gives every group layout `Qt::AlignCenter`. A layout
  aligned like that fills the width only if a child expands horizontally.
  Otherwise it shrinks to its preferred width. Horizontal `Ignored` (`i`) never
  expands and has a preferred width of 0, so those areas collapsed to nothing.
  All `i` horizontal policies are now `me`. **Rule: don't use `i` in a skin
  `SizePolicy`; use `me`/`e` for areas that share width.**
- **Owner check (2026-11-01), after the fix:** all areas show in the right
  places compared with the target. Library drag-and-drop works on both decks:
  the drop is accepted, and the loaded track plays with the keyboard (`D` / `L`).
  No skin warnings in `mixxx.log` after reloading. The centre column (fixed
  320 px) is wider than the target's share at small window sizes. Tune it when
  the real mixer goes in. The owner then checked resizing down to the minimum (configured
  minimum 1024×720) and the 2560×1600 proportions: both fine.
- **Original owner check list:** compare with the target at 2560×1600, resize down to
  the minimum, search/browse and load a track on A/B, then inspect `mixxx.log`
  after reloading. Automated GUI interaction was unavailable because macOS
  denied assistive access to `osascript`.
