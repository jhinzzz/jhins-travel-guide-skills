# jhins-trip-planner

[Chinese / README_CN](./README_CN.md)

End-to-end trip-planning plugin and custom marketplace repository for Claude Code, plus standalone skill installation instructions for Codex.

> **Renamed in 2026-04:** the skill was previously called `travel-itinerary-redesign`. The name was too narrow — redesign is only one of three output modes. If you already have the old plugin installed, run:
>
> ```text
> /plugin uninstall travel-itinerary-redesign@jhins-travel-guide-skills
> /plugin marketplace update jhins-travel-guide-skills
> /plugin install jhins-trip-planner@jhins-travel-guide-skills
> ```
>
> Standalone-skill users should remove the old `travel-itinerary-redesign/` folder from `~/.claude/skills/` or `.claude/skills/` and install the new `jhins-trip-planner/` folder.

This repository now has a plugin-first layout. The Claude plugin lives at the repository root, and the actual skill payload is under [`./skills/jhins-trip-planner/`](./skills/jhins-trip-planner/).

The install and marketplace notes below were checked on 2026-04-19 against the current Codex and Claude Code documentation.

## Repository layout

- [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json): Claude plugin manifest
- [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json): custom Claude marketplace manifest for this repo
- [`skills/jhins-trip-planner/`](./skills/jhins-trip-planner/): actual skill directory
- [`skills/jhins-trip-planner/SKILL.md`](./skills/jhins-trip-planner/SKILL.md): main skill file
- [`skills/jhins-trip-planner/references/planning-rules.md`](./skills/jhins-trip-planner/references/planning-rules.md): canonical intake, weather, transport, and deliverable rules
- [`skills/jhins-trip-planner/references/hotel-selection.md`](./skills/jhins-trip-planner/references/hotel-selection.md): hotel evidence, tiering, and output rules
- [`skills/jhins-trip-planner/references/transportation.md`](./skills/jhins-trip-planner/references/transportation.md): round-trip transport booking, timing, pricing, transfer planning, and arrival time rules
- [`skills/jhins-trip-planner/references/local-specialties.md`](./skills/jhins-trip-planner/references/local-specialties.md): local souvenir and specialty recommendation rules (selection criteria, tiering, customs/transport constraints)
- [`skills/jhins-trip-planner/references/travel-sources.md`](./skills/jhins-trip-planner/references/travel-sources.md): canonical travel information sources, cross-referencing rules, and citation format
- [`skills/jhins-trip-planner/references/dining-rules.md`](./skills/jhins-trip-planner/references/dining-rules.md): restaurant selection rules — cuisine-diversity matrix, operating-status verification, target-date calendar checks, ward consistency, meal × cuisine × area intake, reservation channels, peak-season recheck, and swap cascades
- [`agents/openai.yaml`](./agents/openai.yaml): optional OpenAI/Codex-facing metadata

## Claude Code: install from marketplace

This repository is now set up as a Claude plugin and also as its own custom marketplace source.

Users can install it with these documented Claude Code commands:

```text
/plugin marketplace add jhinzzz/jhins-travel-guide-skills
/plugin install jhins-trip-planner@jhins-travel-guide-skills
```

Equivalent non-interactive CLI commands:

```bash
claude plugin marketplace add jhinzzz/jhins-travel-guide-skills
claude plugin install jhins-trip-planner@jhins-travel-guide-skills
```

After installation, the skill is available through the plugin.

## Claude Code: local plugin testing

Before publishing or updating marketplace users, test locally with Claude Code's documented plugin workflow:

```bash
claude --plugin-dir .
```

Then inside Claude Code:

```text
/reload-plugins
/jhins-trip-planner:jhins-trip-planner
```

If you do not have the `claude` CLI installed locally, you can still review the plugin files and publish from GitHub, but you should test on a machine that has Claude Code available before asking users to install updates.

## Claude Code: publish to the official marketplace

