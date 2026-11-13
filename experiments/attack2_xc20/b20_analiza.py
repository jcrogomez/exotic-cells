"""b20_analiza: aplica escenarios (escala del prefactor de tunel cA, tau de la corriente de exceso) a las curvas crudas de
b20_barrido y saca: clases, relacion pico/valle, fracciones del espacio, perfil minimo, ruptura, firmas sin pico.
Uso: python b20_analiza.py TAG  ->  b20_analisis_TAG.txt (+ b20_mapa_TAG.png si TAG = base)
Escenarios: b20_escenarios.json  {"cA": {...}, "tau": {...}}
"""
import sys, json, pickle, subprocess, itertools
import numpy as np

TAG = sys.argv[1]
D = pickle.load(open("b20_barrido_%s.pkl" % TAG, "rb"))
SC = json.load(open("b20_escenarios.json"))
RES = [r for r in D["res"] if not r["err"]]
T = D["meta"]["T"]
CA = SC["cA_tag"].get(TAG.split("_")[0], 1.0)   # escala del prefactor de este barrido
kT = 8.617333e-5 * T
XJ = 0.1e-4                    # cm; profundidad de union (DATOS_PROCESO: leido por agente)
LB = 1.4e-4                    # cm; largo de frontera de la celda base
AB = XJ * LB
JFLOOR = 150e-15 / AB
JS300, NID = 2.1483e-9, 1.3632  # PDK pfet_01v8 tt jss/njs (a20_pdk.txt seccion 10); se escala con T por Eg/(n kT)
JS = JS300 * np.exp(1.12 / NID * (1 / (8.617333e-5 * 300) - 1 / kT))
out = open("b20_analisis_%s.txt" % TAG, "w")


def P(s=""):
    out.write(s + "\n")


def jdiff(V):
    return JS * (np.exp(V / (NID * kT)) - 1.0)


def fwd(r, cA, tau):
    return CA * cA * r["JF"] + (1e-9 / tau if tau else 0.0) * r["TF"] + jdiff(r["VF"])


def rev(r, cA, tau, mult=True):
    J = CA * np.abs(r["JR"]) + (1e-9 / tau if tau else 0.0) * np.abs(r["TR"]) + JS
    if mult:
        M = np.where(r["IID"] < 0.999, 1.0 / (1.0 - np.minimum(r["IID"], 0.999)), 1e12)
        J = J * M
    return J


def pvr(r, cA, tau):
    V, J = r["VF"], fwd(r, cA, tau)
    for i in range(1, len(V) - 1):
        if V[i] > 0.36:
            break
        if J[i] > J[i - 1] and J[i] > J[i + 1]:
            k = i + int(np.argmin(J[i:]))
            return J[i] / J[k], V[i], J[i], V[k], J[k]
    return 1.0, np.nan, np.nan, np.nan, np.nan


def at(V, J, v):
    return float(np.exp(np.interp(v, V, np.log(np.maximum(J, 1e-300)))))


def vcross(r, J, level):
    Va = -r["VR"]
    if J[-1] < level:
        return np.inf
    if J[0] >= level:
        return Va[0]
    i = int(np.argmax(J >= level))
    a, b = np.log(J[i - 1]), np.log(J[i])
    return Va[i - 1] + (Va[i] - Va[i - 1]) * (np.log(level) - a) / (b - a)


def bv_aval(r):
    Va, I = -r["VR"], r["IID"]
    if I[-1] < 1:
        return np.inf
    i = int(np.argmax(I >= 1))
    return Va[i] if i == 0 else Va[i - 1] + (Va[i] - Va[i - 1]) * (1 - I[i - 1]) / (I[i] - I[i - 1])


def clase(r, cA, tau):
    pv, Vp, Jp, Vv, Jv = pvr(r, cA, tau)
    Jr = rev(r, cA, tau)
    Va = -r["VR"]
    Jr01, Jr18 = at(Va, Jr, 0.1), at(Va, Jr, 1.8)
    Jf01 = at(r["VF"], fwd(r, cA, tau), 0.1)
    if pv > 2 and Jp > JFLOOR:
        c = "N2"
    elif pv > 1.3 and Jp > JFLOOR:
        c = "N"
    elif pv > 1.0 and Jp > JFLOOR:
        c = "n"
    elif Jr01 > JFLOOR and Jr01 > 3 * Jf01:
        c = "B"
    elif Jr18 > 10 * JFLOOR:
        c = "Z"
    else:
        c = "O"
    return c, pv, Vp, Jp, Vv, Jv, Jr01, Jr18, Jf01


P(subprocess.check_output(["date"]).decode().strip())
P("b20_analiza.py  TAG = %s  meta = %s" % (TAG, D["meta"]))
P("Area de frontera %.2e cm2 (1.4 um x xj 0.1 um); piso 150 fA = %.2e A/cm2; difusion PDK: Js = %.2e A/cm2 (T = %g K), n = %.3f"
  % (AB, JFLOOR, JS, T, NID))
