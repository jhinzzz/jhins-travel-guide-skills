---
name: jhins-trip-planner
description: >
  End-to-end trip planner: pre-trip prep, round-trip transport, hotels, day-by-day itineraries with weather and buffer times, route-fit dining, local specialties, categorized budget, and source-traceable recommendations. Three modes: planning advice, guide redesign (markdown + HTML), or existing-page refactor.
  Trigger words: 旅行规划, 行程安排, 旅行攻略, 交通规划, 酒店推荐, 餐厅推荐, 帮我规划旅行, 出行计划, 行前准备, 特产推荐, 手信, 伴手礼, 预算估算, trip planning, travel itinerary, travel guide, plan a trip, itinerary redesign, hotel recommendations, restaurant recommendations, local souvenirs, jhins-trip-planner.
---

# Jhins Trip Planner

## Goal

Turn a travel brief or fragmented plan into a reusable guide without losing content.

Use [planning-rules.md](references/planning-rules.md) as the canonical source for intake order, trip preparation (visa, payment, communication, insurance, local etiquette), weather handling, transport planning, and deliverable selection. Use [hotel-selection.md](references/hotel-selection.md) for hotel selection rules (including check-in/out and luggage). Use [transportation.md](references/transportation.md) for round-trip transport booking, timing, pricing, and transfer planning. Use [local-specialties.md](references/local-specialties.md) for destination-specific souvenir and specialty recommendations. Use [dining-rules.md](references/dining-rules.md) for restaurant selection, cuisine-diversity matrix, operating-status verification, target-date calendar checks, ward consistency, reservation channels, and swap-cascade rules. Use [safety-and-emergency.md](references/safety-and-emergency.md) for emergency numbers, medical access, consular support, insurance claim path, theft/loss response, and destination-specific risk notes. Use [travel-sources.md](references/travel-sources.md) as the canonical list of research sources and citation rules.

## Data Traceability Constraint

Every factual recommendation in the output — including itinerary items, hotel picks, transport options, flight/train schedules, ticket prices, restaurant suggestions, and specialty/souvenir recommendations — must be traceable to a real, verifiable source.

- **Cite the source and research date** for every price, schedule, rating, or availability claim. Use the citation format defined in [travel-sources.md](references/travel-sources.md).
- **Cross-reference at least two independent sources** for significant decisions (hotel selection, transport booking, specialty recommendations). See [travel-sources.md](references/travel-sources.md) for which sources to use for each information type.
- **Never fabricate** specific flight numbers, train numbers, departure times, fares, hotel names, shop names, restaurant names, or product prices. If data is unavailable, state the typical range, mark it as approximate, and note why exact data was unavailable.
- **Do not trust restaurants from training data.** Small venues close, relocate, or rebuild on short notice. Every restaurant recommendation must have its current operating status verified online (closure / relocation / rebuild notices, Google Maps "Permanently closed", platform page integrity) per [dining-rules.md](references/dining-rules.md) §2 before it appears in the output.
- **Verify against the target date, not the typical week.** Check restaurants, attractions, and museum hours against the specific trip dates — regular weekly closures plus destination-specific peak closures. See [dining-rules.md](references/dining-rules.md) §3 for the canonical peak-period list.
- **Confidence and freshness labels**: mark single-source data as "approximate", multi-source confirmed as "verified", and insufficient online data as "verify locally". Flag any data older than 3 months — prices, schedules, and availability change fast.

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
| Trip prep (visa, payment, SIM, insurance, etiquette) | Flag critical items (visa deadline, SIM, etiquette red flags like Ramadan / mosque dress) | Full prep checklist per [planning-rules.md](references/planning-rules.md) |
| Safety & emergency | Short block (emergency numbers + insurer hotline + embassy one-liner) | Full section per [safety-and-emergency.md](references/safety-and-emergency.md) |
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
- Publishing a trip that overlaps a destination-specific peak period (see [dining-rules.md](references/dining-rules.md) §3 for the list) without the "3–5 days before departure" recheck block required by [dining-rules.md](references/dining-rules.md) §8
- Producing a self-drive day whose **total driving time, total distance, or longest single segment** would exceed the daily driving-time ceiling captured at intake ([planning-rules.md](references/planning-rules.md) §Intake) — surface the overage, propose a split (add one day / drop a stop / change lodging) and confirm with the user before finalizing
- Producing a daily schedule whose density conflicts with the user's stated pace preference — e.g., 6 anchors/day when the user picked `leisurely`, or only 1 anchor/day when they picked `tight`. Surface the conflict and propose the realistic density before continuing
- Themes the user picked imply conflicting paces or day shapes (e.g., `adventure` + `wellness`, `photography` + `family with young kids`) — flag the conflict and ask which theme wins for which day before drafting
- `pace=leisurely` combined with any high-intensity adventure sub-activity captured at intake (sunrise-hike, pre-dawn start, full-day trek >5 h, open-water dive, multi-pitch climb, whitewater rafting) — pace and sub-intensity are orthogonal, so finalise the day shape only after the user confirms which one yields on that day
- Scheduling a trip whose window overlaps **Ramadan / a moveable religious festival** without first reconfirming the exact dates for that year (moon-sighting announcement shifts Ramadan by ±1 day and redraws Iftar timing, daytime dining closures, and dress expectations) — verify the year's calendar from an official source before drafting etiquette and dining plans

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

