# Local Specialties and Souvenirs

## Purpose

Recommend destination-specific souvenirs and local specialties (手信/特产) that are genuinely unique to the area, widely recognized in travel guides, and practical to bring home.

## Scope

Covers: iconic food specialties, artisan crafts, local snacks, regional beverages (tea, wine, spirits), cultural souvenirs, and seasonal limited items.

Does not cover: generic airport duty-free goods, mass-produced tourist trinkets with no local identity, or items with import/customs restrictions unless flagged.

## Evidence Standard

- Only recommend specialties that appear repeatedly across mainstream travel sources (see [travel-sources.md](travel-sources.md) for the full source list).
- Cross-reference at least two independent sources before labeling an item as a "must-buy" or "signature" specialty.
- Never fabricate brand names, shop names, prices, or availability — if data is unavailable, state "verify locally" and mark as approximate.
- Label each recommendation with the source and research date (e.g., "小红书 + 马蜂窝, checked 2026-04").
- Prefer items sold at well-known, established shops or official outlets over random vendors.

## Selection Criteria

Recommend items that meet **all three** conditions:

1. **Local identity**: the item is strongly associated with the destination — not something available everywhere.
2. **Travel-guide consensus**: the item appears in at least two reputable travel sources as a recommended purchase.
3. **Practicality**: the item can be reasonably transported home (weight, fragility, shelf life, customs compliance).

### Tiering

- `signature`: iconic specialty with strong consensus — most travelers should consider it.
- `recommended`: well-regarded local item, good gift or personal purchase.
- `niche`: appeals to specific interests (tea enthusiasts, craft collectors, foodies).
- `skip`: overpriced tourist trap, poor quality-to-price ratio, or widely available elsewhere.

## Customs and Transport Constraints

Flag these for international trips:

- Fresh food, meat, dairy, seeds, plants — often prohibited or restricted at customs.
- Liquids over 100ml — must go in checked luggage for flights.
- Alcohol — duty-free limits vary by country (typically 1–2 liters).
- Cultural artifacts or antiques — may require export permits.
- Weight and fragility — note if the item is heavy or breakable and suggest packing tips.

If an item has customs risk, state it explicitly: "Check destination customs rules before purchasing."

## Where to Buy

For each recommended specialty, note:

- **Established shops or official outlets** preferred over generic souvenir stores.
- **Location**: neighborhood, street, or landmark proximity — ideally near an itinerary stop.
- **Price range**: stated as a range with currency (e.g., "¥30–¥80/box").
- **Operating hours**: if known and relevant (some shops close early or have rest days).
- **Source**: where this shop recommendation comes from (e.g., "大众点评 4.8 stars, 马蜂窝 recommended").

## Output Card Format

For each specialty item, present:

1. **Item name**: local name with translation if needed (e.g., "西湖龙井 (West Lake Longjing Tea)")
2. **Tier**: `signature` / `recommended` / `niche` / `skip`
3. **What it is**: one sentence — what makes it special and local
4. **Where to buy**: recommended shop or area, with address if available
5. **Price range**: with currency and source
6. **Transport notes**: weight, fragility, shelf life, customs flags
7. **Best for**: gift / personal use / foodie / collector
8. **Source**: research sources and date

Keep cards compact and scannable. Use tables for comparison when listing multiple items.

## Comparison Format

When presenting multiple specialties for a destination:

| Item | Tier | Price Range | Best For | Transport Notes |
|---|---|---|---|---|
| (name) | signature | ¥X–¥Y | gift | shelf-stable, lightweight |
| (name) | recommended | ¥X–¥Y | foodie | refrigerate, check customs |

## Integration with Daily Itinerary

- Embed shopping recommendations into the relevant day card, near the geographic location where the shop is.
- If a specialty shop is near a planned attraction or restaurant, note the proximity.
- For departure day, flag any last-minute purchase opportunities near the hotel or station.
- Do not create a separate "shopping day" unless the user requests it — weave purchases into the natural flow.

## Parallel Verification for Specialty Shortlists

When the shortlist exceeds **5 candidate specialties** (typical when the destination has multiple well-known categories — tea + silk + crafts + snacks, etc.), verification runs as a batch.

- Spawn **2–3 parallel sub-agents**, each covering a category or sub-region.
- Each sub-agent returns a structured row per item: **tier · shop or outlet · address · current price range · customs / transport flag · source URLs · research date**.
- The main conversation synthesizes the rows into the recommended / signature / niche / skip buckets and embeds them into the relevant day cards.

This follows the same batch-verification pattern as [dining-rules.md](dining-rules.md) §10.

## Non-Goals

- Do not recommend items without evidence from reputable travel sources.
- Do not assume availability or pricing — always mark with research date.
- Do not recommend customs-restricted items without a clear warning.
- Do not pad the list with generic items that have no local identity.
- Do not prioritize expensive items — value-for-money matters.
