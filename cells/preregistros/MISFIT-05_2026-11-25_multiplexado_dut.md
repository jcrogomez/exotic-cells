# MISFIT-05 · varios dispositivos en un mismo lector (ramas DUT + interruptor en paralelo)

Escrito el 2026-11-25 a partir de las 11:10 EST (`date`), **antes** de escribir el generador de decks o de correr nada.
Es la primera prueba pendiente del slot de metrología: `experiments/misfit_arquitectura/DECISION.md` §3 ("multiplexar DUT en
serie" y "fuga de N interruptores abiertos"), y `PRUEBAS_POR_BLOQUE.md` §3–§4. Todo es modelo (SPICE). Nada es silicio.

## Pregunta

Si del nodo XA (y de XB) del lector de XC-19 cuelgan N ramas iguales a la que ya tiene (un nfet DUT 0,42/0,15 con la puerta en
VB, en serie con un nfet interruptor 0,84/0,15 a tierra) y solo una está seleccionada, ¿cuánto cambian la lectura de la rama
seleccionada, su salto de una carga y el cociente tA/tB, y cuánto fugan las N − 1 ramas abiertas?

**Para qué decide:** cuántas estructuras de metrología (parejas LOD, pares de XC-62, variantes del abanico C0–C9) puede leer un
solo lector. Con el número que salga se dimensiona el slot 2.

## Lo que ya se deduce del repo (no es resultado de esta prueba)

De `experiments/xc19_slot_e2/diseno/contrato.txt`, con [`prereg_calc.py`](../../experiments/misfit05/prereg_calc.py) →
`prereg_calc.txt`:
- La rama propia del macro, con su interruptor abierto, fuga 2,4e-4 (ss 85) y 5,0e-5 (ff 85) de la corriente del DUT
  encendido; a tt 27 y ff −40 la caída en 1,4 ms es 0,00 mV. Es una estimación gruesa (mínimo de XA en una ventana, no una
  corriente).
- La cota de subumbral (interruptor a Vgs = 0 frente a DUT a Vgs = VB, n·Ut entre 37 y 47 mV) da entre 3e-6 y 2,7e-4.
- Con 15 ramas abiertas, el mayor de esos números da 0,11–0,40 % de la corriente del DUT.

Así que "la fuga es pequeña" **ya es casi una deducción**. Lo que esta prueba añade: la fuga medida como corriente, la carga
capacitiva de ramas nfet (el cálculo previo era con interruptores pfet de la escalera, 0,08–0,18 % por interruptor,
`xc19_slot/DISENO.md`), su linealidad con N, y si el salto de una carga y tA/tB se conservan.

## Explicaciones aburridas y su chequeo

| Aburrida | Chequeo |
|---|---|
| El deck no está convergido y el número depende de qué más hay en el deck (lección de E2, 2026-11-24) | Control por deck: la instancia `n1` (macro sin ramas extra) reproduce `h01_oa` y `h01_ob` del contrato dentro de 0,01 %. Si falla, se repite con paso máximo menor y se declara |
| El efecto viene de cómo añado las ramas, no de las ramas | Las ramas son las líneas X40/X86 (A) y X46/X74 (B) del netlist extraído, copiadas literalmente, más las capacidades extraídas de su nodo intermedio. Mutante `mc`: una rama extra con el interruptor cerrado |
| La fuga se confunde con la capacidad en tA (una acorta, la otra alarga) | Se miden aparte: la fuga en DC (corriente por una fuente), la suma en el transitorio |
| El `.op` con gmin da una corriente falsa | gmin = 1e-18; testigo `wi` de corriente conocida; y se reporta la corriente con el interruptor abierto a dos tensiones de XA (1,8 y 0,9 V) |
| Las ramas extra no llevan cableado | No se chequea: es el límite declarado de la prueba (abajo) |

## Diseño

- **Macro:** `cells/xc19_slot_core_a2/v_hm/xc19_slot_core_lod.inc`, con el decodificador y el arnés de
  `experiments/xc19_slot/gen_contrato.py` (`XC19_INC` apuntando al v_hm). `src = 01`.
- **Ramas extra:** por cada una, en A: copia de X40 (drenador en XA, puerta en VB, fuente en un nodo nuevo `m`) y de X86 (de `m`
  a tierra, **puerta a 0 V**), más las capacidades extraídas del nodo intermedio (a GND 0,199 fF, a XA 0,060 fF, a VB 0,072 fF,
  a VDD 0,005 fF). En B, lo mismo con X46/X74 y sus valores. A y B reciben el mismo número.
- **N total de ramas** (la del macro más las extra): 1, 2, 4, 8, 16. Variante `trap` para N = 1 y N = 16.
- **Esquinas:** tt 27, ff −40, ss 85, ff 85. Transitorio `tran 10n` como el contrato; 80 µs (ff −40: 160 µs).
- **Deck de fuga (DC), por esquina:** el macro en reposo con `en = 1` da VB; una rama copia cuelga de una fuente Vx. Se mide
  i(Vx) con el interruptor cerrado (I) y abierto (L), a Vx = 1,8 V y 0,9 V.
- **Todo abierto:** instancia `a16`, N = 16 con `src = 00` (ninguna seleccionada), 1,4 ms, solo a ss 85 y ff 85.

## Predicciones

| # | Cantidad | Predicción | Corte que decide |
|---|---|---|---|
| D1 | L/I por rama abierta (DC, el mayor de los dos Vx) | entre 1e-6 y 1e-3 en las 4 esquinas; mayor a 85 °C que a 27 y −40 | **≤ 1e-3** en las 4 esquinas |
| D2 | ΔtA/tA por rama extra, (tA(N) − tA(1)) / tA(1) / (N − 1) | positivo, entre +0,05 % y +0,30 % en las 4 esquinas (manda la capacidad, no la fuga) | tA(16) ≤ 1,10 · tA(1) |
| D3 | Linealidad: incremento por rama a N = 16 frente a N = 2 | dentro de ±20 % | — |
| D4 | Salto de una carga en %, N = 16 frente a N = 1 | cambia menos del 3 % relativo en las 4 esquinas | ≤ 5 % relativo |
| D5 | ln(tA/tB), N = 16 menos N = 1 | \|Δ\| ≤ 0,02 puntos de % | ≤ 0,0807 (umbral de I4 a tt, por comparación) |
| D6 | `a16`, todo abierto | XA no cruza 0,9 V en 1,4 ms; XA mínimo ≥ 1,2 V | no cruza |

Las bandas de D1 y D2 son apuesta mía con los números de arriba; los cortes están ligados a la decisión.

## Controles negativos

| Objeto | Qué es | Debe dar |
|---|---|---|
| Control `n1` | macro sin ramas extra, en cada deck | contrato dentro de 0,01 % (A y B) |
| Mutante `mc` | N = 2 con el interruptor de la rama extra de A **cerrado** | tA entre 0,45 y 0,60 de tA(1); B sin cambio (≤ 0,3 %) |
| Testigo `wi` (fuga) | N = 1 más una fuente de 40 pA de XA a tierra | tA baja; a tt 27 entre −0,3 % y −3 %. En el deck de DC, la misma fuente sumada a L se lee como 40 pA ± 1 % |
| Testigo `wc` (capacidad) | N = 1 más 1 fF ideal en XA | tA sube entre +0,4 % y +0,9 % en las 4 esquinas |

## Sigue / muere / inválido

- **Sigue** (un lector puede llevar hasta 16 ramas): se cumplen los cortes de D1, D2, D4, D5 y D6 en las 4 esquinas.
- **Muere** (el multiplexado por ramas en el nodo no sirve tal cual): 15·L/I > 5 % en alguna esquina, o el salto cambia más del
  5 %, o `a16` cruza. Entonces el slot 2 necesita interruptor hvt o de canal largo, o menos ramas por lector, y se dice cuál
  esquina manda.
- **Entre medias** (cortes cumplidos solo hasta un N menor): se reporta el N máximo que cumple, sin ajustar los cortes.
- **Benchmark inválido si:** falla `n1` en un deck (ese deck no cuenta), o falla cualquiera de `mc`, `wi`, `wc`.

## Incertidumbre y límites declarados

- **Epistémica (no la cierra esta prueba):** la fuga real del interruptor en silicio y su dispersión entre dispositivos (σVth de
  17,3 mV sobre n·Ut de 37–47 mV: ×1,4–1,6 por σ); las esquinas `ff` hacen de cota, no de distribución. Sin Monte Carlo aquí.
- **De modelo:** las ramas extra no llevan cableado. En un layout real cada rama añade metal al nodo; ese término no está y D2 es
  una cota inferior de la carga.
- **Fuera de alcance:** DUT de geometría distinta (LOD, densos/aislados), que es el uso real; ruido; acoplo de las líneas de
  selección. Cada uno pide su propia prueba.
- **Numérica:** el control `n1`; resolución de `meas` de 6 cifras.

## Presupuesto

Resolución: 4 decks de transitorio (≤ 15 instancias cada uno), 4 de DC, 2 largos; de dos en dos, con `caffeinate`. Tope: 40 min
por deck (programado con `timeout` en el script). Auditoría: los cuatro controles de arriba van dentro de los mismos decks.

## Estado

Congelado. SHA en `experiments/misfit05/PREREG_SHA256.txt`. Sin commit todavía: el commit lo pide Juan. Enmiendas: ninguna.