This repository is ready for custom marketplace installation now. It is not automatically in Anthropic's official marketplace.

To make it installable from the official marketplace:

1. Keep `.claude-plugin/plugin.json` updated.
2. Bump the plugin version before each release.
3. Submit the plugin through Anthropic's official submission flow:
   - `claude.ai/settings/plugins/submit`
   - `platform.claude.com/plugins/submit`
4. After approval, users can install it from the official marketplace with:

```text
/plugin install jhins-trip-planner@claude-plugins-official
```

Until that approval happens, the working install path is your custom marketplace command shown above.

## Codex: install with the built-in skill installer

OpenAI's Codex skills docs state that `$skill-installer` can install skills from curated sources and from other repositories.

That means Codex users do not need to manually download the skill if they are willing to use the documented installer workflow.

Prompt pattern inside Codex:

```text
Use $skill-installer to install the skill from jhinzzz/jhins-travel-guide-skills, path skills/jhins-trip-planner
```

I did not find a separately documented package-manager-style shell command such as `codex skill install ...`. The documented path is to invoke `$skill-installer` from within Codex.

## Codex: manual install fallback

If the user does not want to use `$skill-installer`, install the skill manually by copying the nested skill directory:

1. Copy or symlink [`./skills/jhins-trip-planner/`](./skills/jhins-trip-planner/) to one of Codex's documented skill locations.
2. Make sure the installed directory ends with `jhins-trip-planner/SKILL.md`.
3. Restart Codex if the skill does not appear automatically.

Codex skill locations documented by OpenAI:

- User scope: `$HOME/.agents/skills/<skill-name>/`
- Repo scope: `.agents/skills/<skill-name>/`

## Standalone skill install in Claude Code

Claude Code also supports standalone skills outside the plugin marketplace.

If a user wants to install just the raw skill instead of the plugin:

1. Copy or symlink [`./skills/jhins-trip-planner/`](./skills/jhins-trip-planner/) to `~/.claude/skills/jhins-trip-planner/` for personal use, or `.claude/skills/jhins-trip-planner/` inside a project.
2. Make sure the installed directory ends with `jhins-trip-planner/SKILL.md`.
3. Restart Claude Code if the top-level `.claude/skills/` directory was created for the first time during the current session.

## What users get

The `jhins-trip-planner` skill is designed for:

- planning a trip from a rough brief
- restructuring fragmented travel notes
- redesigning an itinerary page into a reusable, weather-aware guide
- planning round-trip transport (flights, high-speed rail, trains, buses, shuttles, ferries, taxis) with booking windows, price ranges, recommended arrival times, and backup options
- producing hotel recommendations and route-fit dining and shopping notes
- recommending destination-specific souvenirs and local specialties with evidence-based tiering and customs/transport warnings

Expected outputs:

- Planning-only requests: itinerary advice in chat or a markdown outline unless files are explicitly requested
- Redesign/page-build requests: both markdown and HTML deliverables
- Standalone page requests: a single HTML file
- Maintainable project requests: split HTML, CSS, and JS when appropriate

## Release checklist

Before publishing an update:

1. Update plugin version in [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)
2. Update marketplace version in [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json)
3. Verify [`skills/jhins-trip-planner/SKILL.md`](./skills/jhins-trip-planner/SKILL.md) still matches the references
4. Verify [`agents/openai.yaml`](./agents/openai.yaml) still matches the current skill behavior
5. Test in Claude Code locally if possible

## Changelog

### v0.5.1 (2026-04-21)

Self-drive planning hardening — destination-agnostic, aligned with the dining-rules rigor model.

