"""c59_2: mapa de regímenes (campo de estrés, temperatura de recocido, tiempo). MODELO SIN CALIBRAR EN SKY130: da intervalos.
Entradas LEÍDAS POR AGENTE (ver c59_INFORME): 
 NBTI escritura: 2.2 nm SiON a -2.7 V: ~10 mV a 1 s, 20-30 mV a 1e3 s; dVt ∝ Eox^3.3 (Pobegen y Grasser 2013). Escalado a 4.15 nm: x tox (SUPUESTO).
 NBTI emisión (retención): Ea normal mu=0.71 eV, sigma=0.29 eV, tau0=1e-15 s (30 nm SiO2, misma fuente).
 HCI: 250-450 mV en nMOS 4.5 nm con Vds=4.5 V, 3 ks; recocido 7200 s/escalón: ~50 % queda a 175-200 C, ~0 a 350-400 C;
      ajuste Ef=1.39 eV, sigma=0.369 eV (de Jong, Salm, Schmitz 2018). Frecuencia de intento efectiva: CALIBRADA aquí a '50 % a 460 K en 7200 s'.
 Techo: >~300 C largo crea defectos (Grasser 2016); >450 C ya no se repara (de Jong).
 TDDB de 4 nm: NO LEÍDO. Se barre: tensión que rompe en 1 s entre 4.5 y 6.5 V, pendiente 1.0-2.5 décadas/V... [DE MEMORIA, se marca]."""
import numpy as np
from scipy.stats import norm
kB = 8.617e-5; out = []; P = out.append
def frac_left(mu, sig, nu, T, t):
    E = np.linspace(mu-6*sig, mu+6*sig, 4001); w = norm.pdf(E, mu, sig); w /= w.sum()
    return float((w*np.exp(-nu*t*np.exp(-E/(kB*T)))).sum())
# --- escritura NBTI
P("# 1. Escritura por NBTI en pfet 4.15 nm (extrapolación: dVt(2.2nm,12.3MV/cm) x (E/12.3)^3.3 x (4.15/2.2)); intervalo x/÷3")
P("# Vg V | Eox MV/cm | dVt 1 s mV | dVt 1e3 s mV | pasos de 0.305 mV a 1e3 s (central) | intervalo x/÷3 mV a 1e3 s")
for V in (1.8, 3.3, 5.0):
    E = V/4.15e-7/1e6; s = (E/12.3)**3.3*(4.15/2.2)
    P(f"{V} | {E:.1f} | {10*s:.2f} | {25*s:.2f} | {25*s/0.305:.0f} | {25*s/3:.2f}-{25*s*3:.1f}")
# --- retención NBTI
P("\n# 2. Retención de lo escrito por NBTI (emisión mu=0.71, sigma=0.29, 1/tau0=1e15): fracción que queda")
P("# T C | 1 s | 1e3 s | 1e5 s (~1 dia) | 3e7 s (1 año)")
for TC in (25, 85, 125, 200, 300):
    P(f"{TC} | " + " | ".join(f"{frac_left(0.71, 0.29, 1e15, TC+273.15, t):.3f}" for t in (1, 1e3, 1e5, 3e7)))
# --- recocido HCI
nu = np.exp(1.39/(kB*460))/7200*np.log(2)
P(f"\n# 3. Recocido del daño por portadores calientes (Ef=1.39, sigma=0.369; nu efectiva calibrada = {nu:.2e} /s): fracción que queda")
P("# comprobación contra lo leído: 7200 s a 190 C -> %.2f (leído ~0.5); a 375 C -> %.3f (leído ~0)" % (frac_left(1.39, .369, nu, 463, 7200), frac_left(1.39, .369, nu, 648, 7200)))
ts = (1e-6, 1e-3, 1, 60, 3600)
P("# T C | " + " | ".join(f"{t:g} s" for t in ts))
for TC in (25, 125, 200, 300, 400, 500, 600, 800):
    P(f"{TC} | " + " | ".join(f"{frac_left(1.39, .369, nu, TC+273.15, t):.3f}" for t in ts))
P("# retención HCI a 25 C: 1 año %.3f ; 10 años %.3f ; a 85 C 10 años %.3f" % (frac_left(1.39, .369, nu, 298, 3e7), frac_left(1.39, .369, nu, 298, 3e8), frac_left(1.39, .369, nu, 358, 3e8)))
P("# tiempo para dejar 10 % (borrado 90 %):")
for TC in (200, 300, 400, 500, 600, 800):
    lo, hi = -9, 12
    for _ in range(60):
        m = (lo+hi)/2
        if frac_left(1.39, .369, nu, TC+273.15, 10**m) > 0.1: lo = m
        else: hi = m
    P(f"  {TC} C: {10**lo:.3g} s")
# --- TDDB (memoria, barrido)
P("\n# 4. Ruptura del óxido de 4.15 nm [DE MEMORIA, sin fuente leída: BARRIDO]. t_BD(V)=1 s*10^(-(V-V1)*g): V1 = 4.5..6.5 V, g = 1.0..2.5 dec/V... ")
P("# V | t_BD mín..máx s")
for V in (1.8, 3.3, 4.0, 5.0, 5.5):
    v = [10**(-(V-V1)*g) for V1 in (4.5, 5.5, 6.5) for g in (1.0, 2.5)]
    P(f"{V} | {min(v):.2g} .. {max(v):.2g}")
P("\n# 5. Niveles: ventana reversible / 0.305 mV. NBTI 3.3 V 1e3 s: %.0f pasos (pero 1-2 dias después queda ~8 %%: %.1f pasos)." % (25*(3.3/4.15e-7/1e6/12.3)**3.3*1.89/0.305, 0.08*25*(3.3/4.15e-7/1e6/12.3)**3.3*1.89/0.305))
P("# HCI 250-450 mV (leído, 4.5 nm, Vds 4.5 V): 820-1475 pasos; resolución limitada por la deriva de recocido a 25 C: %.4f de pérdida relativa en 1e5 s -> %.1f mV sobre 300 mV." % (1-frac_left(1.39, .369, nu, 298, 1e5), 300*(1-frac_left(1.39, .369, nu, 298, 1e5))))
open("c59_2_regimenes.txt", "w").write("\n".join(out)+"\n"); print("\n".join(out))
