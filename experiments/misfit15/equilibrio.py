"""MISFIT-15 (enmienda 2): equilibrio de cada isla = cambio de signo de la corriente de su fuente. Escribe op_<c>_<t>/k.txt con
lineas 'K <c> <t> <inst> <vj> <ix>' (mismas 95 cantidades del prerregistro, mas DWELL). Escrito antes de la tercera pasada."""
import os, numpy as np
import gen
H = gen.H; nan = float("nan")


def cruce(v, a):
    idx = [i for i in range(len(v) - 1) if a[i] * a[i + 1] < 0 or (a[i] == 0 and (i == 0 or a[i - 1] != 0))]
    if len(idx) != 1: return None
    i = idx[0]
    return (i, 0.0) if a[i] == 0 else (i, a[i] / (a[i] - a[i + 1]))


for c, t in gen.CORNERS:
    d = os.path.join(H, f"op_{c}_{t}"); out = []; K = {}
    for x in ("18", "09"):
        for su in "su":
            for j, i0 in enumerate(gen.I0S):
                f = os.path.join(d, f"f_{x}_{su}_{j}.txt")
                if i0 == "1e-7" and (x, su) != ("18", "s"): continue
                if not os.path.exists(f): print("falta", f); continue
                M = np.loadtxt(f); v = M[:, 0]; col = lambda k: M[:, 1 + k]
                assert M.shape[1] == 12 and len(v) == 901, M.shape
                if (x, su, j) == ("18", "s", 0):
                    K["DPW"] = (1.8, -col(8)[0]); K["DPD"] = (1.8, -col(9)[0]); K["DWELL"] = (1.8, -col(10)[0])
                xv = 1.8 if x == "18" else 0.9
                for tp, n, ce, cx in (("A", 1, 0, 1), ("A", 3, 2, 3), ("B", 1, 4, 5), ("B", 3, 6, 7)):
                    if j == 0 and n == 3: continue
                    if j == 6 and (tp, n) != ("B", 1): continue
                    k = 0 if j == 0 else 11 if j == 6 else (j if n == 1 else 5 + j)
                    r = cruce(v, col(ce))
                    if r is None: K[f"{tp}_{x}_{su}_{k}"] = (nan, nan); continue
                    i, fr = r; vi = v[i] + fr * (v[i + 1] - v[i]); ix = -(col(cx)[i] + fr * (col(cx)[i + 1] - col(cx)[i]))
                    K[f"{tp}_{x}_{su}_{k}"] = (vi if tp == "A" else xv - vi, ix)
    g = lambda k: K.get(k, (nan, nan))[1]
    K["BUSA_off"] = (1.8, 7 * g("A_18_u_0")); K["BUSA_on"] = (1.8, 6 * g("A_18_u_0") + g("A_18_s_0"))
    K["BUSB_off"] = (1.8, 7 * g("B_18_u_0") + g("DWELL")); K["BUSB_on"] = (1.8, 6 * g("B_18_u_0") + g("B_18_s_0") + g("DWELL"))
    open(os.path.join(d, "k.txt"), "w").write("".join(f"K {c} {t} {k} {a:.9e} {b:.9e}\n" for k, (a, b) in K.items()))
    print(c, t, len(K), "cantidades,", sum(1 for a, b in K.values() if a != a or b != b), "nan")
