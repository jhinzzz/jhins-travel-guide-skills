---
name: travel-itinerary-redesign
description: Use when planning a trip, restructuring fragmented travel notes, or redesigning a trip-planner page into a reusable, weather-aware itinerary guide with hotel recommendations and route-fit dining and shopping notes.
---

# Travel Itinerary Redesign

## Goal

Turn a travel brief or fragmented plan into a reusable guide without losing content.

Use [planning-rules.md](references/planning-rules.md) as the canonical source for intake order, weather handling, and deliverable selection. Use [hotel-selection.md](references/hotel-selection.md) for hotel selection rules.

## Intake First

- Follow [planning-rules.md](references/planning-rules.md) for the required inputs and question order.
- Treat that file as canonical instead of restating those rules in derived outputs or companion files.

## Core Workflow

1. Inventory the current page or brief first.
   - Map every existing section, mode, anchor, constraint, and appendix before editing.
   - Preserve all facts. Move content instead of deleting it.

2. Rebuild around a generic trip timeline.
   - Use day archetypes such as arrival, city exploration, day trip, weather buffer, food-focused day, and departure.
   - Keep the day-by-day itinerary as the main spine.
   - Keep appendices for full restaurant, shopping, sightseeing, and hotel references.
   - Avoid hard-coding a specific destination into the day template unless the user explicitly gave one.

3. Embed local context into each day.
   - Surface restaurants, shops, attractions, and shopping targets inside the matching day card.
   - Label each item as `main line`, `backup`, `walk-in`, `reservation required`, or `weather-only`.
   - If a restaurant does not fit the route, hours, or booking constraints, move it to backup instead of forcing it into the day.
   - Keep the meal and shopping blocks inside the relevant day so the user does not need to jump across sections.

4. Remove hidden-mode friction.
   - If the page uses tabs or modes, convert them into anchors or shortcuts.
   - Avoid hiding core content behind mode switches unless the user explicitly wants separate views.

5. Adapt to weather.
   - Apply the weather rules in [planning-rules.md](references/planning-rules.md).
   - Use weather to decide whether a day should be slower, more indoor, or more flexible.

6. Recommend hotels with evidence.
   - Use the dedicated hotel selection rules in [hotel-selection.md](references/hotel-selection.md).

7. Optimize for readability.
   - Use short labels, chips, and compact notes.
   - Prefer plain travel-guide wording over AI-style explanations.
   - Keep paragraphs short and scan-friendly.

8. Optimize for web and mobile.
   - Desktop: editorial two-column layouts are fine.
   - Mobile: single-column flow, stacked cards, no horizontal overflow.
   - Make the iPhone-sized view readable without extra taps.

9. Verify before finishing.
   - Check desktop and mobile screenshots.
   - Confirm anchors, navigation, and section visibility.
   - If publishing is requested, commit only the intended files.
   - Use [planning-rules.md](references/planning-rules.md) to decide whether the task needs conversational output only, markdown plus HTML deliverables, or a standalone vs split web output.

## Editing Rules

- Do not delete existing trip content unless the user explicitly asks.
- When reorganizing content, duplicate it into the new location first and keep the original reference section if needed.
- Make reservation status explicit for restaurants.
- Prefer route-fit venues with usable booking paths; otherwise mark them as walk-in or backup.
- Keep packing, transport, meal, shopping, and return-day details visible in the same guide.
- If the user provides dates and destination only, generate a weather-aware scaffold first, then refine with budget and food preferences.
- Do not force file generation for planning-only requests.
- When the user wants a redesigned guide, page, or shareable artifact, follow [planning-rules.md](references/planning-rules.md) for markdown and HTML deliverables.

## Default Page Shape

- Hero summary
- Packing essentials
- Time-sensitive prep
- Daily itinerary cards
- Hotel shortlist by budget and quality tier
- Embedded restaurant / shop / shopping blocks per day
- Full reference appendices
