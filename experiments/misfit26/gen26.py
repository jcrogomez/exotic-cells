"""MISFIT-26 (etapa B): el bloque digital COLOCADO del lector 2 (misfit25/bloque), con la parte analogica extraida y la matriz.
Igual que MISFIT-24, cambiando las 17 celdas del lazo por el bloque entero (lazo + contador + xa/xb), en tres niveles:
  m  extraccion plana de Magic del GDS, con todos los condensadores (ext/r2flat.pex.spice)
  n  netlist final del flujo con las celdas de la libreria, sin cables (misfit25/bloque/reader2_slot.spice)   [control]
  v  como m sin condensadores: solo dispositivos, con sus areas y perimetros de difusion (ext/r2flat.dev.spice) [reparto]
  l  como m, del bloque 'libre' de MISFIT-25 (el flujo metio buferes en x, prenh, prenl y dentro del lazo)   [mutante]
EN sube en t0 (el contador necesita su puesta a cero); src = 1 en rango bajo (xa a 4, xb a 16), src = 2 en alto (256 y 4096).
Uso: gen26.py -> <grupo>/<nivel>_<rango>_<c><t>_<caso>_<I>/lec.sp. Imprime 'ED <n> <t>' (flancos de q), 'XA <t>', 'XB <t>'."""
import os, re, importlib.util
H = os.path.dirname(os.path.abspath(__file__))
_sp = importlib.util.spec_from_file_location("gen24", os.path.join(H, "..", "misfit24", "gen24.py")); g24 = importlib.util.module_from_spec(_sp); _sp.loader.exec_module(g24)
G = g24.G; CASOS = g24.CASOS; QEST = g24.QEST
SRC = {"m": os.path.join(H, "ext", "r2flat.pex.spice"), "v": os.path.join(H, "ext", "r2flat.dev.spice"), "l": os.path.join(H, "ext_libre", "r2flat.pex.spice"),
       "n": os.path.join(H, "..", "misfit25", "bloque", "reader2_slot.spice")}
TOP = {"m": "r2flat", "v": "r2flat", "l": "r2flat", "n": "reader2_slot"}
# q y qb dentro de cada netlist (para la condicion inicial del cerrojo; ver memoria del cerrojo metaestable)
QN = {"m": ("u_loop.u_d0.A", "u_loop.u_q.B"), "v": ("u_loop.u_d0.A", "u_loop.u_q.B"), "n": None, "l": ("u_loop.u_q.Y", "u_loop.u_q.B")}
ESTIRA = {"bajo": 1.9, "alto": 1.25}   # el bloque extraido es mas lento que la estimacion de MISFIT-24 (humo): simulacion mas larga
LOOP = ("Xo_ie", "Xo_ir", "Xo_gl", "Xo_gh", "Xo_cmp", "Xo_s1", "Xo_s2", "Xo_q", "Xo_qb") + tuple(f"Xo_d{k}" for k in range(8))
PORT = {"VGND": "0", "VPWR": "vdd", "VNB": "0", "VPB": "vdd", "en": "en", "pre": "pre", "prenh": "o_prenh", "prenl": "o_prenl",
        "src[0]": "s0", "src[1]": "s1", "x": "o_x", "xa": "xa", "xb": "xb"}
san = lambda n: PORT[n] if n in PORT else "b_" + re.sub(r"[^A-Za-z0-9_]", "_", n)


def bloque(lvl):
    """Cuerpo del subcircuito superior, en linea: puertos a los nodos del deck, el resto con prefijo b_."""
    txt = open(SRC[lvl]).read().replace("\n+", " ").splitlines(); i = next(k for k, l in enumerate(txt) if l.startswith(f".subckt {TOP[lvl]} "))
    out = []; q = None
    for l in txt[i + 1:]:
        f = l.split()
        if not f: continue
        if f[0] == ".ends": break
        if f[0][0] == "X":
            k = next(j for j, a in enumerate(f) if a.startswith("sky130_")); cell = f[k]
            if lvl == "n" and re.search(r"__(fill|tap|decap)", cell): continue
            if lvl == "n" and f[0] == "Xu_loop.u_q": q = (f[k - 1], f[2])          # nor2: A B VGND VNB VPB VPWR Y -> Y = q, B = qb
            out.append("Xb" + re.sub(r"[^A-Za-z0-9_]", "_", f[0][1:]) + " " + " ".join(san(a) for a in f[1:k]) + " " + " ".join(f[k:]))
        elif f[0][0] == "C": out.append("Cb" + f[0][1:] + f" {san(f[1])} {san(f[2])} {f[3]}")
        else: raise ValueError(l)
    return out, (q or QN[lvl])


