# Future Directions

Not a roadmap. "Things we might want to do next + what would have to be true for it to be worth doing."

## Strategic positioning (as of v0.8.0)

This skill is a **general-purpose trip planner**. It is intentionally broad:
- Covers the skeleton: intake · round-trip transport · day-by-day · hotels · dining · specialties · budget · safety · weather.
- Does **not** try to be a deep specialist in any one domain. When a request hits a depth trigger (multi-country safety, tight FX budget, 5+ venue dining), the main reference points into `references/deep/*.md` for extended tables — still same skill, still opt-in.
- Future specialization (pet travel, business travel, LGBTQ safety, ICS export, real-time API) should land as **separate skills in the ecosystem**, not as new sections inside this skill. Trigger words should route the user to the specialist skill via Claude Code's skill discovery.

The main skill should stay thin. A few hundred lines total in `references/*.md` for the skeleton. Deep content goes in `references/deep/*.md` (opt-in) or separate skills (by trigger).

## Directions

### 1. Automated testing for `test-prompts.json`

**Current state**: 24 cases with machine-checkable `assertions`, rule_refs verified by `check-provenance.sh` at commit time, but nothing actually runs the prompts through a model and checks the output.

**What it could look like**: a script (Node / Python, Anthropic SDK) that runs each case, applies two kinds of assertion: `grep-level` (must_contain / must_not_contain_literal) and `judge-level` (must_have_section, rule_refs traced). Ground truth is already structured; the harness just consumes it.

**Why not now**:
- 24 cases × ~30 tool calls each × several runs/month = tens of dollars. Not worth it for a single-person skill today.
- Judge-level assertion (LLM judging LLM) has drift risk.
- Manual case spot-checking on PR review catches most regressions.

**Worth doing when**:
- Skill adoption crosses 10+ regular users, OR used in a commercial context.
- A regression ships that would have been caught (motivation jumps).
- Anthropic offers batch/eval pricing that makes full-suite runs trivial.

### 2. Independent specialist skills (by trigger)

**Current state**: One skill, twelve reference files, five with deep counterparts (opt-in extended).

**What it could look like**: separate skills published in the same marketplace, triggered by domain-specific words:

- `jhins-pet-travel` — trigger: 带狗 / 带猫 / pet carrier / 宠物检疫. Covers airline cargo/cabin policies, destination quarantine windows, pet-friendly hotels, EU pet passport.
- `jhins-business-travel` — trigger: 出差 / business trip / 发票 / VAT refund / work desk. Covers expense receipts, VAT refund ops, work-ready hotel fields, meeting buffer days.
- `jhins-lgbtq-safety` — trigger: partner / same-sex / trans / LGBTQ + destination in high-risk jurisdiction list. Covers entry-law maps, hotel double-bed defaults, passport-gender-vs-presentation risk, trans-specific airport lines.
- `jhins-cross-strait` — trigger: 台湾 / Taiwan / 往来台湾通行证 / 入台证 / 港澳通行证. Covers Mainland ↔ Taiwan / HK / Macau compact permits. As of v0.13.0, `trip-prep.md §2` carries a permit-awareness bullet + `deep/trip-prep.md §Cross-Strait Greater China Permits` carries the matrix; a dedicated skill remains the home for full cross-strait depth (booking channels, hidden costs, night-market cash, child pricing) **if the migration trigger below fires**. Migration trigger: cross-strait content in `trip-prep.md §2` / its deep section outgrows ~one screen, OR a second Greater-China dry-run reopens F6/F9/F11 (booking channels / Taiwan hidden costs / night-market cash). Until then, surgical patches in trip-prep stay.
- `jhins-destination-japan` / `jhins-destination-italy` / etc. — only if user interaction volume per country justifies a dedicated skill.

**Why not now**:
- The main skill's 12 references are already covering the 80% case. Before forking specialist skills, confirm the 20% is painful enough for repeat users.
- Each new skill needs its own `plugin.json`, `marketplace.json` entry, CHANGELOG, setup — overhead is real.
- The deep/ mechanism (v0.8.0) is cheaper for content that sits in the gray zone: "sometimes needed, always same domain."

**Worth doing when**:
- Dry-run trace (`session-learnings-*`) shows the same trigger repeatedly hitting a depth gap (e.g., 3 pet-travel requests in a month).
- Main reference file would cross 200 lines just to accommodate the specialist domain.

### 3. `thresholds.json` — centralize numeric rules

**Current state**: numeric thresholds scattered (15% budget overage · 6h daily driving · 3.45/3.55/3.80 Tabelog floor · 5-venue parallel-agent trigger · 250/220/260 line caps · etc.).

**What it could look like**: `references/thresholds.json`, referenced by key in rule files. Rule files read "use `budget_overage_confirm_threshold`" not "15%".

**Why not now**:
- LLM reads .md equally well from either place; no actual benefit for inference.
- Thresholds rarely change.
- Adds indirection cost to reading.

**Worth doing when**:
- A/B testing thresholds (rare in skill context).
- Thresholds need per-user-tier branching (e.g., "Japanese local ratings vs. foreign tourist expectations").

### 4. Destination triggers matrix

**Current state**: `intake.md` "Capture Relevance Rule" in prose — LLM reads + judges.

**What it could look like**: `triggers.yaml` mapping user-intent keywords to which capture fires (accessibility / adventure sub-intensity / child band / self-drive triad / festival overlap).

**Why not now**:
- Combinatorial explosion is worse in YAML than in prose.
- LLM handles bullet-list triggers fine today.

**Worth doing when**:
- A machine-readable trigger map is needed (e.g., pre-invocation filter in a routing skill that decides which specialist skill to call).

