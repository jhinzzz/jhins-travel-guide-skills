# Planning Rules

## Intake

- Ask for missing trip inputs in this order: travel dates, destination, trip purpose, food preferences, budget, preferred transport mode.
- Ask one missing item at a time when possible.
- If hotel suggestions are needed and room style or party size is missing, ask that after the core inputs.
- If the user has not mentioned transport preferences, ask after budget: "Do you have a preferred transport mode for getting there and back (flight, high-speed rail, etc.)?"
- Do not start detailed planning until the trip brief is usable.

## Weather

- Use the forecast for the travel window when available.
- If forecast is unavailable, use seasonal averages for the destination and dates.
- Adjust packing, shoes, outerwear, rain gear, sunscreen, hydration, indoor/outdoor ratio, and pacing.
- Mark weather-only or weather-sensitive blocks clearly.

## Transportation

- Plan round-trip transport as a first-class part of the itinerary, not an afterthought.
- See [transportation.md](transportation.md) for all transport rules: booking windows, arrival times, pricing, transfers, return-trip planning, and output format.

## Output

- If the user wants planning help only, a conversational itinerary or markdown outline is enough unless they explicitly ask for files.
- If the user wants a redesigned guide, trip-planner page, or other shareable artifact, produce both a markdown deliverable and an HTML deliverable.
- If the user wants a standalone page, output one HTML file.
- If the user wants a maintainable project, split HTML, CSS, and JS as needed.
- State the chosen HTML structure explicitly.

## Hotels

See [hotel-selection.md](hotel-selection.md) for hotel tiering, evidence, and output rules.
