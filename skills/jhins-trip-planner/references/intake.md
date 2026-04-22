# Intake

## Purpose

Capture the trip brief — dates, destination, party, budget, themes, pace, and carry-forward flags (medication, accessibility, children, self-drive readiness, food triad) — **once**, so every downstream section can rely on it without re-asking.

Applies to every request type (`planning-only`, `guide-redesign`, `existing-page-refactor`).

## Capture Relevance Rule (read first)

Do **not** ask every capture below for every trip. Ask only when the party composition, destination, or stated intent makes it relevant. Skip silently when not applicable. Examples:

- Two adults, urban trip, no health flag mentioned → skip §5 (chronic medication), §6 (accessibility), §7 (child age bands). Do not fire a question just to hear "no".
- User picks `adventure & outdoor` → §3 (adventure sub-intensity) becomes required.
- User mentions self-drive → §8 (self-drive triad) becomes required.
- User mentions a child → §7 (child age bands) becomes required.

Default posture: **ask less, then ask more when a captured answer unlocks a specific follow-up**. Never run the full capture list as a rote intake interview.

## 1. Core Inputs and Order

Ask for missing trip inputs in this order: travel dates · destination · party size and companions · trip purpose / theme · pace preference · chronic medication (if relevant) · food preferences · budget · preferred transport mode.

Question pacing:

- Ask one missing item at a time when possible.
- If three or more core inputs are missing (dates, destination, budget), batch the first two or three in one turn.
- Never exceed three questions per turn.

If the user's message implies destination inspiration ("有什么建议", "where should I go"), offer 2–3 brief destination ideas based on season + stated constraints **before** proceeding with the intake order.

## 2. Minimum Viable Brief (when to stop asking and start planning)

The brief is **usable** — i.e., detailed planning can begin — once **all four** of these are present:

- **Destination** (specific city or region)
- **Dates** (or a window with ≤7-day uncertainty)
- **Party size** (and companion composition if it affects room type / transport class)
- **Budget** (or an explicit "flexible" signal)

If any one of the four is missing, stay in scaffold mode per the Fallback Rules in SKILL.md. Do **not** block on pace / theme / food preferences — these have sensible defaults:

- Missing pace → assume `balanced`; state the default in the hero; the user can override.
- Missing theme → assume "general sightseeing"; ask only if the destination has theme-dependent logistics (e.g., adventure, festival dates).
- Missing food preferences → neutral dining picks; note that dining can be refined if the user provides a preference later.

State every default explicitly — the user should never be surprised by an assumption.

## 3. Trip Purpose / Theme

Offer a candidate list rather than leaving it open-ended — users pick faster than they invent:

nature · history & culture · food & shopping · adventure & outdoor · family & kids · romance & honeymoon · photography · wellness & spa · festival & event · business-with-leisure.

Allow multi-select. If two themes conflict in pace (e.g., adventure + wellness), surface the conflict per SKILL.md §Confirmation Checkpoints before drafting.

### Adventure sub-intensity

When the user picks `adventure & outdoor`, ask the single-day intensity ceiling they accept — adventure sub-activities are not interchangeable under one pace label:

- sunrise-hike / pre-dawn start (≤02:00 wakeup)
- full-day trek (>5 h on foot)
- open-water dive
- multi-pitch climb
- whitewater rafting

Any one of these **overrides** the nominal pace. `leisurely` + sunrise-hike is an intra-theme conflict and must be flagged before scheduling.

## 4. Pace Preference

Ask the user to pick one of three:

- **tight** — 4–6 activities/day, minimize downtime, walk-ready all day.
- **balanced** — 2–3 anchor activities/day with flex time.
- **leisurely** — 1–2 anchors/day, long meals, hotel/cafe downtime.

Pace directly affects daily card density, buffer times, and whether lunch/dinner picks can be in different districts.

## 5. Chronic Medication (skip if no party member takes long-term prescription)

Capture the **generic drug name** (not brand) at intake — not during trip preparation. Some generics legal at home are restricted or illegal at the destination:

