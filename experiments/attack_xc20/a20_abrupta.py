"""a20_abrupta: (b) union abrupta simetrica, formula y Poisson propio; validacion del tunel no local;
(d) dopado del lado ligero a partir de cj/pb del PDK.
Uso: python a20_abrupta.py > a20_abrupta.txt
"""
import subprocess
import numpy as np
import a20_lib as L

print(subprocess.check_output(["date"]).decode().strip())
kT = L.kB * 300
Eg = 1.12


def eta_of(N, Nband):
    lo, hi = -40.0, 400.0
    for _ in range(100):
        m = 0.5 * (lo + hi)
        if Nband * L.fd_half(m) < N:
            lo = m
        else:
            hi = m
    return 0.5 * (lo + hi)


print("\n== 0. masa reducida equivalente a cada F0 (WKB dos bandas, Eg = 1.12 eV)")
for F0 in (L.F0_HURKX, 2.1e7, L.F0_PLAN):
    print("  F0 = %.2e V/cm  ->  m_r = %.3f m0" % (F0, L.mr_from_F0(F0, Eg) / L.M0))

print("\n== 1. validacion: tunel no local en campo uniforme frente a Hurkx local integrado")
print("   (criterio de abandono del prerregistro: factor < 2)")
for F in (5e5, 1e6, 2e6, 4e6):
    Vtot = 3.0
    Lx = Vtot / F
    x = np.linspace(0, Lx, 4001)
    j = L.Junction(x, np.zeros_like(x), np.zeros_like(x))
    j.psi = -0.5 + F * x          # Ev_L = 0.5 eV sobre Efp: lado p "lleno"
    j.Efn = -(Vtot - 0.5 - Eg) - 0.5   # Efn muy por debajo: lado n vacio en toda la ventana
    J, lmin = j.tunnel()
    win = (-j.psi[0]) - (Eg - j.psi[-1])        # ventana en eV
    # ocupacion: fv - fc ~ 1 solo para E < Efp = 0 y E > Efn
    win_eff = min(0.0, -j.psi[0]) - max(j.Efn, Eg - j.psi[-1])
    Jloc = L.q * L.A_HURKX * F**1.5 * np.exp(-L.F0_HURKX / F) * win_eff
    print("  F = %.1e V/cm: J_nolocal = %.3e, J_Hurkx = %.3e A/cm2, cociente = %.2f, camino = %.2f nm"
          % (F, J, Jloc, J / Jloc, lmin * 1e7))

print("\n== 2. union abrupta simetrica: formula (Vbi con Fermi-Dirac) y Poisson propio")
print("  N[cm-3]   Vbi[V]  W_form[nm] Emax_form[MV/cm] | Emax_Poisson W10[nm] l_tunel_min[nm] xi_p[meV] xi_n[meV] |"
      " exp(-F0/Emax): Hurkx  plan(3e7)")
rows = []
for N in (1e19, 2e19, 3e19, 5e19, 1e20, 2e20, 3e20):
    xi_n = eta_of(N, L.NC300) * kT
    xi_p = eta_of(N, L.NV300) * kT
    Vbi = Eg + xi_n + xi_p
    W = np.sqrt(2 * L.EPS * Vbi / L.q * (2.0 / N))
    Emax = 2 * Vbi / W
    half = max(6 * W, 30e-7)
    x = np.arange(-half, half, 0.05e-7)
    Na = np.where(x < 0, N, 0.0)
    Nd = np.where(x >= 0, N, 0.0)
    j = L.Junction(x, Na, Nd)
    j.solve(0.0)
    Em, W10, xp, xn, _ = j.depletion()
    psi = j.psi
    # camino de tunel mas corto a V=0: distancia entre Ev = E y Ec = E, minimo sobre E
    Es = np.linspace(Eg - psi[-1], -psi[0], 50)[1:-1] if -psi[0] > Eg - psi[-1] else []
    lmin = min([np.interp(Eg - E, psi, x) - np.interp(-E, psi, x) for E in Es]) if len(Es) else float("nan")
    # si no hay solape de bandas, anchura de la barrera a media altura
    eh, ep = np.exp(-L.F0_HURKX / Emax), np.exp(-L.F0_PLAN / Emax)
    rows.append((N, Em, eh, ep))
    print("  %.0e   %.3f   %6.2f      %5.2f        |   %5.2f      %6.2f     %6.2f       %6.0f   %6.0f  |"
          "   %.2e  %.2e" % (N, Vbi, W * 1e7, Emax / 1e6, Em / 1e6, W10 * 1e7, lmin * 1e7, xp * 1e3, xn * 1e3, eh, ep))
