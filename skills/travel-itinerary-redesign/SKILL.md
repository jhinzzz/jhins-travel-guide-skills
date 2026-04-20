---
name: travel-itinerary-redesign
description: >
  Use when turning a trip brief, fragmented travel notes, or an existing itinerary page into a weather-aware guide with round-trip transport planning, day-by-day structure, hotel recommendations, and route-fit dining or shopping notes.
  Trigger words: 旅行规划, 行程安排, 旅行攻略, 交通规划, 酒店推荐, trip planning, travel itinerary, travel guide, plan a trip, itinerary redesign.
---

# Travel Itinerary Redesign

## Goal

Turn a travel brief or fragmented plan into a reusable guide without losing content.

Use [planning-rules.md](references/planning-rules.md) as the canonical source for intake order, weather handling, transport planning, and deliverable selection. Use [hotel-selection.md](references/hotel-selection.md) for hotel selection rules. Use [transportation.md](references/transportation.md) for round-trip transport booking, timing, pricing, and transfer planning.

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
| 1. Inventory | Brief and constraints only | Full page map |
| 2. Transport | Summary (mode, price range, timing) — no full cards | Full transport cards per [transportation.md](references/transportation.md) |
| 3. Timeline | Day-by-day outline | Full daily itinerary cards |
| 4. Local context | Key recommendations inline | Full embedded blocks per day |
| 5. Hidden-mode friction | Skip | Apply |
| 6. Weather | Apply | Apply |
| 7. Hotels | Direction only if asked | Full shortlist with cards |
| 8. Readability | Conversational tone | Guide-style chips and labels |
| 9. Web and mobile | Skip | Apply |
| 10. Verify | Check completeness of advice | Screenshots, anchors, transport cards |

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
   - Anchor arrival day forward from actual arrival time; anchor departure day backward from the hard cutoff.
   - For each transport leg, output a card per the format in [transportation.md](references/transportation.md) (mode, route, booking window, price range, recommended arrival, hard cutoff, transfer details, backup).

3. Rebuild around a generic trip timeline.
   - Use day archetypes such as arrival, city exploration, day trip, weather buffer, food-focused day, and departure.
   - Keep the day-by-day itinerary as the main spine.
   - Keep appendices for full restaurant, shopping, sightseeing, hotel, and transport references.
   - Avoid hard-coding a specific destination into the day template unless the user explicitly gave one.

4. Embed local context into each day.
   - Surface restaurants, shops, attractions, and shopping targets inside the matching day card.
   - Label each item as `main line`, `backup`, `walk-in`, `reservation required`, or `weather-only`.
   - If a restaurant does not fit the route, hours, or booking constraints, move it to backup instead of forcing it into the day.
   - Keep the meal and shopping blocks inside the relevant day so the user does not need to jump across sections.
   - Include intra-city transport notes where relevant (metro lines, bus routes, taxi estimates, walking distances).

5. Remove hidden-mode friction.
   - If the page uses tabs or modes, convert them into anchors or shortcuts.
   - Avoid hiding core content behind mode switches unless the user explicitly wants separate views.

6. Adapt to weather.
   - Apply the weather rules in [planning-rules.md](references/planning-rules.md).
   - Use weather to decide whether a day should be slower, more indoor, or more flexible.
   - Consider weather impact on transport: typhoons can cancel ferries and flights, heavy rain causes road delays — flag these risks when applicable.

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
- Weather assumptions are visible and practical.
- Fallback labels are visible where evidence or inputs were incomplete.
- Hotel recommendations follow [hotel-selection.md](references/hotel-selection.md).
- Both outbound and return transport legs are present and each card passes the checklist in [transportation.md](references/transportation.md) (booking window, price range, arrival time, hard cutoff, transfers, backup).
- Departure-day timeline works backward correctly from the transport hard cutoff.
- Restaurant and shopping items are attached to the right day or marked as backup.
- Existing source content is preserved unless the user asked to remove it.

## Minimal Output Shape

Use the smallest fitting structure for the chosen mode:

### `planning-only`

- Trip summary
- Assumptions or missing inputs
- Round-trip transport plan (mode, booking window, price range, timing)
- Day-by-day outline
- Hotel direction if requested
- Packing or weather notes

### `guide-redesign`

- Hero summary
- Round-trip transport cards (outbound and return with full details)
- Prep or packing
- Daily itinerary cards (arrival and departure days anchored to transport times)
- Hotel shortlist
- Embedded dining, shopping, and intra-city transport notes
- Reference appendix (including transport comparison if multiple modes were considered)

## Default Page Shape

- Hero summary
- Round-trip transport plan
- Packing essentials
- Time-sensitive prep (including ticket booking deadlines)
- Daily itinerary cards
- Hotel shortlist by budget and quality tier
- Embedded restaurant / shop / shopping blocks per day
- Intra-city transport notes per day
- Full reference appendices
