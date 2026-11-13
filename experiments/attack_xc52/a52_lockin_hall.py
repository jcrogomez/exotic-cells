#!/usr/bin/env python
"""a52_lockin_hall.py — (e) detección síncrona con ruido de disparo + 1/f (Monte Carlo + fórmula) y (f) placa Hall de pozo n.

(e) Modelo: corriente I0 con modulación cuadrada de la señal (campo sí/no) a f_mod: I = I0*(1 + delta*s(t)), s en {0,1}.
    Ruido relativo con DEP unilateral S(f) = (2q/I0)*(1 + fc/f). Estimador: media(sí) - media(no).
    Fórmula (blanco): var = 2*S0/T  ->  T(5 sigma) = 100*q/(I0*delta^2). Con 1/f: ~ x(1 + fc/f_mod) (se comprueba por MC).
(f) V_H = G*r_H*I*B/(q*N*t) y R_hoja = 1/(q*N*mu*t)  =>  V_H = G*r_H*mu*R_hoja*I*B = G*r_H*mu*B*V*(W/L).
    R_hoja: 950 ohm/sq (sky130A.tech l.5104; esquinas 550/1350) y 1700 ohm/sq (ngspice r+c/res_typical__cap_typical.spice l.22, rnw).
    Movilidad: Arora 300 K para electrones (DE MEMORIA): mu = 88 + 1252/(1+(N/1,26e17)^0,88) cm2/Vs. r_H=1,1 (1,0-1,2), G=0,7 (0,5-0,9).
"""
import numpy as np

q = 1.602e-19
rng = np.random.default_rng(52)

# ------------------------------------------------------------------ (e)
print("## (e1) Monte Carlo del estimador síncrono frente a la fórmula (unidades normalizadas: S0=1, fs=1)")


def noise(n, fc_over_fs):
    """Ruido con DEP unilateral S0*(1+fc/f), S0=1 (por Hz, fs=1 => var blanca = 0,5)."""
    f = np.fft.rfftfreq(n)
    f[0] = f[1]
    shape = np.sqrt(1 + fc_over_fs / f)
    w = rng.standard_normal(n) * np.sqrt(0.5)
    return np.fft.irfft(np.fft.rfft(w) * shape, n)


