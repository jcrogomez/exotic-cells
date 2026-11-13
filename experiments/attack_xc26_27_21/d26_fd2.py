"""d26_fd2.py — segunda pasada sobre la misma malla de d26_fd.py (importa su geometría y su solver; no la modifica).

Para cada distancia d = 5, 10, 20 um y cada escenario de lo no público calcula, con la u(r) del adjunto de difusión:
  S_dir   = sum u/r^2 dV desde la fuente puntual (centro del p+, z = 0,5 um)            [um]
  S_tir   = idem desde la imagen (z = -0,5) para direcciones con theta > theta_c (reflexión total en Si/óxido)
  S_cone  = idem para theta < theta_c, en 12 bandas de theta (lo único que una tapa metálica puede cambiar)
  u_well  = u media en las celdas de sustrato que tocan el pozo n del emisor (portadores inyectados por el pozo)
  con y sin un anillo de guarda (pozo n poco profundo o pozo n profundo) alrededor del emisor.
Fracción de fotones emitidos que acaba como electrón en el fotodiodo:  F = alpha/(4 pi) * (S_dir + S_tir + R_cone*S_cone)
(alpha en 1/um; e^{-alpha r} ~ 1 a estas distancias, error < 1e-2).
Salida: d26_fd2.txt, d26_fd2.json
"""
import numpy as np, json, time
import d26_fd as F

NSI, NOX = 3.54, 1.45            # Si a 1100 nm: Green y Keevers 1995 vía PVEducation (LEÍDA). Óxido: valor típico, DE MEMORIA
THC = np.arcsin(NOX/NSI)
XX, YY, ZZ, H = F.XX, F.YY, F.ZZ, F.H

def ring(x0, y0, x1, y1, w, z1):
    o = (XX > x0-w) & (XX < x1+w) & (YY > y0-w) & (YY < y1+w) & (ZZ < z1)
    i = (XX > x0) & (XX < x1) & (YY > y0) & (YY < y1)
    return o & ~i

def run(d, z_nw, z_dnw, dep, L, bot, guard):
    pd, em, ct, rg, s_near, s_ctrl = F.geometry(d, z_nw, z_dnw, dep)
    dm = pd | em | ct | rg
    xe = 3.0 + d
    if guard == 'nw':      # anillo de pozo n de 1 um, a 1,27 um del pozo del emisor, en inversa (u = 0)
        dm = dm | ring(xe-1.27, -1.27, xe+4+1.27, 3+1.27, 1.0, z_nw+dep)
    elif guard == 'dnw':   # anillo de pozo n profundo (dnwell + nwell), mismo sitio, 3 um de ancho mínimo dnwell.2 -> se usa 3
        dm = dm | ring(xe-1.27, -1.27, xe+4+1.27, 3+1.27, 3.0, z_dnw+dep)
    u, info = F.solve(np.ones(XX.shape), dm, np.where(pd, 1.0, 0.0), kappa=1.0/L**2, bottom_dirichlet=bot)
    out = {'cg': int(info)}
    for name, s in (('near', s_near), ('ctrl', s_ctrl)):
        dx, dy = XX-s[0], YY-s[1]
        r2d = np.maximum(dx**2+dy**2+(ZZ-s[2])**2, (H/2)**2)
        r2i = np.maximum(dx**2+dy**2+(ZZ+s[2])**2, (H/2)**2)
        th = np.arccos(np.clip((ZZ+s[2])/np.sqrt(r2i), -1, 1))
        Sdir = float(np.sum(u/r2d)*H**3)
        Stir = float(np.sum(np.where(th >= THC, u/r2i, 0))*H**3)
        bins = np.linspace(0, THC, 13)
        Scone = [float(np.sum(np.where((th >= bins[k]) & (th < bins[k+1]), u/r2i, 0))*H**3) for k in range(12)]
        out[name] = dict(Sdir=Sdir, Stir=Stir, Scone=Scone)
    # u en el contorno del pozo del emisor (cara inferior y laterales, del lado del sustrato)
    nb = np.zeros_like(em)
    for ax in range(3):
        for sh in (1, -1):
            nb |= np.roll(em, sh, axis=ax)
    nb &= ~dm
    bottom = nb & (ZZ > z_nw+dep/2 - 1e-9)
    out['u_well_all'] = float(u[nb].mean())
    out['u_well_bottom'] = float(u[bottom].mean()) if bottom.any() else float('nan')
    ix = lambda x: int((x-F.X0)/H)
    out['Veff'] = float(np.sum(u)*H**3)
    return out

if __name__ == '__main__':
    t0 = time.time(); res = {}; lines = []
    def P(*a):
        s = ' '.join(str(x) for x in a); print(s, flush=True); lines.append(s)
    P('# d26_fd2  theta_c = %.1f grados' % np.degrees(THC))
    P('# d escenario guarda | Sdir Stir Scone(total) | S_ctrl(total) | u_well_all u_well_bottom | cg')
    scen = {'central': (1.5, 2.5, 1.0, 100.0, True), 'somero': (1.0, 1.5, 0.5, 100.0, True),
            'hondo': (2.0, 4.0, 2.0, 100.0, True), 'alto': (1.5, 2.5, 1.0, 1000.0, False), 'Lcorta': (1.5, 2.5, 1.0, 20.0, True)}
    for d in (5, 10, 20):
        for sn, sc in scen.items():
            for g in (('none', 'nw', 'dnw') if sn == 'central' else ('none',)):
                o = run(d, *sc, g)
                res['%d|%s|%s' % (d, sn, g)] = o
                n = o['near']; c = o['ctrl']
                P(d, sn, g, '| %.3f %.3f %.4f' % (n['Sdir'], n['Stir'], sum(n['Scone'])),
                  '| %.4f' % (c['Sdir']+c['Stir']+sum(c['Scone'])), '| %.4f %.4f' % (o['u_well_all'], o['u_well_bottom']),
                  '|', o['cg'], ' t=%.0fs' % (time.time()-t0))
    json.dump(res, open('d26_fd2.json', 'w'), indent=1)
    open('d26_fd2.txt', 'w').write('\n'.join(lines)+'\n')
