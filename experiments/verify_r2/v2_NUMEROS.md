# v2_NUMEROS — mis números, fijados Thu Nov 12 19:08:05 EST 2026

Fijados ANTES de abrir ningún INFORME ni resultado de attack*/attack2*. Lo único leído de esas carpetas: `attack2_xc52/b52_bobinas.py` l. 1–30 y 66–92
(geometría), 19:03 EST. Todo sale de `v2_calc.py` → `v2_salida.txt` (corrida 19:07 EST). A4 y las resistividades de B1 (literatura) estaban
pendientes del subagente web a esta hora: se añaden abajo con su propia hora, también antes de leer informes.

## A
- **A1** (modelo: perfil min(Npk, N0·10^(∓x/L)), vaciamiento numérico, BTBT local, área 1,4 µm × 0,1 µm, −1,8 V). Parámetros de memoria.
  - Hurkx/Kane (A=4e14, P=2,5, B=1,9e7), colas que se cruzan al nivel del pico (N0=Npk): **57 nA … 50 µA**. Con N0/Npk=0,3: 18 nA … 38 µA. Con 0,1: 0,13 nA … 3,7 µA.
  - Los otros dos juegos (P=2 "Schenk-tipo"; Kane E1) dan 2–3 décadas más (hasta 8–97 mA): no me los creo a 3–5 MV/cm; el dato de Dutta
    (≈21 µA/µm a ≈2 V en 65 nm) cuadra con el juego Hurkx (mi tope 36 µA/µm) y no con ellos.
  - Mi intervalo: **~1e-10 … 5e-5 A** (central 1e-7…1e-5). W = 9–31 nm; Emax = 1,4–5,4 MV/cm.
- **A2**: leído por subagente el texto completo del artículo (PDF de ris.utwente.nl; la tesis no abrió). Título real: "Optical Power Efficiency Versus
  Breakdown Voltage of Avalanche-Mode Silicon LEDs in CMOS". **No hay "23 µA/µm a 1,8 V" ni "0,04 V/nm" escritos en el texto.** Lo que hay:
  W = 47,6 µm; V_BR definido a 1 mA; D1 (d=0) V_BR ≈ 2 V → 21 µA/µm a ≈2 V (derivado, no reportado); d de 0 a 280 nm en pasos de 20; V_BR de 2 a 9 V;
  D6 (100 nm) ≈ 6 V → 0,04 V/nm solo entre 0 y 100 nm; 0,025 V/nm en todo el rango (satura). BTBT declarado para d ≤ 60 nm. 65 nm bulk.
- **A3** (equilibrio, 10 nm/déc, picos 1e20–3e20, N0/Npk 0,1–1): el nivel de Fermi **sigue dentro de las dos bandas** en los bordes:
  xi_n = +19…+88 meV, xi_p = +14…+179 meV (según Nv). W = 5,8–11,9 nm; anchura de túnel Eg/(q·Emax) = 3,1–7,6 nm; Emax 1,5–3,7 MV/cm.
  A 5 nm/déc: W 4,9–9,0 nm, túnel 2,4–5,5 nm. Entre 5 y 10 nm/déc la escala de corriente de túnel cambia ×4…×70, sin umbral.
  La degeneración solo se pierde (xi_n ≤ 0) hacia ≥15–20 nm/déc con 1e20 y N0/Npk=0,1.
  Mi frontera (criterio Emax ≳ 2,5–3 MV/cm, túnel ≲ 4 nm; el número de corte es de memoria, no leído): con N0=Npk, 1e20 → ≲5–7 nm/déc;
  2e20 → ≲15 nm/déc; 3e20 → ≲20. Con N0/Npk=0,1: 1e20 → ≲3; 2e20 → ≲5; 3e20 → ≲7. La corriente de exceso (trampas) no la modelo: no puedo fijar PVCR.
- **A4**: pendiente (ver adenda).

## B
- **B1**: barreras solas, w=0,14: **38–238 Ω/µm** (central 97 y 150 según pila; 143–190 si el Ti se consume en TiAl3). Vacío 24–39 nm: 2,3–5,9 Ω (central).
  Vacío 100–500 nm: 10–75 Ω (central). Resistividades de memoria: Ti 60–200, TiN 50–400, TiW 60–120 µΩ·cm.
