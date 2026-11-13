"""a05 (a): resistencia del camino paralelo por la barrera sobre un vacío del aluminio en met1.
Datos PDK local (sky130A): magic/sky130A.tech l.5123 resist (allm1)=125 mOhm/sq; l.5122 resist (allli)=12800 mOhm/sq;
l.5056 height allli 0.9361 0.10 ; l.5058 height allm1 1.3761 0.36 ; ngspice r+c.model l.30,32 tc1rl1=6.045e-4, tc1rm1=3.179e-3.
Espesor y material de la barrera de met1: NO están en el PDK local ni en metal_stack.svg de SkyWater -> se barren."""
import itertools
h=6.62607015e-34; e=1.602176634e-19
R0=h/(2*e*e)
print(f"1/G0 = {R0:.1f} Ohm")
rho_m1=0.125*0.36e-6; rho_li=12.8*0.10e-6
print(f"rho efectiva met1 = Rsh*t = {rho_m1*1e8:.2f} uOhm.cm (Al macizo 2.7; de memoria) ; rho li1 (TiN del proceso) = {rho_li*1e8:.0f} uOhm.cm")
w=0.14e-6
print("\nShunt por barrera R_b = rho*L/(w*t_b), w=0.14 um. Barrido: rho 50..400 uOhm.cm (TiN PVD de memoria 50-400; 128 = li1 del PDK; Ti ~ 50-100), t_b total (abajo+arriba) 20..150 nm")
print(f"{'rho uOcm':>9}{'t_b nm':>8}{'Rsh O/sq':>10}" + "".join(f"{'L='+str(L)+'nm':>12}" for L in (10,30,100,1000)))
allv=[]
for rho,tb in itertools.product((50,128,200,400),(20,50,100,150)):
    rsh=rho*1e-8/(tb*1e-9)
    row=[rsh*L*1e-9/w for L in (10,30,100,1000)]
    allv+=row[:3]
    print(f"{rho:>9}{tb:>8}{rsh:>10.1f}"+"".join(f"{r:>12.2f}" for r in row))
print(f"\nRango R_b para L=10..100 nm en todo el barrido: {min(allv):.2f} .. {max(allv):.1f} Ohm")
print("\nQué ve el exterior: R_tot = R_b || (R0/N). Cambio relativo de R_tot al pasar de N a N-1 canales, y respecto a abierto (N=0):")
for Rb in (1,10,50,150):
    s=[]
    for N in (3,2,1,0):
        Rc=R0/N if N else float('inf')
        Rt=Rb if N==0 else Rb*Rc/(Rb+Rc)
        s.append(Rt)
    print(f"  R_b={Rb:>4} Ohm: R_tot(N=3,2,1,0) = "+", ".join(f"{x:.4f}" for x in s)+f" ; escalón N=1->0: {100*(s[3]-s[2])/s[3]:.3f} % ; fracción de corriente por el contacto de 1 canal: {100*Rb/(Rb+R0):.3f} %")
print("\nBarrera necesaria para que R_b >= 12.9 kOhm con L=100 nm, w=0.14um: Rsh_b >= %.0f Ohm/sq ; con rho=128 uOhm.cm -> t_b <= %.3f nm (menos de una monocapa: imposible)"%(R0*w/100e-9, 128e-8/(R0*w/100e-9)*1e9))
print("Largo de vacío para que el shunt sea 1 kOhm (piso del lector) con Rsh_b=25.6 (128 uOcm, 50 nm): L = %.2f um ; para 12.9 kOhm: %.1f um"%(1e3*w/25.6*1e6, R0*w/25.6*1e6))
print("\nTensión máxima sobre el vacío con fuente de corriente (tautología): V = I*R_b")
for I in (0.26e-3,2.06e-3,4.1e-3,18.5e-3):
    print(f"  I={I*1e3:5.2f} mA: "+", ".join(f"R_b={Rb} Ohm -> {I*Rb*1e3:.1f} mV" for Rb in (1,10,50,150)))
print("Potencia en la barrera sobre el vacío P=I^2 R_b (2.06 mA, 50 Ohm) = %.2f mW ; (18.5 mA, 50 Ohm) = %.1f mW"%((2.06e-3)**2*50*1e3,(18.5e-3)**2*50*1e3))
