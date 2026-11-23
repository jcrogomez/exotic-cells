"""CALCULO PREVIO AL PRERREGISTRO: integra el ruido de puerta del DUT (ruido_<c>_<t>.dat, V/sqrt(Hz)) en bandas de observacion.
Banda [1/T_obs, f_acq/2]: lo que ve una serie de lecturas a f_acq durante T_obs. Interpolacion log-log entre puntos.
El salto de una carga en la puerta es 0,305 mV (q / (Cox W L), el mismo de xc19_caps)."""
import numpy as np
TRAP = 0.305e-3
def load(c, t):
    a = [l.split() for l in open(f"ruido_{c}_{t}.dat") if l[:1].isdigit()]
    f = np.array([float(x[1]) for x in a]); s = np.array([float(x[3]) for x in a])
    return f, s
def band(f, s, f0, f1):
    ff = np.logspace(np.log10(f0), np.log10(f1), 4000)
    ss = np.exp(np.interp(np.log(ff), np.log(f), np.log(s)))
    return np.sqrt(np.trapezoid(ss**2, ff))
print("esquina | S(1 Hz) uV/rtHz | S(100 kHz) | pendiente 0,01-100 Hz | sigma puerta (mV) en [1/T, fa/2] para (fa, T) = "
      "(1 kHz, 1 s) (1 kHz, 100 s) (10 kHz, 1 s) (10 kHz, 100 s) | cociente trampa/sigma")
for c, t in (("tt","27"),("ff","-40"),("ss","85"),("ff","85")):
    f, s = load(c, t)
    s1 = np.exp(np.interp(0.0, np.log10(f), np.log(s)))
    s5 = np.exp(np.interp(5.0, np.log10(f), np.log(s)))
    k = np.polyfit(np.log10(f[(f>=0.01)&(f<=100)]), np.log10(s[(f>=0.01)&(f<=100)]), 1)[0]
    sig = [band(f, s, 1/T, fa/2) for fa, T in ((1e3,1),(1e3,100),(1e4,1),(1e4,100))]
    print(f"{c} {t} | {s1*1e6:.1f} | {s5*1e6:.3f} | {k:.3f} | " + " ".join(f"{x*1e3:.4f}" for x in sig)
          + " | " + " ".join(f"{TRAP/x:.2f}" for x in sig))
