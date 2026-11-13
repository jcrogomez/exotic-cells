# v4o_ruptura.py — ruptura por avalancha de p+/pozo n (XC-21): plana, con n+ a una separacion (reach-through), y en esquinas
# cilindrica / esferica de radio r_j. Integral de ionizacion local con coeficientes de van Overstraeten-de Man (300 K).
# Codigo propio. Modelo local: sin espacio muerto (subestima la ruptura en regiones < ~0.1 um), sin tunel (relevante > ~5e17).
# Campo: E(r) = C/r^k - qN r/((k+1) eps), k = 0 plana, 1 cilindro, 2 esfera; r de r_j a min(r donde E=0, r_j + hueco).
import numpy as np
from scipy.optimize import brentq
q = 1.602e-19; eps = 11.7 * 8.854e-14   # F/cm
def a_n(E): return 7.03e5 * np.exp(-1.231e6 / np.maximum(E, 1.0))
def a_p(E): return np.where(E < 4e5, 1.582e6 * np.exp(-2.036e6 / np.maximum(E, 1.0)), 6.71e5 * np.exp(-1.693e6 / np.maximum(E, 1.0)))

def profile(C, N, k, rj, gap):
    rmax = rj + gap if gap is not None else rj + 50e-4
    r = np.linspace(rj, rmax, 4001)
    E = C / r**k - q * N * r / ((k + 1) * eps) if k > 0 else C - q * N * (r - rj) / eps
    ok = E > 0
    if not ok.all():
        i = np.argmax(~ok); r = np.linspace(rj, r[i], 4001)
        E = C / r**k - q * N * r / ((k + 1) * eps) if k > 0 else C - q * N * (r - rj) / eps
        E = np.maximum(E, 0)
    return r, E

def ion_integral(C, N, k, rj, gap):
    r, E = profile(C, N, k, rj, gap)
    an, ap = a_n(E), a_p(E)
    dr = np.diff(r); mid = lambda f: 0.5 * (f[1:] + f[:-1])
    cum = np.concatenate([[0], np.cumsum(mid(an - ap) * dr)])
    # condicion de ruptura (iniciada por cualquiera de los dos; forma estandar): int a_p exp(-int (a_p - a_n)) = 1 desde el lado n
    I = np.sum(mid(ap * np.exp(cum)) * dr)
    return I, np.sum(mid(E) * dr), E.max()

def bv(N, k=0, rj=0.15e-4, gap=None, vbi=0.95):
    f = lambda lc: ion_integral(10**lc * (rj**k if k > 0 else 1), N, k, rj, gap)[0] - 1
    lc = brentq(f, 3, 8)
    I, V, Emax = ion_integral(10**lc * (rj**k if k > 0 else 1), N, k, rj, gap)
    return V - vbi, Emax

if __name__ == '__main__':
    print("Control: plana sin hueco frente a Sze (Si, abrupta unilateral): 1e15 ~300 V, 1e16 ~60 V, 1e17 ~11-12 V")
    for N in [1e15, 1e16, 1e17]:
        print(f"  N={N:.0e}: BV plana = {bv(N)[0]:.1f} V")
    print("\nN (cm-3) | plana sin hueco | plana hueco 0.27 um (cambio) | cil rj=0.1/0.2 | esf rj=0.1/0.2 | esf rj=0.1 + hueco 0.27")
    for N in [1e16, 3e16, 5e16, 1e17, 2e17, 3e17, 5e17, 1e18]:
        b0, E0 = bv(N); bg, _ = bv(N, gap=0.27e-4)
        c1 = bv(N, 1, 0.1e-4)[0]; c2 = bv(N, 1, 0.2e-4)[0]
        s1, Es = bv(N, 2, 0.1e-4); s2 = bv(N, 2, 0.2e-4)[0]
        sg = bv(N, 2, 0.1e-4, gap=0.27e-4)[0]
        print(f"{N:.0e} | {b0:6.2f} (Emax {E0:.2e}) | {bg:6.2f} ({100*(bg/b0-1):+.0f} %) | {c1:5.2f}/{c2:5.2f} | {s1:5.2f}/{s2:5.2f} | {sg:5.2f}")
    # dopado que reproduce el bv del PDK (pd2nw_05v5: bv = 12.69 V) como plana
    Ncal = 10**brentq(lambda l: bv(10**l)[0] - 12.69, 16, 18)
    print(f"\nN que da BV plana = 12.69 V (bv del PDK pd2nw_05v5): {Ncal:.2e} cm-3")
    for rj in (0.1e-4, 0.15e-4, 0.2e-4):
        print(f"  con ese N: cil rj={rj*1e4:.2f} um {bv(Ncal,1,rj)[0]:.2f} V; esf {bv(Ncal,2,rj)[0]:.2f} V; plana+hueco 0.27 {bv(Ncal,gap=0.27e-4)[0]:.2f} V")
