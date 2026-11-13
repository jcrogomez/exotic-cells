#!/usr/bin/env python3
"""c62: lee c62_dvth_{n,p}.dat. Para cada L: corriente a Vg fijo en inversión débil, pendiente local, y el corrimiento
equivalente de puerta respecto a L=0,150: dVeq = ln(I(L)/I(0.15)) / (dlnI/dVg). Salida c62_dvth.txt"""
import numpy as np
Ls = [0.150, 0.152, 0.155, 0.160, 0.165, 0.170, 0.180, 0.200, 0.250]
out = []
for tag, f, sgn in (("nfet_01v8", "c62_dvth_n.dat", 1), ("pfet_01v8", "c62_dvth_p.dat", -1)):
    d = np.loadtxt(f); vg = np.abs(d[:, 0]); I = np.abs(d[:, 1::2])
    out.append(f"\n{tag} W=0.42, |Vds|=0.9, tt 27C")
    for vq in (0.20, 0.30, 0.40):
        k = int(round(vq / 0.01)); slope = (np.log(I[k + 1]) - np.log(I[k - 1])) / 0.02     # 1/V, por dispositivo
        n = 1 / (slope[0] * 0.025852)
        out.append(f" |Vg|={vq:.2f}: I(L=0.15)={I[k,0]:.3e} A  dlnI/dVg={slope[0]:.2f}/V  n={n:.2f}")
        for j, L in enumerate(Ls):
            r = I[k, j] / I[k, 0]; dv = np.log(r) / slope[0] * 1e3
            per = (dv / ((L - 0.15) * 1e3)) if j else float('nan')
            out.append(f"   L={L:.3f}  I/I0={r:.4f}  dVeq={dv:+8.2f} mV   dVeq/dL={per:+.3f} mV/nm   dlnI/dL={(np.log(r)/((L-0.15)*1e3)*100 if j else float('nan')):+.2f} %/nm")
open("c62_dvth.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
