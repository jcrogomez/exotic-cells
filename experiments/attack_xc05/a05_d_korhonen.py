"""a05 (d): electromigración, Korhonen 1D (J. Appl. Phys. 73, 3790 (1993); citado en READING.md como 'Exists', NO LEÍDO: la ecuación va de memoria).
  w(x) d(sigma)/dt = d/dx [ w(x) kappa ( d(sigma)/dx + G(x) ) ],  kappa = D_a B Omega/(kT),  G = e Z* rho j(x) / Omega,  extremos bloqueantes
  (las cabezas acaban en mcon de W / li1 de TiN: el Al no pasa). Volúmenes finitos, Euler implícito.
Parámetros (todos DE MEMORIA salvo rho): Omega=1.66e-29 m3; rho=4.5e-8 Ohm.m (PDK: 0.125 Ohm/sq x 0.36 um) x (1+3.179e-3 dT);
  Z* 1..10 ; B 30..100 GPa ; sigma_crit 100..600 MPa ; D_a = D0 exp(-Ea/kT), Ea 0.5..0.9 eV, D0 1e-9..1e-6 m2/s (delta*D_gb/d).
Ancla independiente (PDK local): sky130_fd_sc_hd__nom.tlef l.123 'DCCURRENTDENSITY AVERAGE 2.8 ; # mA/um Iavg_max at Tj = 90oC'."""
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spl
kB=1.380649e-23; e=1.602176634e-19; Om=1.66e-29; yr=3.156e7
rho0=0.125*0.36e-6; tc=3.179e-3; tm=0.36e-6
def Gwind(j,Z,dT=0): return e*Z*rho0*(1+tc*dT)*j/Om
print("1) Blech (no depende de la difusividad): sigma_sat = sum(G_i L_i)/2 con extremos bloqueantes; hay nucleación solo si sigma_sat > sigma_crit")
I=2.06e-3
cases={'A: 0.14 x 10 um':[(0.14e-6,10e-6)],
       'B: 0.50 con cuello 0.14 x 1':[(0.5e-6,9e-6),(0.14e-6,1e-6)],
       'cuello 0.14 x 0.30 en 0.50':[(0.5e-6,9.7e-6),(0.14e-6,0.3e-6)],
       'puente 0.05x0.05 en linea 0.14 x 10':[(0.14e-6,9.95e-6),(0.05e-6,0.05e-6)],
       'puente 0.05x0.05 en 0.50':[(0.5e-6,9.95e-6),(0.05e-6,0.05e-6)],
       'solo el puente 0.05 x 0.05 (si los lados fueran depósito)':[(0.05e-6,0.05e-6)],
       'solo el cuello 0.14 x 1':[(0.14e-6,1e-6)]}
print(f"{'caso':<58}{'jL A/cm':>9}"+"".join(f"{'Z*='+str(Z)+' MPa':>12}" for Z in (1,4,10)))
for Icase in (2.06e-3,18.5e-3):
    print(f" I = {Icase*1e3:.2f} mA")
    for n,segs in cases.items():
        jL=sum(Icase/(w*tm)*L for w,L in segs)
        print(f"  {n:<56}{jL/100:>9.0f}"+"".join(f"{Gwind(1,Z)*jL/2/1e6:>12.1f}" for Z in (1,4,10)))
print("  sigma_crit barrida: 100..600 MPa. Umbrales de Blech en la literatura (fragmentos de búsqueda, NO LEÍDOS): ~1e4 A/cm para AlCu encapsulado con tapones de W;\n  ~2640 A/cm (66 um a 0.4 MA/cm2, 303 C, Al-0.25%Cu); 'unas 5 veces menos' sin pasivar (~2000).")
print("  jL de EFLD-01 línea A con 2.06 mA = %.0f A/cm"%(I/(0.14e-6*tm)*10e-6/100))

def korhonen(segs,Icur,T,Z,B,D0,Ea,scrit,dT=0,n=400,tmax=1e4*yr):
    L=sum(s[1] for s in segs); dx=L/n; x=(np.arange(n)+0.5)*dx
    edges=np.cumsum([s[1] for s in segs]); w=np.array([segs[min(np.searchsorted(edges,xx,side='right'),len(segs)-1)][0] for xx in x])
    # cuello centrado: reordenar -> ancho, cuello, ancho
    if len(segs)==2:
        Lw,Ln=segs[0][1],segs[1][1]; w=np.where(abs(x-L/2)<Ln/2,segs[1][0],segs[0][0])
    j=Icur/(w*tm); G=Gwind(j,Z,dT)
    kap=D0*np.exp(-Ea*e/(kB*T))*B*Om/(kB*T)
    wf=2*w[:-1]*w[1:]/(w[:-1]+w[1:]); Gf=0.5*(G[:-1]*w[:-1]+G[1:]*w[1:])/wf  # w*G es constante = e Z rho I/(tm Om)
    main=np.zeros(n); main[:-1]+=wf; main[1:]+=wf
    K=sp.diags([main,-wf,-wf],[0,-1,1])*(kap/dx**2)
    src=np.zeros(n); src[:-1]+=kap*wf*Gf/dx; src[1:]-=kap*wf*Gf/dx      # divergencia del término de viento
    s=np.zeros(n); t=0; dt=1e-6*L*L/kap; smax=[0]; ts=[0]
    while t<tmax:
        lu=spl.splu((sp.diags(w/dt)+K).tocsc())
        for _ in range(4):
            s=lu.solve(w/dt*s+src); t+=dt; ts.append(t); smax.append(s.max())
            if s.max()>=scrit: return np.interp(scrit,smax,ts), s.max()
        dt*=1.3
        if len(smax)>40 and abs(smax[-1]-smax[-5])<1e-6*smax[-1]: break
    return np.inf, s.max()
