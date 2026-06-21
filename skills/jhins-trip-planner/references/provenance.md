# Provenance

Reverse index: **which test case exercises which rule**. Each entry points from a rule anchor to the `test-prompts.json` case(s) that cover it.

## Why this file exists

规则改动前先在这里查"谁在测它"。如果你要修改 `dining-rules.md §5` 的 per-restaurant card 字段，本文件会告诉你 case 6 / 7 / 8 依赖它——回归要过这三条。

反之，**没有被引用的规则**（表格里不出现的 heading）意味着它缺少 case 覆盖。那是加测试的信号，不是删规则的信号——很多规则是为了避免罕见灾难存在的（参考 `safety-and-emergency.md §3` 残缺电话禁令）。

## How to maintain

- 新增/修改 `test-prompts.json` 的 `rule_refs` 后，手动更新下面的表格。
- `scripts/check-provenance.sh` 会校验 `rule_refs` 里的锚点真实存在，但**不**校验本文件是否同步——这是文档，不是机器契约。
- Anchor 写法和 `test-prompts.json` 的 `rule_refs` 一致（`§Foo` / `§1` / `§§1-10` / `§Foo (parenthetical)`）。

## Index

### SKILL.md

| Anchor | Cases |
|---|---|
| §Classify The Task First | 2 |
| §Confirmation Checkpoints | 11 |
| §Confirmation Checkpoints (Ramadan) | 13 |
| §Data Traceability | 5 |
| §Fallback Rules (Missing dates/destination) | 3, 14 |
| §Fallback Rules (Web verification stalls) | 19 |
| §Intake (destination-inspiration pointer) | 16 |

### intake.md

| Anchor | Cases |
|---|---|
| (whole file) | 3 |
| §3, §4 | 11 |
| §6, §7 | 22 |
| §8 | 9 |
| §10 | 26, 27 |

### trip-prep.md

| Anchor | Cases |
|---|---|
| (whole file) | 5 |
| §1 | 12 |
| §2 | 21, 24 |
| §3 | 14 |
| §6 | 13 |

### weather-and-output.md

| Anchor | Cases |
|---|---|
| §2 | 1, 2 |

### transportation.md

| Anchor | Cases |
|---|---|
| §Evidence Standard | 1 |
| §Rental Car / Self-Drive | 9, 10 |

### dining-rules.md

| Anchor | Cases |
|---|---|
| §1 | 1 |
| §2 | 8, 19, 20, 25 |
| §3 (Spring Festival / New Year peak) | 5 |
| §4 | 20 |
| §8 | 23, 24 |
| §9 | 8 |
| §10 | 8 |
| §11 | 19, 20 |
| §§1-10 | 6, 7 |

### budget.md

| Anchor | Cases |
|---|---|
| §1 | 14 |
| §2 | 14 |
| §3 | 14 |
| §4 | 14 |

### hotel-selection.md

| Anchor | Cases |
|---|---|
| §Evidence Standard | 15 |
| §Tiering | 15 |
| §Output Card Format | 15 |
| §Check-In / Check-Out and Luggage | 15 |
| §Comparison Format | 15 |
| §Progressive Search | 25 |
| §Timeout Degradation | 25 |
| §Hardware vs Service | 26 |
| §Hardware-Freshness Signal | 15, 26, 27 |
| §Recency-Weighted Reviews | 26 |
| §Hardware Weighting | 17, 26, 27 |

### local-specialties.md

| Anchor | Cases |
|---|---|
| §Evidence Standard | 1 |
| §Selection Criteria | 4 |
| §Integration with Daily Itinerary | 4 |
| §Customs and Transport Constraints | 2, 10 |

### safety-and-emergency.md

| Anchor | Cases |
|---|---|
| (whole file) | 5 |
| §3 (partial number ban) | 13 |
| §6 | 11 |
| §6 (DTCM vetting) | 13 |
| §6 (thermal-immersion safety) | 22, 24 |
| §6 (disaster closure-status recheck) | 23, 24 |
| §9 | 12 |

### knowledge-layers.md

| Anchor | Cases |
|---|---|
| §2 (bright-line test) | 16 |
| §3 (tolerated policy for hotels) | 17 |
| §4 (destination matching) | 16 |
| §5 (search advisory card) | 16, 17 |
| §6 (user-supplied hotel name flow) | 18 |
| §6 (exhaustion gate) | 19, 20, 25 |

### travel-sources.md

| Anchor | Cases |
|---|---|
| §Per-Person Price Tiers | 7 |
| §Source Selection Rules | 23 |
| §Login-Wall Fallback (Search Aggregators) | 19, 20, 25 |
| §Reading OTA Listings for Hardware Condition | 26 |

### deep/dining-rules.md

| Anchor | Cases |
|---|---|
| §2 | 25 |

### deep/trip-prep.md

| Anchor | Cases |
|---|---|
| §Cross-Strait Greater China Permits | 21, 24 |

### deep/safety-and-emergency.md

| Anchor | Cases |
|---|---|
| §6 | 22, 23 |

## Case index (for looking up what a case exercises)

See `test-prompts.json` — every case carries its own `rule_refs` list.
