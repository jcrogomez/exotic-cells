#!/usr/bin/env python
"""b52_bobinas.py — dos devanados entrelazados en met3/met4, modos suma / cancelado, a corriente (potencia) constante.

Biot–Savart propio (segmentos finitos, fórmula cerrada, vectorizado; no reutiliza a52_coil.py).
Datos de proceso (DATOS_PROCESO.md y a52/v1, PDK local):
  met3/met4: ancho mín 0,3; sep. 0,3 (0,4 si ancho >= 3); 0,047 ohm/sq; EM 6,8 mA/um CC (tlef l.207, verificado R7)
  alturas Magic (sky130A.tech l. 5064/5071): met3 base 2,7861, met4 base 4,0211, espesor 0,845 -> centros 3,2086 y 4,4436 um
  sobre la superficie del silicio (convenio del verificador v1: z = 3,21; a52 restaba 0,3262 -> 2,88; se dan los dos).
Supuestos (NO PDK): eps_r del dieléctrico 3,9 (de memoria; barrido 3,5–4,2 no cambia el orden); desalineación met3–met4
  NO pública -> barrida 0–0,5 um. Vueltas = lazos cuadrados cerrados, pista = nf filamentos.
Geometrías (N vueltas por devanado, borde interior a a_in del centro):
  G1 coplanar: A y B alternan vuelta a vuelta en met3.
  G2 apilada:  A en met3, B en met4, misma huella.
  G3 cruzada:  met3 = A,B,A..; met4 = B,A,B.. (cada devanado alterna de capa en cada vuelta: via3 por vuelta).
"""
import sys, subprocess
import numpy as np

MU0 = 4e-7 * np.pi
EPS0 = 8.854e-12
Z3, Z4, TM = 3.2086, 4.4436, 0.845
RS, EM = 0.047, 6.8
out = []


def P(*a):
    s = " ".join(str(x) for x in a)
    print(s)
    out.append(s)


def loops_to_segments(loops, nf=5):
    """loops: lista de (a_centro, w, z, dx, signo). Devuelve arrays P1,P2 (n,3) en um y peso (signo/nf)."""
    p1, p2, wt = [], [], []
    for a, w, z, dx, sg in loops:
        offs = (np.arange(nf) + 0.5) / nf * w - w / 2
        for o in offs:
            h = a + o
            c = np.array([[-h, -h, z], [h, -h, z], [h, h, z], [-h, h, z]]) + np.array([dx, 0, 0])
            for i in range(4):
                p1.append(c[i]); p2.append(c[(i + 1) % 4]); wt.append(sg / nf)
    return np.array(p1), np.array(p2), np.array(wt)


def bfield(pts, loops, nf=5):
    """B (T por A) en pts (m,3) [um]. Suma de segmentos finitos."""
    p1, p2, wt = loops_to_segments(loops, nf)
    B = np.zeros_like(pts, dtype=float)
    for a, b, w in zip(p1, p2, wt):
        ab = b - a; L = np.linalg.norm(ab); u = ab / L
        ap = pts - a
        t = ap @ u
        perp = ap - np.outer(t, u)
        d = np.maximum(np.linalg.norm(perp, axis=1), 1e-9)
        k = (t / np.hypot(t, d) - (t - L) / np.hypot(t - L, d)) / d
        B += w * (MU0 / (4 * np.pi)) * k[:, None] * np.cross(u, perp / d[:, None]) / 1e-6
    return B


def patch(side, n=21, z=0.0):
    s = np.linspace(-side / 2, side / 2, n)
    X, Y = np.meshgrid(s, s)
    return np.stack([X.ravel(), Y.ravel(), np.full(X.size, z)], 1)


def build(geom, N, w, a_in, dx4=0.0, s=None):
    """Devuelve (loopsA, loopsB) con signo +1. a_in = distancia del centro al borde interior de la primera pista."""
    s = (0.4 if w >= 3 else 0.3) if s is None else s
    p = w + s
    A, B = [], []
    if geom == "G1":
        for k in range(2 * N):
            (A if k % 2 == 0 else B).append((a_in + w / 2 + k * p, w, Z3, 0.0, 1))
    elif geom == "G2":
        for k in range(N):
            A.append((a_in + w / 2 + k * p, w, Z3, 0.0, 1))
            B.append((a_in + w / 2 + k * p, w, Z4, dx4, 1))
    elif geom == "G3":
        for k in range(N):
            a = a_in + w / 2 + k * p
            (A if k % 2 == 0 else B).append((a, w, Z3, 0.0, 1))
            (B if k % 2 == 0 else A).append((a, w, Z4, dx4, 1))
    return A, B


