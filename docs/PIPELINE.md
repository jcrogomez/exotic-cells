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

## Gates before tapeout

1. Readout instrument meets its pre-registered resolution in simulation.
2. Written permission from Tiny Tapeout for any cell that is stressed on the bench, and confirmation of foundry rules for any
   deliberate antenna structure.
3. One pre-registration per cell that occupies silicon.
4. Real area of one complete channel per instrument on the analog template, from placement, not from sums.
5. DRC clean, own LVS clean (extracted from GDS, comparing the real devices), precheck passed.
