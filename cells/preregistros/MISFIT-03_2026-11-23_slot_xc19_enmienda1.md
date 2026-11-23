# MISFIT-03 · etapa a · enmienda 1

Cita [`MISFIT-03_2026-11-23_slot_xc19.md`](MISFIT-03_2026-11-23_slot_xc19.md) (SHA-256 `eb0917c4…e25d`, sellado a las 07:41:09
en `experiments/xc19_slot/PREREG_SHA256.txt`). Escrita el 2026-11-23 desde las 14:13:19 EST (`date`), tras la decisión de Juan
sobre `src` y **antes de dibujar nada del macro**. El original no se edita.

Números nuevos: [`diseno_ref3.txt`](../../experiments/xc19_slot/diseno_ref3.txt) → [`diseno_ref3_analisis.txt`](../../experiments/xc19_slot/diseno_ref3_analisis.txt)
(14:07:46–14:12:50; esquemático, cálculo de diseño). Exploración previa descartada, que se conserva: `diseno_ref.txt`
(referencias de canal largo) y `diseno_ref2.txt` (compuestas 2 × 2 y 3 × 3).

## Decisión de Juan (2026-11-23), transcrita

| `src` | A | B | Propósito |
|---|---|---|---|
| 00 | sin fuente | sin fuente | fuga y detección de fallos |
| 01 | DUT de XC-19 | gemelo | experimento |
| 10 | 2 unidades | 1 unidad | contraste diferencial |
| 11 | 1 unidad | 1 unidad | referencia simétrica |

Condiciones de Juan:
- `src = 10` y `src = 11` necesitan una descarga de referencia conocida y reproducible.
- No se declara linealidad de tres puntos: no hay estado basal de 0 unidades bajo la misma descarga.
- La calibración certifica la cadena temporal y su sensibilidad diferencial, no la detección de una carga.
- XC-20 queda fuera del MISFIT mínimo 1×2.

## Cambios

| # | Qué cambia | Por qué |
|---|---|---|
| E1 | `src` según la tabla de arriba. Sustituye §4 del original (`src = 3` era 1 u en A y 0 u en B; `src = 2` era una propuesta) | decisión de Juan |
| E2 | **Descarga de referencia propia** en cada nodo: 12 nfet mínimos 0,42/0,15 (0,30 µm de difusión, como el DUT y el espejo), 2 en serie × 6 en paralelo, con la puerta en VB y un interruptor nfet 0,84/0,15 en la fuente. Conduce solo en `src = 10/11`. El **DUT se desconecta por la fuente** (nfet 0,84/0,15) fuera de `src = 01`; su difusión y su LOD no se tocan | Juan pide una descarga reproducible. Con el DUT conectado, una trampa suya contaminaría la calibración. 2 × 6 sigue al DUT: ref/DUT = 0,71–1,70 entre esquinas y 1,00 a tt. Su área es 12 veces la del DUT, así que una trampa pesa ~1/12. Las referencias de canal largo no siguen al DUT (2,0 µs en ss 85 frente a 6,4 µs en tt) y la 2 × 2 es 3 veces más lenta |
| E3 | **Tres interruptores pfet 0,42/0,15 por nodo:** S0 sin placa, S1 y S2 con una unidad cada uno. `src = 11`: S0 + S1 en ambos nodos. `src = 10`: A cierra S1 + S2 y B cierra S0 + S1. En B, S2 nunca se cierra pero existe | siempre hay dos interruptores cerrados por nodo, así que sus uniones no cambian entre estados. B es idéntico en `10` y `11`: es la referencia de deriva |
| E4 | **P4 se redefine.** Paso de unidad = [t_A/t_B]₁₀ − [t_A/t_B]₁₁, en %. Diseño (esquemático, u = 0,6 fF): 0,411 % tt 27 · 0,446 % ss 85 · 0,383 % ff −40 · 0,297 % ff 85. **Predicción en el macro extraído:** entre 0,25 y 0,60 % a tt 27, y ≥ 0,15 % en las cuatro esquinas | el estado de 0 u ya no existe |
| E5 | **P5 (linealidad) se retira.** Lo sustituye **P5′, referencia simétrica:** en `src = 11`, abs(t_A/t_B − 1) ≤ 0,15 % en las cuatro esquinas. Sin desajuste en la simulación: mide la asimetría del dibujo | no hay tres puntos bajo la misma descarga (condición de Juan) |
| E6 | **P6′, nueva:** la referencia cae en la ventana del contador y su paso de unidad da ≥ 5 cuentas a 50 MHz en tt 27 y ff −40, y **< 1 cuenta en ff 85** (fallo esperado, como en P6; diseño: 6,3 / 15,1 / 0,4 cuentas). ss 85 se reporta sin predicción binaria (diseño: 4,8 cuentas, en el borde) | la cuantización también afecta a la calibración |
| E7 | **Dónde vive la lógica.** `misfit_cell_slot` = decodificador de `en`/`src` en celdas estándar + macro analógico `xc19_slot_core`. El macro expone las líneas crudas: PRE_N, VBIAS, C1, DUTA, DUTB, REFEN, SA0B, SA1B, SA2B, SB0B, SB1B, más XA_OUT/XB_OUT de sus inversores. El contrato se comprueba sobre la unión de ambos: netlist SPICE de las celdas estándar más el macro extraído. Colocar el decodificador junto al macro es trabajo de MISFIT-04 | la lógica es digital y su lugar natural es el flujo. Dibujar puertas a mano dentro del macro no añade evidencia y sí errores |
| E8 | **`en = 0` inerte:** VBIAS = 0 y C1 = 0, así que la cadena de polarización queda sin alimentación y VB = 0. Precarga encendida (PRE_N bajo): X queda alto y `xa`, `xb` bajos sin nodo flotante. Todos los interruptores abiertos. P2 sin cambios | la cadena de `xc19_bias` se alimenta por su pin VDD; separarlo del VDD del macro es el único corte que no toca el espejo |
| E9 | **Fallos:** F1 placa abierta → paso de unidad < 0,05 %. F2 S1 de A pegado cerrado → `src = 01` desplaza A > 0,25 % respecto a B. F3–F6 sin cambios. **F7, nuevo:** interruptor de fuente del DUT de A pegado cerrado → en `src = 11` la lectura de A se acelera > 20 % respecto a B (el DUT descarga en paralelo con la referencia) | adaptación a E1–E3 |
| E10 | **Precheck:** el precheck de Tiny Tapeout corre sobre un tile, no sobre un macro suelto. Se intenta con el arnés de tile de MISFIT-02. Si no cabe en esta sesión, se declara pendiente para MISFIT-04, **no pasado** | honestidad sobre qué comprueba qué |

Sin cambios: P1, P2, P3, P6, P7, b1–b6, criterios de muerte (P4 con la definición de E4) y presupuestos.
