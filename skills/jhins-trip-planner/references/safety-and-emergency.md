# Safety and Emergency

## Purpose

Ensure every trip output carries the minimum viable safety net: emergency contacts, medical access, consular support, insurance-claim path, and theft/loss response. These are not decorative — a missing emergency number or the wrong consular address can turn a solvable incident into a major trip failure.

Applies whenever the output includes a full trip plan (`guide-redesign` / `existing-page-refactor`) or a multi-day itinerary in `planning-only`. For single-day local advice, apply only the subset that fits.

## 1. Emergency Numbers (Destination-Specific)

Every international trip output must include the destination's real emergency numbers. Do not assume the US "911" works globally.

### What to record

- **Police**
- **Fire**
- **Ambulance / medical**
- **Tourist police** (where it exists — Thailand, Italy, Greece, Egypt, Turkey, Malaysia, etc.)
- **Unified / pan-region number** if applicable (EU 112 works across all EU member states; 911 works in US / Canada / most of Latin America; 112 also works on GSM phones in many countries regardless of local number)

### Common numbers — examples, verify per trip

| Region | Emergency |
|---|---|
| Mainland China | 110 (police) · 119 (fire) · 120 (medical) · 122 (traffic) |
| Hong Kong / Macau | 999 |
| Taiwan | 110 · 119 |
| Japan | 110 (police) · 119 (fire/medical) |
| South Korea | 112 (police) · 119 (fire/medical) |
| EU (all members) | 112 (unified) |
| UK | 999 or 112 |
| US / Canada | 911 |
| Australia | 000 or 112 (from mobile) |
| Thailand | 191 (police) · 1669 (medical) · 1155 (tourist police) |
| Singapore | 999 (police) · 995 (fire/medical) |
| UAE | 999 (police) · 998 (medical) · 997 (fire) |

### Rule

- List the numbers on the output, not as a URL the user has to open.
- For destinations with poor English dispatcher coverage (Japan, Korea, China rural, most of Europe outside major cities), note it explicitly and recommend a translation app for the moment of call.

## 2. Medical Access

For every destination city, name **at least one hospital** the user can realistically reach that serves foreign / non-local patients.

### What to record per destination

