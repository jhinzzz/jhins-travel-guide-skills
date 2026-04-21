# Dining Rules

## Purpose

Govern restaurant and dining recommendations across the full trip. These rules supplement — and take precedence over — general planning rules when the output includes meal recommendations (lunch, dinner, snack-focused blocks, or food-themed days).

Applies to `planning-only`, `guide-redesign`, and `existing-page-refactor` modes whenever restaurants appear in the output.

## 1. Cuisine Diversity Across the Trip

Every main meal (lunch + dinner) across the whole trip is tracked on a **cuisine matrix** so the same category does not appear twice.

### Rule

- Build a matrix keyed by `day × meal` and tagged with cuisine category. Use the natural category vocabulary of the destination — for Japan: shabu-shabu, tempura, sushi, yakiniku, ramen, soba, izakaya, sashimi…; for China: 川菜 / 粤菜 / 本帮菜 / 淮扬菜 / 火锅 / 烧烤 / 面食…; for Italy: pizza, pasta, osteria, trattoria, seafood, risotto…; for the US: steakhouse, BBQ, seafood, brunch, diner, New American…
- A given cuisine category appears **at most once** across the full trip, unless the user explicitly asks for repetition (e.g., "ramen every day", "one hotpot meal on every trip to Chongqing").
- **Backup picks** count against the matrix too — a backup cannot share a category with any already-selected main line.
- Check the matrix **before** drafting each meal, not after. Fill categories that are still open and match user preference first.

### How to Apply

Before writing day-by-day meals, list every still-open slot, then fill one meal at a time and update the matrix after each fill. When the user requests a swap, re-check the whole matrix — replacing one meal can free up or re-occupy categories across the trip.

## 2. Operating-Status Verification (No Trust in Training Data)

Small restaurants close, relocate, or rebuild on short notice. **Do not trust restaurant knowledge from training data** — every restaurant recommended must have its operating status verified online before the output is finalized.

### Rule

For every restaurant recommendation, check all four:

1. **Closure / rest notices in the destination's language**: the local terminology for closed / on hold / relocated / rebuilding — examples: 閉店・休業・移転・建替 (Japanese), 停业・歇业・搬迁・装修 (Chinese), "Permanently closed" / "Temporarily closed" (English on Google Maps), "chiuso" / "trasferito" (Italian), "cerrado" / "traslado" (Spanish). Adapt to the destination's language and verify on the locally authoritative platform.
2. **404 or "new store" redirect** on the official website.
3. **Google Maps status banner** — "Permanently closed" overrides anything else, regardless of destination.
4. **Platform page integrity** — if the platform ID now resolves to a different business (name mismatch, different address), treat the original as closed or relocated.

Use [travel-sources.md](travel-sources.md) for the authoritative dining platform per destination (Tabelog in Japan, Dianping in China, TripAdvisor + Google Maps as international defaults, plus destination-specific sources in the source list).

### If verification keeps failing

If WebFetch fails or information is incomplete for a single venue, **do not downgrade to guessing**. See the parallel sub-agent protocol in the SKILL.md Fallback Rules.

### Failure modes to watch for

- A multi-location chain where the flagship has moved, been rebuilt, or is on temporary closure. Recommend the specific operating branch, not just "the flagship".
- A platform page that has been taken over by a relocated business of the same ID — the name on the page and the name you remember may not match.
- "Irregular days off" (不定休 in Japan, 不定期休息 in China, "closed at chef's discretion" in fine dining anywhere) — flag for phone confirmation before departure, do not treat as "open every day".

## 3. Target-Date Operating Calendar

Every restaurant must be checked against the **specific trip date**, not its "usual" operating pattern. Holidays, peak seasons, and weekly closures eliminate otherwise-good picks.

### High-risk categories (must verify per target date)

