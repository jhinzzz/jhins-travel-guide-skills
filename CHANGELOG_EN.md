# Changelog

[中文 / CHANGELOG.md](./CHANGELOG.md)

Iteration log for the `jhins-trip-planner` skill. Every version answers two questions: **what changed** and **why**. Latest on top.

Version numbers follow the spirit of semver:
- `0.x.0` — new coverage area or structural refactor
- `0.x.y` — small patch, no user-visible behavior change

## [0.8.0] — 2026-04-23

### Changed

- **Main reference files slimmed down** — the three heaviest files cut by -45%:
  - `budget.md`: 88 → 52 lines (-40%)
  - `dining-rules.md`: 190 → 110 lines (-42%)
  - `safety-and-emergency.md`: 205 → 104 lines (-49%)
  - All anchors preserved (§1-§10 / §3 / §6 / §9 etc.); provenance still 40/40; no existing rule_refs break.
- **Introduced `references/deep/` opt-in subdirectory** — the trimmed-out extended content (tables, destination-specific examples, swap-cascade detail, 6-class ethical guardrails, partial-number-ban rationale, allergen-card template, etc.) all migrated to `references/deep/{budget,dining-rules,safety-and-emergency}.md`. LLM does not read these by default; only when a main reference's pointer explicitly triggers a depth threshold.
- **SKILL.md adds a "Deep references (opt-in)" note** (3 lines, after Navigation) stating the read rule.
- `scripts/check-size.sh` now also checks `deep/` with relaxed thresholds (> 400 warn / > 500 error — deep files are supposed to be larger).
- **`FUTURE.md` rewritten** — from "5 conditionally-triggered technical directions" to a **strategic positioning + ecosystem roadmap**: the main skill stays broad and general; domain specialists (pet travel / business / LGBTQ safety / cross-strait / destination-specific) land as **separate skills routed by trigger words**, not as new sections inside this skill.

### Why

The user's intent for this skill is "broad and general-purpose; never a deep specialist in any one domain unless a trigger routes to a dedicated skill." The last 4 iterations went the wrong direction: v0.7.0 added infra, v0.7.1 added checks, v0.7.2 added a new reference. Each pass made the main skill fatter. A local dry-run (Taiwan GW case, `session-learnings-*`) found 16 gaps — continuing the old path would have spawned 3-4 more reference files.

This release reverses direction: **no new content, only relocation**. Deep material stays available (zero information loss), but the LLM's default context window reads -217 fewer lines. Future specialist domains → separate skills, not new references. Jobs's subtraction default, applied.

### Structure guarantee

Zero rule content deleted. Zero anchor renamed. Zero rule_refs broken. All four checks (links / provenance / version / size) remain green.

## [0.7.2] — 2026-04-23

### Added

- **`references/budget.md`** — 4-section reference filling the skill's highest-frequency blind spot. Budget is touched on every trip, but until now only a single rule existed ("15% overage confirmation checkpoint"). This file supplies the structure that checkpoint draws from.
  - §1 Category split defaults by region band (East Asia / mainland China+SEA / Western Europe / Nordics-Iceland / US / Middle East / South+SEA rural — 7 tiers, each with 6 category percentages in local currency).
  - §2 Hidden-cost checklist in "situation → specific line item" format: entry/departure taxes, tipping layers, IC-card deposits, FX fees, DCC traps, duty-free liquid limits, self-drive hidden charges, peak surcharges, return-country customs.
  - §3 Refundable vs non-refundable decision: 7 triggers to spend the premium (age 70+, pregnancy 28w+, young kids, risk-window overlap, pending visa, narrow connection, business) + 4 scenarios to skip (solo flexible, short low-risk, already-flexible multi-leg, premium > 20% of lodging total).
  - §4 FX and payment timing: lock-rate / hold-currency / pay-by-card / pay-cash / refuse-DCC decisions, ordered by destination stability.
- SKILL.md Navigation gets a new row; Core Workflow §3 now references budget.md §1; Final Check upgrades its budget line from "present" to a 4-point audit (band · hidden costs · refundable · FX).
- `test-prompts.json` adds case 14 (Argentina 10 days, tight budget, FX-sensitive) — exercises all 4 budget.md sections. `provenance.md` adds the budget.md section plus case 14's trip-prep §3 and Fallback Rules references.

### Why