- **One foreigner-friendly / international hospital** (English-speaking or traveller-clinic capable) with address and distance from the typical tourist zone.
- **After-hours pharmacy** or 24-hour drugstore for minor issues (common in Japan 24h 调剂薬局 / US CVS 24h / Hong Kong Mannings / Singapore Guardian).
- **Common-drug name translation** for top traveller ailments where the destination uses non-English branding — e.g., in Japan パブロン (cold), ロキソニン (ibuprofen analog), 正露丸 (anti-diarrhoea).
- **Chronic-medication rule**: chronic medication is captured at intake per [planning-rules.md](planning-rules.md) §Intake (generic name, not brand). By the time planning reaches this section, the Trip Preparation parallel sub-agents have already attached a per-country legality flag for each generic. Use those flags here — if any generic is restricted or illegal at a destination (pseudoephedrine in Japan / UAE, ADHD stimulants in Japan, strong codeine / tramadol in UAE / Singapore), surface the specific drug, the specific country, and the specific alternative (carry a doctor's letter + original prescription + import-permit application window, or substitute with a permitted formulation). Do not re-ask the user for the chronic condition at this stage.

### Rule

- Do not fabricate hospital names. If evidence is thin, fall back to the district-level guidance: "Shibuya has X hospital 24/7 ER — verify current ER hours on their website." Cite source and research date.

## 3. Consular / Embassy Support

For international trips, list the traveller's home-country **embassy or consulate** for the destination city (or the closest one if the destination has no consulate).

### What to record

- **Embassy / consulate name and address** in the destination country.
- **Main phone** and **emergency after-hours number** (most consulates have a separate line for citizen emergencies — this is what you want if a passport is lost on Saturday night).
- **Hours** (most are workday-hours only; emergency line 24/7).
- **Reach-by-transit** instruction (metro line + nearest station / walk from major landmark).

### Rule

- Identify the traveller's home country from the intake (visa discussion, passport, nationality). Do not assume — if unclear, ask.
- Do not fabricate addresses or phone numbers. Verify on the embassy's official site and cite the research date.
- **Partial numbers are worse than no number.** Do not write a phone-number skeleton like `+971-50-xxx` or `+81-3-xxxx-xxxx` even with a "verify" tag — a partial number looks real and can be misread under stress. If the exact number cannot be confirmed, write "→ Fetch from the consulate official site before departure: {canonical site URL}" and leave the number field empty. Same rule for street addresses that contain an unverified number.

## 4. Travel Insurance — Claim Path (not just purchase)

The SKILL.md already recommends purchasing insurance. This reference is about **what to do when something happens**.

### What to record

- **Policy details before departure**: claim hotline (usually 24/7, often a local-access number per country), policy number, claim email — stored both in phone and printed.
- **Accept-what evidence** the insurer expects: for medical → receipts + diagnosis note + prescription; for theft → police report filed within 24 hours (many insurers reject late reports); for trip cancellation → airline / hotel written cancellation confirmation.
- **Cashless vs reimbursement**: note whether the policy has direct-billing hospitals at the destination, or whether the user must pay upfront and claim back. Direct-billing is common in Thailand / Singapore / Japan top-tier hospitals; reimbursement-only is common in US / Europe.

### Rule

- The output should state explicitly: "Call insurer BEFORE incurring a large medical cost if possible — many policies require pre-approval for hospitalisation."
- If the user has not bought insurance yet, flag it; if already bought, don't re-recommend purchasing, focus on claim path.

## 5. Theft / Loss Response

Concrete step order, not platitudes. Platitudes ("be careful with your belongings") are not safety advice.

### Passport lost or stolen

1. File a local police report (get the case number and stamped copy — most insurers and your embassy require this).
2. Contact the home-country embassy / consulate (use the number from §3) — they issue emergency travel documents.
3. Notify the airline if the return flight is soon — they can hold the seat while documents are reissued.
4. Typical turnaround for emergency travel documents: 1–5 working days; longer if the embassy is in a different city from the incident.

### Wallet / cards stolen

1. Immediately call each card's issuer hotline to freeze — before police report. (Apps like WeChat Pay / Alipay / card app's in-app freeze are faster than calling overseas.)
2. Then file police report for insurance claim.
3. Use a backup card (recommend traveller carries a separate backup card in a different location — not in the same wallet).
4. If cash-only: embassy may provide emergency loan or wire-transfer facilitation; inform family to send a wire (Western Union / Wise / bank transfer).

### Phone lost or stolen

1. Remote-lock via iCloud / Google Find-My (requires prior setup).
2. Call carrier to suspend SIM.
3. If the eSIM is tied to the device: buy a new local SIM as a temporary fix.
4. Change passwords of critical apps (banking, email, WeChat/LINE) from any other device.

### Luggage lost at airport

1. File a **Property Irregularity Report (PIR)** at the airline baggage counter **before leaving the arrival area** — claims filed later are usually rejected.
2. Keep the baggage claim tag.
3. Insurers typically cover delayed-baggage expenses (toiletries, one change of clothes) up to a cap — keep receipts.

### Rule

- Put these steps as short numbered lists in the output, not prose. People panicking cannot read paragraphs.
- Include a one-line "stay-calm" directive at the top — not cheerful, just practical: "Step 1 before anything else: go to a well-lit public place and breathe."

## 6. Destination-Specific Risk Notes

Include only the risks that are actually significant at the destination, at the time of travel. Do not generic-filler.

### Common categories

