# v2_calc.py — verificador independiente ronda 2. Código propio (thermal y F12 vienen de mi v1_calc.py).
import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spl, sympy as sy
from scipy.integrate import quad
from scipy.optimize import brentq
q=1.602176634e-19; kB=1.380649e-23; T=300.; kT=kB*T/q; eps=11.7*8.8541878e-14; Eg=1.12
def F12(eta):
    f=lambda x: np.sqrt(x)/(1+np.exp(x-eta))
    return quad(f,0,max(60,eta+60))[0]*2/np.sqrt(np.pi)
def inv(r): return brentq(lambda e:F12(e)-r,-45,80)
# ---------- A: union lateral graduada ----------
def profile(x,Npk,N0,L):  # x en cm; lado n en x<0
    Nd=np.minimum(Npk,N0*10**(-x/L)); Na=np.minimum(Npk,N0*10**(x/L)); return Nd-Na
def solve(Npk,N0,L,VR,Nc=2.8e19,Nv=1.04e19):
    def fields(xd):
        x=np.linspace(-xd,xd,4001); N=profile(x,Npk,N0,L)
        E=q/eps*np.concatenate([[0],np.cumsum((N[1:]+N[:-1])/2*np.diff(x))])
        V=np.trapezoid(E,x); return x,E,V
    Vbi=1.1
    for it in range(8):
        f=lambda xd: fields(xd)[2]-(Vbi+VR)
        xd=brentq(f,1e-9,3e-5)
        Ne=abs(profile(np.array([-xd]),Npk,N0,L)[0])
        xin=kT*inv(Ne/Nc); xip=kT*inv(Ne/Nv); Vbi=Eg+xin+xip
    x,E,V=fields(xd)
    return dict(xd=xd,x=x,E=E,Ne=Ne,xin=xin,xip=xip,Vbi=Vbi,Emax=E.max())
MODELS={"Hurkx/Kane P=2.5 (4e14;1.9e7)":(4e14,2.5,1.9e7),"Schenk-tipo P=2 (3.5e21;2.25e7)":(3.5e21,2.0,2.25e7),"Kane E1 P=1 (1.1e27;2.13e7)":(1.1e27,1.0,2.13e7)}
AREA=1.4e-4*0.1e-4
print("== A1: I inversa BTBT a -1,8 V, frontera 1,4 um x 0,1 um (A)")
allI=[]; Icent=[]
for r0 in (1.0,0.3,0.1):
    for Npk in (5e19,1e20,2e20):
        for L in (10e-7,20e-7,35e-7):
            s=solve(Npk,r0*Npk,L,1.8); row=[]
            for nm,(A,P,B) in MODELS.items():
                G=np.where(s["E"]>1e4,A*np.maximum(s["E"],1e4)**P*np.exp(-B/np.maximum(s["E"],1e4)),0)
                I=q*AREA*np.trapezoid(G,s["x"]); row.append(I); allI.append((I,r0))
            print(f"N0/Npk={r0} Npk={Npk:.0e} L={L*1e7:.0f}nm/dec: W={2*s['xd']*1e7:.1f}nm Emax={s['Emax']/1e6:.2f}MV/cm Nborde={s['Ne']:.1e} | I = "+" ; ".join(f"{i:.2e}" for i in row))
for r0 in (1.0,0.3,0.1):
    v=[i for i,r in allI if r==r0]; print(f"N0/Npk={r0}: intervalo I = {min(v):.1e} .. {max(v):.1e} A")
v=[i for i,r in allI]; print(f"todo: {min(v):.1e} .. {max(v):.1e} A")
print("== A3: equilibrio (V=0). Umbral degeneracion n: Nc*F(0)=%.2e ; p: Nv*F(0)=%.2e (Nv=1.04e19) / %.2e (Nv=3.1e19)"%(2.8e19*F12(0),1.04e19*F12(0),3.1e19*F12(0)))
for r0 in (1.0,0.3,0.1):
    for Npk in (1e20,2e20,3e20):
        for Lnm in (2,3,5,7,10,15,20):
            s=solve(Npk,r0*Npk,Lnm*1e-7,0.0); s2=solve(Npk,r0*Npk,Lnm*1e-7,0.0,Nv=3.1e19)
            A,P,B=MODELS["Hurkx/Kane P=2.5 (4e14;1.9e7)"]
            Em=s["Emax"]; Jsc=q*np.trapezoid(A*np.maximum(s["E"],1e4)**P*np.exp(-B/np.maximum(s["E"],1e4)),s["x"])
            print(f"N0/Npk={r0} Npk={Npk:.0e} L={Lnm}nm/dec: W={2*s['xd']*1e7:.2f}nm Nborde={s['Ne']:.2e} xi_n={s['xin']*1e3:+.0f}meV xi_p={s['xip']*1e3:+.0f}meV (Nv alto: {s2['xip']*1e3:+.0f}) Emax={Em/1e6:.2f}MV/cm w_tunel=Eg/qEmax={Eg/Em*1e7:.1f}nm B/Emax={B/Em:.1f} J_escala(q*int G, sin factor de ocupacion)={Jsc:.2e} A/cm2")
