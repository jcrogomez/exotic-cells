# MISFIT-06 · área encima y dentro del núcleo digital (pruebas B1 y B2 del plan)

Escrito el 2026-11-25 11:48 EST (`date`), **antes** de lanzar ninguna corrida del flujo. Plan: [`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md).
Todo es flujo digital (LibreLane 3.0.14, el de MISFIT-04). Nada es silicio.

## Lo que ya se leyó de archivos existentes (exploración, no resultado)

Del DEF final del núcleo de MISFIT-04 (`local_flow/misfit04_core/runs/core/final/def/`), antes de escribir esto:
- **Metal 4:** las señales usan 1131 µm en 93 tramos, de 31 286 µm de rutado. La alimentación son 8 franjas verticales.
- **Relleno:** 600 celdas en 347 tramos contiguos. El mayor mide 8,74 µm; 66 tramos miden ≥ 3 µm (797 µm²) y 20 miden ≥ 5 µm
  (354 µm²). **El relleno está en astillas:** "vivir en el relleno" tal cual da huecos de pocas micras.

Consecuencia para B2, sin corrida: una celda exótica con forma de fila no cabe en el relleno sobrante salvo que mida < ~5 µm. La
vía es otra: instanciarla en el netlist para que el flujo le haga sitio. Eso es una prueba aparte (con celda dibujada) y no entra aquí.

## Pregunta (B1)

¿Cierra el núcleo si el rutado de señales se limita a metal 3, dejando el metal 4 libre salvo las franjas de alimentación?

## Explicaciones aburridas y su chequeo

| Aburrida | Chequeo |
|---|---|
| La corrida nueva difiere por algo que no es el metal (versión, semilla, carpeta) | Control `ctl`: la misma configuración de MISFIT-04 en carpeta nueva debe repetir 1681 instancias y 31 286 µm de rutado |
| "Cierra" porque la métrica no es sensible a quitar capas | Mutante `m2`: límite en metal 2. Debe empeorar de forma visible |
| Queda metal 4 de señal aunque el límite diga metal 3 | Se cuenta el metal 4 de NETS en el DEF final, no se confía en la opción |

## Diseño

Tres copias de `local_flow/misfit04_core` (fuentes y plantilla idénticas), con `RT_MAX_LAYER` = met4 (`ctl`), met3 (`m3`) y met2
(`m2`). Mismo comando que MISFIT-04. Una tras otra. Tope: 20 min por corrida (`timeout` en el script).

## Predicciones

| # | Cantidad | Predicción |
|---|---|---|
| A1 | `ctl` | repite MISFIT-04: 1681 instancias, rutado 31 286 µm, DRC 0, LVS limpio |
| A2 | `m3`: termina, DRC de Magic 0, LVS limpio, holguras de setup y hold ≥ 0 | sí a todo |
| A3 | `m3`: metal 4 de señal en el DEF final | 0 µm |
| A4 | `m3`: longitud de rutado frente a `ctl` | entre 0 y +5 % |
| A5 | `m2`: empeora | no termina, o DRC > 0, o rutado > +5 % frente a `ctl` |

## Sigue / muere / inválido

- **Sigue** (el metal 4 sobre el núcleo queda libre para estructuras de solo metal): A2 y A3 cumplidas.
- **Muere:** `m3` no termina, o deja violaciones de DRC, LVS o tiempos.
- **Benchmark inválido si:** falla A1, o A5 no empeora (la prueba no sería sensible).

## Qué se reporta además

Área de metal 4 libre entre franjas de alimentación sobre el bloque, medida en el DEF de `m3`. **Límite declarado:** que esté
libre no dice que sea usable: falta el acoplo del núcleo hacia lo que se ponga encima (prueba B4) y las reglas de densidad de metal.

## Estado

Congelado. SHA en `experiments/misfit06/PREREG_SHA256.txt`. Enmiendas: ninguna.
