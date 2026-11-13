"""a20_perfil: (c) mapa de regiones de la frontera p+/n+ lateral.
Barre pico Np, gradiente lateral G (nm/decada), separacion dibujada d (nm; <0 solape; la desalineacion de +-30 nm
es un desplazamiento de d, por eso la rejilla lleva d-30 y d+30 alrededor de los valores legales 0 y 270),
y la asimetria r = Nn/Np. Fondo: pozo n de Nw (de cj del PDK, a20_abrupta.txt seccion 4).
Uso: python a20_perfil.py [T] [F0] [Nw] [etiqueta]  ->  a20_mapa_<etiqueta>.txt
"""
import sys, subprocess, itertools
import numpy as np
from multiprocessing import Pool
import a20_lib as L

T = float(sys.argv[1]) if len(sys.argv) > 1 else 300.0
F0 = float(sys.argv[2]) if len(sys.argv) > 2 else L.F0_HURKX
NW = float(sys.argv[3]) if len(sys.argv) > 3 else 6e16
TAG = sys.argv[4] if len(sys.argv) > 4 else "base"
QUICK = TAG != "base"

NPS = (1e19, 3e19, 1e20, 3e20)
GS = (5, 10, 20, 50)
DS = (-100, -50, -30, 0, 30, 50, 100, 200, 240, 270, 300)
RS = (1.0, 2.0)
if QUICK:   # sensibilidades: subconjunto
    DS = (-50, 0, 30, 270)
    RS = (2.0,)

XJ = 0.12e-4            # cm; klayout xsect sd_impl_depth (ilustrativo)
LB = 1.4e-4             # cm; largo de frontera de la celda base del plan
AB = XJ * LB
JFLOOR = 150e-15 / AB   # piso del lector expresado como densidad en la frontera
JS, NID = 2.1483e-9, 1.3632   # PDK pfet_01v8 tt: jss = 2.1483e-5 A/m^2, njs (a20_pdk.txt seccion 10)


def jdiff(V, T=300.0):
    return JS * (np.exp(V / (NID * L.kB * T)) - 1.0)


def cell(args):
    Np, G, d, r = args
    Gc, dc = G * 1e-7, d * 1e-7
    half = abs(dc) / 2 + 6 * Gc + 60e-7
    dx = 0.1e-7 if G <= 10 else 0.2e-7
    x = np.arange(-half, half, dx)
    Na, Nd = L.profile(x, Np, r * Np, Gc, dc, NW)
    j = L.Junction(x, Na, Nd, T)
    try:
        j.solve(0.0)
        Em, W10, xp, xn, xj0 = j.depletion()
        _, lmin0 = j.tunnel(F0=F0)
        jf = {}
        for V in (0.02, 0.04, 0.06, 0.08, 0.1, 0.14, 0.2, 0.3):
            j.solve(V)
            jf[V] = -j.tunnel(F0=F0)[0]
        j.psi = None
        j.solve(0.0)
        jr = {}
        for V in (-0.1, -0.6, -1.2, -1.8):
            j.solve(V)
            jr[V] = j.tunnel(F0=F0)[0]
        Em18 = j.depletion()[0]
    except RuntimeError as e:
        return (Np, G, d, r) + (np.nan,) * 11 + ("ERR",)
    Vpk = max(jf, key=jf.get)
    Jpk = jf[Vpk]
    peak = Jpk > 0 and jf[0.3] < 0.5 * Jpk
    Jf01 = jdiff(0.1, T) + jf[0.1]
    if jr[-0.1] * AB > 0.1 / 1e3:                      # < 1 kohm a 0.1 V en la frontera
        c = "C"
    elif peak and Jpk > max(JFLOOR, 10 * jdiff(0.35, T)):
        c = "N+" if Jpk >= 1.0 else "N"
    elif jr[-0.1] > JFLOOR and jr[-0.1] > 10 * Jf01:
        c = "B"
    elif jr[-1.8] > JFLOOR:
        c = "Z"
    else:
        c = "O"
    return (Np, G, d, r, Em / 1e6, W10 * 1e7, lmin0 * 1e7, xp * 1e3, xn * 1e3, jr[-0.1], jr[-1.8], Jpk, Vpk,
            jf[0.1], Em18 / 1e6, c)


