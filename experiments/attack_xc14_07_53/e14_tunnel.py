"""e14_tunnel.py — túnel a través de SiO2: modelo WKB propio anclado a curvas medidas (Gupta et al., IEEE EDL dic. 1997,
reproducidas en las diapositivas EE311 de K. Saraswat, Stanford, p. 10, «Conduction in Thin Oxides»).

Grados: los puntos digitalizados son LEÍDOS DE UNA FIGURA (fuente secundaria; lectura a ojo, incertidumbre ~±0,3 décadas
en J y ±0,1 V en V). Polaridad y si el espesor es físico o eléctrico: [?] (la figura no lo dice; dopado del poly 3,5e19).
Suelo de medida de la figura: ~1e-5 A/cm² (10 µA/cm²): por debajo no hay dato.

Modelo: J = C0 * (q^3 m / (8 pi h phi m_ox)) * E^2 * exp(-2/hbar * int_0^t sqrt(2 m_ox (phi - q E x)) dx),
con E = (V - V0)/t. Parámetros ajustados por mínimos cuadrados en log J: m_ox, V0, log10 C0, con phi barrida (3,0-3,2 eV).
Ajuste SOLO con 36,5 / 45,5 / 57,0 Å (régimen FN y transición); validación fuera de muestra: curva de 25,8 Å (túnel directo).
Salida: e14_tunnel.txt, e14_tunnel.png
"""
import numpy as np
from scipy.optimize import least_squares
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import os

HERE = os.path.dirname(os.path.abspath(__file__))
q = 1.602176634e-19; h = 6.62607015e-34; hbar = h / (2 * np.pi); m0 = 9.1093837e-31
EPS_OX = 3.9 * 8.8541878128e-12

# (V, J en µA/cm²) leídos de la figura
DATA = {
    25.8: [(0.95, 1e2), (1.2, 3e2), (1.5, 7e2), (2.0, 1.8e3), (2.5, 5e3), (3.0, 1.4e4), (3.5, 3.5e4), (4.0, 1e5), (4.5, 3e5)],
    36.5: [(4.4, 2e2), (4.6, 8e2), (4.8, 2e3), (5.1, 1e4), (5.6, 1e5), (6.1, 1e6), (6.9, 1e7)],
    45.5: [(5.1, 1e2), (5.6, 1e3), (6.1, 1e4), (6.7, 1e5), (7.4, 1e6), (8.2, 1e7)],
    57.0: [(6.1, 1e2), (6.6, 1e3), (7.3, 1e4), (8.0, 1e5), (8.9, 1e6), (10.0, 1e7)],
}


def wkb_exponent(t, vox, mox, phi):
    """2/hbar * integral of kappa over the classically forbidden part of a trapezoidal/triangular barrier."""
    x = np.linspace(0, t, 400)
    U = phi - vox * x / t  # eV
    k = np.sqrt(np.clip(2 * mox * m0 * U * q, 0, None)) / hbar
    return 2 * np.trapezoid(k, x)


def J_model(t_ang, V, mox, V0, logC, phi):
    t = t_ang * 1e-10
    vox = np.maximum(np.asarray(V, float) - V0, 1e-3)
    out = []
    for v in np.atleast_1d(vox):
        E = v / t
        pref = q**3 / (8 * np.pi * h * phi * q) / mox * E**2  # A/m²
        out.append(10**logC * pref * np.exp(-wkb_exponent(t, v, mox, phi)))
    return np.array(out) * 1e-4  # A/cm²


def fit(phi, thick=(36.5, 45.5, 57.0)):
    pts = [(t, v, j * 1e-6) for t in thick for v, j in DATA[t]]

    def res(p):
        mox, V0, logC = p
        return np.array([np.log10(J_model(t, v, mox, V0, logC, phi)[0]) - np.log10(j) for t, v, j in pts])

    r = least_squares(res, x0=[0.42, 0.8, 0.0], bounds=([0.2, -0.5, -6], [0.8, 2.0, 6]))
    return r.x, np.sqrt(np.mean(r.fun**2))


