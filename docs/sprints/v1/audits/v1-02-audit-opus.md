## Audit: last commit 07e41c4 — Build sprint 02 layout skeleton and native library

_Scope: Sprint 02 — Layout skeleton (from `docs/sprints/v1/02_Layout_Skeleton.md`)_

Branch `v1-02` maps to exactly one sprint file: `docs/sprints/v1/02_Layout_Skeleton.md`.

Files audited: `skin/skin.xml`, `skin/deck.xml` (new), `skin/style.qss`. The sprint file was read as the scope and checked against its Findings. Cross-checked against `docs/roadmap.md` item 1, `GLOSSARY.md`, `target_images/traktor_full_with_library.png`, the local load log `logs/v1-02-load.log`, and the Mixxx 2.5 branch source: `legacyskinparser.cpp`, `wtrackwidgetgroup.cpp`, `wsplitter.cpp`, `wwidgetgroup.cpp`.

### Warning

1. **The sprint is not finished. 3 of its 4 acceptance criteria still need the owner** (`docs/sprints/v1/02_Layout_Skeleton.md:45,50-55`).
   - Still open: comparing side by side with the target at 2560×1600, loading a track onto A/B from the library, and resizing down to the minimum. Findings records the minimum as *configured* (1024×720). It is not yet the minimum *reached*, which is what the sprint asks for ("Write down the minimum window size reached in Findings", `:30-31`). The commit is honest about this: the "Check resizing" box is unticked and the Status says "awaiting owner verification".
   - The "no skin errors" criterion does check out for the isolated launch. `logs/v1-02-load.log:2775` reads `Skin is a >=1.12.0 style skin.` and `:2789` reads `Loaded skin "Traktorixx"`. The log's 5 `Warning` lines are all unrelated to the skin (locale, BigSky, iZotope AU, `samplers.xml`, PortAudio timestamps). The installed copy is identical to `skin/` (`diff -r` is clean).
   - Suggested fix: the owner runs the checks in the Findings "Owner check required" bullet. Then replace "Configured minimum" with the size actually reached and tick the box. Don't run `/new-task` before that.

2. **The vertical sizing model works against the roadmap's beatgrid-hide decision** (`skin/skin.xml:23-24`, `skin/deck.xml:19-25`; roadmap `docs/roadmap.md:75`).
   - The roadmap says: "When hidden, its space goes to the library. The waveforms keep their height." The skeleton caps the whole performance area at a fixed 740 px (`MaximumSize ,740` with policy `me,e`). Inside each deck, the waveform placeholder is `Expanding` with no maximum.
   - At 2560×1600 the cap is meant to be reached ("grows up to 740 px", Findings). Once it is, the performance area's height no longer depends on what's inside it. So when sprint 07 hides the beatgrid panel, its 48–72 px goes to the waveform, not the library. The waveform grows and the library gains nothing, which is the opposite of the roadmap decision.
   - Capping the waveform alone won't fix this. In Qt box layouts, a child group passes its layout's *minimum* up to the parent but not its *maximum*: `QWidgetItem::maximumSize` reads the widget's own `maximumSize()`. The deck would just be left with an empty gap at the bottom, and see item 3 for what gets painted there.
   - The task doc is context, and this only bites in sprint 07. But it is the sizing model that sprints 03–06 will build on, so it's cheaper to decide now.
   - Suggested fix: pick one of these and record it in the Findings of this sprint or sprint 07:
     - (a) Make the library the only area that grows vertically. Give each deck sub-area a fixed or tightly bounded height so the deck row's height comes from its contents. Set `PerformanceArea` / `DeckRow` to vertical policy `max` instead of `e` and drop the 740 constant. Hiding a sub-area then shrinks the row's size hint, and the library takes the space. Trade-off: the performance area stops shrinking smoothly on small windows, so check this against the 720 px minimum.
     - (b) Keep the current shrinkable model, and note in `07_Beatgrid_Panel.md` that the ^ toggle must also change the performance area's height. For example, two wrapper groups with different caps, switched by the same control.

### Suggestion

3. **The deck's `TrackWidgetGroup` fills its whole area with the track colour at full opacity by default** (`skin/deck.xml:4-9`; Mixxx `wtrackwidgetgroup.cpp:14,74-93`).
   - `kDefaultTrackColorAlpha = 255`, and `paintEvent` calls `fillRect(rect(), m_trackColor)` whenever the loaded track has a colour.
   - You can't see it today. Widget-group layouts have zero spacing and zero margins (`wwidgetgroup.cpp:99,138`), and the opaque placeholder labels cover the whole deck. But any gap (see item 2) or any transparent child added in sprints 03–07 will show a solid block of track colour behind the deck.
   - Suggested fix: add `<TrackColorAlpha>0</TrackColorAlpha>` to the `TrackWidgetGroup` in `deck.xml` now. The parser reads it at `wtrackwidgetgroup.cpp:38-43`. Choose a tint deliberately later if the owner wants one.

