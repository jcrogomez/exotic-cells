"""CALCULO PREVIO AL PRERREGISTRO del simulador de discriminacion (XC-19 con RTN y abanico de configuraciones). No es el
simulador: son las cuentas cerradas que fijan las predicciones y la tautologia declarada. Salida: prereg_calc.txt.

Entradas (todas de archivos del repo):
  ../xc19_slot/contrato_temporizacion.txt  macro extraido: t de A en src=01 y con el salto de 0,305 mV (MISFIT-03, etapa a)
  calc_ruido/ruido_<c>_<t>.dat             ruido de puerta del DUT segun el modelo del PDK (V/sqrt(Hz))
Constantes: q; Cox = eps_ox / tox con tox = 4,15 nm (b52_INFORME, dato del PDK); 50 MHz.
"""
import math, os
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
q = 1.602176634e-19
COX = 3.9 * 8.8541878128e-12 / 4.15e-9          # F/m^2
F = 50e6; T0 = 1e-6; TRAP = 0.305e-3
CORN = [("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")]

V = {}
for l in open(os.path.join(HERE, "..", "xc19_slot", "contrato_temporizacion.txt")):
    f = l.split()
    for kv in f[3:]:
        k, _, v = kv.partition("=")
        try:
            V[(f[1], f[2], k)] = float(v)
        except ValueError:
            pass


def noise(c, t, f0, f1):
    a = [x.split() for x in open(os.path.join(HERE, "calc_ruido", f"ruido_{c}_{t}.dat")) if x[:1].isdigit()]
    fr = np.array([float(x[1]) for x in a]); s = np.array([float(x[3]) for x in a])
    ff = np.logspace(math.log10(f0), math.log10(f1), 4000)
    ss = np.exp(np.interp(np.log(ff), np.log(fr), np.log(s)))
    return math.sqrt(np.trapezoid(ss ** 2, ff))


def h2(p):
    return 0.0 if p <= 0 or p >= 1 else -p * math.log2(p) - (1 - p) * math.log2(1 - p)


def poisson_bits(lam1, lam3):
    """I(H; S) en bits, H in {f=1, f=3} equiprobable, S = conteo total ~ Poisson(lam_H): techo con conteo perfecto."""
    nmax = int(lam3 + 12 * math.sqrt(lam3) + 30)
    I = 0.0
    lp1 = -lam1; lp3 = -lam3
    for n in range(nmax + 1):
        if n:
            lp1 += math.log(lam1) - math.log(n); lp3 += math.log(lam3) - math.log(n)
        p1, p3 = math.exp(lp1), math.exp(lp3)
        pm = 0.5 * (p1 + p3)
        if p1 > 0: I += 0.5 * p1 * math.log2(p1 / pm)
        if p3 > 0: I += 0.5 * p3 * math.log2(p3 / pm)
    return I


out = []
p = out.append
a0 = q / (COX * 0.42e-6 * 0.15e-6)
p(f"Cox = {COX*1e3:.3f} fF/um^2 ; q/(Cox W L) para 0,42 x 0,15 = {a0*1e3:.4f} mV (el salto usado en xc19_caps: 0,305 mV)")
p("\n## 1. Macro extraido (MISFIT-03, etapa a): tiempo, sensibilidad y cuentas")
p("esquina | tA (us) | dt/t por 0,305 mV (%) | salto (cuentas) | ruido de disparo por conversion (cuentas, 0,108 %) | cuentas totales")
S = {}
for c, t in CORN:
    tA = V[(c, t, "h01_oa")] - T0; tT = V[(c, t, "t01_oa")] - T0
    s = (tA - tT) / tA
    S[(c, t)] = (tA, s)
    p(f"{c} {t} | {tA*1e6:.3f} | {100*s:.4f} | {(tA-tT)*F:.2f} | {0.00108*tA*F:.2f} | {tA*F:.0f}")
p("Si el ruido de disparo por conversion es < 0,3 cuentas, la cuantizacion no se promedia sola (sin dither): ver ff 85.")

