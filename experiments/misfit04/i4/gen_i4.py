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

# enmienda 3, E1: la celda real (clkdlybuf4s25_1) en lugar del escalon ideal. Carga a tierra = red extraida (14,346 / 5,012 fF)
# menos sus acoplos a XA_OUT/XB_OUT (que van aparte) + el pin del abanico (and2_2.A, 1,45 fF en liberty tt)
CL3 = 14.346e-15 - 61.39e-18 - 55.90e-18 + 1.45e-15
CL2 = 5.012e-15 - 4.11e-18 + 1.45e-15
def inst_real(s, p, active):
    s += G.slot(p, "core", "vdd", "vdd", "hi", "pre", "0", "hi")
    for a, b, c in STAT: s += f"C{p}_{a}{b} {p}_{a} {p}_{b} {c:.4e}\n"
    s += pwl_clocked(f"{p}_ag685", 0, False)
    s += f"X{p}_in2 {p}_oa 0 0 vdd vdd {p}_x2 sky130_fd_sc_hd__clkdlybuf4s25_1\nC{p}_x2l {p}_x2 0 {CL2:.4e}\n"
    s += f"X{p}_in3 {p}_ob 0 0 vdd vdd {p}_x3 sky130_fd_sc_hd__clkdlybuf4s25_1\nC{p}_x3l {p}_x3 0 {CL3:.4e}\n"
    if active: s += f"R{p}_a2 {p}_agin2 {p}_x2 1m\nR{p}_a3 {p}_agin3 {p}_x3 1m\n"
    else: s += f"V{p}_agin2 {p}_agin2 0 0\nV{p}_agin3 {p}_agin3 0 0\n"
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
    if npass == 4:                      # enmienda 3, E1
        s = inst_real(s, "rq", False); s = inst_real(s, "ra", True); run += ["rq", "ra"]
    if npass == 5:                      # enmienda 3, E2: tiras S7 de longitud l, fase en ns; items = [(nombre, C, fase_ns)]
        for p, cxa, ph in ITEMS:
            s = inst(s, p, 0, False, cross)
            s += f"V{p}_clk {p}_clk 0 pulse(0 1.8 {ph}n {EDGE} {EDGE} {10e-9 - EDGE:.4e} 20n)\n"
            s += f"C{p}_s7 {p}_clk {p}_XA {cxa:.4e}\n"
            run.append(p)
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
    if npass in (2, 3, 4, 5):
        lo = min(cross) - 200e-9; hi = max(cross) + 200e-9
        n = int((hi - lo) / 50e-12)
        s += "Vgrid grid 0 pwl(0 0 " + " ".join(f"{lo + i * 50e-12:.6e} {0.0 if i % 2 == 0 else 1e-3}" for i in range(n)) + ")\nRgrid grid 0 1G\n"
    meas, echo = [], []
    for r in run:
        for side in ("oa", "ob"):
            meas.append(f"meas tran {r}_{side} when v({r}_{side})=0.9 rise=1"); echo.append(f"{r}_{side}=$&{r}_{side}")
    if npass == 4:                      # cuando sube de verdad la salida de cada bufer
        for x in ("x2", "x3"):
            meas.append(f"meas tran ra_{x} when v(ra_{x})=0.9 rise=1"); echo.append(f"ra_{x}=$&ra_{x}")
    tstop = (max(cross) + 1e-6) if cross else 80e-6
    sv = "save " + " ".join(f"v({r}_{x})" for r in run for x in ("oa", "ob")) + (" v(ra_x2) v(ra_x3)" if npass == 4 else "")    # solo lo medido: la pasada 3 sin esto murio por memoria
    s += f".control\nset noaskquit\n{sv}\ntran 1n {tstop:.4e} 0 2n\n" + "\n".join(meas) + "\n"
    s += "".join(f"echo RES {c} {t} {e}\n" for e in echo) + "quit\n.endc\n.end\n"
    if npass == 5:     # E2: con 11 instancias con reloj el trapecio se atasca ("timestep too small" a 10 ns en p5_1); gear. El control de deck decide
        assert s.count("reltol=1e-5\n") == 1; s = s.replace("reltol=1e-5\n", "reltol=1e-5 method=gear\n")
        if os.environ.get("TMAX"):      # diagnostico de convergencia: paso maximo del tran (por defecto 2n)
            assert s.count(" 0 2n\n") == 1; s = s.replace(" 0 2n\n", f" 0 {os.environ['TMAX']}\n")
        if os.environ.get("ITL4"):
            # p5f: CARGA no basto (p5e_b0 aborto igual, en "vpre#branch", 193,113 ns). Diagnostico sobre ese mismo deck cortado a
            # 400 ns: el aborto se repite tal cual; pasa ese punto con itl4=200, con abstol=1e-12, con trap y sin KLU. Es un paso
            # que no converge en las 10 iteraciones por defecto y a partir de ahi el paso se colapsa. itl4 solo da mas
            # iteraciones de Newton por punto: no toca tolerancias ni metodo
            s = s.replace("reltol=1e-5 method=gear\n", f"reltol=1e-5 method=gear itl4={int(os.environ['ITL4'])}\n")
        if os.environ.get("CARGA"):
            # p5e: los decks de 5 siguieron abortando ("timestep too small" en la rama de una fuente _clk o _agin3). Esas
            # fuentes solo ven condensadores de aF: su corriente es ~0 y se juzga contra abstol = 1e-15 A. Arreglo: 1 kOhm de
            # cada nodo de fuente de agresor a 0,9 V. La fuente es ideal, asi que ninguna tension de nodo cambia; solo su
            # corriente deja de ser ~0 (+-0,9 mA). Lo decide la fase de control que lleva cada deck (ver corre_p5e.sh)
            import re
            src = re.findall(r"^V(\S+_(?:clk|agin2|agin3|ag685)) ", s, re.M)
            add = "Vmid mid 0 0.9\n" + "".join(f"Rk_{n} {n} mid 1k\n" for n in src)
            assert s.count(".control\n") == 1; s = s.replace(".control\n", add + ".control\n")
    return s

