---
name: travel-itinerary-redesign
description: >
  Use when turning a trip brief, fragmented travel notes, or an existing itinerary page into a weather-aware guide with round-trip transport planning, day-by-day structure, hotel recommendations, local specialty souvenirs, and route-fit dining or shopping notes. Supports three modes: planning-only (conversational advice), guide-redesign (markdown + HTML deliverables), and existing-page-refactor (restructure fragmented content).
  Trigger words: 旅行规划, 行程安排, 旅行攻略, 交通规划, 酒店推荐, 帮我规划旅行, 出行计划, 特产推荐, 手信, 伴手礼, trip planning, travel itinerary, travel guide, plan a trip, itinerary redesign, local souvenirs.
---

# Travel Itinerary Redesign

## Goal

Turn a travel brief or fragmented plan into a reusable guide without losing content.

Use [planning-rules.md](references/planning-rules.md) as the canonical source for intake order, trip preparation (visa, payment, communication, insurance), weather handling, transport planning, and deliverable selection. Use [hotel-selection.md](references/hotel-selection.md) for hotel selection rules (including check-in/out and luggage). Use [transportation.md](references/transportation.md) for round-trip transport booking, timing, pricing, and transfer planning. Use [local-specialties.md](references/local-specialties.md) for destination-specific souvenir and specialty recommendations. Use [dining-rules.md](references/dining-rules.md) for restaurant selection, cuisine-diversity matrix, operating-status verification, target-date calendar checks, ward consistency, reservation channels, and swap-cascade rules. Use [travel-sources.md](references/travel-sources.md) as the canonical list of research sources and citation rules.

## Data Traceability Constraint

Every factual recommendation in the output — including itinerary items, hotel picks, transport options, flight/train schedules, ticket prices, restaurant suggestions, and specialty/souvenir recommendations — must be traceable to a real, verifiable source.

- **Cite the source and research date** for every price, schedule, rating, or availability claim. Use the citation format defined in [travel-sources.md](references/travel-sources.md).
- **Cross-reference at least two independent sources** for significant decisions (hotel selection, transport booking, specialty recommendations). See [travel-sources.md](references/travel-sources.md) for which sources to use for each information type.
- **Never fabricate** specific flight numbers, train numbers, departure times, fares, hotel names, shop names, restaurant names, or product prices. If data is unavailable, state the typical range, mark it as approximate, and note why exact data was unavailable.
- **Do not trust restaurants from training data.** Small venues close, relocate, or rebuild on short notice. Every restaurant recommendation must have its current operating status verified online (closure / relocation / rebuild notices, Google Maps "Permanently closed", platform page integrity) per [dining-rules.md](references/dining-rules.md) §2 before it appears in the output.
- **Verify against the target date, not the typical week.** Restaurants, attractions, and museum hours must be checked against the specific trip dates — regular weekly closures plus destination-specific peak closures (examples: Japan Golden Week / O-Bon / New Year; China Spring Festival / National Day; European Christmas / Easter / August vacation; US Thanksgiving / Christmas; Ramadan in the Middle East). See [dining-rules.md](references/dining-rules.md) §3.
- **Mark the confidence level** when evidence is thin: use "approximate" for single-source data, "verified" for multi-source confirmed data, and "verify locally" when online data is insufficient.
- **Research date freshness**: if data is older than 3 months, flag it. Travel prices, schedules, and availability change frequently.

## Classify The Task First

Decide which mode fits before planning details:

1. `planning-only`
   - The user wants itinerary advice, structure, or recommendations.
   - Conversational output or a markdown outline is enough unless the user explicitly asks for files.

2. `guide-redesign`
   - The user wants a reusable guide, trip-planner page, or shareable artifact.
   - Follow [planning-rules.md](references/planning-rules.md) for markdown and HTML deliverables.

3. `existing-page-refactor`
   - The user already has a page, document, or fragmented layout that needs restructuring.
   - This is a subtype of `guide-redesign` where preservation and re-mapping of existing content come before new planning.
   - Preserve content first, then reorganize it into the new guide shape.

If the request could fit both `planning-only` and `guide-redesign`, ask one direct confirmation question before generating files or page structure.

## Mode-Specific Scope

Not every mode needs every workflow step. Use the lightest path that fits:

