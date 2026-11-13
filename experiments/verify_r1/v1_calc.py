import numpy as np, scipy.sparse as sp, scipy.sparse.linalg as spl
from scipy.integrate import quad
from scipy.optimize import brentq
q=1.602176634e-19; kB=1.380649e-23; T=300.; kT=kB*T/q; eps=11.7*8.8541878e-14
print("kT",kT)
def F12(eta):  # normalizada: ->exp(eta) en no degenerado
    f=lambda x: np.sqrt(x)/(1+np.exp(x-eta))
    return quad(f,0,max(60,eta+60))[0]*2/np.sqrt(np.pi)
def inv(r): return brentq(lambda e:F12(e)-r,-40,60)
print("F12(0)",F12(0))
def junction(N,Nc=2.8e19,Nv=1.04e19,ni=1e10,Eg=1.12,bgn=0.):
    vb=2*kT*np.log(N/ni)
    xn=kT*inv(N/Nc); xp=kT*inv(N/Nv); vf=Eg-bgn+xn+xp
    out=[]
    for V in (vb,vf):
        W=np.sqrt(4*eps*V/(q*N)); out.append((V,W*1e7,2*V/W/1e6))
    return out,xn,xp
print("== A1")
res={}
for N in (1e19,1e20):
    for bgn in (0,0.1):
        o,xn,xp=junction(N,bgn=bgn); res[(N,bgn)]=o
        print(f"N={N:.0e} bgn={bgn}: Boltz Vbi={o[0][0]:.3f} W={o[0][1]:.2f}nm E={o[0][2]:.2f}MV/cm | FD Vbi={o[1][0]:.3f} W={o[1][1]:.2f} E={o[1][2]:.2f} xi_n={xn*1e3:.0f}meV xi_p={xp*1e3:.0f}meV")
print("== A2")
for Nc in (2.8e19,3.2e19):
    print(f"Nc={Nc:.2e}: n umbral EF=Ec {Nc*F12(0):.2e}; xi=2kT {Nc*F12(2):.2e}")
for Nv in (1.04e19,1.8e19,3.1e19):
    print(f"Nv={Nv:.2e}: p umbral EF=Ev {Nv*F12(0):.2e}; xi=2kT {Nv*F12(2):.2e}")
print("== A3")
for lab,i in (("Boltz",0),("FD",1)):
    for bgn in (0,0.1):
        E19=res[(1e19,bgn)][i][2]*1e6; E20=res[(1e20,bgn)][i][2]*1e6
        for B in (2e7,4e7):
            d=B*(1/E19-1/E20)/np.log(10)
            print(f"{lab} bgn={bgn} B={B:.0e}: Emax -> {d:.2f} decadas; Emedio(Emax/2) -> {2*d:.2f}")
print("== B2/B3 FD 2D")
def grid(lo,hi,fine_lo,fine_hi,hf,g=1.12):
    xs=list(np.arange(fine_lo,fine_hi+hf/2,hf)); h=hf
    while xs[-1]<hi: h*=g; xs.append(min(xs[-1]+h,hi))
    h=hf
    while xs[0]>lo: h*=g; xs.insert(0,max(xs[0]-h,lo))
    return np.array(xs)
