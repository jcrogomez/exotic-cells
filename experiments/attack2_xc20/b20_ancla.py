"""b20_ancla: el modelo contra lo publicado, ANTES de aplicarlo a SKY130.
 (a) Solomon et al. (IBM RC22916 / JAP 95, 5800): tunel en diodos implantados tipo CMOS, J = 5.3e7 exp(-w/0.38 nm) A/cm2.
 (b) Esaki de silicio con dopado estimado (Zhao 2007: Neff 2.5e19 -> 26 A/cm2; Neff 4e19 a 4-5 nm/dec -> 155 A/cm2).
 (c) Dutta (tesis Twente 2017, TSMC 65 nm, p+/n+ lateral en pozo n, W = 47.6 um): VBR(1 mA) frente a separacion d
     y corriente inversa en d = 0.
Dos juegos de transporte:  H = Hurkx (A = 4e14, F0 = 1.9e7; confirmado en b20_lit_esaki.txt)
                           S = pendiente de Solomon (F0 = Eg/lambda = 2.95e7 V/cm) con A ajustado aqui a su prefactor.
Fuentes y grados: b20_lit_esaki.txt, b20_lit_implante_zener.txt.   Salida: b20_ancla.txt
"""
import subprocess, itertools
import numpy as np
from multiprocessing import Pool
import b20_lib as L

F0S = 1.12 / 0.38e-7
SETS = {"H": (1.9e7, 4e14), "S": (F0S, 8.3e16)}


def sol(w_cm):
    return 5.3e7 * np.exp(-w_cm / 0.38e-7)


def job_a(a):
    kind, N1, N2, G = a
    if kind == "abr":
        x = np.arange(-40e-7, 40e-7, 0.05e-7)
        Na, Nd = L.abrupt(x, N1, N2)
    else:
        half = 6 * G * 1e-7 + 60e-7
        x = np.arange(-half, half, 0.1e-7)
        Na, Nd = L.profile(x, N1, N2, G * 1e-7, G * 1e-7, 0.0, 1e17)
    j = L.Junction(x, Na, Nd)
    j.solve(0.0)
    o = []
    for V in (-0.5, -1.0, -1.5):
        j.solve(V)
        row = [V]
        for k in ("H", "S"):
            J, l = j.tunnel(F0=SETS[k][0], A=SETS[k][1])
            row += [J, l]
        o.append(row)
    return a, o


def job_b(a):
    N1, N2, G = a
    if G == 0:
        x = np.arange(-40e-7, 40e-7, 0.05e-7)
        Na, Nd = L.abrupt(x, N1, N2)
    else:
        half = 6 * G * 1e-7 + 60e-7
        x = np.arange(-half, half, 0.1e-7)
        Na, Nd = L.profile(x, N1, N2, G * 1e-7, G * 1e-7, 0.0, 1e15)
    j = L.Junction(x, Na, Nd)
    j.solve(0.0)
    pk = {"H": 0.0, "S": 0.0}
    for V in np.arange(0.01, 0.2, 0.01):
        j.solve(V)
        for k in pk:
            pk[k] = max(pk[k], -j.tunnel(F0=SETS[k][0], A=SETS[k][1])[0])
    return a, pk


VRD = -np.concatenate([[0.2, 0.3, 0.5, 0.75, 1.0, 1.5, 1.8, 2.0], np.arange(2.5, 14.1, 0.5)])


def job_c(a):
    Np, Nn, G, d, Nw = a
    Gc, dc = G * 1e-7, d * 1e-7
    half = dc / 2 + 6 * Gc + 60e-7
    x = np.arange(-half, half, 0.1e-7 if G <= 10 else 0.2e-7)
    j = L.Junction(x, *L.profile(x, Np, Nn, Gc, Gc, dc, Nw))
    j.solve(0.0)
    o = []
    for V in VRD:
        j.solve(V)
        iid = j.ion_integral(1.2, 1.5)
        o.append([V, j.tunnel(F0=SETS["H"][0], A=SETS["H"][1])[0], j.tunnel(F0=SETS["S"][0], A=SETS["S"][1])[0], iid])
        if iid > 1.5:
            break
    return a, np.array(o)


