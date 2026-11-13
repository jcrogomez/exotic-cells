# v4o_grid.py — rejilla 3D no uniforme de volumenes finitos (centros de celda) y resolvedor simetrico.
# Codigo propio del verificador (ronda 4, optica). Unidades: um.
import numpy as np
import scipy.sparse as sp
import scipy.sparse.linalg as spla


def axis(fine_lo, fine_hi, h, far_lo, far_hi, ratio=1.2):
    """Caras de celda: uniforme h en [fine_lo, fine_hi], crecimiento geometrico hasta far_lo / far_hi."""
    n = int(round((fine_hi - fine_lo) / h))
    faces = list(fine_lo + h * np.arange(n + 1))
    s, x = h, fine_hi
    while x < far_hi:
        s *= ratio; x = min(x + s, far_hi) if far_hi - (x + s) > 0.3 * s * ratio else far_hi
        faces.append(x)
    s, x = h, fine_lo
    lo = []
    while x > far_lo:
        s *= ratio; x = max(x - s, far_lo) if (x - s) - far_lo > 0.3 * s * ratio else far_lo
        lo.append(x)
    return np.array(lo[::-1] + faces)


class Grid:
    def __init__(self, fx, fy, fz):
        self.fx, self.fy, self.fz = fx, fy, fz
        self.cx = 0.5 * (fx[1:] + fx[:-1]); self.cy = 0.5 * (fy[1:] + fy[:-1]); self.cz = 0.5 * (fz[1:] + fz[:-1])
        self.dx = np.diff(fx); self.dy = np.diff(fy); self.dz = np.diff(fz)
        self.shape = (len(self.cx), len(self.cy), len(self.cz))
        self.X, self.Y, self.Z = np.meshgrid(self.cx, self.cy, self.cz, indexing='ij')
        self.V = (self.dx[:, None, None] * self.dy[None, :, None] * self.dz[None, None, :])

    def box(self, x0, x1, y0, y1, z0, z1):
        return (self.X > x0) & (self.X < x1) & (self.Y > y0) & (self.Y < y1) & (self.Z > z0) & (self.Z < z1)

    def solve(self, sigma, sink_rate, dirichlet_mask, dirichlet_val, source=None,
              neumann_far=False, far_val=0.0, tol=1e-9, maxiter=20000):
        """Resuelve -div(sigma grad u) + sink_rate*u = source, con u fijada en dirichlet_mask.
        Fronteras: z=0 Neumann (superficie). Laterales y fondo: Dirichlet far_val salvo neumann_far=True.
        sigma, sink_rate: arrays por celda (sink_rate ya multiplicado por nada: se multiplica por el volumen aqui)."""
        nx, ny, nz = self.shape
        N = nx * ny * nz
        idx = np.arange(N).reshape(self.shape)
        rows, cols, vals = [], [], []
        diag = sink_rate.ravel() * self.V.ravel()
        diag = diag.astype(float).copy()
        rhs = np.zeros(N) if source is None else (source * self.V).ravel().astype(float).copy()
        # caras interiores
        for ax in range(3):
            c = [self.cx, self.cy, self.cz][ax]
            d = [self.dx, self.dy, self.dz][ax]
            dist = np.diff(c)
            sl_a = [slice(None)] * 3; sl_b = [slice(None)] * 3
            sl_a[ax] = slice(0, -1); sl_b[ax] = slice(1, None)
            sa, sb = sigma[tuple(sl_a)], sigma[tuple(sl_b)]
            # media armonica ponderada por distancia
            da = d[:-1] / 2; db = d[1:] / 2
            shp = [1, 1, 1]; shp[ax] = -1
            da = da.reshape(shp); db = db.reshape(shp)
            with np.errstate(divide='ignore', invalid='ignore'):
                g = 1.0 / (da / np.maximum(sa, 1e-30) + db / np.maximum(sb, 1e-30))
            area = [self.dy[None, :, None] * self.dz[None, None, :],
                    self.dx[:, None, None] * self.dz[None, None, :],
                    self.dx[:, None, None] * self.dy[None, :, None]][ax]
            G = (g * area)
            ia, ib = idx[tuple(sl_a)].ravel(), idx[tuple(sl_b)].ravel()
            Gv = np.broadcast_to(G, idx[tuple(sl_a)].shape).ravel()
            rows += [ia, ib]; cols += [ib, ia]; vals += [-Gv, -Gv]
            np.add.at(diag, ia, Gv); np.add.at(diag, ib, Gv)
            # fronteras exteriores en este eje
            for side in (0, 1):
                if ax == 2 and side == 0:
                    continue  # superficie: Neumann
                if neumann_far:
                    continue
                sl = [slice(None)] * 3; sl[ax] = 0 if side == 0 else -1
                dd = d[0] / 2 if side == 0 else d[-1] / 2
                areab = area if ax != 0 else self.dy[None, :, None] * self.dz[None, None, :]
                areab = np.broadcast_to([self.dy[None, :, None] * self.dz[None, None, :],
                                         self.dx[:, None, None] * self.dz[None, None, :],
                                         self.dx[:, None, None] * self.dy[None, :, None]][ax],
                                        (nx, ny, nz))[tuple(sl)]
                Gb = (sigma[tuple(sl)] / dd * areab).ravel()
                ib2 = idx[tuple(sl)].ravel()
                np.add.at(diag, ib2, Gb)
                np.add.at(rhs, ib2, Gb * far_val)
        A = sp.coo_matrix((np.concatenate(vals), (np.concatenate(rows), np.concatenate(cols))), shape=(N, N)).tocsr()
        A = A + sp.diags(diag)
        dm = dirichlet_mask.ravel()
        u = np.zeros(N); u[dm] = np.broadcast_to(dirichlet_val, self.shape).ravel()[dm]
        free = ~dm
        Aff = A[free][:, free]
        b = rhs[free] - A[free][:, dm] @ u[dm]
        M = sp.diags(1.0 / Aff.diagonal())
        x, info = spla.cg(Aff, b, rtol=tol, maxiter=maxiter, M=M)
        u[free] = x
        self._A, self._u = A, u
        return u.reshape(self.shape), info

    def flux_into(self, mask):
        """Corriente neta que sale de las celdas mask hacia el resto (usa la ultima solucion)."""
        r = self._A @ self._u
        return r[mask.ravel()].sum()
