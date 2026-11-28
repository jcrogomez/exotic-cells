"""MISFIT-28, diagnostico (exploratorio, posterior a los veredictos): el deck que hace falsas C1 y C4, repetido guardando ondas.
base = el mismo deck; paso = el mismo con paso maximo 0,1 us en vez de 1 us.
Uso (python con numpy): analiza_diag.py > diag.txt. ondas.txt no se versiona; se regenera con ../corre.sh diag/*/."""
import os, numpy as np
H = os.path.dirname(os.path.abspath(__file__)); P = "v(b_reader2_slot_0_u_loop_"
Q = "v(b_reader2_slot_0__66__CLK)"; QB = P + "u_qb_Y)"
for name in ("bajo_ff-40_oos_3.1623e-10_base", "bajo_ff-40_oos_3.1623e-10_paso"):
    p = os.path.join(H, name, "ondas.txt")
    if not os.path.exists(p): print(f"== {name}: sin ondas"); continue
    deck = open(os.path.join(H, name, "lec.sp")).read().split("\n"); cols = next(l for l in deck if l.startswith("wrdata ")).split()[2:]
    d = np.loadtxt(p); t = d[:, 0]; g = lambda c: d[:, 2 * cols.index(c) + 1]
    def cross(v, th=0.9):
        i = np.where((v[:-1] < th) & (v[1:] >= th))[0]; return t[i] + (th - v[i]) / (v[i + 1] - v[i]) * (t[i + 1] - t[i])
    q = g(Q); r3, r9, r15 = cross(q, 0.3), cross(q), cross(q, 1.5)
    print(f"== {name}: {len(t)} puntos hasta {t[-1]*1e3:.3f} ms; subidas de q por 0,3 / 0,9 / 1,5 V: {len(r3)} / {len(r9)} / {len(r15)}")
    print(f"  ultima subida completa a {r15[-1]*1e3:.5f} ms; periodo medio {np.mean(np.diff(r9[1:]))*1e6:.3f} us")
    ex = [x for x in r3 if not np.any(np.abs(r15 - x) < 1e-7)]
    for x in ex[:2]:
        print(f"  subida a medias a {x*1e3:.5f} ms; paso de tiempo alli: {np.diff(t)[np.searchsorted(t, x) - 1]:.2e} s")
        for dt in (-1e-6, -1e-8, 0, 2e-9, 1e-8, 1e-7, 1e-6, 1e-5, 1e-4):
            j = min(np.searchsorted(t, x + dt), len(t) - 1)
            print(f"    t{dt:+.0e}: " + ", ".join(f"{k} {g(c)[j]:.3f}" for k, c in (("nodo", "v(o_x)"), ("c", P + "u_cmp_Y)"), ("c2", P + "u_s1_Y)"),
                  ("q", Q), ("qb", QB), ("prenl", "v(b_reader2_slot_0_prenl)"), ("prenh", "v(b_reader2_slot_0_prenh)"))))
    j = len(t) - 1; print("  estado final: " + ", ".join(f"{c[2:-1].replace('b_reader2_slot_0_', '')} {g(c)[j]:.3f}" for c in cols))
