# v2_VEREDICTO — verificador independiente, ronda 2 (Thu Nov 12 19:09:16 EST 2026)

Orden: `v2_PLAN.md` (19:03–19:06) → `v2_calc.py`/`v2_salida.txt` (19:07:04) → `v2_NUMEROS.md` (19:08:05; adenda de literatura 19:08:16) → lectura de informes.
**Leído de los agentes** (horas de `date`): `attack2_xc52/b52_bobinas.py` l. 1–30 y 66–92, 19:03:25 (excepción declarada, antes de fijar números).
Después de fijar: `grep` de líneas de `b20_INFORME.md`, `b05_INFORME.md`, `b52_INFORME.md` a las 19:08:22 y 19:08:32; `b05_INFORME.md` l. 83–90.
Nada de attack_xc* (ronda 1) ni otros archivos. Tras leer añadí `v2_post.py` (R(T) del li con `tc1rl1`/`tc2rl1` del PDK, r+c.model.spice l. 30–31).

| Afirm. | Predicción | Mi resultado | Veredicto |
|---|---|---|---|
| A1 | ~10 nA … ~100 µA | Juego Hurkx: 57 nA…50 µA (colas cruzadas al nivel del pico); 0,13 nA…50 µA barriendo el nivel de cruce. Solape ≈ 3,7 décadas | **verificada**. Aviso: con otros dos juegos de parámetros (de memoria) sube 2–3 décadas; el modelo local no fija el techo |
| A2 | Dutta: ~23 µA/µm a 1,8 V; 0,04 V/nm | Artículo leído entero (subagente): ninguna de las dos cifras está escrita. Derivable: 21 µA/µm a V_BR≈2 V (1 mA/47,6 µm); 0,04 V/nm solo entre 0 y 100 nm, 0,025 V/nm de 0 a 280 nm (satura). Tesis: no abrió (403) | **no pude** confirmar "23 a 1,8 V" (el agente lo atribuye a la tesis; él mismo escribe 21 en otra línea). Orden de magnitud: sí. 0,04 V/nm: parcial |
| A3 | muere ≥10 nm/déc; vive ≤5 con ≥1e20 | A 10 nm/déc y 1e20–3e20 el Fermi sigue dentro de las dos bandas (xi_n +19…+88, xi_p +14…+179 meV); túnel 3,1–7,6 nm. No hay umbral entre 5 y 10: la escala de corriente cambia ×4…×70 | **no verificada como frontera**: la condición necesaria NO muere a 10 nm/déc. Mi frontera depende del pico y del nivel de cruce: de ≲3 nm/déc (1e20, cruce a 0,1·pico) a ≲20 (3e20, cruce al pico). El informe dice "improbable, no muerta": eso sí cuadra |
| A4 | B 5–20 keV: 30–56 nm | SRIM leído: B 10 keV 17,3; 20 keV 29,5; 50 keV 55,7 nm. As 20/50 keV: 5,3/9,6 nm | **no verificada**: 30–56 nm es de 20–50 keV, no de 5–20 keV (ahí ~10–30). As: verificada. Mi fuente SRIM parece la misma que la del agente (cifras idénticas): no es independiente |
| B1 | decenas…~400 Ω/µm; 3–5 Ω; 10–60 Ω | ~20–240 Ω/µm (central 97 y 150); vacío 24–39 nm: 2,3–5,9 Ω; 100–500 nm: 10–75 Ω | **verificada** |
| B2 | cuello ~1000 K; línea 5–10 µm ≤ 440–930 K | Cuello 1 µm: ΔT central 520–1770 K (4,2–7,8 mA); horquilla 136–2960 K. V=IR 0,32–0,59 V (1 µm), 0,63–1,17 V (2 µm): alcanzable. Línea a 1,8 V con R(T): 10 µm 430/472/547 K; 5 µm 764/909/1193 K (k_ox 1,4/1,1/0,8) | cuello **verificada** (orden). Línea: **verificada en el centro; no como cota**: con k_ox=0,8 la de 5 µm pasa de 929 K |
| B3 | ≤52 mV; 118 mV sin C; 72 mV con 50 fF | Régimen ≤48 mV; salto a abierto: primer orden, sin sobreimpulso. Acoplo de 0,2 fF: +7 mV con 50 fF (55 mV), +69 mV con 5 fF (117 mV) | **verificada** en orden. 72 mV con 50 fF pide ~0,7 fF de acoplo, no 0,2 |
| C1 | 0,373 mT/mA; 5,4 mA; 0,60 mW | 0,3734 (0,384 en la superficie del Si); 5,36 mA; 20,96 Ω → 0,601 mW (0,49–0,72 en esquinas de Rs) | **verificada** |
| C2 | 1e-11…8e-8 | (µB)² = 4e-10…7,8e-8 | **verificada** arriba; el extremo 1e-11 no sale de (µB)² (el agente lo atribuye a un término termodinámico que no calculé) |
| C3 | 69 fA/√Hz; 150 fA ↔ 0,105 s | 69,33; σ = S·√(1/2T) = 151,4 fA, T = 0,1049 s | **verificada** (con ancho de banda 1/2T; con 1/T serían 214 fA) |
| C4 | D = 2aB1B2; 0; ≠0 | sympy: 2·a·B1·B2; 0 (cúbico también 0); 2·Rr·I1·I2 | **verificada** (demostrado) |
| D1 | 2,04/0,64/0,20 mV; ~100 fF | 2,035/0,644/0,204 mV; 94 fF | **verificada** |

## Lo distinto
1. A4: el intervalo 30–56 nm está corrido de energía. Si el p+ es BF2 a 20–30 keV (B efectivo 4,5–6,7 keV), la dispersión lateral es ~10–12 nm [extrapolado].
2. A3: "muere a ≥10 nm/déc" no se deduce de la degeneración; solo de la relación pico/exceso, que ni mi modelo ni el suyo (P5 fallada ×26–1300) calibran en directa.
3. A2: las dos cifras de Dutta son lecturas de gráfica o de la tesis, no texto del artículo; la pendiente no es constante.
4. B2: la cota de la línea de 5 µm depende de k_ox ≥ ~1,0 W/m·K (no pública). A 2 µm y 7,8 mA quedan 0,63 V para los drivers: `[?]`.
5. C1: mi cuenta no incluye vías (via3 3,41 Ω por corte; el informe pone 12 por salto).

## Límites de esta verificación
Parámetros de BTBT, constantes de Si y resistividades del barrido: de memoria. Literatura: leída por subagentes, no por mí; ΔR⊥ con una sola fuente.
Térmica: k_ox y espesor de óxido bajo li barridos, no medidos. A1 usa campo local (sobreestima a campo alto).
