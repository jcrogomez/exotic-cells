#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Writes the Magic script that assembles the tile of arm B: the hardened core on top, the hand-drawn macro below, two signal
wires on metal 2, the supply on metal 4, and the tile's pins as labels over the core's own pins.
Usage: gen_assemble.py <tt_block_1x1_pg.def> <core.lef> <out.tcl> [variant]
variant: ok (default) | nopower (the macro's supply stripe is not joined to the tile's: N1) | nomacro (the macro is left out,
its wires kept: N3)"""
import re, sys
tdef, clef, out = sys.argv[1:4]
variant = sys.argv[4] if len(sys.argv) > 4 else "ok"
TOP, CY, MX, MY = "tt_um_misfit01b", 40.8, 22.0, 12.0          # core offset in y; macro origin
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
L += ["drc off", "gds readonly true", "gds rescale false", "gds read misfit01_core.gds", "gds readonly false", "gds read misfit_inv_m4.gds", f"cellname create {TOP}", f"load {TOP}",
      f"box 0um {CY}um 0um {CY}um", "getcell misfit01_core"] + ([] if variant == "nomacro" else [f"box {MX}um {MY}um {MX}um {MY}um", "getcell misfit_inv_m4"])
# supply: every core strap continued down to y = 5 um
# and drawn at the top level over the core's own straps, so that the tile's supply pins span the tile
for x0, y0, x1, y1 in vp + vg: r("metal4", x0, 5.0, x1, CY + y1)
# the macro's stripes (VGND at x = 7.2..8.8, VPWR at 9.4..11.0 in the macro) joined to the nearest tile strap that can be
# reached on metal 4 without crossing the other net
g = min(vg, key=lambda s: abs(s[0] - (MX + 7.2)))
r("metal4", min(g[0], MX + 7.2), MY, max(g[2], MX + 8.8), MY + 1.6)
p = min((s for s in vp if s[0] > MX + 11.0), key=lambda s: s[0])
if variant != "nopower": r("metal4", MX + 9.4, MY + 7.4, p[2], MY + 9.0)
# inv_a: core pin at x = 19.94..20.08 down on metal 2, then metal 1 to the macro's A pin (macro y = 4.00..4.31)
r("metal2", 19.94, MY + 3.95, 20.08, CY + 1.0)
r("metal2", 19.84, MY + 3.95, 20.18, MY + 4.37)
r("via1", 19.88, MY + 4.03, 20.14, MY + 4.29)
r("metal1", 19.80, MY + 4.00, MX + 0.80, MY + 4.31)
# inv_y: core pin at x = 30.06..30.20 down on metal 2 to the macro's Y wire (macro y = 4.52..4.85)
r("metal2", 30.06, MY + 4.47, 30.20, CY + 1.0)
r("metal2", 29.96, MY + 4.47, 30.30, MY + 4.90)
r("via1", 30.00, MY + 4.555, 30.26, MY + 4.815)
# pins of the tile: labels over the core's own pin shapes
for name, d, x, y in pins:
    x, y = int(x) / 1000, int(y) / 1000
    r("metal4", x - 0.15, y - 0.5, x + 0.15, y + 0.5)        # top-level metal over the core pin: a label alone does not connect
    pin(name, "metal4", x - 0.15, y - 0.5, x + 0.15, y + 0.5, d.lower(), "signal")
pin("VPWR", "metal4", vp[0][0], 5.0, vp[0][2], CY + vp[0][3], "inout", "power")
pin("VGND", "metal4", vg[0][0], 5.0, vg[0][2], CY + vg[0][3], "inout", "ground")
L += ["box 0um 0um 161um 111.52um", "property FIXED_BBOX [box values]", "box -10um -10um 200um 150um",
      "select top cell", "drc style drc(full)", "drc on", "drc check", "drc catchup",
      "set rules {}", "foreach {msg boxes} [drc listall why] { lappend rules \"$msg  @ [lrange $boxes 0 2]\" }",
      f"puts \"DRC {TOP} violations=[llength $rules]\"", "foreach x $rules { puts \"   $x\" }", "drc off",
      f"save {TOP}", f"gds write {TOP}.gds", f"lef write {TOP}.lef -pinonly", "quit -noprompt"]
open(out, "w").write("\n".join(L) + "\n")
print("VPWR straps", [s[0] for s in vp], "VGND straps", [s[0] for s in vg], "macro VPWR joined to strap at", p[0], "VGND to", g[0])
