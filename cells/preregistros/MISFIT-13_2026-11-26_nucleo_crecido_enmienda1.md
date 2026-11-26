# MISFIT-13 · enmienda 1 · las tres variantes otra vez, con la densidad de colocación sin fijar

Escrita el 2026-11-26 09:47 EST (`date`), **después** de la primera pasada y antes de repetir.

**Qué pasó (se queda como está, `experiments/misfit13/m13_v1.txt`):** el control cierra limpio (N0 cumplida). Las tres
variantes fallan en menos de un minuto en la **colocación detallada** (`DPL-0036`), con ocupación en la colocación global de
83,0 % (`v3`, 8 + 8), 87,7 % (`v1`, 64 líneas) y 94,8 % (`v2`, 128). N1 y N2 cumplidas, N3 falsa. Por la regla escrita:
ninguna cierra y el bloque tiene que crecer.

**Por qué no lo doy por cerrado:** la configuración heredada fija `PL_TARGET_DENSITY_PCT = 60`, y el flujo avisa de que es
demasiado baja y la cambia solo. Es el mismo error que anoté en MISFIT-10 (enmienda 1, punto 2) y no lo quité aquí. El punto
que dice que el núcleo actual cierra a 31 filas se midió **sin** ese parámetro. Mi programa de análisis además reportó el aviso
de densidad como causa; la causa real es `DPL-0036` (se corrige el texto del informe, no el criterio).

**Prueba repetida:** `v1`, `v2` y `v3` con `PL_TARGET_DENSITY_PCT` sin fijar; todo lo demás igual. El control no se
repite: ya cierra. Mismos criterios y mismo tope.

| # | Predicción (baja confianza) |
|---|---|
| P1 | `v3` (8 + 8) cierra limpio con la densidad libre |
| P2 | `v1` (64 líneas) sigue sin cerrar |
| P3 | `v2` (128 líneas) sigue sin cerrar |

**Lectura ya fijada:** si `v3` tampoco cierra, el núcleo con segundo lector no cabe en 32 filas ni con la selección más
barata, y lo siguiente es medir cuántas filas pide (bloque de 33 a 36 filas, que salen de la franja libre).
