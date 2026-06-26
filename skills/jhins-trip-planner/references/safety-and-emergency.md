# Safety and Emergency

Every trip needs a minimum viable safety net: emergency contacts, medical access, consular support, insurance-claim path, theft/loss response. A missing emergency number or wrong consular address turns a solvable incident into a trip failure.

Applies whenever the output includes a full trip plan (`guide-redesign` / `existing-page-refactor`) or a multi-day itinerary in `planning-only`. For tables, destination examples, full ethical guardrails, and multi-city parallel verification protocol, see [deep/safety-and-emergency.md](deep/safety-and-emergency.md).

## 1. Emergency Numbers (Destination-Specific)

### Rule

- Every international trip output lists destination-real emergency numbers. Do not assume "911" works globally.
- Record: police · fire · ambulance / medical · tourist police (where it exists) · EU 112 unified where applicable.
- List numbers on the output directly, not as a URL the user has to open.
- For destinations with poor English dispatcher coverage: note explicitly + recommend a translation app for the call.

Trigger: every international trip. Pointer: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §1.

## 2. Medical Access

### Rule

For each destination city: one foreigner-friendly hospital (name + address + distance from tourist zone) · after-hours pharmacy · common-drug name translation · chronic-medication legality carry-forward from [intake.md](intake.md) §5.

Accessibility / special medical needs from [intake.md](intake.md) §6 are resolved here by name — not re-asked, not deferred to "find one locally". They are **blockers, not notes**.

Trigger: every international trip or domestic with medical carry-forward. Pointer: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §2.

## 3. Consular / Embassy Support

### Rule

International trips list traveller's home-country embassy / consulate for the destination city: name, address, main phone, emergency after-hours line, hours, reach-by-transit.

**Partial numbers are worse than no number.** Do not write `+81-3-xxxx-xxxx` skeletons — a partial number looks real under stress. If unverifiable, leave the field empty and write "→ Fetch from the consulate official site before departure: {URL}".

Trigger: every international trip. Rationale + allergen-card template + address fallback rule: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §3.

## 4. Travel Insurance — Claim Path

### Rule

The SKILL.md already recommends purchasing insurance. This section is about what to do when something happens:

- Policy details before departure (claim hotline, policy number, claim email) stored in phone + printed.
- Evidence the insurer expects, by claim type (medical / theft / cancellation).
- Cashless vs reimbursement — destination-specific (Thailand / Singapore direct-billing; US / Europe reimburse-only).
- Output rule: "Call insurer BEFORE incurring large medical cost — many policies require pre-approval for hospitalisation."

Pointer: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §4.

## 5. Theft / Loss Response

### Rule

Concrete step order for: passport · wallet / cards · phone · luggage at airport. Put steps as short numbered lists, not prose — people panicking cannot read paragraphs.

Key windows: passport via embassy 1–5 working days · card freeze **before** police report · airport PIR **before leaving arrival area**.

Pointer: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §5.

## 6. Destination-Specific Risk Notes

### Rule

Only the risks actually significant at this destination, at the time of travel. No generic filler.

Every risk item phrased as **risk → specific trigger → specific action**. Not "watch out for pickpockets" but "On Rome Metro Line A between Termini and Vatican, pickpockets work in teams at rush hour — keep phone in inner zipped pocket."

When risk mitigation tells the traveller how to pick a safer venue / operator / taxi, name the destination-authoritative platform per [travel-sources.md](travel-sources.md) — not a default TripAdvisor floor.

Two risk classes recur and are easy to miss — apply when triggered:

