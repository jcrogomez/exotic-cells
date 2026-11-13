"""d26_budget.py — presupuesto emisor -> fotodiodo, con la u(r) de la geometría dibujada (reusa d26_fd.geometry/solve).

1. F(alpha, d): fracción de fotones emitidos (fuente puntual isótropa en el emisor, z = zs) que acaba como electrón en el
   fotodiodo, con atenuación e^{-alpha r}, imagen por reflexión total (theta > theta_c) y, dentro del cono de escape, la
   reflectancia R_cone de la tapa (0,175 sin metal; 0,95 Al liso; d27_rcwa.txt).
2. Espectros: (FM) unión en directa: van Roosbroeck-Shockley r(E) ~ alpha(E) E^2 exp(-E/kT) con alpha de Green y Keevers 1995
   (PVEducation, LEÍDA); (AM) avalancha 400-900 nm, pico 620 nm (Dutta 2017, leído por el laboratorio: PESCA_OPTO_1104 §3),
   forma gaussiana supuesta (sigma 110 nm) + cola IR barrida 0-10 %.
3. Eficiencia interna de la unión en directa de ESTA celda (cálculo, no medida): fotones por hueco que cruza la base del PNP
   vertical = B_rel * B * n_base * tau_t, con B = 4,68e-15 cm^3/s a 300 K (Nguyen 2014, tabla, LEÍDA; coincide con Trupke 2003),
   B_rel 0,3-1 (reducción a alta densidad, DE MEMORIA), n_base = max(N_D, p) con N_D 1e17-5e17 (no público, se barre),
   tau_t = W^2/(2 D_p) (W 0,5-1,5 um, D_p 5-10 cm^2/s, barridos), p a 1 mA = J W/(2 q D_p) (alta inyección).
4. beta del PNP vertical: modelos del PDK local (Gummel-Poon con ikf), corriente máxima sin saturar el PNP con R_sub de d26_sub.
5. Fondo por luz atrapada en el dado (300 um, cara trasera reflectante): cota.
6. Calor: deltaT = P/(2 pi k r) en el fotodiodo.
Salida: d26_budget.txt
"""
import numpy as np, json
import d26_fd as F

L = []
def P(*a):
    s = ' '.join(str(x) for x in a); print(s, flush=True); L.append(s)

NSI, NOX = 3.54, 1.45; THC = np.arcsin(NOX/NSI)
# Green y Keevers 1995 (PVEducation), LEÍDA: nm, alpha cm^-1
GK = np.array([[600, 4.14e3], [650, 2.81e3], [700, 1.90e3], [800, 8.5e2], [900, 3.06e2], [1000, 64.0], [1050, 16.3],
               [1080, 6.2], [1100, 3.5], [1120, 2.0], [1140, 1.0], [1150, 0.68], [1160, 0.42], [1180, 0.065], [1200, 0.022]])
def alpha_cm(lam):
    return np.exp(np.interp(lam, GK[:, 0], np.log(GK[:, 1])))

# ---------- 1. u(r) y F(alpha) ----------
XX, YY, ZZ, H = F.XX, F.YY, F.ZZ, F.H
alphas = np.logspace(-1, 4, 26)               # cm^-1
Ftab = {}
for d in (5, 10, 20):
    for sn, sc in {'central': (1.5, 2.5, 1.0, 100.0, True), 'alto': (1.5, 2.5, 1.0, 1000.0, False),
                   'somero': (1.0, 1.5, 0.5, 100.0, True)}.items():
        pd, em, ct, rg, s_near, s_ctrl = F.geometry(d, *sc[:3])
        u, info = F.solve(np.ones(XX.shape), pd | em | ct | rg, np.where(pd, 1.0, 0.0), kappa=1/sc[3]**2, bottom_dirichlet=sc[4])
        for src, s in (('near', s_near), ('ctrl', s_ctrl)):
            for zs in (0.5, 0.15):
                dx, dy = XX-s[0], YY-s[1]
                rd = np.sqrt(np.maximum(dx**2+dy**2+(ZZ-zs)**2, (H/2)**2)); ri = np.sqrt(np.maximum(dx**2+dy**2+(ZZ+zs)**2, (H/2)**2))
                th = np.arccos(np.clip((ZZ+zs)/ri, -1, 1)); cone = th < THC
                row = []
                for a in alphas:
                    au = a*1e-4                    # 1/um
                    ed = np.exp(-au*rd)/rd**2; ei = np.exp(-au*ri)/ri**2
                    Sd = np.sum(u*ed)*H**3; St = np.sum(np.where(~cone, u*ei, 0))*H**3; Sc = np.sum(np.where(cone, u*ei, 0))*H**3
                    row.append((au/(4*np.pi)*Sd, au/(4*np.pi)*St, au/(4*np.pi)*Sc))
                Ftab[(d, sn, src, zs)] = np.array(row)
