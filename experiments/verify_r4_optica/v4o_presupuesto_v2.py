# v4o_presupuesto.py — XC-26: corriente maxima del emisor antes de que la inyeccion de electrones del pozo al sustrato tape la luz,
# y fotocorriente optica resultante. Lee v4o_sustrato.json y v4o_coleccion.json. Codigo propio.
# Criterio (mio): la luz deja de ser legible cuando P_e * I_inj(V) >= eta * F * I, con V = (subida del sustrato bajo el pozo) - V_K.
# I_inj: dos lecturas del PDK local que discrepan ~4 ordenes [?]:
#   (A) base inversa del PNP: IS/BR * exp(V/Vt), IS = 7.119e-18 A * (1.4/11.56) [escalado por area del p+], BR = 0.2675
#   (B) diodo parasito ps2nw leido en A/um^2 y A/um (correccion: la lectura en A/m^2 de v4o_presupuesto.py da Is ~1e-23 A, fisicamente imposible)
import json, numpy as np
from scipy.optimize import brentq
Vt = 0.025852
IS_A = 7.119e-18 * 1.4 / 11.56 / 0.2675
IS_B, nB = 4.21e-18 * 12 + 4.94e-18 * 14, 1.0791  # js en A/um^2 y jsw en A/um (unidades efectivas con scale=1e-6)
sub = json.load(open('v4o_sustrato.json'))
col = {(r['d'], r['L'], r['Zb'], r['z_dn'], r['ring'], r.get('emit_sink', True)): r for r in json.load(open('v4o_coleccion.json'))['runs']}
F = {d: col[(d, 100, 250, 2.5, True, True)]['F_emisor'] for d in (5, 10, 20)}
Pe = col[(5, 100, 250, 2.5, True, False)]['P_bajo_emisor']
print(f"F base (L=100, Zb=250, anillo): {F}; P_e (electron inyectado bajo el pozo, d=5) = {Pe:.4f}")
fc = 17.6 / 18.6  # beta/(beta+1), BF 16.6..19.4
def onset(Rsub, eta, Fd, VK, which):
    def f(I):
        V = I * fc * Rsub - VK
        inj = IS_A * np.expm1(V / Vt) if which == "A" else IS_B * np.expm1(V / (nB * Vt))  # v2: exp-1
        return Pe * inj - eta * Fd * I
    try:
        return brentq(f, 1e-9, 0.02)
    except ValueError:
        return 0.02  # limite de 20 mA (red de Tiny Tapeout)
rows = []
cases = {}
for s in sub:
    key = f"rho={s['rho']} d={s['d']}" + (" guarda" if s['guard'] else "") + (" taps lejanos a masa" if s['far_ground'] else "") + (f" pwell{s['pwell']}" if s['pwell'] else "")
    cases[key] = (s['d'], s['R_equipot_ohm'], s['Vmean_fondo_por_A'])
# escalado lineal en rho para los casos homogeneos de rho=10
for k, (d, Ra, Rb) in list(cases.items()):
    if k.startswith('rho=10 ') and 'pwell' not in k:
        for rho in (1, 20):
            cases[k.replace('rho=10', f'rho={rho}') + ' (escalado)'] = (d, Ra * rho / 10, Rb * rho / 10)
print("\ncaso | R_sub (equipot..media) kOhm | I_umbral mA (V_K=0; A..B) | I_ph pA eta=1e-6 (min..max) | idem V_K=1.0")
for k, (d, Ra, Rb) in cases.items():
    out = []
    for VK in (0.0, 1.0):
        Is = [onset(R, 1e-6, F[d], VK, w) for R in (Ra, Rb) for w in ('A', 'B')]
        out.append((min(Is), max(Is)))
    ip = [(1e-6 * F[d] * a * 1e12, 1e-6 * F[d] * b * 1e12) for a, b in out]
    print(f"{k} | {Ra/1e3:.2f}..{Rb/1e3:.2f} | {out[0][0]*1e3:.3f}..{out[0][1]*1e3:.3f} | {ip[0][0]:.3f}..{ip[0][1]:.3f} | {ip[1][0]:.2f}..{ip[1][1]:.2f}")
print("\nNota: I_ph escala ~linealmente con eta (intervalo 1e-7..1e-5, v4o_eta.txt); el umbral depende de eta solo logaritmicamente.")