- **Traditional / old-line establishments** — often closed on specific weekdays + national holidays. Examples: Japan old-school soba / unagi / kaiseki / oden on 日祝休 (overlaps Golden Week); European fine dining on Sunday/Monday; many European restaurants on August vacation (ferragosto in Italy, les vacances in France); US fine dining on Monday.
- **Department-store / mall tenants** — follow the host property's calendar, not their own hours.
- **Destination peaks that trigger closures or special hours** — Japan Golden Week (late April–early May) / O-Bon (mid-August) / New Year; China Spring Festival / National Day / May Day; Europe Christmas / New Year / Easter / August vacation; US Thanksgiving / Christmas; Middle East Ramadan (daytime closures). The trip window must be cross-referenced against every restaurant's holiday calendar, not just weekly closures.

### What to record per restaurant

- **Regular closed days** (e.g., Sunday + holidays; Monday; second and fourth Wednesdays — use whatever pattern the venue publishes).
- **Holiday-season notices** — check the official site for destination-specific peak closures covering the trip dates.
- **Irregular / chef's discretion** — flag explicitly: "Call to confirm before travel."

### How to Apply

Build a date list for the trip window, mark every non-weekday (weekends + public holidays) in red, and cross-check every restaurant against its target date. A restaurant that fails the date check moves to a "weekday-only alternatives" pool; do not silently re-use it on a closed day.

## 4. Address and Ward Consistency

Restaurant names frequently embed a neighborhood or district — examples: Ebisu / Ginza / Shinjuku / Roppongi in Tokyo; 外灘 / 南锣鼓巷 / 静安寺 in China; Trastevere / Marais / SoHo in Western cities. Verify the official address actually sits in that district before using the name as a route anchor.

### Rule

- Read the official address field on the venue's own page. The district in the address must match the district in the name.
- For multi-branch chains, confirm which branch the user will actually visit. "Flagship" or "本店" does not automatically mean "flagship located in district X" — the flagship may live elsewhere.
- If the name implies a district that doesn't match the address, find an actual in-district alternative rather than forcing the mismatched pick.

## 5. Precise Coverage of User Food Preferences

User-stated food preferences usually specify three things together: **meal slot + cuisine + area**. All three must be honored.

### Rule

- When the user specifies meal slot, cuisine, and area (e.g., "Day 1 dinner, sashimi near Akihabara"; "Day 3 lunch, 本帮菜 near 外滩"; "Friday dinner, pasta in Trastevere"), every constraint is binding — do not drop the area constraint to get a better cuisine match or vice versa.
- When the user uses "or" between two cuisines ("izakaya or sashimi", "hotpot or 川菜"), present **two main-line candidates** (one per cuisine), not a single merged pick.
- Area default: within **10-minute walk of the referenced anchor** (station / landmark / neighborhood). If nothing fits, expand and state "+X min walk" explicitly.

### Quantitative quality bars

Apply the rating floor on the destination's authoritative platform (see [travel-sources.md](travel-sources.md) for exact thresholds per platform). Price tiers are always in local currency — use the destination's norms to calibrate Value / Mid / High, not a one-size-fits-all band.

Principle: the higher-end the category (sushi, kaiseki, tasting menu), the higher the rating floor — because at that tier, near-miss picks are frequent tourist traps.

### Required fields per restaurant card

Every restaurant recommendation must carry all four:

- **Cuisine category** (so the matrix in §1 can be maintained)
- **Platform rating** (Tabelog / Dianping / TripAdvisor / Google Maps / destination-local authority, whichever is listed as authoritative in [travel-sources.md](travel-sources.md))
- **Walking time from the reference anchor** (station, landmark, or neighborhood)
- **Per-person price band** with local currency

## 6. Route Consistency (Dinner Fits the Evening's Location)

Dinner is decided by the **location of that evening's main activity** (shopping, night views, strolling district), not the other way around. A "better" restaurant 30 minutes outside the activity area is not better.

### Rule

- If the user plans to shop/walk/sightsee in area X from late afternoon to 21:00, all dinner main-line and backup picks must be within **10-minute walk** of X.
- Conversely, if the evening activity is in area X, that area must have **at least 2 candidates** (main + backup).
- Drop-in slots ("add an oden stop", "swap in yakitori") must be in the same ward as the anchor — otherwise it is not a real swap.