def Fof(a_cm, d, sn='central', src='near', zs=0.5, Rc=0.175):
    t = Ftab[(d, sn, src, zs)]
    tot = t[:, 0] + t[:, 1] + Rc*t[:, 2]
    return np.exp(np.interp(np.log(a_cm), np.log(alphas), np.log(tot)))
P('# 1. F(alpha): fracción de fotones -> electrones en el fotodiodo (fuente z=0,5 um, sin tapa R_cone=0,175)')
P('# alpha[cm-1] | d=5 central | d=10 | d=20 | control 44 um (d=5) | d=5 alto | d=5 somero')
for a in (0.3, 1, 2, 3.5, 10, 30, 100, 300, 1000, 3000):
    P('%7g | %.2e | %.2e | %.2e | %.2e | %.2e | %.2e' % (a, Fof(a, 5), Fof(a, 10), Fof(a, 20), Fof(a, 5, src='ctrl'),
      Fof(a, 5, 'alto'), Fof(a, 5, 'somero')))

# ---------- 2. espectros ----------
kT = 0.02585
lam = np.linspace(950, 1300, 701); E = 1239.84/lam
aG = alpha_cm(lam); aG[lam > 1200] = 0.022*np.exp(-(lam[lam > 1200]-1200)/20)   # cola extrapolada (supuesto)
rsp = aG*E**2*np.exp(-E/kT)            # por unidad de energía; pasar a por nm: |dE/dlam| = E/lam
rsp_l = rsp*E/lam; rsp_l /= np.trapezoid(rsp_l, lam)
pk = lam[np.argmax(rsp_l)]
half = lam[rsp_l > rsp_l.max()/2]
P('# 2. FM: espectro de van Roosbroeck-Shockley con alpha de Green-Keevers: pico %.0f nm, FWHM %.0f-%.0f nm' % (pk, half.min(), half.max()))
P('#    alpha medio ponderado por el espectro (lo que pesa para un absorbente delgado) = %.2f cm^-1' % np.trapezoid(aG*rsp_l, lam))
def Fspec(lamv, w, d, **kw):
    return np.trapezoid(np.array([Fof(alpha_cm(l), d, **kw) if l <= 1200 else Fof(max(0.022*np.exp(-(l-1200)/20), 0.1), d, **kw) for l in lamv])*w, lamv)
FFM = {d: Fspec(lam, rsp_l, d) for d in (5, 10, 20)}
FFMc = Fspec(lam, rsp_l, 5, src='ctrl')
FFMflat = {d: Fspec(lam, rsp_l, d, Rc=0.95) for d in (5, 10, 20)}
P('#    F_FM: d=5 %.2e, d=10 %.2e, d=20 %.2e, control 44 um %.2e ; con Al liso encima: d=5 %.2e (x%.3f)' %
  (FFM[5], FFM[10], FFM[20], FFMc, FFMflat[5], FFMflat[5]/FFM[5]))
lamA = np.linspace(380, 1150, 771)
FAM = {}
for tail in (0.0, 0.03, 0.1):
    w = np.exp(-0.5*((lamA-620)/110)**2); w[lamA > 900] = 0; w /= np.trapezoid(w, lamA)
    wt = np.where(lamA > 900, 1.0, 0.0); wt /= np.trapezoid(wt, lamA)
    w = (1-tail)*w + tail*wt
    for d in (5, 10, 20):
        FAM[(tail, d)] = Fspec(lamA, w, d, zs=0.15)
