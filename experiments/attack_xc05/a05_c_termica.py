"""a05 (c): térmica propia.
Parte 1: sección 2D (diferencias finitas, Euler implícito) de una línea de met1 enterrada en óxido sobre silicio isotermo.
  Geometría PDK local: sky130A.tech l.5058 'height allm1 1.3761 0.36' (fondo de met1 a 1,376 um del sustrato, espesor 0,36).
  Supuestos: sustrato de Si isotermo en y=0 (k_Si >> k_ox); todo dieléctrico = SiO2 con k_ox barrido 1.0/1.4 W/mK (de memoria: 1.0-1.4);
  sin otros metales vecinos (peor caso: los vecinos enfrían más); techo adiabático a 6 um; pared lateral adiabática a 8 um.
  c_ox = 1.65e6 J/m3K, c_Al = 2.42e6 J/m3K (de memoria). k_Al barrido 100/166/237 (166 = Wiedemann-Franz con rho PDK 4.5 uOhm.cm).
Parte 2: aleta 1D a lo largo de la línea con ancho variable, G'(w) de la parte 1, R'(T) con tc1rm1 del PDK.
  Extremos a T0 (cabezas anchas con contactos). La capacidad por largo se acota: solo Al (cota baja de tau) y C'_ef = tau63_2D*G' (cota alta)."""
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spl, sys
h=25e-9
c_ox=1.65e6; c_al=2.42e6
def sec2d(w_half_cells, k_ox, k_al, transient=True, X=8e-6, Y=6e-6):
    nx=int(X/h); ny=int(Y/h)
    j0=int(round(1.375e-6/h)); j1=j0+int(round(0.35e-6/h))   # celdas en y de la línea
    k=np.full((ny,nx),k_ox); c=np.full((ny,nx),c_ox)
    k[j0:j1,:w_half_cells]=k_al; c[j0:j1,:w_half_cells]=c_al
    src=np.zeros((ny,nx)); A=(j1-j0)*w_half_cells*h*h
    src[j0:j1,:w_half_cells]=0.5/A      # 1 W/m total (media sección = 0.5 W/m) -> W/m3
    idx=np.arange(nx*ny).reshape(ny,nx)
    rows=[];cols=[];vals=[];diag=np.zeros(nx*ny)
    # conductancias entre celdas (media armónica), por unidad de largo: k*h/h = k
    kx=2*k[:,:-1]*k[:,1:]/(k[:,:-1]+k[:,1:]); ky=2*k[:-1,:]*k[1:,:]/(k[:-1,:]+k[1:,:])
    a=idx[:,:-1].ravel(); b=idx[:,1:].ravel(); g=kx.ravel()
    rows+=[a,b]; cols+=[b,a]; vals+=[-g,-g]; np.add.at(diag,a,g); np.add.at(diag,b,g)
    a=idx[:-1,:].ravel(); b=idx[1:,:].ravel(); g=ky.ravel()
    rows+=[a,b]; cols+=[b,a]; vals+=[-g,-g]; np.add.at(diag,a,g); np.add.at(diag,b,g)
    diag[idx[0,:]]+=2*k[0,:]            # fondo isotermo (media celda)
    K=sp.csc_matrix((np.concatenate(vals+[diag]),(np.concatenate(rows+[np.arange(nx*ny)]),np.concatenate(cols+[np.arange(nx*ny)]))))
    q=(src*h*h).ravel()
    Tss=spl.spsolve(K,q)
    line=idx[j0:j1,:w_half_cells].ravel()
    dT=Tss[line].mean()                  # K por (W/m)
    Gp=1.0/dT
    out={'Gp':Gp}
    if transient:
        C=(c*h*h).ravel()
        T=np.zeros(nx*ny); t=0; dt=0.2e-9; ts=[0];Ts=[0]
        while t<200e-6:
            lu=spl.splu((sp.diags(C/dt)+K).tocsc())
            for _ in range(6):
                T=lu.solve(C/dt*T+q); t+=dt; ts.append(t); Ts.append(T[line].mean()/dT)
            dt*=1.5
        ts=np.array(ts);Ts=np.array(Ts)
        for f in (0.5,0.632,0.9): out[f't{int(f*100)}']=np.interp(f,Ts,ts)
        out['curve']=(ts,Ts)
    return out
