# Añade al LEF de las cabezas en cadena obstrucciones de met1 sobre los tramos rm1 entre almohadillas (y sobre el li1 de las cabezas),
# porque Magic (-hide) no los declara y el enrutador pasó met1 por encima (DRC "can't overlap those layers" en EFLD-01, corrida 1).
# Uso: python3 lef_obs_cadena.py entrada.lef salida.lef
import sys
src, dst = sys.argv[1], sys.argv[2]
s = open(src).read()
rects = []
for x0 in (0.0, 11.2):
    for i in range(8):
        y0 = 0.3 + 0.5 * i
        rects.append(f"        RECT {x0:.3f} {y0:.3f} {x0+1.2:.3f} {y0+0.2:.3f} ;")
extra = "      LAYER met1 ;\n" + "\n".join(rects) + "\n"
assert "  OBS\n" in s
s = s.replace("  OBS\n", "  OBS\n" + extra, 1)
open(dst, "w").write(s)
print("OBS añadidas:", len(rects))