P("Prefactor de este barrido: A = %.3g (cA_tag = %g). Escenarios: cF (factor extra sobre el tunel DIRECTO): %s ; tau (TAT): %s" % (4e14 * CA, CA, SC["cA"], SC["tau"]))
P("Clases: N2 pico con PVR > 2 | N PVR > 1.3 | n pico con PVR entre 1 y 1.3 | B backward (inversa a 0.1 V > 3 x directa a 0.1 V"
  " y sobre el piso) | Z tunel inverso: I(-1.8 V) > 10 x piso | O ordinario")
P("%d celdas validas de %d" % (len(RES), len(D["res"])))
P()

scen = list(itertools.product(SC["cA"].items(), SC["tau"].items()))
CL = {}
for (ca_n, cA), (tau_n, tau) in scen:
    for r in RES:
        CL[(ca_n, tau_n, r["Np"], r["Nn"], r["G"], r["d"], r["Nw"])] = clase(r, cA, tau)

NWS = sorted({r["Nw"] for r in RES})
DS = sorted({r["d"] for r in RES})
GS = sorted({r["G"] for r in RES})
PKS = sorted({r["Np"] for r in RES})

P("== 1. FRACCIONES del espacio barrido (por escenario)")
P("escenario(cA,tau)        subconjunto            n     PVR>2   PVR>1.3  pico(>1)  sin pico |  B      Z      O")
for (ca_n, cA), (tau_n, tau) in scen:
    for name, sel in (("d=0, todos", lambda r: r["d"] == 0), ("d=-30..+30", lambda r: abs(r["d"]) <= 30),
                      ("d<=+100 (toda la zona con union)", lambda r: r["d"] <= 100), ("todo", lambda r: True)):
        cs = [CL[(ca_n, tau_n, r["Np"], r["Nn"], r["G"], r["d"], r["Nw"])][0] for r in RES if sel(r)]
        n = len(cs)
        f = lambda *k: 100.0 * sum(cs.count(i) for i in k) / n
        P("%-10s %-12s %-34s %4d  %5.1f%%  %5.1f%%  %5.1f%%   %5.1f%%  | %5.1f%% %5.1f%% %5.1f%%" % (
            ca_n, tau_n, name, n, f("N2"), f("N2", "N"), f("N2", "N", "n"), 100 - f("N2", "N", "n"), f("B"), f("Z"), f("O")))
P()

P("== 2. MAPAS (pozo %.0e). Filas Np/Nn/G; columnas d (nm). 0 y >= 270 son las separaciones enviables." % NWS[0])
for (ca_n, cA), (tau_n, tau) in scen:
    P("-- escenario cA = %s, tau = %s" % (ca_n, tau_n))
    P("%-22s" % "Np     Nn     G" + "".join("%6d" % d for d in DS))
    for Np, Nn in ((2e19, 2e19), (5e19, 5e19), (5e19, 2e20), (1e20, 1e20), (1e20, 2e20), (2e20, 2e20), (2e20, 3e20), (3e20, 3e20)):
        for G in GS:
            P("%.0e  %.0e %3d     " % (Np, Nn, G) + "".join("%6s" % CL.get((ca_n, tau_n, Np, Nn, G, d, NWS[0]), ("-",))[0] for d in DS))
    P()

P("== 3. PERFIL MINIMO en d = 0: G maximo (nm/decada) que aun da PVR > 1.3 [y > 2], por par de picos y escenario (pozo %.0e)" % NWS[0])
for (ca_n, cA), (tau_n, tau) in scen:
    P("-- escenario cA = %s, tau = %s   (filas Np, columnas Nn; '-' = ninguno)" % (ca_n, tau_n))
    P("          " + "".join("%14.0e" % n for n in PKS))
    for Np in PKS:
        row = ""
        for Nn in PKS:
            g13 = [G for G in GS if CL[(ca_n, tau_n, Np, Nn, G, 0, NWS[0])][0] in ("N", "N2")]
            g2 = [G for G in GS if CL[(ca_n, tau_n, Np, Nn, G, 0, NWS[0])][0] == "N2"]
            row += "%14s" % ("%s [%s]" % (max(g13) if g13 else "-", max(g2) if g2 else "-"))
        P("%.0e   " % Np + row)
    P()

