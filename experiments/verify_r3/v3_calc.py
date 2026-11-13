# v3_calc.py — verificador independiente, ronda 3. Código propio. Corre con .venv/bin/python v3_calc.py > v3_salida.txt
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spl, time, subprocess
from scipy.integrate import solve_ivp
from scipy.optimize import brentq
q = 1.602176634e-19; kB = 1.380649e-23; mu0 = 4e-7 * np.pi; eps0 = 8.8541878e-12
print("inicio:", subprocess.run(["date"], capture_output=True, text=True).stdout.strip())

# =============================== A1 ===============================
print("\n== A1: capacidad del nodo de puerta (fF). Fuentes: modelo nfet_01v8 tt (bin W 0,42-0,52 L 0,15-0,18) y v3_f2_salida.txt (ngspice)")
W = 0.42e-6; L = 0.15e-6; tox = 4.148e-9; Cox = 3.9 * eps0 / tox
cgdo = 2.449068e-10                       # F/m, cgso = cgdo; cgsl = cgdl = 0; cf = 1.4067e-12 F/m; cgbo = 1e-13 F/m
c_int_wi = (0.152e-15, 0.161e-15)         # cgg intrínseca de ngspice a Vg = 0,3-0,4 V (inversión débil), Vds = 0,05
c_int_si = 0.43e-15                       # a 1,8 V (inversión fuerte), para cota superior
c_ov2 = 2 * cgdo * W; c_cf = 2 * 1.4067e-12 * W; c_gb = 1e-13 * L
c_sw_ov = cgdo * W                        # solape puerta-nodo del interruptor (este es Cov de A2)
c_j0 = 0.2755e-15                         # capbd de ngspice, AD = 0,42 x 0,265 um2, PD = 1,37 um, a ~0 V
c_j = (c_j0 * 0.80, c_j0)                 # con 0,3-0,6 V de inversa cae ~10-20 % (mj ~0,3-0,4): supuesto
poly_pad = 0.10e-12 * 106.13e-18 / 1e-12 + 1.3e-6 * 55.27e-18 / 1e-6   # cabeza de poly 0,1 um2 + 1,3 um de perímetro sobre campo
li_w = lambda Lw: (0.17e-6 * Lw) * 36.99e-18 / 1e-12 + 2 * (Lw + 0.17e-6) * 40.70e-18 / 1e-6
wire = (poly_pad + li_w(0.5e-6), poly_pad + li_w(1.5e-6))
print(f"Cox*W*L (dibujado) = {Cox*W*L*1e15:.3f} fF (cota; no se usa en inversión débil)")
print(f"puerta del lector: intrínseca en inversión débil {c_int_wi[0]*1e15:.3f}-{c_int_wi[1]*1e15:.3f}; solapes 2*cgdo*W = {c_ov2*1e15:.3f}; franja cf {c_cf*1e15:.4f}; cgbo*L {c_gb*1e15:.5f}")
print(f"interruptor mínimo 0,42/0,15: unión {c_j[0]*1e15:.3f}-{c_j[1]*1e15:.3f}; solape de su puerta {c_sw_ov*1e15:.3f}")
print(f"hilo: cabeza de poly {poly_pad*1e15:.3f}; li de 0,5-1,5 um {li_w(0.5e-6)*1e15:.3f}-{li_w(1.5e-6)*1e15:.3f}")
lo = c_int_wi[0] + c_ov2 + c_j[0] + c_sw_ov + wire[0]; hi = c_int_wi[1] + c_ov2 + c_cf + c_j[1] + c_sw_ov + wire[1]
print(f"TOTAL inversión débil: {lo*1e15:.3f} - {hi*1e15:.3f} fF ; con lector en inversión fuerte hasta {(hi-c_int_wi[1]+c_int_si)*1e15:.3f} fF")
Ctot = 0.5 * (lo + hi); print(f"Cov/C (interruptor) = {c_sw_ov/hi:.3f} - {c_sw_ov/lo:.3f}")

