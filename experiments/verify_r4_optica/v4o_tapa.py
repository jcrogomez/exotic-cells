# v4o_tapa.py — XC-27: cuanto cambia la fotocorriente optica una tapa metalica lisa sobre el par (cota: espejo infinito).
# Codigo propio. Fotones emitidos hacia arriba dentro del cono de escape (Si -> SiO2) que salen con transmitancia T,
# rebotan en met1 a h = 1.376 um (PDK local) con reflectancia Rm, vuelven a entrar con T y bajan por el silicio.
# Contribucion de cada rayo: int alfa e^{-alfa s} P(x(s)) ds, con P el campo de recogida del escenario base de v4o_coleccion.
import numpy as np
from scipy.interpolate import RegularGridInterpolator
from v4o_coleccion import build, spectrum, esc_frac
d = 5; xe = 3.0 + d; src = np.array([xe + 1.1, 1.5, 0.3])
g, photo, sink = build([xe, -44.0], 1.0, 2.5, True, 250)
P, info = g.solve(np.ones(g.shape), np.full(g.shape, 1e-4), photo | sink, photo.astype(float))
interp = RegularGridInterpolator((g.cx, g.cy, g.cz), P, bounds_error=False, fill_value=0.0)
w, al = spectrum(0.0)
n1, n2, h = 3.55, 1.45, 1.376
rng = np.random.default_rng(1)
s = np.concatenate([np.linspace(0, 20, 400), np.geomspace(20.05, 2000, 400)])
ds = np.gradient(s)
kern = sum(wi * ai * np.exp(-ai * s) for wi, ai in zip(w, al)) * ds   # pesos espectrales a lo largo del rayo
def ray_contrib(o, u):
    pts = o[None, :] + s[:, None] * u[None, :]
    ok = pts[:, 2] > 0
    return (interp(pts) * kern * ok).sum()
def T_fres(th):
    st2 = n1 / n2 * np.sin(th)
    if st2 >= 1: return 0.0, None
    ct, ct2 = np.cos(th), np.sqrt(1 - st2**2)
    rs = ((n1*ct - n2*ct2) / (n1*ct + n2*ct2))**2; rp = ((n1*ct2 - n2*ct) / (n1*ct2 + n2*ct))**2
    return 1 - 0.5 * (rs + rp), np.arcsin(st2)
# referencia: F directo por MC isotropo (hacia abajo + reflexion total arriba fuera del cono), para la misma normalizacion
N = 6000
F_dir = 0.0; F_cap = 0.0; F_cone_if_mirror = 0.0
for i in range(N):
    mu = rng.uniform(-1, 1); ph = rng.uniform(0, 2 * np.pi); st = np.sqrt(1 - mu**2)
    u = np.array([st * np.cos(ph), st * np.sin(ph), mu])   # z hacia abajo positivo
    if mu > 0:
        F_dir += ray_contrib(src, u)
    else:
        th = np.arccos(-mu); T, th_ox = T_fres(th)
        ud = np.array([u[0], u[1], -u[2]])
        o_img = np.array([src[0], src[1], -src[2]])        # rayo reflejado = rayo desde la imagen
        c = ray_contrib(src + (src[2] / (-mu)) * u * 0 + 0, ud)  # aproximacion: reflexion en z=0 sobre la fuente (zs pequeno)
        F_dir += (1 - T) * c
        F_cone_if_mirror += T * c
        if T > 0:
            off = 2 * h * np.tan(th_ox)                     # desplazamiento lateral en el oxido (ida y vuelta)
            o2 = src + np.array([np.cos(ph), np.sin(ph), 0]) * off
            o2[2] = src[2]
            F_cap += T * T * ray_contrib(o2, ud)            # x Rm despues
F_dir /= N; F_cap /= N; F_cone_if_mirror /= N
print(f"F directo (MC, d=5, base L=100): {F_dir:.3e}")
print(f"cono de escape, si volviera sin perdidas en el mismo sitio: {F_cone_if_mirror/F_dir*100:.2f} % de lo recogido")
for Rm in (0.5, 0.7, 0.9, 0.95):
    print(f"tapa lisa infinita Rm={Rm}: +{Rm*F_cap/F_dir*100:.2f} % de la senal optica")