The skill already had 9 rule files, but "budget" only appeared as fragments across intake (a single number), SKILL.md (15% overage checkpoint), and trip-prep.md (payment friction). The real-world result: 90% of budget overruns come from **nobody telling the user** that "35% lodging in East Asia or 20% transport in the Nordics is normal," or that "Argentina requires carrying USD cash — do not pre-convert CNY → ARS." This release consolidates scattered budget knowledge into one reference and pairs it with the 15% checkpoint (checkpoint = trigger, budget.md = evidence).

No existing rule file content was touched (zero pollution). SKILL.md is 195 lines (was 194), leaving 55 lines of headroom against the 250-line threshold.

## [0.7.1] — 2026-04-23

### Fixed

- **Plugin metadata version drift** — `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` (two places) were still pinned at `0.5.2`. Bumped to `0.7.1`. Prior `/plugin install` flows were reading stale metadata.

### Added

- **Release hygiene pack** — four checks now form a full gate:
  - `scripts/check-version.sh` — VERSION must agree with SKILL.md, plugin.json, marketplace.json; any drift exits 1.
  - `scripts/check-size.sh` — SKILL.md > 250 lines → error; `reference/*.md` > 220 warn / > 260 error. Thresholds aligned with the v0.6.0 "rule fatigue" lesson (SKILL.md was trimmed from 331 → 190 lines).
  - `scripts/check-all.sh` — aggregator runs `check-links.sh` / `check-provenance.sh` / `check-version.sh` / `check-size.sh` in one command, replacing the manual release checklist.
- README / README_CN Release checklist now points to `scripts/check-all.sh`.

### Why

The v0.7.0 commit summary explicitly called the 0.5.2 drift in plugin.json / marketplace.json "out of scope" — that was an excuse. This release fixes it and promotes the manual pre-release checklist into a machine contract: one command runs four orthogonal checks. Also closes the FUTURE §3 risk that SKILL.md could quietly re-grow past the rule-fatigue threshold.

### Added

- **Rule Provenance mechanism** — makes "why does this rule exist" machine-verifiable and reverse-queryable.
  - `scripts/check-provenance.sh` — verifies that every `rule_refs` anchor in `test-prompts.json` actually points to a heading in the target rule file. Zero dependencies (pure bash + POSIX awk), with a jq fast path when available. Passes 34/34 on positive cases; returns exit code 1 on injected bad refs.
  - `skills/jhins-trip-planner/references/provenance.md` — reverse index (rule → cases that cover it). Before changing a rule, check who's testing it. Un-referenced headings are a signal to add tests, not delete rules.
  - SKILL.md top meta line adds a pointer to provenance.md — Navigation table stays clean.
  - FUTURE.md §1 (test automation) updated: ground truth is now structured and ready; when the harness ships, no corpus needs to be built.

### Why

The skill now has 9 rule files, 1400+ lines. Marginal cost of adding more coverage is low, but the reasoning behind each rule is leaking (`session-learnings-*.md` files are prose, not bound to rules). Without this mechanism, changing `dining-rules.md §5` has no way to surface that cases 6/7/8 depend on it. Now provenance.md makes it visible at a glance and check-provenance.sh blocks anchor drift at commit time.

No existing rule file content was edited. Rule files stay clean — provenance lives in `test-prompts.json`'s `rule_refs` plus a single index file, zero inline annotation.

## [0.6.4] — 2026-04-22

### Changed

- SKILL.md §Confirmation Checkpoints gets a batching rule: multiple intake-phase checkpoints can be asked in a single batch (max 3, priority order legal/safety > scheduling > preference); mid-flight checkpoints (budget overage, restaurant swap, pace/theme conflict) still fire **one at a time**.
- dining-rules.md §3 peak list now covers Eid al-Fitr / al-Adha: `Middle East Ramadan (daytime closures) + Eid al-Fitr / al-Adha (2–4 day public holidays, date shifts by moon sighting, many venues closed or on special hours)`. Previously only Ramadan was listed.

### Why

Case 13 (Dubai 5 days + Ramadan + 8-year-old daughter) QA simulation exposed two gaps:
1. Intake triggered 3 checkpoints simultaneously (Ramadan dates / theme conflict / kid desert intensity). The rule said "stop and ask" but never said whether they could be batched. The LLM made a judgment call and batched them — the new rule legitimizes that.
2. Eid al-Fitr immediately follows Ramadan and is a 2–4 day public holiday with widespread closures or special hours. The old rule only mentioned Ramadan.

