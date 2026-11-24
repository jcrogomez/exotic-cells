"""Capacidad extraida de cada nodo de placa (xc19_slot_core_lod.inc): total, a GND y a su X. u = total - acople a X."""
import re, collections
tot = collections.defaultdict(float); pair = collections.defaultdict(float)
def val(s):
    m = re.match(r"([\d.eE+-]+)([a-zA-Z]*)", s); u = m[2].lower()[:1]
    return float(m[1]) * {"f": 1e-15, "a": 1e-18, "p": 1e-12, "": 1}[u]
for l in open("xc19_slot_core_lod.inc"):
    if l.startswith("C"):
        f = l.split(); v = val(f[3]); tot[f[1]] += v; tot[f[2]] += v; pair[tuple(sorted((f[1], f[2])))] += v
for l in open("xc19_slot_core_lod.inc"):
    f = l.split()
    if l.startswith("X") and "pfet_01v8 " in l and "w=0.42 l=0.15" in l:
        x = f[1] if f[1] in ("XA", "XB") else f[3]; s = f[3] if x == f[1] else f[1]
        cx = pair[tuple(sorted((s, x)))]
        print(f"{f[2]:5} total {tot[s]*1e15:6.3f} fF  a GND {pair[tuple(sorted((s,'GND')))]*1e15:6.3f}  a {x} {cx*1e15:6.3f}  u = {(tot[s]-cx)*1e15:6.3f} fF")
print(f"XA total {tot['XA']*1e15:.3f} fF, XB total {tot['XB']*1e15:.3f} fF, XA-XB {pair[('XA','XB')]*1e18:.1f} aF")
