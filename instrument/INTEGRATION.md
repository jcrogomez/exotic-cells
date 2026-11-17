# Two ways into a Tiny Tapeout tile

How hand-drawn, electrically functional cells and synthesised logic can share one tile that uses only the digital pins.
Read from the sources on 2026-11-17 by an agent; the lines marked *checked* were re-read by a second reader. **No route has
been tried here. The choice is open.**

Sources: `tinytapeout.com/guides/creating-silicon-art`, `tinytapeout.com/specs/analog`, the LibreLane documentation
(`usage/using_macros`, `usage/pdn`), `TinyTapeout/tt-support-tools` at `8f7b506`, `TinyTapeout/tt-multiplexer` at `885086c`,
`algofoogle/ttsky26c-analog-stuff` at `7c57a0f`, `mattvenn/tt06-analog-r2r-dac`, `algofoogle/ttsky25b-analog-vga-dacs`.

## Facts

**Route A: macro inside the digital flow (LibreLane).**
- The only Tiny Tapeout page on GDS + LEF macros in a digital project is the silicon-art guide. Its macros are decorative:
  "it has no inputs, outputs, or power connections".
- That guide turns off disconnected-pin and disconnected-module errors for art, and, for tiles that are almost only art,
  also PDN and LVS. **None of that applies to a functional macro and none of it should be copied.**
- Nothing found in the Tiny Tapeout documentation or precheck forbids or permits a macro that contains transistors.
- Power: LibreLane connects macro power pins through `PDN_MACRO_CONNECTIONS` or power pins in the RTL. Whether that works
  with Tiny Tapeout's single-layer metal-4 power grid: **not confirmed**.
- LVS: LibreLane's documentation calls the macro's SPICE view "currently unused". Read as: top-level LVS sees the macro as
  a black box; its inside needs a separate LVS. (Inference, not a quoted statement.)
- ~~No Tiny Tapeout project was found that places a functional custom cell this way.~~ [corrected 2026-11-17] There is one:
  `htfab/cell-tester` (Tiny Tapeout 5, project 142) put four custom **row cells** into a digital design, by copying them into
  the PDK's library folder under OpenLane 1. Its LVS treated them as black boxes and their timing data was copied from the
  library ([`misfit01/README.md`](misfit01/README.md)). Still none found with a macro that is not a row cell.

**Route B: custom GDS top level on a digital template.**
- The precheck picks the template from the number of analog pins: with zero, a custom-GDS project gets the ordinary digital
  template `tt_block_<tiles>_pg.def`, at any digital size (*checked*: `precheck.py`, `is_analog = analog_pins > 0`).
- Precedent: `algofoogle/ttsky26c-analog-stuff` is a hand-drawn design on the 1×1 digital template with no analog pins
  (*checked*: its `info.yaml` has `tiles: "1x1"`, `language: Analog`, no `analog_pins` key) and is in the ttsky26c shuttle
  repository. It has **no synthesised logic**: pins go straight into the analog blocks. Silicon results: not found.
- Precedent for a hardened digital block inside a custom top level: `mattvenn/tt06-analog-r2r-dac` and
  `algofoogle/ttsky25b-analog-vga-dacs` harden a block separately up to metal 4 and place it by hand, with a full LVS script
  (drawn netlist + gate-level Verilog + standard-cell SPICE). Both use analog pins on 1×2; the method does not depend on them.
- You draw the power as vertical metal-4 stripes (at least 1.2 µm wide, spanning the tile); metal 5 is not available.
- The precheck for this route runs DRC, layer, pin, boundary and power-pin checks. **No LVS, no timing, no simulation**: those
  are the designer's.

**Both routes.** The power switch is chosen from the tile size alone (*checked*: `placer.py`, `'hp' if self.width > 4 else
'll'`, module `tt_pg_1v8_<variant>_<height>`): a 1×1 tile gets `tt_pg_1v8_ll_1`, a 1×2 or 2×2 gets `ll_2`.

## Comparison for MISFIT

| | A: macro in LibreLane | B: custom GDS, digital template |
|---|---|---|
| Logic checked by the flow | Synthesis, timing, DRC, top-level LVS | Only inside the separately hardened block |
| Macro inside checked | Not by the flow | Not by the flow |
| Top-level wiring checked | Yes, to the macro's pins | Only by an LVS we write |
| Power to the macro | Not confirmed | Drawn by hand, visible |
| Router near sensitive nodes | The router decides; obstructions needed | We decide |
| Gate-level test in CI | Standard Tiny Tapeout test, macro as a model | Ours to build |
| Precedent with functional cells | None found | Yes (1×1, no analog pins; hardened block inside, in two others) |
| Effort | Abstracts, pins on grid, PDN trials | Hand floorplan and routing, own LVS scripts |

## What is not known

- Whether Tiny Tapeout accepts transistors in a macro of a digital-flow project. This is the question for the contributor,
  and it is no longer "can it be done": **which route keeps the cells' electrical connections and still lets the whole be
  verified?**
- Whether the power grid reaches a macro's pins under route A.
- Whether either route lets the standard gate-level test and precheck run unchanged.

## The integration trial

**Run in part on 2026-11-17 as MISFIT-01: [`misfit01/README.md`](misfit01/README.md).** Route A splits in two: a macro with
metal-4 supply fails at the power grid; the same devices as a row cell pass every criterion. Route B passes the same criteria
with that macro and a separately hardened core, with DRC and LVS scripted by us. The
design below is the skeleton that the pre-registration filled in.

### As first designed

One dummy slot, the smallest thing that is electrically real: one precharge transistor, one discharge transistor, one
library inverter, with the port list of [`INTERFACES.md`](INTERFACES.md). The same slot and the same core through both routes.

| Check | Route A passes if | Route B passes if |
|---|---|---|
| Builds | LibreLane finishes with LVS, PDN and disconnected-pin errors **on** | The top level is assembled from the hardened core and the slot |
| Power | The extracted top level shows the slot's supply and ground tied to the tile's | Same |
| LVS, whole tile | Extracted from the final GDS, devices of the slot included, matches a netlist of core + slot | Same |
| Precheck | Passes unchanged | Passes unchanged |
| Simulation | The slot extracted from the final GDS discharges and the count read through the core's netlist is within 2 counts of the slot alone | Same |

A route that fails "LVS, whole tile" is out, whatever else it offers. If both pass, the one whose checks run without
hand-written exceptions is preferred. A prediction will be written before the trial; this table is its skeleton.
