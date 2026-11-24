#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Magic script that assembles the MISFIT-04 stage-1 tile (1x2): the hardened core on top (its top pins are the tile's), the XC-19
slot wrapper below it (its 15 metal-2 stubs land on the core's bottom pins), supply on metal 4. The core's metal-4 straps are
extended down only to Y_STRAP, above the macro, so no supply strap crosses the measured nodes (XA's line would be covered and
XB's not). Usage: gen_assemble.py <tt_block_1x2_pg.def> <core.lef> <out.tcl> [variant]
Variants (sabotage campaign, pre-registration section 6) are applied here so every mutant comes from the same healthy script."""
import re, sys
tdef, clef, out = sys.argv[1:4]
V = sys.argv[4] if len(sys.argv) > 4 else "ok"
TOP, CY, OX, OY = "tt_um_misfit04", 138.72, 20.0, 123.845
Y_STRAP = 127.40
pins = re.findall(r"- (\S+) \+ NET \S+ \+ DIRECTION (\w+).*?PLACED \( (\d+) (\d+) \)", open(tdef).read(), re.S)
assert len(pins) == 43
lef = open(clef).read()
def straps(name):
    blk = re.search(rf"PIN {name}\b(.*?)END {name}", lef, re.S).group(1)
    return [tuple(map(float, m)) for m in re.findall(r"RECT (\S+) (\S+) (\S+) (\S+) ;", blk)]
vp, vg = straps("VPWR"), straps("VGND")
L = []
def r(layer, x0, y0, x1, y1): L.append(f"box {min(x0,x1):.3f}um {min(y0,y1):.3f}um {max(x0,x1):.3f}um {max(y0,y1):.3f}um ; paint {layer}")
def pin(name, layer, x0, y0, x1, y1, cls, use):
    L.append(f"box {x0:.3f}um {y0:.3f}um {x1:.3f}um {y1:.3f}um ; label {{{name}}} FreeSans 40 0 0 0 c {layer} ; port make ; port class {cls} ; port use {use}")
L += ["drc off", "gds readonly true", "gds rescale false", "gds read misfit04_core.gds", "gds readonly false", "gds read xc19_slot_w.gds",
      f"cellname create {TOP}", f"load {TOP}", f"box 0um {CY}um 0um {CY}um", "getcell misfit04_core"]
ox = OX + (1.0 if V == "S6shift" else 0.0)
if V == "S6":                                     # macro mirrored in x: A where B was
    L += [f"box {OX}um {OY}um {OX}um {OY}um", "getcell xc19_slot_w child 0 0", "sideways"]
else:
    L += [f"box {ox}um {OY}um {ox}um {OY}um", "getcell xc19_slot_w child 0 0"]
gx, px = 60.45, 57.15                             # VGND strap (core x 60.45) and VPWR strap (57.15) that reach down to the macro
# Tiny Tapeout's pin check wants each supply pin within 10 um of the bottom edge (precheck, first run): the pins are the straps at
# x = 96.02 (VPWR) and 99.32 (VGND), which run the full height and do not cross the slot column (x 6.4..64.6)
PX, GX = 96.02, 99.32
for x0, y0, x1, y1 in vp + vg:
    if abs(x0 - PX) < 1e-6 or abs(x0 - GX) < 1e-6: yb = 5.0          # full-height pin straps, outside the slot column
    elif abs(x0 - px) < 1e-6 or abs(x0 - gx) < 1e-6 or abs(x0 - 21.58) < 1e-6: yb = Y_STRAP
    else: yb = CY + y0
    r("metal4", x0, yb, x1, CY + y1)
# macro supply pads (wrapper: VDD m4 at local (10.5, 4.45), GND at (8.5, 4.45))
yv = OY + 4.45
if V != "S1": r("metal4", OX + 10.20, yv - 0.30, px + 1.60, yv + 0.30)           # VDD pad -> VPWR strap at 57.15
r("metal4", 21.58, yv - 0.30, OX + 8.80, yv + 0.30) if V != "S2" else None      # GND pad <- VGND strap at 21.58
r("metal4", 21.58, Y_STRAP, 23.18, yv + 0.30)
r("metal4", px, Y_STRAP, px + 1.60, yv + 0.30)
# DUMMYB (mirror track of SA2B) to VPWR: its top pad falls under the VPWR strap at 57.15..58.75; a via3 joins them
xd = OX + 31.0 + 7.175; yd = OY + 14.0 - 0.15
r("metal3", xd - 0.25, yd - 0.25, xd + 0.25, yd + 0.25); r("via3", xd - 0.16, yd - 0.16, xd + 0.16, yd + 0.16)
for name, d, x, y in pins:
    x, y = int(x) / 1000, int(y) / 1000
    r("metal4", x - 0.15, y - 0.5, x + 0.15, y + 0.5)
    pin(name, "metal4", x - 0.15, y - 0.5, x + 0.15, y + 0.5, d.lower(), "signal")
pin("VPWR", "metal4", PX, 5.0, PX + 1.60, CY + 84.56, "inout", "power")
pin("VGND", "metal4", GX, 5.0, GX + 1.60, CY + 84.56, "inout", "ground")
# --- sabotages that add geometry (S3 is removed in the wrapper copy; S4, S5, S7, S8 are drawn here)
# S3 and S4 live in the wrapper (gen_wrap.py S3 / S4), passed in through WRAPGDS
if V == "S5":     # XA shorted to GND: XA's line is metal 2 (local y -1.62..-1.32, x -3.66..19.9); metal 1 from the GND bus
    # (local -3.58..-2.68) up under it and a via1. First try (metal 1 only, no via) did not touch XA: amendment-2 witness caught it
    r("metal1", OX + 0.0, OY - 2.80, OX + 0.40, OY - 1.29)
    r("via1", OX + 0.07, OY - 1.60, OX + 0.33, OY - 1.34); r("metal2", OX + 0.02, OY - 1.65, OX + 0.38, OY - 1.29)
if V == "S7":     # clock on metal 3 over XA's line only (local x -3.66..19.9, y -1.62..-1.32)
    r("metal3", OX - 3.0, OY - 1.62, OX + 18.6, OY - 1.32)   # ends 0.41 um from the DUTA m3 track at x 19.16 (met3.2: 0.30)
    # floating in the layout (amendment 2, A4): the clock drive is applied in the I4 SPICE through the extracted coupling
if V == "S8":     # floating metal-3 plate over XA's line only
    r("metal3", OX - 3.0, OY - 1.70, OX + 18.6, OY - 1.24)
L += ["box 0um 0um 161um 225.76um", "property FIXED_BBOX [box values]", f"save {TOP}", f"gds write {TOP}.gds",
      f"lef write {TOP}.lef -pinonly", "quit -noprompt"]
open(out, "w").write("\n".join(L) + "\n")