- **B2**: R = 75,3 Ω (1 µm), 150,6 Ω (2 µm). Óxido bajo li 0,61–0,94 µm (Magic l. 5056: li base 0,9361; superficie 0,2062–0,3262). R_th' 2D = 0,32–0,65 K·m/W.
  Cuello 1 µm: ΔT central 520 K (4,2 mA) y 1770 K (7,8 mA) [3D Green]; horquilla completa 136 K (extremos fríos, k alta) … 2960 K. "Orden de 1000 K": sí.
  Cuello 2 µm: 360–590 K (4,2 mA), 1240–2030 K (7,8 mA) central.
  ¿Alcanzable? V=IR: 0,32–0,59 V (1 µm), 0,63–1,17 V (2 µm) → sobre el tramo sí (máx. 23,9 y 12,0 mA); pero a 2 µm y 7,8 mA quedan 0,63 V para los
  drivers: que sigan dando 0,26 mA cada uno con ese V_DS es [?].
  Línea a 1,8 V: 10 µm → **439 / 488 / 578 K**; 5 µm → **857 / 1050 / 1413 K** (k_ox 1,4 / 1,1 / 0,8). Sin subida de R con T ni resistencia de drivers.
- **B3**: régimen ≤ V_th = 48 mV. Salto 100 Ω → abierto con 50 fF: primer orden, tau = R_ref·C, sin sobreimpulso; cota 48 mV.
  Acoplo de 1,8 V por 0,2 fF: divisor capacitivo +7,2 mV con 50 fF (pico 55 mV); +69 mV con 5 fF (117 mV); +24 mV con 15 fF (72 mV); +300 mV con 1 fF.

## C
- **C1** (G3, N=4, w=1,5, s=0,3, a_in=7; centro): **0,373 mT/mA** (z=0 Magic), 0,384 (superficie Si a 0,3262). 2 mT → 5,36 mA (5,21). R = 20,96 Ω → **0,60 mW**
  (0,49–0,72 con las esquinas 38–56 mΩ/□ del tech). Sin vías: via3 = 3,41 Ω por corte (l. 5139 aprox.), G3 lleva una vía por vuelta.
- **C2**: (µB)² = **4e-10 … 7,8e-8**; solo baja a ~1e-11 con un coeficiente de MR de ~0,03.
- **C3**: 69,33 fA/√Hz. T = 0,1049 s; σ = S·√(1/2T) = 151,4 fA (también para el demodulador de 4 estados). Con ENBW 1/T serían 214 fA.
- **C4**: sympy: a·B² → 2·a·B1·B2; lineal → 0 (también cúbico → 0); calor con retorno compartido → 2·Rr·I1·I2 ≠ 0; sin retorno compartido → 0.

## D
- **D1**: 2,035 / 0,644 / 0,204 mV. Piso 0,57 % ↔ 0,2095 mV → C = **94 fF**.

## Adenda de literatura — Thu Nov 12 19:08:16 EST 2026 (todavía sin abrir ningún INFORME)
Leído por subagente web (yo no abrí las páginas):
- **A4** dispersión lateral ΔR⊥ en Si. SRIM (tablas en AJBAS 7(2) 2025, zenodo.org/records/17075923): B 10 keV **17,3 nm**; B 20 keV **29,5 nm**;
  B 50 keV 55,7 nm. B 5 keV sin tabla: ~10 nm [extrapolación con ΔR⊥/ΔRp≈0,76]. As 20 keV **5,3 nm**; As 50 keV **9,6 nm**; As 30 keV ~6,7 [interpolado].
  ΔRp de contraste (Plummer cap. 8; Gibbons vía SFU): B 10 keV 17–25 nm; B 20 keV 28–38 nm; As 20 keV 7,5; As 50 keV 15,2.
  Mi rango para boro a 5–20 keV: **~10–30 nm**. "30–56 nm" coincide con SRIM para 20–50 keV, no 5–20 keV. Una sola fuente con ΔR⊥ numérico.
- **B1** resistividades leídas: Ti película 50 µΩ·cm (masivo 42); TiW 50–80; TiN 50–100 (20–70 en extractos no abiertos). Ninguna a 10–50 nm de espesor.
  Caen en la parte baja de mi barrido; con TiN a 20 µΩ·cm la pila con TiN bajaría a ~17 Ω/µm. Mi rango queda **~20–240 Ω/µm**.
