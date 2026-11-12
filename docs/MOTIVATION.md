# Motivation

## The question

What physical components can be made to emerge from SKY130 that its library cannot describe or offer, and under what control?

A PDK is a contract: stay inside these rules and devices will behave like these models. Everything outside the models is treated
as a defect to be avoided. But the process still does those things. Mechanical stress shifts thresholds. Single defects switch
currents on and off. Plasma charges floating conductors. Junctions leak, emit and couple through the substrate. That physics is
already paid for in every chip; it is simply not in the catalogue.

## What counts as an Exotic Cell

A cell is exotic if it uses, as its working principle, something the library does not offer as a primitive. To enter the catalogue
a candidate must be:

1. **Based on a normally unwanted behaviour** of fabrication or operation.
2. **Repeatable**: it can be drawn again and behaves the same within stated limits.
3. **Predictable**: it can be simulated, with the PDK models or with a model we add and state.
4. **Useful beyond the obvious**: it must offer something not obtained more simply by resizing a transistor or picking another
   library device. A fuse is a fuse. Being simulable does not make a cell exotic.

A candidate graduates to the library only with a functional contract: model, interface, limits, variability, retention, failure
modes and formation conditions.

## Why it matters

- **Open PDKs ship gates and devices, not phenomena.** A library of measured physical primitives, with layout, model and silicon
  data, would be new to the open-silicon ecosystem.
- **It closes model gaps.** Every measurement has two legitimate outcomes: the model predicted it, which validates the open flow,
  or a reproducible residual remains, which improves the model or reveals a function.
- **It lowers the cost of unconventional hardware.** Probabilistic bits, in-memory analog weights and physical sensors usually
  need special processes. A shuttle tile is a cheap place to find out which of them a standard process can already do.

## Design primitives

These are the building blocks of every experiment, not the cells themselves.

| Primitive | Meaning |
|---|---|
| **Precursor** | A legal geometry that the foundry (route A) or the bench (route B) turns into the device |
| **Complete channel** | Precursor plus drivers, return path, readout and protection. One working channel before any array |
| **Twin** | An untouched copy of the device, same position in the die gradient |
| **Ghost** | A neighbour with no device, to measure disturbance from supply and heat |
| **Dummy** | A structure that dissipates the same power but lacks the mechanism |
| **Chronicler** | The shared readout: every quantity is converted to time and counted digitally |
| **Key** | Interlock and one-way state machine for anything that transforms a device |
| **Contract** | Pre-registration, four result states, and comparison against the conventional component |

## Rules

1. Design transformation paths, not only shapes.
2. Observability before surprise. No precursor enters without a known readout, noise floor and range.
3. The control does not accompany the experiment: it constitutes it.
4. Eliminate the boring explanation first. Carrier diffusion before photons, contacts before constrictions, die gradient before
   geometry.
5. What is latent judges; what is deterministic proves. A clean DRC is not a device. A frequency is not a mechanism.
6. Kill criteria are written before the experiment, never after.
7. Four result states: positive, informative negative, inconclusive, instrument failure. A negative informs only if the
   sensitivity is known.
8. The foundry is legal; the bench is free, with permission and in hardware. Everything submitted passes DRC and LVS. A check that
   a tool omits is not an authorisation.
9. The formation path is never the readout path.
10. The chip must be able to conclude that the conventional component wins.
11. Do not only explore what the process allows: explore what the process provokes.
12. One fact lives in one place, with its source.

## What success is, by level

1. **Instrument characterised**: sensitivity, floor and drift of the readout measured in silicon. Without this nothing below counts.
2. **Atlas**: each candidate with layout, extracted netlist, simulation, raw data, controls and conclusion.
3. **One hypothesis discriminated** above the detection limit, confirmed or refuted.
4. **Exceptional**: a reproducible property, governed by geometry or bias, with a quantified advantage over the library component
   that does the same job. That is an Exotic Cell.

Not success: a table of frequencies with no question, a line that opens, a shift attributed to quantum effects, a photodiode signal
without ruling out carriers.
