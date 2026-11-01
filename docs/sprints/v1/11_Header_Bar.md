# 11 · Header bar

**Status:** Not started
**Branch:** `v1-11`
**Target:** the top strip of `target_images/traktor_full_with_library.png`

## Goal

A slim Traktor-style header with only the items the owner uses.

## Scope

- **Left:** a "Traktorixx" wordmark (original text treatment, not Traktor's logo).
- **Status items**, in Traktor's positions: **CPU** meter, **MIDI activity**,
  **power/battery** status, and the **main output level** meter (Traktor's long
  dotted bar).
- **Right:** **full screen** and **settings** buttons.
- Check that each one exists in Mixxx. MIDI activity and full screen are the
  uncertain ones. Drop and close up anything that doesn't exist, and note it in
  Findings.
- Not included: clock, record, layout dropdown, loop/Link, info, view toggles, ON AIR.

## Out of scope

Everything below the header.

## Tasks

- [ ] Wordmark
- [ ] CPU, MIDI, battery and main level meter (checked against Mixxx)
- [ ] Full screen and settings buttons (checked against Mixxx)
- [ ] `mixxx.log` clean

## Acceptance criteria

- Side by side, the header resembles Traktor's, minus the dropped items.
- Every item works: the CPU meter moves, battery shows the charging state, the level
  meter responds, full screen toggles, and settings opens Preferences.

## Findings
