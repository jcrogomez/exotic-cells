# The MISFIT instrument

A characterisation platform for experimental silicon: one digital core that interrogates any cell plugged into a slot,
turns what the cell does into a count, and can tell "the cell did nothing" from "the instrument is broken". Started
2026-11-17. **RTL and behavioural models only. Nothing here is layout, and nothing is silicon.** No architecture is frozen.

The aim of this phase: show, with an explicit model and reproducible tests, that an unknown cell can be interrogated without
assuming beforehand how it behaves; and that the instrument stays useful when a hypothesis about a cell turns out false
(a null, a defective device and a supply artefact are results it must be able to record).

| File | What |
|---|---|
| [`rtl/tt_um_misfit.v`](rtl/tt_um_misfit.v) | Tiny Tapeout top level, digital pins only, four cell slots |
| [`rtl/misfit_core.v`](rtl/misfit_core.v) | Protocol, channel selection, fault isolation, measurement engine |
| [`models/misfit_cell_slot.v`](models/misfit_cell_slot.v) | Behavioural stand-in for a slot. Simulation only; replaced by a drawn macro |
| [`INTERFACES.md`](INTERFACES.md) | The contract: pins, registers, flags, what a slot macro must do |
| [`RISKS.md`](RISKS.md) | Physical risks the RTL cannot see, and what would test each |
| [`INTEGRATION.md`](INTEGRATION.md) | The two ways into a Tiny Tapeout tile, compared from the sources |
| [`test/`](test/test_misfit.py) | cocotb tests; `test/run.sh` runs them and a synthesis sanity check |
| [`misfit01/`](misfit01/README.md) | MISFIT-01: one hand-drawn inverter into a Tiny Tapeout tile by three routes, with negative controls |
| [`misfit02/`](misfit02/README.md) | MISFIT-02: a hand-drawn cell of known time read by this core's counter; the core and the cell in one tile |

## Separation of concerns

| Block | Knows about | Does not know about |
|---|---|---|
| Protocol (registers, write strobe) | Addresses and bytes | What a measurement is |
| Selection and isolation | Which slot is enabled and selected | What is inside a slot |
| Measurement engine | Precharge, a window, two edges, a count | Which physics produced the edges |
| Slot (macro) | Its own physics, its reference discharge and capacitor units | Other slots, the protocol |

A slot's four input lines and two output lines are the only coupling the design intends. Unintended coupling (supply,
substrate, leakage) is the subject of [`RISKS.md`](RISKS.md).

## What is shown, and at which level

| Property | RTL (cocotb, behavioural slots) | SPICE | Extraction | Layout | Silicon |
|---|---|---|---|---|---|
| Reset leaves every slot disabled, unprecharged, unstimulated | shown (`t01`) | no | no | no | no |
| A start is refused unless armed and the slot enabled, and touches nothing | shown (`t03`) | no | no | no | no |
| Counter, protocol and readout work with every slot disabled (internal digital reference) | shown (`t04`) | not applicable | no | no | no |
| Only the selected slot receives precharge and stimulus | shown (`t05`) | no | no | no | no |
| A discharge time becomes a count; a 0.8 % step is resolved at 50 MHz | shown for an ideal edge (`t06`) | the edge itself: channel simulated ([XC-19](../cells/xc19_channel/README.md)) | channel extracted | reader drawn, not a macro | no |
| Calibration seen, cell not: told apart from a silent instrument | shown (`t07`) | calibration sources not designed | no | no | no |
| Twin read alone or in the same window | shown (`t08`) | supply rejection of the twin: [`supply_transfer`](../experiments/supply_transfer/README.md) | same | no | no |
| A stuck or unknown slot output is flagged, excluded, and does not disturb other slots | shown **for logic values only** (`t09`) | **not shown**: a real short can feed through signals, wells or the supply | no | no | no |
| Timeout, recovery, abort, disarm, reset in mid run | shown (`t10`, `t11`) | no | no | no | no |
| An unknown cell is classified (count, silent, stuck, instrument fault) by widening the window | shown (`t12`) | no | no | no | no |
| An edge at any phase of the clock is captured once, monotonically, one count per period | shown (`t13`) | **metastability not shown**: logic simulation has none; the failure rate of the synchroniser is not estimated | no | no | no |
| A hand-drawn device sits in the tile, powered, wired to synthesised logic, seen by LVS | not applicable | tile extracted from the final GDS simulated | [`misfit01/`](misfit01/README.md): one route passes with its negative controls | same | no |

"Shown" at RTL means: the logic does what the contract says, against a model that obeys the contract. It says nothing about
whether a drawn macro obeys it. Fault injection here forces a logic value on a wire; it is a test of the protocol, not of
electrical isolation.

Run on 2026-11-17: 13 tests, 13 pass (Icarus Verilog 13.0, cocotb 1.9.2). Generic synthesis (Yosys 0.55, not mapped to
SKY130): 991 cells, 142 flip-flops, slots as black boxes. No timing, no area, no gate-level simulation yet.

## Controls built in

- **Positive:** differential capacitor calibration per slot (`src` 2: 2 units on A, 1 on B; `src` 3: 1 unit each); the internal digital reference
  (channel 7), which needs no slot at all.
- **Negative:** `src` 0 (no source selected: a discharge here is leakage or a fault); a refused start; a disabled slot.
- **Not built yet:** a slot with no cell (structural blank), temperature, drift across repeats, randomised reading order.
  These are host-side sequences or macro choices, and are open.

## Open decisions

- Number of slots, counter width, clock frequency, and whether the counter keeps running between windows so that digital
  activity is the same in every compared reading ([`supply_transfer`](../experiments/supply_transfer/README.md)).
- Single, simultaneous or interleaved twin reads as the default. The model says simultaneous protects only a cell that
  resembles its twin.
- The wide-range front-end XC-20 needs (the precharge reader saturates near 1.25 nA).
- Stimulus lines for cells that need a pulse (fuse, coil, heater): not in the contract yet, on purpose.
- The integration route ([`INTEGRATION.md`](INTEGRATION.md)).

## Run

```
./test/run.sh        # Docker, hpretl/iic-osic-tools:2025.07
```
