# v1_NUMEROS — mis valores (escrito Thu Nov 12 13:04:10 EST 2026; corrida de v1_calc.py terminada Thu Nov 12 13:03:29 EST 2026)

Hasta este momento NO he abierto ningún archivo de attack_xc05 / attack_xc20 / attack_xc52.
Salida cruda: `v1_salida.txt`. Código: `v1_calc.py`. PDK = `local_flow/pdk_host/ciel/sky130/versions/8afc8346.../sky130A`.
Errata de la salida cruda: en el bloque C1 la etiqueta "mT/mA" está multiplicada por 1000 (226,99 → 0,227 mT/mA) y la columna "requiere mA" sale 0,0 por lo mismo; los valores correctos están abajo.

## A (constantes de Si de memoria: eps_r 11,7; Eg 1,12; ni 1e10; Nc 2,8e19; Nv 1,04e19; 300 K)
| | Boltzmann (Vbi = 2kT ln(N/ni)) | Fermi–Dirac (Vbi = Eg + xi_n + xi_p), sin BGN | FD con BGN 0,1 eV |
|---|---|---|---|
| 1e19 | Vbi 1,071 V; W 16,65 nm; Emax 1,29 MV/cm | 1,104 V; 16,90 nm; 1,31 | 1,004 V; 16,12 nm; 1,25 |
| 1e20 | Vbi 1,191 V; W 5,55 nm; Emax 4,29 MV/cm | 1,321 V; 5,85 nm; 4,52 | 1,221 V; 5,62 nm; 4,35 |
Aproximación de vaciamiento; a 1e20 W ~ 5 nm es del orden de la longitud de apantallamiento: el número es de orden, no de precisión.

- A2: EF = Ec en n: N = 0,765·Nc = 2,1e19 (Nc 2,8e19) – 2,4e19 (Nc 3,2e19). EF = Ev en p: 0,8e19 (Nv 1,04e19), 1,4e19 (1,8e19), 2,4e19 (3,1e19).
  Umbral simétrico (el mayor de los dos) = **2,1–2,5e19 cm^-3**. Para penetración de 2kT por lado: 8–9e19 (n), 3–9e19 (p).
  Matiz: a 300 K el umbral no es abrupto (cola térmica de ~kT); "no hay pico" por debajo es criterio de T = 0. xi a 1e20: +64 meV (n), +137 meV (p); a 1e19: −23 meV (n), +8 meV (p).
- A3: décadas = B·(1/E19 − 1/E20)/ln10 con Emax: **4,7 (B = 2e7) a 9,4 (B = 4e7)**; con BGN 0,1 eV: 5,0 a 9,9. Con el campo medio (Emax/2) sería el doble (9,4–19).
- A4: `libs.tech/magic/sky130A.tech`: l.5096 "milliohms per square"; l.5106 ndiff 120000; l.5107 pdiff 197000; l.5119 poly 48200 (también l.5113 mrp1 y l.5120 rmp); es la variante típica (hay otras dos: l.5154–5155 132/228, l.5202–5203 108/166). ngspice `r+c/res_typical__cap_typical.spice` l.17–18, 21: rdn=120, rdp=197, rp1=48.2.
  Siliciuro: 2–15 Ω/□ típico (TiSi2/CoSi2). **De memoria, no lo leí hoy en ninguna fuente.** El PDK no trae una difusión con y sin siliciuro para comparar.

## B
- B1: sky130A.tech l.5058 `height allm1 1.3761 0.36` → base de met1 a 1,3761 µm sobre z=0 (referencia del sustrato en Magic), espesor 0,36 µm. tlef hd l.115 `THICKNESS 0.35`. Sobre difusión activa (l.5050: diff 0,2062+0,12 → tope 0,3262) quedan 1,05 µm; en medio pasa li1 (l.5056: 0,9361–1,0361).
- B2 (DF 2D propio, sección 0,14 × 0,36 en óxido, sustrato isotermo, escalón de potencia; tiempo al 63 %): **0,52 µs (k=1,4) / 0,67 (1,1) / 0,73 (1,0) / 0,92 µs (0,8)**. No es exponencial: al 90 % tarda 4–7 µs. Placa 1D 4h²/(pi²·alfa): 0,88–1,53 µs. Sensibilidad a la altura de la tapa (5–30 µm): 0,66–0,73 µs a k=1,1.
- B3: R = 0,125·10/0,14 = 8,93 Ω; P = 37,9 µW; R térmica 2D 0,35–0,62 K·m/W (cilindro-sobre-plano analítico: 0,37–0,64). **ΔT sin pérdidas por los extremos: 1,33 K (k=1,4) – 1,70 (1,1) – 2,33 K (0,8)**; con extremos anclados al sustrato (cota baja, L_h ≈ 2 µm): media 0,84–1,21 K, máx 1,15–1,72 K.
  Dato lateral: 2,06 mA en 0,14 µm = 14,7 mA/µm = 5,3× el límite DC de B4 (0,39 mA para esa anchura); J = 4,1 MA/cm².
