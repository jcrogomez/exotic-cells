"""b20_lib: union lateral p+/n+ en 1D. Evolucion de a20_lib (ronda 1; copiado y ampliado, el original no se toca).
Unidades: cm, V, eV, A/cm^2.

QUE INCLUYE
  - Poisson con Fermi-Dirac (cuasi-niveles planos: Efp = 0 en el lado p, Efn = V en el lado n).
  - Estrechamiento de banda por dopado (BGN) opcional: Slotboom x factor, repartido mitad y mitad entre bandas.
  - Tunel banda a banda NO LOCAL: para cada energia, WKB de dos bandas a lo largo del camino entre Ev(x1)=E y Ec(x2)=E
    sobre el perfil autoconsistente; prefactor tipo Hurkx (G = A F^2.5 exp(-F0/F) en campo uniforme) con el campo medio del
    camino; ocupacion por diferencia de funciones de Fermi. Da tunel inverso (Zener) y directo (pico de Esaki).
  - Corriente de exceso: recombinacion por trampas asistida por tunel (TAT) de Hurkx 1992: SRH con factores de aumento
    Gamma(F) locales; proporcional a 1/tau (se devuelve para tau = 1 ns y se escala por escenario).
  - Difusion/recombinacion: se suma aparte (diodo del PDK).
  - Avalancha: integral de ionizacion (van Overstraeten-de Man) local y con espacio muerto de umbral duro.
QUE NO INCLUYE
  - Fonones explicitos (el silicio es indirecto: la asistencia por fonones entra solo a traves de A y F0 empiricos; no hay
    escalones de fonon ni dependencia termica del acoplo). Ni tunel via colas de banda/estados de impureza.
  - 2D/3D: curvatura de la union en profundidad, variacion del pico con la profundidad, superficie.
  - Resistencia serie, autocalentamiento, dinamica de trampas, ionizacion incompleta.

CONSTANTES (DE MEMORIA salvo indicacion): Eg = 1.12 eV, eps_r = 11.7, Nc = 2.86e19, Nv = 3.10e19 (Green 1990).
  Hurkx/Sentaurus "E2.5": A = 4e14 cm^-1/2 V^-5/2 s^-1, F0 = 1.9e7 V/cm (ver b20_lit_esaki.txt para la confirmacion).
  TAT: masa de tunel 0.25 m0 (Hurkx 1992). Slotboom: 9 meV, Nref 1e17. van Overstraeten: an = 7.03e5 exp(-1.231e6/E);
  ap = 1.582e6 exp(-2.036e6/E) (E < 4e5), 6.71e5 exp(-1.693e6/E) (E > 4e5).
"""
import numpy as np
from scipy.linalg import solve_banded

q = 1.602176634e-19
kB = 8.617333e-5
eps0 = 8.8541878e-14
EPS = 11.7 * eps0
HBAR = 1.054571817e-34
M0 = 9.1093837e-31
NC300, NV300 = 2.86e19, 3.10e19
A_HURKX = 4e14
F0_HURKX = 1.9e7
EG300 = 1.12


def Eg_T(T):
    eg = 1.17 - 4.73e-4 * T * T / (T + 636.0)
    return eg * (EG300 / (1.17 - 4.73e-4 * 300 * 300 / 936.0))


def fd_half(eta):
    e = np.clip(np.asarray(eta, dtype=float), -200, 500)
    v = e**4 + 50.0 + 33.6 * e * (1.0 - 0.68 * np.exp(-0.17 * (e + 1.0) ** 2))
    return 1.0 / (np.exp(-e) + 3.0 * np.sqrt(np.pi) / 4.0 * v ** (-3.0 / 8.0))


def dfd_half(eta):
    h = 1e-4
    return (fd_half(eta + h) - fd_half(eta - h)) / (2 * h)


def mr_from_F0(F0, Eg=EG300):
    F0m = F0 * 100.0
    s = F0m * 4 * HBAR * q / (np.pi * (Eg * q) ** 1.5)
    return s * s / 2.0


def slotboom(N):
    l = np.log(np.maximum(N, 1e10) / 1e17)
    return np.where(N > 1e17, 9e-3 * (l + np.sqrt(l * l + 0.5)), 0.0)