print("PARTE 1: sección 2D. G' = W/(m.K) de la línea al sustrato; tiempos de subida de la temperatura media de la línea (escalón de potencia)")
print(f"{'w um':>6}{'k_ox':>6}{'k_Al':>6}{'G_W/mK':>9}{'t50 ns':>10}{'t63 ns':>10}{'t90 ns':>10}{'C_Al/G ns':>11}")
G={}
for wc,kox,kal in ((1,1.4,166),(3,1.4,166),(3,1.0,166),(3,1.4,100),(3,1.4,237),(10,1.4,166),(10,1.0,166),(1,1.0,166)):
    r=sec2d(wc,kox,kal)
    w=2*wc*h
    G[(wc,kox)]=(r['Gp'],r['t63'])
    print(f"{w*1e6:>6.2f}{kox:>6.1f}{kal:>6.0f}{r['Gp']:>9.3f}{r['t50']*1e9:>10.1f}{r['t63']*1e9:>10.1f}{r['t90']*1e9:>10.1f}{c_al*w*0.35e-6/r['Gp']*1e9:>11.1f}")
    if (wc,kox,kal)==(3,1.4,166):
        ts,Ts=r['curve']
        print("   curva T(t)/T_inf para w=0.15,k_ox=1.4: "+", ".join(f"{t*1e9:.3g}ns:{np.interp(t,ts,Ts):.2f}" for t in (1e-9,3e-9,1e-8,3e-8,1e-7,3e-7,1e-6,3e-6,1e-5,1e-4)))
print("  (PLAN: 'L^2/alfa sobre 100 nm de óxido ~10 ns'. alfa_ox=k/c=%.2e m2/s; (0.1um)^2/alfa=%.1f ns; (1.376um)^2/alfa=%.0f ns)"%(1.4/c_ox,(1e-7)**2/(1.4/c_ox)*1e9,(1.376e-6)**2/(1.4/c_ox)*1e9))

# ---------------- PARTE 2: aleta 1D
Rsh=0.125; alpha=3.179e-3; tm=0.35e-6
def Gp_of_w(w,kox):
    ws=np.array([0.05,0.15,0.5])*1e-6; gs=np.array([G[(1,kox)][0],G[(3,kox)][0],G[(10,kox)][0]])
    return np.interp(np.log(w),np.log(ws),gs)
def tau_of_w(w,kox):
    ws=np.array([0.05,0.15,0.5])*1e-6; gs=np.array([G[(1,kox)][1],G[(3,kox)][1],G[(10,kox)][1]])
    return np.interp(np.log(w),np.log(ws),gs)
def fin(wfun,L,I,kox=1.4,kal=166,dx=5e-9,transient=False,cap='Al'):
    n=int(round(L/dx)); x=(np.arange(n)+0.5)*dx; w=np.array([wfun(xx) for xx in x])
    A=w*tm; gp=np.array([Gp_of_w(ww,kox) for ww in w])
    r0=Rsh/w                       # Ohm/m
    ka=kal*A; kf=2*ka[:-1]*ka[1:]/(ka[:-1]+ka[1:])/dx
    main=np.zeros(n); main[:-1]+=kf; main[1:]+=kf; main[0]+=2*ka[0]/dx; main[-1]+=2*ka[-1]/dx
    T=np.zeros(n)
    for it in range(200):
        M=sp.diags([main+gp*dx-I*I*r0*alpha*dx,-kf,-kf],[0,-1,1]).tocsc()
        Tn=spl.spsolve(M,I*I*r0*dx*np.ones(n))
        if np.any(Tn<0) or Tn.max()>5000: return dict(dTmax=np.inf,x=x,T=Tn,R=np.nan)
        if abs(Tn-T).max()<1e-6: T=Tn;break
        T=Tn
    res=dict(dTmax=T.max(),x=x,T=T,R=(r0*(1+alpha*T)*dx).sum(),R0=(r0*dx).sum())
    if transient:
        if cap=='Al': C=c_al*A*dx
        else: C=np.array([tau_of_w(ww,kox)*Gp_of_w(ww,kox) for ww in w])*dx
        M0=sp.diags([main+gp*dx-I*I*r0*alpha*dx,-kf,-kf],[0,-1,1]).tocsc()
        q=I*I*r0*dx*np.ones(n); Tt=np.zeros(n); t=0; dt=1e-12; i=np.argmax(T); ts=[0];Ts=[0]
        while Ts[-1]<0.95*T[i] and t<1e-3:
            lu=spl.splu((sp.diags(C/dt)+M0).tocsc())
            for _ in range(8):
                Tt=lu.solve(C/dt*Tt+q); t+=dt; ts.append(t);Ts.append(Tt[i])
            dt*=1.4
        res['t63']=np.interp(0.632*T[i],Ts,ts)
    return res
