---
name: travel-itinerary-redesign
description: >
  Use when turning a trip brief, fragmented travel notes, or an existing itinerary page into a weather-aware guide with round-trip transport planning, day-by-day structure, hotel recommendations, and route-fit dining or shopping notes.
  Trigger words: 旅行规划, 行程安排, 旅行攻略, 交通规划, 酒店推荐, trip planning, travel itinerary, travel guide, plan a trip, itinerary redesign.
---

# Travel Itinerary Redesign

## Goal

Turn a travel brief or fragmented plan into a reusable guide without losing content.

Use [planning-rules.md](references/planning-rules.md) as the canonical source for intake order, trip preparation (visa, payment, communication, insurance), weather handling, transport planning, and deliverable selection. Use [hotel-selection.md](references/hotel-selection.md) for hotel selection rules (including check-in/out and luggage). Use [transportation.md](references/transportation.md) for round-trip transport booking, timing, pricing, and transfer planning.

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
| 8. Readability | Conversational tone | Guide-style chips and labels |
| 9. Web and mobile | Skip | Apply |
| 10. Verify | Check completeness of advice | Screenshots, anchors, transport cards, budget check |

When in doubt, start lighter — the user can always ask for more detail.

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
  - Present the most common viable modes for the route with a price-vs-time comparison.
  - Do not default to a single mode without asking.

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

- Existing content is incomplete or contradictory
  - Preserve the source facts, flag the conflict briefly, and avoid silently resolving it by invention.

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
   - Label each item as `main line`, `backup`, `walk-in`, `reservation required`, or `weather-only`.
   - For `reservation required` restaurants, state the recommended booking lead time (e.g., "book 2–4 weeks ahead for kaiseki/Michelin; 3–7 days for popular local restaurants") and the booking channel (phone, online, Tabelog, OpenTable, Google Maps).
   - For attractions that require advance tickets or timed entry, note the booking window and channel (e.g., "Forbidden City: book on WeChat mini-program, opens 7 days ahead, sells out within hours on holidays").
   - If a restaurant does not fit the route, hours, or booking constraints, move it to backup instead of forcing it into the day.
   - Keep the meal and shopping blocks inside the relevant day so the user does not need to jump across sections.
   - Include intra-city transport notes where relevant (metro lines, bus routes, taxi estimates, walking distances).
   - Add buffer time between activities: 15–20 minutes for nearby transitions (same area, walking), 30–45 minutes for cross-district moves (transit + wayfinding + luggage). Real-world transitions always take longer than map estimates due to wayfinding, stairs, crowds, and weather.
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

8. Optimize for readability.
   - Use short labels, chips, and compact notes.
   - Prefer plain travel-guide wording over AI-style explanations.
   - Keep paragraphs short and scan-friendly.
   - For transport cards, use tables or chip-style labels, not paragraphs.

9. Optimize for web and mobile.
   - Desktop: editorial two-column layouts are fine.
   - Mobile: single-column flow, stacked cards, no horizontal overflow.
   - Make the iPhone-sized view readable without extra taps.

10. Verify before finishing.
    - Check desktop and mobile screenshots.
    - Confirm anchors, navigation, and section visibility.
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

## Editing Rules

- Do not delete existing trip content unless the user explicitly asks.
- When reorganizing content, duplicate it into the new location first and keep the original reference section if needed.
- Make reservation status explicit for restaurants.
- Prefer route-fit venues with usable booking paths; otherwise mark them as walk-in or backup.
- Keep packing, transport, meal, shopping, and return-day details visible in the same guide.
- Format transport cards per [transportation.md](references/transportation.md) output format.
- If the user provides dates and destination only, generate a weather-aware scaffold first, then refine with budget and food preferences.
- Do not force file generation for planning-only requests.
- When the user wants a redesigned guide, page, or shareable artifact, follow [planning-rules.md](references/planning-rules.md) for markdown and HTML deliverables.

## Final Check

- Output mode matches the request type.
- Trip preparation items are surfaced for international trips (visa deadlines, payment/currency, SIM/connectivity, insurance).
- Weather assumptions are visible and practical.
- Fallback labels are visible where evidence or inputs were incomplete.
- Hotel recommendations follow [hotel-selection.md](references/hotel-selection.md), including check-in/out times and luggage plan for early arrival or late departure.
- Both outbound and return transport legs are present and each card passes the checklist in [transportation.md](references/transportation.md) (booking window, price range, arrival time, hard cutoff, transfers, backup).
- Arrival day starts from realistic "available in city" time (not landing time for international flights).
- Departure-day timeline works backward correctly from transport hard cutoff through hotel check-out and luggage.
- Budget breakdown by category is present and compared against the user's stated budget.
- Restaurants marked `reservation required` have booking lead times and channels.
- Attractions requiring advance tickets have booking windows and channels.
- Buffer time between activities is realistic (15–20 min nearby, 30–45 min cross-district).
- Off-peak timing suggestions, if present, cite a verifiable source (official hours, Google Maps popular times, published guide). No source = no suggestion.
- Restaurant and shopping items are attached to the right day or marked as backup.
- Existing source content is preserved unless the user asked to remove it.

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
- Packing or weather notes

### `guide-redesign`

- Hero summary
- Trip preparation checklist (visa, payment, SIM, insurance — for international trips)
- Round-trip transport cards (outbound and return with full details)
- Prep or packing
- Daily itinerary cards (arrival and departure days anchored to transport times, with buffer times between activities)
- Reservation and ticket booking deadlines (restaurants, attractions)
- Hotel shortlist (with check-in/out times and luggage plan)
- Budget breakdown by category
- Embedded dining, shopping, and intra-city transport notes
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
- Intra-city transport notes per day
- Full reference appendices
