#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Seat-matrix generator: a table of devices in, a Magic layout, an LVS reference and a seat list out.

Each seat is one nfet (1.8 V) under test with a source switch (nfet 0.84/0.15) below it, the pair used by the XC-19 reader
(cells/xc19_slot_core_a2/xc19_slot_core.tcl, cell xc19_read_s). All drains join the reader node X, all gates the bias VB, all
switch sources GND; each switch gate is its own pin SEL<k>.

    y (um)   layer     what
     W+0.30  metal 1   X bus
     0..W    diff      device under test (gate pad below it, on VB)
    -0.66    metal 1   VB bus
    -1.74    metal 1   GND bus, over the switches' sources and the substrate taps
    -1.96    diff      source switch
    -2.62    poly      switch gate pad -> via stack -> metal 2 pin SEL<k>, running down to y = -3.20

Table (JSON): {"name": ..., "tap_every": 8, "tap_max": 10.0, "seats": [{"id": "C0", "w": 0.42, "l": 0.15, "sa": 0.30, "sb": 0.30, "n": 1}, ...]}
"n" repeats a seat. Limits: one row, nfet only, w >= 0.42, sa and sb >= 0.30 (a contact fits between gate and diffusion end).

Usage: matrix.py <table.json> <out_dir> [--pitch-delta D]     (D shrinks the seat pitch; used only to prove the DRC looks)
Writes <name>.tcl, <name>_ref.spice, <name>_seats.csv. Run the .tcl in Magic with the sky130A rc file (see run.sh).
"""
import json, os, sys

GAP = 0.27          # diffusion to diffusion, diffusion to tap
SW_W, SW_L = 0.84, 0.15
TAP = 0.42


def q(v):
    return f"{round(v / 0.005) * 0.005:.3f}"


class Tcl:
    def __init__(self): self.l = []
    def r(self, layer, x0, y0, x1, y1): self.l.append(f"r {layer} {q(x0)} {q(y0)} {q(x1)} {q(y1)}")
    def pin(self, name, layer, x0, y0, x1, y1): self.l.append(f"pin {name} {layer} {q(x0)} {q(y0)} {q(x1)} {q(y1)}")


def expand(table):
    seats = []
    for s in table["seats"]:
        for k in range(int(s.get("n", 1))):
            d = dict(w=float(s["w"]), l=float(s["l"]), sa=float(s.get("sa", 0.30)), sb=float(s.get("sb", 0.30)))
            assert d["w"] >= 0.42 and d["l"] >= 0.15 and d["sa"] >= 0.30 and d["sb"] >= 0.30, s
            d["id"] = s["id"] if int(s.get("n", 1)) == 1 else f"{s['id']}_{k}"
            seats.append(d)
    return seats


def build(table, pitch_delta=0.0):
    name = table["name"]; seats = expand(table); every = int(table.get("tap_every", 8)); tap_max = float(table.get("tap_max", 10.0))
    wmax = max(s["w"] for s in seats)
    yx0 = wmax + 0.30; yx1 = yx0 + 0.37                     # X bus
    t = Tcl(); x = 0.0; rows = []

    def tap(x):
        t.r("psubdiff", x, -1.75, x + TAP, -1.33)
        t.r("psubdiffcont", x + 0.125, -1.69, x + 0.295, -1.39)
        t.r("locali", x + 0.125, -1.77, x + 0.295, -1.31)
        t.r("viali", x + 0.125, -1.625, x + 0.295, -1.455)
        return x + TAP + GAP

    x = tap(x); last_tap = x - GAP; last_k = 0
    for k, s in enumerate(seats):
        w, l, sa, sb = s["w"], s["l"], s["sa"], s["sb"]; xe = sa + l + sb; ws = max(xe, 0.75, sa + max(l, 0.34))
        # a substrate tap by count, or when this seat's diffusion would end farther than tap_max from the last tap (rule LU.2: 15 um)
        if k and (k - last_k >= every or x + ws - last_tap > tap_max): x = tap(x); last_tap = x - GAP; last_k = k
        X = lambda v: x + v
        # device under test
        t.r("ndiff", X(0), 0, X(xe), w)
        t.r("poly", X(sa), -0.29, X(sa + l), w + 0.13)
        t.r("ndiffc", X(0.04), 0.06, X(0.21), w - 0.06)
        t.r("ndiffc", X(xe - 0.21), 0.06, X(xe - 0.04), w - 0.06)
        t.r("poly", X(sa), -0.62, X(sa + max(l, 0.34)), -0.29)
        t.r("polycont", X(sa + 0.09), -0.54, X(sa + 0.26), -0.37)
        t.r("locali", X(sa + 0.09), -0.62, X(sa + 0.26), -0.29)
        t.r("viali", X(sa + 0.09), -0.60, X(sa + 0.26), -0.43)                      # gate -> VB bus
        # source strap down to the switch drain; drain strap up to the X bus
        t.r("locali", X(0.04), -1.98, X(0.21), w + 0.02)
        t.r("locali", X(xe - 0.21), -0.02, X(xe - 0.04), yx0 + 0.33)
        t.r("viali", X(xe - 0.21), yx0 + 0.10, X(xe - 0.04), yx0 + 0.27)
        # source switch
        t.r("ndiff", X(0), -1.96, X(0.75), -1.12)
        t.r("poly", X(0.30), -2.09, X(0.45), -0.99)
        t.r("ndiffc", X(0.04), -1.90, X(0.21), -1.18)
        t.r("ndiffc", X(0.54), -1.90, X(0.71), -1.18)
        t.r("locali", X(0.54), -1.98, X(0.71), -1.10)
        t.r("viali", X(0.54), -1.625, X(0.71), -1.455)                              # source -> GND bus
        t.r("poly", X(0.30), -2.62, X(0.64), -2.09)
        t.r("polycont", X(0.39), -2.54, X(0.56), -2.37)
        t.r("locali", X(0.39), -2.62, X(0.56), -2.29)
        t.r("viali", X(0.39), -2.54, X(0.56), -2.37)
        cx, cy = X(0.475), -2.455
        t.r("metal1", cx - 0.20, cy - 0.20, cx + 0.20, cy + 0.20)
        t.r("via1", cx - 0.13, cy - 0.13, cx + 0.13, cy + 0.13)
        t.r("metal2", cx - 0.18, -3.20, cx + 0.18, cy + 0.18)
        t.pin(f"SEL{k}", "metal2", cx - 0.18, -3.20, cx + 0.18, -2.90)
        rows.append(dict(seat=k, id=s["id"], x=round(x, 3), w=w, l=l, sa=sa, sb=sb, sel=f"SEL{k}"))
        x += ws + GAP + pitch_delta
    x = tap(x) - GAP
    for y0, y1, n in ((yx0, yx1, "X"), (-0.66, -0.37, "VB"), (-1.74, -1.34, "GND")):
        t.r("metal1", 0, y0, x, y1); t.pin(n, "metal1", 0, y0, 0.40, y1)
    head = ["# SPDX-License-Identifier: Apache-2.0", f"# Generated by generator/matrix.py from table '{name}'. Do not edit by hand.",
            "proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }",
            "proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }",
            "drc off", f"cellname create {name} ; load {name}"]
    tail = ["box -500um -500um 500um 500um", "drc style drc(full)", "drc on ; drc check ; drc catchup", "set rules {}",
            'foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ [lrange $boxes 0 3]" }',
            f'puts "DRC {name} violations=[llength $rules]"', 'foreach x $rules { puts "   $x" }', "drc off",
            f"save {name}", f"gds write {name}.gds", "extract all", "ext2spice lvs", f"ext2spice -o {name}.lvs.spice",
            "ext2spice cthresh 0", "ext2spice rthresh infinite", f"ext2spice -o {name}.pex.spice",
            'select top cell ; puts "BBOX [box values]"', "quit -noprompt"]
    ref = [f"* Reference for LVS, generated from table '{name}'. Do not edit by hand.",
           f".subckt {name} X VB GND " + " ".join(r["sel"] for r in rows)]
    for r in rows:
        k = r["seat"]
        ref.append(f"XD{k} X VB s{k} GND sky130_fd_pr__nfet_01v8 w={r['w']:g} l={r['l']:g}")
        ref.append(f"XS{k} s{k} SEL{k} GND GND sky130_fd_pr__nfet_01v8 w={SW_W:g} l={SW_L:g}")
    ref.append(".ends")
    csv = ["seat,id,x_um,w_um,l_um,sa_um,sb_um,select"] + [f"{r['seat']},{r['id']},{r['x']},{r['w']},{r['l']},{r['sa']},{r['sb']},{r['sel']}" for r in rows]
    return name, "\n".join(head + t.l + tail) + "\n", "\n".join(ref) + "\n", "\n".join(csv) + "\n"


if __name__ == "__main__":
    a = sys.argv[1:]; pd = 0.0
    if "--pitch-delta" in a: i = a.index("--pitch-delta"); pd = -abs(float(a[i + 1])); del a[i:i + 2]
    table = json.load(open(a[0])); out = a[1]; os.makedirs(out, exist_ok=True)
    name, tcl, ref, csv = build(table, pd)
    for suf, txt in ((".tcl", tcl), ("_ref.spice", ref), ("_seats.csv", csv)): open(os.path.join(out, name + suf), "w").write(txt)
    print(f"ok {name}: {csv.count(chr(10)) - 1} seats -> {out}")
