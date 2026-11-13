#!/usr/bin/env python
"""a52_coil.py — Biot–Savart propio para espirales cuadradas dibujables en SKY130 (ataque XC-52/XC-56, sub-afirmación b).

Datos de proceso (PDK local, ver a52_INFORME.md para rutas y líneas):
  met3/met4: ancho mín 0,3 µm, sep. mín 0,3 µm, 0,047 Ω/□, EM 6,8 mA/µm (CC media) y 14,9 mA/µm (eficaz) a Tj=90 °C
  met1/met2: ancho mín 0,14, sep. 0,14, 0,125 Ω/□, EM 2,8 / 6,1 mA/µm
  alturas (sky130A.tech, sección 'height'): superficie del silicio activa = 0,3262 µm (base del poly)
Modelo: cada vuelta = lazo cuadrado cerrado de semilado a_k = a0 + k·paso; cada traza = nf filamentos repartidos en el ancho,
a la altura del centro del metal. Campo evaluado en el plano del silicio (z = 0).
Constantes térmicas: DE MEMORIA (k_Si=148, k_SiO2=1,2 W/mK barrido 1,0–1,4; rho*c Si 1,63e6, SiO2 1,6e6 J/m3K).
"""
import numpy as np

MU0 = 4e-7 * np.pi
ZSI = 0.3262  # µm, base del poly = superficie del canal (sky130A.tech 'height allpoly')
LAY = {  # nombre: (z_centro sobre el silicio [µm], w_min, s_min, Rs [ohm/sq], EM_dc [mA/µm], EM_rms [mA/µm])
    "met1": (1.3761 + 0.36 / 2 - ZSI, 0.14, 0.14, 0.125, 2.8, 6.1),
    "met2": (2.0061 + 0.36 / 2 - ZSI, 0.14, 0.14, 0.125, 2.8, 6.1),
    "met3": (2.7861 + 0.845 / 2 - ZSI, 0.30, 0.30, 0.047, 6.8, 14.9),
    "met4": (4.0211 + 0.845 / 2 - ZSI, 0.30, 0.30, 0.047, 6.8, 14.9),
}


def seg_field(p, a, b):
    """Campo (T por A) en puntos p[...,3] de un segmento recto a->b (metros). Fórmula cerrada."""
    ab = b - a
    L = np.linalg.norm(ab)
    u = ab / L
    ap = p - a
    t = ap @ u
    perp = ap - t[..., None] * u
    d = np.linalg.norm(perp, axis=-1)
    d = np.maximum(d, 1e-12)
    s1 = t / np.sqrt(t**2 + d**2)
    s2 = (t - L) / np.sqrt((t - L) ** 2 + d**2)
    mag = MU0 / (4 * np.pi * d) * (s1 - s2)
    dirv = np.cross(u, perp / d[..., None])
    return mag[..., None] * dirv


def spiral_field(pts, a0, pitch, N, w, z, nf=5):
    """pts en metros (plano z=0). Espiral de N lazos cuadrados, semilado a0 + k*pitch, a altura z. Devuelve B por amperio."""
    B = np.zeros(pts.shape)
    offs = (np.arange(nf) + 0.5) / nf * w - w / 2 if nf > 1 else [0.0]
    for k in range(N):
        for o in offs:
            a = a0 + k * pitch + o
            c = [np.array([-a, -a, z]), np.array([a, -a, z]), np.array([a, a, z]), np.array([-a, a, z])]
            for i in range(4):  # antihorario -> Bz>0 dentro
                B += seg_field(pts, c[i], c[(i + 1) % 4]) / len(offs)
    return B


def grid(side_um, n=21):
    s = np.linspace(-side_um / 2, side_um / 2, n) * 1e-6
    X, Y = np.meshgrid(s, s)
    return np.stack([X, Y, np.zeros_like(X)], -1)


def analyse(layer, a0_um, N, w_um=None, s_um=None, I_mA=10.0, verbose=True):
    z_um, wmin, smin, Rs, em_dc, em_rms = LAY[layer]
    w = wmin if w_um is None else w_um
    s = smin if s_um is None else s_um
    if w >= 3.0:
        s = max(s, 0.4)  # regla de separación para ancho >= 3 µm (tlef SPACINGTABLE)
    pitch = w + s
    um = 1e-6
    B0 = spiral_field(np.array([[0.0, 0.0, 0.0]]), a0_um * um, pitch * um, N, w * um, z_um * um)[0]
    out = {"layer": layer, "a0": a0_um, "N": N, "w": w, "pitch": pitch, "z": z_um, "Bz_mT_per_mA": B0[2] * 1e3 * 1e-3 * 1e3}
    # B0 [T/A]; T/A * 1e-3 A/mA * 1e3 mT/T = mT/mA numéricamente igual
    out["Bz_mT_per_mA"] = B0[2]
    for side in (1, 3, 10):
        Bg = spiral_field(grid(side), a0_um * um, pitch * um, N, w * um, z_um * um)
        bz = Bg[..., 2]
        bpar = np.hypot(Bg[..., 0], Bg[..., 1])
        out[f"unif{side}"] = (bz.min() / B0[2], bz.max() / B0[2], bz.mean() / B0[2], bpar.max() / B0[2])
    length = sum(8 * (a0_um + k * pitch) for k in range(N))  # µm
    R = Rs * length / w
    out.update(length=length, R=R, a_out=a0_um + (N - 1) * pitch + w / 2)
    I = I_mA * 1e-3
    out["P_mW"] = I * I * R * 1e3
    out["V"] = I * R
    out["J_mA_um"] = I_mA / w
    out["Idc_max_mA"] = em_dc * w
    out["Irms_max_mA"] = em_rms * w
    out["B_at_I_mT"] = B0[2] * I_mA
    out["B_at_Idc_max_mT"] = B0[2] * out["Idc_max_mA"]
    out["B_at_Irms_max_mT"] = B0[2] * out["Irms_max_mA"]
    # Térmico estacionario: fuente cuadrada de lado 2*a_out sobre semiespacio de Si: dT_media = 0,4732*P/(k*lado)
    kSi, kox = 148.0, 1.2
    side = 2 * out["a_out"] * um
    out["dT_Si_K"] = 0.4732 * (out["P_mW"] * 1e-3) / (kSi * side)
    # salto a través del óxido (1D, área = huella de metal con ensanche 45° ~ +z a cada lado)
    area = length * um * (w + 2 * z_um * 0.5) * um
    area = min(area, side * side)
    out["dT_ox_K"] = (out["P_mW"] * 1e-3) * (z_um * um) / (kox * area)
    return out


