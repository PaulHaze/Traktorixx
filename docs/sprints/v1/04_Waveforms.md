# 04 · Waveforms (top priority)

**Status:** Not started
**Branch:** `v1-04`
**Target:** `target_images/traktor_dj_deck.png`, `traktor_full_with_library.png`

## Goal

The part the owner cares about most: each deck's **scrolling waveform** with the
**overview** beneath it, looking and behaving as close to Traktor as Mixxx allows.
This sprint finds Mixxx's limits early.

## Scope

- **Scrolling waveform** across the full deck width: fixed playhead (Traktor puts it
  left of centre; match it if Mixxx allows), beat grid lines, cue/hotcue markers,
  red playhead marker. It can be clicked or dragged to move through the track (Mixxx's
  standard behaviour).
- **Overview** below it: the whole track, numbered hotcue markers, play position,
  and a click to jump. Include the "back to start" button on its left, and leave
  space on the right for the key controls (sprint 05).
- **Colours:** Traktor-like spectral colouring (low = red/orange, mid = green,
  high = blue) using the skin's waveform signal colours, plus the beat grid,
  playhead and marker colours. Record which waveform type, chosen in Mixxx
  Preferences → Waveforms, gives the closest look. That's a user setting, not a
  skin setting.
- Waveform height uses most of the deck's height, as in Traktor.

## Out of scope

Track info, the transport/loop rows, the beatgrid panel.

## Tasks

- [ ] Read the skin guide and parser source for the waveform and overview widget options
- [ ] Scrolling waveform per deck, playhead position, markers
- [ ] Overview per deck, with hotcue numbers and the back-to-start button
- [ ] Spectral colours, then compare waveform types in Preferences
- [ ] Check click/drag behaviour on both
- [ ] `mixxx.log` clean

## Acceptance criteria

- With a track loaded on each deck, the waveforms read as "Traktor" side by side
  with `traktor_dj_deck.png`.
- Clicking the overview jumps to that point. The scrolling waveform supports scrubbing.
- Hotcues show as numbered markers on the overview.
- The recommended Preferences → Waveforms settings are written in Findings.
- Every Traktor waveform feature Mixxx can't match is listed in Findings.

## Findings
