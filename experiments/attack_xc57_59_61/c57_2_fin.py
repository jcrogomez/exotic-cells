"""c57_2: unión Peltier como aleta 1D. Dos patas (A, B) de poly sobre óxido de campo, fuga G' al sustrato (de c57_1),
Joule distribuido I^2 R', Joule de contacto I^2 Rc en la unión, Peltier +-S_par*T*I, sumidero extra G_j del puente de li.
Solución analítica (patas largas) + diferencias finitas para la cadena alterna de paso L (uniones fría/caliente).
PDK: n+ poly 48.2 ohm/sq, p+ poly (res_high_po) 319.8, p- (res_xhigh_po) 2000 (sky130A.tech l. 5113-5119);
contacto a poly 152 ohm (l. 5134); espesor poly 0.18 um (l. 5052). SUPUESTOS barridos: S_par, k_poly, k_ox (vía G')."""
import numpy as np
T0 = 300.0; tp = 0.18e-6
def gp(w, kox):  # ajuste a c57_1_gprima.txt (interpolación lineal en w)
    ws = np.array([0.15, 0.35, 0.5, 1.0, 2.0]); g10 = np.array([2.91, 3.67, 4.09, 5.79, 8.84]); g14 = np.array([4.05, 5.08, 5.66, 7.98, 12.13])
    return np.interp(w, ws, g10 if kox == 1.0 else g14)
def junction(I, S, legs, Rc, Gj):
    """legs: lista (Rsh, w_um, k, kox). Devuelve Tj-T0 para +I y -I (analítico, patas >> longitud de curación)."""
    num_even = I**2*Rc; den = Gj; lam = []
    for (Rsh, w, k, kox) in legs:
        G = gp(w, kox); A = w*1e-6*tp; g = np.sqrt(k*A*G); Rl = Rsh/(w*1e-6)
        num_even += g*I**2*Rl/G; den += g; lam.append(np.sqrt(k*A/G)*1e6)
    odd = S*T0*I/den; even = num_even/den
    return odd, even, lam, den
out = []
P = out.append
P("# c57_2_fin.py — una unión aislada. dT_impar = S*T*I/Gtot ; dT_par = Joule. Enfriamiento neto = impar - par.")
P("# caso | S_par uV/K | k_poly | k_ox | lam_A,lam_B um | Gtot uW/K | I_opt uA | dT_neto_max mK | impar@I_opt mK | impar@100uA mK | par@100uA mK | I(impar=par) uA")
cases = {
 "nPoly0.5/pPoly(high)0.5, 2+2 contactos": dict(legs=lambda k, kox: [(48.2, 0.5, k, kox), (319.8, 0.5, k, kox)], Rc=152/2*2, Gj=2e-6),
 "nPoly0.5/pPoly(high)2.0, 2+8 contactos": dict(legs=lambda k, kox: [(48.2, 0.5, k, kox), (319.8, 2.0, k, kox)], Rc=152/2+152/8, Gj=3e-6),
 "nPoly0.15/pPoly0.35 (mínimos), 1+1":     dict(legs=lambda k, kox: [(48.2, 0.15, k, kox), (319.8, 0.35, k, kox)], Rc=304, Gj=1e-6),
 "nPoly0.5/pPoly(xhigh)0.5, 2+2":           dict(legs=lambda k, kox: [(48.2, 0.5, k, kox), (2000, 0.5, k, kox)], Rc=152, Gj=2e-6),
 "nPoly0.5/li0.17 (una sola pata activa)":  dict(legs=lambda k, kox: [(48.2, 0.5, k, kox)], Rc=152/2, Gj=3e-6),
 "ideal: nPoly/pPoly(high) sin Rc ni Gj":   dict(legs=lambda k, kox: [(48.2, 0.5, k, kox), (319.8, 0.5, k, kox)], Rc=0, Gj=0),
}
res = {}
for name, c in cases.items():
    for S in (100e-6, 300e-6, 500e-6):
        for k in (15.0, 30.0):
            for kox in (1.0, 1.4):
                legs = c["legs"](k, kox)
                o1, e1, lam, den = junction(1e-4, S, legs, c["Rc"], c["Gj"])
                a = o1/1e-4; b = e1/1e-8   # impar = a I ; par = b I^2
                Iopt = a/(2*b); net = a*a/(4*b)
                res[(name, S, k, kox)] = (a, b, den)
                P(f"{name} | {S*1e6:.0f} | {k:.0f} | {kox} | {lam[0]:.2f},{lam[-1]:.2f} | {den*1e6:.2f} | {Iopt*1e6:.0f} | {net*1e3:.1f} | {a*Iopt*1e3:.1f} | {o1*1e3:.1f} | {e1*1e3:.1f} | {a/b*1e6:.0f}")
