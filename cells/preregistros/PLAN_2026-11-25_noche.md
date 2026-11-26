# Plan nocturno del 2026-11-25: cuatro bloques de simulación para el tile 1×1

Escrito el 2026-11-25 21:35 EST (`date`), **antes** de generar los decks o de lanzar la cola. Pedido por Juan ("corre un
plan nocturno de simulaciones"). Plan general: [`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md). Todo es SPICE (ngspice 44.2, PDK
8afc8346), en `experiments/noche_1125/`. Nada es silicio.

**Reglas de la noche**
- Cada deck corre con `timeout` **dentro del contenedor** (el que sí corta). Sin corridas de LibreLane: su tope no es fiable.
- La cola es secuencial por bloques; cada deck escribe una línea al empezar y otra al acabar en `cola.out`.
- Los criterios de abajo quedan fijados aquí. Los programas de análisis se escriben por la mañana, **antes de mirar** ningún log
  más allá de contar líneas; lo que no esté en esta página no decide nada.
- Control por deck en todos los bloques que usan el lector 1: una instancia sin modificar repite el contrato dentro de 0,01 %.

## Bloque A · lector de rango ancho, precarga de canal más largo (prueba R2, segunda vuelta)

Sigue a [R2](../../experiments/xc20_lector/r2/RESULTADOS.md): con L = 0,15 µm el modelo de tres números falla un 16 % a 1 nA en ff 85.
- **Variantes:** los dos pfet hvt de la pila de precarga con L = 0,50, 1,00 y 2,00 µm (w = 1, m = 2). Todo lo demás, igual que R2.
- **Casos por variante y esquina:** las 6 corrientes juzgadas (100 pA a 10 µA), las 3 de calibración, 2 testigos (+1 %) y el
  control sin corriente. 4 esquinas. 144 decks.
- **Mismo modelo y mismos criterios que R2** (W1: de 1 nA a 10 µA dentro de ±3 % en las 4 esquinas; W3 testigo; W4 sin corriente).

| # | Predicción |
|---|---|
| A1 | L = 0,50: cumple W1 en las 4 esquinas (la fuga en caliente cae lo bastante) |
| A2 | L = 1,00: cumple de 1 nA a 1 µA y **falla a 10 µA** (la precarga, más débil, no recarga del todo en el pulso) |
| A3 | L = 2,00: falla ya a 1 µA |
| A4 | El testigo (+1 %) da entre −1,2 % y −0,8 % en toda variante y esquina donde el punto de 10 nA y el de 1 µA oscilan |
| A5 | Sin corriente, ningún flanco en 20 ms, en las 12 combinaciones |

**Se adopta** la L más corta que cumpla W1, W3 y W4. **Muere** si ninguna cumple: entonces dos rangos con dos precargas.
**Inválido** un caso si falla su testigo.

## Bloque B · Monte Carlo de desajuste del lector pequeño (v_f3)

MISFIT-07 y 09 probaron el filtro pequeño sin desajuste real. Aquí, 48 chips `tt_mm` (4 decks de 2 tiradas × 6 chips, semillas
2301–2304, con `setseed`), más el control `tt` de 6 chips. Mismo generador que MISFIT-03 enmienda 2 (`gen_mc.py`), con el macro v_f3.

| # | Predicción |
|---|---|
| B0 | Control: los 6 chips `tt` son idénticos entre sí y repiten el contrato de v_f3 medido en MISFIT-09 (tA de h01 = 30,8832 µs) dentro de 0,01 % |
| B1 | Salto de una carga: mediana de \|D\| entre 0,70 y 0,91 %, y ≥ 90 % de los chips entre 0,50 y 1,00 % (los mismos límites que M3) |
| B2 | La mediana de \|D\| queda a menos de 0,03 puntos de la de v_hm (0,803 %) |
| B3 | σ de ln(tA/tB) en e01 entre 0,90 y 1,51 (v_hm dio 1,204; ±25 %) |
| B4 | Paso de calibración **relativo**, P4 / [tA/tB]e11: entre 0,90 y 1,03 % en todos los chips (en v_hm fue 0,93–1,00 %, visto como exploración) |

**Muere** el lector pequeño si B1 falla. **Inválido** si falla B0 o más del 25 % de los chips no cruza en 200 µs.

## Bloque C · ruido de disparo del lector pequeño, con semillas de verdad

En MISFIT-03 las tiradas de ruido compartían semilla (`set rndseed` se ignora). Aquí se usa `setseed` y se corre en v_f3:
R0 (k = 0), R1 (k = 1), R3 (k = 3), src = 11, 8 instancias × 8 repeticiones, y R1 repetido con otra semilla (R1b).

| # | Predicción |
|---|---|
| C0 | R0: dispersión nula; tA repite el h11 de v_f3 dentro de 0,01 % |
| C1 | R1 y R1b: σ de ln(tA/tB) entre 0,115 y 0,195 % (la banda de v_hm) |
| C2 | σ(R3) / σ(R1) entre 2,4 y 3,6 |
| C3 (nuevo) | R1 y R1b tienen muestras **distintas** (ahora sí hay sorteos independientes) y sus σ coinciden dentro de ±35 % |

**Inválido** si falla C0 o si R1 y R1b salen idénticos (la semilla seguiría sin aplicarse).

## Bloque D · cuántos puestos aguanta un lector (prueba R6), sobre v_f3

Método de MISFIT-05 con más ramas: N = 1, 32, 64 y 128 ramas iguales (copias de las líneas extraídas del DUT y su interruptor,
con las capacidades del nodo intermedio; **sin cableado**, que sigue siendo el límite declarado). 4 esquinas. Más "todo abierto"
con 32 y 128 ramas a 85 °C, 1,4 ms.

Cuenta previa con los números de MISFIT-05 (lineal): +0,23–0,25 % de tiempo por rama; fuga por rama abierta 3,6e-4 (ss 85).

| # | Predicción |
|---|---|
| D1 | Tiempo por rama extra: entre +0,20 y +0,28 %, igual a 32, 64 y 128 (lineal dentro de ±10 %) |
| D2 | El salto de una carga cambia menos del 2 % relativo a 128 ramas frente a 1, en las 4 esquinas |
| D3 | ln(tA/tB) se mueve menos de 0,0807 puntos de % hasta 64 ramas; a 128 puede pasarlo (la asimetría A/B crece con N) |
| D4 | Todo abierto, 1,4 ms a 85 °C: con 32 ramas no cruza a ss 85; con 128 **cruza** en las dos esquinas (la fuga ya se podría medir) |
| D5 | Testigos de MISFIT-05 (1 fF: +0,4 a +0,9 %; 40 pA: tA baja) y mutante (rama extra cerrada: tA entre 0,45 y 0,60) |

**Cortes que deciden** (los de MISFIT-05): salto ≤ 5 % relativo; tiempo con N ramas ≤ 1,5 veces el de 1 (se relaja el 1,10 de
MISFIT-05, que era para 16; la lectura se alarga y se dice cuánto); (N − 1) × fuga por rama ≤ 5 % de la corriente, con la fuga
de MISFIT-05. **Se reporta el N máximo que cumple los tres.** **Inválido** si falla el control del deck o D5.

## Presupuesto

Estimado con lo que tardaron hoy bloques parecidos: A ≈ 3 h, B ≈ 0,5 h, C ≈ 2 h, D ≈ 1 h. Tres decks a la vez (dos en el
bloque C, por memoria). Tope por deck: 60 min (90 en C). Si la cola no termina, lo que falte se dice y no se rellena.

SHA en `experiments/noche_1125/PREREG_SHA256.txt`.
