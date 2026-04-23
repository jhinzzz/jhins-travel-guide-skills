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

**Current state**: 14 cases with machine-checkable `assertions`, rule_refs verified by `check-provenance.sh` at commit time, but nothing actually runs the prompts through a model and checks the output.

**What it could look like**: a script (Node / Python, Anthropic SDK) that runs each case, applies two kinds of assertion: `grep-level` (must_contain / must_not_contain_literal) and `judge-level` (must_have_section, rule_refs traced). Ground truth is already structured; the harness just consumes it.

**Why not now**:
- 14 cases × ~30 tool calls each × several runs/month = tens of dollars. Not worth it for a single-person skill today.
- Judge-level assertion (LLM judging LLM) has drift risk.
- Manual case spot-checking on PR review catches most regressions.

**Worth doing when**:
- Skill adoption crosses 10+ regular users, OR used in a commercial context.
- A regression ships that would have been caught (motivation jumps).
- Anthropic offers batch/eval pricing that makes full-suite runs trivial.

### 2. Independent specialist skills (by trigger)

**Current state**: One skill, ten reference files, three with deep counterparts (opt-in extended).

**What it could look like**: separate skills published in the same marketplace, triggered by domain-specific words:

- `jhins-pet-travel` — trigger: 带狗 / 带猫 / pet carrier / 宠物检疫. Covers airline cargo/cabin policies, destination quarantine windows, pet-friendly hotels, EU pet passport.
- `jhins-business-travel` — trigger: 出差 / business trip / 发票 / VAT refund / work desk. Covers expense receipts, VAT refund ops, work-ready hotel fields, meeting buffer days.
- `jhins-lgbtq-safety` — trigger: partner / same-sex / trans / LGBTQ + destination in high-risk jurisdiction list. Covers entry-law maps, hotel double-bed defaults, passport-gender-vs-presentation risk, trans-specific airport lines.
- `jhins-cross-strait` — trigger: 台湾 / Taiwan / 往来台湾通行证 / 入台证 / 港澳通行证. Covers Mainland ↔ Taiwan / HK / Macau compact permits (not in trip-prep.md §2 — that's international visa only).
- `jhins-destination-japan` / `jhins-destination-italy` / etc. — only if user interaction volume per country justifies a dedicated skill.

**Why not now**:
- The main skill's 10 references are already covering the 80% case. Before forking specialist skills, confirm the 20% is painful enough for repeat users.
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

### 5. Agentic trip companion

**Current state**: static skill. Every invocation starts fresh from SKILL.md.

**What it could look like**: persistent trip memory ("replace Day 3 hotel with a sea-view one") · real-time API integrations (flight status, hotel availability, Google Maps) · interactive HTML output (swap in place) · in-trip companion for "now what?"

**Why not now**:
- Crosses from static skill to a full agent + backend + frontend project — different order of magnitude.
- API costs, API key management, rate limits all at once.
- Basic rules need to be bulletproof first — otherwise real-time data just industrializes flawed plans.

**Worth doing when**:
- Personal repeat use hits "would be nice if X" often enough.
- Sharing with family / friends where manual skill invocation is a barrier.

---

## Recording principle

- Only write **conditional-future** directions, not generic TODOs.
- Each item must answer "what would have to be true to do this." No answer → do it now, not here.
- Remove completed items — `git log` is the archive, not this file.
