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

## Check-In / Check-Out and Luggage

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

## Progressive Search (Default Flow)

Hotel verification uses a two-phase progressive approach to avoid long search times:

### Phase 1: Scout (single platform, 2-3 minutes)

- Pick the best platform for the destination per [travel-sources.md](travel-sources.md) (e.g., Ctrip for China domestic, Booking.com for international).
- Search for 3-5 candidates matching the user's constraints (area, budget, party).
- Present **scout cards** (reduced fields): name · area · nightly rate range · platform rating · source.
- **Climb the channel ladder before declaring price unreachable.** A blank Booking / price-hidden Ctrip from a *static* fetch is usually a JS-render or headless-fingerprint block, **not** a login wall — climb [travel-sources.md](travel-sources.md) §Login-Wall Fallback: a JS-rendering rung, then (for OTAs that silently degrade on a headless fingerprint) a fingerprint-resistant render rung, recovers OTA listings + nightly prices with no credentials. Only after the available render rungs fail does price count as genuinely unreachable.
- **Partial-scout fallback (price still unreachable after the ladder):** nightly rate is the field platforms most often withhold from a static fetch. A scout that has name + area + rating but **no verifiable price** is still useful — present it with the rate field marked `价格需登录查询 / price requires login — verify on booking` rather than dropping the candidate or inventing a number. Do **not** backfill a price from a single stale or wrong-currency aggregator snippet. A scout missing *only* price is not a verification failure; only escalate to the Timeout Degradation advisory card when name **and** rating are also unobtainable.
- Ask user to pick 1-2 hotels for deep verification.

### Phase 2: Deep Verify (cross-reference, only on user's picks)

- Cross-reference the user's chosen hotel(s) on a second platform.
- Fill in the full 7-field output card: name+tier · area · transit · rate · budget fit · why · verdict.
- Add check-in/out + luggage info.

This eliminates 80% of wasted verification: only user-selected hotels get full treatment.

## Timeout Degradation

If hotel search stalls at any phase, degrade to a search advisory card per [knowledge-layers.md](knowledge-layers.md) §5. **First climb the channel ladder** ([travel-sources.md](travel-sources.md) §Login-Wall Fallback): a static-fetch blank/302 is a rung to climb (render rungs, then aggregator), not a "failure" to count toward degradation. The triggers below count only failures that persist *after* the available rungs are exhausted, mirroring the [knowledge-layers.md](knowledge-layers.md) §6 exhaustion gate.

| Trigger | Action |
|---|---|
| 3 consecutive WebFetch failures for the same hotel | Degrade that hotel to search advisory card |
| Single hotel search exceeds 3 minutes of active fetching | Degrade to search advisory card |
| All candidates in Phase 1 fail | Output search advisory card for the entire hotel category |

Never continue searching indefinitely. Never require the user to manually terminate.

When degrading, output the search advisory card with: platform + keywords + filters specific to the user's stated constraints (area, budget, party composition).

## Parallel Verification for Hotel Shortlists

When the shortlist exceeds **4 candidates** (typical when the trip spans multiple cities, or when the user wants options across 3 budget tiers), verification runs as a batch — not serial WebFetch calls in the main conversation.

- Spawn **2–3 parallel sub-agents**, each covering a slice of the shortlist (by city, by budget tier, or by platform).
- Each sub-agent returns a structured row per hotel: **current nightly rate range · rating on two platforms · transit time to main hub · check-in / check-out policy · luggage storage availability · refund policy · source URL · research date**.
- The main conversation synthesizes the rows into the comparison table and decides first-pick / backup / niche / avoid.
- Each sub-agent independently follows the Timeout Degradation rules above.

This follows the same batch-verification pattern as [dining-rules.md](dining-rules.md) §10.