print("\n2) Comprobación del solucionador: línea uniforme larga, t_nuc analítico semi-infinito = (pi/4kappa)(sigma_c/G)^2")
T=300;Z=4;B=50e9;D0=1e-8;Ea=0.6;sc=100e6
tn,_=korhonen([(0.14e-6,100e-6)],2.06e-3,T,Z,B,D0,Ea,sc)
kap=D0*np.exp(-Ea*e/(kB*T))*B*Om/(kB*T); Gv=Gwind(2.06e-3/(0.14e-6*tm),Z)
print(f"  numérico {tn/yr:.3g} años ; analítico {np.pi/(4*kap)*(sc/Gv)**2/yr:.3g} años")

print("\n3) Tiempo hasta sigma_crit, línea A (0.14 x 10 um), I=2.06 mA, T=300 K + 1.2 K (corrida a05_c). 'inf' = inmortal (Blech).  Unidades: años")
print(f"{'Ea eV':>6}{'D0 m2/s':>9}{'Z*':>4}{'B GPa':>6}"+"".join(f"{'sc='+str(s)+'MPa':>13}" for s in (100,200,400,600)))
for Ea in (0.5,0.6,0.7,0.9):
    for D0 in (1e-9,1e-7,1e-6):
        for Z,B in ((4,50e9),(10,100e9)):
            row=[korhonen([(0.14e-6,10e-6)],2.06e-3,301.2,Z,B,D0,Ea,s*1e6,dT=1.2)[0]/yr for s in (100,200,400,600)]
            print(f"{Ea:>6.1f}{D0:>9.0e}{Z:>4}{B/1e9:>6.0f}"+"".join(f"{r:>13.3g}" for r in row))
print("\n4) Lo mismo con buf_16 x8 = 18.5 mA (3.7e7 A/cm2), dT = 137 K (a05_c, k_ox 1.4) -> T = 437 K. Unidades: segundos")
print(f"{'Ea eV':>6}{'D0 m2/s':>9}{'Z*':>4}"+"".join(f"{'sc='+str(s)+'MPa':>13}" for s in (100,200,400,600)))
for Ea in (0.5,0.6,0.7,0.9):
    for D0 in (1e-9,1e-7,1e-6):
        row=[korhonen([(0.14e-6,10e-6)],18.5e-3,437,4,50e9,D0,Ea,s*1e6,dT=137)[0] for s in (100,200,400,600)]
        print(f"{Ea:>6.1f}{D0:>9.0e}{4:>4}"+"".join(f"{r:>13.3g}" for r in row))
print("\n5) Cuello B y puente, I = 2.06 y 18.5 mA: sigma máxima alcanzable (MPa), Z*=4 (numérico, estado estacionario)")
for n in ('B: 0.50 con cuello 0.14 x 1','cuello 0.14 x 0.30 en 0.50','puente 0.05x0.05 en 0.50','puente 0.05x0.05 en linea 0.14 x 10'):
    for Ic in (2.06e-3,18.5e-3):
        tn,sm=korhonen(cases[n],Ic,300,4,50e9,1e-6,0.5,1e12,tmax=1e9*yr)
        print(f"  {n:<40} I={Ic*1e3:5.2f} mA: sigma_max = {sm/1e6:8.1f} MPa")
print("\n6) Ancla aburrida con la regla del propio PDK: 2.8 mA/um a Tj=90 C -> j_regla = %.2e A/cm2. Si esa regla garantiza >= 10 años [? vida de diseño: DE MEMORIA],"%(2.8e-3/1e-6/tm/1e4))
print("   Black con n=2 (nucleación, coherente con Korhonen): t(300 K, 4.2e6 A/cm2) >= 10 a x (j_regla/j)^2 x exp(Ea/k (1/301 - 1/363))")
jr=2.8e-3/1e-6/tm
for Ea in (0.5,0.6,0.7,0.9):
    f=(jr/(2.06e-3/(0.14e-6*tm)))**2*np.exp(Ea*e/kB*(1/301.2-1/363.15))
    f2=(jr/(18.5e-3/(0.14e-6*tm)))**2*np.exp(Ea*e/kB*(1/437-1/363.15))
    print(f"   Ea={Ea}: 2.06 mA/301 K -> >= {10*f:8.1f} años ;  18.5 mA/437 K -> >= {10*f2*yr/3600:8.2f} horas")
print("\n7) Velocidad de deriva tras nuclear, v = D_a e Z* rho j/(kT) (Z*=4), y tiempo para vaciar 0.14 um:")
for T,Ic,dT in ((301.2,2.06e-3,1.2),(437,18.5e-3,137)):
    for Ea,D0 in ((0.5,1e-6),(0.6,1e-7),(0.7,1e-7),(0.9,1e-9)):
        v=D0*np.exp(-Ea*e/(kB*T))*e*4*rho0*(1+tc*dT)*(Ic/(0.14e-6*tm))/(kB*T)
        print(f"   T={T:.0f} K I={Ic*1e3:.2f} mA Ea={Ea} D0={D0:.0e}: v={v*1e9:.3g} nm/s ; 0.14 um en {0.14e-6/v:.3g} s ; el paso por 'un átomo' (0.3 nm) dura {0.3e-9/v:.3g} s")
