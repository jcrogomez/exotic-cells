# Interface contract

Version 0 (2026-11-17). A draft to be broken: nothing is frozen. The RTL and the tests follow this page; if they disagree,
that is a bug in one of the three.

## Host side (Tiny Tapeout pins)

| Pin | Direction | Use |
|---|---|---|
| `ui_in[7:0]` | in | Write data |
| `uio[3:0]` | in | Register address |
| `uio[4]` | in | Write strobe. A write happens on its rising edge (synchronised, three clocks) |
| `uio[5]` | in | Unused |
| `uio[6]` | out | `done` |
| `uio[7]` | out | `busy` |
| `uo_out[7:0]` | out | Contents of the addressed register, one clock later |
| `clk`, `rst_n` | in | Clock (tests use 50 MHz), asynchronous active-low reset |

No analog pins.

## Registers

| Addr | Name | Access | Reset | Contents |
|---|---|---|---|---|
| 0 | `ID` | r | 0x4D | Constant |
| 1 | `CTRL` | rw | 0 | bit 0 `arm`; bit 1 `dual` (A and B in the same window); bit 2 `twin` (single read of B instead of A) |
| 2 | `CHSEL` | rw | 0 | Slot 0–3; 7 = internal digital reference |
| 3 | `SRC` | rw | 0 | 0 none, 1 cell, 2 differential calibration (2 units A, 1 unit B), 3 symmetric reference (1 unit each) |
| 4 | `ENMASK` | rw | 0 | One enable bit per slot |
| 5 | `TMO` | rw | 16 | Window = 2^`TMO` clocks, clamped to 24 |
| 6 | `CMD` | w | | bit 0 start; bit 1 abort; bit 2 clear flags |
| 7 | `STATUS` | r | 0 | bit 0 busy, 1 done, 2 timeout A, 3 timeout B, 4 stuck A, 5 stuck B, 6 refused, 7 armed |
| 8–A | `COUNT_A` | r | 0 | 24 bits, low byte first |
| B–D | `COUNT_B` | r | 0 | 24 bits |
| E | `REFDLY` | rw | 16 | Internal reference delay = 16 × `REFDLY` clocks |
| F | `PREW` | rw | 3 | Precharge width = 16 × (`PREW` + 1) clocks |

Rules: configuration writes are ignored while busy, except disarming, which always takes effect. A start is refused, with the
`refused` flag and no slot activity, unless `arm` is set and the selected slot is enabled (channel 7 needs no slot).

## One acquisition

1. **Precharge:** `pre` high on the selected slot for the precharge width.
2. **Stuck check:** at the last precharge clock the slot's outputs must be low. An output that is high is flagged `stuck`
   and that side is not counted.
3. **Count:** `pre` falls; a 24-bit time base starts at 0. Each side's count is captured when its output is seen high
   (two-flop synchroniser: the count is the true time in clocks plus 2, ±1).
4. **End:** when every counted side has been captured, or the window expires (`timeout` per side, count left at 0).

Reading the result: `done` and no flag = a count. `timeout` = slower than the window (widen it) or silent. `stuck` = the
node cannot be precharged or the output is shorted high. `refused` = the request was not allowed.

## Slot (macro) side

Each slot is a macro `misfit_cell_slot` with exactly these signal ports, at digital levels:

| Port | Direction | Meaning | Required of the macro |
|---|---|---|---|
| `en` | in | Slot enabled | With `en` low the macro draws no static current beyond leakage, drives `xa` and `xb` low, and applies no stimulus to its cell |
| `pre` | in | Precharge | High: measured nodes A and B are precharged. Falling edge: the discharge starts |
| `src[1:0]` | in | Source | 0: nothing connected to the nodes. 1: the cell on A, its twin (or blank) on B. 2: differential calibration, 2 capacitor units on A and 1 on B. 3: 1 unit on both (symmetric reference). In 2 and 3 a reference discharge of known geometry replaces the cell |
| `xa`, `xb` | out | Discharged | Rise once when node A (B) has crossed the comparator threshold; low during precharge. Asynchronous to `clk` |

Supply and ground reach the macro as power pins, not as signals. How (power pins in a hardened macro, or drawn stripes) depends
on the integration route and is open.

What the core guarantees to a slot: `en`, `pre` and `src` are all low after reset and whenever the instrument is disarmed;
`pre` and `src` are non-zero only for the selected, enabled slot, only during an acquisition.

What the core assumes of a slot, and cannot check: that `en` low really makes it inert; that its outputs are valid logic
levels when enabled; that it does not disturb its neighbours through supply, substrate or wells ([`RISKS.md`](RISKS.md)).

Change of 2026-11-23 (MISFIT-03, amendment 1): `src` 2 and 3 were a calibration current and a single switched capacitor. The calibration certifies the timing chain and its differential sensitivity, not the detection of one electron charge.

## Replacing the behavioural model

[`models/misfit_cell_slot.v`](models/misfit_cell_slot.v) is the model the tests use. A physical macro replaces it with the
same port list. The claim "the macro obeys the contract" then needs its own evidence: a SPICE run of the extracted macro for
each row of the table above, with the result recorded next to the macro.