def main():
    lines = []
    P = lambda s="": (lines.append(s), print(s))
    P("e14_tunnel — ajuste WKB a Gupta 1997 (vía Saraswat EE311 p.10). Lectura a ojo ±0,3 déc.")
    fits = {}
    for phi in (3.0, 3.1, 3.2):
        x, rms = fit(phi)
        fits[phi] = x
        P(f"phi={phi:.1f} eV: m_ox={x[0]:.3f} m0, V0={x[1]:.2f} V, log10C0={x[2]:+.2f}; rms ajuste={rms:.2f} déc")
        # validación fuera de muestra: 25,8 Å
        for V0_dt in (x[1], 0.0):
            err = [np.log10(J_model(25.8, v, x[0], V0_dt, x[2], phi)[0]) - np.log10(j * 1e-6) for v, j in DATA[25.8]]
            P(f"   validación 25,8 Å con V0={V0_dt:.2f}: error medio {np.mean(err):+.2f} déc, máx |err| {np.max(np.abs(err)):.2f} déc")
    # Leave-one-thickness-out
    P("\nDejar un espesor fuera (phi=3,1): ajustar con dos, predecir el tercero")
    for out in (36.5, 45.5, 57.0):
        keep = tuple(t for t in (36.5, 45.5, 57.0) if t != out)
        x, _ = fit(3.1, keep)
        err = [np.log10(J_model(out, v, *x, 3.1)[0]) - np.log10(j * 1e-6) for v, j in DATA[out]]
        P(f"  fuera {out} Å: m_ox={x[0]:.3f}, V0={x[1]:.2f}; error medio {np.mean(err):+.2f}, máx {np.max(np.abs(err)):.2f} déc")

    # Predicción a 41,5 Å (SKY130 nfet_01v8 toxe=4,148 nm, PDK local) y 116 Å (g5v0d10v5)
    P("\nPredicción J(V) [A/cm²] para 41,5 Å. Escenarios: phi 3,0-3,2; V0 ajustado (régimen FN) o V0=0 (diferencia de")
    P("niveles de Fermi toda en el óxido: cota alta); método B = curva medida de 25,8 Å escalada por WKB.")
    Vs = np.array([0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.3, 1.5, 1.8, 2.5, 3.3, 4.0, 5.0, 6.0])
    table = {}
    for phi, x in fits.items():
        for V0 in (x[1], 0.0, 0.5):
            table[(phi, V0)] = J_model(41.5, Vs, x[0], V0, x[2], phi)
    # método B: escalar la curva de 25,8 Å medida (solo V>=0,95, por encima del suelo)
    vB = np.array([v for v, _ in DATA[25.8]]); jB = np.array([j * 1e-6 for _, j in DATA[25.8]])
    B = {}
    for phi, x in fits.items():
        for V0 in (0.0, 0.5):
            r = J_model(41.5, vB, x[0], V0, 0, phi) / J_model(25.8, vB, x[0], V0, 0, phi)
            B[(phi, V0)] = jB * r
    arr = np.array(list(table.values()))
    lo, hi = arr.min(0), arr.max(0)
    P(f"{'V':>5} {'J_min':>10} {'J_max':>10}   (método A, todos los escenarios)")
    for i, v in enumerate(Vs):
        P(f"{v:5.2f} {lo[i]:10.2e} {hi[i]:10.2e}")
    P("Método B (25,8 Å medida × T(41,5)/T(25,8)):")
    arrB = np.array(list(B.values()))
    for i, v in enumerate(vB):
        P(f"{v:5.2f} {arrB[:, i].min():10.2e} {arrB[:, i].max():10.2e}")
    # óxido grueso 11,6 nm a baja tensión
    P("\nÓxido de 116 Å (nfet_g5v0d10v5, toxm=1,16e-8, PDK local) — J [A/cm²]:")
    for v in (1.0, 3.3, 5.0, 8.0, 10.0, 12.0, 14.0):
        js = [J_model(116, v, x[0], V0, x[2], phi)[0] for phi, x in fits.items() for V0 in (x[1], 0.0)]
        P(f"  {v:5.1f} V: {min(js):.2e} – {max(js):.2e}")
    np.save(os.path.join(HERE, "e14_tunnel_fits.npy"), np.array([[phi, *x] for phi, x in fits.items()]))
    with open(os.path.join(HERE, "e14_tunnel.txt"), "w") as f:
        f.write("\n".join(lines) + "\n")

    fig, ax = plt.subplots(figsize=(7, 5))
    x = fits[3.1]
    vv = np.linspace(0.1, 10, 200)
    for t, c in zip((25.8, 36.5, 45.5, 57.0), ("C0", "C1", "C2", "C3")):
        d = np.array(DATA[t]); ax.semilogy(d[:, 0], d[:, 1] * 1e-6, "o", color=c, label=f"{t} Å leído")
        ax.semilogy(vv, J_model(t, vv, *x, 3.1), "-", color=c, lw=1)
    ax.fill_between(Vs, lo, hi, color="k", alpha=0.2, label="41,5 Å, envolvente")
    ax.axhline(1e-5, ls=":", color="gray"); ax.text(6.5, 1.3e-5, "suelo de medida", color="gray")
    ax.set_ylim(1e-22, 1e2); ax.set_xlabel("V puerta (V)"); ax.set_ylabel("J (A/cm²)"); ax.legend(fontsize=7)
    ax.set_title("e14: WKB ajustado a 36,5/45,5/57 Å; 25,8 Å fuera de muestra")
    fig.tight_layout(); fig.savefig(os.path.join(HERE, "e14_tunnel.png"), dpi=120)


if __name__ == "__main__":
    main()
