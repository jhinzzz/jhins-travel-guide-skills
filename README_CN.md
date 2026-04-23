# jhins-trip-planner

[English / README](./README.md)

这是一个面向 Claude Code 的端到端旅行规划插件仓库，同时也保留了给 Codex 使用的独立 skill 安装方式。

> **2026-04 重命名：**本 skill 原名 `travel-itinerary-redesign`，但「redesign」只是三种输出模式之一，名字覆盖不全当前能力。如果你已安装旧插件，请执行：
>
> ```text
> /plugin uninstall travel-itinerary-redesign@jhins-travel-guide-skills
> /plugin marketplace update jhins-travel-guide-skills
> /plugin install jhins-trip-planner@jhins-travel-guide-skills
> ```
>
> 如果是独立 skill 安装，请从 `~/.claude/skills/` 或 `.claude/skills/` 删除旧的 `travel-itinerary-redesign/` 目录，再安装新的 `jhins-trip-planner/` 目录。

当前仓库已经改成 plugin-first 结构：Claude plugin 就在仓库根目录，真正的 skill 内容在 [`./skills/jhins-trip-planner/`](./skills/jhins-trip-planner/) 下。

以下安装与 marketplace 说明基于 2026-04-19 查阅的 Codex 与 Claude Code 官方文档整理。

## 仓库结构

- [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)：Claude plugin manifest
- [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json)：当前仓库自己的 Claude marketplace 清单
- [`skills/jhins-trip-planner/`](./skills/jhins-trip-planner/)：真正的 skill 目录
- [`skills/jhins-trip-planner/SKILL.md`](./skills/jhins-trip-planner/SKILL.md)：主技能文件
- [`skills/jhins-trip-planner/references/planning-rules.md`](./skills/jhins-trip-planner/references/planning-rules.md)：行程输入、天气处理、交通规划、交付形式的唯一规则来源
- [`skills/jhins-trip-planner/references/hotel-selection.md`](./skills/jhins-trip-planner/references/hotel-selection.md)：酒店证据标准、分层与输出规则
- [`skills/jhins-trip-planner/references/transportation.md`](./skills/jhins-trip-planner/references/transportation.md)：往返交通购票时间、到站时间、票价指导、换乘规划与输出格式
- [`skills/jhins-trip-planner/references/local-specialties.md`](./skills/jhins-trip-planner/references/local-specialties.md)：当地手信/特产推荐规则（选品标准、分层、海关/运输约束）
- [`skills/jhins-trip-planner/references/travel-sources.md`](./skills/jhins-trip-planner/references/travel-sources.md)：旅游攻略数据源、交叉验证规则与引用格式
- [`skills/jhins-trip-planner/references/dining-rules.md`](./skills/jhins-trip-planner/references/dining-rules.md)：餐饮规划规则 — 品类矩阵、运营状态核实、目标日期日历、行政区一致性、餐次×品类×区域输入、预订渠道、旺季复查、替换级联
- [`skills/jhins-trip-planner/references/safety-and-emergency.md`](./skills/jhins-trip-planner/references/safety-and-emergency.md)：安全与应急规则 — 目的地紧急号码、医疗就近、领事支持、保险理赔路径、失窃/丢失响应、目的地特定风险
- [`skills/jhins-trip-planner/references/budget.md`](./skills/jhins-trip-planner/references/budget.md)：预算规则 — 按区域 band 分类目占比、隐性成本、refundable 取舍触发、汇率与支付时机
- [`skills/jhins-trip-planner/references/provenance.md`](./skills/jhins-trip-planner/references/provenance.md)：反向索引 — 每条规则 heading 被 test-prompts.json 的哪些 case 覆盖
- [`scripts/check-provenance.sh`](./scripts/check-provenance.sh)：校验 `test-prompts.json` 里每个 `rule_refs` 锚点指向的 heading 真实存在
- [`scripts/check-version.sh`](./scripts/check-version.sh)：`VERSION` 必须和 `SKILL.md` / `plugin.json` / `marketplace.json` 对齐
- [`scripts/check-size.sh`](./scripts/check-size.sh)：`SKILL.md` 和 reference 文件必须落在规则疲劳阈值之下
- [`scripts/check-all.sh`](./scripts/check-all.sh)：聚合脚本 — 一条命令跑上面四个 check
- [`agents/openai.yaml`](./agents/openai.yaml)：可选的 OpenAI/Codex 元数据

## Claude Code：通过 marketplace 安装

这个仓库现在已经同时具备：

- Claude plugin
- 自定义 marketplace source

所以用户现在就可以通过 Claude Code 的 marketplace 机制安装，而不需要你先上官方 marketplace。

安装命令：

