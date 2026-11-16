#!/usr/bin/env python3
"""Verificador ronda 3 (xc20_hipotesis_r3): modelo generativo escrito solo desde PREREG.md (con Enmienda 1).

No usa ni lee motor3.py, motor2.py ni motor.py. Parte de ver2_modelo.py (código del verificador de la ronda 2).
Decisiones de implementación: ver ver3_INFORME.md §1.

Un "mundo" = parámetros de cada chip + corrientes verdaderas (log10) en las 11 lecturas posibles + normales estándar de la
calibración y del ruido. Todo diseño, lector y calibración es una función determinista del mismo mundo: las diferencias
son pareadas (Enmienda 1, §5).
"""
import numpy as np

KB = 8.617333262e-5
KT = (1.0 / 300.15 - 1.0 / 358.15) / KB      # exp(Ea*KT) = factor 27 -> 85 °C
L10 = np.log10

# lectura -> (V aplicada, °C, celda, d en µm). Celda 'su' = sin unión (solo B).
MEAS = {
    'b27':     (1.8, 27, 'b',   0.0),
    'd27':     (1.8, 27, 'c27', 0.27),
    'b85':     (1.8, 85, 'b',   0.0),
    'd27_85':  (1.8, 85, 'c27', 0.27),
    'b09':     (0.9, 27, 'b',   0.0),
    'su27':    (1.8, 27, 'su',  None),
    'su85':    (1.8, 85, 'su',  None),
    'd54':     (1.8, 27, 'c54', 0.54),
    'd108':    (1.8, 27, 'c108', 1.08),
    'd54_85':  (1.8, 85, 'c54', 0.54),
    'd108_85': (1.8, 85, 'c108', 1.08),
}
MKEYS = list(MEAS)
CELLS = ['b', 'c27', 'c54', 'c108', 'su']

E1 = ['b27', 'd27', 'b85', 'd27_85', 'b09']
DESIGNS = {
    'E1': E1,
    'E2': E1 + ['su27', 'su85'],
    'E3': E1 + ['su27', 'su85', 'd54'],
    'E4': E1 + ['su27', 'su85', 'd54', 'd108'],
    'E5': E1 + ['su27', 'su85', 'd54', 'd108', 'd54_85', 'd108_85'],
    'E6': ['b27', 'd27', 'd54', 'd108', 'su27'],
    'E6c': ['b27', 'd27', 'su27'],
}

# variantes
VARIANTS = {
    'W0':   dict(mechs=['T', 'R', 'M', 'G'], kmax=1e6, qfix=True, F=False, B=False, w2=False),
    'W1':   dict(mechs=['T', 'R', 'M', 'G', 'F'], kmax=1e12, qfix=False, F=True, B=True, w2=False),
    'W1q1': dict(mechs=['T', 'R', 'M', 'G', 'F'], kmax=1e12, qfix=True, F=True, B=True, w2=False),
    'W1K6': dict(mechs=['T', 'R', 'M', 'G', 'F'], kmax=1e6, qfix=False, F=True, B=True, w2=False),
    # control de mecanismo (no prerregistrado): W1q1 con el túnel anulado en d = 0,54 y 1,08 (esas celdas leen solo G + B)
    'W1q1cut': dict(mechs=['T', 'R', 'M', 'G', 'F'], kmax=1e12, qfix=True, F=True, B=True, w2=False, tcut=True),
    # W2: clase = 4 s_T + 2 s_R + s_F (8 clases, prior 1/8), B con desajuste por celda
    'W2':   dict(mechs=[f'{t}{r}{f}' for t in 'tT' for r in 'rR' for f in 'fF'], kmax=1e12, qfix=False, F=True,
                 B=True, w2=True),
}
FLAGS = {'T': (1, 0, 0), 'R': (0, 1, 0), 'M': (1, 1, 0), 'G': (0, 0, 0), 'F': (0, 0, 1)}


def flags_of(var, j):
    v = VARIANTS[var]
    if v['w2']:
        return ((j >> 2) & 1, (j >> 1) & 1, j & 1)
    return FLAGS[v['mechs'][j]]


def logu(u, lo, hi):
    return np.exp(np.log(lo) + u * (np.log(hi) - np.log(lo)))


NDIM = 22