## [0.6.3] — 2026-04-22

### Added

- `.gitignore` — explicitly excludes `session-learnings-*.md` (personal session notes) and locally generated cache directories from git. Replaces the "just remember not to track them" soft constraint.
- `FUTURE.md` item 1 gets a clarification: the `rule_refs` field in `test-prompts.json` is a **human-readable annotation**, not a machine assertion; `check-links.sh` does not scan JSON. Prevents future readers from mistaking these references as harness dependencies.

### Why

Three informational findings from the internal pre-landing review of v0.6.0–v0.6.2 — mechanical fixes, bundled into one bump.

## [0.6.2] — 2026-04-22

### Added

- `VERSION` file, this `CHANGELOG.md`, and `FUTURE.md` — versioning infrastructure. SKILL.md now shows the current version number at the top.
- CHANGELOG backfilled to v0.3.0 (mined from git log).
- FUTURE.md records 5 "conditionally triggered future directions" (test automation / thresholds.json / destinations/ split / triggers matrix / agentification), each with its trigger condition.

### Why

Infrastructure rather than rule changes. The skill has matured from "a pile of rules" into "versioned, with history, with a roadmap" — these three files are the supporting layer.

## [0.6.1] — 2026-04-22

### Added

- `scripts/check-links.sh` — bash script that scans the skill package and validates cross-file references: every `[text](file.md)` points to a real file, every `§Anchor` matches a heading in the target file, orphan reference files are warned. Zero dependencies, pure bash + POSIX tools, runs in under 1 second.
- Smart anchor parsing — correctly distinguishes that in "`(dining-rules.md) §5 for how they combine with meal`" the anchor is `§5`, not the whole trailing phrase.

### Why

`v0.6.0` split `planning-rules.md` into three files, and cross-file references grew from under 10 to 30+. Manual maintenance has too high a miss rate; it needed automation.

## [0.6.0] — 2026-04-22

### Added

- **Accessibility capture** (`intake.md §6`) — wheelchair / dialysis / in-cabin oxygen / pregnancy / service animal / allergies carry-forward. Each category must be explicitly resolved in downstream hotel / attraction / transport cards, no more "later verify".
- **Children age banding** (`intake.md §7`) — 0-2 / 3-5 / 6-9 / 10-14 / 15-17, each band mapping to different attraction / lodging / restaurant constraints. Replaces the vague "young children".
- **Transit visa blind spots** (`trip-prep.md §2`) — US has no sterile transit, Hong Kong 24/72/168h, Dubai stopover, Singapore VFTF, Schengen ATV-required countries.
- **Interline baggage conflicts** (`transportation.md`) — piece-vs-weight system clashes, self-transfer time budgeting, duty-free liquid re-screening, cabin-bag size mismatches.
- **Climate shift risk** (`weather-and-output.md §1`) — European summer heat waves, earlier cherry blossoms, late-season typhoons, North American wildfire smoke, coral season disruption. Any use of seasonal averages must carry a disclaimer.
- **Ethical tourism guardrails** (`safety-and-emergency.md §6`) — 7 categories of default redirects (captive wildlife / orphanage voluntourism / long-neck photography / turtle contact, etc.).
- **Religious festival expansion** (`trip-prep.md §6`) — beyond Ramadan, adds Holi / Songkran / Shabbat / Buddhist Lent, each in "situation → specific action" format.
- **Guided vs independent decision** (`weather-and-output.md §4`) — 7 conditions that trigger a guided-tour recommendation + 4 scenarios for staying independent.
- **Payment friction in practice** (`trip-prep.md §3`) — destination-specific friction for China / Japan / Iceland / Germany-Austria / India / Argentina / United States.
- **Minimum viable brief threshold** (`intake.md §2`) — with destination + dates + party + budget in hand, detailed planning can proceed; pace/theme have defaults and do not block.
- **Capture relevance rule** (top of `intake.md`) — irrelevant captures should not be mechanically asked (two adults: skip accessibility; no kids: skip age banding).
- **Peak-period pre-trip recheck now covers planning-only mode** — SKILL.md Mode-Specific Scope adds one line, closing the systematic gap for scenarios like domestic May Day / National Day holidays.

### Changed

