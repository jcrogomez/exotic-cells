# MISFIT-07 · cuánto filtro de polarización necesita el lector (prueba R7 del plan)

Escrito el 2026-11-25 12:12 EST (`date`), **antes** de escribir el generador o de correr nada. Plan:
[`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md). Motivo: el objetivo es un tile 1×1 (Juan, 2026-11-25) y el filtro de VB
(33 dedos nfet 5,5 × 10 µm, ~10 pF) ocupa 4743 de los 5570 µm² del lector; no cabe en la franja libre de 161 × 24,5 µm.
Todo es modelo (SPICE). Nada es silicio.

## Lo que ya dice el repo (no es resultado de esta prueba)

De `experiments/xc19_caps/INFORME.md` y `filt.txt`, sobre el canal **viejo** (`xc19_channel_caps`, filtro ideal):
- Los 10 pF salieron del criterio "hundimiento de VB < 0,03 mV cuando dispara una etapa" (C12): pedía ~5 pF.
- El criterio sobre lo que se mide, "interacción asíncrona < 0,08 % del tiempo", **se cumplía incluso sin filtro** (0,0058 %).

Así que el tamaño del filtro lo fijó una tensión interna, no la lectura. Esta prueba lo vuelve a medir sobre el macro actual,
con la lectura como criterio.

## Pregunta

En el macro extraído v_hm, ¿cuántos dedos del filtro hacen falta para que la lectura (tiempo de A, salto de una carga, paso de
calibración y diafonía hacia B) no cambie?

## Explicaciones aburridas y su chequeo

| Aburrida | Chequeo |
|---|---|
| El deck no está convergido | Control por deck: la instancia con 33 dedos y src = 01 repite `h01` del contrato (A y B) dentro de 0,01 % |
| "No cambia" porque la métrica no ve el filtro | Testigo: con 0 dedos la diafonía hacia B debe ser ≥ 3 veces la de 33 dedos |
| Quitar dedos cambia la DC de VB y no solo la capacidad | Se reporta VB en cada variante; debe coincidir dentro de 0,1 mV |
| El cableado de los dedos quitados sigue en el netlist | Límite declarado: las capacidades extraídas de cable se quedan; la capacidad real con k dedos es algo menor que la simulada |

## Diseño

- Macro `cells/xc19_slot_core_a2/v_hm` con el arnés de `experiments/xc19_slot/gen_contrato.py`.
- Variantes: se conservan k = 33, 16, 8, 4, 2, 0 dedos (se borran los demás dispositivos `GND VB GND GND nfet 5.5/10` del
  netlist extraído, por orden de aparición).
- Por variante, cuatro instancias: `h` (src 01), `t` (src 01 con el salto de 0,305 mV en A), `r` (src 11) y `c` (src 10).
- Cuatro esquinas; 80 µs (ff −40: 160 µs). Una corrida a la vez. Tope: 40 min por deck (`timeout` en el script).

## Cantidades

- **S** = salto de una carga en A, (tA(t) − tA(h)) / tA(h).
- **X** = diafonía: |tB(t) − tB(h)| / tB(h), lo que se mueve B cuando solo cambió A.
- **P** = paso de calibración, tA/tB(c) − tA/tB(r).
- **D** = desplazamiento del tiempo de A frente a la variante de 33 dedos.

## Predicciones

| # | Predicción |
|---|---|
| F1 | Con k ≥ 4 (≈ 1,2 pF), S cambia menos del 2 % relativo frente a k = 33, en las 4 esquinas |
| F2 | Con k ≥ 4, X ≤ 0,08 % (una décima del salto) en las 4 esquinas |
| F3 | Con k ≥ 4, P cambia menos del 2 % relativo frente a k = 33 |
| F4 | Con k ≥ 4, \|D\| ≤ 0,5 % |
| F5 (testigo) | X(k = 0) ≥ 3 · X(k = 33) en al menos 3 de las 4 esquinas |

**Corte que decide el filtro:** el k más pequeño que cumple F1–F4 en las 4 esquinas. Con 5,52 fF/µm² (`xc19_caps`), k dedos son
k × 55 µm² de puerta.

## Sigue / muere / inválido

- **Sigue** (el lector cabe en un tile): el corte da k ≤ 8 (≤ 440 µm² de puerta).
- **Muere:** hace falta k ≥ 16. Entonces el filtro no cabe en la franja y hay que mudarlo (condensador metal-aislante-metal en el
  segundo piso, o repartirlo en celdas de fila) o volver a 1×2.
- **Benchmark inválido si:** falla el control de un deck (ese deck no cuenta) o falla F5.

## Lo que esta prueba no cubre

- **Ruido.** El transitorio no tiene ruido. Argumento, no medida: el filtro corta por encima de ~24 kHz (τ ≈ 6,7 µs con 10 pF),
  así que no toca el 1/f; y el ruido blanco de la cadena, promediado en una lectura de 30 µs, no depende de C. Lo cierra R5.
- **Varias ramas y dos lectores en el mismo VB** (R3, R6): más golpes sobre el mismo nodo.
- **Desajuste** entre A y B: con tiempos distintos el golpe de uno cae en mitad de la lectura del otro. La instancia `c`
  (A y B con cargas distintas) es el único caso asíncrono que entra aquí.

## Estado

Congelado. SHA en `experiments/misfit07/PREREG_SHA256.txt`. Enmiendas: ninguna.
