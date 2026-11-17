#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Decks that time the cell: from PRE falling (0.9 V) to XA and XB rising (0.9 V), 10 fF on each output.
Usage: cell_sim.py <outdir>     Netlists expected in <outdir>: sch.spice (reference), dev.spice, c.spice (extractions)."""
import sys, os
out = sys.argv[1]
RUNS = [("sch", "tt", 27, 1.80), ("dev", "tt", 27, 1.80), ("c", "tt", 27, 1.80),
        ("c", "tt", 27, 1.79), ("c", "tt", 27, 1.81), ("c", "tt", 85, 1.80), ("c", "ss", 27, 1.80), ("c", "ff", 27, 1.80),
        ("c", "ss", 85, 1.80), ("c", "ff", -40, 1.80)]
for lvl, corner, temp, vdd in RUNS:
    tag = f"{lvl}_{corner}_{str(temp).replace('-', 'm')}_{int(round(vdd * 100))}"
    open(os.path.join(out, f"t_{tag}.sp"), "w").write(f"""* time cell, level {lvl}, corner {corner}, {temp} C, {vdd} V
.lib /pdk/libs.tech/ngspice/sky130.lib.spice {corner}
.include {lvl}.spice
.temp {temp}
Vdd vdd 0 {vdd}
Vpre pre 0 pulse({vdd} 0 100n 0.2n 0.2n 1 2)
Xc pre xa xb 0 vdd misfit_tcell
Ca xa 0 10f
Cb xb 0 10f
.control
tran 0.5n 6u
meas tran ta trig v(pre) val=0.9 fall=1 targ v(xa) val=0.9 rise=1
meas tran tb trig v(pre) val=0.9 fall=1 targ v(xb) val=0.9 rise=1
meas tran ra trig v(xa) val=0.18 rise=1 targ v(xa) val=1.62 rise=1
meas tran rb trig v(xb) val=0.18 rise=1 targ v(xb) val=1.62 rise=1
let ratio = tb/ta
echo CELL {lvl} {corner} {temp} {vdd} $&ta $&tb $&ratio $&ra $&rb
quit
.endc
.end
""")
