#!/usr/bin/env node
'use strict';
// validate.js — mechanical checks on a trip object. Zero dependencies.
//
//   node validate.js <trip.json | page.html>   validate a plan
//   node validate.js --gcj02-to-wgs84 <lat> <lng>
//   node validate.js --selftest
//
// Exit 0 on clean or warnings only, 1 on any error — same convention as the
// check-*.sh scripts. Checks only what is decidable from the data: presence,
// pairing (a price with its source), counts, and geometry. Whether a rule was
// followed in spirit stays an LLM judgement; see SKILL.md §Final Check.

const fs = require('fs');

const errors = [];
const warnings = [];
const err = (path, msg) => errors.push(`${path}: ${msg}`);
const warn = (path, msg) => warnings.push(`${path}: ${msg}`);

const missing = (v) => v === undefined || v === null || v === '' ||
  (Array.isArray(v) && v.length === 0);

// Require every field in `fields` on `obj`. Used for the card formats that
// reference files define as a fixed field list.
function requireFields(obj, fields, path) {
  if (!obj || typeof obj !== 'object') { err(path, 'expected an object'); return; }
  for (const f of fields) if (missing(obj[f])) err(path, `missing ${f}`);
}

// Data Traceability: a number the user could act on carries where it came from
// and when. The field names differ by kind — a rating cites its platform, a
// price its source, an operating status its checkedOn date.
function requireSourced(obj, path, sourceField = 'source', dateField = 'date') {
  if (missing(obj)) return; // absence is the caller's check, not this one's
  if (typeof obj !== 'object') {
    err(path, `expected an object with ${sourceField} + ${dateField}`); return;
  }
  if (missing(obj[sourceField])) err(path, `missing ${sourceField} (Data Traceability)`);
  if (missing(obj[dateField])) err(path, `missing ${dateField} (Data Traceability)`);
}

// --- GCJ-02 → WGS-84 ------------------------------------------------------
// Inverse of the published GCJ-02 offset, solved by iteration: apply the
// forward transform to the current guess and subtract the residual. Converges
// to well under a metre in a handful of rounds.
const PI = Math.PI;
const A = 6378245.0;          // Krasovsky 1940 semi-major axis, as GCJ-02 uses
const EE = 0.00669342162296594323;

function outOfChina(lat, lng) {
  return lng < 72.004 || lng > 137.8347 || lat < 0.8293 || lat > 55.8271;
}

function transformLat(x, y) {
  let ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y +
    0.2 * Math.sqrt(Math.abs(x));
  ret += (20.0 * Math.sin(6.0 * x * PI) + 20.0 * Math.sin(2.0 * x * PI)) * 2.0 / 3.0;
  ret += (20.0 * Math.sin(y * PI) + 40.0 * Math.sin(y / 3.0 * PI)) * 2.0 / 3.0;
  ret += (160.0 * Math.sin(y / 12.0 * PI) + 320 * Math.sin(y * PI / 30.0)) * 2.0 / 3.0;
  return ret;
}

function transformLng(x, y) {
  let ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y +
    0.1 * Math.sqrt(Math.abs(x));
  ret += (20.0 * Math.sin(6.0 * x * PI) + 20.0 * Math.sin(2.0 * x * PI)) * 2.0 / 3.0;
  ret += (20.0 * Math.sin(x * PI) + 40.0 * Math.sin(x / 3.0 * PI)) * 2.0 / 3.0;
  ret += (150.0 * Math.sin(x / 12.0 * PI) + 300.0 * Math.sin(x / 30.0 * PI)) * 2.0 / 3.0;
  return ret;
}

// WGS-84 → GCJ-02, the direction the published formula states.
function wgs84ToGcj02(lat, lng) {
  if (outOfChina(lat, lng)) return { lat, lng };
  const dLatRaw = transformLat(lng - 105.0, lat - 35.0);
  const dLngRaw = transformLng(lng - 105.0, lat - 35.0);
  const radLat = lat / 180.0 * PI;
  let magic = Math.sin(radLat);
  magic = 1 - EE * magic * magic;
  const sqrtMagic = Math.sqrt(magic);
  const dLat = (dLatRaw * 180.0) / ((A * (1 - EE)) / (magic * sqrtMagic) * PI);
  const dLng = (dLngRaw * 180.0) / (A / sqrtMagic * Math.cos(radLat) * PI);
  return { lat: lat + dLat, lng: lng + dLng };
}

function gcj02ToWgs84(lat, lng) {
  if (outOfChina(lat, lng)) return { lat, lng };
  let wLat = lat, wLng = lng;
  for (let i = 0; i < 8; i++) {
    const fwd = wgs84ToGcj02(wLat, wLng);
    wLat += lat - fwd.lat;
    wLng += lng - fwd.lng;
  }
  return { lat: wLat, lng: wLng };
}

