# e53 — Prerregistro de XC-53 (bomba de carga de alta tensión)

Hora de `date`: Fri Nov 13 07:16:20 EST 2026. Escrito ANTES de correr. Predicciones P-G1..G4 y P-H1 ya fijadas en `e14_PREREG.md` (12-nov 22:33:58).
Ya leído después de aquel prerregistro: tinytapeout.com/specs/analog (pin analógico < 500 Ω, < 5 pF, 4 mA máx.; VAPWR 3,3 V
opcional; met5 prohibido; tesela analógica 1×2 = 160 × 225 µm; sin mención de alta tensión interna). P-H1 ya se puede
calificar con eso; se califica en el informe.
Del PDK local (grep, 12-nov): `bvs = 11.7` en nfet_01v8, `bvs = 12.636` en nfet_g5v0d10v5; existen modelos
`diode_pw2nd_11v0`, `diode_pd2nw_11v0`, `cap_mim_m3_1/2`, `cap_var_hvt/lvt`.

## Qué se corre
- e53_dickson.py: modelo analítico de Dickson (V_out frente a N, f, C, C_par, I_carga, caída por etapa) desde 1,8 y 3,3 V.
- e53_*.sp en ngspice (imagen hpretl/iic-osic-tools:2025.07, PDK de la imagen montado solo lectura; nuestra carpeta como
  única escribible): Dickson con nfet_g5v0d10v5 en diodo (cuerpo a tierra), y variante con pfet_g5v0d10v5 en diodo con
  pozo propio unido a su fuente; N = 2..8; reloj 2 fases a 10 MHz; C de bombeo 1 pF ideal y C_par 10 %; carga 0 y 1 µA.
  Se mide V_out estacionaria y V_GS, V_DS y V(pozo-sustrato) máximos de cada dispositivo.

## Predicciones nuevas
- P-G5. nfet en diodo con cuerpo a tierra, desde 1,8 V: V_out < 5 V para todo N ≤ 8 (efecto de cuerpo). Desde 3,3 V,
  N = 4: 8–11 V en vacío.
- P-G6. pfet en diodo con pozo a su fuente, desde 1,8 V: ganancia 0,7–1,1 V por etapa → 6–9 V con N = 6–8.
- P-G7. Ningún dispositivo de la cadena ve |V_GS| > 1 etapa (≤ 2·VDD) si se usa conexión en diodo; el límite lo pone la
  unión pozo n – sustrato del último pfet o la n+/sustrato del último nfet (bvs 11,7–12,6 V, PDK).
- P-G8. Corriente útil a 1 V por debajo del vacío con 1 pF y 10 MHz: 1–5 µA.

## Qué la mata / qué la deja viva
- Muere si ninguna topología con dispositivos del PDK pasa de ~5,5 V desde 1,8 V ni desde 3,3 V, o si las reglas del PDK
  o de TT prohíben nodos internos > 5,5 V (dato que buscaré; si no existe, `[?]`).
- Vive si da ≥ 6 V a ≥ 100 nA en < 50 % de una tesela 1×2, con cada dispositivo dentro de su límite.

## Tautologías
- V_out(vacío) ideal = VDD + N·(α·VDD − V_d), α = C/(C+C_par): la simulación solo aporta V_d real.
- I_max ≈ f·C·(ΔV por etapa perdida); no hay física nueva, solo números.
