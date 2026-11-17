# MISFIT-01: one hand-drawn inverter through the Tiny Tapeout flow

Run on 2026-11-17 against a pre-registration written first
([`MISFIT-01_2026-11-17_integracion_fisica.md`](../../cells/preregistros/MISFIT-01_2026-11-17_integracion_fisica.md), with one
amendment made before any arm ran).
Two amendments were made to it, each before the arm it concerns ran. **All three arms run. Layout, extraction and simulation;
no silicon.**

The question: which route puts a hand-drawn MOS device into a Tiny Tapeout tile that uses only the digital pins, wired to
synthesised logic and to the supply, with **no check switched off** and the device visible to LVS? Nothing exotic yet: the
circuit is an inverter (nfet 0.65/0.5, pfet 1.00/0.5, a geometry the library does not have) between two registers.

## Result

| Arm | How the inverter enters | Predicted | Observed |
|---|---|---|---|
| A1 | Macro (GDS + LEF) with its supply on two metal-4 stripes, `PDN_MACRO_CONNECTIONS` | Fails: supply does not reach the macro (80 %) | **Failed as predicted.** `[PDN-0232] The grid "macro - u_inv" does not contain any shapes or vias`, `[PDN-0233] Failed to generate full power grid`. The flow connects a macro between metal 4 and metal 5, and the Tiny Tapeout template has no metal 5 |
| A2 | The same devices as a row cell (3.68 × 2.72 µm, metal-1 rails, own taps), added as an extra cell and placed by the flow | Passes DRC and LVS from GDS (65 %) | **Passes all six criteria**, on the second attempt. The first attempt passed the flow and failed the precheck |
| B | Core hardened apart (161 × 70.72 µm, its top pins are the tile's pins); the 12 × 9 µm macro that failed in A1 placed below it; two signal wires on metal 2 and the supply on metal 4 drawn by script; own LVS | Passes with own LVS (70 %) | **Passes all six criteria**, on the third attempt |

### Arm A2 against the six criteria (run `a2r2`)

| # | Criterion | Result | Evidence |
|---|---|---|---|
| 1 | No template check switched off | Held. Five keys added, none disables anything: `EXTRA_LEFS`, `EXTRA_GDS_FILES`, `EXTRA_SPICE_MODELS`, `EXTRA_VERILOG_MODELS`, `MAGIC_EXT_USE_GDS` | [`a2/src/config.json`](a2/src/config.json) |
| 2 | Magic DRC on the final GDS: 0 | 0 | flow metrics |
| 3 | LVS from the final GDS matches, and the extraction holds both transistors with their W/L | "Circuits match uniquely"; `nfet_01v8 w=0.65 l=0.5`, `pfet_01v8 w=1 l=0.5` inside `misfit_inv` | [`results/a2r2_lvs.rpt`](results/a2r2_lvs.rpt), [`results/a2r2_tile_extracted.spice`](results/a2r2_tile_extracted.spice) |
| 4 | pfet source on the tile's supply, nfet source on its ground | `Xu_inv … VGND VPWR misfit_inv` in the extracted top level | same file |
| 5 | Tiny Tapeout precheck passes unchanged | Passes (15 checks) | [`results/a2r2_precheck.md`](results/a2r2_precheck.md) |
| 6 | The netlist extracted from the final GDS, simulated in ngspice, inverts | Inverts: the inverter output on `uo_out[1]` reads 1.8 V after reset, 0 V after a 1 is clocked in, 1.8 V after a 0; the output register follows. Same figures as with the first version of the cell: the extraction carries devices, not parasitics, and the transistors did not change | [`results/tile_sim.txt`](results/tile_sim.txt) |

### Negative controls (arm A2, corrected cell)

| Control | What was done | Had to happen | Happened |
|---|---|---|---|
| N1 structural | pfet source not tied to the rail (`a2r2n1`) | Flow or LVS fails | LVS fails: 24 errors, "Top level cell failed pin matching" |
| N2 functional | Layout with L = 1.0, reference netlist of L = 0.5 (`a2r2n2`) | LVS fails | LVS fails: 2 property errors |
| N2 functional | Layout and netlist with L = 1.0 (`a2r2n2b`) | Passes, and the simulated delay changes by more than 20 % | Passes. Devices only, 20 ps step. Clock to `uo_out[1]`, whole path: falling 0.600 → 0.713 ns (+19 %), rising 0.709 → 0.958 ns (+35 %). The inverter alone was not isolated: the path includes the clock tree, the register and the output buffer, which did not change, so the inverter's own delay changed by more than these figures; the falling edge on the whole path is under the 20 % stated |
| N3 verifier | Cell with no devices (`a2r2n3`) | LVS fails | Fails: 4 Magic DRC errors and 29 LVS errors |

The same four controls gave the same outcomes with the first version of the cell ([`results/attempt1/`](results/attempt1/)).

### Arm B against the six criteria

| # | Criterion | Result | Evidence |
|---|---|---|---|
| 1 | No template check switched off | Held for the core (template configuration; only the die size and pin template changed). The tile itself is not built by the flow: its DRC and LVS are scripts of ours | [`b/core/`](b/core/), [`b/lvs.sh`](b/lvs.sh) |
| 2 | Magic DRC on the final GDS: 0 | 0, checked on the GDS read back in a fresh session | `b/lvs.sh` output |
| 3 | LVS from the final GDS matches, with both transistors | "Circuits match uniquely": 33 devices and 60 nets in the core, 2 devices in `misfit_inv_m4`, compared inside | [`results/b_lvs.rpt`](results/b_lvs.rpt) |
| 4 | Supply and ground of the inverter on the tile's | `Xmisfit_inv_m4_0 … VGND VPWR` at the top level of the extraction | [`results/b_tile_extracted.spice`](results/b_tile_extracted.spice) |
| 5 | Precheck passes unchanged | Passes (15 checks), third attempt | [`results/b_precheck.md`](results/b_precheck.md) |
| 6 | Extracted netlist inverts in ngspice | Inverts at both extraction levels: `uo_out[1]` reads 1.8 V after reset, 0 V after a 1 is clocked in, 1.8 V after a 0; the output register follows | [`results/pex/levels.txt`](results/pex/levels.txt) |

### Negative controls (arm B)

| Control | What was done | Had to happen | Happened |
|---|---|---|---|
| N1 structural | The macro's supply stripe not joined to the tile's | LVS fails | "Netlists do not match". **DRC stays at 0**: only LVS sees a missing supply |
| N2 functional | Reference netlist with L = 1.0 against the layout of L = 0.5 (the layout was not redrawn in this arm) | LVS flags it | 2 property errors. netgen still prints "Circuits match uniquely": a script that reads only that line would pass it; ours counts property errors |
| N3 verifier | Macro left out, wires kept | LVS fails | "Netlists do not match", and 2 DRC errors |

### The three attempts of arm B

1. Pin labels placed over the core's pins without top-level metal: the extraction showed the tile's ports not connected to the
   core. Predicted in amendment 2 (60 %: "the first LVS will not match, by a drawing error of mine in the supply or a pin").
2. LVS matched and Magic DRC was 0, and the **precheck failed twice over**: the supply pins did not reach within 10 µm of the
   top edge, and the KLayout manufacturing deck found four `hvtp.SP.1` violations between standard cells of the core. Writing
   the core back through Magic had regenerated the implant layers of the library cells; reading it with `gds readonly true`
   keeps them as the PDK drew them.
3. Both fixed. DRC, LVS, precheck and the three controls as above.

The prediction "the precheck passes if Magic DRC and the KLayout deck pass" (75 %) was wrong as worded: Magic DRC passed and the
precheck did not.

## Extraction levels

What "extracted" means in every figure of this page:

| Level | What the netlist holds | Reached | Used for |
|---|---|---|---|
| Devices | Transistors and resistors from the final GDS, ideal wires | A2 and B | LVS; first simulations |
| Devices + capacitance | The same plus every capacitance Magic extracts (`ext2spice cthresh 0`): 991 capacitors in A2, 1149 in B | A2 and B | Delays below |
| Devices + capacitance + wire resistance | Interconnect resistance | **Not reached.** The flow writes resistance and capacitance of the routed nets of A2 as SPEF for its timing analysis; that was not turned into a simulation, and B has none | |

Clock to `uo_out[1]` (inverter output through the output buffer, 10 fF load), tt, 27 C:

| Arm | Level | Falling | Rising |
|---|---|---|---|
| A2 | devices | 0.615 ns | 0.734 ns |
| A2 | devices + capacitance | 0.901 ns | 1.125 ns |
| B | devices | 0.795 ns | 0.902 ns |
| B | devices + capacitance | 1.452 ns | 1.646 ns |

- Capacitance adds 46 to 53 % to the path in A2 and 82 % in B: the device-only figures are not post-layout delays.
- B is slower than A2 at both levels. The paths differ (another placement, hand-drawn wires about 25 µm long, a macro with
  metal up to layer 4), so this is not a comparison of the inverter.
- The B run with capacitance did not converge as extracted (singular matrix at the output of an unused tie cell) and was
  rerun with a 1 TΩ shunt on every node (`rshunt`); the other three have none. Time step 50 ps; the same A2 netlist at
  20 ps gave 0.600 and 0.709 ns, so about 3 % of each figure is the step.

These are simulations of an extraction. They are not a statement about silicon.

## What the first attempt of A2 taught

The first cell passed Magic's full DRC, the flow's DRC and LVS, and then **failed the precheck**: the KLayout manufacturing deck
flags the poly contact 0.095 µm from the p+ implant of the pfet (`licon.SP.6`, 0.11 µm). Magic does not check that distance in
this position. The contact was moved 0.04 µm. This is the kind of rule the pipeline's edge report exists for: checked by one
deck only. A clean flow run was not a pass.

## What this does and does not show

- **Shown (layout, extraction, LVS, precheck, simulation of the extraction):** a hand-drawn transistor pair can sit in a
  Tiny Tapeout digital tile, powered through the standard-cell rails, wired by the router, compared device by device by LVS,
  with the template's checks on, and the verifiers do reject a cut supply, a changed channel and a missing device.
- **Not shown:** that silicon behaves like the simulation. A clean DRC and LVS does not make a new device work.
- **Not seen by the flow:** timing through the cell. The log says `misfit_inv has no liberty cell`: static timing treats it as
  a black box, so the path register → inverter → register is **not timed**. A real slot needs either a timing model or a
  synchroniser at its outputs (the instrument already has one) and a stated constraint on its inputs.
- **The limit of the row route:** it needs the cell in **row form** (2.72 µm high, or a multiple, with the rail pattern). The
  XC-19 channel as drawn is 25.5 × 5.1 µm and its cells were not drawn on rows. Arm B takes free geometry instead (below).
- **Not tested:** nwell and tap interaction with neighbours beyond what DRC checks; cells that break rules on purpose; anything
  with a second supply; four slots.

## A2 against B

| Question | A2: row cell in the digital flow | B: custom GDS with a hardened core |
|---|---|---|
| Which geometries | Cells 2.72 µm high (or a multiple, untested) with the library's rail and well pattern, widths in steps of 0.46 µm | Anything that passes DRC in the free area. Shown with a 12 × 9 µm macro that the digital flow could not power |
| Supply and ground | Metal-1 rails, by abutment with the rows | Metal 4 drawn by our script, joined to the core's straps continued down the tile |
| Signals | The router, to pins on local interconnect or metal 1 | Wires drawn by our script from pins we put on the core's bottom edge. Two here |
| Checks that stay on | Flow DRC, LVS with the devices compared, timing of the logic, precheck: all automatic | Precheck automatic. DRC and LVS are scripts of ours; the core's inside is timed by the flow, the wires we draw are not |
| Timing of the custom cell | None: no Liberty model, the flow treats it as a black box | None, and the boundary between core and cell is not timed either |
| XC-19 as drawn (25.5 × 5.1 µm, not on rows) | Needs redrawing on rows, or a double-height cell (untested) | Fits as it is |
| Attempts to pass | 2 | 3 |
| Keys outside the template | 5 | 0 in the core; the tile is outside the flow |
| Area used | 3.68 × 2.72 µm inside the rows | Core takes the top 70.72 µm of the 111.52 µm tile; 161 × 40.8 µm left free |
| Where it can go wrong unseen | A rule only the precheck knows (`licon.SP.6`) | Everything the hand-written LVS does not read; a GDS rewritten by the wrong tool (`hvtp.SP.1`); property errors under a "match" line |

**How timing would be characterised (open, nothing done).** Neither route has a model, and copying the library's would be
wrong for a new geometry. Two ways out, not exclusive: simulate each cell extracted with capacitance over corners and write
its delays as a Liberty table; or design so that it does not matter, which the instrument already does on the output side
(the cell's edge is asynchronous and goes through a synchroniser) and can do on the input side (enable, source and precharge
held still during a count).

**Which carries XC-19 without touching its geometry:** B.

**Which is less risky for MISFIT:** they fail in different places. A2 risks the *experiment* (a cell bent to fit a row is not
the cell under study) and protects the *verification* (everything is checked by the flow). B protects the experiment and puts
the verification in our hands. Both passed the same six criteria and the same controls, so a hybrid is supported by the
evidence: row cells for what is ordinary (references, calibration sources, comparators), free geometry for the cells whose
shape is the experiment. Not decided.

## The precedent: `htfab/cell-tester` (Tiny Tapeout 5, project 142)

Read from the repository at `d21b040` by an agent, nothing executed. It corrects a line of ours: we had found no Tiny Tapeout
project with functional custom cells in the digital flow. There is one.

| | cell-tester | A2 |
|---|---|---|
| Cells | Four row cells (2.72 µm, 4.14 to 9.66 µm wide) recreating library cells, generated by a Python script; taps from the flow | One hand-drawn inverter, own taps |
| How they enter | Copied into the PDK's own library folder; OpenLane 1 | Extra-cell keys of LibreLane 3; PDK untouched |
| LVS | Custom cells as **black boxes**: no transistor in the LVS netlist | Devices compared; negative controls fail |
| Timing model | The library's Liberty data **copied** under new names. The author says so | None |
| Checks off | KLayout DRC and XOR off, **as in the template of the time** (and of today): not a concession of the author | As the template |
| Silicon | The author reports testing the direct outputs by hand at human speed, and does not recommend the cells for serious use. No delay measurement published | None |

Worth reusing from it, as ideas: each custom cell next to its library twin on paired pins; a gated ring oscillator that replays
preloaded input vectors faster than the pins allow; a delay line that samples all outputs as an edge travels down it (a
time-to-digital converter in units of one buffer delay); a name prefix that tells the flow which instances not to resize.
Not to reuse: the copied timing data and the black-box LVS.

## Hypotheses: what survived and what did not

| Hypothesis | Prior | Outcome |
|---|---|---|
| A macro with metal-4 supply cannot be powered under the Tiny Tapeout template | 80 % | Survived: power-grid generation fails |
| The same devices as a row cell pass every check with none switched off | 65 % | Survived, after the precheck caught a rule Magic does not check |
| A custom-GDS tile with a separately hardened core passes with an LVS of our own | 70 % | Survived, on the third attempt |
| The first LVS of arm B will not match, by a drawing error in the supply or a pin | 60 % | Survived: pins |
| The precheck passes whenever Magic DRC and the KLayout deck pass | 75 % | **Refuted** as worded: Magic DRC was clean both times the precheck failed |
| A clean Magic DRC means a clean manufacturing deck | implicit | **Refuted** twice (`licon.SP.6` in a cell of ours, `hvtp.SP.1` in rewritten library cells) |
| Lengthening the channel changes the simulated delay by more than 20 % | stated | **Partly**: +35 % rising, +19 % falling on the whole path; the inverter alone was not isolated |
| No Tiny Tapeout project has functional custom cells in the digital flow | our earlier reading | **Refuted** by cell-tester (row cells; black-box LVS) |
| cell-tester switched KLayout DRC and XOR off as a concession | an outside claim | **Refuted**: those lines are the template's |

## What is still missing for a working chip

- A cell that does something the instrument measures: phase 2 (a known discharge time read through the counter), with its
  own prediction.
- Wire resistance in the extraction, and corners other than tt, 27 C.
- A timing statement for the boundary between logic and custom cells.
- Four slots: in B, every slot signal is one more scripted wire and every slot one more supply join; untested beyond one.
- Whether Tiny Tapeout accepts either route for a real submission. The precheck passing is necessary, not sufficient.
- Silicon.

## Cost

| | A1 | A2 | B |
|---|---|---|---|
| Attempts | 2 of 4 (one lost to a port error of ours, one to the power grid; the other two not used, the failure being structural) | 2 of 4 | 3 of 4 |
| Manual steps | Macro drawn; abstract by hand | Cell drawn on the row template; abstract by script | Pin template derived by script; assembly, wires and supply by script; LVS and extraction scripts written |
| Checks that run by themselves | Stopped at the power grid | DRC, LVS with devices, precheck | Precheck |

## Files

| | |
|---|---|
| [`cell/misfit_inv.tcl`](cell/misfit_inv.tcl), [`cell/lef.py`](cell/lef.py), [`cell/build.sh`](cell/build.sh) | The cell, its abstract and its control variants |
| [`cell/misfit_inv_m4.tcl`](cell/misfit_inv_m4.tcl) | The macro of arm A1 |
| [`a1/`](a1/), [`a2/`](a2/) | Sources and configuration of each arm |
| [`b/`](b/) | Arm B: the core, its pin template, the assembly generator, the LVS script, the reference top level |
| [`setup_arm.sh`](setup_arm.sh) | Builds a run folder in the local bench and hardens it |
| [`sim/`](sim/) | Simulation of a tile as extracted from its final GDS |
| [`results/`](results/) | LVS reports, extracted netlists, precheck result, simulation output |

The run folders themselves are in the local bench (`local_flow/misfit01_*`), outside this repository.

## Next

1. Phase 2 of the pre-registration: a cell whose response is a time, read through the instrument's counter, with its own
   prediction written first. XC-19 is not redrawn before that.
2. A double-height row cell (5.44 µm), to see how far the row route stretches.
3. Wire resistance in the extraction.
