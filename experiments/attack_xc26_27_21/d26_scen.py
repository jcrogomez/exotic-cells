"""d26_scen.py — escenarios finales de XC-26: corriente máxima del emisor sin saturar el PNP vertical, luz frente a vía eléctrica.

Entradas: d26_sub.json (R_sub = V bajo el pozo del emisor por mA), d26_budget.json (F_FM por distancia), d26_fd2.json (u en el
borde del pozo del emisor: electrones inyectados si el pozo n/sustrato entra en directa).
Supuestos (barridos): V_EB del emisor 0,80 V a ~mA (DE MEMORIA, diodo de Si), resistencia serie del emisor R_s 0,3-0,7 kOhm
(contactos 585 / 185 Ohm por licon, sky130A.tech l. 5132/5130, PDK local; 2 licon por lado: supuesto), tensión del ánodo 1,8 o 3,3 V.
Criterio de no saturación: V_sub(bajo el pozo) - V_nw <= 0,30 V; con eso la inyección de electrones del pozo
(Is = js*A + jsw*P del parásito ps2nw: 4,21e-18 A/um2 * 12 + 4,94e-18 A/um * 14, unidades inferidas del escalado del PDK) vale
Is*exp(0,30/(1,079*0,02585)) y llega al fotodiodo multiplicada por u_well.
eta: fotones por hueco, ley B*n*tau_t con n = max(N_D, p(J)) (d26_budget.py), evaluada a la corriente máxima.
Salida: d26_scen.txt
"""
import numpy as np, json
sub = json.load(open('d26_sub.json')); bud = json.load(open('d26_budget.json')); fd = json.load(open('d26_fd2.json'))
B, q = 4.68e-15, 1.602e-19
Is_nw = 4.21e-18*12 + 4.94e-18*14
def eta(I, ND, W, Dp, Brel):
    tt = (W*1e-4)**2/(2*Dp); p = (I/1.4e-8)*W*1e-4/(2*q*Dp)
    return Brel*B*max(ND, p)*tt
L = []
def P(*a):
    s = ' '.join(str(x) for x in a); print(s); L.append(s)
P('# escenario sustrato | Vanodo | R_sub kOhm | I_max mA | eta (baja/central/alta) | I_ph d=5,10,20,44 (central) pA | intervalo d=5 pA | electrones al borde, d=5 pA')
for key in sorted(sub):
    if not key.endswith('|0|5') or 'sin_pwell' in key: continue
    scen, rho = key.split('|')[0], key.split('|')[1]
    R = sub[key]['V_bajo_emisor']             # kOhm (V por mA)
    for Va in (1.8, 3.3):
        for Rs in (0.3, 0.7):
            # I*R = Va - 0,80 - I*Rs + 0,30  ->  I = (Va - 0,5)/(R + Rs)   [mA]
            I = (Va-0.5)/(R+Rs)
            Vnw = Va-0.8-I*Rs
            if Vnw < 0: I = (Va-0.8)/Rs if Rs else I
            e_lo = eta(I*1e-3, 1e17, 0.5, 10, 0.3); e_c = eta(I*1e-3, 2e17, 1.0, 7.5, 0.6); e_hi = eta(I*1e-3, 5e17, 1.5, 5, 1.0)
            Fd = [bud['FFM'][str(d)] for d in (5, 10, 20)] + [bud['FFMc']]
            Iph = [I*1e-3*e_c*f*1e12 for f in Fd]
            lo = I*1e-3*e_lo*Fd[0]*0.3*1e12; hi = I*1e-3*e_hi*Fd[0]*1e12      # 0,3: alpha efectivo 3,5 en vez de 12 (espectro corrido)
            Iel = Is_nw*np.exp(0.30/(1.079*0.02585))*fd['5|central|none']['u_well_all']*1e12
            P('%-8s rho=%-4s | %.1f | %5.2f | %.3f | %.1e/%.1e/%.1e | %s | %.3f-%.1f | %.1e' % (scen, rho, Va, R, I, e_lo, e_c, e_hi,
              ' '.join('%.3f' % x for x in Iph), lo, hi, Iel))
P('# piso del lector: 0,15 pA (2^20 ciclos, 27 C, modelo); 0,01 pA con 2^24 si la fuga del excitador es la del modelo')
open('d26_scen.txt', 'w').write('\n'.join(L)+'\n')
