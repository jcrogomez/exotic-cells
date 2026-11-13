"""b20_barrido: curvas I-V crudas de la union lateral p+/n+ sobre el espacio de perfiles.
Guarda por celda: Jbbt(V) (>0 = directa), Jtat(V) para tau = 1 ns, integral de ionizacion local y con espacio muerto,
y descriptores de equilibrio. Los escenarios (escala del prefactor, tau, difusion) se aplican despues en b20_analiza.py.
Uso: python b20_barrido.py TAG [T=300] [F0=1.9e7] [bgn=0] [kind=log] [sub=0|1] [gratio=1]
  sub=0: d <= +100 nm, todo.  sub=1: solo d en {-30, 0, +30} y pozo 6e16.  sub=2: d en {240, 270, 300}, 7 pares de picos.  gratio = Gp/Gn (el p+ mas difuso que el n+ si > 1).
Salida: b20_barrido_TAG.pkl y b20_barrido_TAG.log
"""
import sys, pickle, itertools, subprocess, time
import numpy as np
from multiprocessing import Pool
import b20_lib as L

TAG = sys.argv[1]
T = float(sys.argv[2]) if len(sys.argv) > 2 else 300.0
F0 = float(sys.argv[3]) if len(sys.argv) > 3 else L.F0_HURKX
BGN = float(sys.argv[4]) if len(sys.argv) > 4 else 0.0
KIND = sys.argv[5] if len(sys.argv) > 5 else "log"
SUB = int(sys.argv[6]) if len(sys.argv) > 6 else 0
GR = float(sys.argv[7]) if len(sys.argv) > 7 else 1.0

PKS = (2e19, 5e19, 1e20, 2e20, 3e20)
GS = (3, 5, 10, 20, 30, 50)
DS = (-100, -30, 0, 30, 100)
NWS = (6e16, 2e17)
PAIRS = [(a, b) for a in PKS for b in PKS]
if SUB == 1:
    DS = (-30, 0, 30)
    NWS = (6e16,)
if SUB == 2:      # zona lejana (sin tunel): solo la diagonal y dos pares asimetricos
    DS = (240, 270, 300)
    PAIRS = [(a, a) for a in PKS] + [(5e19, 2e20), (1e20, 2e20)]

VF = np.array([0.005, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.12, 0.14, 0.16, 0.18, 0.20, 0.23, 0.26,
               0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.60, 0.70, 0.80])
VR = -np.array([0.01, 0.02, 0.05, 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.2, 1.5, 1.8, 2.2, 2.6, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0,
                7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 16.0])


def cell(args):
    Np, Nn, G, d, Nw = args
    Gn = G * 1e-7
    Gp = G * GR * 1e-7
    dc = d * 1e-7
    half = abs(dc) / 2 + 6 * max(Gn, Gp) + 60e-7
    dx = 0.1e-7 if G <= 10 else 0.2e-7
    x = np.arange(-half, half, dx)
    Na, Nd = L.profile(x, Np, Nn, Gp, Gn, dc, Nw, KIND)
    r = dict(Np=Np, Nn=Nn, G=G, d=d, Nw=Nw, err="")
    try:
        j = L.Junction(x, Na, Nd, T, BGN)
        j.solve(0.0)
        Em, W10, xp, xn = j.summary()
        # gradiente neto en la union metalurgica (cm^-4) y dopado a +-W10/2
        k = int(np.argmin(np.abs(j.N[1:-1]))) + 1
        r.update(Emax0=Em, W10=W10, xi_p=xp, xi_n=xn, lmin0=j.tunnel(F0=F0)[1], grad=abs(np.gradient(j.N, x)[k]),
                 Vbi=j.psi[-1] - j.psi[0])
        jf, tf = [], []
        for V in VF:
            j.solve(V)
            jf.append(-j.tunnel(F0=F0)[0])
            tf.append(j.tat())
        j.psi = None
        j.solve(0.0)
        jr, tr, ii, iid, em = [], [], [], [], []
        for V in VR:
            j.solve(V)
            jb = j.tunnel(F0=F0)[0]
            jr.append(-jb)
            tr.append(j.tat())
            ii.append(j.ion_integral())
            iid.append(j.ion_integral(1.2, 1.5))
            em.append(np.max(np.abs(j.field())))
            if (iid[-1] > 2.0 and ii[-1] > 2.0) or jb > 3e7:
                break
        n = len(jr)
        r.update(VF=VF, JF=np.array(jf), TF=np.array(tf), VR=VR[:n], JR=np.array(jr), TR=np.array(tr), II=np.array(ii),
                 IID=np.array(iid), EM=np.array(em))
    except RuntimeError as e:
        r["err"] = str(e)
    return r


if __name__ == "__main__":
    t0 = time.time()
    jobs = [(a, b, g, d, w) for (a, b) in PAIRS for g in GS for d in DS for w in NWS]
    with Pool(8) as pool:
        res = pool.map(cell, jobs, chunksize=6)
    meta = dict(T=T, F0=F0, A=L.A_HURKX, bgn=BGN, kind=KIND, gratio=GR, date=subprocess.check_output(["date"]).decode().strip())
    pickle.dump(dict(meta=meta, res=res), open("b20_barrido_%s.pkl" % TAG, "wb"))
    nerr = sum(1 for r in res if r["err"])
    open("b20_barrido_%s.log" % TAG, "w").write("%s\n%s\nceldas %d, errores %d, %.0f s\n%s\n" % (
        meta["date"], meta, len(res), nerr, time.time() - t0, "\n".join("%s" % ((r["Np"], r["Nn"], r["G"], r["d"], r["Nw"], r["err"]),) for r in res if r["err"])))
    print(open("b20_barrido_%s.log" % TAG).read()[:3000])
