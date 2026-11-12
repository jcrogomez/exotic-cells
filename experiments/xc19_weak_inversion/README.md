# XC-19: budget for a weak-inversion readout stage

Run on 2026-11-11, after the pre-registration
[`XC-19_2026-11-11_etapa_inversion_debil.md`](../../cells/preregistros/XC-19_2026-11-11_etapa_inversion_debil.md) was committed.
Model only (ngspice 44.2, sky130A `8afc8346`, tt).

**This is not a demonstration of a single trap.** The PDK models contain no discrete traps. The step is emulated by moving the
gate 0.305 mV. A favourable result says the instrument could see a trap if one exists.

## Result against the predictions

DUT: `nfet_01v8` 0.42/0.15 um, Vds = 0.9 V. Full table: `budget.txt` (from `dc_27.sp`, `dc_28.sp`, `budget.py`).

| Vg (V) | I | Step per 0.305 mV | Drift of I | Drift of DUT/twin ratio | Time to discharge 10 fF | Shortest dwell seen at 5 sigma |
|---|---|---|---|---|---|---|
| 0.00 | 23 fA | 0.48 % | 4.6 %/K | -0.83 %/K | 0.39 s | 7.4 s |
| 0.20 | 3.3 pA | 0.84 % | 6.1 %/K | 0.15 %/K | 2.7 ms | 17 ms |
| 0.30 | 51 pA | 0.84 % | 5.2 %/K | 0.16 %/K | 0.18 ms | 1.1 ms |
| 0.45 | 3.0 nA | 0.82 % | 3.7 %/K | 0.17 %/K | 3.0 us | 20 us |
| 0.60 | 136 nA | 0.70 % | 2.1 %/K | 0.16 %/K | 66 ns | 0.6 us |
| 0.80 | 4.7 uA | 0.38 % | 0.7 %/K | 0.08 %/K | 1.9 ns | 57 ns |

"Ratio" is the DUT against a copy whose gate is 17 mV lower, one sigma of mismatch for this size
([LOD audit](../lod_audit/README.md)). "Shortest dwell" is the shot-noise limit, (5 / step)^2 q / I.

| # | Predicted | Obtained | |
|---|---|---|---|
| P1 | slope factor n 1.3 to 1.6 | 1.41 for Vg 0.15 to 0.40 V | held |
| P2 | step 0.73 to 0.90 % at least 0.2 V below threshold | 0.76 to 0.84 % for Vg 0.10 to 0.55 V; 0.48 % at Vg = 0 | held, except at Vg = 0 |
| P3 | step below 0.4 % above threshold | 0.38 % at 0.80 V and falling | held |
| P4 | current at Vg = 0 between 1 pA and 1 nA | 23 fA | **failed** |
| P5 | drift at Vg = 0 between 5 and 10 %/K | 4.6 %/K | failed narrowly |
| P6 | ratio drift about 0.16 %/K | 0.15 to 0.17 %/K for Vg 0.20 to 0.60 V | held |
| P7 | shot noise 0.42 % per shot at 10 fF | not simulated; arithmetic only | open |

## Abandonment criteria

| Criterion | Verdict |
|---|---|
| 1. Step of at least 0.4 % wherever the DUT exceeds 100 times the competing leakage (3.2 pA) | Passes for Vg 0.20 to 0.75 V |
| 2. At least two decades of observable dwell times | Passes: 3.7 decades at 0.30 V, 5.4 at 0.45 V (up to 5 s) |
| 3. Ratio drift under 0.4 % for 1 K | Passes at one sigma of mismatch (0.16 %); a 2.5 sigma pair reaches the limit |
| 4. Supply stability no tighter than 0.1 mV | Passes for the drain (0.1 %/mV, so 4 mV for half a step). The full stage with its precharge and threshold inverter was not simulated |

The stage is not abandoned. Three things changed:

1. **The bias-free version is dead.** At Vg = 0 the DUT carries 23 fA, below the 32 fA of competing leakage, and the step is
   smaller. The stage needs a gate bias between about 0.25 and 0.45 V.
2. **The critical quantity was not in the pre-registration: gate-bias noise.** The step equals 0.305 mV at the gate, so half a
   step is 0.15 mV of bias. Only what is common to DUT and twin cancels. With a twin of 4.2/1.5 um the slope factors differ by
   about 2.5 % (1.41 against 1.45, from the same table), which leaves roughly 6 mV of tolerable common bias noise. A twin of the
   same size would cancel better but would also carry its own traps.
