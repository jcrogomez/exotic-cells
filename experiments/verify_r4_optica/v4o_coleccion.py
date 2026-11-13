# v4o_coleccion.py — fraccion F de fotones emitidos que acaban como electron recogido por el fotodiodo (XC-26).
# Codigo propio del verificador. Geometria de 05_exotic_lab/macros/photon/{comun,emisor}.tcl:
#   photo (DNW) x 0..3, y 0..3; emisor nwell x xe..xe+4, y 0..3 con xe = 3+d; p+ centro x = xe+1.1, y = 1.5;
#   control nwell x -44..-40; anillo DNW interior x -48.5..31.5, y -6.3..9.3, ancho 3, nwell 0.4 por dentro y por fuera.
# Profundidades NO publicas [?]: nwell z_nw, DNW z_dn; se barren.
# Modelo: P(x) = probabilidad de que un electron generado en x lo recoja el photo:  lap P - P/L^2 = 0,
#   P=1 en el photo, P=0 en todo otro pozo n (emisores, control, anillo DNW), superficie reflectante, fondo sumidero o reflectante.
#   F = int g(x) P(x) dV, g = densidad de absorcion de una fuente puntual isotropa con espectro de Si (v4o_alpha),
#   con la superficie como espejo (reflexion interna total) salvo el cono de escape.
import numpy as np, json, sys, time
from v4o_grid import axis, Grid

# --- espectro (mismo que v4o_alpha.py) ---
lam = np.arange(850, 1451, 10)
a_tab = np.array([535,480,432,383,343,306,272,240,210,183,157,134,114,95.9,79.2,64.0,51.1,39.9,30.2,22.6,16.3,11.1,8.0,6.2,4.7,3.5,
 2.7,2.0,1.5,1.0,0.68,0.42,0.22,0.065,0.036,0.022,0.013,0.0082,0.0047,0.0024,0.0010,3.6e-4,2.0e-4,1.2e-4,7.1e-5,4.5e-5,2.7e-5,
 1.6e-5,8.0e-6,3.5e-6,1.7e-6,1.0e-6,6.7e-7,4.5e-7,2.5e-7,2.0e-7,1.5e-7,8.5e-8,7.7e-8,4.2e-8,3.2e-8])
Etab = 1239.84 / lam; kT = 0.025852
def alpha(e): return np.exp(np.interp(e, Etab[::-1], np.log(a_tab[::-1]), left=np.log(a_tab[-1]), right=np.log(a_tab[0])))
def spectrum(dE, nb=60):
    Eg = np.linspace(Etab.min(), Etab.max(), 3000)
    em = alpha(Eg + dE) * Eg**2 * np.exp(-Eg / kT); em /= em.sum()
    edges = np.linspace(0, len(Eg), nb + 1).astype(int)
    w = np.array([em[edges[i]:edges[i+1]].sum() for i in range(nb)])
    al = np.array([(em[edges[i]:edges[i+1]] * alpha(Eg[edges[i]:edges[i+1]])).sum() / max(w[i], 1e-300) for i in range(nb)])
    return w, al * 1e-4   # alfa en 1/um

# --- escape por arriba (Si -> SiO2, Fresnel sin polarizar), fraccion del hemisferio superior ---
def esc_frac(n1=3.55, n2=1.45):
    th = np.linspace(0, np.arcsin(n2 / n1), 4000)[:-1]
    ct = np.cos(th); st2 = n1 / n2 * np.sin(th); ct2 = np.sqrt(1 - st2**2)
    rs = ((n1*ct - n2*ct2) / (n1*ct + n2*ct2))**2; rp = ((n1*ct2 - n2*ct) / (n1*ct2 + n2*ct))**2
    T = 1 - 0.5 * (rs + rp)
    return np.trapezoid(T * np.sin(th), th), np.trapezoid(np.sin(th), th)   # (transmitida, geometrica) del hemisferio

