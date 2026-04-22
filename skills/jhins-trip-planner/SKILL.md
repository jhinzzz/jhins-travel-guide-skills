---
name: planner
description: >
  End-to-end trip planner: pre-trip prep, round-trip transport, hotels, day-by-day itineraries with weather and buffer times, route-fit dining, local specialties, categorized budget, and source-traceable recommendations. Three modes: planning advice, guide redesign (markdown + HTML), or existing-page refactor.
  Trigger words: 旅行规划, 行程安排, 旅行攻略, 交通规划, 酒店推荐, 餐厅推荐, 帮我规划旅行, 出行计划, 行前准备, 特产推荐, 手信, 伴手礼, 预算估算, trip planning, travel itinerary, travel guide, plan a trip, itinerary redesign, hotel recommendations, restaurant recommendations, local souvenirs, jhins-trip-planner, planner.
---

# Jhins Trip Planner

Version: **0.6.2** — see [CHANGELOG.md](../../CHANGELOG.md) for history, [FUTURE.md](../../FUTURE.md) for deferred directions.

## North Star

The goal is a trip the user will actually enjoy and remember. The rules below exist to prevent fabrication and preserve real constraints — not to generate rule-satisfying reports. When a rule and the user's experience conflict, surface the conflict rather than silently satisfying the rule.

## Navigation

Read references lazily, based on what the request actually needs:

| When the request involves… | Read this |
|---|---|
| Intake order, minimum viable brief, theme / pace / medication / accessibility / child / self-drive / food captures | [intake.md](references/intake.md) |
| Visa + transit visa, payment, SIM, insurance, etiquette, religious / festival overlap, multi-country parallel verification | [trip-prep.md](references/trip-prep.md) |
| Weather (incl. climate-shift risk), output format (markdown / HTML), independent-travel-vs-guided decision | [weather-and-output.md](references/weather-and-output.md) |
| Round-trip transport, booking windows, arrival times, transfers, self-drive route-book, multi-carrier luggage | [transportation.md](references/transportation.md) |
| Hotel tiering, evidence, check-in/out, luggage | [hotel-selection.md](references/hotel-selection.md) |
| Restaurant selection, cuisine matrix, operating-status, reservation, swap cascade | [dining-rules.md](references/dining-rules.md) |
| Souvenirs, 特产, 手信 | [local-specialties.md](references/local-specialties.md) |
| Emergency numbers, medical, embassy, insurance claim, theft/loss, destination risks, ethical-tourism guardrails | [safety-and-emergency.md](references/safety-and-emergency.md) |
| Which platform to use for which info type, rating floors, citation format | [travel-sources.md](references/travel-sources.md) |

If a rule is in a reference, do not restate it here — follow the pointer.

## Data Traceability (Hard Constraint)

Every factual claim — flight/train numbers, fares, schedules, hotel names, restaurant names, shop names, prices, ratings — must be traceable to a real source. Cite `(source, research date)` per [travel-sources.md](references/travel-sources.md).

- Cross-reference ≥2 independent sources for hotel, transport, and specialty picks.
- Never fabricate specifics. If data is unavailable, give a typical range, mark approximate, and say why.
- **Never trust restaurants from training data.** Every restaurant must pass operating-status verification per [dining-rules.md](references/dining-rules.md) §2 before appearing in output.
- Verify against the **target date**, not the typical week — weekly closures + destination-specific peak closures per [dining-rules.md](references/dining-rules.md) §3.
- Labels: single-source → "approximate"; multi-source confirmed → "verified"; insufficient → "verify locally". Flag data older than 3 months.

## Classify The Task First

1. `planning-only` — advice, outline, or recommendation. Conversational or markdown outline only, unless files are explicitly requested.
2. `guide-redesign` — reusable guide / page / shareable artifact. Produces markdown + HTML per [weather-and-output.md](references/weather-and-output.md) §2.
3. `existing-page-refactor` — subtype of `guide-redesign` where existing content must be preserved and re-mapped before new planning.

If the request could fit both `planning-only` and `guide-redesign`, ask one confirmation before generating files.

## Mode-Specific Scope

Use the lightest path that fits:

