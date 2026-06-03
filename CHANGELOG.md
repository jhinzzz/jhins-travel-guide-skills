# Changelog

[English / CHANGELOG_EN.md](./CHANGELOG_EN.md)

记录 jhins-trip-planner 这个 skill 的迭代轨迹，每个版本说明**改了什么**。最新版本在最上面。

版本号遵循 semver 的精神：
- `0.x.0` — 新增覆盖面或结构性重构
- `0.x.y` — 小补丁，不改用户感知的行为

## [0.14.0] — 2026-06-03

### Added

- **抓取渠道阶梯：JS 渲染 + 抗指纹渲染层 — `travel-sources.md §Login-Wall Fallback`** — 渠道顺序从两档（静态抓取 → 搜索聚合器 snippet）升级为四档能力阶梯：① 静态抓取（无 JS）② JS 渲染无头浏览器 ③ 抗指纹渲染 ④ 搜索聚合器（保底）。按能力分层描述，不点名具体工具，缺某档的环境跳到下一档。
- **test-prompts.json case 25** — channel-ladder JS-render 层回归测试。

### Changed

- **`deep/dining-rules.md §2`** — 明示 Google Maps 横幅需 JS 渲染才可达；静态抓取失败时横幅缺失为 non-signal，不得读成"营业中"。
- **`hotel-selection.md §Progressive Search` + §Timeout Degradation** — "价格不可达"fallback 加前置：先爬渲染档再判定；Timeout Degradation 表加守则：静态抓取空白/302 不计入降级触发次数。
- **`travel-sources.md` Case A / Case B 重构** — Case A 放宽为任意阶梯档拿到的活页都算 §2 验证；Case B 为所有可达档都被墙才走 snippet 弱档，"Maps 横幅不可达"限定到静态档。
- **`knowledge-layers.md §6` exhaustion gate** — 升级为"先爬渠道阶梯（JS/抗指纹渲染档），再 ≥2 channels（≥1 聚合器）"。
- **FUTURE.md §8** — authenticated-fetch 方向标注为"部分被 v0.14.0 render 档覆盖"；§1 测试用例计数 24→25。
- **SKILL.md / VERSION / plugin.json / marketplace.json** — 0.13.0 → 0.14.0。

## [0.13.0] — 2026-06-03

### Added

- **跨海峡 / 大中华通行证（不是签证）— `trip-prep.md §2` + `deep/trip-prep.md`** — 主文件 §2 加一条 bullet：大陆↔台湾、港澳↔台湾、大陆↔港澳用通行证 + 签注，不是旅游签证；列出触发口岸对，办理周期当签证周期在 intake 提示。深度文件加 `§Cross-Strait Greater China Permits` 完整矩阵（自由行/跟团口径、回程台胞证/回乡证）。
- **脆弱旅客温泉/热浴安全 — `safety-and-emergency.md §6` + deep §6** — 新增"脆弱旅客热暴露"规则（小孩 + 老人/心血管 + 复用既有孕妇 ≥40°C 注），按 risk→trigger→action 写：短时间、最凉的池、脸红/头晕立刻出水、补水、显示场馆张贴的年龄下限/时长上限。不写死儿童水温/分钟阈值。触发条件挂"行程里出现温泉"。
- **灾害 / 闭店状态复查 — `safety-and-emergency.md §6` + deep §6** — 新增规则：按具体信号触发（具名景点震后状态 / 官方预警窗口 / weather §1 季节灾害窗口），通过政府旅游局/国家公园管理局/灾害机构复查官方闭店状态，出发前 3–5 天，并入已有出发前复查块（dining §8）。
- **test-prompts.json case 21–24** — 21 跨海峡通行证、22 儿童温泉安全、23 太鲁阁震后灾害复查、24 集成案例。

### Changed

- **SKILL.md §Final Check** — 零新增 invariant（19 条不变）：onsen carry-forward 并入既有 Intake carry-forward 行；灾害复查改写既有 Pre-trip recheck 行的触发条件。
- **intake.md §7 Child carry-forward rule** — 加"行程出现温泉 → 带入 safety §6 热浴安全"挂钩。
- **FUTURE.md** — 修正 §2 第41行措辞；写入 `destinations/` 迁移触发器；§1 测试用例计数 19→24。
- **SKILL.md / VERSION / plugin.json / marketplace.json** — 0.12.1 → 0.13.0。

## [0.12.1] — 2026-06-02

### Fixed

