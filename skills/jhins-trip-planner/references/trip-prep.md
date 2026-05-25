# Trip Preparation

Time-sensitive prep items that must be surfaced before the trip — missing any of these can ruin a trip that is otherwise perfectly planned.

Applies when the trip is international, or when a domestic trip crosses non-trivial prep thresholds (remote areas, cross-province rules, peak-period constraints).

## 1. Parallel Verification for Multi-Country / Multi-Stop Trips

When the trip crosses **2+ countries** (or includes a long transit country — Schengen transfers, UAE stopovers, Hong Kong transit, etc.), do **not** serialize visa / entry / payment / SIM / insurance / etiquette research in the main conversation.

- Spawn **2 parallel sub-agents**, grouped by country (not by topic). Each sub-agent receives the intake-captured chronic-medication generics (if any) and returns a structured row per country: **visa requirement + processing time · entry requirements (passport validity, return ticket proof, minors-with-one-parent documents where applicable) · primary currency + dominant payment methods · recommended SIM / eSIM option · destination-specific etiquette red flags · chronic-medication legality flag (per the intake generic list) · source URLs · research date**.
- The main conversation consolidates the rows into the trip-prep checklist and the etiquette section, flagging any cross-country conflicts (e.g., Schengen visa covers France but not UK; pseudoephedrine legal in EU but restricted in Japan; tramadol legal in US but restricted in UAE).

Follows the same batch-verification pattern as [dining-rules.md](dining-rules.md) §10.

## 2. Visa and Entry

- For international trips, check visa requirements before planning details.
- Include processing time: e.g., Japan tourist visa 5–7 working days, Schengen 15–45 calendar days, US B1/B2 varies widely.
- If visa processing could conflict with travel dates, warn the user immediately.
- For visa-free destinations, note any entry requirements (passport validity, return ticket, hotel booking proof).
- If visa status is unknown, ask; do not assume.
- **Minors crossing borders** — when the party includes a child under 18 travelling with only one parent (or with a non-parent adult), many destinations require supporting documents: notarised consent from the absent parent/guardian, translated birth certificate linking child to accompanying adult, and sometimes an apostille. High-enforcement destinations include UAE, Saudi Arabia, South Africa, Mexico, and several EU members. Surface the requirement at intake, not at the airport.

### Transit Visa Rules

"I'm just changing planes" is not a safe assumption. Check transit policy separately from destination visa. High-risk transit countries: US (no sterile transit — full immigration), Hong Kong (scheme varies by nationality), Dubai (carrier-issued stopover visa), Singapore (VFTF conditions), Schengen (ATV-required nationalities).

**Rule** — surface transit-visa checks at intake when the proposed routing connects through US / UK (2024 ETA expansion affects transit) / Canada / Australia / Russia / Schengen (for ATV-required passports). Do not silently assume transit is visa-free.

Country-specific detail: [deep/trip-prep.md](deep/trip-prep.md) §2.

## 3. Payment and Currency

- Note the primary currency at the destination.
- Recommend exchange or withdrawal strategy (airport exchange, ATM, bank pre-exchange) with approximate rates if available.
- List essential payment methods: e.g., IC card (Japan), WeChat/Alipay (China), contactless card (Europe/Australia), cash-heavy destinations.
- Flag destinations where foreign cards are commonly declined (many small shops in Japan and China).

### Practical Payment Friction — destination-specific

Generic advice ("bring a card and some cash") is not advice. When the destination triggers payment friction, surface the destination-specific detail from [deep/trip-prep.md](deep/trip-prep.md) §3. Covered destinations: Mainland China (WeChat/Alipay caps), Japan (cash-only shops), Iceland (cashless), Germany/Austria (cash preference), India (UPI), Argentina (multi-rate FX), USA (tipping layer), capital-control countries.

### Rule

- Do not cite a generic payment rule without pairing it with destination-specific friction when it applies.
- Cite source + research date for every caps / fee / rate claim. These change quickly.

## 4. Communication

