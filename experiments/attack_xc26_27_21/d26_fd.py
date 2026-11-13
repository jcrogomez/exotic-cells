"""d26_fd.py — diferencias finitas 3D sobre la geometría de photon_e05/e10/e20 (macros/photon/emisor.tcl, comun.tcl).

Dos problemas sobre la misma malla (h = 0,5 um):
 (1) u(r): probabilidad de que un electrón minoritario generado en r acabe en el fotodiodo (adjunto de la difusión):
     lap(u) - u/L^2 = 0, u = 1 en el volumen del fotodiodo (dnwell + vaciamiento), u = 0 en los demás pozos n
     (pozo del emisor, del control y anillo de dnwell), flujo nulo arriba y a los lados; fondo: u = 0 o flujo nulo.
 (2) V(r): potencial del sustrato p con 1 mA de huecos entrando por la unión pozo n / sustrato del emisor;
     V = 0 en los taps p+ dibujados (anillo del fotodiodo; guarda opcional) y, según escenario, en el borde lateral
     (taps de la lógica de alrededor); los pozos n son huecos aislantes.
Parámetros de proceso no públicos (profundidad de pozos, vaciamiento, L, resistividad): se barren. Nada aquí es dato medido.
Uso: python d26_fd.py  -> d26_fd.txt y d26_fd.npz
"""
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spla, time, sys, json

H = 0.5
X0, X1, Y0, Y1, ZMAX = -52.0, 35.0, -10.0, 13.0, 50.0
nx, ny, nz = int((X1-X0)/H), int((Y1-Y0)/H), int(ZMAX/H)
xc = X0 + H*(np.arange(nx)+0.5); yc = Y0 + H*(np.arange(ny)+0.5); zc = H*(np.arange(nz)+0.5)
XX, YY, ZZ = np.meshgrid(xc, yc, zc, indexing='ij')

def box(x0, x1, y0, y1, z1, z0=0.0):
    return (XX > x0) & (XX < x1) & (YY > y0) & (YY < y1) & (ZZ > z0) & (ZZ < z1)

def geometry(d, z_nw, z_dnw, dep):
    """Máscaras. dep = margen de vaciamiento hacia el sustrato (um) añadido a los pozos polarizados en inversa."""
    pd = box(0-dep, 3+dep, 0-dep, 3+dep, z_dnw+dep)
    xe = 3.0 + d
    em = box(xe-dep/2, xe+4+dep/2, 0-dep/2, 3+dep/2, z_nw+dep/2)          # pozo del emisor (polarización baja: medio margen)
    ct = box(-44-dep/2, -40+dep/2, 0-dep/2, 3+dep/2, z_nw+dep/2)          # control a 40 um
    # anillo dnwell: interior x -48,5..31,5, y -6,3..9,3, ancho 3,0 + nwell 0,4 por cada lado
    xi0, xi1, yi0, yi1 = -48.5, 31.5, -6.3, 9.3
    outer = box(xi0-3.4-dep, xi1+3.4+dep, yi0-3.4-dep, yi1+3.4+dep, z_dnw+dep)
    inner = box(xi0+0.4+dep, xi1-0.4-dep, yi0+0.4+dep, yi1-0.4-dep, 1e9)
    ring = outer & ~inner
    src_near = (xe+1.1, 1.5, 0.5)       # centro del p+ del emisor (x0+0,6..1,6; y 0,8..2,2)
    src_ctrl = (-44+1.1, 1.5, 0.5)
    return pd, em, ct, ring, src_near, src_ctrl

