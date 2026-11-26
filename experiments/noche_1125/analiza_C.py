"""Plan nocturno 2026-11-25, bloque C: ruido de disparo en el lector pequeno v_f3, con setseed. Escrito ANTES de abrir ningun
log. Derivado de xc19_slot_e2/analiza_ruido.py. Lineas 'RN <repeticion> <instancia> <tA> <tB>' (absolutos). Salida: C.txt
h11 de v_f3 (tt 27): misfit09/tr_tt_27/m9.log, rS. Formas fijadas aqui: C0 dispersion nula = rango relativo <= 1e-6;
C3 "distintas" = ninguna de las 64 parejas (tA, tB) de R1 aparece en R1b, y dentro de cada deck las 8 repeticiones de una
instancia no son todas iguales; "+-35 %" = |sigma(R1b)/sigma(R1) - 1| <= 0,35."""
import os, re
import numpy as np
H = os.path.dirname(os.path.abspath(__file__)); T0 = 1e-6
N9 = {}
for l in open(os.path.join(H, "..", "misfit09", "tr_tt_27", "m9.log"), errors="replace"):
    f = l.split()
    if len(f) == 5 and f[0] == "M9": N9[f[3]] = float(f[4])
H11 = (N9["rS_oa"], N9["rS_ob"])
def lee(d):
    r = []; k = []
    for ln in open(os.path.join(H, "C", d, "ruido.log"), errors="replace"):
        m = re.match(r"RN (\d+) (\d+) (\S+) (\S+)\s*$", ln)
        if m:
            try: r.append((float(m[3]) - T0, float(m[4]) - T0)); k.append((int(m[1]), int(m[2])))
            except ValueError: pass
    return np.array(r), k
out = []; p = out.append
p("# Noche 1125, bloque C · analiza_C.py · ruido de disparo, v_f3, tt 27, src = 11. Tiempos desde T0 = 1 us. sigma en %.")
S = {}
for d in ("R0", "R1", "R3", "R1b"):
    x, k = lee(d)
    if len(x) == 0: p(f"{d}: sin muestras"); continue
    lr = np.log(x[:, 0] / x[:, 1]); S[d] = (lr.std(ddof=1) * 100, len(x), x, k)
    rep = sum(1 for j in range(8) if len({tuple(x[i]) for i in range(len(x)) if k[i][1] == j}) > 1)
    p(f"{d}: N = {len(x)} (se esperan 64); sigma ln(tA/tB) = {S[d][0]:.4f} %; sigma ln tA = {np.log(x[:, 0]).std(ddof=1)*100:.4f} %; "
      f"media tA = {x[:, 0].mean()*1e6:.4f} us; instancias cuyas repeticiones difieren: {rep} de 8; parejas distintas: {len({tuple(v) for v in x})}")
inv = False
if "R0" in S:
    x = S["R0"][2]; sp = max(np.ptp(x[:, 0]) / x[:, 0].mean(), np.ptp(x[:, 1]) / x[:, 1].mean())
    dn = abs(x[:, 0].mean() - (H11[0] - T0)) / (H11[0] - T0)
    c0 = sp <= 1e-6 and dn <= 1e-4 and S["R0"][1] == 64; inv |= not c0
    p(f"C0: R0 rango relativo entre muestras {sp:.2e} (<= 1e-6) y tA frente al h11 de v_f3 {dn*100:.4f} % (<= 0,01 %) -> {'cumplida' if c0 else 'FALSA'}")
else: inv = True
if "R1" in S and "R1b" in S:
    a, b = S["R1"][0], S["R1b"][0]
    p(f"C1: sigma R1 = {a:.4f} %, sigma R1b = {b:.4f} % (las dos en [0,115, 0,195]) -> {'cumplida' if 0.115 <= a <= 0.195 and 0.115 <= b <= 0.195 else 'FALSA'}")
    com = len({tuple(v) for v in S["R1"][2]} & {tuple(v) for v in S["R1b"][2]}); dist = com == 0
    c3 = dist and abs(b / a - 1) <= 0.35; inv |= not dist
    p(f"C3: parejas (tA, tB) comunes a R1 y R1b: {com} de 64; sigma(R1b)/sigma(R1) = {b/a:.3f} (+-35 %) -> {'cumplida' if c3 else 'FALSA'}")
    xx = np.vstack([S["R1"][2], S["R1b"][2]]); p(f"    R1 y R1b juntos (N = {len(xx)}, sin prediccion): sigma ln(tA/tB) = {np.log(xx[:, 0]/xx[:, 1]).std(ddof=1)*100:.4f} %")
if "R1" in S and "R3" in S:
    q = S["R3"][0] / S["R1"][0]; p(f"C2: sigma(R3)/sigma(R1) = {q:.3f} en [2,4, 3,6] -> {'cumplida' if 2.4 <= q <= 3.6 else 'FALSA'}")
p(f"Benchmark invalido (falla C0, o R1 y R1b identicos): {'SI' if inv else 'no'}")
open(os.path.join(H, "C.txt"), "w").write("\n".join(out) + "\n"); print("\n".join(out))
