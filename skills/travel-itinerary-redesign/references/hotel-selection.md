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

- Prefer hotels that appear repeatedly in mainstream travel guides or have strong ratings on major OTAs. See [travel-sources.md](travel-sources.md) for the canonical source list and which platforms to use for hotel research.
- Cross-reference at least two independent sources for hotel recommendations (e.g., Booking.com + TripAdvisor, or Ctrip + Google Maps).
- Cite the source and research date for every price and rating claim (e.g., "Booking.com, checked 2026-04").
- Do not rely on a single source when the choice is important.
- If the evidence is weak, label the hotel as avoid or omit it.

## Tiering

- `mass-market`: practical, broad appeal, reliable value
- `recommended`: strongest fit for most users
- `niche`: good but only for a specific use case
- `avoid`: weak rating, bad location, poor value, or booking friction

## Check-In, Check-Out, and Luggage

- Standard check-in: 14:00–15:00. Standard check-out: 10:00–12:00. Varies by hotel — always verify.
- Early arrival (before check-in): note whether the hotel offers luggage storage at the front desk so the user can explore before the room is ready.
- Late departure (after check-out): note whether the hotel offers luggage storage post-checkout and until what time. This directly affects departure-day planning.
- If the arrival transport lands early morning (before 10:00) or the departure transport leaves late evening (after 20:00), flag the gap and recommend a luggage plan:
  - Hotel front desk storage (most common, usually free)
  - Station/airport coin lockers (Japan, Europe — note size limits and cost)
  - Commercial luggage storage services (e.g., LuggAgent, Bounce)
- Early check-in and late check-out may be available for an extra fee or via loyalty status — note if applicable.

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