def resist(loops):
    return sum(8 * a * RS / w for a, w, *_ in loops)


def outer(loops):
    return max(a + w / 2 for a, w, *_ in loops)


def elems(loops, dl=0.25):
    """Discretiza los ejes de las pistas: centros (n,3), vectores dl (n,3), fracción de longitud s (n) y ancho."""
    c, d, ww = [], [], []
    for a, w, z, dx, sg in loops:
        cs = np.array([[-a, -a, z], [a, -a, z], [a, a, z], [-a, a, z]]) + np.array([dx, 0, 0])
        for i in range(4):
            v = cs[(i + 1) % 4] - cs[i]; L = np.linalg.norm(v); n = max(4, int(round(L / dl)))
            t = (np.arange(n) + 0.5) / n
            c.append(cs[i] + np.outer(t, v)); d.append(np.tile(v / n, (n, 1))); ww.append(np.full(n, w))
    c = np.vstack(c); d = np.vstack(d); ww = np.concatenate(ww)
    ln = np.linalg.norm(d, axis=1)
    sfrac = (np.cumsum(ln) - ln / 2) / ln.sum()
    return c, d, sfrac, ww


def neumann(l1, l2, same):
    """Inductancia mutua (H) entre dos conjuntos de lazos por Neumann; si same, regulariza con GMD = 0,2235 (w+t)."""
    c1, d1, _, w1 = elems(l1, 0.5)
    c2, d2, _, w2 = elems(l2, 0.5)
    M = 0.0
    for i in range(0, len(c1), 400):
        r2 = ((c1[i:i + 400, None, :] - c2[None, :, :]) ** 2).sum(-1)
        g = 0.2235 * (w1[i:i + 400, None] + TM) if same else 0.0
        dot = d1[i:i + 400] @ d2.T
        M += (dot / np.sqrt(r2 + g ** 2 + (0 if same else 1e-6))).sum()
    return MU0 / (4 * np.pi) * M * 1e-6


def cap_weights(loops, side=10.0, eps_r=3.9):
    """Carga inducida por voltio en un parche puesto a tierra de side x side en z=0, por cada elemento de pista.
    q_i = c_i * f_i, c_i = eps dA / h (placa local), f_i = fracción de la carga imagen que cae en el parche
    (núcleo de plano conductor: h / (2 pi (rho^2 + h^2)^1.5)). Sin solver: orden de magnitud (x3)."""
    c, d, sf, ww = elems(loops, 0.5)
    g = patch(side, 41)
    dA = (side / 40) ** 2
    q = np.zeros(len(c))
    for i in range(len(c)):
        h = c[i, 2] - TM / 2
        rho2 = ((g[:, :2] - c[i, :2]) ** 2).sum(1)
        f = (h / (2 * np.pi * (rho2 + h * h) ** 1.5)).sum() * dA
        ci = EPS0 * eps_r * (ww[i] * np.linalg.norm(d[i])) * 1e-12 / (h * 1e-6)
        q[i] = ci * f
    return q, sf


P("b52_bobinas.py — corrida:", subprocess.check_output(["date"]).decode().strip())
P("")
P("== 0. Validación ==")
ctr = np.array([[0.0, 0.0, 0.0]])
b = bfield(ctr, [(10.0, 1e-6, 0.0, 0.0, 1)], nf=1)[0, 2]
P(f"lazo cuadrado semilado 10 um, centro, mismo plano: {b:.6f} T/A; analítico 2*sqrt2*mu0/(pi*2a) = {2*np.sqrt(2)*MU0/(np.pi*20e-6):.6f}")
A5 = [(10.0 + 1.5 / 2 + k * 1.8, 1.5, 3.21, 0.0, 1) for k in range(5)]
P(f"5 vueltas met3, w=1,5, borde interior a 10 um, z=3,21: {bfield(ctr, A5)[0,2]:.3f} mT/mA (verificador v1: 0,190)")
Lsq = neumann([(10.0, 0.3, 0.0, 0.0, 1)], [(10.0, 0.3, 0.0, 0.0, 1)], True)
rho = 0.2235 * (0.3 + TM)
Lan = 2 * MU0 * 20e-6 / np.pi * (np.log(20e-6 / (rho * 1e-6)) - 0.774)
P(f"L de un lazo cuadrado de lado 20 um (GMD {rho:.2f} um): Neumann {Lsq*1e12:.1f} pH; fórmula de lazo cuadrado {Lan*1e12:.1f} pH")
P("")