- Self-drive infeasible or risky
  - **Licence not recognised at destination**: do not force self-drive. For mainland China specifically, foreign and international driving permits are not recognised — switch to public transport, private driver / chartered car, or suggest a companion who holds a valid local licence. For Japan, standard IDPs are not valid — require a JAF translation of the home licence; if unavailable, switch off self-drive.
  - **Long stretches of low / no cellular signal** (e.g., Iceland Highlands / F-roads, US national parks, Australian outback, Tibetan plateau, remote coastal routes): **require offline-map download** to the pre-trip checklist; do not rely solely on live Google Maps / Amap. Also flag the fuel-station gap so the user refuels before the gap, not inside it.
  - **First time driving on the opposite traffic side** (LHD traveller going to RHD country or vice versa): set the first day as a short adaptation leg (≤3 hours, daylight, simple route, no city rush hour), not the longest transfer of the trip. Recommend an airport-to-first-hotel route the user can study the night before.
  - **Party includes elderly, young children, pregnant passengers, or pets, or route crosses high-altitude / mountain / unpaved roads**: lower the daily driving-time ceiling from the default 6 h to 4–5 h (3–4 h on high-altitude days), and add extra rest stops. Do not compress the itinerary to "fit more" by ignoring this.

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
  - For a single item: retry via a different source in [travel-sources.md](references/travel-sources.md) (official site → platform page → Google Maps / editorial guide).
  - Treat repeated WebFetch hits that return **different businesses for the same ID** as a strong signal the original venue closed or moved; do not recommend it.

- Batch verification (general rule — applies to any research category)
  - Trigger the parallel sub-agent pattern whenever the batch crosses the per-category threshold below. Main conversation handles synthesis only — never run serial WebFetch over a long list.
  - Each sub-agent returns a structured-row report per item; give the user a short status line ("Dispatched N sub-agents for {category} verification").
  - Category thresholds and row schemas are defined in:
    - Dining ≥5 venues → [dining-rules.md](references/dining-rules.md) §10
    - Hotels >4 candidates → [hotel-selection.md](references/hotel-selection.md) §Parallel Verification
    - Specialties >5 items → [local-specialties.md](references/local-specialties.md) §Parallel Verification
    - Safety & emergency ≥2 cities / countries → [safety-and-emergency.md](references/safety-and-emergency.md) §9
    - Trip prep ≥2 countries → [planning-rules.md](references/planning-rules.md) §Trip Preparation → Parallel Verification

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
   - For self-drive / rental-car days, follow [transportation.md](references/transportation.md) §Rental Car / Self-Drive — each day card names the route-book app (Amap for mainland China; Google Maps elsewhere with regional fallback) and carries three required fields: **total distance (km) · total driving time · longest single uninterrupted driving segment**. All three must fit under the intake-captured ceiling ([planning-rules.md](references/planning-rules.md) §Intake); otherwise split the day or drop a stop before showing the plan.
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

