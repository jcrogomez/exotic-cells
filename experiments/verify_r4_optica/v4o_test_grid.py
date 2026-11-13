# Control del resolvedor: semiesfera colectora de radio a=2 um en superficie, medio semi-infinito, L infinita.
# Exacto (frontera lejana ~infinita): P(R) = a/R. Tambien conduccion: resistencia de dispersion de semiesfera = rho/(2 pi a).
import numpy as np, time
from v4o_grid import axis, Grid
t=time.time()
fx = axis(-20, 20, 0.5, -1500, 1500); fy = axis(-20, 20, 0.5, -1500, 1500); fz = axis(0, 20, 0.5, 0, 1500)
g = Grid(fx, fy, fz); print("celdas", g.shape, np.prod(g.shape))
R = np.sqrt(g.X**2 + g.Y**2 + g.Z**2)
a = 2.0
m = R < a
u, info = g.solve(np.ones(g.shape), np.zeros(g.shape), m, 1.0)
print("info", info, "t", round(time.time()-t,1))
for Rt in [4, 10, 20, 40, 100]:
    i = np.argmin(abs(g.cx - Rt)); j = np.argmin(abs(g.cy)); k = 0
    Rr = np.sqrt(g.cx[i]**2 + g.cy[j]**2 + g.cz[k]**2)
    print(f"R={Rr:.2f}: P={u[i,j,k]:.4f}  a/R={a/Rr:.4f}  ratio={u[i,j,k]/(a/Rr):.3f}")
I = g.flux_into(m)   # sigma=1 (1/(ohm um)), V=1 -> R = 1/I en ohm*um/rho
print("R*a/rho num =", 1/I*a, " exacto 1/(2pi) =", 1/(2*np.pi))
