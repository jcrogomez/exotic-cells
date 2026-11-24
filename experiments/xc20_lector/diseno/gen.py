"""XC-20, lector de rango ancho: calculo de DISENO en esquematico (no es prediccion ni veredicto).
Oscilador de relajacion: I del dispositivo descarga X (C); inv_1 de la biblioteca como comparador; una cadena de retardo cierra el
lazo y enciende la precarga (pfet a VDD) hasta que X vuelve a subir. Se cuentan los flancos de c. Barrido de I (fuente ideal)."""
import sys
c_val, temp, corner, out = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
I = [10 ** (e / 2) for e in range(-20, -5)]          # 100 pA .. 316 uA (medias decadas)
s = [f"* XC-20 lector, C = {c_val}", f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {corner}",
     ".include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice", f".temp {temp}",
     ".options gmin=1e-15 reltol=1e-4", "Vd vdd 0 1.8"]
J = int(sys.argv[5]); I = [I[J]]
import os
# v4: precarga configurable, PRECARGA="modelo,w,m,pila" (por defecto la v3: pfet_01v8, w = 4, m = 16, sin pila). En 200 fF la v3
# no oscila a 100 y 316 pA y a 1 nA da ~1,9x el periodo esperado: la fuga del pfet de 64 um se opone a I (inferencia)
PM, PW, PMM, PST = (os.environ.get("PRECARGA", "pfet_01v8,4,16,1").split(",")); PW, PMM, PST = float(PW), int(PMM), int(PST)
def precarga(p):
    if PST == 1:
        return [f"X{p}_pre {p}_x {p}_pren vdd vdd sky130_fd_pr__{PM} w={PW} l=0.15 m={PMM}"]
    return [f"X{p}_pre {p}_x {p}_pren {p}_st vdd sky130_fd_pr__{PM} w={PW} l=0.15 m={PMM}",
            f"X{p}_pre2 {p}_st {p}_pren vdd vdd sky130_fd_pr__{PM} w={PW} l=0.15 m={PMM}"]
for j, i in enumerate(I):
    p = f"o{j}"
    # v3 (tras diseno_v1_sin_ic/ y pruebas en el scratchpad): sin histeresis el lazo es un regulador lineal estable (X quieto en
    # ~0,79 V con 10 pF); latch SR de nor2: S = X bajo (inv_1 + 2 inv_1 de afilado), Q enciende la precarga, R = Q tras 8
    # dlygate4sd3 (pulso de ancho fijo); pfet m = 16 para que X llegue a VDD dentro del pulso
    s += [f"C{p} {p}_x 0 {c_val}", f"I{p} {p}_x 0 {i:.4e}",
          *precarga(p),
          f"X{p}_cmp {p}_x 0 0 vdd vdd {p}_c sky130_fd_sc_hd__inv_1",
          f"X{p}_s1 {p}_c 0 0 vdd vdd {p}_c2 sky130_fd_sc_hd__inv_1",
          f"X{p}_s2 {p}_c2 0 0 vdd vdd {p}_s sky130_fd_sc_hd__inv_1",
          f"X{p}_q {p}_r {p}_qb 0 0 vdd vdd {p}_q sky130_fd_sc_hd__nor2_1",
          f"X{p}_qb {p}_s {p}_q 0 0 vdd vdd {p}_qb sky130_fd_sc_hd__nor2_1",
          f"X{p}_p {p}_q 0 0 vdd vdd {p}_pren sky130_fd_sc_hd__inv_4"]
    prev = f"{p}_q"
    for k in range(8):
        nxt = f"{p}_r" if k == 7 else f"{p}_d{k}"
        s += [f"X{p}_d{k} {prev} 0 0 vdd vdd {nxt} sky130_fd_sc_hd__dlygate4sd3_1"]; prev = nxt
    s += [f".ic v({p}_x)=1.8"]
CV = float(c_val.replace('p', 'e-12').replace('f', 'e-15'))
TS = {i: 14 * CV * 1.3 / i + 16 * 10e-9 for i in I}     # v4: excursion efectiva vista 1,0-1,3 V     # 16 periodos estimados + 16 x 5 ns de re-precarga
s += [".control", "set noaskquit", "save " + " ".join(f"v(o{j}_q) v(o{j}_x)" for j in range(len(I)))]
# un transitorio por corriente seria caro; un solo transitorio hasta el mayor tiempo necesario, contando cruces por ventana
tstop = max(TS.values())
s += [f"tran {min(tstop/20000, 1e-9):.3e} {tstop:.4e} 0 {min(tstop/2000, 1e-6):.3e}"]
for j, i in enumerate(I):
    s += [f"meas tran n{j}_r1 when v(o{j}_q)=0.9 rise=2", f"meas tran n{j}_r2 when v(o{j}_q)=0.9 rise=12",
          f"echo RES {J} {i:.4e} $&n{j}_r1 $&n{j}_r2"]
s += ["quit", ".endc", ".end"]
import os; os.makedirs(out, exist_ok=True); open(os.path.join(out, "lec.sp"), "w").write("\n".join(s) + "\n")
print("ok", out, f"tstop {tstop:.3e}")
