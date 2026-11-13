"""v4n_descarga.py — descarga por túnel de una puerta flotante de 4,15 nm cargada por antena de plasma.

Supuestos (declarados, no medidos):
- Capacidad = solo C_ox de la propia puerta (sin metal añadido, sin agotamiento del silicio en serie). Entonces
  dV_ox/dt = -J(V_ox)/C_ox y el área se cancela (tautología).
- V es la tensión SOBRE EL ÓXIDO. La tensión del nodo difiere en V_fb + psi_s (≈ -1 V a +1 V según tipo de puerta y
  sustrato); el modelo no la conoce.
- Suministro de electrones ilimitado (emisor 3D degenerado). En agotamiento profundo sin fuente/drenaje que aporte
  portadores, la corriente real puede ser menor: el resultado es entonces un límite inferior de lo retenido.
- 27 °C constantes durante los 6 meses.
Método: t(V) = ∫_V^{V0} C_ox dV'/J(V') sobre rejilla fina, exacto salvo cuadratura (no hay integrador de EDO).
"""
import numpy as np
from v4n_tunel import J_tsu_esaki, J_schuegraf_hu, Cox

SEIS_MESES = 0.5 * 365.25 * 86400
Vg = np.concatenate([np.linspace(0.005, 3.0, 1200), np.linspace(3.0, 7.5, 300)[1:]])


def curva(model, tox, phi, mox):
    J = np.array([model(v, tox, phi, mox) for v in Vg])
    C = Cox(tox)
    inv = C / J
    # T(V) = ∫_V^{Vmax} C/J dV  (tiempo para bajar de Vmax a V)
    seg = 0.5 * (inv[1:] + inv[:-1]) * np.diff(Vg)
    Tcum = np.concatenate([np.cumsum(seg[::-1])[::-1], [0.0]])
    return Tcum, J


def V_en(t, V0, Tcum):
    T0 = np.interp(V0, Vg, Tcum)  # Tcum decrece con V
    tt = T0 + t
    # invertir: buscar V con Tcum(V)=tt; Tcum decreciente → usar arrays invertidos
    return np.interp(tt, Tcum[::-1], Vg[::-1]) if tt <= Tcum[0] else Vg[0]


def main():
    out = []
    p = out.append
    p("# modelo phi mox | t(7V->2V) s | V(1 s) desde 3.3/5/7 | V(6 meses) desde 3.3/5/7 | deriva mV/día a 6 meses | dV/dtox V/nm")
    res = []
    for name, model in (("TE", J_tsu_esaki), ("SH", J_schuegraf_hu)):
        for phi in (3.0, 3.1, 3.2):
            for mox in (0.40, 0.45, 0.50):
                Tc, J = curva(model, 4.15e-9, phi, mox)
                t72 = np.interp(2.0, Vg, Tc) - np.interp(7.0, Vg, Tc)
                v1 = [V_en(1.0, v0, Tc) for v0 in (3.3, 5.0, 7.0)]
                v6 = [V_en(SEIS_MESES, v0, Tc) for v0 in (3.3, 5.0, 7.0)]
                vd = V_en(SEIS_MESES + 86400, 5.0, Tc)
                deriva = (v6[1] - vd) * 1e3
                Ta, _ = curva(model, 4.10e-9, phi, mox)
                Tb, _ = curva(model, 4.20e-9, phi, mox)
                sens = (V_en(SEIS_MESES, 5.0, Tb) - V_en(SEIS_MESES, 5.0, Ta)) / 0.1
                # tiempo para bajar de 5 V a 1.5 V
                t15 = np.interp(1.5, Vg, Tc) - np.interp(5.0, Vg, Tc)
                res.append((name, phi, mox, v6[1], deriva, sens, max(v6) - min(v6), t15))
                p(f"{name} {phi} {mox:.2f} | {t72:.2e} | " + " ".join(f"{x:.4f}" for x in v1) + " | "
                  + " ".join(f"{x:.6f}" for x in v6) + f" | {deriva:.3f} | {sens:.3f} | t(5V->1.5V)={t15:.2e} s")
    for name in ("TE", "SH"):
        r = [x for x in res if x[0] == name]
        p(f"# {name}: V(6m) {min(x[3] for x in r):.3f}..{max(x[3] for x in r):.3f} V ; deriva {min(x[4] for x in r):.2f}..{max(x[4] for x in r):.2f} mV/día ;"
          f" sens {min(x[5] for x in r):.2f}..{max(x[5] for x in r):.2f} V/nm ; max|V6m(V0)-V6m(V0')| {max(x[6] for x in r):.2e} V")
    # sigma por desajuste de espesor de la tarjeta del PDK: sigma_rel = toxe_slope/sqrt(W*L[um^2])
    for disp, slope in (("nfet_01v8", 3.443e-3), ("pfet_01v8", 4.443e-3)):
        for A in (1.0, 0.15 * 0.42, 0.15 * 0.36):
            st = 4.148 * slope / np.sqrt(A)
            sens = [x[5] for x in res]
            p(f"# {disp} A={A:.4f} um^2: sigma_tox={st*1e3:.1f} pm -> sigma_V {min(sens)*st*1e3:.1f}..{max(sens)*st*1e3:.1f} mV")
    # explicación de la independencia: V(t) en la cola ~ V1*ln(t0/t): pendiente logarítmica
    for name, model in (("TE", J_tsu_esaki),):
        Tc, J = curva(model, 4.15e-9, 3.1, 0.45)
        for t in (1e3, 1e5, SEIS_MESES / 10, SEIS_MESES):
            a = V_en(t, 5.0, Tc); b = V_en(t * 10, 5.0, Tc)
            p(f"# TE 3.1/0.45: V({t:.1e} s)={a:.4f}  caída por década de t = {(a-b)*1e3:.1f} mV")
    txt = "\n".join(out)
    print(txt)
    open("v4n_descarga.txt", "w").write(txt + "\n")


if __name__ == "__main__":
    main()
