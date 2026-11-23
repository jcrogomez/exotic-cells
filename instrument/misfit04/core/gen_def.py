#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Pin template of the MISFIT-04 core, from the Tiny Tapeout 1x2 template: same x for every tile pin, die 87.04 um high, placed
at the top of the 1x2 (y = 138.72), and 15 pins on its bottom edge (metal 2), each above the metal-3 track that the slot
wrapper (cells/xc19_slot_core/../misfit04 wrapper) brings up from the macro. Track x in tile coordinates = OX + x_local.
Usage: gen_def.py <tt_block_1x2_pg.def> <out.def>"""
import sys
H, OX = 87040, 20.0
# x_local: metal-3 track of each macro pin in the macro's own coordinates (see the wrapper generator)
PINS = (("s0_xa", "INPUT", -9.225), ("s0_sa2b", "OUTPUT", -7.175), ("s0_sa1b", "OUTPUT", -5.775), ("s0_refa", "OUTPUT", -5.075),
        ("s0_sa0b", "OUTPUT", -4.375), ("s0_c1", "OUTPUT", 3.335), ("s0_vbias", "OUTPUT", 5.735), ("s0_duta", "OUTPUT", 19.16),
        ("s0_prea", "OUTPUT", 20.05), ("s0_dutb", "OUTPUT", 22.16), ("s0_preb", "OUTPUT", 23.05), ("s0_sb0b", "OUTPUT", 35.375),
        ("s0_refb", "OUTPUT", 36.075), ("s0_sb1b", "OUTPUT", 36.775), ("s0_xb", "INPUT", 40.225))
s = open(sys.argv[1]).read()
s = s.replace("DESIGN tt_um_template ;", "DESIGN misfit04_core ;")
s = s.replace("DIEAREA ( 0 0 ) ( 161000 225760 ) ;", f"DIEAREA ( 0 0 ) ( 161000 {H} ) ;")
assert s.count(" 225260 ) N ;") == 43
s = s.replace(" 225260 ) N ;", f" {H - 500} ) N ;")
extra = "".join(f"""    - {n} + NET {n} + DIRECTION {d} + USE SIGNAL
      + PORT
        + LAYER met2 ( -70 -500 ) ( 70 500 )
        + PLACED ( {int(round((OX + x) * 1000))} 500 ) N ;
""" for n, d, x in PINS)
s = s.replace("PINS 43 ;\n", f"PINS {43 + len(PINS)} ;\n" + extra)
s = s.replace("NETS 43 ;\n", f"NETS {43 + len(PINS)} ;\n" + "".join(f"    - {n} ( PIN {n} ) + USE SIGNAL ;\n" for n, _, _ in PINS))
open(sys.argv[2], "w").write(s)
