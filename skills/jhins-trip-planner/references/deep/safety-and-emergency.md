# Safety and Emergency — Deep Reference (opt-in)

Extended emergency number table, medical access detail, partial-number ban rationale, insurance claim path, theft/loss step-by-step, destination-specific risks, and ethical-tourism guardrails.

Only read when the trip has: multi-country / multi-city safety block, chronic-medication or accessibility carry-forward, incident-response output, or user-mentioned high-risk activity (captive wildlife, orphanage visit, drug tourism, disaster zone).

## 1. Emergency Numbers — Common Destinations

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

Record: police · fire · ambulance / medical · tourist police (where it exists — Thailand, Italy, Greece, Egypt, Turkey, Malaysia) · unified number (EU 112 works everywhere; 112 also works on GSM phones in many countries regardless of local number).

For destinations with poor English dispatcher coverage (Japan, Korea, China rural, most of Europe outside major cities), note explicitly + recommend a translation app for the moment of call.

## 2. Medical Access — Extended

Record per destination:

- **One foreigner-friendly / international hospital** (English-speaking or traveller-clinic capable) with address and distance from the typical tourist zone.
- **After-hours pharmacy** or 24-hour drugstore (Japan 24h 调剂薬局 / US CVS 24h / Hong Kong Mannings / Singapore Guardian).
- **Common-drug name translation** — Japan パブロン (cold), ロキソニン (ibuprofen analog), 正露丸 (anti-diarrhoea); Chinese 消炎药 / 止泻药 / 退烧药 equivalents; etc.
- **Chronic-medication legality** — carry-forward from `intake.md §5`. By the time planning reaches this section, Trip Preparation parallel sub-agents have already attached per-country legality flags. Use those flags; do not re-ask.

### Accessibility & special medical needs (carry-forward from intake §6)

When intake captured any of the following, the safety block must resolve them by name — do not re-ask, do not defer to "find one locally":

- **Dialysis**: name the booked center + address + confirmation number + session day/time. If unbooked at the time of planning, surface as a blocker (not a to-do) with the typical lead time (4–8 weeks; longer for Maldives / small Greek islands / rural Iceland).
- **Cabin oxygen**: carrier-specific medical clearance status (requested / approved / denied) + POC model if user-owned. If the carrier does not supply onboard O₂, flag carrier-change as a trip-feasibility issue.
- **Severe food allergy**: include the allergen card translated into the destination's language (not a phrase-book snippet — a literal card the user can hand to a server). Example Japanese: 「私は落花生アレルギーがあります。摂取するとアナフィラキシーを起こします。調理に落花生・落花生油を一切使わないでください。」Cite the translator or official allergy-association source.
- **Service animal**: destination-authority paperwork status (quarantine lead time cleared? vaccination/titer dates logged?). If paperwork is incomplete at the time of planning, this is a trip-feasibility blocker.
- **Sensory sensitivities**: note which planned attractions offer quiet hours / sensory-friendly sessions + how to book them.

Accessibility/medical carry-forward items are **blockers, not notes**.

## 3. Partial-Number Ban (rationale)

Do not fabricate hospital names or consular phone numbers. If evidence is thin, fall back to district-level guidance: "Shibuya has X hospital 24/7 ER — verify current ER hours on their website."

**Partial numbers are worse than no number.** Do not write a phone-number skeleton like `+971-50-xxx` or `+81-3-xxxx-xxxx` even with a "verify" tag — a partial number looks real and can be misread under stress. If the exact number cannot be confirmed, write:

> "→ Fetch from the consulate official site before departure: {canonical site URL}"

and leave the number field empty. Same rule for street addresses containing an unverified number. Consulates and hospitals are the two highest-stakes categories.

## 4. Consular / Embassy Support — Extended

Record per destination city:

- Embassy / consulate name and address.
- Main phone **and** emergency after-hours number (most consulates have a separate line for citizen emergencies — this is what you want if a passport is lost on Saturday night).
- Hours (most are workday-hours only; emergency line 24/7).
- Reach-by-transit instruction (metro line + nearest station / walk from major landmark).

Identify the traveller's home country from intake. Do not assume. Verify on the embassy's official site and cite research date.

## 5. Insurance Claim Path — Extended

- **Policy details before departure**: claim hotline (usually 24/7, often a local-access number per country), policy number, claim email — stored in phone + printed.
- **Accept-what evidence**:
  - Medical → receipts + diagnosis note + prescription.
  - Theft → police report filed within 24 hours (many insurers reject late reports).
  - Trip cancellation → airline / hotel written cancellation confirmation.
- **Cashless vs reimbursement**: direct-billing common in Thailand / Singapore / Japan top-tier hospitals; reimbursement-only common in US / Europe.

Output should state: "Call insurer BEFORE incurring a large medical cost if possible — many policies require pre-approval for hospitalisation." If not yet purchased, flag it; if purchased, don't re-recommend purchase — focus on claim path.

## 6. Theft / Loss Response — Full Steps

### Passport lost or stolen

1. File a local police report (get the case number and stamped copy — most insurers and your embassy require this).
2. Contact home-country embassy / consulate (§4 number) — they issue emergency travel documents.
3. Notify the airline if the return flight is soon — they can hold the seat while documents are reissued.
4. Typical turnaround for emergency travel documents: 1–5 working days; longer if the embassy is in a different city.

### Wallet / cards stolen

1. Immediately call each card's issuer hotline to freeze — before police report. (In-app freeze via WeChat Pay / Alipay / card app is faster than overseas phone calls.)
2. Then file police report for insurance claim.
3. Use a backup card (recommend traveller carries a separate backup in a different location — not same wallet).
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

