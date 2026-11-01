# 05 · Deck info, sync row, pitch and key

**Status:** Not started
**Branch:** `v1-05`
**Target:** `target_images/traktor_dj_deck.png`

## Goal

Everything around each deck's waveform except transport and loops.

## Scope

- **Track info** (top of the deck): cover art, title (large), artist, label
  (check whether Mixxx has a "label" track field; if not, use album and note it),
  elapsed time, remaining time, BPM, tempo %, and the deck letter **A** / **B** in
  accent orange.
- **Sync row:** SYNC, MASTER (the deck's sync leader button), and the two nudge
  (tempo-bend) buttons on the right. No phase meter.
- **Pitch fader** on the deck's right edge, styled like Traktor's (thin track, flat cap).
- **Key lock** button and **key adjust** ‹ › chevrons at the right end of the
  overview row.
- First knob/button SVGs as needed (simple, flat, Traktor-like). Draw them fresh.

## Out of scope

Transport, loops, beatgrid panel, mixer.

## Tasks

- [ ] Track info block, with the fields above
- [ ] SYNC / MASTER / nudge buttons
- [ ] Pitch fader
- [ ] Key lock + key adjust
- [ ] Look up every control name in the controls reference
- [ ] `mixxx.log` clean

## Acceptance criteria

- Side by side with `traktor_dj_deck.png`, the info block, sync row and pitch fader
  match its arrangement and feel.
- Every control works: SYNC syncs, MASTER sets the leader, nudge bends tempo, the
  pitch fader changes tempo, key lock holds pitch, and key ‹ › shifts key.
- Time, BPM and tempo % update live.

## Findings