geoms={
 'A: linea 0.14 x 10 um (EFLD-01 A)': (lambda x:0.14e-6, 10e-6),
 'B: 0.50 con cuello 0.14 x 1 um': (lambda x:0.14e-6 if 4.5e-6<=x<5.5e-6 else 0.5e-6, 10e-6),
 'cuello corto 0.14 x 0.30 en 0.50': (lambda x:0.14e-6 if 4.85e-6<=x<5.15e-6 else 0.5e-6, 10e-6),
 'cuello sublito 0.10 x 0.30 en 0.50': (lambda x:0.10e-6 if 4.85e-6<=x<5.15e-6 else 0.5e-6, 10e-6),
 'puente 0.05 x 0.05 entre lineas 0.14': (lambda x:0.05e-6 if 4.975e-6<=x<5.025e-6 else 0.14e-6, 10e-6),
 'puente 0.05 x 0.05 entre lineas 0.50': (lambda x:0.05e-6 if 4.975e-6<=x<5.025e-6 else 0.5e-6, 10e-6),
}
print("\nPARTE 2: aleta 1D. dT_max (K) en estado estacionario frente a corriente; 'inf' = embalamiento térmico (I^2 R' alfa > pérdidas)")
Is=[0.26e-3,2.06e-3,4.1e-3,9.4e-3,18.5e-3,30e-3]
print(f"{'geometria':<40}{'k_ox':>5}{'k_Al':>5}{'R0 Ohm':>8}"+"".join(f"{I*1e3:>9.2f}mA" for I in Is)+f"{'j(2.06mA) A/cm2':>17}")
for name,(wf,L) in geoms.items():
    for kox,kal in ((1.4,166),(1.0,100),(1.4,237)):
        row=[fin(wf,L,I,kox,kal) for I in Is]
        wmin=min(wf(x) for x in np.linspace(0,L,4001))
        print(f"{name:<40}{kox:>5.1f}{kal:>5.0f}{row[0]['R0']:>8.2f}"+"".join(f"{r['dTmax']:>11.2f}" for r in row)+f"{2.06e-3/(wmin*tm)/1e4:>17.2e}")
print("\nConstante de tiempo (t63 del punto más caliente, escalón de 2.06 mA), k_ox=1.4, k_Al=166: cota baja (solo capacidad del Al) y cota alta (C' efectiva de la sección 2D)")
for name,(wf,L) in geoms.items():
    a=fin(wf,L,2.06e-3,transient=True,cap='Al'); b=fin(wf,L,2.06e-3,transient=True,cap='ef')
    print(f"  {name:<40} t63 = {a['t63']*1e9:8.2f} ns .. {b['t63']*1e9:8.1f} ns   (dT={a['dTmax']:.2f} K)")
print("\nCorriente para dT_max = 100 K y para llegar a fusión del Al (dT=633 K), k_ox=1.4,k_Al=166 (bisección):")
for name,(wf,L) in geoms.items():
    out=[]
    for target in (100,633):
        lo,hi=1e-4,0.2
        for _ in range(40):
            mid=(lo*hi)**0.5
            if fin(wf,L,mid,dx=10e-9)['dTmax']>target: hi=mid
            else: lo=mid
        out.append(lo)
    wmin=min(wf(x) for x in np.linspace(0,L,4001))
    print(f"  {name:<40} I(100K)={out[0]*1e3:6.1f} mA  I(fusión)={out[1]*1e3:6.1f} mA  j(fusión)={out[1]/(wmin*tm)/1e4:.2e} A/cm2 ; ebufn_4 x8 = 2.06 mA ; buf_16 x8 = 18.5 mA (LEEME constricción)")
