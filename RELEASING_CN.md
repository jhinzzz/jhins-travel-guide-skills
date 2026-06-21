# 发布 jhins-trip-planner

[English / RELEASING](./RELEASING.md)

面向维护者的测试、发布与版本管理说明。安装并使用本 skill 的终端用户无需关心这里的内容 —— 安装与使用请看 [README_CN.md](./README_CN.md)。

## Claude Code：本地测试 plugin

在正式发布或更新前，建议按 Claude Code 官方文档先做本地测试：

```bash
claude --plugin-dir .
```

然后在 Claude Code 内执行：

```text
/reload-plugins
/jhins-trip-planner:jhins-trip-planner
```

如果你本机没有安装 `claude` CLI，那就无法在本机直接跑官方 plugin 验证流程。此时至少应在有 Claude Code 环境的机器上做一次真实测试，再让用户安装更新。

## Claude Code：发布到官方 marketplace

这个仓库现在已经可以通过“自定义 marketplace”安装，但还不等于已经进入 Anthropic 官方 marketplace。

如果你想让用户通过官方 marketplace 安装，还需要：

1. 持续维护 [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)
2. 每次发布前提升版本号
3. 通过 Anthropic 官方入口提交：
   - `claude.ai/settings/plugins/submit`
   - `platform.claude.com/plugins/submit`
4. 审核通过后，用户可以使用：

```text
/plugin install jhins-trip-planner@claude-plugins-official
```

在官方审核通过之前，当前真正可用的安装方式仍然是 [README_CN.md](./README_CN.md) 里的自定义 marketplace 命令。

## 发布检查清单

每次更新前：

1. 先 bump `VERSION`，然后跑 [`scripts/check-all.sh`](./scripts/check-all.sh) —— 它会依次跑 `check-links.sh` / `check-provenance.sh` / `check-version.sh` / `check-size.sh`，任何一项回归（跨文件引用断链、test_refs 锚点漂移、版本号不对齐、规则疲劳膨胀）都会退出 1。
2. 核对 [`agents/openai.yaml`](./agents/openai.yaml) 是否仍与当前 skill 行为一致。
3. 在 [`CHANGELOG.md`](./CHANGELOG.md) + [`CHANGELOG_EN.md`](./CHANGELOG_EN.md) 里加新版本条目（改了什么、为什么）。
4. 如条件允许，先在 Claude Code 本地跑一次 plugin 测试。
