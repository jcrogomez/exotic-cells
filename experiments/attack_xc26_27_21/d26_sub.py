"""d26_sub.py — potencial del sustrato p cuando el colector del PNP vertical (pozo n del emisor -> sustrato) mete 1 mA de huecos.

Corrige d26_fd.py parte (2): allí el anillo de taps del fotodiodo quedaba tragado por el margen de vaciamiento y los taps de
borde caían dentro del anillo de dnwell (aislante), así que sin guarda el sistema no tenía referencia (valores absurdos,
cg = 20000). Aquí: h = 1 um, dominio 240 x 180 x 120 um, pozos sin margen (aislantes), taps dibujados exactos.
Escenarios de referencia a masa (no públicos -> se barren):
  A 'logica'  : toda la superficie fuera del anillo de dnwell (+2 um) a masa (taps densos de celdas estándar: cota baja de V)
  B 'dibujado': solo los taps dibujados (anillo p+ del fotodiodo; guarda si la hay) y las caras laterales del dominio (resto
                del dado a ~100 um); cara trasera aislante (dado pegado con adhesivo no conductor: supuesto)
  C 'epi'     : como B pero bajo z_epi = 6 um el sustrato es p+ (0,02 ohm cm) conectado a las caras laterales (oblea epitaxial)
Resistividad del sustrato: 1, 10, 20 ohm cm (no pública). Capa superficial de pozo p 4400 ohm/sq en 1 um (sky130A.tech l. 5100,
'resist (pwell,isosub)/well 4400000' mOhm/sq) activada o no.
Lineal en la corriente: V por mA.
"""
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spla, time, json

H = 1.0
X0, X1, Y0, Y1, ZM = -130.0, 110.0, -88.0, 92.0, 120.0
nx, ny, nz = int((X1-X0)/H), int((Y1-Y0)/H), int(ZM/H)
xc = X0+H*(np.arange(nx)+.5); yc = Y0+H*(np.arange(ny)+.5); zc = H*(np.arange(nz)+.5)
XX, YY, ZZ = np.meshgrid(xc, yc, zc, indexing='ij')
def box(x0, x1, y0, y1, z1, z0=0.0):
    return (XX > x0) & (XX < x1) & (YY > y0) & (YY < y1) & (ZZ > z0) & (ZZ < z1)

def build(d, z_nw=1.5, z_dnw=2.5):
    xe = 3.0+d
    pd = box(0, 3, 0, 3, z_dnw)
    em = box(xe, xe+4, 0, 3, z_nw)
    ct = box(-44, -40, 0, 3, z_nw)
    xi0, xi1, yi0, yi1 = -48.5, 31.5, -6.3, 9.3
    ring = box(xi0-3.4, xi1+3.4, yi0-3.4, yi1+3.4, z_dnw) & ~box(xi0+0.4, xi1-0.4, yi0+0.4, yi1-0.4, 1e9)
    outside = ~box(xi0-5.4, xi1+5.4, yi0-5.4, yi1+5.4, 1e9)
    return xe, pd, em, ct, ring, outside

def ringtap(x0, y0, x1, y1, w):
    o = (XX > x0-w) & (XX < x1+w) & (YY > y0-w) & (YY < y1+w); i = (XX > x0) & (XX < x1) & (YY > y0) & (YY < y1)
    return o & ~i & (ZZ < H)

def solve(sig, dmask, rhs):
    N = nx*ny*nz; idx = np.arange(N).reshape(nx, ny, nz); r, c, v = [], [], []; dg = np.zeros((nx, ny, nz))
    for ax in range(3):
        a = [slice(None)]*3; b = [slice(None)]*3; a[ax] = slice(0, -1); b[ax] = slice(1, None)
        g = 2*sig[tuple(a)]*sig[tuple(b)]/(sig[tuple(a)]+sig[tuple(b)])*H
        ia, ib = idx[tuple(a)].ravel(), idx[tuple(b)].ravel(); gg = g.ravel()
        r += [ia, ib]; c += [ib, ia]; v += [-gg, -gg]; dg[tuple(a)] += g; dg[tuple(b)] += g
    A = sp.coo_matrix((np.concatenate(v), (np.concatenate(r), np.concatenate(c))), shape=(N, N)).tocsr() + sp.diags(dg.ravel())
    free = ~dmask.ravel()
    Aff = A[free][:, free]
    sol, info = spla.cg(Aff, rhs.ravel()[free], rtol=1e-8, maxiter=40000, M=sp.diags(1/Aff.diagonal()))
    V = np.zeros(N); V[free] = sol
    return V.reshape(nx, ny, nz), info

