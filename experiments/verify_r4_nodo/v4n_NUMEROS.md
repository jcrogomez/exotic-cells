# v4n_NUMEROS — números propios del verificador (ronda 4, nodo flotante), ANTES de leer nada del agente salvo e*_PREREG.md

Hora de `date` al escribir este archivo: Fri Nov 13 10:40:19 EST 2026

Todo V de túnel es tensión SOBRE EL ÓXIDO (V_ox). Modelos: TE = Tsu–Esaki + WKB, emisor 3D (v4n_tunel.py);
SH = fórmula analítica tipo Schuegraf–Hu; BSIM4 = igc de ngspice con parámetros por defecto (v4n_igc.sp).
Barrido: phi_B 3,0–3,2 eV, m_ox 0,40–0,50 m0 (rangos de memoria, no leídos hoy).

## 1. J(1 V, 4,15 nm)
- TE: 5,4e-14 .. 5,6e-11 A/cm². SH: 1,1e-15 .. 1,1e-12 (≈ 50× por debajo de TE con los mismos parámetros).
- BSIM4 igc por defecto (V_puerta = 1 V, vth0 = 0,5): 1,8e-9 A/cm²; con aigc/bigc/cigc de la tarjeta nfet_01v8: 2,5e-9.
- Pendiente TE: 4,6–5,2 décadas/nm a 1 V. Control de cordura (de memoria): TE da 7–49 A/cm² a 1,5 nm y 0,02–0,23 a 2 nm.

## 2. Descarga de la carga de antena (solo C_ox, 27 °C, suministro de electrones ilimitado)
- V(1 s) partiendo de 3,3/5/7 V: 2,53–3,42 V (no "cae" a ~0 en 1 s; lo que se va en ≤ 1 s es lo que está por encima de ~3 V).
- t(7 V → 2 V): 24 s .. 1,7e5 s.
- V(6 meses): TE ≤ 0,005 (descargada; límite de rejilla) .. 0,66 V; SH 0,31 .. 1,31 V. Conjunto: ~0 .. 1,3 V.
- Independencia de V0: |V6m(3,3) − V6m(7)| ≤ 3,2e-8 V en todos los casos.
- Deriva a 6 meses: TE 0 .. 1,20 mV/día; SH 0,60 .. 0,85 mV/día.
- dV(6 m)/dt_ox: TE 0 .. 2,63 V/nm; SH 1,23 .. 1,79 V/nm.
- σ_tox del PDK = toxe·toxe_slope/√(W·L), toxe_slope nfet 3,443e-3, pfet 4,443e-3: 14 pm (1 µm², nfet) .. 79 pm (0,054 µm², pfet).
  σ_V: 0 .. 38 mV (1 µm² nfet), 0 .. 150 mV (0,063 µm² nfet), hasta 209 mV (0,054 µm² pfet).
- Caída por década de tiempo (TE 3,1/0,45): 437 mV a 1e3 s, 513 mV a 1e5 s, 389 mV a 1,6e6 s, 1,6 mV a 1,6e7 s (ya descargada).

## 3. 11,6 nm (y 11,75 nm de la tarjeta pfet_g5v0d10v5) a V_ox = 5 V
- TE 2,0e-20 .. 2,5e-15 A/cm²; SH 1,2e-21 .. 2,3e-16. A 5,5 V, TE máx. 2,6e-13.

## 4. TDDB, 4,15 nm, 1 µm², 27 °C (t63)
- Ancla Q (cota inferior si el proceso cumple "10 años al 0,1 %, 0,1 cm², 1,98 V, 125 °C", spec típica de memoria, NO de SKY130):
  a 3,3 V ≥ 1,2e3 .. 9,1e16 s según modelo (ley de potencia n 40–48 / E gamma 1–3 déc/(MV/cm), beta 1,2–2,5, Ea 0,3–0,8).
- Ancla QBD (QBD 1–1000 C/cm² en 1e-4 cm², de memoria; t = QBD/J_TE): 3,3 V: 7,4e5 .. 2,9e13 s;
  5,7 V: 3,2 .. 8,8e6 s; 6,5 V: 0,39 .. 6,6e5 s; 8 V: 0,022 .. 2,0e4 s.
  V_ox para t63 = 1 h: 4,0 .. > 9 V; para 1 min: 4,9 .. > 9 V; para 1 s: 6,1 .. > 9 V.

## 5. Dickson pfet_g5v0d10v5 en diodo, pozo a la salida (v4n_dickson.py)
Elegido: 10 MHz, 2 fases 45 ns, MIM 22×22 µm (≈1 pF) por etapa, 0,1 pF parásita por nodo, C_out 2 pF, W/L 5/0,5, N+1 diodos, 80 µs, tt 27 °C.
- Desde 1,8 V, vacío: N=4 5,88 V; N=6 8,01 V; N=8 10,10 V (aún subía 25–50 mV en los últimos 10 µs).
- Con carga 0,5/1/2 µA: N=6 7,04/6,73/6,15 V; N=8 9,00/8,58/7,83 V. R_salida ≈ 1,0–1,5 MΩ.
- Máx |V_SD| = |V_GS| de cualquier diodo: 2,57–2,77 V (1,8 V). Pozo–sustrato del último: = V_out (hasta 10,1 V).
- Fuente p+ sobre pozo en directa hasta 0,54 V (vacío) y 0,78 V (1 µA): PNP vertical a sustrato activo, NO modelado.
- Desde 3,3 V: máx |V_GS| 5,28–5,48 V (no 5,8); V_out N=4 12,8 V, N=6 17,6 V en vacío (pozo–sustrato > 11 V).
- La columna de eficiencia de v4n_dickson.txt da > 1: mi contabilidad de potencia de los relojes está mal; NO se usa.
- Área estimada (sin trazado): N=6 11–14 %, N=8 15–18 % de una tesela 1×2.

## 6. Fuga de interruptor frente a túnel
- nfet_01v8 apagado 0,42/0,15: 12–45 fA (0,1–1,8 V) con gmin = 1e-20; con gmin por defecto (1e-12 S) da ~1 pA·V (artefacto).
- V_ox de cruce (túnel = interruptor), TE: I_sw 0,66 fA → 2,4–3,3 V (1 µm²), 1,6–2,7 V (100 µm²), 1,0–2,4 V (1000 µm²);
  I_sw 25 fA → 3,0–3,7 V (1 µm²), 1,8–2,9 V (1000 µm²). BSIM4 por defecto: 0,5–3,1 V según área.