# =============================== A2 ===============================
print("\n== A2: varianza congelada / (kT/C) con rampa de puerta e inyección por Cov")
print("Modelo: interruptor en inversión débil, I_f = Is e^{u}, I_r = Is (u = -(Vnodo-Vref)/UT), Is = Is0 exp(-s), s = a t/(n UT);")
print("  du/ds = n*rho - B(e^u - 1);  dy/ds = -2 B e^u y + B(e^u + 1);  y = sigma^2 C/kT; B = B0 e^{-s}; rho = Cov/C. Ruido de disparo 2q(I_f+I_r).")
def frozen(nrho, B0=200.0):
    f = lambda s, Y: [nrho - B0 * np.exp(-s) * np.expm1(Y[0]), -2 * B0 * np.exp(-s) * np.exp(Y[0]) * Y[1] + B0 * np.exp(-s) * (np.exp(Y[0]) + 1)]
    r = solve_ivp(f, [0, np.log(B0) + 40], [nrho / B0, 1.0], method="LSODA", rtol=1e-10, atol=1e-13)
    return r.y[1, -1]
xs = [0, 0.01, 0.02, 0.05, 0.1, 0.15, 0.2, 0.3, 0.4, 0.5, 0.7, 0.9, 1.0, 1.5]
ys = [frozen(x) for x in xs]
for x, y in zip(xs, ys): print(f"  n*Cov/C = {x:4.2f}: y = {y:.4f}   (1-y)/(n*rho) = {((1-y)/x if x else float('nan')):.3f}   [B0=50: {frozen(x,50.):.4f}]")
c0 = (1 - frozen(0.01)) / 0.01
print(f"pendiente en el origen respecto de n*rho: c = {c0:.3f}  -> coeficiente respecto de Cov/C = c*n: n=1,2: {1.2*c0:.2f}; n=1,4: {1.4*c0:.2f}; n=1,6: {1.6*c0:.2f}")
for n in (1.3, 1.5):
    for rho in (0.05, 0.1, 0.2):
        y = frozen(n * rho); print(f"  n={n} Cov/C={rho}: y={y:.4f} ; coef. efectivo (1-y)/rho = {(1-y)/rho:.3f} ; fórmula 1-0,85 rho = {1-0.85*rho:.4f}")
# Monte Carlo no lineal (Euler-Maruyama), eps = q/(C UT)
def mc(nrho, eps, B0=50.0, N=40000, ds=5e-4, seed=3):
    rng = np.random.default_rng(seed); u = nrho / B0 + np.sqrt(eps) * rng.standard_normal(N); s = 0.0
    while s < np.log(B0) + 14:
        B = B0 * np.exp(-s); eu = np.exp(u)
        u = u + (nrho - B * (eu - 1)) * ds + np.sqrt(eps * B * (eu + 1) * ds) * rng.standard_normal(N); s += ds
    return u.var() / eps
t0 = time.time(); eps = q / (1e-15 * kB * 300 / q)
for x in (0.0, 0.3, 0.6):
    print(f"  MC (40000 caminos, C=1 fF, eps={eps:.4f}) n*rho={x}: y = {mc(x, eps):.4f} (ODE {frozen(x,50.):.4f}; error estadístico ~0,7 %)")
print(f"  [MC {time.time()-t0:.0f} s]")

# =============================== A3 / A4 ===============================
print("\n== A3/A4")
T = 300.0; UT = kB * T / q
for C in (0.5e-15, 0.963e-15, 2e-15):
    for n in (1.3, 1.5):
        print(f"  C={C*1e15:.3f} fF n={n}: sigma_V = {np.sqrt(kB*T/C)*1e3:.3f} mV ; sigma_t/t = sigma_V/(n UT) = {np.sqrt(kB*T/C)/(n*UT)*100:.2f} %")
