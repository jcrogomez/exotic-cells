# v4o_alpha.py — alfa del Si ponderado por el espectro de emision banda a banda (van Roosbroeck-Shockley / Planck generalizado)
# Tabla: Green & Keevers 1995 (300 K) tal como la publica pveducation.org (leida 2026-11-13 por WebFetch), 850-1450 nm.
import numpy as np
lam = np.arange(850, 1451, 10)
a = np.array([535,480,432,383,343,306,272,240,210,183,157,134,114,95.9,79.2,64.0,51.1,39.9,30.2,22.6,16.3,11.1,8.0,6.2,4.7,3.5,
 2.7,2.0,1.5,1.0,0.68,0.42,0.22,0.065,0.036,0.022,0.013,0.0082,0.0047,0.0024,0.0010,3.6e-4,2.0e-4,1.2e-4,7.1e-5,4.5e-5,2.7e-5,
 1.6e-5,8.0e-6,3.5e-6,1.7e-6,1.0e-6,6.7e-7,4.5e-7,2.5e-7,2.0e-7,1.5e-7,8.5e-8,7.7e-8,4.2e-8,3.2e-8])
assert len(a) == len(lam)
E = 1239.84/lam            # eV
kT = 0.025852
Eg = np.linspace(E.min(), E.max(), 4000)
la = np.interp(Eg, E[::-1], np.log(a[::-1]))
def alpha(e): return np.exp(np.interp(e, E[::-1], np.log(a[::-1]), left=np.log(a[-1]), right=np.log(a[0])))
print("alfa(1100 nm) =", alpha(1239.84/1100), "cm^-1")
for dE in [0.0, 0.03, 0.06, 0.10]:   # desplazamiento por estrechamiento de banda en la region que emite
    em = alpha(Eg + dE) * Eg**2 * np.exp(-Eg/kT)      # fotones emitidos por unidad de energia
    em /= np.trapezoid(em, Eg)
    a_abs = alpha(Eg)                                  # absorcion en el sustrato poco dopado
    amean = np.trapezoid(em*a_abs, Eg)
    pk = 1239.84/Eg[np.argmax(em)]
    # fraccion de fotones con alfa < 1 cm^-1 (longitud > 1 cm: atraviesan el dado sin absorberse)
    f_lo = np.trapezoid(em*(a_abs < 1.0), Eg)
    # mediana del alfa por numero de fotones
    o = np.argsort(a_abs); c = np.cumsum((em*np.gradient(Eg))[o]); med = a_abs[o][np.searchsorted(c, 0.5*c[-1])]
    print(f"dE={dE:.2f} eV: pico {pk:.0f} nm, <alfa>={amean:.2f} cm^-1, mediana {med:.2f}, frac alfa<1: {f_lo:.2f}")