- Recommend a connectivity plan: local SIM, eSIM, pocket WiFi, or roaming.
- Note approximate cost and where to purchase (airport counter, online pre-order, convenience store).
- Connectivity is critical — enables maps, translation, ride-hailing, and emergency contact.
- **Offline-map download** — for any trip segment crossing low / no cellular signal areas (remote self-drive, mountain / plateau routes, hiking, ferry crossings, border zones), add offline-map download to the pre-trip checklist: Amap offline pack for mainland China; Google Maps "Download offline maps" for other regions (regional alternatives — Yandex / Naver / Kakao / Waze — per [transportation.md](transportation.md) §Rental Car / Self-Drive).

## 5. Travel Insurance

- Recommend travel insurance for international trips, especially where medical costs are high (US, Japan, Europe).
- Note what to look for: medical coverage, trip cancellation, luggage loss.
- Mark optional but recommended; do not force on domestic short trips.

## 6. Local Etiquette and Cultural Norms

Surface etiquette rules that will actually affect the traveller's day. Not a culture lecture — the 5–8 rules that prevent real embarrassment, refused entry, or offence. Pull only rules relevant to the destination, not a universal list.

Cover these categories when the destination triggers them:

- **Dress code** — mosques (head cover for women, covered shoulders/knees for all), temples (removed shoes, no shorts at Thai / Cambodian royal temples), upscale Japanese kaiseki / Michelin (no shorts / tank tops), Vatican and many European basilicas (covered shoulders/knees), Middle East public spaces (modest dress especially in Ramadan, Saudi / Iran).
- **Tipping** — US / Canada (15–20% at sit-down restaurants, $1–2/bag porters, 15–20% taxis); most of Europe (rounding up or 5–10% for good service; some countries include service); Japan / Korea / China / Singapore / Taiwan (tipping not customary, can cause confusion); Middle East and South Asia (10% often expected); cruise / tour-guide tipping varies widely.
- **Shoes off** — Japan (homes, ryokan, some traditional restaurants, temples), Korea (homes, some restaurants), Turkey (homes, mosques), Thailand (homes, temples), many Southeast Asian temples.
- **Photography restrictions** — Kyoto geisha districts (Gion — private alleys banned, fines exist), many religious sites (interior photography banned), Middle East (people and airports off-limits in some countries), museums (flash restrictions vary), military / government / border areas across many countries.
- **Public behaviour** — PDA restrictions (Middle East, parts of Southeast Asia), drinking-in-public limits (Islamic countries, some US cities, Indian dry states), pointing with feet / head-touching (Thailand / Southeast Asia), left-hand eating taboo (much of South Asia and the Middle East).
- **Greetings and small talk** — bowing depth in Japan, handshake vs cheek-kiss vs bow defaults, who offers hand first, using both hands to present a card / gift in East Asia.
- **Money and bargaining** — expected in markets (Egypt, Morocco, Turkey, India, Southeast Asia street markets); inappropriate in fixed-price shops / department stores. Fake-goods warnings where relevant.

### Religious and Festival Sensitivities

Only surface items below when the trip window actually overlaps. Do not apply generically.

Key festivals with hard operational impact: Ramadan (Muslim-majority — daytime closures, alcohol restrictions, Iftar queues), Holi (India — colour/water damage to electronics/clothes), Songkran (Thailand — water festival, electronics unsafe), Shabbat (Israel — transport/shops stop), Buddhist Lent/Vassa (Thailand — alcohol sale bans on specific dates), East Asia travel peaks (Golden Week / O-Bon / Spring Festival / Chuseok / Tet — transport crowd-storms).

When the trip window overlaps any of these, read [deep/trip-prep.md](deep/trip-prep.md) §6 for full situation → specific action detail per festival. Verify year-specific dates from moveable-festival calendars per [travel-sources.md](travel-sources.md).

### Etiquette Rule

Each etiquette item must be phrased as **situation → specific action**, not abstract norms. Not "Japan is polite" but "Remove shoes before stepping onto tatami; street shoes stay in the entryway (玄関)". Cite source + research date where the rule carries legal or financial consequence (e.g., Gion photo fines, Saudi dress code).

## 7. Safety and Emergency

For every international trip (and domestic trips where the destination has non-trivial safety considerations — remote areas, high-altitude, disaster-season overlaps), include a safety and emergency section.

See [safety-and-emergency.md](safety-and-emergency.md) for the full ruleset: emergency numbers, medical access, consular support, insurance claim path, theft / loss response, and destination-specific risk notes.