print(f"  sigma_t/t = q/(n sqrt(k T C)) -> d ln/dT = -1/(2T) = {-100/(2*T):.4f} %/K a 300 K (n y C constantes)")
print("  con n(T): d ln n/dT entre -3e-4 y +3e-4 /K (supuesto) cambia a", f"{(-1/(2*T)-3e-4)*100:.3f} .. {(-1/(2*T)+3e-4)*100:.3f} %/K")
print(f"  la VARIANZA del observable (sigma_t/t)^2 = q^2/(n^2 k T C): proporcional a 1/T, no a T: {-100/T:.3f} %/K")
print(f"  A4: T = q^2/(n^2 k C s^2) -> dT/T = -dC/C: C +-10 % => T: {300/1.1-300:.1f} / {300/0.9-300:+.1f} K (lineal: +-30 K); cociente s1^2/s2^2 = C2/C1 (T y n se cancelan)")
print(f"       si además se aplica A2 (factor 1 - c n Cov/C) no cambia el orden.")

# =============================== térmico 2D ===============================
def edges(points, hmin, lo, hi, g=1.18):
    pts = sorted(set([round(p, 12) for p in points if lo <= p <= hi])); xs = []
    a, b = pts[0], pts[-1]
    for i in range(len(pts) - 1):
        n = max(1, int(np.ceil((pts[i + 1] - pts[i]) / hmin))); xs += list(np.linspace(pts[i], pts[i + 1], n + 1)[:-1])
    xs.append(b); h = hmin
    while xs[-1] < hi - 1e-15: h *= g; xs.append(min(xs[-1] + h, hi))
    h = hmin
    while xs[0] > lo + 1e-15: h *= g; xs.insert(0, max(xs[0] - h, lo))
    return np.array(xs)
def solve2d(rects, xpts, zpts, tf=0.3262e-6, actives=(), kox=1.2, ksi=150.0, D=300e-6, X=300e-6, H=6e-6, hmin=0.01e-6, zfine=None):
    """x>=0 (simetría en x=0). z<-tf silicio; -tf<z<0 óxido de campo salvo intervalos 'actives' (silicio); z>0 óxido. rects: (x0,x1,z0,z1,k,fuente)."""
    xe = edges([0.0] + list(xpts), hmin, 0.0, X); ze = edges(list(zpts) + [-tf, 0.0], hmin, -D, H)
    xc = (xe[1:] + xe[:-1]) / 2; zc = (ze[1:] + ze[:-1]) / 2; dx = np.diff(xe); dz = np.diff(ze); nx, nz = len(xc), len(zc)
    Xg, Zg = np.meshgrid(xc, zc, indexing="ij"); k = np.where(Zg < -tf, ksi, kox)
    for a, b in actives: k[(Xg > a) & (Xg < b) & (Zg < 0)] = ksi
    Q = np.zeros((nx, nz)); masks = []
    for (x0, x1, z0, z1, kk, src) in rects:
        m = (Xg > x0) & (Xg < x1) & (Zg > z0) & (Zg < z1); k[m] = kk; masks.append(m)
        if src: Q[m] = (dx[:, None] * dz[None, :])[m] / (dx[:, None] * dz[None, :])[m].sum() * src
    idx = np.arange(nx * nz).reshape(nx, nz); diag = np.zeros(nx * nz); R = []; Cc = []; V = []
    gx = dz[None, :] / (dx[:-1, None] / 2 / k[:-1, :] + dx[1:, None] / 2 / k[1:, :]); a = idx[:-1, :].ravel(); b = idx[1:, :].ravel(); g = gx.ravel()
    R += [a, b]; Cc += [b, a]; V += [-g, -g]; np.add.at(diag, a, g); np.add.at(diag, b, g)
    gz = dx[:, None] / (dz[None, :-1] / 2 / k[:, :-1] + dz[None, 1:] / 2 / k[:, 1:]); a = idx[:, :-1].ravel(); b = idx[:, 1:].ravel(); g = gz.ravel()
    R += [a, b]; Cc += [b, a]; V += [-g, -g]; np.add.at(diag, a, g); np.add.at(diag, b, g)
    np.add.at(diag, idx[:, 0], dx / (dz[0] / 2 / k[:, 0]))            # fondo a T = 0
    n = nx * nz; A = sp.csc_matrix((np.concatenate(V + [diag]), (np.concatenate(R + [np.arange(n)]), np.concatenate(Cc + [np.arange(n)]))))
    Tm = spl.spsolve(A, Q.ravel()).reshape(nx, nz); ar = dx[:, None] * dz[None, :]
    means = [(Tm * m * ar).sum() / (m * ar).sum() for m in masks]
    def at(x, z): return Tm[np.argmin(abs(xc - x)), np.argmin(abs(zc - z))]
    return means, at
