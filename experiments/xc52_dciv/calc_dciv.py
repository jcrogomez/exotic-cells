"""XC-52 etapa 0 (DCIV en el chip): calculo de factibilidad, DISENO (no prediccion ni veredicto). Salida: calc_dciv.txt
Pico DCIV de recombinacion por trampas de interfaz (Fitzgerald-Grove; forma usada por Lenahan y col.):
    I_pico = (1/2) q ni sigma v_th Nit A exp(q VF / 2kT)
Entradas: sigma 1,5e-17 - 1e-15 cm^2 (b52_INFORME.md, fila Trampas: "no publico"), Nit 1e9 - 1e12 cm^-2 (W1_RESULTADO.md,
b52), v_th 1e7 cm/s y ni(T) = 9,65e9 (T/300)^1,5 exp(-Eg/2k (1/T - 1/300)) cm^-3 con Eg = 1,12 eV (aproximacion de libro, no PDK).
Lo que el modelo SPICE ya da a la misma polarizacion (el fondo) sale de fondo/ (ngspice), no de aqui."""
import math
q, k = 1.602e-19, 1.381e-23
def ni(T): return 9.65e9 * (T / 300) ** 1.5 * math.exp(-1.12 * q / (2 * k) * (1 / T - 1 / 300))
out = []
for T in (300.15, 358.15):
    for VF in (0.30, 0.40, 0.50):
        for A_um2 in (100, 1000, 10000):
            row = []
            for Nit in (1e9, 1e10, 1e11):
                lo = 0.5 * q * ni(T) * 1.5e-17 * 1e7 * Nit * A_um2 * 1e-8 * math.exp(q * VF / (2 * k * T))
                hi = lo * (1e-15 / 1.5e-17)
                row.append(f"Nit {Nit:.0e}: {lo:.2e}-{hi:.2e} A")
            out.append(f"T {T-273.15:.0f} C  VF {VF:.2f} V  A {A_um2:>5} um^2 | " + " | ".join(row))
open("calc_dciv.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