P("== 1. Campo en el plano del silicio, modos suma (A+B) y cancelado (A-B), por mA en CADA devanado ==")
P("Bz0 = centro; <|B|> = media del módulo (3 componentes) sobre el dispositivo de 10x10 um; unif = min/max de Bz en 10x10")
P("geom  N  w    a_in | R_A   R_B  ohm | suma: Bz0 mT/mA  <|B|>   unif | cancel: Bz0   <|B|>  max|B| (mT/mA) | resid <|B|>c/<|B|>s | huella um | I_EM mA | B_max suma mT | P bobinas mW @I_EM")
pt = patch(10.0, 21)
CONF = []
for geom in ("G1", "G2", "G3"):
    for N, w, a_in in ((3, 1.5, 7.0), (3, 1.5, 10.0), (5, 1.5, 7.0), (3, 2.1, 7.0), (4, 1.5, 7.0)):
        if geom == "G3" and N % 2 == 1:
            Nn = N + 1  # G3 necesita N par para que los dos devanados sean iguales
        else:
            Nn = N
        A, B = build(geom, Nn, w, a_in)
        BA, BB = bfield(pt, A), bfield(pt, B)
        S, C = (BA + BB), (BA - BB)  # T/A = mT/mA numéricamente
        c0 = len(pt) // 2
        ms, mc = np.linalg.norm(S, axis=1), np.linalg.norm(C, axis=1)
        Iem = EM * w
        row = (geom, Nn, w, a_in, resist(A), resist(B), S[c0, 2], ms.mean(), S[:, 2].min() / S[:, 2].max(),
               C[c0, 2], mc.mean(), mc.max(), mc.mean() / ms.mean(), 2 * outer(A + B), Iem, ms.mean() * Iem,
               Iem ** 2 * (resist(A) + resist(B)) * 1e-3)
        CONF.append(row)
        P("%s  %d  %.1f  %4.1f | %5.1f %5.1f | %7.4f %7.4f %5.2f | %8.4f %7.4f %7.4f | %6.3f | %5.1f | %5.1f | %5.2f | %5.2f" % row)
P("")
P("Nota: con z de a52 (2,88/4,12 en vez de 3,21/4,44) el campo sube ~3-6 %; no cambia nada de lo que sigue.")
P("")

P("== 2. Residuo de cancelación frente a desalineación met3–met4 (dx de met4; NO pública: barrido) ==")
P("geom N w a_in | dx um : resid <|B|>cancel/<|B|>suma sobre 10x10, y Bz0 cancel (mT/mA)")
for geom, N in (("G2", 3), ("G3", 4)):
    for dx in (0.0, 0.05, 0.1, 0.2, 0.5):
        A, B = build(geom, N, 1.5, 7.0, dx4=dx)
        BA, BB = bfield(pt, A), bfield(pt, B)
        ms = np.linalg.norm(BA + BB, axis=1); mc = np.linalg.norm(BA - BB, axis=1)
        P(f"{geom} {N} 1.5 7.0 | dx={dx:4.2f} : resid {mc.mean()/ms.mean():.4f} ; Bz0 cancel {(BA-BB)[len(pt)//2,2]:+.5f} ; max|B|c {mc.max():.5f}")
P("G1 es de una sola capa: la desalineación entre capas no le afecta (sí el sesgo de ancho de pista, común a A y B).")
P("")

P("== 3. Inductancia (Neumann, GMD; +-30 %) y fem en el lazo de lectura ==")
for geom, N in (("G1", 3), ("G2", 3), ("G3", 4)):
    A, B = build(geom, N, 1.5, 7.0)
    LA, LB, M = neumann(A, A, True), neumann(B, B, True), neumann(A, B, False)
    R = resist(A) + resist(B)
    P(f"{geom} N={N}: L_A {LA*1e9:.3f} nH, L_B {LB*1e9:.3f} nH, M {M*1e9:.3f} nH (k={M/np.sqrt(LA*LB):.2f}); "
      f"L_suma {1e9*(LA+LB+2*M):.3f} nH, L_cancel {1e9*(LA+LB-2*M):.3f} nH; R serie {R:.1f} ohm; L_suma/R = {(LA+LB+2*M)/R*1e12:.1f} ps")
    for side in (10.0, 30.0, 100.0):
        g = patch(side, 41)
        Bs = bfield(g, A)[:, 2] + bfield(g, B)[:, 2]
        phi = Bs.mean() * (side * 1e-6) ** 2  # Wb por A
        I = 0.0102
        P(f"    lazo de lectura {side:.0f}x{side:.0f} um: flujo {phi*I*1e15:.2f} fWb a 10,2 mA (suma) -> fem al conmutar suma<->cancel en "
          f"1 ns / 100 ns / 10 us: {phi*I/1e-9*1e6:.1f} uV / {phi*I/1e-7*1e6:.3f} uV / {phi*I/1e-5*1e9:.2f} nV")
