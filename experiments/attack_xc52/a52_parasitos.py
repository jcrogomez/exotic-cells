#!/usr/bin/env python
"""a52_parasitos.py — (c) explicación aburrida cuantificada y (d) bombeo de carga / diodo con puerta.

Entradas con grado:
  PDK local: alturas, Rs, vth0/k1/ndep/toxe (ver a52_INFORME.md).
  corrida propia: bobinas de a52_coil.txt (62,7 ohm / 0,257 mT/mA ancho mínimo; 12,5 ohm / 0,265 mT/mA ancho 1,5 µm).
  DE MEMORIA: constantes térmicas (k, rho*c), sigma de captura 1e-16..1e-15 cm2, vth 1e7 cm/s, ni 1e10 cm-3,
              eps_ox 3,9; coeficientes de temperatura (derivados abajo de ni(T)).
  fuente LEÍDA: Dit sin estrés 1,17e10 cm-2 eV-1 (Sharov, OSTI 1899505, tabla I); ~1e9 cm-2 fresco (Hori y Ono, arXiv 2008.11857);
                fórmula dc-IV (Harmon 2020, arXiv 2008.08121, ec. 1).
"""
import numpy as np

q, kB, eps0, mu0 = 1.602e-19, 1.381e-23, 8.854e-12, 4e-7 * np.pi
T = 300.0
Vt = kB * T / q
print(f"Vt = {Vt*1e3:.2f} mV")

# ---------------------------------------------------------------- (c1) inducción
print("\n## (c1) fem inducida = 2*pi*f*B*A  (seno; para flanco cuadrado de subida tr: B*A/tr)")
print("lazo            B[mT]  f=100kHz    1MHz      10MHz   | dI/I a f en dc-IV (fem/2Vt) a 10 MHz | rectificado par (x^2/4)")
for name, A in (("10x10 um", 1e-10), ("20x20 um", 4e-10), ("100x100 um", 1e-8)):
    for B in (1e-3, 3e-3):
        e = [2 * np.pi * f * B * A for f in (1e5, 1e6, 1e7)]
        x = e[2] / (2 * Vt)
        print(f"{name:12s}  {B*1e3:4.0f}   {e[0]*1e6:8.3f} uV {e[1]*1e6:8.3f} uV {e[2]*1e6:8.2f} uV |  {x:9.2e}  | {x*x/4:9.2e}")

# ---------------------------------------------------------------- (c2) capacitivo
print("\n## (c2) acoplo capacitivo bobina -> nodo de lectura (placa paralela, eps_r=3,9, sin blindaje)")
print("   C_c = eps*A_nodo*relleno/h ; i_c(f) = 2*pi*f*C_c*V_media ; V_media = I*R/2 (bobina referida a un extremo)")
coils = {"met3 w=0,3 (62,7 ohm)": 62.7, "met3 w=1,5 (12,5 ohm)": 12.5}
h = 2.88e-6
for cname, R in coils.items():
    Vm = 10e-3 * R / 2
    print(f" bobina {cname}: V_media a 10 mA = {Vm*1e3:.0f} mV")
    for side, fill in ((1, 0.5), (3, 0.5), (10, 0.6)):
        # nodo = placa del dispositivo + cableado local (x2, barrido 1..4 en el informe)
        Cc = eps0 * 3.9 * (side * 1e-6) ** 2 * fill / h * 2
        ic = [2 * np.pi * f * Cc * Vm for f in (1e5, 1e6, 1e7)]
        Cnode = 12.4e-15
        dV = Cc / (Cc + Cnode) * Vm
        rect = (dV / (2 * Vt)) ** 2 / 4
        print(f"   nodo {side:2d}x{side:<2d} um: C_c={Cc*1e18:7.1f} aF | i_c = {ic[0]*1e12:8.2f} pA (100k) {ic[1]*1e12:8.1f} pA (1M) {ic[2]*1e12:9.1f} pA (10M)"
              f" | excursion en nodo flotante de 12,4 fF: {dV*1e3:6.3f} mV -> rectificacion par en dc-IV {rect:8.1e}")
