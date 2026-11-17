#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Deck that simulates a whole tile as extracted from its final GDS (devices only, no parasitics).
Usage: tile_sim.py <extracted.spice> <out.sp> <tag>"""
import re, sys
src, out, tag = sys.argv[1:4]
text = open(src).read()
m = re.findall(r"\.subckt (tt_um_\w+) (.*?)\n(?=[^+])", text, re.S)[-1]
top, ports = m[0], m[1].replace("\n+", " ").split()
drive = {"VGND": "0", "VPWR": "vdd", "clk": "clk", "rst_n": "rstn", "ena": "vdd", "ui_in[0]": "din"}
nodes = [drive.get(p, p if p.startswith(("uo_out", "uio_o")) else "0") for p in ports]
open(out, "w").write(f"""* {tag}: tile extracted from the final GDS. clk 50 MHz; ui_in[0] toggles every 40 ns, away from the clock edge.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include {src.split('/')[-1]}
.temp 27
Vdd vdd 0 1.8
Vclk clk 0 pulse(0 1.8 10n 0.2n 0.2n 9.8n 20n)
Vrst rstn 0 pwl(0 0 25n 0 25.2n 1.8)
Vdin din 0 pulse(0 1.8 45n 0.2n 0.2n 39.8n 80n)
Xdut {' '.join(nodes)} {top}
C1 uo_out[1] 0 10f
C0 uo_out[0] 0 10f
.control
tran 50p 130n
meas tran y_reset find v(uo_out[1]) at=40n
meas tran y_after1 find v(uo_out[1]) at=68n
meas tran y_after0 find v(uo_out[1]) at=108n
meas tran q_after1 find v(uo_out[0]) at=88n
meas tran tfall trig v(clk) val=0.9 rise=3 targ v(uo_out[1]) val=0.9 fall=1
meas tran trise trig v(clk) val=0.9 rise=5 targ v(uo_out[1]) val=0.9 rise=1
echo TILE {tag} $&y_reset $&y_after1 $&y_after0 $&q_after1 $&tfall $&trise
quit
.endc
.end
""")