if __name__ == "__main__":
    jobs = list(itertools.product(NPS, GS, DS, RS))
    with Pool(8) as pool:
        res = pool.map(cell, jobs, chunksize=4)
    out = open("a20_mapa_%s.txt" % TAG, "w")
    def P(s=""):
        out.write(s + "\n")
    P(subprocess.check_output(["date"]).decode().strip())
    P("a20_perfil.py  T = %g K, F0 = %.2e V/cm, A = %.1e, Nw = %.1e cm-3" % (T, F0, L.A_HURKX, NW))
    P("Area de frontera %.2e cm2 (1.4 um x 0.12 um); piso 150 fA = %.2e A/cm2; J_dif PDK: Js = %.2e A/cm2, n = %.3f"
      % (AB, JFLOOR, JS, NID))
    P("Clases: O ordinario (tunel bajo el piso hasta 1.8 V) | Z tunel inverso legible solo a 1.8 V (Zener blando) |"
      " B backward (inversa a 0.1 V > 10 x directa a 0.1 V y sobre el piso) |")
    P("        N pico de tunel en directa sobre piso y difusion (resistencia negativa SIN contar corriente de exceso);"
      " N+ si J_pico >= 1 A/cm2 | C cuasi-ohmica (< 1 kohm a 0.1 V)")
    P("xi_p, xi_n: energia de Fermi dentro de la banda en el borde de la zona de vaciamiento (|E| = 10 % de Emax);"
      " > 0 = degenerado")
    P()
    P("Np      G   d    r  Emax0  W10   l_tun0  xi_p  xi_n  J_inv(0.1V) J_inv(1.8V)  J_pico    V_pico Jtun_dir(0.1) Emax(1.8V) clase")
    P("cm-3   nm/dec nm       MV/cm  nm    nm     meV   meV    A/cm2       A/cm2       A/cm2     V      A/cm2      MV/cm")
    for r_ in res:
        if r_[-1] == "ERR":
            P("%.0e %3d %5d %.0f  ERR" % r_[:4])
            continue
        P("%.0e %3d %5d %.0f  %5.2f %6.1f %6.1f %5.0f %5.0f  %9.2e   %9.2e   %9.2e  %.2f   %9.2e   %5.2f   %s" % r_)
    P()
    cls = {(a, b, c_, d_): r_[-1] for r_ in res for (a, b, c_, d_) in [r_[:4]]}
    for r in RS:
        P("== MAPA r = Nn/Np = %g   (filas: Np, G ; columnas: d en nm)" % r)
        P("%-14s" % "Np      G" + "".join("%6d" % d for d in DS))
        for Np in NPS:
            for G in GS:
                P("%.0e %4d   " % (Np, G) + "".join("%6s" % cls[(Np, G, d, r)] for d in DS))
        P()
    from collections import Counter
    P("Recuento de clases: %s de %d celdas" % (dict(Counter(r_[-1] for r_ in res)), len(res)))
    out.close()
    if not QUICK:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        code = {"O": 0, "Z": 1, "B": 2, "N": 3, "N+": 4, "C": 5, "ERR": -1}
        fig, axs = plt.subplots(1, 2, figsize=(13, 5.5))
        for ax, r in zip(axs, RS):
            M = np.array([[code[cls[(Np, G, d, r)]] for d in DS] for Np in NPS for G in GS])
            ax.imshow(M, cmap="viridis", vmin=-1, vmax=5, aspect="auto")
            for i, (Np, G) in enumerate(itertools.product(NPS, GS)):
                for k, d in enumerate(DS):
                    ax.text(k, i, cls[(Np, G, d, r)], ha="center", va="center", color="w", fontsize=8)
            ax.set_xticks(range(len(DS)), DS)
            ax.set_yticks(range(16), ["%.0e / %d" % t for t in itertools.product(NPS, GS)])
            ax.set_xlabel("separacion dibujada d (nm); 0 y >= 270 son legales")
            ax.set_ylabel("pico Np (cm-3) / gradiente G (nm/decada)")
            ax.set_title("r = Nn/Np = %g  (O ordinario, Z Zener blando, B backward, N/N+ pico de tunel)" % r, fontsize=9)
        fig.tight_layout()
        fig.savefig("a20_mapa.png", dpi=130)
