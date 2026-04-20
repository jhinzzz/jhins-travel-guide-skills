# travel-itinerary-redesign

[English / README](./README.md)

这是一个面向 Claude Code 的旅行行程插件仓库，同时也保留了给 Codex 使用的独立 skill 安装方式。

当前仓库已经改成 plugin-first 结构：Claude plugin 就在仓库根目录，真正的 skill 内容在 [`./skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/) 下。

以下安装与 marketplace 说明基于 2026-04-19 查阅的 Codex 与 Claude Code 官方文档整理。

## 仓库结构

- [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json)：Claude plugin manifest
- [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json)：当前仓库自己的 Claude marketplace 清单
- [`skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/)：真正的 skill 目录
- [`skills/travel-itinerary-redesign/SKILL.md`](./skills/travel-itinerary-redesign/SKILL.md)：主技能文件
- [`skills/travel-itinerary-redesign/references/planning-rules.md`](./skills/travel-itinerary-redesign/references/planning-rules.md)：行程输入、天气处理、交通规划、交付形式的唯一规则来源
- [`skills/travel-itinerary-redesign/references/hotel-selection.md`](./skills/travel-itinerary-redesign/references/hotel-selection.md)：酒店证据标准、分层与输出规则
- [`skills/travel-itinerary-redesign/references/transportation.md`](./skills/travel-itinerary-redesign/references/transportation.md)：往返交通购票时间、到站时间、票价指导、换乘规划与输出格式
- [`skills/travel-itinerary-redesign/references/local-specialties.md`](./skills/travel-itinerary-redesign/references/local-specialties.md)：当地手信/特产推荐规则（选品标准、分层、海关/运输约束）
- [`skills/travel-itinerary-redesign/references/travel-sources.md`](./skills/travel-itinerary-redesign/references/travel-sources.md)：旅游攻略数据源、交叉验证规则与引用格式
- [`agents/openai.yaml`](./agents/openai.yaml)：可选的 OpenAI/Codex 元数据

## Claude Code：通过 marketplace 安装

这个仓库现在已经同时具备：

- Claude plugin
- 自定义 marketplace source

所以用户现在就可以通过 Claude Code 的 marketplace 机制安装，而不需要你先上官方 marketplace。

安装命令：

```text
/plugin marketplace add jhinzzz/jhins-travel-guide-skills
/plugin install travel-itinerary-redesign@jhins-travel-guide-skills
```

对应的非交互 CLI 命令：

```bash
claude plugin marketplace add jhinzzz/jhins-travel-guide-skills
claude plugin install travel-itinerary-redesign@jhins-travel-guide-skills
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
/travel-itinerary-redesign:travel-itinerary-redesign
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
/plugin install travel-itinerary-redesign@claude-plugins-official
```

在官方审核通过之前，当前真正可用的安装方式仍然是上面的自定义 marketplace 命令。

## Codex：使用内置 skill installer 安装

OpenAI 的 Codex skills 文档明确写到，`$skill-installer` 可以安装 curated skills，也可以从其他仓库安装 skill。

这意味着 Codex 用户如果愿意用官方推荐流程，就不需要手动下载。

在 Codex 里可以使用类似提示：

```text
Use $skill-installer to install the skill from jhinzzz/jhins-travel-guide-skills, path skills/travel-itinerary-redesign
```

我没有查到一个单独文档化的 shell 子命令，类似 `codex skill install ...`。当前有文档依据的方式，是在 Codex 中调用 `$skill-installer`。

## Codex：手动安装兜底方案

如果用户不想使用 `$skill-installer`，就手动安装 skill：