3. **A window of four to five decades probably holds more than one trap** (see below), so the signature to look for is a set
   of discrete levels, not strictly two.

## Probability of finding a trap: an estimate, not a datum

Assumptions: the flicker-noise parameter of the model card (`noia = 2.5e42`, `noib = noic = 0`, same value in all 180 bins)
read as a uniform oxide trap density, 4.0e17 per eV per cm3; tunnelling attenuation 1e8 per cm, the constant used by the BSIM4
flicker formula (manual eq. 10.7); a trap counts as visible if its occupancy lies between 10 and 90 %, a window of 4.4 kT; drawn
gate area.

That gives about **0.66 visible traps per decade of dwell time per minimum device**: 2.5 over 3.7 decades, 3.6 over 5.4.
If the density were ten times lower, 0.25 to 0.36 per device, and 8 to 12 devices would be needed for a 95 % chance of one.

What this does not cover: the amplitude of a real trap is not 0.305 mV but a wide distribution around it; the card's value may be
a generic fit and not a measurement of this geometry; the 4.2/1.5 um twin would hold about 100 times more traps, each 100 times
smaller, which should look like continuous noise near 0.03 % per decade.

## Cross-check with XC-12 on the same instrument

The LOD shift is deterministic and large for this reader. With n kT/q = 36.5 mV from this run, the model predicts a current
ratio of 2.3 for the 31.1 mV pair and 3.4 for the 44.1 mV pair. That makes XC-12 the calibration of the XC-19 reader: a known
layout difference must appear as a known ratio before any 0.8 % step is believed. Both numbers are arithmetic from two model
runs, not a simulation of the combined circuit.

## Next

- Simulate the complete stage: precharge, threshold inverter, counter resolution against the clock.
- Decide where the 0.25 to 0.45 V bias comes from in a digital flow, and its noise.
- Shot noise in a transient simulation, to close P7.

---

# Part 2: the complete stage and its bias

Run on 2026-11-11, after the pre-registration
[`XC-19_2026-11-11_etapa_completa_y_polarizacion.md`](../../cells/preregistros/XC-19_2026-11-11_etapa_completa_y_polarizacion.md)
was committed. Model only. Still not a demonstration of a trap.

**An error of ours, caught and corrected.** The first run wrote the 16 parallel devices of the bias chain as `mult=16`, which
ngspice ignores for these subcircuits (the multiplier is `m=`). The run was therefore a chain ending in a single device. It
showed up as a "16-device" twin timing exactly like a single one. That run is kept in `run1_mult_ignored/`; every number below
comes from the rerun with `m=16`.

## Bias: a chain of diode-connected transistors

K `nfet_01v8` in series from VDD to ground; the bottom gate-drain node is the bias. V1: all 1/1 um. V2: the bottom one is 16
devices equal to the DUT, so the DUT carries 1/16 of the chain current. Files: `gen_bias.py`, `bias.txt`, `bias_table.txt`.

| | V1 (tt, 27 C) | V2 (tt, 27 C) |
|---|---|---|
| K = 3 | 0.499 V, 11 nA | 0.472 V, 5.5 nA |
| K = 4 | 0.335 V, 134 pA | 0.317 V, 81 pA |
| K = 5 | 0.237 V, 9.2 pA | 0.220 V, 5.7 pA |
| K = 6 | 0.174 V, 1.6 pA | 0.157 V, 1.0 pA |

Over five corners and 27/85 C, taking 3.2 pA to 40 nA as the usable range of DUT current:

- **V2 with K = 4 is usable in all ten conditions** (7.5 pA to 4.1 nA). K = 3 covers eight of ten.
- V1 has no single K that works everywhere: its bias voltage hardly moves between corners (0.329 to 0.340 V at K = 4) while the
  DUT threshold does, so the DUT current spreads by a factor of 2300 at 27 C.

Bias-node noise with 1 pF, integrated from 1 Hz to 1 MHz: 90 uV rms (K = 3), 116 uV (K = 4). Sensitivity to the supply:
dVb/dVDD = 0.25 (K = 3), 0.20 (K = 4), 0.15 (K = 5).

## Complete stage

Precharge pfet, DUT, library `inv_1`; time from release to the inverter switching. V2 bias. Files: `gen_stage.py`, `stage.txt`.

| | K = 3 | K = 4 |
|---|---|---|
| Discharge time | 0.36 us | 24.5 us |
| Change for a 0.305 mV step | 0.80 % | 0.86 % |
| Effective node capacitance | 1.9 fF | 2.0 fF |
| Change per mV of supply, stage alone | 0.52 % | 0.53 % |
| Ticks of an assumed 50 MHz clock `[?]` | 18 | 1225 |

