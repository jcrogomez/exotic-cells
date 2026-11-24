"""I3: cuenta los cambios de cada red del nucleo dentro de cada ventana [inicio + 1 ciclo, subida del ultimo de xa/xb], leidos del VCD.
Ventanas de i3_sim.txt. Salida: i3.txt (veredicto) e i3_redes.tsv (cambios por red en la ventana de src = 01, para I4)."""
import re, collections
W = {}
for l in open("i3_sim.txt"):
    m = re.match(r"(VENTANA|XB) src=(\d+) .*?(\d+)$", l.strip())
    if m: W.setdefault(m.group(2), {})[m.group(1)] = int(m.group(3))
win = {s: (v["VENTANA"] + 20000, v["XB"]) for s, v in W.items()}
ids = {}; scope = []
cnt = {s: collections.Counter() for s in win}
t = 0
with open("i3.vcd") as f:
    for l in f:
        if l.startswith("$scope"): scope.append(l.split()[2]); continue
        if l.startswith("$upscope"): scope.pop(); continue
        if l.startswith("$var"):
            p = l.split(); ids.setdefault(p[3], []).append(".".join(scope[1:] + [p[4]])); continue
        if l.startswith("#"): t = int(l[1:]); continue
        if not l or l[0] in "$ \n": continue
        if l[0] in "01xzXZ": k = l[1:].strip()
        elif l[0] in "bB": k = l.split()[1]
        else: continue
        for s, (a, b) in win.items():
            if a <= t <= b:
                for n in ids.get(k, []): cnt[s][n] += 1
PORTS = ["s0_prea", "s0_preb", "s0_vbias", "s0_c1", "s0_duta", "s0_dutb", "s0_refa", "s0_refb", "s0_sa0b", "s0_sa1b", "s0_sa2b", "s0_sb0b", "s0_sb1b"]
out = []
bad = 0
for s, (a, b) in sorted(win.items()):
    dec = {p: cnt[s]["dut." + p] for p in PORTS}
    assert all(("dut." + p) in {n for l in ids.values() for n in l} for p in PORTS), "linea del decodificador ausente del VCD"
    bad += sum(dec.values())
    tog = [n for n, c in cnt[s].items() if c > 0]
    out.append(f"src={s}: ventana {a/1e6:.3f}-{b/1e6:.3f} us ({(b-a)/20000:.0f} ciclos); cambios en las 13 lineas del decodificador: {sum(dec.values())}; redes del nucleo que cambian: {len(tog)}; cambios totales: {sum(cnt[s].values())}")
    top = cnt[s].most_common(12)
    out.append("   las que mas cambian: " + ", ".join(f"{n} {c}" for n, c in top))
out.append(f"I2/I3 veredicto: cambios del decodificador en las tres ventanas = {bad} (prediccion 0) -> {'cumplida' if bad == 0 else 'FALSA'}")
open("i3.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
with open("i3_redes.tsv", "w") as f:
    for n, c in sorted(cnt["01"].items(), key=lambda x: -x[1]): f.write(f"{n}\t{c}\n")