- **Output mode** matches the request type.
- **Trip prep**: international trips pass the checklist in [planning-rules.md](references/planning-rules.md) §Trip Preparation (visa · payment · SIM · insurance · etiquette).
- **Weather**: assumptions visible and practical per [planning-rules.md](references/planning-rules.md) §Weather.
- **Fallback labels**: visible where evidence or inputs were incomplete (see Fallback Rules above).
- **Hotels**: pass the card checklist in [hotel-selection.md](references/hotel-selection.md) (incl. check-in/out and luggage plan).
- **Transport**: both legs present; each card passes the 9-field checklist in [transportation.md](references/transportation.md); arrival / departure anchored correctly.
- **Budget**: category breakdown present; >15% overage triggered the confirmation checkpoint.
- **Local context**: booking lead times stated where needed; buffer times follow Step 4 tiers; off-peak suggestions cited or omitted.
- **Dining**: passes [dining-rules.md](references/dining-rules.md) §§1-9 (matrix · operating status · target-date · ward · 4 fields · route · reservations · cascade).
- **Self-drive** (when applicable): passes [transportation.md](references/transportation.md) §Rental Car / Self-Drive + intake triad from [planning-rules.md](references/planning-rules.md) §Intake — day cards show the three required fields, fit the ceiling, name the route-book app, and offline-map is on the pre-trip checklist for low-signal segments.
- **Pace & theme**: daily density matches the chosen pace; theme conflicts resolved before drafting; any high-intensity adventure sub-activity is reconciled with pace on a per-day basis.
- **Intake carry-forward**: chronic-medication generics captured at intake (if any) flow into the Trip Preparation parallel rows as per-country legality flags; minors-with-one-parent documents raised where the destination enforces them; for Ramadan / moveable-festival overlap, the year-specific calendar is verified from an official source before etiquette and dining blocks are drafted.
- **Local etiquette**: destination-triggered items present, each phrased as *situation → specific action* per [planning-rules.md](references/planning-rules.md) §Local Etiquette.
- **Safety & emergency**: passes the section checklist in [safety-and-emergency.md](references/safety-and-emergency.md) — numbers · hospital · embassy (incl. after-hours) · insurer claim path · theft/loss numbered steps · risk items with §6 phrasing.
- **Pre-trip recheck block**: present whenever the trip overlaps a peak period; lists every at-risk venue by name and target date per [dining-rules.md](references/dining-rules.md) §8.
- **Specialties** (if present): pass the card checklist in [local-specialties.md](references/local-specialties.md).
- **Data traceability**: every factual claim cites source and research date per [travel-sources.md](references/travel-sources.md).
- **Content preservation**: existing source content preserved unless the user asked to remove it.

## Minimal Output Shape

Use the smallest fitting structure for the chosen mode:

### `planning-only`

- Trip summary (theme + pace stated explicitly)
- Assumptions or missing inputs
- Trip preparation flags (visa, payment, SIM, top etiquette red flags — for international trips)
- Round-trip transport plan (mode, booking window, price range, timing)
- Day-by-day outline with activity buffer times, calibrated to the chosen pace
- For self-drive days: route-book app + driving-day three fields (distance · driving time · longest single segment)
- Budget estimate by category
- Hotel direction if requested
- Local specialty highlights if relevant (signature items only, with source)
- Packing or weather notes
- Short safety & emergency block (emergency numbers + insurer hotline + embassy one-liner)
- All prices, schedules, and recommendations cite source and research date

### `guide-redesign`

- Hero summary (theme + pace stated explicitly)
- Trip preparation checklist (visa, payment, SIM, insurance — for international trips)
- Local etiquette & cultural norms (destination-triggered rules only — dress code / tipping / shoes-off / photo restrictions / public behaviour as applicable)
- Round-trip transport cards (outbound and return with full details)
- Prep or packing
- Daily itinerary cards (arrival and departure days anchored to transport times, with buffer times between activities calibrated to the chosen pace; self-drive days carry the three required fields — distance · driving time · longest single segment — and name the route-book app)
- Reservation and ticket booking deadlines (restaurants, attractions)
- Hotel shortlist (with check-in/out times and luggage plan)
- Budget breakdown by category
- Local specialty and souvenir cards (with tiering, source, and transport notes per [local-specialties.md](references/local-specialties.md))
- Embedded dining, shopping, and intra-city transport notes
- All prices, schedules, and recommendations cite source and research date per [travel-sources.md](references/travel-sources.md)
- Pre-trip recheck block (when the trip overlaps a destination-specific peak period): restaurants / reservations / crowd-sensitive items to re-confirm 3–5 days before departure per [dining-rules.md](references/dining-rules.md) §8
- Safety & emergency section (emergency numbers, medical access, embassy / consulate contact, insurance claim path, theft / loss / passport response, destination-specific risks) per [safety-and-emergency.md](references/safety-and-emergency.md)
- Reference appendix (including transport comparison if multiple modes were considered)

## Default Page Shape

Use the `guide-redesign` shape above as the default page skeleton. The two shapes are identical except where the user has asked for a reduced page — in which case drop the reference appendix first, then the pre-trip recheck block (only if the trip does not overlap a peak period). Never drop safety & emergency, transport legs, or budget breakdown.
