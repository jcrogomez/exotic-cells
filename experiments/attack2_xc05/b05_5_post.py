"""b05 (5) post: lee los registros de ngspice (b05_5_sp/*.log) y resume: transferencia en continua, sensibilidad del lector por fuente,
resolución en R (con el ruido de disparo de 0,55 % por conversión de experiments/xc19_noise, SUPUESTO que vale igual con la fuente en A),
y los extremos de V(A) en cada transitorio."""
import re, os, numpy as np
W = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'b05_5_sp')
def lines(n, tag):
    p = os.path.join(W, n + '.log')
    return [l.split() for l in open(p) if l.startswith(tag + ' ')] if os.path.exists(p) else []
t0 = lines('t0_dc', 'T0'); cal = lines('t0b_cal', 'T0B')
print("== T0: continua. V(A) [mV] y V(H) [mV] frente a R del dispositivo, por rango")
tab = {}
for l in t0: tab.setdefault(l[1], []).append((float(l[2]), float(l[3]) * 1e3, float(l[4]) * 1e3))
for rng, rows in tab.items():
    print(f"  rango {rng}: " + "  ".join(f"{r:g}:{va:.2f}/{vh:.1f}" for r, va, vh in rows))
    print(f"     máximo V(A) en continua = {max(v for _, v, _ in rows):.2f} mV (dispositivo abierto)")
if cal:
    v = np.array([float(l[1]) for l in cal]); t = np.array([float(l[2]) for l in cal])
    print("\n== T0B: tiempo de conversión frente a V(A) (fuente del nfet lector)")
    print("  " + "  ".join(f"{a*1e3:g}mV:{b*1e6:.2f}us" for a, b in zip(v, t)))
    o = np.argsort(v); v = v[o]; t = t[o]
    sl = np.gradient(np.log(t), v)
    print(f"  d ln(t)/dV = {sl.min():.1f} .. {sl.max():.1f} /V  -> un e-pliegue cada {1e3/sl.mean():.1f} mV; 0,3 mV = {(np.exp(sl.mean()*0.3e-3)-1)*100:.2f} % de tiempo")
    dv_noise = 0.0055 / sl.mean()
    print(f"  con 0,55 % de ruido por conversión: dV = {dv_noise*1e3:.3f} mV por conversión; {dv_noise*1e3/8:.4f} mV promediando 64")
    print("\n== Resolución en R (dR/R por conversión única; mejor rango), y corriente por el dispositivo")
    best = {}
    for rng, rows in tab.items():
        r = np.array([x[0] for x in rows if x[0] < 1e11]); va = np.array([x[1] for x in rows if x[0] < 1e11]) * 1e-3
        dvdlnr = np.gradient(va, np.log(r))
        for ri, vi, di in zip(r, va, dvdlnr):
            res = dv_noise / di if di > 0 else np.inf
            if ri not in best or res < best[ri][0]: best[ri] = (res, rng, vi)
    for ri in sorted(best):
        res, rng, vi = best[ri]
        print(f"  R = {ri:>9g} Ohm: dR/R = {res*100:6.2f} %  (rango {rng}, V(A) = {vi*1e3:6.2f} mV, I = {vi/ri*1e6:8.3f} uA, P = {vi*vi/ri*1e9:8.3f} nW)")
    for (a, b, name) in ((12906, 12906 / 2, '1 G0 -> 2 G0'), (12906, 12906 / 0.8, '1 G0 -> 0,8 G0'), (12906 / 3, 12906 / 4, '3 -> 4 G0'), (12906 / 10, 12906 / 11, '10 -> 11 G0')):
        k = min(best, key=lambda x: abs(np.log(x / a))); res = best[k][0]
        print(f"  paso {name}: dR/R = {abs(b-a)/a*100:.1f} %  frente a {res*100:.2f} % de resolución -> {abs(b-a)/a/res:.0f} sigma por conversión")
for n, tag, title in (('t1_arranque', 'T1', 'arranque y apagado (rampas de VDD)'), ('t2_saltos', 'T2', 'saltos del dispositivo en 1 ns'), ('t4_rango', 'T4', 'cambio de rango'),
                      ('t5_lector', 'T5', 'conversión del lector'), ('t5_lector', 'T6', 'escalón de +-0,2 V en VDD en 1 ns'), ('t7_anillo', 'T7', 'anillo con resistencia serie: V sobre el dispositivo'), ('t8_fuente', 'T8', 'fuente de corriente de 50 nA sin limitar')):
    L = lines(n, tag)
    print(f"\n== {tag}: {title}  ({len(L)} casos)")
    worst = (0, None)
    def fl(x):
        try: return float(x)
        except ValueError: return float('nan')
    for l in L:
        d = dict(x.split('=') for x in l[1:] if '=' in x)
        mx = np.nanmax([abs(fl(d.get('max', 0))), abs(fl(d.get('min', 0)))])
        if mx > worst[0]: worst = (mx, ' '.join(l))
        o = []
        for k, x in d.items():
            if k in ('max', 'min', 'antes', 'despues', 'reposo', 'maxH'): o.append(f"{k}={fl(x)*1e3:.2f}mV")
            elif k in ('tconv', 't_50mV', 't_100mV'): o.append(f"{k}={fl(x)*1e6:.4f}us")
            else: o.append(f"{k}={x}")
        print("  " + " ".join(o))
    if worst[1]: print(f"  PEOR: |V(A)| = {worst[0]*1e3:.2f} mV en: {worst[1]}")
