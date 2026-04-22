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

每次更新前，至少检查：

1. [`.claude-plugin/plugin.json`](./.claude-plugin/plugin.json) 里的版本号
2. [`.claude-plugin/marketplace.json`](./.claude-plugin/marketplace.json) 里的版本号
3. [`skills/jhins-trip-planner/SKILL.md`](./skills/jhins-trip-planner/SKILL.md) 是否仍与 references 一致
4. [`agents/openai.yaml`](./agents/openai.yaml) 是否仍与当前 skill 行为一致
5. 如条件允许，先在 Claude Code 本地跑一次 plugin 测试

## 版本变动

### v0.5.2 (2026-04-22)

安全、礼仪、多国行前准备严谨度加固 — 目的地无关，并打通 intake 到输出的追溯链路。

**新功能：**
- **安全与应急参考文件**（`safety-and-emergency.md`）— 每趟行程的统一安全板块：目的地特有紧急号码（警察 / 消防 / 救护 / 旅游警察）、每座城市至少一家游客友好医院、本国驻该城使领馆 + 非工作时间应急热线、保险理赔路径（不只是购买）、护照 / 卡 / 手机 / 行李丢失的分步应对、目的地特定风险改写为**风险 → 具体触发点 → 具体操作**。
- **电话号码禁残缺** — 使领馆和医院电话必须完整已核实，或者留空并附显式「→ 出发前到官方网站核实：{URL}」。禁止 `+81-3-xxxx-xxxx` 这类看起来像真号码的骨架占位，否则紧张时容易被误读。
- **更安全场所选择的权威平台规则** — 风险缓解涉及挑餐厅 / 挑运营商 / 挑出租车点时，必须引用目的地权威平台（迪拜用 DTCM 认证名单；罗马餐饮用 Gambero Rosso / TheFork / Dissapore；东京用 Tabelog；中国内地用大众点评），不能无差别默认 TripAdvisor。
- **当地礼仪与文化规范进入 intake** — `planning-rules.md` §Trip Preparation 新增：着装（清真寺 / 寺庙 / 米其林）、按区域的小费规范、脱鞋规则、拍照禁令（京都祇园 / 宗教场所室内 / 中东机场与军事区）、公共场合行为红线（PDA / 公共饮酒 / 头 / 脚 / 左手）、讨价还价礼仪、节庆敏感度（斋月 / 安息日 / 泰国佛诞节）。每条都改写为**场景 → 具体动作**。
- **pace / 主题 / 可变节日 新增 Confirmation Checkpoint** — `SKILL.md` 新增 4 个 intake 阶段确认点：pace 与每日密度不符；多主题冲突；pace × adventure 子强度正交冲突（例：`leisurely` + 日出登山必须按日拆分）；斋月 / 可变宗教节日窗口重叠（起草餐饮 / 礼仪前先核实该年的具体日期）。
- **adventure 子强度 intake** — 用户选 `adventure & outdoor` 时，必须捕获单日强度上限（日出登山 / 全日徒步 / 开放水域潜水 / 多段攀岩 / 白水漂流），因为它们会覆盖名义 pace，不可互换。
- **慢性病药物 intake** — 长期处方药在 intake 阶段就以**通用名**（非品牌名）捕获，并传递给 Trip Preparation 并行行 schema，让各国合法性标识（日本 / 阿联酋 伪麻黄素受限；日本 ADHD 兴奋剂非法；阿联酋 / 新加坡 可待因 / 曲马多受限）在起草前就浮现 — 安全板块绝不再次追问。
- **未成年人跨境** — `planning-rules.md` §Visa and Entry 捕获单亲 / 非亲属陪同未成年人的公证同意书 / 翻译出生证 / 领事认证要求（高敏感目的地：阿联酋 / 沙特 / 南非 / 墨西哥 / 部分欧盟成员国），在 intake 阶段提出而不是到机场才发现。
- **多国 / 多城的并行验证** — 凡行程跨 ≥ 2 国，自动按国分 spawn 2 个并行子 agent，返回结构化行（签证 + 办理时长 · 入境要求 · 主要货币 + 主流支付 · SIM / eSIM 建议 · 礼仪红线 · 慢性药合法性标识 · 未成年人文件标识 · 源 URL · 研究日期）。凡跨 ≥ 2 城，安全板块按城 spawn 2–3 个子 agent。酒店候选 > 4 家、特产候选 > 5 项也进入并行验证。
- **可变宗教节日日历权威源** — `travel-sources.md` 新增阿联酋月相委员会、沙特 Umm al-Qura 日历、以色列宗教事务部、泰国佛诞节日历作为年份特定的权威源（月相宣布可能最后一刻 ±1 天）。
- **DTCM 认证导游 / 运营商名单** — `travel-sources.md` 新增迪拜经济与旅游部认证名单，作为迪拜沙漠越野 / 导游团选择的主源。

**优化：**
- Final Check 新增 intake-carry-forward 审计（慢性药通用名 → Trip Prep 行 → Safety §2；未成年人文件在 intake 提出；斋月 / 可变节日日期起草前已从官方源核实）。
- Final Check 新增 Pace & theme 检查项（每日密度与 pace 一致；主题冲突起草前已解决；adventure 子强度按日已协调）。
- 旺季复查块统一在 `dining-rules.md` §3 单点维护，其他文件只引用（不再在多处重复列旺季清单）。
- Fallback Rules 把 Web 验证阈值统一合并为一张表（餐厅 / 酒店 / 特产 / 交通 / 安全领事）。
- `test-prompts.json` 新增 3 条 v0.5.2 场景：id:11（巴厘岛 adventure + wellness pace-theme 冲突）、id:12（日韩泰春节多国 + 慢性病）、id:13（迪拜斋月 + 8 岁女儿）。

