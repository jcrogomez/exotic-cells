#!/usr/bin/env python3
"""c63 (b): contacto de 0,17 x 0,17 um sobre silicio sin implante, como diodo de barrera (emisión termoiónica + fuerza imagen).
BARRIDO, no predicción: altura de barrera 0,45-0,70 eV (rango de lo leído para TiSi2/Ti/TiN/W, c63_lit_barreras.txt),
dopado 5e16-2e17 (no público), A* 112 (n) y 32 (p) A/cm2K2 (fragmento, sin leer). Sin túnel (E00 se imprime: << kT),
sin efecto de borde del contacto (subestima la inversa), sin generación en la zona vaciada. Salida c63_barrera.txt"""
import numpy as np
q, kB, e0 = 1.602e-19, 1.381e-23, 8.854e-14; es = 11.7 * e0; A = 0.17e-4 ** 2
def mu_n(N): return 92 + 1268 / (1 + (N / 1.3e17) ** 0.91)          # Arora/Masetti aproximado, de memoria
def mu_p(N): return 54.3 + 406.9 / (1 + (N / 2.35e17) ** 0.88)
def run(T, phi, N, typ="n", VR=1.8):
    kT = kB * T / q; Ast = 112 if typ == "n" else 32; Nc = (2.8e19 if typ == "n" else 1.04e19) * (T / 300) ** 1.5
    vbi = phi - kT * np.log(Nc / N)
    Em = np.sqrt(2 * q * N * (max(vbi, 0.05) + VR) / es); dphi = np.sqrt(q * Em / (4 * np.pi * es))
    Em0 = np.sqrt(2 * q * N * max(vbi, 0.05) / es); dphi0 = np.sqrt(q * Em0 / (4 * np.pi * es))
    I0 = A * Ast * T * T * np.exp(-(phi - dphi0) / kT); IR = A * Ast * T * T * np.exp(-(phi - dphi) / kT)
    return I0, IR, dphi, Em
out = ["c63_barrera: contacto 0,17x0,17 um (2,89e-10 cm2). I0 = saturación a 0 V; IR = inversa a 1,8 V con fuerza imagen.",
       "Piso del lector de precarga: 150 fA (modelado, 27 C). Vf = caída directa ideal (n=1,05) a 1 nA / 1 uA / 100 uA SIN y CON resistencia serie.", ""]
for typ, Ns in (("n", (5e16, 1e17, 2e17)), ("p", (1e16, 1e17))):
    for N in Ns:
        mu = mu_n(N) if typ == "n" else mu_p(N); rho = 1 / (q * N * mu); r = 0.17e-4 / np.sqrt(np.pi); Rsp = rho / (4 * r)
        E00 = 18.5e-15 * np.sqrt(N * 1e6 / ((0.26 if typ == 'n' else 0.39) * 11.7))
        out.append(f"silicio {typ}, N={N:.0e} cm-3: rho={rho:.3f} ohm cm, R dispersión (disco equivalente) = {Rsp/1e3:.1f} kohm; E00={E00*1e3:.1f} meV (kT=25,9)")
        out.append(f"  {'phiB':>5s} {'I0(27C)':>10s} {'IR(27C)':>10s} {'IR/piso':>8s} {'IR(85C)':>10s} {'dphi mV':>7s} {'Emax MV/cm':>10s} {'Vf 1nA':>7s} {'Vf 1uA':>7s} {'Vf100uA':>8s} {'+R·I 100uA':>10s}")
        for phi in (0.45, 0.50, 0.55, 0.57, 0.60, 0.65, 0.70):
            I0, IR, dphi, Em = run(300.15, phi, N, typ); _, IR85, _, _ = run(358.15, phi, N, typ)
            vf = [1.05 * 0.025865 * np.log(I / I0 + 1) for I in (1e-9, 1e-6, 1e-4)]
            out.append(f"  {phi:5.2f} {I0:10.2e} {IR:10.2e} {IR/150e-15:8.1f} {IR85:10.2e} {dphi*1e3:7.1f} {Em/1e6:10.2f} {vf[0]:7.3f} {vf[1]:7.3f} {vf[2]:8.3f} {vf[2]+Rsp*1e-4:10.3f}")
        out.append("")
out += ["Resistencia del pozo hasta la toma n+: hoja 950 (Magic) a 1700 (rnw) ohm/cuadro x 1-3 cuadros = 1-5 kohm, más la dispersión de arriba.",
        "Referencia p-n: un p+/pozo n del mismo tamaño tiene Is ~1e-20..1e-18 A (orden, de memoria): cae ~0,25-0,35 V más que la barrera a igual corriente."]
open("c63_barrera.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
