# v4o_sustrato.py — resistencia del sustrato entre el fondo del pozo del emisor (colector del PNP vertical) y los taps (XC-26).
# Codigo propio. Geometria de macros/photon. Pozos n y DNW: aislantes para la corriente de huecos (union en inversa o a 0 V).
# Taps: anillo p+ del photo (interior -0.5..3.5, ancho 0.6) [+ guarda alrededor del emisor en e05g] [+ frontera lejana a masa].
# Dos inyectores: (a) electrodo equipotencial en la cascara de sustrato que rodea el pozo (cota inferior de R);
#                 (b) corriente uniforme bajo la huella del p+ (1.0 x 1.4 um), se reporta V media y maxima en esa cascara.
import numpy as np, json, sys
from v4o_grid import axis, Grid

def run(d, rho_ohmcm, z_nw=1.0, z_dn=2.5, guard=False, far_ground=False, pwell=None, ring=True):
    xe = 3.0 + d
    fx = axis(-53, 36, 0.5, -600, 600, 1.25); fy = axis(-10.5, 13.5, 0.5, -600, 600, 1.25); fz = axis(0, 4, 0.25, 0, 300, 1.25)
    g = Grid(fx, fy, fz)
    sig = np.full(g.shape, 1.0 / (rho_ohmcm * 1e4))     # 1/(ohm um)
    if pwell is not None:   # (rho_pw ohm cm, espesor um)
        sig[g.Z < pwell[1]] = 1.0 / (pwell[0] * 1e4)
    nw = g.box(xe, xe + 4, 0, 3, 0, z_nw)
    ins = nw | g.box(-44, -40, 0, 3, 0, z_nw) | g.box(0, 3, 0, 3, 0, z_dn)
    if ring:
        ins |= g.box(-51.9, 34.9, -9.7, 12.7, 0, z_dn) & ~g.box(-48.1, 31.1, -5.9, 8.9, -1, 99)
    sig[ins] = 1e-30
    tap = g.box(-1.1, 4.1, -1.1, 4.1, 0, 0.25) & ~g.box(-0.5, 3.5, -0.5, 3.5, -1, 99)
    if guard:
        tap |= g.box(xe - 1.1, xe + 5.1, -1.1, 4.1, 0, 0.25) & ~g.box(xe - 0.5, xe + 4.5, -0.5, 3.5, -1, 99)
    shell = g.box(xe - 0.5, xe + 4.5, -0.5, 3.5, 0, z_nw + 0.5) & ~nw
    out = {"d": d, "rho": rho_ohmcm, "guard": guard, "far_ground": far_ground, "pwell": pwell, "ring": ring}
    # (a) equipotencial
    dm = tap | shell | ins; dv = shell.astype(float)  # celdas aislantes fijadas: conductancia ~0, solo evitan filas nulas
    u, info = g.solve(sig, np.zeros(g.shape), dm, dv, neumann_far=not far_ground, far_val=0.0, tol=1e-10)
    I = g.flux_into(shell)
    out["R_equipot_ohm"] = 1.0 / I
    # (b) inyeccion uniforme 1 A bajo la huella del p+, en la capa justo bajo el fondo del pozo
    k = np.argmin(abs(g.cz - (z_nw + 0.125)))
    inj = np.zeros(g.shape, bool)
    ii = (g.cx > xe + 0.6) & (g.cx < xe + 1.6); jj = (g.cy > 0.8) & (g.cy < 2.2)
    inj[np.ix_(ii, jj, [k])] = True
    q = np.zeros(g.shape); q[inj] = 1.0 / (g.V[inj].sum())
    u, info2 = g.solve(sig, np.zeros(g.shape), tap | ins, 0.0, source=q, neumann_far=not far_ground, far_val=0.0, tol=1e-10)
    sh_b = shell & (g.Z > z_nw)    # cascara bajo el fondo
    out["Vmean_fondo_por_A"] = float(u[sh_b].mean()); out["Vmax_fondo_por_A"] = float(u[sh_b].max())
    out["V_photo_borde_por_A"] = float(u[g.box(0, 3, 0, 3, z_dn, z_dn + 0.5)].mean())
    out["cg"] = [int(info), int(info2)]
    return out

if __name__ == '__main__':
    res = []
    cases = [dict(d=5, rho_ohmcm=10), dict(d=10, rho_ohmcm=10), dict(d=20, rho_ohmcm=10),
             dict(d=5, rho_ohmcm=10, guard=True), dict(d=5, rho_ohmcm=10, far_ground=True), dict(d=20, rho_ohmcm=10, far_ground=True),
             dict(d=5, rho_ohmcm=1, pwell=(0.2, 1.0)), dict(d=5, rho_ohmcm=10, pwell=(0.2, 1.0)), dict(d=5, rho_ohmcm=20, pwell=(0.2, 1.0))]
    for c in cases:
        r = run(**c); print(json.dumps(r)); sys.stdout.flush(); res.append(r)
    json.dump(res, open("v4o_sustrato.json", "w"), indent=1)