print("   Blindaje a tierra (met1/met2): divide C_c por 1e2..1e3 (BARRIDO, no calculado con solver de campo): rectificacion cae 1e4..1e6.")
print("   Corriente de bombeo de referencia: 10x10 um, 10 MHz, Dit 1e10: ver (d). Senal 1e-4 de 13 nA = 1,3 pA.")
# corrientes de Foucault en el blindaje
Rsq, a = 0.125, 20e-6
L = mu0 * a
for f in (1e6, 1e7):
    print(f"   blindaje met1 macizo de {a*1e6:.0f} um: wL/R_hoja a {f/1e6:.0f} MHz = {2*np.pi*f*L/Rsq:.1e} (<<1: transparente al campo)")

# ---------------------------------------------------------------- (c3) térmico
print("\n## (c3) térmico. Coeficientes de temperatura (cálculo):")
Eg = 1.12
dln_ni = 1.5 / T + Eg / (2 * (kB / q) * T * T)
for VF in (0.3, 0.4):
    print(f"   dc-IV a VF={VF}: dlnI/dT = dln(ni)/dT - VF/(2*k*T^2/q) = {100*(dln_ni - VF/(2*(kB/q)*T*T)):.2f} %/K")
print(f"   generacion/fuga (ni): {100*dln_ni:.2f} %/K ; bombeo de carga: -(2k/q)*ln(arg)/dE ~ -0,3 %/K (ver d)")
kSi, cSi, kox, cox = 148.0, 1.63e6, 1.2, 1.6e6
eSi = np.sqrt(kSi * cSi)


def T_si_1d(qflux, f, hox):
    """Amplitud de T en la superficie del Si, calentador sobre losa de óxido hox, Si semi-infinito, 1D, cara superior aislada."""
    w = 2 * np.pi * f
    g = np.sqrt(1j * w * cox / kox)
    return abs(qflux / (kox * g * np.sinh(g * hox) + np.cosh(g * hox) * eSi * np.sqrt(1j * w)))


print("   Onda térmica 1D calentador(metal)->óxido(2,88 um)->Si, acotada por el valor estacionario 3D (0,4732*P/(k*lado)).")
print("   Corriente senoidal bipolar a f: potencia alterna P0/2 a 2f (misma armónica que una señal par en B).")
cases = {"met3 w=0,3 N=5 (6,27 mW, lado 22,6 um)": (6.27e-3, 22.6e-6), "met3 w=1,5 N=5 (1,25 mW, lado 28,7 um)": (1.25e-3, 28.7e-6)}
for cname, (P0, side) in cases.items():
    dc = 0.4732 * P0 / (kSi * side)
    print(f"  {cname}: dT_Si estacionario (potencia media) = {dc*1e3:.0f} mK")
    for f in (1e3, 1e4, 1e5, 1e6, 1e7):
        Pac = P0 / 2
        t1 = T_si_1d(Pac / side**2, 2 * f, h)
        t = min(t1, 0.4732 * Pac / (kSi * side))
        print(f"     f_bobina={f:8.0f} Hz (calor a {2*f:9.0f} Hz): dT_Si alterna = {t*1e3:10.4f} mK -> dc-IV {t*0.0577:9.2e} ; bombeo {t*0.003:9.2e} (relativo)")
print("   Señal 1e-4 equivale a 1,7 mK (dc-IV) o 33 mK (bombeo).")

# ---------------------------------------------------------------- (d) bombeo de carga
print("\n## (d) Bombeo de carga")
ni, vth = 1.0e10, 1.0e7
print("  Vfb implícito de BSIM4 (vfb = vth0 - phi_s - k1*sqrt(phi_s), phi_s = 2Vt ln(ndep/ni) [+0,4 de BSIM4.5+ no incluido]):")
for name, vth0, k1, ndep in (("nfet_01v8", 0.519, 0.5409, 1.7e17), ("pfet_01v8", 1.0596, 0.4345, 1.7e17),
                             ("nfet_g5v0d10v5", 0.7888, 0.8833, 1.7e17), ("pfet_g5v0d10v5", 1.0110, 0.5952, 1.7e17)):
    phis = 2 * Vt * np.log(ndep / 1.45e10)
    vfb = vth0 - phis - k1 * np.sqrt(phis)
    win = vth0 - vfb
    print(f"   {name:16s} |vth0|={vth0:.3f} V phi_s={phis:.3f} Vfb_eq={vfb:+.3f} V  ventana |Vth-Vfb|={win:.2f} V ; margen total con pulso de 1,8 V = {1.8-win:.2f} V"
          f" ({(1.8-win)/2:.2f} V por lado si el cuerpo se centra)")
