#!/usr/bin/env python
"""b52_dinamica_clasico.py — (T1) banda de la señal frente al filtro térmico; (T2) tamaño de lo clásico y discriminación por forma.

Fuentes LEÍDAS usadas como entrada (texto abierto en scratchpad/a52_dl y b52_dl):
  Harmon et al., arXiv:2008.08121: Imax = 1/2 q^2 ni sigma vth A Dit |VF| exp(q|VF|/2kT) (ec. 1); dispositivo 41 000 um2;
     5e-9 A a VF=0,30 V (fig. 7a, leído por a52 de la figura); tasas del modelo kS, kD = 0,01–0,1 ns^-1 (figs. 5-6).
  Harmon 2023 (arXiv, harmon2023.txt l.294): kS = 0,16 ns^-1, kD = 0,08 ns^-1.
  Moxim et al. 2024 (JAP 135, 155703): kD = 0,00125 ns^-1; captura limitada a 400/133/80 ns a 1/3/5 MHz de bombeo;
     tboxcar 0–9 us; modulación de campo 210 Hz–1 kHz; horas de promediado.
  Lee, Paik, McCamey, Boehme, arXiv:1208.5573: en modulación lenta la señal en fase es constante; muy por encima de las
     tasas del par, fase y cuadratura tienden a cero.
  Cochrane et al., Sci. Rep. 6, 37077 (2016), SiC: modulación a audiofrecuencia; dI/I = 0,37 %; 440 nT/rtHz; ruido de disparo.
Supuestos (NO leídos): ni = 1e10 cm^-3, vth = 1e7 cm/s (memoria); Dit del dispositivo irradiado de Harmon NO dado -> 1e11–1e12.
Térmica: números de a52_parasitos (modelo 1D, constantes de memoria), no recalculados.
MODELO PROPIO (conjetura, no publicado): relajación de la ocupación de la trampa df/dt = cn n (1-f) - cp p f.
"""
import subprocess
import numpy as np

out = []


def P(*a):
    s = " ".join(str(x) for x in a)
    print(s); out.append(s)


q, kT = 1.602e-19, 0.02585
P("b52_dinamica_clasico.py — corrida:", subprocess.check_output(["date"]).decode().strip())
P("")
P("== T1.a Escalas de tiempo del par de espines (de las tasas leídas) ==")
for nm, k in (("Harmon 2020 kS,kD (bajo)", 0.01), ("Harmon 2020 (alto)", 0.1), ("Harmon 2023 kS", 0.16), ("Harmon 2023 kD", 0.08), ("Moxim 2024 kD", 0.00125)):
    P(f"  {nm:28s}: {k} ns^-1 -> vida {1/k:7.1f} ns -> corte 1/(2 pi tau) = {k*1e9/(2*np.pi)/1e6:8.2f} MHz")
P("  anchura <-> tiempo: 1/(gamma dB), gamma = 28 GHz/T: 0,15 mT -> %.0f ns ; 0,5 mT -> %.0f ns ; 1,5 mT -> %.1f ns" % (
    1e9 / (2 * np.pi * 28e9 * 0.15e-3), 1e9 / (2 * np.pi * 28e9 * 0.5e-3), 1e9 / (2 * np.pi * 28e9 * 1.5e-3)))
P("  => el par en sí sigue al campo hasta 0,2–25 MHz. No es el eslabón lento.")
P("")
P("== T1.b Eslabón lento del dc-IV: el ciclo de la trampa (modelo propio) ==")
P("Estado estacionario: U = cn n cp p/(cn n + cp p). Si el campo cambia cn en una fracción d:")
P("  terminal que SUMINISTRA el portador con captura dependiente de espín: salto inmediato d, relaja a d*cp p/(cn n + cp p)  (no se pierde a alta f)")
P("  terminal del OTRO portador (cuerpo en un nfet): paso bajo de primer orden, tasa k = cn n + cp p")
ni, vth = 1e10, 1e7
P("  (i) con sigma supuesta y n = p = ni exp(qVF/2kT):")
P("   VF     n=p cm^-3   | sigma=1,5e-17: k s^-1, f_c | 1,5e-16 | 1e-15")
for VF in (0.30, 0.35, 0.40, 0.45, 0.50):
    n = ni * np.exp(VF / (2 * kT))
    r = []
    for s in (1.5e-17, 1.5e-16, 1e-15):
        k = 2 * s * vth * n
        r.append(f"{k:9.2e} {k/(2*np.pi)/1e3:9.3f} kHz")
    P(f"   {VF:.2f}  {n:9.2e}  | " + " | ".join(r))
P("  (ii) calibrado con la corriente de Harmon (5 nA a VF=0,30 en 4,1e-4 cm2), sin sigma: tasa por trampa U1 = I/(q A Dit qVF); k = 4 U1")
for Dit in (1e11, 3e11, 1e12):
    U1 = 5e-9 / (q * 4.1e-4 * Dit * 0.30)
    k = 4 * U1
    row = [f"VF={VF:.2f}: {k*np.exp((VF-0.30)/(2*kT))*(VF/0.30)/(2*np.pi)/1e3:8.3f} kHz" for VF in (0.30, 0.40, 0.50)]
    P(f"   Dit_irr={Dit:.0e}: U1 = {U1:8.1f} s^-1; f_c: " + " ; ".join(row))
