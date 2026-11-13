"""c57_3: variante que apareció al leer: el Peltier en los CONTACTOS de una difusión p+ (el par de 750 uV/K es poly n / p+ activa).
El calor Peltier se deposita en el silicio, junto al termómetro MOS. Fuente puntual sobre semiespacio: dT(r) = Q/(2 pi k r).
S(p+ activa) = +430..450 uV/K (Akin 1998 / Olgun 1997: NO LEÍDO / leído-resumen por agente); Rc = 585 ohm (sky130A.tech l. 5131);
k_si = 150. Supuesto: S del lado metálico (li/W) ~ 0; S de la p+ de SKY130 igual a la de Akin (proceso distinto: barrer 200-450)."""
import numpy as np
out = []; P = out.append
P("# S uV/K | I uA | Q_Peltier uW | Q_Joule contacto uW | impar a r=0.5 um mK | par mK | neto mK | señal lector % (5.2 %/K) | t 5 sigma s")
for S in (200e-6, 440e-6):
    for I in (30e-6, 110e-6, 300e-6, 1e-3):
        qp = S*300*I; qj = I*I*585
        k = 1/(2*np.pi*150*0.5e-6)
        odd = qp*k*1e3; ev = qj*k*1e3; sig = odd*1e-3*5.2
        N = 2*(5*0.55/sig)**2
        P(f"{S*1e6:.0f} | {I*1e6:.0f} | {qp*1e6:.2f} | {qj*1e6:.2f} | {odd:.1f} | {ev:.1f} | {ev-odd:+.1f} | {sig:.3f} | {N*0.18e-3:.3g}")
P("# I máx con enfriamiento neto = S*T/Rc: %.0f uA (S=440) ; %.0f uA (S=200). El Joule del cuerpo de la difusión (197 ohm/sq) se reparte a lo largo y no está incluido." % (440e-6*300/585*1e6, 200e-6*300/585*1e6))
open("c57_3_difusion.txt", "w").write("\n".join(out)+"\n"); print("\n".join(out))