**New:**
- **Route-book app per self-drive day** — `transportation.md` §Rental Car / Self-Drive now prescribes the on-the-ground navigation app: **Amap (高德地图)** as the route book for mainland China driving; **Google Maps** elsewhere, with regional fallbacks (Yandex Maps / Naver / Kakao / Waze) where Google coverage is weak or blocked. Each driving day is saved as a named multi-stop route; offline-map download is required for low-signal segments (Iceland Highlands / F-roads, US national parks, Australian outback, Tibetan plateau, remote coastal routes).
- **Driver-readiness intake triad** — `planning-rules.md` §Intake now captures three driver-readiness elements whenever the user chooses self-drive: (1) **licence validity at destination** (mainland China does not recognise foreign/IDP; Japan requires JAF translation); (2) **driving side** (LHD vs RHD, with an adaptation-day recommendation for first-time side switchers); (3) **daily driving-time ceiling** (default 6 h solo fit adult; 4–5 h with elderly/kids/pregnant/pets; 3–4 h on high-altitude or mountain days).
- **Self-drive fallback branches** — `SKILL.md` Fallback Rules add four self-drive edge cases: licence not recognised at destination; long stretches of low/no cellular signal (require offline-map download + fuel-gap flagging); first-time driving on the opposite traffic side (short adaptation first leg, not the longest transfer); vulnerable co-travellers or mountain/high-altitude routes (lower the daily ceiling).
- **Self-drive day card three required fields** — each driving day carries **total distance (km) · total driving time · longest single uninterrupted driving segment**, analogous to the four restaurant fields in `dining-rules.md` §5. All three must fit under the intake ceiling; otherwise split the day or drop a stop.
- **Confirmation checkpoint for self-drive overage** — finalising a driving day that exceeds the intake ceiling now triggers explicit user confirmation, alongside existing checkpoints (budget > 15%, restaurant swap cascade, peak-season recheck).
- **Offline-map download in pre-trip checklist** — `planning-rules.md` §Communication adds offline-map download for any trip segment crossing low/no cellular signal areas.

**Optimizations:**
- Final Check now includes a `Self-drive` verification row (intake captured · day card three fields · app named · offline-map on checklist).
- `Minimal Output Shape`, `guide-redesign` block, and `Default Page Shape` now list self-drive card fields so the output contract is explicit.
- `test-prompts.json` adds two self-drive scenarios: id:9 (川西 domestic self-drive with elderly passengers) and id:10 (Iceland Ring Road international self-drive with LHD→RHD switch).

### v0.5.0 (2026-04-21)

Lessons from a real Japan Golden Week trip were distilled into **destination-agnostic** dining rules — Japan / Europe / US / China examples illustrate the same underlying patterns so the skill remains a general-purpose travel skill, not a Japan guide.

**New features:**
- **Dining rules reference** (`dining-rules.md`) — consolidated restaurant governance, destination-agnostic: cuisine-diversity matrix across the whole trip, operating-status verification in the destination's language (closure / on-hold / relocated / rebuilt notices, plus "Permanently closed" on Google Maps), target-date calendar checks (weekly closures + destination-specific peak closures), district/address consistency, meal × cuisine × area intake, reservation channels and lead times, and swap-cascade rules.
- **Restaurant quantitative benchmarks** — platform-specific rating floors (Tabelog compressed scale ≥ 3.45/3.55/3.80; Dianping ≥ 4.5; TripAdvisor ≥ 4.0; Google Maps ≥ 4.3; local-authority alternates like TheFork / Yelp / OpenRice / Zomato). Per-person price tiers (Value / Mid / High) are always in **local currency** with destination-calibrated anchors, not a fixed JPY band.
- **Parallel sub-agent verification protocol** — for any trip with 5+ venues, verification runs as a batch through 2–3 parallel sub-agents returning structured rows (operating status · address · closures · peak-season notes · reservation channel · source URL).
- **Peak-period pre-trip recheck block** — trips overlapping destination-specific peaks (examples: Japan GW / O-Bon / New Year; China Spring Festival / National Day; European Christmas / Easter / August vacation; US Thanksgiving / Christmas; Ramadan in the Middle East) now carry a "3–5 days before departure" recheck block listing irregular-closure and holiday-closure-risk venues by name and target date.

