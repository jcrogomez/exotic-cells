"""b20_firma_T: dependencia con la temperatura y variantes de perfil en d = 0 (juego S, escenario central).
Compara b20_barrido_sol (300 K) con sol_T233 y sol_T358; y con sol_erfc, sol_gr2 (Gp = 2 Gn), sol_bgn (BGN 0.6 x Slotboom).
Salida: b20_firma_T.txt"""
import json, pickle, subprocess, os
import numpy as np
SC = json.load(open("b20_escenarios.json"))
CA = SC["cA_tag"]["sol"]; cF = SC["cA"][SC["central"][0]]; tau = SC["tau"][SC["central"][1]]
AB = 0.1e-4 * 1.4e-4
JS300, NID = 2.1483e-9, 1.3632
def load(tag):
    f = "b20_barrido_%s.pkl" % tag
    if not os.path.exists(f): return None
    D = pickle.load(open(f, "rb"))
    return D["meta"], {(r["Np"], r["Nn"], r["G"], r["d"]): r for r in D["res"] if not r["err"] and r["Nw"] == 6e16}
def cur(r, T, v):
    kT = 8.617333e-5 * T
    JS = JS300 * np.exp(1.12 / NID * (1 / (8.617333e-5 * 300) - 1 / kT))
    if v > 0:
        J = CA * cF * r["JF"] + 1e-9 / tau * r["TF"] + JS * (np.exp(r["VF"] / (NID * kT)) - 1)
        return AB * np.exp(np.interp(v, r["VF"], np.log(np.maximum(J, 1e-300))))
    J = CA * np.abs(r["JR"]) + 1e-9 / tau * np.abs(r["TR"]) + JS
    return AB * np.exp(np.interp(-v, -r["VR"], np.log(J)))
def pvr(r, T):
    kT = 8.617333e-5 * T
    JS = JS300 * np.exp(1.12 / NID * (1 / (8.617333e-5 * 300) - 1 / kT))
    J = CA * cF * r["JF"] + 1e-9 / tau * r["TF"] + JS * (np.exp(r["VF"] / (NID * kT)) - 1)
    for i in range(1, len(J) - 1):
        if r["VF"][i] > 0.36: break
        if J[i] > J[i-1] and J[i] > J[i+1]: return J[i] / J[i:].min()
    return 1.0
out = open("b20_firma_T.txt", "w")
def P(s=""):
    print(s); out.write(s + "\n")
P(subprocess.check_output(["date"]).decode().strip())
P("Juego S (A = %.3g, F0 = 2.947e7), cF = %g, tau = %g s (tau NO se varia con T: la parte termica del exceso entra solo por n, p y Gamma). I por 1.4 um." % (4e14 * CA, cF, tau))
runs = {k: load(k) for k in ("sol", "sol_T233", "sol_T358", "sol_erfc", "sol_gr2", "sol_bgn")}
cells = [(5e19, 5e19, 20), (5e19, 2e20, 20), (1e20, 1e20, 10), (1e20, 1e20, 20), (1e20, 2e20, 20), (1e20, 2e20, 30), (2e20, 2e20, 10), (2e20, 2e20, 20), (2e20, 2e20, 3), (3e20, 3e20, 5)]
P("== Temperatura (d = 0). Cocientes I(358 K)/I(233 K) [dI/dT relativo]; referencia: la difusion del PDK cambia x%.1e entre 233 y 358 K" %
  np.exp(1.12 / NID * (1 / (8.617333e-5 * 233) - 1 / (8.617333e-5 * 358))))
P("Np/Nn/G           I(-1.8) 233K   300K      358K    cociente | I(-0.1) 233K  300K     358K   cociente | I(+0.1) cociente | I(+0.4) cociente | PVR 233/300/358")
if all(runs[k] for k in ("sol", "sol_T233", "sol_T358")):
    for c in cells:
        k = c + (0,)
        a, b, h = runs["sol_T233"][1][k], runs["sol"][1][k], runs["sol_T358"][1][k]
        P("%.0e/%.0e/%-3d  %9.2e %9.2e %9.2e  x%5.2f | %9.2e %9.2e %9.2e x%6.2f | x%8.2f | x%9.1f | %.2f/%.2f/%.2f" % (
            c[0], c[1], c[2], cur(a, 233, -1.8), cur(b, 300, -1.8), cur(h, 358, -1.8), cur(h, 358, -1.8) / cur(a, 233, -1.8),
            cur(a, 233, -0.1), cur(b, 300, -0.1), cur(h, 358, -0.1), cur(h, 358, -0.1) / cur(a, 233, -0.1),
            cur(h, 358, 0.1) / cur(a, 233, 0.1), cur(h, 358, 0.4) / cur(a, 233, 0.4), pvr(a, 233), pvr(b, 300), pvr(h, 358)))
else:
    P("FALTAN barridos de temperatura")
P()
P("== Variantes de perfil (300 K, d = 0): I(-1.8 V), I(-0.1 V) y PVR; y efecto de la desalineacion d = -30 / +30 sobre I(-1.8)")
P("Np/Nn/G           variante   I(-1.8)    I(-0.1)    PVR   | I(-1.8) en d=-30   d=+30   cociente(-30/+30)")
for c in cells:
    for tag in ("sol", "sol_erfc", "sol_gr2", "sol_bgn"):
        if not runs[tag]: 
            P("%s FALTA" % tag); continue
        R = runs[tag][1]
        r = R[c + (0,)]
        m, p = cur(R[c + (-30,)], 300, -1.8), cur(R[c + (30,)], 300, -1.8)
        P("%.0e/%.0e/%-3d  %-9s %9.2e  %9.2e  %5.2f | %9.2e  %9.2e  x%.1f" % (c[0], c[1], c[2], tag, cur(r, 300, -1.8), cur(r, 300, -0.1), pvr(r, 300), m, p, m / p))
out.close()
