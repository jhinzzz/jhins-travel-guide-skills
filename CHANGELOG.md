# Changelog

记录 jhins-trip-planner 这个 skill 的迭代轨迹。每个版本回答两个问题：**改了什么**、**为什么改**。最新版本在最上面。

版本号遵循 semver 的精神：
- `0.x.0` — 新增覆盖面或结构性重构
- `0.x.y` — 小补丁，不改用户感知的行为

## [0.6.3] — 2026-04-22

### Added

- `.gitignore` — 显式声明 `session-learnings-*.md`（个人会话笔记）和 `.omc/`（工具生成目录）不进 git。取代"靠遗忘不 track"的软约束。
- `FUTURE.md` 第 1 条补一句说明：`test-prompts.json` 的 `rule_refs` 字段是"给人看的注释"而非机器 assertion，`check-links.sh` 不扫 JSON。避免未来把这些引用误当成 harness 依赖。

### Why

来自 v0.6.0-v0.6.2 的 `/review` pre-landing 审查发现的 3 条 informational — mechanical fix，一并 bump。

## [0.6.2] — 2026-04-22

### Added

- `VERSION` 文件、本 `CHANGELOG.md`、`FUTURE.md` — 建立版本化机制。SKILL.md 顶部显示当前版本号。
- CHANGELOG 向前回溯到 v0.3.0（从 git log 挖掘）。
- FUTURE.md 记录 5 个"条件触发的未来方向"（自动化测试 / thresholds.json / destinations/ 拆分 / triggers 矩阵 / agent 化），每一项带触发条件。

### Why

基础设施而非规则改动。skill 已从"一堆规则"进入"有版本、有历史、有未来"的阶段，这三个文件是配套。

## [0.6.1] — 2026-04-22

### Added

- `scripts/check-links.sh` — bash 脚本，扫描所有 skill 包，验证跨文件引用一致性：每个 `[text](file.md)` 指向真实存在的文件、每个 `§Anchor` 匹配目标文件里的 heading、孤立的 reference 文件给出 warning。零依赖，pure bash + POSIX 工具，1 秒内跑完。
- Smart anchor 解析：能正确区分 "`(dining-rules.md) §5 for how they combine with meal`" 里的 anchor 是 `§5` 而不是整句续写。

### Why

`v0.6.0` 把 `planning-rules.md` 拆成三个文件，跨文件引用从不到 10 条变成 30+ 条。手动维护失效率太高，需要自动化。

## [0.6.0] — 2026-04-22

### Added

- **Accessibility 捕获**：`intake.md §6` — 轮椅 / 透析 / 机舱氧气 / 孕期 / 服务动物 / 过敏 carry-forward，每类在 hotel / attraction / transport 下游卡片必须显式 resolve，不再"later verify"。
- **儿童年龄分段**：`intake.md §7` — 0-2 / 3-5 / 6-9 / 10-14 / 15-17 五段，每段对应不同的 attraction / 住宿 / 餐厅约束。替代之前笼统的 "young children"。
- **转机签证盲区**：`trip-prep.md §2` — US 无 sterile transit、香港 24/72/168h、迪拜 stopover、新加坡 VFTF、Schengen ATV-required 国家。
- **联程行李冲突**：`transportation.md` — piece-vs-weight 制式冲突、self-transfer 时间预算、免税液体重新安检、cabin-bag 规格不匹配。
- **气候偏移风险**：`weather-and-output.md §1` — 欧洲夏季热浪、樱花前移、晚季台风、北美野火烟霾、珊瑚季节紊乱。使用 seasonal averages 时必须加免责声明。
- **伦理旅游守则**：`safety-and-emergency.md §6` — 圈养野生动物 / 孤儿院 voluntourism / 长颈族拍照 / 海龟接触 等 7 类默认重定向。
- **宗教节日扩展**：`trip-prep.md §6` — Ramadan 之外补 Holi / Songkran / Shabbat / Buddhist Lent，每个 "situation → specific action" 格式。
- **跟团 vs 自由行决策**：`weather-and-output.md §4` — 7 个触发跟团建议的条件 + 4 个保持独立行的场景。
- **支付实操摩擦**：`trip-prep.md §3` — 中国 / 日本 / 冰岛 / 德奥 / 印度 / 阿根廷 / 美国 destination-specific 摩擦点。
- **最小可用 brief 门槛**：`intake.md §2` — destination + dates + party + budget 四项齐备就可以进入细节规划，pace/theme 有默认不阻塞。
- **Capture relevance rule**：`intake.md` 顶部 — 无关的 capture 不要机械地追问（两个成人不问 accessibility、不带儿童不问年龄段）。
- **Peak-period pre-trip recheck 覆盖 planning-only**：SKILL.md Mode-Specific Scope 新增一行，堵住国内五一 / 十一等场景的系统性漏洞。

