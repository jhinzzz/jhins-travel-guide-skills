# Attractions and Activities

Governs sightseeing anchors, museums, theme parks, guided activities, and timed-entry sites. The trip exists *for* these — dining, hotels, and transport serve them. A plan that verifies restaurants to perfection but misses that the Alhambra sold out three months ago has failed the trip.

This file covers only what is **attraction-specific**. Naming/verification of attraction entities lives in [knowledge-layers.md](knowledge-layers.md) (Local Knowledge Layer); post-disaster closure-status lives in [safety-and-emergency.md](safety-and-emergency.md) §6; the target-date discipline is shared with [dining-rules.md](dining-rules.md) §3; batch verification follows SKILL.md §Batch Verification; sources are [travel-sources.md](travel-sources.md). Do not restate those here — follow the pointer.

## 1. Advance Booking and Capacity

### Rule

Many attractions are **capacity-limited**: tickets are gone weeks to months before the date, and a walk-up is impossible — not merely inconvenient. This is the attraction failure mode that ruins an otherwise-good plan, because unlike a closed restaurant it has no same-area substitute.

For every attraction, establish the **booking lead time** by category and place the booking action in the plan, not as an afterthought:

| Category | Typical lead time | Notes |
|---|---|---|
| Capacity-capped timed-entry | weeks to **2–3 months**; some release in batches | Alhambra, Uffizi, Vatican Museums, Anne Frank House, teamLab, Ghibli Museum, Sagrada Família, Acropolis peak slots, Inca Trail permits (months) |
| Theme parks | days to weeks; date-specific tickets + ride reservations | Disney / Universal premium-access and popular-ride slots sell out same-day |
| Major museums (timed but rarely capped) | days | Off-peak walk-up often fine; peak/holiday needs advance |
| Guided tours / activities | days to weeks; small-group sells out first | Cooking classes, sunrise hikes, licensed-guide-only sites |
| Free / uncapped sites | none | Still flag peak-hour crowding |

- A capacity-capped attraction whose tickets are **not bookable for the target date at planning time** is a confirmation checkpoint, not a silent omission — surface it and offer alternatives (different date, secondary-market caution, or a substitute anchor).
- "Release-day rush" attractions (permits, famous timed slots) must state the **release date and time**, not just "book ahead" — the user needs to set an alarm.
- Never present a capacity-capped attraction as a confirmed plan item without stating its booking status / lead time. Treat an unbooked capped site like an unconfirmed reservation, not a sure thing.

Trigger: every attraction. Capacity-capped sites get the checkpoint treatment.

## 2. Operating Calendar and Time-Slot Fit

### Rule

Apply the same target-date discipline as restaurants ([dining-rules.md](dining-rules.md) §3) — check the **specific trip date**, not the usual pattern — plus three attraction-specific gates:

- **Last-entry ≠ closing time.** Many sites stop admission 30–90 min before they close (palaces, museums, towers, caves). Schedule against **last admission**, not the closing hour. A 17:30 arrival at a site that "closes 18:00" but last-admits 17:00 is a wasted leg.
- **Weekly closures and seasonal shutdowns.** Weekly rest days (many museums close Monday or Tuesday) + seasonal closures that are *total*, not cosmetic: alpine huts and mountain passes (winter), polar-region access, monsoon-closed trails, off-season cable cars, fixed annual maintenance windows. A seasonally-closed anchor must be caught at planning time, not discovered on arrival.
- **Time-slot fit.** When an attraction is sold as a fixed **timed-entry slot**, the slot must fit the day's geography and pace — do not book a 09:00 slot across town from a 09:30 activity. The slot anchors the day; arrange dining and transit around it, not the reverse (analogous to the [dining-rules.md](dining-rules.md) §6 route-consistency logic, applied to the day's lead anchor).

Trigger: any attraction with a fixed slot, a weekly rest day, a last-admission cutoff, or a trip window crossing a seasonal-closure boundary.

## 3. Anchor-Per-Day and Density

### Rule

A day has **one lead anchor** — the thing the day is built around (the capacity-capped museum, the day-trip, the timed activity). Secondary stops fill in around it.

- Do not stack **two heavy timed anchors** in one day — two fixed-slot, far-apart, high-queue sites compete and the day breaks. Split them across days.
- Daily attraction density must match the intake pace ([intake.md](intake.md) §4): `tight` 4–6 stops, `balanced` 2–3 anchors, `leisurely` 1–2. A density that exceeds the chosen pace is a confirmation checkpoint per SKILL.md (e.g. 6 anchors on `leisurely`).
- Buffer between attraction stops follows the SKILL.md Core Workflow buffer tiers (nearby / cross-district / with-luggage). A timed slot tightens the buffer requirement — arrive early enough to clear security/queue before the slot lapses.

Trigger: any multi-attraction day.

## 4. Output Card Format

For each attraction, present these fields in a compact card or row:

1. **Name and category**: e.g., "teamLab Planets — timed-entry museum"
2. **Booking**: lead time + channel (official site / Klook / on-site) + booking status if capped (`booked` / `must book by <date>` / `release <date time>`)
3. **Slot / hours**: the booked or recommended time slot; **last admission** if it differs from closing
4. **Target-date status**: open on the trip date? weekly/seasonal closure cleared? (per §2)
5. **Ticket price range**: with currency and source ([travel-sources.md](travel-sources.md) citation format); ticket prices are strict Local-Knowledge per [knowledge-layers.md](knowledge-layers.md) §3 — verify or degrade, never fabricate
6. **Accessibility / child notes**: stroller access, wheelchair route, height minimums, child pricing — carry-forward from [intake.md](intake.md) §6/§7
7. **Verdict**: `must-book-now` / `anchor` / `if-time` / `skip`

Keep cards compact — tables or chip-style labels, not paragraphs. Embed each attraction in its day card near its geography (same as [local-specialties.md](local-specialties.md) §Integration with Daily Itinerary).

## Verification and Fallback

- Attraction names, ticket prices, and ratings are **Local Knowledge** — they need web evidence or degrade to a search advisory card per [knowledge-layers.md](knowledge-layers.md) §5. Well-known landmarks (UNESCO / national-level) may use the Reasoning Layer with a "widely documented" note per [knowledge-layers.md](knowledge-layers.md) §3 — but **opening hours, ticket prices, and capacity/booking status always require live verification**, never training data.
- Sources: official site / Klook for tickets; 马蜂窝 / TripAdvisor for selection — per [travel-sources.md](travel-sources.md).
- When an itinerary has **5+ attractions to verify** (hours, prices, booking status across many sites), run the batch per SKILL.md §Batch Verification — slicing axis: by day or by area. Per-attraction return fields: operating status on target date · last-admission time · booking lead time + channel · current ticket price · source URL + research date.
- Post-disaster / advisory closure-status recheck is **not** done here — it fires on a specific signal and folds into the pre-trip recheck block per [safety-and-emergency.md](safety-and-emergency.md) §6.

## Non-Goals

- Do not present a capacity-capped attraction as a confirmed plan item without its booking lead time / status.
- Do not schedule against closing time when last admission is earlier.
- Do not stack two heavy timed anchors in one day.
- Do not exceed the intake pace's density ceiling without surfacing the conflict.
- Do not output attraction names, ticket prices, or ratings from training data without verification — the [knowledge-layers.md](knowledge-layers.md) rules apply to attractions exactly as to restaurants.
- Do not build a destination-specific capacity database here — name examples, teach the category logic; the live booking page is the source of truth.
