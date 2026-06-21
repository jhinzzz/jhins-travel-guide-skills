# Weather and Output

Covers two topics that affect how the output is shaped but do not belong in intake or trip prep: weather-aware planning and output-format selection. The independent-vs-guided travel decision lives in [travel-mode.md](travel-mode.md).

## 1. Weather

- Use the forecast for the travel window when available.
- If forecast is unavailable, use seasonal averages for the destination and dates.
- Adjust packing, shoes, outerwear, rain gear, sunscreen, hydration, indoor/outdoor ratio, and pacing.
- Mark weather-only or weather-sensitive blocks clearly.

### Climate-Shift Risk — historicals are weakening

When using seasonal averages or climatologies (e.g., "Paris August ~25 °C"), flag explicitly that historical averages increasingly under-predict extremes. Surface patterns below when the trip window is relevant:

- **European summer heatwaves** — Paris / Rome / Madrid / Athens now regularly hit 38–42 °C for multi-day stretches in July–August. Many older hotels and Airbnbs in historic centres have no AC. For June–August trips in continental Europe, recommend AC-equipped lodging explicitly and plan siesta-style midday indoor blocks.
- **Cherry blossom shift (Japan / Korea)** — mean peak bloom in Tokyo / Kyoto has drifted ~1 week earlier over the past two decades. Booking a "late-March / early-April 2026" trip on historical averages may miss peak bloom. Cross-check current-year JMA / KMA forecasts at booking time, not seasonal averages.
- **Late-season typhoons (East / Southeast Asia)** — typhoon season now reliably extends into November in Japan / Philippines / Vietnam. A "post-season" October–November trip is no longer typhoon-safe by default. Keep transport backups per [transportation.md](transportation.md).
- **North-American wildfire smoke** — summer smoke events (Canadian fires → US East Coast AQI spikes; Pacific Northwest smoke summer–fall) can ruin outdoor-heavy itineraries even hundreds of km downwind. Include an AQI check 1–2 weeks before departure for outdoor-focused trips in affected regions June–October.
- **Coral / marine-season shifts** — bleaching events, jellyfish blooms, and algal blooms no longer track textbook seasons. For dive / snorkel destinations, cross-check a current marine advisory (reef authority, NOAA, destination dive operators) at booking.
- **Shoulder-season rainfall unpredictability** — "rainy season ends in early October" is no longer reliable in many tropical destinations. Recommend 1–2 flexible indoor-option days in the itinerary when the trip straddles a shoulder period.

### Weather Rule

When the output relies on seasonal averages rather than a live forecast, add a one-line disclaimer in the weather block: **"Historical averages under-predict extremes — re-check the forecast and any destination-specific advisory (heat / typhoon / AQI / marine) 1–2 weeks before departure."** Do not hide the caveat inside a long packing list.

## 2. Output Format

- If the user wants planning help only, a conversational itinerary or markdown outline is enough unless they explicitly ask for files.
- If the user wants a redesigned guide, trip-planner page, or other shareable artifact, produce both a markdown deliverable and an HTML deliverable.
- If the user wants a standalone page, output one HTML file.
- If the user wants a maintainable project, split HTML, CSS, and JS as needed.
- State the chosen HTML structure explicitly.

## 3. Downstream Pointers

- **Transportation** — see [transportation.md](transportation.md) for all transport rules: booking windows, arrival times, pricing, transfers, return-trip planning, output format.
- **Hotels** — see [hotel-selection.md](hotel-selection.md) for hotel tiering, evidence, and output rules.
- **Dining** — see [dining-rules.md](dining-rules.md) for cuisine-diversity matrix, operating-status verification, target-date calendar checks, district / address consistency, meal × cuisine × area intake, reservation channels and lead times, peak-period pre-trip recheck, and swap-cascade rules.
- **Local specialties** — see [local-specialties.md](local-specialties.md) for souvenir and specialty selection criteria, tiering, and output format.
- **Research sources** — see [travel-sources.md](travel-sources.md) for the canonical list of travel information sources, cross-referencing rules, and citation format. All factual claims must be traceable to sources listed there.
