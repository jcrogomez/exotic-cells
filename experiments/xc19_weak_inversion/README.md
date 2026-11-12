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
