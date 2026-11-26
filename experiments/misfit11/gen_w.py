"""MISFIT-11 etapa 2: el lector pequeno v_f3 con la matriz generada (extraccion con capacidades) colgada de XA y de XB.
Uso: XC19_INC=<v_f3 lod.inc> gen_w.py -> w/tr_<c>_<t>/m.sp. Lineas de salida: 'MW <c> <t> <inst>_<oa|ob> <t_cruce>'
Instancias: n1 (lector solo, su puesto cerrado: control), wc (n1 + 1 fF en XA: testigo), t1 (lector solo con la trampa),
m<N>_<k> (lector con su puesto abierto, estado 00, y matriz de N puestos en cada lado con el puesto k cerrado),
t<N>_0 (igual, con la puerta del puesto 0 del lado A en VB + salto de la trampa).
Las matrices se anotan con sa = sb de la tabla (el generador los dibujo; el lector lleva los suyos anotados por Residual)."""
import os, sys, csv
H = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, os.path.join(H, "..", "xc19_slot"))
assert "xc19_slot_core_a2/v_f3" in os.environ.get("XC19_INC", "")
import gen_contrato as G


def matriz(n, gt=None):
    """subcircuito de la extraccion; con gt = k, la puerta del dispositivo del puesto k sale al puerto GT"""
    name = f"u{n}"; L = open(os.path.join(H, name, name + ".pex.spice")).read().splitlines()
    seats = {int(r["seat"]): r for r in csv.DictReader(open(os.path.join(H, name, name + "_seats.csv")))}
    i0 = next(i for i, l in enumerate(L) if l.startswith(".subckt")); hdr = L[i0].split(); k = i0 + 1
    while L[k].startswith("+"): hdr += L[k][1:].split(); k += 1
    ports = hdr[2:]; body = L[k:]; dev = [l.split() for l in body if l.startswith("X")]
    src = {}                                   # nodo de fuente del dispositivo de cada puesto = drenador de su interruptor
    for d in dev:
        if d[2].startswith("SEL"): src[[x for x in (d[1], d[3]) if x != "GND"][0]] = int(d[2][3:])
    sub = name + ("" if gt is None else f"_gt{gt}"); out = [f".subckt {sub} " + " ".join(ports + ([] if gt is None else ["GT"]))]; nd = 0
    for l in body:
        f = l.split()
        if f and f[0].startswith("X"):
            if f[2] == "VB":
                s = [x for x in (f[1], f[3]) if x != "X"][0]; kk = src[s]; r = seats[kk]; nd += 1
                if gt == kk: f[2] = "GT"
                f += [f"sa={r['sa_um']}", f"sb={r['sb_um']}"]
            else: f += ["sa=0.3", "sb=0.3"]
            l = " ".join(f)
        out.append(l)
    assert nd == n, (nd, n)
    return sub, ports, "\n".join(out) + "\n"


def cuelga(inst, n, k, gt=False):
    L = []
    for side in ("A", "B"):
        sub = f"u{n}_gt{k}" if (gt and side == "A") else f"u{n}"
        m = {"X": f"{inst}_X{side}", "VB": f"{inst}_VB", "GND": "0"}
        nodes = [m.get(p, "hi" if p == f"SEL{k}" else "0") for p in PORTS[n]] + ([f"{inst}_GTm"] if (gt and side == "A") else [])
        L.append(f"X{inst}mat{side} " + " ".join(nodes) + f" {sub}")
    if gt: L.append(f"B{inst}gtm {inst}_GTm 0 V=v({inst}_VB)+{G.TRAP}")
    return "\n".join(L) + "\n"


SUBS = ""; PORTS = {}
for n in (16, 64):
    s, p, txt = matriz(n); PORTS[n] = p; SUBS += txt; SUBS += matriz(n, gt=0)[2]


def tr(c, t):
    ts = "240u" if (c, t) == ("ff", "-40") else "120u"
    s = G.HEAD.format(kind="MISFIT-11 etapa 2, matriz extraida", c=c, t=t) + G.VARS["core"] + G.VARS["trap"] + SUBS
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"; run = []

    def add(inst, var, s0, extra=""):
        nonlocal s
        s += G.slot(inst, var, "vdd", "vdd", "hi", "pre", "0", s0, extra=extra); run.append(inst)
    add("n1", "core", "hi"); add("wc", "core", "hi", "Cwc wc_XA 0 1f\n"); add("t1", "trap", "hi")
    for n in (16, 64):
        for k in (0, n - 1): add(f"m{n}_{k}", "core", "0", cuelga(f"m{n}_{k}", n, k))
        add(f"t{n}_0", "core", "0", cuelga(f"t{n}_0", n, 0, gt=True))
    c_ = [".control", "set noaskquit", "save " + " ".join(f"v({r}_oa) v({r}_ob)" for r in run), f"tran 10n {ts}"]
    for r in run:
        for sd in ("oa", "ob"):
            c_ += [f"meas tran {r}_{sd} when v({r}_{sd})=0.9 rise=1", f"echo MW {c} {t} {r}_{sd} $&{r}_{sd}"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"


for c, t in G.CORNERS:
    d = os.path.join(H, "w", f"tr_{c}_{t}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "m.sp"), "w").write(tr(c, t))
print("ok w")
