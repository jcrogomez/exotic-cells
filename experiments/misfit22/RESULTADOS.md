# MISFIT-22 · el lector 2 dibujado: nodo y dos precargas · resultados

Prerregistro: [`MISFIT-22`](../../cells/preregistros/MISFIT-22_2026-11-26_lector2_dibujado.md), sellado y subido antes de
tocar el generador; [enmienda 1](../../cells/preregistros/MISFIT-22_2026-11-26_lector2_dibujado_enmienda1.md). Tabla:
[`generator/tables/reader2fe.json`](../../generator/tables/reader2fe.json). Salida: `reader2fe/`; primera pasada en
`pasada1/`; testigo de reglas en `testigo_reglas/`. Dibujo, verificación y capacidades extraídas; ninguna simulación.

## Lo aburrido primero

- **Es solo la parte analógica** (condensador del nodo y las dos precargas). El comparador, el cerrojo y el retardo siguen
  siendo celdas de librería sin colocar. Cómo lee esta celda extraída es MISFIT-23, sin correr.
- **La enmienda 1 se selló por SHA y hora antes de la pasada 2, pero no la subí antes de correrla** (sí el prerregistro).
  Queda dicho; la hora está en `PREREG_SHA256.txt`.
- **El testigo de LVS encontró un hueco en `generator/run.sh`:** con un largo equivocado netgen dice "Circuits match
  uniquely" y, aparte, "Property errors were found"; la línea de resumen solo copiaba lo primero. Corregido (ahora imprime
  `property errors: N`). Revisados los 20 LVS aceptados del repo: ninguno tenía errores de propiedad. Los mutantes
  anteriores eran de topología y por eso no lo habían destapado.
- Capacidades de la extracción de Magic, no de un resolvedor de campos.

## Resultado

| # | Predicción | Veredicto |
|---|---|---|
| L1 | Limpia en las tres herramientas y LVS match | **cumplida, con una enmienda**: pasada 1, LVS casa pero 2 reglas en Magic y 7 en KLayout (`li.5`, `licon.9`); pasada 2: 0 / 0 / 0, "Circuits match uniquely", 0 errores de propiedad |
| L2 | Caja entre 60 y 85 µm² | **cumplida**: 8,88 × 7,98 = 70,9 µm² |
| L3 | Cableado sobre X entre 0,5 y 4 fF | **cumplida**: 2,42 fF (1,84 a GND, 0,29 a VDD, 0,19 a PRENL, 0,09 a PRENH), un 1,2 % de 200 fF |
| L4 (testigo) | Precargas a 0,10 µm: al menos una violación | **cumplida**: `diff/tap.3` en Magic, 1 en cada deck de KLayout |
| L5 (testigo) | Contra la precarga larga a 0,50 µm netgen no casa | **cumplida, con matiz**: la topología casa y netgen marca error de propiedad; mi resumen no lo mostraba (ver arriba) |

Nueve dispositivos extraídos: el condensador 4,3/4,0 y ocho `pfet_01v8_hvt` 1,0 de ancho (cuatro de 0,15 y cuatro de
1,00), con los cuatro nodos intermedios sin contacto.

**Qué dice:** el lector 2 cabe en 71 µm² (unos 3,3 puestos de XC-20) y su cableado interno no pesa. Las líneas de
precarga acoplan al nodo 0,09 y 0,19 fF por cable, además del solape de los transistores: es inyección de reloj sobre un
nodo que en el rango bajo solo recibe ~50 fC por ciclo, y entra en MISFIT-23.

## Qué explicación aburrida no descarté

- Que la celda extraída lea peor que el esquemático: dos precargas colgando a la vez, nodos intermedios separados, áreas
  de difusión reales (el esquemático no llevaba ninguna). Es MISFIT-23.
- Que el cable de X hasta el comparador y hasta las matrices, sin dibujar, pese más que todo lo de aquí.
- Que `hvtp` o el pozo den problemas al pegar esta celda a otras: verificada sola.