- pseudoephedrine — restricted in Japan / UAE
- ADHD stimulants — illegal in Japan
- strong codeine / tramadol — restricted in UAE / Singapore
- some common cold-flu combinations — flagged in multiple destinations

Carry the generic list forward so the Trip Preparation parallel sub-agents can flag cross-country legality as part of their country row, rather than surfacing it only in the safety section post-draft.

## 6. Accessibility and Special Medical Needs (skip if no relevant flag)

Ask once; carry forward to transport, hotel, attraction, and safety sections. Do not surface as an afterthought. Capture whichever apply:

1. **Mobility** — wheelchair (manual / power), walker / cane, limited stair tolerance. Affects hotel room type (roll-in shower, elevator required), attraction vetting (stair-heavy: Cinque Terre, many Kyoto temples, Santorini, Machu Picchu), rental-car choice (hand controls? adapted vehicle rental has longer lead time), intra-city transport (Tokyo metro older lines are elevator-incomplete; London Tube "step-free" network is partial).
2. **Dialysis** — must pre-book a dialysis centre at the destination (typical lead time 4–8 weeks; longer for peak seasons and small-island destinations). Capture sessions-per-week + preferred day/time. Flag destinations with very limited capacity (Maldives, small Greek islands, rural Iceland). Include centre name + address + confirmation number in the safety section, not "find one locally".
3. **Cabin oxygen** — airlines require advance medical clearance (48h–7 days lead; some require POC model approval). Capture O₂ flow rate and whether the user owns a POC or needs airline-supplied O₂. Some airlines do not supply onboard O₂ at all (most LCCs, some long-haul carriers) — this may dictate carrier choice.
4. **Pregnancy** — capture gestational week at departure + at return. Airlines enforce third-trimester cutoffs (typical: ≤28 weeks no letter; 28–36 weeks requires fit-to-fly letter dated within 7 days of flight; ≥36 weeks usually refused — verify the specific carrier). Flag destinations with Zika or malaria prophylaxis concerns. Avoid high-altitude activity (>2,500 m) and hot-spring immersion ≥40 °C.
5. **Service / assistance animal** — airlines split "service animal" (trained, usually still cabin-accepted) from "emotional support animal" (most carriers no longer cabin-accept as of 2021+). Destinations impose quarantine / vaccination rules separately (UK / Japan / Australia / NZ / HK / Taiwan have long-lead quarantine windows — 4–10 months for rabies-free island states; EU pet-passport ~21 days post-rabies-titer). Capture animal species, weight, age, and vaccination status; calendar pre-trip vet visit and destination-authority paperwork.
6. **Other flag-and-carry** — severe food allergy (nut / shellfish / gluten) with epinephrine → translate allergen card into destination language per [safety-and-emergency.md](safety-and-emergency.md) §2; sensory sensitivities → flag high-crowd attractions, recommend timed-entry or quiet hours; recent surgery (air-travel waiting period); scuba certification recency if diving planned.

### Accessibility carry-forward rule

When any capture above fires, every downstream section must respect it. Hotel cards show roll-in shower / elevator availability; attraction cards show stair counts + elevator status + sensory-friendly timed entries; transport cards note station step-free status; safety block includes dialysis-centre confirmation or allergen card translation. If a constraint cannot be met at a destination, surface it at intake as a trip-feasibility concern — not at page-render time.

## 7. Child Age Bands (skip if no minors)

When the party includes anyone under 18, capture age-at-departure per child and map to a band. The bands are not cosmetic — each triggers different downstream constraints. Do not merge all "kids" into one bucket.

