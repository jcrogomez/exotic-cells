#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Scientific CI, level 2: rerun a few reference simulations with the pinned PDK and judge the numbers.

    python3 tools/science_ci.py            # needs ngspice on PATH and the PDK at /pdk (decks include /pdk/...)

Each deck prints one line of results. Checks are of three kinds:
  regression  the run reproduces the committed result file within a tolerance (catches tool or PDK drift);
  positive    an effect that is put in on purpose must be seen (a one-charge step, the stress mismatch Residual annotates);
  negative    where nothing is put in, nothing may be seen (identical twins, supply common to both halves).
A run is refused before its numbers are read if ngspice exits non-zero, prints an error, or never reaches its final
"ngspice-... done" line: ngspice 44.2 exits 0 after an error inside a .control block (an invalid vector, .noise under KLU),
so the exit code alone is not enough (checked 2026-11-15). The first checks plant such failures and require the refusal.
Exits non-zero if any check fails.
"""
import os, re, shutil, subprocess, sys, tempfile

root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
REG_TOL = 0.01  # 1 %: margin for ngspice builds (image vs CI runner); the mode itself is pinned by ngspice_pdk.sh


class RunFailed(Exception):
    pass


ERROR_LINE = re.compile(r"^[ \t]*(error\b|error:)|simulation interrupted|fatal error|timestep too small|singular matrix|"
                        r"no such vector|not \(yet\) supported", re.I | re.M)


def simulate(d, deck, tag):
    """Run deck in folder d and return the numbers of its last `tag` line; RunFailed if the run is not a complete, clean one."""
    # Same wrapper as the committed runs: the PDK's spinit (ngbehavior=hsa) as .spiceinit, with SPICE_USERINIT_DIR unset so
    # ngspice reads it. References regenerated in that mode on 2026-11-14 (experiments/AUDITORIA_HSA_2026-11-13.md).
    p = subprocess.run([os.path.join(root, "tools", "ngspice_pdk.sh"), deck], cwd=d, capture_output=True, text=True)
    out, err = p.stdout, p.stderr
    why = []
    if p.returncode != 0:
        why.append(f"ngspice exited {p.returncode}")
    m = ERROR_LINE.search(out + "\n" + err)
    if m:
        why.append("error printed: " + (out + "\n" + err)[m.start():].splitlines()[0].strip()[:160])
    if not re.search(r"^ngspice-\S+ done", out, re.M):
        why.append("no final 'ngspice-... done' line")
    lines = [l for l in out.splitlines() if l.startswith(tag + " ")]
    if not lines:
        why.append(f"no {tag} line in the output")
    if why:
        raise RunFailed(f"{deck}: " + "; ".join(why) + "\n--- stdout (tail) ---\n" + out[-1500:] + "\n--- stderr (tail) ---\n" + err[-1500:])
    return [float(v) for v in lines[-1].split()[1:]]


def run(folder, deck, tag, d=None):
    d = d or os.path.join(root, folder)
    try:
        got = simulate(d, deck, tag)
    except RunFailed as e:
        sys.exit(f"{folder}/{deck}: run refused\n{e}")
    want = [float(v) for v in open(os.path.join(d, deck.replace(".sp", ".txt"))).read().split()[1:]]
    return got, want


bad = 0


def check(kind, name, ok, detail):
    global bad
    bad += not ok
    print(f"{'ok  ' if ok else 'FAIL'} {kind:10s} {name}: {detail}")


# 0. Planted run failures: each deck prints the expected line and then fails; the run must be refused, never accepted.
PLANTED = {
    "error after the line, exit code 0": "op\necho NEG 1 2 3\nlet z = v(nonexistent)\nquit",
    "noise under KLU, exit code 0": "option klu\nop\necho NEG 1 2 3\nnoise v(1) V1 dec 2 1 10\nquit",
    "quit with code 1": "op\necho NEG 1 2 3\nquit 1",
    "fatal error, no final line": "op\necho NEG 1 2 3\nsource /nonexistent/deck.sp\nquit",
}
with tempfile.TemporaryDirectory() as tmp:
    for name, body in PLANTED.items():
        open(os.path.join(tmp, "planted.sp"), "w").write(
            "* planted failure\nV1 1 0 dc 1 ac 1\nR1 1 0 1k\n.control\n" + body + "\n.endc\n.end\n")
        try:
            simulate(tmp, "planted.sp", "NEG")
            check("negative", f"planted run failure refused, {name}", False, "accepted")
        except RunFailed as e:
            check("negative", f"planted run failure refused, {name}", True, str(e).splitlines()[0][:110])
    # and a clean run of the same circuit is accepted (the refusal is not unconditional)
    open(os.path.join(tmp, "planted.sp"), "w").write("* clean\nV1 1 0 1\nR1 1 0 1k\n.control\nop\necho NEG 1 2 3\nquit\n.endc\n.end\n")
    try:
        check("positive", "clean run of the planted circuit accepted", simulate(tmp, "planted.sp", "NEG") == [1, 2, 3], "NEG 1 2 3")
    except RunFailed as e:
        check("positive", "clean run of the planted circuit accepted", False, str(e)[:200])

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