| Step | `planning-only` | `guide-redesign` / `existing-page-refactor` |
|---|---|---|
| Trip prep (visa, payment, SIM, insurance) | Flag critical items (visa deadline, SIM) | Full prep checklist per [planning-rules.md](references/planning-rules.md) |
| 1. Inventory | Brief and constraints only | Full page map |
| 2. Transport | Summary (mode, booking window, price range, timing) — no full cards | Full transport cards per [transportation.md](references/transportation.md) |
| 3. Timeline + budget | Day-by-day outline with budget estimate | Full daily cards with category-level budget breakdown |
| 4. Local context | Key recommendations inline with booking lead times | Full embedded blocks per day with buffer times |
| 5. Hidden-mode friction | Skip | Apply |
| 6. Weather | Apply | Apply |
| 7. Hotels | Direction only if asked | Full shortlist with cards (incl. check-in/out, luggage) |
| 8. Local specialties | Mention signature items if relevant | Full specialty cards per [local-specialties.md](references/local-specialties.md) |
| 9. Readability | Conversational tone | Guide-style chips and labels |
| 10. Web and mobile | Skip | Apply |
| 11. Verify | Check completeness of advice | Full verification per Final Check section |

When in doubt, start lighter — the user can always ask for more detail.

## Language

- Detect the user's language from their first message and use it for all output (itinerary, cards, labels, notes, confirmation questions).
- If the user switches language mid-conversation, follow the switch.
- Skill instructions are in English for LLM readability — this does not affect output language.
- For place names, use the user's language first with the local-language name in parentheses on first mention (e.g., "东京（Tokyo）" for Chinese users, "Tokyo (東京)" for English users). This helps with both reading and on-the-ground wayfinding.

## Intake First

- Follow [planning-rules.md](references/planning-rules.md) for the required inputs and question order.
- Treat that file as canonical instead of restating those rules in derived outputs or companion files.

## Confirmation Checkpoints

Ask for confirmation before crossing these boundaries:

- Switching from advice or outline mode into markdown plus HTML deliverables
- Replacing an existing page structure instead of only reorganizing content inside it
- Choosing a transport mode when the user has not stated a preference
- Treating missing dates, destination, or budget as permission to invent specifics
- Dropping existing sections, venues, or notes instead of preserving them as backup or reference
- Finalizing a plan where the estimated total exceeds the user's stated budget by more than 15% — present the overage, suggest which categories to trim, and get confirmation before proceeding
- Swapping any restaurant, hotel, or anchor attraction after the first draft — run the cascade in [dining-rules.md](references/dining-rules.md) §9 (daily card, detail section, pre-trip recheck block, nav anchors, cuisine matrix) and confirm the full update with the user before closing the change
- Publishing a trip that overlaps a destination-specific peak period (examples: Japan GW / O-Bon / New Year; China Spring Festival / National Day; European Christmas / Easter / August vacation; US Thanksgiving / Christmas) without the "3–5 days before departure" recheck block required by [dining-rules.md](references/dining-rules.md) §8

## Fallback Rules

When critical inputs or evidence are incomplete, degrade gracefully instead of inventing certainty:

- Missing dates or destination
  - Stay in scaffold mode.
  - Output assumptions explicitly and avoid detailed daily sequencing that depends on local context.

- Missing budget or food preferences
  - Continue with a neutral structure, then mark hotel and dining choices as provisional.

- No reliable forecast
  - Use seasonal averages and label the weather guidance as approximate.

- Weak hotel evidence
  - Do not promote a hotel as a first pick.
  - Keep it as backup, niche, or omit it according to [hotel-selection.md](references/hotel-selection.md).

- Missing transport preference
  - If the route has one overwhelmingly dominant mode (e.g., Shanghai–Hangzhou high-speed rail, Beijing–Tokyo flight), present it as the primary option with alternatives noted, and ask the user to confirm or switch — do not block planning while waiting for a transport preference answer.
  - If multiple modes are genuinely competitive (e.g., Beijing–Shanghai flight vs. high-speed rail), present a price-vs-time comparison and ask the user to choose before proceeding.
  - Do not default to a single mode without at least noting alternatives.

- Transport schedule or price unavailable
  - Follow the evidence standard in [transportation.md](references/transportation.md): use approximate ranges with research date, never fabricate specifics.

- Visa or entry requirements unknown
  - For international trips, flag that visa status must be confirmed before booking transport or hotels.
  - Do not assume visa-free entry without verification.

- Attraction ticket availability or restaurant reservation status unknown
  - Flag the item as "advance booking likely required — verify availability" rather than silently scheduling it.
  - Do not assume availability during peak seasons or holidays.

- Off-peak timing data unavailable
  - If no reliable crowd data exists (official hours, Google Maps popular times, published guides), omit the off-peak suggestion entirely.
  - Do not guess crowd patterns based on general assumptions.

