"""Generador del simulador de discriminacion de XC-19 (prerregistro XC-19_2026-11-23_discriminacion_abanico.md + enmiendas 1 y 2).

Comun a los dos estimadores (E_A del autor, E_B independiente). Solo genera lecturas y verdad; no estima nada.

Modelo (§5 del prerregistro, A2-A3 de la enmienda 1, B1 de la enmienda 2):
  t_k[n] = t_c*(WL_C0/WL_k) * (1 + s_c*(dV_A[n] + b[n])/0.305 mV) * (1 + eps_A[n])
  t_B[n] = t_c * (1 + s_c*(dV_B[n] + 0.95*b[n])/0.305 mV) * (1 + eps_B[n])
  dV = suma de telegramas: a ~ Exp(eta*q/(Cox W L)), tau log-uniforme en [1 us, 1e4 s], p = 1/2, numero Poisson con densidad
       rho*f*A por decada de tau (rho = N_banda(C0) / log10(T*fa/2)); trampas con tau < t_conv: promediadas (constante, se omiten)
  eps ~ N(0, 0.108 %), b ~ N(0, 0.1 mV) por conversion
  cuenta = floor(t*50 MHz + phi) + 2; phi fijo por dispositivo (variante S) o uniforme por conversion (variante D)
Lectura entregada: y[n] = cuenta_A[n] - cuenta_B[n] (enteros), una fila por dispositivo.
"""
import math, os
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
q = 1.602176634e-19
COX = 3.9 * 8.8541878128e-12 / 4.15e-9
FCLK = 50e6
TRAP = 0.305e-3
EPS = 0.00108
SIGB = 0.1e-3
CORNERS = [("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")]
# geometria (W, L) en um por clase; A = W*L / (0,42*0,15)
GEOM = {"A1": (0.42, 0.15), "A2": (0.84, 0.15), "A4": (0.42, 0.60), "A8": (1.68, 0.30)}
WL0 = 0.42 / 0.15
AREA0 = 0.42e-6 * 0.15e-6


def corner_params():
    """t_c (s) y s_c (fraccion por 0,305 mV) del macro extraido (contrato_temporizacion.txt)."""
    V = {}
    for l in open(os.path.join(HERE, "..", "xc19_slot", "contrato_temporizacion.txt")):
        f = l.split()
        for kv in f[3:]:
            k, _, v = kv.partition("=")
            try:
                V[(f[1], f[2], k)] = float(v)
            except ValueError:
                pass
    out = {}
    for c, t in CORNERS:
        tA = V[(c, t, "h01_oa")] - 1e-6; tT = V[(c, t, "t01_oa")] - 1e-6
        out[(c, t)] = (tA, (tA - tT) / tA)
    return out


def n_band():
    """N_banda de C0 por (esquina, fa, T, eta), leido de prereg_calc.txt (seccion 2)."""
    N = {}
    for l in open(os.path.join(HERE, "prereg_calc.txt")):
        m = l.split("|")
        if len(m) == 7 and "(" in m[1] and len(m[0].split()) == 2:
            c, t = m[0].split()
            fa, T = m[1].strip().strip("()").replace(" Hz", "").replace(" s", "").split(",")
            N[(c, t, float(fa), float(T), 1)] = float(m[3]); N[(c, t, float(fa), float(T), 2)] = float(m[4])
    return N


CP = corner_params()
NB = n_band()


def in_band(tau, fa, T):
    return (tau >= 1 / (math.pi * fa)) & (tau <= T / (2 * math.pi))


def traps(rng, n_dev, rho, f, A, eta):
    """Lista por dispositivo de (tau, a). rho por decada en C0; A area relativa."""
    lam = rho * f * A * 10.0
    out = []
    for _ in range(n_dev):
        k = rng.poisson(lam)
        tau = 10 ** rng.uniform(-6, 4, k)
        a = rng.exponential(eta * q / (COX * AREA0 * A), k)
        out.append((tau, a))
    return out


def telegraph(rng, tau, a, n, dt):
    """Suma de telegramas muestreada cada dt: cadena de Markov de dos estados con p_cambio = (1 - exp(-2 dt/tau))/2."""
    v = np.zeros(n)
    for ti, ai in zip(tau, a):
        p = 0.5 * (1 - math.exp(-2 * dt / ti))
        flips = rng.random(n) < p
        x = (np.cumsum(flips) + (rng.random() < 0.5)) & 1
        v += ai * x
    return v


def simulate(rng, corner, cls, f, eta, fa, T, variant, n_dev, rho_scale=1.0, amp_scale=1.0, same_traps_in_B=False,
             quant=True):
    """Devuelve y (n_dev x N enteros), verdad por dispositivo (n_banda, n_permanencia>=10) y t_k.
    rho_scale: multiplica la densidad de C0 (prior sobre lambda0). amp_scale: mutante M1 (0). same_traps_in_B: mutante M4.
    quant=False: mutante M3 (lectura continua en cuentas)."""
    c, t = corner
    tc, sc = CP[corner]
    W, L = GEOM[cls]
    A = W * L / (0.42 * 0.15)
    tk = tc * WL0 / (W / L)
    if tk > 0.8 / fa:
        return None, None, tk
    N = int(round(fa * T)); dt = 1.0 / fa
    rho = NB[(c, t, fa, T, eta)] / math.log10(T * fa / 2) * rho_scale
    trA = traps(rng, n_dev, rho, f, A, eta)
    trB = trA if same_traps_in_B else traps(rng, n_dev, rho, 1.0, 1.0, eta)
    Y = np.empty((n_dev, N), dtype=np.int32)
    truth = np.zeros((n_dev, 2), dtype=np.int32)
    for d in range(n_dev):
        tauA, aA = trA[d]; tauB, aB = trB[d]
        keepA = tauA >= tk; keepB = tauB >= tc
        dVA = telegraph(rng, tauA[keepA], aA[keepA] * amp_scale, N, dt)
        dVB = telegraph(rng, tauB[keepB], aB[keepB] * amp_scale, N, dt) if not same_traps_in_B else dVA * A
        b = rng.normal(0, SIGB, N)
        tA = tk * (1 + sc * (dVA + b) / TRAP) * (1 + rng.normal(0, EPS, N))
        tB = tc * (1 + sc * (dVB + 0.95 * b) / TRAP) * (1 + rng.normal(0, EPS, N))
        if variant == "S":
            phA, phB = rng.random(), rng.random()
        else:
            phA, phB = rng.random(N), rng.random(N)
        if quant:
            Y[d] = (np.floor(tA * FCLK + phA) - np.floor(tB * FCLK + phB)).astype(np.int32)
        else:
            Y[d] = np.round(16 * (tA * FCLK - tB * FCLK)).astype(np.int32)   # M3: 1/16 de cuenta, sin cuantizacion real
        ib = in_band(tauA, fa, T)
        truth[d, 0] = int(ib.sum())
        truth[d, 1] = int((ib & (tauA >= 10 * dt)).sum())
    return Y, truth, tk


if __name__ == "__main__":
    for k, v in CP.items():
        print(k, f"t_c = {v[0]*1e6:.3f} us, s_c = {100*v[1]:.4f} %")
    print({k: v for k, v in NB.items() if k[2] == 1000.0 and k[3] == 1.0})
    rng = np.random.default_rng(1)
    Y, tr, tk = simulate(rng, ("tt", "27"), "A1", 1.0, 1, 1e3, 1.0, "S", 200)
    print("tt A1: dispositivos con >=1 trampa en banda:", (tr[:, 0] > 0).mean(), "(prereg_calc: 0,299)")
