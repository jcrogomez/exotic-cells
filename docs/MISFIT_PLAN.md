# MISFIT: build plan for the first tile

What goes on the first MISFIT tile, how the area is found, and every test that stands between today and a tapeout request.
Written 2026-11-25. **This is a proposal, not a frozen design: the [decisions](#decisions) in it were taken by delegation
and Juan can overturn them.** Everything quoted here is simulation, layout checks or arithmetic. Nothing has been fabricated.

This page is the plan for one chip. The project-wide to-do list is the [roadmap](ROADMAP.md); why each family ranks where it
does is in the [ranking](RANKING.md); every headline number and its file is in [CLAIMS](CLAIMS.md).

## The plan in six lines

1. **Two readers, up to 64 seats each.** One reader for picoamp currents (exists, drawn), one wide-range reader (schematic
   only, now in two ranges). A generated, extracted matrix of 64 identical devices read by the small reader stays inside the cuts
   in four corners ([MISFIT-11](../experiments/misfit11/RESULTADOS.md)). Silicon area, not the reader, is what limits the seat count.
2. **Fill the seats with the exotic cells, not only with metrology.** Single traps, a tunnel junction, plasma-written gates,
   an unimplanted contact, next to the metrology that guarantees data.
3. **Find area in three dimensions:** above the digital core (metal-only structures), inside its filler space (row-shaped
   cells), and by putting the core on a diet.
4. **One hazardous cell, used last:** a fuse, blown at the end of the chip's life.
5. **Every cell that takes silicon has a pre-registration first** (gate 3 of the [pipeline](PIPELINE.md#gates-before-tapeout)).
6. **Filter at the end.** Nothing is dropped from this plan until a test listed below kills it.

## What "value" means here

**The value is a new design space.** A process is sold as a set of rules and the devices that live inside them. Everything
else is treated as failure, and in a closed industry nobody maps it: the foundry disclaims it and a paying customer cannot
afford to try. But between "what standard cells do" and "what fails" there is a third region of behaviours that are physical,
repeatable and usable ([MOTIVATION](MOTIVATION.md)). **This tile is worth building to the extent that it opens that region:**
where its borders are, which configurations cross them, and which cells come back as primitives someone else can design with.
Direction given by Juan (2026-11-25: "abrir otro espacio de configuraciones exóticos"); the wording is the agent's and waits
for his correction.

What that asks of the tile:

- **Configurations, not single devices.** A border is found by sweeping across it (geometry, material, formation history,
  excitation, environment). A family earns several seats along the parameter that crosses the regions, listed per family in
  [EXPERIMENTOS](EXPERIMENTOS.md).
- **More seats than 48.** Run ([night of 2026-11-25](../experiments/noche_1125/RESULTADOS.md)): 64 identical branches on the small reader add 15–16 % to the
  reading time and shrink the trap step by at most 2.2 % (hot slow corner); 128 add 29–32 % and shrink it by 4.3 %. No wiring
  in that run. Hierarchical selection would cut both. What is left of test **R6** is below.
- **Each cell returns with a contract** when it works: model, interface, limits, spread, failure modes.

**The by-product is also valuable.** Getting there means measuring things the industry keeps closed, and publishing them:
layout, method, raw data and licence. The table is the agent's reading of that. The industry column is general knowledge written from memory, **not yet sourced**: it goes to
the [research agenda](RESEARCH_AGENDA.md) before it is quoted anywhere else.

| What the industry keeps closed | What this tile would publish | Cells |
|---|---|---|
| **Process-monitor and test-chip data.** Foundries measure every lot with test structures and expensive bench instruments; the structures and the numbers stay inside | An open test vehicle whose instrument is on the chip and needs only digital pins: anyone can repeat the measurement on their own tile | both readers, the calibration seats |
| **Reliability characterisation.** Trap generation under bias and temperature, single-trap noise statistics, plasma (antenna) damage, electromigration: qualification data, confidential | Open reliability numbers for SKY130 at 1.8 V, with the stress and the structures drawn | XC-19, XC-52 stage 0, XC-14, XC-01 |
| **Layout-dependent effects in the models.** Foundry kits model stress and proximity; the open flow drops part of it on extraction | Silicon against model for stress and proximity, and the fix upstream | XC-12, XC-62 |
| **Mismatch and noise data** that analog designers need and usually get only under NDA | Device-to-device spread of weak-inversion current and of sampled noise, per geometry | XC-19 fan, XC-58 |
| **Licensed memory and security IP.** One-time-programmable fuses, single-poly non-volatile cells, chip identity, random-number sources | Open candidates for each, with measured behaviour instead of a datasheet | XC-01 (fuse), XC-14 (stored charge), XC-19 and XC-58 (randomness, identity) |
| **Devices sold as extra process options** (extra masks, extra cost) | The same function from standard layers, if it exists: a rectifying contact, a tunnel junction | XC-63, XC-20 |
| **The method itself.** How a test chip is checked before tapeout is tribal knowledge | Pre-registered predictions, sabotage campaigns and their failures, all in the repository | every test below |

The **Return** column in the cast keeps a one-letter shorthand for the kind of deliverable: **P** an open primitive (a device
or IP block), **N** an open number about the process, **R** a model residual that can go upstream, **I** an open instrument.
A null result counts when the calibration was seen and the cell was not: an upper bound is a number too.

## The chip in one picture

Drawn when the target was a 1×2 tile; **the target is now 1×1** (161.00 × 111.52 µm): same blocks, the readers shrunk to fit a
24.5 µm strip, and the metal-only structures on metal 4 above the core. To be redrawn when the first matrix exists. Digital pins only.

```
 y=225.76 ┌──────────────────────────────────────────────────────────────────┐
          │  DIGITAL CORE  (161 × 87 µm today)                               │
          │  counters · sequencing · decoder · registers                     │
          │  ░ in its filler space: row-shaped exotic cells        (test B2) │
          │  ▒ above it, metal only: antennas, coil                (test B1) │
          ├──────────────────────────────────────────────────────────────────┤
          │ ┌────────────────────┐ ┌───────────────┐ ┌─────────────────────┐ │
          │ │ READER 1a (exists) │ │ READER 1b     │ │ READER 2            │ │
          │ │ pA, weak inversion │ │ same design,  │ │ wide range,         │ │
          │ │ twins A/B, ladder  │ │ shares the    │ │ oscillator,         │ │
          │ │ 58 × 96 µm         │ │ bias filter   │ │ 100 pA – 1 µA+      │ │
          │ │ 16 seats:          │ │ 16 seats:     │ │ 16 seats:           │ │
          │ │ single traps       │ │ metrology +   │ │ tunnel junction,    │ │
          │ │ (geometry fan)     │ │ plasma gates  │ │ contact, poly, DCIV │ │
          │ └────────────────────┘ └───────────────┘ └─────────────────────┘ │
          │  FUSE (hazard zone, own enable, used last)                       │
 y=0      └──────────────────────────────────────────────────────────────────┘
```

## Area budget

The target is one tile (1×1), decided 2026-11-25. Two floors: silicon in the strip beside the core, and metal 4 above the core.
"Raw" ignores routing, keep-outs and density rules.

| Item | Area (µm²) | Source |
|---|---|---|
| Tile 1×1 | 17 955 | `tile_sizes.yaml` (161.00 × 111.52) |
| Digital core block | 14 013 | 161.00 × 87.04; the MISFIT-04 core |
| **Silicon strip left** | **3 941** (161 × 24.48 µm) | subtraction |
| One small reader (drawn, `v_f3`) | 1 204 (58.2 × 20.7 µm) | [MISFIT-09](../experiments/misfit09/RESULTADOS.md) |
| Strip left after two readers | 1 533 | arithmetic; nothing is placed |
| **Second floor:** metal 4 above the core | **11 856**, raw (80 µm high, five lanes between power stripes) | [MISFIT-06](../experiments/misfit06/RESULTADOS.md) |
| Area of one device seat (device, switch, buses, taps) | **4.77** for a minimum transistor, 20.6 for the long-diffusion table | generated and checked, [MISFIT-11](../experiments/misfit11/RESULTADOS.md); select lines beyond the matrix edge not included |
| One 64-seat matrix, one side | 305 (71.2 × 4.29 µm) | same |
| Wide-range reader | `[?]` | schematic only, two precharges; test R2 |

**What this says, plainly.** Silicon is the scarce floor: after two readers, about 1 500 µm² are left for every matrix and for
the second reader's own parts. Transistor-sized devices are small, so that may be enough for a few dozen seats, but the number is
not known. Metal is the plentiful floor: antennas, a coil and metal rule walks have eight times that area.

**Update 2026-11-26: the grown core does not fit.** With a second reader and seat selection the core fails placement in its 32 rows in all three variants tried ([MISFIT-13](../experiments/misfit13/RESULTADOS.md)). How many rows it needs is not measured: by decision 9 the cells come first and the tile count is settled last.

**The core will not give much back.** Its block is already close to full where it matters: at 28 rows instead of 32 the placer
sees 94 % occupation and fails ([MISFIT-10](../experiments/misfit10/), first run; the fine grid is in its amendment). And the core
has to *grow*: selection for more seats, a second reader and the stress mode are not in it yet. If it outgrows 32 rows, the strip
shrinks and the options are fewer seats or a 1×2 tile.

## The digital core on a diet

Where the core's 12 687 µm² of cells go (`local_flow/misfit04_core/runs/core/final/metrics.json`):

| Part | Area (µm²) | Share |
|---|---|---|
| Combinational logic | 4 599 | 36 % |
| 142 flip-flops | 3 731 | 29 % |
| Timing-repair buffers (122 of them fix hold) | 1 958 | 15 % |
| Filler | 1 708 | 13 % |
| Clock tree and taps | 571 | 5 % |
| Other (buffers, inverters, antenna cells) | 120 | 1 % |

Four options, mildest first. None has been run.

| # | Option | What it frees | What it risks | Test |
|---|---|---|---|---|
| 1 | **Live in the filler.** Hand-drawn cells shaped like a standard-cell row, placed by the digital flow (route proven by [MISFIT-01](../instrument/misfit01/README.md)) | up to 1 708 µm², free | filler may be scattered in slivers | B2 |
| 2 | **Build above.** Cap core routing at metal 3; metal-only structures go on metal 4 over the logic | up to the core's footprint, for antennas and a coil | digital switching couples into whatever sits above | B1, B4 |
| 3 | **One counter instead of three.** Today: a 24-bit timer and two 24-bit captures (72 of 142 flip-flops). Capture one count and a short difference | roughly 30–40 flip-flops `[?]` | changes verified RTL: all 13 cocotb tests and the MISFIT-04 checks rerun | B3 |
| 4 | **Let the host count.** Each cell oscillates (as reader 2 does) and a pin carries a frequency | most of the core | loses the same-window twin read that cancels supply noise; pin bandwidth unknown `[?]` | not planned for this tile |

Options 1 and 2 add space without touching verified logic, so they are tried first. Option 4 is recorded, not pursued.

## The cast

Nicknames are for orientation; the identifier is the catalogue's. **Return** uses the letters above. Seat counts are a first
allocation and move freely until layout.

### Reader 1a · single charges (exists)

| Seats | Cell | What silicon would show | Return | State | Next test |
|---|---|---|---|---|---|
| 10 | **XC-19** single trap, geometry fan C0–C9 ("the electron hunter") | Two-level switching of one captured electron: 0.80 % of the reading (median of 48 simulated chips) | P, N | Macro drawn, DRC/LVS clean; contract, mismatch and shot noise simulated | R1, C1 |
| 2 | Reference pair, no exotic physics | The reader works when nothing else does | I | Part of the macro | — |
| 4 | **XC-58** sampled thermal noise (kT/C) | Noise that follows 1/C: a randomness source and a femtofarad meter | P, I | Model only; ngspice and Monte Carlo disagree (0.50 vs 0.90 of kT/C) | C6 |

### Reader 1b · metrology and plasma-written gates (same design, to be drawn)

| Seats | Cell | What silicon would show | Return | State | Next test |
|---|---|---|---|---|---|
| 6 | **XC-12** diffusion-length (LOD) matrix ("the ruler") | The 31 mV the model predicts and extraction drops | R, N | Extraction gap confirmed; no layout | C2 |
| 4 | **XC-62** dense/isolated poly pairs ("the bent mirror") | What the foundry's optical correction leaves behind | R, N | Legal; optical model does not converge to the nanometre | C2 |
| 6 | **XC-14** antenna-charged floating gates, thin and thick oxide, with diode twins ("factory tattoo") | A threshold set by the plasma at fabrication, read at first power-up | P, N | No pre-registration; antennas would sit above the core | C3, B1 |

Kelvin strips are **not** in this allocation (Juan, 2026-11-25, proposed swapping them for XC-14). Consequence, stated once:
the silicide answer stays a third-party statement ([OPEN_QUESTIONS](OPEN_QUESTIONS.md) A1) with no in-silicon check, against
his note of 2026-11-16 to keep them until a time readout was shown to answer it. His call.

### Reader 2 · wide range (schematic only)

| Seats | Cell | What silicon would show | Return | State | Next test |
|---|---|---|---|---|---|
| 5 | **XC-20** p+ touching n+, at 0, 0.27, 0.54, 1.08 µm and a no-junction cell ("the tunnel") | Reverse current at zero gap far above the 0.27 µm cell, nearly flat with temperature | P, N | Physics verified to order; abutment passes the precheck; matrix approved 2026-11-16, macro not frozen | R2, C4 |
| — | XC-20 variants found by the rule walk | The same abutted junction is legal in four forms: p+/n+ in a well, n+/p+ in substrate, and both with high-voltage diffusions | P, N | Found 2026-11-25 by enumeration ([XC-64 hunts](../experiments/xc64_hunt/RESULTADOS.md)); not drawn | C4 |
| 3 | **XC-63** contact on unimplanted silicon | A contact that rectifies: a Schottky diode from standard layers | P | Verified that the PDK ships seven such cells; no cell of ours | C5 |
| 3 | **XC-39** polysilicon resistor heating itself | Resistance drift with its own power | N | Coefficient read from the model card | C5 |
| 3 | **XC-52 stage 0** gated-diode (DCIV) trap count before and after on-chip stress ("the ghost's first step") | Whether 1.8 V stress creates interface traps at all | N | Design note; the spin cell itself leans dead until this is known | C7 |
| 2 | Known calibration currents | The reader's own linearity | I | Part of the reader | R2 |

### Outside the readers

| Cell | Where | Return | State | Next test |
|---|---|---|---|---|
| **XC-01 → XC-05** fuse ("the kamikaze") | Hazard zone, own enable, blown last | P (a fuse) or P (a few-channel contact) | Layout most advanced (DRC 0, LVS); ~8 mA per tile is acceptable (third party, A7) | C8 |
| **XC-56** microcoil | Above the core | I | 0.373 mT/mA verified; useful only if XC-52 or a magnetodiode is on board | B1 |
| Row-shaped cells in the filler | Inside the core | open | Route proven with an inverter; no exotic row cell drawn | B2 |

### Not on this tile, and why

They stay in the catalogue; another vehicle is what they need, not a better argument.

| Family | Needs |
|---|---|
| XC-21 avalanche emitter, XC-07 oxide breakdown | More than 5 V (pump XC-53, or a 3.3 V / GF180 vehicle) |
| XC-25 Hall plate | Analog pins (sub-millivolt signals) |
| XC-54, XC-30, XC-61 | A cryostat |
| XC-52 spin cell proper | Stage 0 first (on this tile) |
| XC-26 / XC-27 optical link | Substrate resistivity unknown; a pA reader seat can host a first pair if area remains |

## Three additions beyond the given cast

Added 2026-11-25 by the agent at Juan's request to add value rather than rearrange what was already listed. Each has the test
that would kill it.

### 1. The rule walk (new family, [XC-64](../cells/xc64_rule_walk/PLAN.md))

Every design rule is a border the foundry drew without saying why it is there or how much margin it has. A rule walk is one
structure repeated with a single dimension stepping on the 5 nm grid from comfortably legal, through the rule value, as far
past it as the vehicle allows, read for the electrical quantity the rule protects. It is the most direct map of the border
between "works as modelled" and everything else, and it is how XC-20 was found (p+ and n+ are legal at 0 and from 0.27 µm,
nothing in between). The generator already exists and has measured real edges ([`residual/drc_edge`](../residual/drc_edge/README.md)).
What may be *submitted* past a rule is a vehicle question, not ours to assume: a check that does not look is not permission.

### 2. A generator, not a layout

The reader macro, the tile assembly and the ten sabotaged tiles are already produced by scripts. The step that turns a chip
into a tool: **each matrix is generated from a parameter table** (family, swept dimension, range, step, replicas, twins), and
the same table produces the cells, their seats, the selection logic, the predicted reading of each seat and the keys of its
records. Someone else edits the table and gets their own exploration tile, with its checks. The tile we tape out is then the
first instance of something reusable, which is what opening a design space means in practice.

### 3. A time axis, and many dies

- **Time.** Any seat can be stressed in place (gate held at 1.8 V, optional heater) and read again, so each configuration has
  a history: fresh, after stress, after rest. Ageing (XC-10, today an instrument with no design) becomes a mode of the
  instrument instead of a separate cell. A border that moves with stress is a different finding from one that does not.
- **Dies.** An open host program runs the whole campaign from the digital pins and writes one record per reading in the atlas
  format already drafted ([`misfit_arquitectura/DECISION.md`](../experiments/misfit_arquitectura/DECISION.md) §5). If every
  chip of a shuttle carries every project and anyone holding one can select ours (from memory, **to verify**:
  [OPEN_QUESTIONS](OPEN_QUESTIONS.md) Q7), then the statistics that single traps and plasma charge need come from many owners
  running the same program, not from one bench.

## The tests

The same information seen by block of the chip (done, missing, impossible before silicon) is kept in
[`PRUEBAS_POR_BLOQUE.md`](../experiments/misfit_arquitectura/PRUEBAS_POR_BLOQUE.md) (Spanish).

Each row becomes a pre-registration in [`cells/preregistros/`](../cells/preregistros/README.md) before anything is run:
prediction, control, a mutant the test must catch, a witness where the effect really occurs, and what kills it. "Dies if" below
is the sketch, not the frozen criterion.

### Done

| Test | Question | Verdict | Report |
|---|---|---|---|
| MISFIT-01 | Can a hand-drawn device pass Tiny Tapeout's checks? | Yes by two routes; the macro-inside-the-flow route fails at the power grid, as predicted | [`instrument/misfit01`](../instrument/misfit01/README.md) |
| MISFIT-02 | Does the counter read a drawn cell of known time? | Six of seven predictions held | [`instrument/misfit02`](../instrument/misfit02/README.md) |
| MISFIT-03 | Does the extracted reader 1a meet its contract in four corners, with mismatch and noise? | Contract and shot noise met; trap step seen in all 47 simulated chips that completed (of 48); three mismatch predictions false (mismatch ~2.5× the model) | [`xc19_slot_e2`](../experiments/xc19_slot_e2/INFORME_enmienda2.md) |
| MISFIT-04 | Does reader 1a survive integration in the tile, and do the checks catch sabotage? | DRC, LVS, precheck clean; real aggressors 5–7× under threshold (10× was the bet: false); one sabotage invisible to standard checks, caught by a new LVS variant; coupling sensitivity 113.7 aF from 39 of 40 phases (one phase could not be simulated; [closing amendment](../cells/preregistros/MISFIT-04_2026-11-25_tile_integrado_enmienda4.md)) | [`misfit04`](../experiments/misfit04/RESULTADOS.md), [`e2.txt`](../experiments/misfit04/e2/e2.txt) |
| MISFIT-05 | Can one reader carry 16 devices? | Yes in four corners: 15 open branches leak ≤ 0.54 % of the device current; each branch adds 0.23–0.25 % of time; no wiring or mismatch in the model | [`misfit05`](../experiments/misfit05/RESULTADOS.md) |
| MISFIT-06 | Is the metal 4 above the digital core free for exotic structures? | Capping all routing at metal 3 fails (34 minimum-area errors under the metal-4 pins). Blocking metal 4 over the core except the pin band closes clean: **11 856 µm² of metal 4 reserved, raw**. Leftover filler is in slivers (largest run 8.74 µm) | [`misfit06`](../experiments/misfit06/RESULTADOS.md) |
| MISFIT-07 | Does the reader need its 10 pF bias filter (85 % of its area)? | No, as far as the reading goes: with the filter removed, the trap step changes by at most 0.08 % relative and the reading by 0.011 %, even when one side takes 3–5 times longer than the other. First run invalid (badly designed witness), redone. No noise, one reader per bias | [`misfit07`](../experiments/misfit07/RESULTADOS.md) |
| MISFIT-08 | Can the core lose its shared 24-bit timer? | Yes: 13 of 13 cocotb tests, 0 mismatches against the original in 5 × 2 000 000 random cycles (a one-count mutant is caught), 24 fewer flip-flops, **cell area −9.0 %** after place and route; one flow run per variant | [`misfit08`](../experiments/misfit08/RESULTADOS.md) |
| MISFIT-09 | Does a reader drawn with one filter row instead of eleven fit a single tile and read the same? | Yes: 58.2 × 20.7 µm (1 204 µm², was 5 570), DRC 0 in Magic and both KLayout decks, LVS match; against the full reader in four corners the reading moves ≤ 0.053 % and the trap step ≤ 0.14 % relative. Bias capacitance 0.96 pF (was 10.16) | [`misfit09`](../experiments/misfit09/RESULTADOS.md) |
| MISFIT-13 | Does the core still fit its block with seat selection and a second reader? | **No.** The present core closes clean; with a second reader decoder it fails detailed placement with 128 select lines, with 64 shared lines and even with 8 rows + 8 columns, also with the placement density left free. The edge is between 78.6 % and 83.0 % occupation at placement. One run per variant; the new RTL is not verified | [`misfit13`](../experiments/misfit13/RESULTADOS.md) |
| MISFIT-12 | Three quick tests on the generated matrices | **Unequal devices on one bus:** the layout adds under 0.1 % and the modelled diffusion-length effect is 47–64 % of the reading; one prediction false (ratio 2.28, bet 1.5–1.8). **128 seats with wiring:** inside the cuts (1.43–1.46 times, trap step −4.5 % at worst). **Reader 2, re-reading old data (exploration):** each range needs a calibration current at its low end | [`misfit12`](../experiments/misfit12/RESULTADOS.md) |
| MISFIT-11 | Can a seat matrix be generated from a table, and does the reader still read through its real wiring? | Yes for 1.8 V transistors: four tables (1, 16, 64 equal seats; 12 seats with diffusion from 0.30 to 6 µm) come out rule-clean in Magic and both KLayout decks with LVS match, no hand edits; the generated seat extracts identical to the reader's. First pass failed a latch-up rule on the long-diffusion table; the generator now places taps by distance. With the extracted 64-seat matrix on each side: +0.33 to +0.36 % of reading time per seat, 1.21–1.23 times in total, trap step −2.35 % at worst, seat position irrelevant (0.005 %) | [`misfit11`](../experiments/misfit11/RESULTADOS.md) |
| Night plan, 2026-11-25 | Four questions on the small reader and on reader 2, 159 SPICE decks, criteria sealed before the run | **Seats:** inside the cuts up to 128 branches without wiring; one of five predictions false (the step shrinks 4.3 % at 128 in the hot slow corner, predicted < 2 %). **Mismatch,** 48 chips: trap step median 0.805 % (the large reader gave 0.803 %), spread between twins 1.11 against 1.20; one chip of 48 falls 1.6 % under the bet band for the calibration step. **Shot noise** with independent seeds: 0.157 % per reading, all four predictions met. **Reader 2:** no single precharge length keeps 1 nA–10 µA within ±3 % in four corners; the pre-registered death rule applies | [`noche_1125`](../experiments/noche_1125/RESULTADOS.md) |

### B · finding area (first, because they size everything else)

| Test | Question | Dies if | Cost |
|---|---|---|---|
| **B2** row cells inside the core | Leftover filler is in slivers (MISFIT-06). Does a hand-drawn row cell **instantiated in the netlist** get placed, and pass DRC, LVS and precheck? | the flow cannot place or connect it | one flow run + MISFIT-01 checks |
| ~~**B3b** shorter core block~~ | Dead ([MISFIT-10](../experiments/misfit10/RESULTADOS.md)): the original closes at 31 rows and not at 30; the lean core closes at none of 31, 30, 29. The block stays at 32 rows and the lean core is not adopted for space | — | done |
| **B4** noise from below | With real core activity extracted under a metal-4 plate, how much couples into a reader node? | above the reader's threshold (0.0807 % at tt, as in MISFIT-04) | extraction + SPICE, method of MISFIT-04 |

### R · readers

| Test | Question | Dies if | Cost |
|---|---|---|---|
| **R1** bias trim with real switches | Do the 11 codes (0 to −155 mV, steps 16–41 mV in schematic) survive switch drop, leakage and mismatch? | a step above 50 mV in any corner, or the trap step changes shape with the code | SPICE + Monte Carlo |
| **R2** wide-range reader | Two verdicts in schematic. [First](../experiments/xc20_lector/r2/RESULTADOS.md): the short precharge (0.15 µm) fails by 16 % at 1 nA in the hot fast corner. [Second](../experiments/noche_1125/RESULTADOS.md), block A: precharges of 0.50, 1.00 and 2.00 µm each fail somewhere, so **the single-precharge reader is dead** and the reader gets two ranges. Seen in those runs, not yet a verdict: 1.00 µm holds 100 pA–1 µA within 0.9 % in four corners, 0.15 µm holds 10 nA–10 µA within 2.7 %. **Next:** a pre-registered run of the two-range reader at currents not used for calibration, with mismatch and a moved supply (the charge per cycle of the long precharge depends on the precharge strength), then layout | the two ranges do not overlap inside the band, or the low range's calibration does not survive mismatch | pre-registration, schematic, then layout |
| **R3** two front ends on one bias filter | Does reader 1b disturb reader 1a through the shared bias? | kickback above the trap step's noise floor | SPICE on extracted macros |
| **R4** unequal devices on one reader | With real LOD and XC-62 pairs (not 16 identical branches) and extracted wiring, how biased is a ratio? | bias above the effect being measured | layout + extraction |
| **R5** noise on the extracted macro | Trap step against 1/f and thermal noise with real capacitances ([RISKS](../instrument/RISKS.md) row 10) | step under 5σ after averaging | SPICE noise |
| **R6** how many seats a reader really holds | Half done ([night of 2026-11-25](../experiments/noche_1125/RESULTADOS.md), block D): 32, 64 and 128 identical branches, flat, **no wiring**, pass the three cuts in four corners; at 128 two cuts sit at 85–91 % of their limit, so the plan uses 64. **With extracted wiring** ([MISFIT-11](../experiments/misfit11/RESULTADOS.md)): 64 seats confirmed, all four predictions met. **Left:** the select lines to the core and their decoder, two-level selection, unequal devices (R4) | the selection wiring or the decoder break a cut | layout + SPICE |

### C · cells

| Test | Cell | Question | Dies if |
|---|---|---|---|
| **C1** | XC-19 fan | What distinguishes C1–C6 in a model? Today only areas are modelled | no predicted difference: the fan is redrawn as an area sweep |
| **C2** | XC-12, XC-62 | Layout of the matrix with orientation and proximity controls, read through reader 1b | effect below mismatch at the chosen replication |
| **C3** | XC-14 | For the plausible range of stored charge, does the device current fall inside reader 1b or reader 2? Does reset leave the node untouched before the first read? | current outside both ranges, or any path that biases the gate before the read |
| **C4** | XC-20 | Cells drawn for the approved matrix; expected currents inside reader 2 in four corners | current outside the reader's ranges |
| **C5** | XC-63, XC-39 | Expected current and its boring explanation (ohmic contact; reader drift) | no observable separates it from the boring explanation |
| **C6** | XC-58 | Reconcile ngspice (0.50) and Monte Carlo (0.90) of kT/C | unexplained after the audit: the seat goes back to XC-19 |
| **C7** | XC-52 stage 0 | Can the well be forward-biased by 0.2–0.4 V using digital pins only? Peak above background at 1e10–1e11 traps/cm² | no way to set the bias without an analog pin |
| **C8** | XC-01 | Papers on fuses without silicide first (Q10); then driver from the tile supply, isolation, re-reads over time | the blow current disturbs neighbours past recovery |

### G · generator, time and dies

| Test | Question | Dies if |
|---|---|---|
| ~~**G1** regenerate~~ | Done ([MISFIT-11](../experiments/misfit11/RESULTADOS.md)): the reader has one device per side, not a matrix; the generated seat extracts identical to it, and matrices of 16 and 64 come out clean with LVS match. [`generator/`](../generator/README.md) | — |
| **G2** a second table | Half done ([MISFIT-11](../experiments/misfit11/RESULTADOS.md)): a second transistor table (XC-12, diffusion 0.30–6 µm) comes out clean after one generator fix. **Left:** a second device *kind*, the XC-20 junction in its four variants, and the precheck on a tile | each family needs its own generator |
| **G3** rule walk | Three island hunts done ([report](../experiments/xc64_hunt/RESULTADOS.md)): with two-layer rectangles Magic leaves no legal island beyond the XC-20 family, which has four members (two polarities, low and high voltage); nothing past a rule passes the precheck. A fourth hunt over shapes (step, hole, bend, ring) found none legal: one rule, poly.11 "no bends in transistors", closes them all. Next: legal shapes that print differently at the rule value, and asking Tiny Tapeout whether a declared Magic violation can be accepted in a macro | a hunt over shapes also finds nothing submittable *and* no legal-side ladder has a readable quantity |
| **G4** stress in place | Stressing one seat moves its neighbours' readings by less than the trap step (supply transfer is 1.27 % per mA) | neighbours move more than that |
| **G5** host program | Run against the RTL simulation, it produces valid atlas records for every seat and flags an injected fault | records cannot be produced from the pins alone |

### T · the whole tile

| Test | Question |
|---|---|
| **T1** design for test (gate 7) | Reader self-test, readback of counters and selection, safe power-up, per-macro enables, a faulty channel excluded without losing the chip |
| **T2** integration | DRC, own LVS, precheck, and the sabotage campaign of MISFIT-04 repeated on the full tile, including the LVS variant that sees a cut ground |
| **T3** edge report (gate 6) | Every rule a custom cell sits within one grid step of |
| **T4** current budget | Tile current by state, through the tile's power switch with metal |

## Order of work

| Phase | What | Closes when |
|---|---|---|
| 0 | ~~Leftovers of MISFIT-04~~ closed 2026-11-25 with 39 of 40 phases; the rerun of phase 10 aborted and the gap is stated | done |
| 1 | **Area:** B1, B2, B3 | the `[?]` rows of the area budget are numbers |
| 2 | **Readers:** R1, R2 (pre-registration and schematic verdict), R3 | reader 2 has a verdict; reader 1 has its trim |
| 3 | **Cells on paper:** C1–C8 pre-registrations, in ranking order (XC-20, XC-19, XC-14 first); G1–G3 so the cells are generated, not drawn one by one | every seat has a pre-registration or is given away |
| 4 | **Layout:** reader 1b, reader 2, cells; R4, R5, B4 | each macro extracted against its contract |
| 5 | **Tile:** T1–T4, G4, G5, then the [gates](PIPELINE.md#gates-before-tapeout) | all seven gates |

Phases 1 and 2 can run in parallel; nothing in phase 4 starts before phase 1 gives the area.

## Decisions

Taken by the agent on 2026-11-25 because Juan delegated them ("tú decide"). He can overturn any of them; what would reverse
each one is stated. Record: `agent/brain/decisions/2026-11-25-misfit-primer-tile.md` (private notebook).

| # | Decision | Why | Reversed if |
|---|---|---|---|
| 1 | **Kelvin strips out, XC-14 in** | SKY130 is the only Tiny Tapeout window for antenna experiments; the silicide question already has a third-party answer | a time readout is shown to answer the silicide question in few seats |
| 2 | **Value = a new design space first**, closed data opened as by-product | Juan's words, 2026-11-25 | he rewords it |
| 3 | **Target one tile (1×1), with metal 4 above the core as the second floor** (Juan, 2026-11-25; replaces the agent's "design for 1×2") | a smaller tile is cheaper to repeat on more shuttles, and forces the area ideas to be real | the reader and the top candidates do not fit after tests B1b, B3 and R7 |
| 4 | **The fuse goes on the first tile**, in its own zone with its own enable, blown last | an open one-time fuse is among the most useful things this tile could return; the risk is contained by test T1 and killed by C8 | C8 shows the blow disturbs neighbours past recovery |
| 5 | **MISFIT-04 sweep:** phase 10 rerun once with two controls; phases 1 and 6 count (same settings as the valid decks, per-deck control passed); the 0.5 ns step and the per-deck control are recorded as an amendment written after the fact and labelled as such | cheapest way to close it without touching a verdict | **happened:** the rerun aborted after 2 minutes; phase 10 stays missing ([amendment 4](../cells/preregistros/MISFIT-04_2026-11-25_tile_integrado_enmienda4.md)) |
| 6 | **The rule walk, the generator and the time axis enter the plan** | they are what turns a set of cells into a map | their tests G1–G5 |
| 7 | **64 seats per reader, not 128** (2026-11-26) | the written rule allows 128, but that run has no wiring and two cuts at 85–91 % of their limit; at 64 they are under half ([report](../experiments/noche_1125/RESULTADOS.md)) | a run with extracted wiring leaves 128 with margin, or breaks 64. **Checked 2026-11-26:** 64 holds with extracted wiring ([MISFIT-11](../experiments/misfit11/RESULTADOS.md)); 128 not run |
| 8 | **Reader 2 has two ranges with two precharges** (2026-11-26) | not a choice: the pre-registered death rule of the night plan, block A | — |
| 9 | **Candidates first, area and tile count last** (Juan, 2026-11-26) | the tile size follows from what goes in; cells are designed in order of confidence and exoticness, starting with XC-20 | he says otherwise |

**Still Juan's, because it is money:** how many chips to order. The plan leans on within-die matrices and on other owners'
dies so that the answer matters less.

## How this is documented

- **One fact, one place.** A number lives in the report of the run that produced it; pages like this one link to it.
- **Per test:** a pre-registration (sealed by hash before running), a script that regenerates the result, and a
  `RESULTADOS.md` that gives the boring explanation first and each verdict in the words of the pre-registration.
- **Per cell:** its folder under [`cells/`](../cells/) with a plan; the catalogue row in the [README](../README.md#catalogue).
- **Languages:** front pages in English; reports and plans in Spanish, the working language.
- **To see the tile:** [`instrument/galois/galois.html`](../instrument/galois/galois.html), a step-by-step viewer built from
  the real layout and result files (`instrument/galois/viewer/`). It shows the MISFIT-04 tile; it is rebuilt when the tile changes.
- **When a test closes:** its row moves to *Done* here, [CLAIMS](CLAIMS.md) gets the headline number, and the
  [roadmap](ROADMAP.md) gets one line.
