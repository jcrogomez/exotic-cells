"""MISFIT-03 etapa a: veredictos de P2-P7 y F1-F7 a partir de contrato.txt (salida de run_contrato.sh).

Umbrales copiados del prerregistro (MISFIT-03_2026-11-23_slot_xc19.md) y de su enmienda 1 (E4-E9). Escrito antes de ver
contrato.txt. Tiempos: t = t_cruce - T0, T0 = 1 us (flanco de pre). Cuentas: t * 50 MHz (contador aritmetico, ver b5).
Uso: python3 analiza_contrato.py > contrato_analisis.txt
"""
import os, re, collections

HERE = os.path.dirname(os.path.abspath(__file__))
HERE = os.environ.get("XC19_OUT") or HERE   # enmienda 2: lee contrato.txt de otra carpeta
T0 = 1e-6; F = 50e6
CORN = ["tt 27", "ff -40", "ss 85", "ff 85"]
V = collections.defaultdict(dict)
for l in open(os.path.join(HERE, "contrato.txt")):
    f = l.split()
    key = f"{f[1]} {f[2]}"
    last = None
    for kv in f[3:]:
        if "=" not in kv:
            # meas fallida (sin cruce): ngspice sustituye $&nombre por la forma de onda del nodo homonimo y escribe sus
            # valores sueltos tras la clave; esa clave no es una medida
            if last is not None:
                V[key][last] = None
            continue
        k, _, v = kv.partition("=")
        last = k
        try:
            V[key][k] = float(v)
        except ValueError:
            V[key][k] = None


def t(c, k):
    v = V[c].get(k)
    return None if v is None else v - T0


def ratio(c, r):
    a, b = t(c, f"{r}_oa"), t(c, f"{r}_ob")
    return None if a is None or b is None else a / b


def fmt(x, n=4):
    return "—" if x is None else f"{x:.{n}f}"


out = []
p = out.append
ok = lambda b: "cumplida" if b else "FALSA"
p("# MISFIT-03 etapa a · contrato del macro extraido · veredictos (generado por analiza_contrato.py)\n")
p("| esquina | tA src=01 (us) | tB src=01 (us) | tA/tB-1 src=11 (%) | paso P4 (%) | trampa (cuentas) | paso (cuentas) | VB (V) |")
p("|---|---|---|---|---|---|---|---|")
R = {}
for c in CORN:
    tA, tB = t(c, "h01_oa"), t(c, "h01_ob")
    r11, r10 = ratio(c, "h11"), ratio(c, "h10")
    step = None if r11 is None or r10 is None else 100 * (r10 - r11)
    trap = None if tA is None or t(c, "t01_oa") is None else (tA - t(c, "t01_oa")) * F
    tB11 = t(c, "h11_ob")
    ucnt = None if step is None else step / 100 * tB11 * F
    asym = None if r11 is None else 100 * (r11 - 1)
    R[c] = dict(tA=tA, tB=tB, asym=asym, step=step, trap=trap, ucnt=ucnt, r01=ratio(c, "h01"), r11=r11)
    p(f"| {c} | {fmt(tA and tA*1e6,3)} | {fmt(tB and tB*1e6,3)} | {fmt(asym)} | {fmt(step)} | {fmt(trap,2)} | {fmt(ucnt,2)} | {fmt(V[c].get('vb'),4)} |")

p("\n## Predicciones\n")
tt = R["tt 27"]
p(f"- **P3** (tt 27, src=01): tA = {fmt(tt['tA']*1e6,3)} us, banda 30,96-33,4 us -> {ok(30.96e-6 <= tt['tA'] <= 33.4e-6)}")
for c in CORN:
    a = R[c]["asym"]
    p(f"- **P5'** {c}: abs(tA/tB - 1) en src=11 = {fmt(abs(a))} %, limite 0,15 % -> {ok(abs(a) <= 0.15)}")
s = tt["step"]
p(f"- **P4** tt 27: paso = {fmt(s)} %, banda 0,25-0,60 % -> {ok(0.25 <= s <= 0.60)}")
for c in CORN:
    s = R[c]["step"]
    p(f"- **P4** {c}: paso = {fmt(s)} %, >= 0,15 % -> {ok(s >= 0.15)}; criterio de muerte K2 (< 0,10 %): {'CUMPLIDO' if s < 0.10 else 'no'}")
for c in CORN:
    n = R[c]["trap"]
    if c == "ff 85":
        p(f"- **P6** {c}: trampa = {fmt(n,2)} cuentas, prediccion < 2 (fallo esperado) -> {ok(n < 2)}")
    else:
        p(f"- **P6** {c}: trampa = {fmt(n,2)} cuentas, prediccion >= 10 -> {ok(n >= 10)}")
for c in CORN:
    n = R[c]["ucnt"]
    if c == "ss 85":
        p(f"- **P6'** {c}: paso de unidad = {fmt(n,2)} cuentas (sin prediccion binaria; diseno 4,8)")
    elif c == "ff 85":
        p(f"- **P6'** {c}: paso de unidad = {fmt(n,2)} cuentas, prediccion < 1 (fallo esperado) -> {ok(n < 1)}")
    else:
        p(f"- **P6'** {c}: paso de unidad = {fmt(n,2)} cuentas, prediccion >= 5 -> {ok(n >= 5)}")
