"""a05 (e): lazo de parada. Modelo JUGUETE (declara su estructura; los números absolutos no valen, vale qué variable manda).
  Estado: R_c (resistencia del cuello/contacto). d ln R_c/dt = nu * exp(-Ea / k T_c).
  T_c: relación tensión-temperatura de una constricción difusiva (Kohlrausch/Holm, DE MEMORIA): T_c^2 = T0^2 + V_c^2/(4 Lz), Lz = 2.44e-8 W.Ohm/K2.
       No depende de la geometría; su constante de tiempo es a^2/alfa_Al (a=10 nm -> ~1 ps) => respuesta térmica instantánea frente a cualquier lazo.
       Por encima de 933 K (V_c > 0.276 V): fundido, ritmo capilar 1/50 ps (cálculo: sqrt(rho a^3/gamma), a=10 nm; supuesto).
       Para R_c >~ 1 kOhm el contacto es balístico y se calienta menos (Yang 2005, LEÍDO: <50 K a 1 V con buen contacto térmico);
       ahí rompe la fuerza de la corriente: probabilidad de formar contacto de un átomo de Al -> 0 a ~0.8-1 V (Mizobata 2003, vía Yang 2005).
       Regla usada en el régimen balístico (R_c > 1 kOhm): si V_c > V_rot (0.8 V) -> abre.
  Circuito: driver = fuente de corriente I_sat hasta que satura contra V0 con R_on;  opcional R_serie, shunt de barrera R_b, o V0 reducida.
  Lazo: cuando R_tot medido >= R_umbral en t*, la corriente se corta en t* + retardo. Resultado: R_c final (tope 1e6 = 'abierto')."""
import numpy as np
kB=8.617333e-5; Lz=2.44e-8; T0=300.0
def Vc_of(Rc,cfg):
    Rb=cfg.get('Rb',np.inf); Rp=Rc*Rb/(Rc+Rb) if np.isfinite(Rb) else Rc
    Rs=cfg.get('Rser',0)+cfg.get('Ron',73.0)
    V=cfg['V0']*Rp/(Rp+Rs)
    Isat=cfg.get('Isat',np.inf)
    return min(V, Isat*Rp), Rp
def rate(V,Rc,Ea,nu=1e13):
    if Rc>1e3:                       # balístico: sin Kohlrausch; rompe por fuerza si V>0.8
        return 2e10 if V>0.8 else nu*np.exp(-Ea/(kB*(T0+50*V)))
    T=np.sqrt(T0*T0+V*V/(4*Lz))
    return 2e10 if T>=933 else nu*np.exp(-Ea/(kB*T))
def run(cfg,Ea,Rth,delay,R0=5.0,tmax=10.0):
    R=R0;t=0;tstar=None
    while t<tmax and R<1e6:
        V,Rp=Vc_of(R,cfg); r=rate(V,R,Ea)
        # v2 (iteración 1 tras ver v1, exploratorio): un cuello difusivo que funde no se detiene en un contacto de pocos canales -> abre
        if R<=1e3 and np.sqrt(T0*T0+V*V/(4*Lz))>=933: return 1e6,t,tstar
        if tstar is None and Rp>=Rth: tstar=t
        dt=min(0.02/r, tmax-t)
        if tstar is not None:
            if t>=tstar+delay: break
            dt=min(dt,tstar+delay-t+1e-15)
        R*=np.exp(r*dt); t+=dt
    return min(R,1e6),t,tstar
delays=[1e-9,1e-7,1e-5,1e-3]
cfgs={
 'driver 2.06 mA / 1.8 V, sin barrera':dict(V0=1.8,Isat=2.06e-3),
 'driver 2.06 mA / 1.8 V, barrera 20 Ohm':dict(V0=1.8,Isat=2.06e-3,Rb=20.0),
 'driver 2.06 mA / 1.8 V, barrera 150 Ohm':dict(V0=1.8,Isat=2.06e-3,Rb=150.0),
 '1.8 V + R serie 1 kOhm':dict(V0=1.8,Rser=1e3),
 '1.8 V + R serie 10 kOhm':dict(V0=1.8,Rser=1e4),
 '1.8 V + R serie 100 kOhm':dict(V0=1.8,Rser=1e5),
 'fuente rígida 0.05 V':dict(V0=0.05,Ron=1.0),
 'fuente rígida 0.10 V':dict(V0=0.10,Ron=1.0),
 'fuente rígida 0.20 V':dict(V0=0.20,Ron=1.0),
 'fuente rígida 0.50 V':dict(V0=0.50,Ron=1.0),
}
print("Tabla Kohlrausch: V_c -> T_c (K): "+", ".join(f"{v} V:{np.sqrt(T0**2+v*v/(4*Lz)):.0f}" for v in (0.02,0.05,0.1,0.2,0.276,0.3,0.5,1.8)))
print("Con fuente de corriente de 2.06 mA la tensión de fusión (0.276 V) se alcanza en R_c = %.0f Ohm (~%d canales); con 0.26 mA en %.0f Ohm"%(0.276/2.06e-3,12906/(0.276/2.06e-3),0.276/0.26e-3))
for Ea in (0.7,1.0):
    for Rth in (30.0,2000.0):
        print(f"\nEa = {Ea} eV ; umbral del lazo R_tot >= {Rth:.0f} Ohm ; R_c final (Ohm) por retardo; 'ABIERTO' = >= 1e6 ; '--' = nunca cruza el umbral en 10 s (R_c a los 10 s)")
        print(f"{'configuración':<42}"+"".join(f"{d:>12.0e}s" for d in delays)+f"{'t* (s)':>12}")
        for n,c in cfgs.items():
            out=[];ts=None
            for d in delays:
                R,t,tstar=run(c,Ea,Rth,d); ts=tstar
                out.append('ABIERTO' if R>=1e6 else (f"{R:.3g}" if tstar is not None else f"--{R:.3g}"))
            print(f"{n:<42}"+"".join(f"{o:>13}" for o in out)+(f"{ts:>12.3g}" if ts is not None else f"{'nunca':>12}"))
print("\nTensión sobre un contacto de 12.9 kOhm (1 canal) y de 4.3 kOhm (3 canales) en cada configuración, y corriente por él:")
for n,c in cfgs.items():
    v1,_=Vc_of(12906.0,c); v3,_=Vc_of(4302.0,c)
    Rb=c.get('Rb',np.inf)
    print(f"  {n:<42} V(12.9k)={v1:6.3f} V  I={v1/12906*1e6:7.1f} uA   V(4.3k)={v3:6.3f} V"+("   (casi toda la corriente va por la barrera)" if np.isfinite(Rb) else ""))
print("\nLectura con el anillo: en cada flanco el nodo excitador salta 1.8 V y la carga (32 puertas) está aún en el valor anterior ->\n  la tensión inicial sobre el contacto en serie es ~1.8 V (decae con R*C). V_rot de un contacto de 1 átomo de Al ~0.8-1 V. La lectura del anillo es destructiva [cálculo; sin SPICE].")