P("")

P("== 4. Acoplo eléctrico: diferencia entre modos (sin blindaje; núcleo de plano conductor, sin solver, x3) ==")
P("Al invertir B su perfil de tensión se refleja: dV_i = V_B (1 - 2 s_i). Carga inducida en un nodo 10x10 a tierra virtual.")
qe = 1.602e-19
for geom, N in (("G1", 3), ("G2", 3), ("G3", 4)):
    A, B = build(geom, N, 1.5, 7.0)
    q, sf = cap_weights(B)
    Iem = 10.2e-3
    VB = Iem * resist(B)
    Ctot = q.sum()
    dQ = (q * VB * (1 - 2 * sf)).sum()
    # orden alternativo: recorrer las vueltas hacia fuera y volver (dentro-fuera-dentro) -> perfil equilibrado
    P(f"{geom} N={N}: C(B->nodo) {Ctot*1e18:.1f} aF; caída en B {VB*1e3:.0f} mV; dQ(modo) = {dQ/qe:+.1f} e = dV_equiv {dQ/Ctot*1e3:+.1f} mV sobre C")
    for Csh in (1e-2, 1e-3):
        P(f"      con blindaje (factor {Csh:g}, barrido de a52): {dQ*Csh/qe:+.3f} e por transición")
P("Señal de referencia por semiperiodo: I*T/2*delta/q. 10 pA, 1 kHz, 1e-4 -> %.2f e; 10 pA, 50 Hz, 1e-4 -> %.1f e; 1 nA, 1 kHz, 3e-5 -> %.1f e"
  % (10e-12 * 0.5e-3 * 1e-4 / qe, 10e-12 * 10e-3 * 1e-4 / qe, 1e-9 * 0.5e-3 * 3e-5 / qe))
P("")

P("== 5. Lo que queda tras el esquema: potencia y térmica residual ==")
P("Esquema de 2 estados (a52: se invierte solo B). Camino serie: R_A + R_B + 4 R_on (dos interruptores por puente) + R_alim.")
dT = {1.5: 0.070}  # K a 1,25 mW en una espiral de w=1,5 (a52_parasitos, modelo 1D, constantes de memoria)
TC = 0.058  # /K del dc-IV (a52)
A, B = build("G3", 4, 1.5, 7.0)
Rc = resist(A) + resist(B)
Pc = (10.2e-3) ** 2 * Rc
dTc = 0.070 * Pc / 1.25e-3
P(f"G3 N=4: R bobinas {Rc:.1f} ohm, P bobinas {Pc*1e3:.2f} mW a 10,2 mA -> dT silicio ~ {dTc*1e3:.0f} mK (escala lineal de los 70 mK/1,25 mW de a52)")
P("R_on  desajuste | dI/I (fuente de tensión 1,8 V con lastre) | dP/P | residuo térmico par 2 estados (dc-IV 5,8 %/K) | 4 estados (término cruzado)")
for Ron in (5.0, 10.0, 20.0):
    for mm in (0.005, 0.02, 0.05):
        Rtot = 1.8 / 10.2e-3
        dI = mm * Ron * np.sqrt(2) / Rtot
        res2 = dTc * TC * 2 * dI
        res4 = dTc * TC * 2 * dI * dI  # producto de dos desajustes independientes: segundo orden
        P(f"{Ron:4.0f}  {mm*100:4.1f} %   | {dI:.2e} | {2*dI:.2e} | {res2:.2e} | {res4:.2e}")
P("Con fuente de corriente (lazo que regula I): dI/I = error del lazo (1e-4..1e-3) -> residuo 2 estados %.1e..%.1e" % (dTc * TC * 2e-4, dTc * TC * 2e-3))
P("")
open(__file__.replace(".py", ".txt"), "w").write("\n".join(out) + "\n")
