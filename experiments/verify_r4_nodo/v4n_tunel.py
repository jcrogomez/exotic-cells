"""v4n_tunel.py — verificador independiente, ronda 4 (nodo flotante).

Túnel de electrones a través de SiO2 con dos modelos propios, sin anclar a ningún dato medido:
  M1  Tsu–Esaki con transmisión WKB por barrera trapezoidal y emisor 3D degenerado (integración numérica).
  M2  Fórmula analítica tipo Schuegraf–Hu (FN generalizada a barrera trapezoidal, sin corrección de
      punto de retorno): J = q^3 E^2/(16 pi^2 hbar phi) * exp(-4 sqrt(2 m_ox) phi^1.5 /(3 hbar q E) * (1-(1-V/phi)^1.5)).
Parámetros barridos (de memoria, rango habitual en la literatura de túnel en SiO2; no leído en esta sesión):
  phi_B (Si/SiO2 electrones) 3,0–3,2 eV; m_ox/m0 0,40–0,50. Emisor M1: E_F − E_C = 0,05 eV, m_emisor = 0,5 m0.
Unidades: J en A/cm^2, V es la tensión SOBRE EL ÓXIDO (V_ox), no la del nodo.
"""
import numpy as np

q = 1.602176634e-19
hbar = 1.054571817e-34
m0 = 9.1093837e-31
kB = 1.380649e-23
eps0 = 8.8541878128e-12


def T_wkb(Ex, V, tox, phi, mox):
    """Transmisión WKB; Ex y phi en eV medidos desde E_C del emisor; V en voltios (V>0 baja la barrera hacia el colector)."""
    n = 400
    x = (np.arange(n) + 0.5) / n * tox
    U = phi - V * x / tox  # eV
    d = np.clip(U[None, :] - Ex[:, None], 0, None) * q
    kappa = np.sqrt(2 * mox * m0 * d) / hbar
    return np.exp(-2 * kappa.sum(axis=1) * tox / n)


def J_tsu_esaki(V, tox, phi=3.1, mox=0.5, T=300.0, EF=0.05, mem=0.5):
    """A/cm^2. Corriente neta (directa menos inversa)."""
    kT = kB * T / q
    E = np.linspace(-0.3, max(phi, V) + 0.5, 1500)  # eV respecto a E_C del emisor
    Tr = T_wkb(E, V, tox, phi, mox)
    a = (EF - E) / kT
    N = np.logaddexp(0, a) - np.logaddexp(0, a - V / kT)
    pref = q * mem * m0 * kB * T / (2 * np.pi**2 * hbar**3)  # A/m^2 por J de energía
    J = pref * np.trapezoid(Tr * N, E * q)  # el emisor por debajo de E_C: transmisión ~0 de todos modos
    return J * 1e-4


def J_schuegraf_hu(V, tox, phi=3.1, mox=0.5):
    E = V / tox  # V/m
    phiJ = phi * q
    r = np.clip(1 - V / phi, 0, None)
    expo = -4 * np.sqrt(2 * mox * m0) * phiJ**1.5 / (3 * hbar * q * E) * (1 - r**1.5)
    J = q**3 * E**2 / (16 * np.pi**2 * hbar * phiJ) * np.exp(expo)
    return J * 1e-4


def Cox(tox, er=3.9):
    return er * eps0 / tox * 1e-4  # F/cm^2


if __name__ == "__main__":
    tox = 4.15e-9
    print("# J(V_ox) A/cm^2, tox=4.15 nm")
    print("# modelo  phi  mox   V=0.3   0.5   1.0   1.5   2.0   3.3")
    Vs = [0.3, 0.5, 1.0, 1.5, 2.0, 3.3]
    rows = []
    for phi in (3.0, 3.1, 3.2):
        for mox in (0.40, 0.45, 0.50):
            te = [J_tsu_esaki(v, tox, phi, mox) for v in Vs]
            sh = [J_schuegraf_hu(v, tox, phi, mox) for v in Vs]
            rows.append((phi, mox, te, sh))
            print("TE ", phi, mox, " ".join(f"{j:.2e}" for j in te))
            print("SH ", phi, mox, " ".join(f"{j:.2e}" for j in sh))
    te1 = [r[2][2] for r in rows]
    sh1 = [r[3][2] for r in rows]
    print(f"# J(1 V) Tsu-Esaki: {min(te1):.2e} .. {max(te1):.2e} ; Schuegraf-Hu: {min(sh1):.2e} .. {max(sh1):.2e}")
    print(f"# cociente TE/SH a 1 V (mismos phi,mox): {min(a/b for a,b in zip(te1,sh1)):.2f} .. {max(a/b for a,b in zip(te1,sh1)):.2f}")
    # pendiente con espesor a 1 V
    for phi, mox in ((3.1, 0.5), (3.1, 0.4)):
        j1 = J_tsu_esaki(1.0, 4.05e-9, phi, mox); j2 = J_tsu_esaki(1.0, 4.25e-9, phi, mox)
        print(f"# décadas/nm a 1 V (TE phi={phi} mox={mox}): {np.log10(j1/j2)/0.2:.2f}")
    # 11.6 nm a 5 V (y 11.75 nm del modelo pfet_g5v0d10v5)
    for t in (11.6e-9, 11.75e-9):
        js = [J_tsu_esaki(5.0, t, phi, mox) for phi in (3.0, 3.1, 3.2) for mox in (0.4, 0.5)]
        jsh = [J_schuegraf_hu(5.0, t, phi, mox) for phi in (3.0, 3.1, 3.2) for mox in (0.4, 0.5)]
        print(f"# tox={t*1e9:.2f} nm, V_ox=5 V: TE {min(js):.1e}..{max(js):.1e}  SH {min(jsh):.1e}..{max(jsh):.1e} A/cm^2")
        js6 = [J_tsu_esaki(5.5, t, phi, mox) for phi in (3.0, 3.1, 3.2) for mox in (0.4, 0.5)]
        print(f"#   V_ox=5.5 V: TE max {max(js6):.1e}")
    print(f"# Cox(4.15 nm) = {Cox(4.15e-9):.3e} F/cm^2")