TP = 0.18e-6; TF = 0.3262e-6; ZLI = 0.9361e-6 - 0.3262e-6; TLI = 0.10e-6
print("\n== G' (W/mK): conductancia por unidad de longitud de una línea sobre óxido de campo hacia el silicio (2D, fuente 1 W/m en toda la línea; mitad simétrica => 0,5 W/m)")
Gp = {}
for name, z0, th, ws in (("poly", 0.0, TP, (0.15, 0.3, 0.5, 1.0)), ("li", ZLI, TLI, (0.17, 0.5, 1.0))):
    for w in ws:
        for kox in (1.0, 1.4):
            for tf in (TF,) if name == "li" else (0.25e-6, TF, 0.40e-6):
                (Th,), at = solve2d([(0, w * 1e-6 / 2, z0, z0 + th, 20.0, 0.5)], [w * 1e-6 / 2, 3e-6], [z0, z0 + th, -tf - 0.2e-6, z0 + th + 0.3e-6], tf=tf, kox=kox)
                Tsi = at(0.0, -tf - 0.02e-6); G = 1.0 / (Th - Tsi); Gp[(name, w, kox, round(tf * 1e6, 4))] = G
                print(f"  {name} w={w} um kox={kox} t_campo={tf*1e6:.4f}: T_línea={Th:.4f} K por W/m ; T_Si debajo={Tsi:.4f} ({Tsi/Th*100:.1f} %) ; G' = {G:.2f} W/mK (placa sola: {kox*w/(tf*1e6+ (z0*1e6)):.2f})")

print("\n== B1/B2: aleta 1D. Rth unión = 1/(2 sqrt(k_p w t G')); Joule de línea dT = I^2 Rs/(w G'); contacto opcional Rc = 152 ohm en la unión")
Rs = 48.2; Tamb = 300.0; resB1 = []; resB2 = []
for w in (0.15, 0.3, 0.5, 1.0):
    for kp in (15.0, 30.0):
        for kox in (1.0, 1.4):
            G = Gp[("poly", w, kox, 0.3262)]; Rth = 1 / (2 * np.sqrt(kp * w * 1e-6 * TP * G)); Lh = np.sqrt(kp * w * 1e-6 * TP / G)
            dT = [S * Tamb * 100e-6 * Rth for S in (100e-6, 300e-6, 500e-6)]; resB1 += [dT[0], dT[2]]
            a = 300e-6 * Tamb * Rth; b = Rs / (w * 1e-6 * G); bc = 152 * Rth
            row = f"  w={w} kp={kp:.0f} kox={kox}: Rth={Rth:.3e} K/W, L_h={Lh*1e6:.2f} um | B1 (100 uA; S=100/300/500): {dT[0]:.2f}/{dT[1]:.2f}/{dT[2]:.2f} K"
            for lab, bb in (("sin Rc", b), ("con Rc", b + bc)):
                Iopt = a / (2 * bb); cool = a * a / (4 * bb); I0 = a / bb; resB2.append((Iopt, cool, I0, lab, w))
                row += f" | B2 {lab}: I*={Iopt*1e6:.0f} uA, enfriamiento neto {cool:.2f} K, cruce {I0*1e6:.0f} uA"
            print(row)
