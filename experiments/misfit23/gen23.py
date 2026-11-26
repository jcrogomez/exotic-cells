"""MISFIT-23: el lector 2 con la parte analogica EXTRAIDA (misfit22/reader2fe, las dos precargas en el nodo) y la matriz xc20w.
Mismo lazo y mismos casos que MISFIT-17 (se importa su gen.py), sin formas, puesto 6 ni lector sin matriz.
Uso: gen23.py -> d/<rango>_<c><t>_<caso>_<I>/lec.sp. Imprime los 12 flancos: 'ED <n> <t>'. La precarga del otro rango queda en VDD."""
import os, re, sys
import importlib.util
H = os.path.dirname(os.path.abspath(__file__))
_sp = importlib.util.spec_from_file_location("gen17", os.path.join(H, "..", "misfit17", "gen.py")); G = importlib.util.module_from_spec(_sp); _sp.loader.exec_module(G)
DIV = 10                      # paso maximo = el de MISFIT-17 / DIV (enmienda 1 de MISFIT-17)
CASOS = {r: [x for x in G.CASOS[r] if x[0] in ("cal", "oos", "wit", "zero")] for r in G.LP}
PIN = {"bajo": "PRENL", "alto": "PRENH"}


def frente(rng):
    L = open(os.path.join(H, "..", "misfit22", "reader2fe", "reader2fe.pex.spice")).read().splitlines()
    mp = {"X": "o_x", "VDD": "vdd", "GND": "0", "PRENH": "vdd", "PRENL": "vdd"}; mp[PIN[rng]] = "o_pren"
    nd = lambda n: mp.get(n, "f_" + n.replace("#", "")); out = []; n = {"X": 0, "C": 0}
    for l in L:
        f = l.split()
        if not f or f[0][0] not in "XC": continue
        n[f[0][0]] += 1
        if f[0][0] == "X": out.append("Xf" + f[0][1:] + " " + " ".join(nd(a) for a in f[1:5]) + " " + " ".join(f[5:]))
        else: out.append("Cf" + f[0][1:] + f" {nd(f[1])} {nd(f[2])} {f[3]}")
    assert n["X"] == 9, n
    return out


def deck(c, t, rng, caso, i):
    s = G.deck(c, t, rng, caso, i).splitlines(); k = [j for j, l in enumerate(s) if l.split()[0] in ("Xo_c", "Xo_pre", "Xo_pre2")]
    assert len(k) == 3, k
    s = [l for j, l in enumerate(s) if j not in k]; j = s.index("Vd vdd 0 1.8"); s[j + 1:j + 1] = frente(rng)
    s[0] = s[0].replace("MISFIT-17", "MISFIT-23 (parte analogica extraida)")
    j = next(j for j, l in enumerate(s) if l.startswith("tran ")); f = s[j].split(); s[j] = f"tran {f[1]} {f[2]} 0 {float(f[4]) / DIV:.3e}"
    j = s.index("quit"); ex = []
    for n in range(1, 13): ex += [f"meas tran e{n} when v(o_q)=0.9 rise={n}", f"echo ED {n} $&e{n}"]
    s[j:j] = ex
    return "\n".join(s) + "\n"


if __name__ == "__main__":
    n = 0
    for c, t in G.CORN:
        for rng in G.LP:
            for caso, i in CASOS[rng]:
                d = os.path.join(H, "d", f"{rng}_{c}{t}_{caso}_{i:.4e}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write(deck(c, t, rng, caso, i)); n += 1
    print("decks:", n)
