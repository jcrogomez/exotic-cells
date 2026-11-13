"""b20_biestable: linea de carga y estabilidad sobre las curvas I-V con pico de b20_barrido_base.pkl.
(i) un diodo con carga resistiva o de fuente de corriente (transistor en saturacion); (ii) par en serie (Goto).
Para una celda dada se varia tau (corriente de exceso) para recorrer la relacion pico/valle y se mide:
ventana de alimentacion con biestabilidad, excursion del nodo, desajuste tolerado entre picos, y el par hecho con replicas
en espejo bajo desalineacion (celdas d = -30 y d = +30).
Uso: python b20_biestable.py  ->  b20_biestable.txt
"""
import json, pickle, subprocess
import numpy as np
from scipy.interpolate import PchipInterpolator

import sys
TAG = sys.argv[1] if len(sys.argv) > 1 else "base"
D = pickle.load(open("b20_barrido_%s.pkl" % TAG, "rb"))
SC = json.load(open("b20_escenarios.json"))
CA = SC["cA_tag"][TAG]
RES = {(r["Np"], r["Nn"], r["G"], r["d"], r["Nw"]): r for r in D["res"] if not r["err"]}
kT = 8.617333e-5 * 300
JS, NID = 2.1483e-9, 1.3632
AB = 0.1e-4 * 1.4e-4
out = open("b20_biestable_%s.txt" % TAG, "w")


def P(s=""):
    out.write(s + "\n")


VG = np.linspace(0, 0.8, 1601)


def curve(r, cA, tau, scale=1.0):
    V = np.concatenate([[0.0], r["VF"]])
    J = np.concatenate([[0.0], CA * cA * r["JF"] + 1e-9 / tau * r["TF"] + JS * (np.exp(r["VF"] / (NID * kT)) - 1)])
    return scale * AB * PchipInterpolator(V, J)(VG)        # A, sobre VG


def peak_valley(I):
    for i in range(1, len(VG) - 1):
        if VG[i] > 0.36:
            return None
        if I[i] > I[i - 1] and I[i] >= I[i + 1]:
            k = i + int(np.argmin(I[i:]))
            return VG[i], I[i], VG[k], I[k]
    return None


def roots(f):
    s = np.sign(f)
    idx = np.where(s[:-1] * s[1:] < 0)[0]
    return [VG[i] - f[i] * (VG[i + 1] - VG[i]) / (f[i + 1] - f[i]) for i in idx]


def pair(I1, I2, Vs):
    """nodo medio Vm: diodo 1 abajo (de Vm a masa), diodo 2 arriba (de Vs a Vm). Devuelve las soluciones."""
    V2 = Vs - VG
    ok = (V2 >= 0) & (V2 <= 0.8)
    f = np.where(ok, I1 - np.interp(V2, VG, I2), np.nan)
    f = f[ok]
    vg = VG[ok]
    s = np.sign(f)
    idx = np.where(s[:-1] * s[1:] < 0)[0]
    return [vg[i] - f[i] * (vg[i + 1] - vg[i]) / (f[i + 1] - f[i]) for i in idx]


def window(I1, I2):
    best = (0, None, None, 0)
    lo = hi = None
    for Vs in np.arange(0.05, 1.3, 0.005):
        r = pair(I1, I2, Vs)
        if len(r) >= 3:
            lo = Vs if lo is None else lo
            hi = Vs
            ex = r[-1] - r[0]
            if ex > best[0]:
                best = (ex, r[0], r[-1], Vs)
    return lo, hi, best


P(subprocess.check_output(["date"]).decode().strip())
P("b20_biestable.py sobre b20_barrido_" + TAG + ".pkl; cF = %s (central). I por 1.4 um de frontera, xj = 0.1 um." % SC["cA"][SC["central"][0]])
cA = SC["cA"][SC["central"][0]]
P()
P("== (i) y (ii) frente a la relacion pico/valle (se recorre con tau). Celdas d = 0, pozo 6e16.")
P("celda (Np/Nn/G)      tau     PVR   Vp     Ip        Vv     | (i) R_min=|r_neg|  ventana Vs con R=3|r_neg|  excursion | (i') fuente I: tolerancia +-%  excursion |"
  " (ii) par: ventana Vs      excursion  desajuste Ip2/Ip1 tolerado")
