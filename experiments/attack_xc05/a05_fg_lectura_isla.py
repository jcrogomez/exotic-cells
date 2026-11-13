"""a05 (f) lectura con el anillo y (g) isla de Coulomb.
(f) Puntos del lector (05_exotic_lab/macros/constriccion/LEEME.md, corrida ngspice del laboratorio, 'sim/efld00_lector_drivers.txt'):
    período 2.99 ns con 10 Ohm; +1.7 % a 1 kOhm; +32 % a 10 kOhm; x2.2 a 100 kOhm; x3.1 a 1 MOhm. Interpolación PCHIP en log10(R) (supuesto mío)."""
import numpy as np
from scipy.interpolate import PchipInterpolator
h=6.62607015e-34; e=1.602176634e-19; kB=1.380649e-23; eps0=8.8541878128e-12
R0=h/(2*e*e)
f=PchipInterpolator(np.log10([10,1e3,1e4,1e5,1e6]),[1.0,1.017,1.32,2.2,3.1])
T0=2.99
print("(f) período del anillo frente a R en serie (interpolado):")
Rs=[('3 canales',R0/3),('2 canales',R0/2),('1 canal 1.0 G0',R0),('Al 0.8 G0',R0/0.8),('Al 0.6 G0',R0/0.6),('Al 1.1 G0',R0/1.1)]
prev=None
for n,R in Rs:
    r=float(f(np.log10(R))); print(f"  {n:<16} R={R/1e3:6.2f} kOhm  período x{r:.3f} = {T0*r:.3f} ns  pendiente local {float(f.derivative()(np.log10(R)))/(R*np.log(10))*T0*1e6:.0f} ps/kOhm")
a=[float(f(np.log10(R0/k))) for k in (3,2,1)]
print(f"  pasos: 3->2 canales {100*(a[1]-a[0])/a[0]:.1f} % ; 2->1 {100*(a[2]-a[1])/a[1]:.1f} % ; 1.0 G0 -> 0.8 G0 {100*(float(f(np.log10(R0/0.8)))-a[2])/a[2]:.1f} %")
print("  PLAN: 83 ps/kOhm en torno a 12.9 kOhm (corrida del laboratorio); mi interpolación arriba. Resolución de un contador de N ciclos: 1/N; dispersión entre canales [?]")
print("  Con barrera en paralelo R_b: R_tot = R_b || R_c ; diferencia de período entre 1 canal y abierto:")
for Rb in (10,50,150,1e3,1e4):
    r1=float(f(np.log10(Rb*R0/(Rb+R0)))); r0=float(f(np.log10(Rb)))
    print(f"    R_b={Rb:>7.0f} Ohm: {100*(r0-r1)/r1:.4f} %  ({(r0-r1)*T0*1e3:.3f} ps)")
print("  Lectura a baja tensión con resistencia en serie R_s (el contacto ve V = 1.8*R_c/(R_c+R_s) como mucho):")
for Rsr in (0,1e4,3e4,1e5):
    r1=float(f(np.log10(Rsr+R0))); r2=float(f(np.log10(Rsr+R0/2))); rop=float(f(np.log10(max(Rsr,10))))
    print(f"    R_s={Rsr/1e3:>5.0f} kOhm: V_max sobre 12.9k = {1.8*R0/(R0+Rsr):.2f} V ; período 1 canal x{r1:.3f}, 2 canales x{r2:.3f} (dif {100*(r1-r2)/r2:.2f} %) ; I_pico = {1.8/(R0+Rsr)*1e6:.0f} uA")
print("\n(g) isla de Coulomb: C = 4 pi eps0 eps_r r (esfera aislada en dieléctrico infinito, cota inferior de C_sigma); E_C = e^2/2C")
for r,er,n in ((2e-9,3.9,'radio 2 nm, SiO2 (lo que dice XC-06)'),(1e-9,3.9,'radio 1 nm (diámetro 2 nm), SiO2'),(2e-9,9.0,'radio 2 nm, Al2O3 er~9 (de memoria)'),(2e-9,1.0,'radio 2 nm, vacío (hueco de vacío EM)')):
    C=4*np.pi*eps0*er*r; Ec=e*e/(2*C)
    print(f"  {n:<40} C={C*1e18:.3f} aF  E_C={Ec/e*1e3:6.1f} meV  E_C/kT(77K)={Ec/(kB*77):5.1f}  E_C/kT(300K)={Ec/(kB*300):4.1f}")
print("  Con electrodos a ~1 nm (dos uniones): cada unión añade ~ eps0 eps_r A/d con A ~ pi r^2: r=2 nm, d=1 nm, er=3.9 -> %.2f aF por unión -> C_sigma ~ %.2f aF -> E_C ~ %.0f meV (%.1f kT a 77 K)"%(
   eps0*3.9*np.pi*(2e-9)**2/1e-9*1e18, (4*np.pi*eps0*3.9*2e-9+2*eps0*3.9*np.pi*(2e-9)**2/1e-9)*1e18,
   e/(2*(4*np.pi*eps0*3.9*2e-9+2*eps0*3.9*np.pi*(2e-9)**2/1e-9))*1e3, e*e/(2*(4*np.pi*eps0*3.9*2e-9+2*eps0*3.9*np.pi*(2e-9)**2/1e-9))/(kB*77)))
print("  Corriente por una isla con uniones túnel de R_T: I ~ e/(2 R_T C)... orden V/(2R_T): con R_T=1 GOhm y 50 mV -> 25 pA; con barrera de 10-150 Ohm en paralelo la isla lleva < 1e-7 de la corriente: ilegible en met1 con barrera.")
