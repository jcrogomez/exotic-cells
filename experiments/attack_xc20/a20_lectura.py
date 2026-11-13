"""a20_lectura: (e) que corriente y que relacion pico/valle (PVR) necesita un par en serie para ser biestable y leerse.
Toma la curva de tunel de una celda del mapa (argumentos: Np G d r), le suma difusion (PDK) y una corriente de exceso
parametrica J_ex = k * J_pico * (exp(V/Vx) - 1), Vx = 0.12 V (forma supuesta; k se barre para recorrer el PVR).
Uso: python a20_lectura.py 1e20 5 0 2 > a20_lectura.txt"""
import sys, subprocess
import numpy as np
import a20_lib as L

Np, G, d, r = (float(a) for a in (sys.argv[1:5] if len(sys.argv) > 4 else ("1e20", "5", "0", "2")))
print(subprocess.check_output(["date"]).decode().strip())
AB = 1.4e-4 * 0.12e-4
JS, NID, kT = 2.1483e-9, 1.3632, L.kB * 300
half = abs(d) * 1e-7 / 2 + 6 * G * 1e-7 + 60e-7
x = np.arange(-half, half, 0.1e-7)
Na, Nd = L.profile(x, Np, r * Np, G * 1e-7, d * 1e-7, 6e16)
j = L.Junction(x, Na, Nd)
Vs = np.concatenate([np.arange(0, 0.2, 0.01), np.arange(0.2, 0.701, 0.025)])
Jt = []
for V in Vs:
    j.solve(V)
    Jt.append(-j.tunnel()[0])
Jt = np.array(Jt)
ip = int(np.argmax(Jt))
Jpk, Vpk = Jt[ip], Vs[ip]
print("Celda Np=%.0e G=%g nm/dec d=%g nm r=%g: J_pico(tunel) = %.3e A/cm2 a %.2f V -> I_pico = %.3e A en %.2e cm2"
      % (Np, G, d, r, Jpk, Vpk, Jpk * AB, AB))
print("I_pico / piso del lector (150 fA) = %.1e" % (Jpk * AB / 150e-15))
Vf = np.linspace(0, 0.7, 1401)
Jtf = np.interp(Vf, Vs, Jt)
Jd = JS * (np.exp(Vf / (NID * kT)) - 1)

def curve(k, scale=1.0, Vx=0.12):
    return scale * Jtf + k * Jpk * (np.exp(Vf / Vx) - 1) + Jd

def pvr(J):
    # primer maximo local y minimo posterior (corregido: la version anterior tomaba el maximo global en 0-0.3 V)
    dJ = np.diff(J)
    up = np.where((dJ[:-1] > 0) & (dJ[1:] <= 0))[0]
    if len(up) == 0:
        return 1.0, float("nan"), float("nan")
    i = up[0] + 1
    k = i + int(np.argmin(J[i:]))
    return J[i] / J[k], Vf[i], Vf[k]

def bistable(J1, J2):
    """Par en serie: diodo 1 abajo (0..Vm), diodo 2 arriba (Vm..Vsup). Devuelve la ventana de Vsup con 3 cruces
    y la separacion maxima entre los dos estados estables de Vm."""
    best = (0.0, None)
    win = []
    for Vsup in np.arange(0.05, 1.2, 0.005):
        Vm = Vf[Vf <= min(Vsup, 0.7)]
        V2 = Vsup - Vm
        ok = V2 <= 0.7
        Vm, V2 = Vm[ok], V2[ok]
        if len(Vm) < 5:
            continue
        f = np.interp(Vm, Vf, J1) - np.interp(V2, Vf, J2)
        s = np.where(np.sign(f[:-1]) * np.sign(f[1:]) < 0)[0]
        if len(s) >= 3:
            win.append(Vsup)
            sw = Vm[s[-1]] - Vm[s[0]]
            if sw > best[0]:
                best = (sw, Vsup)
    return (min(win), max(win), best[0], best[1]) if win else None

print("\n k(exceso)   PVR    V_pico  V_valle | par identico: ventana de alimentacion [V], excursion del nodo medio [V] |"
      " con desajuste de pico 10 %, 30 %, 50 %")
for k in (0, 1e-3, 1e-2, 3e-2, 8e-2, 0.12, 0.2, 0.3, 0.5, 0.8, 1.2, 2.0):
    J = curve(k)
    p, vp, vv = pvr(J)
    b = bistable(J, J)
    s = "%8.4f  %7.2f   %.3f   %.3f  | " % (k, p, vp, vv)
    s += ("%.3f-%.3f, excursion %.3f a Vsup=%.3f" % b) if b else "NO biestable"
    for mm in (0.1, 0.3, 0.5):
        bm = bistable(J, curve(k, 1 + mm))
        s += " | %s" % (("si(%.2f V)" % bm[2]) if bm else "no")
    print(s)
print("\nLectura con inversor: el nodo medio se mueve entre ~V_pico y ~Vsup - V_pico; un inversor de 1,8 V conmuta cerca de"
      " VDD/2 (no calculado aqui): hace falta un comparador o referir el par a VDD y leer con un pfet.")
print("Tiempo de conmutacion del nodo de 12.4 fF: C dV / I_pico = %.2e s" % (12.4e-15 * 0.4 / (Jpk * AB)))
