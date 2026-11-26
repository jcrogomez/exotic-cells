# Roadmap

Where MISFIT is, and what comes next. No dates are promised. Last update: 2026-11-25. The detailed work per front is in
[PLAN_EXPLORATORIO](PLAN_EXPLORATORIO.md) (Spanish); the gates before tapeout are in [PIPELINE](PIPELINE.md#gates-before-tapeout).
This page is the single to-do list. What goes on the first tile and its tests, in order, is the
[build plan](MISFIT_PLAN.md). Everything that can be studied before silicon, by kind, is in the
[research agenda](RESEARCH_AGENDA.md).

## Where we are

| Stage | State |
|---|---|
| Catalogue of ideas | 64 identifiers; 15 survived attack and independent verification on paper |
| Shared reader (XC-19) | Complete slot drawn (58 × 96 µm), DRC/LVS clean, and integrated in a 1×2 tile with the digital core: DRC, own LVS and precheck pass (MISFIT-03, MISFIT-04). Contract, mismatch (48 chips) and shot noise simulated; bias trim designed in schematic, not drawn. One reader can carry 16 devices (MISFIT-05, model without wiring) |
| Second reader (wide range, for XC-20) | Schematic only: linear within ±1.6 % from 100 pA to 1 µA at tt 27 °C ([design note](../experiments/xc20_lector/DISENO_lector.md)); no pre-registration, not drawn |
| Metrology seats (LOD, XC-62) | Not designed |
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
- [ ] **First tile, [build plan](MISFIT_PLAN.md)** (proposed 2026-11-25, not frozen): two readers of 16 seats, area found above
      and inside the digital core, tests B1–B4, R1–R6, C1–C8, G1–G5, T1–T4 in the order given there. Decisions taken by delegation, listed there
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
- [ ] Kelvin strips of n+, p+, poly and li next to XC-20: the in-silicon check of A1. With digital pins only (A8), read them
      through the reader (resistance as a discharge time). No analog pins (Juan, 2026-11-17). Juan, 2026-11-16: a time
      readout does not automatically keep the four-terminal property (material vs contact, switch and routing resistance);
      **keep the Kelvin structures until the time readout is shown to answer the silicide question**
- [ ] **Instrument skeleton** ([`instrument/`](../instrument/README.md), started 2026-11-17): RTL top level with four slots, cocotb
      tests (13 pass), interface contract, risk matrix. Behavioural slots only; nothing frozen
- [ ] **MISFIT-01**, the integration trial ([`instrument/misfit01/`](../instrument/misfit01/README.md), pre-registered): a hand-drawn
      inverter passes DRC, LVS with its devices, the precheck and three negative controls by two routes: as a row cell in the
      digital flow, and as a free-geometry macro under a separately hardened core (custom GDS, our own LVS). As a macro
      inside the digital flow it fails at the power grid, as predicted. XC-19 is not redrawn yet
  - [x] phase 2, **MISFIT-02** ([`instrument/misfit02/`](../instrument/misfit02/README.md), pre-registered): a drawn cell of known
        time (545 and 1060 ns) read as 29–30 and 54–55 counts; six of seven predictions held, one failed low; the real
        instrument core and the cell pass DRC, LVS and the precheck in one tile. Two legs composed, not co-simulated
  - [ ] the instrument core alone nearly fills a 1×1 tile (MISFIT-02, stage 2): decide the tile size before the slots
  - [ ] a double-height row cell; wire resistance in the extraction; a timing statement for the logic-to-cell boundary
  - [ ] decide row cells, free geometry, or both (the evidence supports both; not decided)
- [ ] **Shared instrumentation system** (Juan, 2026-11-16): one instrument that characterises many cells, calibrates itself
      and isolates faults with the fewest digital pins. The architecture decision is in [PROPOSAL](PROPOSAL.md#architecture-decision-juan-2026-11-16)
- [ ] **DFT plan** (A8; gate 7 of [PIPELINE](PIPELINE.md#gates-before-tapeout)), before drawing more cells. Every channel must be testable without the exotic physics:
  - [ ] reader self-test: calibration current, switched reference capacitor and gate step selectable from the digital pins,
        so the reader is proven before any cell is trusted
  - [ ] counter and multiplexer readback: a known pattern through every counter; the selected channel read back
  - [ ] safe power-up state: no fuse, coil, heater or pump active until enabled, so XC-14's first read is not disturbed and
        nothing stresses a cell by default
  - [ ] per-macro enables, so a shorted or leaking macro can be isolated without losing the chip
  - [ ] identify a faulty channel and exclude it, keeping the rest usable (Juan, 2026-11-16)
  - [ ] no reading while a fuse, coil or heater pulses (A7: ~40 mV supply droop at 8 mA, extrapolated)
  - [x] supply sensitivity to the tile's own activity, simulated against a pre-registration ([`experiments/supply_transfer`](../experiments/supply_transfer/README.md)):
        +1.27 % per mA for one side; the twin protects only a cell that takes as long as its twin
  - [ ] choose, with evidence, how an unknown cell is protected from supply changes: equal digital activity in every
        compared window, calibration re-read in the same window, or randomised order. Not chosen
- [ ] E-fuse (XC-01 → XC-05): read papers on fuses without silicide (Q10) before any new XC-01 work; then a pre-registration with two outcomes (clean open / rejoin or few channels) and re-reads over time (P8)

### Ask
- [ ] open_pdks (not Magic): the LOD extraction gap is in the SKY130 tech file; one line makes Magic write `sa`/`sb` for
      simple devices, and is wrong for shared diffusion. Draft and reproducers ready, **not filed**; LVS with the extra
      parameters untested ([draft](../experiments/lod_audit/upstream/MAGIC_ISSUE_DRAFT.md))
- [ ] Tiny Tapeout: which integration route keeps a functional macro's connections and still lets the whole tile be
      verified ([`instrument/INTEGRATION.md`](../instrument/INTEGRATION.md)); whether a power-switch figure with parasitics exists
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

- 2026-11-26 · MISFIT-20: XC-14's floating-gate seat with its antenna plate drawn by the generator, rule-clean with LVS;
  plate and node couplings extracted ([report](../experiments/misfit20/RESULTADOS.md)).
- 2026-11-26 · MISFIT-19: XC-14's readable window: a floating gate born at 0.3–1.0 V lands inside reader 2; the thick-oxide
  transistor is the one to read it with ([report](../experiments/misfit19/RESULTADOS.md)).
- 2026-11-26 · MISFIT-18: the XC-19 geometry fan drawn by the generator (18 seats, rule-clean, LVS). The model tells apart
  only area and diffusion length; three classes stay as exploratory seats ([report](../experiments/misfit18/RESULTADOS.md)).
- 2026-11-26 · MISFIT-16: XC-20's main cell (p+ touching n+ in an n-well, switch on the ground side) drawn by the generator,
  rule-clean with LVS at the first pass; the well costs 3.8 fF per seat on the reader node
  ([report](../experiments/misfit16/RESULTADOS.md)).
- 2026-11-26 · MISFIT-15: in the XC-20 seat as drawn the junction sees 0.9–1.65 V, set by its own current; with the switch on
  the ground side it sees the full node voltage. The n-well variant becomes the main cell. Tool finding: ngspice takes the
  area of an extracted PDK diode unscaled ([report](../experiments/misfit15/RESULTADOS.md)).
- 2026-11-26 · MISFIT-14: the XC-20 cells drawn by the generator (n+ touching p+ in substrate, four gaps and a control),
  rule-clean with LVS; the junction is extracted as a device ([report](../experiments/misfit14/RESULTADOS.md)).
- 2026-11-26 · MISFIT-13: the core with seat selection and a second reader does not close in its present block, in any of three
  selection schemes ([report](../experiments/misfit13/RESULTADOS.md)). MISFIT-12: unequal devices share a reader bus cleanly and 128
  seats with wiring stay inside the cuts ([report](../experiments/misfit12/RESULTADOS.md)). Order changed: cells first, tile count last.
- 2026-11-26 · MISFIT-11: a seat-matrix generator ([`generator/`](../generator/README.md)). A table of transistors gives a
  layout, an LVS reference and a seat list; four tables rule-clean with LVS match, 4.77 µm² per minimum seat, and the small
  reader reads an extracted 64-seat matrix inside its cuts in four corners ([report](../experiments/misfit11/RESULTADOS.md)).
- 2026-11-26 · Night plan of 2026-11-25, 159 SPICE decks with criteria sealed before the run: a small reader stays inside
  its cuts with up to 128 identical branches (no wiring; the plan uses 64); under mismatch (48 chips) and shot noise it
  reads like the large one; the wide-range reader with a single precharge is dead and gets two ranges
  ([report](../experiments/noche_1125/RESULTADOS.md)).
- 2026-11-25 · MISFIT-09: the XC-19 reader drawn with one filter row: 58.2 × 20.7 µm instead of 58.2 × 95.7, rule-clean,
  reading unchanged in four corners. It fits the free strip of a single tile ([report](../experiments/misfit09/RESULTADOS.md)).
- 2026-11-25 · MISFIT-08: a lean digital core without the shared timer, equivalent to the original cycle by cycle in
  random simulation, 9.0 % less cell area after place and route ([report](../experiments/misfit08/RESULTADOS.md)).
- 2026-11-25 · MISFIT-07: the reader's 10 pF bias filter (85 % of its area) is not needed by the reading, in four corners
  and with asynchronous sides; first run invalid by a badly designed witness, redone ([report](../experiments/misfit07/RESULTADOS.md)).
- 2026-11-25 · MISFIT-06: with metal 4 blocked over the digital core except the pin band, the core closes clean (DRC 0,
  LVS 0, timing met): 11 856 µm² of metal 4 reserved above it, raw. A global metal-3 cap fails under the pins
  ([report](../experiments/misfit06/RESULTADOS.md)).
- 2026-11-25 · MISFIT-05: one reader carries 16 device branches in four corners (15 open branches leak ≤ 0.54 % of the
  device current; +0.23–0.25 % of time per branch). Model without wiring or mismatch ([report](../experiments/misfit05/RESULTADOS.md)).
- 2026-11-24 · MISFIT-04: the XC-19 slot and the digital core in one 1×2 tile pass DRC, own LVS and the precheck; real
  aggressors stay 5–7× under threshold; a cut macro ground is invisible to the standard checks and is caught by an LVS
  without substrate taps; coupling sensitivity from 39 of 40 phases ([report](../experiments/misfit04/RESULTADOS.md)).
- 2026-11-24 · MISFIT-03: the extracted slot meets its contract in the corners that were missing; Monte Carlo of 48 chips and
  shot noise run; three mismatch predictions false ([report](../experiments/xc19_slot_e2/INFORME_enmienda2.md)).
- 2026-11-17 · MISFIT-02: a hand-drawn time cell read through the instrument's counter (SPICE time → RTL count), and the real
  instrument core with that cell through DRC, own LVS and the precheck.
- 2026-11-17 · MISFIT-01: a hand-drawn device through Tiny Tapeout's checks by two routes (row cell in the digital flow;
  free geometry under a hardened core); the macro route inside the digital flow fails at the power grid. Precedent found and
  read: `htfab/cell-tester`. A precheck-only rule (`licon.SP.6`) caught what Magic's DRC did not.
- 2026-11-17 · Instrument skeleton (RTL, 13 cocotb tests, contract, risks, integration routes read from the sources). Supply
  transfer function of the XC-19 channel simulated; six pre-registered predictions held. LOD gap traced to the tech file.
- 2026-11-17 · Juan: digital pins only, no analog pins. Tile power switch read from the Tiny Tapeout sources and its
  transistor simulated ([`experiments/tt_power_gate`](../experiments/tt_power_gate/README.md)). Minimal case of the LOD extraction gap prepared
  for upstream, not filed.
- 2026-11-16 · Repo reorganised for newcomers: research agenda, architectures, good first tasks, shared-instrument figure.
- 2026-11-16 · A Tiny Tapeout contributor: digital pins only unless analog voltages are needed (extra cost); prioritise DFT (A8).
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
