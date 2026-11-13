"""c57_1: G' (W/m.K) de una pista de poly sobre óxido de campo y fracción de su temperatura que llega (a) a un
elemento de poly vecino sobre el mismo óxido, (b) a la superficie de una zona activa de silicio vecina (el termómetro
en inversión débil vive ahí), (c) a una puerta de poly encima de esa zona activa. Barrido: ancho, k del óxido, distancia."""
import numpy as np, c_lib as L
print("# c57_1_gprima.py — sección 2D, h=20 nm; k_si=150; potencia 1 W/m en la pista; dT en K por W/m")
print("w_um k_ox  G'(W/mK)  R'th(K.m/W)")
for kox in (1.0, 1.4):
    for w in (0.15, 0.35, 0.5, 1.0, 2.0):
        r = [(-w/2, w/2, L.H_FOX, L.H_FOX+L.T_POLY, 30.0)]
        x, y, T = L.solve2d(r, [(-w/2, w/2, L.H_FOX, L.H_FOX+L.T_POLY, 1.0)], k_ox=kox)
        dT = L.mean_in(x, y, T, -w/2, w/2, L.H_FOX, L.H_FOX+L.T_POLY)
        print(f"{w:4.2f} {kox:3.1f}  {1/dT:6.2f}   {dT:6.3f}")
print("\n# Acoplo a vecinos: pista calefactora w=0.5; vecino a distancia d (borde a borde)")
print("k_ox d_um  f_polyvecino  f_activa_Si(superficie, mesa 1um)  f_Si_bajo_calefactor")
for kox in (1.0, 1.4):
    for d in (0.21, 0.5, 1.0, 3.0):
        w = 0.5
        heater = (-w/2, w/2, L.H_FOX, L.H_FOX+L.T_POLY)
        # (a) vecino de poly flotante
        nb = (w/2+d, w/2+d+0.5, L.H_FOX, L.H_FOX+L.T_POLY)
        x, y, T = L.solve2d([heater+(30.0,), nb+(30.0,)], [heater+(1.0,)], k_ox=kox)
        th = L.mean_in(x, y, T, *heater); fa = L.mean_in(x, y, T, *nb)/th
        # (b) mesa activa de silicio de 1 um
        mesa = (w/2+d, w/2+d+1.0, 0.0, L.H_FOX)
        x, y, T = L.solve2d([heater+(30.0,), mesa+(150.0,)], [heater+(1.0,)], k_ox=kox)
        th2 = L.mean_in(x, y, T, *heater)
        fb = L.mean_in(x, y, T, mesa[0], mesa[1], L.H_FOX-0.04, L.H_FOX)/th2
        fc = L.mean_in(x, y, T, -w/2, w/2, -0.04, 0.0)/th2
        print(f"{kox:3.1f} {d:4.2f}   {fa:8.4f}      {fb:10.5f}                 {fc:8.5f}")
print("\n# Nota: el silicio 2D está anclado a 6 um de profundidad y a +-8 um; la subida absoluta del silicio depende de ese")
print("# anclaje (logarítmica). f_Si es por tanto un ORDEN DE MAGNITUD (factor ~2), no un número.")
