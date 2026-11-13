"""a20_lib: Poisson 1D con Fermi-Dirac + tunel banda a banda por camino no local (WKB dos bandas,
prefactor de Hurkx). Unidades: cm, V, eV, A/cm^2.

Constantes (todas DE MEMORIA salvo donde se indica; son las de manual para silicio a 300 K):
  Eg = 1.12 eV, eps_r = 11.7, Nc = 2.86e19, Nv = 3.10e19 cm^-3 (Green 1990)
  Hurkx 1992 (IEEE TED 39, 331), tunel indirecto en silicio: G = A |F|^2.5 D exp(-F0/|F|),
    A = 4e14 cm^-1/2 V^-5/2 s^-1, F0 = 1.9e7 V/cm.   (DE MEMORIA; no se abrio el articulo)
  "Kane del plan": F0 = 3e7 V/cm (valor que usa PLAN.md).
No se incluye: estrechamiento de banda por dopado, ionizacion incompleta, trampas (corriente de exceso),
efectos 2D. Sin trampas no hay valle: toda relacion pico/valle de este codigo es cota superior.
"""
import numpy as np
from scipy.linalg import solve_banded

q = 1.602176634e-19
kB = 8.617333e-5          # eV/K
eps0 = 8.8541878e-14      # F/cm
EPS = 11.7 * eps0
HBAR = 1.054571817e-34    # J s
M0 = 9.1093837e-31
NC300, NV300 = 2.86e19, 3.10e19
A_HURKX = 4e14
F0_HURKX = 1.9e7
F0_PLAN = 3.0e7


def Eg_T(T):
    # Varshni para silicio (DE MEMORIA): 1.17 - 4.73e-4 T^2/(T+636); se reescala para dar 1.12 a 300 K
    eg = 1.17 - 4.73e-4 * T * T / (T + 636.0)
    return eg * (1.12 / (1.17 - 4.73e-4 * 300 * 300 / 936.0))


def fd_half(eta):
    """Integral de Fermi-Dirac de orden 1/2 normalizada (Bednarczyk, error < 0.4 %)."""
    eta = np.asarray(eta, dtype=float)
    e = np.clip(eta, -200, 500)
    v = e**4 + 50.0 + 33.6 * e * (1.0 - 0.68 * np.exp(-0.17 * (e + 1.0) ** 2))
    return 1.0 / (np.exp(-e) + 3.0 * np.sqrt(np.pi) / 4.0 * v ** (-3.0 / 8.0))


def dfd_half(eta):
    h = 1e-4
    return (fd_half(eta + h) - fd_half(eta - h)) / (2 * h)


def mr_from_F0(F0, Eg):
    """Masa reducida que hace que el WKB de dos bandas de exp(-F0/F) en campo uniforme."""
    # F0 [V/m] = pi sqrt(2 m) Eg^1.5 / (4 hbar q)
    F0m = F0 * 100.0
    s = F0m * 4 * HBAR * q / (np.pi * (Eg * q) ** 1.5)
    return s * s / 2.0