- **SKILL.md slimmed by 44%** (331 → 190 lines). Adds a North Star + Navigation table. Rule details move down into their reference files; SKILL.md keeps only pointers.
- **Split `planning-rules.md`** (205-line grab bag) into three focused files:
  - `intake.md` (142 lines) — §1-§10 numbered, capture + carry-forward
  - `trip-prep.md` (108 lines) — §1-§7 numbered, visa + payment + SIM + insurance + etiquette + safety pointer
  - `weather-and-output.md` (70 lines) — weather + output + downstream pointers + independent-vs-guided
- **`test-prompts.json` structured** — the prose `expected` field is replaced with machine-checkable `assertions` (13 cases, each with mode / must_contain / must_cite_source_for / rule_refs fields).

### Why

An earlier skill review surfaced three classes of problem: (1) SKILL.md was 32KB and the LLM hit rule fatigue by the time it reached Final Check; (2) coverage blind spots (accessibility / ethics / transit visas / climate / diverse payment methods) would bite on real trips; (3) test-prompts was prose, unusable for regression. This release fixes all three in one pass.

## [0.5.2] — 2026-04-22

### Added

- **Safety & Emergency module** (`safety-and-emergency.md`) — destination-specific emergency numbers (police / fire / ambulance / tourist police), one foreigner-friendly hospital per city, home-country embassy / consulate with after-hours line, insurer claim path (not just purchase), step-by-step theft / loss response (passport, cards, phone, luggage), destination-specific risk phrased as **risk → specific trigger → specific action**.
- **Partial-number ban** — consular and hospital phone numbers must be complete and verified, or left empty with an explicit "→ Fetch from official site before departure: {URL}" pointer. No skeleton placeholders like `+81-3-xxxx-xxxx` that look real under stress.
- **Authoritative-platform rule for safer-venue selection** — when risk mitigation tells the traveller how to pick a restaurant / operator / taxi stand, recommendations must cite the destination-authoritative platform (DTCM-certified list for Dubai tour operators, Gambero Rosso / TheFork / Dissapore for Rome dining, Tabelog for Tokyo, Dianping for mainland China), not TripAdvisor by default.
- **Local etiquette & cultural norms at intake** — `planning-rules.md` §Trip Preparation now covers dress codes (mosques / temples / Michelin), tipping norms per region, shoes-off rules, photography restrictions (Kyoto Gion, religious interiors, Middle East airports / military), public-behavior lines (PDA / drinking-in-public / head / feet / left-hand), bargaining etiquette, and festival sensitivities (Ramadan / Sabbath / Buddhist Lent). Every item phrased as **situation → specific action**.
- **Pace / theme / moveable-festival confirmation checkpoints** — SKILL.md adds 4 new intake-time checkpoints: pace ≠ density mismatch, multi-theme conflict, pace × adventure sub-intensity orthogonal conflict (e.g., `leisurely` + sunrise-hike must be resolved per-day), Ramadan / moveable religious-festival overlap (reconfirm the year's exact dates from an official source before drafting dining / etiquette).
- **Adventure sub-intensity at intake** — when the user picks `adventure & outdoor`, the skill captures the single-day intensity ceiling (sunrise-hike / full-day trek / open-water dive / multi-pitch climb / whitewater rafting). These override the nominal pace and are not interchangeable.
- **Chronic medication at intake** — long-term prescription medication is captured as a **generic drug name** (not brand) and carried into the Trip Preparation parallel row schema, so per-country legality flags surface before drafting — never re-asked in the safety section.
- **Minors crossing borders** — `planning-rules.md` §Visa and Entry captures notarized-consent / translated-birth-certificate / apostille requirements for minors travelling with only one parent (high-enforcement destinations: UAE, Saudi Arabia, South Africa, Mexico, several EU members), raised at intake rather than at the airport.
- **Parallel verification for multi-country / multi-city trips** — any trip crossing ≥ 2 countries spawns 2 parallel sub-agents by country returning a structured row (visa + processing time · entry requirements · primary currency + dominant payment methods · recommended SIM / eSIM · destination-specific etiquette red flags · chronic-medication legality flag · minors-documents flag · source URLs · research date). Any trip crossing ≥ 2 cities spawns 2–3 sub-agents for the full safety block per city. Hotel shortlists > 4 candidates and specialty shortlists > 5 candidates also gain parallel verification.
- **Moveable-festival calendar sources** — `travel-sources.md` adds UAE Moon Sighting Committee, Saudi Umm al-Qura calendar, Israel Ministry of Religious Services, Thailand Buddhist Lent calendar as authoritative year-specific sources (±1 day last-minute moon-sighting shift).
- **DTCM certified tour-operator list** — `travel-sources.md` adds the Dubai Department of Economy and Tourism certified list as the primary source for desert safari / guided-tour vetting in Dubai.

### Changed

- Final Check audits the intake-carry-forward chain (chronic-medication generics → Trip Preparation row → Safety §2; minors documents raised at intake; Ramadan / moveable-festival date verified from official source before drafting).
- Final Check adds a Pace & theme row (daily density matches chosen pace; theme conflicts resolved before drafting; adventure sub-intensity reconciled per day).
- Peak-period recheck block is now single-sourced in `dining-rules.md` §3 and referenced elsewhere (no more duplicated peak-list inventory).
- Fallback Rules unify web-verification thresholds (restaurants / hotels / specialties / transport / consular-safety) into a single batch table.
- `test-prompts.json` adds three v0.5.2 scenarios: id:11 (Bali adventure + wellness pace-theme conflict), id:12 (Japan-Korea-Thailand spring-festival multi-country with chronic medication), id:13 (Dubai with 8-year-old during Ramadan).

## [0.5.1] — 2026-04-21

### Added

- **Self-drive planning hardening** — aligned with the dining-rules rigor model.
  - **Route-book app per self-drive day** — `transportation.md` §Rental Car / Self-Drive prescribes the on-the-ground navigation app: **Amap** as the route book for mainland China driving; **Google Maps** elsewhere, with regional fallbacks (Yandex / Naver / Kakao / Waze) where Google coverage is weak or blocked. Each driving day saved as a named multi-stop route; offline-map download required for low-signal segments (Iceland Highlands / F-roads, US national parks, Australian outback, Tibetan plateau, remote coastal routes).
  - **Driver-readiness intake triad** — `planning-rules.md` §Intake captures three driver-readiness elements whenever the user chooses self-drive: (1) **licence validity at destination** (mainland China does not recognise foreign/IDP; Japan requires JAF translation); (2) **driving side** (LHD vs RHD, with an adaptation-day recommendation for first-time side switchers); (3) **daily driving-time ceiling** (default 6h solo fit adult; 4–5h with elderly/kids/pregnant/pets; 3–4h on high-altitude or mountain days).
  - **Self-drive fallback branches** — SKILL.md Fallback Rules add four self-drive edge cases: licence not recognised at destination; long stretches of low/no cellular signal (require offline-map download + fuel-gap flagging); first-time driving on the opposite traffic side (short adaptation first leg, not the longest transfer); vulnerable co-travellers or mountain/high-altitude routes (lower the daily ceiling).
  - **Self-drive day card three required fields** — each driving day carries **total distance (km) · total driving time · longest single uninterrupted driving segment**, analogous to the four restaurant fields in `dining-rules.md` §5. All three must fit under the intake ceiling; otherwise split the day or drop a stop.
  - **Confirmation checkpoint for self-drive overage** — finalising a driving day that exceeds the intake ceiling now triggers explicit user confirmation, alongside existing checkpoints (budget > 15%, restaurant swap cascade, peak-season recheck).
  - **Offline-map download in pre-trip checklist** — `planning-rules.md` §Communication adds offline-map download for any trip segment crossing low/no cellular signal areas.

### Changed

- Final Check includes a `Self-drive` verification row (intake captured · day card three fields · app named · offline-map on checklist).
- `Minimal Output Shape`, `guide-redesign` block, and `Default Page Shape` all list self-drive card fields so the output contract is explicit.
- `test-prompts.json` adds two self-drive scenarios: id:9 (Western Sichuan domestic self-drive with elderly passengers) and id:10 (Iceland Ring Road international self-drive with LHD→RHD switch).

## [0.5.0] — 2026-04-21

### Added

- **Dining rules** — dedicated `dining-rules.md`: cross-day cuisine-diversity matrix, operating-status verification in the destination's language (closure / on-hold / relocated / rebuilt notices, plus "Permanently closed" on Google Maps), target-date operating calendar (weekly closures + destination-specific peak closures), ward/address consistency, four-field restaurant card (cuisine · platform rating · walking time from anchor · per-person price band in local currency), 10-minute walking radius, reservation channels + lead time, pre-departure peak recheck block, restaurant swap cascade, batched parallel verification.
- **Restaurant quantitative benchmarks** — platform-specific rating floors (Tabelog compressed scale ≥ 3.45/3.55/3.80; Dianping ≥ 4.5; TripAdvisor ≥ 4.0; Google Maps ≥ 4.3; local-authority alternates like TheFork / Yelp / OpenRice / Zomato). Per-person price tiers (Value / Mid / High) are always in **local currency** with destination-calibrated anchors, not a fixed JPY band.
- **Parallel sub-agent verification protocol** — for any trip with 5+ venues, verification runs as a batch through 2–3 parallel sub-agents returning structured rows (operating status · address · closures · peak-season notes · reservation channel · source URL).
- **Peak-period pre-trip recheck block** — trips overlapping destination-specific peaks (Japan GW / Obon / New Year; China Spring Festival / National Day; European Christmas / Easter / August holiday; US Thanksgiving / Christmas; Middle East Ramadan) carry a "3–5 days before departure" recheck block listing irregular-closure and peak-closure-risk venues by name and target date.
- Renamed the skill to `jhins-trip-planner` (previously `travel-itinerary-redesign`).

### Changed

- Data traceability tightened: explicit "do not trust restaurants from training data" rule — every restaurant's current status must be verified before appearing in the output.
- Food preference intake now captures three binding elements: **meal slot × cuisine × area**. "X or Y" cuisine requests produce two main-line candidates, not a merged pick.
- Swap cascade checkpoint: after any restaurant / hotel / anchor swap, run the §9 cascade (daily card, detail section, pre-trip recheck block, nav anchors, cuisine matrix) and confirm with the user.
- New web-verification fallback: if WebFetch stalls or a venue ID resolves to a relocated business, do not guess and do not silently drop — retry via a different source, or escalate to parallel sub-agents.
- Test suite adds cases across Japan GW and European Christmas so the peak-period rigor is not only tested against Japan.

## [0.4.0] — 2026-04-20

### Added

- **Local specialties** — `local-specialties.md`: three-stage filtering / signature · recommended · niche · skip tiering / customs and transport constraints / embedding shopping stops near their production origin.
- **Travel sources** — `travel-sources.md`: canonical data-source inventory (platform × purpose matrix) + citation format + rating thresholds.
- **Data traceability hard constraint** — all prices / schedules / ratings / availability must cite source + research date; never fabricate specific flight numbers / train numbers / shop names.

### Changed

- A bundle of optimizations after 11 rounds of internal skill quality iteration (the items below):
  - Dominant-mode transport routes (e.g., Shanghai → Hangzhou high-speed rail) no longer block on preference questions — the primary mode is given directly with alternatives listed.
  - Intake batching: when 3+ core inputs are missing, the first 2–3 questions are batched; vague requests get destination inspiration.
  - Budget overage checkpoint fires at 15% threshold.
  - Conflicting constraints fallback: explicit conflict exposure + prioritization options.
  - Last-minute trip (within 48h) fallback: skip booking-window advice, prioritize real-time channels.
  - Buffer time criteria quantified: nearby (~1 km / 10-min walk) vs cross-district (transit / >1 km) vs with-luggage (+10–15 min).
  - Output verification replaced "check screenshots" with concrete HTML validation criteria (375px viewport, broken anchors).
  - Workflow renumbered to a continuous 1–11 sequence.
  - Editing Rules deduplicated; Final Check refactored to reference canonical sources.
  - Evidence standards in `hotel-selection.md` and `transportation.md` now cross-reference `travel-sources.md`.

## [0.3.0] — 2026-04-19

### Added

- First version-numbered release. Pre-existing coverage: intake order, hotel selection, transport baseline rules, mode-specific scope table, multilingual auto-detection.
- License switched to MIT (briefly used CC BY-SA 4.0 before).

## [0.2.0] — 2026-04-18

### Added

- Comprehensive trip preparation (visa, payment, SIM, insurance).
- Booking rules and J-person rigor.
- Mode-specific scope table.
- Enhanced hotel-selection specificity.
- Trigger words in frontmatter.
- De-duplicated transport rules across files.
- Comprehensive transportation planning.

## [0.1.0] — 2026-04-17

### Added

- Initial skill with day-by-day itinerary workflow.
- Plugin-first repository layout.
- Claude Code and Codex installation support.

## Earlier (unversioned) — 2026-04-19 to 2026-04-20

- Initial `travel-itinerary-redesign` skill: three planning modes (planning-only / guide-redesign / existing-page-refactor) + weather awareness + baseline intake question order + skill plugin structure.
