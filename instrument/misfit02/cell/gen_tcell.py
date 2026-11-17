#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Writes the Magic script of the MISFIT-02 time cell. Units: um.

A row of five small cells (inverter, precharge pfet, inverter, precharge pfet, inverter: the MISFIT-01 geometries) and, on
each side, a weak nfet 0.42/24 that discharges the node and a MOS capacitor 12 x 12 that loads it: one capacitor on side A
(left), two on side B (right). Ports: PRE, XA, XB on metal 2 at the top; VGND and VPWR on metal-4 stripes.
Usage: gen_tcell.py <out.tcl> [variant]     variant: ok | weak12 (weak nfet 0.42/12 instead of 0.42/24, for the N2 control)"""
import sys
out = sys.argv[1]; variant = sys.argv[2] if len(sys.argv) > 2 else "ok"
LW = 12.0 if variant == "weak12" else 24.0
L = []
def r(layer, x0, y0, x1, y1):
    x0, x1 = sorted((x0, x1)); y0, y1 = sorted((y0, y1))
    L.append(f"box {x0:.3f}um {y0:.3f}um {x1:.3f}um {y1:.3f}um ; paint {layer}")
def pin(name, layer, x0, y0, x1, y1):
    L.append(f"box {x0:.3f}um {y0:.3f}um {x1:.3f}um {y1:.3f}um ; label {name} FreeSans 40 0 0 0 c {layer} ; port make")
YTOP = 5.5
L += ["drc off", "load misfit_inv", "load misfit_pch", "cellname create tctmp", "load tctmp"]
X0, PITCH = 2.0, 3.68
cells = ["misfit_inv", "misfit_pch", "misfit_inv", "misfit_pch", "misfit_inv"]
for i, c in enumerate(cells):
    L += [f"box {X0 + i * PITCH:.3f}um 0um {X0 + i * PITCH:.3f}um 0um", f"getcell {c}"]
L += ["select top cell", "flatten -nolabels misfit_tcell", "load misfit_tcell"]
xc = [X0 + i * PITCH for i in range(5)]
def via_a(i):   r("viali", xc[i] + 0.225, 1.07, xc[i] + 0.395, 1.24)          # on the A pin of cell i
def via_y(i, y): r("viali", xc[i] + 1.91, y, xc[i] + 2.08, y + 0.17)           # on the Y strip of cell i
def riser(i, on_a):                                                           # metal-2 riser to the top from A or Y of cell i
    cx = xc[i] + (0.31 if on_a else 1.995)
    if on_a: via_a(i)
    else: via_y(i, 1.07)
    r("metal1", cx - 0.21, 0.95, cx + 0.21, 1.36)
    r("via1", cx - 0.13, 1.025, cx + 0.13, 1.285)
    r("metal2", cx - 0.17, 0.95, cx + 0.17, YTOP)
    return cx
XGA, XGB = 0.9, 21.5                                                          # origins of the two device groups
# pre_n: output of the first inverter, on the lower track, to both precharge gates and both weak gates
r("metal1", XGA - 1.45, 0.45, XGB + 1.45, 0.75)
via_y(0, 0.515)
for i in (1, 3):
    r("metal1", xc[i] + 0.16, 0.45, xc[i] + 0.46, 1.30); via_a(i)
# the two measured nodes, on the upper track: precharge drain, reading inverter, and out to the device group
r("metal1", XGA - 0.45, 1.60, xc[2] + 0.46, 1.90); via_y(1, 1.665)
r("metal1", xc[2] + 0.16, 1.00, xc[2] + 0.46, 1.90); via_a(2)
r("metal1", xc[3] + 1.85, 1.60, XGB + 0.45, 1.90); via_y(3, 1.665)
r("metal1", xc[4] + 0.16, 1.00, xc[4] + 0.46, 1.90); via_a(4)
x_pre, x_xa, x_xb = riser(0, True), riser(2, False), riser(4, False)
# supply: via stacks from the rails to two metal-4 stripes
for (xs, yc, x4) in ((6.45, 0.0, 5.9), (13.6, 2.72, 13.0)):
    for lay, g in (("via1", 0.0), ("metal2", 0.1), ("via2", 0.0), ("metal3", 0.15), ("via3", 0.0)):
        r(lay, xs - g, yc - 0.2 - g, xs + 0.4 + g, yc + 0.2 + g)
    r("metal4", x4, -3.0, x4 + 1.6, YTOP)
def group(xg, s, ncap):
    X = lambda dx: xg + s * dx
    CB = -13.25; YB0, YB1 = CB - 1.5, CB - 1.2                                # capacitor bottom; ground bus
    # weak nfet 0.42/LW, drain at dx = 0
    r("ndiff", X(0), 1.20, X(LW + 1.0), 1.62)
    r("poly", X(0.5), 1.07, X(LW + 0.5), 1.75)
    r("ndiffc", X(0.14), 1.26, X(0.31), 1.56)
    r("locali", X(0.06), -0.97, X(0.39), 1.64)                                # node: drain pad and the way down to the capacitors
    r("viali", X(0.14), 1.31, X(0.31), 1.48)
    r("metal1", X(0.0), 1.25, X(0.45), 1.90)
    r("poly", X(1.0), 0.43, X(1.5), 1.07)                                     # gate pad
    r("polycont", X(1.165), 0.515, X(1.335), 0.685)
    r("locali", X(1.085), 0.48, X(1.415), 0.72)
    r("viali", X(1.165), 0.515, X(1.335), 0.685)
    xs = LW + 0.69                                                            # source end
    r("ndiffc", X(xs), 1.26, X(xs + 0.17), 1.56)
    r("locali", X(xs - 0.08), YB0, X(xs + 0.25), 1.64)                        # source down to the ground bus
    r("psubdiff", X(LW + 1.4), 1.20, X(LW + 1.82), 1.62)
    r("psubdiffcont", X(LW + 1.525), 1.26, X(LW + 1.695), 1.56)
    r("locali", X(xs - 0.08), 1.18, X(LW + 1.78), 1.64)
    # ground: from the row's rail down the inner side to the bus, with a tap next to the drain end
    r("locali", X(-0.35), -0.085, (2.0 if s < 0 else 20.4), 0.085)
    r("locali", X(-0.65), YB0, X(-0.35), 1.55)
    r("psubdiff", X(-0.71), 0.85, X(-0.29), 1.55)
    r("psubdiffcont", X(-0.585), 1.0, X(-0.415), 1.4)
    xend = max(LW + 0.94, 13.0 * ncap + (ncap - 1))
    r("locali", X(-0.65), YB0, X(xend), YB1)
    for k in range(ncap):
        o = 14.0 * k
        r("ndiff", X(o), CB, X(o + 13.0), CB + 12.0)
        r("poly", X(o + 0.5), CB - 0.13, X(o + 12.5), CB + 12.13)
        r("poly", X(o + 6.0), CB + 12.13, X(o + 6.5), CB + 12.77)             # gate tab
        r("polycont", X(o + 6.165), CB + 12.345, X(o + 6.335), CB + 12.515)
        for c in (0.14, 12.69):
            r("ndiffc", X(o + c), CB + 0.2, X(o + c + 0.17), CB + 11.8)
            r("locali", X(o + c - 0.08), YB0, X(o + c + 0.25), CB + 11.88)
        for t in (2.8, 9.8):
            r("psubdiff", X(o + t), CB - 1.65, X(o + t + 0.42), CB - 1.05)
            r("psubdiffcont", X(o + t + 0.125), CB - 1.47, X(o + t + 0.295), CB - 1.23)
    r("locali", X(0.06), CB + 12.28, X(14.0 * (ncap - 1) + 6.5), CB + 12.58)   # node across to every capacitor gate
group(XGA, -1, 1)
group(XGB, +1, 2)
pin("PRE", "metal2", x_pre - 0.17, YTOP - 1.0, x_pre + 0.17, YTOP)
pin("XA", "metal2", x_xa - 0.17, YTOP - 1.0, x_xa + 0.17, YTOP)
pin("XB", "metal2", x_xb - 0.17, YTOP - 1.0, x_xb + 0.17, YTOP)
pin("VGND", "metal4", 5.9, -3.0, 7.5, YTOP)
pin("VPWR", "metal4", 13.0, -3.0, 14.6, YTOP)
L += ["box -40um -20um 60um 10um", "select top cell", "drc style drc(full)", "drc on", "drc check", "drc catchup", "set rules {}",
      "foreach {msg boxes} [drc listall why] { lappend rules \"$msg  @ [lrange $boxes 0 1]\" }",
      "puts \"DRC misfit_tcell violations=[llength $rules]\"", "foreach x $rules { puts \"   $x\" }", "drc off",
      "save misfit_tcell", "gds write misfit_tcell.gds", "extract all", "ext2spice lvs", "ext2spice -o misfit_tcell.spice",
      "quit -noprompt"]
open(out, "w").write("\n".join(L) + "\n")
print(f"pins: PRE x={x_pre:.3f} XA x={x_xa:.3f} XB x={x_xb:.3f}")
