# v3_post.py — DESPUÉS de leer los informes (19:52). (1) capas presentes en una wafflecap y una fingercap shieldl1; (2) B2 con pata p+ de 319,8 ohm/cuadro.
import sys, gdstk, collections, warnings
warnings.simplefilter("ignore")
lib = gdstk.read_gds(sys.argv[1])
for name in ("sky130_fd_pr__cap_vpp_05p9x05p9_m1m2m3m4_shieldl1_wafflecap", "sky130_fd_pr__cap_vpp_11p3x11p3_m1m2m3m4_shieldl1_wafflecap", "sky130_fd_pr__cap_vpp_02p7x06p1_m1m2m3m4_shieldl1_fingercap"):
    c = [c for c in lib.cells if c.name == name][0]; cnt = collections.Counter((p.layer, p.datatype) for p in c.get_polygons(depth=None))
    print(name, "refs:", len(c.references), "capas:", sorted(cnt.items()))
import numpy as np
print("B2 con pata n+ 48,2 y pata p+ 319,8 ohm/cuadro (misma geometría y G'): b = (b_n + b_p)/2; S=300 uV/K; G' de v3_salida (kox 1,0/1,4)")
TP = 0.18e-6
for w, Gs in ((0.15, (2.92, 4.08)), (0.5, (4.24, 5.92)), (1.0, (5.95, 8.30))):
    for kp in (15.0, 30.0):
        for G in Gs:
            Rth = 1 / (2 * np.sqrt(kp * w * 1e-6 * TP * G)); a = 300e-6 * 300 * Rth; b = (48.2 + 319.8) / 2 / (w * 1e-6 * G)
            for lab, bb in (("sin Rc", b), ("con 2x152 ohm", b + 304 * Rth)):
                print(f"  w={w} kp={kp:.0f} G'={G}: {lab}: I*={a/(2*bb)*1e6:.0f} uA, neto {a*a/(4*bb):.2f} K, cruce {a/bb*1e6:.0f} uA", end=" |")
            print()
