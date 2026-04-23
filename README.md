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
- [`skills/jhins-trip-planner/references/safety-and-emergency.md`](./skills/jhins-trip-planner/references/safety-and-emergency.md): safety and emergency rules — destination-specific emergency numbers, medical access, consular support, insurance claim path, theft / loss response, and destination-specific risk notes
- [`skills/jhins-trip-planner/references/provenance.md`](./skills/jhins-trip-planner/references/provenance.md): reverse index — which test-prompts.json case covers which rule heading
- [`scripts/check-provenance.sh`](./scripts/check-provenance.sh): validates every `rule_refs` anchor in `test-prompts.json` resolves to a real heading
- [`scripts/check-version.sh`](./scripts/check-version.sh): `VERSION` must match `SKILL.md` / `plugin.json` / `marketplace.json`
- [`scripts/check-size.sh`](./scripts/check-size.sh): `SKILL.md` and reference files must stay under the rule-fatigue thresholds
- [`scripts/check-all.sh`](./scripts/check-all.sh): aggregator — runs all four checks above in one command
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

1. Bump `VERSION`, then run [`scripts/check-all.sh`](./scripts/check-all.sh) — this runs `check-links.sh` / `check-provenance.sh` / `check-version.sh` / `check-size.sh` and fails if any of them flag a regression (stale anchors, version drift, rule-fatigue bloat, broken cross-file references).
2. Verify [`agents/openai.yaml`](./agents/openai.yaml) still matches the current skill behavior.
3. Add a [`CHANGELOG.md`](./CHANGELOG.md) + [`CHANGELOG_EN.md`](./CHANGELOG_EN.md) entry for the new version (what changed, why).
4. Test in Claude Code locally if possible.

## Changelog

Full version history: [CHANGELOG_EN.md](./CHANGELOG_EN.md) (English) · [CHANGELOG.md](./CHANGELOG.md) (中文).

## References

- Codex skills docs: [developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)
- Claude Code discover/install plugins: [code.claude.com/docs/en/discover-plugins](https://code.claude.com/docs/en/discover-plugins)
- Claude Code create plugins: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)
- Claude Code plugin marketplaces: [code.claude.com/docs/en/plugin-marketplaces](https://code.claude.com/docs/en/plugin-marketplaces)
- Claude Code plugins reference: [code.claude.com/docs/en/plugins-reference](https://code.claude.com/docs/en/plugins-reference)
