#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Scientific CI, level 2: rerun a few reference simulations with the pinned PDK and judge the numbers, not the exit codes.

    python3 tools/science_ci.py            # needs ngspice on PATH and the PDK at /pdk (decks include /pdk/...)

Each deck prints one line of results. Checks are of three kinds:
  regression  the run reproduces the committed result file within a tolerance (catches tool or PDK drift);
  positive    an effect that is put in on purpose must be seen (a one-charge step, the stress mismatch Residual annotates);
  negative    where nothing is put in, nothing may be seen (identical twins, supply common to both halves).
Exits non-zero if any check fails.
"""
import os, shutil, subprocess, sys, tempfile

root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
REG_TOL = 0.01  # 1 %: ngspice builds differ between the Docker image and the CI runner


def run(folder, deck, tag, d=None):
    d = d or os.path.join(root, folder)
    spinit, local = "/pdk/libs.tech/ngspice/spinit", os.path.join(d, ".spiceinit")
    made = os.path.exists(spinit) and not os.path.exists(local)
    if made:  # the PDK's ngspice settings (compatibility mode), as the committed runs used
        open(local, "w").write(open(spinit).read())
    try:
        out = subprocess.run(["ngspice", "-b", deck], cwd=d, capture_output=True, text=True).stdout
    finally:
        if made:
            os.unlink(local)
    lines = [l for l in out.splitlines() if l.startswith(tag + " ")]
    if not lines:
        sys.exit(f"{folder}/{deck}: no {tag} line in the output\n" + out[-2000:])
    got = [float(v) for v in lines[-1].split()[1:]]
    want = [float(v) for v in open(os.path.join(d, deck.replace(".sp", ".txt"))).read().split()[1:]]
    return got, want


bad = 0


def check(kind, name, ok, detail):
    global bad
    bad += not ok
    print(f"{'ok  ' if ok else 'FAIL'} {kind:10s} {name}: {detail}")


# 1. Readout cell, extracted and annotated (cells/xc19_read/post_layout.sp).
#    ta/tb: default chain, gate without/with a 0.305 mV step; tc/td: matched chain, same; tm: annotated cell on the default
#    chain; ts: schematic reference; vb0/wb0: bias voltages.
got, want = run("cells/xc19_read", "post_layout.sp", "POST")
for i, (g, w) in enumerate(zip(got, want)):
    check("regression", f"post_layout[{i}]", abs(g - w) <= REG_TOL * abs(w), f"{g:.6g} vs committed {w:.6g}")
ta, tb, tc, td, tm, ts, vb0, wb0 = got
for name, a, b in (("default chain", ta, tb), ("matched chain", tc, td)):
    step = (a - b) / a * 100
    check("positive", f"one-charge step, {name}", 0.75 <= step <= 0.90, f"{step:.3f} % (pre-registered 0.75-0.90 %)")
check("positive", "stress mismatch seen after annotation", tm / tc > 1.3, f"tm/tc = {tm / tc:.3f} (> 1.3)")

# Planted null: the same deck with the injected step set to zero must show no step (the checker can fail).
with tempfile.TemporaryDirectory() as tmp:
    null = os.path.join(tmp, "xc19_read")
    shutil.copytree(os.path.join(root, "cells/xc19_read"), null)
    deck = open(os.path.join(null, "post_layout.sp")).read()
    assert deck.count(" 0.305m") == 2
    open(os.path.join(null, "post_layout.sp"), "w").write(deck.replace(" 0.305m", " 0"))
    n, _ = run("cells/xc19_read", "post_layout.sp", "POST", d=null)
for name, a, b in (("default chain", n[0], n[1]), ("matched chain", n[2], n[3])):
    check("negative", f"no step put in, none seen, {name}", abs(a - b) / a < 1e-4, f"{abs(a - b) / a * 100:.4f} % (< 0.01 %)")

# 2. Complete channel, extracted and annotated (cells/xc19_channel/channel_sim.sp), at 1.80 V and 1.81 V.
got, want = run("cells/xc19_channel", "channel_sim.sp", "CHSIM")
for i, (g, w) in enumerate(zip(got, want)):
    check("regression", f"channel_sim[{i}]", abs(g - w) <= REG_TOL * abs(w), f"{g:.6g} vs committed {w:.6g}")
ta, tb, ua, ub = got
check("negative", "identical twins A and B show no step", abs(ta - tb) / ta < 1e-4, f"{abs(ta - tb) / ta:.2e} (< 1e-4)")
check("negative", "10 mV of supply cancels in A/B", abs(ta / tb - ua / ub) < 1e-5, f"{abs(ta / tb - ua / ub):.2e} (< 1e-5)")
check("positive", "one stage alone does see the supply", abs(ua - ta) / ta > 0.01, f"{abs(ua - ta) / ta * 100:.2f} % (> 1 %)")

print("failures:", bad)
sys.exit(bool(bad))
