---
name: travel-itinerary-redesign
description: Create or refactor travel itineraries into reusable, weather-aware, mobile-first guides with packing lists, hotels, day-by-day plans, embedded restaurants and shopping, preserved content, explicit reservation or walk-in notes, and final markdown plus HTML deliverables. Use when planning trips, editing trip-planner pages, or simplifying fragmented travel guides.
---

# Travel Itinerary Redesign

## Goal

Turn a travel brief or fragmented plan into a reusable guide without losing content.

See [planning-rules.md](references/planning-rules.md) for the intake, weather, and output rules, and [hotel-selection.md](references/hotel-selection.md) for hotel selection rules.

## Intake First

- Ask for missing trip inputs progressively, in this order: travel dates, destination, trip purpose, food preferences, budget.
- Ask only the next missing item when possible.
- If hotel suggestions are needed and room style or party size is missing, ask that after the five core inputs.
- Do not start detailed planning until the trip brief is usable.

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
   - Check the destination's forecast for the travel window, or use seasonal averages when exact forecasts are unavailable.
   - Adjust clothing, shoes, outerwear, rain gear, sunscreen, hydration, indoor/outdoor ratio, and pacing.
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
   - Produce a final markdown file and an HTML file.
   - If the user wants a standalone page, keep the HTML in one file.
   - If the user wants a maintainable project, split HTML, CSS, and JS as needed.

## Editing Rules

- Do not delete existing trip content unless the user explicitly asks.
- When reorganizing content, duplicate it into the new location first and keep the original reference section if needed.
- Make reservation status explicit for restaurants.
- Prefer route-fit venues with usable booking paths; otherwise mark them as walk-in or backup.
- Keep packing, transport, meal, shopping, and return-day details visible in the same guide.
- If the user provides dates and destination only, generate a weather-aware scaffold first, then refine with budget and food preferences.
- Always end with both a markdown deliverable and an HTML deliverable.
- Choose single-file HTML vs split HTML/CSS/JS based on the user's request and project complexity.

## Default Page Shape

- Hero summary
- Packing essentials
- Time-sensitive prep
- Daily itinerary cards
- Hotel shortlist by budget and quality tier
- Embedded restaurant / shop / shopping blocks per day
- Full reference appendices
