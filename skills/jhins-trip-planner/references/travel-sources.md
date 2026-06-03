# Travel Information Sources

## Purpose

Define the canonical set of travel information sources used for research, cross-referencing, and evidence verification. Every recommendation (itinerary, hotel, transport, dining, specialty) must be traceable to at least one source listed here.

## Evidence Principle

- Every factual claim (price, schedule, rating, availability) must cite its source and research date.
- Cross-reference at least two independent sources for significant decisions (hotel selection, transport booking, specialty recommendations).
- Prefer primary sources (official websites, booking platforms) over aggregated or user-generated content alone.
- When sources conflict, note the discrepancy and use the more conservative or recent data.

## Source Categories

### China Domestic Platforms

| Platform | Best For | URL | Notes |
|---|---|---|---|
| 马蜂窝 (Mafengwo) | Destination guides, user itineraries, attraction tips | mafengwo.cn | Strong community reviews; good for off-beaten-path insights |
| 携程 (Ctrip / Trip.com) | Hotel booking, flight/train prices, package tours | ctrip.com / trip.com | Price data is real-time; reliable for transport and hotel pricing |
| 去哪儿 (Qunar) | Price comparison for flights, hotels, trains | qunar.com | Good for budget comparison; cross-check with Ctrip |
| 小红书 (Xiaohongshu / RED) | Local tips, food recommendations, hidden gems, specialties | xiaohongshu.com | User-generated; verify popularity claims with a second source |
| 大众点评 (Dianping) | Restaurant ratings, local shops, services | dianping.com | China's Yelp — strong for dining and local business verification |
| 飞猪 (Fliggy) | Flights, hotels, travel packages | fliggy.com | Alibaba ecosystem; good for domestic China deals |
| 12306 | China rail schedules and tickets | 12306.cn | Official and authoritative for all China rail |
| 高德地图 / 百度地图 | Directions, transit routes, real-time traffic (China) | amap.com / map.baidu.com | Authoritative for China domestic navigation |

### Login-Wall Fallback (Search Aggregators)

Travel platforms — Chinese (Dianping, Ctrip, Mafengwo, Xiaohongshu, Amap) **and international (Booking.com, TripAdvisor, Google Maps, Tabelog)** — routinely gate their result pages behind a **login wall / 302 redirect / blank response / captcha / cookie-consent wall / rate-limit / geo-block** for anonymous fetches. The rule keys on the **failure mode**, not the brand — the platforms named here are examples, not an exhaustive list. When it happens, do **not** treat it as "no data" — climb the channel ladder below before degrading.

**Channel ladder — try in order; use the most capable rung the environment offers, fall through on failure.** The skill names *capabilities*, not specific tools — a runtime missing a rung simply skips to the next. A failure on one rung is a signal to climb, **not** to degrade to an advisory card.

1. **Static fetch (no JS)** — the default web-fetch. Serves server-rendered pages; Tabelog list pages routinely return full anonymous data here. Returns only page chrome / blank for JS-rendered apps (Google Maps, most OTA result pages). A blank/chrome result is **not** "no data" — it means the content is script-rendered; fall through, do not treat as verification failure.
2. **JS-rendering headless browser (if available)** — executing the page's JavaScript recovers what a static fetch cannot: Google Maps search results, ratings, and the **operating-status / "Permanently closed" banner** (the [dining-rules.md](dining-rules.md) §2 signal that is otherwise unreachable to anonymous fetch). This rung alone clears most dining §2 verification. No credentials, no login.
3. **Fingerprint-resistant render (if available)** — some OTAs (Booking, Ctrip) silently degrade for a headless fingerprint: chrome renders but results/prices stay hidden even with JS. A headed / anti-fingerprint render recovers OTA listings and prices. This defeats bot-detection, **not** a login wall — still no credentials.
4. **Search aggregators (guaranteed floor)** — re-index the same content as result snippets (table below). Always available, weakest evidence. Use when no richer rung exists or the rungs above also fail.

A live page recovered by rung 2 or 3 is **stronger** than a rung-4 snippet — it is a live fetch of the authoritative source, so cite it normally (Case A below), not with the snippet qualifier. The tier-4 aggregators:

| Aggregator | Best For | URL | Notes |
|---|---|---|---|
| DuckDuckGo (HTML endpoint) | Anonymous web search that returns parseable snippets | html.duckduckgo.com/html/ | **First aggregator to try.** If a native web-search tool is available, use it for snippets too; the DuckDuckGo HTML endpoint is the **guaranteed floor** — never assume a richer tool exists. Snippets routinely carry shop name · address · per-person price · rating sourced from Dianping / Ctrip / Mafengwo / TripAdvisor / Tabelog. |
| Bing | Second search aggregator for cross-checking | bing.com/search | Use a second aggregator to confirm a name surfaced by the first. |

These are a **retry channel, not a primary source** — the underlying datum still belongs to Dianping / Ctrip / etc. and is cited as such (e.g., `大众点评 4.5分（经 DuckDuckGo 聚合, 2026-05-30）`). A single platform's login wall is **not** a verification failure — see [knowledge-layers.md](knowledge-layers.md) §6 exhaustion gate before degrading to a search advisory card.

#### Clearing a restaurant when the authoritative page may be walled

A live authoritative page (Tabelog / Dianping / TheFork …) gives [dining-rules.md](dining-rules.md) §2's four signals. Two real cases — check **Case A first**:

**Case A — the authoritative platform served data (any ladder rung).** A live page from the platform's own list / detail page, recovered at **any** rung — static fetch (Tabelog list pages routinely do), JS-rendering render (Google Maps results + status banner), or fingerprint-resistant render (OTA listings) — is a live fetch of the authoritative source. If you have live name + rating + price + ward, that **is** §2 verification — cite it normally (no qualifier), and **do not run the weaker snippet bar you don't need**. The ladder's lower rungs are fallbacks, not the default path.

**Case B — the authoritative page stayed walled at every available rung; only aggregator snippets are reachable.** A snippet can't reproduce §2's live signals, so this bar is **explicitly weaker** and the output must say so. (The Google Maps "Permanently closed" banner is unreachable to a *static* fetch — but a JS-rendering rung, if the environment has one, recovers it, which lands you in Case A. Case B is the genuine floor: no render rung available, or it too failed.) Clear a restaurant from snippets only when **all** hold:

1. **Name + rating corroborated by either** (a) one snippet *sourced from the authoritative platform* (a DuckDuckGo/Bing result carrying the Tabelog/Dianping name + score), **or** (b) ≥2 independent aggregator hits on the same name + address. Aggregators routinely surface *different* shops for the same query, so exact cross-aggregator agreement is the exception — an authoritative-sourced single snippet counts; a single *generic* snippet is candidacy only.
2. **Recent activity** — current-year review dates or a current price; stale-only hits do not clear it.
3. **No closure / relocation language** in any reachable snippet (停业 / 歇业 / 閉店 / 移転 / "permanently closed" / chiuso …). The live Maps banner may be unreachable — do the strongest closure check the reachable channels allow, and flag residual uncertainty rather than implying a banner check you couldn't run.
4. **Name + district match the address** (the §4 ward-consistency check — doable from snippet text).

Output a Case-B restaurant **with a visible tier qualifier**: `（经聚合器快照核实，非活页 / verified via aggregator snippet, not live page）`. If the bar is **not** met → candidacy only → not a main pick → degrade to a search advisory card per [knowledge-layers.md](knowledge-layers.md) §5. Neither case weakens [dining-rules.md](dining-rules.md) §2's absolute ban: a name with **zero** evidence still never ships, regardless of degradation path.

### International Platforms

