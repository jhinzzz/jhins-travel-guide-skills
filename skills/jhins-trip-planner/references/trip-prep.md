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

"I'm just changing planes" is not a safe assumption. Check transit policy separately from destination visa. The common traps:

- **United States** — no airside / sterile transit. Every traveller clears US immigration via ESTA (visa-waiver eligible) or C-1 transit visa. Budget 90+ minutes between flights for immigration + re-checking bags + re-clearing security. A US airport connection is effectively an entry.
- **Hong Kong** — 24h / 72h / 168h visa-free transit schemes vary by nationality + onward destination. Mainland Chinese passport holders must have a third-country onward ticket + valid destination visa to use transit-visa-free; cannot exit to HK territory in some cases. Verify the specific scheme before assuming.
- **Dubai (UAE)** — stopover-visa programs run by Emirates / Etihad / flydubai allow 48h–96h stays with carrier-issued visa (paid). Separate from standard tourist visa. Requires same-carrier onward flight in most programs.
- **Singapore** — VFTF (Visa-Free Transit Facility): 96h visa-free transit for many otherwise-visa-required nationalities (e.g., mainland Chinese, Indian, Russian passport holders), with conditions (confirmed onward ticket to a third country, valid visa for the onward country, specific carrier / origin-destination pairs). Verify eligibility on ICA before booking.
- **Schengen airside transit** — most passports do airside transit without a visa, but a list of "ATV-required nationalities" (Iran, Pakistan, Sri Lanka, and others) require a type-A Airport Transit Visa even if they never leave the sterile zone. Verify per passport.

**Rule** — surface transit-visa checks at intake when the proposed routing connects through US / UK (2024 ETA expansion affects transit) / Canada / Australia / Russia / Schengen (for ATV-required passports). Do not silently assume transit is visa-free.

## 3. Payment and Currency

- Note the primary currency at the destination.
- Recommend exchange or withdrawal strategy (airport exchange, ATM, bank pre-exchange) with approximate rates if available.
- List essential payment methods: e.g., IC card (Japan), WeChat/Alipay (China), contactless card (Europe/Australia), cash-heavy destinations.
- Flag destinations where foreign cards are commonly declined (many small shops in Japan and China).

### Practical Payment Friction — destination-specific

The examples above are policy; below is what happens on the ground. Surface whichever apply to the trip.

- **Mainland China — WeChat Pay / Alipay foreigner onboarding is volatile.** Tourist-mode binding of international Visa / Mastercard works most of the time but has per-transaction caps (typical: ¥200 per tx / ¥6,000 per year for Alipay Tour Card / TourPass — verify, changes frequently). Some small merchants, subway gates, and vending machines reject the tourist QR code. Recommend: (1) set up Alipay + WeChat Pay tourist mode at home before departure; (2) carry ¥300–500 cash as backup; (3) for large transactions (hotels, trains not booked online), a Visa / Mastercard at the hotel front desk is usually faster than the wallet.
- **Japan — small shops refuse cards more than guides admit.** Ramen counters, small izakayas, some 100-yen shops, many temple-vicinity gift shops, neighbourhood cafés, and coin-parking lots in Kyoto + rural areas are cash-only in practice. Tabelog "accepts cards" label is not always current. Recommend ¥5,000–10,000 cash per day for non-tourist-district dining. 7-Eleven ATMs accept most foreign cards (Visa / Mastercard / UnionPay / AmEx); Lawson / FamilyMart also work. IC cards (Suica / PASMO / ICOCA) top-up from foreign cards in Apple Wallet or physical card — recommend for transit + vending.
- **Iceland — effectively cashless.** Cash is so rare some smaller shops and food trucks won't accept it. Cards (chip + PIN or contactless) are the default for everything including public bathrooms and self-service fuel. Recommend: no cash pre-exchange beyond ~€50 in króna for emergencies; primary card should be no-foreign-transaction-fee Visa / Mastercard; some fuel stations require card's 4-digit PIN (not signature) at pay-at-pump — verify with card issuer.
- **Germany + Austria + parts of Netherlands — cash friction in reverse.** Despite Western Europe, many restaurants / cafés / small shops still prefer or require cash; contactless acceptance lags France / UK / Nordics. Carry €100–200 per person in cash; don't rely on contactless in bakeries, biergartens, Weihnachtsmarkt stalls.
- **India — UPI is default, but UPI foreign-visitor access is limited.** Most small merchants expect UPI (Paytm / PhonePe / Google Pay India) QR scans. Foreign visitors can enable UPI One World at BOM / DEL airports with prepaid INR wallet; outside that, cash and international cards fill the gap, with cards declined in many small / older merchants. Recommend: enable UPI One World at arrival airport if staying >3 days; use bank-branch ATMs inside bank lobbies (skimming risk outside).
- **Argentina — multiple exchange rates.** Official vs "blue-dollar" vs MEP / CCL rates diverge 30–80%. Visa / Mastercard sometimes triggers "dólar tarjeta" rate (better than official) automatically; cash USD via Western Union or `cueva` exchangers gets closer to blue. Verify rate picture on bluedollar.net or local source at research time — the gap is destination-defining for budget. Rare case where "bring USD cash" is substantially cheaper than cards.
- **USA — tipping is effectively a tax layer.** Sit-down restaurants 18–22% on pre-tax is the current floor in major metros (not 15% as older guides say); rideshare 15–20%; hotel housekeeping $2–5/night; porters $2/bag. Mention in the budget block, not as an afterthought — a 10-day dining-heavy US trip with 20% tipping changes the total by 15–20%.
- **Countries with capital controls / cash-import limits** — China, Egypt, Argentina, Russia, and others cap foreign-cash import/export. Surface at intake if the user mentions bringing large cash amounts, not at customs.