r19 = [r for r in rows if r[0] == 1e19][0]
r20 = [r for r in rows if r[0] == 1e20][0]
for name, F0 in (("Hurkx 1.9e7", L.F0_HURKX), ("plan 3e7", L.F0_PLAN)):
    # campos de formula
    def Ef(N):
        xi_n = eta_of(N, L.NC300) * kT
        xi_p = eta_of(N, L.NV300) * kT
        Vbi = Eg + xi_n + xi_p
        W = np.sqrt(2 * L.EPS * Vbi / L.q * (2.0 / N))
        return 2 * Vbi / W
    for lab, f in (("Emax", 1.0), ("Emedio=Emax/2", 0.5)):
        d = (F0 / (f * Ef(1e19)) - F0 / (f * Ef(1e20))) / np.log(10)
        print("  cociente exp 1e20/1e19 con %s y campo %s: 10^%.1f" % (name, lab, d))

print("\n== 3. corriente de tunel de la union abrupta simetrica (modelo no local, F0 Hurkx y F0 plan)")
print("  N       J_inv(-0.1V)  J_inv(-1.8V)  J_pico_directa  V_pico |  idem con F0 = 3e7: J_inv(-1.8V) J_pico")
for N in (1e19, 2e19, 3e19, 5e19, 1e20, 2e20, 3e20):
    xi_n = eta_of(N, L.NC300) * kT
    xi_p = eta_of(N, L.NV300) * kT
    Vbi = Eg + xi_n + xi_p
    W = np.sqrt(2 * L.EPS * Vbi / L.q * (2.0 / N))
    half = max(8 * W, 40e-7)
    x = np.arange(-half, half, 0.05e-7)
    j = L.Junction(x, np.where(x < 0, N, 0.0), np.where(x >= 0, N, 0.0))
    out = {}
    for V in (0.0, -0.1, -0.5, -1.0, -1.8):
        j.solve(V)
        out[V] = (j.tunnel()[0], j.tunnel(F0=L.F0_PLAN)[0])
    j.psi = None
    best = (0, 0)
    best3 = 0
    for V in (0.0, 0.02, 0.04, 0.06, 0.08, 0.1, 0.13, 0.16, 0.2, 0.25, 0.3, 0.4):
        j.solve(V)
        Jf = -j.tunnel()[0]
        best3 = max(best3, -j.tunnel(F0=L.F0_PLAN)[0])
        if Jf > best[0]:
            best = (Jf, V)
    print("  %.0e   %.2e     %.2e     %.2e      %.2f  |   %.2e   %.2e"
          % (N, out[-0.1][0], out[-1.8][0], best[0], best[1], out[-1.8][1], best3))

print("\n== 4. (d) dopado del lado ligero deducido de cj, pb del PDK (union de un lado, abrupta: N = 2 pb cj^2/(q eps))")
print("   cj en F/m^2 del modelo (a20_pdk.txt seccion 8); mj < 0.5 indica union graduada: N es orden de magnitud")
for name, cj, pb, mj, bv in (("pd2nw_05v5 (p+/pozo n)", 0.00074079, 0.6587, 0.34629, 12.69),
                             ("pw2nd_05v5 (n+/pozo p)", 0.0013459, 0.729, 0.44, 11.7),
                             ("pw2nd_05v5_nvt", 0.0008602, 0.66345, 0.28329, 12.69)):
    cjc = cj * 1e-4   # F/cm^2
    for vb in (pb, 0.95):
        N = 2 * vb * cjc**2 / (L.q * L.EPS)
        W0 = L.EPS / cjc
        print("  %-24s cj=%.3e F/cm2 Vbi=%.2f -> N ~ %.1e cm-3, W(0 V) = %.0f nm, mj=%.2f, bv=%.1f V"
              % (name, cjc, vb, N, W0 * 1e7, mj, bv))
print("  Area de frontera lateral 1.4 um x xj: xj = 0.12 um (klayout xsect, ilustrativo) -> %.2e cm2;"
      " xj = 0.15 um (BSIM xj, valor por defecto del modelo) -> %.2e cm2" % (1.4e-4 * 0.12e-4, 1.4e-4 * 0.15e-4))
