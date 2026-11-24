"""I4, paso 1: acoplo extraido (Magic, tile completo) de XA, XB, XA_OUT (s0_xa) y XB_OUT (s0_xb) con cada otra red.
b1: total por nodo en plano frente a jerarquico. Cada red agresora se clasifica con el VCD de I3: cambia en la ventana o no.
Salida: acoplo.txt y agresores.json (redes que cambian con C >= 1 aF a algun nodo medido)."""
import re, collections, json
def val(s):
    m = re.match(r"([\d.eE+-]+)([a-zA-Z]*)", s); return float(m[1]) * {"f": 1e-15, "a": 1e-18, "p": 1e-12, "": 1.0}[m[2][:1].lower()]
def caps(fn, norm):
    C = collections.defaultdict(float)
    for l in open(fn):
        if l[:1] != "C": continue
        p = l.split()
        if len(p) < 4: continue
        a, b, v = norm(p[1]), norm(p[2]), val(p[3])
        C[(a, b)] += v; C[(b, a)] += v
    return C
nf = lambda s: s.replace("/", ".")
F = caps("ext/tile_flat.pex.spice", nf); H = caps("ext/tile_hier.pex.spice", nf)
T = {"XA": "xc19_slot_w_0.xc19_slot_core_0.XA", "XB": "xc19_slot_w_0.xc19_slot_core_0.XB", "XA_OUT": "misfit04_core_0.s0_xa", "XB_OUT": "misfit04_core_0.s0_xb"}
HT = {"XA": "xc19_slot_w_0.xc19_slot_core_0.XA", "XB": "xc19_slot_w_0.xc19_slot_core_0.XB", "XA_OUT": "xc19_slot_w_0.XA_OUT", "XB_OUT": "xc19_slot_w_0.XB_OUT"}
VARS = set()
scope = []
for l in open("../i3/i3.vcd"):
    if l.startswith("$enddefinitions"): break
    if l.startswith("$scope"): scope.append(l.split()[2])
    elif l.startswith("$upscope"): scope.pop()
    elif l.startswith("$var"): VARS.add(".".join(["misfit04_core_0"] + scope[2:] + [l.split()[4]]))
tog = {}
for l in open("../i3/i3_redes.tsv"):
    n, c = l.rstrip("\n").split("\t"); tog[n.replace("dut.", "misfit04_core_0.", 1)] = int(c)
def toggles(net):
    if net in tog: return tog[net]
    if net in VARS: return 0            # existe en el VCD y no cambio en la ventana
    return None
out = ["# I4 paso 1 · acoplo extraido a los nodos medidos (tile completo, Magic, cthresh 0)", ""]
out.append("b1, total de capacidad por nodo (fF), plano frente a jerarquico:")
b1ok = True
for k in T:
    tf = sum(v for (a, b), v in F.items() if a == T[k]); th = sum(v for (a, b), v in H.items() if a == HT[k])
    d = abs(tf - th) / max(tf, 1e-30)
    b1ok &= d <= 0.05
    out.append(f"  {k}: plano {tf*1e15:.3f} · jerarquico {th*1e15:.3f} · diferencia {100*d:.2f} % ({'<= 5 %' if d <= 0.05 else '> 5 %: se usa el plano'})")
ag = {}
for k, n in T.items():
    rows = sorted(((b, v) for (a, b), v in F.items() if a == n and b != n), key=lambda x: -x[1])
    out.append(f"\n{k} ({n}): {len(rows)} redes acopladas, total {sum(v for _, v in rows)*1e15:.3f} fF")
    for b, v in rows[:25]:
        t = toggles(b)
        tag = "a tierra/sustrato" if b in ("0", "VGND", "GND") else ("cambia en la ventana (%d)" % t if t else ("quieta" if t == 0 else "sin dato en el VCD (no es red del nucleo)"))
        out.append(f"   {v*1e18:9.2f} aF  {b}  [{tag}]")
        if t and v >= 1e-18: ag.setdefault(k, []).append([b, v, t])
out.append(f"\nb1 -> {'pasa' if b1ok else 'algun nodo difiere > 5 %: se usa la extraccion plana, como dice el prerregistro'}")
out.append("agresores (cambian en la ventana, >= 1 aF): " + ", ".join(f"{k}: {len(v)}" for k, v in ag.items()))
open("acoplo.txt", "w").write("\n".join(out) + "\n"); json.dump(ag, open("agresores.json", "w"), indent=1)
print("\n".join(out))
