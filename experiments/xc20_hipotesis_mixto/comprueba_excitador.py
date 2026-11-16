"""Consistencia eléctrica del excitador de motor2 (Rs + Imax) en V4, añadido 2026-11-15 por la revisión externa.
Para cada mecanismo y punto de medida: residuo de V + Rs·I(V) = Vap; fracción de chips limitados; para los limitados, el punto
real I = Imax con V_dev = I_dev^-1(Imax) y fuente V_dev + Rs·Imax <= Vap; y que corriente() devuelva exactamente eso.
Uso: python3 comprueba_excitador.py  (lee motor2.py de esta carpeta)."""
import os, sys, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__))); import motor2 as M
rng = np.random.default_rng(7); N = 20000
pts = [("base",1.8,27),("d027",1.8,27),("base",1.8,85),("d027",1.8,85),("base",0.9,27),("peine",1.8,27)]
peor = 0.0
for m in M.VARIANTES["V4"][0]:
    p = M.muestrea(m, N, rng, "V4")
    for (e,v,t) in pts:
        lo, hi = np.zeros(N), np.full(N, v)
        for _ in range(60):
            mid=.5*(lo+hi); f=mid+p["rs"]*M.i_dev(m,p,e,mid,t)-v
            lo,hi=np.where(f<0,mid,lo),np.where(f<0,hi,mid)
        vs=.5*(lo+hi); i_s=M.i_dev(m,p,e,vs,t)
        res = np.abs(vs + p["rs"]*i_s - v).max()          # residuo de la ecuación del lazo
        I = M.corriente(m,p,e,v,t,"V4")
        lim = i_s > p["imax"]
        # punto real con límite: I = Imax, V_dev = I_dev^-1(Imax), fuente = V_dev + Rs·Imax ≤ Vap
        a,b = np.zeros(lim.sum()), vs[lim].copy()
        q = {k: val[lim] for k,val in p.items()}
        for _ in range(60):
            mid=.5*(a+b); g=M.i_dev(m,q,e,mid,t)-q["imax"]
            a,b=np.where(g<0,mid,a),np.where(g<0,b,mid)
        vl=.5*(a+b); fuente = vl + q["rs"]*q["imax"]
        ok_fuente = (fuente <= v + 1e-9).all() if lim.any() else True
        ok_I = np.allclose(I[lim], q["imax"]) and np.allclose(I[~lim], i_s[~lim])
        sat_ancho = (I[lim] >= M.LECTORES["ancho"][2]).mean() if lim.any() else float("nan")
        todo_ok = (res < 1e-9) and ok_fuente and ok_I
        assert todo_ok, (m, e, v, t)
        print(f"{m} {e:5s} {v} {t}: limitados {lim.mean():.4f}; residuo lazo {res:.1e}; fuente<=Vap {ok_fuente}; min(I,Imax) correcto {ok_I};"
              f" Vdev limitada {np.median(vl) if lim.any() else float('nan'):.3f} V (mediana); de los limitados, sobre el techo del ancho {sat_ancho:.3f}")
print("ok: excitador coherente en todos los puntos")
