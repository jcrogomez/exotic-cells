"""b05 (4): qué abertura de grieta cae en la ventana de lectura, y qué no linealidad hay a baja tensión. Cálculo (Simmons 1963, fórmulas DE MEMORIA).
Baja tensión, barrera rectangular de altura phi y ancho s, masa libre, sin fuerza imagen (la fuerza imagen baja la barrera: R real menor):
  G/A = (3 sqrt(2 m phi) / (2 s)) (e/h)^2 exp(-(4 pi s / h) sqrt(2 m phi))
Tensión intermedia: I = G V (1 + g V^2),  g = (Ae)^2/(96 phi) - A e^2/(32 phi^1.5) con A = 4 pi s sqrt(2m)/h (phi en J).
Áreas: grieta que cruza la barrera de met1 (0,14 um x 30 o 75 nm), el li (0,17 x 0,10 um), o una sola aspereza de 1 nm2.
phi barrido 1-4,5 eV: ~3-4 eV metal/SiO2, 4,5 vacío, 1-2 óxido defectuoso (SUPUESTO; no hay dato)."""
import numpy as np
h = 6.626e-34; e = 1.602e-19; m = 9.109e-31; G0 = 2 * e * e / h
def GA(s, phi): return (3 * np.sqrt(2 * m * phi * e) / (2 * s)) * (e / h) ** 2 * np.exp(-(4 * np.pi * s / h) * np.sqrt(2 * m * phi * e))
def gcub(s, phi):
    A = 4 * np.pi * s * np.sqrt(2 * m) / h; p = phi * e
    return (A * e) ** 2 / (96 * p) - A * e * e / (32 * p ** 1.5)
areas = {'met1 barrera A 0,14um x 30nm': 0.14e-6 * 30e-9, 'met1 barrera B 0,14um x 75nm': 0.14e-6 * 75e-9, 'li 0,17 x 0,10 um': 0.17e-6 * 0.1e-6, 'aspereza 1 nm2': 1e-18}
print("b05_4_tunel. 1/G0 = %.0f Ohm" % (1 / G0))
print("\n(4a) Resistencia de túnel [Ohm] frente a abertura s")
ss = (0.2, 0.3, 0.5, 0.7, 1.0, 1.3, 1.6, 2.0, 3.0)
for an, Ar in areas.items():
    print(f"  {an}")
    for phi in (1.0, 2.0, 3.1, 4.5):
        print(f"    phi={phi:>3} eV: " + " ".join(f"{s}nm:{1/(GA(s*1e-9,phi)*Ar):8.1e}" for s in ss))
print("\n(4b) Abertura [nm] que da 100 Ohm / 12,9 kOhm / 1 MOhm / 1 GOhm (bisección)")
def s_for(R, Ar, phi):
    lo, hi = 0.02e-9, 10e-9
    for _ in range(60):
        mid = (lo + hi) / 2
        if 1 / (GA(mid, phi) * Ar) > R: hi = mid
        else: lo = mid
    return lo * 1e9
for an, Ar in areas.items():
    for phi in (1.0, 3.1, 4.5):
        print(f"  {an:<30} phi={phi}: " + " / ".join(f"{s_for(R,Ar,phi):.2f}" for R in (100, 12906, 1e6, 1e9)) + f"   -> ventana 100 Ohm-1 MOhm = {s_for(1e6,Ar,phi)-s_for(100,Ar,phi):.2f} nm de ancho")
print("  (aberturas < ~0,25 nm no son un hueco: es contacto. Ahí la fórmula deja de valer.)")
print("\n(4c) No linealidad: término cúbico relativo g V^2 a 25 / 50 / 100 / 300 mV")
for phi in (1.0, 3.1, 4.5):
    for s in (0.5, 1.0, 2.0):
        g = gcub(s * 1e-9, phi)
        print(f"  phi={phi} eV s={s} nm: " + "  ".join(f"{V*1e3:.0f}mV:{g*V*V*100:7.3f}%" for V in (0.025, 0.05, 0.1, 0.3)))
print("  Contacto metálico de pocos canales: óhmico a estas tensiones (transmisión casi constante en una escala de eV): ~0 %.")
print("  Resistencia difusiva con autocalentamiento: dR/R = TCR * dT(V); con V=50 mV sobre 10 kOhm son 0,25 uW: dT < 0,1 K con Rth <= 4e5 K/W: < 0,03 %.")
print("\n(4d) De dónde saldría una grieta de esa escala (cálculo, SUPUESTO alfa_TiN 9,4e-6 /K, alfa_SiO2 0,5e-6 /K DE MEMORIA):")
print("     contracción libre al enfriar un tramo de largo L desde T_pico: d = (alfa_TiN - alfa_ox) * dT * L")
for L in (30e-9, 100e-9, 300e-9, 1000e-9):
    print(f"  L = {L*1e9:>5.0f} nm: " + "  ".join(f"dT={dT}K: {8.9e-6*dT*L*1e9:5.2f} nm" for dT in (400, 700, 1600)))
print("\n(4e) Lo que el lector distingue (piso 0,3 mV sobre 50 mV: ~0,6 % de la escala): ver b05_5.")
