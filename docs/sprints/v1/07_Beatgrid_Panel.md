# 07 · Beatgrid panel

**Status:** Not started
**Branch:** `v1-07`
**Target:** `target_images/beatgrid_subsection.png`

## Goal

The track-preparation panel under each deck, hidden by default, with one **^** press
showing or hiding it on **both** decks.

## Scope

- **^ toggle:** one shared show/hide state for both decks, remembered between
  sessions (a skin-level persistent control/variable). Either deck's ^ button
  toggles it.
- **Panel contents**, as far as Mixxx supports them: grid/cue nudge buttons, grid
  lock, BPM display/edit box, grid shift ‹ ›, set grid at the current position
  (↻GRID), BPM ×2 and /2, TAP, and delete-cue / MOVE-CUE-GRID if they map. Check
  each against the controls reference, then drop and close up anything with no
  Mixxx equivalent, listing it in Findings.
- When hidden, the panel's space goes to the **library**, which grows. The deck's
  waveform height stays the same whether the panel is open or not.

## Out of scope

Anything else on the deck.

## Tasks

- [ ] Shared, persistent show/hide state wired to both ^ buttons
- [ ] Map each Traktor grid control to a Mixxx control, or drop it
- [ ] Panel layout and styling
- [ ] `mixxx.log` clean

## Acceptance criteria

- One ^ press opens the panel on both decks. Pressing again closes both. The state
  survives a Mixxx restart.
- Every control in the panel works on its own deck.
- Hidden by default on a fresh profile.
- Opening or closing the panel only changes the library's height. The waveforms
  don't move or resize.

## Findings
