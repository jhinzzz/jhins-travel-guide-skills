# Future Directions

不是 roadmap，是"未来可能想做的事情 + 当时为什么没做"。每一项都有明确的**什么条件下值得做**触发器。

## 1. 自动化测试 `test-prompts.json`

**现状**：`test-prompts.json` 里有 13 个 case，每个有机器可检查的 assertions，但**没有东西真在跑**。

**想做成什么样**：脚本 / Node / Python，用 Anthropic SDK 拿每个 prompt 跑一遍 skill，对输出做两类断言：
- `grep-level`（机械可验）：`must_contain "往返高铁"`、`must_not_contain_literal "G7501"`
- `judge-level`（LLM-as-judge）：`must_have_section "pre-trip recheck block"`、`rule_refs` 被正确追溯

**为什么现在没做**：
- 13 个 case × 每个 case 20-50 次 tool call × 每月多次跑 = 几十美元/月。对个人 skill 投入产出比不对。
- Judge-level assertion 用 LLM 验证 LLM，信号/噪声比不高，会被漂移。
- 现在规则改动用"我自己拿 1-2 case 手测 + PR review"更划算。

**注意**：`test-prompts.json` 的 `rule_refs` 字段（如 `"intake.md §6"`）的锚点**已经**被 `scripts/check-provenance.sh` 校验（v0.7.0），同时 `references/provenance.md` 提供"rule → 谁在测它"的反向索引。自动化 harness 真开始做时，ground truth（case → 期望行为 → 对应规则）已经结构化就绪，不需要再建语料库。

**什么时候值得做**：
- skill 被 10+ 个人常用，或用于商业产品
- 某次回归引入明显 bad output 让人真的痛（到那时 test harness 的价值就明显）
- Anthropic 推出便宜的 batch/eval API（例如 $0.01 per full case）

## 2. `thresholds.json` 集中数字阈值

**现状**：数字阈值散落在多个文件里：
- Tabelog rating floor（`dining-rules.md`）: 3.45 / 3.55 / 3.80
- Daily driving ceiling hours（`intake.md`）: 6 / 4-5 / 3-4
- Budget overage threshold（`SKILL.md`）: 15%
- Dining batch threshold（`dining-rules.md`）: ≥5 venues → parallel
- Per-person price tiers（`travel-sources.md`）: 本地货币 value / mid / high

**想做成什么样**：一个 `references/thresholds.json`，所有数字阈值集中在里面，规则文件里**引用键名**而不是 hardcode 数字。例：

```json
{
  "tabelog_rating_floor": { "casual": 3.45, "sushi_highend": 3.55, "michelin": 3.80 },
  "driving_hours_ceiling": { "default": 6, "with_elderly": 4.5, "high_altitude": 3.5 },
  "budget_overage_confirm_threshold": 0.15,
  "parallel_sub_agent_triggers": { "dining": 5, "hotels": 4, "specialties": 5, "safety_cities": 2, "prep_countries": 2 }
}
```

**为什么现在没做**：
- LLM 读规则时从 .md 读和从 .json 读差别不大
- 阈值现在改动不频繁
- 增加一层间接性 = 增加认知负担

**什么时候值得做**：
- 做 A/B test 想看"如果 Tabelog 阈值调到 3.50 会怎样"
- 阈值要按用户 tier 或年份分化（日本本地人门槛 vs 外国游客门槛）
- 有多个 skill 共享同一组数字（现在只有一个）

## 3. `destinations/` 按国家维度拆分

**现状**：目的地相关规则散落各处：
- 日本支付小店拒卡（`trip-prep.md`）
- 日本驾照需要 JAF 翻译（`intake.md`）
- 日本紧急号码（`safety-and-emergency.md`）
- 日本 Tabelog（`travel-sources.md`）
- 日本黄金周 / O-Bon（`dining-rules.md` + `trip-prep.md`）

**想做成什么样**：`references/destinations/japan.md`、`china.md`、`iceland.md` 等，每个国家文件**自包含**该国的支付 / 驾照 / 礼仪 / 节日 / 紧急 / 签证信息。

**为什么现在没做**：
- 目前覆盖 ~10 国，分文件的收益没到
- 规则仍然跨国家（"Schengen 成员都适用"），强行按国家拆会破坏这种抽象
- 对一个新国家加支持的成本仍然可控

**什么时候值得做**：
- 覆盖 >25 个国家
- 某国的规则量自己就到 100+ 行（日本已经快了）
- 用户请求"只对某国做深度 review"（需要专门 context）

## 4. "Destination triggers" 矩阵

**现状**：`intake.md` 顶部的 "Capture Relevance Rule" 用文字描述——"ask X only when destination/party triggers it"。LLM 要读完规则再判断。

**想做成什么样**：一份 `triggers.yaml`：

```yaml
accessibility:
  trigger_if_party_mentions: [wheelchair, dialysis, pregnancy, service_animal, epipen]
  destination_amplifier: [maldives, iceland, machu_picchu]  # 这些地方更可能 unmeetable
festival_overlap:
  ramadan:
    destinations: [UAE, Saudi_Arabia, Egypt, Indonesia, Malaysia]
    check_if_dates_in: "annual moon-sighting window"
self_drive_triad:
  trigger_if_user_says: [self-drive, rental_car, road_trip, 自驾]
```

**为什么现在没做**：
- 正确编码这个矩阵比写文字更复杂（组合爆炸）
- LLM 读 yaml 和读 bullet list 本质差不多
- 现在触发逻辑 bug 不多，投入修它不划算

**什么时候值得做**：
- 触发逻辑出过 2+ 次 false negative（该 ask 没 ask）
- skill 接入工作流需要机器读 triggers（例如提前静态分析用户 prompt）

## 5. 产品化：变成"可对话的旅行规划 agent"

**现状**：纯静态 skill（.md 规则 + 文件结构），每次 invoke 从 SKILL.md 开始。

**想做成什么样**：
- 保留规划历史，用户回来接着改"把第 3 天酒店换成海景"
- 接 real-time API：航班 / 酒店 / Google Maps / 当地天气直接查而不是让用户 verify
- 产出可交互的 HTML（不只是静态页），用户直接点 swap

**为什么现在没做**：
- 从 skill 跳到 "agent + backend + 前端" 是完全另一个工程
- 真实 API 成本 / API key 管理 / rate limit 一起上
- 要先确认基础 skill 本身规则足够好，否则再加 integrations 只是把 shit 工业化

**什么时候值得做**：
- skill 在个人用途被反复使用、每次都觉得"要是能 X 就好了"
- 要给朋友/家人分享、他们不会每次手动 invoke

---

## 记录原则

- 只记**条件触发的未来**，不记"应该做的通用 todo"。
- 每一项必须能回答"什么情况下做"，没答案就是现在应该做（直接做，别记这里）。
- 删掉已经做完的条目，不做"完成归档"——git log 就是归档。
