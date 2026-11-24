"""I4: acoplo de la tira S7 y de la placa S8 a XA, de la extraccion plana de esos tiles (ext/S7, ext/S8).
La red sabotaje es la red nueva (no presente en el sano) con mayor acoplo a XA. Salida: caps_s78.json y caps_s78.txt"""
import re, collections, json
def val(s):
    m = re.match(r"([\d.eE+-]+)([a-zA-Z]*)", s); return float(m[1]) * {"f": 1e-15, "a": 1e-18, "p": 1e-12, "": 1.0}[m[2][:1].lower()]
def caps(fn):
    C = collections.defaultdict(float)
    for l in open(fn):
        p = l.split()
        if l[:1] == "C" and len(p) >= 4:
            a, b = p[1].replace("/", "."), p[2].replace("/", "."); C[(a, b)] += val(p[3]); C[(b, a)] += val(p[3])
    return C
XA = "xc19_slot_w_0.xc19_slot_core_0.XA"
ok = caps("ext/tile_flat.pex.spice"); okn = {a for a, b in ok}
R, txt = {}, []
for V in ("S7", "S8"):
    C = caps(f"ext/{V}/tile_flat.pex.spice")
    new = sorted(((b, v) for (a, b), v in C.items() if a == XA and b not in okn), key=lambda x: -x[1])
    net, cxa = new[0]
    tot = sum(v for (a, b), v in C.items() if a == net)
    R[f"{V}_XA"] = cxa; R[f"{V}_rest"] = tot - cxa
    txt.append(f"{V}: red {net} · a XA {cxa*1e18:.2f} aF · resto {(tot-cxa)*1e18:.2f} aF · XA total sano {sum(v for (a,b),v in ok.items() if a==XA)*1e15:.3f} fF, {V} {sum(v for (a,b),v in C.items() if a==XA)*1e15:.3f} fF")
    txt.append("   otras redes nuevas acopladas a XA: " + ", ".join(f"{b} {v*1e18:.2f} aF" for b, v in new[1:4]))
json.dump(R, open("caps_s78.json", "w"), indent=1); open("caps_s78.txt", "w").write("\n".join(txt) + "\n"); print("\n".join(txt))
