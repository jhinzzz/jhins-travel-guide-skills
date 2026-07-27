# Trip Data Contract

The structured form of a finished plan. One object, `trip`, carrying everything the skill's rules produce.

Why it exists: an HTML deliverable that only holds prose has to be re-researched on every edit. Embed this object and later edits parse it, mutate it, and re-render — no second research pass, no drift between the prose and the data behind it.

Written as markdown because the consumer is an LLM. The mechanical half is enforced by [validate.js](validate.js), not by JSON Schema keywords.

## Shape

```js
const trip = {
  title, startDate, endDate,                   // ISO dates: YYYY-MM-DD
  mode,                                        // planning-only | guide-redesign | existing-page-refactor
  language,                                    // per SKILL.md §Language
  destination: { name, bbox },                 // bbox: [minLat, minLng, maxLat, maxLng] — optional, enables coordinate containment checks
  theme: [], pace,                             // intake.md §3 / §4
  party: { adults, children: [{ ageBand }], accessibility: [], medication: [] },   // intake.md §5 / §6 / §7
  assumptions: [],                             // every default filled at intake — non-empty whenever a default was used

  weather: {
    forecast,                                  // use when a live forecast was available
    seasonalAverages,                          // use otherwise — triggers the disclaimer below
    climateShiftDisclaimer,                    // REQUIRED when seasonalAverages is used — weather-and-output.md §1 Weather Rule
    advisories: []                             // heat / typhoon / AQI / marine
  },

  tripPrep: { visa, transitVisa, payment, sim, insurance, etiquette: [], festivalOverlap },   // trip-prep.md

  transport: [{                                // transportation.md §Output Format — all 9 fields
    leg,                                       // outbound | return — BOTH required
    modeAndRoute, bookingWindow, bookingChannel, schedule,
    seatClassAndPrice: { range, currency, source, date },
    recommendedArrival, hardCutoff, transferDetails, backupOption,
    perLegBaggage                              // transportation.md §Multi-Carrier Luggage Conflicts — when 2+ separate tickets
  }],

  hotels: [{                                   // hotel-selection.md §Output Card Format — all 8 fields
    nameAndTier, area, transit,
    rate: { range, currency, roomType, source, date },
    budgetFit, whyThisTier, verdict,
    hardware: { basis, cautionChip },          // basis: renovation year | recent-review proxy | 未能核实
    checkInOut, luggageStorage,
    coord: { lat, lng }                        // WGS-84
  }],

  days: [{
    date, weekday, archetype,                  // arrival | city | day-trip | weather-buffer | food-day | departure
    leadAnchor,                                // attractions.md §3 — exactly one per day
    slots: [{
      period, name, time, coord: { lat, lng },
      buffer,                                  // nearby 15–20 | cross-district 30–45 | +10–15 with luggage
      researchLinks: [{ platform, searchUrl }] // search URLs only, never a specific post
    }],
    attractions: [{                            // attractions.md §4 — all 7 fields
      nameAndCategory,
      booking: { leadTime, channel, status },  // status: booked | must-book-by <date> | release <date time>
      slotOrHours, lastAdmission, targetDateStatus,
      ticketPrice: { range, currency, source, date },
      accessibilityNotes, verdict,
      coord: { lat, lng }
    }],
    dining: [{                                 // dining-rules.md §5 — the 4 required fields plus operating status
      meal, name, cuisineCategory,
      rating: { value, platform, date },
      walkTimeFromAnchor,
      pricePerPerson: { band, currency },
      operatingStatus: { verified, checkedOn, source, tierQualifier },   // dining-rules.md §2
      closedDays, openingHours, reservationChannel, reservationLeadTime,
      isSignature,                             // dining-rules.md §12
      coord: { lat, lng }
    }],
    specialties: [{                            // local-specialties.md §Output Card Format — all 8 fields
      itemName, tier, whatItIs, whereToBuy,
      price: { range, currency, source, date },
      transportNotes, bestFor, sources,
      seasonWindow, coord: { lat, lng }
    }],
    selfDrive: { distance, drivingTime, longestSegment, routeBookApp }   // transportation.md §Rental Car / Self-Drive
  }],

  budget: {
    regionBand, themeAdjustment,               // budget.md §1
    categories: [{ name, amount, currency }],
    hiddenCosts: [],                           // budget.md §2
    refundableDecisions: [],                   // budget.md §3
    fx: { assumedRate, rateDate, buffer },     // budget.md §4
    statedBudget, overagePercent               // >15% means the checkpoint already happened
  },

  safety: {                                    // safety-and-emergency.md §§1-6
    emergencyNumbers: {}, hospital: {}, embassy: {}, insurerClaimPath: {},
    theftLossSteps: [], destinationRisks: [],   // each: risk → trigger → action
    thermalImmersion                           // safety-and-emergency.md §6, when triggered
  },

  backups: [{
    trigger,                                   // rain | sold out | weekly closure | typhoon | over budget
    replaces,                                  // D3-afternoon | D2-dinner
    with: {},                                  // same shape as the slot / dining / attraction it replaces
    note
  }],

  reminders: [{ item, leadDays, source }],     // dueDate = startDate − leadDays
  preTripRecheckBlock,                         // dining-rules.md §8 + safety-and-emergency.md §6 folded into ONE block
  dataSources: [],
  disclaimer
};
```

## Pre-staged backups

`backups[]` is the one field here with no existing rule behind it. [dining-rules.md](../references/dining-rules.md) §9 says how to *propagate* a swap once it happens, but nothing stages an alternative ahead of time — so when it rains on day 3, the traveller has nothing in hand. Each entry names its trigger, what it replaces, and the replacement, giving the swap cascade something to cascade to.

## Coordinates

- `trip` carries **WGS-84 only**. Amap and Tencent return GCJ-02; convert before writing, or the point lands a few hundred metres off on OSM tiles. `node validate.js --gcj02-to-wgs84 <lat> <lng>` does the conversion.
- Two distinct places may not share a coordinate. A collision means one of them was never actually looked up.
- Every coordinate must fall inside `destination.bbox` when one is given.

## Evidence fields are not optional

Any object carrying a `range` or `amount` — every price, fare, and rate — carries `source` and `date` alongside it. Same for `rating` (`platform` + `date`) and `operatingStatus` (`source` + `checkedOn`). This is [SKILL.md](../SKILL.md) §Data Traceability in structural form: a number with no source is the failure this whole skill exists to prevent, and it is the one failure a validator can catch mechanically.

## Validation

`node validate.js <trip.json | page.html>` — reads the object (from the file directly, or from the `<script id="trip-data">` block in an HTML deliverable) and reports what is missing. Exit 0 clean or warnings only, exit 1 on any error. `node validate.js --selftest` checks the validator itself.
