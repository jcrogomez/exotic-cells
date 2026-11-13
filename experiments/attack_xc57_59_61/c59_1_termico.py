"""c59_1: ¿a qué temperatura llega (a) el calefactor, (b) un elemento de poly sobre óxido de campo entre dos calefactores,
(c) la superficie de una zona activa de silicio (el transistor) entre dos calefactores de poly, (d) lo mismo con un calefactor de
li encima? Sección 2D (c_lib). Resultado en K por W/m y potencia lineal / corriente para +200 y +400 K.
Supuesto: k_ox 1.0-1.4, k_si 150 (a 300 K; baja a ~75 a 500 K: el silicio caliente se calienta hasta ~2x más)."""
import numpy as np, c_lib as L
out = []; P = out.append
P("# c59_1_termico.py — dos calefactores de poly w=0.5 a cada lado, 1 W/m cada uno (2 W/m total)")
P("# k_ox d_um | dT_calefactor K/(W/m tot) | (b) poly central 0.15: K/(W/m), f | (c) activa Si 0.42 um: K/(W/m), f")
rows = {}
for kox in (1.0, 1.4):
    for d in (0.21, 0.5, 1.0, 3.0):
        w = 0.5
        for kind in ("poly", "si"):
            cw = 0.15 if kind == "poly" else 0.42
            hl = (-cw/2-d-w, -cw/2-d, L.H_FOX, L.H_FOX+L.T_POLY); hr = (cw/2+d, cw/2+d+w, L.H_FOX, L.H_FOX+L.T_POLY)
            rects = [hl+(30.,), hr+(30.,)]
            if kind == "poly": rects.append((-cw/2, cw/2, L.H_FOX, L.H_FOX+L.T_POLY, 30.)); probe = (-cw/2, cw/2, L.H_FOX, L.H_FOX+L.T_POLY)
            else: rects.append((-cw/2, cw/2, 0, L.H_FOX, 150.)); probe = (-cw/2, cw/2, L.H_FOX-0.04, L.H_FOX)
            x, y, T = L.solve2d(rects, [hl+(1.,), hr+(1.,)], k_ox=kox)
            th = L.mean_in(x, y, T, *hl)/2; tpz = L.mean_in(x, y, T, *probe)/2
            rows[(kox, d, kind)] = (th, tpz)
        a = rows[(kox, d, "poly")]; b = rows[(kox, d, "si")]
        P(f"{kox} {d} | {a[0]:.3f} | {a[1]:.4f}, {a[1]/a[0]:.3f} | {b[1]:.5f}, {b[1]/b[0]:.4f}")
P("\n# (d) calefactor de li (w=0.5, y=0.936..1.036) centrado ENCIMA de la zona activa (0.42 um) con su puerta de poly")
for kox in (1.0, 1.4):
    hl = (-0.25, 0.25, L.Y_LI, L.Y_LI+L.T_LI)
    rects = [hl+(20.,), (-0.21, 0.21, 0, L.H_FOX, 150.), (-0.5, 0.5, L.H_FOX, L.H_FOX+L.T_POLY, 30.)]
    x, y, T = L.solve2d(rects, [hl+(1.,)], k_ox=kox)
    th = L.mean_in(x, y, T, *hl); ts = L.mean_in(x, y, T, -0.21, 0.21, L.H_FOX-0.04, L.H_FOX); tg = L.mean_in(x, y, T, -0.2, 0.2, L.H_FOX, L.H_FOX+L.T_POLY)
    rows[(kox, "li")] = (th, ts)
    P(f"k_ox {kox}: li {th:.3f} K/(W/m); canal Si {ts:.5f} (f={ts/th:.4f}); puerta poly {tg:.5f}")
P("\n# Potencia y corriente para +200 K y +400 K en el OBJETIVO (lineal; calefactor n+ poly 48.2 ohm/sq w=0.5 -> 96.4 ohm/um;")
P("# límite de tensión: 1.8 V sobre la longitud del calefactor). 'T_cal' = subida del propio calefactor.")
P("# objetivo | k_ox d | dT_obj | W/m total | mW por um | I por calefactor mA | V/um | T_cal K | longitud máx a 1.8 V um")
for kox in (1.0, 1.4):
    for d in (0.21, 0.5, 1.0):
        for kind, name in (("poly", "poly central"), ("si", "canal Si")):
            th, tpz = rows[(kox, d, kind)]
            for dT in (200, 400):
                Pl = dT/tpz; I = np.sqrt(Pl/2/96.4e6); V = I*96.4e6*1e-6
                P(f"{name} | {kox} {d} | {dT} | {Pl:.3g} | {Pl*1e-3:.3g} | {I*1e3:.2f} | {V:.2f} | {th*Pl:.0f} | {1.8/V:.2f}")
P("\n# El calefactor mismo: +200/+400/+700 K")
for kox in (1.0, 1.4):
    th = rows[(kox, 0.5, "poly")][0]*2   # K por W/m de UN calefactor
    for dT in (200, 400, 700):
        Pl = dT/th; I = np.sqrt(Pl/96.4e6)
        P(f"k_ox {kox}: +{dT} K con {Pl*1e-3:.2f} mW/um, I={I*1e3:.2f} mA, {I*96.4:.2f} V/um, J={I/(0.5e-4*0.18e-4)/1e6:.1f} MA/cm2")
P("\n# 3D: transistor en silicio masivo, fuente de potencia P en un disco de radio a sobre semiespacio: dT = P/(4 k a).")
for a in (1, 5, 20):
    for dT in (200, 400):
        P(f"radio {a} um, +{dT} K: P = {4*150*a*1e-6*dT*1e3:.0f} mW (k=150) .. {4*75*a*1e-6*dT*1e3:.0f} mW (k=75, silicio caliente)")
P("# Comparación leída: polyheater de Aichinger/Pobegen ~55 K/W, 4.2 W para +250 K (leído-resumen por agente).")
P("\n# Tiempos (cálculo): difusión en óxido h^2/alpha con alpha=8e-7 m2/s: 0.326 um -> %.2f us; 0.94 um -> %.2f us; silicio 5 um (alpha 8.8e-5): %.2f us" % ((0.326e-6)**2/8e-7*1e6, (0.94e-6)**2/8e-7*1e6, (5e-6)**2/8.8e-5*1e6))
open("c59_1_termico.txt", "w").write("\n".join(out)+"\n"); print("\n".join(out))
