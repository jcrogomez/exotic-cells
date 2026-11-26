# MISFIT-22 · el lector 2 dibujado: nodo y dos precargas

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit22/PREREG_SHA256.txt`), **antes** de tocar el generador.
Juan pidió hoy dibujar el lector 2 antes de seguir con más candidatos: las tres celdas en papel (XC-20, XC-19, XC-14) dan
corrientes que solo este lector convierte en algo que sale por un pin digital, y solo existe en esquemático.

## Qué se dibuja

La parte analógica del lector 2, como celda propia `reader2fe`, generada por `generator/matrix.py` (clase nueva `reader2`):

- el condensador del nodo: `nfet_01v8` 4,3/4,0 con puerta en X y fuente, drenaje y sustrato en GND;
- **las dos precargas sobre el mismo nodo**, cada una con su línea de puerta: rango alto (PRENH, `pfet_01v8_hvt` 1,0/0,15)
  y rango bajo (PRENL, 1,0/1,00). Cada una son dos ramas en paralelo de dos transistores en serie, en una sola difusión
  (VDD · g · g · X · g · g · VDD), en un pozo n común con su toma;
- pines en metal 1: X, PRENH, PRENL, VDD, GND.

**Decisiones mías, por delegación:**

1. **La lógica del lazo (comparador, cerrojo, retardo) se queda en celdas de librería colocadas por el flujo digital**, como
   en el lector 1. La revierte: que el cable de X hasta el comparador, ya rutado, pese más del 10 % del nodo o meta ruido.
2. **El nodo intermedio de cada rama queda sin contacto** (dos nodos separados por precarga, no uno común como en el
   esquemático). Ahorra dos contactos y su fuga. La revierte: que la lectura con la celda extraída empeore (MISFIT-23).
3. El rango se elige con qué línea de puerta se mueve; la otra queda en VDD. Las dos precargas cuelgan siempre del nodo:
   eso es un circuito distinto del simulado en MISFIT-17 y hay que releerlo con la celda extraída. **Esa lectura es otra
   prueba (MISFIT-23),** que se prerregistra cuando cierre la enmienda 1 de MISFIT-17 (fija el paso de simulación).

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| Sale limpio porque la herramienta no mira | Testigo de reglas: la misma celda con las dos precargas a 0,10 µm (L4) |
| El LVS casa porque casa cualquier cosa | Testigo de LVS: contra una referencia con la precarga larga de 0,50 µm (L5) |
| Limpio en Magic y sucio en fábrica | Los dos decks de KLayout, el completo con FEOL activado |

## Predicciones

| # | Predicción |
|---|---|
| L1 | Limpia en Magic `drc(full)`, KLayout `sky130A_mr` y deck completo, y LVS "match" contra la referencia generada. Las correcciones de reglas que hagan falta van como enmiendas, contadas |
| L2 | Caja entre 60 y 85 µm² |
| L3 | Capacidad de cableado extraída sobre X (suma de condensadores del `.pex.spice` con un extremo en X, sin dispositivos): entre 0,5 y 4 fF, menos del 2 % de los ~200 fF del nodo |
| L4 (testigo) | Con las dos precargas a 0,10 µm, Magic o KLayout dan al menos una violación |
| L5 (testigo) | Contra la referencia con la precarga larga a 0,50 µm, netgen **no** casa |

- **Sigue si** L1, L4 y L5 se cumplen: la celda extraída pasa a MISFIT-23.
- **L2 o L3 falsas:** se anota el valor; no bloquean.
- **Inválido** si falla un testigo: la herramienta no mira y L1 no dice nada.
- **Muere** (este dibujo) si tras tres enmiendas no queda limpio: se cambia de disposición, no de reglas.

## Qué no dice

Nada de cómo lee (MISFIT-23). Nada de desajuste, ni del rutado de X, ni de la lógica. Capacidades de Magic, no de un
resolvedor de campos.
