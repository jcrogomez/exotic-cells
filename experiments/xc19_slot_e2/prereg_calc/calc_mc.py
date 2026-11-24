"""MISFIT-03 enmienda 2: numeros de prediccion del Monte Carlo, calculados antes de congelar. Salida: calc_mc.txt
Entradas del repo:
  trampa: 0,305 mV en la puerta del DUT (prerregistro MISFIT-03, tabla de la etapa a)
  sigma_Vth 17,3 mV por nfet 0,42/0,15 (experiments/lod_audit/README.md); n en 1,3-1,6 ([?], como calc.py)
  tA nominal src=01 a tt 27 en el macro v_hm: 30,8732 us desde T0 (contrato de diseno a2, h01_oa = 31,8732 us absoluto)
  referencia: 2 en serie x 6 en paralelo de nfet 0,42/0,15 con la puerta en VB (enmienda 1, E2)
Modelo: subumbral, I = I0 exp(-dVth/(n Ut)). Serie de dos con la misma puerta: 1/I = 1/I1 + 1/I2 (EKV directo). Solo desajuste
local de los dispositivos que descargan; el espejo y VB son comunes a A y B y aqui no entran (por eso el reparto de tA de un chip
es una cota inferior)."""
import math, random
q, kB = 1.602e-19, 1.381e-23
Ut = kB * 300.15 / q; SV = 17.3e-3; TRAP = 0.305e-3; TA = 30.8732e-6; F = 50e6
out = []
rng = random.Random(20261124)
for n in (1.3, 1.6):
    st = math.exp(TRAP / (n * Ut)) - 1
    out.append(f"n = {n}: salto de trampa dI/I = {st*100:.3f} %  (cuentas nominales a tt: {st/(1+st)*TA*F:.2f})")
    s = SV / (n * Ut)
    # fraccion de chips con la trampa < 10 cuentas: tA del DUT lognormal con sigma s (solo el DUT; cota inferior del reparto)
    t10 = 10 / (st / (1 + st) * F)
    z = math.log(t10 / TA) / s
    frac = 0.5 * (1 + math.erf(z / math.sqrt(2)))
    out.append(f"   sigma ln I (DUT) = {s:.3f}; trampa < 10 cuentas si tA < {t10*1e6:.2f} us -> fraccion de chips {frac*100:.1f} %")
    # referencia 2x6: sigma ln I_ref y sigma ln(tA/tB) en src = 11, por Monte Carlo de 200000 tiradas
    def ref():
        tot = 0.0
        for _ in range(6):
            i1 = math.exp(rng.gauss(0, s)); i2 = math.exp(rng.gauss(0, s))
            tot += 1 / (1 / i1 + 1 / i2)
        return tot
    N = 200000
    r = [math.log(ref() / ref()) for _ in range(N)]
    m = sum(r) / N; sd = math.sqrt(sum((x - m) ** 2 for x in r) / (N - 1))
    out.append(f"   referencia 2x6: sigma ln(tA/tB) en src = 11 = {sd:.4f}")
open("calc_mc.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