- **Theft / pickpocket hotspots** — Rome / Paris / Barcelona metro, Bangkok tuk-tuk scams, NYC subway late hours, etc. Name the **specific zone and time**, not "be careful in the city".
- **Traffic and road safety** — Vietnam scooter chaos, Italian driving style, India traffic reality, crossing the street in Hanoi, etc. Note relevant behaviours.
- **Natural hazards aligned to trip dates** — Japan typhoon season (Aug–Oct), Philippines typhoon, Caribbean hurricane (Jun–Nov), Bali rainy season / dengue, Thailand jellyfish on specific beaches in specific months.
- **Political / demonstration risk** — only if the traveller's date overlaps known events; do not speculate.
- **Altitude sickness** — >3,000 m destinations: Tibet, Cusco/Machu Picchu, La Paz, Aconcagua, Lijiang's Jade Dragon area. Include acclimatisation advice + Diamox consultation note.
- **Food & water** — tap-water-drinkable vs not; street-food cautions specific to the destination.

### Rule

- Every risk item must be phrased as: **Risk → specific trigger → what the traveller actually does**. Not "watch out for pickpockets" but "On Rome Metro Line A between Termini and Vatican, pickpockets work in teams at rush hour — keep phone in inner zipped pocket, no exceptions."
- When the risk mitigation tells the traveller how to pick a safer venue (e.g., avoiding tourist-trap restaurants in Trevi / Navona, picking a trustworthy taxi stand, choosing a certified tour operator), **name the destination-authoritative platform** per [travel-sources.md](travel-sources.md) rather than the first rating platform that comes to mind. For Rome restaurants that means Gambero Rosso / TheFork / Dissapore alongside Google Maps and TripAdvisor; for Tokyo dining it means Tabelog; for mainland China 大众点评; for UAE tour operators the DTCM-certified list. Do not default to "TripAdvisor > X.X stars" globally.

## 7. Output Placement

In the trip deliverable, the safety section should be:

- **For `planning-only`**: a short "Safety & Emergency" block near the end — emergency numbers + embassy one-liner + insurance claim hotline reminder. 5–10 lines.
- **For `guide-redesign` / `existing-page-refactor`**: a full section with all 6 sub-blocks above, placed after Hotels / Budget and before the Reference Appendix.
- **Discreet placement**: do not open the guide with an alarming safety wall — the user is planning a fun trip. But do not bury it so deep the user cannot find it in an emergency. A sidebar / card-row format works.

## 8. Data Traceability

All safety and emergency information follows the same traceability rules as the rest of the skill — cite the source (official consular site, official emergency-services site, insurer policy doc, reputable travel-advisory like SmartTraveller AU / State Department US / FCDO UK / Ministry of Foreign Affairs CN) and research date.

Do not cite "general knowledge" — phone numbers and addresses are exactly the category most likely to be wrong if pulled from training data.

## 9. Parallel Verification for Multi-City Trips

A multi-city international trip easily generates 15+ independent research tasks (for each city: emergency numbers × medical facility × consulate × insurer hotline × destination-specific risks). Do not serialize these in the main conversation.

### Rule

- When the trip crosses **2 or more cities** or **2 or more countries**, spawn **2–3 parallel sub-agents** — each covering one city or one country's full safety block.
- Each sub-agent returns a structured row per destination: **emergency numbers · foreigner-friendly hospital + address · embassy / consulate + after-hours line · insurer claim hotline · top 2–3 destination-specific risks with §6 phrasing · source URLs · research date**.
- The main conversation does synthesis, de-duplication across cities (e.g., same consulate serves two stops), and final placement in the output.
- Give the user a short status line when dispatching (e.g., "Dispatched 3 sub-agents for safety verification").

This follows the same batch-verification pattern as [dining-rules.md](dining-rules.md) §10.

## Non-Goals

- Do not manufacture alarmist content. The goal is preparedness, not fear-mongering.
- Do not recommend specific insurance products by brand without evidence — describe what coverage to look for instead.
- Do not replace this section with a link to a government travel advisory — include the key operational numbers and addresses directly.
- Do not list generic "be careful" advice. Every risk item must pass the §6 phrasing rule (specific trigger + specific action).