P("== 4. CELDAS d = 0, pozo %.0e: numeros por perfil (escenario central %s / %s)" % (NWS[0], SC["central"][0], SC["central"][1]))
cA, tau = SC["cA"][SC["central"][0]], SC["tau"][SC["central"][1]]
P("Np     Nn     G   Emax0 W10  l_tun xi_p xi_n | PVR   Vp    Jp(A/cm2) Ip(1.4um)  Vv   | I(-0.1)   I(+0.1)   I(-1.8 V)  | Vz(1nA/um) Vz(1uA/um) BVaval  [solo tunel cA=1: Vz1uA]")
P("cm-3   cm-3   nm  MV/cm nm   nm    meV  meV  |                                       | A (1.4 um de frontera)        | V          V          V")
for r in RES:
    if r["d"] != 0 or r["Nw"] != NWS[0]:
        continue
    c, pv, Vp, Jp, Vv, Jv, Jr01, Jr18, Jf01 = clase(r, cA, tau)
    Jr = rev(r, cA, tau)
    P("%.0e  %.0e %3d  %4.2f %5.1f %5.1f %4.0f %4.0f | %5.2f %5.3f %9.2e %9.2e %5.2f | %9.2e %9.2e %9.2e | %6.2f     %6.2f     %6.2f    %6.2f   %s" % (
        r["Np"], r["Nn"], r["G"], r["Emax0"] / 1e6, r["W10"] * 1e7, r["lmin0"] * 1e7, r["xi_p"] * 1e3, r["xi_n"] * 1e3, pv, Vp, Jp,
        Jp * AB, Vv, Jr01 * AB, Jf01 * AB, Jr18 * AB, vcross(r, Jr, 1.0), vcross(r, Jr, 1e3), bv_aval(r),
        vcross(r, rev(r, 1.0, None), 1e3), c))
P()

P("== 5. RUPTURA frente a separacion d (escenario central), pozo por pozo. Vz a 1 uA/um (1e3 A/cm2) / BV de avalancha (integral = 1, espacio muerto)")
for Nw in NWS:
    P("-- pozo %.0e" % Nw)
    P("%-22s" % "Np     Nn     G" + "".join("%13d" % d for d in DS))
    for Np, Nn in ((5e19, 5e19), (5e19, 2e20), (1e20, 1e20), (1e20, 2e20), (2e20, 2e20), (3e20, 3e20)):
        for G in GS:
            row = ""
            for d in DS:
                rr = [r for r in RES if (r["Np"], r["Nn"], r["G"], r["d"], r["Nw"]) == (Np, Nn, G, d, Nw)]
                if not rr:
                    row += "%13s" % "-"
                    continue
                row += "%13s" % ("%.1f/%.1f" % (vcross(rr[0], rev(rr[0], cA, tau), 1e3), bv_aval(rr[0])))
            P("%.0e  %.0e %3d     " % (Np, Nn, G) + row)
    P()

P("== 6. FIRMAS SIN PICO en d = 0 (escenario central): cociente inversa/directa y curvatura")
P("Np     Nn     G   clase  I(-0.1)/I(+0.1)  I(-0.3)/I(+0.3)  I(-1.8)/I(-0.9)   gamma(0) [1/V] = (d2I/dV2)/(dI/dV)")
for r in RES:
    if r["d"] != 0 or r["Nw"] != NWS[0] or r["Np"] != r["Nn"] and (r["Np"], r["Nn"]) not in ((5e19, 2e20), (1e20, 2e20)):
        continue
    Jf, Jr = fwd(r, cA, tau), rev(r, cA, tau)
    Va = -r["VR"]
    f = lambda v: at(r["VF"], Jf, v)
    g = lambda v: at(Va, Jr, v)
    h = 0.02
    d1 = (f(h) + g(h)) / (2 * h)
    d2 = (f(h) - g(h)) / h**2
    P("%.0e  %.0e %3d   %-3s   %10.2f      %10.2e      %10.1f       %8.1f" % (r["Np"], r["Nn"], r["G"], clase(r, cA, tau)[0], g(0.1) / f(0.1),
                                                                   g(0.3) / f(0.3), g(1.8) / g(0.9), d2 / d1))
out.close()

if TAG == "base":
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    code = {"O": 0, "Z": 1, "B": 2, "n": 3, "N": 4, "N2": 5}
    fig, axs = plt.subplots(1, len(scen), figsize=(5.2 * len(scen), 9), squeeze=False)
    pairs = [(a, a) for a in PKS] + [(5e19, 2e20), (1e20, 2e20), (2e20, 1e20), (2e20, 3e20)]
    for ax, ((ca_n, cA), (tau_n, tau)) in zip(axs[0], scen):
        rows = [(Np, Nn, G) for (Np, Nn) in pairs for G in GS]
        M = np.array([[code[CL[(ca_n, tau_n, Np, Nn, G, d, NWS[0])][0]] for d in DS] for (Np, Nn, G) in rows])
        ax.imshow(M, cmap="viridis", vmin=0, vmax=5, aspect="auto")
        for i, (Np, Nn, G) in enumerate(rows):
            for k, d in enumerate(DS):
                ax.text(k, i, CL[(ca_n, tau_n, Np, Nn, G, d, NWS[0])][0], ha="center", va="center", color="w", fontsize=6)
        ax.set_xticks(range(len(DS)), DS, fontsize=7)
        ax.set_yticks(range(len(rows)), ["%.0e/%.0e G%d" % t for t in rows], fontsize=5)
        ax.set_xlabel("separacion d (nm); 0 y >= 270 enviables", fontsize=8)
        ax.set_title("cA = %s, tau = %s" % (ca_n, tau_n), fontsize=8)
    fig.tight_layout()
    fig.savefig("b20_mapa_base.png", dpi=130)
