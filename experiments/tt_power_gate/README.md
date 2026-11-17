# Tile power switch: how much does the supply move per mA?

Run on 2026-11-17 11:52 EST. **Simulation of the switch transistor alone; no metal, no silicon.** It closes part of A7
([OPEN_QUESTIONS](../../docs/OPEN_QUESTIONS.md)): the Tiny Tapeout pages state no on-resistance for the tile power switches.

Source of the sizes: `TinyTapeout/tt-multiplexer`, commit `885086c`, `pg/sky130/tt_pg_1v8_*/xschem/*.sch` (design and layout
by Sylvain Munaut, after Harald Pretl's `iic-jku/sky130_power_gate`). Read from the schematics:

- The switch is one PMOS between `VPWR` and the gated rail `GPWR`; ground is not switched.
- `hp` variants use `pfet_01v8`, `ll` variants `pfet_01v8_hvt`; L = 0.15 um; W = 1769 um (`_1`), 3683 um (`_2`),
  8424.5 um (`_4`).
- When off, a stack of NFETs discharges `GPWR`. Each gate carries MIM capacitors on `VPWR` and `GPWR`.
- The 3.3 V gate (`tt_pg_3v3_2`) is a `pfet_g5v0d10v5`, W = 3151 um, L = 0.5 um, behind a level shifter. Not simulated here.

## Prediction (written before the run)

`hp_1` at tt: 1.1 to 1.7 ohm, so 9 to 14 mV at 8 mA. The prediction was stated in the working session before the first
run, not in a committed file. That first run (scratch) had a printing error, and its `ss` and `ff` decks did not apply the
temperature. This folder is the corrected rerun.

## Result (`drops.txt`)

Drop across the transistor, gate at 0 V, 1.8 V supply, ngspice 44.2, PDK models of the `hpretl/iic-osic-tools:2025.07` image:

| Corner, temperature | Variant | 1 mA | 8 mA | 20 mA |
|---|---|---|---|---|
| tt, 27 C | `hp_1` | 1.59 mV | 12.80 mV | 32.45 mV |
| tt, 27 C | `hp_2` | 0.76 mV | 6.12 mV | 15.40 mV |
| tt, 27 C | `hp_4` | 0.33 mV | 2.67 mV | 6.69 mV |
| tt, 27 C | `ll_1` | 1.85 mV | 14.95 mV | 38.06 mV |
| ss, 85 C | `hp_1` | 2.03 mV | 16.39 mV | 41.75 mV |
| ss, 85 C | `ll_1` | 2.36 mV | 19.17 mV | 49.08 mV |
| ff, -40 C | `hp_1` | 1.20 mV | 9.66 mV | 24.43 mV |

`hp_1` at tt is 1.59 ohm: inside the predicted interval.

## What it means, by grade

- **Run:** the transistor of the smallest gate accounts for 32 mV of drop at 20 mA. The analog specification says about
  0.1 V at 20 mA through the power network, so the transistor would be about a third of it. The rest (metal, contacts, the
  network outside the tile, or margin in the stated figure) is not resolved here.
- **Superseded the same day** by a run with the transfer function
  ([`supply_transfer`](../supply_transfer/README.md): +1.27 % per mA for one side behind `ll_1`; a twin read in the same window
  cancels it only when both sides take the same time). The two items below are kept as first written.
- **Arithmetic:** the XC-19 reader stage moves 0.53 % per mV of supply ([CLAIMS](../../docs/CLAIMS.md)). With 1.59 mV per mA,
  each mA of change in tile current moves a reading by about 0.84 % (0.18 % with `hp_4`). One trap is a step of about 0.8 %.
- **Conjecture:** if that holds, "never read while a fuse, coil or heater pulses" is not enough. The tile's own digital
  activity has to be the same between readings that are compared, or the reading has to be ratiometric against a twin
  that sees the same supply. The twin results in CLAIMS (0.02 to 0.09 % for 10 mV) suggest the second route works in the
  model.

## Not known

- ~~Which variant feeds a tile.~~ Found the same day in `tt-multiplexer/py/tt/placer.py` (`'hp' if self.width > 4 else 'll'`,
  height from the tile): a 1×1 tile gets `ll_1`, a 1×2 or 2×2 gets `ll_2`. The `hp_1` figures above are therefore not the
  ones that apply to a small tile; `ll_1` (1.85 ohm at tt) and `ll_2` (0.89 ohm) are.
- The figure with layout parasitics: the upstream testbench `tb_rdson.sch` compares schematic and extracted views; not run.
- Pulse rating and electromigration limits of the switch and its metal.
- Dynamic droop: decoupling on `GPWR` was not modelled.
- The model gives almost no temperature dependence at tt (1.59 ohm at 27 C, 1.62 ohm at 85 C). Not checked against anything.

## Reproduce

`./gen.sh` writes the four decks, runs them in Docker and rebuilds `drops.txt`.