class Junction:
    def __init__(self, x, Na, Nd, T=300.0, bgn=0.0):
        self.x = x
        self.dx = x[1] - x[0]
        self.N = Nd - Na
        self.T = T
        self.kT = kB * T
        self.Eg0 = Eg_T(T)
        self.dEg = bgn * slotboom(Na + Nd)
        self.Nc = NC300 * (T / 300.0) ** 1.5
        self.Nv = NV300 * (T / 300.0) ** 1.5
        self.psi = None

    # bandas: Ev = -psi + dEg/2 ; Ec = Eg0 - psi - dEg/2
    def bands(self):
        return -self.psi + self.dEg / 2, self.Eg0 - self.psi - self.dEg / 2

    def carriers(self, psi, Efn, dEg):
        kT = self.kT
        etap = (-psi + dEg / 2) / kT
        etan = (Efn - self.Eg0 + psi + dEg / 2) / kT
        p = self.Nv * fd_half(etap)
        n = self.Nc * fd_half(etan)
        dp = -self.Nv * dfd_half(etap) / kT
        dn = self.Nc * dfd_half(etan) / kT
        return p, n, dp, dn

    def neutral_psi(self, N, Efn, dEg):
        """Potencial de neutralidad (biseccion vectorizada). N y dEg escalares o vectores."""
        N = np.atleast_1d(np.asarray(N, dtype=float))
        dEg = np.broadcast_to(np.asarray(dEg, dtype=float), N.shape)
        lo = np.full(N.shape, -1.5)
        hi = np.full(N.shape, 40.0)
        for _ in range(60):
            mid = 0.5 * (lo + hi)
            p, n = self.Nv * fd_half((-mid + dEg / 2) / self.kT), self.Nc * fd_half((Efn - self.Eg0 + mid + dEg / 2) / self.kT)
            up = p - n + N > 0
            lo = np.where(up, mid, lo)
            hi = np.where(up, hi, mid)
        r = 0.5 * (lo + hi)
        return r if r.size > 1 else float(r[0])

    def solve(self, V=0.0, tol=1e-7, itmax=600):
        Efn = V
        x, dx, N, dEg = self.x, self.dx, self.N, self.dEg
        n_pts = len(x)
        pl = self.neutral_psi(N[0], Efn, dEg[0])
        pr = self.neutral_psi(N[-1], Efn, dEg[-1])
        if self.psi is None:
            st = max(1, n_pts // 400)
            ps = self.neutral_psi(N[::st], 0.0, dEg[::st])
            psi = np.interp(x, x[::st], ps)
        else:
            psi = self.psi.copy()
        w = (psi - psi[0]) / max(psi[-1] - psi[0], 1e-9)
        psi = psi + w * (pr - psi[-1]) + (1 - w) * (pl - psi[0])
        psi[0], psi[-1] = pl, pr
        c = q / EPS
        ab = np.zeros((3, n_pts))
        ab[0, 2:] = 1.0 / dx**2
        ab[2, :-2] = 1.0 / dx**2
        ab[1, 0] = ab[1, -1] = 1.0 / dx**2   # misma escala que el resto (con 1.0 la fila de contorno se pierde en el pivoteo)
        for it in range(itmax):
            p, n, dp, dn = self.carriers(psi, Efn, dEg)
            R = np.zeros(n_pts)
            R[1:-1] = (psi[:-2] - 2 * psi[1:-1] + psi[2:]) / dx**2 + c * (p[1:-1] - n[1:-1] + N[1:-1])
            ab[1, 1:-1] = -2.0 / dx**2 + c * (dp[1:-1] - dn[1:-1])
            d = solve_banded((1, 1), ab, -R)
            m = np.max(np.abs(d))
            lim = 0.15
            if m > lim:
                d *= lim / m
            psi += d
            if m < tol:
                break
        else:
            raise RuntimeError("Poisson no converge (V=%g, max d=%g)" % (V, m))
        self.psi = psi
        self.Efn = Efn
        self.p, self.n = p, n
        return psi

    def field(self):
        return np.gradient(self.psi, self.dx)

    def summary(self):
        """Emax, anchura al 10 %, y degeneracion de VOLUMEN (maximo de Ev-Efp en el lado p y de Efn-Ec en el n), eV."""
        E = self.field()
        i = int(np.argmax(np.abs(E)))
        Emax = abs(E[i])
        on = np.where(np.abs(E) > 0.1 * Emax)[0]
        W10 = self.x[on[-1]] - self.x[on[0]]
        Ev, Ec = self.bands()
        xi_p = np.max(Ev)                 # Ev - Efp (Efp = 0)
        xi_n = np.max(self.Efn - Ec)
        return Emax, W10, xi_p, xi_n

    def tunnel(self, F0=F0_HURKX, A=A_HURKX, nE=240, nu=61):
        """Tunel banda a banda no local. Devuelve (J, lmin): J > 0 sentido inverso (Zener), J < 0 directo (Esaki)."""
        Ev, Ec = self.bands()
        x = self.x
        mEv = np.maximum.accumulate(-Ev) + 1e-12 * np.arange(len(x))   # -Ev creciente
        mEc = np.maximum.accumulate(-Ec) + 1e-12 * np.arange(len(x))
        Ev_L, Ec_R = -mEv[0], -mEc[-1]
        if Ev_L <= Ec_R:
            return 0.0, np.inf
        kT = self.kT
        # ventana: acotada a las energias donde (fv - fc) no es despreciable
        lo = max(Ec_R, min(0.0, self.Efn) - 30 * kT)
        hi = min(Ev_L, max(0.0, self.Efn) + 30 * kT)
        if hi <= lo:
            return 0.0, np.inf
        Es = lo + (np.arange(nE) + 0.5) * (hi - lo) / nE
        dE = (hi - lo) / nE
        x1 = np.interp(-Es, mEv, x)
        x2 = np.interp(-Es, mEc, x)
        Lp = x2 - x1
        ok = Lp > 0
        if not ok.any():
            return 0.0, np.inf
        Es, x1, Lp = Es[ok], x1[ok], Lp[ok]
        u = np.linspace(0, 1, nu)
        xs = x1[:, None] + Lp[:, None] * u[None, :]
        ev = -np.interp(xs, x, mEv)
        ec = -np.interp(xs, x, mEc)
        a = np.clip(Es[:, None] - ev, 0, None)
        b = np.clip(ec - Es[:, None], 0, None)
        mr = mr_from_F0(F0)
        pref = np.sqrt(2 * mr) / HBAR * np.sqrt(q) * 1e-2
        kap = pref * np.sqrt(a * b / np.maximum(a + b, 1e-9))
        Tw = np.exp(-2.0 * np.trapezoid(kap, u, axis=1) * Lp)
        Egm = np.mean(a + b, axis=1)
        Fbar = Egm / Lp
        fv = 1.0 / (1.0 + np.exp(np.clip(Es / kT, -60, 60)))
        fc = 1.0 / (1.0 + np.exp(np.clip((Es - self.Efn) / kT, -60, 60)))
        J = q * A * np.sum(Fbar**1.5 * Tw * (fv - fc)) * dE
        return J, float(Lp.min())

    def tat(self, tau=1e-9, mt=0.25):
        """Recombinacion SRH asistida por tunel (Hurkx). J > 0 en directa. tau_n = tau_p = tau; trampa a mitad de banda."""
        Ev, Ec = self.bands()
        kT = self.kT
        F = np.abs(self.field()) * 100.0 + 1.0           # V/m
        Eg = Ec - Ev
        dEn = np.clip(Ec - Ec[-1], 0, Eg / 2)
        dEp = np.clip(Ev[0] - Ev, 0, Eg / 2)
        u = np.linspace(0, 1, 49)

        def gamma(dE):
            K = 4.0 / 3.0 * np.sqrt(2 * mt * M0 * (dE * q) ** 3) / (q * HBAR * F)
            ex = (dE / kT)[:, None] * u[None, :] - K[:, None] * u[None, :] ** 1.5
            return (dE / kT) * np.trapezoid(np.exp(np.clip(ex, -200, 200)), u, axis=1)
        gn, gp = gamma(dEn), gamma(dEp)
        ni = np.sqrt(self.Nc * self.Nv) * np.exp(-Eg / (2 * kT))
        num = self.n * self.p * (1.0 - np.exp(-self.Efn / kT))
        den = tau * ((self.n + ni) / (1 + gn) + (self.p + ni) / (1 + gp))
        return q * np.trapezoid(num / den, self.x)

    def ion_integral(self, eth_n=0.0, eth_p=0.0):
        """Integral de ionizacion. eth > 0: espacio muerto de umbral duro (eV). Ruptura cuando llega a 1."""
        E = np.abs(self.field())
        psi = self.psi
        Es = np.maximum(E, 1e3)
        an = 7.03e5 * np.exp(-1.231e6 / Es)
        ap = np.where(Es < 4e5, 1.582e6 * np.exp(-2.036e6 / Es), 6.71e5 * np.exp(-1.693e6 / Es))
        if eth_n > 0:
            an = np.where(psi - psi[0] >= eth_n, an, 0.0)
            ap = np.where(psi[-1] - psi >= eth_p, ap, 0.0)
        dx = self.dx
        d = (an - ap) * dx
        head = np.cumsum(d) - d                      # int_0^x (an - ap): electrones inyectados por el lado p, hacia +x
        return float(np.sum(an * np.exp(-np.clip(head, -50, 50))) * dx)   # = 1 - 1/Mn


def profile(x, Np, Nn, Gp, Gn, d, Nw=6e16, kind="log"):
    """Dopado lateral de dos mascaras. p+ a la izquierda (borde en -d/2), n+ a la derecha (borde en +d/2); d < 0 solape.
    kind = "log": N = pico/(1 + 10^(dist/G)) (mitad de pico en el borde de mascara, cola de G por decada).
    kind = "erfc": N = pico/2 erfc(dist/(sqrt(2) sigma)), con sigma = G/1.443 (misma pendiente a mitad de pico)."""
    if kind == "log":
        za = np.clip((x + d / 2) / Gp, -300, 300)
        zd = np.clip(-(x - d / 2) / Gn, -300, 300)
        Na = Np / (1.0 + 10.0**za)
        Nd = Nn / (1.0 + 10.0**zd) + Nw
    else:
        from scipy.special import erfc
        sp, sn = Gp / 1.443, Gn / 1.443
        Na = Np / 2 * erfc((x + d / 2) / (np.sqrt(2) * sp))
        Nd = Nn / 2 * erfc(-(x - d / 2) / (np.sqrt(2) * sn)) + Nw
    return Na, Nd


def abrupt(x, Na0, Nd0):
    return np.where(x < 0, Na0, 0.0), np.where(x >= 0, Nd0, 0.0)
