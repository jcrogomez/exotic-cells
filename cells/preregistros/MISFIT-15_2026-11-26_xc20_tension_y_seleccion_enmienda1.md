# MISFIT-15 · enmienda 1 · la primera pasada no convergió

Escrita el 2026-11-26 (hora de sellado en `experiments/misfit15/PREREG_SHA256.txt`), **después** de la primera pasada y
**antes** de la segunda.

## Qué pasó (se queda como está, en `experiments/misfit15/pasada1/`)

Los 4 decks terminaron con salida 0 pero el punto de operación no convergió ("gmin stepping failed", "source stepping
failed"): todas las tensiones salen `nan` y las 95 líneas vienen vacías. Por la regla escrita, **inválida**. No se leyó
ningún número. Causa `[?]`, sin diagnosticar más: 95 puestos independientes en una sola matriz, con islas flotantes y
gmin = 1e-18. Además mi analizador esperaba 93 líneas y son 95 (error de cuenta mío; no toca veredictos).

## Qué cambia

Solo el banco, no lo que se mide ni las bandas:

- Un deck por esquina con **un** puesto de cada clase (A y B, con n = 1 y n = 3), los dos diodos sueltos y los cuatro buses.
  X, la puerta e I0 se cambian con `alter` y se resuelve un punto de operación por combinación. Las mismas 95 cantidades.
- I0 entra por una fuente de tensión de control (I = v(ctl)·(V/1,8)ⁿ), para poder cambiarlo sin rehacer el circuito.
- gmin sigue en 1e-18. Si un punto no converge, sale `nan` y la pasada es inválida igual que antes; el siguiente paso
  sería dar tensiones iniciales a las islas, con otra enmienda.

Predicciones K1–K8, reglas de decisión e invalidez: las del prerregistro, sin tocar.