P("  Advertencia: el texto de Harmon da 2e15–7e18 cm^-3 de portadores (eso es ni exp(qVF/kT), no /2kT). Con esas densidades f_c sería")
P("  %.0e veces mayor a VF=0,30. Es un intervalo de 2–5 décadas: se mide en silicio barriendo la frecuencia de modulación." % np.exp(0.30 / (2 * kT)))
P("")
P("== T1.c Ventana: señal (terminal lento) frente a calor síncrono con UNA bobina (calor de a52) ==")
therm = {1e3: (4e-3, 2.6e-2), 1e4: (4e-3, 2.6e-2), 1e5: (3e-4, 2.7e-3), 1e6: (3e-7, 3e-6)}
P("  f_mod   calor par (dc-IV)      | señal atenuada 1/sqrt(1+(f/fc)^2), delta0=3e-4 (VF 0,30) fc=0,16–1,6 kHz | delta0=3e-5 (VF 0,50) fc=8–76 kHz")
for f, (t1, t2) in therm.items():
    a = [3e-4 / np.sqrt(1 + (f / fc) ** 2) for fc in (160, 1600)]
    b = [3e-5 / np.sqrt(1 + (f / fc) ** 2) for fc in (8e3, 76e3)]
    P(f"  {f:7.0e}  {t1:.0e}–{t2:.0e}   | {a[0]:.1e}–{a[1]:.1e}  (señal/calor {a[0]/t2:.1e}–{a[1]/t1:.1e}) | {b[0]:.1e}–{b[1]:.1e}  ({b[0]/t2:.1e}–{b[1]/t1:.1e})")
P("  Bombeo de carga (cada ciclo independiente; banda = f_cp/2). Calor en bombeo: -0,3 %/K (a52): 1 MHz -> 2e-8–1,5e-7; señal 1e-7–1e-5 (Hori, leído).")
P("")
P("== T2.a Tamaño de lo clásico a 2 mT ==")
B = 2e-3
for nm, mu in (("electrón, volumen (memoria)", 0.14), ("canal nfet (memoria)", 0.04), ("hueco (memoria)", 0.045), ("pozo n 1e17 (Arora, a52)", 0.0777)):
    P(f"  magnetorresistencia ordinaria (mu B)^2, {nm:28s} mu={mu:.3f}: {(mu*B)**2:.1e}; ángulo Hall mu B = {mu*B:.1e} rad")
x = 9.274e-24 * B / (1.381e-23 * 300)
hw = 1.055e-34 * 1.602e-19 * B / (0.26 * 9.109e-31) / q
P(f"  polarización de espín g muB B/2kT = {x:.1e}; efecto termodinámico en ni ~ x^2/2 = {x*x/2:.1e}")
P(f"  Landau: hbar w_c = {hw*1e6:.2f} ueV (m*=0,26); corrección (hw/2kT)^2/6 = {(hw/(2*kT))**2/6:.1e}")
P("  Zeeman a 2 mT: %.2f ueV frente a kT = 25,9 meV" % (2 * 9.274e-24 * B / q * 1e6))
P("  => todo lo clásico o termodinámico que es par en B queda en 1e-11–1e-7: de 2,5 a 7 décadas bajo 3e-5.")
P("")
P("== T2.b Forma: fracción de una lorentziana vista con +-2 mT, y coste de separar 'satura' de 'parábola' ==")
Bp = np.array([0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0])
P("  Puntos |B| = %s mT (8 amplitudes; cada una se mide contra B=0 con la secuencia de 4 estados)." % Bp)
P("  T1 = tiempo para 5 sigma sobre la amplitud saturada A a un solo |B|. Ruido por punto: A/5 * sqrt(T1/Tp).")
P("  Gamma mT | fracción a 2 mT | fracción a 1 mT | chi2 de la mejor parábola si Tp = T1 | T_total (8 puntos) para rechazar la parábola a 5 sigma, en T1")
for G in (0.15, 0.3, 0.5, 1.0, 1.5, 3.0):
    L = Bp ** 2 / (Bp ** 2 + G ** 2)
    c = (L * Bp ** 2).sum() / (Bp ** 4).sum()
    chi = ((L - c * Bp ** 2) ** 2).sum() * 25
    P(f"  {G:5.2f}   | {4/(4+G*G):.2f}            | {1/(1+G*G):.2f}            | {chi:8.1f}                            | {8*25/chi:8.1f}")
P("  Asimetría por el campo terrestre b (0,02–0,05 mT vertical, memoria): [S(+B+b)-S(-B+b)]/A = 4 b B G^2/(B^2+G^2)^2;")
for G in (0.3, 0.5, 1.5):
    Bm = G / np.sqrt(3)
    P(f"     Gamma={G}: máx en |B|={Bm:.2f} mT: {4*0.04*Bm*G*G/(Bm*Bm+G*G)**2:.3f} de A con b=0,04 mT")
P("  Residuo del modo 'cancelado' (b52_bobinas): G2 apilada 0,27 mT de media a 10,2 mA; G3 cruzada 0,07 mT. Señal que queda en el 'cero':")
for G in (0.15, 0.5, 1.5):
    P(f"     Gamma={G}: G2 {0.27**2/(0.27**2+G*G):.2f} de A ; G3 {0.074**2/(0.074**2+G*G):.3f} de A  (el contraste se reduce en esa fracción)")
open(__file__.replace(".py", ".txt"), "w").write("\n".join(out) + "\n")