| Platform | Best For | URL | Notes |
|---|---|---|---|
| TripAdvisor | Hotel and restaurant reviews, attraction rankings | tripadvisor.com | Global coverage; strong for Western destinations |
| Klook | Activity tickets, day tours, transport passes | klook.com | Good for Asia-Pacific bookings; real-time pricing |
| Lonely Planet | Destination guides, cultural context, itinerary ideas | lonelyplanet.com | Editorial authority; good for context and planning |
| Trip.com | International hotel and flight booking | trip.com | Ctrip's international arm; strong for Asia |
| Condé Nast Traveler | Luxury travel, curated recommendations, best-of lists | cntraveler.com | Editorial picks; good for upscale recommendations |
| Booking.com | Hotel booking, guest reviews | booking.com | Wide global coverage; reliable pricing |
| Google Maps | Directions, transit, restaurant/shop reviews, popular times | maps.google.com | Global navigation; popular-times data for crowd planning |
| Agoda | Hotels in Asia-Pacific | agoda.com | Strong for Southeast Asia and East Asia hotel deals |
| Skyscanner | Flight price comparison | skyscanner.com | Meta-search; good for finding the cheapest flight options |
| Rome2Rio | Multi-modal transport routing | rome2rio.com | Useful for comparing flight vs. rail vs. bus options |
| Japan-Specific: Tabelog | Restaurant ratings in Japan | tabelog.com | Japan's authoritative dining guide; ratings are strict — see Tabelog rating tiers below |
| Japan-Specific: Navitime / Jorudan | Japan transit routing | navitime.co.jp / jorudan.co.jp | Authoritative for Japan rail and bus schedules |
| Europe-Specific: Trainline / Rail Europe | European rail booking | thetrainline.com / raileurope.com | Cross-border rail booking and pricing |

### Official and Authoritative Sources

| Source Type | Examples | When to Use |
|---|---|---|
| Airline official sites | airchina.com, ana.co.jp, etc. | Final fare verification, baggage rules, schedule confirmation |
| National rail sites | 12306.cn, jreast.co.jp, sncf.com, bahn.de | Schedule and pricing authority |
| Government tourism boards | japan.travel, visitkorea.or.kr, visitdubai.com, etc. | Visa requirements, entry rules, official event calendars, licensed-operator whitelists |
| Embassy / consulate sites | — | Visa processing times, entry requirements |
| Weather services | weather.com, jma.go.jp, weather.com.cn | Forecast and seasonal data |
| UAE licensed tour operators | visitdubai.com (DTCM / Dubai Department of Economy and Tourism certified list) | Desert safari / guided tour operator vetting in Dubai — use this in place of generic TripAdvisor floors |
| Moveable religious-festival calendars | UAE Moon Sighting Committee, Saudi Umm al-Qura calendar, Israel Ministry of Religious Services, Thailand Buddhist Lent calendar | Year-specific dates for Ramadan, Eid al-Fitr / al-Adha, Sabbath observance windows, Vassa (Buddhist Lent) — dates shift by year and sometimes by ±1 day at last-minute moon sighting |

## Source Selection Rules

### Which sources to use when

| Information Type | Primary Source | Cross-Check Source |
|---|---|---|
| Flight prices and schedules | Airline website or Skyscanner | Ctrip / Trip.com / Qunar |
| Train schedules (China) | 12306 | Ctrip |
| Train schedules (Japan) | Navitime / Jorudan | Google Maps |
| Train schedules (Europe) | National rail site | Trainline / Rome2Rio |
| Hotel pricing and reviews | Booking.com / Ctrip / Trip.com | TripAdvisor / Google Maps / Agoda |
| Restaurant recommendations | Dianping (China) / Tabelog (Japan) / TripAdvisor (intl) | 小红书 / Google Maps |
| Any platform login-walled / blocked (302 / blank / captcha / consent wall) | See §Login-Wall Fallback (canonical channel order) | — |
| Local specialties | 马蜂窝 / 小红书 | Dianping / TripAdvisor / Lonely Planet |
| Attraction info and tickets | Official site / Klook | 马蜂窝 / TripAdvisor |
| Visa and entry | Embassy / government site | Travel forum cross-check |
| Weather | Weather service for the destination | Seasonal averages from Lonely Planet / travel guides |

## Restaurant Rating and Price Benchmarks

Use these benchmarks when evaluating a restaurant on its authoritative platform. See [dining-rules.md](dining-rules.md) §5 for how they combine with meal × cuisine × area intake.

### Platform rating floors

Apply the rating floor of the destination's authoritative platform — different platforms use different scales, so a "good" score is not universal.

