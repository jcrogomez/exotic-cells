"""d27_rcwa.py — reflexión de vuelta al silicio de luz de 1100 nm que sube desde el Si, con cinco tipos de tapa en met1.

Pila (de abajo arriba; grcwa pone la incidencia en la primera capa, así que la primera capa es el Si):
  Si semi-infinito (n = 3,54, Green y Keevers 1995 vía PVEducation, LEÍDA)
  óxido 1,376 um (sky130A.tech l. 5058: met1 empieza a 1,3761 um; PDK local)
  met1 0,36 um (l. 5058) : sin metal / Al liso / Al con hoyos cuadrados (red periódica)
  óxido semi-infinito (el resto de la pila; se ignoran nitruro y aire: subestima algo la reflexión 'sin metal')
Índices NO leídos (DE MEMORIA, se barren): óxido 1,45; Al a 1100 nm 1,2 + 10,5i y 1,0 + 8,0i; barrera TiN 25 nm 1,9 + 5,6i
bajo el Al como variante.
Hoyos: lado >= 0,38 um (0,14 um^2, precheck_map/README.md) y met1 entre hoyos >= 0,14 (ancho mínimo): paso >= 0,52.
Salida: R_total(theta) (suma de órdenes reflejados al Si), R_0 (especular) y la fracción en órdenes no especulares,
para theta en el Si entre 0 y 24 grados (ángulo crítico Si/óxido), s y p promediadas, azimut 0 y 45 grados.
"""
import numpy as np, grcwa, json, time, sys
grcwa.set_backend('numpy')
LAM = 1.1; F0 = 1/LAM
NSI, NOX = 3.54, 1.45
THC = np.arcsin(NOX/NSI)
T_OX, T_M1, T_TIN = 1.376, 0.36, 0.025

def R_of(theta, phi, cap, nG=121, Nx=120, al=(1.2+10.5j), tin=False):
    """cap: ('none',) | ('flat',) | ('holes', pitch, side)"""
    pitch = cap[1] if cap[0] == 'holes' else 1.0
    L1, L2 = [pitch, 0], [0, pitch]
    Rs = []
    for pol in ('s', 'p'):
        obj = grcwa.obj(nG, L1, L2, F0, theta, phi, verbose=0)
        obj.Add_LayerUniform(1.0, NSI**2)
        obj.Add_LayerUniform(T_OX, NOX**2)
        eps_m = al**2
        if cap[0] == 'none':
            obj.Add_LayerUniform(T_M1, NOX**2)
        elif cap[0] == 'flat':
            if tin: obj.Add_LayerUniform(T_TIN, (1.9+5.6j)**2)
            obj.Add_LayerUniform(T_M1, eps_m)
        else:
            if tin: obj.Add_LayerGrid(T_TIN, Nx, Nx)
            obj.Add_LayerGrid(T_M1, Nx, Nx)
        obj.Add_LayerUniform(1.0, NOX**2)
        obj.Init_Setup()
        if cap[0] == 'holes':
            x = (np.arange(Nx)+0.5)/Nx*pitch
            Xg, Yg = np.meshgrid(x, x, indexing='ij')
            hole = (np.abs(Xg-pitch/2) < cap[2]/2) & (np.abs(Yg-pitch/2) < cap[2]/2)
            grids = []
            if tin: grids.append(np.where(hole, NOX**2, (1.9+5.6j)**2).ravel())
            grids.append(np.where(hole, NOX**2, eps_m).ravel())
            obj.GridLayer_geteps(np.concatenate(grids))
        if pol == 's': obj.MakeExcitationPlanewave(0, 0, 1, 0, order=0)
        else: obj.MakeExcitationPlanewave(1, 0, 0, 0, order=0)
        Ri, Ti = obj.RT_Solve(normalize=1, byorder=1)
        Ri = np.real(Ri); Ti = np.real(Ti)
        Rs.append((Ri.sum(), Ri[0], Ti.sum()))
    Rs = np.array(Rs)
    return Rs.mean(axis=0)     # R_total, R_especular, T_total

if __name__ == '__main__':
    t0 = time.time(); L = []; out = {}
    def P(*a):
        s = ' '.join(str(x) for x in a); print(s, flush=True); L.append(s)
    thetas = np.radians([0.5, 5, 10, 15, 20, 23.5])
    caps = [('none',), ('flat',)] + [('holes', p, s) for p, s in
            [(0.52, 0.38), (0.76, 0.38), (0.76, 0.62), (1.0, 0.38), (1.0, 0.5), (1.0, 0.86), (1.5, 0.75), (2.0, 1.0), (2.0, 1.86)]]
    P('# d27_rcwa  lambda 1,1 um; theta en Si (grados) ->', ' '.join('%.1f' % np.degrees(t) for t in thetas))
    P('# convergencia: Al liso trivial; red paso 1,0 lado 0,5 a theta 10, nG 61/121/201')
    for nG in (61, 121, 201):
        r = R_of(np.radians(10), 0, ('holes', 1.0, 0.5), nG=nG)
        P('  nG=%d  R_tot=%.4f R_esp=%.4f T=%.4f  t=%.0fs' % (nG, r[0], r[1], r[2], time.time()-t0))
    for al in ((1.2+10.5j), (1.0+8.0j)):
        for tin in (False, True):
            if al != (1.2+10.5j) and tin: continue
            for phi in (0.0, np.pi/4):
                for cap in caps:
                    if cap[0] == 'none' and (al != (1.2+10.5j) or tin): continue
                    rows = [R_of(t, phi, cap, al=al, tin=tin) for t in thetas]
                    key = '%s|al=%s|tin=%d|phi=%.0f' % (str(cap), al, tin, np.degrees(phi))
                    out[key] = [list(map(float, r)) for r in rows]
                    P(key, '| R_tot', ' '.join('%.3f' % r[0] for r in rows), '| R_esp', ' '.join('%.3f' % r[1] for r in rows),
                      '| t=%.0fs' % (time.time()-t0))
    json.dump(out, open('d27_rcwa.json', 'w'), indent=1)
    open('d27_rcwa.txt', 'w').write('\n'.join(L)+'\n')
