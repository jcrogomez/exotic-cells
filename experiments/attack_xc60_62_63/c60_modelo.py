#!/usr/bin/env python3
"""c60 (i): magnetodiodo, modelo propio de primer orden. BARRIDO de lo no público (profundidad del pozo d, velocidades de
recombinación s, movilidad efectiva, vida media): salen intervalos, no números.
Modelo: lámina de espesor d (z=0 cara superior con s1; z=d cara inferior con s2), corriente a lo largo de x, campo B en el
plano (y) => deriva transversal u = theta*v_x en z, theta = mu_ef*B. Problema transversal D p'' - u p' = -lam p con flujos de
superficie: a primer orden u equivale a s1 -> s1+u/2, s2 -> s2-u/2, así que
   d(lam) = (u/2)*(dlam/ds1 - dlam/ds2)   (impar en B; CERO si s1 = s2: el control centrado no hace falta simularlo).
1/tau_ef = 1/tau_b + lam. Con arrastre v_x = mu*E y Einstein: u*d/D = theta*E*d/VT.
Inyección alta (doble inyección, I ~ tau*V^2/L^3): a corriente constante dV = -(V/2)*dtau/tau.
Inyección baja (transistor lateral, flujo por difusión): dlnI_lat = (L/2Lef)*dtau/tau con u = theta*D/Lef.
Campo: tira de met1/met3 de ancho w, espesor real, integrada (Biot-Savart 2D). Salida c60_modelo.txt"""
import numpy as np
from scipy.optimize import brentq
mu0, VT, q = 4e-7 * np.pi, 0.025852, 1.602e-19
out = []
# ---- 1. campo en el plano bajo una tira
def Bstrip(w, t, hbot, depth, K):
    """B_x (T) en el eje, a `depth` bajo la superficie del silicio; tira de ancho w, espesor t, cara inferior a hbot; K A/m por ancho"""
    J = K / t; xs = np.linspace(-w / 2, w / 2, 801); zs = np.linspace(hbot, hbot + t, 41) + depth
    XX, ZZ = np.meshgrid(xs, zs); dA = (xs[1] - xs[0]) * (zs[1] - zs[0])
    return mu0 * J / (2 * np.pi) * np.sum(ZZ / (XX ** 2 + ZZ ** 2)) * dA * (len(xs) * len(zs)) / ((len(xs)) * (len(zs)))
out.append("1. CAMPO EN EL PLANO bajo una tira (um; alturas del tech l.5058-5068: met1 1,3761+0,36, met2 2,0061+0,36, met3 2,7861+0,845).")
out.append("   Límite continuo LEF: met1 2,8, met2 2,8 [supuesto igual a met1: comprobar], met3 6,8 mA/um. Profundidad en silicio 0,5 um.")
out.append(f"   {'capa':5s} {'w um':>5s} {'I mA':>6s} {'B mT':>6s} {'mT/mA':>6s}   cota de lámina infinita mu0*K/2")
for name, hb, t, K in (("met1", 1.3761, 0.36, 2.8), ("met2", 2.0061, 0.36, 2.8), ("met3", 2.7861, 0.845, 6.8)):
    for w in (0.14 if name == "met1" else 0.3, 1.0, 2.0, 5.0, 10.0):
        B = Bstrip(w * 1e-6, t * 1e-6, hb * 1e-6, 0.5e-6, K * 1e-3 / 1e-6) * 1e3
        out.append(f"   {name:5s} {w:5.2f} {K*w:6.2f} {B:6.3f} {B/(K*w):6.3f}   {mu0*K*1e3/2*1e3:.2f} mT")
# ---- 2. autovalor transversal y factor G
def lam(s1, s2, d, D):
    """menor autovalor de D p'' = -lam p, D p'(0) = s1 p(0), -D p'(d) = s2 p(d). Unidades cm, s."""
    f = lambda k: (D * D * k * k - s1 * s2) * np.sin(k * d) - k * D * (s1 + s2) * np.cos(k * d)
    ks = np.linspace(1e-6, np.pi / d * 0.999999, 20001); v = f(ks); i = np.where(np.sign(v[1:]) != np.sign(v[:-1]))[0]
    if len(i) == 0: return 0.0
    k = brentq(f, ks[i[0]], ks[i[0] + 1]); return D * k * k
def G(s1, s2, d, D, taub):
    """dln(tau_ef)/d(u*d/D), u>0 empuja hacia z=d"""
    h1, h2 = max(s1, 1.0) * 1e-3, max(s2, 1.0) * 1e-3
    dl = 0.5 * ((lam(s1 + h1, s2, d, D) - lam(s1, s2, d, D)) / h1 - (lam(s1, s2 + h2, d, D) - lam(s1, s2, d, D)) / h2)   # por unidad de u
    l0 = lam(s1, s2, d, D); tau = 1 / (1 / taub + l0)
    return -dl * tau * D / d, tau