K = 4 is the working point: one clock tick is 0.08 % of the time. K = 3 is too fast to count directly.

## Against the predictions

| # | Predicted | Obtained | |
|---|---|---|---|
| B1 | V1 bias 0.25 to 0.36 V at K = 5; 0.21 to 0.30 V at K = 6 | 0.237 V; 0.174 V | **failed**: the body effect of the upper devices is stronger than assumed |
| B2 | dVb/dVDD 0.10 to 0.25 at K = 5 | 0.148 | held |
| B3 | bias noise 50 to 150 uV rms | 90 to 116 uV | held |
| B4 | V1: DUT current spreads more than 30 times | 2300 times at 27 C alone | held, and far worse |
| S1 | node capacitance 1 to 5 fF | 1.9 to 2.0 fF | held |
| S2 | 0.75 to 0.90 % per step | 0.80 to 0.86 % | held |
| S3 | precharge leakage under 10 % of DUT current across the window | 5.3 pA: 7 % at K = 4, but 41 % at the low end of the window | **failed** at the low end |
| S4 | 0.4 to 0.8 % per mV of supply, stage alone | 0.53 % | held |
| S5 | DUT/twin ratio under 0.03 % per mV of supply | 0.075 % with the 4.2/1.5 um twin | **failed** |

## Abandonment criteria

| Criterion | Verdict |
|---|---|
| 1. Some K keeps the bias in 0.25 to 0.45 V in five corners | Passes as written (K = 4, both variants). But it was written on the wrong variable: at a fixed voltage the current still spreads 2300 times. On current, V2 passes and V1 does not |
| 2. Bias noise above 6 mV rms | Not reached: 0.12 mV |
| 3. At 85 C precharge leakage above the DUT current across the window | Not reached: 232 pA against 573 pA (K = 4) |
| 4. DUT/twin ratio moves more than 0.4 % for 10 mV of supply | **Reached with the pre-registered twin: 0.75 %.** The 4.2/1.5 um twin does not rescue the stage |
| 5. Inverter switches more than once | Not testable here: a noiseless simulation switches once by construction. Open |

## What changed in the design

Exploratory runs made after seeing the results (`gen_explore.py`, `explore.txt`). They were not pre-registered and count as
leads, not as tests.

1. **The twin must have the DUT's own geometry.** The long twin fails because the short DUT has drain-induced barrier lowering
   and the long one does not. With an identical device whose gate is 17 mV off (one sigma of mismatch) the ratio moves 0.02 %
   for 10 mV of supply; with 16 identical devices in parallel, 0.09 %. Both are under the 0.4 % limit. *(Corrected on
   2026-11-11: the first version of this run said 0.19 % and 0.15 %. Its generator announced the long high-threshold precharge
   but still instantiated the minimum pfet; an external review found it. The old decks are in `run2_explore_min_pfet/`.)* The price: an identical
   twin has its own traps, so a step identifies the pair, not the device. Three devices compared pairwise would tell which
   one moved. The large device stays useful as a separate control channel, not as the timing reference.
2. **The precharge device should be a long high-threshold pfet.** Minimum `pfet_01v8` leaks 5.3 pA at 27 C and 232 pA at 85 C;
   `pfet_01v8_hvt` at L = 0.5 um leaks 0.010 pA and 0.015 pA.
3. **Kickback on the bias node, not anticipated.** Each discharge pulls the bias down by 2.1 to 2.5 mV through the gate-drain
   capacitance, seven to eight steps' worth, and the node takes tens of microseconds to recover. It is deterministic and
   repeats every cycle, but any stage that fires disturbs the others. A filter capacitor of 1 pF is not enough; the size
   needed, or an isolation stage, is the next thing to simulate.
4. **Supply noise is the dominant external sensitivity.** One millivolt of supply moves a single stage by 0.6 of a step. With an
   identical twin and the long high-threshold precharge the ratio moves 0.02 % for 10 mV in this single case; the Monte Carlo
   of part 3 gives the spread.

## Open

- Kickback: capacitor size or isolation, and its effect on bias noise bandwidth.
- Shot noise and inverter chatter in a transient-noise simulation (P7 of part 1 and criterion 5).
- Mismatch between DUT and twin as a Monte Carlo, not a single 17 mV case.
- Layout: none of this includes wiring or extracted parasitics. A 2 fF node will not stay 2 fF.
- The clock actually available on the board.