def solve(coef, dmask, dval, rhs=None, kappa=0.0, bottom_dirichlet=False, tol=1e-8):
    """div(coef grad u) - kappa*coef*u = -rhs, Dirichlet en dmask. Neumann en el contorno salvo fondo opcional."""
    N = nx*ny*nz
    idx = np.arange(N).reshape(nx, ny, nz)
    rows, cols, vals = [], [], []
    diag = np.zeros((nx, ny, nz))
    def face(a, b):
        return 2*a*b/(a+b+1e-300)
    for ax in range(3):
        sl_a = [slice(None)]*3; sl_b = [slice(None)]*3
        sl_a[ax] = slice(0, -1); sl_b[ax] = slice(1, None)
        ca, cb = coef[tuple(sl_a)], coef[tuple(sl_b)]
        g = face(ca, cb)                    # conductancia de cara (h^2/h * h... se cancela con h uniforme)
        ia, ib = idx[tuple(sl_a)].ravel(), idx[tuple(sl_b)].ravel()
        gg = g.ravel()
        rows += [ia, ib]; cols += [ib, ia]; vals += [-gg, -gg]
        diag[tuple(sl_a)] += g; diag[tuple(sl_b)] += g
    if bottom_dirichlet:
        diag[:, :, -1] += 2*coef[:, :, -1]
    diag += kappa*coef*H*H
    A = sp.coo_matrix((np.concatenate(vals), (np.concatenate(rows), np.concatenate(cols))), shape=(N, N)).tocsr()
    A = A + sp.diags(diag.ravel())
    b = np.zeros(N) if rhs is None else rhs.ravel().copy()
    dm = dmask.ravel(); free = ~dm
    u = np.zeros(N); u[dm] = dval.ravel()[dm]
    bf = b[free] - A[free][:, dm] @ u[dm]
    Aff = A[free][:, free]
    M = sp.diags(1.0/Aff.diagonal())
    sol, info = spla.cg(Aff, bf, rtol=tol, maxiter=20000, M=M)
    u[free] = sol
    return u.reshape(nx, ny, nz), info

def collection(d, z_nw, z_dnw, dep, L, bottom_dirichlet):
    pd, em, ct, ring, s_near, s_ctrl = geometry(d, z_nw, z_dnw, dep)
    dmask = pd | em | ct | ring
    dval = np.where(pd, 1.0, 0.0)
    u, info = solve(np.ones((nx, ny, nz)), dmask, dval, kappa=1.0/L**2, bottom_dirichlet=bottom_dirichlet)
    out = {}
    for name, s in (('near', s_near), ('ctrl', s_ctrl)):
        r2 = (XX-s[0])**2 + (YY-s[1])**2 + (ZZ-s[2])**2
        r2 = np.maximum(r2, (H/2)**2)
        G = float(np.sum(u/r2)*H**3)                 # um ; fracción recogida = alfa[1/um] * 2/(4 pi) * G (x2 por reflexión total arriba)
        # reparto: lo absorbido dentro del propio volumen del fotodiodo frente a lo que llega por difusión
        Gpd = float(np.sum(np.where(pd, 1.0, 0.0)/r2)*H**3)
        out[name] = (G, Gpd)
    Veff = float(np.sum(u)*H**3)                     # um^3: volumen efectivo de recogida (para luz uniforme)
    return out, Veff, info, u

def potential(d, z_nw, z_dnw, dep, rho_bulk, rsh_pw, guard, edge_taps):
    """V en voltios por 1 mA de huecos entrando al sustrato desde el pozo del emisor. rho en ohm·cm; rsh_pw ohm/sq (capa pozo p de 1 um)."""
    pd, em, ct, ring, s_near, s_ctrl = geometry(d, z_nw, z_dnw, dep)
    ins = pd | em | ct | ring
    sig_bulk = 1.0/(rho_bulk*1e4)                    # S/um  (rho ohm·cm = 1e4 ohm·um)
    sig = np.full((nx, ny, nz), sig_bulk)
    if rsh_pw:
        sig_pw = 1.0/(rsh_pw*1.0)                    # capa de 1 um: sigma = 1/(Rsh * t)
        sig[:, :, zc < 1.0] = max(sig_pw, sig_bulk)
    sig[ins] = 1e-12*sig_bulk
    # taps: anillo p+ del fotodiodo: interior -0,5..3,5, ancho 0,6 ; guarda igual alrededor del emisor
    def ring_mask(x0, y0, x1, y1, w):
        o = (XX > x0-w) & (XX < x1+w) & (YY > y0-w) & (YY < y1+w)
        i = (XX > x0) & (XX < x1) & (YY > y0) & (YY < y1)
        return o & ~i & (ZZ < H)
    taps = ring_mask(-0.5, -0.5, 3.5, 3.5, 0.6)
    xe = 3.0 + d
    if guard:
        taps |= ring_mask(xe-0.5, -0.5, xe+4.5, 3.5, 0.6)
    if edge_taps:
        edge = np.zeros((nx, ny, nz), bool)
        edge[0, :, :2] = edge[-1, :, :2] = True; edge[:, 0, :2] = edge[:, -1, :2] = True
        taps |= edge
    taps &= ~ins
    # fuente: 1 mA repartido en las celdas de sustrato que tocan el fondo del pozo del emisor
    emz = em.copy()
    below = np.zeros_like(em); below[:, :, 1:] = em[:, :, :-1] & ~em[:, :, 1:]
    below &= ~ins
    rhs = np.zeros((nx, ny, nz)); rhs[below] = 1e-3/below.sum()/H     # A por celda / h  (ecuación en S/um * V/um^2 * um^3 -> dividir por h)
    V, info = solve(sig, taps, np.zeros((nx, ny, nz)), rhs=rhs, tol=1e-9)
    ix = lambda x: int((x-X0)/H); iy = lambda y: int((y-Y0)/H); iz = lambda z: int(z/H)
    v_pd = float(V[ix(1.5), iy(1.5), iz(z_dnw+dep+0.5)])            # justo bajo el fotodiodo
    v_pd_side = float(V[ix(3.0+dep+0.3), iy(1.5), iz(0.3)])         # sustrato en superficie entre fotodiodo y anillo
    v_em = float(V[below].max())
    v_far = float(V[ix(min(xe+14, X1-1)), iy(1.5), iz(0.3)])        # 10 um más allá del emisor, superficie (donde iría un nfet del lector)
    return v_pd, v_pd_side, v_em, v_far, info

