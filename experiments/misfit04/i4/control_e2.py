"""E2: fase de control de cada deck p5* frente a p5c_0 y p3 (Delta con signo de tA/tB contra la q del mismo deck, tt 27).
Uso: python3 control_e2.py"""
import glob, os
def lee(fn):
    R = {}
    for l in open(fn, errors="replace"):
        f = l.split()
        if len(f) == 4 and f[0] == "RES" and f[1] == "tt": k, v = f[3].split("="); R[k] = float(v)
    return R
r = lambda d, p: (d[p + "_oa"] - 1e-6) / (d[p + "_ob"] - 1e-6)
D = lambda d, p: (r(d, p) / r(d, "q") - 1) * 100
c = lee("corridas/p5c_0/i4.log"); p3 = lee("p3.txt")
for fn in sorted(glob.glob("corridas/p5[e-z]*_*/i4.log")):
    e = lee(fn); dk = os.path.basename(os.path.dirname(fn)); ab = "aborted" in open(fn, errors="replace").read()
    if ab or "q_oa" not in e: print(f"{dk}: abortado o incompleto"); continue
    for ph in (0, 4, 8, 12, 16):
        k = f"l216f{ph}"
        if k + "_oa" in e:
            de, dc, d3 = D(e, k), D(c, k), D(p3, f"s7{ph // 4}")
            print(f"{dk}: control fase {ph}: {de:+.5f} %  p5c_0 {dc:+.5f}  p3 {d3:+.5f}  dif {abs(de - dc):.5f} / {abs(de - d3):.5f} -> {'ok' if max(abs(de - dc), abs(de - d3)) <= 0.001 else 'FALLA'} (limite 0,001); c_oa {e['c_oa']:.6e} (p5c_0 {c['c_oa']:.6e})")
    print("   ", {k[:-3]: round(D(e, k[:-3]), 5) for k in e if k.endswith("_oa") and k[0] == "l"})
