# cruce posterior a leer a52: reproducir su geometria (semilado MEDIO 10 um, z=2.88 um) con mi Biot-Savart
import numpy as np
mu0=4e-7*np.pi
def sq(a,z):  # lazo cuadrado semilado a, analitico en el eje
    return mu0/(4*np.pi)*8*a*a/((a*a+z*z)*np.sqrt(2*a*a+z*z))
for w in (0.3,1.5,2.1):
    p=w+0.3
    for lab,rs,z in (("medio=10, z=2.88",[10+(i-2)*p for i in range(5)],2.88),("borde interior=10, z=3.21",[10+w/2+i*p for i in range(5)],3.21),("borde interior=10, z=2.88",[10+w/2+i*p for i in range(5)],2.88)):
        b=sum(sq(a*1e-6,z*1e-6) for a in rs)
        print(f"w={w} {lab}: {b:.4f} mT/mA; semilados {rs[0]:.2f}..{rs[-1]:.2f}; campo al limite CC ({6.8*w:.2f} mA) = {b*6.8*w:.2f} mT")