| Platform | Scale | Recommendation floor | Notes |
|---|---|---|---|
| Tabelog (Japan) | 3.00–5.00, compressed | ≥ 3.45 for casual categories; ≥ 3.55 for sushi / sashimi / high-end; ≥ 3.80 for Michelin-adjacent | Strict scale — 3.50+ is excellent; 4.00+ is rare. |
| Dianping (China) | 1.0–5.0 | ≥ 4.5 stars with volume | Urban top tier typically 4.6–4.9. |
| TripAdvisor | 1.0–5.0 | ≥ 4.0/5 with 100+ reviews | Skews slightly high for tourist spots — cross-check with locals' platform. |
| Google Maps | 1.0–5.0 | ≥ 4.3 stars with volume | Global fallback when no local platform exists. |
| Local-authority alternates | Varies | Use the published "good" threshold | TheFork (EU), Yelp (US), OpenRice (HK/SG), Zomato (India) etc. — check the platform's own definition of a strong score. |

Rule of thumb: higher-end cuisine (sushi, kaiseki, tasting menus, Michelin) → raise the rating floor, because near-misses are common tourist traps.

### Per-Person Price Tiers

Price tiers are always stated in **local currency** and calibrated to local dining norms. A "Mid" band in Tokyo, Shanghai, Rome, and Kansas City lands on very different numbers.

Use **three tiers** per destination:

- **Value** — where locals eat on a normal weeknight
- **Mid** — nice dinner out, special occasion for an average worker
- **High** — splurge / landmark / Michelin-tier

Research the local tier ranges on the destination's dominant platform before writing the first restaurant card. Example anchors (dinner, per person):

| Destination | Value | Mid | High |
|---|---|---|---|
| Japan (Tokyo) | < ¥6,000 | ¥6,000–10,000 | > ¥10,000 |
| China Tier-1 (Shanghai / Beijing) | < ¥200 | ¥200–500 | > ¥500 |
| Western Europe (Rome / Paris) | < €40 | €40–90 | > €90 |
| US major metros | < $40 | $40–100 | > $100 |

These are illustrative — verify on the platform at research time; adjust for smaller cities and recent inflation.

When a "High" item is recommended, include a same-category "Mid" backup so the user has a lower-price option.

## Operating-Status Detection

Every venue must have its current operating status verified before appearing in the output. Treat these signals as hard disqualifiers, regardless of destination:

- **Google Maps** page shows "Permanently closed" or "Temporarily closed" banner.
- **Official website** returns 404, shows a closure / on-hold / relocation / rebuild notice in the destination's language (examples: 閉店・休業・移転・建替 in Japan; 停业・歇业・搬迁 in China; "chiuso" in Italy; "cerrado" in Spanish-speaking countries), or redirects to a "new location" link.
- **Authoritative platform page** (Tabelog / Dianping / TheFork / TripAdvisor, etc.) has been repurposed — the name on the current page does not match the name you searched for.
- **Multiple independent searches** for the same venue ID return different businesses — strong signal that the original closed or relocated.

When verification is ambiguous (WebFetch fails, pages conflict), do not guess. Either retry with a different source, or batch the venue into a parallel sub-agent sweep per the SKILL.md Fallback Rules.

## Citation Format

When citing a source in the output, use this compact format:

- Inline: `(来源: 携程, 2026-04-18)` or `(Source: Booking.com, checked 2026-04)`
- For price data: `¥400–¥650/晚 (携程, 2026-04-18)`
- For ratings: `大众点评 4.8分` or `TripAdvisor 4.5/5`
- For schedules: `(12306, 查询日期 2026-04-18)` or `(JR East, checked 2026-04)`

Always include the research date — travel data changes frequently.

## Non-Goals

- Do not treat any single platform as the sole authority — always cross-reference.
- Do not cite sources you did not actually consult — if the data is from general knowledge, state that explicitly and mark as approximate.
- Do not use outdated data without flagging the age — if the research date is more than 3 months old, note it.
- Do not recommend platforms for tasks they are weak at (e.g., do not use Lonely Planet for real-time pricing).
