# Roadmap

Holds one or two grilled items at most. See the planning flow in `AGENTS.md`.

## 1. Traktorixx v1: Traktor look for the owner's 2-deck setup

**Goal:** an original skin in `skin/`, written from scratch for Mixxx 2.5.6 and
built up section by section until it resembles `target_images/`.

### Decisions (from grilling)

- **Mixxx version:** 2.5.6. Built on macOS. A Linux port for the Lenovo
  (2560×1600) comes later.
- **Screen size:** 2560×1600 is the maximum design size.
- **Base:** none. Written from scratch (decided after first choosing to copy RAW).
  `../Traktmixxx-RAW/` and Mixxx's bundled skins are read-only references. Never copy
  from them. This keeps the skin all the owner's own work and allows a
  non-commercial licence (CC BY-NC 4.0).
- **Location:** `skin/` in this repo, symlinked into Mixxx's user skins folder as
  `Traktorixx`. Fall back to a copy script if the sandbox blocks the link.
- **Decks:** 2 only (A/B). No deck 3/4 or deck switching.
- **Features:** only what appears in `target_images/`. Not included: samplers,
  microphone, aux and vinyl control.
- **Library:** always shown below the decks. It keeps Mixxx's standard library
  layout and is only recoloured to match the skin. Lowest priority.
- **FX:** two FX units, both in single-effect mode (`fx_strip.png`): D/W and on/off
  plus 3 parameter knobs and 3 parameter buttons. Unit 1 sits on the left of the
  FX row and unit 2 on the right (mirrored). Each channel gets FX "1" and "2" assign
  buttons. Ignore the group-mode unit 2 in `traktor_full.png`. That's Traktor's
  default and the owner would swap it out. Build unit 1 first.
- **FX placement:** unit 1 on the left belongs to deck A, and unit 2 on the right
  belongs to deck B. Each unit takes **half** the width of its side of the FX row.
  The other half is kept free for a possible second unit per side (up to 4 units,
  which Mixxx supports). Build each unit as a reusable template so adding one
  only means placing it.
- **Layout:** follow the arrangement in `target_images/traktor_full_with_library.png`.
  From top to bottom: header bar, then the FX row (FX unit 1 | master panel |
  FX unit 2), then deck A | mixer | deck B, then the library. Each deck has its
  waveform and overview inside it, not in a separate waveform area.
- **Header bar:** a "Traktorixx" wordmark where Traktor's logo is, then the items
  the owner actually uses, in Traktor's positions: CPU meter, MIDI activity,
  power/battery status, main output level meter, full screen and settings. Not
  included: the layout ("Mixer") dropdown, loop/Link and info buttons, view toggles
  and ON AIR. Full screen and MIDI activity still need checking against Mixxx's controls.
- **Fidelity:** the skin should *resemble* Traktor so it feels familiar. It is
  not a 1:1 clone. If a Traktor item is unused by the owner or has no Mixxx match,
  drop it and close up the space. Each section keeps Traktor's overall zones,
  proportions and feel.
- **Master panel** (centre of the FX row): keep the master tempo display,
  AUTO/MASTER (sync leader) and the MAIN volume knob. Drop SNAP, QUANT, LINK and
  BOOST (the owner doesn't use them, and BOOST is a Traktor plugin).
- **Header leftovers:** drop the clock and record button (not on the owner's list).
- **Deck** (`traktor_dj_deck.png`). Keep, in Traktor's arrangement:
  - **Track info:** cover art, title, artist, label, BPM, tempo %, elapsed and
    remaining time, deck letter. Close to the screenshot as it is. Check that Mixxx
    has a "label" field; if it doesn't, choose a substitute (e.g. album).
  - **Sync row:** SYNC and MASTER are used constantly. The two nudge (tempo-bend)
    buttons are rarely used (the controller does it) but stay. Drop the phase meter
    unless it turns out to come free with SYNC.
  - **Pitch fader:** must stay.
  - **Waveforms: highest priority to get right.** A full-width scrolling waveform
    with the beat grid and cue markers, and below it a smaller **overview** of the
    whole track with numbered hotcues. Both can be clicked to move through the
    track. Match Traktor's look and behaviour as closely as Mixxx allows, and
    report any gaps found.
  - **Key lock** button and **key adjust** ‹ › chevrons: keep.
  - **Transport:** play, CUE and CUP, with Traktor's press/release behaviour (see
    `GLOSSARY.md`). Drop FLX and REV.
  - **Loop row:** used a lot. Size selector (1/2, 1, 2, 4, 8 with ‹ › paging), IN, OUT
    and loop on/off.
  - **Beatgrid panel** (grid edit, BPM box, TAP, MOVE/CUE/GRID): used a lot while
    preparing tracks, never while DJing. Hidden by default. The **^** button on
    either deck shows or hides it on **both** decks together, as in current Traktor
    (Mixxx remembers the state).
    When hidden, its space goes to the library. The waveforms keep their height.
- **Mixer** (`center_mix_console.png`, `individual_deck_knobs.png`,
  `deck_mixer_control.png`). Per channel: GAIN with dB readout and auto-gain dot,
  FLTR with on/off, FX 1/2 assign, a KEY **key lock toggle button** (the knob is
  never used to change key, so it goes), headphone cue, HI/MID/LO
  with kill dots, channel fader and level meter. Drop PAN. No crossfader.
- **Font:** use a font that already ships with Mixxx, so nothing needs installing
  on either machine. Choose the one that reads best at small sizes in a dark club.
  Matching Traktor's font doesn't matter.
- **Reference shots:** `traktor_full_with_library.png` is the whole target window.
  `mixx_full_with_library.png` is the owner's current Mixxx (LateNight skin), kept
  as the "before" picture.

### Sprint order (epic `v1`, branches `v1-{nn}`)

01. Minimal skin in `skin/` (skin.xml + style.qss) that loads on 2.5.6, plus the symlink (check the sandbox allows it)
02. Layout skeleton: header / FX row / deck A–mixer–deck B / library (the real library widget), sized for 2560×1600 max
03. Global colours (sampled from the target images) and font
04. Deck: scrolling waveform and overview (top priority, so any Mixxx limits show up early)
05. Deck: track info, sync row, pitch fader, key lock and key adjust
06. Deck: transport (CUE/CUP behaviour) and loop row
07. Beatgrid panel with the shared ^ toggle
08. Mixer channel strips (first knob/fader SVGs drawn here)
09. Master panel
10. FX unit template, then units 1 and 2
11. Header bar
12. Library recolour

### Open

- None. Grilling finished on 2026-11-01. Sprints planned in `docs/sprints/v1/`.