for key in ((3e20, 3e20, 3), (3e20, 3e20, 5), (2e20, 2e20, 3), (2e20, 3e20, 5), (1e20, 1e20, 3), (1e20, 2e20, 3), (3e20, 3e20, 10), (2e20, 2e20, 5)):
    r = RES.get(key + (0, 6e16))
    if r is None:
        continue
    for tau in (1e-7, 1e-8, 3e-9, 1e-9, 3e-10, 1e-10, 3e-11, 1e-11):
        I = curve(r, cA, tau)
        pv = peak_valley(I)
        if pv is None:
            continue
        Vp, Ip, Vv, Iv = pv
        ip, iv = np.searchsorted(VG, Vp), np.searchsorted(VG, Vv)
        g = np.gradient(I, VG)[ip:iv + 1]
        rneg = -1.0 / g.min() if g.min() < 0 else np.inf
        # (i) resistencia R = 3 |r_neg|: ventana de Vs con tres cortes
        R = 3 * rneg
        lo = hi = None
        ex = 0
        for Vs in np.arange(0.02, 3.0, 0.002):
            rt = roots((Vs - VG) / R - I)
            if len(rt) >= 3:
                lo = Vs if lo is None else lo
                hi = Vs
                ex = max(ex, rt[-1] - rt[0])
        # (i') fuente de corriente ideal entre Iv e Ip: media geometrica; tolerancia = hasta tocar Ip o Iv
        Im = np.sqrt(Ip * Iv)
        rt = roots(Im - I)
        exi = rt[-1] - rt[0] if len(rt) >= 3 else 0
        tol = (np.sqrt(Ip / Iv) - 1) * 100
        # (ii) par identico y desajuste tolerado
        wl, wh, best = window(I, I)
        kmax = 1.0
        for k in np.arange(1.02, 6.0, 0.02):
            l2, h2, b2 = window(I, k * I)
            if l2 is None:
                break
            kmax = k
        P("%.0e/%.0e/%-3d  %.0e  %5.2f  %.3f  %.2e  %.3f  | %9.2e ohm  %s  %.3f V | +-%5.1f %%  %.3f V | %s  %.3f V (%.3f->%.3f)  x%.2f" % (
            key[0], key[1], key[2], tau, Ip / Iv, Vp, Ip, Vv, rneg,
            ("%.3f-%.3f V" % (lo, hi)) if lo else "ninguna      ", ex, tol, exi,
            ("%.3f-%.3f V" % (wl, wh)) if wl else "ninguna      ", best[0], best[1] or 0, best[2] or 0, kmax))
    P()

P("== (iii) par hecho con dos replicas en espejo bajo desalineacion de 30 nm: un diodo queda en d = -30 (solape) y el otro"
  " en d = +30 (hueco). tau = %s" % SC["tau"][SC["central"][1]])
tau = SC["tau"][SC["central"][1]]
P("celda (Np/Nn/G)   Ip(d=-30)   Ip(d=0)    Ip(d=+30)   cociente(-30/+30)  PVR(-30) PVR(+30)  par(-30,+30) biestable?   par(0,0)?")
for key in ((3e20, 3e20, 3), (3e20, 3e20, 5), (3e20, 3e20, 10), (2e20, 2e20, 3), (2e20, 2e20, 5), (2e20, 3e20, 5), (1e20, 1e20, 3), (1e20, 2e20, 3)):
    for tt in (tau, 1e-8):
        c = {}
        for d in (-30, 0, 30):
            r = RES.get(key + (d, 6e16))
            c[d] = curve(r, cA, tt)
        pk = {d: peak_valley(c[d]) for d in c}
        f = lambda d: ("%.2e" % pk[d][1]) if pk[d] else "sin pico"
        pvv = lambda d: ("%.2f" % (pk[d][1] / pk[d][3])) if pk[d] else "-"
        w = window(c[-30], c[30])
        w0 = window(c[0], c[0])
        ratio = ("%.1f" % (pk[-30][1] / pk[30][1])) if pk[-30] and pk[30] else "-"
        P("%.0e/%.0e/%-3d tau %.0e  %s   %s   %s   %s   %s  %s   %s   %s" % (key[0], key[1], key[2], tt, f(-30), f(0), f(30), ratio, pvv(-30), pvv(30),
                                                              "SI (%.3f-%.3f V)" % w[:2] if w[0] else "NO", "SI" if w0[0] else "NO"))
out.close()
print(open("b20_biestable_%s.txt" % TAG).read())
