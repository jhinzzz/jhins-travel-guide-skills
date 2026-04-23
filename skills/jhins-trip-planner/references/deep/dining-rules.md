# Dining Rules — Deep Reference (opt-in)

Extended examples, failure modes, reservation channels, lead-time tables, and cascade workflow for `dining-rules.md`. Only read when a dining-heavy itinerary crosses the trigger (≥5 venues, peak period, swap cascade, restaurant verification failure).

## 1. Cuisine Diversity — Extended

Build a matrix keyed by `day × meal` tagged with cuisine category. Use the natural vocabulary of the destination:

- Japan: shabu-shabu, tempura, sushi, yakiniku, ramen, soba, izakaya, sashimi…
- China: 川菜 / 粤菜 / 本帮菜 / 淮扬菜 / 火锅 / 烧烤 / 面食…
- Italy: pizza, pasta, osteria, trattoria, seafood, risotto…
- US: steakhouse, BBQ, seafood, brunch, diner, New American…

Rules:
- A given category appears at most once across the full trip unless the user explicitly asks for repetition ("ramen every day").
- Backup picks count against the matrix — a backup cannot share a category with any main line.
- Check the matrix before drafting each meal, not after.
- On swap, re-check the whole matrix — replacing one meal can free or re-occupy categories.

## 2. Operating-Status Verification — Extended

For every restaurant, check all four:

1. **Closure / rest notices in destination language**: Japanese 閉店・休業・移転・建替; Chinese 停业・歇业・搬迁・装修; English "Permanently closed" / "Temporarily closed" on Google Maps; Italian chiuso / trasferito; Spanish cerrado / traslado. Adapt to destination language + authoritative platform.
2. **404 or "new store" redirect** on the official site.
3. **Google Maps status banner** — "Permanently closed" overrides everything else.
4. **Platform page integrity** — if the platform ID now resolves to a different business (name mismatch, different address), treat original as closed / relocated.

Authoritative platform per destination: see [travel-sources.md](../travel-sources.md).

### Failure modes to watch for

- Multi-location chain where the flagship has moved / been rebuilt / on temporary closure — recommend the specific operating branch, not "the flagship".
- Platform page taken over by a relocated business of the same ID — the name on the page and the name you remember may not match.
- "Irregular days off" (不定休 / 不定期休息 / "chef's discretion") — flag for phone confirmation before departure, do not treat as "open every day".

### If verification keeps failing

Do not downgrade to guessing. See the parallel sub-agent protocol in SKILL.md Fallback Rules.

## 3. Target-Date Operating Calendar — Extended

### High-risk categories

- **Traditional / old-line** — Japan old-school soba / unagi / kaiseki / oden on 日祝休 (overlaps Golden Week); European fine dining on Sunday/Monday; many European restaurants on August vacation (ferragosto / les vacances); US fine dining on Monday.
- **Department-store / mall tenants** — follow the host property's calendar, not their own hours.
- **Destination peaks that trigger closures or special hours** — Japan Golden Week / O-Bon / New Year; China Spring Festival / National Day / May Day; Europe Christmas / New Year / Easter / August vacation; US Thanksgiving / Christmas; Middle East Ramadan (daytime closures) + Eid al-Fitr / al-Adha (2–4 day public holidays, date shifts by moon sighting, many venues closed or on special hours).

### Record per restaurant

- **Regular closed days** (Sunday + holidays; Monday; second and fourth Wednesdays — whatever the venue publishes).
- **Holiday-season notices** on the official site for destination-specific peak closures covering trip dates.
- **Irregular / chef's discretion** — flag explicitly: "Call to confirm before travel."

### Apply

Build a date list for the trip window, mark every non-weekday in red, cross-check every restaurant against its target date. A restaurant that fails the date check moves to a "weekday-only alternatives" pool.

## 5. Quality Bars and Price Tiers

