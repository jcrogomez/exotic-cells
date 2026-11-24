"""MISFIT-04 I4 (enmienda 2, A4): agresores reales sobre el slot, activos frente a quietos, 5 fases, 4 esquinas; testigo S7 y S8.
Deck base: experiments/xc19_slot/gen_contrato.py (macro extraido con LOD + decodificador E7 en celdas), instancia src = 01.
  gen_i4.py 1            -> i4_p1_<c>_<t>.sp  (pasada 1: solo la instancia quieta; da los cruces)
  gen_i4.py 3 p1.txt     -> pasada 3: quieta + ablacion (un agresor a la vez) + S7 x 5 fases + S8
  gen_i4.py 2 p1.txt     -> i4_p2_<c>_<t>.sp  (pasada 2: quieta + 5 fases activas + S7 x 5 fases + S8, con rejilla de 50 ps
                            en +-200 ns alrededor de los cruces de la pasada 1)
Acoplos: agresores.json/acoplo.txt (extraccion plana del tile sano); S7 y S8: caps_s78.json (extraccion de esos tiles)."""
import sys, os, json
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "xc19_slot"))
import gen_contrato as G
T0 = G.T0
ONDAS = json.load(open("ondas.json"))
S78 = json.load(open("caps_s78.json")) if os.path.exists("caps_s78.json") else None
# A3.4: acoplos que se anaden (F), de acoplo.txt
STAT = [("XA", "oa", 34.54e-18), ("XB", "ob", 33.84e-18), ("XA", "XB", 23.37e-18)]          # nodo-nodo, en todas
AGR = [("ag685", "ob", 6.92e-18), ("agin3", "oa", 61.39e-18), ("agin3", "ob", 55.90e-18), ("agin2", "oa", 4.11e-18)]
EDGE = 100e-12

def pwl_clocked(name, shift_ns, active):
    v0, ts = ONDAS["misfit04_core_0._0685_.Y"]
    hi = 1.8
    if not active: return f"V{name} {name} 0 {hi * v0}\n"
    pts = [(0, hi * v0)]; v = v0
    for t in ts:
        tt = T0 + (t + shift_ns) * 1e-9
        pts.append((tt, hi * v)); v ^= 1; pts.append((tt + EDGE, hi * v))
    return f"V{name} {name} 0 pwl(" + " ".join(f"{a:.6e} {b:g}" for a, b in pts) + ")\n"

def step(name, t, active):
    if not active or t is None: return f"V{name} {name} 0 0\n"
    return f"V{name} {name} 0 pwl(0 0 {t:.9e} 0 {t + EDGE:.9e} 1.8)\n"

def inst(s, p, k, active, cross, extra="", only=None):
    """p: prefijo; k: fase 0..4; cross: (t_oa, t_ob) de la pasada 1 (o None)."""
    s += G.slot(p, "core", "vdd", "vdd", "hi", "pre", "0", "hi", extra=extra)
    for a, b, c in STAT: s += f"C{p}_{a}{b} {p}_{a} {p}_{b} {c:.4e}\n"
    on = lambda g: active and (only is None or g == only)
    s += pwl_clocked(f"{p}_ag685", 4 * k, on("ag685"))
    ta, tb = cross if cross else (None, None)
    s += step(f"{p}_agin2", ta + 0.5e-9 if ta else None, on("agin2"))
    s += step(f"{p}_agin3", tb + 0.5e-9 if tb else None, on("agin3"))
    for g, n, c in AGR: s += f"C{p}_{g}{n} {p}_{g} {p}_{n} {c:.4e}\n"
    return s

def deck(c, t, npass, cross=None):
    s = G.HEAD.format(kind=f"MISFIT-04 I4 pasada {npass}", c=c, t=t) + G.VARS["core"]
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {T0} 1.8 {T0 + 1e-9} 0)\n"
    run = ["c", "q"]
    s += G.slot("c", "core", "vdd", "vdd", "hi", "pre", "0", "hi")          # control del deck: h01 del contrato tal cual
    s = inst(s, "q", 0, False, cross)
    if npass == 3:                      # ablacion: un agresor a la vez (fase 0)
        for g in ("ag685", "agin2", "agin3"):
            s = inst(s, f"o{g}", 0, True, cross, only=g); run.append(f"o{g}")
    if npass == 2:
        for k in range(5):
            s = inst(s, f"a{k}", k, True, cross); run.append(f"a{k}")
    if npass in (2, 3) and S78 and npass == 3:
            for k in range(5):
                p = f"s7{k}"
                s = inst(s, p, 0, False, cross)
                s += f"V{p}_clk {p}_clk 0 pulse(0 1.8 {4 * k}n {EDGE} {EDGE} {10e-9 - EDGE:.4e} 20n)\n"
                s += f"C{p}_s7 {p}_clk {p}_XA {S78['S7_XA']:.4e}\n"
                run.append(p)
            p = "s8"; s = inst(s, p, 0, False, cross)
            s += f"C{p}_pxa {p}_plate {p}_XA {S78['S8_XA']:.4e}\nC{p}_pg {p}_plate 0 {S78['S8_rest']:.4e}\nR{p}_pl {p}_plate 0 1e12\n"
            run.append(p)
    if npass in (2, 3):
        lo = min(cross) - 200e-9; hi = max(cross) + 200e-9
        n = int((hi - lo) / 50e-12)
        s += "Vgrid grid 0 pwl(0 0 " + " ".join(f"{lo + i * 50e-12:.6e} {0.0 if i % 2 == 0 else 1e-3}" for i in range(n)) + ")\nRgrid grid 0 1G\n"
    meas, echo = [], []
    for r in run:
        for side in ("oa", "ob"):
            meas.append(f"meas tran {r}_{side} when v({r}_{side})=0.9 rise=1"); echo.append(f"{r}_{side}=$&{r}_{side}")
    tstop = (max(cross) + 1e-6) if cross else 80e-6
    sv = "save " + " ".join(f"v({r}_{x})" for r in run for x in ("oa", "ob"))    # solo lo medido: la pasada 3 sin esto murio por memoria
    s += f".control\nset noaskquit\n{sv}\ntran 1n {tstop:.4e} 0 2n\n" + "\n".join(meas) + "\n"
    s += "".join(f"echo RES {c} {t} {e}\n" for e in echo) + "quit\n.endc\n.end\n"
    return s

if __name__ == "__main__":
    npass = int(sys.argv[1])
    P1 = {}
    if npass in (2, 3):
        for l in open(sys.argv[2]):
            f = l.split()
            if f and f[0] == "RES":
                k, v = f[3].split("="); P1.setdefault((f[1], f[2]), {})[k] = float(v)
    for c, t in G.CORNERS:
        cross = (P1[(c, t)]["q_oa"], P1[(c, t)]["q_ob"]) if npass in (2, 3) else None
        os.makedirs(f"corridas/p{npass}_{c}_{t}", exist_ok=True)
        open(f"corridas/p{npass}_{c}_{t}/i4.sp", "w").write(deck(c, t, npass, cross))
    print("ok", npass)