for c in CORN:
    r0, rl, rh = R[c]["r01"], ratio(c, "l01"), ratio(c, "u01")
    d = max(abs(rl - r0), abs(rh - r0)) * 100
    tl, th = t(c, "l01_oa"), t(c, "u01_oa")
    p(f"- **P7** {c}: A/B se mueve {d:.5f} % con +-10 mV (tA: {tl*1e6:.3f} / {R[c]['tA']*1e6:.3f} / {th*1e6:.3f} us), limite 0,01 % -> {ok(d < 0.01)}")
lim = {"tt 27": 1e-9, "ff 85": 50e-9}
for c in CORN:
    # corriente estatica: .op (diag_en0/p2op_*.sp) en las 4 esquinas; el transitorio con entradas moviendose solo termino en
    # tt 27 y ff 85 (e0 no avanza en ff -40 ni ss 85, ni con gmin = 1e-15): ahi la parte "xa = xb = 0 moviendo pre y src" es
    # "no corrida"
    ic = -V[c]["op_icore"]
    s = f"- **P2** {c}: en=0, corriente estatica del macro por .op {ic*1e9:.4f} nA; xa = {V[c]['op_oa']*1e6:.2f} uV en el .op"
    if V[c].get("e0_icore") is not None:
        idd = -V[c]["e0_idec"]; xm = max(V[c]["e0_oa_max"], V[c]["e0_ob_max"])
        s += f"; transitorio 1,4 ms con entradas moviendose: max(xa, xb) = {xm*1e6:.2f} uV, macro {-V[c]['e0_icore']*1e9:.4f} nA, decodificador {idd*1e9:.4f} nA"
    else:
        idd = None
        s += "; transitorio con entradas moviendose: **no corrido** (el simulador no avanza)"
    if c in lim:
        s += f"; limite {lim[c]*1e9:g} nA: macro -> {ok(ic < lim[c])}"
        if idd is not None:
            s += f", macro + decodificador -> {ok(ic + idd < lim[c])}"
    p(s)
p("\n## Fallos inyectados\n")
p("Banda sana = [min, max] de la misma lectura del macro sano en las 4 esquinas.\n")
band = lambda key: (min(R[c][key] for c in CORN), max(R[c][key] for c in CORN))
b01, b11 = band("r01"), band("r11")
bstep = band("step")
inv = {}
for c in CORN:
    st = 100 * (ratio(c, "f1b") - ratio(c, "f1a"))
    d2 = 100 * (ratio(c, "f2") - R[c]["r01"])
    r7 = ratio(c, "f7")
    f3 = V[c]["f3_oa_pre"]; f4 = V[c]["f4_oa_pre"]; f4t = t(c, "f4_oa")
    p(f"- {c}: **F1** paso = {st:.4f} % (< 0,05 % -> {ok(st < 0.05)}; banda sana {bstep[0]:.4f}-{bstep[1]:.4f}) · "
      f"**F2** A desplazado {d2:.4f} % (> 0,25 % -> {ok(d2 > 0.25)}) · **F3** xa al final de la precarga = {f3:.3f} V "
      f"(stuck -> {ok(f3 > 0.9)}) · **F4** xa al final de la precarga = {f4:.3f} V, cruce {fmt(f4t and f4t*1e6,3)} us "
      f"(stuck o timeout -> {ok(f4 > 0.9 or f4t is None)}) · **F7** tA/tB src=11 = {r7:.4f} (< 0,80 -> {ok(r7 < 0.80)})")
    inv.setdefault("F1", []).append(bstep[0] <= st <= bstep[1])
    r2 = ratio(c, "f2"); inv.setdefault("F2", []).append(b01[0] <= r2 <= b01[1])
    inv.setdefault("F7", []).append(b11[0] <= r7 <= b11[1])
for c in CORN:
    ic, idd = -V[c]["f5_icore"], -V[c]["f5_idec"]
    s = (f"- {c}: **F5** en=0 con VBIAS y C1 pegados a VDD: corriente macro {ic*1e9:.3f} nA, por VBIAS/C1 (alimentacion del "
         f"decodificador) {idd*1e9:.3f} nA, VB {V[c]['f5_vb']:.4f} V, xa max {V[c]['f5_oa_max']*1e3:.3f} mV")
    if c in lim:
        s += f" (macro + decodificador supera {lim[c]*1e9:g} nA -> {ok(ic + idd > lim[c])}; VB > 0,1 V -> {ok(V[c]['f5_vb'] > 0.1)})"
    else:
        s += f" (VB > 0,1 V -> {ok(V[c]['f5_vb'] > 0.1)})"
    p(s)
    f6 = t(c, "f6_oa")
    p(f"- {c}: **F6** DUT de A abierto, src=01: cruce de xa {fmt(f6 and f6*1e6,3)} us en 1,4 ms (timeout = sin cruce en 1,31 ms -> {ok(f6 is None or f6 > 1.31e-3)}); XA min {V[c]['f6_XA_min']:.4f} V")
    h0a, h0b = t(c, "h00_oa"), t(c, "h00_ob")
    p(f"- {c}: **src=00**: cruce xa {fmt(h0a and h0a*1e6,3)} us, xb {fmt(h0b and h0b*1e6,3)} us (timeout esperado); XA min {V[c]['h00_XA_min']:.4f} V")
p("\n## Mutante del criterio (fallo invisible = dentro de la banda sana en las 4 esquinas)\n")
for k, v in inv.items():
    p(f"- {k}: dentro de la banda sana en {sum(v)} de 4 esquinas -> {'INVISIBLE' if all(v) else 'visible'}")
print("\n".join(out))