**Improvements:**
- Data traceability tightened: explicit "do not trust restaurants from training data" rule — every restaurant must have its current status verified before appearing in the output.
- Food preference intake now captures three binding elements: **meal slot × cuisine × area**. "X or Y" cuisine requests produce two main-line candidates, not a merged pick.
- Swap cascade checkpoint added: after any restaurant / hotel / anchor swap, run the §9 cascade (daily card, detail section, pre-trip recheck block, nav anchors, cuisine matrix) and confirm with the user.
- Restaurant card required fields: cuisine category · platform rating · walking time from anchor · per-person price band in local currency.
- New web-verification fallback: if WebFetch stalls or a venue ID resolves to a relocated business, do not guess and do not drop silently — retry via a different source, or escalate to parallel sub-agents.
- Test suite adds cases across Japan GW and European Christmas so the peak-period rigor is not only tested against Japan.

### v0.4.0 (2026-04-20)

**New features:**
- **Local specialties and souvenirs** — new reference file (`local-specialties.md`) with evidence-based selection criteria, 4-tier rating system (signature / recommended / niche / skip), customs and transport constraint warnings, and output card format. Embedded into daily itinerary cards near purchase locations.
- **Travel information sources** — new reference file (`travel-sources.md`) defining canonical research platforms for China (Mafengwo, Ctrip, Qunar, Xiaohongshu, Dianping, Fliggy, 12306) and international (TripAdvisor, Klook, Lonely Planet, Trip.com, Condé Nast Traveler, Booking.com, Google Maps, etc.), with cross-referencing rules and citation format.
- **Data traceability constraint** — every factual recommendation (prices, schedules, ratings, hotel names, shop names) must cite its source and research date. No fabricated specifics allowed.

**Improvements (11 rounds of Darwin Skill optimization, score 86.0 → 93.15):**
- Dominant-mode transport routes no longer block planning with unnecessary preference questions
- Intake batching: when 3+ core inputs are missing, first 2–3 questions are batched; vague requests get destination inspiration
- Budget overage checkpoint at 15% threshold before finalizing plans
- Conflicting constraints fallback with explicit prioritization options
- Last-minute trip (within 48h) fallback: skip booking windows, prioritize real-time channels
- Buffer time criteria quantified: nearby (~1 km / 10-min walk) vs. cross-district (transit / >1 km) vs. with-luggage (+10–15 min)
- Step 10 verification replaced vague "check screenshots" with concrete HTML validation criteria (375px viewport, broken anchors)
- Workflow renumbered to continuous 1–11 sequence
- Editing Rules deduplicated; Final Check refactored to reference canonical sources
- Evidence standards in hotel-selection.md and transportation.md now cross-reference travel-sources.md

### v0.3.0 (2026-04-19)

- Plugin version bump
- Language auto-detection for multilingual output
- Fix plugin install: remove unsupported agents field from manifest

### v0.2.0 (2026-04-18)

- Comprehensive trip preparation (visa, payment, SIM, insurance)
- Booking rules and J-person rigor
- Mode-specific scope table
- Enhanced hotel-selection specificity
- Trigger words in frontmatter
- De-duplicated transport rules across files
- Comprehensive transportation planning

### v0.1.0 (2026-04-17)

- Initial skill with day-by-day itinerary workflow
- Plugin-first repository layout
- Claude Code and Codex installation support

## References

- Codex skills docs: [developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)
- Claude Code discover/install plugins: [code.claude.com/docs/en/discover-plugins](https://code.claude.com/docs/en/discover-plugins)
- Claude Code create plugins: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)
- Claude Code plugin marketplaces: [code.claude.com/docs/en/plugin-marketplaces](https://code.claude.com/docs/en/plugin-marketplaces)
- Claude Code plugins reference: [code.claude.com/docs/en/plugins-reference](https://code.claude.com/docs/en/plugins-reference)
