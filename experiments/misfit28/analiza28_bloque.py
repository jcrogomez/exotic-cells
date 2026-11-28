"""MISFIT-28, parte fisica: revision del bloque con el lazo v2. Escrito antes de correr. Uso: analiza28_bloque.py > m28_bloque.txt
La revision red por red de misfit25/analiza25.py con la tabla del lazo v2 (18 celdas: u_s1 pasa a inv_4, entra u_k) y la
comprobacion de que el unico nodo con dos conductores es c2 (el aviso de Yosys que el flujo deja pasar)."""
import os, re, sys
H = os.path.dirname(os.path.abspath(__file__))
src = open(os.path.join(H, "..", "misfit25", "analiza25.py")).read().split("\nR = {")[0].replace("misfit25_r2_{v}{SUF}", "misfit28_r2_{v}").replace("assert len(LOOP) == 17", "pass")
sys.argv = sys.argv[:1]; ns = {}; exec(src, ns)
ns["LOOP"].update({"u_s1": "inv_4", "u_k": "inv_1"}); ns["FAN"].update({"u_loop.c2": 3, "u_loop.s": 3}); assert len(ns["LOOP"]) == 18
o = ns["mira"]("a"); LF = ns["LF"]
if "met" not in o: print("NO termina:", o.get("why")); print("H1 (cierra limpio): FALSA"); sys.exit()
print(f"metricas: {o['met']} | caja {o.get('bbox')} | area {o.get('area')} um2 | instancias {o.get('celdas')}")
print(f"celdas del lazo: {len(o.get('loop', {}))} de 18; tipos distintos del RTL: {o.get('tipos_mal') or 'ninguno'}"); print(f"redes del lazo con otro numero de conexiones: {o.get('fan_mal') or 'ninguna'}")
print(f"bufer, retardo o diodo fuera del lazo: {o.get('extra') or 'ninguno'}")
log = open(f"{LF}/misfit28_r2_a/runs/core/02-yosys-synthesis/yosys-synthesis.log", errors="replace").read()
md = set(re.findall(r"multiple conflicting drivers for (\S+?):", log)); solo = md == {"reader2_loop.\\c2", "reader2_slot.\\u_loop.c2"} or md == {"reader2_slot.\\u_loop.c2"}
print(f"avisos de doble conductor: {sorted(md)}"); print(f"conductores multiples solo en c2: {'si' if solo else 'NO'}")
h1 = o.get("limpio") is True; h2 = o.get("ok") and len(o["loop"]) == 18 and not o["tipos_mal"] and not o["fan_mal"] and not o["extra"]
print(f"H1 (cierra limpio): {'cumplida' if h1 else 'FALSA'}"); print(f"H2 (lazo intacto y sin buferes): {'cumplida' if h2 else 'FALSA'}")
