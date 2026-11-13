"""b05_lib: térmica propia de la ronda 2 (generaliza a05_c_termica.py de la ronda 1; no lo importa).
sec2d: sección 2D (diferencias finitas, media sección por simetría) de una línea enterrada en óxido sobre silicio isotermo.
fin1d: aleta 1D a lo largo de la línea con tramos de propiedades distintas, R'(T) y corriente fija o limitada por tensión.
Supuestos comunes (de memoria, por eso se barren): k_ox 1,0-1,4 W/mK; c_ox 1,65e6 J/m3K; sustrato isotermo; sin metales vecinos
(los vecinos enfrían más: esto es cota alta de dT); techo adiabático."""
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spl
L0 = 2.44e-8  # Wiedemann-Franz, W.Ohm/K2
c_ox = 1.65e6

def sec2d(w, t, y0, k_line, c_line, k_ox, h, transient=True, X=6e-6, Y=5e-6):
    """w ancho total, t espesor, y0 altura del fondo sobre el silicio. Devuelve G' [W/m.K], t50/t63/t90 [s]."""
    nx = int(X / h); ny = int(Y / h)
    wc = max(1, int(round(w / 2 / h))); j0 = int(round(y0 / h)); j1 = j0 + max(1, int(round(t / h)))
    k = np.full((ny, nx), k_ox); c = np.full((ny, nx), c_ox)
    k[j0:j1, :wc] = k_line; c[j0:j1, :wc] = c_line
    src = np.zeros((ny, nx)); A = (j1 - j0) * wc * h * h
    src[j0:j1, :wc] = 0.5 / A
    idx = np.arange(nx * ny).reshape(ny, nx)
    rows = []; cols = []; vals = []; diag = np.zeros(nx * ny)
    kx = 2 * k[:, :-1] * k[:, 1:] / (k[:, :-1] + k[:, 1:]); ky = 2 * k[:-1, :] * k[1:, :] / (k[:-1, :] + k[1:, :])
    for a, b, g in ((idx[:, :-1].ravel(), idx[:, 1:].ravel(), kx.ravel()), (idx[:-1, :].ravel(), idx[1:, :].ravel(), ky.ravel())):
        rows += [a, b]; cols += [b, a]; vals += [-g, -g]; np.add.at(diag, a, g); np.add.at(diag, b, g)
    diag[idx[0, :]] += 2 * k[0, :]
    n = nx * ny
    K = sp.csc_matrix((np.concatenate(vals + [diag]), (np.concatenate(rows + [np.arange(n)]), np.concatenate(cols + [np.arange(n)]))))
    q = (src * h * h).ravel()
    Tss = spl.spsolve(K, q)
    line = idx[j0:j1, :wc].ravel()
    dT = Tss[line].mean()
    out = {'Gp': 1.0 / dT, 'w_eff': 2 * wc * h, 't_eff': (j1 - j0) * h, 'y0_eff': j0 * h}
    if transient:
        C = (c * h * h).ravel(); T = np.zeros(n); tt = 0; dt = 0.2e-9; ts = [0]; Ts = [0]
        while tt < 100e-6:
            lu = spl.splu((sp.diags(C / dt) + K).tocsc())
            for _ in range(6):
                T = lu.solve(C / dt * T + q); tt += dt; ts.append(tt); Ts.append(T[line].mean() / dT)
            dt *= 1.5
        ts = np.array(ts); Ts = np.array(Ts)
        for f in (0.5, 0.632, 0.9): out[f't{int(f*100)}'] = float(np.interp(f, Ts, ts))
    return out

def fin1d(segs, I=None, drv=None, dx=5e-9, T0=300.0, maxit=400):
    """segs: lista de dicts {L, kA [W.m/K], Gp [W/m.K], r0 [Ohm/m a T0], a1, a2 (R'=r0(1+a1 dT+a2 dT^2))}.
    Extremos a T0. I fija [A], o drv=(Isat, Rdrv): I = min(Isat, 1.8/(R(T)+Rdrv)) (modelo del driver: fuente que satura + resistencia de triodo).
    Devuelve dTmax, R(T), I, perfil."""
    x = []; kA = []; Gp = []; r0 = []; a1 = []; a2 = []
    for s in segs:
        n = max(1, int(round(s['L'] / dx)))
        kA += [s['kA']] * n; Gp += [s['Gp']] * n; r0 += [s['r0']] * n; a1 += [s.get('a1', 0)] * n; a2 += [s.get('a2', 0)] * n
    kA = np.array(kA); Gp = np.array(Gp); r0 = np.array(r0); a1 = np.array(a1); a2 = np.array(a2); n = len(kA)
    kf = 2 * kA[:-1] * kA[1:] / (kA[:-1] + kA[1:]) / dx
    main = np.zeros(n); main[:-1] += kf; main[1:] += kf; main[0] += 2 * kA[0] / dx; main[-1] += 2 * kA[-1] / dx
    M = sp.diags([main + Gp * dx, -kf, -kf], [0, -1, 1]).tocsc(); lu = spl.splu(M)
    T = np.zeros(n); Icur = I if I is not None else drv[0]
    for it in range(maxit):
        rT = r0 * np.clip(1 + a1 * T + a2 * T * T, 0.05, None)
        R = (rT * dx).sum()
        if drv is not None: Icur = min(drv[0], 1.8 / (R + drv[1]))
        Tn = lu.solve(Icur ** 2 * rT * dx)
        Tn = 0.5 * T + 0.5 * Tn
        if not np.all(np.isfinite(Tn)) or Tn.max() > 2e4: return dict(dTmax=np.inf, R=np.nan, I=Icur)
        if abs(Tn - T).max() < 1e-4 * max(1, Tn.max()): T = Tn; break
        T = Tn
    rT = r0 * np.clip(1 + a1 * T + a2 * T * T, 0.05, None)
    return dict(dTmax=float(T.max()), R=float((rT * dx).sum()), R0=float((r0 * dx).sum()), I=Icur, T=T, V=float(Icur * (rT * dx).sum()))
