# MISFIT-10 · cuántas filas puede perder el bloque del núcleo (prueba B3b del plan)

Escrito el 2026-11-25 12:56 EST (`date`), **antes** de lanzar ninguna corrida. Plan: [`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md).
Sigue a MISFIT-06 (metal 4 reservado) y MISFIT-08 (núcleo lean, −9,0 % de área de celdas en el mismo bloque).

## Pregunta

El bloque mide hoy 161 × 87,04 µm (32 filas de 2,72 µm). ¿Hasta cuántas filas cierra limpio, con el núcleo lean y con el original?
Cada fila que suelte son 438 µm² de silicio para la franja de un tile 1×1.

## Explicaciones aburridas y su chequeo

| Aburrida | Chequeo |
|---|---|
| El bloque ya estaba sobrado y la dieta no pinta nada | Se corre también el **RTL original** a las mismas alturas: la aportación de la dieta es la diferencia entre los dos mínimos |
| "Cierra" siempre porque la prueba no aprieta | Testigo: a 20 filas (ocupación de ~97 % con el área de MISFIT-08) el lean **no** debe cerrar |
| Un resultado depende de la semilla del flujo | No se chequea aquí: una corrida por punto. Por eso la altura que se adopte lleva margen (abajo) |
| La configuración no es la del tile | Todas las corridas llevan la obstrucción de metal 4 de MISFIT-06, escalada: y de 0 a (alto − 7,04 µm) |

## Diseño

Mismas fuentes, plantilla y comando que MISFIT-06 `obs`; la plantilla se reescala (alto del dado y y de los 43 pines de arriba).
Alturas: 28, 26, 24, 22 y 20 filas (76,16 / 70,72 / 65,28 / 59,84 / 54,40 µm) con el lean; 26, 24 y 22 con el original.
`PL_TARGET_DENSITY_PCT`, fijado de antemano por altura: 65, 70, 75, 82 y 90. Dos corridas a la vez. Tope: 20 min por corrida;
si se alcanza, se para el contenedor y cuenta como "no cierra".

**Cierra limpio** = el flujo termina, DRC de Magic 0, LVS 0, 0 violaciones de setup y de hold, y 0 µm de metal 4 de señal dentro
de la obstrucción.

## Predicciones

| # | Predicción |
|---|---|
| H1 | El lean cierra limpio a 28 y a 26 filas |
| H2 | El lean cierra limpio a 24 filas (apuesta) |
| H3 (testigo) | El lean no cierra a 20 filas |
| H4 | El original cierra limpio a 26 filas: el bloque de 32 filas estaba sobrado con o sin dieta |
| H5 | El mínimo del lean está 2 filas por debajo del mínimo del original (813 µm² son 1,9 filas), dentro de la rejilla de 2 filas |

## Qué se adopta

**Altura de diseño = el mínimo que cierra limpio, más 2 filas de margen**, para la versión que dé el mínimo más bajo. Regla fijada
antes de ver nada.

- **Sigue:** el bloque baja al menos 4 filas (≥ 1752 µm² para la franja).
- **Muere:** ni el lean ni el original cierran por debajo de 30 filas.
- **Inválido si:** falla H3 (la prueba no aprieta) o el lean a 28 filas no cierra (algo ajeno a la altura está roto).

## Límites declarados

- **El núcleo va a crecer:** falta la lógica de selección para 32 o más puestos, el segundo lector y el modo de estrés. La altura
  de hoy es una cota inferior de la del tile final, no su valor.
- Una semilla por punto. Sin acoplo hacia el segundo piso (B4).

SHA en `experiments/misfit10/PREREG_SHA256.txt`.
