# AGENTS.md

Master reference for every agent working on this repo (Claude/Opus and Codex/Astra).
`CLAUDE.md` points here.

## Project

**Traktorixx** (working title; remote: `github.com/PaulHaze/Traktorixx`) is a custom skin for the DJ software [Mixxx](https://mixxx.org).
The goal is to make Mixxx look and feel like the owner's Traktor setup. The owner is
moving from Traktor to Mixxx. The skin is **written from scratch**. It's the owner's
own work, not a fork.

- **Target Mixxx version:** 2.5.6 only. No backwards compatibility with 2.3/2.4.
- **Platforms:** built and tested on the owner's Mac. The gig machine will be a
  Lenovo laptop running Linux (2560×1600), ported and tweaked later. Keep the
  skin free of anything macOS-only.
- **Screen size:** design for a maximum window of **2560×1600**, and stay resizable
  down to smaller windows.
- **Target look:** `target_images/` holds Traktor screenshots of each part of the UI
  (deck, cue/loop/beatgrid rows, mixer, FX strip, master section). These are the
  reference for "done".
- **References only, never copy:** `../Traktmixxx-RAW/` (CC BY-SA) and Mixxx's
  bundled skins such as LateNight (GPL). Read them to learn how Mixxx widgets,
  templates and controls work, then write our own XML, QSS and SVGs. **Never copy
  files, code blocks or SVG artwork from them.** Doing so would bind this skin to
  their licences. Mixxx control names and widget tags are Mixxx's interface, so
  using those is fine.
- **Approach:** build up from a minimal skin that loads, adding one small, targeted
  section at a time until it resembles the target images.
- **Scope: 2 decks only (A/B).** No 4-deck support or deck switching. Forks can add it.
- **Scope rule: `target_images/` is the feature list.** They are screenshots of the
  owner's own Traktor setup. If a feature isn't in them, the owner doesn't use it
  and it isn't in the skin (no samplers, mics, aux, vinyl control, etc.) unless
  the owner adds it later.
- **Fidelity: resemble Traktor, don't clone it.** The aim is familiarity. If a
  Traktor item is unused by the owner or has no Mixxx match, drop it and close up
  the space. Keep Traktor's zones, proportions, colours and feel.
- **Exception: the library/browser** has no target image and is the lowest priority.
  Its colours, fonts and spacing only need to match the rest of the skin. It doesn't
  need to copy Traktor's browser.
- **Repo layout:** `skin/` is the Mixxx skin folder (`skin.xml`, `style.qss`,
  assets) and nothing else goes in it. Docs, `target_images/` and agent files live
  outside `skin/`.
- **Project brief:** `project_info.md`.
- **Paths:** every path in this file is relative to the repo root
  (`/Users/paulhayes/code/AI/traktor_skin/traktorixx`). For example,
  `docs/sprints/v1/` is `<repo>/docs/sprints/v1/`. The RAW reference skin sits
  outside the repo at `../Traktmixxx-RAW/`.

## Reference docs

Check these before guessing. Use the 2.5 versions where they exist.

- **Creating skins (main guide, XML tags, templates, variables):**
  <https://github.com/mixxxdj/mixxx/wiki/Creating-Skins>
- **Skin layout tutorial (sizing, size policies, layouts):**
  <https://github.com/mixxxdj/mixxx/wiki/Skin%20layout%20tutorial>
- **Skin system changelog (what changed per Mixxx version):**
  <https://github.com/mixxxdj/mixxx/wiki/skin_system_changelog>
- **Colour schemes:** <https://github.com/mixxxdj/mixxx/wiki/Skin-Color-Scheme-Architecture>
- **Mixxx controls (every `[Group],key` a widget can bind to):**
  <https://manual.mixxx.org/2.5/en/chapters/appendix/mixxx_controls.html>
- **Settings directory (where user skins go):**
  <https://manual.mixxx.org/2.5/en/chapters/appendix/settings_directory.html>
  - macOS: `~/Library/Containers/org.mixxx.mixxx/Data/Library/Application Support/Mixxx/skins/`
  - Linux: `~/.mixxx/skins/`, or `~/.var/app/org.mixxx.Mixxx/.mixxx/skins/` for Flatpak
- **Skin parser source (what each XML tag really accepts; the final authority):**
  <https://github.com/mixxxdj/mixxx/blob/2.5/src/skin/legacy/legacyskinparser.cpp>
- **Built-in tooltip IDs:**
  <https://github.com/mixxxdj/mixxx/blob/2.5/src/skin/legacy/tooltips.cpp>
- **Mixxx's bundled 2.5 skins (read-only reference, GPL, never copy):**
  <https://github.com/mixxxdj/mixxx/tree/2.5/res/skins>. LateNight is the most
  modern of them.
- **Qt stylesheets (QSS):** <https://doc.qt.io/qt-6/stylesheet-reference.html>
  and <https://doc.qt.io/qt-6/stylesheet-examples.html>
- **Troubleshooting:** skin parse errors and warnings are written to `mixxx.log`
  in the settings directory. Check it after every reload.

## Dev loop

- **Install by copy.** Verified on Mixxx 2.5.6: the macOS App Sandbox cannot read
  `skin.xml` through a symlink to this checkout. The rest of this section (skin
  selection, Reload Skin, visible QSS change) is not yet verified in the running app.
  Use the copy installer from the repo root:

  ```sh
  ./scripts/install.sh
  ```

  It installs into
  `~/Library/Containers/org.mixxx.mixxx/Data/Library/Application Support/Mixxx/skins/Traktorixx`
  and replaces the earlier symlink if present. Run it after every skin edit.
- Launch the installed app in developer mode (quit any existing Mixxx first):

  ```sh
  "/Applications/-- Audio --/Mixxx.app/Contents/MacOS/Mixxx" --developer
  ```

- Select **Traktorixx** in **Mixxx → Preferences → Interface → Skin**, then Apply.
  Reload from **Developer → Reload Skin** after running the installer. The
  `--developer` flag is confirmed by the installed app's `--help`; the menu path
  is confirmed by the [Mixxx 2.5 menu implementation](https://github.com/mixxxdj/mixxx/blob/2.5/src/widget/wmainmenubar.cpp).
- Check `mixxx.log` in the settings directory above after each reload. GUI selection
  and a visible QSS change on reload need the owner's check.

## Licence

Traktorixx is **CC BY-NC 4.0** (see `LICENSE`), © Paul Hayes (PaulHaze): free to
use and adapt, but not commercially. That only holds while every file is original
work, hence the never-copy rule above. RoundCorners, Traktmixxx and Traktmixxx-RAW
are thanked in the README as inspiration. Don't copy Native Instruments logos or
artwork. Draw our own SVGs.

## Mixxx skin conventions

- A skin is a folder containing `skin.xml` (the layout), `style.qss` (the styling),
  and image assets, mostly SVG. Mixxx lists it in Preferences → Interface under
  the folder's name.
- `style.qss` is a **Qt stylesheet**, not browser CSS. It has no nesting, no custom
  properties or variables, and no `@apply`, media queries or modern selectors. Reuse
  values through the skin XML's `<SetVariable>` / templates, not in QSS.
- Mixxx widgets are driven by **controls** (`[Channel1],play`, `[Master],crossfader`,
  …). Look up control names in the Mixxx manual's controls reference. Don't guess them.
- Keep it small: one fixed layout, no small/medium/large variants, no settings
  menus per section. Use templates only for real repetition (deck A/B, FX unit
  1/2, mixer channels). Each change should be small enough for the owner to check
  visually in Mixxx before the next one starts.

## Domain docs

Single context: `GLOSSARY.md` and `docs/adr/` at the repo root. Create each one the
first time there is something to put in it. `GLOSSARY.md` records the agreed names
for things (Traktor terms vs Mixxx terms). It contains no implementation detail.

## Working with the owner

- When grilling (stress-testing a plan or idea), ask **one question at a time** with
  a recommended answer, then wait for the reply.
- Look up facts yourself, in the repo and the reference skins. Ask the owner only
  about decisions.

## Planning flow

All planning docs live in `docs/`. Create each file the first time it is needed.

1. `docs/brainstorms.md`: raw ideas.
2. The owner picks one and grills it. Grilling moves the idea into
   `docs/roadmap.md` with all the detail the grilling produced (goal, decisions,
   scope). The roadmap holds one or two items at most.
3. When an item's turn comes, its sprints are planned. Only then is
   `docs/sprints/{epic}/` created, with `00_Overview.md` and numbered sprint
   files. The epic's branch name is decided at that point.
4. Sprints are built in order. `docs/sprints/` holds only the epic being worked on.
5. When an epic finishes, compact it into `docs/old/{epic}/` (sprint summary + audit
   summary), update `docs/spec.md` (what the skin currently does), then delete
   `docs/sprints/{epic}/`. Remove the item from the roadmap and add a short entry
   to `docs/shipped.md` (newest first).

### Work tracking

No GitHub Issues. Work is tracked as numbered sprint files in
`docs/sprints/{epic}/`, worked one at a time and in order within an epic.

### Current epic: `v1`

- Plan: `docs/roadmap.md` (item 1). Sprints: `docs/sprints/v1/`, with the overview
  in `00_Overview.md` and sprints `01_…md` to `12_…md`.
- Branches: epic branch `v1`, sprint branches `v1-{nn}` (`v1-04` →
  `docs/sprints/v1/04_*.md`).
- Audits: `docs/sprints/v1/audits/v1-{nn}-audit-{opus|astra}.md`, summary
  `v1-{nn}-audit-summary.md`.
- Each sprint is one small change that the owner checks visually in Mixxx before
  the next sprint starts.

### Parked epics

- A paused epic moves to `docs/parked/{epic}/` (same files, audits included), so
  that `docs/sprints/` holds only the active epic. It moves back to
  `docs/sprints/{epic}/` when work resumes. Don't implement or audit a parked epic.
- None parked right now.

## Sprint & audit workflow

### Shared conventions

- **Branch convention:** `{epic}-{nn}`. `{nn}` is the two-digit sprint number within
  the epic, e.g. `v1-01`. The epic is everything before the trailing `-{nn}`, so
  an epic name may contain hyphens.
- **Sprint file:** strip `-{nn}` from the branch to get the epic folder, then use the
  file in `docs/sprints/{epic}/` whose two-digit prefix matches `{nn}`
  (`v1-02` → `docs/sprints/v1/02_*.md`). The whole file is the task scope.
- **Audits directory:** `docs/sprints/{epic}/audits/`
- **Cross-cutting context:** `docs/roadmap.md`, `docs/spec.md`, `GLOSSARY.md`,
  `docs/adr/` and the matching `target_images/`. Read whichever parts bear on the change.
- Every audit must first confirm that the branch name maps to exactly one sprint
  file. Flag a mismatch or a missing file at the top of the report. Then compare
  the commit against that sprint's goal, scope and acceptance criteria, and list
  anything missing, only partly done, or outside the sprint's scope.

### `$start-task` context

- The sprint file is the canonical brief. Read the epic's `00_Overview.md` rules
  before starting, and update the sprint's **Status** and checkboxes as you work.
- Implementation agent: `gpt-6.1-sol` at medium reasoning effort.
- `$start-task` must not create, switch, rename, merge or delete branches. The owner
  manages them, except through `/new-task`.
- Auditing happens separately in the owner's Opus workflow. `$start-task` does not
  run an Astra audit.

### `$audit-commit` context (Codex / Astra)

- Implementation file: the sprint file found as described under Shared conventions.
- Audit report filename: `{branch}-audit-astra.md` in the audits directory.

### `/audit-commit` context (Claude / Opus)

Used by `/audit-commit`, `/audit-sum`, `/audit-action` and `/summary`.

- Claude audit filename: `{branch}-audit-opus.md` in the audits directory.
- `/audit-commit` runs `/audit-sum` at the end if the Astra audit exists. If it
  doesn't, skip with a one-line note.

### `$audit-sum` context

- Inputs: `{branch}-audit-opus.md` (label **Opus**) and `{branch}-audit-astra.md`
  (label **Astra**, read-only. Use it wherever the skill says `Sol`/`GPT`).
- Output: `{branch}-audit-summary.md`
- Summary heading line: `Combined findings of Astra and Opus audits:`
- Completeness rule: every finding from both audits appears with all of its
  information: severity, `file:line` references, reasoning, evidence and the
  suggested fix. Never drop or merge an auditor's details, or shorten them away.
  Put Astra's fix on the `Suggested fix:` line. Add an alternative only as a
  clearly labelled extra. Notes that aren't findings (verification runs, coverage,
  positive observations) go in a short `Auditor notes` section at the end,
  attributed to their auditor.

### `$new-task` context

- Parent branch: `v1` (the epic branch). Sprint branches `v1-{nn}` merge into it,
  and it is pushed after each merge.
- Push flag: `true`
- The next branch increments `{nn}` within the same epic (`v1-01` → `v1-02`).
  Starting a new epic is the owner's call.