def params(U, var):
    v = VARIANTS[var]
    p = {}
    p['g0'] = logu(U[:, 0], 3e-18, 2e-12)
    p['gea'] = 0.56 + U[:, 1] * 0.56
    p['gsh'] = 1.0 + U[:, 2] * 0.4
    p['t0'] = logu(U[:, 3], 12e-9, 0.5e-3)
    p['tsh'] = logu(U[:, 4], 15.0, 57.0)
    p['tea'] = 0.010 + U[:, 5] * 0.024
    p['K'] = logu(U[:, 6], 7e3, v['kmax'])
    p['q'] = np.ones(len(U)) if v['qfix'] else 0.5 + U[:, 7]
    p['Rb'] = logu(U[:, 8], 10.0, 1e7)
    p['nl'] = U[:, 9] < 0.5
    p['V0'] = logu(U[:, 10], 0.3, 2.0)
    p['tcr'] = 0.002 + U[:, 11] * 0.002
    p['Rs'] = logu(U[:, 12], 100.0, 5e3)
    p['Imax'] = logu(U[:, 13], 1e-4, 4e-3)
    p['f0'] = logu(U[:, 14], 1e-15, 1e-11)
    p['lF'] = 0.2 + U[:, 15] * 0.8
    p['fea'] = 0.3 + U[:, 16] * 0.4
    p['fsh'] = 1.0 + U[:, 17] * 0.4      # decisión: forma en V de F con prior propio igual al de G
    if v['B']:
        p['B'] = logu(U[:, 18], 1e-16, 1e-12)
        p['B85'] = 1.0 + U[:, 19] * 49.0
    else:
        p['B'] = np.zeros(len(U)); p['B85'] = np.ones(len(U))
    p['lsw_u'] = logu(U[:, 20], 0.1, 1.0)    # fuga de interruptores de S_f: L_sw = f·150 fA·u
    p['lsw85'] = 1.0 + U[:, 21] * 49.0
    p['tcut'] = np.full(len(U), bool(v.get('tcut', False)))
    return p


def i_dev(V, p, sT, sR, sF, tc, d):
    I = p['g0'] * (V / 1.8) ** np.log2(p['gsh'])
    if tc == 85:
        I = I * np.exp(p['gea'] * KT)
    it = p['t0'] * (V / 1.8) ** np.log2(p['tsh'])
    if tc == 85:
        it = it * np.exp(p['tea'] * KT)
    if d > 0:
        it = it * p['K'] ** (-(d / 0.27) ** p['q'])
    if d > 0.3:
        it = np.where(p['tcut'], 0.0, it)
    I = I + sT * it
    if d == 0:
        ohm = V / p['Rb']
        with np.errstate(over='ignore', invalid='ignore'):
            nlv = (1.8 / p['Rb']) * np.sinh(V / p['V0']) / np.sinh(1.8 / p['V0'])
        ir = np.where(p['nl'], nlv, ohm)
        if tc == 85:
            ir = ir / (1.0 + p['tcr'] * 58.0)
        I = I + sR * ir
    fi = p['f0'] * (V / 1.8) ** np.log2(p['fsh']) * np.exp(-d / p['lF'])
    if tc == 85:
        fi = fi * np.exp(p['fea'] * KT)
    I = I + sF * fi
    return I


def currents(p, sT, sR, sF, cellu, keys=MKEYS, nit=48):
    """log10 I (incluido B) por lectura. Excitador: V + Rs I(V) = Vap (bisección), min(I, Imax); B se suma después."""
    out = {}
    n = len(sT)
    for k in keys:
        Vap, tc, cell, d = MEAS[k]
        Bk = p['B'] * (p['B85'] if tc == 85 else 1.0) * cellu[cell]
        if cell == 'su':
            I = Bk
        else:
            lo = np.zeros(n); hi = np.full(n, Vap)
            for _ in range(nit):
                mid = 0.5 * (lo + hi)
                f = mid + p['Rs'] * i_dev(mid, p, sT, sR, sF, tc, d) - Vap
                pos = f > 0
                hi = np.where(pos, mid, hi); lo = np.where(pos, lo, mid)
            V = 0.5 * (lo + hi)
            I = np.minimum(i_dev(V, p, sT, sR, sF, tc, d), p['Imax']) + Bk
        out[k] = L10(I).astype(np.float32)
    return out


NORMS = ['zc', 'zs', 'za', 'zr0', 'zr1', 'zr2'] + ['e_' + k for k in MKEYS]


