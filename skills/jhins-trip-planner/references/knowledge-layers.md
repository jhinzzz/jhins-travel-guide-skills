# Knowledge Layers

## Purpose

Prevent the skill from outputting unverifiable local knowledge as if it were fact. Split all travel information into two layers with different trust rules, and provide graceful degradation when verification is unavailable.

## 1. Two Layers

| Layer | Content | Trust Rule | Output Behavior |
|---|---|---|---|
| **Reasoning** | Destination selection, climate/season logic, budget allocation, schedule/pace, transport mode comparison, party-fit analysis, general infrastructure characterization | May reason from training data + objective facts | Direct output with reasoning shown |
| **Local Knowledge** | Hotel names, restaurant names, dishes, specialty shops, attraction names, ticket prices, ratings, addresses, operating status | MUST have web search evidence OR degrade to search advisory | Verified output with citation, OR search advisory card |

## 2. Bright-Line Test

If removing a claim would require deleting a **named entity** or a **specific number** (price, rating, count), it belongs to the Local Knowledge Layer.

General characterizations without names or specific numbers are Reasoning Layer.

- Reasoning: "这个区域度假酒店比较密集"
- Local Knowledge: "这个区域有万豪和希尔顿"
- Reasoning: "配套设施比较成熟"
- Local Knowledge: "有5家五星级酒店"

## 3. Per-Category Degradation Rules

Two policies govern what happens when web search evidence is unavailable:

| Policy | Categories | Behavior when unverified |
|---|---|---|
| **Strict** | Restaurants, dishes, ticket prices | NEVER output from training data. Output search advisory card only. No "approximate" labeling permitted. |
| **Tolerated** | Hotels, specialty shops, attraction names | May output with prominent "unverified / approximate" label + search advisory card alongside. Well-known landmarks (UNESCO, national-level) may use Reasoning Layer with "widely documented" note. |

The strict policy for restaurants preserves [dining-rules.md](dining-rules.md) §2 absolute ban. The strict policy for ticket prices reflects that prices change frequently and training data is unreliable.

## 4. Destination Matching Framework

For "推荐个地方" / "有什么建议" flows, use **objective dimensions only**:

| Dimension | Source | Example |
|---|---|---|
| Distance / travel time | Reasoning (geography is stable) | "深圳到阳江自驾约3.5h" |
| Climate / weather in target period | Reasoning (seasonal patterns) | "6月粤西沿海30°C+，偶阵雨" |
| Transport accessibility | Reasoning (infrastructure) | "有高铁直达 vs 需自驾" |
| Destination type | Reasoning (geography/nature) | "海岛 / 海湾 / 山区 / 古城" |
| Infrastructure maturity | Reasoning (general knowledge) | "度假酒店密集区 vs 新开发" |
| Peak-period crowd level | Reasoning (holiday patterns) | "端午热门近郊 vs 相对冷门" |
| Party-fit signals | Reasoning (objective logic) | "3岁小孩→需要儿童池/平坦沙滩" |

**NOT in destination matching:** specific hotel names, restaurant names, dishes, prices. These belong to the Local Knowledge Layer.

Output format:

```
## [目的地名] — [一句话定位]

**客观条件：**
- 距离：[从出发地的交通方式和时间]
- 气候：[目标时段的天气概况]
- 交通：[到达方式]
- 类型：[海岛/海湾/山区等]
- 设施成熟度：[高端酒店多/少，配套完善/一般 — 无具体名称]
- 节假日人流：[热门/适中/冷门]

**适合你的原因：**
- [基于party composition和需求的匹配逻辑]

**不确定的部分（需要你验证）：**
- [具体酒店选择 → 搜索建议]
- [当地美食 → 搜索建议]
```

## 5. Search Advisory Card

When Local Knowledge cannot be verified, output a search advisory card instead of fabricating or punting:

```
### 🔍 [类别] 搜索建议

**平台：** [最适合的搜索平台，如携程/大众点评/小红书]
**关键词：** [具体搜索词]
**筛选条件：**
- [条件1，如：评分4.5+]
- [条件2，如：带"儿童泳池"标签]
- [条件3，如：价格区间]
**判断标准：** [怎么从搜索结果里挑好的]
**避坑提示：** [常见的坑]
```

For `planning-only` mode, use a compact variant (platform + keywords + top 2 filters only).

## 6. Behavior Flows

### Exhaustion gate (read before degrading)

A single platform returning a **login wall / 302 redirect / timeout / blank result is NOT a search failure** — it only means *that platform* won't serve *that rung* of the channel ladder. A blank/chrome result from a static (no-JS) fetch usually means the content is script-rendered, not absent: a JS-rendering rung recovers it, and the same datum is also re-indexed by search aggregators (full ladder in [travel-sources.md](travel-sources.md) §Login-Wall Fallback).

Before degrading any Local Knowledge item to a search advisory card, you must have **climbed the channel ladder**: tried the more capable rungs the environment offers (JS-rendering / fingerprint-resistant render, when available) and, at minimum, **≥2 channels one of which is a search aggregator**. Only after the reachable rungs all fail to surface a verifiable datum may you output the advisory card — and it must state which channels were tried and why each failed.

The search advisory card is a **last resort**, not the default response to the first login wall. "Platform needs login → I can't verify → advisory card" is a forbidden shortcut: the login wall blocks the platform's *own* page, not the aggregator-indexed copy.

```
User: "推荐个地方"
  → Reasoning Layer: destination matching (objective dimensions only)
  → Output: 2-3 destinations with objective comparison
  → DO NOT output specific hotels/restaurants/dishes

User: "就去X吧，有什么酒店推荐？"
  → Attempt web search (progressive per hotel-selection.md)
  → IF search succeeds: output verified hotel cards
  → IF a platform is login-walled/blank: retry via aggregator (≥2 channels) per exhaustion gate above
  → IF aggregator retry ALSO fails: output search advisory card (last resort, list channels tried)
  → NEVER output hotel names from training data without verification

User: "推荐个地方，顺便看看有什么好酒店"
  → Complete destination matching FIRST (Reasoning Layer)
  → Present destinations; ask user to confirm choice
  → THEN address hotels per Local Knowledge Layer rules
  → Do NOT conflate the two layers in one response

User: "我听说X酒店不错，帮我看看"
  → Name came from user, not training data
  → Attempt web search to VALIDATE (exists? open? ratings? price?)
  → IF search confirms: output hotel card with verified data
  → IF a platform is login-walled: retry via aggregator (≥2 channels) per exhaustion gate above
  → IF aggregator retry ALSO fails: "我没能验证这家酒店的信息" + search advisory
  → NEVER embellish user-supplied names with unverified details
```

## 7. Integration

Other reference files point here for search advisory format and layer rules:

- [hotel-selection.md](hotel-selection.md) — progressive search + timeout degradation → search advisory card
- [dining-rules.md](dining-rules.md) — §2 absolute ban + search advisory when web search unavailable
- [local-specialties.md](local-specialties.md) — search advisory when evidence unavailable
