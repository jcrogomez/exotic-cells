# MISFIT-08 · resultados: el núcleo sin contador común es equivalente y ocupa un 9 % menos

Escrito el 2026-11-25 12:47 EST (`date`). Prerregistro: [`MISFIT-08_2026-11-25_dieta_del_nucleo.md`](../../cells/preregistros/MISFIT-08_2026-11-25_dieta_del_nucleo.md);
sello e incidencias del humo en `PREREG_SHA256.txt`. RTL, banco y script: [`instrument/misfit08/`](../../instrument/misfit08/)
(`misfit_core.v` lean, `eq_tb.v`, `eq_mut.v`, `run.sh`). Salidas: `run.out`, `instrument/misfit08/eq.txt`, `cocotb.txt`;
flujo en `local_flow/misfit08_core_lean` (fuera de git), referencia `misfit06_core_ctl`.

## Lo aburrido primero

1. **Mi primer RTL lean no era equivalente.** Dejaba leer la cuenta mientras corría; el original da 0 hasta el cruce. Lo cazó el
   banco en el humo y se corrigió antes de la corrida que cuenta (la cuenta solo es visible con su lado parado).
2. **El banco no sembraba** en el humo (las 5 semillas eran la misma). Corregido antes de la corrida que cuenta.
3. **La síntesis sola decía lo contrario:** el área tras Yosys sube de 8438 a 8678 µm² (+2,8 %). El ahorro aparece tras colocar y
   rutar. Parte viene de menos buffers de reparación de hold (de 1958 a 1351 µm²), que puede depender de la semilla del flujo:
   **una sola corrida por variante.**
4. Equivalencia por simulación aleatoria, no prueba formal.

## Veredictos, con las palabras del prerregistro

| # | Resultado | Veredicto |
|---|---|---|
| L1 | 13 de 13 pruebas cocotb pasan con el núcleo lean, sin tocar las pruebas | cumplida |
| L2 | 0 discrepancias en 5 semillas × 2 000 000 ciclos. Cobertura mínima por semilla: 2099 medidas terminadas, 1819 tiempos agotados, 236 abortos, 750 054 lecturas de contadores, 1653 medidas con A y B | cumplida |
| L3 (mutante) | detectado en las 5 semillas (36 728 a 38 519 discrepancias) | cumplida |
| L4 | flip-flops: 142 → 118 | cumplida |
| L5 | área de celdas sin relleno ni tomas: 9051,2 → 8237,9 µm², **−8,99 %**; DRC 0, LVS 0, 0 violaciones de tiempos | cumplida |

Benchmark válido. **Sigue:** el lean puede sustituir al núcleo en el tile 1×1.

## Coste

La holgura de setup baja de 6,65 a 4,67 ns (periodo de 20 ns); la de hold queda en 0,119 ns. El rutado sube 1,5 %.

## Qué se lleva el tile

813 µm² menos de celdas con el mismo bloque de 161 × 87,04 µm. Para convertirlo en franja libre hay que **bajar la altura del
bloque** (cada fila son 2,72 µm × 161 µm = 438 µm²): es otra corrida, con plantilla nueva. No está hecha.

El RTL de MISFIT-04 (`instrument/rtl/misfit_core.v`) no se tocó.

## ¿Qué explicación aburrida no descarté?

Que el 9 % sea en parte suerte del flujo (punto 3). Se cierra repitiendo `ctl` y `lean` con otra semilla de colocación.
