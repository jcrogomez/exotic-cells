# Design pipeline

## The exotic design pipeline

Added on 2026-11-12. The target is the third region of the SKY130 configuration space: neither what standard cells do nor what
fails, but a usable, unconventional physical behaviour. A family goes through these steps; the output of each is a file in its
folder under `cells/`.

| Step | What is done | Output |
|---|---|---|
| 1. Raw material | Start from something the process does that nobody asked for: a leak, a defect, a model gap, a material property, a rule nobody checks | A line in the catalogue |
| 2. First-principles attack | Put numbers on the scales: energy against kT, length against what can be drawn or printed, time against what the reader can follow, signal against the floor. Constants and assumptions stated | Section 0 of `PLAN.md` |
| 3. Three-region hypothesis | Name the parameter that carries the structure from conventional, through the third region, into failure, and guess where the two borders are | Section 0 of `PLAN.md` |
| 4. Physical simulation | Simulate the physics the PDK models leave out, sweeping what is unknown about the process: lithography, doping, device transport, heat, electromigration, optics, magnetic field, acoustics | A folder under `experiments/`, prediction written first |
| 5. Rules as material | For each geometry: inside the rule, at an edge no deck checks, or outside the rule. What the shuttle precheck accepts is measured, not assumed | Edge report and precheck map |
| 6. Independent attack | Someone else tries to kill the idea with their own arithmetic and their own sources before anything is drawn | Attack note in the folder |
| 7. Parametric layout | A script draws the sweep so that it crosses both borders: dimensions, aspect ratio, perimeter against area, distance, orientation, layer | `.tcl`, `.mag`, `.gds` in the folder |
| 8. Reader and controls | Twin, ghost and dummy through the same readout; calibration that does not depend on the phenomenon | Simulated channel |
| 9. Silicon | Virgin, calibrate, characterise, transform if it applies, observe, retain, classify | Raw data |
| 10. Residual | Silicon minus prediction. Either the model improves or a behaviour deserves a cell | Contract, or an entry in the atlas |
| 11. Filter | Only at the end, when tests, simulations and design ideas have run out | The library |

Tests available at each step: [`../cells/PRUEBAS.md`](../cells/PRUEBAS.md). Order of work:
[`PLAN_EXPLORATORIO.md`](PLAN_EXPLORATORIO.md).

## The standard flow, and what we add to it

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

## Design rules as material

Three zones, all explored:

1. **Inside the rule, where the process does not follow the drawing.** Necks, corners, facing line ends, notches. Legal, and
   printed differently from what was drawn ([lithography exploration](../experiments/litho_explore/README.md)).
2. **At an edge nobody checks.** Rules the PDK marks as not checked, rules only one deck checks, and checks the shuttle precheck
   does not run. Where the legal edge is, and which rule sits there: [`residual/drc_edge`](../residual/drc_edge/README.md).
3. **Outside the rule.** Free in simulation. What the precheck actually rejects is measured by running it, geometry by geometry.

Reliability rules (current density, voltage, ageing) are not geometry: they are what the bench exceeds on purpose.

## Gates before tapeout

1. Readout instrument meets its pre-registered resolution in simulation, with noise simulated explicitly.
2. Answers from Tiny Tapeout on what is still unknown: number of chips, custom macros, fill blocking, bench stress, antenna.
3. One pre-registration per cell that occupies silicon.
4. Real area of one complete channel per instrument on the template actually chosen, from placement, not from sums.
5. The shuttle precheck passed (its requirement, not ours), with the precheck map of step 5 showing what each cell relies on;
   own LVS extracted from GDS, comparing the real devices.
6. **Edge report**: every rule a custom cell sits within one grid step of, every rule that only one deck checks, and every
   disagreement between decks, listed with the cell that causes it.
