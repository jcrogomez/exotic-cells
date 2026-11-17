# From tile current to reading error: the supply transfer function of the XC-19 channel

Run on 2026-11-17 12:12 EST against a pre-registration written first
([`XC-19_2026-11-17_transferencia_alimentacion.md`](../../cells/preregistros/XC-19_2026-11-17_transferencia_alimentacion.md)).
**Simulation only.** Extracted and annotated channel, tt, 27 C, `hsa` mode, supply through a series resistance, a current
source loading the supplied node, no decoupling. Rs = 1.85 ohm is the transistor of `tt_pg_1v8_ll_1`
([`tt_power_gate`](../tt_power_gate/README.md)); 5 ohm is the 0.1 V at 20 mA of the analog specification.

## Result (`strans.txt`)

| Case | A (us) | B (us) | A vs quiet | Ratio vs quiet |
|---|---|---|---|---|
| `q` quiet | 30.2750 | 30.2746 | | A/B = 1.000013 |
| `s1` 1 mA continuous | 30.6590 | 30.6587 | +1.27 % | A/B moves 0.0003 % |
| `s8` 8 mA continuous | 33.4972 | 33.4968 | +10.64 % | 0.0001 % |
| `s1r5` 1 mA, 5 ohm | 31.3279 | 31.3276 | +3.48 % | 0.0003 % |
| `m1` step 0→1 mA at 15 us | 30.5063 | 30.5060 | +0.76 % (0.60 of `s1`) | 0.0003 % |
| `r1` 0/2 mA square at 50 MHz | 30.6556 | 30.6553 | +1.26 % (0.99 of `s1`) | 0.0003 % |
| `uq` B with 266 fF, quiet | 30.2736 | 59.6587 | | B/A = 1.970651 |
| `u1` same, step 0→1 mA at 36 us | 30.2736 | 60.0328 | 0.0000 % | B/A moves +0.63 % (0.49 of `s1`) |

The ratio figures of the equal-twin rows are at the last printed digit (six significant figures).

## Against the pre-registration

| | Predicted | Observed | |
|---|---|---|---|
| P0 control | quiet = 30.27 us | 30.275 us | held |
| P1 static, one side | +1.2 %, +9 to +12 %, +3.3 % | +1.27 %, +10.64 %, +3.48 % | held |
| P2 A and B together, equal | ratio moves < 0.01 % | ≤ 0.0003 % | held |
| P3 step at mid conversion | 30 to 70 % of static | 60 % | held |
| P4 clock-rate ripple | same as its mean, ±10 % | 99 % | held |
| P5 A and B unequal | A unchanged; ratio moves 0.3 to 0.6 of static | 0.0000 %; 0.49 | held |

P1 was nearly deducible from the known static sensitivity (stated as such beforehand). P3, P4 and P5 were not.

## What it means, by grade

- **Run (model):** a reading of one side moves 1.27 % per mA of tile current behind a 1×1 tile's power switch, and 3.5 % per mA
  if the whole stated supply drop applies. One trap is a step of about 0.8 %. The earlier 0.84 % per mA was arithmetic with a
  different switch variant and the stage figure; this replaces it.
- **Run (model):** reading A and its twin B in the same window cancels the disturbance to the last printed digit **when both
  take the same time**. When B takes twice as long, a 1 mA change after A has finished moves the ratio 0.63 %.
- **Run (model):** ripple at the clock frequency acts through its mean. The shape of digital activity during a count did not
  matter here; its average did.
- **Conclusion for the instrument (judgement):** a twin protects a cell that resembles its twin. An unknown cell does not, so
  the simultaneous read is not enough for it. Candidates, none chosen: the same digital activity in every compared window;
  the calibration source re-read in the same window as the cell; reading order randomised so that a drift cannot pass for
  a signal. Reading in turns (A quiet, B loaded) moves as much as one side alone: arithmetic, not run.

## Not covered

Mismatch between A and B (earlier result: median 0.047 % for 10 mV, `experiments/xc19_weak_inversion/n5.txt`), noise, the
metal of the power network, ground bounce, substrate coupling, the tile's real decoupling, other corners and temperatures.
Nothing here is silicon.

## Reproduce

`SKY130A=<path to sky130A> ./run.sh`