out.append("\n2. FACTOR G = dln(tau_ef)/d(theta*E*d/VT). Analítico s1=0, s2=inf, sin volumen: 4/pi^2 = 0,405.")
out.append("   D = 10 cm2/s (ambipolar, supuesto 5-15), tau_b = 1 us (supuesto; apenas importa si d << sqrt(D tau_b) = 32 um)")
out.append(f"   {'d um':>5s} {'s_sup cm/s':>10s} {'s_inf cm/s':>10s} {'G':>7s} {'tau_ef ns':>9s} {'Lef=sqrt(D tau) um':>18s}")
D, taub = 10.0, 1e-6; Gtab = {}
for d in (0.5, 1.0, 2.0):
    for s1 in (1e1, 1e3, 1e4, 1e5):
        for s2, tag in ((1e7, "unión (colector)"), (s1, "= s_sup (simétrico)")):
            g, tau = G(s1, s2, d * 1e-4, D, taub); Gtab[(d, s1, s2)] = (g, tau)
            out.append(f"   {d:5.1f} {s1:10.0e} {s2:10.0e} {g:7.3f} {tau*1e9:9.3f} {np.sqrt(D*tau)*1e4:18.2f}   {tag}")
out.append("   Caras LATERALES (campo vertical de la bobina; anchura w entre una pared de STI con s y el pozo abierto/otra pared):")
for wd in (1.0, 3.0):
    for s1 in (1e3, 1e4, 1e5):
        for s2 in (1e1,):
            taub_eff = 4 * (1e-4) ** 2 / (np.pi ** 2 * D)          # la unión del fondo a d=1 um hace de 'volumen': tau = 0,4 ns
            g, tau = G(s1, s2, wd * 1e-4, D, taub_eff)
            out.append(f"   w={wd:.0f} um  s_pared={s1:.0e}  s_otra={s2:.0e}  con fondo colector a 1 um (tau_b=0,41 ns): G_lateral={g:+.4f}")
# ---- 3. señales
out.append("\n3. SEÑAL en inyección ALTA a corriente constante: dV = (V/2)*G*theta*(V/VT)*(d/L)*f,  theta = mu_ef*B,")
out.append("   f = fracción del largo con conductividad modulada = min(1, (mu*E*tau_ef + sqrt(D*tau_ef))/L), mu = 500 cm2/Vs (supuesto).")
out.append("   Cara superior s=1e3 (escenario; con 1e5 G baja como en la tabla 2), fondo = unión pozo-sustrato. V = caída en la base.")
out.append("   Comparadores: paso del lector 0,305 mV; Hall 0,017-0,66 mV/mA a 2,65 mT => 0,0064-0,25 mV/mA a 1 mT.")
out.append(f"   {'d':>4s} {'L':>5s} {'V':>4s} {'mu_ef':>6s} {'f':>5s} {'dV@1mT uV':>10s} {'dV@1,6mT':>9s} {'V/T':>7s} {'dI/I@1mT':>9s} {'I_alta mA (W=5um, N=1e17)':>26s} {'I_sub/I':>7s}")
for d in (0.5, 1.0, 2.0):
    g, tau = Gtab[(d, 1e3, 1e7)]
    for LoD in (2, 5, 20):
        L = LoD * d
        for V in (0.3, 1.0):
            for mue in (0.05, 0.15):
                Ef = V / (L * 1e-4); f = min(1.0, (500 * Ef * tau + np.sqrt(D * tau)) / (L * 1e-4))
                s = 0.5 * V * g * mue * (V / VT) * (d / L) * f          # V/T
                Ihi = q * 1e17 * (d * 1e-4) * (5e-4) * (L * 1e-4 * f) / tau * 1e3
                if mue == 0.05 or True:
                    out.append(f"   {d:4.1f} {L:5.1f} {V:4.1f} {mue:6.2f} {f:5.2f} {s*1e-3*1e6:10.1f} {s*1.6e-3*1e6:9.1f} {s:7.3f} {2*s*1e-3/V:9.2e} {Ihi:26.2f} {'~1':>7s}")
out.append("\n4. Inyección BAJA (transistor lateral pnp con colector de sustrato): dlnI_lat = theta_p*L/(2d)*(G/0,405), theta_p = mu_p*B, mu_p = 0,03-0,045 m2/Vs;")
out.append("   la corriente lateral que sobrevive es ~exp(-L/Lef), Lef = 2d/pi.")
for LoD in (1, 2, 3, 5, 10):
    out.append(f"   L/d={LoD:2d}: dI/I por mT = {0.03e-3*LoD/2:.1e} .. {0.045e-3*LoD/2:.1e};  fracción lateral exp(-pi L/2d) = {np.exp(-np.pi*LoD/2):.1e}")
open("c60_modelo.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
