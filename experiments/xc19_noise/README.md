# XC-19: noise made explicit, and whether an event can be detected

Run on 2026-11-11 and 12, after the pre-registration
[`XC-19_2026-11-11_ruido_y_deteccion.md`](../../cells/preregistros/XC-19_2026-11-11_ruido_y_deteccion.md) was committed.
Prompted by an external review: at the working point chosen in part 2 the shot noise of one conversion is as large as the step
being looked for. Model only. The step and its dwell times are injected; nothing here demonstrates a trap.

## N8a: shot noise in a transient simulation

Extracted readout cell, four in series, a white current source of density 2qI on the discharge node (`shot_trnoise.sp`,
read by `shot_read.py`, output in `shot.txt`). **48 conversions, not the 200 planned**: the run costs about eleven minutes per
simulated millisecond.

| | |
|---|---|
| Mean conversion time | 29.029 us |
| Spread | 159.2 ns, 0.548 % |
| Uncertainty of that spread from 48 samples | about 10 % of its value |

Prediction: 0.6 to 1.1 % (0.82 % from the electron count). **Failed narrowly, on the low side.** The 0.4 to 1.6 % band that validates the approach: inside.

The simulated spread is a third below the electron-count estimate. We have not identified why: candidates are the way the
simulator interpolates the noise source between its 10 ns samples, and a slow drift of 1 % across the run (29.15 us on the first
conversion, 28.84 us on the last) while the bias settles. The detection study below uses the larger, 0.82 % figure, so its
conclusions err on the cautious side.


## N8b: detection at the working point of part 2 (81 pA, 2.3 fF, 30 us per conversion)

Behavioural simulation, `detect.py`, fixed seed, output in `detect.txt`. A two-level signal of 0.83 % with exponential dwell
times, Gaussian noise of 0.82 % per conversion, a moving average of M conversions and a trigger with hysteresis.

| Mean dwell | Against a noiseless reference (M = 25) | Against an equally noisy twin (M = 49) |
|---|---|---|
| 0.9 ms | 39 % detected, 48 false per second | 22 %, 45 per second |
| 3 ms | 71 %, 11 per second | 54 %, 16 per second |
| 9 ms | 88 %, 3.0 per second | 80 %, 3.0 per second |
| 30 ms | 97 %, 1.7 per second | 95 %, 1.1 per second |
| 90 ms | 98 %, 1.8 per second | 97 %, 1.2 per second |

With no signal at all the detector still fires 1.3 to 1.5 times per second.

- Predicted: under 60 % at 3 ms. Obtained 71 %: failed, it does better.
- Predicted: 90 % with under one false event per second from about 7 ms (reference) and 15 ms (twin). Not reached at any dwell:
  **failed**.
- **Abandonment criterion reached**: even at 90 ms the false-event rate stays above one per second. The working point of part 2
  is abandoned. A slower detector would lower the false rate, but the criterion was fixed beforehand.

## N8c: more current and more capacitance (5.5 nA, about 135 fF)

The signal-to-noise ratio of one conversion grows with the number of electrons, and for a given conversion time that means more
current and a proportionally larger capacitor. Three in series instead of four, plus 133 fF on the node.

Checked in ngspice with the extracted cell (`k3_cap.sp`): 19.0 us per conversion, step 0.80 %, 860 000 electrons, so 0.108 %
of shot noise; kickback on the bias 0.005 mV with 10 pF.

| Mean dwell | Against a noiseless reference (M = 1) | Against an equally noisy twin (M = 1) |
|---|---|---|
| 0.07 ms (3 conversions) | 98 % detected, 0 false | 94 %, 1.9 per second |
| 0.25 ms | 99 %, 0 false | 98 %, 2.6 per second |
| 2.5 ms | 99.9 %, 0 false | 99.8 %, 3.2 per second |
| 25 ms | 100 %, 0 false | 99.9 %, 3.0 per second |

- Predicted: 0.08 to 0.16 % per conversion, held (0.108 %). Step 0.80 %, held.
- Predicted: more than 5 sigma in one conversion against a reference (7.4, held) and more than 4 against a twin (5.2, held).
- Predicted: 90 % from 0.25 ms with M = 1, held; it reaches 94 % at 0.07 ms.
- Against a twin, one conversion at 5.2 sigma still gives about three false events per second. Averaging two conversions would
  remove them at the cost of the shortest dwells. Not run.

**The revised working point is three in series with about 135 fF.** It also makes the node capacitance a drawn component
instead of a few femtofarads of wiring, which was the weakest number of the previous design.

## What these numbers leave out

- Bias noise (about 0.1 mV rms, common to device and twin), the threshold noise of the inverter, supply noise.
- Mismatch: the Monte Carlo of part 3 shows that discharge times spread over two orders of magnitude between nominally
  identical stages, so every device needs its own baseline and the counter needs that range.
- A twin read after the device does not cancel fast supply noise; two readers at once cancel it but add mismatch and coupling.
  The choice has not been compared.
- The dynamics of a real trap depend on gate and drain voltage, and the drain voltage moves during every conversion.
- The 133 fF as layout. A 4 x 4 um transistor used as capacitor gives 27.1 us against 29.2 us for the ideal one
  ([`cells/xc19_channel`](../../cells/xc19_channel/README.md)), exploratory.
