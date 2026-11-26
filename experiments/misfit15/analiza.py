"""MISFIT-15: veredictos K1..K8 a partir de op_<c>_<t>/m.log. Escrito antes de correr. Uso: analiza.py > m15.txt"""
import os, glob
H = os.path.dirname(os.path.abspath(__file__)); CORN = [("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")]; NEXP = 96  # 88 + testigo + 2 diodos + 4 buses + DWELL (enmienda 2); antes lei mal la cuenta (93)
D = {}; bad = []
for c, t in CORN:
    L = [l.split() for l in open(os.path.join(H, f"op_{c}_{t}", "k.txt")) if l.startswith("K ")]
    D[(c, t)] = {f[3]: (float(f[4]), float(f[5])) for f in L if len(f) == 6}
    if len(D[(c, t)]) != NEXP: bad.append(f"{c} {t}: {len(D[(c, t)])} de {NEXP} lineas")
print("lineas:", "todas" if not bad else "; ".join(bad))
def g(ct, inst): return D[ct].get(inst, (float("nan"), float("nan")))
def row(title, f, fmt="{:.4g}"):
    print(f"{title:58s} " + "  ".join(f"{c} {t}: " + fmt.format(f((c, t))) for c, t in CORN))
V = {}
print("\n== K1 diodo suelto a 1,8 V inversa (A) ==")
row("pw2nd 1,4 um2 (topologia A)", lambda ct: g(ct, "DPW")[1], "{:.3e}"); row("pd2nw 1,4 um2 (topologia B)", lambda ct: g(ct, "DPD")[1], "{:.3e}"); row("pozo supuesto 112 um2", lambda ct: g(ct, "DWELL")[1], "{:.3e}")
V["K1"] = all(abs(g(ct, "DPW")[1]) < 100e-12 for ct in CORN)
print("apuesta < 1 pA a 27 y -40:", all(abs(g(ct, "DPW")[1]) < 1e-12 for ct in CORN[:2]))
print("\n== Vj seleccionado, X = 1,8 (V) ==")
names = ["I0=0"] + [f"n=1 {i}" for i in ("1p", "100p", "10n", "1u", "10u")] + [f"n=3 {i}" for i in ("1p", "100p", "10n", "1u", "10u")]
for topo in "AB":
    for x in ("18", "09"):
        for k, nm in enumerate(names): row(f"{topo} X={x} sel {nm} Vj", lambda ct: g(ct, f"{topo}_{x}_s_{k}")[0])
print("\n== I_X seleccionado y no seleccionado, X = 1,8 (A) ==")
for topo in "AB":
    for k, nm in enumerate(names):
        row(f"{topo} {nm} I_sel", lambda ct: g(ct, f"{topo}_18_s_{k}")[1], "{:.3e}"); row(f"{topo} {nm} I_nosel", lambda ct: g(ct, f"{topo}_18_u_{k}")[1], "{:.3e}")
        row(f"{topo} {nm} nosel/sel", lambda ct: g(ct, f"{topo}_18_u_{k}")[1] / g(ct, f"{topo}_18_s_{k}")[1], "{:.3e}")
V["K2"] = all(0.85 <= g(ct, "A_18_s_4")[0] <= 1.30 for ct in CORN)
V["K3"] = all(g(ct, "A_18_s_3")[0] < 1.45 for ct in CORN)
V["K4"] = all(g(ct, f"B_18_s_{k}")[0] >= 1.75 for ct in CORN for k in (1, 2, 3, 4)) and all(g(ct, "B_18_s_5")[0] >= 1.60 for ct in CORN)
V["K5"] = all(g(ct, f"{tp}_18_u_0")[1] / g(ct, f"{tp}_18_s_0")[1] >= 0.5 for ct in CORN for tp in "AB")
lim = {("tt", "27"): 1e-3, ("ff", "-40"): 1e-3, ("ss", "85"): 3e-2, ("ff", "85"): 3e-2}
V["K6"] = all(g(ct, f"{tp}_18_u_4")[1] / g(ct, f"{tp}_18_s_4")[1] <= lim[ct] for ct in CORN for tp in "AB")
w = g(("tt", "27"), "B_18_s_11")[1]; m = g(("tt", "27"), "B_18_s_0")[1]
V["K7 testigo"] = 97e-9 <= w <= 103e-9; V["K7 mutante"] = abs(m) < 1e-9
print(f"\ntestigo B 100 nA tt 27: {w:.4e} A   mutante I0=0: {m:.3e} A")
V["K8"] = all(0.12 <= g(ct, "A_18_s_9")[1] / 1e-6 <= 0.35 for ct in CORN)
row("K8 A n=3 1u I_X/I0", lambda ct: g(ct, "A_18_s_9")[1] / 1e-6)
print("\n== bus de 7 puestos, I0 = 0, X = 1,8 (A) ==")
for b in ("BUSA_off", "BUSA_on", "BUSB_off", "BUSB_on"): row(b, lambda ct: g(ct, b)[1], "{:.3e}")
print("\n== veredictos ==")
for k, v in V.items(): print(f"{k}: {'cumplida' if v else 'falsa'}")
print("benchmark:", "valido" if V["K7 testigo"] and V["K7 mutante"] and not bad else "INVALIDO")
