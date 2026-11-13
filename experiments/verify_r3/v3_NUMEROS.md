# v3_NUMEROS — verificador independiente, ronda 3

Escrito: Thu Nov 12 19:51:52 EST 2026. **Hasta esta hora no he abierto ningún archivo de attack_xc58, attack_xc57_59_61 ni attack_xc60_62_63.**
Código: `v3_calc.py` → `v3_salida.txt`; `v3_f2.spice` → `v3_f2_salida.txt` (ngspice de hpretl/iic-osic-tools:2025.07, PDK 8afc8346, esquina tt, 27 °C);
`v3_g1.py` → `v3_g1_out/` (contenedor tt-precheck-local:ttsky26d, PDK 0536d02d, Magic 8.3.568, KLayout 0.30.8); `v3_g3.py` → `v3_g3_salida.txt`.
Nota: en el scratchpad de la sesión había ya copias de la documentación de SkyWater (csv/rst bajados a las 13:31–13:32 por un agente anterior);
solo usé las que bajé yo (assumptions.rst, masks.rst, periphery-rules.rst, 19:41) y, para la frase de las SRAM, `device-details.rst` (documento público).

## A. kT/C (XC-58)
- **A1.** Sumandos (fF): lector 0,42/0,15 en inversión débil: intrínseca 0,152–0,161 (ngspice, cgg a Vg 0,3–0,4 V) + solapes 2·cgdo·W = 0,206
  (cgdo = cgso = 2,449·10⁻¹⁰ F/m; cgsl = cgdl = 0) + franja 0,001. Interruptor 0,42/0,15: unión 0,220–0,275 (capbd de ngspice con AD = 0,42×0,265 µm²,
  PD = 1,37 µm; −20 % supuesto por polarización inversa) + solape de su puerta 0,103. Hilo: cabeza de poly 0,082 + li de 0,5–1,5 µm 0,058–0,145
  (tech l. 5302–5303, 5309–5310). **Total 0,82–0,97 fF** (hasta 1,24 fF si el lector entra en inversión fuerte). Cov/C = 0,106–0,125.
- **A2.** Modelo propio: interruptor en inversión débil con puerta en rampa; la inyección Cov·dVg/dt saca al interruptor del equilibrio y su ruido pasa
  de térmico (4kTg) hacia disparo (2qI, mitad). EDO de varianza linealizada + Monte Carlo no lineal (40 000 caminos; coincide dentro de 1 %).
  Resultado: σ²/(kT/C) = f(n·Cov/C), con f ≈ 1 − 0,69·n·Cov/C para n·Cov/C ≲ 0,3, y f → 1/2 para n·Cov/C ≥ 1 (límite de "reinicio blando").
  **Coeficiente respecto de Cov/C = 0,69·n = 0,83 (n=1,2), 0,90 (n=1,3), 0,97 (n=1,4), 1,04 (n=1,5).** La forma 1 − c·Cov/C se reproduce; el coeficiente
  no es universal: es proporcional a la pendiente n del interruptor. Supuestos: rampa (no escalón), interruptor siempre en inversión débil al congelar,
  Cov constante, sin la carga de canal del propio interruptor.
- **A3.** σ_t/t = σ_V/(n·U_T) = q/(n·√(kTC)) ∝ T^(−1/2): **−0,167 %/K** a 300 K (−0,14 a −0,20 si n deriva ±3·10⁻⁴/K, supuesto). Valor: 5,4–6,2 % con 0,963 fF.
  La varianza del observable va como 1/T (−0,33 %/K), no como T.
- **A4.** T = q²/(n²·k·C·s²) → dT/T = −dC/C: ±10 % en C ⇒ −27/+33 K (**±30 K** lineal) a 300 K. El cociente de varianzas con dos capacidades da C₂/C₁: T (y n) se cancelan.
- **A5.** NIST SP 800-90B (enero 2018), §3.1.1 "Data Collection": punto 1, "A sequential dataset of at least 1 000 000 sample values obtained directly from
  the noise source (i.e., raw data) shall be collected"; punto 3, "the entropy source must be restarted 1000 times; for each restart, 1000 consecutive samples
  shall be collected" (matriz 1000×1000; repetido en §3.1.4.1, r = 1000, c = 1000). Total **2·10⁶**. Punto 2: otro 1 000 000 de salidas condicionadas solo si
  hay componente de acondicionamiento no listado en §3.1.5.1.1. Leído en el PDF de nvlpubs.nist.gov con pdftotext.