- **0–2 (infant / 在怀)** — airline lap-infant vs bought-seat; long-haul may require a bassinet (request at booking, ~20 kg max). Hotel crib availability + cost. Restaurant high-chair availability. Stroller transport constraints (narrow alleys of Venice / Kyoto / old-town Medina may defeat a stroller — consider a carrier instead). Altitude: pediatric advice generally avoids >2,500 m for infants. Most museums/attractions free; flag any age floors (wine-country / casino / adult venues refuse entry).
- **3–5 (preschool)** — attraction attention span ~45 min; plan 1–2 anchor attractions/day max on `balanced` pace. Walking tolerance ~1–2 km; buffer times go up. Meal timing rigidity (early dinner, 18:00–18:30 window) may conflict with Europe/Latin American late-dinner culture — flag. Many museums offer child-friendly audio guides or "backpack" programs — surface if available. Theme parks: verify height minimums.
- **6–9 (early school)** — can walk 3–4 km/day; attraction tolerance rises to ~1 hour each. Hotel: rollaway vs family-room decision. Many attraction family-ticket discounts kick in. Photo restrictions at geisha districts, military sites still apply — age is not a defense. Food allergies: kid may self-report; still carry translated allergen card.
- **10–14 (pre-teen)** — mostly adult-pace capable; separate-room consideration starts (especially 12+). Passport signature age varies by country; most still need accompanying adult consent. Some countries bar unaccompanied minors in hotel rooms (UAE, Saudi). Adult museum tickets may apply from 12 in many destinations.
- **15–17 (teen)** — adult-pace; adult-pricing near-universal. Unaccompanied minor airline fees may still apply on certain carriers even with a parent on the same flight (rare). Age minimums for activities (Iceland ice-cave tour 10+; bungee / skydive typically 18+ or with parental consent). Alcohol access: destination legal age varies (16 for beer/wine in parts of Europe; 18 most of world; 21 US/Indonesia parts — do NOT recommend alcohol-adjacent activities as family inclusions).

### Child carry-forward rule

Every downstream section respects the child bands captured at intake. Hotel cards show crib/rollaway availability + family-room capacity; restaurant cards flag high-chair / kid-menu / age-floor; attraction cards show stroller accessibility + child ticket pricing + height minimums; transport cards show lap-infant vs separate-ticket + stroller gate-check rules; itinerary pacing respects attention-span and walking-tolerance tiers above.

## 8. Self-Drive Readiness Triad (skip if not self-driving)

When the user chooses self-drive / rental car, capture three driver-readiness elements **before** planning daily routes (analogous to the meal × cuisine × area binding for dining):

1. **Licence validity at the destination** — mainland China does **not** recognize foreign or international driver's licences; Japan requires a JAF translation of the original licence (not a standard IDP); most other countries accept a valid home licence + IDP. Confirm the licence actually works at the destination — do not assume.
2. **Driving side** — LHD (left-hand drive / right-hand traffic) vs RHD (right-hand drive / left-hand traffic: UK / AU / NZ / Japan / HK / SG / Thailand / South Africa / Ireland / parts of Caribbean). If the user has never driven on the destination's side, flag it and recommend a short adaptation day as the first leg — not a long transfer.
3. **Daily driving-time comfort ceiling** — ask the max single-day driving time the user is comfortable with. Lower the default ceiling when the party includes **elderly, young children, pregnant passengers, pets**, or the route crosses **mountain passes / unpaved roads / >3,500 m altitude / night driving**. Typical ceilings: 6 h solo fit adult; 4–5 h with elderly/kids; 3–4 h on high-altitude or mountain days.

## 9. Food Preferences — meal × cuisine × area triad

When the user mentions specific meal intent, capture **three elements** together:

- **Meal slot** — which day / lunch or dinner
- **Cuisine** — ramen / sushi / izakaya / sashimi / local specialty, etc.
- **Area** — station, neighborhood, or anchor

All three bind the recommendation per [dining-rules.md](dining-rules.md) §5 — do not discard the area constraint to get a better cuisine match or vice versa.

When the user uses "or" between two cuisines ("izakaya or sashimi"), capture both and plan to offer two main-line candidates, not a merged pick.

## 10. Hotel Room Style and Transport Preference

- If hotel suggestions are needed and room style is missing, ask after the core inputs.
- If the user has not mentioned transport preferences, ask after budget: "Do you have a preferred transport mode for getting there and back (flight, high-speed rail, rental car, etc.)?"
