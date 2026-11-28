# Reader 2 as a slot

Reader 2 (the two-range relaxation oscillator of [MISFIT-17](../../experiments/misfit17/RESULTADOS.md) to
[MISFIT-24](../../experiments/misfit24/RESULTADOS.md)) wrapped so that it obeys the slot contract of
[`INTERFACES.md`](../INTERFACES.md): ports `en`, `pre`, `src[1:0]`, `xa`, `xb`. The core reads it without changes.

| File | What it is |
|---|---|
| `reader2_slot.v` | The wrapper: run logic, a 13-bit ripple counter on the loop output, two sticky outputs |
| `reader2_loop.v` | The loop as library cells, the netlist simulated in MISFIT-24. The front end `reader2fe` is placed outside, on `x`, `prenh`, `prenl` |
| `config.json` | LibreLane configuration of the block (MISFIT-25) |
| `unit/` | The unit: floorplan and pin template of the re-placed block (`plano.py`, `config.json`), assembly with `reader2fe` (`gen_assemble.py`) and its DRC + LVS (`lvs.sh`, `top_ref.v`) (MISFIT-27) |
| `reader2_loop_model.v` | Behavioural stand-in for the loop, for tests only |
| `tb_reader2_slot.v`, `run.sh` | Functional test and its mutant (`test.txt`, `mutant.txt`) |

## How a reading works

The core raises `pre` (the loop idles, the long precharge holds the node at the supply, `xa` = `xb` = 0), then drops it
and counts clocks. The loop starts; `xa` rises after `NA` loop periods and `xb` after `NB`. The core captures both counts.

    period = (count_b − count_a) × clock period / (NB − NA)

The difference removes the first interval, which is several periods long because the node starts at the supply
(MISFIT-24), and the two-flop synchroniser delay, which is the same on both sides.

| `src` | Range | `NA` | `NB` |
|---|---|---|---|
| 0 | idle | | |
| 1 | low (long precharge), slow end | 4 | 16 |
| 2 | high (short precharge) | 256 | 4096 |
| 3 | low, fast end | 64 | 1024 |

## State

- **Observed:** the functional test passes 21 of 21 checks with the behavioural loop (Icarus Verilog 13.0); the mutant
  (wrong `NB` expected for `src` 3) fails 3 checks.
- **Placed** ([MISFIT-25](../../experiments/misfit25/RESULTADOS.md)): 53.4 × 64.1 µm, rule-clean, LVS clean, the loop cells and nets as
  written. The configuration matters: without the port-buffer switches, the do-not-touch list and design repair off, the
  flow buffers `x` and the loop and still reports a clean block.
- **Assembled** ([MISFIT-27](../../experiments/misfit27/RESULTADOS.md)): the block re-placed at 46.9 × 46.2 µm with pins by template, joined to
  `reader2fe` as `reader2_unit` (46.9 × 56.2 µm): 0 rule violations in Magic, LVS match, three LVS mutants caught.
- **Open defect** ([MISFIT-26](../../experiments/misfit26/RESULTADOS.md)): extracted with parasitics, the loop shows no hysteresis. At
  100–316 pA in fast corners the latch dwells at intermediate voltages; the counter got one extra count in one deck and the
  oscillator stopped in another. The loop in `reader2_loop.v` is the one with the defect; the fix is MISFIT-28.
- **Not done:** simulation of the assembled unit. The
  structural loop has only been simulated as a SPICE netlist (MISFIT-24), not through this Verilog. Whether the tap
  values give enough counts over the whole current range at the chip's clock is not computed here.
- The seats hang from `x`; their select lines come from the core as in MISFIT-13.

## Rules of use (simulation, [night of 2026-11-26](../../experiments/noche_1126/RESULTADOS.md))

- A reading is a ratio against calibration currents measured in the same session: without recalibrating, the period
  moves 5 to 10 % per 100 mV of supply.
- The zero is a reading with every seat open. Hot, with 63 seats, the loop oscillates on leak alone.
- Up to 64 seats per reader; the low range was checked down to 316 pA.
- In SPICE the latch can sit on its metastable point at start (three runs at 1.70 V did); decks that use this loop
  initialise `q` and `qb`. Whether silicon needs help to leave that point is not simulated.