## B. Peltier (XC-57)
- G' (2D, volúmenes finitos, poly 0,18 µm sobre 0,3262 µm de óxido de campo, tech l. 5052): 2,9–8,3 W/mK para w = 0,15–1,0 µm, k_ox 1,0–1,4.
- **B1.** Aleta 1D, R_th = 1/(2√(k_p·w·t·G')) = 0,75–4,6·10⁵ K/W; S·T·I·R_th con 100 µA, S 100–500 µV/K: **0,22–6,9 K** (w = 0,15: 0,8–6,9 K; w = 1: 0,2–1,9 K).
- **B2.** ΔT = −a·I + b·I²: óptimo existe. S = 300 µV/K: sin resistencia de contacto I* = 133–820 µA, enfriamiento neto 1,95–3,89 K (= (ST)²/(16·k_p·t·R_s),
  independiente de w), cruce 270–1640 µA; con 152 Ω de contacto en la unión: **I* = 92–217 µA, enfriamiento 0,66–2,4 K, cruce 184–435 µA**.
- **B3.** 2D (línea infinita, cota superior): 1,6–11,6 % a 0,5–1 µm. Corrección 3D (unión puntual, calor repartido en L_h = 0,3–0,9 µm, silicio como
  semiespacio): **0,2–1,0 %**.

## C. Borrado térmico (XC-59)
- **C1.** 2D, calefactor infinito, fondo a 30–300 µm: poly 1,6–15,6 %; li 1,1–6,8 %; conjunto **1,1–15,6 %** (d = 0,2–3 µm). Con largo finito 2–50 µm (3D aprox.):
  0,2–6,0 %. +200 K en el canal ⇒ calefactor a +1300…+18 000 K (2D) o más.
- **C2.** Elemento de poly de 0,15 µm entre dos calefactores a 0,21 µm: **70–77 %**; si el elemento mide 0,5 µm: 57–66 %.

## D. Congelación (XC-61)
- **D1.** E_D = 45 meV, g = 2: n/N_D = 10⁻³ a **36,7–37,7 K** (4–6·10¹⁷); a 77 K ionizado **5,7–6,9 %**. Con E_D rebajada por dopado (≈20 meV, Pearson–Bardeen,
  supuesto): 10⁻³ a 18 K y 31–37 % a 77 K. A 4–6·10¹⁷ la estadística de donador aislado es dudosa: está a un factor ~7 de la transición de Mott (3,7·10¹⁸),
  N^(1/3)·a_B ≈ 0,19; hay banda de impurezas, la energía de activación baja y por debajo de ~20–30 K la conducción por saltos entre donadores
  (con la compensación del pozo) sustituye a la de banda: la resistencia no sigue a n(T).
- **D2.** Lawaetz y Proctor, "Kinetics of bound electrons in Si:P", J. Phys. Soc. Japan 49 (1980) Supl. A, 333–336 (leído en PDF): muestra de 100 Ω·cm,
  5·10¹³ cm⁻³ de donadores, 18–37 K; "10 volts applied across the sample corresponds to a field of 125 V/cm" (pie de fig. 3; la figura llega a 19 V ≈ 240 V/cm).
  Son los campos aplicados en los pulsos de ruptura, no una curva de umbral. Germanio: no leí fuente primaria; solo un resumen (PRB 1979, n-Ge 4–9,5 K) que habla
  de campos "por encima de 6 V/cm". `[?]` para el número de Ge.

## E. Magnetodiodo (XC-60)
- **E1.** Cinta 5 µm × 0,36 µm, base a 1,3761 µm, 14 mA: lámina infinita 1,759 mT; en el centro, campo en el plano **1,25 mT** en la superficie activa
  (z = +0,33), 1,14 mT en z = 0, 0,99 mT a 0,5 µm, 0,87 mT a 1 µm, 0,69 mT a 2 µm bajo z = 0. En el borde de la cinta: 0,5–0,75 mT en el plano y 0,3–0,8 mT vertical.

## F. Proximidad (XC-62)
- **F1.** `sky130A.tech` (PDK 8afc8346): l. 4338 ancho 0,150 (poly.1a); l. 4339 separación 0,210 (poly.2); l. 4341–4344 poly a difusión 0,075 (poly.4);
  l. 4352 sobresalir del transistor 0,130 (poly.8; 0,110 en celdas SRAM, l. 4353); l. 4347–4351 difusión más allá de la puerta 0,250 (poly.7).
- **F2.** ngspice, nfet_01v8 W = 0,42, tt, Vds = 0,05 V: vth del modelo 774,45 mV (L = 0,150) → 772,63 (0,151) → 765,77 (0,155): **−1,81 mV/nm** (−1,74 medio hasta 0,155);
  a corriente constante (28 nA): 592,99 → 591,79 → 587,39 mV: **−1,20 mV/nm** (−1,12). Signo: el umbral baja al alargar (canal corto inverso). 17,3 mV ↔ 10–15 nm.
  No pude ir por debajo de 0,15 µm (fuera del bin).
- **F3.** No hallé una frase que diga literalmente "la fábrica aplica OPC en poly". Lo que sí está en skywater-pdk (docs/rules): regla (x.1a) "p1m.md (OPC), DECA and
  AMKOR layers (...) and mask data for p1m, met1, via, met2 must be on a grid of mm" 0,001; capa areaid.op (81:54) "OPC drop. Block automatic OPC (for fab blocks and
  lithocal structures)"; regla (x.9) "Shapes on maskAdd or maskDrop layers ("serifs") are allowed in core only"; device-details: las SRAM "are constructed with smaller
  design rules (Table 9), along with OPC (optical proximity correction) techniques". La página rules/opc.html da 404.

## G. Contacto sin implante (XC-63)
- **G1.** Sondas propias (hora 19:43–19:44): control (nwell + tap + nsdm + licon + li): Magic 0, KLayout feol/beol/offgrid 0/0/0. **La misma sin nsdm: Magic 1 error
  ("All nwells must contain metal-connected N+ taps (nwell.4)"), KLayout 0/0/0.** Con una difusión p+ en el pozo: 2 errores (nwell.4 y LU.3). Causa: Magic, al leer el GDS,
  descarta la toma sin implante (en el .mag no queda ni tap ni contacto; solo el li), y el pozo queda sin toma. Con una segunda toma normal en el mismo pozo: 0 en todo.
  Toma sin implante fuera de pozo: 0 en todo. Ninguna regla se dispara por el contacto en sí.
- **G2.** A* = 112 A/cm²K², área 2,89·10⁻¹⁰ cm², 300 K: sin rebaje **0,24–0,77 pA** (φ_B 0,60–0,57). Con rebaje por fuerza imagen (N_D 4–6·10¹⁷; campo 2,3–6,5·10⁵ V/cm
  entre 0 y 1,8 V de inversa; Δφ 53–88 meV): **2–25 pA**. Con A* = 252 (teórico <100>) todo ×2,25. E₀₀ ≈ 7 meV (kT/E₀₀ = 3,7): la emisión asistida por campo suma.
- **G3.** GDS del PDK, 70 celdas cap_vpp: las cinco `*_m1m2m3m4_shieldl1_fingercap*` (02p7x06p1, 02p7x11p1, 02p7x21p1, 02p7x41p1, 02p9x06p1…fingercap2) tienen todos sus
  licon (28, 52, 102, 202, 30) sobre tap (65:44) y ninguna geometría nsdm ni psdm; fuera de pozo n. **Además lo mismo pasa en dos más**: `05p9x05p9` y
  `11p3x11p3_m1m2m3m4_shieldl1_wafflecap` (60 y 112 licon). Son tomas sobre sustrato p, no sobre pozo n.
- **G4.** skywater-pdk.readthedocs.io/en/main/rules/periphery.html: (n/ psd.5b) "Enclosure of tap by nsdm(psdm), except for butting edge", 0,125 µm, marca P;
  (n/ psd.9) "Diff and tap must be enclosed by their corresponding implant layers. Rule exempted for …" (sello, anillos de difusión, gated_npn, areaid.zer);
  (licon.4) "Licon1 must overlap li1 and (poly or diff or tap)". La regla se llama "n/ psd.5b", no "nsd/psd.5b"; licon.4 tal como está escrita NO prohíbe un contacto
  sobre tap sin implante; la que lo prohíbe es n/ psd.9 (y 5b).
