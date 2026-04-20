# Hotel Selection

## Purpose

Recommend hotels that are actually usable for the trip, not just popular on paper.

## Inputs To Use

- Destination
- Travel dates
- Budget
- Trip purpose
- Party size
- Room style if needed

## Evidence Standard

- Prefer hotels that appear repeatedly in mainstream travel guides or have strong ratings on Trip.com, Airbnb, Google Maps, and major OTAs.
- Do not rely on a single source when the choice is important.
- If the evidence is weak, label the hotel as avoid or omit it.

## Tiering

- `mass-market`: practical, broad appeal, reliable value
- `recommended`: strongest fit for most users
- `niche`: good but only for a specific use case
- `avoid`: weak rating, bad location, poor value, or booking friction

## Price Guidance

- State nightly rates as ranges (e.g., "¥400–¥650/night"), not single numbers.
- Always specify currency.
- Note what the range covers: room type (standard double, twin, suite), breakfast inclusion, refund policy.
- Label prices with source and research date (e.g., "Trip.com, checked 2026-04-18").
- If comparing across budget tiers, include total stay cost (nightly rate × nights) so the user sees the real spend.

## Output Card Format

For each hotel, present these fields in a compact card or table row:

1. **Name and tier**: e.g., "Hotel ABC — `recommended`"
2. **Area**: neighborhood or landmark proximity
3. **Transit convenience**: distance and time to the main transport hub (station, airport) and to key attractions
4. **Nightly rate range**: with currency, room type, and source
5. **Budget fit**: within / stretch / over budget
6. **Why this tier**: one sentence on the key strength or weakness
7. **Verdict**: `first pick`, `backup`, `niche`, or `avoid`

Keep cards compact. Use tables or chip-style labels, not paragraphs.

## Comparison Format

When presenting multiple options across budget tiers, use a comparison table:

| Hotel | Tier | Area | Nightly Rate | Transit | Verdict |
|---|---|---|---|---|---|
| (name) | recommended | (area) | ¥X–¥Y | (minutes to hub) | first pick |
| (name) | mass-market | (area) | ¥X–¥Y | (minutes to hub) | backup |

Put the recommended first pick at the top of each budget group.

## Presentation Rule

- Keep hotel recommendations short and scannable.
- Put the best option first in each budget group.
- Keep only a few strong options per tier — 2-3 per budget group is enough.
