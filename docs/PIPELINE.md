# Design pipeline

The flow follows the standard Tiny Tapeout / Zero to ASIC steps. Nothing is skipped. Each step gains one extra move that turns a
chip design flow into an experiment.

| Standard step | What we add |
|---|---|
| Specification (`info.yaml`, `docs/info.md`) | **Pre-registration** per cell: prediction, controls and kill criterion, frozen by hash before any run |
| Schematic and ngspice | **Twin simulation**: every cell runs next to its control, with the effect switched on and off |
| Layout (Magic, scripted and parametric) | **Randomised replicas**: position and mirrored orientation drawn from a committed seed |
| DRC, extraction, LVS | **Residual**: annotate the netlist with layout context the extractor drops (diffusion length, well distance, antenna ratio) |
| Post-layout simulation | **Mismatch floor**: Monte Carlo sets how many replicas are needed before anything is drawn |
| cocotb and gate-level simulation | **Planted mutant**: a fake effect injected into the model that the readout must detect, plus a case it must not detect |
| Precheck, GDS via GitHub Actions, submission | **Contract**: each cell ships with layout, model, prediction and limits |
| Bring-up on the demo board (MicroPython) | **Bench twin**: the same script runs against the simulation and the chip. Silicon minus prediction is the residual |

## Simulability classes

Software can kill candidates and size the instrument. It cannot confirm physics the model does not contain.

| Class | Meaning | What software decides |
|---|---|---|
| A | The effect is in the PDK models | Whether it works across corners and mismatch |
| B | Needs an added model with literature parameters | Order of magnitude, and whether the readout can see it |
| C | No open model predicts it | Only that the structure is legal and harms no neighbour |

Class describes what can be simulated, not whether a cell is exotic or useful.

## The loop

```
geometry -> physical model -> prediction -> silicon -> measured residual
```

A residual has two legitimate destinations: an improvement to the model, or a functional property that deserves an Exotic Cell.

## Design rules: obeyed, and used as an instrument

The premise of this project is that unwanted behaviour can be drawn on purpose. That does not mean drawing rule violations.
On a shared shuttle a geometric violation can reject the submission or damage other people's projects, and that decision is not
ours. The exotic space lies elsewhere:

1. **Legal geometry the model does not describe.** Diffusion length, well distance, abutted junctions, minimum constrictions.
   They pass every check and are still simulated wrongly ([LOD audit](../experiments/lod_audit/README.md)).
2. **Rules that no deck checks.** They are listed, not exploited blindly: an omitted check is not an authorisation.
3. **The margin.** The distance from each shape to its limit is an experimental variable. Knowing exactly where the legal
   edge is, and which rule sits there, is measured with [`residual/drc_edge`](../residual/drc_edge/README.md).
4. **Reliability rules, which are not geometry.** Current density, voltage, ageing. Those are exceeded on purpose, on the bench,
   after fabrication, with permission and with interlocks.

## Gates before tapeout

1. Readout instrument meets its pre-registered resolution in simulation, with noise simulated explicitly.
2. Written permission from Tiny Tapeout for any cell that is stressed on the bench, and confirmation of foundry rules for any
   deliberate antenna structure.
3. One pre-registration per cell that occupies silicon.
4. Real area of one complete channel per instrument on the template actually chosen, from placement, not from sums.
5. DRC clean on every mandatory deck, run on the whole design with the full rule set; own LVS clean (extracted from GDS,
   comparing the real devices); precheck passed.
6. **Edge report**: every rule a custom cell sits within one grid step of, every rule that only one deck checks, and every
   disagreement between decks, listed with the cell that causes it.
