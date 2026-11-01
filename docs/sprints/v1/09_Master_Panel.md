# 09 · Master panel

**Status:** Not started
**Branch:** `v1-09`
**Target:** `target_images/master_volume.png`

## Goal

The centre of the FX row: master tempo, sync-leader mode and main volume.

## Scope

- **Master tempo** display (Mixxx's internal clock BPM).
- **AUTO / MASTER:** the sync-leader mode buttons. Find the Mixxx equivalents.
  AUTO means the leader is picked automatically, and MASTER means the internal clock
  leads. Note the mapping in `GLOSSARY.md` if it's new.
- **MAIN** volume knob (main output gain), with Traktor's blue value arc.
- Dropped and closed up: SNAP, QUANT, LINK, BOOST, and anything else in the
  image the owner doesn't use (e.g. TAP and nudge, unless the owner says otherwise).

## Out of scope

The FX units on either side.

## Tasks

- [ ] Tempo display
- [ ] AUTO / MASTER mapped and styled
- [ ] MAIN knob
- [ ] `mixxx.log` clean

## Acceptance criteria

- Side by side, the panel resembles Traktor's without the dropped items.
- MAIN changes the output level, the tempo shows the internal clock, and AUTO/MASTER
  switch the leader.

## Findings
