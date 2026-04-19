# Hotel Selection

## Purpose

Recommend hotels that are actually usable for the trip, not just popular on paper.

## Inputs To Use

- Destination
- Travel dates
- Budget
- Trip purpose
- Party size
- Room style if needed

## Evidence Standard

- Prefer hotels that appear repeatedly in mainstream travel guides or have strong ratings on Trip.com, Airbnb, Google Maps, and major OTAs.
- Do not rely on a single source when the choice is important.
- If the evidence is weak, label the hotel as avoid or omit it.

## Tiering

- `mass-market`: practical, broad appeal, reliable value
- `recommended`: strongest fit for most users
- `niche`: good but only for a specific use case
- `avoid`: weak rating, bad location, poor value, or booking friction

## Output Rules

- Group hotels by budget first, then by quality tier.
- For each option, state:
  - area
  - transit convenience
  - budget fit
  - why it belongs in the tier
  - whether it is a first pick, backup, or avoid
- If you cannot verify quality, do not promote the hotel.

## Presentation Rule

- Keep hotel recommendations short and scannable.
- Put the best option first in each budget group.
- Keep only a few strong options per tier.