# ---------- B1 ----------
print("== B1: barreras solas, w=0,14 um (ohm/um)")
w=0.14e-4
def Rl(layers): return 1/(w*sum(t*1e-7/(rho*1e-6) for t,rho in layers))*1e-4  # ohm/um
for lab,(rTi,rTiN,rTiW) in {"bajo":(60,50,60),"central":(100,150,80),"alto":(200,400,120),"Ti consumido (TiAl3), central":(1e9,150,80)}.items():
    s1=Rl([(10,rTi),(30,rTiW)]); s2=Rl([(15,rTi),(25,rTiN),(9,rTi),(50,rTiN)])
    Ral=0.125/0.14
    print(f"{lab}: pila Ti/Al/TiW {s1:.0f} ohm/um ; pila Ti/TiN/Al/Ti/TiN {s2:.0f} ohm/um | vacio 24..39 nm: {s1*0.024:.1f}..{s1*0.039:.1f} y {s2*0.024:.1f}..{s2*0.039:.1f} ohm | vacio 100..500 nm: {s1*0.1:.0f}..{s1*0.5:.0f} y {s2*0.1:.0f}..{s2*0.5:.0f} ohm (Al intacto: {Ral:.2f} ohm/um)")
# ---------- B2 ----------
print("== B2: cuello de li")
def grid(lo,hi,fine_lo,fine_hi,hf,g=1.12):
    xs=list(np.arange(fine_lo,fine_hi+hf/2,hf)); h=hf
    while xs[-1]<hi: h*=g; xs.append(min(xs[-1]+h,hi))
    h=hf
    while xs[0]>lo: h*=g; xs.insert(0,max(xs[0]-h,lo))
    return np.array(xs)
def thermal(kox,zb,tm=0.1e-6,w=0.17e-6,ztop=10e-6,xmax=30e-6,kmet=20.):
    xe=grid(0,xmax,0,0.3e-6,0.005e-6); ze=grid(0,ztop,max(zb-0.2e-6,0.02e-6),zb+tm+0.2e-6,0.01e-6)
    ze=np.unique(np.round(np.concatenate([ze,[zb,zb+tm]]),12)); xe=np.unique(np.round(np.concatenate([xe,[w/2]]),12))
    xc=(xe[1:]+xe[:-1])/2; zc=(ze[1:]+ze[:-1])/2; dx=np.diff(xe); dz=np.diff(ze); nx,nz=len(xc),len(zc)
    X,Z=np.meshgrid(xc,zc,indexing='ij'); met=(X<w/2)&(Z>zb)&(Z<zb+tm); k=np.where(met,kmet,kox)
    idx=np.arange(nx*nz).reshape(nx,nz); rows=[];cols=[];vals=[];diag=np.zeros(nx*nz)
    gx=dz[None,:]/(dx[:-1,None]/2/k[:-1,:]+dx[1:,None]/2/k[1:,:]); a=idx[:-1,:].ravel();b=idx[1:,:].ravel();g=gx.ravel()
    rows+=[a,b];cols+=[b,a];vals+=[-g,-g];np.add.at(diag,a,g);np.add.at(diag,b,g)
    gz=dx[:,None]/(dz[None,:-1]/2/k[:,:-1]+dz[None,1:]/2/k[:,1:]); a=idx[:,:-1].ravel();b=idx[:,1:].ravel();g=gz.ravel()
    rows+=[a,b];cols+=[b,a];vals+=[-g,-g];np.add.at(diag,a,g);np.add.at(diag,b,g)
    g0=dx/(dz[0]/2/k[:,0]); np.add.at(diag,idx[:,0],g0)
    n=nx*nz; A=sp.csc_matrix((np.concatenate(vals+[diag]),(np.concatenate(rows+[np.arange(n)]),np.concatenate(cols+[np.arange(n)]))))
    area=dx[:,None]*dz[None,:]; Q=np.where(met,1.0,0)*area; Q=Q/Q.sum()*0.5
    Tss=spl.spsolve(A,Q.ravel()).reshape(nx,nz); return (Tss*met*area).sum()/(met*area).sum()
