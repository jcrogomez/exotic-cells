"""b20_valida: (1) reproduce la tabla de la ronda 1 (union abrupta simetrica) con b20_lib; (2) umbral de degeneracion de
volumen; (3) efecto del BGN; (4) tiempos. Salida: b20_valida.txt"""
import time, subprocess, numpy as np
import b20_lib as L
out = open("b20_valida.txt", "w")
def P(s=""):
    print(s); out.write(s + "\n")
P(subprocess.check_output(["date"]).decode().strip())
P("Union abrupta simetrica, 300 K, A = 4e14, F0 = 1.9e7 (Hurkx de memoria). J en A/cm2. tau TAT = 1 ns.")
P("N      bgn  xi_p  xi_n  Emax   Jinv(0.1)  Jinv(1.8)  Jpico_tunel Vp    Jtat(0.3)  Jtat(0.5)  [ronda 1: Jinv0.1, Jinv1.8, Jpico]")
r1 = {1e19: (2.2e-7, 4.5, 0), 3e19: (5.3e-2, 9.9e2, 0), 5e19: (2.0, 6.1e3, 1.8e-2), 1e20: (75, 4.4e4, 4.6), 3e20: (3.7e3, 4.7e5, 1.2e3)}
t0 = time.time()
for N in (1e19, 2e19, 2.5e19, 3e19, 5e19, 1e20, 3e20):
    for bgn in (0.0, 0.6):
        x = np.arange(-40e-7, 40e-7, 0.05e-7)
        j = L.Junction(x, *L.abrupt(x, N, N), bgn=bgn)
        j.solve(0.0); Em, W, xp, xn = j.summary()
        best = (0, 0)
        tat = {}
        for V in (0.02, 0.04, 0.06, 0.08, 0.1, 0.12, 0.15, 0.2, 0.3, 0.4, 0.5):
            j.solve(V); jt = -j.tunnel()[0]
            if jt > best[0]: best = (jt, V)
            tat[V] = j.tat()
        j.psi = None; j.solve(0.0)
        j.solve(-0.1); a = j.tunnel()[0]
        j.solve(-1.0); j.solve(-1.8); b = j.tunnel()[0]
        P("%.1e %.1f %5.0f %5.0f %5.2f  %9.2e  %9.2e  %9.2e  %.2f  %9.2e  %9.2e   %s" % (N, bgn, xp*1e3, xn*1e3, Em/1e6, a, b, best[0], best[1], tat[0.3], tat[0.5], r1.get(N, "") if bgn == 0 else ""))
P("tiempo total %.1f s" % (time.time() - t0))
out.close()
