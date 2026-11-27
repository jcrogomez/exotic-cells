"""MISFIT-27, parte 1: veredictos H1..H3 del bloque recolocado. Escrito antes de correr. Uso: analiza27.py <etiqueta> > m27_<etiqueta>.txt
Reutiliza la revision red por red de misfit25/analiza25.py (funcion mira) sobre local_flow/misfit27_r2_<etiqueta>."""
import os, re, sys
H = os.path.dirname(os.path.abspath(__file__)); tag = sys.argv[1]; PRE = os.environ.get("M27_PRE", "misfit27_r2_")   # M27_PRE=misfit25_r2_ para probar el guion sobre el bloque de MISFIT-25
src = open(os.path.join(H, "..", "misfit25", "analiza25.py")).read().split("\nR = {")[0].replace("misfit25_r2_{v}{SUF}", PRE + "{v}")
sys.argv = sys.argv[:1]; ns = {}; exec(src, ns); o = ns["mira"](tag); LF = ns["LF"]
if "met" not in o: print("NO termina:", o.get("why")); print("\n## Veredictos\nH1 (cierra limpio a la primera): FALSA\nH2: sin bloque\nH3: sin bloque"); sys.exit()
print(f"metricas: {o['met']} | caja {o.get('bbox')} | area {o.get('area')} um2 | instancias {o.get('celdas')}")
print(f"celdas del lazo: {len(o.get('loop', {}))} de 17; tipos distintos del RTL: {o.get('tipos_mal') or 'ninguno'}"); print(f"redes del lazo con otro numero de conexiones: {o.get('fan_mal') or 'ninguna'}")
print(f"bufer, retardo o diodo fuera del lazo: {o.get('extra') or 'ninguno'}")
# longitud de la red x en el DEF final
t = open(f"{LF}/{PRE}{tag}/runs/core/final/def/reader2_slot.def").read(); m = re.search(r"\n\s*- x \( PIN x \).*?;", t, re.S); lon = {}
if m:
    for seg in re.finditer(r"(met\d|li1)\s+(?:TAPER\s+)?((?:\(\s*[\d*]+\s+[\d*]+(?:\s+\d+)?\s*\)\s*)+)", m.group(0)):
        pts = re.findall(r"\(\s*([\d*]+)\s+([\d*]+)", seg.group(2)); px = py = None
        for a, b in pts:
            x = px if a == "*" else int(a); y = py if b == "*" else int(b)
            if px is not None: lon[seg.group(1)] = lon.get(seg.group(1), 0) + (abs(x - px) + abs(y - py)) / 1000
            px, py = x, y
tot = sum(lon.values()) if lon else None; print("red x, cable por capa (um):", lon or "no encontrada")
h1 = o.get("limpio") is True; h2 = o.get("ok") and len(o["loop"]) == 17 and not o["tipos_mal"] and not o["fan_mal"] and not o["extra"]
print("\n## Veredictos"); print(f"H1 (cierra limpio): {'cumplida' if h1 else 'FALSA'}"); print(f"H2 (lazo intacto y sin buferes): {'cumplida' if h2 else 'FALSA'}")
print(f"H3 (red x < 15 um): {'cumplida' if tot is not None and tot < 15 else 'FALSA'} ({tot})")