class Junction:
    def __init__(self, x, Na, Nd, T=300.0):
        self.x = x
        self.dx = x[1] - x[0]
        self.N = Nd - Na
        self.T = T
        self.kT = kB * T
        self.Eg = Eg_T(T)
        self.Nc = NC300 * (T / 300.0) ** 1.5
        self.Nv = NV300 * (T / 300.0) ** 1.5
        self.psi = None

    def carriers(self, psi, Efn):
        kT = self.kT
        etap = -psi / kT
        etan = (Efn - self.Eg + psi) / kT
        p = self.Nv * fd_half(etap)
        n = self.Nc * fd_half(etan)
        dp = -self.Nv * dfd_half(etap) / kT
        dn = self.Nc * dfd_half(etan) / kT
        return p, n, dp, dn

    def neutral_psi(self, N, Efn):
        lo, hi = -1.0, 3.0
        for _ in range(80):
            mid = 0.5 * (lo + hi)
            p, n, _, _ = self.carriers(np.array([mid]), Efn)
            if p[0] - n[0] + N > 0:
                lo = mid
            else:
                hi = mid
        return 0.5 * (lo + hi)

    def solve(self, V=0.0, tol=1e-7, itmax=400):
        """V > 0 directa, V < 0 inversa. Efp = 0 (lado p, izquierda), Efn = V."""
        Efn = V
        x, dx, N = self.x, self.dx, self.N
        n_pts = len(x)
        pl = self.neutral_psi(N[0], Efn)
        pr = self.neutral_psi(N[-1], Efn)
        if self.psi is None:
            psi = np.array([self.neutral_psi(Ni, 0.0) for Ni in N[::max(1, n_pts // 400)]])
            psi = np.interp(x, x[::max(1, n_pts // 400)], psi)
            self.V_last = 0.0
        else:
            psi = self.psi.copy()
        # desplaza el lado n con el cambio de polarizacion (continuacion)
        dV = V - getattr(self, "V_last", 0.0)
        w = (psi - psi[0]) / max(psi[-1] - psi[0], 1e-9)
        psi = psi + w * (pr - psi[-1]) + (1 - w) * (pl - psi[0])
        psi[0], psi[-1] = pl, pr
        c = q / EPS
        ab = np.zeros((3, n_pts))
        for it in range(itmax):
            p, n, dp, dn = self.carriers(psi, Efn)
            R = np.zeros(n_pts)
            R[1:-1] = (psi[:-2] - 2 * psi[1:-1] + psi[2:]) / dx**2 + c * (p[1:-1] - n[1:-1] + N[1:-1])
            ab[0, 2:] = 1.0 / dx**2
            ab[2, :-2] = 1.0 / dx**2
            ab[1, 1:-1] = -2.0 / dx**2 + c * (dp[1:-1] - dn[1:-1])
            ab[1, 0] = ab[1, -1] = 1.0
            ab[0, 1] = 0.0
            ab[2, -2] = 0.0
            d = solve_banded((1, 1), ab, -R)
            m = np.max(np.abs(d))
            lim = 0.1
            if m > lim:
                d *= lim / m
            psi += d
            if m < tol:
                break
        else:
            raise RuntimeError("Poisson no converge (V=%g, max d=%g)" % (V, m))
        self.psi = psi
        self.V_last = V
        self.Efn = Efn
        return psi

    # --- observables -------------------------------------------------
    def field(self):
        return np.gradient(self.psi, self.dx)   # V/cm (positivo: psi sube hacia el lado n)

    def depletion(self):
        """Emax, anchura donde |E| > 10 % de Emax, y degeneracion en esos dos bordes (eV dentro de la banda)."""
        E = self.field()
        i = int(np.argmax(np.abs(E)))
        Emax = abs(E[i])
        thr = 0.1 * Emax
        l = i
        while l > 0 and abs(E[l]) > thr:
            l -= 1
        r = i
        while r < len(E) - 1 and abs(E[r]) > thr:
            r += 1
        W10 = self.x[r] - self.x[l]
        xi_p = -self.psi[l]                         # Ev - Efp en el borde p (>0: degenerado)
        xi_n = self.Efn - self.Eg + self.psi[r]     # Efn - Ec en el borde n
        return Emax, W10, xi_p, xi_n, self.x[i]

    def tunnel(self, F0=F0_HURKX, A=A_HURKX, nE=160):
        """Corriente de tunel (A/cm^2). Positiva = sentido inverso (Zener); negativa = directa (Esaki).
        Devuelve (J, l_min) con l_min el camino de tunel mas corto dentro de la ventana (cm)."""
        psi = np.maximum.accumulate(self.psi)
        x = self.x
        Eg = self.Eg
        Ev_L = -psi[0]
        Ec_R = Eg - psi[-1]
        if Ev_L <= Ec_R:
            return 0.0, np.inf
        mr = mr_from_F0(F0, 1.12)   # mr fijado con Eg de 300 K; la T entra por Eg(T)
        pref = np.sqrt(2 * mr) / HBAR * np.sqrt(q) * 1e-2    # kappa [1/cm] = pref * sqrt(eV)
        Es = np.linspace(Ec_R, Ev_L, nE + 2)[1:-1]
        kT = self.kT
        J = 0.0
        lmin = np.inf
        dE = Es[1] - Es[0]
        # psi estrictamente creciente para interpolar
        pm = psi + 1e-12 * np.arange(len(psi))
        for E in Es:
            x1 = np.interp(-E, pm, x)          # Ev(x1) = E
            x2 = np.interp(Eg - E, pm, x)      # Ec(x2) = E
            L = x2 - x1
            if L <= 0:
                continue
            xs = np.linspace(x1, x2, 81)
            ps = np.interp(xs, x, pm)
            a = np.clip(E + ps, 0, None)          # E - Ev
            b = np.clip(Eg - ps - E, 0, None)     # Ec - E
            kap = pref * np.sqrt(a * b / Eg)
            Tw = np.exp(-2.0 * np.trapezoid(kap, xs))
            Fbar = Eg / L
            fv = 1.0 / (1.0 + np.exp(np.clip((E - 0.0) / kT, -60, 60)))
            fc = 1.0 / (1.0 + np.exp(np.clip((E - self.Efn) / kT, -60, 60)))
            J += q * A * Fbar**1.5 * Tw * (fv - fc) * dE
            lmin = min(lmin, L)
        return J, lmin


def profile(x, Np, Nn, G, d, Nw=1e17):
    """Dopado lateral de dos mascaras. x en cm; G en cm/decada; d = separacion dibujada (cm; <0 solape).
    p+ a la izquierda (borde en -d/2), n+ a la derecha (borde en +d/2), fondo de pozo n Nw.
    Cada borde: Npico / (1 + 10^(distancia/G)): mitad del pico en el borde de mascara, cola de G por decada."""
    za = np.clip((x + d / 2) / G, -300, 300)
    zd = np.clip(-(x - d / 2) / G, -300, 300)
    Na = Np / (1.0 + 10.0**za)
    Nd = Nn / (1.0 + 10.0**zd) + Nw
    return Na, Nd
