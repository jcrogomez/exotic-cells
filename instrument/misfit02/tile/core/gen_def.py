#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Pin template of the stage-2 core, derived from the Tiny Tapeout 1x1 template: same x for every tile pin, die 87.04 um
high, three pins on the bottom edge (metal 2) placed exactly above the risers of the time cell at origin x = OX.
Usage: gen_def.py <tt_block_1x1_pg.def> <out.def>"""
import sys
H, OX = 87040, 30.0          # 70.72 um was tried first: 80.6 % utilisation, detailed placement failed
PINS = (("s0_pre", "OUTPUT", 2.31), ("s0_xa", "INPUT", 11.355), ("s0_xb", "INPUT", 18.715))
s = open(sys.argv[1]).read()
s = s.replace("DESIGN tt_um_template ;", "DESIGN misfit02_core ;")
s = s.replace("DIEAREA ( 0 0 ) ( 161000 111520 ) ;", f"DIEAREA ( 0 0 ) ( 161000 {H} ) ;")
assert s.count(" 111020 ) N ;") == 43
s = s.replace(" 111020 ) N ;", f" {H - 500} ) N ;")
extra = "".join(f"""    - {n} + NET {n} + DIRECTION {d} + USE SIGNAL
      + PORT
        + LAYER met2 ( -70 -500 ) ( 70 500 )
        + PLACED ( {int(round((OX + x) * 1000))} 500 ) N ;
""" for n, d, x in PINS)
s = s.replace("PINS 43 ;\n", f"PINS {43 + len(PINS)} ;\n" + extra)
s = s.replace("NETS 43 ;\n", f"NETS {43 + len(PINS)} ;\n" + "".join(f"    - {n} ( PIN {n} ) + USE SIGNAL ;\n" for n, _, _ in PINS))
open(sys.argv[2], "w").write(s)