### v0.5.1 (2026-04-21)

自驾规划严谨度加固 — 目的地无关，对标 dining-rules 的严谨度模型。

**新功能：**
- **每个自驾日的路书 App** — `transportation.md` §Rental Car / Self-Drive 明确规定导航 App：中国大陆自驾用 **高德地图（Amap）** 作为路书；其他地区用 **Google Maps**，覆盖薄弱或被屏蔽的区域给出区域替代（俄罗斯 Yandex / 韩国 Naver / Kakao / Waze 等）。每日驾驶段存为多点收藏路线；低信号路段（冰岛高地 / F-roads、美国国家公园、澳洲内陆、青藏高原、偏远海岸）**强制预下载离线地图**。
- **自驾 intake 三要素** — `planning-rules.md` §Intake 新增：用户选择自驾时必须确认 (1) **驾照在目的地是否有效**（中国大陆不认外国和国际驾照；日本需 JAF 翻译件）；(2) **驾驶侧**（LHD vs RHD，首次换向建议短途适应首日）；(3) **单日驾驶时长上限**（默认 6h 成年单人；带老人 / 儿童 / 孕妇 / 宠物 4–5h；高海拔或山路 3–4h）。
- **自驾 Fallback 分支** — `SKILL.md` Fallback Rules 新增 4 个自驾边界场景：驾照在目的地无效；长段低 / 无信号（强制预下载离线地图 + 提前加油）；首次对向车道驾驶（首日短途适应，不是最长转场）；同行脆弱群体或山路 / 高海拔（下调单日上限）。
- **自驾日卡片三字段** — 每个驾驶日必带 **总里程（km）· 总驾驶时长 · 最长连续驾驶段**，对标餐厅卡的四字段（`dining-rules.md` §5）。三字段必须落在 intake 上限内；否则拆日或减一站。
- **自驾超标确认 checkpoint** — 当驾驶日三字段超过 intake 上限时触发显式用户确认，与预算超 15%、餐厅替换级联、旺季复查 并列为一等 Confirmation Checkpoint。
- **离线地图下载进入行前清单** — `planning-rules.md` §Communication 新增：跨低 / 无信号路段的行程需把离线地图下载写进行前清单。

**优化：**
- Final Check 新增 `Self-drive` 验证项（intake 已捕获 · 日卡片三字段 · App 已命名 · 离线地图已入清单）。
- `Minimal Output Shape`、`guide-redesign` 块、`Default Page Shape` 都列出自驾卡片字段，输出契约更明确。
- `test-prompts.json` 新增两条自驾场景：id:9（川西国内自驾 + 带父母）、id:10（冰岛环岛国际自驾 + LHD→RHD 换向）。

### v0.5.0 (2026-04-21)

基于一次真实的日本黄金周行程规划过程中发现的问题，本次把经验沉淀为**与目的地无关的通用规则**，日本 / 欧洲 / 美国 / 中国相关内容仅作为同一原则下的举例，以确保 skill 仍是一个通用旅行技能，而不是日本专用指南。

**新功能：**
- **餐饮规则参考文件** (`dining-rules.md`) — 目的地无关的餐厅推荐规则：跨天跨餐的品类矩阵（全程品类去重）、运营状态核实（按目的地语言识别闭店 / 休业 / 搬迁 / 重建公告，Google Maps 的 "Permanently closed" 作为统一兜底）、目标日期日历（每周定休 + 目的地特有旺季闭店）、地址与区/街区一致性、餐次×品类×区域精确输入、预订渠道与提前量、替换后的级联更新。
- **餐厅量化标准** — 按平台分别定义评分底线（Tabelog 的压缩标尺 ≥ 3.45/3.55/3.80；大众点评 ≥ 4.5；TripAdvisor ≥ 4.0；Google Maps ≥ 4.3；以及 TheFork / Yelp / OpenRice / Zomato 等本地权威平台的等效线）。人均价格档次（Value / Mid / High）始终使用**本地货币**，按目的地消费水平校准，而不是固定一套 JPY 区间。
- **并行子 agent 验证协议** — 凡涉及 ≥5 家餐厅/酒店/景点的批量验证，默认起 2-3 个并行子 agent，每个返回结构化表格（营业状态 · 地址 · 定休日 · 旺季备注 · 预约方式 · 源 URL）。
- **旺季出发前 3-5 天复查块** — 行程如与目的地特有旺季重合（示例：日本 GW / 盂兰盆 / 新年；中国春节 / 国庆 / 五一；欧洲圣诞 / 复活节 / 八月假期；美国感恩节 / 圣诞；中东斋月），文末固定输出"出发前复查清单"，按名字 + 目标日期列出所有不定休 / 定休日 / 可能旺季休業 风险餐厅。

**优化：**
- 数据可追溯强化：增加「不信任训练数据里的餐厅」硬约束 — 所有推荐餐厅必须核实当前运营状态。
- 食物偏好 intake 精确化：餐次 × 品类 × 区域 三要素同时绑定。"X 或 Y" 的品类请求要产出两条主线候选，不做合并。
- 新增替换级联检查点：任何餐厅 / 酒店 / 锚点景点替换后，执行 §9 级联（每日卡片 + 详情卡 + 出发前复查块 + 导航锚点 + 品类矩阵），并向用户确认。
- 餐厅卡片四字段强制：品类 · 平台评分 · 距锚点步行时间 · 本地货币人均价位。
- 新增 Web 验证 fallback：WebFetch 失败或餐厅 ID 指向搬迁店时，不猜测不静默丢弃 — 先换源重试，否则升级到并行子 agent 批量验证。
- 测试集新增了覆盖日本 GW 与欧洲圣诞的双案例，避免旺季严谨度只在日本场景下被验证。

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
