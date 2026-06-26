# Dining Rules

Governs restaurant and dining recommendations across the full trip. These rules supplement and take precedence over general planning rules when the output includes meal recommendations.

Applies to `planning-only`, `guide-redesign`, and `existing-page-refactor` whenever restaurants appear. For tables, failure modes, channels, lead-times, swap cascade details, and the markets / hawker exception, see [deep/dining-rules.md](deep/dining-rules.md).

## 1. Cuisine Diversity Across the Trip

### Rule

- Track every main meal (lunch + dinner) on a `day × meal × cuisine` matrix.
- **Signatures first, variety for the rest.** Place the destination's signature categories per §12 before applying diversity. After signatures are placed, each *remaining* cuisine category appears at most once unless the user explicitly asks for repetition. Diversity never blocks a §12 signature (a repeated signature is not a violation).
- Backup picks count against the matrix.
- Check the matrix before drafting each meal; on swap, re-check the whole matrix.

Trigger: any itinerary with 2+ meals. Pointer: [deep/dining-rules.md](deep/dining-rules.md) §1.

## 2. Operating-Status Verification (No Trust in Training Data)

### Rule

Small restaurants close, relocate, rebuild on short notice. **Do not trust restaurant knowledge from training data** — every recommendation must be verified online before output finalizes.

Check all four: closure / rest notices in destination language · 404 or "new store" redirect · Google Maps status banner ("Permanently closed" always overrides) · platform page integrity (name / address match).

Trigger: every restaurant recommendation, always. Pointer: [deep/dining-rules.md](deep/dining-rules.md) §2.

## 3. Target-Date Operating Calendar

### Rule

Every restaurant must be checked against the **specific trip date**, not its usual pattern. Weekly closures + destination-specific peak closures eliminate otherwise-good picks.

Record per restaurant: regular closed days · holiday-season notices · irregular / chef's-discretion flags · **opening hours**.

**Opening hours must cover the meal slot you schedule it in.** A shop that opens at 16:30 cannot be a lunch pick, however famous. Check before slotting — do not place a venue, then discover the clash. Single-item / sell-out venues (limited daily stock, "sells out by X") get the same gate: if its open-and-stocked window doesn't cover the slot, it is not that meal's pick — surface it as a flagged optional detour, not a main.

Trigger: any restaurant with a regular day off, or trip window overlapping a destination peak (Japan GW / China Spring Festival / Europe Christmas / Middle East Ramadan + Eid etc.). Pointer: [deep/dining-rules.md](deep/dining-rules.md) §3.

## 4. Address and Ward Consistency

### Rule

- The district in the restaurant name must match the district in the official address.
- For multi-branch chains, confirm which branch the user will actually visit.
- If the name implies a district that doesn't match the address, find an actual in-district alternative.

Trigger: restaurant names embedding a district (Ebisu 恵比寿, 外滩, Trastevere, etc.).

## 5. Precise Coverage of User Food Preferences

### Rule

User food preferences usually specify three things: **meal slot + cuisine + area**. All three are binding — do not drop the area constraint to improve the cuisine match or vice versa.

"X or Y" cuisine requests produce two main-line candidates, not a merged pick. Area default: within 10-minute walk of the referenced anchor.

Required fields per restaurant card (all four): cuisine category · platform rating · walking time from anchor · per-person price band in local currency.

Trigger: any user-stated food preference. Rating floors + price tier calibration: [deep/dining-rules.md](deep/dining-rules.md) §5 + [travel-sources.md](travel-sources.md).

## 6. Route Consistency (Dinner Fits the Evening's Location)

### Rule

Dinner is decided by the location of the evening's main activity, not the other way around. A "better" restaurant 30 min outside the activity area is not better.

- Evening plan in area X → all dinner mains + backups within 10-min walk of X.
- Area X must have ≥ 2 candidates.
- Drop-in slots must be in the same ward as the anchor.

## 7. Reservation Channel and Lead Time

### Rule

Every restaurant requiring reservation must state its channel + lead time, using destination-appropriate platforms. Irregular closures require a visible "call to confirm before travel" label.

Channels + lead-time table: [deep/dining-rules.md](deep/dining-rules.md) §7.

## 8. Peak-Season Pre-Trip Recheck Block

### Rule