- Last-minute trip (departure within 48 hours)
  - Normal booking windows are irrelevant — skip advance-booking advice and focus on what is still available now.
  - Prioritize real-time booking channels (ride-hailing, walk-in hotels, same-day train/flight availability).
  - Warn that prices are likely higher and options limited; suggest flexible alternatives (e.g., nearby destinations with better last-minute availability).
  - Skip visa-dependent international destinations unless the user confirms visa is already in hand.

- Conflicting constraints (e.g., luxury hotel on a tight budget, 10 attractions in 2 days)
  - Surface the conflict explicitly: state what the user asked for and why the constraints clash.
  - Offer 2–3 prioritization options (e.g., "keep the budget and downgrade hotel tier" vs. "keep the hotel and extend the trip by one day") and let the user choose.
  - Do not silently compromise — the user should know what trade-off was made and why.

- Local specialty data is thin or unverifiable
  - Do not recommend specific shops or products without source evidence.
  - Fall back to general category guidance (e.g., "Hangzhou is known for Longjing tea and silk — verify specific shops locally").
  - Mark as "verify locally" per [local-specialties.md](references/local-specialties.md).

- Existing content is incomplete or contradictory
  - Preserve the source facts, flag the conflict briefly, and avoid silently resolving it by invention.

- Web verification stalls (WebFetch fails, page ambiguous, a venue ID now resolves to a relocated business)
  - Do not fall back to "please verify yourself" and move on. Do not invent. Do not drop the item silently.
  - For a single venue: retry via a different source in [travel-sources.md](references/travel-sources.md) (official site → platform page → Google Maps status → editorial guide).
  - For batches of 5 or more venues (typical when a trip has full meal, hotel, and attraction slates): spawn **2–3 parallel sub-agents**, each responsible for a bucket grouped by day, ward, or category. Each sub-agent returns a structured row per venue (operating status, address, regular closures, peak-season notes, reservation channel, source URL).
  - The main conversation does synthesis and decisions — it does not run serial WebFetch calls over a long list.
  - While sub-agents are running, give the user a short status line (e.g., "Dispatched 3 sub-agents for venue verification") so the pause is visible.
  - Treat repeated WebFetch hits that return **different businesses for the same ID** as a strong signal the original venue closed or moved; do not recommend it.

## Core Workflow

1. Inventory the current page or brief first.
   - Map every existing section, mode, anchor, constraint, and appendix before editing.
   - Preserve all facts. Move content instead of deleting it.
   - If the request is `planning-only`, inventory the user's brief and constraints instead of inventing page structure too early.

2. Plan round-trip transport first.
   - Determine outbound and return transport before filling in daily activities.
   - Follow [transportation.md](references/transportation.md) for all transport rules: booking windows, arrival times, pricing, transfers, and return-trip planning.
   - Anchor arrival day forward from the realistic "available in the city" time (landing time + immigration + baggage + customs for international flights; see [transportation.md](references/transportation.md)). Anchor departure day backward from the hard cutoff, accounting for hotel check-out and luggage (see [hotel-selection.md](references/hotel-selection.md)).
   - For each transport leg, output a card per the format in [transportation.md](references/transportation.md) (mode, route, booking window, price range, recommended arrival, hard cutoff, transfer details, backup).

3. Rebuild around a generic trip timeline.
   - Use day archetypes such as arrival, city exploration, day trip, weather buffer, food-focused day, and departure.
   - Keep the day-by-day itinerary as the main spine.
   - Keep appendices for full restaurant, shopping, sightseeing, hotel, and transport references.
   - Avoid hard-coding a specific destination into the day template unless the user explicitly gave one.
   - Once transport, hotels, and daily activities are sketched, produce a budget breakdown by category (transport, accommodation, dining, attractions/tickets, local transport, miscellaneous). Compare the total against the user's stated budget. If over budget, flag which categories can be trimmed and suggest alternatives before finalizing.

