# MISFIT-13 · el núcleo crecido no cabe en su bloque · resultados

Prerregistro: [`MISFIT-13`](../../cells/preregistros/MISFIT-13_2026-11-26_nucleo_crecido.md) y
[enmienda 1](../../cells/preregistros/MISFIT-13_2026-11-26_nucleo_crecido_enmienda1.md). RTL: `instrument/misfit13/`. Salidas:
[`m13_v1.txt`](m13_v1.txt) (primera pasada), [`m13_e1.txt`](m13_e1.txt) (densidad sin fijar). LibreLane 3.0.14, una corrida por punto.

## Lo aburrido primero

- **Una corrida por variante, y falla el colocador, no la física.** `DPL-0036` dice que el colocador detallado no encontró
  sitio; otra semilla, otro reparto de pines u otra estrategia de reparación podrían cerrar un caso al límite.
- **El RTL nuevo no está verificado** (solo compila): es una prueba de tamaño.
- **El segundo lector se aproximó** con otro decodificador E7; el lector 2 real pedirá otra cosa (un divisor).
- **Los pines los colocó el flujo,** no la plantilla del tile. Con eso el propio control ocupa más que con plantilla.

## Resultado

| Variante | Ocupación efectiva | Ocupación al colocar | Pasada 1 (densidad 60) | Enmienda 1 (densidad libre) |
|---|---|---|---|---|
| `v0` núcleo actual | 66,5 % | 78,6 % | **cierra limpio** | — |
| `v3` 8 filas + 8 columnas + 2º lector | 70,3 % | 83,0 % | falla (`DPL-0036`) | falla |
| `v1` 64 líneas + 2º lector | 73,7 % | 87,7 % | falla | falla |
| `v2` 128 líneas + 2º lector | 79,4 % | 94,8 % | falla | falla |

| # | Predicción | Veredicto |
|---|---|---|
| N0 | El control cierra limpio | **cumplida** |
| N1 | 64 líneas no cierra | **cumplida** |
| N2 | 128 líneas no cierra | **cumplida** |
| N3 | 8 + 8 cierra | **falsa**, también con la densidad libre (P1 de la enmienda, falsa) |

**Veredicto (regla escrita):** ninguna variante cierra; el bloque del núcleo tiene que crecer. El borde está entre 78,6 % y
83,0 % de ocupación al colocar: el núcleo actual ya está pegado a él.

**Lo que no se hizo, a propósito:** medir cuántas filas pide. Juan pidió el 2026-11-26 decidir primero los candidatos y dejar
el espacio y el número de tiles para después. Este resultado queda como dato para esa cuenta: con lo que hay hoy, dos lectores
con selección de puestos no entran en un tile 1×1 sin quitarle filas a la franja de las celdas.