print(f"B1 intervalo (S 100-500 uV/K, 100 uA, w 0,15-1,0): {min(resB1):.2f} - {max(resB1):.2f} K")
for lab in ("sin Rc", "con Rc"):
    v = [r for r in resB2 if r[3] == lab]
    print(f"B2 {lab} (S=300): I* {min(r[0] for r in v)*1e6:.0f}-{max(r[0] for r in v)*1e6:.0f} uA ; enfriamiento {min(r[1] for r in v):.2f}-{max(r[1] for r in v):.2f} K ; cruce {min(r[2] for r in v)*1e6:.0f}-{max(r[2] for r in v)*1e6:.0f} uA")
    v = [r for r in v if r[4] == 0.15]
    print(f"   solo w=0,15: I* {min(r[0] for r in v)*1e6:.0f}-{max(r[0] for r in v)*1e6:.0f} uA ; enfriamiento {min(r[1] for r in v):.2f}-{max(r[1] for r in v):.2f} K")

print("\n== C1 / B3 (2D): fracción T_canal / T_calefactor. Canal: silicio activo (hasta z=0) a distancia d del borde del calefactor; fondo T=0 a D")
resC1 = []
def frac2d(name, w, d, kox, D, tf=TF):
    z0, th = (0.0, TP) if name == "poly" else (ZLI, TLI); e = w * 1e-6 / 2; xch = e + d * 1e-6
    act = [(e + max(0.075e-6, d * 1e-6 - 0.25e-6), xch + 0.25e-6)]
    (Th,), at = solve2d([(0, e, z0, z0 + th, 20.0, 0.5)], [e, act[0][0], xch, act[0][1], xch + 1e-6], [z0, z0 + th, -tf - 0.2e-6, z0 + th + 0.3e-6], tf=tf, actives=act, kox=kox, D=D, X=max(D, 100e-6))
    return at(xch, -0.005e-6) / Th
for name, ws in (("poly", (0.15, 0.5, 1.0)), ("li", (0.17, 1.0))):
    for w in ws:
        for kox in (1.0, 1.4):
            row = f"  {name} w={w} kox={kox}:"
            for D in (30e-6, 300e-6):
                for d in (0.2, 0.5, 1.0, 3.0):
                    f = frac2d(name, w, d, kox, D); resC1.append((f, D, d)); row += f" D={D*1e6:.0f}um d={d}: {f*100:.2f}%"
            print(row)
print(f"C1 2D intervalo completo: {min(r[0] for r in resC1)*100:.2f} - {max(r[0] for r in resC1)*100:.2f} %  -> calefactor para +200 K en el canal: +{200/max(r[0] for r in resC1):.0f} .. +{200/min(r[0] for r in resC1):.0f} K")
v = [r[0] for r in resC1 if 0.5 <= r[2] <= 1.0]; print(f"B3 2D (d = 0,5-1 um, línea infinita = cota superior para una unión puntual): {min(v)*100:.2f} - {max(v)*100:.2f} %")

print("\n== C1 / B3 (corrección 3D): silicio como semiespacio, T_Si(r) = integral q'(x) dx /(2 pi k_si r); calefactor finito L; unión: q'(x) ~ exp(-|x|/L_h)")
ksi = 150.0
for name, w, kox in (("poly", 0.15, 1.2), ("poly", 1.0, 1.2), ("li", 0.17, 1.2)):
    G = 0.5 * (Gp[(name, w, 1.0, 0.3262)] + Gp[(name, w, 1.4, 0.3262)])
    for Lh in (2.0, 10.0, 50.0):
        row = f"  calefactor {name} w={w} L={Lh} um:"
        for d in (0.2, 1.0, 3.0):
            r = (w / 2 + d) * 1e-6; Tsi = 2 * np.arcsinh(Lh * 1e-6 / (2 * r)) / (2 * np.pi * ksi); Tsi0 = 2 * np.arcsinh(Lh * 1e-6 / (2 * 0.3e-6)) / (2 * np.pi * ksi)
            row += f" d={d}: {Tsi/(1/G+Tsi0)*100:.2f}%"
        print(row)
