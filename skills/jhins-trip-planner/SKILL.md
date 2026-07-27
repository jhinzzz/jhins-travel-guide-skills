---
name: jhins-trip-planner
description: >
  Use when the user asks to plan a trip, organize travel notes into a guide, refactor an existing itinerary page, or get advice on destinations, transport, hotels, dining, budget, packing, safety, or local specialties — whether domestic or international, solo or group, self-drive or guided.
  Trigger words: 旅行规划, 行程安排, 旅行攻略, 交通规划, 酒店推荐, 餐厅推荐, 帮我规划旅行, 出行计划, 行前准备, 特产推荐, 手信, 伴手礼, 预算估算, trip planning, travel itinerary, travel guide, plan a trip, itinerary redesign, hotel recommendations, restaurant recommendations, local souvenirs, jhins-trip-planner, planner.
---

# Jhins Trip Planner

Version: **0.20.0** — see [CHANGELOG.md](../../CHANGELOG.md) for history, [FUTURE.md](../../FUTURE.md) for deferred directions, [provenance.md](references/provenance.md) for which test case covers which rule.

## North Star

The goal is a trip the user will actually enjoy and remember. The rules below exist to prevent fabrication and preserve real constraints — not to generate rule-satisfying reports. When a rule and the user's experience conflict, surface the conflict rather than silently satisfying the rule.

## Navigation

**Always** = read at the start of any trip request. **On trigger** = read only when the trigger fires. This table is the *only* router — later sections state rules, not pointers.

| Read this | When | Tier |
|---|---|---|
| [intake.md](references/intake.md) | Profile recall, brief capture, minimum-viable threshold, theme / pace / medication / accessibility / child / self-drive / food captures | **Always** |
| [knowledge-layers.md](references/knowledge-layers.md) §§1–3 | Classifying every named entity before it enters the draft | **Always** |
| [travel-sources.md](references/travel-sources.md) §Citation Format | Writing any price, schedule, or rating | **Always** |
| [travel-sources.md](references/travel-sources.md) (rest) | Which platform for which info type, rating floors, login-wall channel ladder | On trigger |
| [knowledge-layers.md](references/knowledge-layers.md) §§4–6 | Destination inspiration, search advisory cards, exhaustion gate | On trigger |
| [trip-prep.md](references/trip-prep.md) | International trip: visa + transit visa, payment, SIM, insurance, etiquette, religious / festival overlap | On trigger |
| [weather-and-output.md](references/weather-and-output.md) | Weather (incl. climate-shift risk); producing markdown / HTML files | On trigger |
| [travel-mode.md](references/travel-mode.md) | Independent-vs-guided decision, tour / private-guide inserts, licensed-operator vetting | On trigger |
| [transportation.md](references/transportation.md) | Round-trip transport, booking windows, arrival times, transfers, self-drive route-book, multi-carrier luggage | On trigger |
| [budget.md](references/budget.md) | Budget breakdown, hidden costs, refundable-vs-not, FX / payment timing | On trigger |
| [hotel-selection.md](references/hotel-selection.md) | Hotel shortlist requested | On trigger |
| [dining-rules.md](references/dining-rules.md) | Any restaurant enters the draft | On trigger |
| [attractions.md](references/attractions.md) | Any attraction enters the draft — booking lead times, capacity, timed-entry, last-admission, seasonal closure, anchor density | On trigger |
| [local-specialties.md](references/local-specialties.md) | Souvenirs, 特产, 手信 | On trigger |
| [safety-and-emergency.md](references/safety-and-emergency.md) | Multi-day itinerary or any full trip plan | On trigger |

If a rule is in a reference, do not restate it here — follow the pointer.

**Deep references (opt-in)**: the `references/deep/` subdirectory holds extended tables, examples, and destination-specific detail for reference files that have a deep counterpart (`budget.md`, `dining-rules.md`, `intake.md`, `safety-and-emergency.md`, `trip-prep.md`). Do **not** read deep files by default. Open only when the main reference explicitly points there, or when the request crosses a depth trigger stated in the main reference (e.g., 5+ restaurants → dining deep, cross-currency + tight budget → budget deep, multi-city international → safety deep, party with children/accessibility → intake deep, transit via US/HK/Dubai/SG or destination-specific payment friction → trip-prep deep).

## Data Traceability (Hard Constraint)

Every factual claim — flight/train numbers, fares, schedules, hotel names, restaurant names, shop names, prices, ratings — must be traceable to a real source. Cite `(source, research date)` per [travel-sources.md](references/travel-sources.md).

