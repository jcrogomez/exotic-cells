"""XC-64 caza por cruce de bordes y relectura de la caza por parejas con el criterio corregido (enmienda 1). Salida: cruces.txt
Limpio = todas las reglas violadas son de presencia de toma (LU.x, nwell.4)."""
import os, re, collections
H = os.path.dirname(os.path.abspath(__file__))
TOMA = re.compile(r"\(LU\.\d+\)|\(nwell\.4\)")
limpio = lambda rules: all(TOMA.search(r) for r in rules)
o = ["# XC-64 · analiza_cruces.py · limpio = solo reglas de presencia de toma (LU.x, nwell.4)"]
# --- relectura de la caza por parejas (analisis posterior, declarado)
P = collections.defaultdict(dict)
for l in open(os.path.join(H, "pares.csv")).read().splitlines()[1:]:
    ctx, a, b, v, n, rules = l.split(";", 5); P[(ctx, a, b)][float(v)] = [x.strip() for x in rules.split("|") if x.strip()]
o.append("\n## Caza por parejas, releida con el criterio corregido (posterior)")
isl = []
for k, d in sorted(P.items()):
    if k[1] == k[2]: continue
    vs = sorted(v for v in d if v < 1); c = [limpio(d[v]) for v in vs]
    if c[0] and not all(c): isl.append((k, max(v for v, x in zip(vs, c) if x and v < min([w for w, y in zip(vs, c) if not y]))))
for k, hi in isl: o.append(f"  {k[0]:4s} {k[1]:11s} {k[2]:11s} isla limpia en [0.000, {hi:.3f}]")
o.append(f"  total: {len(isl)} (se esperaban 4)")
# --- cruces
C = collections.defaultdict(dict)
for l in open(os.path.join(H, "cruces.csv")).read().splitlines()[1:]:
    ctx, a, b, s, n, rest = l.split(";", 5); rules = rest.rsplit(";", 1)[0]
    C[(ctx, a, b)][float(s)] = [x.strip() for x in rules.split("|") if x.strip()]
ESP = lambda a, b: a in ("locali", "metal1") or b in ("locali", "metal1") or {a, b} == {"poly", "nwell"}
o.append(f"\n## Caza por cruce de bordes: {len(C)} escaneos. A = rectangulo de 2 um; B = 0,5 um, sobresale s de A")
hall = []; esp_ok = 0; esp_no = []
for k, d in sorted(C.items()):
    ss = sorted(s for s in d if 0 < s < 0.5); cl = [s for s in ss if limpio(d[s])]
    if ESP(k[1], k[2]):
        if cl: esp_ok += 1
        else: esp_no.append(k)
    elif cl:
        hall.append((k, cl, limpio(d[0.0]), limpio(d[0.5]), limpio(d[-9.0])))
o.append(f"parejas esperadas (con locali, metal1, o poly/nwell): {esp_ok} con puntos a caballo limpios; sin ninguno: {len(esp_no)} {[f'{c}:{a}/{b}' for c,a,b in esp_no][:8]}")
t = C.get(("sub", "ndiff", "metal1"), {}); tw = [s for s in t if 0 < s < 0.5 and limpio(t[s])]
o.append(f"testigo (metal1 a caballo de ndiff, sustrato): {len(tw)} puntos limpios -> {'ok' if tw else 'FALLA: caza invalida'}")
o.append(f"\n## Parejas NO esperadas con puntos a caballo limpios: {len(hall)}")
for k, cl, i0, i5, far in hall:
    o.append(f"  {k[0]:4s} A={k[1]:11s} B={k[2]:11s} limpio para s en [{cl[0]:.2f}, {cl[-1]:.2f}] ({len(cl)} de 49 puntos); B dentro: {'limpio' if i0 else 'no'}; B fuera pegado: {'limpio' if i5 else 'no'}; lejos: {'limpio' if far else 'no'}")
o.append("\nPrediccion (ninguna pareja no esperada): " + ("cumplida" if not hall else "FALSA: cada una se mira en el GDS antes de creerla"))
open(os.path.join(H, "cruces.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
