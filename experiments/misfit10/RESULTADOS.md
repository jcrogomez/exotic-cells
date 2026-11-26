# MISFIT-10 · resultados: el bloque del núcleo no puede perder filas

Escrito el 2026-11-25 21:33 EST (`date`). Prerregistro: [`MISFIT-10_2026-11-25_altura_del_nucleo.md`](../../cells/preregistros/MISFIT-10_2026-11-25_altura_del_nucleo.md)
y su [enmienda 1](../../cells/preregistros/MISFIT-10_2026-11-25_altura_del_nucleo_enmienda1.md); sellos e incidencias en
`PREREG_SHA256.txt`. Corridas en `local_flow/misfit10_core_*` (fuera de git); `m10.txt` (primera tanda), `corre.out`, `corre_b.out`.

## Lo aburrido primero: fallos míos

1. **El tope de 20 min no cortó nada, tres veces.** `gtimeout` no mata a LibreLane. Dos corridas (original a 30 filas, lean a
   29) siguieron **8 horas** hasta que las paré a mano; iban por las iteraciones 43 y 55 del rutado detallado. Cuentan como
   "no cierra", que es lo que eran, pero el tope tiene que imponerse desde fuera del proceso.
2. Premisa falsa de partida: tomé el área de celdas como holgura (ver la enmienda 1).
3. Una corrida por punto, una semilla.

## Qué cierra limpio (termina, DRC 0, LVS 0, sin violaciones de tiempos, metal 4 reservado)

| Filas | Alto (µm) | Original | Lean (MISFIT-08) |
|---|---|---|---|
| 32 | 87,04 | sí (MISFIT-06) | sí, **sin** la obstrucción de metal 4 (MISFIT-08); con ella no se probó |
| 31 | 84,32 | **sí** (holgura de setup 5,54 ns, hold 0,112 ns) | no: 25 min sin converger el rutado |
| 30 | 81,60 | no: horas sin converger | no |
| 29 | 78,88 | no: falla en segundos, en la colocación | no |
| ≤ 28 | | no (colocación) | no (colocación) |

## Veredictos

- **Primera tanda** (28 a 20 filas): H1, H2 y H4 falsas; H3 cumplida; benchmark inválido por su propia regla.
- **Enmienda 1** (31, 30, 29): J1 **falsa** (el lean no cierra a 31), J2 **falsa**, J3 **falsa**, J4 cumplida (la rejilla aprieta).
- **Regla de adopción** (mínimo que cierra más 2 filas de margen): el mínimo es 31, con el original. La altura de diseño sería
  33 filas, **más de las 32 de hoy**. El criterio "sigue" (soltar ≥ 4 filas) no se cumple: **muere**.

## Qué se lleva el tile

- **El bloque del núcleo se queda en 32 filas**, y con solo una fila de margen según mi propia regla.
- **La dieta (lean) no se adopta para ganar sitio.** Deja menos área de celdas al final, pero es más difícil de rutar: no cierra
  donde el original sí. Queda como variante verificada en lo lógico (MISFIT-08) y nada más.
- La franja de silicio de un tile 1×1 son los 3941 µm² de hoy. Todo lo que el núcleo tenga que crecer (selección de más puestos,
  segundo lector, modo de estrés) sale de ahí o empuja a 1×2.

## ¿Qué explicación aburrida no descarté?

Que con otros ajustes del flujo (densidad, colocación guiada por rutabilidad, semilla) el borde se mueva una o dos filas. No lo
exploré: mover el borde una fila no cambia la conclusión.
