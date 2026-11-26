# Reader 2 as a slot

Reader 2 (the two-range relaxation oscillator of [MISFIT-17](../../experiments/misfit17/RESULTADOS.md) to
[MISFIT-24](../../experiments/misfit24/RESULTADOS.md)) wrapped so that it obeys the slot contract of
[`INTERFACES.md`](../INTERFACES.md): ports `en`, `pre`, `src[1:0]`, `xa`, `xb`. The core reads it without changes.

| File | What it is |
|---|---|
| `reader2_slot.v` | The wrapper: run logic, a 13-bit ripple counter on the loop output, two sticky outputs |
| `reader2_loop.v` | The loop as library cells, the netlist simulated in MISFIT-24, plus the generated front end `reader2fe` |
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
- **Not done:** synthesis, placement, and any timing check of the ripple counter at the loop's top frequency. The
  structural loop has only been simulated as a SPICE netlist (MISFIT-24), not through this Verilog. Whether the tap
  values give enough counts over the whole current range at the chip's clock is not computed here.
- The seats hang from `x`; their select lines come from the core as in MISFIT-13.
