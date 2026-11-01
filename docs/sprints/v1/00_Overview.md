# Epic v1: Traktorixx v1

**Goal:** an original Mixxx 2.5.6 skin, written from scratch in `skin/`, that resembles
the owner's Traktor setup (`target_images/traktor_full_with_library.png`) closely
enough to feel familiar in a club.

**Source of truth:** `docs/roadmap.md` (item 1) holds every decision. `GLOSSARY.md`
holds the names of things. `AGENTS.md` holds the conventions and reference docs.

## Rules for every sprint

1. **One sprint at a time, in numeric order.** Each sprint is one branch, `v1-{nn}`.
   The owner checks the result in Mixxx before the next sprint starts.
2. **Never copy** from `../Traktmixxx-RAW/` or Mixxx's bundled skins. Read them to
   learn how something works, then write your own. All SVGs are drawn fresh.
3. **Don't guess control names.** Look up every `[Group],key` in the Mixxx controls
   reference (see `AGENTS.md`).
4. **No errors or new warnings.** After every change, reload the skin and check
   `mixxx.log` for skin warnings or errors.
5. **Stay in scope.** If something isn't in the sprint file, don't build it. Note it
   in `docs/brainstorms.md`. Anything Traktor has that Mixxx can't do goes in the
   sprint's **Findings** section, so the owner can decide.
6. **Resemble, don't clone.** Compare against the named target image side by side.
   Getting close in layout, proportion and colour is the bar, not pixel-perfect.
7. **Keep it lean.** One fixed layout. Templates only for real repetition (deck A/B,
   mixer channel 1/2, FX unit 1/2). Shared sizes and colours go in skin variables
   once sprint 03 defines them.
8. **Size budget:** the full window must work at 2560×1600 and shrink sensibly. Never
   let a sprint push the minimum window size above what the owner's screens can show.
9. Update the sprint's **Status** and checkboxes as you work.

## Sprints

| # | File | Builds |
|---|---|---|
| 01 | `01_Minimal_Skin.md` | A minimal skin that loads, plus the copy-install dev loop |
| 02 | `02_Layout_Skeleton.md` | Header / FX row / decks + mixer / library areas |
| 03 | `03_Colours_And_Font.md` | Colour palette, font, base QSS |
| 04 | `04_Waveforms.md` | Scrolling waveform and overview per deck (top priority) |
| 05 | `05_Deck_Info_Sync_Pitch.md` | Track info, SYNC/MASTER, nudge, pitch fader, key lock/adjust |
| 06 | `06_Transport_And_Loops.md` | Play/CUE/CUP and the loop row |
| 07 | `07_Beatgrid_Panel.md` | Beatgrid panel with the shared ^ toggle |
| 08 | `08_Mixer.md` | Mixer channel strips |
| 09 | `09_Master_Panel.md` | Master tempo, AUTO/MASTER, MAIN |
| 10 | `10_FX_Units.md` | FX unit template, then units 1 and 2 |
| 11 | `11_Header_Bar.md` | Header bar |
| 12 | `12_Library.md` | Library recolour |

## Dependencies

- 01 → 02 → 03 must happen in order (load, then structure, then look).
- 04–12 depend on 02 and 03. They run in numeric order, but each only touches its
  own area.
- 07 depends on 06, because the ^ button sits at the end of the loop row.
- 10 needs the FX "1/2" assign buttons from 08 to test routing.