- **snippet 级 §2 门槛重构为 Case A / Case B** — 修正过严的 snippet 门槛：
  - **Case A（先判）** — 匿名抓取权威平台（Tabelog/点评）拿到 name+rating+price+ward 即算 §2 验证，正常引用、不加"非活页"限定、不跑聚合器门槛。
  - **Case B（权威页被挡）** — 第①条放宽为"一个权威来源的 snippet 或 ≥2 个独立聚合器命中"。
- **§2 信号#3"Google Maps 关停横幅"对匿名抓取不可达 → 明示** — 门槛改为"用可达渠道做最强关停检查，并标注残余不确定性"。
- **hotel-selection.md §Progressive Search 补"价格拿不到"分支** — name+area+rating 齐全但无价时，价格字段标 `价格需登录查询`，而非丢弃候选或编造数字。
- **test-prompts.json case 20** — 同步重构为 Case A / Case B 断言。

### Changed

- **SKILL.md / VERSION / plugin.json / marketplace.json** — 0.12.0 → 0.12.1。

## [0.12.0] — 2026-06-02

### Added

- **`travel-sources.md` §Login-Wall Fallback — snippet 级 §2 证据门槛** — 活页被登录墙挡住时，靠聚合器快照放行一家餐厅必须四条全满：①≥2 个聚合器给出同一店名+地址 ②快照显示当年/近期活跃 ③任一快照无停业词 ④店名与地址行政区一致（§4）。放行后带可见限定 `（经聚合器快照核实，非活页）`；不满足则降级为搜索建议卡。
- **国际平台对称覆盖** — §Login-Wall Fallback 触发条件从"中国平台登录墙"泛化为访问失败模式（登录墙 / 302 / 空白 / captcha / cookie 同意墙 / 限流 / 地域封锁），适用于 Booking.com / TripAdvisor / Google Maps / Tabelog。
- **test-prompts.json case 20**（`international-login-wall-snippet-bar`）— 东京惠比寿居酒屋场景，模拟 Tabelog 302 + Google Maps 同意墙。

### Changed

- **渠道顺序归一（去重）** — 把 `§Login-Wall Fallback` 定为唯一权威来源：Source-Selection 表行与 `knowledge-layers.md §6` 改为指针；DuckDuckGo 单元格改为工具无关措辞。
- **SKILL.md / VERSION / plugin.json / marketplace.json** — 0.11.0 → 0.12.0。

## [0.11.0] — 2026-05-30

### Added

- **`travel-sources.md` §Login-Wall Fallback (Search Aggregators)** — 新增一类来源：通用搜索聚合器（DuckDuckGo HTML 端点 / Bing），标注为 retry 渠道（底层数据仍归属原平台），不是 primary source。
- **`knowledge-layers.md` §6 Exhaustion gate（穷尽闸）** — 新增硬规则：单平台登录墙 / 302 / 超时 / 空白 ≠ search failed；降级为搜索建议卡前必须先试 ≥2 个渠道（≥1 个搜索聚合器）。两条 hotel flow 的 `IF search fails` 分支同步改写。
- **`dining-rules.md` §11 反合理化表 + red flag** — 钉死两个借口，并加 STOP red-flag：写餐厅搜索建议卡前自问试了几个渠道、有没有聚合器。
- **`dining-rules.md` §3 营业时段闸** — 新增"开门时段必须覆盖排入的餐段"。
- **test-prompts.json case 19**（`login-wall-exhaustion-gate`）— 顺德午餐场景，模拟点评 302 + 高德登录墙。
- **provenance.md** — 新增缺失的 `knowledge-layers.md` 段，登记 case 19 的 anchor 覆盖。

### Changed

- **SKILL.md §Fallback Rules（Web verification stalls）** — 补充"登录墙 / 302 / 空白 ≠ 失败，先经 §6 穷尽闸用聚合器 retry 再降级"。
- **SKILL.md Version** — 0.10.0 → 0.11.0（VERSION / plugin.json / marketplace.json 同步）。

## [0.10.0] — 2026-05-26

### Added

- **`references/knowledge-layers.md`** — 双层知识架构：Reasoning Layer（客观推理，可用训练数据）vs Local Knowledge Layer（具体名称/价格，必须 web 验证或降级）。包含：
  - §2 Bright-line test（命名实体/具体数字 = Local Knowledge）
  - §3 Per-category degradation rules（strict: 餐厅/菜品/票价 · tolerated: 酒店/特产店/景点名）
  - §4 Destination matching framework（7 个客观维度，无具体名称）
  - §5 Search advisory card template（平台 + 关键词 + 筛选 + 判断标准 + 避坑）
  - §6 Behavior flows（4 种用户场景的完整决策路径）