- **Thermal-immersion safety for vulnerable travellers** — hot spring / onsen / sento / thermal bath + a vulnerable traveller (young child, elderly, cardiac/blood-pressure condition; pregnancy heat limits already covered at [deep/intake.md](deep/intake.md) §6.4) → keep immersion brief and in the coolest available pool, exit at the first sign of flushing / dizziness / drowsiness, hydrate between dips, and **surface the facility's own posted age-floor and time-limit** (most onsen/spas post them at the entrance). Infants are generally not recommended in hot springs. Do **not** state a specific pediatric temperature or minute threshold as fact — pediatric limits are facility-specific and not reliably citable; direct the user to the posted limit or pediatric guidance. Fires whenever a thermal bath appears anywhere in the itinerary and the party includes a vulnerable traveller — carry-forward from [intake.md](intake.md) §6/§7. Pointer: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §6.
- **Disaster / closure-status recheck** — fires only on a **specific signal**, not ambient risk (do not fire on every trip to a seismic country): (a) a named attraction/region carries a known post-disaster closure or recovery status (e.g. Taroko post-2024-quake), OR (b) the destination is in an active official advisory window at research time (raised volcano alert, wildfire evacuation order, post-quake aftershock advisory), OR (c) trip dates fall in a named seasonal hazard window per [weather-and-output.md](weather-and-output.md) §1. Action: recheck the **official closure / operating status** via the government tourism board / national-park authority / disaster agency (the authority-source class in [travel-sources.md](travel-sources.md) §Source Selection Rules — *not* the venue-level operating-status check, which is for restaurants/shops), 3–5 days before departure, and append it as **one line inside the existing pre-trip recheck block** ([dining-rules.md](dining-rules.md) §8) — do not emit a second recheck block. The hazard-forecast / AQI / advisory recheck already lives in [weather-and-output.md](weather-and-output.md) §1 — do not duplicate it here; this rule is closure-status only. If the authority page is login-walled / 404 / contradictory, apply the [travel-sources.md](travel-sources.md) §Login-Wall Fallback exhaustion gate; if status is genuinely unconfirmable, output the recheck as a pre-departure to-do **with the official URL** — never infer "open / all-clear" from a page that did not load.

### Ethical / responsible-tourism guardrails

Flag and redirect red-flag items proactively, not silently drop. Categories: captive wildlife · ethnic-village photo tours · marine-animal contact · orphanage voluntourism · wildlife / cultural products of endangered species · drug tourism · disaster / poverty tourism.

One-line phrasing + one redirect alternative. Do not moralise.

Trigger: destination has material risk, or user request / itinerary touches a red-flag item. Pointer: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §6 + §7.

## 7. Output Placement

- `planning-only`: short "Safety & Emergency" block near the end — emergency numbers + embassy one-liner + insurer claim hotline reminder. 5–10 lines.
- `guide-redesign` / `existing-page-refactor`: full section with all 6 sub-blocks, placed after Hotels / Budget, before Reference Appendix.
- Discreet placement: do not open the guide with an alarming safety wall. Do not bury so deep the user cannot find it in an emergency.

## 8. Data Traceability

All safety info follows skill-wide traceability rules — cite source (official consular site, emergency-services site, insurer policy, reputable travel-advisory like SmartTraveller AU / State Department US / FCDO UK / MFA CN) and research date. Phone numbers and addresses are the category most likely to be wrong if pulled from training data.

## 9. Parallel Verification for Multi-City Trips

### Rule

Trigger: trip crosses ≥ 2 cities or ≥ 2 countries. Run the fan-out per SKILL.md §Batch Verification — slicing axis: one city or country's full safety block per sub-agent.

Per-destination return fields: emergency numbers · foreigner-friendly hospital + address · embassy / consulate + after-hours line · insurer claim hotline · top 2–3 destination risks with §6 phrasing · source URLs · research date.

Domain-specific rule: the main conversation de-duplicates shared facts across cities before final placement. Pointer: [deep/safety-and-emergency.md](deep/safety-and-emergency.md) §8.

## Non-Goals

- Do not manufacture alarmist content. Goal is preparedness, not fear.
- Do not recommend specific insurance products by brand without evidence — describe coverage to look for.
- Do not replace this section with a link to a government advisory — include key operational numbers + addresses directly.
- Do not list generic "be careful" advice. Every risk item passes §6 phrasing.
