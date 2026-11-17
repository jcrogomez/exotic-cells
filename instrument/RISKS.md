# Physical risk matrix

What the RTL tests cannot see. Version 0 (2026-11-17). Grades: **model** = simulated here; **source** = read from a
specification or upstream file; **none** = no evidence yet. Nothing is silicon.

| # | Risk | Why the RTL is blind to it | Evidence today | What would test it | Level needed |
|---|---|---|---|---|---|
| 1 | Supply droop from tile current shifts a reading | Counts are exact in RTL | model: +1.27 % per mA behind a 1×1 power switch; the twin cancels it only if both sides take the same time ([`supply_transfer`](../experiments/supply_transfer/README.md)). source: switch sizes ([`tt_power_gate`](../experiments/tt_power_gate/README.md)) | The same run with the power-network metal, the tile's decoupling and the core's real current profile | SPICE with extracted supply; then silicon |
| 2 | The core's own switching current differs between compared readings | Same | none (the mean matters, not the shape: model, one case) | Current profile of the synthesised core per state; compare windows | Gate-level power estimate + SPICE |
| 3 | A shorted or leaking slot back-powers others through signal lines, wells or protection diodes | A "disabled" slot is a logic 0 in RTL | none | Extracted macro with a forced short, neighbours enabled; check every path that is not a supply pin | SPICE on extraction |
| 4 | `en` low does not make a macro inert (floating nodes, leakage through the precharge device) | Contract assumed | model, partial: precharge leakage 0.010 to 5.3 pA ([CLAIMS](../docs/CLAIMS.md)) | Each macro simulated with `en` low, all corners | SPICE on extraction |
| 5 | Slow edge on `xa`/`xb` into a library gate: crowbar current, metastability, double counting | An edge is instantaneous in RTL | none for the path into the synchroniser; the inverter threshold is in the channel runs | Simulate the real edge into the first gate; consider a Schmitt input | SPICE |
| 6 | Kickback and coupling from `pre` and from the clock into the measured node | No charge in RTL | model: kickback 0.076 mV at 1 pF, 0.016 mV at 10 pF, one stage ([CLAIMS](../docs/CLAIMS.md)) | Extracted channel with routed control lines | Extraction with routing |
| 7 | Temperature: discharge times move with it more than the signal | No temperature in RTL | model: bias usable in five corners at 27 and 85 C ([CLAIMS](../docs/CLAIMS.md)); no on-chip thermometer | A temperature-dependent slot as a reference; repeats over a controlled sweep | SPICE, then silicon |
| 8 | Drift and ageing over the life of a measurement campaign | No time beyond the window | none | Repeated calibration reads; order randomised | Silicon |
| 9 | Mismatch between a cell and its twin passes for a signal | Twins are identical in RTL | model: ratio moves a median of 0.047 % for 10 mV; times spread over two orders ([CLAIMS](../docs/CLAIMS.md)) | Replicas per cell; the blank slot | SPICE Monte Carlo, then silicon |
| 10 | Noise floor above the step looked for | No noise in RTL | model: 98 % detection at 5.5 nA and 135 fF; fails at 81 pA ([CLAIMS](../docs/CLAIMS.md)) | Noise simulated on the extracted macro with its real capacitors | SPICE on extraction |
| 11 | The macro's power pins are not connected by the flow, or connected through a path nobody checked | Power is implicit in RTL | none | The integration trial of [`INTEGRATION.md`](INTEGRATION.md) | Layout + LVS |
| 12 | A cell that breaks rules on purpose fails a check that is not ours to waive, or damages a neighbour (latch-up, charge injection into the substrate) | Not modelled | model, partial: precheck map ([`precheck_map`](../experiments/precheck_map/README.md)) | Guard structures and distance rules per cell; the edge report of the pipeline | Layout, DRC, then silicon |
| 13 | Digital-router wires over a sensitive node | No geometry in RTL | none | Obstructions in the macro abstract; extraction with the routed top level | Layout |
| 14 | The range of an unknown cell exceeds the reader (too fast for the clock, too slow for the window, current above saturation) | The model's times are whatever the test sets | model: the precharge reader saturates near 1.25 nA ([RANKING](../docs/RANKING.md)) | A second front-end or selectable capacitor; classify "out of range" explicitly | SPICE |

Rule used to fill the matrix: a property demonstrated by emulation is listed as **none** for the physical level, even when
its RTL test passes.