- **hotel-selection.md §Progressive Search** — 两阶段渐进式酒店搜索：Phase 1 单平台侦察 → Phase 2 用户确认后才交叉验证。
- **hotel-selection.md §Timeout Degradation** — 3 次连续 WebFetch 失败 OR 单酒店搜索超 3 分钟 → 自动降级为搜索建议卡。
- **dining-rules.md §11** — Search advisory fallback：web search 不可用时输出搜索建议卡，保持 §2 absolute ban。
- **local-specialties.md §Search Advisory Fallback** — 同 pattern：验证失败时输出搜索建议卡。
- **test-prompts.json cases 16-18** — (16) 国内目的地推荐无 web search；(17) 酒店搜索超时降级；(18) 用户提供酒店名验证流程。

### Changed

- **SKILL.md Navigation** — 新增 knowledge-layers.md 行。
- **SKILL.md §Data Traceability** — 加 progressive search 引用 + Local Knowledge 降级指向。
- **SKILL.md §Intake** — destination-inspiration 流程指向 knowledge-layers.md §4。
- **SKILL.md §Fallback Rules** — hotel 和 specialty 降级条目加搜索建议卡指向。
- **SKILL.md §Final Check** — 新增 Knowledge layers 审计行。

## [0.9.0] — 2026-05-25

### Changed

- **SKILL.md description 重写** — 从 workflow-summary 格式改为 "Use when..." 触发条件格式。
- **trip-prep.md 瘦身 -55%** — Transit Visa Rules / Practical Payment Friction / Religious and Festival Sensitivities 的展开移入新建 `references/deep/trip-prep.md`；主文件保留 Rule statement + trigger pointer + 一行摘要。
- **intake.md §6-§7 瘦身 -60%** — Accessibility 6 类详细说明 + Child Age Bands 5 段展开移入新建 `references/deep/intake.md`；主文件保留精简列表/表格 + carry-forward rule + deep pointer。
- **SKILL.md deep-references 段** — 更新文件列表（+intake.md, +trip-prep.md）和 depth trigger 示例。

### Added

- **`references/deep/trip-prep.md`** — transit visa 国家细节、destination-specific 支付摩擦 7 国、宗教节日 situation→action 全文。
- **`references/deep/intake.md`** — accessibility/medical-needs 6 类全量说明 + child age-bands 5 段全量约束表。
- **test-prompts.json case 15** — `hotel-selection-multi-tier`：京都 3 天 2 晚住宿推荐，覆盖 hotel-selection.md 的 5 个 anchor。
- **provenance.md** — hotel-selection.md 段从 "_No cases_" 更新为 case 15 的 5 个 anchor 覆盖。
- **FUTURE.md §5** — 新增 "Attractions / activities reference" 方向 + 触发条件。

## [0.8.0] — 2026-04-23

### Changed

- **主 reference 文件瘦身** — 三个最胖的文件压缩 -45%：
  - `budget.md`: 88 → 52 行（-40%）
  - `dining-rules.md`: 190 → 110 行（-42%）
  - `safety-and-emergency.md`: 205 → 104 行（-49%）
  - 所有 anchor 保留。
- **引入 `references/deep/` opt-in 子目录** — 被瘦身掉的深度内容全部迁到 `references/deep/{budget,dining-rules,safety-and-emergency}.md`，只在主 reference pointer 命中 depth trigger 时才读。
- **SKILL.md 增加 "Deep references (opt-in)" 说明段**（3 行，放在 Navigation 后）。
- `scripts/check-size.sh` 增加 deep/ 子目录检查 + 放宽阈值（> 400 warn / > 500 error）。
- `FUTURE.md` 重写 —— 从"5 条条件触发的技术未来"改为战略定位 + 生态 roadmap：专精领域通过独立 skill + trigger 词路由实现。

## [0.7.2] — 2026-04-23

### Added

- **`references/budget.md`** — 新增 4 节预算 reference。
  - §1 按 region band 的类目占比默认表（东亚 / 中国+SEA / 西欧 / 北欧冰岛 / 美国 / 中东 / 南亚SEA 乡村，7 档本币占比），每档 6 个类目（交通/住宿/餐饮/景点/购物/buffer）。
  - §2 Hidden costs 清单 situation→line item 格式：入境离境税、小费层、IC 押金、FX 手续费、DCC 陷阱、免税液体、自驾隐藏成本、旺季溢价、归国关税。
  - §3 Refundable vs non-refundable 决策：7 个买 refundable 触发（老人 / 孕晚期 / 低龄娃 / 风险窗 / 待签 / 窄连接 / 商务）+ 4 个跳过场景（单人 / 短低风险 / 本身灵活多段 / 溢价超 20% 时买保险更划算）。
  - §4 FX & payment timing：锁汇 / 持币不换 / 卡走网络汇 / 付现 / 拒绝 DCC 五档决策，按目的地稳定性分。
