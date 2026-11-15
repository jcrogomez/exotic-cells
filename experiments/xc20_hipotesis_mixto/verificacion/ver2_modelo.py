#!/usr/bin/env python3
"""Verificador ronda 2 (xc20_hipotesis_mixto): modelo generativo escrito solo desde PREREG.md.

No usa ni lee motor2.py / motor.py. Elecciones ante ambigüedades: ver ver2_INFORME.md §1.

Medidas (clave -> (V aplicada, °C, estructura)):
  d0_18_27, d27_18_27, d0_18_85, d27_18_85, d0_09_27, pe_18_27 (peine: T y R x4, G igual).
"""
import numpy as np

KB = 8.617333262e-5
KT = (1.0 / 300.15 - 1.0 / 358.15) / KB      # exp(Ea*KT) = factor 27 -> 85 °C
LN10 = np.log(10.0)

MEAS = {
    'd0_18_27':  (1.8, 27, 'd0'),
    'd27_18_27': (1.8, 27, 'd27'),
    'd0_18_85':  (1.8, 85, 'd0'),
    'd27_18_85': (1.8, 85, 'd27'),
    'd0_09_27':  (0.9, 27, 'd0'),
    'pe_18_27':  (1.8, 27, 'pe'),
}
MKEYS = list(MEAS)

DESIGNS = {
    'D0':          ['d0_18_27', 'd27_18_27'],
    'D0+85C':      ['d0_18_27', 'd27_18_27', 'd0_18_85', 'd27_18_85'],
    'D0+-0.9V':    ['d0_18_27', 'd27_18_27', 'd0_09_27'],
    'D0+peine':    ['d0_18_27', 'd27_18_27', 'pe_18_27'],
    'D0+85C+-0.9V': ['d0_18_27', 'd27_18_27', 'd0_18_85', 'd27_18_85', 'd0_09_27'],
}
DNAMES = list(DESIGNS)

READERS = {
    'ancho': {'floor': {27: 1e-9, 85: 1e-9}, 'ceil': 1e-3},
    'XC26':  {'floor': {27: 150e-15, 85: 0.1e-12}, 'ceil': 1.25e-9},
}

# variantes: mecanismos, R no lineal (prob), Rb max, excitador, K finito
VARIANTS = {
    'V0':     dict(mechs=['T', 'R', 'G'], p_nl=0.0, rb_hi=1e5, exc=False, kinf=False),
    'V0Kinf': dict(mechs=['T', 'R', 'G'], p_nl=0.0, rb_hi=1e5, exc=False, kinf=True),
    'V4':     dict(mechs=['T', 'R', 'M', 'G'], p_nl=0.5, rb_hi=1e7, exc=True, kinf=False),
    # variantes intermedias (fuera del mínimo pedido; para las predicciones 1-3)
    'V1':     dict(mechs=['T', 'R', 'M', 'G'], p_nl=0.0, rb_hi=1e5, exc=False, kinf=False),
    'V2':     dict(mechs=['T', 'R', 'G'], p_nl=0.5, rb_hi=1e5, exc=False, kinf=False),
    'V3':     dict(mechs=['T', 'R', 'G'], p_nl=0.0, rb_hi=1e5, exc=True, kinf=False),
}
# calibraciones: (sigma_eps, sigma_g, sigma_delta)
CALIB = {
    'C0_0.05': (0.05, 0.0, 0.0),
    'C0_0.5':  (0.5, 0.0, 0.0),
    'C1':      (0.02, 0.5, 0.0),
    'C2':      (0.02, 0.5, 0.03),
}

NDIM = 13   # dimensiones uniformes por chip


def logu(u, lo, hi):
    return np.exp(np.log(lo) + u * (np.log(hi) - np.log(lo)))