print("   nfet sobre sustrato a 0 V con puerta 0..1,8 V: Vgb_min = 0 > Vfb = -0,81 V -> nunca acumula (queda en agotamiento).")
print("   Densidad mayoritaria necesaria para llenar en media fase de 10 MHz (50 ns): n > 1/(sigma*vth*t) =",
      f"{1/(1e-15*vth*50e-9):.1e} cm-3 (sigma 1e-15) .. {1/(1e-16*vth*50e-9):.1e} (sigma 1e-16); pozo: 1,7e17")
print("  Icp = q*f*A*Dit*dE ; dE = -2kT ln( vth*ni*sigma*sqrt(tr*tf)*|Vfb-Vt|/dVg )  (Groeseneken 1984, fórmula DE MEMORIA)")
for tr in (1e-9, 1e-8):
    for sig in (1e-15, 1e-16):
        arg = vth * ni * sig * tr * (1.24 / 1.8)
        dE = -2 * Vt * np.log(arg)
        print(f"   tr=tf={tr*1e9:.0f} ns sigma={sig:.0e}: dE = {dE:.2f} eV ; d(dE)/dT/dE = {100*(-2*(kB/q)*np.log(arg))/dE/ T * 0 + 100*(2*(kB/q)*np.log(arg))/dE:.2f} %/K (solo el término explícito)")
dE = 0.75
print(f"  Tabla con dE = {dE} eV (tr 1..10 ns, sigma 1e-15..1e-16 -> 0,73..0,97 eV):")
print("   Dit[cm-2eV-1]   area    trampas   Icp(1 MHz)   Icp(10 MHz)  | señal 1e-4 a 10 MHz | cargas/ciclo de señal")
for Dit, src in ((1e9, "Hori fresco ~1e9 cm-2"), (1.17e10, "Sharov sin estrés"), (1e11, "tras estrés FN (Hori)"), (1e12, "Moxim/Sharov estresado")):
    for side in (1, 3, 10):
        A = (side * 1e-4) ** 2
        N = A * Dit * dE
        print(f"   {Dit:8.2e}  {side:2d}x{side:<2d} um {N:9.1f}  {q*1e6*N*1e12:10.3f} pA {q*1e7*N*1e12:10.2f} pA |  {q*1e7*N*1e-4*1e15:9.3f} fA     | {N*1e-4:8.4f}   [{src}]")
print("  Diodo con puerta (dc-IV): Imax = (q/2)*ni*sigma*vth*Dit*A*(q|VF|)*exp(q|VF|/2kT)   (Harmon 2020 ec. 1)")
for Dit in (1e9, 1.17e10, 1e12):
    for sig in (1e-16, 1e-15):
        row = []
        for VF in (0.3, 0.4):
            for side in (1, 10):
                A = (side * 1e-4) ** 2
                I = 0.5 * q * ni * sig * vth * Dit * A * VF * np.exp(VF / (2 * Vt))
                row.append(f"VF={VF} {side}x{side}: {I*1e12:9.4f} pA")
        print(f"   Dit={Dit:8.2e} sigma={sig:.0e} | " + " | ".join(row))
print("  Comprobación contra Harmon 2020 fig. 7a (leída): A=4,1e-4 cm2, 1 Mrad, VF=0,3 -> ~5e-9 A  => Dit*sigma =",
      f"{5e-9/(0.5*q*ni*vth*4.1e-4*0.3*np.exp(0.3/(2*Vt))):.2e} (p.ej. Dit 1e11 con sigma 1,5e-16)")