4. Embed local context into each day.
   - Surface restaurants, shops, attractions, and shopping targets inside the matching day card.
   - For restaurants specifically, follow [dining-rules.md](references/dining-rules.md) — maintain the cuisine-diversity matrix (§1) across the whole trip, verify operating status (§2), check the target date against regular closures and holiday notices (§3), confirm ward consistency (§4), respect meal-slot × cuisine × area preferences (§5), keep dinner picks within 10-minute walk of the evening's anchor (§6), and state reservation channel + lead time (§7). Every restaurant card carries four required fields: cuisine category · platform rating · walking time from station · per-person price band.
   - Label each item as `main line`, `backup`, `walk-in`, `reservation required`, or `weather-only`.
   - For `reservation required` restaurants, state the recommended booking lead time (e.g., "2–4 weeks ahead for tasting-menu / Michelin-tier; 3–7 days for popular local restaurants") and the booking channel (phone, online, or the destination-appropriate platform — Tabelog / Dianping / OpenTable / Resy / TheFork / Google reservations, etc., per [dining-rules.md](references/dining-rules.md) §7).
   - For attractions that require advance tickets or timed entry, note the booking window and channel (e.g., "Forbidden City: book on WeChat mini-program, opens 7 days ahead, sells out within hours on holidays").
   - If a restaurant does not fit the route, hours, or booking constraints, move it to backup instead of forcing it into the day.
   - Keep the meal and shopping blocks inside the relevant day so the user does not need to jump across sections.
   - Include intra-city transport notes where relevant (metro lines, bus routes, taxi estimates, walking distances).
   - Add buffer time between activities based on transition type:
     - **Nearby** (15–20 min): next activity is within ~1 km or a 10-minute walk — same neighborhood, same commercial area, same station exit zone.
     - **Cross-district** (30–45 min): requires metro/bus/taxi, or walking distance exceeds 1 km. Includes time for wayfinding, platform transfers, and waiting.
     - **With luggage** (+10–15 min): add to either tier when carrying check-in/check-out bags — elevators, escalators, and crowds slow movement significantly.
     - When in doubt, use the longer buffer. Real-world transitions always take longer than map estimates due to wayfinding, stairs, crowds, and weather.
   - For high-traffic attractions and restaurants, include off-peak timing suggestions only when backed by verifiable evidence (official opening hours, published crowd data, Google Maps popular-times graphs, or well-documented travel guides). State the source. Do not guess crowd patterns — if no reliable data is available, omit the suggestion rather than fabricate it.

5. Remove hidden-mode friction.
   - If the page uses tabs or modes, convert them into anchors or shortcuts.
   - Avoid hiding core content behind mode switches unless the user explicitly wants separate views.

6. Adapt to weather.
   - Apply the weather rules in [planning-rules.md](references/planning-rules.md).
   - Use weather to decide whether a day should be slower, more indoor, or more flexible.
   - Consider weather impact on transport: typhoons can cancel ferries and flights, heavy rain causes road delays. Flag these risks and include a backup plan per [transportation.md](references/transportation.md) (do not assume transport availability during severe weather).

7. Recommend hotels with evidence.
   - Use the dedicated hotel selection rules in [hotel-selection.md](references/hotel-selection.md).
   - Factor in proximity to the main transport hub (station, airport) for arrival and departure convenience.

8. Recommend local specialties and souvenirs.
   - Use [local-specialties.md](references/local-specialties.md) for selection criteria, tiering, and output format.
   - Only recommend items that are genuinely unique to the destination and validated by at least two travel sources (see [travel-sources.md](references/travel-sources.md)).
   - Embed specialty shopping into the relevant day card near the geographic location of the recommended shop.
   - Flag customs and transport constraints for international trips (prohibited items, liquid limits, fragile packaging).
   - For departure day, note last-minute purchase spots near the hotel or station if applicable.

9. Optimize for readability.
   - Use short labels, chips, and compact notes.
   - Prefer plain travel-guide wording over AI-style explanations.
   - Keep paragraphs short and scan-friendly.
   - For transport cards, use tables or chip-style labels, not paragraphs.

10. Optimize for web and mobile.
    - Desktop: editorial two-column layouts are fine.
    - Mobile: single-column flow, stacked cards, no horizontal overflow.
    - Make the iPhone-sized view readable without extra taps.

11. Verify before finishing.
    - For guide-redesign / existing-page-refactor: review the generated HTML for viewport compatibility (no horizontal overflow on 375px width, no broken anchors, all sections reachable). If a browser tool is available, take desktop and mobile screenshots to visually confirm.
    - Confirm all sections, anchors, and navigation links are present and reachable.
    - Verify all transport legs have booking windows, price ranges, arrival times, and backup options.
    - Verify departure-day timing works backward correctly from the hard cutoff.
    - If publishing is requested, commit only the intended files.
    - Use [planning-rules.md](references/planning-rules.md) to decide whether the task needs conversational output only, markdown plus HTML deliverables, or a standalone vs split web output.

## Non-Goals

- Do not force HTML generation for planning-only requests.
- Do not replace route fit, booking constraints, or weather logic with generic sightseeing filler.
- Do not drop existing facts just to make the layout cleaner.
- Do not hide core trip content behind tabs or mode switches unless the user explicitly wants that.
- Do not violate the transport evidence standard or skip the return trip — see [transportation.md](references/transportation.md) for the full list of transport non-goals.
- Do not recommend souvenirs or specialties without evidence from at least two travel sources — see [local-specialties.md](references/local-specialties.md).
- Do not present any price, schedule, or factual claim without citing the source and research date — see [travel-sources.md](references/travel-sources.md).

