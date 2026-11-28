"""MISFIT-28, enmienda 1: el analisis sellado (analiza28.py, sin tocar) leyendo el rango bajo de e1/ (paso maximo <= 0,1 us)
y el resto (rango alto, zero, largo, testigos, fisico) de la primera pasada. Despues, el control de convergencia E0.
Uso: python3 analiza28e.py > m28e.txt"""
import os, runpy, gen28 as g, gen28e as e
from lee28 import lee
orig = g.nombre
g.nombre = lambda grp, c, t, rng, k, i, kw: e.nombre_e(grp, c, t, rng, k, i, kw) if e.es_e(grp, rng) else orig(grp, c, t, rng, k, i, kw)
print("# enmienda 1: rango bajo de e1/ (paso <= 0,1 us); rango alto, zero, largo, testigos y fisico de la primera pasada")
runpy.run_path(os.path.join(g.H, "analiza28.py"), run_name="__main__")
print("\n## E0: convergencia en el paso, 316 pA, paso 0,1 us frente a 0,03 us"); ok = []
for x in e.lista_fino():
    _, c, t, rng, k, i, kw = x; a = lee(os.path.join(e.nombre_e("a", c, t, rng, k, i, kw), "lec.log")); b = lee(os.path.join(e.nombre_e(*x), "lec.log"))
    if "T" in a and "T" in b:
        d = (a["T"] / b["T"] - 1) * 100; bien = abs(d) <= 0.1 and len(b["ed"]) == 18 and not b["medias"] and b["fin"] == "salida 0"
        print(f"  {c} {t}: T {a['T']:.9e} frente a {b['T']:.9e}, diferencia {d:+.4f} %, fino con {len(b['ed'])} flancos, a medias {b['medias']} -> {'bien' if bien else 'MAL'}")
    else: bien = False; print(f"  {c} {t}: falta periodo ({a['fin']} / {b['fin']}) -> MAL")
    ok.append(bien)
print(f"E0 (periodo igual dentro de 0,1 % y 18 flancos limpios con el paso fino, 4 esquinas): {'cumplida' if len(ok) == 4 and all(ok) else 'FALSA'} ({sum(ok)} de 4)")