def fmt(o):
    u1, u3, u10 = o["unif1"], o["unif3"], o["unif10"]
    return (f"{o['layer']:5s} a0={o['a0']:5.1f} N={o['N']:2d} w={o['w']:4.2f} paso={o['pitch']:4.2f} z={o['z']:4.2f} | "
            f"Bz0={o['Bz_mT_per_mA']:6.3f} mT/mA | unif(min/centro) 1x1={u1[0]:5.3f} 3x3={u3[0]:5.3f} 10x10={u10[0]:6.3f} "
            f"(max {u10[1]:5.2f}, |Bpar|max {u10[3]:4.2f}) | R={o['R']:6.1f} ohm | 10mA: P={o['P_mW']:6.2f} mW V={o['V']:5.2f} V "
            f"J={o['J_mA_um']:5.1f} mA/um | Idc_max={o['Idc_max_mA']:5.2f} mA -> {o['B_at_Idc_max_mT']:5.2f} mT ; "
            f"Irms_max={o['Irms_max_mA']:5.2f} mA -> {o['B_at_Irms_max_mT']:5.2f} mT | dT_Si(10mA)={o['dT_Si_K']:6.3f} K dT_ox={o['dT_ox_K']:6.2f} K")


if __name__ == "__main__":
    print("# Validación: lazo cuadrado filamentario de semilado 10 µm en z=0: B_centro analítico = 2*sqrt(2)*mu0/(pi*lado)")
    um = 1e-6
    b = spiral_field(np.array([[0.0, 0.0, 0.0]]), 10 * um, 1 * um, 1, 0.0, 0.0, nf=1)[0][2]
    print(f"  numérico {b:.6f} T/A  analítico {2*np.sqrt(2)*MU0/(np.pi*20*um):.6f} T/A ; espira circular r=10: {MU0/(2*10*um):.6f}")
    # eje de lazo circular vs cuadrado en z=2.88
    print("\n# 1) La afirmación literal: 5 vueltas, 'radio' 10 µm (semilado medio 10 µm), 10 mA")
    for layer in ("met3", "met4"):
        for w in (None, 1.5, 3.0):
            wv = LAY[layer][1] if w is None else w
            sv = 0.4 if wv >= 3 else 0.3
            p = wv + sv
            a0 = 10 - 2 * p  # semilado medio = 10
            if a0 - wv / 2 <= 0.3:
                a0 = wv / 2 + 0.5
            print(fmt(analyse(layer, a0, 5, w_um=w)))
    print("\n# 2) Barrido: semilado interior a0, vueltas N, capa, ancho mínimo (campo máximo por mA)")
    for layer in ("met2", "met3", "met4"):
        for a0 in (1.0, 2.0, 5.0, 10.0, 20.0):
            for N in (1, 3, 5, 10):
                print(fmt(analyse(layer, a0, N)))
    print("\n# 3) Ancho conforme a electromigración para 10 mA en CC (>= 10/6,8 = 1,47 µm) y eficaz (>= 0,67 µm), met3")
    for w in (0.3, 0.7, 1.5, 3.0):
        for a0 in (2.0, 5.0, 10.0):
            for N in (1, 3, 5):
                print(fmt(analyse("met3", a0, N, w_um=w)))
    print("\n# 4) met3+met4 en serie (misma huella, 5+5 vueltas, ancho mínimo): suma de campos por mA")
    for a0 in (2.0, 5.0, 10.0):
        o3, o4 = analyse("met3", a0, 5), analyse("met4", a0, 5)
        print(f"a0={a0}: {o3['Bz_mT_per_mA']+o4['Bz_mT_per_mA']:.3f} mT/mA, R={o3['R']+o4['R']:.0f} ohm")
    print("\n# 5) Bifilar (ida y vuelta entrelazadas, paso w+s): campo residual en el centro relativo a la bobina normal")
    for a0 in (2.0, 5.0, 10.0):
        z, w, s = LAY["met3"][0], 0.3, 0.3
        p = w + s
        tot = 0.0
        nor = 0.0
        for k in range(10):
            bk = spiral_field(np.array([[0.0, 0.0, 0.0]]), (a0 + k * p) * um, p * um, 1, w * um, z * um)[0][2]
            tot += bk * (1 if k % 2 == 0 else -1)
            nor += bk
        Bg_n = 0
        print(f"a0={a0}: normal 10 vueltas {nor:.3f} mT/mA ; bifilar (5 ida + 5 vuelta) {tot:.4f} mT/mA ; residuo {tot/nor*100:.1f} %")
