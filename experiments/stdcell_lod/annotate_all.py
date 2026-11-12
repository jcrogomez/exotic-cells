#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Runs lod_annotate on every extracted cell in a directory; writes devices.csv and prints coverage and statistics."""
import glob, os, sys, statistics as st, collections
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "residual"))
from lod_annotate import annotate
work = sys.argv[1]
ok, fail, rows = 0, collections.Counter(), []
fails = []
for sp in sorted(glob.glob(os.path.join(work, "sky130_fd_sc_hd__*.spice"))):
    if sp.endswith(".lod.spice"):
        continue
    base = sp[:-6]
    cell = os.path.basename(base)
    try:
        text, report = annotate(base + ".mag", base + ".ext", sp)
    except SystemExit as e:
        msg = str(e)
        kind = ("channel direction" if "channel direction" in msg else "gate lookup" if "gates found" in msg
                else "no match" if "no layout device" in msg else "leftover" if "have no instance" in msg else "other")
        fail[kind] += 1
        fails.append((cell, msg[:110]))
        continue
    except Exception as e:
        fail[type(e).__name__] += 1
        fails.append((cell, repr(e)[:110]))
        continue
    if not report:
        fail["no transistors"] += 1
        continue
    ok += 1
    open(base + ".lod.spice", "w").write(text)
    for name, typ, w, l, sa, sb in report:
        rows.append((cell, name, typ, w, l, sa, sb))
with open("devices.csv", "w") as f:
    f.write("cell,instance,type,w_um,l_um,sa_um,sb_um\n")
    for r in rows:
        f.write("%s,%s,%s,%.3f,%.3f,%.4f,%.4f\n" % r)
total = ok + sum(fail.values())
print(f"cells: {total}  annotated: {ok}  failed: {dict(fail)}")
for typ in sorted({r[2] for r in rows}):
    v = sorted(min(r[5], r[6]) for r in rows if r[2] == typ)
    m = sorted(max(r[5], r[6]) for r in rows if r[2] == typ)
    q = lambda a, p: a[int(p * (len(a) - 1))]
    print(f"{typ:12s} n={len(v):5d}  shorter side: min {v[0]:.3f} p10 {q(v,.1):.3f} median {q(v,.5):.3f} p90 {q(v,.9):.3f} max {v[-1]:.3f}"
          f"  | longer side median {q(m,.5):.3f} max {m[-1]:.3f}  | both sides < 1.04: {sum(1 for r in rows if r[2]==typ and max(r[5],r[6])<1.04)/len(v)*100:.0f} %")
for c, m in fails[:12]:
    print("FAIL", c, m)
