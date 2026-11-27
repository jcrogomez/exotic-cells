"""MISFIT-25: veredictos H1..H4. Escrito antes de ninguna corrida. Uso: analiza25.py [sufijo] > m25<sufijo>.txt
Lee local_flow/misfit25_r2_<v><sufijo>/runs/core/final: metrics.json y el netlist final (nl/ o pnl/)."""
import glob, json, os, re, sys
LF = "/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow"; SUF = sys.argv[1] if len(sys.argv) > 1 else ""
LOOP = {"u_cmp": "inv_1", "u_s1": "inv_1", "u_s2": "inv_1", "u_q": "nor2_1", "u_qb": "nor2_1", "u_ie": "inv_1", "u_ir": "inv_1", "u_gl": "a21oi_4", "u_gh": "nand3_4"}
LOOP.update({f"u_d{k}": "dlygate4sd3_1" for k in range(8)}); assert len(LOOP) == 17
FAN = {"x": 1, "u_loop.q": 6, "prenh": 1, "prenl": 1}
FAN.update({f"u_loop.{n}": 2 for n in ("c", "c2", "s", "qb", "r", "enb", "rsb")}); FAN.update({f"u_loop.d[{k}]": 2 for k in range(7)})
ALIAS = {"q": "u_loop.q", "u_loop.x": "x", "u_loop.prenh": "prenh", "u_loop.prenl": "prenl"}


def netlist(d):
    fs = sorted(glob.glob(d + "/runs/core/final/nl/*.v")) or sorted(glob.glob(d + "/runs/core/final/pnl/*.v"))
    if not fs: return None, None
    t = open(fs[0]).read(); inst = []
    for m in re.finditer(r"\n\s*(sky130_fd_sc_hd__\w+)\s+(\\?\S+)\s*\((.*?)\);", t, re.S):
        pins = {p: n.strip().lstrip("\\").strip() for p, n in re.findall(r"\.(\w+)\(\s*([^()]*?)\s*\)", m.group(3))}
        inst.append((m.group(1)[len("sky130_fd_sc_hd__"):], m.group(2).lstrip("\\"), pins))
    return inst, fs[0]


def mira(v):
    d = f"{LF}/misfit25_r2_{v}{SUF}"; mf = d + "/runs/core/final/metrics.json"; o = {"v": v, "ok": False}
    if not os.path.exists(mf):
        log = open(d + "_harden.log", errors="replace").read() if os.path.exists(d + "_harden.log") else ""
        errs = re.findall(r"(?:ERROR|\[ERROR[^\]]*\])[^\n]*", log); last = [l for l in log.splitlines() if l.strip()][-1:] or [""]
        o["why"] = (errs[0] if errs else "sin metricas")[:160] + " | ultima linea: " + last[0][:100]; return o
    m = json.load(open(mf)); keys = ("magic__drc_error__count", "design__lvs_error__count", "antenna__violating__nets")
    o["met"] = {k: m.get(k, "AUSENTE") for k in keys}; o["limpio"] = all(m.get(k, "AUSENTE") == 0 for k in keys)
    bb = m.get("design__die__bbox"); o["bbox"] = bb
    if bb: x0, y0, x1, y1 = (float(a) for a in str(bb).split()); o["area"] = (x1 - x0) * (y1 - y0)
    o["celdas"] = m.get("design__instance__count__stdcell")
    inst, f = netlist(d); o["nl"] = f
    if inst is None: return o
    o["ok"] = True; loop = {}
    for cell, name, pins in inst:
        k = name.split(".")[-1]
        if name.startswith("u_loop.") and k in LOOP: loop[k] = cell
    o["loop"] = loop; o["tipos_mal"] = {k: (loop.get(k), LOOP[k]) for k in LOOP if loop.get(k) != LOOP[k]}
    fan = {n: [] for n in FAN}
    for cell, name, pins in inst:
        for p, n in pins.items():
            n = ALIAS.get(n, n)
            if n in fan: fan[n].append(f"{name}:{cell}.{p}")
    o["fan"] = fan; o["fan_mal"] = {n: fan[n] for n in FAN if len(fan[n]) != FAN[n]}
    o["extra"] = sorted({i[1] + ":" + i[0] for i in inst if re.search(r"buf|dly|diode", i[0]) and not (i[1].startswith("u_loop.") and i[1].split(".")[-1] in LOOP)})
    return o


R = {v: mira(v) for v in ("prot", "libre")}
for v, o in R.items():
    print(f"## {v}")
    if "met" not in o: print("  NO termina:", o.get("why")); continue
    print(f"  metricas: {o['met']} | caja {o.get('bbox')} | area {o.get('area')} um2 | instancias {o.get('celdas')}")
    if not o["ok"]: print("  sin netlist final"); continue
    print(f"  netlist: {os.path.relpath(o['nl'], LF)}"); print(f"  celdas del lazo encontradas: {len(o['loop'])} de {len(LOOP)}; tipos distintos del RTL: {o['tipos_mal'] or 'ninguno'}")
    print(f"  redes del lazo con otro numero de conexiones: {o['fan_mal'] or 'ninguna'}"); print(f"  bufer, retardo o diodo fuera de las celdas del lazo: {o['extra'] or 'ninguno'}")
p, l = R["prot"], R["libre"]
h1 = p.get("limpio") is True; h2 = p.get("ok") and len(p["loop"]) == len(LOOP) and not p["tipos_mal"] and not p["fan_mal"]
h3 = "area" in p and 1000 <= p["area"] <= 3000; h4 = l.get("ok") and bool(l["tipos_mal"] or l["fan_mal"])
print("\n## Veredictos")
print(f"H1 (prot cierra limpio): {'cumplida' if h1 else 'FALSA'}"); print(f"H2 (el lazo sobrevive intacto en prot): {'cumplida' if h2 else 'FALSA'}")
print(f"H3 (area entre 1000 y 3000 um2): {'cumplida' if h3 else 'FALSA'} ({p.get('area')})"); print(f"H4 (testigo: en libre cambia algo del lazo): {'cumplida' if h4 else 'FALSA'}")
print("prueba:", "valida" if "met" in l else "INVALIDA o por revisar: libre no termina (ver causa arriba)")
