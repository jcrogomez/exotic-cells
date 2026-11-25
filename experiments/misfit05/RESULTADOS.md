# MISFIT-05 · resultados: 16 ramas DUT + interruptor en un mismo lector

Escrito el 2026-11-25 11:18 EST (`date`). Prerregistro: [`MISFIT-05_2026-11-25_multiplexado_dut.md`](../../cells/preregistros/MISFIT-05_2026-11-25_multiplexado_dut.md),
sellado a las 11:11:38 (`PREREG_SHA256.txt`). Corrida: `corre.sh` → `corre.out` (11:12:38–11:17:21, 10 decks, ninguno abortó).
Números: `analiza_m5.py` → [`m5.txt`](m5.txt); el análisis se escribió antes de ver ninguna salida. Todo es modelo, nada es silicio.

## Lo aburrido primero

1. **Las ramas extra no llevan cableado** (límite declarado). La carga por rama (+0,23–0,25 %) es una cota inferior: en un layout
   cada rama añade metal al nodo. El testigo de 1 fF da +0,65–0,70 %, así que cada fF de cable por rama suma eso.
2. **Sin desajuste.** La fuga sale de las esquinas, no de una distribución. Con σVth = 17,3 mV, un interruptor a +3σ fuga unas
   ×3–4 más (aritmética con n·Ut = 37–47 mV, no corrida).
3. **El criterio del mutante `mc` estaba mal escrito por mí.** Pedía "B sin cambio (≤ 0,3 %)" frente a N = 1, pero `mc` es N = 2
   y B lleva una rama abierta: B cambió +0,27–0,29 %, que es la carga de esa rama (D2), no un efecto del mutante. Pasó por
   0,01–0,03 puntos. No se toca el veredicto; la comparación correcta era contra `n2`.
4. **Todas las ramas son iguales.** El uso real (parejas LOD, pares de XC-62) tiene DUT distintos; no se probó.

## Veredictos, con las palabras del prerregistro

**Benchmark válido:** el control `n1` repite el contrato en los 4 decks (+0,0000 %), `h00` en los 2 largos, y pasan `mc`, `wi`
(40 pA leídos como 40,000 pA en DC) y `wc`.

| # | Resultado | Predicción | Corte |
|---|---|---|---|
| D1 | L/I por rama abierta: tt 27 2,5e-6; ff −40 3,7e-8; ss 85 3,6e-4; ff 85 6,5e-5 | **FALSA**: ff −40 queda por debajo de mi banda (1e-6) | cumple (≤ 1e-3); 15 ramas = 0,54 % en la peor esquina (ss 85) |
| D2 | +0,228 a +0,251 % de tA por rama extra; tA(16)/tA(1) = 1,034–1,038 | cumplida | cumple |
| D3 | incremento por rama a N = 16 frente a N = 2: −0,39 a +0,06 % | cumplida | — |
| D4 | el salto de una carga cambia −0,04 a −0,46 % relativo | cumplida | cumple |
| D5 | ln(tA/tB) se mueve +0,013 a +0,018 puntos de % | cumplida (límite 0,02: justo) | cumple |
| D6 | todo abierto, 1,4 ms: XA mínimo 1,577 V (ss 85) y 1,320 V (ff 85); no cruza | cumplida (límite 1,2 V: justo en ff 85) | cumple |

**Sigue:** un lector puede llevar hasta 16 ramas, con los límites de arriba.

## Qué se lleva el slot de metrología

- La fuga de las ramas abiertas no es el problema: 0,54 % de la corriente con 15 ramas en la peor esquina. Es constante entre
  lecturas de un mismo chip, así que no toca el salto (D4); sí sesga un cociente entre dos DUT distintos en esa cantidad.
- El coste real es la capacidad: cada rama alarga la lectura un 0,23–0,25 % más su cable.
- **La lectura "todo abierto" no sirve para medir la fuga:** en 1,4 ms XA no llega a 0,9 V. Solo da una cota.
- D5 quedó cerca de su límite por la asimetría A/B de las capacidades extraídas del nodo intermedio (0,199 frente a 0,205 fF a
  tierra): con 16 ramas la asimetría del lector crece 0,013–0,018 puntos de %. Es pequeño frente al umbral de I4 (0,0807).

## ¿Qué explicación aburrida no descarté?

El cableado y el desajuste (1 y 2). Las dos se cierran con el layout del slot 2 extraído y un Monte Carlo, no con esta prueba.
