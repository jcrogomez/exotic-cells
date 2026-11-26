# MISFIT-15 · enmienda 2 · tampoco converge punto a punto: equilibrio por barrido

Escrita el 2026-11-26 (hora de sellado en `experiments/misfit15/PREREG_SHA256.txt`), **después** de la segunda pasada y
**antes** de la tercera.

## Qué pasó (se queda en `experiments/misfit15/pasada2/`)

Con un puesto de cada clase y un punto de operación por combinación, los decks llegaron al tope de 600 s (salida 124) con
35 a 51 líneas de 95. A tt 27 **ningún** punto converge ("transient op failed, timestep too small"); a ff 85 convergen los
primeros con el puesto seleccionado y fallan los no seleccionados. **Inválida.** De esta pasada solo miré qué líneas traían
valor y cuáles no; ningún valor.

Lectura (inferencia, no demostrada): el fallo va con las islas flotantes cuando todo lo que las ata es una fuga de fA o
menos. Es un problema del resolvedor, no del circuito.

## Qué cambia

El equilibrio de la isla deja de buscarlo el resolvedor:

- Cada isla lleva una fuente de tensión propia. Se barre de 0 a 1,8 V en pasos de 2 mV (`dc`), con X, la puerta e I0
  fijos. Todos los nodos están forzados, así que no hay nada que converger.
- El equilibrio es la tensión de isla donde la corriente de esa fuente cambia de signo (interpolación lineal entre los dos
  puntos vecinos, `equilibrio.py`). V_j e I_X se leen ahí. Si no hay cambio de signo o hay más de uno, sale `nan` y la
  pasada es inválida.
- **Los buses pasan a ser aritmética** sobre puestos sueltos: todos abiertos = 7 × I_X(no sel., I0 = 0); uno cerrado =
  6 × I_X(no sel.) + I_X(sel.); en B se suma la fuga del diodo de pozo supuesto, medida suelta a 1,8 V. Pierdo la
  comprobación con el subcircuito extraído de MISFIT-14; los dispositivos son los mismos.
- El analizador lee `k.txt` (salida de `equilibrio.py`) en vez del log. Bandas y veredictos, los mismos.
- Tope: 600 s por deck, como antes.

**Límite nuevo, declarado:** la resolución de V_j es la de la malla, 2 mV antes de interpolar. Las bandas de K2–K4 están a
decenas de mV de cualquier valor que espero, pero si un veredicto cae a menos de 5 mV de su borde se dice "no decidible".

Predicciones K1–K8 y reglas de decisión: las del prerregistro, sin tocar.