## Editing Rules

These rules supplement the Core Workflow and Non-Goals — they apply specifically when modifying existing content or producing deliverables.

- Keep packing, transport, meal, shopping, specialty, and return-day details visible in the same guide — do not split them into separate documents unless the user asks.
- If the user provides dates and destination only, generate a weather-aware scaffold first, then refine with budget and food preferences once provided.

## Final Check

Verify each area against its canonical source — do not re-check rules already defined in reference files; instead confirm the output passes the reference's own checklist.

- Output mode matches the request type.
- **Trip prep**: international trips surface visa, payment, SIM, insurance per [planning-rules.md](references/planning-rules.md).
- **Weather**: assumptions visible and practical per [planning-rules.md](references/planning-rules.md).
- **Fallback labels**: visible where evidence or inputs were incomplete (see Fallback Rules above).
- **Hotels**: pass the output card checklist in [hotel-selection.md](references/hotel-selection.md), including check-in/out and luggage plan.
- **Transport**: both legs present, each card passes the 9-field checklist in [transportation.md](references/transportation.md). Arrival day anchored to realistic "available in city" time; departure day works backward from hard cutoff.
- **Budget**: breakdown by category present; compared against user's stated budget; if over 15%, confirmation checkpoint was triggered.
- **Local context**: restaurants and attractions have booking lead times and channels where applicable; buffer times realistic (15–20 min nearby, 30–45 min cross-district); off-peak suggestions cite source or are omitted.
- **Dining**: cuisine-diversity matrix holds (no category appears twice across lunch/dinner unless user asked); every restaurant verified against target date and operating status; district consistency holds; every card has the four required fields per [dining-rules.md](references/dining-rules.md) §5.
- **Pre-trip recheck block**: for any trip overlapping a destination-specific peak period, the "3–5 days before departure" block is present and lists every irregular-closure / weekday-or-holiday-closed / possible special-closure restaurant by name and target date.
- **Specialties**: if present, pass the card checklist in [local-specialties.md](references/local-specialties.md) (tiered, sourced, transport-flagged).
- **Data traceability**: every factual claim cites source and research date per [travel-sources.md](references/travel-sources.md). No fabricated specifics anywhere.
- **Content preservation**: existing source content preserved unless the user asked to remove it.

## Minimal Output Shape

Use the smallest fitting structure for the chosen mode:

### `planning-only`

- Trip summary
- Assumptions or missing inputs
- Trip preparation flags (visa, payment, SIM — for international trips)
- Round-trip transport plan (mode, booking window, price range, timing)
- Day-by-day outline with activity buffer times
- Budget estimate by category
- Hotel direction if requested
- Local specialty highlights if relevant (signature items only, with source)
- Packing or weather notes
- All prices, schedules, and recommendations cite source and research date

### `guide-redesign`

- Hero summary
- Trip preparation checklist (visa, payment, SIM, insurance — for international trips)
- Round-trip transport cards (outbound and return with full details)
- Prep or packing
- Daily itinerary cards (arrival and departure days anchored to transport times, with buffer times between activities)
- Reservation and ticket booking deadlines (restaurants, attractions)
- Hotel shortlist (with check-in/out times and luggage plan)
- Budget breakdown by category
- Local specialty and souvenir cards (with tiering, source, and transport notes per [local-specialties.md](references/local-specialties.md))
- Embedded dining, shopping, and intra-city transport notes
- All prices, schedules, and recommendations cite source and research date per [travel-sources.md](references/travel-sources.md)
- Pre-trip recheck block (when the trip overlaps a destination-specific peak period): restaurants / reservations / crowd-sensitive items to re-confirm 3–5 days before departure per [dining-rules.md](references/dining-rules.md) §8
- Reference appendix (including transport comparison if multiple modes were considered)

## Default Page Shape

- Hero summary
- Trip preparation checklist (visa, currency, SIM, insurance)
- Round-trip transport plan
- Packing essentials
- Time-sensitive prep (ticket booking deadlines for transport, attractions, and restaurants)
- Daily itinerary cards (with buffer times)
- Hotel shortlist by budget and quality tier (with check-in/out and luggage notes)
- Budget breakdown by category
- Embedded restaurant / shop / shopping blocks per day
- Local specialty and souvenir recommendations (embedded in relevant day or as dedicated section)
- Intra-city transport notes per day
- Source citations on all factual claims
- Pre-trip recheck block when the trip overlaps a destination-specific peak
- Full reference appendices