def deck(lvl, c, t, rng, caso, i, extra=(), nq=18, largo=None):
    s = g24.deck(c, t, rng, caso, i).splitlines()
    k = [j for j, l in enumerate(s) if l.split() and (l.split()[0] in LOOP or l.split()[0] in ("Ven", "Vrs"))]; assert len(k) == 19, k
    s = [l for j, l in enumerate(s) if j not in k]
    T = QEST[rng] / i + 4e-9 if i else None; t0 = min(3 * T, 2e-6) if i else 2e-6
    body, qn = bloque(lvl); q, qb = (san(a) for a in qn)
    j = s.index("Vd vdd 0 1.8")
    s[j + 1:j + 1] = [f"Ven en 0 pwl(0 0 {t0:.4e} 0 {t0 + 1e-9:.4e} 1.8)", "Vpre pre 0 0",
                      f"Vs0 s0 0 {1.8 if rng == 'bajo' else 0}", f"Vs1 s1 0 {0 if rng == 'bajo' else 1.8}"] + body + list(extra)
    s[0] = f"* MISFIT-26 nivel {lvl}: bloque colocado del lector 2, rango {rng}, caso {caso}, I = {i:.4e} A, {c} {t} C"
    j = next(j for j, l in enumerate(s) if l.startswith(".ic ")); s[j] += f" v({q})=0 v({qb})=1.8"
    j = next(j for j, l in enumerate(s) if l.startswith("save ")); s[j] = f"save v({q}) v(o_x) v(xa) v(xb) v(o_prenl) v(o_prenh) i(vd)"
    j = next(j for j, l in enumerate(s) if l.startswith("tran ")); f = s[j].split()
    if i:
        te = t0 + (largo or (nq + 12)) * T * (1 if lvl == "n" else ESTIRA[rng]); s[j] = f"tran {f[1]} {te:.4e} 0 {f[4]}"
    a = j + 1; b = s.index("quit"); ex = [f"echo T0 {t0:.6e}"]
    for n in range(1, nq + 1): ex += [f"meas tran e{n} when v({q})=0.9 rise={n}", f"echo ED {n} $&e{n}"]
    ex += ["meas tran txa when v(xa)=0.9 rise=1", "echo XA $&txa", "meas tran txb when v(xb)=0.9 rise=1", "echo XB $&txb",
           f"meas tran qidle max v({q}) from=0 to={t0:.4e}", "echo QIDLE $&qidle", f"meas tran xidle min v(o_x) from=0 to={t0:.4e}", "echo XIDLE $&xidle"]
    s[a:b] = ex
    return "\n".join(s) + "\n"


CAL = lambda rng: [(k, i) for k, i in CASOS[rng] if k in ("cal", "oos")]
W20 = ("Cw20 o_x 0 20f",)


def lista():
    L = []
    for c, t in G.CORN:
        for rng in G.LP: L += [("d", "m", c, t, rng, k, i, ()) for k, i in CAL(rng)]                     # A: 48
    for c, t in (("tt", "27"), ("ss", "85")):
        for rng in G.LP: L += [("ctl", "n", c, t, rng, k, i, ()) for k, i in CAL(rng)]                   # control: 24
    L += [("w20", "m", "tt", "27", "alto", k, i, W20) for k, i in CASOS["alto"] if k == "cal"]          # testigo: 3
    L += [("zero", "m", "ff", "85", rng, "zero", 0.0, ()) for rng in G.LP]                               # sin corriente: 2
    for rng in G.LP: L += [("dev", "v", "tt", "27", rng, k, i, ()) for k, i in CASOS[rng] if k == "cal"]    # reparto: 6
    for rng in G.LP: L += [("libre", "l", "tt", "27", rng, k, i, ()) for k, i in CASOS[rng] if k == "cal"]  # mutante: 6
    return L


def nombre(g, lvl, c, t, rng, k, i): return os.path.join(H, g, f"{lvl}_{rng}_{c}{t}_{k}_{i:.4e}")


if __name__ == "__main__":
    import sys
    L = lista(); n = {}
    for g, lvl, c, t, rng, k, i, ex in L:
        if lvl == "l" and QN["l"] is None: continue
        d = nombre(g, lvl, c, t, rng, k, i); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write(deck(lvl, c, t, rng, k, i, ex)); n[g] = n.get(g, 0) + 1
    # contador a ritmo maximo: rango alto, 10 uA, hasta pasar xa (256 flancos); xb (4096) no se simula
    for c, t in (("tt", "27"), ("ss", "85")):
        s = deck("m", c, t, "alto", "cal", 1e-5, nq=12, largo=520).splitlines(); j = s.index("meas tran txa when v(xa)=0.9 rise=1")
        q = san(QN["m"][0]); ex = []
        for e in (255, 256, 257): ex += [f"meas tran k{e} when v({q})=0.9 rise={e}", f"echo EK {e} $&k{e}"]
        s[j:j] = ex; d = os.path.join(H, "largo", f"m_alto_{c}{t}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write("\n".join(s) + "\n"); n["largo"] = n.get("largo", 0) + 1
    print("decks:", n)
