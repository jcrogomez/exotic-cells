"""MISFIT-21: acoplos a la puerta desde la extraccion. Uso: acoplos.py <carpeta>. Cg = area de puerta x 3,1 (grueso) o 8,3 (fino) fF/um2."""
import csv, sys, os
d = sys.argv[1]; seats = {int(r["seat"]): r for r in csv.DictReader(open(os.path.join(d, "xc14fg_seats.csv")))}
L = [l.split() for l in open(os.path.join(d, "xc14fg.pex.spice")) if l.strip()]; sw = {}; fg = {}; C = {}
for f in L:
    if f[0].startswith("X") and len(f) > 5 and f[2].startswith("SEL"): sw[f[3]] = int(f[2][3:])
for f in L:
    if f[0].startswith("X") and len(f) > 5 and f[1] == "X": fg[sw[f[3]]] = f[2]
for f in L:
    if f[0].startswith("C"):
        v = float(f[3].rstrip("f")); C.setdefault(f[1], {}); C.setdefault(f[2], {}); C[f[1]][f[2]] = C[f[1]].get(f[2], 0) + v; C[f[2]][f[1]] = C[f[2]].get(f[1], 0) + v
print(f"# {d}: capacidades extraidas en el nodo de puerta, fF")
print("puesto id      opcion  placa   C_CP1   C_CP2   C_X     C_resto  Cg     C_total  k_CP1   k_CP2   k_X")
for k in sorted(fg):
    r = seats[k]; n = fg[k]; c = C.get(n, {}); c1 = c.get("CP1", 0); c2 = c.get("CP2", 0); cx = c.get("X", 0); rest = sum(v for a, v in c.items() if a not in ("CP1", "CP2", "X"))
    cg = 0.42 * 0.5 * 3.1 if r["oxide"] == "thick" else 0.42 * 0.15 * 8.3; tot = c1 + c2 + cx + rest + cg
    print(f"{k:5d}  {r['id']:7s} {r['option'] or '-':6s} {float(r['ant_w_um']) * float(r['ant_h_um']):6.2f}  {c1:6.3f}  {c2:6.3f}  {cx:6.3f}  {rest:7.3f}  {cg:5.3f}  {tot:7.3f}  {c1 / tot:6.3f}  {c2 / tot:6.3f}  {cx / tot:6.4f}" + ("   (puerta = VB)" if n == "VB" else ""))
