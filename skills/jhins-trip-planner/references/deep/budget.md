# Budget — Deep Reference (opt-in)

Extended tables, examples, and rationale for `budget.md`. Only read when the main file's pointer directs you here (e.g., complex cross-currency trip, tight budget with trade-offs, unfamiliar region band).

## 1. Category Split — Region Band Table

Defaults when the user gives a single total. Split excludes round-trip **international** transport (flights / long-haul rail). For cross-strait (mainland ↔ Taiwan / HK / Macau), treat as international for the purpose of this band.

| Region | Transport (intra-dest) | Lodging | Dining | Attractions | Shopping | Buffer |
|---|---|---|---|---|---|---|
| East Asia (Japan / Korea / Taiwan) | 15% | 35% | 20% | 10% | 10% | 10% |
| Mainland China + SEA cities | 10% | 30% | 20% | 15% | 15% | 10% |
| Western Europe | 12% | 35% | 25% | 10% | 8% | 10% |
| Nordics / Iceland | 20% | 30% | 25% | 10% | 5% | 10% |
| United States | 15% | 40% | 25% | 10% | 5% | 5% |
| Middle East / Gulf | 10% | 45% | 20% | 10% | 10% | 5% |
| South / SE Asia (Bali / Thailand rural) | 10% | 25% | 20% | 15% | 20% | 10% |

### Theme and party adjustments (one at a time; state when applied)

- Food-focused → dining +5 / shopping −5
- Adventure → attractions +5 / shopping −5
- Family with kids → buffer +5 / shopping −5
- Luxury lodging override stated → back-check other categories; surface conflict rather than rebalancing silently

**Buffer is non-negotiable.** Removing buffer to fit a tight budget is how the 15% overage happens in the first place.

**Stacking rule**: if two adjustments push the same category to zero or negative (e.g., food-focused + kids both cutting shopping), do **not** silently rebalance. Either ask the user, or redistribute the second adjustment to a non-overlapping category + state it.

## 2. Hidden Costs — Extended Checklist

Format: **situation → specific line item**. Surface only when the destination or party triggers it.

- **Entry / departure tax** → Bali IDR 150k per person on departure (can be pre-paid online); Venice day-visitor fee €5 (peak days); Bhutan daily SDF; Maldives green tax per night per guest; Dominican Republic tourist card; Egypt Sinai visa stamp.
- **Tipping** → US 18–22% pre-tax at sit-down restaurants + rideshare 15–20% + hotel housekeeping $2–5/night + porters $2/bag (10-day US trip swings 15–20% of dining total); Middle East + South Asia 10%; East Asia 0 (tipping can offend — budget zero, do not pad).
- **IC / transit card deposits** → Japan Suica ¥500 refundable (but refund-in-person at Midori no Madoguchi); HK Octopus HK$50; Taiwan EasyCard NT$100; London Oyster £7 non-refundable if unregistered. These rarely "cost" anything but they tie up cash at start-of-trip.
- **Foreign-transaction fees** → Most Chinese cards + many US cards charge 1.5–3% FX; quietly adds 3–5% to total card spend across a trip. Check card before departure; if FX fee applies, budget +3%.
- **Dynamic currency conversion (DCC)** → POS terminals in Europe / UK / Turkey offer "pay in your home currency" — always refuse (rates are 5–10% worse than network rate). Not a budget line, but budget the 5% loss if the traveller doesn't know to refuse.
- **Duty-free liquid limit on carry-on** → departure country may allow, transit country may re-screen and confiscate. Matters when buying specialty alcohol / cosmetics as souvenirs. Budget the repurchase cost or the checked-luggage fee instead.
- **Self-drive hidden line items** → rental base + CDW / SCDW insurance (often mandatory, 30–50% of base) + fuel + toll roads (Italy, France, Japan, US turnpikes) + parking (Japanese city hotels often charge ¥2000–3000/night on top of room rate) + one-way drop-off fees. See [transportation.md](../transportation.md) §Rental Car / Self-Drive.
- **Seasonal surcharges** → peak-period hotels 1.5–3x (Japan GW / Europe Christmas / Bali high season / Maldives + Caribbean December–February); ski / dive charter peak; national-park entrance premiums during bloom / foliage weeks.
- **Customs / duty on returning goods** → destination-of-return duties (China ¥5000 personal limit; US $800 returning-resident; EU €430 air / €300 land); Australia + NZ biosecurity declarations. Relevant when specialty shopping is part of the trip per [local-specialties.md](../local-specialties.md) §Customs and Transport Constraints.
- **Attraction child pricing** → by height (East Asia: Taipei 101 under-115cm free; TRA under-115cm free) or by age (Western: under-5 free, 6-11 half). Materially affects family-trip attraction budget.
- **Night-market / hawker cash stacking** → Taiwan night markets, Singapore hawker centers, Hong Kong dai pai dong, Thailand street carts are cash-heavy. Family of 3 × 4 nightmarket dinners can be NT$4000+ in cash alone. Plan ATM trips + withdraw-fee stacking.