- Cross-reference ≥2 independent sources for hotel, transport, and specialty picks. For hotels, use progressive search per [hotel-selection.md](references/hotel-selection.md) §Progressive Search.
- Never fabricate specifics. If data is unavailable, give a typical range, mark approximate, and say why. For Local Knowledge Layer items (named entities, prices), degrade to search advisory card per [knowledge-layers.md](references/knowledge-layers.md) §5 when verification fails.
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

Follow [intake.md](references/intake.md) for required inputs, question order, minimum-viable-brief threshold, relevance rule (skip captures that don't apply), and the meal × cuisine × area / self-drive triad / theme / pace / medication / accessibility / child-band captures. Do not start detailed planning until the brief crosses the minimum-viable threshold in [intake.md](references/intake.md) §2. For destination-inspiration flows ("推荐个地方"), use the destination-matching framework in [knowledge-layers.md](references/knowledge-layers.md) §4 — objective dimensions only, no named entities.

## Confirmation Checkpoints

Stop and ask before crossing any of these — rule bodies live in the referenced file.

**Batching rule**: checkpoints that trigger at **intake time** (before any draft exists) fold into the single batched intake question (intake §1 step 3) — up to four, ranked by risk (legal / safety > scheduling > preference), rest deferred. **Mid-flight checkpoints** (budget overage during draft, swap cascade, pace/theme conflict discovered while scheduling) are still asked **one at a time** — the reason for that rule is isolation, which batching would defeat.

- Switching from advice/outline into markdown + HTML deliverables
- Replacing an existing page structure (vs. reorganizing inside it)
- Choosing a transport mode when the user has stated no preference
- Treating missing dates/destination/budget as permission to invent
- Dropping existing sections, venues, or notes
- Budget overage >15% — present overage, suggest trims, confirm
- Restaurant/hotel/anchor-attraction swap after first draft — run the swap cascade (dining-rules §9)
- Capacity-capped or timed-entry attraction not bookable for the target date at planning time — surface it; offer date shift / substitute anchor (attractions §1)
- Publishing a trip overlapping a destination peak without the "3–5 days before departure" recheck block (dining-rules §8)
- Self-drive day exceeding the intake-captured driving-time ceiling (intake §8)
- Daily density conflicts with the chosen pace (e.g., 6 anchors on `leisurely`)
- Theme conflicts (e.g., `adventure` + `wellness`, `photography` + `family-young-kids`) — ask which theme wins per day before drafting
- `pace=leisurely` + high-intensity adventure sub-activity (sunrise-hike, pre-dawn start, full-day trek, open-water dive, multi-pitch, whitewater) — reconcile per day
- Trip window overlapping **Ramadan or a moveable religious festival** — verify year-specific dates from an official source before drafting etiquette/dining

## Fallback Rules (When Evidence Is Incomplete)

Degrade gracefully — never invent certainty. Each fallback: what's missing → what to do. Rules themselves live in the referenced files.

- **Missing dates/destination** → stay in scaffold mode; surface assumptions; no day-by-day sequencing.
- **Missing budget or food preferences** → neutral structure; mark hotel/dining as provisional.
- **No reliable forecast** → seasonal averages, labeled approximate; also check climate-shift risk (weather-and-output §1).
- **Weak hotel evidence** → do not promote as first pick; backup/niche/omit per hotel-selection. If verification times out, degrade to a search advisory card (knowledge-layers §5).
- **Missing transport preference** → if one mode is dominant, present as primary with alternatives and confirm; if genuinely competitive, present comparison and wait.
- **Transport schedule/price unavailable** → ranges + research date (transportation); never fabricate.
- **Visa/entry unknown** → flag before booking; assume nothing.
- **Ticket/reservation availability unknown** → label "advance booking likely required — verify"; do not schedule silently.
- **Off-peak timing unknown** → omit the suggestion rather than guess.
- **Self-drive infeasible/risky** (licence not recognised, low-signal stretches, LHD/RHD first-timer, elderly/kids/pregnant/pets/altitude) → follow transportation §Rental Car / Self-Drive.
- **Last-minute trip (≤48h)** → real-time channels only; warn about price/availability; skip visa-dependent options.
- **Conflicting constraints** (luxury-on-tight-budget, 10-attractions-in-2-days) → surface conflict; offer 2–3 prioritization choices; do not silently compromise.
- **Thin specialty data** → category guidance + "verify locally"; no specific shops without source (local-specialties). Output a search advisory card (knowledge-layers §5) when verification unavailable.
- **Contradictory existing content** → preserve source facts; flag; don't resolve by invention.
- **Web verification stalls** → a login wall / 302 / blank on one platform is **not** a failure. Climb the channel ladder and apply the exhaustion gate (knowledge-layers §6) before degrading to a search advisory card.
- **Batch verification** — when the combined verification list reaches ≥5 items or the trip spans ≥2 cities, fan out parallel sub-agents per §Batch Verification below.

## Batch Verification

Verification fans out **once per itinerary**, not once per domain. Do not serialize the fetches in the main conversation, and do not run a dining sweep, then a hotel sweep, then an attractions sweep — one restaurant's operating status, address, weekly closure, and reservation channel come back from one agent in one row.

**Single trigger**: the combined Tier-A + Tier-B verification list (per [knowledge-layers.md](references/knowledge-layers.md) §3) reaches **≥5 items**, or the trip spans **≥2 cities or countries**.

1. Draft the itinerary skeleton first — names selected, nothing verified.
2. Compute the whole Tier-A + Tier-B list in one step, across every domain.
3. Slice by **geography** (city, then district), not by domain. Country-level items (visa / entry / payment / SIM, nationwide emergency numbers) attach to **one** slice per country — not to every city slice inside it, which would duplicate the same fetch two or three times.
4. Fan out **one sub-agent per slice** — typically 2–4, but there is no cap: a 5-country trip uses 5, one per country. If geography yields a single slice, still dispatch that one sub-agent; the point is keeping the fetches out of the main conversation. Each verifies *everything* in its slice.
5. Each sub-agent returns **one structured row per item**, using the return fields its domain defines — dining §10 · hotels §Parallel Verification · specialties §Parallel Verification · attractions §Verification and Fallback · safety §9 · trip prep §1.
6. Each sub-agent independently obeys its domain's degradation / timeout rules (hotel Timeout Degradation, the channel-ladder exhaustion gate).
7. The main conversation synthesizes the rows, de-duplicates across slices, and decides the final output.
8. Emit one status line: `Dispatched N sub-agents for verification across M slices`.

## Core Workflow

1. **Inventory** the page or brief. Preserve all facts; move, don't delete. For `planning-only`, inventory brief + constraints rather than inventing page structure.
2. **Plan round-trip transport first** per [transportation.md](references/transportation.md). Anchor arrival day forward from realistic "available in the city" time; anchor departure day backward from the hard cutoff (hotel check-out + luggage per [hotel-selection.md](references/hotel-selection.md)).
3. **Rebuild around a generic trip timeline** (day archetypes: arrival, city, day-trip, weather-buffer, food-day, departure). Keep day-by-day as the spine; appendices for full reference. Produce a budget breakdown by category per [budget.md](references/budget.md) §1 (apply the region band, adjust by theme, surface hidden costs per §2); compare to the user's stated budget.
4. **Embed local context into each day** — dining per [dining-rules.md](references/dining-rules.md) (matrix · operating status · target-date · ward · 4 required fields · route · reservations); attractions per [attractions.md](references/attractions.md) (booking lead time · capacity/timed-entry · last-admission · target-date + seasonal closure · one lead anchor per day); intra-city transport notes; self-drive day cards carry distance · driving time · longest single segment + route-book app per [transportation.md](references/transportation.md) §Rental Car / Self-Drive. Buffers between activities:
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

Judge the drafted output against the assertions below. Each one is decidable by reading the draft — **do not reopen a reference to run this check**. If an assertion fails, go back to the reference that owns the rule and fix the draft. Items marked `→ v0.21 validate.js` are not readable assertions and stay LLM-judged until the validator ships.

- **Output mode**: the artifact type matches what was asked — no HTML for `planning-only`, no bare advice when a guide was requested.
- **Trip prep** (international): visa + transit-visa status · payment method · SIM/eSIM · insurance · etiquette items · religious/festival overlap all present as named lines, not "check before you go". Accessibility captures from intake appear resolved by name.
- **Weather**: every assumption is visible (forecast vs seasonal average, stated which). If seasonal averages were used, the climate-shift disclaimer is present.
- **Fallback labels**: every incomplete-evidence spot carries a visible label — `approximate` · `verify locally` · `未能核实` · or a search advisory card. No silent gaps.
- **Hotels**: every card carries 8 fields — name+tier · area · transit · nightly rate range (with currency + source + date) · budget fit · why this tier · verdict · Hardware (renovation year, or recent-review proxy, or `未能核实`). Check-in/check-out times and luggage storage stated. A dated-hardware caution chip appears wherever the Hardware line is a Tier-2 proxy that reads negative.
- **Transport**: both outbound and return legs present. Every card carries 9 fields — mode and route · booking window · booking channel · schedule or frequency · seat class and price range · recommended arrival time · hard cutoff time · transfer details · backup option. Arrival day is anchored forward from realistic "available in the city" time; departure day is anchored backward from the hard cutoff.
- **Budget**: a named region band is cited; theme adjustment stated or explicitly "none"; hidden costs listed where triggered; refundable-vs-non decisions stated where the party mix triggers it; for cross-currency trips the assumed FX rate + rate date appear. If the total exceeds the stated budget by >15%, the confirmation happened before this draft.
- **Local context**: every bookable item states its booking lead time or current status. Every inter-activity gap carries a buffer matching its tier (nearby 15–20 min · cross-district 30–45 min · +10–15 min with luggage). Off-peak timing claims are cited or absent.
- **Dining**: every restaurant carries 4 required fields — cuisine category · platform rating · walking time from the day's anchor · per-person price band. Operating status was verified against the target date (not the typical week), with source + check date. Weekly closures cleared. Restaurant and its stated district/ward agree. Reservation channel + lead time present where the venue needs one. The destination's signature category occupies a slot before diversity is considered.
- **Attractions** (when present): every card carries 7 fields — name+category · booking (lead time + channel + status) · time slot or hours + last admission · target-date status · ticket price range · accessibility/child notes · verdict. Scheduled against last admission, not closing time. Exactly one lead anchor per day. Daily density matches the stated pace.
- **Self-drive** (when applicable): every driving day states distance · driving time · longest single segment · route-book app. Licence validity at the destination, driving side, and the intake driving-time ceiling are all respected — no day exceeds the ceiling.
- **Pace & theme**: daily anchor count matches the stated pace. Theme conflicts were resolved before drafting, not papered over. Any high-intensity adventure activity is reconciled against the nominal pace, per day.
- **Intake carry-forward**: every capture taken at intake appears resolved downstream — chronic-medication generics as per-country legality flags · accessibility/medical needs (wheelchair · dialysis · cabin-O₂ · pregnancy · service animal) named in the transport/hotel/attraction cards they constrain · minors-with-one-parent documents raised where enforced · Greater-China crossings described as permits, never visas · thermal-immersion safety present wherever a hot spring appears alongside a vulnerable traveller · Ramadan/moveable-festival dates verified for the trip year.
- **Local etiquette**: every item reads *situation → specific action*. No generic "respect local customs".
- **Safety & emergency**: destination-real emergency numbers (not "911") · one named foreigner-friendly hospital with address · embassy with an after-hours line · insurer claim hotline · theft/loss step lists · destination risks each phrased *risk → trigger → action*. No partial phone numbers anywhere — a field is either complete or replaced by a fetch-before-departure line with the official URL.
- **Pre-trip recheck block**: present when the trip overlaps a destination peak period **or** a disaster/closure signal fired. Exactly **one** such block in the output, never two.
- **Specialties** (if present): every card carries 8 fields — item name · tier · what it is · where to buy · price range (with currency + source) · transport notes · best for · source + date. Season-bound items are flagged against the trip date. `signature` tier items each have ≥2 sources.
- **Knowledge layers**: every named entity (hotel · restaurant · shop · dish · attraction · price) either carries web evidence or has degraded to a search advisory card. No named entity rests on training data alone. Destination-inspiration answers use objective dimensions only, no named entities.
- **Data traceability**: every price, schedule, rating, and availability claim carries `(source, research date)`. Anything older than 3 months is flagged as such. → v0.21 validate.js
- **Content preservation**: for `existing-page-refactor`, every fact in the source is still present — moved, not deleted. → v0.21 validate.js

## Minimal Output Shape

### `planning-only`

Trip summary (theme + pace stated) · assumptions/missing inputs · trip-prep flags (visa/payment/SIM + etiquette red flags for international) · round-trip transport (mode/window/price/timing) · day-by-day outline with pace-calibrated buffers · self-drive day fields if applicable · budget estimate by category · hotel direction if requested · signature specialties if relevant (with source) · packing/weather notes · short safety block · all prices/schedules cite source + research date.

### `guide-redesign`

Hero summary (theme + pace) · trip-prep checklist · local etiquette (destination-triggered rules only) · round-trip transport cards · prep/packing · daily itinerary cards (arrival/departure anchored; self-drive fields; pace-calibrated buffers) · reservation/ticket deadlines · hotel shortlist (check-in/out + luggage) · budget breakdown by category · specialty cards · embedded dining/shopping/intra-city notes · pre-trip recheck block if peak-period overlap · full safety & emergency section · reference appendix (incl. transport comparison if multiple modes considered) · all factual claims cite source + research date.

## Default Page Shape

Use `guide-redesign` as the default page skeleton. When the user asks for a reduced page, drop the reference appendix first, then the pre-trip recheck block (only if no peak-period overlap). **Never** drop safety & emergency, transport legs, or budget breakdown.
