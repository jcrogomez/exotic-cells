#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""c62: imagen aérea (Abbe, la de litho_explore/litho.py ampliada) de una puerta de poly 0,15 sobre difusión de W=0,42.
Óptica SUPUESTA (248 nm; NA 0,60/0,70; sigma 0,5/0,8), máscara binaria, umbral constante calibrado a línea aislada 0,15.
Sin resina, sin grabado, SIN OPC: cota del efecto sistemático sin corrección, no predicción de silicio. Unidades um.
Salida: c62_litho.txt. Traducción a corriente: pendiente dlnI/dL del modelo (c62_dvth.txt)."""
import numpy as np, itertools, sys
N, dx, LAM = 1024, 0.005, 0.248
x = (np.arange(N) - N // 2 + 0.5) * dx
X, Y = np.meshgrid(x, x, indexing="ij")
f = np.fft.fftfreq(N, dx); FX, FY = np.meshgrid(f, f, indexing="ij")
W, LG = 0.42, 0.15
SLN, SLP, SVG = 0.0382, 0.0529, 27.45      # dlnI/dL (1/nm) nfet y pfet a |Vg|=0,2; dlnI/dVg nfet (1/V). c62_dvth.txt
def image(chrome, na, sigma, ns=7):
    T = np.fft.fft2(1.0 - chrome); s = np.linspace(-1, 1, ns); I = np.zeros((N, N)); n = 0
    for a, b in itertools.product(s, s):
        if a * a + b * b > 1.0001: continue
        fx, fy = a * sigma * na / LAM, b * sigma * na / LAM
        P = ((FX + fx) ** 2 + (FY + fy) ** 2) <= (na / LAM) ** 2
        I += np.abs(np.fft.ifft2(T * P)) ** 2; n += 1
    return I / n
def rect(x0, x1, y0, y1): return ((X >= x0) & (X < x1) & (Y >= y0) & (Y < y1)).astype(float)
def cross(c, thr, j, step):
    """desde el índice j (dentro de lo impreso, c<thr) camina en `step` hasta cruzar el umbral; devuelve coordenada"""
    a = j
    while 0 < a < N - 1 and c[a] < thr: a += step
    b = a - step
    return x[b] + (thr - c[b]) / (c[a] - c[b]) * (x[a] - x[b])
def width_x(I, thr, yq, x0=0.0):
    iy = int(np.argmin(np.abs(x - yq))); c = I[:, iy]; j = int(np.argmin(np.abs(x - x0)))
    if c[j] >= thr: return 0.0
    return cross(c, thr, j, +1) - cross(c, thr, j, -1)
def tip_y(I, thr, x0=0.0, sgn=+1):
    c = I[int(np.argmin(np.abs(x - x0))), :]; j = N // 2
    return cross(c, thr, j, sgn)
def gate(xs=(0.0,), top=0.13, bot=0.13, field=(), bar=None, bx=(0, 0)):
    m = np.zeros((N, N))
    for xc in list(xs) + list(field): m += rect(xc - LG / 2, xc + LG / 2, -W / 2 - bot, W / 2 + top)
    if bar is not None: m += rect(bx[0], bx[1], W / 2 + bar, W / 2 + bar + 0.15)
    return np.clip(m, 0, 1)
CASES = [
 ("iso_longcap (referencia)", dict(top=1.5, bot=1.5)),
 ("iso_cap013", dict()),
 ("iso_cap013_top_only", dict(bot=1.5)),
 ("nb1_021", dict(xs=(0.0, 0.36))), ("nb2_021", dict(xs=(-0.36, 0.0, 0.36))),
 ("nb2_021_longcap", dict(xs=(-0.36, 0.0, 0.36), top=1.5, bot=1.5)),
 ("nb2_042", dict(xs=(-0.57, 0.0, 0.57))), ("nb2_100", dict(xs=(-1.15, 0.0, 1.15))),
 ("field2_0325", dict(field=(-0.475, 0.475))),
 ("elbow_0075", dict(top=0.075, bar=0.075, bx=(-0.075, 0.8))), ("elbow_013", dict(top=0.13, bar=0.13, bx=(-0.075, 0.8))),
 ("T_0075", dict(top=0.075, bar=0.075, bx=(-0.8, 0.8))),
 ("U_0075", dict(xs=(0.0, 0.36), top=0.075, bar=0.075, bx=(-0.075, 0.435))),
 ("U_013", dict(xs=(0.0, 0.36), top=0.13, bar=0.13, bx=(-0.075, 0.435))),
]
ys = np.linspace(-W / 2, W / 2, 43)
out = ["c62_litho: L impreso (um) de la puerta en x=0; dibujado 0,150. centro y=0; bordes de la difusión y=+0,21 (lado de la variante) e y=-0,21.",
       "cubre+ / cubre-: cuánto sobresale la punta impresa del borde de la difusión (dibujado 0,13 o la barra); <=0 = la puerta NO cubre.",
       "I/I0 n|p: corriente en inversión débil respecto a L=0,150 uniforme, integrando exp(-s*dL(y)) en W (s del modelo; extrapolado si L<0,15).",
       "dVeq: corrimiento equivalente de puerta del nfet (mV). Comparar con desajuste 17,3 mV (docs/CLAIMS.md)."]
res = {}
for na, sg in [(0.60, 0.5), (0.60, 0.8), (0.70, 0.5), (0.70, 0.8)]:
    Iref = image(rect(-LG / 2, LG / 2, -2.4, 2.4), na, sg); lo, hi = 0.0, 1.0
    for _ in range(40):
        thr = (lo + hi) / 2
        if width_x(Iref, thr, 0.0) > LG: hi = thr
        else: lo = thr
    out.append(f"\nNA {na:.2f} sigma {sg:.1f} umbral {thr:.3f}")
    out.append(f"  {'caso':26s} {'L(0)':>6s} {'L(+.21)':>7s} {'L(-.21)':>7s} {'Lmin':>6s} {'Lmax':>6s} {'cubre+':>7s} {'cubre-':>7s} {'I/I0 n':>7s} {'I/I0 p':>7s} {'dVeq':>7s}")
    for name, kw in CASES:
        I = image(gate(**kw), na, sg)
        Ly = np.array([width_x(I, thr, y) for y in ys])
        cp = tip_y(I, thr, sgn=+1) - W / 2 if kw.get("bar") is None and kw.get("top", 0.13) < 1 else float("nan")
        cm = -W / 2 - tip_y(I, thr, sgn=-1) if kw.get("bot", 0.13) < 1 else float("nan")
        if (Ly <= 0).any(): rn = rp = float("inf"); dv = float("inf")
        else:
            dL = (Ly - LG) * 1e3; rn = np.mean(np.exp(-SLN * dL)); rp = np.mean(np.exp(-SLP * dL)); dv = np.log(rn) / SVG * 1e3
        out.append(f"  {name:26s} {Ly[21]:6.3f} {Ly[-1]:7.3f} {Ly[0]:7.3f} {Ly.min():6.3f} {Ly.max():6.3f} {cp:7.3f} {cm:7.3f} {rn:7.3f} {rp:7.3f} {dv:+7.1f}")
        res.setdefault(name, []).append((Ly[21], Ly[-1], Ly[0], cp, cm, rn, dv))
out.append("\nResumen por caso: intervalo en los cuatro ajustes")
for name, v in res.items():
    v = np.array(v, float)
    out.append(f"  {name:26s} L(0) {v[:,0].min():.3f}-{v[:,0].max():.3f}  L(+.21) {v[:,1].min():.3f}-{v[:,1].max():.3f}  L(-.21) {v[:,2].min():.3f}-{v[:,2].max():.3f}  cubre+ {np.nanmin(v[:,3]) if not np.isnan(v[:,3]).all() else float('nan'):.3f}-{np.nanmax(v[:,3]) if not np.isnan(v[:,3]).all() else float('nan'):.3f}  cubre- {np.nanmin(v[:,4]) if not np.isnan(v[:,4]).all() else float('nan'):.3f}-{np.nanmax(v[:,4]) if not np.isnan(v[:,4]).all() else float('nan'):.3f}  I/I0n {v[:,5].min():.2f}-{v[:,5].max():.2f}  dVeq {v[:,6].min():+.1f}..{v[:,6].max():+.1f} mV")
open(sys.argv[1] if len(sys.argv) > 1 else "c62_litho.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
