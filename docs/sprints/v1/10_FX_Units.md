# 10 · FX units

**Status:** Not started
**Branch:** `v1-10`
**Target:** `target_images/fx_strip.png`

## Goal

One reusable **single-effect mode** FX unit template, placed as unit 1 (left, deck A)
and unit 2 (right, deck B, mirrored), each in its half of the FX row.

## Scope

- **Template** (parameterised by unit number and mirroring):
  - Unit number label ("1", "2") in accent orange
  - **D/W** knob (the unit's mix) with an **ON/OFF** button under it
  - **Effect chooser** dropdown (shows the effect name)
  - **3 parameter knobs** with labels taken from the loaded effect
  - **3 parameter buttons** under them, with labels from the effect
- Single-effect mode means showing **one effect slot** of the Mixxx effect unit and
  its parameters. Check how Mixxx exposes parameter names and button parameters.
- The second half of each FX side stays empty, reserved for a later second unit.
- Place unit 1, check it, then place unit 2.

## Out of scope

Group mode, a second unit per side, and the empty space.

## Tasks

- [ ] Look up effect unit, slot and parameter controls and label widgets
- [ ] Build the template and place unit 1
- [ ] Place unit 2, mirrored
- [ ] Check routing with the mixer FX 1/2 buttons
- [ ] `mixxx.log` clean

## Acceptance criteria

- Side by side with `fx_strip.png`, unit 1 resembles it.
- Choosing an effect updates the knob and button labels, and every knob, button and D/W
  works.
- Assigning deck A to FX 1 in the mixer puts the effect on deck A's audio.

## Findings