xx = np.linspace(-20e-6, 20e-6, 400001)
for w in (0.15, 0.5, 1.0):
    for kp in (15.0, 30.0):
        G = 0.5 * (Gp[("poly", w, 1.0, 0.3262)] + Gp[("poly", w, 1.4, 0.3262)]); Lh = np.sqrt(kp * w * 1e-6 * TP / G); Rth = 1 / (2 * np.sqrt(kp * w * 1e-6 * TP * G))
        row = f"  unión en poly w={w} kp={kp:.0f} (L_h={Lh*1e6:.2f} um, Rth={Rth:.2e}):"
        for d in (0.5, 1.0):
            r = np.sqrt(xx**2 + ((w / 2 + d) * 1e-6) ** 2 + TF**2); Tsi = np.trapezoid(np.exp(-abs(xx) / Lh) / (2 * Lh) / (2 * np.pi * ksi * r), xx)
            row += f" d={d} um: {Tsi/Rth*100:.2f}%"
        print(row)

print("\n== C2: elemento de poly (w_c) sobre campo entre dos calefactores de poly a 0,21 um; fracción T_centro/T_calefactor (2D)")
for wc in (0.15, 0.5):
    for wh in (0.15, 0.5, 1.0):
        for kox in (1.0, 1.4):
            x1 = wc * 1e-6 / 2; x2 = x1 + 0.21e-6; x3 = x2 + wh * 1e-6; row = f"  w_c={wc} w_h={wh} kox={kox}:"
            for D in (30e-6, 300e-6):
                (Tc, Th), at = solve2d([(0, x1, 0, TP, 20.0, 0.0), (x2, x3, 0, TP, 20.0, 0.5)], [x1, x2, x3, x3 + 1e-6], [0, TP, -TF - 0.2e-6, TP + 0.3e-6], kox=kox, D=D, X=max(D, 100e-6))
                row += f" D={D*1e6:.0f}um: {Tc/Th*100:.1f}%"
            print(row)

# =============================== D1 ===============================
print("\n== D1: n/N_D con n^2/(N_D - n) = (N_C/g) exp(-E_D/kT), g=2, N_C = 2,8e19 (T/300)^1,5 cm^-3 (no degenerado, sin compensación)")
kBe = 8.617333e-5
def nfrac(Nd, T, Ed): K = 2.8e19 * (T / 300) ** 1.5 / 2 * np.exp(-Ed / (kBe * T)); return (-K + np.sqrt(K * K + 4 * K * Nd)) / 2 / Nd
for Ed in (0.045, 0.045 - 3.1e-8 * (5e17) ** (1 / 3)):
    print(f" E_D = {Ed*1e3:.1f} meV" + ("" if Ed == 0.045 else " (rebajada por dopado, Pearson-Bardeen: E_D0 - 3,1e-8 N^(1/3) eV; supuesto)"))
    for Nd in (4e17, 5e17, 6e17):
        T3 = brentq(lambda T: nfrac(Nd, T, Ed) - 1e-3, 3, 300)
        print(f"  N_D={Nd:.0e}: n/N_D=1e-3 a T = {T3:.1f} K ; a 77 K ionizado {nfrac(Nd,77,Ed)*100:.1f} % ; a 300 K {nfrac(Nd,300,Ed)*100:.0f} % ; a 30 K {nfrac(Nd,30,Ed):.1e} ; a 4,2 K {nfrac(Nd,4.2,Ed):.1e}")
