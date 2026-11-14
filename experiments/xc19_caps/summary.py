#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Cifras derivadas de post.txt y cal.txt -> summary.txt.  python3 summary.py
Escrito el 2026-11-14 al regenerar en modo hsa; reproduce exactamente summary.sin_hsa.txt a partir de *.sin_hsa.txt
(python3 summary.py --sin-hsa), que se calculó antes a mano con las mismas fórmulas."""
import os, re, sys

here = os.path.dirname(os.path.abspath(__file__))
suf = ".sin_hsa.txt" if "--sin-hsa" in sys.argv else ".txt"


def kv(name):
    rows = []
    for line in open(os.path.join(here, name + suf)):
        if line.startswith("RES"):
            rows.append({k: v for k, v in re.findall(r"(\w+)=(\S+)", line)})
    return rows


p = {}
for r in kv("post"):
    p.update({k: float(v) for k, v in r.items()})
tA, tB, ts, a81, b81 = p["new_tA"], p["new_tB"], p["new_tA_step"], p["new_tA_1v81"], p["new_tB_1v81"]
oA, oB, oa81, ob81 = p["old_ideal_tA"], p["old_ideal_tB"], p["old_tA_1v81"], p["old_tB_1v81"]
out = [
    f"POST tA_new_us {tA * 1e6:.4f} tB_new_us {tB * 1e6:.4f} tA_ideal_us {oA * 1e6:.4f}",
    f"POST new_vs_ideal_pct {(tA / oA - 1) * 100:.3f}",
    f"POST A_vs_B_pct {(tA / tB - 1) * 100:.4f}",
    f"POST step_pct {(tA - ts) / tA * 100:.4f}",
    f"POST stage_10mV_pct new {(a81 / tA - 1) * 100:.3f} old {(oa81 / oA - 1) * 100:.3f}",
    f"POST ratio_10mV_pct new {((a81 / b81) / (tA / tB) - 1) * 100:.4f} old {((oa81 / ob81) / (oA / oB) - 1) * 100:.4f}",
]
c = {r["case"]: (float(r["tA"]), float(r["tB"])) for r in kv("cal")}
s0A, s0B = c["s0"]
out.append(f"CAL static_high_minus_low_ns {(c['s1'][0] - s0A) * 1e9:.2f}")
for k in ("r2", "r10", "r20", "f2", "f10", "f20"):
    dt = c[k][0] - s0A
    out.append(f"CAL {k} dt_ns {dt * 1e9:+.1f} pct {dt / s0A * 100:+.3f} B_shift_ns {(c[k][1] - s0B) * 1e9:+.2f}")
Q = 0.59537e-15 * 1.8  # Cc extraída (caps_ga.inc, C21 XA CALA) por 1,8 V
for k in ("r2", "r10", "r20"):
    out.append(f"CAL {k} I_implied_nA {Q / (c[k][0] - s0A) * 1e9:.2f} (Q = Cc*1.8 V = 1.072 fC)")
text = "\n".join(out) + "\n"
if "--sin-hsa" in sys.argv:
    sys.stdout.write(text)
else:
    open(os.path.join(here, "summary.txt"), "w").write(text)
    sys.stdout.write(text)
