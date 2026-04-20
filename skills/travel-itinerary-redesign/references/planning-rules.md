# Planning Rules

## Intake

- Ask for missing trip inputs in this order: travel dates, destination, party size and companions, trip purpose, food preferences, budget, preferred transport mode.
- Ask one missing item at a time when possible.
- Party size and companions come early because they affect transport tickets, room type, restaurant seating, and budget split.
- If hotel suggestions are needed and room style is missing, ask that after the core inputs.
- If the user has not mentioned transport preferences, ask after budget: "Do you have a preferred transport mode for getting there and back (flight, high-speed rail, rental car, etc.)?"
- Do not start detailed planning until the trip brief is usable.

## Trip Preparation

Time-sensitive prep items that must be surfaced before the trip — missing any of these can ruin a trip that is otherwise perfectly planned.

### Visa and Entry

- For international trips, check visa requirements before planning details.
- Include processing time: e.g., Japan tourist visa 5–7 working days, Schengen 15–45 calendar days, US B1/B2 varies widely.
- If visa processing could conflict with the travel dates, warn the user immediately.
- For visa-free destinations, note any entry requirements (passport validity, return ticket, hotel booking proof).
- If visa status is unknown, ask; do not assume.

### Payment and Currency

- Note the primary currency at the destination.
- Recommend exchange or withdrawal strategy (airport exchange, ATM, bank pre-exchange) with approximate rates if available.
- List essential payment methods: e.g., IC card (Japan), WeChat/Alipay (China), contactless card (Europe/Australia), cash-heavy destinations.
- Flag destinations where foreign cards are commonly declined (e.g., many small shops in Japan and China).

### Communication

- Recommend a connectivity plan: local SIM, eSIM, pocket WiFi, or roaming.
- Note approximate cost and where to purchase (airport counter, online pre-order, convenience store).
- Connectivity is critical — it enables maps, translation, ride-hailing, and emergency contact.

### Travel Insurance

- Recommend travel insurance for international trips, especially where medical costs are high (US, Japan, Europe).
- Note what to look for: medical coverage, trip cancellation, luggage loss.
- Mark as optional but recommended; do not force it on domestic short trips.

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
