# Traktorixx

A [Mixxx](https://mixxx.org) skin that makes Mixxx look and feel like Traktor.

> **🚧 Work in progress.** This skin isn't usable yet. The plan is finished and
> building has started, one small step at a time. Expect things to be missing,
> broken or changing.

## Why

I moved from Traktor to Mixxx and missed the layout I'd spent years getting used to.
Traktorixx aims to **resemble** my Traktor setup, not clone it pixel for pixel. It keeps
Traktor's arrangement, proportions and feel, so Mixxx feels familiar in a dark club.

It's built around how I DJ:

- **2 decks** (A and B), with no 4-deck mode
- **Traktor-style decks:** a full-width scrolling waveform with a clickable whole-track
  overview underneath, SYNC/MASTER, pitch fader, key lock, and Traktor's CUE and CUP
  button behaviour
- **Loop row:** size selector, IN/OUT and loop on/off
- **Beatgrid panel** for preparing tracks. One button opens it on both decks.
- **Mixer** with gain, filter, FX assign, key lock, headphone cue, 3-band EQ with kills,
  and channel faders
- **FX row** with one single-effect FX unit per deck on either side of a master panel
  (master tempo, AUTO/MASTER, main volume)
- **Library**: Mixxx's standard library, always shown below the decks and recoloured
  to match

Traktor features I don't use, or that Mixxx doesn't have, are left out on purpose. If
you need 4 decks, samplers and so on, fork it and add them. You're very welcome to.

## Status & roadmap

| | |
|---|---|
| Mixxx version | 2.5.6 |
| Developed on | macOS |
| Planned | Linux (tested on a 2560×1600 laptop) |
| Max design size | 2560×1600 |

The full plan and every decision behind it are in [`docs/roadmap.md`](docs/roadmap.md).
The skin is written from scratch in small numbered sprints: a minimal skin that
loads, then the layout skeleton, colours and font, then each section in turn,
starting with the waveforms.

## Installing (once it's usable)

Mixxx loads skins from a `skins` folder in its user settings directory. Copy or
symlink this repo's `skin/` folder in there, naming it `Traktorixx`:

- **macOS:** `~/Library/Containers/org.mixxx.mixxx/Data/Library/Application Support/Mixxx/skins/Traktorixx`
- **Linux:** `~/.mixxx/skins/Traktorixx` (Flatpak: `~/.var/app/org.mixxx.Mixxx/.mixxx/skins/Traktorixx`)

Then restart Mixxx, open **Preferences → Interface**, and pick **Traktorixx**.

## Repo layout

```
skin/            the Mixxx skin itself (skin.xml, style.qss, assets)
docs/            roadmap and sprint plans
target_images/   reference screenshots of my Traktor setup, the look I'm aiming for
GLOSSARY.md      the names used for each part of the skin
AGENTS.md        instructions for the AI agents working on this repo
```

## Built with Claude

I'm being upfront: this skin is being built with a lot of help from AI. I use
[Claude Code](https://claude.com/claude-code) (Anthropic's Claude) to plan the work,
write the skin XML and stylesheets, and review changes. I make the decisions and
check every change in Mixxx myself. `AGENTS.md`, `GLOSSARY.md` and `docs/` are the
working notes that keep the AI on track. Have a look if you're curious how that works.

## Credits

Traktorixx is written from scratch by **Paul Hayes** ([PaulHaze](https://github.com/PaulHaze)).

Thanks to these skins, which were great references and inspiration (no code or
artwork from them is used):

- [RoundCorners](https://github.com/22degrees) by **22degrees**
- [Traktmixxx](https://mixxx.discourse.group/t/traktmixxx-forked-from-roundcorners/18370)
  by **intialonso**
- [Traktmixxx-RAW](https://github.com/djraw/Traktmixxx-RAW) by **djraw**
- Mixxx's own bundled skins

## Licence

[Creative Commons Attribution-NonCommercial 4.0](https://creativecommons.org/licenses/by-nc/4.0/)
(CC BY-NC 4.0). See [`LICENSE`](LICENSE).

**Use it, change it, share it, and draw inspiration from it. Just don't use it for
anything commercial.** You don't have to credit me, although a mention is always nice.

## Disclaimer

Not affiliated with or endorsed by Native Instruments. Traktor is a trademark of
Native Instruments GmbH. The name is used here only to describe the look this skin is
inspired by. No Native Instruments code or artwork is included in the skin. The
screenshots in `target_images/` are for reference only.
