#!/usr/bin/env python
"""b52_escenarios_lector.py — (T4) escenarios de trampas; (T5) presupuesto de ruido del lector; (T6) área del canal.

Entradas LEÍDAS:
  Corriente dc-IV: Imax = 1/2 q^2 ni sigma vth A Dit |VF| exp(q|VF|/2kT) (Harmon arXiv:2008.08121 ec. 1; Sharov OSTI 1899505 ec. 1).
  Dit virgen: ~1e9 cm^-2 a 300 K (Hori y Ono arXiv:2008.11857); 1,17e10 cm^-2 eV^-1 (Sharov tabla I); ~1e10 típico (Starkov, tesis TU Wien, node43).
  Dit tras estrés: 1,09e12 / 1,48e12 / 1,82e12 tras 20/40/60 min a -9 V sobre 7,5 nm (12 MV/cm) (Sharov tabla I);
     ~1e11 (Hori); 'HCD-induced Nit may easily reach 1e12' con tensiones sobre la nominal, 0,35 um (Starkov).
  dI/I (ESTIMACIÓN de a52 sobre la fig. 7 de Harmon, x3): 3e-4 (VF 0,30–0,33), 1e-4 (0,45), 3e-5 (0,50). Bombeo: 1e-7–1e-5 (Hori, leído).
  Dit*sigma = 1,5e-5 en el dispositivo irradiado de Harmon (a52) -> sigma 1,5e-17..1,5e-16 si Dit_irr = 1e12..1e11.
NO LEÍDO / NO PÚBLICO (se barre): Dit de SKY130; sigma; cuántas trampas crea 3,3 V (8 MV/cm) o 1,8 V (4,3 MV/cm) en 4,15 nm
  (tres búsquedas sin texto abierto -> [?]); densidad en el borde del aislamiento (resumen ilegible: [?]) -> factor 1–10 supuesto;
  fracción paramagnética (centros Pb) de las trampas de un óxido pasivado: [?] 0–1.
Lector: piso modelado de XC-26 150 fA con 2^20 ciclos a 10 MHz (PLANTILLA.md, laboratorio sin publicar).
"""
import subprocess
import numpy as np

out = []


def P(*a):
    s = " ".join(str(x) for x in a)
    print(s); out.append(s)


q, kT, ni, vth = 1.602e-19, 0.02585, 1e10, 1e7
kB = 1.381e-23


def Irec(Dit, sig, A_um2, VF):
    return 0.5 * q * ni * sig * vth * (A_um2 * 1e-8) * Dit * VF * np.exp(VF / (2 * kT))


def tfmt(t):
    if t < 1: return f"{t*1e3:.0f} ms"
    if t < 120: return f"{t:.1f} s"
    if t < 7200: return f"{t/60:.1f} min"
    if t < 2 * 86400: return f"{t/3600:.1f} h"
    return f"{t/86400:.1f} d"


P("b52_escenarios_lector.py — corrida:", subprocess.check_output(["date"]).decode().strip())
P("")
P("== Comprobación: 10x10 um, Dit 1,17e10, sigma 1e-16, VF 0,30 -> %.2f pA (a52: 0,9 pA)" % (Irec(1.17e10, 1e-16, 100, 0.30) * 1e12))
P("   Harmon: A=41000 um2, Dit*sigma=1,5e-5, VF 0,30 -> %.1f nA (leído de su fig.: 5 nA)" % (Irec(1.5e-5, 1.0, 41000, 0.30) * 1e9))
P("")
P("== T5.a Qué corriente hace falta (solo disparo, secuencia campo/sin campo a partes iguales): T = 100 q/(I d^2) ==")
P("   d (dI/I)   | I para 5 sigma en 10 s | 1 min | 1 h | electrones totales")
for d in (3e-4, 1e-4, 3e-5, 1e-5, 1e-6):
    P(f"   {d:.0e}     | {100*q/(d*d*10)*1e12:10.3g} pA | {100*q/(d*d*60)*1e12:9.3g} pA | {100*q/(d*d*3600)*1e12:9.3g} pA | {100/(d*d):.1e}")
P("")
P("== T5.b El lector de XC-26 tal cual (si los 150 fA son ruido blanco 1 sigma en T0 = 2^20/10 MHz = 0,105 s) ==")
T0 = 2 ** 20 / 10e6
sI = 150e-15 * np.sqrt(2 * T0)
P(f"   densidad equivalente: {sI*1e15:.0f} fA/rtHz = disparo de {sI**2/(2*q)*1e9:.1f} nA. Por debajo de esa corriente manda el lector, no el dispositivo.")
for dI in (0.1e-15, 1e-15, 10e-15, 100e-15, 1e-12):
    P(f"   señal absoluta {dI*1e15:7.1f} fA -> T(5 sigma) = 100 T0 (150 fA/dI)^2 = {tfmt(100*T0*(150e-15/dI)**2)}")
