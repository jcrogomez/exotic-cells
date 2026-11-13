"""b20_lejos: celdas con separacion legal >= 0.24 um (b20_barrido_base_lejos.pkl): fuga a -1.8 V y ruptura. Salida b20_lejos.txt"""
import pickle, subprocess, numpy as np
D = pickle.load(open("b20_barrido_base_lejos.pkl", "rb"))
AB = 0.1e-4 * 1.4e-4; JS = 2.1483e-9
o = open("b20_lejos.txt", "w")
def P(s):
    print(s); o.write(s + "\n")
P(subprocess.check_output(["date"]).decode().strip())
P("Juego H, tau = 0.1 ns. I(-1.8 V) por 1.4 um (tunel + TAT + Js del PDK); BV de avalancha (integral de ionizacion = 1, espacio muerto).")
P("PDK: bv del diodo p+/pozo n = 12.69 V (a20_pdk.txt); SkyWater (leida por agente): BVP 12.2 V (10.2-14.5). El modelo de avalancha sale ~20-40 % alto en union abrupta (b20_valida_bv.txt).")
P("Np     Nn     G   d    Nw     I(-1.8) A   tunel solo A  BVaval V")
for r in D["res"]:
    if r["Np"] != 1e20 or r["Nn"] != 2e20 or r["G"] not in (5, 20, 50): continue
    Va = -r["VR"]
    J = np.abs(r["JR"]) + 10 * np.abs(r["TR"]) + JS
    i18 = np.exp(np.interp(1.8, Va, np.log(J))) * AB
    t18 = np.interp(1.8, Va, np.abs(r["JR"])) * AB
    I = r["IID"]
    if I[-1] < 1: bv = np.inf
    else:
        i = int(np.argmax(I >= 1)); bv = Va[i - 1] + (Va[i] - Va[i - 1]) * (1 - I[i - 1]) / (I[i] - I[i - 1])
    P("%.0e  %.0e %3d  %3d  %.0e  %9.2e   %9.2e    %5.1f" % (r["Np"], r["Nn"], r["G"], r["d"], r["Nw"], i18, t18, bv))
o.close()
