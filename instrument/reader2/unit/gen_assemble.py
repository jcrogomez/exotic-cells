#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Magic script that assembles reader2_unit: the re-placed digital block on top, reader2fe below it with its X pin under the block's
x pin. Three metal-2 drops with a via1 onto the cell's metal-1 pads; the cell's VDD goes up a via stack to the VPWR metal-4 strap
that passes over it, its GND runs on metal 3 to a VGND strap. Coordinates come from plano.py and the block's LEF.
Usage: gen_assemble.py <reader2_slot.lef> <out.tcl> [variant]    variants (mutants for the LVS): noX, noPRENL, noVDD"""
import re, sys
import plano as P
lef, out = sys.argv[1:3]; V = sys.argv[3] if len(sys.argv) > 3 else "ok"; TOP = "reader2_unit"
t = open(lef).read()
def straps(name): return [tuple(map(float, m)) for m in re.findall(r"RECT (\S+) (\S+) (\S+) (\S+) ;", re.search(rf"PIN {name}\b(.*?)END {name}", t, re.S).group(1))]
ox, oy = P.FEO; pad = {k: (a + ox, b + oy, c + ox, d + oy) for k, (a, b, c, d) in P.FE.items()}; cy = lambda k: (pad[k][1] + pad[k][3]) / 2
L = []
def r(layer, x0, y0, x1, y1): L.append(f"box {min(x0,x1):.3f}um {min(y0,y1):.3f}um {max(x0,x1):.3f}um {max(y0,y1):.3f}um ; paint {layer}")
def sq(layer, x, y, h): r(layer, x - h, y - h, x + h, y + h)
def pin(name, layer, x0, y0, x1, y1, cls, use): L.append(f"box {x0:.3f}um {y0:.3f}um {x1:.3f}um {y1:.3f}um ; label {{{name}}} FreeSans 40 0 0 0 c {layer} ; port make ; port class {cls} ; port use {use}")
def v1(x, y): sq("via1", x, y, 0.13); sq("metal1", x, y, 0.18); r("metal2", x - 0.18, y - 0.23, x + 0.18, y + 0.23)
def v2(x, y): sq("via2", x, y, 0.14); r("metal3", x - 0.18, y - 0.35, x + 0.18, y + 0.35)
def v3(x, y): sq("via3", x, y, 0.16); sq("metal3", x, y, 0.25)
L += ["drc off", "gds readonly true", "gds rescale false", "gds read reader2_slot.gds", "gds readonly false", "gds read reader2fe.gds",
      f"cellname create {TOP}", f"load {TOP}", f"box 0um {P.YB}um 0um {P.YB}um", "getcell reader2_slot",
      f"box {ox:.3f}um {oy:.3f}um {ox:.3f}um {oy:.3f}um", "getcell reader2fe child 0 0"]
# the three drops: block pin (metal 2, bottom edge) -> via1 on the cell's pad
for net, key in (("x", "X"), ("prenl", "PRENL"), ("prenh", "PRENH")):
    x = P.S[net]; y = cy(key); a, b, c, d = pad[key]
    r("metal1", min(a, x - 0.18), b, max(c, x + 0.18), d)                 # pad widened under the via where the track is off its centre
    r("metal2", x - 0.14, y - 0.23, x + 0.14, P.YB + 0.28)
    if V != "no" + key: v1(x, y)
    else: r("metal2", x - 0.18, y - 0.23, x + 0.18, y + 0.23)
pin("x", "metal2", P.S["x"] - 0.14, P.YB - 1.0, P.S["x"] + 0.14, P.YB - 0.6, "input", "signal")
# VDD: stack on the cell's pad, left of the x drop, up to the VPWR strap above it
xv, yv = 27.25, cy("VDD"); a, b, c, d = pad["VDD"]; r("metal1", min(a, xv - 0.18), b, c, d)
vp = [s for s in straps("VPWR") if s[0] <= xv - 0.16 and xv + 0.16 <= s[2]]; assert len(vp) == 1, vp
sx0, sy0, sx1, sy1 = vp[0]; xm = min(sx1, P.S["x"] - 0.14 - 0.14); assert xm - sx0 >= 0.9, (sx0, xm)
v1(xv, yv); v2(xv, yv)
if V != "noVDD": v3(xv, yv)
else: sq("metal3", xv, yv, 0.25)
r("metal4", sx0, yv - 0.35, xm, P.YB + sy0 + 0.5); pin("VPWR", "metal4", sx0, yv - 0.35, xm, yv + 0.65, "inout", "power")
# GND: stack on the pad, metal 3 to the first VGND strap right of the cell, metal 4 up to it
xg, yg = (pad["GND"][0] + pad["GND"][2]) / 2, cy("GND"); vg = sorted(s for s in straps("VGND") if s[0] > ox + 8.88 + 0.5); assert vg, straps("VGND")
gx0, gy0, gx1, gy1 = vg[0]; xs = (gx0 + gx1) / 2
v1(xg, yg); v2(xg, yg); r("metal3", xg - 0.18, yg - 0.18, xs + 0.25, yg + 0.18); v3(xs, yg)
r("metal4", gx0, yg - 0.35, gx1, P.YB + gy0 + 0.5); pin("VGND", "metal4", gx0, yg - 0.35, gx1, yg + 0.65, "inout", "ground")
for n, x in P.N.items():
    y = P.YB + P.H; r("metal2", x - 0.14, y - 0.28, x + 0.14, y); pin(n, "metal2", x - 0.14, y - 0.28, x + 0.14, y, P.DIR[n].lower(), "signal")
L += [f"box 0um 0um {P.W}um {P.YB + P.H}um", "property FIXED_BBOX [box values]", f"save {TOP}", f"gds write {TOP}.gds", f"lef write {TOP}.lef -pinonly", "quit -noprompt"]
open(out, "w").write("\n".join(L) + "\n"); print(f"{V}: reader2fe at ({ox:.3f}, {oy:.3f}); VPWR strap x {sx0}..{sx1} used {sx0}..{xm:.3f}; VGND strap x {gx0}..{gx1}; unit {P.W} x {P.YB + P.H}")