aB = 0.529e-8 * 11.7 / 0.26; print(f" Mott: N_c ~ (0,26/a_B*)^3 con a_B* = {aB*1e7:.2f} nm (m*=0,26) -> {(0.26/aB)**3:.1e} cm^-3 (experimental Si:P 3,7e18). N_D^(1/3) a_B* a 5e17 = {(5e17)**(1/3)*aB:.3f}; distancia media {(5e17)**(-1/3)*1e7:.1f} nm")

# =============================== E1 ===============================
print("\n== E1: Biot-Savart, cinta de met1 w=5 um, espesor 0,36 um, base a 1,3761 um sobre z=0 (referencia del tech: base del pozo/sustrato; superficie activa en z=0,3262), I=14 mA")
I = 14e-3; w = 5e-6; tm = 0.36e-6; zb = 1.3761e-6
print(f" lámina infinita mu0 I/(2w) = {mu0*I/(2*w)*1e3:.3f} mT")
zz = np.linspace(zb, zb + tm, 201)
def Bx(x, z):   # promedio sobre el espesor de la fórmula de cinta delgada
    return np.mean(mu0 * I / (2 * np.pi * w) * (np.arctan((x + w / 2) / (zz - z)) - np.arctan((x - w / 2) / (zz - z))))
def Bz(x, z):
    return np.mean(mu0 * I / (4 * np.pi * w) * np.log(((x + w / 2) ** 2 + (zz - z) ** 2) / ((x - w / 2) ** 2 + (zz - z) ** 2)))
for zs, lab in ((0.3262e-6, "superficie del silicio activo (z=+0,3262)"), (0.2062e-6, "techo del pozo según tech (z=+0,2062)"), (0.0, "z=0"), (-0.5e-6, "0,5 um bajo z=0"), (-1e-6, "1 um bajo z=0"), (-2e-6, "2 um bajo z=0")):
    print(f"  {lab}: B_plano(centro) = {Bx(0,zs)*1e3:.3f} mT ; en x=2 um: {Bx(2e-6,zs)*1e3:.3f} mT ; en el borde x=2,5: plano {Bx(2.5e-6,zs)*1e3:.3f}, vertical {abs(Bz(2.5e-6,zs))*1e3:.3f} mT")

# =============================== G2 ===============================
print("\n== G2: emisión termoiónica inversa, contacto 0,17 x 0,17 um, T=300 K")
A = (0.17e-4) ** 2; kT = kBe * 300; es = 11.7 * 8.8541878e-14
for Ast in (112.0, 252.0):
    print(f" A* = {Ast} A/cm2K2 (112: valor efectivo usual n-Si; 252: teórico <100>)")
    for phi in (0.57, 0.60):
        I0 = A * Ast * 300**2 * np.exp(-phi / kT); row = f"  phi_B={phi}: sin rebaje I = {I0*1e12:.3f} pA"
        for Nd in (4e17, 6e17):
            for VR in (0.0, 0.5, 1.8):
                Vbi = phi - kT * np.log(2.8e19 / Nd); E = np.sqrt(2 * q * Nd * (Vbi + VR - kT) / es); dphi = np.sqrt(q * E / (4 * np.pi * es))
                row += f" | N={Nd:.0e} VR={VR}: E={E/1e5:.1f}e5 V/cm, dphi={dphi*1e3:.0f} meV, I={I0*np.exp(dphi/kT)*1e12:.1f} pA"
        print(row)
E00 = 18.5e-12 * np.sqrt(5e17 / (0.3 * 11.7)); print(f" E00 (5e17, m*=0,3) = {E00*1e3:.1f} meV ; kT/E00 = {kT/E00:.1f} -> emisión termoiónica asistida por campo no despreciable en inversa (sube la corriente)")
print("\nfin:", subprocess.run(["date"], capture_output=True, text=True).stdout.strip())
