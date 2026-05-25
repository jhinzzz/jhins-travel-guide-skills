# Intake — Deep Reference (opt-in)

Extended accessibility/medical-needs detail and child age-band reference tables for `intake.md`. Only read when the party includes a member with accessibility/medical needs (§6) or minors (§7).

## 6. Accessibility and Special Medical Needs — Full Detail

When any capture below fires, every downstream section must respect it. Hotel cards show roll-in shower / elevator availability; attraction cards show stair counts + elevator status + sensory-friendly timed entries; transport cards note station step-free status; safety block includes dialysis-centre confirmation or allergen card translation. If a constraint cannot be met at a destination, surface it at intake as a trip-feasibility concern — not at page-render time.

### 6.1 Mobility

Wheelchair (manual / power), walker / cane, limited stair tolerance. Affects:
- Hotel room type (roll-in shower, elevator required)
- Attraction vetting (stair-heavy: Cinque Terre, many Kyoto temples, Santorini, Machu Picchu)
- Rental-car choice (hand controls? adapted vehicle rental has longer lead time)
- Intra-city transport (Tokyo metro older lines are elevator-incomplete; London Tube "step-free" network is partial)

### 6.2 Dialysis

Must pre-book a dialysis centre at the destination (typical lead time 4–8 weeks; longer for peak seasons and small-island destinations). Capture sessions-per-week + preferred day/time. Flag destinations with very limited capacity (Maldives, small Greek islands, rural Iceland). Include centre name + address + confirmation number in the safety section, not "find one locally".

### 6.3 Cabin Oxygen

Airlines require advance medical clearance (48h–7 days lead; some require POC model approval). Capture O₂ flow rate and whether the user owns a POC or needs airline-supplied O₂. Some airlines do not supply onboard O₂ at all (most LCCs, some long-haul carriers) — this may dictate carrier choice.

### 6.4 Pregnancy

Capture gestational week at departure + at return. Airlines enforce third-trimester cutoffs (typical: ≤28 weeks no letter; 28–36 weeks requires fit-to-fly letter dated within 7 days of flight; ≥36 weeks usually refused — verify the specific carrier). Flag destinations with Zika or malaria prophylaxis concerns. Avoid high-altitude activity (>2,500 m) and hot-spring immersion ≥40 °C.

### 6.5 Service / Assistance Animal

Airlines split "service animal" (trained, usually still cabin-accepted) from "emotional support animal" (most carriers no longer cabin-accept as of 2021+). Destinations impose quarantine / vaccination rules separately (UK / Japan / Australia / NZ / HK / Taiwan have long-lead quarantine windows — 4–10 months for rabies-free island states; EU pet-passport ~21 days post-rabies-titer). Capture animal species, weight, age, and vaccination status; calendar pre-trip vet visit and destination-authority paperwork.

### 6.6 Other Flag-and-Carry

- Severe food allergy (nut / shellfish / gluten) with epinephrine → translate allergen card into destination language per [safety-and-emergency.md](../safety-and-emergency.md) §2
- Sensory sensitivities → flag high-crowd attractions, recommend timed-entry or quiet hours
- Recent surgery (air-travel waiting period)
- Scuba certification recency if diving planned

## 7. Child Age Bands — Full Reference

When the party includes anyone under 18, capture age-at-departure per child and map to a band. The bands are not cosmetic — each triggers different downstream constraints. Do not merge all "kids" into one bucket.

### 7.1 Infant (0–2 / 在怀)

- Airline lap-infant vs bought-seat; long-haul may require a bassinet (request at booking, ~20 kg max)
- Hotel crib availability + cost
- Restaurant high-chair availability
- Stroller transport constraints (narrow alleys of Venice / Kyoto / old-town Medina may defeat a stroller — consider a carrier instead)
- Altitude: pediatric advice generally avoids >2,500 m for infants
- Most museums/attractions free; flag any age floors (wine-country / casino / adult venues refuse entry)

### 7.2 Preschool (3–5)

- Attraction attention span ~45 min; plan 1–2 anchor attractions/day max on `balanced` pace
- Walking tolerance ~1–2 km; buffer times go up
- Meal timing rigidity (early dinner, 18:00–18:30 window) may conflict with Europe/Latin American late-dinner culture — flag
- Many museums offer child-friendly audio guides or "backpack" programs — surface if available
- Theme parks: verify height minimums

### 7.3 Early School (6–9)

- Can walk 3–4 km/day; attraction tolerance rises to ~1 hour each
- Hotel: rollaway vs family-room decision
- Many attraction family-ticket discounts kick in
- Photo restrictions at geisha districts, military sites still apply — age is not a defense
- Food allergies: kid may self-report; still carry translated allergen card

### 7.4 Pre-teen (10–14)

- Mostly adult-pace capable; separate-room consideration starts (especially 12+)
- Passport signature age varies by country; most still need accompanying adult consent
- Some countries bar unaccompanied minors in hotel rooms (UAE, Saudi)
- Adult museum tickets may apply from 12 in many destinations

### 7.5 Teen (15–17)

- Adult-pace; adult-pricing near-universal
- Unaccompanied minor airline fees may still apply on certain carriers even with a parent on the same flight (rare)
- Age minimums for activities (Iceland ice-cave tour 10+; bungee / skydive typically 18+ or with parental consent)
- Alcohol access: destination legal age varies (16 for beer/wine in parts of Europe; 18 most of world; 21 US/Indonesia parts — do NOT recommend alcohol-adjacent activities as family inclusions)

### Child Carry-Forward Rule

Every downstream section respects the child bands captured at intake. Hotel cards show crib/rollaway availability + family-room capacity; restaurant cards flag high-chair / kid-menu / age-floor; attraction cards show stroller accessibility + child ticket pricing + height minimums; transport cards show lap-infant vs separate-ticket + stroller gate-check rules; itinerary pacing respects attention-span and walking-tolerance tiers above.
