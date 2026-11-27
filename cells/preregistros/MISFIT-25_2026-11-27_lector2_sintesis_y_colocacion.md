# MISFIT-25 · síntesis y colocación del bloque digital del lector 2

Escrito el 2026-11-27 (hora de sellado en `experiments/misfit25/PREREG_SHA256.txt`), **antes** de ninguna corrida de
LibreLane sobre este bloque. Pedido por Juan ("continúa con la síntesis y colocación del lector 2").

## Qué se corre

LibreLane 3.0.14 (el contenedor de `local_flow`), PDK 8afc8346, sobre [`instrument/reader2`](../../instrument/reader2/README.md):
`reader2_slot` = la lógica del lazo de MISFIT-24 como celdas instanciadas (17 celdas) más el contador de rizado de 13
biestables y las dos salidas retenidas. La parte analógica `reader2fe` queda **fuera** del bloque, sobre los pines `x`,
`prenh` y `prenl`; unirla es la etapa siguiente (ensamblado y LVS propio, como en MISFIT-02).

Bloque propio, tamaño relativo (40 % de utilización), sin reloj (`CLOCK_PORT` nulo, sin árbol de reloj). Dos variantes:

| Variante | Configuración |
|---|---|
| `prot` | Como está en `instrument/reader2/config.json`: sin búferes en puertos y `RSZ_DONT_TOUCH_RX` sobre `x`, `prenh`, `prenl` y todo `u_loop.*` |
| `libre` (testigo) | La misma sin esas tres protecciones (búferes en puertos por defecto, sin lista de no tocar) |

**Límites declarados:** es cierre físico. No hay análisis de tiempos que valga (el bloque no tiene reloj: el lazo es un
oscilador asíncrono y el contador es de rizado; lo que diga el flujo de tiempos no se usa). Tampoco LVS de la parte
analógica, ni simulación del bloque extraído: esa es la etapa B, que se prerregistra aparte cuando haya un bloque limpio.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| "El lazo sobrevive" porque el flujo nunca toca celdas instanciadas | Variante `libre`: si tampoco cambia nada, la protección no se ha probado y se dice |
| "Limpio" porque el flujo no comprobó algo | Se exige `metrics.json` con DRC de Magic, LVS y antenas presentes, no ausentes |
| El análisis no ve un búfer porque el nombre cambió | El análisis cuenta, por nombre de red, todas las instancias colgadas de cada red del lazo en el netlist final, no solo las esperadas |

## Predicciones

| # | Predicción |
|---|---|
| H1 | `prot` cierra limpio: termina, DRC de Magic 0, LVS 0, 0 redes con violación de antena |
| H2 | En `prot`, las 17 celdas del lazo están en el netlist final con su mismo tipo, y cada red del lazo tiene exactamente las conexiones del RTL (`x`: 1; `q`: 6; `c`, `c2`, `s`, `qb`, `r`, `enb`, `rsb` y los 7 retardos intermedios: 2; `prenh`, `prenl`: 1). Ningún búfer ni diodo en ellas |
| H3 | Área del bloque (`prot`) entre 1000 y 3000 µm² |
| H4 (testigo) | En `libre` cambia al menos una cosa del lazo: una celda de otro tamaño, o una instancia de más en alguna red del lazo (lo esperable, un búfer en `x`) |

## Qué se hace con cada resultado

- **H1 y H2 cumplidas:** este es el bloque. Sigue la etapa B (extraerlo y simularlo con `reader2fe` y la matriz) y el
  ensamblado.
- **H1 falla por la rejilla de alimentación o por el tamaño:** se ajusta la configuración (hasta 2 enmiendas, cada una
  escrita antes de correr) y se guarda la pasada fallida.
- **H2 falla:** el flujo toca el lazo aun protegido. Entonces el lazo no va por síntesis: se coloca a mano junto a la
  parte analógica y solo el contador pasa por el flujo.
- **H4 falla:** la protección no queda demostrada; se dice y H2 vale menos.
- **Inválida** la prueba si `libre` no termina por una causa ajena al lazo.

Tope: 20 min por corrida, con parada del contenedor.
