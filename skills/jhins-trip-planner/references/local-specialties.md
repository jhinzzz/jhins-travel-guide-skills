# Local Specialties and Souvenirs

## Purpose

Recommend destination-specific souvenirs and local specialties (手信/特产) that are genuinely unique to the area, widely recognized in travel guides, and practical to bring home.

## Scope

Covers: iconic food specialties, artisan crafts, local snacks, regional beverages (tea, wine, spirits), cultural souvenirs, and seasonal limited items.

Does not cover: generic airport duty-free goods, mass-produced tourist trinkets with no local identity, or items with import/customs restrictions unless flagged.

## Evidence Standard

- Only recommend specialties that appear repeatedly across mainstream travel sources (see [travel-sources.md](travel-sources.md) for the full source list).
- Cross-reference ≥2 independent sources per [travel-sources.md](travel-sources.md) §Evidence Principle before labeling an item as a "must-buy" or "signature" specialty.
- Never fabricate brand names, shop names, prices, or availability — if data is unavailable, state "verify locally" and mark as approximate.
- Label each recommendation with the source and research date (e.g., "小红书 + 马蜂窝, checked 2026-04").
- Prefer items sold at well-known, established shops or official outlets over random vendors.

## Selection Criteria

Recommend items that meet **all three** conditions:

1. **Local identity**: the item is strongly associated with the destination — not something available everywhere.
2. **Travel-guide consensus**: the item appears in at least two reputable travel sources as a recommended purchase.
3. **Practicality**: the item can be reasonably transported home (weight, fragility, shelf life, customs compliance).

### Tiering

Each tier is an AND-list, not a vibe (same discipline as [hotel-selection.md](hotel-selection.md) §Tiering). An item earns a tier only if it meets every condition.

- `signature`: strong local identity **AND** ≥2 reputable-source consensus **AND** reasonably transportable home — the item a traveler would regret not bringing back. Mirrors the dining "destination signature" idea ([dining-rules.md](dining-rules.md) §12): the edible signatures of a place often have a take-home form (a 章鱼烧 snack pack, a ramen gift box, a regional tea) — surface that bridge when it exists.
- `recommended`: local identity **AND** ≥1 source **AND** transportable — a good gift or personal purchase, not quite the must-bring.
- `niche`: local identity **AND** ≥1 source **AND** appeals only to a specific interest (tea enthusiasts, craft collectors, foodies) — name the single interest.
- `skip`: no real local identity **OR** overpriced tourist trap **OR** poor quality-to-price **OR** widely available elsewhere.

"Weak evidence" (promote no further than `niche`, or omit): <2 sources for a "must-buy" claim, or no verifiable shop/price.

### Seasonal Availability

Some signatures are only sold in season — and a traveler who plans around them and arrives off-season is let down.

- Flag season-bound items against the **trip date**: fresh seasonal produce (matcha-new-tea spring, regional fruit windows), festival-only or holiday-limited editions, harvest-timed goods (new-crop rice, first-flush tea, seasonal sake).
- If a signature item is out of season for the trip date, say so and offer the year-round form if one exists (e.g. fresh seasonal sweet → its shelf-stable version), rather than recommending something unbuyable.
- Do not present a season-limited item as always-available — state the window with a source.

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

Trigger: shortlist exceeds **5 candidate specialties** (typical when the destination has multiple well-known categories — tea + silk + crafts + snacks, etc.). Run the fan-out per SKILL.md §Batch Verification — slicing axis: by category or sub-region.

Per-item return fields: **tier · shop or outlet · address · current price range · customs / transport flag · source URLs · research date**.

Domain-specific rule: the main conversation synthesizes the rows into the recommended / signature / niche / skip buckets and embeds them into the relevant day cards.

## Search Advisory Fallback

When web search is unavailable or verification fails for specific shop names, brands, or prices, output a search advisory card per [knowledge-layers.md](knowledge-layers.md) §5 instead of fabricating or omitting. Category-level guidance (what type of specialty to look for, general price expectations, transport constraints) remains Reasoning Layer and can be output directly.

## Non-Goals

- Do not recommend items without evidence from reputable travel sources.
- Do not assume availability or pricing — always mark with research date.
- Do not recommend customs-restricted items without a clear warning.
- Do not pad the list with generic items that have no local identity.
- Do not prioritize expensive items — value-for-money matters.
- Do not present a season-limited specialty as always-available — flag the window against the trip date per §Seasonal Availability.