def thermal(kox,zb=1.3761e-6,tm=0.36e-6,w=0.14e-6,ztop=11e-6,xmax=30e-6,kal=200.,transient=True):
    hf=0.02e-6
    xe=grid(0,xmax,0,0.3e-6,hf)   # simetria en x=0 ; bordes de celda
    ze=grid(0,ztop,zb-0.2e-6,zb+tm+0.2e-6,hf)
    # ajustar bordes exactos: w/2=0.07 -> usar hf=0.01 en x
    xe=np.unique(np.concatenate([np.arange(0,0.3e-6+1e-12,0.01e-6),xe]))
    ze=np.unique(np.round(np.concatenate([ze,[zb,zb+tm]]),12))
    xc=(xe[1:]+xe[:-1])/2; zc=(ze[1:]+ze[:-1])/2; dx=np.diff(xe); dz=np.diff(ze)
    nx,nz=len(xc),len(zc)
    X,Z=np.meshgrid(xc,zc,indexing='ij')
    met=(X<w/2)&(Z>zb)&(Z<zb+tm)
    k=np.where(met,kal,kox); C=np.where(met,2.42e6,1.6e6)
    idx=np.arange(nx*nz).reshape(nx,nz)
    rows=[];cols=[];vals=[];diag=np.zeros(nx*nz)
    # x faces
    gx=dz[None,:]/(dx[:-1,None]/2/k[:-1,:]+dx[1:,None]/2/k[1:,:])
    a=idx[:-1,:].ravel();b=idx[1:,:].ravel();g=gx.ravel()
    rows+=[a,b];cols+=[b,a];vals+=[-g,-g];np.add.at(diag,a,g);np.add.at(diag,b,g)
    gz=dx[:,None]/(dz[None,:-1]/2/k[:,:-1]+dz[None,1:]/2/k[:,1:])
    a=idx[:,:-1].ravel();b=idx[:,1:].ravel();g=gz.ravel()
    rows+=[a,b];cols+=[b,a];vals+=[-g,-g];np.add.at(diag,a,g);np.add.at(diag,b,g)
    # fondo isotermo z=0
    g0=dx/(dz[0]/2/k[:,0]); np.add.at(diag,idx[:,0],g0)
    A=sp.csc_matrix((np.concatenate(vals+[diag]),(np.concatenate(rows+[np.arange(nx*nz)]),np.concatenate(cols+[np.arange(nx*nz)]))))
    area=dx[:,None]*dz[None,:]
    Q=np.where(met,1.0,0)*area; Q=Q/Q.sum()*0.5  # 1 W/m total, mitad por simetria
    Tss=spl.spsolve(A,Q.ravel()).reshape(nx,nz)
    Rth=(Tss*met*area).sum()/(met*area).sum()   # K por (W/m)
    tau=None
    if transient:
        M=sp.diags((C*area).ravel())
        Tn=np.zeros(nx*nz); t=0; dt=2e-9; lu=spl.splu((M/dt+A).tocsc()); hist=[]
        wm=(met*area).ravel()/(met*area).sum()
        while t<20e-6:
            Tn=lu.solve(M@Tn/dt+Q.ravel()); t+=dt; hist.append((t,wm@Tn))
        hist=np.array(hist); tau=np.interp(0.632*Rth,hist[:,1],hist[:,0]); t90=np.interp(0.9*Rth,hist[:,1],hist[:,0])
        return Rth,tau,t90
    return Rth,None,None
Rl=0.125*10/0.14; I=2.06e-3; P=I*I*Rl; print(f"R linea={Rl:.3f} ohm P={P*1e6:.2f} uW  P/L={P/10e-6:.3f} W/m  J={I/0.14e-6/0.36e-6/1e4/1e6:.2f} MA/cm2 ; I/w={I*1e3/0.14:.1f} mA/um")
for kox in (0.8,1.0,1.1,1.4):
    Rth,tau,t90=thermal(kox)
    dT=P/10e-6*Rth
    # aleta: extremos a T sustrato
    A_al=0.14e-6*0.36e-6; Lh=np.sqrt(200*A_al*Rth); L=10e-6
    fmean=1-np.tanh(L/2/Lh)/(L/2/Lh); fmax=1-1/np.cosh(L/2/Lh)
    alpha=kox/1.6e6; h=1.3761e-6
    print(f"kox={kox}: Rth'={Rth:.3f} K/(W/m) tau63={tau*1e6:.3f} us t90={t90*1e6:.2f} us | dT(2D,sin extremos)={dT:.2f} K; con extremos: media {dT*fmean:.2f} max {dT*fmax:.2f} (L_h={Lh*1e6:.2f} um) | 1D slab tau=4h2/pi2a={4*h*h/np.pi**2/alpha*1e6:.2f} us | cilindro acosh Rth={np.arccosh((h+0.18e-6)/0.125e-6)/(2*np.pi*kox):.3f}")
# sensibilidad a la tapa: ztop
for zt in (5e-6,11e-6,30e-6):
    print("ztop",zt,thermal(1.1,ztop=zt))