- B4: tlef hd l.123 `DCCURRENTDENSITY AVERAGE 2.8 ; # mA/um Iavg_max at Tj = 90oC` (met1, capa abre en l.100); l.207 `... 6.8` (met3, capa en l.188). Es corriente media por µm de ancho a Tj 90 °C; RMS: 6,1 (l.124) y 14,9 (l.208).
- B5: solo con los 3 puntos del LEEME:
  | R | lineal en R | lineal en log R | potencia del exceso |
  |---|---|---|---|
  | 4,3 k | 1,128 | 1,209 | 1,109 |
  | 6,5 k | 1,202 | 1,263 | 1,185 |
  | 12,9 k | 1,348 | 1,417 | 1,370 |
  Con la tabla completa de ngspice (`05_exotic_lab/macros/constriccion/sim/efld00_lector_drivers.txt`: 5 k → 3,42 ns; 12,9 k → 4,195 ns; base 2,99 ns): **4,3 k → 1,12; 6,5 k → 1,20; 12,9 k → 1,403** (este último es dato simulado, no interpolado).

## C
- PDK met3: ancho mín 0,30 (tech l.4687, tlef l.195), separación mín 0,30 (tech l.4688, tlef l.199; 0,40 si ancho ≥ 3). Altura: tech l.5064 `height allm3 2.7861 0.845` → centro a 3,21 µm sobre z=0.
- C1 (5 vueltas concéntricas, borde interior a 10 µm, filamento en el eje de pista, campo en z=0 bajo el centro):
  | geometría | cuadrada | circular |
  |---|---|---|
  | w 0,3 / s 0,3 | **0,227 mT/mA** | **0,247 mT/mA** |
  | w 1,5 / s 0,3 | 0,190 | 0,208 |
  Si el Hall está 0,7 µm dentro del silicio cambia < 4 %. Para 2,65 mT: 11,7 / 10,7 mA (compacta), 14,0 / 12,8 mA (1,5 µm).
  Dato lateral: la compacta (0,3 µm) admite 2,04 mA DC → 0,46–0,50 mT; la de 1,5 µm admite 10,2 mA → 1,9–2,1 mT. Ninguna da 2,65 mT dentro del límite DC; hace falta w ≈ 2,1 µm (no calculado el campo para esa).
- C2: 10/6,8 = 1,47 µm.
- C3: V_H = I·B/(q·n·t), r_H = 1, sin factor geométrico: esquinas **0,0165 mV/mA (5e17; 2 µm) … 0,662 mV/mA (5e16; 0,5 µm)**; intermedias 0,066 y 0,165. Por la vía de la R de hoja (V_H = I·B·mu·Rs, mu 400–1000 cm²/Vs, Rs 950–1700): 0,10–0,45 mV/mA.
- C4: tech l.5104 `resist (nwell)/well 950000` (mΩ/□; variantes l.5152: 1350000, l.5200: 550000). ngspice `libs.tech/ngspice/r+c/res_typical__cap_typical.spice` l.22 `rnw=1700` (esquinas 1240–2160 en los otros r+c).
- C5: semiperiodos T/2 con I y I(1+d); N = I·T/(2q) por mitad; diferencia d·I·T/(2q), varianza I·T/q → SNR = (d/2)·sqrt(I·T/q) → T = 4·k²·q/(d²·I) = 100·q/(d²·I) = **0,114 s** (k=5). Con demodulación senoidal en vez de cuadrada: ×pi²/8 → 0,141 s. Solo ruido de disparo; sin 1/f ni ruido del amplificador.