Apply the rating floor on the destination's authoritative platform — see [travel-sources.md](../travel-sources.md) for exact thresholds per platform (Tabelog compressed scale, Dianping, TripAdvisor, Google Maps, etc.). Price tiers are always in local currency, calibrated to destination norms.

Principle: the higher-end the category (sushi, kaiseki, tasting menu), the higher the rating floor — near-miss picks at that tier are frequent tourist traps.

### Four required fields (main file §5)

Every restaurant card carries all four: cuisine category · platform rating · walking time from anchor · per-person price band in local currency.

## 6. Route Consistency — Extended

Dinner is decided by the **location of that evening's main activity**. A "better" restaurant 30 min outside the activity area is not better.

- Evening plan in area X, 17:00–21:00 → all dinner mains + backups within 10-min walk of X.
- Area X must have ≥ 2 candidates (main + backup).
- Drop-in slots ("add an oden stop") must be in the same ward as the anchor; otherwise not a real swap.

## 7. Reservation Channels and Lead Times

### Channels (pick by destination)

- **Japan**: TableCheck, Tabelog online, OMAKASE, Pocket Concierge, phone, official site, walk-in.
- **China**: 大众点评, 美团, 官方微信 / 小程序, phone, walk-in.
- **US / Europe / international**: OpenTable, Resy, SevenRooms, TheFork (Europe), Google reservations, official site, phone, walk-in.

Verify the channel is actually usable by a traveler — some Chinese platforms require a local phone; some Japanese forms are Japanese-only.

### Lead times

| Tier | Lead time | Peak adjustment |
|---|---|---|
| Tasting-menu / Michelin / top-end | 2–4 weeks (months for famous sushi / kaiseki) | +2 weeks peak |
| Popular mid-to-high-end | 1–2 weeks | +1 week peak |
| Well-regarded neighborhood | 3–7 days | +3–5 days peak |
| Casual / counter / walk-in | None | Flag queue peaks |

"Destination peak" = the holiday / season listed in §3 for that country.

### Irregular closures

If a candidate has irregular / chef's-discretion closures, the card must carry a visible "call to confirm before travel" label.

## 8. Peak-Season Pre-Trip Recheck Block — Required Contents

- Every restaurant with any of: irregular closures / closes on trip weekday-or-holiday / possible special holiday closure — listed by name and target date.
- Every reservation that needs re-confirmation.
- Peak-day warnings: tax-refund queues, airport / station rush, attraction crowds, return-leg transit disruptions.

## 9. Swap Cascade — Where to Update

1. Daily meal line in main view.
2. Dedicated restaurant info card / detail section.
3. Pre-trip recheck block (if listed).
4. Navigation anchors, headings, descriptions using the old name.
5. Cuisine matrix from §1 (free old category, occupy new).

Use a grep-first flow: list every occurrence of the outgoing name, update one by one. Never leave a stale name in a card title or anchor.

## 10. Parallel Batch Verification Workflow

For trips with 5+ dining picks, verification runs as a batch:

- List every restaurant requiring verification, grouped by day / ward / category.
- Spawn **2–3 parallel sub-agents**. Each returns a structured row per venue: operating status · address · regular closures · peak-season notes · reservation channel · source URL.
- Main conversation synthesizes + decides.
- Give user a status line: "Dispatched N sub-agents for venue verification".

See SKILL.md Fallback Rules for the general parallel sub-agent pattern.

## Edge: Markets and stall clusters as destination

A night market / hawker center / food hall / outdoor market is not a single restaurant — it's 100+ independent stalls. Verification applies at two levels:

- **Market-level**: is the market itself operating (seasonal closure, venue rebuild, permit issues)?
- **Stall-level**: if recommending specific stalls by name (豪大大雞排, 豪記大腸麵線, etc.), apply §2 to each.

If the recommendation is "visit Shilin night market Day 1 evening" (market as anchor), market-level verification suffices + pre-trip recheck includes "verify 2-3 signature stalls are open that night". If the recommendation names specific stalls, every named stall goes through §2.