4. **The library sidebar width is not remembered** (`skin/skin.xml:105-111`; Mixxx `wsplitter.cpp:34-49`).
   - Findings says "its sidebar width is adjustable". That is true, but without `<SplitSizesConfigKey>` the splitter goes back to `300,1800` on every launch and every Reload Skin.
   - Suggested fix: add a `<SplitSizesConfigKey>` with a skin-owned key, e.g. `[Traktorixx],library_split`. Alternatively, leave it for sprint 12 (Library) and note it there.

5. **The proportions within the performance area differ somewhat from the target** (`skin/skin.xml:30,35,59,94`, `skin/deck.xml:15-16`). Measured from `target_images/traktor_full_with_library.png`; all values approximate.
   - The overall split matches well: the target has about 46% performance area and 54% library. The skin's 740 / 860 at 1600 px tall is the same.
   - Centre column: the target's master panel and mixer span about 15.5% of the width, about 400 px at 2560. The skin uses a fixed 320 px, about 20% narrower, so the decks come out wider.
   - Header + FX row: the target's equivalent is about 57 + 140 px at 1600 tall. The skin has 32 + 112. The deck row takes the difference (596 px against about 545).
   - Deck sub-areas: in the target, info + sync row and the scrolling waveform each take roughly 27% of the deck height. In the skin, info is capped at 120 px (about 20%) and the waveform absorbs the rest (about 268 px, 45%).
   - All of this is within "roughly the right size", so no action is needed unless the owner's side-by-side check disagrees. Revisit when sprint 04/05 bring real widgets. Raising the info cap to about 160 px and widening the centre column to 360–400 px would bring it closer.

### Positive observations

- **Scope matches the sprint completely, with nothing out of scope:**
  - Header strip, FX row (FX unit 1 | master panel | FX unit 2), deck A | mixer | deck B, and the library, in that order.
  - One deck template with a `group` parameter (plus a `deck` letter), used for `[Channel1]` and `[Channel2]`.
  - The five deck sub-areas, named exactly as in the sprint.
  - No real controls, no waveform, and only placeholder tints. That honours the "Out of scope" line.
- **The FX layout matches the roadmap and the target.** Each FX side is two equal `Ignored` halves, with the unit on the outer edge and the reserved space inside (`skin.xml:37-78`). This is how the target image places FX unit 1 and FX unit 2, and it meets roadmap `:31-33` ("each unit takes half the width of its side").
- **The columns line up by construction.** `320f` gives a true fixed width: `setFixedWidth` when the policy is Fixed (`legacyskinparser.cpp:2124-2133`). Both the FX sides and the decks use horizontal policy `i`, so the sides share the remaining width equally in both rows, and the master panel sits exactly above the mixer.
- **The size declarations all parse cleanly.** Single-axis `,740` / `,220` forms take the `setMaximumHeight` / `setMinimumHeight` branches and are UI-scaled like the two-axis forms (`legacyskinparser.cpp:2026-2071`). `me,32f` / `me,112f` give fixed heights with a MinimumExpanding width.
- **The minimum-size arithmetic adds up.** Height: 32 + 112 + (80 + 120 + 40 + 48 + 48 = 336) = 480, plus the library's 220 = 700, which is within the 720 minimum. Width: 3 × 320 = 960, within 1024. The library row needs 180 + 500 + the 2 px handle. The "shrinks to 480 px" claim in Findings matches.
- **The splitter is set up correctly.** `<Collapsible>0,0</Collapsible>` has the same number of entries as the splitter has children (checked at `wsplitter.cpp:77-97`), so the library can't collapse, and there's no visibility connection, so it is always shown.
- **Using `TrackWidgetGroup` as the deck container is a well-judged minimum.** It gives each deck a library drop target and a track context menu (`wtrackwidgetgroup.cpp:29,106-114`) without adding any transport controls, so the "load a track onto A/B" criterion can be tested in a skeleton.
- **The v1-01 audit's suggestion 6 has been dealt with.** The global `WLabel` selector is gone. Every QSS rule now targets a specific `ObjectName`, so future labels won't inherit placeholder boxes. `style.qss` is still pure ASCII.
- **The sprint doc is accurate.** The Findings claims (parser source, `xmllint`, clean skin log, copy installer) were all confirmed against the source and the local log, and the unverified items are clearly marked.

Want me to fix any of these?
