"""MISFIT-24: el lazo del lector 2 con seleccion de rango y habilitacion en celdas de libreria.
Igual que MISFIT-23 (parte analogica extraida, matriz xc20w), cambiando el inversor que movia la linea de precarga por:
  PRENL = a21oi(q, /RS, /EN)   -> con EN = 0 la precarga larga queda encendida y sujeta el nodo en VDD
  PRENH = nand3(q, RS, EN)
Uso: gen24.py -> d/ (64 decks, puertas _4, EN fijo), dyn/ (8, EN sube y baja), f1/ (6, puertas _1, tt 27).
Imprime 'ED <n> <t>' (12 flancos) y, en dyn, 'DY <nombre> <valor>'."""
import os, importlib.util
H = os.path.dirname(os.path.abspath(__file__))
_sp = importlib.util.spec_from_file_location("gen23", os.path.join(H, "..", "misfit23", "gen23.py")); g23 = importlib.util.module_from_spec(_sp); _sp.loader.exec_module(g23)
G = g23.G; CASOS = g23.CASOS; MID = {"bajo": 3.1623e-9, "alto": 1e-6}; QEST = {"bajo": 55e-15, "alto": 185e-15}
SC = "sky130_fd_sc_hd__"


def frente():
    L = open(os.path.join(H, "..", "misfit22", "reader2fe", "reader2fe.pex.spice")).read().splitlines()
    mp = {"X": "o_x", "VDD": "vdd", "GND": "0", "PRENH": "o_prenh", "PRENL": "o_prenl"}
    nd = lambda n: mp.get(n, "f_" + n.replace("#", "")); out = []; n = 0
    for l in L:
        f = l.split()
        if not f or f[0][0] not in "XC": continue
        if f[0][0] == "X": n += 1; out.append("Xf" + f[0][1:] + " " + " ".join(nd(a) for a in f[1:5]) + " " + " ".join(f[5:]))
        else: out.append("Cf" + f[0][1:] + f" {nd(f[1])} {nd(f[2])} {f[3]}")
    assert n == 9, n
    return out


def tiempos(rng, i):
    T = QEST[rng] / i + 4e-9; return 3 * T, 19 * T, 23 * T, T


def deck(c, t, rng, caso, i, fz="4", dyn=False):
    s = G.deck(c, t, rng, caso, i).splitlines(); k = [j for j, l in enumerate(s) if l.split()[0] in ("Xo_c", "Xo_pre", "Xo_pre2", "Xo_p")]
    assert len(k) == 4, k
    s = [l for j, l in enumerate(s) if j not in k]; j = s.index("Vd vdd 0 1.8")
    if dyn:
        t0, t1, te, T = tiempos(rng, i); en = f"Ven en 0 pwl(0 0 {t0:.4e} 0 {t0 + 1e-9:.4e} 1.8 {t1:.4e} 1.8 {t1 + 1e-9:.4e} 0)"
    else: en = "Ven en 0 1.8"
    s[j + 1:j + 1] = frente() + [en, f"Vrs rs 0 {1.8 if rng == 'alto' else 0}", f"Xo_ie en 0 0 vdd vdd o_enb {SC}inv_1", f"Xo_ir rs 0 0 vdd vdd o_rsb {SC}inv_1",
                                 f"Xo_gl o_q o_rsb o_enb 0 0 vdd vdd o_prenl {SC}a21oi_{fz}", f"Xo_gh o_q rs en 0 0 vdd vdd o_prenh {SC}nand3_{fz}"]
    s[0] = s[0].replace("MISFIT-17", f"MISFIT-24 (lazo con seleccion y habilitacion, puertas _{fz}{', EN sube y baja' if dyn else ''})")
    j = next(j for j, l in enumerate(s) if l.startswith("save ")); s[j] += " i(vd)"
    j = next(j for j, l in enumerate(s) if l.startswith("tran "))
    if dyn: s[j] = f"tran {min(te / 20000, 1e-9):.3e} {te:.4e} 0 {min(te / 2000, 1e-6):.3e}"
    j = s.index("quit"); ex = []
    for n in range(1, 13): ex += [f"meas tran e{n} when v(o_q)=0.9 rise={n}", f"echo ED {n} $&e{n}"]
    if dyn:
        ex += [f"echo DY t0 {t0:.6e}", f"echo DY t1 {t1:.6e}",
               f"meas tran qidle max v(o_q) from=0 to={t0:.4e}", "echo DY qidle $&qidle",
               f"meas tran xidle min v(o_x) from={0.2 * t0:.4e} to={t0:.4e}", "echo DY xidle $&xidle",
               f"meas tran iidle avg i(vd) from={0.5 * t0:.4e} to={t0:.4e}", "echo DY iidle $&iidle",
               f"meas tran qoff max v(o_q) from={t1 + 2 * T:.4e} to={te:.4e}", "echo DY qoff $&qoff",
               f"meas tran xoff min v(o_x) from={t1 + 2 * T:.4e} to={te:.4e}", "echo DY xoff $&xoff"]
    s[j:j] = ex
    return "\n".join(s) + "\n"


def lista():
    out = []
    for c, t in G.CORN:
        for rng in G.LP:
            out += [("d", c, t, rng, caso, i, "4", False) for caso, i in CASOS[rng]]
            out.append(("dyn", c, t, rng, "oos", MID[rng], "4", True))
    for rng in G.LP: out += [("f1", "tt", "27", rng, caso, i, "1", False) for caso, i in CASOS[rng] if caso == "cal"]
    return out


if __name__ == "__main__":
    L = lista()
    for sub, c, t, rng, caso, i, fz, dyn in L:
        d = os.path.join(H, sub, f"{rng}_{c}{t}_{caso}_{i:.4e}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write(deck(c, t, rng, caso, i, fz, dyn))
    print("decks:", len(L), {k: sum(1 for x in L if x[0] == k) for k in ("d", "dyn", "f1")})