# cadena alterna por diferencias finitas: periodo 2L, unión fría en x=0 y caliente en x=L
def chain(I, S, legA, legB, Rc, Gj, L_um, n=400):
    import scipy.sparse as sp, scipy.sparse.linalg as spl
    N = 2*n; dx = L_um*1e-6/n
    kA = np.zeros(N); G = np.zeros(N); q = np.zeros(N)
    for i in range(N):
        Rsh, w, k, kox = legA if i < n else legB
        kA[i] = k*w*1e-6*tp; G[i] = gp(w, kox); q[i] = I**2*Rsh/(w*1e-6)
    M = sp.lil_matrix((N, N)); rhs = q*dx
    for i in range(N):
        j = (i+1) % N; c = 2*kA[i]*kA[j]/(kA[i]+kA[j])/dx
        M[i, i] += c; M[j, j] += c; M[i, j] -= c; M[j, i] -= c
        M[i, i] += G[i]*dx
    # uniones: entre N-1 y 0 (fría con +I: absorbe) y entre n-1 y n (caliente)
    for (i, sgn) in ((0, -1.0), (n, +1.0)):
        M[i, i] += Gj; rhs[i] += sgn*S*T0*I + I**2*Rc
    T = spl.spsolve(M.tocsc(), rhs)
    return T[0], T[n]
P("\n# cadena alterna (DF): dT en la unión 'fría' para +I y -I; impar=(T(+I)-T(-I))/2 ; S=300uV/K, k=30, kox=1.4, nPoly0.5/pPoly(high)0.5")
P("# L_um | I_uA | T_fria(+I) mK | T_fria(-I) mK | impar mK | par mK | impar/impar_aislada")
legA = (48.2, 0.5, 30.0, 1.4); legB = (319.8, 0.5, 30.0, 1.4)
a_iso = res[("nPoly0.5/pPoly(high)0.5, 2+2 contactos", 300e-6, 30.0, 1.4)][0]
for Lum in (0.5, 1, 2, 5, 20):
    for I in (30e-6, 100e-6):
        tp_, _ = chain(I, 300e-6, legA, legB, 152, 2e-6, Lum); tm_, _ = chain(-I, 300e-6, legA, legB, 152, 2e-6, Lum)
        odd = (tp_-tm_)/2; ev = (tp_+tm_)/2
        P(f"{Lum} | {I*1e6:.0f} | {tp_*1e3:.1f} | {tm_*1e3:.1f} | {odd*1e3:.1f} | {ev*1e3:.1f} | {abs(odd)/(a_iso*I):.2f}")
# lectura
P("\n# Lectura (c): señal impar en el sensor y tiempo a 5 sigma. Lector: 5.2 %/K y ruido de disparo 0.55 %/conversión (xc19, corrida);")
P("# conversión 0.18 ms a Vg=0.30 V. Demodulación síncrona: N = 2*(5*0.55/señal%)^2 conversiones (mitad en cada sentido).")
P("# f = fracción de dT de la unión que llega al sensor: 0.2 poly vecino a 0.5 um (no es termómetro MOS); 0.02 zona activa de silicio (c57_1)")
P("# dT_impar_union mK | f | señal % | N conversiones | tiempo s (0.18 ms/conv)")
for dT in (1, 10, 100, 1000):
    for f in (0.02, 0.005):
        sig = dT*1e-3*f*5.2
        N = 2*(5*0.55/sig)**2
        P(f"{dT} | {f} | {sig:.5f} | {N:.3g} | {N*0.18e-3:.3g}")
P("\n# Explicaciones aburridas (cálculo): asimetría del driver eps=|I+|-|I-|/I: impar falsa = 2*eps*par/2 = eps*par.")
P("# Thomson: q'_T = mu_T*I*dT/dx con mu_T = T dS/dT ~ S (orden): impar a orden I^3: ratio Thomson/Peltier ~ dT_par/T0.")
for name in ("nPoly0.5/pPoly(high)0.5, 2+2 contactos",):
    a, b, den = res[(name, 300e-6, 30.0, 1.4)]
    for I in (30e-6, 100e-6, 300e-6, 1e-3):
        P(f"I={I*1e6:.0f} uA: impar {a*I*1e3:.1f} mK, par {b*I*I*1e3:.1f} mK, falsa impar con eps=1% {0.01*2*b*I*I*1e3:.2f} mK, Thomson/Peltier ~ {b*I*I/T0:.1e}; tensión en unión+patas 5um ~ {I*(152+48.2*5/0.5+319.8*5/0.5)*1e3:.0f} mV")
open("c57_2_fin.txt", "w").write("\n".join(out)+"\n"); print("\n".join(out))