---

# Part 3: night plan, blocks N3, N4 and N5

Run on 2026-11-11 and 12 against [`PLAN_2026-11-11_noche.md`](../../cells/preregistros/PLAN_2026-11-11_noche.md). Model only.
Decks from `gen_night.py`; raw lines in `night.txt`. All stages here use the long high-threshold precharge.

## N3: kickback on the bias node

| Filter capacitor | Dip of the bias when one stage fires |
|---|---|
| 1 pF | 0.076 mV |
| 10 pF | 0.016 mV |
| 30 pF | 0.006 mV |

**Prediction: 0.15 to 0.33 mV at 10 pF and 0.05 to 0.11 mV at 30 pF. Failed, in the favourable direction.** The 2.1 to 2.5 mV of
part 2 did not come from the device under test. It came from the large twins sharing the node (the 4.2/1.5 um device and the
16-device array), whose gate-drain capacitance is many times larger. One small stage disturbs the bias by a quarter of a step
with 1 pF. 10 pF is enough; 30 pF is not needed.

Cascode over the device under test and over the long twin, gate on the next tap of the chain:

| | Predicted | Obtained | |
|---|---|---|---|
| Step for 0.305 mV | 0.75 to 0.90 % | 0.80 % | held |
| Kickback with 1 pF, three stages including the long twin | under 0.5 mV | 0.62 mV | failed narrowly |
| Ratio to the long twin for 10 mV of supply | under 0.4 % | 0.57 % | **failed** |

The cascode holds the drain near 0.38 V and the stage becomes 2.9 times slower (68.7 us). It does not rescue the long twin.
The long twin is out for good; the cascode stays as a candidate only for what it does to the trap itself (constant drain
voltage during the measurement), which no circuit simulation can tell.

## N4: the LOD pair read by the stage

The two audit transistors (0.30 and 3.0 um of diffusion), annotated, each as the discharging device of a stage.

| | Discharge time |
|---|---|
| 0.30 um, annotated | 48.2 us |
| 3.0 um, annotated | 29.4 us |
| 0.30 um, as extracted | 25.2 us |
| 3.0 um, as extracted | 36.3 us |

**Prediction: time ratio 2.4 to 2.9. Obtained 1.64. Failed, and outside the 2.0 to 3.3 band that triggers a correction.**

What was wrong was not the threshold arithmetic. Without annotation the two already differ, by 0.69, because the long diffusion
is also a larger drain junction and so a larger capacitance on the node. Dividing that out, the current ratio is 2.36, against
2.34 predicted from threshold alone; the extra factor of 1.15 we had added for mobility does not appear in weak inversion.

Consequences for using XC-12 on this reader:

- Draw the long diffusion on the source side, or equalise the node capacitance explicitly. With the long side on the source
  only, the model gives half the threshold difference, 15.5 mV, and a current ratio of 1.53 with the same drain junction
  (`explore_lod_source_side.sp`; the two numbers were written in the deck before running it).
- The pair checks that reader and extractor agree with each other. It is not an independent calibration of the reader: that
  needs known perturbations that do not depend on the phenomenon (a gate step, a switched reference capacitor, a test current).

## N5: mismatch as a Monte Carlo

Device against an identical twin, every transistor of bias, stages and inverters drawn from the PDK mismatch model, the same
draw simulated at VDD and at VDD + 10 mV (`n5_mc.sp`, read by `n5_read.py`, output in `n5.txt`). Four in series, long
high-threshold precharge. **39 draws, not the 100 planned**: each takes about a minute and the run was stopped to close the
night. The log carries an error in its summary line (it referenced measurements of the previous plot); the measurements
themselves are intact and are what the reader uses.

| | Result over 39 draws |
|---|---|
| Ratio device/twin for 10 mV of supply | median 0.047 %, largest 0.329 % |
| Pairs above the 0.4 % limit | 0 of 39 (0 %) |
| One stage alone for 10 mV of supply | median -5.10 % |
| Discharge time of one stage | 0.7 to 147.6 us, median 26.0 us |
| Time ratio device/twin | 0.02 to 15.45 |

Prediction: 5 to 25 % of the pairs above the limit. **failed, in the favourable direction**.

**The finding that matters is the last two rows.** Nominally identical stages differ in discharge time by two orders of
magnitude, and a device and its twin by an order of magnitude either way. The reader therefore cannot assume a ratio near one:
every device needs its own baseline, the counter must span that range, and the bias should be adjustable per channel.