## 3. Refundable vs Non-Refundable — Extended Guidance

Refundable tickets / rooms typically cost 15–40% more.

### Spend the premium (7 triggers)

- Traveller over 70 or with chronic condition that risks last-minute cancellation.
- Pregnancy in or beyond 28 weeks (many airlines restrict boarding; non-refundable = dead money if restricted).
- Primary-school-age-or-younger kids on the trip (last-minute illness rate is meaningfully higher). Chinese context: 小学阶段及以下儿童（6-12 岁及以下）。
- Trip window straddles a known risk event (typhoon season sweet spot, wildfire-prone region in dry season, Middle East around a political anniversary, earthquake-recovery zone such as Taroko 2024+).
- Cross-border trip where visa issuance is still pending at booking time.
- Narrow connection (<2h domestic / <3h international) — refundable return leg buys flexibility if first leg delays.
- Business trip where a meeting could shift — the refundable premium is a cheap hedge.

### Skip the premium (4 scenarios)

- Solo traveller, flexible schedule, non-peak season.
- Short trip (≤3 days) to a low-risk destination (same-country, well-connected).
- Multi-leg itinerary where reshuffle is cheap anyway (European rail passes, open-jaw flights already have flexibility).
- Party size × room count × nights makes the refundable premium exceed ~20% of the lodging total — at that point, trip insurance with medical + cancellation coverage is usually cheaper.

### Output rule

State the decision explicitly: "Flights booked non-refundable (save ¥1,200/person); hotel Day 1 refundable (arrival-day flexibility); hotels Day 2–5 non-refundable (peak rates)." Don't leave the user to guess. When the party mix triggers "spend the premium" but the user insists on non-refundable, add a one-line travel-insurance recommendation per [trip-prep.md](../trip-prep.md) §5.

## 4. FX and Payment Timing — Extended Guidance

For cross-currency trips where the stated budget is in the traveller's home currency, add a one-line FX assumption. A 5% FX shift across 3 months is normal; the budget needs to say what rate it assumed.

- **Lock the rate early** → when a bank / broker offers forward exchange or a fixed-rate travel card (Wise, Revolut, domestic bank card with fixed rate lock) for a currency that has been volatile in the past 6 months (TRY, ARS, JPY, ISK, EGP recently). Lock at trip confirmation, not at departure.
- **Hold the currency, don't convert** → when the destination has capital controls or parallel exchange rates (Argentina blue dollar, Egypt unofficial, Russia SWIFT constraints for Chinese cards). Bring USD / EUR cash and convert on the ground via trusted channels. Cite per [trip-prep.md](../trip-prep.md) §3 destination friction.
- **Pay by card at ATM / network rate** → when the destination is stable and the card has no FX fee (most of EU / Japan / Korea / Taiwan / US). Carry cash ≤ 1 day's emergency; top up at 7-Eleven / airport ATM on arrival.
- **Pay cash** → where card acceptance is thin and rate differential is negligible (Germany / Austria bakeries, Japan rural, India small merchants, Vietnam / Cambodia / Laos outside tourist hubs, **Taiwan night markets + rural hot-spring ryokans**). See [trip-prep.md](../trip-prep.md) §3.
- **Avoid DCC** → always refuse "pay in your home currency" at any POS. Mention once in trip-prep output when the destination is Europe / UK / Turkey / Thailand-tourist-zone.

### Output rule for cross-currency budgets

Every cross-currency budget section must state:
> "Rates assumed: 1 CNY = X JPY as of {research date}; 5% FX buffer included in the Buffer category above."

If the trip is more than 6 weeks out, explicitly name the FX risk.

Do not recommend a specific card / app by product name without a source or a "verify current terms" caveat — card terms change frequently.
