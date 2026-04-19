# travel-itinerary-redesign

[Chinese / README_CN](./README_CN.md)

Travel itinerary redesign plugin and custom marketplace repository for Claude Code, plus standalone skill installation instructions for Codex.

This repository now has a plugin-first layout. The Claude plugin lives at the repository root, and the actual skill payload is under [`./skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/).

The install and marketplace notes below were checked on 2026-04-19 against the current Codex and Claude Code documentation.

## Repository layout

- [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json): Claude plugin manifest
- [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json): custom Claude marketplace manifest for this repo
- [`skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/): actual skill directory
- [`skills/travel-itinerary-redesign/SKILL.md`](./skills/travel-itinerary-redesign/SKILL.md): main skill file
- [`skills/travel-itinerary-redesign/references/planning-rules.md`](./skills/travel-itinerary-redesign/references/planning-rules.md): canonical intake, weather, and deliverable rules
- [`skills/travel-itinerary-redesign/references/hotel-selection.md`](./skills/travel-itinerary-redesign/references/hotel-selection.md): hotel evidence, tiering, and output rules
- [`agents/openai.yaml`](./agents/openai.yaml): optional OpenAI/Codex-facing metadata

## Claude Code: install from marketplace

This repository is now set up as a Claude plugin and also as its own custom marketplace source.

Users can install it with these documented Claude Code commands:

```text
/plugin marketplace add jhinzzz/jhins-travel-guide-skills
/plugin install travel-itinerary-redesign@jhins-travel-guide-skills
```

Equivalent non-interactive CLI commands:

```bash
claude plugin marketplace add jhinzzz/jhins-travel-guide-skills
claude plugin install travel-itinerary-redesign@jhins-travel-guide-skills
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
/travel-itinerary-redesign:travel-itinerary-redesign
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
/plugin install travel-itinerary-redesign@claude-plugins-official
```

Until that approval happens, the working install path is your custom marketplace command shown above.

## Codex: install with the built-in skill installer

OpenAI's Codex skills docs state that `$skill-installer` can install skills from curated sources and from other repositories.

That means Codex users do not need to manually download the skill if they are willing to use the documented installer workflow.

Prompt pattern inside Codex:

```text
Use $skill-installer to install the skill from jhinzzz/jhins-travel-guide-skills, path skills/travel-itinerary-redesign
```

I did not find a separately documented package-manager-style shell command such as `codex skill install ...`. The documented path is to invoke `$skill-installer` from within Codex.

## Codex: manual install fallback

If the user does not want to use `$skill-installer`, install the skill manually by copying the nested skill directory:

1. Copy or symlink [`./skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/) to one of Codex's documented skill locations.
2. Make sure the installed directory ends with `travel-itinerary-redesign/SKILL.md`.
3. Restart Codex if the skill does not appear automatically.

Codex skill locations documented by OpenAI:

- User scope: `$HOME/.agents/skills/<skill-name>/`
- Repo scope: `.agents/skills/<skill-name>/`

## Standalone skill install in Claude Code

Claude Code also supports standalone skills outside the plugin marketplace.

If a user wants to install just the raw skill instead of the plugin:

1. Copy or symlink [`./skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/) to `~/.claude/skills/travel-itinerary-redesign/` for personal use, or `.claude/skills/travel-itinerary-redesign/` inside a project.
2. Make sure the installed directory ends with `travel-itinerary-redesign/SKILL.md`.
3. Restart Claude Code if the top-level `.claude/skills/` directory was created for the first time during the current session.

## What users get

The `travel-itinerary-redesign` skill is designed for:

- planning a trip from a rough brief
- restructuring fragmented travel notes
- redesigning an itinerary page into a reusable, weather-aware guide
- producing hotel recommendations and route-fit dining and shopping notes

Expected outputs:

- Planning-only requests: itinerary advice in chat or a markdown outline unless files are explicitly requested
- Redesign/page-build requests: both markdown and HTML deliverables
- Standalone page requests: a single HTML file
- Maintainable project requests: split HTML, CSS, and JS when appropriate

## Release checklist

Before publishing an update:

1. Update plugin version in [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)
2. Update marketplace version in [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json)
3. Verify [`skills/travel-itinerary-redesign/SKILL.md`](./skills/travel-itinerary-redesign/SKILL.md) still matches the references
4. Verify [`agents/openai.yaml`](./agents/openai.yaml) still matches the current skill behavior
5. Test in Claude Code locally if possible

## References

- Codex skills docs: [developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)
- Claude Code discover/install plugins: [code.claude.com/docs/en/discover-plugins](https://code.claude.com/docs/en/discover-plugins)
- Claude Code create plugins: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)
- Claude Code plugin marketplaces: [code.claude.com/docs/en/plugin-marketplaces](https://code.claude.com/docs/en/plugin-marketplaces)
- Claude Code plugins reference: [code.claude.com/docs/en/plugins-reference](https://code.claude.com/docs/en/plugins-reference)