P('# 2b. AM (400-900 nm, pico 620, fuente z=0,15): F_AM d=5/10/20: cola 0 %%: %.2e %.2e %.2e | cola 3 %%: %.2e %.2e %.2e | cola 10 %%: %.2e %.2e %.2e' %
  tuple(FAM[(t, d)] for t in (0.0, 0.03, 0.1) for d in (5, 10, 20)))

# ---------- 3. eficiencia interna de la directa ----------
B = 4.68e-15; q = 1.602e-19
P('# 3. eta_FM (fotones por hueco que cruza la base), cálculo con parámetros barridos')
P('# N_D[cm-3] W[um] Dp[cm2/s] | tau_t[ns] | eta baja inyección (Brel 1) | p a 1 mA en 1,4 um2 [cm-3] | eta a 1 mA (Brel 0,3-1)')
etas = []
for ND in (1e17, 5e17):
    for W in (0.5, 1.0, 1.5):
        for Dp in (5.0, 10.0):
            tt = (W*1e-4)**2/(2*Dp)
            J = 1e-3/1.4e-8
            p = J*W*1e-4/(2*q*Dp)
            e_lo = B*ND*tt; e_hi = (0.3*B*max(ND, p)*tt, B*max(ND, p)*tt)
            etas += [e_lo, *e_hi]
            P('%.0e %.1f %4.1f | %.2f | %.1e | %.1e | %.1e-%.1e' % (ND, W, Dp, tt*1e9, e_lo, p, *e_hi))
P('#    rango eta en esta celda: %.1e - %.1e (mediana %.1e)' % (min(etas), max(etas), np.median(etas)))

# ---------- 4. beta del PNP vertical (PDK) ----------
P('# 4. beta del PNP vertical del PDK (Gummel-Poon, tt: bf*dkbfpp; sky130_fd_pr__pnp_05v5_*.model.spice l. 45-46 y 50-51; corners/tt/nonfet.spice l. 38-39)')
for name, bf, ikf, Is, ise, ne in (('W0p68L0p68 (0,46 um2)', 19.35*0.95154, 3.3057e-5, 1.5075e-18*0.9284, 9.4936e-17, 1.6444),
                                   ('W3p40L3p40 (11,6 um2)', 16.603*1.1288, 3.8589e-4, 7.119e-18*1.0046, 1.031e-15*0.745, 1.64)):
    row = []
    for Ic in (1e-6, 1e-5, 1e-4, 3e-4, 1e-3, 3e-3):
        qb = (1+np.sqrt(1+4*Ic/ikf))/2           # aproximación de alta inyección sin VAF
        Vbe = 0.02585*np.log(Ic*qb/Is)
        Ib = Ic*qb/bf + ise*np.exp(Vbe/(ne*0.02585))
        row.append('%.0e:%.1f' % (Ic, Ic/Ib))
    P('   %s  Ic:beta  %s' % (name, '  '.join(row)))

# ---------- 5. luz atrapada en el dado ----------
Vdie = 3.0e3*3.0e3*300.0     # um^3, dado de ~3x3 mm (DE MEMORIA, orden de magnitud) -> cota
fd = json.load(open('d26_fd2.json'))
Veff = fd['5|central|none']['Veff']
P('# 5. Luz atrapada (cota): fracción absorbida en el dado <= 1; repartida en %.1e um^3 -> F_fondo <= %.1e (Veff %.0f um^3) frente a F_FM(5 um) %.1e' % (Vdie, Veff/Vdie, Veff, FFM[5]))

# ---------- 6. calor ----------
for Pw in (1.8e-3,):
    for r in (7.6, 12.6, 22.6):
        P('# 6. deltaT en el fotodiodo con %.1f mW a %.1f um: %.2f K (k = 148 W/m K, DE MEMORIA)' % (Pw*1e3, r, Pw/(2*np.pi*148*r*1e-6)))

json.dump({'FFM': FFM, 'FFMc': FFMc, 'FFMflat': FFMflat, 'FAM': {str(k): v for k, v in FAM.items()},
           'eta_range': [min(etas), float(np.median(etas)), max(etas)]}, open('d26_budget.json', 'w'), indent=1)
open('d26_budget.txt', 'w').write('\n'.join(L)+'\n')
