"""b05 (1): los dos apilamientos de met1 de DATOS_PROCESO. Barrera en paralelo, vacío puenteado, potencia y temperatura del puente.
Datos PDK: met1 0,14 um mín (tlef l.107), 0,125 Ohm/sq (tech l.5123), tc1rm1 3,179e-3 (r+c.model l.32), altura 1,3761 um (tech l.5058).
Apilamientos (leído por agente, DATOS_PROCESO): A = 10 nm Ti / 320 nm AlCu / 30 nm TiW ; B = 15 Ti / 25 TiN / 320 AlCu / 9 Ti / 50 TiN.
Resistividades (uOhm.cm), tres escenarios bajo/nominal/alto:
  TiW 50 / 70 / 150  (50-80 LEIDO en eesemi.com, divulgativa; 150 = margen mío para película de 30 nm, SUPUESTO)
  TiN 50 / 128 / 400 (45-135 NO LEIDO; 128 = li del PDK: 12,8 Ohm/sq x 0,1 um; 400 = margen mío para 25 nm, SUPUESTO)
  Ti  40 / 80 / 200  (NO ENCONTRADO en lectura; 42 masivo DE MEMORIA; SUPUESTO)
Escenario 'Ti consumido': el Ti reaccionó a TiAl3 (reacción LEIDA: Besser et al. MRS 355, 631; patente US6448173) y no puentea el vacío.
Térmica: k de cada barrera = Wiedemann-Franz L0*T/rho (cota baja; x2 como escenario); G' de la sección 2D propia; el vacío no conduce.
TCR de la barrera: 6,045e-4 /K (li del PDK como sustituto, SUPUESTO)."""
import numpy as np, sys
from b05_lib import sec2d, fin1d, L0
w = 0.14e-6
stacks = {
 'A Ti10/AlCu/TiW30': [('Ti', 10e-9), ('TiW', 30e-9)],
 'B Ti15/TiN25/AlCu/Ti9/TiN50': [('Ti', 15e-9), ('TiN', 25e-9), ('Ti', 9e-9), ('TiN', 50e-9)],
}
rho = {'bajo': dict(TiW=50e-8, TiN=50e-8, Ti=40e-8), 'nom': dict(TiW=70e-8, TiN=128e-8, Ti=80e-8), 'alto': dict(TiW=150e-8, TiN=400e-8, Ti=200e-8)}
print("b05_1_met1: barreras en paralelo en línea de met1 de 0,14 um")
g = {}
for kox in (1.4, 1.0):
    r = sec2d(0.14e-6, 0.36e-6, 1.3761e-6, 166, 2.42e6, kox, 17.5e-9)
    g[kox] = r['Gp']
    print(f"  seccion 2D met1 0,14: k_ox={kox}: G'={r['Gp']:.2f} W/mK  t63={r['t63']*1e9:.0f} ns  (ronda 1: 1,8-3,4 W/mK; 0,47-1,25 us)")
def Rp(stack, sc, sinTi=False):
    G = 0; kA = 0
    for m, t in stacks[stack]:
        if sinTi and m == 'Ti': continue
        G += w * t / rho[sc][m]; kA += L0 * 300 / rho[sc][m] * w * t
    return 1 / G, kA   # Ohm/m, W.m/K
print("\n(1a) R' de las barreras en paralelo [Ohm/um] y dR de un vacío de largo Lv [Ohm]")
print(f"{'apilamiento':<30}{'esc':>5}{'Ti?':>10}{'Ohm/um':>9}" + "".join(f"{l:>8}nm" for l in (10, 30, 100, 300, 1000)) + f"{'Lv para 1k':>12}{'12,9k':>9}")
for st in stacks:
    for sc in rho:
        for sinTi in (False, True):
            r, _ = Rp(st, sc, sinTi)
            print(f"{st:<30}{sc:>5}{'consumido' if sinTi else 'presente':>10}{r*1e-6:>9.1f}" + "".join(f"{r*l*1e-9:>10.1f}" for l in (10, 30, 100, 300, 1000)) + f"{1e3/r*1e6:>10.1f}um{12906/r*1e6:>7.0f}um")
print("  Comparar: Al 0,125 Ohm/sq / 0,14 um = 0,89 Ohm/um. La línea virgen de 10 um vale 8,9 Ohm.")