def sample_world(nper, var, seed, override=None):
    """nper chips por clase. Devuelve dict con 'lab', 'X' (log10 I por lectura), 'Z' (normales), 'p' (parámetros)."""
    v = VARIANTS[var]
    rng = np.random.default_rng(seed)
    C = len(v['mechs'])
    n = nper * C
    U = rng.random((n, NDIM))
    lab = np.repeat(np.arange(C), nper)
    p = params(U, var)
    if override:
        for kk, vv in override.items():
            p[kk] = np.full(n, vv) if np.isscalar(vv) else vv
    fl = np.array([flags_of(var, j) for j in range(C)])[lab]
    sT, sR, sF = fl[:, 0].astype(float), fl[:, 1].astype(float), fl[:, 2].astype(float)
    if v['w2']:
        cellu = {c: 10 ** (0.15 * rng.standard_normal(n)) for c in CELLS}
    else:
        rng.standard_normal((len(CELLS), n))      # mantener la secuencia
        cellu = {c: 1.0 for c in CELLS}
    X = {}
    ch = 200000
    for a in range(0, n, ch):
        sl = slice(a, a + ch)
        pp = {kk: vv[sl] for kk, vv in p.items()}
        cu = {c: (cellu[c][sl] if not np.isscalar(cellu[c]) else 1.0) for c in CELLS}
        xx = currents(pp, sT[sl], sR[sl], sF[sl], cu)
        for kk in xx:
            X.setdefault(kk, []).append(xx[kk])
    X = {kk: np.concatenate(vv) for kk, vv in X.items()}
    Z = {kk: rng.standard_normal(n).astype(np.float32) for kk in NORMS}
    keep = {kk: p[kk] for kk in ('K', 'q', 'B', 't0', 'g0', 'f0')}
    return dict(lab=lab, X=X, Z=Z, p=keep, lsw_u=p['lsw_u'], lsw85=p['lsw85'], var=var)


# ---------------- lectores y calibración ----------------
XC = {'floor': {27: 150e-15, 85: 0.1e-12}, 'ceil': 1.25e-9}
AN = {'floor': {27: 1e-9, 85: 1e-9}, 'ceil': 1e-3}
CALIB = {'C1': None, 'C3a': 0.05, 'C3b': 0.2, 'C3c': 0.5}
SIG_C, SIG_E, SIG_R = 0.5, 0.02, 0.05


def which(reader, k):
    """Qué front-end lee la lectura k: 'X' (XC26), 'A' (ancho) o 'S' (rangos)."""
    if reader in ('X', 'A'):
        return reader
    if reader == 'A2':
        return 'A' if MEAS[k][3] == 0.0 else 'X'
    if reader.startswith('S'):
        return 'S'
    raise ValueError(reader)


def limits(reader, k):
    fe = which(reader, k)
    tc = MEAS[k][1]
    if fe == 'X':
        return L10(XC['floor'][tc]), L10(XC['ceil'])
    if fe == 'A':
        return L10(AN['floor'][tc]), L10(AN['ceil'])
    f = float(reader[1:])
    return L10(f * (150e-15 if tc == 27 else 0.1e-12)), L10(1e-3)


def observe(W, calib, reader, keys, mut_lsw=True):
    """Devuelve dict k -> (estado 0 bajo/1 legible/2 saturado, y)."""
    X, Z = W['X'], W['Z']
    sg = CALIB[calib]
    obs = {}
    for k in keys:
        fe = which(reader, k)
        x = X[k].astype(np.float64)
        if fe == 'S':
            f = float(reader[1:])
            pre = x + SIG_C * Z['zc']
            rg = np.where(pre < -9, 0, np.where(pre < -6, 1, 2))
            if mut_lsw:
                lsw = f * 150e-15 * W['lsw_u'] * (W['lsw85'] if MEAS[k][1] == 85 else 1.0)
                x = np.where(rg == 0, L10(10 ** x + lsw), x)
            zr = np.choose(rg, [Z['zr0'], Z['zr1'], Z['zr2']])
            y = x + SIG_C * Z['zc'] + SIG_R * zr
        elif sg is None:        # C1: un g común a todo, también en A2
            y = x + SIG_C * Z['zc']
        else:
            y = x + SIG_C * Z['zc'] + sg * (Z['zs'] if fe == 'X' else Z['za'])
        y = y + SIG_E * Z['e_' + k]
        lf, lc = limits(reader, k)
        o = np.where(y < lf, 0, np.where(y > lc, 2, 1))
        obs[k] = (o, y)
    return obs


def features(obs, keys, reader):
    cols, vals = [], []
    for k in keys:
        o, y = obs[k]
        lf, lc = limits(reader, k)
        v = np.clip(y, lf, lc)
        cols.append((o == 0)); cols.append((o == 2))
        vals.append(v)
    for i in range(len(keys)):
        cols.append(vals[i])
        for j in range(i + 1, len(keys)):
            cols.append(vals[i] - vals[j])
    return np.stack([c.astype(np.float32) for c in cols], axis=1)