P("")
P("== T5.c Lector propuesto: integrar en C hasta dV, contar tiempo, reiniciar en cada estado de la secuencia ==")
P("   Ruido por conversión en electrones^2: disparo N = C dV/q ; kTC/q^2 ; comparador (C vn/q)^2 ; cuantización (N/(f_clk t))^2/12")
P("   C fF  dV V | N e-     | kTC e-^2 | comp vn=0,1/0,3/1 mV e-^2      | F = var/N (vn 0,1 / 0,3 / 1 mV) | t_conv a 1 pA / 10 pA / 100 pA / 1 nA")
for C, dV in ((12.4e-15, 0.5), (100e-15, 0.5), (100e-15, 1.0), (1e-12, 0.5), (1e-12, 1.0)):
    N = C * dV / q
    ktc = kB * 300 * C / q ** 2
    comp = [(C * vn / q) ** 2 for vn in (1e-4, 3e-4, 1e-3)]
    F = [(N + 2 * ktc + c) / N for c in comp]
    tc = [C * dV / I for I in (1e-12, 1e-11, 1e-10, 1e-9)]
    P(f"   {C*1e15:5.1f} {dV:.1f} | {N:.2e} | {ktc:.2e} | {comp[0]:.2e} {comp[1]:.2e} {comp[2]:.2e} | {F[0]:.2f} {F[1]:.2f} {F[2]:.2f} | "
      + " / ".join(tfmt(t) for t in tc))
P("   (2 kTC: reinicio + muestreo del umbral. Con dV >> kT/q = 26 mV el reinicio no cuenta: kTC/N = kT/(q dV).)")
P("   Cuantización con reloj de 10 MHz y t_conv >= 1 ms: <= 1e4^-1/sqrt(12) = 3e-5 por conversión, frente a N^-1/2 >= 4e-4: despreciable.")
P("   Deriva: 5,8 %/K (a52). Para 1e-5 hace falta 0,17 mK de estabilidad ENTRE estados; la secuencia +,-,-,+ quita la deriva lineal;")
P("   un gemelo sin bobina leído a la vez quita la común (temperatura, alimentación) y cuesta x2 en tiempo si su disparo es igual.")
P("   Fuga del nodo: I_fuga (unión del pozo + interruptor de reinicio) [?] 1 fA–1 pA: añade disparo; factor (1 + I_fuga/I).")
P("")
P("== T4. Escenarios. Área en um2; corriente a VF 0,30 / 0,40 V; señal absoluta; T(5 sigma) con el lector propuesto (F=1,3) ==")
P("   d: 3e-4 a VF 0,30 y 1,7e-4 a VF 0,40 (interpolado de la estimación de a52; x3 arriba y abajo). f_Pb = 1 (todas las trampas responden).")
P("   Trampas activas ~ Dit*A*VF (ventana ~ qVF, Harmon/Sharov).")
SC = [
    ("(i) virgen, Hori 1e9", 1e9), ("(i) virgen, Sharov 1,17e10", 1.17e10), ("(i) virgen, techo supuesto 1e11", 1e11),
    ("(ii) estrés: +1e10 [?]", 2e10), ("(ii) estrés: 1e11 (Hori)", 1e11), ("(ii) estrés: 1e12 (Sharov, 12 MV/cm)", 1e12),
]
F = 1.3
for A, nmA in ((100, "10x10"), (900, "30x30"), (2000, "matriz 2000")):
    P(f"   --- área {nmA} um2 ---")
    P("   escenario                              sigma    | trampas | I(0,30)    dI      T5s(d) [T5s(d/3)] | I(0,40)    dI      T5s(d) [T5s(d/3)] | XC-26 tal cual (0,40)")
    for nm, Dit in SC:
        for sig in (1.5e-17, 1.5e-16, 1e-15):
            r = []
            for VF, d in ((0.30, 3e-4), (0.40, 1.7e-4)):
                I = Irec(Dit, sig, A, VF)
                r.append(f"{I*1e12:9.3g} pA {I*d*1e15:8.3g} fA {tfmt(100*q*F/(I*d*d)):>9s} [{tfmt(900*q*F/(I*d*d)):>9s}]")
            I4 = Irec(Dit, sig, A, 0.40)
            P(f"   {nm:38s} {sig:.1e} | {Dit*A*1e-8*0.3:7.0f} | {r[0]} | {r[1]} | {tfmt(100*T0*(150e-15/(I4*1.7e-4))**2):>9s}")
