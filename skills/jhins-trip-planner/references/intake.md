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

## 0. Traveller Profile Recall

At the start of a trip request, check whether a traveller profile is already stored — home city / departure airport · usual party composition · pace preference · hotel tier and hardware preference · disliked activity types · airline or hotel loyalty. If one exists, read it back in **one sentence** for confirmation and do not re-ask what it answers.

If no profile exists, **skip silently**. Do not ask the user to create one, and never invent recalled preferences — an unstored profile is a no-op, not a gap to fill.

This rule names the *fields*, not the storage mechanism: in a harness with no persistent memory it degrades to nothing.

## 1. Core Inputs and Order

Ask for missing trip inputs in this order: travel dates · destination · party size and companions · trip purpose / theme · pace preference · chronic medication (if relevant) · food preferences · budget · preferred transport mode.

Four steps, in order — the goal is a confirmed brief in **one or two turns**, not an interview:

1. **Extract** everything the conversation already states. Never ask for something the user has said.
2. **Fill** every still-unstated parameter with an explicit default — pace, theme, food preferences (§2), plus daily start/end times. Do **not** ask for these.
3. **Ask once, batched.** Only the items that genuinely change the plan go into a *single* structured question (`AskUserQuestion` where the harness offers it): the minimum-viable-brief fields that are still missing (§2), transport preference and hotel room style (§10) when they are unstated and in scope, plus any capture the Capture Relevance Rule fires (self-drive triad, child bands, accessibility, medication). If more than four apply, ask the top four by risk — legal/safety > scheduling > preference — and defer the rest to mid-flight checkpoints.
4. **Read back a one-screen brief** listing every assumed default alongside the confirmed inputs, and wait for the user's go-ahead before detailed planning.

If all four minimum-viable-brief fields are already present, step 3 drops to whatever still must not be defaulted silently — usually just transport preference, and room style if a hotel is in scope. If nothing is left, ask **nothing** and go straight to the brief.

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

1. **Mobility** — wheelchair / walker / cane / limited stair tolerance
2. **Dialysis** — sessions-per-week + preferred day/time; lead time 4–8 weeks
3. **Cabin oxygen** — O₂ flow rate + POC ownership; airline medical clearance 48h–7 days
4. **Pregnancy** — gestational week at departure + return; airline cutoffs apply
5. **Service / assistance animal** — species, weight, vaccination status; quarantine lead times
6. **Other** — severe food allergy (epinephrine), sensory sensitivities, recent surgery, scuba cert recency

For full detail on each category (constraints, lead times, destination-specific limitations), see [deep/intake.md](deep/intake.md) §6.

### Accessibility carry-forward rule

When any capture above fires, every downstream section must respect it — hotel, attraction, transport, and safety cards must explicitly resolve the constraint. If a constraint cannot be met at a destination, surface it at intake as a trip-feasibility concern — not at page-render time.

## 7. Child Age Bands (skip if no minors)

When the party includes anyone under 18, capture age-at-departure per child and map to a band:

| Band | Age | Key constraint |
|---|---|---|
| Infant | 0–2 | Lap-infant vs seat; bassinet; stroller limits; altitude <2,500 m |
| Preschool | 3–5 | Attention ~45 min; walk ~1–2 km; early dinner window |
| Early school | 6–9 | Walk 3–4 km; family-ticket discounts; rollaway/family-room |
| Pre-teen | 10–14 | Near-adult pace; separate-room from 12+; some countries bar solo minors in rooms |
| Teen | 15–17 | Adult-pace/pricing; activity age minimums; alcohol legal-age varies |

The bands are not cosmetic — each triggers different downstream constraints on pacing, hotel, transport, and dining. For full per-band detail (stroller limits, height minimums, meal timing, photo restrictions, etc.), see [deep/intake.md](deep/intake.md) §7.

### Child carry-forward rule

Every downstream section respects the child bands captured at intake. Hotel cards show crib/rollaway + family-room capacity; restaurant cards flag high-chair / kid-menu / age-floor; attraction cards show stroller accessibility + child ticket pricing + height minimums; transport cards show lap-infant vs separate-ticket + stroller gate-check; itinerary pacing respects attention-span and walking-tolerance tiers. When a hot spring / onsen / thermal bath appears anywhere in the itinerary (not only when `wellness & spa` is the stated theme), carry the child band forward into thermal-immersion safety per [safety-and-emergency.md](safety-and-emergency.md) §6.

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

- If hotel suggestions are needed and room style is missing, fold the question into §1 step 3's single batched question rather than asking it on its own turn.
- If hotel suggestions are in scope, capture **hardware preference** once: `modern-hardware-preferred` / `heritage-OK` / `no-preference`. Ask only when relevant (per the Capture Relevance Rule at the top of this file). This bends hotel *ranking weight* per [hotel-selection.md](hotel-selection.md) §Hardware Weighting — it does **not** change what is disclosed on the card.
- If the user has not mentioned transport preferences, ask — folded into §1 step 3's single batched question, not on its own turn: "Do you have a preferred transport mode for getting there and back (flight, high-speed rail, rental car, etc.)?" Never default a transport mode silently; SKILL.md §Confirmation Checkpoints makes choosing one on the user's behalf a stop-and-ask.
