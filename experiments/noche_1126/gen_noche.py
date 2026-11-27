"""Plan nocturno 2026-11-26 (cells/preregistros/PLAN_2026-11-26_noche.md): cinco bloques sobre el lector 2 de MISFIT-24.
Base: misfit24/gen24.py (parte analogica extraida, matriz xc20w, lazo con seleccion y habilitacion, puertas _4).
  S/  alimentacion a 1,70 y 1,90 V                 W/  cable en el nodo: +20 y +50 fF
  N/  63 puestos (9 copias de la matriz) en el nodo  K/  contador de rizado de 4 biestables sobre q, 10 uA
  M/  desajuste: un chip por deck (tt_mm, setseed), 3 calibraciones y 1 fuera de muestra con 'alter'
Uso: gen_noche.py -> <bloque>/<caso>/lec.sp. Lineas 'ED <n> <t>'; en M 'MC <tag> <n> <t>'; en K 'KD <nombre> <t>'."""
import os, re, importlib.util
H = os.path.dirname(os.path.abspath(__file__))
_sp = importlib.util.spec_from_file_location("gen24", os.path.join(H, "..", "misfit24", "gen24.py")); g24 = importlib.util.module_from_spec(_sp); _sp.loader.exec_module(g24)
G = g24.G; CASOS = g24.CASOS; MID = g24.MID; SC = g24.SC
NCHIP = 40; SEED0 = 2600


def sub(rng):
    """3 calibraciones y la corriente media fuera de muestra."""
    return [(k, i) for k, i in CASOS[rng] if k == "cal" or (k == "oos" and i == MID[rng])]


def ins(s, after, lines):
    j = s.index(after); s[j + 1:j + 1] = lines


def deck_S(c, t, rng, caso, i, v):
    s = g24.deck(c, t, rng, caso, i).splitlines(); n = 0
    for j, l in enumerate(s):
        if l == "Vd vdd 0 1.8" or l == "Ven en 0 1.8" or l == "Vrs rs 0 1.8" or re.fullmatch(r"Vsel\d sel\d 0 1\.8", l) or l == ".ic v(o_x)=1.8":
            s[j] = l[:-3] + f"{v:.2f}"; n += 1
    assert n >= 3, n
    s[0] += f" · VDD = {v:.2f} V"
    return "\n".join(s) + "\n"


def deck_W(c, t, rng, caso, i, cw):
    s = g24.deck(c, t, rng, caso, i).splitlines(); ins(s, "Vd vdd 0 1.8", [f"Cwire o_x 0 {cw}f"]); s[0] += f" · cable {cw} fF"
    return "\n".join(s) + "\n"


def copias(n):
    m, isl, dj6 = G.matriz(-1); out = []
    for k in range(1, n + 1):
        for l in m:
            f = l.split()
            if f[0].startswith("Vsel"): continue
            f[0] += f"_k{k}"
            out.append(" ".join(("0" if re.fullmatch(r"sel\d", x) else f"n{k}_" + x[2:] if x.startswith("m_") else x) for x in f))
    return out


def deck_N(c, t, rng, caso, i):
    s = g24.deck(c, t, rng, caso, i).splitlines(); ex = copias(8); assert len(ex) > 8 * 14
    ins(s, "Vd vdd 0 1.8", ex); s[0] += " · 63 puestos (9 matrices)"
    return "\n".join(s) + "\n"


def deck_K(c, t):
    i = 1e-5; s = g24.deck(c, t, "alto", "cal", i).splitlines()
    fl = ["Vrb rb 0 pwl(0 0 5n 0 5.1n 1.8)"]; ck = "o_q"
    for k in range(4):
        fl.append(f"Xk{k} {ck} k{k}n rb 0 0 vdd vdd k{k} k{k}n {SC}dfrbp_1"); ck = f"k{k}n"
    ins(s, "Vd vdd 0 1.8", fl); s[0] += " · contador de rizado de 4 biestables sobre q"
    j = next(j for j, l in enumerate(s) if l.startswith("save ")); s[j] += " v(k0) v(k3)"
    j = next(j for j, l in enumerate(s) if l.startswith("tran ")); f = s[j].split(); s[j] = f"tran {f[1]} {float(f[2]) * 2.2:.4e} 0 {f[4]}"
    j = s.index("quit"); ex = []
    for nm, node, r in (("q1", "o_q", 1), ("q8", "o_q", 8), ("q9", "o_q", 9), ("q24", "o_q", 24), ("k0_1", "k0", 1), ("k3_1", "k3", 1), ("k3_2", "k3", 2)):
        ex += [f"meas tran {nm} when v({node})=0.9 rise={r}", f"echo KD {nm} $&{nm}"]
    s[j:j] = ex
    return "\n".join(s) + "\n"