if __name__ == "__main__":
    out = open("b20_ancla.txt", "w")
    def P(s=""):
        print(s); out.write(s + "\n")
    P(subprocess.check_output(["date"]).decode().strip())
    P("Juegos: H: F0 = %.3g, A = %.3g ; S: F0 = %.3g, A inicial = %.3g" % (SETS["H"] + SETS["S"]))
    P()
    P("== (a) Solomon: J_modelo / J_Solomon(w = camino de tunel mas corto a esa tension). Rango medido por Solomon: union 2e18-7e19.")
    ja = [("abr", n, n, 0) for n in (2e19, 5e19, 1e20, 2e20)] + [("abr", 2e19, 1e20, 0), ("abr", 5e18, 1e20, 0)] + \
         [("log", n, n, g) for n in (5e19, 1e20, 2e20) for g in (3, 5, 10, 20)]
    with Pool(6) as pool:
        ra = pool.map(job_a, ja)
    P("perfil                    V     | H: J(A/cm2)  w(nm)  J/Jsol | S: J(A/cm2)  w(nm)  J/Jsol")
    rat = {"H": [], "S": []}
    for a, o in ra:
        for V, JH, lH, JS_, lS in o:
            P("%-4s %.0e/%.0e G%-3d  %5.1f  | %9.2e  %5.2f  %7.2f | %9.2e  %5.2f  %7.2f" % (a[0], a[1], a[2], a[3], V, JH, lH * 1e7, JH / sol(lH), JS_, lS * 1e7, JS_ / sol(lS)))
            if 3e-7 < lH < 9e-7:
                rat["H"].append((lH, JH / sol(lH))); rat["S"].append((lS, JS_ / sol(lS)))
    for k in rat:
        r = np.array([v for _, v in rat[k]])
        P("juego %s, caminos 3-9 nm: mediana J/Jsol = %.2f ; minimo %.2g ; maximo %.2g ; dispersion (decadas, p10-p90) %.2f" % (
            k, np.median(r), r.min(), r.max(), np.log10(np.percentile(r, 90) / np.percentile(r, 10))))
    cS = 1.0 / np.median([v for _, v in rat["S"]])
    P("=> A_S calibrado = %.3g (factor %.2f sobre el inicial); cA_S respecto a 4e14 = %.1f" % (SETS["S"][1] * cS, cS, SETS["S"][1] * cS / 4e14))
    AS = SETS["S"][1] * cS
    P()
    P("== (b) Esaki de silicio: Jp del modelo (solo tunel directo) frente a lo publicado")
    P("Publicado (LEIDA, tesis Zhao 2007): Neff = NaNd/(Na+Nd) ~ 2.5e19 -> Jp = 26 A/cm2 (PVR 1.25); Neff ~ 4e19 a ~4-5 nm/dec -> 155 A/cm2.")
    P("Koga-Toriumi (LEIDA de segunda mano): implante 25-30 keV, 1000 C 30 s: ~10 A/cm2, PVR ~2 (dopados [?]).")
    P("Solomon (LEIDA): Rivas/Dashiell, w = 4.3 nm en el pico: su ley da ~1500 A/cm2 y lo medido es ~10 veces mas.")
    jb = [(5e19, 5e19, g) for g in (0, 3, 5)] + [(8e19, 8e19, g) for g in (0, 3, 5)] + [(3e19, 2e20, 0), (5e19, 2e20, 0), (4e19, 1e21, 0), (2.5e19, 1e21, 0)]
    with Pool(6) as pool:
        rb = pool.map(job_b, jb)
    P("Na      Nd      G(0=abrupta)  Neff     Jp H (A/cm2)  Jp S calibrado (A/cm2)")
    for a, pk in rb:
        P("%.1e %.1e  %3d         %.1e  %9.2e     %9.2e" % (a[0], a[1], a[2], a[0] * a[1] / (a[0] + a[1]), pk["H"], pk["S"] * cS))
    P()
    P("== (c) Dutta, TSMC 65 nm, p+/n+ lateral en pozo n (N ~ 1e17 por su TCAD), W = 47.6 um, xj 100-200 nm (se toma 150 nm)")
    P("Medido (LEIDA-FIG): VBR(1 mA = 21 uA/um): d=0: 1.8 V; 20: 2.5; 40: 3.35; 60: 4.25; 80: 5.15; 100: 5.95; 140: 7.3; 200: 8.5; >=240: 9.0-9.3")
    P("Medido d = 0, 25 C: I/W (uA/um) a -0.2 V ~0.02; -0.5: 0.3; -1.0: ~2.3; -1.5: ~11; -1.8: 23")
    xj = 0.15e-4
    lev = 21e-6 / (1e-4 * xj)          # A/cm2
    DSD = (0, 20, 40, 60, 100, 140, 200)
    prof = [(1e20, 1e20, 5), (1e20, 1e20, 10), (1e20, 2e20, 10), (2e20, 2e20, 5), (2e20, 2e20, 10), (2e20, 2e20, 15), (2e20, 2e20, 20),
            (3e20, 3e20, 10), (3e20, 3e20, 20), (1e20, 2e20, 20), (2e20, 2e20, 30)]
    jc = [p + (d, 1e17) for p in prof for d in DSD]
    with Pool(6) as pool:
        rc = dict(pool.map(job_c, jc))
    for k, col in (("H", 1), ("S", 2)):
        sc = 1.0 if k == "H" else cS
        P("-- juego %s:  VBR(21 uA/um) por d (nm) | I/W en d = 0 (uA/um) a -0.2, -0.5, -1.0, -1.8 V" % k)
        P("Np/Nn/G            " + "".join("%7d" % d for d in DSD) + "   |")
        for p in prof:
            row = ""
            for d in DSD:
                o = rc[p + (d, 1e17)]
                J = sc * o[:, col] / np.maximum(1 - o[:, 3], 1e-3)
                J = np.where(o[:, 3] >= 1, 1e30, J)
                if J[-1] < lev:
                    row += "%7s" % ">14"
                else:
                    i = int(np.argmax(J >= lev))
                    v = -o[i, 0] if i == 0 else -(o[i - 1, 0] + (o[i, 0] - o[i - 1, 0]) * (np.log(lev) - np.log(J[i - 1])) / (np.log(J[i]) - np.log(J[i - 1])))
                    row += "%7.2f" % v
            o = rc[p + (0, 1e17)]
            iw = [sc * np.exp(np.interp(v, -o[:, 0], np.log(o[:, col]))) * xj * 1e-4 * 1e6 for v in (0.2, 0.5, 1.0, 1.8)]
            P("%.0e/%.0e/%-3d   " % p + row + "   | " + "  ".join("%8.2e" % v for v in iw))
    out.close()