P("")
P("   (iii) estructuras con más borde. Diodo con puerta en tiras: área de puerta A, perímetro de aislamiento Pe, franja de borde w_e, factor k de densidad.")
P("         trampas equivalentes = Dit (A + (k-1) Pe w_e). Tiras de 0,42 um de ancho activo (mínimo de difusión; comprobar) en 10x10: Pe ~ 2*10*N_tiras.")
for k in (1, 3, 10):
    for we in (0.05, 0.2):
        Ns = int(10 / 0.84)
        Pe = 2 * 10 * Ns
        Aact = Ns * 0.42 * 10
        P(f"         k={k:2d}, w_e={we:.2f} um: {Ns} tiras, A activa {Aact:.0f} um2, Pe {Pe} um -> equivalente {Aact + (k-1)*Pe*we:.0f} um2 de cara plana (frente a 100 de la placa llena)")
P("         => el borde solo gana si k >= ~5 Y w_e >= 0,1 um. Sin dato de k: no se puede prometer; se dibuja la pareja placa/tiras y se mide.")
P("")
P("   Ruido 1/f: factor (1 + 0,8 fc/f_mod) (Monte Carlo de a52). Con t_conv = dwell: f_mod = 1/(4 t_conv).")
for I in (1e-12, 1e-11, 1e-10, 1e-9):
    tc = 100e-15 * 0.5 / I
    fm = 1 / (4 * tc)
    P(f"      I = {I*1e12:6.0f} pA: t_conv {tfmt(tc)}, f_mod {fm:8.2f} Hz -> factor con esquina 1/f en 1 / 10 / 100 Hz [?]: {1+0.8*1/fm:.2f} / {1+0.8*10/fm:.2f} / {1+0.8*100/fm:.1f}")
P("")
P("== T4.b Campo eléctrico de estrés disponible (óxido 4,15 nm, DATOS_PROCESO) ==")
for V in (1.8, 3.3, 5.0):
    P(f"   {V} V -> {V/4.15e-7/1e6:.1f} MV/cm (lo leído que crea 1e12 en 20 min: 9 V / 7,5 nm = 12,0 MV/cm)")
P("")
P("== T6. Geometría y área de un canal (de b52_bobinas, G3 cruzada N=4, pista 1,5, borde interior a 7 um) ==")
kmT, R, foot = 0.3733, 21.0, 27.8
for Bt in (2.0, 4.0):
    I = Bt / kmT
    P(f"   +-{Bt:.0f} mT: {I:.1f} mA por devanado (en serie: una sola corriente), densidad {I/1.5:.1f} mA/um (límite 6,8), caída en bobinas {I*R:.0f} mV, "
      f"P bobinas {I*I*R*1e-3:.2f} mW, P total desde 1,8 V {1.8*I:.1f} mW, caída en la red de la tesela (5 ohm, leído por agente) {I*5:.0f} mV, "
      f"vías via3 por salto (0,48 mA/vía) {int(np.ceil(I/0.48))}")
P("   Interruptores: 2 puentes en serie = 4 conduciendo; R_on 10 ohm c/u -> 40 ohm; resto hasta 1,8 V en un lastre o fuente de corriente.")
P("   R_on*W ~ 1–2 kohm*um nfet, x2,5–3 pfet (DE MEMORIA [?]; sacar del modelo ngspice antes de dibujar): W ~ 100–200 um (n), 300–500 um (p).")
blocks = [("bobina doble + dispositivo 10x10 + blindaje", foot ** 2), ("gemelo de referencia (misma bobina, sin corriente o ficticia)", foot ** 2),
          ("bobina + placa Hall (o el propio pozo del dispositivo con 4 tomas: 0)", foot ** 2),
          ("2 puentes: 4 nfet W=150 + 4 pfet W=400, dedos de 5 um, paso 0,6 um [supuesto]", (4 * 150 + 4 * 400) / 5 * 0.6 * 6.5),
          ("integrador + comparador + C 100 fF [supuesto]", 600.0), ("contador 20 bits + secuenciador [supuesto, ~25 um2/flop]", 30 * 25 + 400.0),
          ("separaciones y anillos de guarda (+40 % [supuesto])", 0.0)]
tot = 0
for nm, a in blocks[:-1]:
    P(f"   {nm:75s} {a:7.0f} um2"); tot += a
P(f"   {blocks[-1][0]:75s} {0.4*tot:7.0f} um2")
P(f"   TOTAL canal completo ~ {1.4*tot:.0f} um2 (intervalo honesto x0,7–x2: {0.7*1.4*tot:.0f}–{2*1.4*tot:.0f}); tesela 1x1 ~161x111 um = 17 900 um2 (DE MEMORIA [?]) -> {1.4*tot/17900*100:.0f} %")
open(__file__.replace(".py", ".txt"), "w").write("\n".join(out) + "\n")
