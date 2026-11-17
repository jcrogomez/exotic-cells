# Research agenda

Everything that can be done before silicon, sorted by kind: sources to read, physical models to build or interpret,
mathematical results to test, and experiments to run on silicon. Last update: 2026-11-16. The single to-do list with owners
and order is [ROADMAP](ROADMAP.md); question codes (A1, Q10, P6…) refer to [OPEN_QUESTIONS](OPEN_QUESTIONS.md). Small, well
defined entry points for newcomers are in [CONTRIBUTING](../CONTRIBUTING.md#good-first-tasks).

## 1. Sources to read

The full list, with what each check found, is [READING](READING.md). **No claim in this repository rests on an unread
source.** In order of what they would change:

| Priority | Source or search | For | What reading it would settle |
|---|---|---|---|
| 1 | Moxim et al., APL 120, 063502 (2022) and J. Appl. Phys. (2024) | XC-52 | The size of spin-dependent recombination in Si/SiO2 at room temperature (P6). Without it XC-52 gets no area |
| 2 | **Search:** e-fuses without silicide on poly, and in metal or TiN | XC-01, XC-05 | Whether a fuse in SKY130 can open cleanly, and how often blown traces rejoin (Q10, P8). No paper identified yet |
| 3 | Kane 1961; Esaki 1958 | XC-20 | The tunnelling exponent used in our estimates, read at the source |
| 4 | **Search:** an Esaki or backward diode in a standard bulk CMOS flow | XC-20 | Whether anyone has done XC-20 before. Three searches found nothing; not finding is not absence |
| 5 | Grasser et al. 2010 (time-dependent defect spectroscopy) | XC-19 | How to separate defects by capture and emission times |
| 6 | **Search:** plasma charge surviving the anneal on thick gate oxide | XC-14 | P3, before silicon answers it |
| 7 | Scheer et al. 1998; Agraït et al. 2003 | XC-05 | Channels in aluminium contacts |
| 8 | `TinyTapeout/tt-multiplexer`, `pg/sky130` subfolders; `iic-jku/sky130_power_gate` | All | Transistor alone simulated 2026-11-17: 1.59 Ω for the smallest gate ([`experiments/tt_power_gate`](../experiments/tt_power_gate/README.md)). Still missing: with parasitics, the variant per tile, the pulse rating |
| 9 | **Search:** SKY130 substrate resistivity | XC-26 | P4 |

## 2. Physical models to build or interpret

| Model | For | Status | Next step |
|---|---|---|---|
| Band-to-band tunnelling (Kane) at an abutted p+/n+ edge | XC-20 | Verified to order of magnitude: tens of nA to tens of µA per 1.4 µm at 1.8 V | Doping-profile scenarios with a device simulator (devsim); the profile is not public, so results are intervals |
| Negative resistance of the same junction | XC-20 | Open | Depends on the profile; bound it, do not predict it |
| Series resistance of the diffusion and contacts | XC-20 | Arithmetic: ~1 kΩ, ~20 mV at 20 µA | Fold into the hypothesis engine as the new boring explanation after A1 |
| Hypothesis engine (which structures tell us most) | XC-20 | Round 3 not consolidated | The six items in ROADMAP: fix W2 and the selectable reader, second estimator, prior sensitivity |
| Weak-inversion reader with shot noise and mismatch | XC-19 | Simulated against four pre-registrations | Complete channel with extraction and post-layout |
| kT/C: Monte Carlo 0.90 vs ngspice ~0.50 | XC-58 | Open disagreement (P7) | Find which model is wrong before trusting either |
| Plasma charge, tunnelling discharge, anneal | XC-14 | Discharge verified; residual drift to order; anneal missing | Add an anneal step once a source is read (§1, item 6) |
| Fuse neck: heating, electromigration, barrier bridging, rejoin | XC-01, XC-05 | Heating verified (li 500–1800 K at 4–8 mA); metal 1 bridged by its barrier (verified); rejoin not modelled | A rejoin model, after §1 item 2 |
| Spin-dependent recombination against classical even-in-field terms | XC-52 | Shape discriminator verified (×4 quadratic vs ×1.6–2.0 saturating) | Needs the size from §1 item 1 |
| Supply droop from pulses | All | Spec: 0.1 V at 20 mA (A7); ~40 mV at 8 mA extrapolated; switch transistor alone 1.59 mV per mA ([`experiments/tt_power_gate`](../experiments/tt_power_gate/README.md)) | A droop model per macro, feeding the "no reading during pulses" rule; whether a reading survives the tile's own digital activity |
| Optical emission and collection | XC-26 | Collected fraction verified to order; emission efficiency is a ×100 interval | Substrate resistivity (P4) |
| LOD stress in silicon vs model | XC-12, Residual | Model prediction only | Silicon, through the process matrix |

## 3. Mathematical results to test

| Statement | Why it matters | How to test |
|---|---|---|
| A difference of two Barber-Agakov lower bounds is not a bound on the difference of the true informations | Every "this structure adds X bits" in round 3 is such a difference | Build a toy with exact mutual information where the difference overshoots (a witness), then check whether round 3's differences could be in that regime |
| Incremental information needs a second estimator family | The author's and verifier's estimators disagree by 0.03–0.05 bits on some rows | Estimate I(K; Y_new \| Y_old) directly with a different method and its own interval |
| Shapley value of a structure is relative to the experiment, not a property of the cell | Choosing structures for the next chip | Repeat the two-structure split under other priors and models; see if the order changes |
| Redundancy R between two structures was never negative (no synergy) in round 3 | Whether structures can be worth more together than apart | Look for a model where R < 0, or argue why it cannot happen here |
| Every estimator must be monotone in the design (more readings never lose information) | A non-monotone row is an estimator failure, not physics | Already checked per row; keep it as a CI-style rule |
| The kT/C observable goes as T^(−1/2) (verified) | Thermometry: primary is ruled out, calibrated secondary is open | Sensitivity analysis with the reader's own drift |
| The background B must be identifiable from the cells drawn | The B witness of round 3 was ill-posed | Design a witness with G near B, or prove which cell geometry identifies B |

## 4. Experiments to run on silicon

The candidates, with success and failure written for each, are in the [ranking](RANKING.md); the full table of observables and
controls is [EXPERIMENTOS](EXPERIMENTOS.md) (Spanish). The order on the first chip:

1. **Virgin read**, before anything else is powered or pulsed. XC-14's first read is the experiment.
2. **Reader self-test and calibration:** if the calibration step is not resolved, everything else is inconclusive.
3. **Sweeps:** separation, edge length, temperature (hot plate), supply; long time series for XC-19.
4. **Writes last:** e-fuse blows, stress for XC-52, anything destructive.
5. **Retain and repeat:** the same channels on another day.

## 5. Tools to build

- The shared instrument with design-for-test ([ARCHITECTURES](ARCHITECTURES.md), gate 7 of [PIPELINE](PIPELINE.md)).
- A digital readout for Kelvin strips that keeps the four-terminal property (no analog pins: Juan, 2026-11-17).
- Residual: module 3 idea, choosing structures by their value relative to the rest of the experiment. Not before the
  estimates have controlled errors.