Format rule: short numbered lists in the output, not prose. People panicking cannot read paragraphs. Include a one-line "stay-calm" directive: "Step 1 before anything else: go to a well-lit public place and breathe."

## 7. Destination-Specific Risk — Phrasing Template

Format: **risk → specific trigger → specific action**. Not "watch out for pickpockets" but:

> "On Rome Metro Line A between Termini and Vatican, pickpockets work in teams at rush hour — keep phone in inner zipped pocket, no exceptions."

Common categories: theft / pickpocket hotspots · traffic and road safety · natural hazards aligned to trip dates (typhoon season Aug–Oct Japan / Philippines; Caribbean hurricane Jun–Nov; Bali rainy season + dengue) · political / demonstration risk (only if dates overlap known events) · altitude sickness (>3,000m: Tibet, Cusco, La Paz, Aconcagua) · food & water hygiene.

When risk mitigation tells the traveller how to pick a safer venue / operator / taxi, **name the destination-authoritative platform** per [travel-sources.md](../travel-sources.md). For Rome restaurants: Gambero Rosso / TheFork / Dissapore + Google Maps + TripAdvisor. For Tokyo: Tabelog. For mainland China: 大众点评. For UAE tour operators: DTCM-certified list. Do not default to "TripAdvisor > X.X stars" globally.

## 8. Ethical / Responsible-Tourism Guardrails — Full List

Some popular activities are not safe for animals, communities, or the traveller's own legal exposure. Flag and redirect rather than recommend by default. Every item: *what to avoid → why → what to recommend instead*.

- **Captive-wildlife contact and rides** — avoid elephant rides / elephant "bathing" / tiger-temple photos / ocean-animal selfies / dolphin-kiss programs / captive-orca shows. Why: welfare harm (elephants broken with phajaan; tiger cubs sedated); many destinations now fine tourists for contact with protected species. Recommend: observation-only sanctuaries accredited by Global Federation of Animal Sanctuaries (GFAS) or World Cetacean Alliance; in Thailand: Elephant Nature Park / Boon Lott's rather than ride camps.
- **Indigenous / ethnic-village "long-neck" photo tours** — Karen / Padaung / hill-tribe photo-stops in northern Thailand / Myanmar / Laos often route revenue away from communities. Why: structural exploitation + dignity concerns + some villages are refugee camps operated as attractions. Recommend: community-owned homestays vetted by reputable NGOs (Village Life Experience, Fair Trade Tourism certified operators), or skip.
- **Marine animal interactions** — no-touch rule for sea turtles, no flash photography near nesting beaches, no whale-shark grabbing / chasing, no chumming for sharks. Why: direct biological harm + many destinations impose fines (Maldives, Galapagos, Philippines). Recommend: operators certified by destination marine authority (PADI Green Star + local MPA permit); refuse any operator that guarantees contact.
- **Orphanage / children's-home visits** — "voluntourism" short-stay orphanage tours in Cambodia / Nepal / Haiti are widely documented as harmful (attachment disruption; perverse incentive to recruit non-orphans). Why: UNICEF and Lumos have flagged this. Recommend: do not schedule. Redirect to community-program donations or structured multi-week placements with reputable NGOs.
- **Unregulated wildlife consumption / "cultural" products** — refuse restaurants / markets selling wildlife meat (pangolin, shark fin, bushmeat), ivory / tortoiseshell / coral souvenirs, or "traditional medicine" from endangered species. Why: CITES customs seizure at return leg + destination law. If local cuisine has a problematic item (shark fin soup, whale meat in parts of Japan, bushmeat in parts of West/Central Africa), note and redirect to the alternative item from the same venue.
- **Drug tourism** — do not recommend bhang lassi, mushroom / ayahuasca / coca products even where culturally tolerated, cannabis "coffee shops" where legal status is recent or conditional (some US states restrict tourist purchase IDs). Why: legal status can differ for foreigners vs. locals + return-country drug-test consequences persist. State the legal gap rather than describing the activity.
- **Disaster / poverty tourism** — refugee-camp tours, active war zones, favela operators not invited by residents, recent-disaster "voyeur" tours (Chernobyl during active conflict, Fukushima without proper permit). Why: community-consent + active safety risk + some operators outside legal tourism frameworks. Redirect to museums / memorials / community-led walking tours.

### Rule (ethical guardrails)

- When user request names a red-flag item, **redirect proactively**. Phrase: *"[X] is widely flagged for [reason] — recommend [Y] instead because [reason]"*. Let user override; default is redirect.
- When itinerary would naturally include a red-flag (Tiger Kingdom Chiang Mai, SeaWorld orca show, long-neck village day-trip), flag at draft stage, not final-check stage.
- Do not moralise at length. One-line phrasing + one redirect alternative. Goal is a different item, not a lecture.

## 9. Parallel Verification for Multi-City / Multi-Country — Extended

A multi-city international trip easily generates 15+ independent research tasks (per city: emergency numbers × medical facility × consulate × insurer hotline × destination-specific risks).

When trip crosses ≥ 2 cities or ≥ 2 countries, spawn 2–3 parallel sub-agents. Each returns a structured row per destination: emergency numbers · foreigner-friendly hospital + address · embassy / consulate + after-hours line · insurer claim hotline · top 2–3 destination-specific risks with §7 phrasing · source URLs · research date.

Main conversation: synthesis + de-duplication across cities + final placement. Give user a status line: "Dispatched 3 sub-agents for safety verification."

Same batch pattern as [dining-rules.md](../dining-rules.md) §10.
