# Planning Rules

## Intake

- Ask for missing trip inputs in this order: travel dates, destination, party size and companions, trip purpose / theme, pace preference, chronic medication (any in the party), food preferences, budget, preferred transport mode.
- **Trip purpose / theme** — offer a candidate list rather than leaving it open-ended, so the user picks rather than inventing: nature / history & culture / food & shopping / adventure & outdoor / family & kids / romance & honeymoon / photography / wellness & spa / festival & event / business-with-leisure. Allow multi-select; if two themes conflict in pace (e.g., adventure + wellness), surface the conflict per Confirmation Checkpoints.
- **Adventure sub-intensity** — when the user picks `adventure & outdoor`, ask the single-day intensity ceiling they accept, because adventure sub-activities are not interchangeable under a single pace: sunrise-hike / pre-dawn start (≤02:00 wakeup), full-day trek (>5 h on foot), open-water dive, multi-pitch climb, whitewater rafting. Any one of these overrides the nominal pace — e.g., `leisurely` + sunrise-hike is an intra-theme conflict and must be flagged before scheduling.
- **Pace preference** — ask the user to pick one of three: **tight** (4–6 activities/day, minimize downtime, walk-ready all day), **balanced** (2–3 anchor activities/day with flex time), **leisurely** (1–2 anchors/day, long meals, hotel / cafe downtime). Pace directly affects daily card density, buffer times, and whether lunch/dinner picks can be in different districts.
- **Chronic medication at intake** — if any party member takes long-term prescription medication, capture the **generic drug name** (not brand) at intake, not during trip preparation. Some generics legal at home are restricted or illegal at the destination (pseudoephedrine restricted in Japan / UAE; ADHD stimulants illegal in Japan; strong codeine / tramadol restricted in UAE / Singapore; even some common cold-flu combinations are flagged). Carry the generic list forward so the Trip Preparation parallel sub-agents can flag cross-country legality as part of their country row, rather than surfacing it only in the safety section post-draft.
- Ask one missing item at a time when possible. However, if three or more core inputs are missing (dates, destination, budget), batch the first two or three questions in one turn to avoid excessive back-and-forth. Always keep the question count per turn to three or fewer.
- For **food preferences**, capture three elements whenever the user mentions specific meal intent: **meal slot** (which day / lunch or dinner), **cuisine** (ramen / sushi / izakaya / sashimi / local specialty, etc.), and **area** (station, neighborhood, or anchor). All three bind the recommendation per [dining-rules.md](dining-rules.md) §5 — do not discard the area constraint to get a better cuisine match or vice versa. When the user uses "or" between two cuisines ("izakaya or sashimi"), capture both and plan to offer two main-line candidates, not a merged pick.
- If the user's message implies they want destination inspiration (e.g., "有什么建议", "where should I go"), offer 2–3 brief destination ideas based on the season and any stated constraints before proceeding with the intake order.
- Party size and companions come early because they affect transport tickets, room type, restaurant seating, and budget split.
- If hotel suggestions are needed and room style is missing, ask that after the core inputs.
- If the user has not mentioned transport preferences, ask after budget: "Do you have a preferred transport mode for getting there and back (flight, high-speed rail, rental car, etc.)?"
- **If the user chooses self-drive / rental car**, capture three driver-readiness elements before planning daily routes (analogous to the meal × cuisine × area binding for dining):
  1. **Licence validity at the destination** — mainland China does **not** recognize foreign or international driver's licences; Japan requires a JAF translation of the original licence (not a standard IDP); most other countries accept a valid home licence + IDP. Confirm the traveller's licence actually works at the destination — do not assume.
  2. **Driving side** — LHD (left-hand drive / right-hand traffic) vs RHD (right-hand drive / left-hand traffic: UK / AU / NZ / Japan / HK / SG / Thailand / South Africa / Ireland / parts of Caribbean). If the user has never driven on the destination's side, flag it and recommend a short adaptation day as the first leg, not a long transfer.
  3. **Daily driving-time comfort ceiling** — ask the max single-day driving time the user is comfortable with, and lower the default ceiling when the party includes **elderly, young children, pregnant passengers, pets**, or the route crosses **mountain passes / unpaved roads / >3,500 m altitude / night driving**. Typical ceilings: 6 h solo fit adult; 4–5 h with elderly/kids; 3–4 h on high-altitude or mountain days.
- Do not start detailed planning until the trip brief is usable.

## Trip Preparation

Time-sensitive prep items that must be surfaced before the trip — missing any of these can ruin a trip that is otherwise perfectly planned.

### Parallel Verification for Multi-Country / Multi-Stop Trips

When the trip crosses **2+ countries** (or includes a long transit country — Schengen transfers, UAE stopovers, Hong Kong transit, etc.), do not serialize visa / entry / payment / SIM / insurance / etiquette research in the main conversation.

- Spawn **2 parallel sub-agents**, grouped by country (not by topic). Each sub-agent receives the intake-captured chronic-medication generics (if any) and returns a structured row per country: **visa requirement + processing time · entry requirements (passport validity, return ticket proof, minors-with-one-parent documents where applicable) · primary currency + dominant payment methods · recommended SIM / eSIM option · destination-specific etiquette red flags · chronic-medication legality flag (per the intake generic list) · source URLs · research date**.
- The main conversation consolidates the rows into the trip-prep checklist and the etiquette section, flagging any cross-country conflicts (e.g., Schengen visa covers France but not UK; pseudoephedrine legal in EU but restricted in Japan; tramadol legal in US but restricted in UAE).

Follows the same batch-verification pattern as [dining-rules.md](dining-rules.md) §10.

### Visa and Entry

