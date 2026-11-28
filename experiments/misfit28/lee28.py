"""MISFIT-28: lector de un lec.log de gen28 (valores impresos con 'print', 12 cifras)."""
import re, statistics
def lee(f):
    r = {"ed": {}, "el": {}, "eh": {}, "ek": {}, "fin": "sin log", "medias": True}
    try: L = open(f, errors="replace").read().splitlines()
    except FileNotFoundError: return r
    r["fin"] = next((l.strip() for l in reversed(L) if l.strip()), "vacio")
    for l in L:
        m = re.match(r"^(ed|el|eh|ek)(\d+) = ([-+0-9.eE]+)", l)
        if m: r[m.group(1)][int(m.group(2))] = float(m.group(3)); continue
        m = re.match(r"^(txa|txb|qidle|xidle|xmin) = ([-+0-9.eE]+)", l)
        if m: r[m.group(1)] = float(m.group(2))
    e = r["ed"]; per = [e[n + 1] - e[n] for n in range(2, 12) if n in e and n + 1 in e]
    if len(per) == 10: r["T"] = statistics.mean(per); r["dis"] = statistics.stdev(per) / r["T"] * 100; r["pmin"] = min(per) / r["T"]; r["pmax"] = max(per) / r["T"]
    # pulso a medias: algun flanco n cuyas tres alturas no pertenecen al mismo flanco (mas de 20 ns entre 0,3 y 1,5 V), o cuentas distintas
    r["medias"] = (len(r["el"]) != len(e) or len(r["eh"]) != len(e)) or any(abs(r["eh"][n] - r["el"][n]) > 2e-8 for n in e if n in r["eh"] and n in r["el"])
    return r