### 5. Attractions / activities reference

**Current state**: attractions are mentioned in Core Workflow step 4 ("attractions with booking windows") but have no dedicated reference file. Booking lead times, height/age minimums, capacity limits, seasonal closures, timed-entry slots, and peak-hour avoidance are all ad-hoc.

**What it could look like**: `references/attractions.md` with rules for: advance-booking lead times by category (theme park / museum / guided tour / activity), capacity-limited attractions (Alhambra, teamLab, Ghibli Museum, Anne Frank House), seasonal closures (mountain huts, polar regions, monsoon closures), peak-hour strategies, and the relationship between attraction density and pace.

**Why not now**:
- Most attraction logistics are destination-specific — a generic reference risks being either too thin to be useful or too fat to be general.
- The current per-day-card approach ("booking lead times stated") works for most cases.
- Dining, hotel, transport, and budget each had clear *repeated failure modes* that justified a reference. Attractions haven't yet shown the same pattern in test-prompt traces.

**Worth doing when**:
- A dry-run trace (or real user session) shows repeated failure on attraction booking (missed capacity, wrong timed entry, seasonal closure surprise) across 3+ different trips.
- A specific test case would need `rule_refs` pointing to attraction rules — and there's no file to point at.

### 6. Agentic trip companion

**Current state**: static skill. Every invocation starts fresh from SKILL.md.

**What it could look like**: persistent trip memory ("replace Day 3 hotel with a sea-view one") · real-time API integrations (flight status, hotel availability, Google Maps) · interactive HTML output (swap in place) · in-trip companion for "now what?"

**Why not now**:
- Crosses from static skill to a full agent + backend + frontend project — different order of magnitude.
- API costs, API key management, rate limits all at once.
- Basic rules need to be bulletproof first — otherwise real-time data just industrializes flawed plans.

**Worth doing when**:
- Personal repeat use hits "would be nice if X" often enough.
- Sharing with family / friends where manual skill invocation is a barrier.

### 7. Live-fetch smoke test in the release ritual

**Current state**: `check-all.sh` validates structure — anchors, versions, sizes, provenance links. `test-prompts.json` has 24 cases but nothing runs them against a model (FUTURE §1). The anti-scraping logic (v0.11/v0.12) is **runtime-conditional**: it only fires when a live fetch hits a login wall, and it is the least statically-testable code in the skill.

**What it exposed**: v0.12.0 shipped a snippet-level §2 bar that passed every static check and both adversarial plan-reviews, then **failed on the first real fetch** — the "≥2 aggregators agree" gate was unsatisfiable in practice (DuckDuckGo and Bing return disjoint results), which would have demoted a genuinely-open restaurant. A v0.7.2-style dry-run caught it; v0.12.1 fixed it. Static checks structurally could not.

**What it could look like**: before any release that touches `travel-sources.md` §Login-Wall Fallback / `knowledge-layers.md` §6 / `dining-rules.md` §2/§11, run one login-wall-heavy brief end-to-end with **real** WebFetch/WebSearch against the actual platforms (Tabelog / Dianping / DuckDuckGo HTML / Bing) and walk the canonical channel order + snippet bar. Capture findings as a committed (or at least retained) dry-run artifact. Lightweight form: a `scripts/`-adjacent checklist that names the brief and the four observations to record (did the authoritative page serve? did aggregators agree? did the qualifier read sensibly? did the bar clear a known-good shop?).

**Why not now (as automation)**:
- A scripted live-fetch harness needs a model in the loop + network + platform-shape stability — same cost/drift problem as §1's full eval suite.
- The manual dry-run already works and is cheap (~30 min), proven twice (v0.7.2 Taiwan, v0.12.0 Tokyo).

**Worth doing when**:
- A second anti-scraping release ships a runtime-conditional rule (the manual dry-run becomes a standing pre-release step, not an ad-hoc one).
- §1's eval harness gets built — fold the live-fetch smoke brief into it as one always-run case rather than a separate ritual.

### 8. Authenticated fetch via browser cookies

**Current state**: when a platform login-walls an anonymous fetch, the skill degrades to search-aggregator snippets (v0.11/v0.12). Snippets are a *discovery* layer — they carry name/rating but not the live page's full §2 signals (the Google Maps "Permanently closed" banner is unreachable to anonymous fetch at all).

**What it could look like**: an authenticated fetch path using the user's own session cookies (there is a `setup-browser-cookies`-style mechanism in the broader tooling) that defeats the login wall *directly* and returns the real platform page — strictly more evidence than scraping a re-indexed snippet. Plausibly the real 10× for anti-scraping: it would let §2's four live signals actually be checked instead of approximated.

**Why not now**:
- Different mechanism with its own risks: it handles the user's real credentials/cookies, raises platform-ToS questions, and couples the skill to a stateful auth setup it currently doesn't need.
- v0.11/v0.12 + v0.12.1's Case-A/Case-B reframe cover the common path well enough; the snippet route is additive, not blocking.
- Building it blind (before a dry-run shows the snippet path failing on real recommendations the user cares about) risks over-engineering.

**Worth doing when**:
- A dry-run or real session shows the snippet path repeatedly *failing to verify* restaurants/hotels the user actually wants (not just theoretically weaker — actually producing advisory cards where a logged-in fetch would have confirmed).
- The cookie/auth mechanism is already set up for another reason, making the marginal cost of wiring it into the skill small.

---

## Recording principle

- Only write **conditional-future** directions, not generic TODOs.
- Each item must answer "what would have to be true to do this." No answer → do it now, not here.
- Remove completed items — `git log` is the archive, not this file.
