"""b05 (2): línea y cuello de interconexión local (TiN) bajo corriente.
PDK: li 12,8 Ohm/sq (tech l.5122; ngspice rl1=12,2), 0,10 um de espesor a 0,9361 um del sustrato (tech l.5056), ancho mín 0,17 (tlef l.71),
tc1rl1=6,045e-4, tc2rl1=-3,693e-7 (r+c.model l.30-31; extrapolados fuera de su rango de ajuste: SUPUESTO).
Supuestos barridos: k_TiN 5,7 (Wiedemann-Franz con 128 uOhm.cm) / 15 / 30 W/mK (DE MEMORIA el rango); c_TiN 3,2e6 J/m3K (DE MEMORIA);
k_ox 1,0 / 1,4. Driver: N ebufn_4, I = min(N*0,257 mA, 1,8/(R + 2,7k/N)) ajustado a la tabla ngspice de EFLD-00
(efld00_lector_drivers.txt: 8 ebufn_8 con 1 kOhm dan 1,542 mA; el modelo da 1,54)."""
import numpy as np
from b05_lib import sec2d, fin1d
print("b05_2_li: TiN de interconexión local")
G = {}
for w in (0.17e-6, 0.51e-6):
    for kox in (1.4, 1.0):
        r = sec2d(w, 0.10e-6, 0.9361e-6, 15, 3.2e6, kox, 17e-9)
        G[(round(w * 1e6, 2), kox)] = r['Gp']
        print(f"  seccion 2D li w={w*1e6:.2f}: k_ox={kox}: G'={r['Gp']:.2f} W/mK  t50={r['t50']*1e9:.0f} ns t63={r['t63']*1e9:.0f} ns t90={r['t90']*1e9:.0f} ns")
Rsh = 12.8; t = 0.10e-6; a1 = 6.045e-4; a2 = -3.693e-7
def seg(L, w, kox, kT, tcr='pdk'):
    return dict(L=L, kA=kT * w * t, Gp=G[(round(w * 1e6, 2), kox)], r0=Rsh / w, a1=a1 if tcr == 'pdk' else 1.4e-3, a2=a2 if tcr == 'pdk' else 0)
geoms = {
 'linea 0,17 x 10 um': lambda kox, kT, tc: [seg(10e-6, 0.17e-6, kox, kT, tc)],
 'linea 0,17 x 5 um': lambda kox, kT, tc: [seg(5e-6, 0.17e-6, kox, kT, tc)],
 'linea 0,17 x 2 um': lambda kox, kT, tc: [seg(2e-6, 0.17e-6, kox, kT, tc)],
 'cuello 0,17x1,0 entre 0,51 (2x2um)': lambda kox, kT, tc: [seg(2e-6, 0.51e-6, kox, kT, tc), seg(1e-6, 0.17e-6, kox, kT, tc), seg(2e-6, 0.51e-6, kox, kT, tc)],
 'cuello 0,17x0,34 entre 0,51 (2x2um)': lambda kox, kT, tc: [seg(2e-6, 0.51e-6, kox, kT, tc), seg(0.34e-6, 0.17e-6, kox, kT, tc), seg(2e-6, 0.51e-6, kox, kT, tc)],
}
print("\n(2a) Corriente fija: dT máx [K] (extremos a 300 K). j(2,06 mA) = %.2e A/cm2 en 0,17x0,10" % (2.06e-3 / (0.17e-4 * 0.10e-4)))
Is = (0.26e-3, 1.03e-3, 2.06e-3, 4.1e-3, 8.2e-3)
print(f"{'geometria':<38}{'k_ox':>5}{'k_TiN':>6}{'TCR':>5}{'R0':>7}" + "".join(f"{I*1e3:>8.2f}mA" for I in Is))
for name, gf in geoms.items():
    for kox, kT, tc in ((1.4, 15, 'pdk'), (1.0, 5.7, 'pdk'), (1.4, 30, 'pdk'), (1.4, 15, 'cre')):
        row = [fin1d(gf(kox, kT, tc), I=I, dx=10e-9) for I in Is]
        print(f"{name:<38}{kox:>5.1f}{kT:>6.1f}{tc:>5}{row[0]['R0']:>7.0f}" + "".join(f"{r['dTmax']:>10.0f}" for r in row))
print("  ('TCR cre' = 1,4e-3 /K lineal, TiN denso de Creemer 2008, LEIDO por agente; 'pdk' = tc1/tc2 del PDK)")

print("\n(2b) Con el driver real (N ebufn_4 por lado, 1,8 V): corriente, tensión sobre la línea, dT máx, T máx. k_ox 1,4, k_TiN 15, TCR pdk")
print(f"{'geometria':<38}" + "".join(f"{'N='+str(N):>26}" for N in (8, 16, 32, 64)))
for name, gf in geoms.items():
    out = []
    for N in (8, 16, 32, 64):
        r = fin1d(gf(1.4, 15, 'pdk'), drv=(N * 0.257e-3, 2700 / N), dx=10e-9)
        out.append(f"{r['I']*1e3:5.2f}mA {r['V']:4.2f}V {300+r['dTmax']:5.0f}K")
    print(f"{name:<38}" + "".join(f"{o:>26}" for o in out))
print("  Igual con el peor caso térmico (k_ox 1,0, k_TiN 5,7):")
for name, gf in geoms.items():
    out = []
    for N in (8, 16, 32, 64):
        r = fin1d(gf(1.0, 5.7, 'pdk'), drv=(N * 0.257e-3, 2700 / N), dx=10e-9)
        out.append(f"{r['I']*1e3:5.2f}mA {r['V']:4.2f}V {300+r['dTmax']:5.0f}K")
    print(f"{name:<38}" + "".join(f"{o:>26}" for o in out))

print("\n(2c) Corriente para alcanzar T máx = 673 K (oxidación de TiN expuesto, NO LEIDO: 400-450 C), 993 K (720 C: fallo del calefactor de")
print("     Creemer, LEIDO), 1073 K (800 C: 'TiN should work up to', LEIDO), 1900 K (funde el SiO2 vecino: Yin 2006, LEIDO), y N de ebufn_4 y tensión.")
for name, gf in geoms.items():
    for kox, kT in ((1.4, 15), (1.0, 5.7), (1.4, 30)):
        s = f"{name:<38} k_ox {kox} k_TiN {kT:>4}: "
        for Tl in (673, 993, 1073, 1900):
            lo, hi = 1e-4, 0.1
            for _ in range(30):
                mid = (lo * hi) ** 0.5
                if fin1d(gf(kox, kT, 'pdk'), I=mid, dx=10e-9)['dTmax'] + 300 > Tl: hi = mid
                else: lo = mid
            r = fin1d(gf(kox, kT, 'pdk'), I=lo, dx=10e-9)
            s += f" {Tl}K: {lo*1e3:4.1f}mA/{r['V']:4.2f}V/N>={int(np.ceil(lo/0.257e-3))}{'(!V)' if r['V'] > 1.6 else ''} ;"
        print(s)
print("  '(!V)': la tensión sobre la línea supera ~1,6 V: no alcanzable con drivers de 1,8 V por muchos que se pongan.")
