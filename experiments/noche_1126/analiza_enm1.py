"""Enmienda 1: veredictos E0..E3. Escrito antes de correr. Uso: analiza_enm1.py > enm1.txt (importa analiza_noche: reimprime la noche por stderr no; se silencia)."""
import os, io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    import analiza_noche as a
g = a.g; H = a.H
def T(c):
    for sub in ("S_enm1", "S"):
        p = os.path.join(H, sub, c)
        if os.path.exists(os.path.join(p, "lec.log")): return a.lee(p)
    return (None, 0)
ctl = "bajo_tt27_v1.70_cal_1.0000e-08"; t1 = a.lee(os.path.join(H, "S_enm1", ctl))[0]; t0 = a.lee(os.path.join(H, "S", ctl))[0]
d = None if not (t0 and t1) else (t1 / t0 - 1) * 100; a.ver("E0 (control dentro de 0,1 %)", d is not None and abs(d) <= 0.1, f"({d})")
n = [a.lee(os.path.join(H, "S_enm1", c))[1] for c in ("bajo_tt27_v1.70_cal_1.0000e-10", "bajo_tt27_v1.70_oos_3.1623e-09", "alto_tt27_v1.70_cal_1.0000e-08")]
a.ver("E1 (los tres oscilan, 12 flancos)", all(x == 12 for x in n), f"{n}")
e2 = []; e3 = []
for rng in ("bajo", "alto"):
    R = {(k, i): T(f"{rng}_tt27_v1.70_{k}_{i:.4e}")[0] for k, i in g.sub(rng)}; i = g.MID[rng]
    fp = a.fit([(ii, R[(k, ii)]) for k, ii in g.sub(rng) if k == "cal"]); f0 = a.fit24(rng, "tt", "27")
    er, e18 = a.err(fp, R[("oos", i)], i), a.err(f0, R[("oos", i)], i); e2.append(er); e3.append((rng, e18))
    print(f"  {rng} tt 27 1.70 V: Q {None if not fp else round((fp[0] / f0[0] - 1) * 100, 2)} % frente a 1,80 V | recalibrado: error {a.r(er)} % | con la calibracion de 1,80 V: error {a.r(e18)} %")
a.ver("E2 (recalibrado dentro de +-3 % en los dos casos)", all(e is not None and abs(e) <= 3 for e in e2), f"{[a.r(e) for e in e2]}")
a.ver("E3 (con la calibracion de 1,80 V: alto 3-8 %, bajo 2-20 %)", all(e is not None and ((3 <= abs(e) <= 8) if rng == "alto" else (2 <= abs(e) <= 20)) for rng, e in e3), f"{[(rng, a.r(e)) for rng, e in e3]}")
print("decks que no acabaron en 'salida 0':", [b for b in a.BAD if "S_enm1" in str(b[0])] or "ninguno")