1. 将 [`./skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/) 复制或软链接到 Codex 的 skill 目录。
2. 确认安装后目录以 `travel-itinerary-redesign/SKILL.md` 结尾。
3. 如果技能没有自动出现，重启 Codex。

OpenAI 文档当前列出的 Codex skill 路径包括：

- 用户级：`$HOME/.agents/skills/<skill-name>/`
- 仓库级：`.agents/skills/<skill-name>/`

## Claude Code：作为独立 skill 安装

除了 plugin 安装方式，Claude Code 也支持单独安装 raw skill。

如果用户只想安装 skill 本体，不想走 plugin：

1. 将 [`./skills/travel-itinerary-redesign/`](./skills/travel-itinerary-redesign/) 复制或软链接到 `~/.claude/skills/travel-itinerary-redesign/`，供个人使用；或者放到项目内的 `.claude/skills/travel-itinerary-redesign/`。
2. 确认安装后的目录以 `travel-itinerary-redesign/SKILL.md` 结尾。
3. 如果当前会话中第一次创建 `.claude/skills/` 顶层目录，重启 Claude Code。

## 用户安装后能做什么

`travel-itinerary-redesign` 这个 skill 主要用于：

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

每次更新前，至少检查：

1. [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json) 里的版本号
2. [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json) 里的版本号
3. [`skills/travel-itinerary-redesign/SKILL.md`](./skills/travel-itinerary-redesign/SKILL.md) 是否仍与 references 一致
4. [`agents/openai.yaml`](./agents/openai.yaml) 是否仍与当前 skill 行为一致
5. 如条件允许，先在 Claude Code 本地跑一次 plugin 测试

## 版本变动

### v0.4.0 (2026-04-20)

**新功能：**
- **当地手信/特产推荐** — 新增参考文件 `local-specialties.md`，含证据选品标准、4 级评分体系（signature / recommended / niche / skip）、海关和运输约束提示、输出卡片格式。特产推荐嵌入每日行程卡片中对应购买地点附近。
- **旅游攻略数据源** — 新增参考文件 `travel-sources.md`，定义中国平台（马蜂窝、携程、去哪儿、小红书、大众点评、飞猪、12306）和国际平台（TripAdvisor、Klook、Lonely Planet、Trip.com、Condé Nast Traveler、Booking.com、Google Maps 等）的交叉验证规则和引用格式。
- **数据可追溯约束** — 所有事实性推荐（价格、时刻表、评分、酒店名、店铺名）必须标注来源和查询日期，禁止编造具体信息。

**优化（Darwin Skill 11 轮优化，总分 86.0 → 93.15）：**
- 明显路线（如上海→杭州高铁）不再阻塞询问交通偏好，直接推荐主要方式并列出替代选项
- intake 批量化：缺 3 个以上核心输入时批量提问；模糊请求自动提供目的地灵感
- 预算超标 15% 时触发确认检查点
- 用户约束互相矛盾时明确暴露冲突并提供优先级选项
- 临时出行（48 小时内）fallback：跳过订票窗口建议，优先实时渠道
- 缓冲时间量化：附近（~1 km / 步行 10 分钟）vs 跨区（需换乘 / >1 km）vs 带行李（+10–15 分钟）
- 步骤 10 验证从「检查截图」改为具体 HTML 验证标准（375px 视口、断链检查）
- 工作流编号连续化（1–11）
- Editing Rules 去重；Final Check 改为引用式校验
- hotel-selection.md 和 transportation.md 的证据标准统一引用 travel-sources.md

### v0.3.0 (2026-04-19)

- 插件版本升级
- 新增语言自动检测，支持多语言输出
- 修复插件安装：移除 manifest 中不支持的 agents 字段

### v0.2.0 (2026-04-18)

- 新增行前准备（签证、支付、SIM 卡、保险）
- 预订规则与 J-person 严谨度
- Mode-Specific Scope 表格
- 酒店推荐具体性增强
- Frontmatter 触发词
- 跨文件交通规则去重
- 全面的交通规划体系

### v0.1.0 (2026-04-17)

- 初始版本：按日行程工作流
- Plugin-first 仓库结构
- 支持 Claude Code 和 Codex 安装

## 参考文档

- Codex skills docs: [developers.openai.com/codex/skills](https://developers.openai.com/codex/skills)
- Claude Code discover/install plugins: [code.claude.com/docs/en/discover-plugins](https://code.claude.com/docs/en/discover-plugins)
- Claude Code create plugins: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)
- Claude Code plugin marketplaces: [code.claude.com/docs/en/plugin-marketplaces](https://code.claude.com/docs/en/plugin-marketplaces)
- Claude Code plugins reference: [code.claude.com/docs/en/plugins-reference](https://code.claude.com/docs/en/plugins-reference)
