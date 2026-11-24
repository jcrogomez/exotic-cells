"""I4: forma de onda de cada agresor de reloj del VCD de I3 (ventana src = 01), en tiempo relativo a la subida de prea
(la suelta de la precarga). Salida: ondas.json {red: [valor inicial, [t_ns, ...]]}"""
import json, re
REDES = {"misfit04_core_0._0685_.Y": ("_0685_", "Y")}
t0 = None
for l in open("../i3/i3_sim.txt"):
    m = re.match(r"VENTANA src=01 inicio (\d+)", l)
    if m: t0 = int(m.group(1))
t1 = t0 + 30_000_000                                      # 30 us
ids, scope, cur = {}, [], {}
with open("../i3/i3.vcd") as f:
    for l in f:
        if l.startswith("$scope"): scope.append(l.split()[2]); continue
        if l.startswith("$upscope"): scope.pop(); continue
        if l.startswith("$var"):
            p = l.split()
            for k, (inst, port) in REDES.items():
                if scope[-1] == inst and p[4] == port and len(scope) == 3: ids[p[3]] = k
            continue
        if l.startswith("$enddefinitions"): break
    out = {k: [None, []] for k in REDES}; t = 0
    for l in f:
        if l[0] == "#": t = int(l[1:]); continue
        if l[0] in "01" and l[1:].strip() in ids:
            k = ids[l[1:].strip()]
            if t < t0: out[k][0] = int(l[0])
            elif t <= t1: out[k][1].append(round((t - t0) / 1000, 3))
json.dump(out, open("ondas.json", "w"))
for k, (v0, ts) in out.items(): print(k, "inicial", v0, "cambios", len(ts), "primeros", ts[:6], "ultimo", ts[-1] if ts else None)