### Changed

- **SKILL.md 瘦身 44%**（331 → 190 行）。新增 North Star + Navigation 表。规则细节下沉到对应 reference，SKILL.md 只保留 pointer。
- **拆 `planning-rules.md`** (205 行 trash-can) 成三个专门文件：
  - `intake.md` (142 行) — §1-§10 编号，capture + carry-forward
  - `trip-prep.md` (108 行) — §1-§7 编号，visa + payment + SIM + insurance + etiquette + safety-pointer
  - `weather-and-output.md` (70 行) — weather + output + downstream pointers + independent-vs-guided
- **test-prompts.json 结构化**：从散文 `expected` 改为机器可检查的 `assertions` 字段（13 个 case，每个有 mode / must_contain / must_cite_source_for / rule_refs 等字段）。

### Why

原 skill review 发现三类问题：(1) SKILL.md 32KB 过胖，LLM 读到 Final Check 时规则疲劳；(2) 覆盖盲区（accessibility / 伦理 / 转机 / 气候 / 多样支付）会在真实 trip 上被踩；(3) test-prompts 是散文不可做回归。这版一次性解决。

## [0.5.2] — 2026-04-22

### Added

- **Safety & Emergency 模块** — `safety-and-emergency.md`：紧急号码 / 医疗接入 / 领事馆（含"部分号码禁令"）/ 保险理赔路径 / 盗抢流程 / destination-specific 风险。
- **Local Etiquette** — `planning-rules.md §Local Etiquette`：8 类 situation → action 格式的红线（着装 / 小费 / 脱鞋 / 摄影 / 公共行为 / 问候 / 讨价还价 / 宗教节日）。
- **多国多城并行子 agent 模式** — 2+ 国 / 2+ 城自动触发 parallel verification。
- **慢性药合规捕获** — intake 阶段抓 generic 名，进入并行 prep 查 per-country legality。

## [0.5.1] — 2026-04-21

### Added

- **自驾 planning hardening** — 三要素 intake（驾照有效性 / 驾驶侧 / 每日驾驶上限）+ 每日驾驶卡三字段（距离 · 时长 · 最长单段）+ 高德/Google Maps 路书 app 指定 + 低信号区段强制离线地图下载。

## [0.5.0] — 2026-04-21

### Added

- **Dining rules** — 专门的 `dining-rules.md`：品类矩阵跨天去重 / 运营状态实时核验 / target-date 营业日历 / 行政区一致性 / 四字段餐厅卡 / 10 分钟步行半径 / 预订渠道 + 提前量 / peak 出发前复查块 / 餐厅替换级联 / 批量并行核验。
- 重命名 skill 为 `jhins-trip-planner`（原名 `travel-itinerary-redesign`）。

## [0.4.0] — 2026-04-20

### Added

- **Local specialties** — `local-specialties.md`：三段式筛选 / signature · recommended · niche · skip 分级 / 海关与运输约束 / 产地附近的购物嵌入日程。
- **Travel sources** — `travel-sources.md`：canonical 数据源清单（平台 × 用途对应表）+ 引用格式 + 评分门槛。
- **Data traceability hard constraint** — 所有价格 / 时刻 / 评分 / 可用性必须 cite source + research date，never 编造具体航班号 / 车次 / 店名。

## [0.3.0] — 2026-04-20

### Added

- 首个版本号化 release。前面的内容包括：intake 顺序、hotel selection、transport 基础规则、mode-specific scope 表、多语言自动检测。
- 开源协议改为 MIT（之前短暂用过 CC BY-SA 4.0）。

## 更早（无版本号）— 2026-04-19 至 2026-04-20

- 最初的 `travel-itinerary-redesign` skill：规划三模式（planning-only / guide-redesign / existing-page-refactor）+ 天气感知 + intake 基础问题顺序 + skill plugin 结构。
