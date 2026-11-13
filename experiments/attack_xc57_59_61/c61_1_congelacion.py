"""c61_1: fracción ionizada frente a T en silicio para los dopados de SKY130 (leídos por agente en skywater-pdk 'assumptions':
pozo n pico 6e17, fondo 8e14, pozo p pico 4e17) y barrido 1e14..2e18. Estadística estándar con compensación:
 n(n+Nk)/(N-Nk-n) = (Nc/g) exp(-Ed/kT). Ed baja con el dopado: Ed = Ed0 - 3.1e-8*N^(1/3) eV (Pearson-Bardeen, DE MEMORIA; se da con y sin).
No incluye conducción por saltos/banda de impurezas (importante sobre ~1e17-1e18): por eso 'congelado' aquí = portadores libres, no resistencia."""
import numpy as np
from scipy.optimize import brentq
kB = 8.617e-5; out = []; P = out.append
def frac(N, T, typ, K=0.0, pb=True):
    Ed0, g, NcN = (0.0456, 2, 2.8e19) if typ == 'n' else (0.045, 4, 1.83e19)
    Ed = max(Ed0 - (3.1e-8*N**(1/3) if pb else 0), 0.002)
    Nc = NcN*(T/300)**1.5; A = Nc/g*np.exp(-Ed/(kB*T)); Nk = K*N
    f = lambda n: n*(n+Nk) - A*(N-Nk-n)
    n = brentq(f, 0, N-Nk); return n/N
Ts = (300, 150, 77, 50, 30, 20, 10, 4.2)
for pb in (False, True):
    P(f"\n# fracción de portadores libres n/N ; Ed {'reducida por dopado (Pearson-Bardeen)' if pb else 'fija 45 meV'} ; compensación K=0.01")
    P("# tipo N cm-3 | " + " | ".join(f"{T} K" for T in Ts))
    for typ, N in (('p', 1e14), ('p', 8e14), ('p', 1e16), ('p', 1e17), ('p', 4e17), ('n', 5e16), ('n', 1e17), ('n', 6e17), ('n', 2e18)):
        P(f"{typ} {N:.0e} | " + " | ".join(f"{frac(N, T, typ, 0.01, pb):.2e}" for T in Ts))
P("\n# Temperaturas de 50 % y de 1e-3 (K=0.01), Ed fija / Ed reducida")
for typ, N in (('p', 1e14), ('p', 8e14), ('p', 1e16), ('p', 4e17), ('n', 5e16), ('n', 1e17), ('n', 6e17)):
    r = []
    for pb in (False, True):
        for target in (0.5, 1e-3):
            try: r.append(brentq(lambda T: frac(N, T, typ, 0.01, pb)-target, 3, 600))
            except Exception: r.append(float('nan'))
    P(f"{typ} {N:.0e}: T50 = {r[0]:.0f} / {r[2]:.0f} K ; T(1e-3) = {r[1]:.0f} / {r[3]:.0f} K")
P("\n# Campo y tensión: E_ruptura leído solo para Si:P 5e13: 125-240 V/cm a 18-37 K (Lawaetz y Proctor 1980). Para MOSFET (cuerpo ~1e17):")
P("# 1.2e4 V/cm a 4.2 K (Simoen y Claeys, NO LEÍDO). Tensión sobre un tramo d:")
for d in (0.27, 1, 2, 10, 50):
    P(f"  d={d} um: 125 V/cm -> {125*d*1e-4*1e3:.1f} mV ; 1.2e4 V/cm -> {1.2e4*d*1e-4:.2f} V ; con 1.8 V el campo es {1.8/(d*1e-4):.0f} V/cm")
P("\n# Resistencia de un resistor de pozo p aislado (res_iso_pw, 3050 ohm/sq, PDK l. 5105) de 10 cuadros: 30.5 kohm a 300 K;")
P("# con n/N de la tabla y movilidad sin cambio: 77 K x%.1f ; 30 K x%.1e ; 10 K x%.1e (límite superior: los saltos lo acotan)" % (frac(4e17, 300, 'p', .01)/frac(4e17, 77, 'p', .01), frac(4e17, 300, 'p', .01)/frac(4e17, 30, 'p', .01), frac(4e17, 300, 'p', .01)/frac(4e17, 10, 'p', .01)))
P("# Oscilador de relajación tipo Coon-Perera: periodo ~ R_L*C_L. Con C = 10 fF..1 pF y R_L = 1 Mohm..1 Gohm: f = %.0e .. %.0e Hz" % (1/(1e9*1e-12), 1/(1e6*1e-14)))
open("c61_1_congelacion.txt", "w").write("\n".join(out)+"\n"); print("\n".join(out))
