#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Pin template of the core of arm B, derived from the Tiny Tapeout 1x1 template: same x for every pin, die 70.72 um high,
two extra pins on the bottom edge (metal 2). Usage: gen_def.py <tt_block_1x1_pg.def> <out.def>"""
import re, sys
H = 70720
s = open(sys.argv[1]).read()
s = s.replace("DESIGN tt_um_template ;", "DESIGN misfit01_core ;")
s = s.replace("DIEAREA ( 0 0 ) ( 161000 111520 ) ;", f"DIEAREA ( 0 0 ) ( 161000 {H} ) ;")
assert s.count(" 111020 ) N ;") == 43
s = s.replace(" 111020 ) N ;", f" {H - 500} ) N ;")
extra_pins = "".join(f"""    - {n} + NET {n} + DIRECTION {d} + USE SIGNAL
      + PORT
        + LAYER met2 ( -70 -500 ) ( 70 500 )
        + PLACED ( {x} 500 ) N ;
""" for n, d, x in (("inv_a", "OUTPUT", 20010), ("inv_y", "INPUT", 30130)))
s = s.replace("PINS 43 ;\n", "PINS 45 ;\n" + extra_pins)
s = s.replace("NETS 43 ;\n", "NETS 45 ;\n    - inv_a ( PIN inv_a ) + USE SIGNAL ;\n    - inv_y ( PIN inv_y ) + USE SIGNAL ;\n")
open(sys.argv[2], "w").write(s)
