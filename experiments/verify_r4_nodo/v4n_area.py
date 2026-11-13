"""v4n_area.py — estimación de área (sin trazado) de la bomba de v4n_dickson frente a una tesela analógica 1×2 (160×225 µm).
MIM: 22×22 µm de capm + 1 µm de margen por lado (reglas de separación/encierro aproximadas, de memoria: [?] exactas).
pfet_g5v0d10v5 W=5 L=0,5 en pozo propio con anillo: 10×8 µm por dispositivo (supuesto; [?] sin trazado).
"""
tesela = 160 * 225
for N in (6, 8):
    mim = N * (22 + 2) ** 2
    pf = (N + 1) * 10 * 8
    cout = (2e-12 / 2e-15) + 100  # 2 pF de C_out en MIM, µm²
    for con_cout in (False, True):
        a = mim + pf + (cout if con_cout else 0)
        print(f"N={N} C_out en MIM={con_cout}: {a:.0f} um^2 = {100*a/tesela:.1f} % de 1x2")