p("\n## 2. El 1/f del modelo del PDK leido como trampas discretas (McWhorter)")
p("Si el 1/f del modelo es la suma de trampas de dos niveles (p = 1/2, varianza a^2/4 cada una) con amplitudes exponenciales de")
p("media eta * q/(Cox W L) (<a^2> = 2 (eta a0)^2), el numero de trampas cuyo tiempo cae en la banda es N = 4 sigma^2 / <a^2>.")
p("banda = [1/T, fa/2]; esquina | (fa, T) | sigma_1f (mV) | N con eta = 1 | N con eta = 2 | P(>= 1 trampa), eta = 1 | eta = 2")
N0 = {}
for c, t in CORN:
    for fa, T in ((1e3, 1.0), (1e3, 100.0), (1e4, 1.0), (1e4, 100.0)):
        sg = noise(c, t, 1 / T, fa / 2)
        n1 = 4 * sg ** 2 / (2 * a0 ** 2); n2 = 4 * sg ** 2 / (2 * (2 * a0) ** 2)
        N0[(c, t, fa, T)] = n1
        p(f"{c} {t} | ({fa:g} Hz, {T:g} s) | {sg*1e3:.4f} | {n1:.3f} | {n2:.3f} | {1-math.exp(-n1):.3f} | {1-math.exp(-n2):.3f}")
p("Lectura: para el DUT minimo el 1/f del modelo equivale a menos de una trampa en banda. En ese tamano la hipotesis")
p("'1/f gaussiano continuo' no es fisica: la pregunta real es 0, 1 o 2 trampas por dispositivo (Poisson).")

p("\n## 3. Abanico: area relativa A (amplitud ~ 1/A, numero ~ A) y techo de Poisson para distinguir densidad x3 de x1")
p("Techo = bits sobre f (f = 3 frente a f = 1, equiprobables) si cada trampa en banda se contara sin error. lambda0 = N de la")
p("seccion 2 a tt 27, (1 kHz, 1 s), eta = 1. R = replicas de la misma configuracion.")
lam0 = N0[("tt", "27", 1e3, 1.0)]
p("A | salto por trampa a tt (cuentas) | lambda por dispositivo (f = 1) | techo R=1 | R=4 | R=16 | R=64 | R para 0,5 bits")
for A in (1, 2, 4, 8):
    tA, s = S[("tt", "27")]
    step = s / A * tA * F
    lam = lam0 * A
    row = [poisson_bits(R * lam, 3 * R * lam) for R in (1, 4, 16, 64)]
    Rneed = next((R for R in range(1, 2000) if poisson_bits(R * lam, 3 * R * lam) >= 0.5), None)
    p(f"{A} | {step:.2f} | {lam:.3f} | " + " | ".join(f"{x:.3f}" for x in row) + f" | {Rneed}")
p("Lectura: el techo depende de R*A (el total de area), no de como se reparte; el instrumento decide cuanto de ese techo se")
p("alcanza. El area grande diluye el salto (1/A) hacia el ruido de disparo; la chica lo deja visible pero con pocas trampas.")

p("\n## 4. Tautologias para la prediccion")
tA, s = S[("tt", "27")]
p(f"- tt 27: una trampa del DUT minimo = {s*tA*F:.1f} cuentas frente a {0.00108*tA*F:.2f} de disparo por conversion: "
  f"{s/0.00108:.1f} sigma en una conversion. Contra ruido blanco la deteccion es trivial; lo que decide es el numero de trampas.")
tA, s = S[("ff", "85")]
p(f"- ff 85: una trampa = {s*tA*F:.2f} cuentas y el disparo {0.00108*tA*F:.3f} cuentas: la cuantizacion no se promedia. Con la "
  f"fase de pre fija respecto al reloj (pre es sincrono en el nucleo), la lectura es determinista salvo en el borde: "
  f"una trampa se ve solo si mueve el cruce sobre un entero, en una fraccion ~ {s*tA*F:.2f} de las fases.")
open(os.path.join(HERE, "prereg_calc.txt"), "w").write("\n".join(out) + "\n")
print("\n".join(out))