def params(U, var):
    """U: (n, 13) uniformes en [0,1). Devuelve dict de parámetros (todos los mecanismos)."""
    v = VARIANTS[var]
    p = {}
    p['g0'] = logu(U[:, 0], 3e-18, 2e-12)
    p['gea'] = 0.56 + U[:, 1] * 0.56
    p['gsh'] = 1.0 + U[:, 2] * 0.4
    p['t0'] = logu(U[:, 3], 12e-9, 0.5e-3)
    p['tsh'] = logu(U[:, 4], 15.0, 57.0)
    p['tea'] = 0.010 + U[:, 5] * 0.024
    p['K'] = np.full(len(U), np.inf) if v['kinf'] else logu(U[:, 6], 7e3, 1e6)
    p['Rb'] = logu(U[:, 7], 10.0, v['rb_hi'])
    p['nl'] = U[:, 8] < v['p_nl']
    # V0 solo se usa si nl; se reescala la misma U[:,8] no: dimensión propia
    p['V0'] = logu(U[:, 9], 0.3, 2.0)
    p['tcr'] = 0.002 + U[:, 10] * 0.002
    p['Rs'] = logu(U[:, 11], 100.0, 5e3)
    p['Imax'] = logu(U[:, 12], 1e-4, 4e-3)
    return p


def i_dev(V, p, mech, tc, struct):
    """Corriente del dispositivo a tensión V (array) sobre la estructura."""
    I = p['g0'] * (V / 1.8) ** np.log2(p['gsh'])
    if tc == 85:
        I = I * np.exp(p['gea'] * KT)
    s = 4.0 if struct == 'pe' else 1.0
    if mech in ('T', 'M'):
        it = p['t0'] * (V / 1.8) ** np.log2(p['tsh'])
        if tc == 85:
            it = it * np.exp(p['tea'] * KT)
        if struct == 'd27':
            it = it / p['K']
        I = I + s * it
    if mech in ('R', 'M') and struct != 'd27':
        V0 = p['V0']
        ohm = V / p['Rb']
        with np.errstate(over='ignore', invalid='ignore'):
            nlv = (1.8 / p['Rb']) * np.sinh(V / V0) / np.sinh(1.8 / V0)
        ir = np.where(p['nl'], nlv, ohm)
        if tc == 85:
            ir = ir / (1.0 + p['tcr'] * 58.0)
        I = I + s * ir
    return I


def currents(U, mech, var, keys=MKEYS):
    """log10 I para cada medida. Excitador: V + Rs I(V) = Vap (bisección), luego min(I, Imax)."""
    v = VARIANTS[var]
    p = params(U, var)
    out = {}
    n = len(U)
    for k in keys:
        Vap, tc, st = MEAS[k]
        if not v['exc']:
            I = i_dev(np.full(n, Vap), p, mech, tc, st)
        else:
            lo = np.zeros(n); hi = np.full(n, Vap)
            for _ in range(55):
                mid = 0.5 * (lo + hi)
                f = mid + p['Rs'] * i_dev(mid, p, mech, tc, st) - Vap
                pos = f > 0
                hi = np.where(pos, mid, hi); lo = np.where(pos, lo, mid)
            V = 0.5 * (lo + hi)
            I = np.minimum(i_dev(V, p, mech, tc, st), p['Imax'])
        out[k] = np.log10(I)
    return out


def thresholds(k, reader):
    tc = MEAS[k][1]
    if reader == 'mixto':      # exploratorio, fuera del PREREG: d=0,27 con XC26; d=0 y peine con el ancho
        reader = 'XC26' if MEAS[k][2] == 'd27' else 'ancho'
    r = READERS[reader]
    return np.log10(r['floor'][tc]), np.log10(r['ceil'])


def observe(X, Z, calib, reader, keys=MKEYS):
    """X: dict k->log10 I (n,). Z: dict de normales estándar: 'g','d', y k para eps.
    Devuelve dict k -> (estado 0 bajo/1 legible/2 saturado, y)."""
    se, sg, sd = CALIB[calib]
    obs = {}
    for k in keys:
        y = X[k] + sg * Z['g'] + (sd * Z['d'] if MEAS[k][1] == 85 else 0.0) + se * Z[k]
        lf, lc = thresholds(k, reader)
        o = np.where(y < lf, 0, np.where(y > lc, 2, 1))
        obs[k] = (o, y)
    return obs


def sample_world(n, mech, var, rng):
    U = rng.random((n, NDIM))
    X = currents(U, mech, var)
    Z = {k: rng.standard_normal(n) for k in MKEYS}
    Z['g'] = rng.standard_normal(n); Z['d'] = rng.standard_normal(n)
    return X, Z
