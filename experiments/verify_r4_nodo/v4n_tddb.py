"""v4n_tddb.py — tiempo a la ruptura del óxido de 4,15 nm, con dos anclas independientes entre sí y del agente.

ANCLA Q (cota inferior, especificación típica de calificación; NO es dato de SKY130, que es [?]):
  "10 años al 0,1 % acumulado, área de puerta total 0,1 cm^2, V_max = 1,1·1,8 = 1,98 V, 125 °C".
  De memoria (práctica habitual JEDEC/fundición), no leído en esta sesión. Si el proceso cumple esa especificación,
  t63(1 µm², 27 °C, V) es AL MENOS lo que da este cálculo. Extrapolación en tensión: ley de potencia n = 40–48
  (Wu, IBM, de memoria) y modelo E con gamma = 1–3 décadas por MV/cm (de memoria). Temperatura: Ea 0,3–0,8 eV.
ANCLA QBD (de memoria, sin fuente leída): carga a la ruptura de óxidos de ~4 nm bajo estrés de tensión constante
  QBD = 1–1000 C/cm^2 en ~1e-4 cm^2 a 27 °C. t_BD = QBD / J(V_ox), con J del modelo Tsu–Esaki propio (v4n_tunel).
  QBD se toma constante en V (simplificación; en óxidos finos QBD crece al bajar la tensión → t a 3,3 V sería mayor).
Escalado de área Weibull: t63 ∝ A^(-1/beta), beta = 1,2–2,5.
V es tensión sobre el óxido; la de puerta puede ser 0–1 V mayor (banda plana y agotamiento del poly).
"""
import numpy as np
from v4n_tunel import J_tsu_esaki

kB_eV = 8.617333e-5
ANIO = 365.25 * 86400


def ancla_Q(V, beta, n=None, gamma=None, Ea=0.5):
    tF = 10 * ANIO
    t63_A0 = tF / (-np.log(1 - 1e-3)) ** (1 / beta)
    t63_1um = t63_A0 * (0.1 / 1e-8) ** (1 / beta)
    acelT = np.exp(Ea / kB_eV * (1 / 300.15 - 1 / 398.15))
    t = t63_1um * acelT
    if n is not None:
        return t * (V / 1.98) ** (-n)
    # modelo E: log10 t cae gamma décadas por MV/cm; 1 MV/cm = 0,415 V en 4,15 nm
    return t * 10 ** (-gamma * (V - 1.98) / 0.415)


def ancla_QBD(V, beta, QBD, phi=3.1, mox=0.45):
    J = J_tsu_esaki(V, 4.15e-9, phi, mox)
    t_1e4 = QBD / J  # s, área 1e-4 cm^2
    return t_1e4 * (1e-4 / 1e-8) ** (1 / beta)


def main():
    out = []
    p = out.append
    betas = (1.2, 1.6, 2.0, 2.5)
    # Ancla Q
    vals = {}
    for V in (3.3, 5.0, 6.0, 7.0):
        ts = []
        for b in betas:
            for Ea in (0.3, 0.8):
                for n in (40, 48):
                    ts.append(ancla_Q(V, b, n=n, Ea=Ea))
                for g in (1.0, 3.0):
                    ts.append(ancla_Q(V, b, gamma=g, Ea=Ea))
        vals[V] = ts
        p(f"ANCLA Q (cota inferior) V_ox={V}: t63(1 um^2, 27 C) >= {min(ts):.1e} .. {max(ts):.1e} s (rango de la cota según modelo)")
    # Ancla QBD
    p("# ANCLA QBD: t63(1 um^2) frente a V_ox; rango sobre QBD 1–1000 C/cm^2, beta 1.2–2.5, (phi,mox) (3.0,0.40)..(3.2,0.50)")
    Vs = np.arange(3.0, 9.01, 0.1)
    lo, hi = [], []
    for V in Vs:
        ts = [ancla_QBD(V, b, Q, ph, m) for b in betas for Q in (1.0, 1000.0) for ph, m in ((3.0, 0.40), (3.2, 0.50))]
        lo.append(min(ts)); hi.append(max(ts))
    lo = np.array(lo); hi = np.array(hi)
    for V in (3.3, 5.0, 5.7, 6.5, 7.0, 7.4, 8.0):
        i = np.argmin(abs(Vs - V))
        p(f"  V_ox={V}: {lo[i]:.1e} .. {hi[i]:.1e} s")
    # tensión para 1 h
    lv = np.log10(lo); hv = np.log10(hi)
    V1h_min = np.interp(np.log10(3600), lv[::-1], Vs[::-1])
    V1h_max = np.interp(np.log10(3600), hv[::-1], Vs[::-1])
    p(f"  V_ox para t63 = 1 h (1 um^2): {V1h_min:.2f} .. {V1h_max:.2f} V")
    for tt, nom in ((60, "1 min"), (1, "1 s")):
        a = np.interp(np.log10(tt), lv[::-1], Vs[::-1]); c = np.interp(np.log10(tt), hv[::-1], Vs[::-1])
        p(f"  V_ox para t63 = {nom}: {a:.2f} .. {c:.2f} V")
    txt = "\n".join(out)
    print(txt)
    open("v4n_tddb.txt", "w").write(txt + "\n")


if __name__ == "__main__":
    main()
