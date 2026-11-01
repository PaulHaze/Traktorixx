# 06 · Transport and loop row

**Status:** Not started
**Branch:** `v1-06`
**Target:** `target_images/cue_deck_subsection.png`, `cue_only_subsection.png`,
`beatjump_and_loop_subsection.png`

## Goal

The row under each deck's overview: transport on the left, loops on the right,
behaving as described in `GLOSSARY.md`.

## Scope

- **Play** button.
- **CUE:** behaves as in `GLOSSARY.md`. Hold to play from the cue point, release
  to return. If PLAY is pressed while CUE is held, playback carries on after CUE is
  released.
- **CUP:** pressing jumps to the cue point and holds there, and playback starts on release.
- Find out how Mixxx provides each behaviour. Some depend on the **cue mode** user
  preference, not the skin. Record the required Preferences setting in Findings.
- **Loop row:** size selector showing four sizes with ‹ › paging (1/4, 1/2, 1, 2 …
  up to 8 and beyond), with the active size highlighted. Then **IN**, **OUT** and
  loop on/off.
- The **^** button at the far right. Its look only; sprint 07 wires it up.
- No FLX or REV.

## Out of scope

The beatgrid panel and the behaviour of ^.

## Tasks

- [ ] Play / CUE / CUP buttons
- [ ] Find the controls and cue-mode setting that give the GLOSSARY behaviours
- [ ] Loop size selector with paging and active highlight
- [ ] IN / OUT / loop toggle
- [ ] ^ button (visual only)
- [ ] `mixxx.log` clean

## Acceptance criteria

- CUE, CUE+PLAY and CUP behave exactly as `GLOSSARY.md` describes (owner tests it).
- Selecting a loop size and pressing loop on/off loops that many beats. IN/OUT set a
  manual loop.
- Side by side, the row resembles Traktor's.

## Findings
