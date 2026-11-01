# Roadmap

Holds one or two grilled items at most. See the planning flow in `AGENTS.md`.

## 1. Traktorixx v1: Traktor look for the owner's 2-deck setup

**Goal:** Traktmixxx-RAW copied into `skin/`, loading cleanly on Mixxx 2.5.6, cut
down to the owner's features, then restyled section by section to match
`target_images/`.

### Decisions (from grilling)

- **Mixxx version:** 2.5.6 on macOS only.
- **Base:** copy of `../Traktmixxx-RAW/`. The old Traktmixxx folder is dropped.
- **Location:** `skin/` in this repo, symlinked into Mixxx's user skins folder as
  `Traktorixx`. Fall back to a copy script if the sandbox blocks the link.
- **Decks:** 2 only (A/B). Deck 3/4 and deck switching are removed.
- **Features:** only what appears in `target_images/`. Removed: samplers,
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
- **Reference shots:** `traktor_full_with_library.png` is the whole target window.
  `mixx_full_with_library.png` is the owner's current Mixxx (LateNight skin), kept
  as the "before" picture.

### Open

- Still being grilled.