print("\n(1b) Puente de barrera con vacío en el centro de una línea de 10 um: V sobre el vacío, P en el puente, T máx (T0=300 K).")
print("     Aleta 1D: Al a ambos lados (k=166), vacío = solo barrera (k Wiedemann-Franz x fk), G' 2D al óxido (x fG en el vacío).")
print("     Referencias de temperatura (DE MEMORIA): 933 K funde Al; ~700-750 K reacción Ti/Al y límite de proceso; 1941 K funde Ti; ~3200 K TiN.")
print("     Tao-Cheung-Hu 1996 (resumen LEIDO por agente): vida de 10 años del TiN si su punto caliente < ~408 C (681 K).")
aAl = 3.179e-3; ab = 6.045e-4
def run(st, sc, sinTi, Lv, I, kox=1.4, fk=1.0, fG=1.0):
    r, kA = Rp(st, sc, sinTi)
    Al = dict(L=(10e-6 - Lv) / 2, kA=166 * w * 0.32e-6, Gp=g[kox], r0=0.125 / w, a1=aAl)
    V = dict(L=Lv, kA=kA * fk, Gp=g[kox] * fG, r0=r, a1=ab)
    dx = min(5e-9, Lv / 10)
    # malla gruesa en Al, fina en el vacío: tres segmentos con dx común limitado
    dx = max(dx, 1e-9)
    res = fin1d([Al, V, Al], I=I, dx=dx)
    return res, r * Lv
Is = (0.26e-3, 2.06e-3, 4.1e-3, 18.5e-3)
print(f"{'apilamiento':<30}{'esc':>5}{'Ti':>6}{'Lv nm':>7}{'dR0':>8}" + "".join(f"{'T@'+format(I*1e3,'.2f')+'mA':>12}{'V mV':>7}" for I in Is))
store = {}
for st in stacks:
    for sc, sinTi in (('bajo', False), ('nom', False), ('nom', True), ('alto', True)):
        for Lv in (10e-9, 30e-9, 100e-9, 300e-9, 1000e-9):
            row = []
            for I in Is:
                res, dR = run(st, sc, sinTi, Lv, I)
                Tm = 300 + res['dTmax']; row.append((Tm, I * dR * 1e3)); store[(st, sc, sinTi, Lv, I)] = Tm
            print(f"{st:<30}{sc:>5}{'no' if sinTi else 'si':>6}{Lv*1e9:>7.0f}{dR:>8.1f}" + "".join(f"{(f'{T:.0f}K' if np.isfinite(T) and T<1e4 else '>1e4K'):>12}{V:>7.0f}" for T, V in row))
print("  (línea virgen sin vacío a 18,5 mA: ", end="")
res = fin1d([dict(L=10e-6, kA=166 * w * 0.32e-6, Gp=g[1.4], r0=0.125 / w, a1=aAl)], I=18.5e-3, dx=5e-9); print(f"T máx = {300+res['dTmax']:.0f} K)")

print("\n(1c) Sensibilidad térmica, apilamiento A nominal con Ti, Lv = 100 nm, 18,5 mA y 2,06 mA: k de barrera x2, G' en el vacío x0,5, k_ox 1,0")
for lab, kw in (('base', {}), ('k barrera x2', dict(fk=2)), ("G' vacío x0,5", dict(fG=0.5)), ('k_ox 1,0', dict(kox=1.0))):
    a, _ = run('A Ti10/AlCu/TiW30', 'nom', False, 100e-9, 18.5e-3, **kw); b, _ = run('A Ti10/AlCu/TiW30', 'nom', False, 100e-9, 2.06e-3, **kw)
    print(f"  {lab:<16} T(18,5 mA) = {300+a['dTmax']:.0f} K   T(2,06 mA) = {300+b['dTmax']:.1f} K")

print("\n(1d) Largo máximo de vacío que el puente aguanta bajo T_lim (bisección), por corriente. '>3000' = no llega a T_lim con 3 um de vacío.")
print(f"{'apilamiento':<30}{'esc':>5}{'Ti':>4}{'T_lim':>7}" + "".join(f"{I*1e3:>9.2f}mA" for I in Is))
for st in stacks:
    for sc, sinTi in (('bajo', False), ('nom', False), ('alto', True)):
        for Tl in (681, 933, 1941):
            out = []
            for I in Is:
                if run(st, sc, sinTi, 3e-6, I)[0]['dTmax'] + 300 < Tl: out.append('>3000'); continue
                if run(st, sc, sinTi, 5e-9, I)[0]['dTmax'] + 300 > Tl: out.append('<5'); continue
                lo, hi = 5e-9, 3e-6
                for _ in range(22):
                    mid = (lo * hi) ** 0.5
                    if run(st, sc, sinTi, mid, I)[0]['dTmax'] + 300 > Tl: hi = mid
                    else: lo = mid
                out.append(f"{lo*1e9:.0f}")
            print(f"{st:<30}{sc:>5}{'no' if sinTi else 'si':>4}{Tl:>6}K" + "".join(f"{o:>9}nm" for o in out))

print("\n(1e) Firma frente a una resistencia normal: coeficiente térmico efectivo de la línea de 10 um con un vacío puenteado (cálculo)")
print("     TCR_ef = (R_Al*3,179e-3 + dR*a_b)/(R_Al+dR), a_b = 6,0e-4 (SUPUESTO: li del PDK). Línea virgen: 3,18e-3 /K")
for dR in (1, 3, 10, 30, 100, 300):
    print(f"   dR = {dR:>4} Ohm -> R = {8.93+dR:6.1f} Ohm, TCR_ef = {(8.93*aAl+dR*ab)/(8.93+dR)*1e3:.2f}e-3 /K")