rng=np.random.default_rng(1)
def green3d(L,w,h,k,n=400000):  # K/W, media sobre el rectangulo; plano isotermo a h por debajo; medio infinito arriba
    p1=rng.random((n,2))*[L,w]; p2=rng.random((n,2))*[L,w]; d=np.linalg.norm(p1-p2,axis=1)
    d=np.maximum(d,1e-10); return (np.mean(1/d)-np.mean(1/np.sqrt(d*d+4*h*h)))/(4*np.pi*k)
Rs=12.8; wl=0.17
RTH={}
for kox in (0.8,1.1,1.4):
    for zb in (0.61e-6,0.73e-6,0.94e-6):
        RTH[(kox,zb)]=thermal(kox,zb)
print("R_th' 2D (K m/W): "+" ; ".join(f"k={k} h={z*1e6:.2f}: {v:.3f}" for (k,z),v in RTH.items()))
rmin,rmax,rc=min(RTH.values()),max(RTH.values()),RTH[(1.1,0.73e-6)]
for L in (1.0,2.0):
    R=Rs*L/wl
    for I in (4.2e-3,7.8e-3):
        P=I*I*R; res=[]
        for rth,kox,zb,ktin in ((rmin,1.4,0.61e-6,30.),(rc,1.1,0.73e-6,20.),(rmax,0.8,0.94e-6,10.)):
            d2=P/(L*1e-6)*rth
            Lh=np.sqrt(ktin*0.17e-6*0.1e-6*rth); xx=L*1e-6/2/Lh
            fmean=1-np.tanh(xx)/xx; fmax=1-1/np.cosh(xx)
            g=green3d(L*1e-6,0.17e-6,zb,kox)*P
            res.append(f"[2D sin extremos {d2:.0f} | aleta, extremos a Tamb: media {d2*fmean:.0f} max {d2*fmax:.0f} | 3D Green media {g:.0f}]")
        print(f"L={L}um R={R:.1f}ohm I={I*1e3}mA: V=IR={I*R:.2f} V (queda {1.8-I*R:.2f} V para los drivers) P={P*1e3:.2f}mW ; dT(K) bajo/central/alto: "+" ".join(res))
    print(f"   L={L}um: corriente maxima absoluta con 1,8 V sobre el tramo solo: {1.8/R*1e3:.1f} mA")
for L in (5.0,10.0):
    R=Rs*L/wl; I=1.8/R; P=1.8*I
    out=[]
    for rth,ktin in ((rmin,30.),(rc,20.),(rmax,10.)):
        d2=P/(L*1e-6)*rth; Lh=np.sqrt(ktin*0.17e-6*0.1e-6*rth); xx=L*1e-6/2/Lh
        out.append(f"{300+d2:.0f} (max con extremos frios {300+d2*(1-1/np.cosh(xx)):.0f})")
    print(f"linea L={L}um R={R:.0f}ohm I(1,8V)={I*1e3:.2f}mA P={P*1e3:.2f}mW: T(K)=300+dT bajo/central/alto: "+" / ".join(out))
# ---------- B3 ----------
print("== B3")
Vth=0.048
for Rref in (100.,1e3,1e4):
    print(f"Rref={Rref:.0f}: V sobre 100 ohm = {Vth*100/(100+Rref)*1e3:.1f} mV ; abierto = {Vth*1e3:.0f} mV ; tau=Rref*50fF = {Rref*50e-15*1e12:.0f} ps (1er orden, sin sobreimpulso)")
for Cn in (1,2,5,15,50,100):
    print(f"C nodo={Cn} fF: divisor capacitivo 1,8*0,2/(0,2+C) = {1.8*0.2/(0.2+Cn)*1e3:.1f} mV -> pico {48+1.8*0.2/(0.2+Cn)*1e3:.0f} mV")
for Rref in (100.,1e3,1e4):
    for tr in (20e-12,100e-12):
        print(f"flanco lento: Rref={Rref:.0f} tr={tr*1e12:.0f}ps: R*Cov*dV/dt = {Rref*0.2e-15*1.8/tr*1e3:.2f} mV (vale si tr >> Rref*Cnodo)")