def case(d, rho, pwell, guard, scen):
    xe, pd, em, ct, ring, outside = build(d)
    ins = pd | em | ct | ring
    sig = np.full((nx, ny, nz), 1/(rho*1e4))                       # S/um
    if pwell: sig[:, :, zc < 1.0] = np.maximum(sig[:, :, zc < 1.0], 1/4400.0)
    if scen == 'epi': sig[:, :, zc > 6.0] = 1/(0.02*1e4)
    sig[ins] = 1e-9*sig.min()
    taps = ringtap(-0.5, -0.5, 3.5, 3.5, 0.6)
    if guard: taps |= ringtap(xe-0.5, -0.5, xe+4.5, 3.5, 0.6)
    if scen == 'logica': taps |= outside & (ZZ < H)
    lat = np.zeros_like(taps); lat[0] = lat[-1] = True; lat[:, 0] = lat[:, -1] = True
    taps |= lat                                                    # resto del dado a ~100 um
    taps &= ~ins
    below = np.zeros_like(em); below[:, :, 1:] = em[:, :, :-1]; below &= ~ins
    rhs = np.zeros((nx, ny, nz)); rhs[below] = 1e-3/below.sum()
    V, info = solve(sig, taps, rhs)
    i = lambda x: int((x-X0)/H); j = lambda y: int((y-Y0)/H); k = lambda z: int(z/H)
    return dict(V_bajo_emisor=float(V[below].mean()), V_bajo_emisor_max=float(V[below].max()),
                V_sup_junto_emisor=float(V[i(xe+5.5), j(1.5), 0]), V_bajo_fd=float(V[i(1.5), j(1.5), k(3.0)]),
                V_sup_fd=float(V[i(-0.2), j(1.5), 0]), V_fuera_anillo=float(V[i(37.0), j(1.5), 0]), cg=int(info))

if __name__ == '__main__':
    t0 = time.time(); out = {}; L = []
    def P(*a):
        s = ' '.join(str(x) for x in a); print(s, flush=True); L.append(s)
    P('# d26_sub: V por 1 mA de huecos al sustrato. malla', nx, ny, nz)
    P('# d rho pwell guarda escenario | V_bajo_emisor(media,max) V_sup_junto_emisor V_bajo_fd V_sup_fd V_fuera_anillo | cg')
    for scen in ('logica', 'dibujado', 'epi'):
        for rho in (1.0, 10.0, 20.0):
            for guard in (0, 1):
                for d in ((5, 20) if (rho == 10.0 and guard == 0) else (5,)):
                    r = case(d, rho, True, guard, scen)
                    out['%s|%g|%d|%d' % (scen, rho, guard, d)] = r
                    P(d, rho, 1, guard, scen, '| %.3f %.3f %.4f %.4f %.4f %.4f' % (r['V_bajo_emisor'], r['V_bajo_emisor_max'],
                      r['V_sup_junto_emisor'], r['V_bajo_fd'], r['V_sup_fd'], r['V_fuera_anillo']), '|', r['cg'], ' t=%.0fs' % (time.time()-t0))
    r = case(5, 10.0, False, 0, 'dibujado'); out['dibujado|10|0|5|sin_pwell'] = r
    P(5, 10.0, 0, 0, 'dibujado', '| %.3f %.3f %.4f %.4f %.4f %.4f' % (r['V_bajo_emisor'], r['V_bajo_emisor_max'], r['V_sup_junto_emisor'],
      r['V_bajo_fd'], r['V_sup_fd'], r['V_fuera_anillo']), '|', r['cg'])
    json.dump(out, open('d26_sub.json', 'w'), indent=1)
    open('d26_sub.txt', 'w').write('\n'.join(L)+'\n')