```text
/plugin marketplace add jhinzzz/jhins-travel-guide-skills
/plugin install jhins-trip-planner@jhins-travel-guide-skills
```

对应的非交互 CLI 命令：

```bash
claude plugin marketplace add jhinzzz/jhins-travel-guide-skills
claude plugin install jhins-trip-planner@jhins-travel-guide-skills
```

安装完成后，这个 skill 会通过 plugin 提供给 Claude Code。

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

在官方审核通过之前，当前真正可用的安装方式仍然是上面的自定义 marketplace 命令。

## Codex：使用内置 skill installer 安装

OpenAI 的 Codex skills 文档明确写到，`$skill-installer` 可以安装 curated skills，也可以从其他仓库安装 skill。

这意味着 Codex 用户如果愿意用官方推荐流程，就不需要手动下载。

在 Codex 里可以使用类似提示：

```text
Use $skill-installer to install the skill from jhinzzz/jhins-travel-guide-skills, path skills/jhins-trip-planner
```

我没有查到一个单独文档化的 shell 子命令，类似 `codex skill install ...`。当前有文档依据的方式，是在 Codex 中调用 `$skill-installer`。

## Codex：手动安装兜底方案

如果用户不想使用 `$skill-installer`，就手动安装 skill：

1. 将 [`./skills/jhins-trip-planner/`](./skills/jhins-trip-planner/) 复制或软链接到 Codex 的 skill 目录。
2. 确认安装后目录以 `jhins-trip-planner/SKILL.md` 结尾。
3. 如果技能没有自动出现，重启 Codex。

OpenAI 文档当前列出的 Codex skill 路径包括：

- 用户级：`$HOME/.agents/skills/<skill-name>/`
- 仓库级：`.agents/skills/<skill-name>/`

## Claude Code：作为独立 skill 安装

除了 plugin 安装方式，Claude Code 也支持单独安装 raw skill。

如果用户只想安装 skill 本体，不想走 plugin：

1. 将 [`./skills/jhins-trip-planner/`](./skills/jhins-trip-planner/) 复制或软链接到 `~/.claude/skills/jhins-trip-planner/`，供个人使用；或者放到项目内的 `.claude/skills/jhins-trip-planner/`。
2. 确认安装后的目录以 `jhins-trip-planner/SKILL.md` 结尾。
3. 如果当前会话中第一次创建 `.claude/skills/` 顶层目录，重启 Claude Code。

## 用户安装后能做什么

`jhins-trip-planner` 这个 skill 主要用于：

- 从粗略旅行需求开始做行程规划
- 整理碎片化旅行笔记
- 把旅行页面重构成可复用、考虑天气因素的行程指南
- 规划往返交通（航班、高铁、火车、巴士、穿梭巴士、渡轮、的士等），含购票时间、票价区间、建议到站时间、备选方案
- 输出酒店建议，以及贴合路线的餐饮和购物信息
- 推荐当地手信/特产，含证据分级、海关和运输提示

预期输出：

- 仅做规划时：聊天建议或 markdown 大纲，除非明确要求文件
- 做旅行页面或交付物重构时：同时产出 markdown 和 HTML
- 需要单页面时：输出单个 HTML 文件
- 需要可维护项目时：按情况拆分 HTML、CSS、JS

## 发布检查清单

每次更新前：

1. 先 bump `VERSION`，然后跑 [`scripts/check-all.sh`](./scripts/check-all.sh) —— 它会依次跑 `check-links.sh` / `check-provenance.sh` / `check-version.sh` / `check-size.sh`，任何一项回归（跨文件引用断链、test_refs 锚点漂移、版本号不对齐、规则疲劳膨胀）都会退出 1。
2. 核对 [`agents/openai.yaml`](./agents/openai.yaml) 是否仍与当前 skill 行为一致。
3. 在 [`CHANGELOG.md`](./CHANGELOG.md) + [`CHANGELOG_EN.md`](./CHANGELOG_EN.md) 里加新版本条目（改了什么、为什么）。
4. 如条件允许，先在 Claude Code 本地跑一次 plugin 测试。

## 版本变动

完整版本记录见 [CHANGELOG.md](./CHANGELOG.md)（中文）· [CHANGELOG_EN.md](./CHANGELOG_EN.md)（English）。

## 参考文档

- Codex skills docs: [developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)
- Claude Code discover/install plugins: [code.claude.com/docs/en/discover-plugins](https://code.claude.com/docs/en/discover-plugins)
- Claude Code create plugins: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)
- Claude Code plugin marketplaces: [code.claude.com/docs/en/plugin-marketplaces](https://code.claude.com/docs/en/plugin-marketplaces)
- Claude Code plugins reference: [code.claude.com/docs/en/plugins-reference](https://code.claude.com/docs/en/plugins-reference)