# 1D puro (linea ancha): dT = P/(w L) * h / k
print("1D sin dispersion lateral: dT=",P/(0.14e-6*10e-6)*1.3761e-6/1.1,"K")
print("== B5")
f=lambda R,m: {"linR":np.interp(R,[1,10,100],[1.017,1.32,2.2]),
 "logR":np.interp(np.log10(R),[0,1,2],[1.017,1.32,2.2]),
 "pot":1+10**np.interp(np.log10(R),[0,1,2],np.log10([0.017,0.32,1.2]))}[m]
for R in (4.3,6.5,12.9):
    print(R,{m:round(float(f(R,m)),3) for m in ("linR","logR","pot")})
Rs=[0.01,0.1,1,5,10,12.9,15,20,30,100]; Ts=[2.99,2.99,3.04,3.42,3.945,4.195,4.36,4.67,5.25,6.60]
from scipy.interpolate import PchipInterpolator
pc=PchipInterpolator(np.log10(Rs),Ts)
for R in (4.3,6.5,12.9):
    print("tabla sim:",R,"lin",round(np.interp(R,Rs,Ts)/2.99,3),"pchip logR",round(float(pc(np.log10(R)))/2.99,3))
print("== C1")
mu0=4e-7*np.pi
def Bz_poly(pts,z,n=400):
    # campo en (0,0,-z) de un lazo poligonal cerrado en z=0, 1 A
    B=0
    P=np.array(pts+[pts[0]])
    for a,b in zip(P[:-1],P[1:]):
        t=(np.arange(n)+0.5)/n; r=a[None,:]+(b-a)[None,:]*t[:,None]; dl=(b-a)/n
        R=np.array([0,0,-z])[None,:]-np.c_[r,np.zeros(n)]
        cr=np.cross(np.r_[dl,0][None,:],R)
        B+=(cr[:,2]/np.linalg.norm(R,axis=1)**3).sum()
    return mu0/4/np.pi*B
def spiral(rin,w,s,nt,z,shape):
    tot=0; rr=[]
    for i in range(nt):
        a=rin+w/2+i*(w+s); rr.append(a)
        if shape=="sq": tot+=Bz_poly([np.array(p,float) for p in [(a,a),(-a,a),(-a,-a),(a,-a)]],z)
        else: tot+=mu0*a*a/2/(a*a+z*z)**1.5
    return tot, rr
zc=2.7861e-6+0.845e-6/2
for w,s in ((0.3e-6,0.3e-6),(1.5e-6,0.3e-6),(1.47e-6,0.3e-6)):
    for sh in ("sq","circ"):
        for z in (zc,zc-0.2062e-6-0.5e-6,0.0):
            b,rr=spiral(10e-6,w,s,5,z,sh)
            print(f"w={w*1e6} s={s*1e6} {sh} z={z*1e6:.2f}um: {b*1e3*1e-3*1e3:.4f} mT/mA  (radios {rr[0]*1e6:.2f}..{rr[-1]*1e6:.2f}); 2.65 mT requiere {2.65/(b*1e3*1e-3*1e3):.1f} mA")
# espiral real (continua) cuadrada compacta: check
print("== C2", 10/6.8)
print("== C3")
for n in (5e16,5e17):
    for t in (0.5e-4,2e-4):
        print(f"n={n:.0e} t={t*1e4}um: VH={1e-3*2.65e-3/(q*n*1e6*t*1e-2)*1e3:.4f} mV/mA  Rs(mu=800..400)~")
for Rs_,mu in ((950,700),(1700,700),(950,1000),(1700,1000),(950,400),(1700,400)):
    print(f"via Rs={Rs_} mu={mu}: VH={1e-3*2.65e-3*mu*1e-4*Rs_*1e3:.3f} mV/mA")
print("== C5")
I0=14e-9; d=1e-4
print("T =100 q/(d^2 I) =",100*q/(d*d*I0),"s ; sin demod seno: x pi^2/8 =",100*q/(d*d*I0)*np.pi**2/8, " ; ref continua conocida (sin restar): 25q/(d^2 I)*2=", 50*q/(d*d*I0))