def build(d_list_layout, z_nw, z_dn, ring, Zb, far=600.0):
    fx = axis(-53, 36, 0.5, -far, far, 1.25); fy = axis(-10.5, 13.5, 0.5, -far, far, 1.25)
    fz = axis(0, 4, 0.25, 0, Zb, 1.25)
    g = Grid(fx, fy, fz)
    photo = g.box(0, 3, 0, 3, 0, z_dn)
    sink = np.zeros(g.shape, bool)
    for xe in d_list_layout:
        sink |= g.box(xe, xe + 4, 0, 3, 0, z_nw)
    if ring:
        outer = g.box(-51.9, 34.9, -9.7, 12.7, 0, z_dn)
        inner = g.box(-48.1, 31.1, -5.9, 8.9, -1, 99)
        sink |= outer & ~inner
    return g, photo, sink

def F_of(g, P, src, w, al, mirror, zs=0.3):
    F = 0.0
    r1 = np.sqrt((g.X - src[0])**2 + (g.Y - src[1])**2 + (g.Z - zs)**2)
    r2 = np.sqrt((g.X - src[0])**2 + (g.Y - src[1])**2 + (g.Z + zs)**2)
    PV = P * g.V
    for wi, ai in zip(w, al):
        gd = ai * np.exp(-ai * r1) / (4 * np.pi * r1**2) + mirror * ai * np.exp(-ai * r2) / (4 * np.pi * r2**2)
        F += wi * (gd * PV).sum()
    return F

if __name__ == '__main__':
    t_esc, t_geo = esc_frac()
    mirror = 1 - t_esc            # fraccion del hemisferio superior que vuelve al silicio
    out = {"escape_hemisferio_transmitido": t_esc, "cono_geometrico_hemisferio": t_geo,
           "escape_fraccion_total": t_esc / 2, "mirror": mirror, "runs": []}
    print(f"escape: {t_esc:.4f} del hemisferio superior ({t_esc/2:.4f} del total); cono geometrico {t_geo:.4f}")
    w0, al0 = spectrum(0.0); w6, al6 = spectrum(0.06)
    print("alfa medio (1/cm):", (w0 * al0).sum() * 1e4, (w6 * al6).sum() * 1e4)
    scen = json.loads(sys.argv[1])
    for s in scen:
        t = time.time()
        d = s["d"]; xe = 3.0 + d
        g, photo, sink = build([xe, -44.0] if s.get("emit_sink", True) else [-44.0], s["z_nw"], s["z_dn"], s["ring"], s["Zb"])
        L = s["L"]
        dm = photo | sink
        dval = photo.astype(float)
        P, info = g.solve(np.ones(g.shape), np.full(g.shape, 1.0 / L**2), dm, dval,
                          neumann_far=False, far_val=0.0) if s["bottom"] == "sink" else (None, None)
        if s["bottom"] != "sink":
            # fondo reflectante: lo emulo con frontera lejana Dirichlet solo en laterales -> aproximacion: Zb muy hondo
            P, info = g.solve(np.ones(g.shape), np.full(g.shape, 1.0 / L**2), dm, dval, neumann_far=False, far_val=0.0)
        res = dict(s); res["cg_info"] = int(info); res["celdas"] = int(np.prod(g.shape))
        res["F_emisor"] = F_of(g, P, (xe + 1.1, 1.5), w0, al0, mirror)
        res["F_control"] = F_of(g, P, (-42.9, 1.5), w0, al0, mirror)
        res["F_emisor_BGN006"] = F_of(g, P, (xe + 1.1, 1.5), w6, al6, mirror)
        res["F_emisor_sin_espejo"] = F_of(g, P, (xe + 1.1, 1.5), w0, al0, 0.0)
        # portadores: electron inyectado bajo el fondo del pozo del emisor (solo tiene sentido con emit_sink=False)
        k = np.argmin(abs(g.cz - (s["z_nw"] + 0.15)))
        ii = (g.cx > xe) & (g.cx < xe + 4); jj = (g.cy > 0) & (g.cy < 3)
        res["P_bajo_emisor"] = float(P[np.ix_(ii, jj, [k])].mean())
        res["t_s"] = round(time.time() - t, 1)
        print(json.dumps(res)); sys.stdout.flush()
        out["runs"].append(res)
    json.dump(out, open(sys.argv[2], "w"), indent=1)