n = 2**18
for per in (64, 1024):  # muestras por periodo de modulación
    ref = (np.arange(n) // (per // 2)) % 2
    for ratio in (0.0, 1.0, 10.0, 100.0):  # fc / f_mod
        est = []
        for _ in range(200):
            x = noise(n, ratio / per)
            est.append(x[ref == 1].mean() - x[ref == 0].mean())
        var = np.var(est)
        pred_white = 2 * 1.0 / n  # 2*S0/T
        print(f"  periodo={per:5d} muestras  fc/f_mod={ratio:6.1f}: var_MC/var_blanco = {var/pred_white:7.2f}   (1+fc/f_mod = {1+ratio:6.1f})")
print("  -> el factor medido se usa abajo como F(fc/f_mod) ~ 1 + 0,8*fc/f_mod (ajuste a ojo de la tabla; ver informe).")

print("\n## (e2) Tiempo a 5 sigma, solo disparo: T = 100*q/(I0*delta^2)")
cur = [("bombeo 10x10 um, 10 MHz, Dit 1,17e10", 14e-9), ("bombeo 10x10, 1 MHz  (o 3x3 a 10 MHz)", 1.3e-9),
       ("bombeo 1x1, 10 MHz, Dit 1,17e10", 140e-12), ("bombeo 1x1, 10 MHz, Dit 1e9", 12e-12),
       ("dc-IV 10x10, VF 0,4, Dit 1,17e10 sigma 1e-15", 86e-12), ("dc-IV 10x10, VF 0,3, sigma 1e-16", 0.93e-12),
       ("plan XC-52: 16 nA", 16e-9)]
print(f"  {'corriente':46s} {'I0':>9s} | delta=1e-3      1e-4        1e-5        1e-6")
for name, I in cur:
    ts = [100 * q / (I * d * d) for d in (1e-3, 1e-4, 1e-5, 1e-6)]
    print(f"  {name:46s} {I*1e12:8.1f}pA | " + "  ".join(f"{t:9.3g} s" for t in ts))
print("\n## (e3) Con 1/f: multiplicar por F = 1 + 0,8*fc/f_mod")
for fmod in (1e3, 1e5, 1e6):
    print("  f_mod=%8.0f Hz: " % fmod + "  ".join(f"fc={fc:8.0f}: x{1+0.8*fc/fmod:8.1f}" for fc in (1e2, 1e4, 1e6, 1e7)))
print("  Nota: la fracción de la señal alcanzada con campo B y semianchura G (lorentziana): B^2/(B^2+G^2)")
for B in (0.5, 1.0, 2.6):
    print("   B=%.1f mT: " % B + "  ".join(f"G={G} mT -> {B*B/(B*B+G*G):.2f}" for G in (0.5, 1.0, 1.7)))

# ------------------------------------------------------------------ (f)
print("\n## (f) Placa Hall de pozo n")
print("  N[cm-3]   mu[cm2/Vs]  t(950)[um] t(1700)[um] | S_I = G*rH*mu*Rs [V/(A*T)] (950 / 1700) | V_H por mA y mT [uV] (950/1700) | modo tension: uV por V y mT (cuadrada)")
G, rH = 0.7, 1.1
for N in (1e16, 3e16, 1e17, 3e17, 1e18):
    mu = 88 + 1252 / (1 + (N / 1.26e17) ** 0.88)
    t950 = 1 / (q * N * mu * 950) * 1e4
    t1700 = 1 / (q * N * mu * 1700) * 1e4
    mu_si = mu * 1e-4
    s950, s1700 = G * rH * mu_si * 950, G * rH * mu_si * 1700
    print(f"  {N:7.0e}   {mu:8.0f}   {t950:8.3f}   {t1700:8.3f}   |   {s950:6.1f} / {s1700:6.1f}                      |  {s950*1e-6*1e6:6.1f} / {s1700*1e-6*1e6:6.1f}               | {G*rH*mu_si*1e-3*1e6:6.1f}")
print("  Barrido de G*rH: 0,5..1,08 (x0,65..x1,4 sobre la tabla).")
print("  Caída en placa cuadrada a 1 mA: 0,95 V (950) / 1,70 V (1700, no cabe en 1,8 V con interruptores): con 1700 el límite es la tensión.")
print("\n  Con el campo de la bobina (a52_coil.txt): 5 vueltas met3 w=1,5: 0,265 mT/mA -> 2,65 mT a 10 mA; w=0,3: 0,52 mT en el límite CC de EM")
for mu in (500, 800, 1100):
    for B in (0.52, 1.15, 2.65):
        vh = G * rH * mu * 1e-4 * B * 1e-3 * 1.0  # por voltio de polarización (placa cuadrada)
        step, sig1 = 0.305e-3, 0.305e-3 * 0.55 / 0.83
        nconv = (5 * sig1 / (2 * vh)) ** 2  # diferencia +B / -B = 2*V_H; ruido de dos lecturas ~ sqrt(2) incluido aparte
        print(f"   mu={mu:5d} B={B:4.2f} mT, 1 V de polarización: V_H = {vh*1e6:6.1f} uV = {vh/step:5.2f} pasos de 0,305 mV ; "
              f"pares de conversiones (+B/-B) para 5 sigma: {2*nconv:7.1f}")
print("  Ruido por conversión del lector: 0,55 % frente a 0,83 % por paso -> sigma = 0,20 mV por conversión (PLANTILLA, corrida de modelo).")
print("  Offset sin corriente rotatoria: 0,1..1 % de la polarización = 1..10 mV (DE MEMORIA, [?] en SKY130) = 5..200 veces V_H;")
print("  la inversión del campo de la bobina lo cancela (el offset no depende de B); la rotación de corriente ya no es imprescindible.")
print("  fem inducida en el lazo de sentido (10x10 um, 2,65 mT): 0,17 uV a 100 kHz, 1,7 uV a 1 MHz, 17 uV a 10 MHz (frente a V_H ~ 100-200 uV).")
print("  Ruido térmico de la placa: sqrt(4kT*950) = %.1f nV/rtHz -> despreciable frente al lector." % (np.sqrt(4 * 1.381e-23 * 300 * 950) * 1e9))