### Rule

- Do not cite a generic payment rule without pairing it with at least one destination-specific friction above when it applies. "Bring a credit card and some local cash" is not advice — it's a non-statement.
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

- **Ramadan (Muslim-majority countries)** — no eating / drinking / smoking / chewing gum in public during daylight hours; many restaurants closed daytime and reopen for Iftar around sunset — queues long (book ahead); alcohol only inside licensed hotels; modest dress (shoulders + knees covered, especially women). Dates shift ~11 days earlier each year; verify year-specific dates from UAE Moon Sighting Committee / Saudi Umm al-Qura calendar at intake.
- **Holi (India, late Feb–March)** — wet + dry colour throwing in public from morning through early afternoon on Holi day itself. *Specific action*: do not wear light-colored clothes you care about on Holi day and the evening before (Holika Dahan); expect colors to persist despite washing; cover camera lenses and phone ports with tape or a dry bag; apply oil / coconut oil to hair and exposed skin before going out so pigment washes out more easily; some colors are toxic synthetic — recommend participating only at organised hotel / resort parties that use food-grade colors.
- **Songkran (Thailand / Laos / Cambodia / Myanmar, ~April 13–15)** — Thai New Year water festival. *Specific action*: electronics are not safe in public spaces during these three days — carry phones in waterproof pouches (sold at any 7-Eleven during Songkran), do not bring non-waterproof cameras on the street, expect getting soaked from buckets / water guns / hoses whether participating or not. Temples and elders should not be splashed; splashing monks is offensive. Airport transfers on Songkran days should use taxis / private cars, not tuk-tuks or open transport.
- **Shabbat (Jerusalem / orthodox neighbourhoods, Israel)** — from ~1 hour before Friday sunset to ~1 hour after Saturday sunset. *Specific action*: public transport (buses / trains) stops across most of Israel during Shabbat; taxis + sherut (shared minibus) still run but with surcharge; most restaurants, supermarkets, and shops in Jerusalem + orthodox areas of Tel Aviv (e.g., Bnei Brak, Mea Shearim) are closed; hotel elevators may switch to Shabbat mode (stops every floor — slow); do not drive through orthodox neighbourhoods on Shabbat — stone throwing by residents at passing cars is documented. Plan Friday afternoon → Saturday evening as rest / hotel / Jewish-Quarter walking; resume normal itinerary Saturday night.
- **Buddhist Lent / Vassa (Thailand / Laos / Myanmar / Cambodia, ~July–October)** — three-month period opens with Asalha Puja, ends with Ok Phansa. *Specific action*: the two bookend days + Magha Puja + Visakha Puja + Vesak are legally alcohol-sale-banned nationwide in Thailand (no alcohol at bars, restaurants, 7-Eleven — hotel minibars may be locked). Surface specific banned dates at intake. Dress codes at temples stricter during this period. Ordination ceremonies around early Vassa can disrupt temple access — check target date.
- **Golden Week / O-Bon / Spring Festival / Chuseok / Tet (East Asia travel peaks)** — covered in detail in [dining-rules.md](dining-rules.md) §3; bring forward here because these trigger entire-country transport crowd-storms, not just restaurant closures. Plan return-leg transport as bookable-on-day-of-release, not 2 weeks ahead.

### Etiquette Rule

Each etiquette item must be phrased as **situation → specific action**, not abstract norms. Not "Japan is polite" but "Remove shoes before stepping onto tatami; street shoes stay in the entryway (玄関)". Cite source + research date where the rule carries legal or financial consequence (e.g., Gion photo fines, Saudi dress code).

## 7. Safety and Emergency

For every international trip (and domestic trips where the destination has non-trivial safety considerations — remote areas, high-altitude, disaster-season overlaps), include a safety and emergency section.

See [safety-and-emergency.md](safety-and-emergency.md) for the full ruleset: emergency numbers, medical access, consular support, insurance claim path, theft / loss response, and destination-specific risk notes.
