# Roadmap

Where MISFIT is, and what comes next. No dates are promised. Last update: 2026-11-16. The detailed work per front is in
[PLAN_EXPLORATORIO](PLAN_EXPLORATORIO.md) (Spanish); the gates before tapeout are in [PIPELINE](PIPELINE.md#gates-before-tapeout).
This page is the single to-do list.

## Where we are

| Stage | State |
|---|---|
| Catalogue of ideas | 63 identifiers; 15 survived attack and independent verification on paper |
| Shared reader (XC-19) | Simulated against four pre-registrations; reader, bias and channel DRC clean (T2). Not yet a complete channel with pins and power |
| Top candidate (XC-20) | Physics verified to order; hypothesis engine at round 3, **not consolidated**; structure matrix approved, macro not frozen |
| Tiny Tapeout questions | Silicide and antenna answered by a third party ([OPEN_QUESTIONS](OPEN_QUESTIONS.md)); the rest open |
| Silicon | None |

## Phases

1. **Instrument first.** Close one complete XC-19 channel: capacitors, power, independent calibration, digital output,
   extraction and post-layout against its pre-registration. Nothing else is trustworthy until this works in simulation.
2. **Top three on paper.** XC-20, XC-19, XC-14 ([ranking](RANKING.md)) each with a frozen pre-registration and a drawn cell.
3. **Area and fit.** Real area of one channel from placement; decide 1×2 or 2×2; decide what of Tier B fits.
4. **Tapeout gates.** Precheck, own LVS, edge report, one pre-registration per cell on silicon.
5. **Silicon.** Virgin read first (XC-14's first read is the experiment), then calibration, then sweeps.

## To do

### Now
- [ ] XC-20, before another large round of the hypothesis engine (Juan, 2026-11-16; each item needs its own pre-registration):
  - [ ] fix W2 and the selectable-range correlations in `motor3.py`
  - [ ] separate estimator error from modelling differences in the W1 discrepancies
  - [ ] evaluate the incremental gain on K directly, with a second estimator family and its own interval (a difference of
        two variational lower bounds certifies nothing)
  - [ ] report tunnel presence, K given tunnel, and background separately
  - [ ] design an identifiable background control, including geometric differences between cells
  - [ ] keep failed predictions and invalidated runs in the history
  - [ ] sensitivity of the value of 0.54 and 1.08 µm to the priors of F, B and K: when does each one change value? (0.54 µm
        only beats 1.08 µm when conventional leakage coexists with tunnelling and decays with distance: `PREREG_E2d108.md`)
- [ ] XC-19: finish the first complete channel (E4.1 in PLAN_EXPLORATORIO)
- [ ] XC-14: write its pre-registration now that the shuttle side is open (A2)
- [ ] Kelvin strips of n+, p+, poly and li next to XC-20: the in-silicon check of A1
- [ ] E-fuse (XC-01 → XC-05): read papers on fuses without silicide (Q10) before any new XC-01 work; then a pre-registration with two outcomes (clean open / rejoin or few channels) and re-reads over time (P8)

### Ask
- [ ] Tiny Tapeout contributor: Q1 (antenna "not enforced" or "negligible")
- [ ] Tiny Tapeout: Q3 (high voltage), Q7 (number of chips)
- [ ] Look at the GF180 PDK for the high-voltage families (Q9)

### Later
- [ ] Tier B cells that fit after phase 3
- [ ] A source for the spin-dependent recombination size before any XC-52 area
- [ ] Reconcile ngspice and Monte Carlo for kT/C (P7)
- [ ] Residual, idea only: the value of a structure is relative to the experiment it sits in (Shapley value over V(S), where
      V can be information on a mechanism or a parameter, or the power to falsify). Not a property of a cell, and not built
      until V(S) has controlled errors and the choice is robust to models and priors

## Done (most recent first)

- 2026-11-16 · A Tiny Tapeout contributor: ~8 mA per tile is fine (A7); analog spec read (0.1 V drop at 20 mA; 4 mA on analog pins).
- 2026-11-16 · A Tiny Tapeout contributor suggested the e-fuse and named its hard part (A6); XC-01/XC-05 moved to tier B.
- 2026-11-16 · A Tiny Tapeout contributor answered silicide and antenna (A1, A2). Juan approved the XC-20 separation matrix (0, 0.27, 0.54, 1.08 µm
  and a no-junction cell) without freezing the macro; round 3 of the engine stays not consolidated
  ([report §7](../experiments/xc20_hipotesis_r3/INFORME.md)). New design rule: structures that hold the ordinary physics
  ([PIPELINE](PIPELINE.md))
- 2026-11-15 · XC-20 hypothesis engine, round 3, with independent verifier
- 2026-11-14/15 · XC-20 hypothesis engine, rounds 1–2; mixed reader explored
- 2026-11-13 · Capability matrix of SKY130 ([CAPACIDADES](CAPACIDADES_SKY130.md)); HSA audit of ngspice
- 2026-11-12/13 · Attack rounds 1–4 over the catalogue
- 2026-11-11 · LOD extraction gap found; Residual module 1