if __name__ == '__main__':
    t0 = time.time()
    lines = []
    def P(*a):
        s = ' '.join(str(x) for x in a); print(s); lines.append(s); sys.stdout.flush()
    P('# d26_fd.py  malla', nx, ny, nz, 'h =', H, 'um')
    P('# (1) Recogida. G [um]: suma de u/r^2 dV. Fracción de fotones emitidos que acaba como electrón en el fotodiodo = alfa*2/(4pi)*G')
    P('# d  z_nw z_dnw dep  L  fondo | G_near  Gpd_near | G_ctrl(44um) | Veff[um3] | cg')
    res = {}
    scen = [  # (z_nw, z_dnw, dep, L, bottom_dirichlet)  barrido de lo no público
        (1.5, 2.5, 1.0, 100.0, True),    # central
        (1.5, 2.5, 1.0, 100.0, False),   # fondo reflectante (nada se pierde abajo)
        (1.0, 1.5, 0.5, 100.0, True),    # pozos someros, poco vaciamiento
        (2.0, 4.0, 2.0, 100.0, True),    # pozos hondos, sustrato poco dopado
        (1.5, 2.5, 1.0, 20.0, True),     # vida corta
        (1.5, 2.5, 1.0, 1000.0, False),  # vida larga y fondo reflectante: cota alta
    ]
    for d in (5, 10, 20):
        for sc in scen:
            out, Veff, info, u = collection(d, *sc)
            res[(d,)+sc] = (out, Veff)
            P(d, *sc, '|', '%.3f %.3f' % out['near'], '| %.4f' % out['ctrl'][0], '| %.1f' % Veff, '|', info, '  t=%.0fs' % (time.time()-t0))
    json.dump({str(k): v for k, v in res.items()}, open('d26_fd_recogida.json', 'w'))
    P('# (2) Potencial de sustrato, voltios por 1 mA de huecos al sustrato (lineal en la corriente).')
    P('# d rho_bulk[ohm cm] rsh_pw[ohm/sq] guarda taps_borde | V_bajo_fd  V_lado_fd  V_bajo_emisor  V_10um_mas_alla | cg')
    for d in (5, 20):
        for rho in (1.0, 10.0, 50.0):
            for rsh in (4400.0, 0):
                for guard in (False, True):
                    for edge in (True, False):
                        if d == 20 and (rsh == 0 or not edge):
                            continue
                        r = potential(d, 1.5, 2.5, 1.0, rho, rsh, guard, edge)
                        P(d, rho, rsh, int(guard), int(edge), '| %.4f %.4f %.4f %.4f' % r[:4], '|', r[4], '  t=%.0fs' % (time.time()-t0))
    open('d26_fd.txt', 'w').write('\n'.join(lines)+'\n')
