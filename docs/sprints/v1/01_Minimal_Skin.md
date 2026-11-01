# 01 · Minimal skin that loads

**Status:** Not started
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

- [ ] Write `skin/skin.xml` (manifest + minimal layout)
- [ ] Write `skin/style.qss`
- [ ] Preview image (if needed)
- [ ] Create the symlink. Check that Mixxx lists and loads it. If it doesn't, use the copy-script fallback
- [ ] Confirm reload-skin works in `--developer` mode
- [ ] Update `AGENTS.md` → Dev loop with the verified steps
- [ ] `mixxx.log` shows no skin errors or warnings

## Acceptance criteria

- Traktorixx appears in Preferences → Interface, and selecting it loads our placeholder window.
- Editing `skin/style.qss` and reloading shows the change without restarting Mixxx.
- `AGENTS.md` → Dev loop is marked verified, with exact commands.
- No skin errors or warnings in `mixxx.log`.

## Findings

_(Sandbox behaviour, preview filename, anything surprising.)_