- For international trips, check visa requirements before planning details.
- Include processing time: e.g., Japan tourist visa 5–7 working days, Schengen 15–45 calendar days, US B1/B2 varies widely.
- If visa processing could conflict with the travel dates, warn the user immediately.
- For visa-free destinations, note any entry requirements (passport validity, return ticket, hotel booking proof).
- If visa status is unknown, ask; do not assume.
- **Minors crossing borders** — when the party includes a child under 18 travelling with only one parent (or with a non-parent adult), many destinations require supporting documents: notarised consent from the absent parent / guardian, translated birth certificate linking the child to the accompanying adult, and sometimes an apostille. High-enforcement destinations include UAE, Saudi Arabia, South Africa, Mexico, and several EU members. Surface the requirement at intake, not at the airport.

### Payment and Currency

- Note the primary currency at the destination.
- Recommend exchange or withdrawal strategy (airport exchange, ATM, bank pre-exchange) with approximate rates if available.
- List essential payment methods: e.g., IC card (Japan), WeChat/Alipay (China), contactless card (Europe/Australia), cash-heavy destinations.
- Flag destinations where foreign cards are commonly declined (e.g., many small shops in Japan and China).

### Communication

- Recommend a connectivity plan: local SIM, eSIM, pocket WiFi, or roaming.
- Note approximate cost and where to purchase (airport counter, online pre-order, convenience store).
- Connectivity is critical — it enables maps, translation, ride-hailing, and emergency contact.
- **Offline-map download** — for any trip segment crossing low / no cellular signal areas (remote self-drive, mountain / plateau routes, hiking, ferry crossings, border zones), add offline-map download to the pre-trip checklist: Amap offline pack for mainland China; Google Maps "Download offline maps" for other regions (and regional alternatives — Yandex / Naver / Kakao / Waze — per [transportation.md](transportation.md) §Rental Car / Self-Drive).

### Travel Insurance

- Recommend travel insurance for international trips, especially where medical costs are high (US, Japan, Europe).
- Note what to look for: medical coverage, trip cancellation, luggage loss.
- Mark as optional but recommended; do not force it on domestic short trips.

### Local Etiquette and Cultural Norms

Surface etiquette rules that will actually affect the traveller's day. Not a culture lecture — just the 5–8 rules that prevent real embarrassment, refused entry, or offence. Pull only the rules relevant to the destination, not a universal list.

Cover these categories when the destination triggers them:

- **Dress code** — mosques (head cover for women, covered shoulders/knees for all), temples (removed shoes, no shorts at Thai / Cambodian royal temples), upscale Japanese kaiseki / Michelin (no shorts / tank tops), Vatican and many European basilicas (covered shoulders/knees), Middle East public spaces (modest dress especially in Ramadan and in Saudi / Iran).
- **Tipping** — US / Canada (15–20% at sit-down restaurants, $1–2/bag for porters, 15–20% for taxis); most of Europe (rounding up or 5–10% for good service; some countries include service); Japan / Korea / China / Singapore / Taiwan (tipping not customary and can cause confusion); Middle East and South Asia (10% often expected); cruise / tour-guide tipping varies widely.
- **Shoes off** — Japan (homes, ryokan, some traditional restaurants, temples), Korea (homes, some restaurants), Turkey (homes, mosques), Thailand (homes, temples), many Southeast Asian temples.
- **Photography restrictions** — Kyoto geisha districts (Gion — private alleys banned, fines exist), many religious sites (interior photography banned), Middle East (people and airports off-limits in some countries), museums (flash restrictions vary), military / government / border areas across many countries.
- **Public behaviour** — PDA restrictions (Middle East, parts of Southeast Asia), drinking-in-public limits (Islamic countries, some US cities, Indian dry states), pointing with feet / head-touching (Thailand / Southeast Asia), left-hand eating taboo (much of South Asia and the Middle East).
- **Greetings and small talk** — bowing depth in Japan, handshake vs cheek-kiss vs bow defaults, who offers hand first, using both hands to present a card / gift in East Asia.
- **Money and bargaining** — expected in markets (Egypt, Morocco, Turkey, India, Southeast Asia street markets); inappropriate in fixed-price shops / department stores. Fake-goods warnings where relevant.
- **Religious and festival sensitivities** — Ramadan daytime eating/drinking in public (Muslim-majority countries), Sabbath observance in Jerusalem / orthodox areas, Buddhist Lent in Thailand (some alcohol restrictions), Shabbat in Tel Aviv.

**Rule**: each etiquette item must be phrased as *"situation → specific action"*, not abstract norms. Not "Japan is polite" but "Remove shoes before stepping onto tatami; street shoes stay in the entryway (玄関)". Cite source and research date where the rule carries legal or financial consequence (e.g., Gion photo fines, Saudi dress code).

### Safety and Emergency

For every international trip (and domestic trips where the destination has non-trivial safety considerations — remote areas, high-altitude, disaster-season overlaps), include a safety and emergency section.

See [safety-and-emergency.md](safety-and-emergency.md) for the full ruleset: emergency numbers, medical access, consular support, insurance claim path, theft/loss response, and destination-specific risk notes.

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

## Dining

See [dining-rules.md](dining-rules.md) for restaurant selection — cuisine-diversity matrix (no category repeats across the trip), operating-status verification (destination-language closure / relocation notices, "Permanently closed" on Google Maps), target-date calendar checks (weekly closures plus destination-specific peak closures), district/address consistency, meal × cuisine × area intake, reservation channels and lead times, peak-period pre-trip recheck, and swap-cascade rules.

## Local Specialties

See [local-specialties.md](local-specialties.md) for souvenir and specialty selection criteria, tiering, and output format.

## Research Sources

See [travel-sources.md](travel-sources.md) for the canonical list of travel information sources, cross-referencing rules, and citation format. All factual claims must be traceable to sources listed there.
