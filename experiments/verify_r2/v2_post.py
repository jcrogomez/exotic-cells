# posterior a la lectura de informes: linea de li a 1,8 V con R(T) (tc1rl1, tc2rl1 del PDK), sin resistencia de drivers
from scipy.optimize import brentq
for L,R0 in ((5,376.5),(10,752.9)):
    for lab,rth in (("k1,4 h0,61",0.324),("k1,1 h0,73",0.436),("k0,8 h0,94",0.646)):
        f=lambda d: d-1.8**2/(R0*(1+6.045e-4*d-3.693e-7*d*d))/(L*1e-6)*rth
        d=brentq(f,0,1500); print(f"L={L}um {lab}: T={300+d:.0f} K")
