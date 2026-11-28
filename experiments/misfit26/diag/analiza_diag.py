"""MISFIT-26, diagnostico (exploratorio, posterior a los veredictos): los dos decks anomalos repetidos guardando ondas.
Uso (python con numpy): analiza_diag.py > diag.txt. ondas.txt no se versiona; se regenera con ../corre.sh diag/*/ (8 y 30 min)."""
import os, numpy as np
H = os.path.dirname(os.path.abspath(__file__)); Q = "v(b_u_loop_u_d0_A)"
for name in ("m_bajo_ff85_oos_3.1623e-10", "m_bajo_ff-40_cal_1.0000e-10"):
    f = open(os.path.join(H, name, "ondas.txt")); cols = f.readline().split(); d = np.loadtxt(f); t = d[:, 0]; g = lambda c: d[:, cols.index(c)]
    def cross(v, up=True, th=0.9):
        a, b = (v[:-1] < th, v[1:] >= th) if up else (v[:-1] >= th, v[1:] < th); i = np.where(a & b)[0]; return t[i] + (th - v[i]) / (v[i + 1] - v[i]) * (t[i + 1] - t[i])
    q = g(Q); rq = cross(q); c0 = g("v(b__53__A)"); tog = np.sort(np.concatenate([cross(c0), cross(c0, False)]))
    print(f"== {name}: {len(t)} puntos hasta {t[-1]*1e3:.3f} ms; subidas de q por 0,9 V: {len(rq)}; cambios del primer biestable: {len(tog)}")
    for c in ("v(xa)", "v(xb)"):
        r = cross(g(c)); print(f"  {c} sube a {np.round(r*1e3, 5)} ms, con {[int(np.sum(rq < x)) for x in r]} subidas de q antes")
    ex = [x for x in tog if not np.any((rq <= x) & (rq > x - 5e-8))]; print("  cambios del primer biestable sin flanco de q:", np.round(np.array(ex) * 1e3, 5), "ms")
    for x in ex[:1]:
        w = (t > x - 1e-7) & (t < x + 1e-7); j = np.searchsorted(t, x + 2e-8)
        print(f"    alli q llega como mucho a {q[w].max():.3f} V; 20 ns despues: nodo {g('v(o_x)')[j]:.3f} V, s {g('v(b_u_loop_u_s2_Y)')[j]:.3f} V, q {q[j]:.3f} V, qb {g('v(b_u_loop_u_q_B)')[j]:.3f} V")
    j = len(t) - 1; print(f"  estado final: nodo {g('v(o_x)')[j]:.4f} V, s {g('v(b_u_loop_u_s2_Y)')[j]:.3f} V, q {q[j]:.4f} V, qb {g('v(b_u_loop_u_q_B)')[j]:.4f} V, prenl {g('v(o_prenl)')[j]:.4f} V; ultima subida de q a {rq[-1]*1e3:.4f} ms")
