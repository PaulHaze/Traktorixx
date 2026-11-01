## Audit: last commit 9774ace — Add minimal Traktorixx skin and macOS development installer

_Scope: Sprint 01 — Minimal skin that loads (from `docs/sprints/v1/01_Minimal_Skin.md`)_

Branch `v1-01` maps to exactly one sprint file: `docs/sprints/v1/01_Minimal_Skin.md`.

Files audited: `skin/skin.xml`, `skin/style.qss`, `skin/skin_preview.png`, `scripts/install.sh`, plus the `AGENTS.md` Dev loop section and the sprint file, which the sprint scope requires to be updated. Claims about Mixxx were checked against the 2.5 branch source: `legacyskinparser.cpp`, `legacyskin.cpp`, `skincontext.h`, `wlabel.cpp`.

### Warning

1. **The sprint is not finished. 3 of its 4 acceptance criteria are still unverified** (`docs/sprints/v1/01_Minimal_Skin.md:36-46`).
   - Still open: "appears in Preferences and loads", "QSS edit shows on reload", and "no skin errors/warnings in `mixxx.log`". The commit is honest about this. The Status line says "awaiting owner GUI verification" and those tasks are left unchecked.
   - Don't run `/new-task` until the owner has done these checks.
   - A clean log does **not** prove the stylesheet loaded. `LegacySkinParser::getStyleFromNode` opens the `<Style src>` file with no `else` branch (`legacyskinparser.cpp:2165-2172`). A wrong path fails silently and logs no warning.
   - So the visible `#202124` background is the only proof that `style.qss` was applied.
   - The log line `Skin is a >=1.12.0 style skin.` (`legacyskinparser.cpp:492`) confirms the root `<skin>` was parsed as a new-style `WWidgetGroup`.
   - Suggested fix: the owner runs the checks. When ticking the boxes, record in Findings that the dark background showed and that the `>=1.12.0` line is in the log.

2. **The installer never removes stale files** (`scripts/install.sh:13-14`).
   - `cp -R "$repo_dir/skin/." "$destination/"` adds and overwrites files but never deletes them. A file that is renamed or deleted in `skin/` stays in the installed copy.
   - Example: a future sprint renames an SVG but leaves an old `skin.xml` reference. Mixxx still finds the stale file, so the log stays clean. The missing asset then only shows up on a fresh install, such as the Linux gig machine.
   - This undermines Overview rule 4 ("No errors or new warnings") in every later sprint.
   - Suggested fix: replace lines 13-14 with a mirroring copy:
     ```sh
     mkdir -p "$destination"
     rsync -a --delete --exclude '.DS_Store' "$repo_dir/skin/" "$destination/"
     ```
     `rsync` ships with macOS and Linux. Another option is `rm -rf "$destination"` before `mkdir -p`. That is safe here because the path is fixed and `set -u` guards `$HOME`.

### Suggestion

3. **The Dev loop wording in `AGENTS.md` overstates what was verified, and it contains notes about one agent session** (`AGENTS.md:81`, `AGENTS.md:101-103`).
   - "**Verified on Mixxx 2.5.6:**" opens the whole Dev loop section. What was verified is only that the sandbox blocks the symlink. The copy-install load and the reload have not been verified yet.
   - Lines 101-103 ("this agent's macOS Accessibility/Screen Recording access does not allow those checks") describe one agent's session. They belong in the sprint Findings, not in the master reference that every agent reads.
   - Acceptance criterion 3 ("Dev loop is marked verified, with exact commands") is therefore only partly met.
   - Suggested fix: after the owner checks, change line 81 to cover the whole loop, for example "Verified on Mixxx 2.5.6 (owner, <date>)". Remove the agent-access sentence from lines 101-103.

4. **The repo root path in `AGENTS.md` is wrong** (`AGENTS.md:45-46`; this predates the commit, but the file was touched here).
   - It says `/Users/paulhayes/code/AI/traktor_skin/custom_taktor_skin`. The checkout is actually `/Users/paulhayes/code/AI/traktor_skin/traktorixx`.
   - `../Traktmixxx-RAW/` still resolves correctly from the real path. But an agent that follows the absolute path will hit a directory that does not exist.
   - Suggested fix: update the path to `.../traktor_skin/traktorixx`.

5. **The Overview still describes a symlink dev loop** (`docs/sprints/v1/00_Overview.md:36`).
   - The sprints table says "plus the symlink dev loop". The sprint has since found that the symlink does not work.
   - Suggested fix: change it to "plus the copy-install dev loop".

6. **The global `WLabel` selector will style every future label** (`skin/style.qss:2`).
   - `WWidgetGroup#Traktorixx, WLabel` gives every `WLabel` in the skin a solid `#202124` background. Sprint 02 adds layout areas with their own backgrounds. Any label placed in those areas will then show a dark box until sprint 03 replaces the QSS.
   - Suggested fix: scope it to `#Traktorixx WLabel`, or give the placeholder label an `<ObjectName>` and target that. Another option is to let labels inherit the background and set only `color`.

7. **The preview colour doesn't match the skin** (`skin/skin_preview.png`).
   - The preview background is `#2b2c30`, while the QSS background is `#202124`. The preview was rendered separately rather than taken as a screenshot. This is acceptable for a placeholder under the sprint scope.
   - Suggested fix: replace it with a real screenshot once the layout exists (sprint 02/03 or later). No action needed now.

### Positive observations

- **Every claim in the sprint Findings checks out against the Mixxx 2.5 source:**
  - A root `<skin>` with `<Layout>` is parsed as a single `WWidgetGroup` (`legacyskinparser.cpp:489-495`, `parseWidgetGroup` at `:741-752`). It gets `ObjectName`, `Size`, `SizePolicy` and `Style` through `setupWidget`, so `WWidgetGroup#Traktorixx` in `style.qss:2` matches.
  - `skin:style.qss` resolves through `SkinContext::setSkinBasePath`, which calls `QDir::setSearchPaths("skin", …)` (`skincontext.h:53-56`). `parseSkin` calls it, so the path does not depend on the launch directory.
  - `skin_preview.png` is the filename Mixxx reads, and it falls back to a built-in placeholder (`legacyskin.cpp:51,56`).
  - `<Alignment>center</Alignment>` is a valid `WLabel` value (`wlabel.cpp:63`).
- **The scope is tight:**
  - The manifest has exactly the fields the sprint asks for (title, author, version 0.1, description, CC BY-NC 4.0 licence).
  - The layout is one window group with one placeholder label.
  - No layout, deck or styling work slipped in, so nothing from the out-of-scope list was touched.
- **The sprint's fallback path was followed as written.** The symlink was tried, the sandbox blocked it (with log evidence recorded), `scripts/install.sh` was written, and `AGENTS.md` → Dev loop was updated with the exact launch command and menu path.
- **The installed copy is identical to `skin/`** (`diff -r` is clean). Only the symlink at the destination is removed (`install.sh:10-12`), so an existing real directory is never deleted.
- **The installer is careful POSIX shell:** `set -eu`, `CDPATH=` neutralised, `--` guards, and every path quoted. That matters because the destination contains `Application Support`.
- **Licence and never-copy rule:** the files are minimal and original. Nothing is lifted from LateNight, which also uses a different style-path form (`skins:LateNight/style.qss`). `style.qss` is pure ASCII, which is safe given that Mixxx reads it with `QString::fromLocal8Bit` (`legacyskinparser.cpp:2172`).
- **Nothing in the skin is macOS-only.** The macOS container path lives only in `scripts/`, outside `skin/`, as the `AGENTS.md` platform rule requires.

Want me to fix any of these?
