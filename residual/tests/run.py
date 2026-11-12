#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Checks lod_annotate.py against layouts whose diffusion lengths are known by construction (cases.tcl)."""
import os, sys
here = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.dirname(here))
from lod_annotate import annotate

L_SHAPE = 1 / (0.5 / (0.30 + 0.075) + 0.5 / (2.00 + 0.075)) - 0.075  # two half-width strips, L = 0.15
EXPECTED = {  # cell: {instance: (sa, sb)}; sa is the left or bottom side
    "sym030": {"X0": (0.30, 0.30)},
    "sym300": {"X0": (3.00, 3.00)},
    "asym": {"X0": (0.30, 1.00)},
    "vert": {"X0": (0.50, 2.00)},
    "twofinger": {"X0": (0.40, 0.95), "X1": (0.95, 0.40)},
    "lshape": {"X0": (L_SHAPE, 0.50)},
    "pfet": {"X0": (0.30, 0.60)},
}
bad = 0
for cell, want in EXPECTED.items():
    p = os.path.join(here, "cases", cell)
    text, report = annotate(p + ".mag", p + ".ext", p + ".spice")
    got = {r[0]: (r[4], r[5]) for r in report}
    for inst, (sa, sb) in want.items():
        ok = inst in got and abs(got[inst][0] - sa) < 1e-3 and abs(got[inst][1] - sb) < 1e-3
        bad += not ok
        print(f"{'ok  ' if ok else 'FAIL'} {cell:10s} {inst} expected sa={sa:.4f} sb={sb:.4f} got {got.get(inst)}")
    open(p + ".lod.spice", "w").write(text)

# twins: two parallel devices that differ only in recorded area. The small-area one must get 0.30, the other 1.00.
p = os.path.join(here, "cases", "twins")
text, report = annotate(p + ".mag", p + ".ext", p + ".spice")
for line in text.splitlines():
    if line.startswith("X"):
        par = dict(k.split("=") for k in line.split()[6:])
        want = 0.30 if float(par["ad"]) < 0.2 else 1.00
        ok = abs(float(par["sa"]) - want) < 1e-3 and abs(float(par["sb"]) - want) < 1e-3
        bad += not ok
        print(f"{'ok  ' if ok else 'FAIL'} twins      {line.split()[0]} ad={par['ad']} expected sa=sb={want} got sa={par['sa']} sb={par['sb']}")

# Negative tests: a netlist that disagrees with its layout, or that the tool does not support, must stop it.
import tempfile
p = os.path.join(here, "cases", "asym")
original = open(p + ".spice").read()
NEGATIVE = [
    ("wrong area", original.replace("ad=0.42", "ad=0.99"), "no layout device matches"),
    ("wrong body", original.replace(" VSUBS ", " WRONG_BODY "), "no layout device matches"),
    ("wrong gate", original.replace(" a_60_n26# ", " other_gate "), "no layout device matches"),
    ("wrong width", original.replace("w=0.42", "w=0.84"), "no layout device matches"),
    ("wrong model", original.replace("nfet_01v8", "nfet_01v8_lvt"), "no layout device matches"),
    ("multiplier m", original.replace("l=0.15", "l=0.15 m=2"), "merged or multi-finger"),
    ("multiplier mult", original.replace("l=0.15", "l=0.15 mult=2"), "merged or multi-finger"),
    ("fingers nf", original.replace("l=0.15", "l=0.15 nf=2"), "merged or multi-finger"),
    ("no areas", original.replace("ad=0.42 pd=2.84 as=0.126 ps=1.44 ", ""), "no ad/pd/as/ps"),
    ("extra device", original.replace(".ends", "X9 a b c VSUBS sky130_fd_pr__nfet_01v8 ad=1 pd=1 as=1 ps=1 w=1 l=1\n.ends"),
     "no layout device matches"),
]
for name, text, expect in NEGATIVE:
    assert text != original, name
    with tempfile.NamedTemporaryFile("w", suffix=".spice", delete=False) as f:
        f.write(text)
    try:
        annotate(p + ".mag", p + ".ext", f.name)
        ok = False
    except SystemExit as e:
        ok = expect in str(e)
    os.unlink(f.name)
    bad += not ok
    print(f"{'ok  ' if ok else 'FAIL'} rejects    {name}")
print("failures:", bad)
sys.exit(bool(bad))
