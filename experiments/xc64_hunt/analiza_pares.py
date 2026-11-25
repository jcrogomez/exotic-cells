"""XC-64 caza sistematica: islas por pareja de capas. Escrito ANTES de ver pares.csv. Salida: pares.txt
Limpio = las reglas violadas en v estan contenidas en las del punto lejano (3,0 um). Isla = tramo limpio que no toca v = 0,400."""
import os, collections
H = os.path.dirname(os.path.abspath(__file__))
D = collections.defaultdict(dict)
for l in open(os.path.join(H, "pares.csv")).read().splitlines()[1:]:
    ctx, a, b, v, n, rules = l.split(";", 5)
    D[(ctx, a, b)][float(v)] = frozenset(x.strip() for x in rules.split("|") if x.strip())
ESPERADAS = {("well", "pdiff", "nsubdiff"), ("sub", "ndiff", "psubdiff"), ("well", "mvpdiff", "mvnsubdiff"), ("sub", "mvndiff", "mvpsubdiff")}
o = [f"# XC-64 caza sistematica · analiza_pares.py · {len(D)} escaneos"]
islas = []; fus = []; incompletos = 0; nunca = 0
for k, d in sorted(D.items()):
    if 3.0 not in d or len(d) < 82: incompletos += 1; continue
    far = d[3.0]; vs = sorted(v for v in d if v < 1); limpio = [d[v] <= far for v in vs]
    if not any(limpio): nunca += 1
    seg = []; a = None
    for v, okk in zip(vs, limpio):
        if okk and a is None: a = v
        if not okk and a is not None: seg.append((a, prev)); a = None
        prev = v
    if a is not None: seg.append((a, vs[-1]))
    for s in seg:
        if abs(s[1] - 0.400) > 1e-9:
            extra = sorted(set().union(*[d[v] - far for v in vs if not d[v] <= far]))
            (fus if k[1] == k[2] else islas).append((k, s, extra))
o.append(f"escaneos incompletos: {incompletos}; parejas que nunca quedan limpias ni a 0,400: {nunca}")
o.append("\n## Fusiones (una capa consigo misma; triviales)")
for k, s, e in fus: o.append(f"  {k[0]:4s} {k[1]:11s} limpio en [{s[0]:.3f}, {s[1]:.3f}]")
o.append("\n## Islas entre capas distintas")
enc = set()
for k, s, e in islas:
    enc.add(k); tag = "esperada" if k in ESPERADAS else "NO ESPERADA"
    o.append(f"  {k[0]:4s} {k[1]:11s} {k[2]:11s} limpio en [{s[0]:.3f}, {s[1]:.3f}]  <- {tag}; reglas que la rodean: {'; '.join(x[:60] for x in e[:3])}")
o.append("\n## Veredicto")
falt = ESPERADAS - enc; extra = enc - ESPERADAS
o.append(f"testigo XC-20 (pdiff, nsubdiff en pozo, isla en 0): {'aparece' if ('well','pdiff','nsubdiff') in enc else 'NO APARECE: benchmark invalido'}")
o.append(f"islas esperadas que faltan: {sorted(falt) if falt else 'ninguna'}")
o.append(f"islas no esperadas: {len(extra)}" + ("" if not extra else " -> " + ", ".join(f"{c}:{a}/{b}" for c, a, b in sorted(extra))))
o.append("Prediccion (exactamente las cuatro esperadas): " + ("cumplida" if not falt and not extra else "FALSA"))
open(os.path.join(H, "pares.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
