"""MISFIT-04 I4: veredicto. Lee p1.txt (control) y p2.txt (+ p3.txt con S7 y S8 si existe). Salida: i4.txt"""
import os
T0 = 1e-6
UMBRAL = {("tt", "27"): 0.0807, ("ff", "-40"): 0.1001, ("ss", "85"): 0.0684, ("ff", "85"): 0.0631}   # % (prerregistro I4)
CONTRATO_H01 = {}
for l in open("../../xc19_slot/contrato.txt"):
    f = l.split()
    if len(f) >= 4 and f[0] == "RES" and f[3].startswith(("h01_oa=", "h01_ob=")):
        k, v = f[3].split("="); CONTRATO_H01[(f[1], f[2], k)] = float(v)
def lee(fn):
    R = {}
    if not os.path.exists(fn): return R
    for l in open(fn):
        f = l.split()
        if f and f[0] == "RES":
            k, v = f[3].split("=")
            try: R.setdefault((f[1], f[2]), {})[k] = float(v)
            except ValueError: R.setdefault((f[1], f[2]), {})[k] = None
    return R
P1, P2, P3 = lee("p1.txt"), lee("p2.txt"), lee("p3.txt")
ratio = lambda d, p: (d[p + "_oa"] - T0) / (d[p + "_ob"] - T0)
out = ["# MISFIT-04 I4 · agresores reales, activos frente a quietos (enmienda 2, A4)", ""]
ok_ctrl, ok_i4, s7 = True, True, {}
for ct, u in UMBRAL.items():
    c = P2.get(ct) or P1[ct]
    ctrl = abs(c["c_oa"] - CONTRATO_H01[ct + ("h01_oa",)]) / (CONTRATO_H01[ct + ("h01_oa",)] - T0) * 100
    ok_ctrl &= ctrl <= 0.01
    line = f"{ct[0]} {ct[1]:>3}: control c frente al contrato {ctrl:.4f} % ({'vale' if ctrl <= 0.01 else 'NO VALE'})"
    if ct in P2:
        q = ratio(P2[ct], "q")
        d = [abs(ratio(P2[ct], f"a{k}") - q) / q * 100 for k in range(5)]
        m = max(d); ok_i4 &= m < u
        line += f" · max_k |D(tA/tB)| = {m:.5f} % (umbral {u} %; margen {u / m if m > 0 else float('inf'):.0f}x) por fase " + " ".join(f"{x:.5f}" for x in d)
    if ct in P3 and "s70_oa" in P3[ct]:
        q = ratio(P3[ct], "q")
        d7 = [abs(ratio(P3[ct], f"s7{k}") - q) / q * 100 for k in range(5)]
        d8 = abs(ratio(P3[ct], "s8") - q) / q * 100
        s7[ct] = (max(d7), d8, u)
        ab = {g: abs(ratio(P3[ct], f"o{g}") - q) / q * 100 for g in ("ag685", "agin2", "agin3")}
        line += "\n           ablacion (fase 0, un agresor): " + " · ".join(f"{g} {v:.5f} %" for g, v in ab.items())
        line += f"\n           S7 testigo max_k {max(d7):.5f} % ({max(d7) / u:.1f}x umbral) · S8 {d8:.5f} % ({d8 / u:.2f}x umbral)"
    out.append(line)
out.append("")
out.append(f"Control del deck: {'vale en las 4 esquinas' if ok_ctrl else 'NO vale: benchmark invalido'}")
if P2: out.append(f"I4 (tile sano): {'cumplida' if ok_i4 and len(P2) == 4 else 'FALSA' if not ok_i4 else 'incompleta'}")
if ("tt", "27") in s7:
    m7, d8, u = s7[("tt", "27")]
    out.append(f"Testigo S7 a tt 27: {m7 / u:.1f}x el umbral (requisito > 10x) -> {'identificable' if m7 > 10 * u else 'I4 CIEGO: benchmark invalido'}")
    out.append(f"S8 a tt 27: {'detectado' if d8 > u else 'no detectado'} por I4")
open("i4.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