def trans(i):
    ts = 14 * 260e-15 * 2.0 / i + 16 * 10e-9
    return f"tran {min(ts / 20000, 1e-9):.3e} {ts:.4e} 0 {min(ts / 2000, 1e-6):.3e}"


def deck_M(rng, seed):
    """seed None = control tt (sin desajuste). Puesto 0 seleccionado siempre; calibracion por el nodo (Io), fuera de muestra por el puesto (Ij)."""
    s = g24.deck("tt", "27", rng, "oos", MID[rng]).splitlines()
    if seed is not None:
        assert s[1].endswith("sky130.lib.spice tt"); s[1] += "_mm"
    j = next(j for j, l in enumerate(s) if l.startswith("Ij ")); f = s[j].split(); s[j] = f"{f[0]} {f[1]} {f[2]} 0"; s.insert(j + 1, "Io o_x 0 0")
    s[0] += f" · desajuste, semilla {seed}" if seed is not None else " · control tt del bloque M"
    j = s.index(".control"); s = s[:j]
    ctl = [".control", "set noaskquit"] + ([f"setseed {seed}", "reset"] if seed is not None else []) + ["save v(o_q) v(o_x)"]
    for tag, src, i in [(f"cal{n}", "Io", i) for n, (k, i) in enumerate(sub(rng)[:3])] + [("oos", "Ij", MID[rng])]:
        assert (tag == "oos") == (src == "Ij")
        ctl += ["alter Io dc = 0", "alter Ij dc = 0", f"alter {src} dc = {i:.4e}", trans(i)]
        for n in range(1, 13): ctl += [f"meas tran e{n} when v(o_q)=0.9 rise={n}", f"echo MC {tag} {n} $&e{n}", f"unlet e{n}"]
    return "\n".join(s + ctl + ["quit", ".endc", ".end"]) + "\n"


def lista():
    L = []
    for c, t in (("tt", "27"), ("ss", "85")):
        for rng in G.LP:
            for k, i in sub(rng):
                for v in (1.70, 1.90): L.append((f"S/{rng}_{c}{t}_v{v:.2f}_{k}_{i:.4e}", deck_S, (c, t, rng, k, i, v)))
                for cw in (20, 50): L.append((f"W/{rng}_{c}{t}_c{cw}_{k}_{i:.4e}", deck_W, (c, t, rng, k, i, cw)))
    for c, t, rng in (("tt", "27", "bajo"), ("ss", "85", "bajo"), ("ff", "85", "bajo"), ("ff", "85", "alto")):
        for k, i in CASOS[rng]:
            if k != "wit": L.append((f"N/{rng}_{c}{t}_{k}_{i:.4e}", deck_N, (c, t, rng, k, i)))
    for c, t in G.CORN: L.append((f"K/{c}{t}", deck_K, (c, t)))
    for rng in G.LP:
        L.append((f"M/{rng}_control", deck_M, (rng, None)))
        for n in range(NCHIP): L.append((f"M/{rng}_s{SEED0 + n + (100 if rng == 'alto' else 0)}", deck_M, (rng, SEED0 + n + (100 if rng == "alto" else 0))))
    return L


if __name__ == "__main__":
    L = lista(); cnt = {}
    for d, fn, a in L:
        p = os.path.join(H, d); os.makedirs(p, exist_ok=True); open(os.path.join(p, "lec.sp"), "w").write(fn(*a)); cnt[d[0]] = cnt.get(d[0], 0) + 1
    print("decks:", len(L), cnt)
