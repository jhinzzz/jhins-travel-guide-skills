# Releasing jhins-trip-planner

[中文 / RELEASING_CN](./RELEASING_CN.md)

Maintainer notes for testing, publishing, and cutting a release. End users installing the skill do not need anything here — see [README.md](./README.md) for install and usage.

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

1. Keep [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json) updated.
2. Bump the plugin version before each release.
3. Submit the plugin through Anthropic's official submission flow:
   - `claude.ai/settings/plugins/submit`
   - `platform.claude.com/plugins/submit`
4. After approval, users can install it from the official marketplace with:

```text
/plugin install jhins-trip-planner@claude-plugins-official
```

Until that approval happens, the working install path is the custom marketplace command shown in [README.md](./README.md).

## Release checklist

Before publishing an update:

1. Bump `VERSION`, then run [`scripts/check-all.sh`](./scripts/check-all.sh) — this runs `check-links.sh` / `check-provenance.sh` / `check-version.sh` / `check-size.sh` and fails if any of them flag a regression (stale anchors, version drift, rule-fatigue bloat, broken cross-file references).
2. Verify [`agents/openai.yaml`](./agents/openai.yaml) still matches the current skill behavior.
3. Add a [`CHANGELOG.md`](./CHANGELOG.md) + [`CHANGELOG_EN.md`](./CHANGELOG_EN.md) entry for the new version (what changed, why).
4. Test in Claude Code locally if possible.
