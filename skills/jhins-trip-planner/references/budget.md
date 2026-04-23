# Budget

Budget is touched on every trip. A single total is not a plan — without category splits, hidden costs, refundable decisions, and FX timing, the final bill drifts 20–40%. The 15% overage checkpoint in SKILL.md still applies; this file is the structure it checks against.

For tables, extended examples, and destination-specific detail, see [deep/budget.md](deep/budget.md).

## 1. Category Split by Region Band

### Rule

- Apply a region-band default split (7 tiers; table in deep) in the destination's primary currency, with a CNY / USD shadow for cross-currency trips.
- Adjust one category based on stated theme or party mix (food / adventure / kids). Never silently rebalance.
- Buffer is non-negotiable. Do not remove buffer to fit a tight budget.
- Split excludes round-trip international transport (cross-strait counts as international here).

Trigger: any trip with a stated total budget. Pointer: [deep/budget.md](deep/budget.md) §1.

## 2. Hidden Costs

### Rule

Surface only costs the destination or party actually triggers. Format: **situation → specific line item**.

Common classes: entry / departure tax · tipping layer · IC / transit deposits · foreign-transaction fees · DCC trap · duty-free carry-on limit · self-drive hidden lines · seasonal surcharges · return-country customs · child pricing · nightmarket cash stacking.

Trigger: destination-specific (Bali departure tax, US tipping, Taiwan EasyCard, Argentina rate divergence, etc.). Pointer: [deep/budget.md](deep/budget.md) §2.

## 3. Refundable vs Non-Refundable Decision

### Rule

Refundable premiums cost 15–40% more. Spend when party mix, visa status, or trip window triggers risk (7 triggers in deep). Skip for flexible solo / short / low-risk / already-flexible itineraries (4 scenarios in deep).

Output must state the decision explicitly per booking. Don't leave the user to guess.

Trigger: any booking with a refundable option. Pointer: [deep/budget.md](deep/budget.md) §3.

## 4. FX and Payment Timing

### Rule

Cross-currency budgets must state the assumed rate + research date + FX buffer. A 5% FX shift across 3 months is normal.

Five decision tiers by destination stability: **lock early** (volatile: TRY / ARS / ISK / EGP) · **hold USD/EUR cash** (capital-controlled: Argentina / Egypt / Russia) · **pay by card at network rate** (stable + no-FX-fee: EU / Japan / Korea / Taiwan / US) · **pay cash** (thin card acceptance: Germany bakeries / Japan rural / Taiwan night markets / SE Asia outside hubs) · **always refuse DCC** at every POS.

Trigger: any cross-currency trip. Pointer: [deep/budget.md](deep/budget.md) §4.

## Non-Goals

- Not a list of specific hotel / flight prices — that lives in each day's card with its source per [travel-sources.md](travel-sources.md).
- Not a replacement for the 15% overage Confirmation Checkpoint in SKILL.md — this file gives the structure that the checkpoint checks against.
- No recommendations on specific financial products (credit cards, travel cards, insurers) — naming a product dates the skill. Point at the category; let the user pick.
