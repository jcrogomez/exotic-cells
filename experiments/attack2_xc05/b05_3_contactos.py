"""b05 (3): contacto aislado (mcon o licon) como sitio de transformación. Cálculo analítico con supuestos barridos.
PDK: mcon 9,3 Ohm (tech l.5134; rcl1=9,3), licon a poly 152 Ohm (l.5133; rcp1=145,28), a n+ 185 (l.5126; rcn=182), a p+ 585 (l.5128);
tamaño 0,17x0,17 (tlef l.89); alturas: licon 0,3262->0,9361 (difusión) y 0,5062->0,9361 (poly); mcon 1,0361->1,3761, 0,34 um (tech l.5053-5057).
Límite LEF del mcon: 0,36 mA (tlef l.96).
Térmica (SUPUESTOS, DE MEMORIA): k_Si 100-150, k_poly 15-40, k_ox 1,0-1,4, k_W 100-170 W/mK.
 - licon sobre difusión: el calor se genera en la interfaz y se esparce en el silicio: R_th = 1/(4 k_Si a), a = radio equivalente.
 - licon sobre poly (0,18 um de poly sobre ~0,33 um de óxido de campo): aleta 1D de poly de ancho wp en las dos direcciones,
   R_th = 1/(2 sqrt(k_poly A G')), G' ~ k_ox (wp/t_fox + 1,5) (franja: SUPUESTO).
 - mcon: el calor sale por el met1 (aleta, G' de b05_1) y por el li; R_th = paralelo de dos brazos de met1 y dos de li.
Driver: I = min(N*0,257 mA, 1,8/(R + 2,7k/N))."""
import numpy as np
a_side = 0.17e-6; A = a_side ** 2; a = np.sqrt(A / np.pi)
print("b05_3_contactos. Área %.4f um2, radio equivalente %.3f um" % (A * 1e12, a * 1e6))
print("\n(3a) Densidad de corriente [A/cm2] frente a las líneas")
for I in (0.26e-3, 0.36e-3, 2.06e-3, 4.1e-3, 18.5e-3):
    print(f"  I = {I*1e3:5.2f} mA: contacto {I/A/1e4:.2e} ; met1 0,14x0,36 {I/(0.14e-6*0.36e-6)/1e4:.2e} ; li 0,17x0,10 {I/(0.17e-6*0.1e-6)/1e4:.2e}  ({I/0.36e-3:.1f}x el límite LEF del mcon)")
def fin_rth(k, Asec, Gp): return 1 / np.sqrt(k * Asec * Gp)   # un brazo semi-infinito
print("\n(3b) Potencia y dT por contacto (rango = extremos de los supuestos térmicos)")
cases = {'mcon (li-W-met1)': 9.3, 'licon sobre poly': 152.0, 'licon sobre n+': 185.0, 'licon sobre p+': 585.0}
def rth(name):
    if 'mcon' in name:
        out = []
        for kox_G, kT in ((2.75, 30), (1.97, 5.7)):
            m1 = fin_rth(166, 0.14e-6 * 0.36e-6, kox_G); li = fin_rth(kT, 0.17e-6 * 0.1e-6, kox_G * 1.2)
            out.append(1 / (2 / m1 + 2 / li))
        return min(out), max(out)
    if 'poly' in name:
        out = []
        for kp, kox, wp in ((40, 1.4, 0.5e-6), (15, 1.0, 0.27e-6)):
            Gp = kox * (wp / 0.33e-6 + 1.5); out.append(fin_rth(kp, wp * 0.18e-6, Gp) / 2)
        return min(out), max(out)
    return 1 / (4 * 150 * a), 1 / (4 * 100 * a)
print(f"{'contacto':<20}{'R Ohm':>7}{'Rth K/W':>22}" + "".join(f"{'N='+str(N)+': I mA / P mW / dT K':>34}" for N in (1, 8, 32, 72)))
for name, R in cases.items():
    lo, hi = rth(name); s = f"{name:<20}{R:>7.1f}{lo:>11.2e}-{hi:<10.2e}"
    for N in (1, 8, 32, 72):
        I = min(N * 0.257e-3, 1.8 / (R + 2700 / N)); P = I * I * R
        s += f"{I*1e3:>10.2f} /{P*1e3:>6.2f} /{P*lo:>6.0f}-{P*hi:<6.0f}"
    print(s)
print("  Línea de met1 0,14x10 um para comparar (b05_1, ronda 1): 1-2 K a 2,06 mA; 142 K a 18,5 mA. Línea de li: ver b05_2.")
print("  Nota: la R del PDK es la del contacto virgen a campo bajo; con unión p+/n o n+/p en serie el camino real es difusión-contacto-difusión")
print("  (dos contactos en serie más la hoja de difusión: 120/197 Ohm/sq). N=72 es 18,5 mA: 9 veces EFLD-01.")
print("\n(3c) Calor por unidad de volumen en el sitio (P / volumen caliente supuesto), a 2,06 mA")
for name, R, vol in (('mcon: tapón entero 0,17x0,17x0,34', 9.3, A * 0.34e-6), ('licon-poly: disco de interfaz 0,17x0,17x0,02', 152, A * 20e-9), ('li 0,17x0,10 por um', 75.3, 0.17e-6 * 0.1e-6 * 1e-6), ('met1 0,14x0,36 por um', 0.89, 0.14e-6 * 0.36e-6 * 1e-6)):
    I = 2.06e-3; print(f"  {name:<46} P = {I*I*R*1e6:7.1f} uW   {I*I*R/vol:.2e} W/m3")
