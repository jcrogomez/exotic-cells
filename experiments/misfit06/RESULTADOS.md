# MISFIT-06 · resultados: el metal 4 sobre el núcleo queda libre, reservándolo con una obstrucción

Escrito el 2026-11-25 12:27 EST (`date`). Prerregistro: [`MISFIT-06_2026-11-25_area_del_nucleo.md`](../../cells/preregistros/MISFIT-06_2026-11-25_area_del_nucleo.md)
y su [enmienda 1](../../cells/preregistros/MISFIT-06_2026-11-25_area_del_nucleo_enmienda1.md); sellos e incidencias en
`PREREG_SHA256.txt`. Números: `analiza_m6.py` → [`m6.txt`](m6.txt) (escrito antes de ver salidas) y las métricas finales de cada
corrida en `local_flow/misfit06_core_{ctl,m3,m2,obs}/runs/core/final/metrics.json` (fuera de git). Todo es flujo digital.

## Lo aburrido primero: fallos míos

1. El primer lanzamiento no corrió nada (faltaba crear la carpeta de la corrida). Relanzado sin cambiar el prerregistro.
2. **El tope de 20 min no cortó la corrida `m2`:** `gtimeout` mata el proceso del host, no el contenedor. La paré a mano a los
   28 min. El tope tiene que ir dentro del contenedor.
3. Mi banda para el rutado de `m3` (0 a +5 %) estaba mal pensada: al quitar una capa el rutado **bajó** 5,9 %.

## Veredictos, con las palabras del prerregistro

| # | Resultado | Veredicto |
|---|---|---|
| A1 | `ctl` repite MISFIT-04: 1681 instancias, 31 286 µm, DRC 0, LVS 0 | cumplida |
| A2 | `m3` termina con LVS 0 y holguras positivas, pero **34 errores de DRC** (área mínima de metal 3, met3.6) | **FALSA** |
| A3 | `m3`: 0 µm de metal 4 de señal | cumplida |
| A4 | `m3`: rutado −5,90 % frente a `ctl` | **FALSA** (fuera de 0 a +5 %) |
| A5 | `m2` empeora: a los 28 min seguía en la iteración 10 del rutado detallado con 3258 violaciones | cumplida (no termina) |

Benchmark válido. **B1 tal como se escribió: muere.** El núcleo no cierra con el límite global en metal 3.

**Por qué (exploración):** las 34 cajas de error están todas en y = 86,5–86,9 µm, bajo los 43 pines de metal 4 del borde superior.

### Enmienda 1 (B1b): obstrucción de metal 4 en y 0–80 µm, banda de pines libre

| # | Resultado | Veredicto |
|---|---|---|
| O1 | `obs` termina; DRC de Magic 0; LVS 0; holgura de setup 5,59 ns y de hold 0,109 ns; 0 violaciones | cumplida |
| O2 | metal 4 de señal por debajo de y = 80 µm: 0,0 µm (quedan 165,8 µm, todos por encima de y = 80,58) | cumplida |
| O3 | rutado −5,58 % frente a `ctl` | cumplida |

**Sigue.** Ventana reservada sobre el núcleo: 80 µm de alto por 148,2 µm de huecos entre las 8 franjas de alimentación =
**11 856 µm² de metal 4, en bruto.** Los huecos miden 18,3, 34,0, 34,0, 34,0 y 21,2 µm de ancho (más cuatro de 1,7 µm entre
franjas gemelas, que no sirven).

Coste medido: la holgura de setup baja de 6,65 a 5,59 ns y la de hold de 0,115 a 0,109 ns. Siguen positivas.

## Relleno (B2), leído del DEF de MISFIT-04 sin corrida

600 celdas de relleno en 347 tramos; el mayor mide 8,74 µm; 66 tramos ≥ 3 µm (797 µm²); 20 tramos ≥ 5 µm (354 µm²). El relleno
sobrante está en astillas. Para alojar celdas de fila hay que instanciarlas en el netlist.

## ¿Qué explicación aburrida no descarté?

- Que la ventana esté libre para el enrutador no dice que sea **usable**: falta el acoplo del núcleo hacia lo que se ponga encima
  (prueba B4), las reglas de densidad de metal, y comprobar que el LEF del bloque la exporta como libre al nivel del tile.
- No comprobé que las 34 cajas correspondan una a una a pines; solo que todas caen en su banda.
- Una sola semilla del flujo por variante.
