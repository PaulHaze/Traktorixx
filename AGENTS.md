# AGENTS.md

Master reference for every agent working on this repo (Claude/Opus and Codex/Astra).
`CLAUDE.md` points here.

## Project

**Traktorixx** (working title; remote: `github.com/PaulHaze/Traktorixx`) is a custom skin for the DJ software [Mixxx](https://mixxx.org), running on the owner's Mac.
The goal is to make Mixxx look and feel as close to Traktor as possible. The owner is
moving from Traktor to Mixxx.

- **Target Mixxx version:** 2.5.6 (macOS) only. No backwards compatibility with
  2.3/2.4.
- **Target look:** `target_images/` holds Traktor screenshots of each part of the UI
  (deck, cue/loop/beatgrid rows, mixer, FX strip, master section). These are the
  reference for "done".
- **Base skin (read-only reference):** `../Traktmixxx-RAW/`, a fork of RoundCorners
  (via Traktmixxx) written for Mixxx 2.3. Never edit it. It stays alongside this repo
  so you can compare against the original.
- **Approach:** copy Traktmixxx-RAW into this repo once, get it loading cleanly on
  2.5.6, then make small, targeted changes, one at a time, until it matches the
  target images.
- **Scope: 2 decks only (A/B).** Remove RAW's deck 3/4 layouts and deck-switching UI;
  don't add 4-deck support. Forks can add it.
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
- **Official skin guide:** <https://github.com/mixxxdj/mixxx/wiki/Creating-Skins>
- **Project brief:** `project_info.md`.

## Dev loop

- `~/Library/Containers/org.mixxx.mixxx/Data/Library/Application Support/Mixxx/skins/Traktorixx`
  is a symlink to this repo's `skin/` folder. Not yet verified: if the macOS sandbox
  stops Mixxx loading the linked skin, replace the link with a copy script.
- Start Mixxx with `--developer` and use the menu's reload-skin option to see
  changes without restarting.

## Licence

The reference skins are CC BY-SA 3.0 (RoundCorners by 22degrees, Traktmixxx by
intialonso, Traktmixxx-RAW by djraw). Anything derived from them keeps that licence
and those credits. Don't copy Native Instruments logos or artwork. Draw our own SVGs.

## Mixxx skin conventions

- A skin is a folder containing `skin.xml` (the layout), `style.qss` (the styling),
  and image assets, mostly SVG. Mixxx lists it in Preferences → Interface under
  the folder's name.
- `style.qss` is a **Qt stylesheet**, not browser CSS. It has no nesting, no custom
  properties or variables, and no `@apply`, media queries or modern selectors. Reuse
  values through the skin XML's `<SetVariable>` / templates, not in QSS.
- Mixxx widgets are driven by **controls** (`[Channel1],play`, `[Master],crossfader`,
  …). Look up control names in the Mixxx manual's controls reference. Don't guess them.
- Prefer editing the existing templates over adding new ones. Each change should be
  small enough for the owner to check visually in Mixxx before the next one starts.

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

### Current epic

None yet. The first epic is planned once the initial grilling is finished.

### Parked epics

- A paused epic moves to `docs/parked/{epic}/` (same files, audits included), so
  that `docs/sprints/` holds only the active epic. It moves back to
  `docs/sprints/{epic}/` when work resumes. Don't implement or audit a parked epic.
- None parked right now.

## Sprint & audit workflow

### Shared conventions

- **Branch convention:** `{epic}-{nn}`. `{nn}` is the two-digit sprint number within
  the epic, e.g. `deck-01`. The epic is everything before the trailing `-{nn}`, so
  an epic name may contain hyphens.
- **Sprint file:** strip `-{nn}` from the branch to get the epic folder, then use the
  file in `docs/sprints/{epic}/` whose two-digit prefix matches `{nn}`
  (`deck-02` → `docs/sprints/deck/02_*.md`). The whole file is the task scope.
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

- Parent branch: the current epic's branch (none yet). Sprint branches merge into it.
- Push flag: `true`
- The next branch increments `{nn}` within the same epic (`deck-01` → `deck-02`).
  Starting a new epic is the owner's call.