ITEMS = []
if __name__ == "__main__" and sys.argv[1] == "5":    # gen_i4.py 5 p1.txt -> corridas/p5_<j>/ (solo tt 27, trozos de 9 + c + q)
    E2 = json.load(open("../e2/caps_e2.json"))
    todo = [(f"l216f{k}", E2["21.6"], k) for k in range(20)] + [(f"l80f{k}", E2["8.0"], k) for k in range(0, 20, 2)] + \
           [(f"l40f{k}", E2["4.0"], k) for k in range(0, 20, 2)]
    P1 = {}
    for l in open(sys.argv[2]):
        f = l.split()
        if f and f[0] == "RES": k, v = f[3].split("="); P1.setdefault((f[1], f[2]), {})[k] = float(v)
    cross = (P1[("tt", "27")]["q_oa"], P1[("tt", "27")]["q_ob"])
    # CHUNK (por defecto 9) y PREF (por defecto p5_): los decks de 9 abortaron en ngspice ("tran simulation(s) aborted"), con
    # trap y con gear; la enmienda 3 pide "varias corridas de <= 11 instancias", asi que trozos menores siguen en el diseno
    CH = int(os.environ.get("CHUNK", 9)); PF = os.environ.get("PREF", "p5_")
    if os.environ.get("SOLO_CONTROL"): todo = [x for x in todo if x[0] in ("l216f0", "l216f4", "l216f8", "l216f12", "l216f16")]
    if os.environ.get("SOLO"): todo = [x for x in todo if x[0] in os.environ["SOLO"].split(",")]
    for j in range(0, len(todo), CH):
        ITEMS[:] = todo[j:j + CH]
        os.makedirs(f"corridas/{PF}{j // CH}", exist_ok=True)
        open(f"corridas/{PF}{j // CH}/i4.sp", "w").write(deck("tt", "27", 5, cross))
    print("ok 5", len(todo)); sys.exit()
if __name__ == "__main__":
    npass = int(sys.argv[1])
    P1 = {}
    if npass in (2, 3, 4):
        for l in open(sys.argv[2]):
            f = l.split()
            if f and f[0] == "RES":
                k, v = f[3].split("="); P1.setdefault((f[1], f[2]), {})[k] = float(v)
    for c, t in G.CORNERS:
        cross = (P1[(c, t)]["q_oa"], P1[(c, t)]["q_ob"]) if npass in (2, 3, 4) else None
        os.makedirs(f"corridas/p{npass}_{c}_{t}", exist_ok=True)
        open(f"corridas/p{npass}_{c}_{t}/i4.sp", "w").write(deck(c, t, npass, cross))
    print("ok", npass)