## 7. Reservation Channel and Lead Time

Every restaurant that requires reservation must state its channel and lead time. Use destination-appropriate channels.

### Channels

Pick the destination-appropriate channel mix — examples:

- **Japan**: TableCheck, Tabelog online, OMAKASE, Pocket Concierge, phone, official-site form, walk-in.
- **China**: 大众点评, 美团, 官方微信 / 小程序, phone, walk-in.
- **US / Europe / international**: OpenTable, Resy, SevenRooms, TheFork (Europe), Google reservations, official-site, phone, walk-in.

Verify that the channel is actually available to a traveler — e.g., some Chinese platforms require a local phone number; some Japanese official forms are Japanese-only.

### Lead times (default; adjust for peak)

| Tier | Lead time | Peak-season adjustment |
|---|---|---|
| Tasting-menu / Michelin / top-end | 2–4 weeks (sometimes months for famous sushi / kaiseki / chef's counters) | +2 weeks during destination peak |
| Popular mid-to-high-end | 1–2 weeks | +1 week during destination peak |
| Well-regarded neighborhood | 3–7 days | +3–5 days during destination peak |
| Casual / counter / walk-in | None | Flag queue peaks (typical: local prime dinner window on weekends) |

"Destination peak" = the holiday or season listed in §3 for that country, not a generic label.

### Irregular closures

If a candidate has irregular / chef's-discretion closures, the card must carry a visible "call to confirm before travel" label — it cannot be silently recommended.

## 8. Peak-Season Pre-Trip Recheck Block

Every guide output covering a peak-season window must carry a **"3–5 days before departure" recheck block** at the bottom.

What counts as "peak" depends on the destination — use examples like Japan Golden Week / O-Bon / New Year; China Spring Festival / National Day / May Day; Europe Christmas / Easter / August vacation; US Thanksgiving / Christmas; Middle East Ramadan. When the trip window overlaps any such peak, the block is required.

### Required contents

- Every restaurant with any of: irregular closures / closes on the trip's weekday-or-holiday / possible special holiday closure — listed by name and target date.
- Every reservation that needs re-confirmation.
- Peak-day warnings appropriate to the destination: tax-refund or immigration queues, airport / station rush, attraction crowds, return-leg traffic or transit disruptions.

## 9. Cascading Updates on Restaurant Swaps

Swapping any restaurant requires updating **every place the restaurant is referenced**, not just the primary meal card.

### Places to update

1. The daily meal line in the main view.
2. Any dedicated restaurant info card / detail section.
3. The pre-trip recheck block (if the name was listed there).
4. Any navigation anchor, heading, or description that used the restaurant name.
5. The cuisine matrix from §1 (free the old category, occupy the new).

### How to Apply

Use a grep-first flow: list every occurrence of the outgoing name across the deliverable, then update them one by one. Never leave a stale name in a card title or anchor when the meal line has been swapped.

## 10. Verification Batch Workflow

For any trip with 5 or more dining picks, verification must be done as a **batch**, not inline inside the main conversation.

### Rule

- List every restaurant requiring verification, grouped by day (or by ward / category).
- Spawn **2–3 parallel sub-agents** to cover the batch — each returns a structured row per venue: **operating status · address · regular closures · peak-season notes · reservation channel · source URL**.
- Keep the main conversation focused on synthesis and decisions. Do not run serial WebFetch calls in the main context.
- Give the user a status line ("Dispatched N sub-agents for venue verification") so they know why there is a pause.

Details of the parallel sub-agent pattern are in the main SKILL.md Fallback Rules.

## Non-Goals

- Do not rely on general knowledge of restaurants from training data. Every recommendation must pass §2 verification.
- Do not present a restaurant as recommendation-grade without the four required fields in §5.
- Do not ignore the cuisine matrix to "squeeze in" a favorite category twice unless the user asked.
- Do not skip pre-trip recheck blocks for peak-season trips.
- Do not update only the day card when swapping — always run the §9 cascade.
