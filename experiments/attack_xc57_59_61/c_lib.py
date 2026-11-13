"""c_lib.py — solucionador 2D estacionario de calor (diferencias finitas, malla uniforme) para la sección
transversal de SKY130. Usado por c57_* y c59_*. Alturas del PDK local (sky130A.tech l. 5048-5058):
poly 0.3262..0.5062, li 0.9361..1.0361, met1 1.3761..1.7361; óxido de campo bajo poly = 0.326 um
(coincide con eps/C: defaultareacap *poly 106.13 aF/um2, l. 5302 -> 3.9*8.854e-12/106.13e-6 = 0.325 um).
Origen y=0 = silicio bajo el óxido de campo. La zona activa (mesa) sube hasta y=0.326 (nivel del fondo del poly).
Unidades: um para geometría; resultados en K por (W/m) de potencia lineal."""
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spl

H_FOX = 0.326; T_POLY = 0.18; Y_LI = 0.936; T_LI = 0.10

def solve2d(rects_k, sources, h=0.02, xlim=(-8, 8), ylim=(-6, 3.0), k_ox=1.4, k_si=150.0):
    """rects_k: lista (x0,x1,y0,y1,k) pintada sobre el fondo (silicio y<0, óxido y>0).
    sources: lista (x0,x1,y0,y1,P_lin[W/m]) repartida uniforme. Dirichlet T=0 en fondo y lados DEL SILICIO; resto adiabático.
    Devuelve x,y (centros, um), T[K]."""
    nx = int(round((xlim[1]-xlim[0])/h)); ny = int(round((ylim[1]-ylim[0])/h))
    x = xlim[0] + (np.arange(nx)+0.5)*h; y = ylim[0] + (np.arange(ny)+0.5)*h
    X, Y = np.meshgrid(x, y, indexing='ij')
    k = np.where(Y < 0, k_si, k_ox).astype(float)
    for (x0, x1, y0, y1, kk) in rects_k:
        k[(X > x0) & (X < x1) & (Y > y0) & (Y < y1)] = kk
    q = np.zeros_like(k)  # W/m por celda
    for (x0, x1, y0, y1, P) in sources:
        m = (X > x0) & (X < x1) & (Y > y0) & (Y < y1)
        q[m] += P / m.sum()
    idx = np.arange(nx*ny).reshape(nx, ny)
    gx = 2*k[:-1, :]*k[1:, :]/(k[:-1, :]+k[1:, :])  # conductancia por unidad de profundidad (h/h = 1)
    gy = 2*k[:, :-1]*k[:, 1:]/(k[:, :-1]+k[:, 1:])
    rows = np.concatenate([idx[:-1, :].ravel(), idx[1:, :].ravel(), idx[:, :-1].ravel(), idx[:, 1:].ravel()])
    cols = np.concatenate([idx[1:, :].ravel(), idx[:-1, :].ravel(), idx[:, 1:].ravel(), idx[:, :-1].ravel()])
    vals = np.concatenate([gx.ravel(), gx.ravel(), gy.ravel(), gy.ravel()])
    A = sp.coo_matrix((-vals, (rows, cols)), shape=(nx*ny, nx*ny)).tocsr()
    diag = -np.asarray(A.sum(axis=1)).ravel()
    # Dirichlet: fondo (j=0) y lados en silicio
    d = np.zeros((nx, ny))
    d[:, 0] += 2*k[:, 0]
    sil = Y[0, :] < 0
    d[0, sil] += 2*k[0, sil]; d[-1, sil] += 2*k[-1, sil]
    A = A + sp.diags(diag + d.ravel())
    T = spl.spsolve(A.tocsc(), q.ravel()).reshape(nx, ny)
    return x, y, T

def mean_in(x, y, T, x0, x1, y0, y1):
    X, Y = np.meshgrid(x, y, indexing='ij')
    m = (X > x0) & (X < x1) & (Y > y0) & (Y < y1)
    return T[m].mean()
