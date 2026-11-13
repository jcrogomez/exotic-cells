"""d21_bv.py — tensión de ruptura por avalancha de uniones p+/n(-n+) en una dimensión, con el hueco p+ -> n+ como parámetro.

Modelo (cálculo, sin calibrar): p+ abrupto (lado p+ despreciable), región n de dopado N_D (pozo n, no público: 1e16-1e18),
de anchura g (hueco legal: 0,27; 0,54; 1,08 um; o infinita = unión plana p+/pozo n), y n+ que corta el vaciamiento (punch-through).
Coeficientes de ionización de van Overstraeten y de Man (1970) — valores DE MEMORIA:
  electrones a = 7,03e5 /cm, b = 1,231e6 V/cm ; huecos a = 1,582e6 /cm, b = 2,036e6 V/cm (E < 4e5), a = 6,71e5, b = 1,693e6 (E >= 4e5).
Ruptura: integral de ionización (inicio por huecos o electrones, la que llegue antes) = 1.
Túnel banda a banda: campo pico >= ~1e6 V/cm marca el régimen Zener (umbral DE MEMORIA, orden de magnitud).
Esquina: la unión real es lateral y somera (0,1 um, DATOS_PROCESO): un radio de curvatura r_j ~ 0,1 um baja la ruptura de la
plana; se da la corrección cilíndrica de Sze y Gibbons (1966, DE MEMORIA) como cota baja.
Salida: d21_bv.txt
"""
import numpy as np
q, eps = 1.602e-19, 11.7*8.854e-14
def an(E): return 7.03e5*np.exp(-1.231e6/np.maximum(E, 1))
def ap(E): return np.where(E < 4e5, 1.582e6*np.exp(-2.036e6/np.maximum(E, 1)), 6.71e5*np.exp(-1.693e6/np.maximum(E, 1)))

def ion_integral(Emax, ND, g_cm):
    W = eps*Emax/(q*ND)
    if W <= g_cm:
        x = np.linspace(0, W, 4000); E = Emax - q*ND*x/eps
    else:   # punch-through: el vaciamiento llega al n+, campo trapezoidal
        x = np.linspace(0, g_cm, 4000); E = Emax - q*ND*x/eps
    a_n, a_p = an(E), ap(E)
    dx = x[1]-x[0]
    # huecos inician en el lado n (x = máx) y viajan hacia el p+ (x = 0); integral estándar
    diff = np.cumsum((a_n - a_p)*dx)          # int_0^x (a_n - a_p)
    I_e = np.sum(a_n*np.exp(-diff)*dx)
    I_h = np.sum(a_p*np.exp(diff - diff[-1])*dx)
    V = np.sum(E*dx)
    return max(I_e, I_h), V, E.max()

def bv(ND, g_um):
    g = g_um*1e-4 if g_um else 1.0
    lo, hi = 1e4, 5e6
    for _ in range(80):
        mid = np.sqrt(lo*hi)
        I, V, Em = ion_integral(mid, ND, g)
        if I < 1: lo = mid
        else: hi = mid
    I, V, Em = ion_integral(hi, ND, g)
    return V, Em

L = []
def P(*a):
    s = ' '.join(str(x) for x in a); print(s); L.append(s)
P('# N_D [cm-3] | ruptura plana p+/n (V, E_pico MV/cm) | hueco 1,08 | 0,54 | 0,27 um  (V aplicado ~ V - V_bi, V_bi ~ 0,9-1,0)')
for ND in (1e16, 3e16, 1e17, 2e17, 5e17, 1e18, 2e18):
    row = [bv(ND, g) for g in (None, 1.08, 0.54, 0.27)]
    P('%.0e | %s' % (ND, ' | '.join('%.2f V (%.2f)' % (v, e/1e6) for v, e in row)))
P('# Corrección cilíndrica (Sze-Gibbons, DE MEMORIA): BV_cil/BV_plano = ((rj/W)^2 + 2 (rj/W)^(6/7))^(1/2) - rj/W, W = vaciamiento a ruptura')
for ND in (1e17, 2e17, 5e17):
    V, Em = bv(ND, None); W = eps*Em/(q*ND)*1e4
    for rj in (0.1, 0.2):
        h = rj/W; f = np.sqrt(h**2 + 2*h**(6/7)) - h
        P('  N_D %.0e: W %.2f um, r_j %.1f um -> factor %.2f -> %.1f V' % (ND, W, rj, f, f*V))
P('# Lectura: el bv del PDK (12,69 V, diode_pd2nw_05v5) cae en la fila de N_D para la que la plana o la cilíndrica dan ~12-13 V')
open('d21_bv.txt', 'w').write('\n'.join(L)+'\n')