# ---------- C1 ----------
print("== C1")
mu0=4e-7*np.pi
def Bsq(a,z): return 2*mu0*a*a/(np.pi*(a*a+z*z)*np.sqrt(2*a*a+z*z))
def coil(N,w,ain,s,z3,z4,nf=9):
    tot=0; suma=0
    for k in range(N):
        a=ain+w/2+k*(w+s); suma+=2*a
        for zz in (z3,z4):
            offs=((np.arange(nf)+0.5)/nf-0.5)*w
            tot+=np.mean([Bsq((a+o)*1e-6,zz*1e-6) for o in offs])
    return tot, suma
for lab,(N,w,ain) in {"G3 N=4 w=1,5 a_in=7":(4,1.5,7.0),"N=4 w=1,5 a_in=10":(4,1.5,10.0),"N=6 w=1,5 a_in=7":(6,1.5,7.0),"N=4 w=2,1 a_in=7":(4,2.1,7.0)}.items():
    for z0,zl in ((0.0,"z=0 Magic"),(0.3262,"z=0,3262 (superficie Si)")):
        b,sa=coil(N,w,ain,0.3,3.2086-z0,4.4436-z0)
        for rs in (0.047,0.038,0.056):
            R=8*sa*rs/w; I=2e-3/b
            if rs==0.047 or (lab.startswith("G3") and z0==0): print(f"{lab} {zl} Rs={rs}: {b*1e0:.4f} T/A = mT/mA ; I(2 mT)={I*1e3:.2f} mA ; R={R:.2f} ohm ; P={I*I*R*1e3:.3f} mW")
# ---------- C2, C3, D1 ----------
print("== C2"); 
for mu in (0.01,0.045,0.14): print(f"mu={mu}: (mu B)^2 = {(mu*2e-3)**2:.2e} ; x coef 0,03..1 -> {(mu*2e-3)**2*0.03:.1e}..{(mu*2e-3)**2:.1e}")
print("== C3"); S=np.sqrt(2*q*15e-9); Tint=2**20/10e6
print(f"sqrt(2qI)={S*1e15:.2f} fA/rtHz ; T={Tint:.4f} s ; sigma=S*sqrt(1/(2T))={S*np.sqrt(1/(2*Tint))*1e15:.1f} fA ; con ENBW=1/T: {S*np.sqrt(1/Tint)*1e15:.1f} fA ; densidad equivalente a 150 fA: {150/np.sqrt(1/(2*Tint)):.1f} (ENBW 1/2T) o {150/np.sqrt(1/Tint):.1f} (1/T) fA/rtHz")
print(f"demod 4 estados, cada uno T/4: var(D)=4*S^2/(2*T/4)/16 -> sigma_D={np.sqrt(4*S**2/(2*Tint/4)/16)*1e15:.1f} fA")
print("== C4 (sympy)")
a,b,c,B1,B2,I1,I2,Rr,R1,R2=sy.symbols("a b c B1 B2 I1 I2 Rr R1 R2")
def D(f): return sy.expand((f(1,1)-f(1,-1)-f(-1,1)+f(-1,-1))/4)
print("y=a B^2 :",D(lambda s1,s2:a*(s1*B1+s2*B2)**2)); print("y=c+b B :",D(lambda s1,s2:c+b*(s1*B1+s2*B2)))
print("y=c+bB+aB^2+dB^3:",D(lambda s1,s2:c+b*(s1*B1+s2*B2)+a*(s1*B1+s2*B2)**2+sy.Symbol('d')*(s1*B1+s2*B2)**3))
print("calor con retorno compartido R1 I1^2+R2 I2^2+Rr (s1 I1+s2 I2)^2 :",D(lambda s1,s2:R1*(s1*I1)**2+R2*(s2*I2)**2+Rr*(s1*I1+s2*I2)**2))
print("calor sin retorno compartido:",D(lambda s1,s2:R1*(s1*I1)**2+R2*(s2*I2)**2))
print("== D1")
for C in (1e-15,1e-14,1e-13): print(f"C={C*1e15:.0f} fF: sqrt(kT/C)={np.sqrt(kB*T/C)*1e3:.3f} mV")
v=0.57/0.83*0.305e-3; print(f"piso 0,57 % <-> {v*1e3:.4f} mV ; C=kT/v^2={kB*T/v**2*1e15:.1f} fF")
