# 08 · Mixer

**Status:** Not started
**Branch:** `v1-08`
**Target:** `target_images/center_mix_console.png`, `individual_deck_knobs.png`,
`deck_mixer_control.png`

## Goal

The two mixer channels between the decks, mirrored as in Traktor: outer column
(gain/filter/FX/key/cue) and inner column (EQ/fader), one channel template used twice.

## Scope

Per channel:

- **GAIN** knob with a dB readout and the auto-gain dot (find what it maps to, e.g.
  ReplayGain; if there's no match, drop the dot).
- **FLTR** knob (the quick-effect filter) with its on/off dot.
- **FX 1 / 2** assign buttons (assign the channel to FX unit 1/2).
- **KEY:** a simple key lock **toggle button** (no knob).
- **Headphone cue** button.
- **HI / MID / LO** EQ knobs, each with a kill dot.
- **Channel fader** and the dotted **level meter** beside the EQ column.
- No PAN and no crossfader.
- Draw the knob and fader SVGs: dark knob, thin arc showing the value, Traktor style.

## Out of scope

The master panel and main volume (sprint 09).

## Tasks

- [ ] Channel template, mirrored for channels 1 and 2
- [ ] Knob, fader and dot SVGs
- [ ] Every control mapped and checked in the controls reference
- [ ] Level meters
- [ ] `mixxx.log` clean

## Acceptance criteria

- Side by side with `center_mix_console.png`, the layout and feel match.
- Every control works, and the FX 1/2 buttons route the channel to the matching unit.
- The meters respond to audio.

## Findings