// --- Loading --------------------------------------------------------------
// HTML deliverables embed the object per weather-and-output.md §2; a .json
// file holds it directly.
function extractTripData(raw, file) {
  if (/^\s*[[{]/.test(raw)) return JSON.parse(raw);
  const m = raw.match(/<script[^>]*id=["']trip-data["'][^>]*>([\s\S]*?)<\/script>/i);
  if (!m) throw new Error(`${file}: no <script id="trip-data"> block found`);
  return JSON.parse(m[1]);
}

// --- Checks ---------------------------------------------------------------
function checkCoords(trip) {
  const seen = new Map();
  const bbox = trip.destination && trip.destination.bbox;

  const visit = (coord, label) => {
    if (missing(coord)) return;
    const { lat, lng } = coord;
    if (typeof lat !== 'number' || typeof lng !== 'number') {
      err(label, 'coord.lat / coord.lng must be numbers'); return;
    }
    if (lat < -90 || lat > 90 || lng < -180 || lng > 180) {
      err(label, `coord out of range (${lat}, ${lng})`); return;
    }
    // 5 decimals ≈ 1 m — finer than that is noise, and rounding here keeps
    // two lookups of the same place from reading as distinct points.
    const key = `${lat.toFixed(5)},${lng.toFixed(5)}`;
    if (seen.has(key)) {
      err(label, `coord collides with ${seen.get(key)} — two distinct places cannot share a coordinate`);
    } else {
      seen.set(key, label);
    }
    if (Array.isArray(bbox) && bbox.length === 4) {
      const [minLat, minLng, maxLat, maxLng] = bbox;
      if (lat < minLat || lat > maxLat || lng < minLng || lng > maxLng) {
        err(label, `coord (${lat}, ${lng}) falls outside destination.bbox — GCJ-02 written as WGS-84?`);
      }
    }
  };

  (trip.hotels || []).forEach((h, i) => visit(h.coord, `hotels[${i}]`));
  (trip.days || []).forEach((d, i) => {
    (d.slots || []).forEach((s, j) => visit(s.coord, `days[${i}].slots[${j}]`));
    (d.attractions || []).forEach((a, j) => visit(a.coord, `days[${i}].attractions[${j}]`));
    (d.dining || []).forEach((v, j) => visit(v.coord, `days[${i}].dining[${j}]`));
    (d.specialties || []).forEach((s, j) => visit(s.coord, `days[${i}].specialties[${j}]`));
  });
}

function validate(trip, today) {
  requireFields(trip, ['title', 'startDate', 'endDate', 'mode', 'language'], 'trip');

  const full = trip.mode !== 'planning-only';

  // weather-and-output.md §1 Weather Rule
  if (!missing(trip.weather && trip.weather.seasonalAverages) &&
      missing(trip.weather.climateShiftDisclaimer)) {
    err('trip.weather', 'seasonalAverages used without climateShiftDisclaimer (weather-and-output.md §1)');
  }

  // transportation.md §Return Trip Planning
  const legs = (trip.transport || []).map((t) => t.leg);
  for (const need of ['outbound', 'return']) {
    if (!legs.includes(need)) err('trip.transport', `no ${need} leg (transportation.md §Return Trip Planning)`);
  }
  (trip.transport || []).forEach((t, i) => {
    requireFields(t, ['leg', 'modeAndRoute', 'bookingWindow', 'bookingChannel', 'schedule',
      'seatClassAndPrice', 'recommendedArrival', 'hardCutoff', 'transferDetails', 'backupOption'],
      `trip.transport[${i}]`);
    requireSourced(t.seatClassAndPrice, `trip.transport[${i}].seatClassAndPrice`);
  });

  // hotel-selection.md §Output Card Format
  (trip.hotels || []).forEach((h, i) => {
    requireFields(h, ['nameAndTier', 'area', 'transit', 'rate', 'budgetFit', 'whyThisTier',
      'verdict', 'hardware', 'checkInOut', 'luggageStorage'], `trip.hotels[${i}]`);
    requireSourced(h.rate, `trip.hotels[${i}].rate`);
    if (h.hardware && missing(h.hardware.basis)) {
      err(`trip.hotels[${i}].hardware`, 'missing basis (renovation year, review proxy, or 未能核实)');
    }
  });

  (trip.days || []).forEach((d, i) => {
    const p = `trip.days[${i}]`;
    requireFields(d, ['date', 'archetype'], p);

    // attractions.md §3 — exactly one lead anchor per day
    if (missing(d.leadAnchor)) err(p, 'missing leadAnchor (attractions.md §3 — exactly one per day)');
    else if (Array.isArray(d.leadAnchor) && d.leadAnchor.length !== 1) {
      err(p, `leadAnchor has ${d.leadAnchor.length} entries — attractions.md §3 requires exactly one`);
    }

    // dining-rules.md §5 + §2
    (d.dining || []).forEach((v, j) => {
      const dp = `${p}.dining[${j}]`;
      requireFields(v, ['meal', 'name', 'cuisineCategory', 'rating', 'walkTimeFromAnchor',
        'pricePerPerson'], dp);
      requireSourced(v.rating, `${dp}.rating`, 'platform');
      if (missing(v.operatingStatus)) {
        err(dp, 'missing operatingStatus (dining-rules.md §2 — never trust training data)');
      } else {
        requireSourced(v.operatingStatus, `${dp}.operatingStatus`, 'source', 'checkedOn');
      }
    });

    (d.attractions || []).forEach((a, j) => {
      const ap = `${p}.attractions[${j}]`;
      requireFields(a, ['nameAndCategory', 'booking', 'slotOrHours', 'lastAdmission',
        'targetDateStatus', 'ticketPrice', 'verdict'], ap);
      requireSourced(a.ticketPrice, `${ap}.ticketPrice`);
    });

    (d.specialties || []).forEach((s, j) => {
      const sp = `${p}.specialties[${j}]`;
      requireFields(s, ['itemName', 'tier', 'whatItIs', 'whereToBuy', 'price',
        'transportNotes', 'bestFor', 'sources'], sp);
      requireSourced(s.price, `${sp}.price`);
    });
  });

  // safety-and-emergency.md §7
  if (full && missing(trip.safety)) {
    err('trip.safety', `safety block required for mode=${trip.mode} (safety-and-emergency.md §7)`);
  }

  // safety-and-emergency.md §6 — one recheck block, never two
  if (Array.isArray(trip.preTripRecheckBlock) && trip.preTripRecheckBlock.length > 1) {
    err('trip.preTripRecheckBlock', 'more than one recheck block (safety-and-emergency.md §6 requires exactly one)');
  }

  // reminders[] resolve to a date the traveller can still act on
  (trip.reminders || []).forEach((r, i) => {
    const rp = `trip.reminders[${i}]`;
    if (missing(r.item)) err(rp, 'missing item');
    if (typeof r.leadDays !== 'number') { err(rp, 'leadDays must be a number'); return; }
    const start = Date.parse(`${trip.startDate}T00:00:00Z`);
    if (Number.isNaN(start)) return; // bad startDate already reported
    const due = new Date(start - r.leadDays * 86400000);
    if (due < today) {
      warn(rp, `"${r.item}" was due ${due.toISOString().slice(0, 10)} — already past`);
    }
  });

  // Defaults were filled but never disclosed.
  if (missing(trip.assumptions)) {
    warn('trip.assumptions', 'empty — if any intake default was used it belongs here (intake.md §1)');
  }

  checkCoords(trip);
}

// --- Self-test ------------------------------------------------------------
// One runnable check: a minimal valid trip passes, and each rule fires when
// its field is removed.
function selftest() {
  const base = () => ({
    title: 'T', startDate: '2030-05-01', endDate: '2030-05-02',
    mode: 'planning-only', language: 'zh',
    destination: { name: 'Kyoto', bbox: [34.8, 135.6, 35.2, 135.9] },
    assumptions: ['pace=moderate'],
    transport: ['outbound', 'return'].map((leg) => ({
      leg, modeAndRoute: 'r', bookingWindow: 'w', bookingChannel: 'c', schedule: 's',
      seatClassAndPrice: { range: '1-2', currency: 'JPY', source: 'x', date: '2030-01-01' },
      recommendedArrival: 'a', hardCutoff: 'h', transferDetails: 't', backupOption: 'b',
    })),
    days: [{
      date: '2030-05-01', archetype: 'city', leadAnchor: 'Kiyomizu-dera',
      slots: [{ period: 'am', name: 'walk', coord: { lat: 34.9948, lng: 135.7850 } }],
      dining: [{
        meal: 'dinner', name: 'X', cuisineCategory: 'kaiseki',
        rating: { value: 3.6, platform: 'Tabelog', date: '2030-01-01' },
        walkTimeFromAnchor: '8 min', pricePerPerson: { band: '¥¥¥', currency: 'JPY' },
        operatingStatus: { verified: true, checkedOn: '2030-01-01', source: 'official' },
        coord: { lat: 35.0036, lng: 135.7780 },
      }],
    }],
    reminders: [{ item: 'book ticket', leadDays: 30, source: 'official' }],
  });

  const run = (mutate) => {
    errors.length = 0; warnings.length = 0;
    const trip = base();
    if (mutate) mutate(trip);
    validate(trip, new Date('2030-01-01T00:00:00Z'));
    return errors.slice();
  };

  const cases = [
    ['clean trip passes', null, 0],
    ['missing rate source', (t) => {
      t.hotels = [{ nameAndTier: 'H', area: 'a', transit: 't',
        rate: { range: '1', currency: 'JPY', date: '2030-01-01' }, budgetFit: 'f',
        whyThisTier: 'w', verdict: 'v', hardware: { basis: '2019' }, checkInOut: 'c',
        luggageStorage: 'l', coord: { lat: 35.01, lng: 135.77 } }];
    }, 1],
    ['missing return leg', (t) => { t.transport = t.transport.slice(0, 1); }, 1],
    ['coord collision', (t) => { t.days[0].dining[0].coord = { ...t.days[0].slots[0].coord }; }, 1],
    ['coord outside bbox', (t) => { t.days[0].slots[0].coord = { lat: 40.0, lng: 116.0 }; }, 1],
    ['seasonal averages without disclaimer', (t) => { t.weather = { seasonalAverages: 'x' }; }, 1],
    ['no leadAnchor', (t) => { delete t.days[0].leadAnchor; }, 1],
    ['two leadAnchors', (t) => { t.days[0].leadAnchor = ['a', 'b']; }, 1],
    ['dining without operating status', (t) => { delete t.days[0].dining[0].operatingStatus; }, 1],
    ['safety missing on guide-redesign', (t) => { t.mode = 'guide-redesign'; }, 1],
    ['two recheck blocks', (t) => { t.preTripRecheckBlock = ['a', 'b']; }, 1],
  ];

  let failed = 0;
  for (const [name, mutate, want] of cases) {
    const got = run(mutate);
    const ok = got.length === want;
    if (!ok) failed++;
    console.log(`${ok ? 'ok  ' : 'FAIL'}  ${name} — ${got.length} error(s), want ${want}`);
    if (!ok) got.forEach((e) => console.log(`        ${e}`));
  }

  // Known pair: Amap returns GCJ-02 for a place whose WGS-84 position is known.
  // Round-trip must land within a metre; 1e-5 deg ≈ 1.1 m.
  const wgs = { lat: 39.90869, lng: 116.39749 };            // Tiananmen, WGS-84
  const gcj = wgs84ToGcj02(wgs.lat, wgs.lng);
  const back = gcj02ToWgs84(gcj.lat, gcj.lng);
  const drift = Math.max(Math.abs(back.lat - wgs.lat), Math.abs(back.lng - wgs.lng));
  const geoOk = drift < 1e-5;
  if (!geoOk) failed++;
  console.log(`${geoOk ? 'ok  ' : 'FAIL'}  gcj02→wgs84 round-trip drift ${(drift * 111000).toFixed(2)} m`);
  // The offset must be real — a no-op conversion would pass the round-trip.
  const offset = Math.max(Math.abs(gcj.lat - wgs.lat), Math.abs(gcj.lng - wgs.lng));
  const offsetOk = offset > 1e-3;
  if (!offsetOk) failed++;
  console.log(`${offsetOk ? 'ok  ' : 'FAIL'}  gcj02 offset is non-trivial (${(offset * 111000).toFixed(0)} m)`);

  console.log(failed === 0 ? '\nselftest: all passed' : `\nselftest: ${failed} failed`);
  return failed === 0 ? 0 : 1;
}

// --- CLI ------------------------------------------------------------------
function main(argv) {
  const args = argv.slice(2);

  if (args[0] === '--selftest') return selftest();

  if (args[0] === '--gcj02-to-wgs84') {
    const lat = Number(args[1]);
    const lng = Number(args[2]);
    if (!Number.isFinite(lat) || !Number.isFinite(lng)) {
      console.error('usage: validate.js --gcj02-to-wgs84 <lat> <lng>');
      return 1;
    }
    const out = gcj02ToWgs84(lat, lng);
    console.log(`${out.lat.toFixed(7)} ${out.lng.toFixed(7)}`);
    return 0;
  }

  if (args.length !== 1 || args[0].startsWith('--')) {
    console.error('usage: validate.js <trip.json | page.html>');
    console.error('       validate.js --gcj02-to-wgs84 <lat> <lng>');
    console.error('       validate.js --selftest');
    return 1;
  }

  let trip;
  try {
    trip = extractTripData(fs.readFileSync(args[0], 'utf8'), args[0]);
  } catch (e) {
    console.error(`ERROR: ${e.message}`);
    return 1;
  }

  validate(trip, new Date());

  for (const w of warnings) console.log(`WARN   ${w}`);
  for (const e of errors) console.error(`ERROR  ${e}`);

  console.log(`\n${errors.length} error(s), ${warnings.length} warning(s)`);
  return errors.length === 0 ? 0 : 1;
}

if (require.main === module) process.exit(main(process.argv));