Every guide output covering a peak window carries a "3–5 days before departure" recheck block at the bottom.

Peak examples: Japan GW / O-Bon / New Year; China Spring Festival / National Day / May Day; Europe Christmas / Easter / August; US Thanksgiving / Christmas; Middle East Ramadan.

Required contents: irregular-closure venues by name and target date · reservations needing re-confirmation · destination-specific peak-day warnings. Pointer: [deep/dining-rules.md](deep/dining-rules.md) §8.

## 9. Cascading Updates on Restaurant Swaps

### Rule

Swapping any restaurant requires updating every place it is referenced: daily meal line · detail card · pre-trip recheck block · navigation anchors · cuisine matrix (§1).

Trigger: any restaurant / hotel / anchor swap after first draft. Flow: [deep/dining-rules.md](deep/dining-rules.md) §9.

## 10. Verification Batch Workflow

### Rule

Trigger: trips with 5+ dining picks. Run the fan-out per SKILL.md §Batch Verification.

Per-venue return fields: operating status · address · regular closures · peak-season notes · reservation channel · source URL. Pointer: [deep/dining-rules.md](deep/dining-rules.md) §10.

## 11. Search Advisory Fallback

When web search is unavailable or all verification attempts fail for restaurant recommendations, output a search advisory card per [knowledge-layers.md](knowledge-layers.md) §5. Never fall back to "approximate" labeling or training-data names for restaurants and dishes — the §2 absolute ban applies regardless of degradation path.

**Exhaust channels before degrading.** A login wall on one platform is not "all verification attempts failed" — the [knowledge-layers.md](knowledge-layers.md) §6 exhaustion gate applies: try ≥2 channels (≥1 search aggregator) first. The advisory card is a last resort, not the response to the first 302.

| Rationalization | Reality |
|---|---|
| "Dianping needs login → can't verify → output advisory card" | The login wall blocks Dianping's *own* page; the same shop name/rating is indexed by aggregators. **Not allowed to degrade before trying an aggregator.** |
| "I already tried two platforms (Dianping + Amap), both login-walled" | Two login walls on the *same kind* of source ≠ exhaustion. The required retry is a **search aggregator**, which neither of those is. |

🚩 **Red flag — STOP before writing a restaurant search advisory card:** ask "how many channels did I try, and was one an aggregator?" Fewer than 2, or zero aggregators → keep searching, do not degrade.

## 12. Destination Signature Priority

### Rule

Before optimizing for variety, ask the real question: **what is this place best at?** A trip to Osaka that never eats 粉物 (takoyaki / okonomiyaki), or to San Sebastián that skips pintxos, or to Hakata that misses tonkotsu ramen, has failed the traveler — however "diverse" the matrix looks. The goal is the food worth traveling for, not a rule-satisfying spread.

- **Place the destination's signature categories first.** Identify the 1–3 dishes/categories the destination is genuinely known for (verify the claim per §2 / [travel-sources.md](travel-sources.md) — do not assert "famous for X" from training data alone) and give them meal slots before filling the rest.
- **Signatures may repeat; variety yields to them.** A signature category is allowed to appear more than once when the destination justifies it (two 粉物 meals in Osaka is correct, not a violation). The §1 diversity rule applies only to the *remaining* slots after signatures are placed — it never blocks a signature.
- **Respect the slot the signature belongs to.** Some signatures are time-bound: a fish-market breakfast (Tsukiji 朝食), a late-night ramen, a morning-only 朝粥, a night-market crawl. Place it in its real slot per §3 opening hours — a breakfast signature is not a dinner pick.

Trigger: any destination with a recognized signature cuisine (almost all). Defer to explicit user preference when it conflicts (if the user says "no repeats," honor it).

## Non-Goals

- Do not rely on general training-data restaurant knowledge. Every pick passes §2.
- Do not present a restaurant without the four required fields in §5.
- Do not ignore the cuisine matrix to squeeze a favorite category twice unless user asked — but a destination signature placed per §12 is not a "favorite squeeze"; it takes priority over diversity.
- Do not optimize for a diverse matrix at the cost of skipping what the destination is actually famous for — signatures come first (§12).
- Do not skip pre-trip recheck for peak-season trips.
- Do not update only the day card on swap — always run §9 cascade.
