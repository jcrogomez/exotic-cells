#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Magic script that assembles the stage-2 tile of MISFIT-02: the hardened instrument core on top (its top pins are the
tile's), the time cell below it with its three metal-2 risers under the core's three bottom pins, the supply on metal 4.
Usage: gen_assemble.py <tt_block_1x1_pg.def> <core.lef> <out.tcl> [variant]
variant: ok | nopower (the cell's supply stripe not joined: N1) | nocell (the cell left out)"""
import re, sys
tdef, clef, out = sys.argv[1:4]
variant = sys.argv[4] if len(sys.argv) > 4 else "ok"
TOP, CY, OX, OY = "tt_um_misfit02", 24.48, 30.0, 19.48
pins = re.findall(r"- (\S+) \+ NET \S+ \+ DIRECTION (\w+).*?PLACED \( (\d+) (\d+) \)", open(tdef).read(), re.S)
assert len(pins) == 43
lef = open(clef).read()
def straps(name):
    blk = re.search(rf"PIN {name}\b(.*?)END {name}", lef, re.S).group(1)
    return [tuple(map(float, m)) for m in re.findall(r"RECT (\S+) (\S+) (\S+) (\S+) ;", blk)]
vp, vg = straps("VPWR"), straps("VGND")
L = []
def r(layer, x0, y0, x1, y1): L.append(f"box {x0:.3f}um {y0:.3f}um {x1:.3f}um {y1:.3f}um ; paint {layer}")
def pin(name, layer, x0, y0, x1, y1, cls, use):
    L.append(f"box {x0:.3f}um {y0:.3f}um {x1:.3f}um {y1:.3f}um ; label {{{name}}} FreeSans 40 0 0 0 c {layer} ; port make ; port class {cls} ; port use {use}")
L += ["drc off", "gds readonly true", "gds rescale false", "gds read misfit02_core.gds", "gds readonly false", "gds read misfit_tcell.gds",
      f"cellname create {TOP}", f"load {TOP}", f"box 0um {CY}um 0um {CY}um", "getcell misfit02_core"]
# placed by its origin, not by the corner of its bounding box (the cell extends to negative x and y)
if variant != "nocell": L += [f"box {OX}um {OY}um {OX}um {OY}um", "getcell misfit_tcell child 0 0"]
for x0, y0, x1, y1 in vp + vg: r("metal4", x0, 5.0, x1, CY + y1)
# the cell's stripes (VGND at x = 5.9..7.5, VPWR at 13.0..14.6, y = -3..5.5 in the cell) joined to the tile's straps
g = max((s for s in vg if s[2] < OX + 5.9), key=lambda s: s[0])
r("metal4", g[0], OY - 3.0, OX + 7.5, OY - 1.4)
p = min((s for s in vp if s[0] > OX + 14.6), key=lambda s: s[0])
if variant != "nopower": r("metal4", OX + 13.0, OY + 3.9, p[2], OY + 5.5)
for name, d, x, y in pins:
    x, y = int(x) / 1000, int(y) / 1000
    r("metal4", x - 0.15, y - 0.5, x + 0.15, y + 0.5)
    pin(name, "metal4", x - 0.15, y - 0.5, x + 0.15, y + 0.5, d.lower(), "signal")
pin("VPWR", "metal4", vp[0][0], 5.0, vp[0][2], CY + vp[0][3], "inout", "power")
pin("VGND", "metal4", vg[0][0], 5.0, vg[0][2], CY + vg[0][3], "inout", "ground")
L += ["box 0um 0um 161um 111.52um", "property FIXED_BBOX [box values]", f"save {TOP}", f"gds write {TOP}.gds",
      f"lef write {TOP}.lef -pinonly", "quit -noprompt"]
open(out, "w").write("\n".join(L) + "\n")
print("cell VGND joined to strap at", g[0], "| VPWR to strap at", p[0])