- SKILL.md Navigation 加一行；Core Workflow §3 改为引用 budget.md §1；Final Check 的 budget 行从"present"升级为四项审计（band · hidden costs · refundable · FX）。
- `test-prompts.json` 新增 case 14（阿根廷 10 天 + 预算紧 + FX 敏感），同时覆盖 budget.md 4 节。`provenance.md` 同步加 budget.md 段 + case 14 的 trip-prep §3 和 Fallback Rules 引用。

## [0.7.1] — 2026-04-23

### Fixed

- **Plugin 元数据版本漂移** — `.claude-plugin/plugin.json` 和 `.claude-plugin/marketplace.json`（两处）从 `0.5.2` 统一到 `0.7.1`。

### Added

- **Release hygiene 三件套** —— 四个 check：
  - `scripts/check-version.sh` — VERSION 与 SKILL.md、plugin.json、marketplace.json 版本号必须一致，漂移即退 1。
  - `scripts/check-size.sh` — SKILL.md > 250 行 → error；reference/*.md > 220 行 → warn，> 260 行 → error。
  - `scripts/check-all.sh` — 聚合跑 `check-links.sh` / `check-provenance.sh` / `check-version.sh` / `check-size.sh`。
- README / README_CN 的 Release checklist 指向 `scripts/check-all.sh`。

### Added

- **规则溯源机制（Rule Provenance）**
  - `scripts/check-provenance.sh` — 校验 `test-prompts.json` 里每个 case 的 `rule_refs` 锚点真实指向规则文件里的 heading。零依赖，有 jq 时走 jq 快路径。
  - `skills/jhins-trip-planner/references/provenance.md` — 反向索引（rule → 覆盖它的 cases）。
  - SKILL.md 顶部 meta 行加 provenance.md 指针。
  - FUTURE.md §1（自动化测试）更新。

## [0.6.4] — 2026-04-22

### Changed

- SKILL.md §Confirmation Checkpoints 加 batching rule：intake 阶段多个 checkpoint 可合并问（最多 3 个，按 legal/safety > scheduling > preference 排优先级）；mid-flight checkpoint（预算超标、餐厅替换、pace/theme 冲突）仍必须**逐个**问。
- dining-rules.md §3 peak list 补 Eid al-Fitr / al-Adha：`Middle East Ramadan (daytime closures) + Eid al-Fitr / al-Adha (2–4 day public holidays, date shifts by moon sighting, many venues closed or on special hours)`。原本只写了 Ramadan。

## [0.6.3] — 2026-04-22

### Added

- `.gitignore` — 显式声明 `session-learnings-*.md`（个人会话笔记）和本地生成的缓存目录不进 git。
- `FUTURE.md` 第 1 条补一句说明：`test-prompts.json` 的 `rule_refs` 字段是给人看的注释而非机器 assertion，`check-links.sh` 不扫 JSON。

## [0.6.2] — 2026-04-22

### Added

- `VERSION` 文件、本 `CHANGELOG.md`、`FUTURE.md` — 建立版本化机制。SKILL.md 顶部显示当前版本号。
- CHANGELOG 向前回溯到 v0.3.0。
- FUTURE.md 记录 5 个条件触发的未来方向（自动化测试 / thresholds.json / destinations/ 拆分 / triggers 矩阵 / agent 化）。

## [0.6.1] — 2026-04-22

### Added

- `scripts/check-links.sh` — bash 脚本，扫描所有 skill 包，验证跨文件引用一致性：每个 `[text](file.md)` 指向真实文件、每个 `§Anchor` 匹配目标文件 heading、孤立 reference 文件给出 warning。
- Smart anchor 解析。

## [0.6.0] — 2026-04-22

### Added

- **Accessibility 捕获**：`intake.md §6` — 轮椅 / 透析 / 机舱氧气 / 孕期 / 服务动物 / 过敏 carry-forward，每类在 hotel / attraction / transport 下游卡片必须显式 resolve，不再"later verify"。
- **儿童年龄分段**：`intake.md §7` — 0-2 / 3-5 / 6-9 / 10-14 / 15-17 五段，每段对应不同的 attraction / 住宿 / 餐厅约束。
- **转机签证盲区**：`trip-prep.md §2` — US 无 sterile transit、香港 24/72/168h、迪拜 stopover、新加坡 VFTF、Schengen ATV-required 国家。
- **联程行李冲突**：`transportation.md` — piece-vs-weight 制式冲突、self-transfer 时间预算、免税液体重新安检、cabin-bag 规格不匹配。
- **气候偏移风险**：`weather-and-output.md §1` — 欧洲夏季热浪、樱花前移、晚季台风、北美野火烟霾、珊瑚季节紊乱。使用 seasonal averages 时必须加免责声明。
- **伦理旅游守则**：`safety-and-emergency.md §6` — 圈养野生动物 / 孤儿院 voluntourism / 长颈族拍照 / 海龟接触 等 7 类默认重定向。
- **宗教节日扩展**：`trip-prep.md §6` — Ramadan 之外补 Holi / Songkran / Shabbat / Buddhist Lent，每个 "situation → specific action" 格式。
- **跟团 vs 自由行决策**：`weather-and-output.md §4` — 7 个触发跟团建议的条件 + 4 个保持独立行的场景。
- **支付实操摩擦**：`trip-prep.md §3` — 中国 / 日本 / 冰岛 / 德奥 / 印度 / 阿根廷 / 美国 destination-specific 摩擦点。
- **最小可用 brief 门槛**：`intake.md §2` — destination + dates + party + budget 四项齐备即可进入细节规划，pace/theme 有默认不阻塞。
- **Capture relevance rule**：`intake.md` 顶部 — 无关的 capture 不机械追问（两个成人不问 accessibility、不带儿童不问年龄段）。
- **Peak-period pre-trip recheck 覆盖 planning-only**：SKILL.md Mode-Specific Scope 新增一行。

### Changed

- **SKILL.md 瘦身 44%**（331 → 190 行）。新增 North Star + Navigation 表，规则细节下沉到 reference，SKILL.md 只保留 pointer。
- **拆 `planning-rules.md`** 成三个专门文件：
  - `intake.md` (142 行) — §1-§10 编号，capture + carry-forward
  - `trip-prep.md` (108 行) — §1-§7 编号，visa + payment + SIM + insurance + etiquette + safety-pointer
  - `weather-and-output.md` (70 行) — weather + output + downstream pointers + independent-vs-guided
- **test-prompts.json 结构化**：从散文 `expected` 改为机器可检查的 `assertions` 字段（13 个 case）。

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

### Changed

- 11 轮内部 skill 质量迭代后的一批综合优化（下列条目）：
  - 明显路线（上海→杭州高铁这类）不再阻塞询问交通偏好，直接给主要方式 + 替代。
  - Intake 批量化：缺 3 个以上核心输入时批量提问；模糊请求自动提供目的地灵感。
  - 预算超标 15% 触发确认检查点。
  - 约束冲突时显式暴露 + 提供优先级选项。
  - 临时出行（48h 内）fallback：跳过订票窗口，优先实时渠道。
  - 缓冲时间量化：附近（~1 km / 10 min）vs 跨区（>1 km / 换乘）vs 带行李（+10-15 min）。
  - 输出验证从"检查截图"改为具体 HTML 验证标准（375px 视口、断链）。
  - 工作流编号连续化（1-11）。
  - Editing Rules 去重；Final Check 改为引用式校验。
  - `hotel-selection.md` 和 `transportation.md` 的证据标准统一引用 `travel-sources.md`。

## [0.3.0] — 2026-04-19

### Added

- 首个版本号化 release。前面的内容包括：intake 顺序、hotel selection、transport 基础规则、mode-specific scope 表、多语言自动检测。
- 开源协议改为 MIT（之前短暂用过 CC BY-SA 4.0）。

## [0.2.0] — 2026-04-18

### Added

- 完整行前准备（签证 / 支付 / SIM / 保险）。
- 预订规则与 J-person 严谨度。
- Mode-Specific Scope 表格。
- 酒店推荐具体性增强。
- Frontmatter 触发词。
- 跨文件交通规则去重。
- 完整的交通规划体系。

## [0.1.0] — 2026-04-17

### Added

- 初始 skill：按日行程工作流。
- Plugin-first 仓库结构。
- 支持 Claude Code 和 Codex 安装。

## 更早（无版本号）— 2026-04-19 至 2026-04-20

- 最初的 `travel-itinerary-redesign` skill：规划三模式（planning-only / guide-redesign / existing-page-refactor）+ 天气感知 + intake 基础问题顺序 + skill plugin 结构。