| Step | `planning-only` | `guide-redesign` / refactor |
|---|---|---|
| Trip prep (visa, payment, SIM, insurance, etiquette) | Critical flags only | Full checklist |
| Safety & emergency | Short block (numbers + insurer + embassy one-liner) | Full section per [safety-and-emergency.md](references/safety-and-emergency.md) |
| Inventory | Brief + constraints | Full page map |
| Transport | Summary (mode, window, price, timing) | Full cards per [transportation.md](references/transportation.md) |
| Timeline + budget | Day-by-day outline + budget estimate | Full daily cards + category budget |
| Local context (dining / shops / attractions) | Key items inline with booking lead times | Full embedded blocks with buffers |
| Hidden-mode friction | Skip | Apply |
| Weather | Apply | Apply |
| Hotels | Direction only if asked | Full shortlist with cards |
| Local specialties | Signature items if relevant | Full cards per [local-specialties.md](references/local-specialties.md) |
| Pre-trip recheck (peak-period overlap) | Short block listing at-risk items (dates + names) per [dining-rules.md](references/dining-rules.md) §8 | Full block per §8 |
| Readability | Conversational | Guide-style chips and labels |
| Web and mobile | Skip | Apply |
| Verify | Advice completeness | Full Final Check |

When in doubt, start lighter — the user can ask for more detail.

## Language

- Detect the user's language from their first message; follow language switches mid-conversation.
- Place names: user's language first, local-language in parentheses on first mention (e.g., "东京（Tokyo）" for Chinese users, "Tokyo (東京)" for English users).
- Skill instructions are in English for LLM readability — this does not affect output language.

## Intake

