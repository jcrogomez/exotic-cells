# v4o_eta.py — eficiencia interna de emision (fotones por electron de corriente del emisor) del diodo p+/pozo n en directa.
# Sin calibrar: da intervalo por componentes, no un numero. Entradas:
#  TF = 6.15e-10 s y BF = 16.6 / 19.35, IKF = 0.386 mA (3.4x3.4) / 33 uA (0.68x0.68): PDK local, modelos pnp_05v5.
#  B = 4.7e-15 a 9.5e-15 cm^3/s (Nguyen 2014 / Trupke 2003, valores DE MEMORIA, no leidos en esta sesion) [?]
#  Auger C_p ~ 1e-31 cm^6/s (de memoria) [?]; dopados del pozo y del p+ no publicos: se barren.
import numpy as np
TF = 6.15385e-10
B = (4.7e-15, 9.5e-15)
print("(i) huecos almacenados en la base (pozo n): eta_b = TF*B*N_D (baja inyeccion; TF es cota superior del tiempo en base)")
for ND in (5e16, 1e17, 3e17):
    print(f"   N_D={ND:.0e}: {TF*B[0]*ND:.1e} .. {TF*B[1]*ND:.1e}")
# alta inyeccion: con I >> IKF la densidad de huecos supera N_D; tasa ~ B*p*(N_D+p): factor ~ (1 + I/IKF) (aprox. Gummel-Poon q_b)
A_e = 1.0*1.4  # um^2
ikf_lo, ikf_hi = 0.386e-3/(3.4*3.4)*A_e, 33e-6/(0.68*0.68)*A_e
print(f"   IKF escalado al p+ 1.0x1.4: {ikf_lo*1e6:.0f}..{ikf_hi*1e6:.0f} uA -> factor de alta inyeccion a 0.17 mA: "
      f"{1+0.17e-3/ikf_hi:.1f}..{1+0.17e-3/ikf_lo:.1f}; a 1 mA: {1+1e-3/ikf_hi:.0f}..{1+1e-3/ikf_lo:.0f}")
print("(ii) electrones inyectados en el p+ (fraccion 1/(BF+1) de la corriente), recombinan en <= tau_eff ~ 1e-10..1e-9 s")
for NA, bred in ((1e19, 0.7), (1e20, 0.3)):   # bred: reduccion de B a dopado alto (de memoria, Altermatt) [?]
    for tau in (1e-10, 1e-9):
        print(f"   N_A={NA:.0e}, tau={tau:.0e}: eta_e = {1/17.6*tau*B[0]*bred*NA:.1e} .. {1/17.6*tau*B[1]*bred*NA:.1e}"
              "  (fotones desplazados al rojo por BGN: alfa medio x0.1..0.3, ver v4o_alpha)")
