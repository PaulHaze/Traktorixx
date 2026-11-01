# 01 · Minimal skin that loads

**Status:** Done; owner verified in Mixxx
**Branch:** `v1-01`

## Goal

A skin of our own called **Traktorixx** that shows up in Mixxx 2.5.6's Preferences →
Interface, loads without errors, and reloads quickly while we develop it.

## Scope

- `skin/skin.xml` with a manifest (title Traktorixx, author Paul Hayes, version
  0.1, description, licence CC BY-NC 4.0) and a minimal layout: one window
  widget with a placeholder label. Enough to prove it loads.
- `skin/style.qss`, almost empty: a dark background so it's obviously our skin.
- A preview image for Preferences → Interface, if Mixxx 2.5 uses one. Check the
  skin guide for the filename. A simple placeholder is fine.
- The dev loop: symlink
  `~/Library/Containers/org.mixxx.mixxx/Data/Library/Application Support/Mixxx/skins/Traktorixx`
  → `<repo>/skin`. If the macOS sandbox blocks it, write `scripts/install.sh`
  (copies `skin/` to that path) instead, and update `AGENTS.md` → Dev loop.
- Confirm `--developer` mode and its reload-skin option work, and write the exact
  launch command and menu path into `AGENTS.md` → Dev loop.

## Out of scope

Any real layout, decks or styling.

## Tasks

- [x] Write `skin/skin.xml` (manifest + minimal layout)
- [x] Write `skin/style.qss`
- [x] Preview image (if needed)
- [x] Test the symlink and install the copy-script fallback after the sandbox blocks it
- [x] Check that Mixxx lists and loads the installed copy
- [x] Confirm reload-skin works in `--developer` mode
- [x] Update `AGENTS.md` → Dev loop with the verified steps
- [x] `mixxx.log` shows no skin errors or warnings

## Acceptance criteria

- Traktorixx appears in Preferences → Interface, and selecting it loads our placeholder window.
- Editing `skin/style.qss` and reloading shows the change without restarting Mixxx.
- `AGENTS.md` → Dev loop is marked verified, with exact commands.
- No skin errors or warnings in `mixxx.log`.

## Findings

- Mixxx 2.5.6 is installed at `/Applications/-- Audio --/Mixxx.app`.
- The macOS App Sandbox blocks the symlink to this checkout. An isolated
  `--developer --settings-path` run inside the Mixxx container logged
  `LegacySkinParser::openSkin - can't open file` for the linked `skin.xml`.
  `scripts/install.sh` now installs a copy in the requested user-skins path;
  running it replaces the old symlink. Repeat it before each reload.
- The root `<skin>` is itself the window's `WWidgetGroup` when it has a
  `<Layout>`; no separate `<Window>` tag is needed. Styles use `skin:style.qss`
  so they resolve independently of the launch directory.
- Mixxx 2.5 reads `skin_preview.png` and falls back to its own placeholder if
  absent. Added our own dark placeholder. Source:
  [LegacySkin::preview](https://github.com/mixxxdj/mixxx/blob/2.5/src/skin/legacy/legacyskin.cpp).
- The installed app's `--help` confirms `--developer`. The Developer menu was
  observed after launch; **Developer → Reload Skin** is confirmed in the
  [2.5 menu source](https://github.com/mixxxdj/mixxx/blob/2.5/src/widget/wmainmenubar.cpp)
  and [skin guide](https://github.com/mixxxdj/mixxx/wiki/Creating-Skins).
- Static verification passed: `xmllint --noout skin/skin.xml`, shell syntax
  checking, and installer execution. The installed files match `skin/`.
- **Owner verified (2026-11-01):** Traktorixx is listed in Preferences → Interface,
  loads, and renders the dark placeholder. The log (symlinked at `logs/mixxx.log`,
  git-ignored) shows `Loaded skin "Traktorixx"` with no skin warnings or errors;
  the other warnings in it (locale, Audio Units, window position) are unrelated.