Follow [intake.md](references/intake.md) for required inputs, question order, minimum-viable-brief threshold, relevance rule (skip captures that don't apply), and the meal × cuisine × area / self-drive triad / theme / pace / medication / accessibility / child-band captures. Do not start detailed planning until the brief crosses the minimum-viable threshold in [intake.md](references/intake.md) §2.

## Confirmation Checkpoints

Stop and ask before crossing any of these — rule bodies live in the referenced file:

- Switching from advice/outline into markdown + HTML deliverables
- Replacing an existing page structure (vs. reorganizing inside it)
- Choosing a transport mode when the user has stated no preference (see [transportation.md](references/transportation.md))
- Treating missing dates/destination/budget as permission to invent
- Dropping existing sections, venues, or notes
- Budget overage >15% — present overage, suggest trims, confirm
- Restaurant/hotel/anchor-attraction swap after first draft — run cascade per [dining-rules.md](references/dining-rules.md) §9
- Publishing a trip overlapping a destination peak without the "3–5 days before departure" recheck block per [dining-rules.md](references/dining-rules.md) §8
- Self-drive day exceeding the intake-captured driving-time ceiling ([intake.md](references/intake.md) §8)
- Daily density conflicts with the chosen pace (e.g., 6 anchors on `leisurely`)
- Theme conflicts (e.g., `adventure` + `wellness`, `photography` + `family-young-kids`) — ask which theme wins per day before drafting
- `pace=leisurely` + high-intensity adventure sub-activity (sunrise-hike, pre-dawn start, full-day trek, open-water dive, multi-pitch, whitewater) — reconcile per day
- Trip window overlapping **Ramadan or a moveable religious festival** — verify year-specific dates from an official source before drafting etiquette/dining

## Fallback Rules (When Evidence Is Incomplete)

Degrade gracefully — never invent certainty. Each fallback: what's missing → what to do. Rules themselves live in the referenced files.

- **Missing dates/destination** → stay in scaffold mode; surface assumptions; no day-by-day sequencing.
- **Missing budget or food preferences** → neutral structure; mark hotel/dining as provisional.
- **No reliable forecast** → seasonal averages, labeled approximate; also check climate-shift risk per [weather-and-output.md](references/weather-and-output.md) §1.
- **Weak hotel evidence** → do not promote as first pick; backup/niche/omit per [hotel-selection.md](references/hotel-selection.md).
- **Missing transport preference** → if one mode is dominant, present as primary with alternatives and confirm; if genuinely competitive, present comparison and wait.
- **Transport schedule/price unavailable** → ranges + research date per [transportation.md](references/transportation.md); never fabricate.
- **Visa/entry unknown** → flag before booking; assume nothing.
- **Ticket/reservation availability unknown** → label "advance booking likely required — verify"; do not schedule silently.
- **Off-peak timing unknown** → omit the suggestion rather than guess.
- **Self-drive infeasible/risky** (licence not recognised, low-signal stretches, LHD/RHD first-timer, elderly/kids/pregnant/pets/altitude) → follow [transportation.md](references/transportation.md) §Rental Car / Self-Drive.
- **Last-minute trip (≤48h)** → real-time channels only; warn about price/availability; skip visa-dependent options.
- **Conflicting constraints** (luxury-on-tight-budget, 10-attractions-in-2-days) → surface conflict; offer 2–3 prioritization choices; do not silently compromise.
- **Thin specialty data** → category guidance + "verify locally"; no specific shops without source per [local-specialties.md](references/local-specialties.md).
- **Contradictory existing content** → preserve source facts; flag; don't resolve by invention.
- **Web verification stalls** → retry via a different source in [travel-sources.md](references/travel-sources.md); repeated mismatches on the same ID = closed/relocated; never "please verify yourself".
- **Batch verification** — parallel sub-agents when the batch crosses:
  - Dining ≥5 → [dining-rules.md](references/dining-rules.md) §10
  - Hotels >4 → [hotel-selection.md](references/hotel-selection.md) §Parallel Verification
  - Specialties >5 → [local-specialties.md](references/local-specialties.md) §Parallel Verification
  - Safety ≥2 cities/countries → [safety-and-emergency.md](references/safety-and-emergency.md) §9
  - Trip prep ≥2 countries → [trip-prep.md](references/trip-prep.md) §1

## Core Workflow

1. **Inventory** the page or brief. Preserve all facts; move, don't delete. For `planning-only`, inventory brief + constraints rather than inventing page structure.
2. **Plan round-trip transport first** per [transportation.md](references/transportation.md). Anchor arrival day forward from realistic "available in the city" time; anchor departure day backward from the hard cutoff (hotel check-out + luggage per [hotel-selection.md](references/hotel-selection.md)).
3. **Rebuild around a generic trip timeline** (day archetypes: arrival, city, day-trip, weather-buffer, food-day, departure). Keep day-by-day as the spine; appendices for full reference. Produce a budget breakdown by category; compare to the user's stated budget.
4. **Embed local context into each day** — dining per [dining-rules.md](references/dining-rules.md) (matrix · operating status · target-date · ward · 4 required fields · route · reservations); attractions with booking windows; intra-city transport notes; self-drive day cards carry distance · driving time · longest single segment + route-book app per [transportation.md](references/transportation.md) §Rental Car / Self-Drive. Buffers between activities:
   - **Nearby** (15–20 min): within ~1 km / 10-min walk.
   - **Cross-district** (30–45 min): metro/bus/taxi or >1 km walk.
   - **With luggage** (+10–15 min): add to either tier.
   - When in doubt, use the longer buffer.
5. **Remove hidden-mode friction** — convert tabs/modes to anchors; don't hide core content behind switches unless requested.
6. **Adapt to weather** per [weather-and-output.md](references/weather-and-output.md) §1 (incl. climate-shift risk disclaimer when using historicals). Flag transport risks (typhoons, heavy rain) with backups per [transportation.md](references/transportation.md).
7. **Recommend hotels with evidence** per [hotel-selection.md](references/hotel-selection.md). Factor hub proximity.
8. **Recommend specialties** per [local-specialties.md](references/local-specialties.md). Embed near the matching day's geography. Flag customs/transport constraints.
9. **Optimize for readability** — short labels, chips, compact notes, plain travel-guide wording. Tables/chips for transport cards, not paragraphs.
10. **Optimize for web and mobile** — desktop two-column OK; mobile single-column, no horizontal overflow, iPhone-width readable.
11. **Verify before finishing** — run the Final Check below.

## Non-Goals

- Do not force HTML for `planning-only`.
- Do not replace route/booking/weather logic with generic sightseeing filler.
- Do not drop existing facts to clean the layout.
- Do not hide core trip content behind tabs unless the user asked.
- Do not violate the transport evidence standard or skip the return trip — see [transportation.md](references/transportation.md).
- Do not recommend specialties without ≥2 sources — see [local-specialties.md](references/local-specialties.md).
- Do not present any price/schedule/factual claim without source + research date.

## Final Check

Verify each area against its canonical checklist — do not re-check rules in reference files; confirm the output passes the reference's own checklist.

- **Output mode** matches the request.
- **Trip prep**: international trips pass [trip-prep.md](references/trip-prep.md) (visa + transit · payment · SIM · insurance · etiquette · religious-festival overlap) + accessibility carry-forward from [intake.md](references/intake.md) §6.
- **Weather**: assumptions visible and practical per [weather-and-output.md](references/weather-and-output.md) §1; climate-shift disclaimer present when using historicals.
- **Fallback labels**: visible where evidence or inputs were incomplete.
- **Hotels**: pass [hotel-selection.md](references/hotel-selection.md) card checklist (incl. check-in/out + luggage).
- **Transport**: both legs present; each card passes the 9-field checklist in [transportation.md](references/transportation.md); arrival/departure correctly anchored.
- **Budget**: category breakdown present; >15% overage triggered the checkpoint.
- **Local context**: booking lead times stated; buffer times follow the tier above; off-peak suggestions cited or omitted.
- **Dining**: passes [dining-rules.md](references/dining-rules.md) §§1-9.
- **Self-drive** (when applicable): passes [transportation.md](references/transportation.md) §Rental Car / Self-Drive + intake triad.
- **Pace & theme**: daily density matches pace; theme conflicts resolved; high-intensity adventure reconciled per day.
- **Intake carry-forward**: chronic-medication generics (if any) flow into Trip Preparation per-country legality flags; accessibility/medical needs (wheelchair · dialysis · cabin-O₂ · pregnancy · service animal) flow into transport/hotel/attraction vetting; minors-with-one-parent documents raised where enforced; Ramadan/moveable-festival dates verified.
- **Local etiquette**: destination-triggered items phrased as *situation → specific action* per [trip-prep.md](references/trip-prep.md) §6.
- **Safety & emergency**: passes [safety-and-emergency.md](references/safety-and-emergency.md) — numbers · hospital · embassy (incl. after-hours) · insurer claim path · theft/loss steps · risks with §6 phrasing.
- **Pre-trip recheck block**: present when the trip overlaps a peak period, per [dining-rules.md](references/dining-rules.md) §8.
- **Specialties** (if present): pass [local-specialties.md](references/local-specialties.md) card checklist.
- **Data traceability**: every factual claim cites source + research date per [travel-sources.md](references/travel-sources.md).
- **Content preservation**: existing source content preserved unless removal was requested.

## Minimal Output Shape

### `planning-only`

Trip summary (theme + pace stated) · assumptions/missing inputs · trip-prep flags (visa/payment/SIM + etiquette red flags for international) · round-trip transport (mode/window/price/timing) · day-by-day outline with pace-calibrated buffers · self-drive day fields if applicable · budget estimate by category · hotel direction if requested · signature specialties if relevant (with source) · packing/weather notes · short safety block · all prices/schedules cite source + research date.

### `guide-redesign`

Hero summary (theme + pace) · trip-prep checklist · local etiquette (destination-triggered rules only) · round-trip transport cards · prep/packing · daily itinerary cards (arrival/departure anchored; self-drive fields; pace-calibrated buffers) · reservation/ticket deadlines · hotel shortlist (check-in/out + luggage) · budget breakdown by category · specialty cards · embedded dining/shopping/intra-city notes · pre-trip recheck block if peak-period overlap · full safety & emergency section · reference appendix (incl. transport comparison if multiple modes considered) · all factual claims cite source + research date.

## Default Page Shape

Use `guide-redesign` as the default page skeleton. When the user asks for a reduced page, drop the reference appendix first, then the pre-trip recheck block (only if no peak-period overlap). **Never** drop safety & emergency, transport legs, or budget breakdown.
