# MISFIT-15 · XC-20: qué tensión ve la unión en su puesto y si la selección aísla

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit15/PREREG_SHA256.txt`), **antes** de escribir los decks y sin
haber leído las corrientes de fuga de los modelos de diodo del PDK. Primera mitad de C4 (corriente esperada por celda frente
a los lectores). Plan de la familia: [`cells/xc20_abutted_junction/PLAN.md`](../xc20_abutted_junction/PLAN.md). Celdas:
[MISFIT-14](../../experiments/misfit14/RESULTADOS.md).

## Pregunta

El puesto dibujado en MISFIT-14 (topología **A**) pone el interruptor nfet 0,84/0,15 **entre X y la isla n+**; el ánodo es el
sustrato. Un nfet con la puerta a 1,8 V no pasa 1,8 V. Dos preguntas de circuito, que el modelo sí puede contestar:

1. ¿Qué tensión inversa ve la unión cuando su puesto está seleccionado?
2. ¿Un puesto no seleccionado deja de contar? Para una celda que conduce como un diodo ordinario, la fuga del interruptor
   abierto puede ser mayor que la de la unión, y entonces "seleccionar" no selecciona nada.

Control: la topología **B**, la de la variante en pozo n aún sin dibujar: pozo n (cátodo) directo en X, isla p+ (ánodo) con el
interruptor **entre la isla y GND**, como en los puestos de XC-19.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| El modelo no tiene túnel: cualquier corriente "de túnel" la pongo yo | Se dice: la corriente se inyecta con un elemento I = I0·(V/1,8)ⁿ para V > 0, con n = 1 (puente óhmico) y n = 3 (forma empinada). Dos formas, no una medida |
| El banco no lee lo que inyecto | Testigo K7 |
| Las direcciones de K2–K5 se deducen de lo ya sabido (caída de umbral de un nfet de paso; fuga de subumbral mayor que la de un diodo) | Declarado: lo que la corrida añade es el **tamaño** en 4 esquinas, no la dirección |
| La fuga del pozo en B depende de un pozo que no está dibujado | Supuesto declarado: pozo compartido de 28 × 4 µm (112 µm², 64 µm) para 7 puestos, modelo `sky130_fd_pr__model__parasitic__diode_ps2nw`. Si el modelo no carga, B se corre sin pozo y se dice |

## Corridas (todas son puntos de operación DC; 4 esquinas: tt 27, ff −40, ss 85, ff 85)

Un puesto por instancia, con su propia fuente en X (se mide la corriente I_X que sale de ella). gmin = 1e-18.

- Topologías A y B × X ∈ {1,8; 0,9} V × seleccionado/no seleccionado ×
  {I0 = 0; n = 1 con I0 ∈ 1 pA, 100 pA, 10 nA, 1 µA, 10 µA; n = 3 con los mismos cinco}. 2 × 2 × 2 × 11 = 88 instancias por esquina.
- Diodo suelto del PDK (`diode_pw2nd_05v5`, 1,4 µm², 4,8 µm, lo que extrae MISFIT-14) a 1,8 V en inversa, y el de B
  (`diode_pd2nw_05v5`, mismo tamaño).
- Bus de 7 puestos con I0 = 0 (A tal como se extrajo; B con el pozo supuesto): todos abiertos, y uno cerrado.

V_j es la tensión cátodo − ánodo de la unión. Las bandas se aplican a cada esquina por separado.

## Predicciones

| # | Predicción |
|---|---|
| K1 | El diodo del PDK da menos de 100 pA a 1,8 V en las 4 esquinas (apuesta: < 1 pA a 27 y −40 °C). Si se cumple, una celda que se porte como diodo ordinario queda bajo el rango bajo del lector 2 |
| K2 | A, seleccionado, X = 1,8 V, n = 1, I0 = 1 µA: V_j entre 0,85 y 1,30 V en las 4 esquinas |
| K3 | A, seleccionado, X = 1,8 V, n = 1, I0 = 10 nA: V_j < 1,45 V en las 4 esquinas |
| K4 | B, seleccionado, X = 1,8 V, n = 1: V_j ≥ 1,75 V con I0 ≤ 1 µA y ≥ 1,60 V con 10 µA, en las 4 esquinas |
| K5 | Sin aislamiento para celdas ordinarias: con I0 = 0 y X = 1,8 V, I_X(no seleccionado) / I_X(seleccionado) ≥ 0,5 en las dos topologías y las 4 esquinas |
| K6 | Con aislamiento para celdas que conducen: n = 1, I0 = 1 µA, X = 1,8 V, I_X(no sel.) / I_X(sel.) ≤ 1·10⁻³ a tt 27 y ff −40, y ≤ 3·10⁻² a ss 85 y ff 85, en las dos topologías |
| K7 (testigo) | B, seleccionado, X = 1,8 V, n = 1, I0 = 100 nA (instancia añadida solo para esto): I_X entre 97 y 103 nA a tt 27. **Mutante:** la misma instancia con I0 = 0 da menos de 1 nA a tt 27 |
| K8 | A, seleccionado, X = 1,8 V, n = 3, I0 = 1 µA: I_X / I0 entre 0,12 y 0,35 en las 4 esquinas |

## Qué se hace con cada resultado

- **K2 cumplida** (la unión no ve los 1,8 V de la ficha): la variante en pozo n con el interruptor abajo (B) pasa a ser la
  principal y es lo siguiente que se dibuja; A se queda como control de polaridad, con su tensión real declarada.
- **K2 falsa por arriba** (V_j > 1,30 V): A vale como está.
- **K5 cumplida:** un bus compartido con selección **muere** para las celdas de d ≥ 0,27 µm y la celda sin unión, mientras se
  porten como diodo ordinario. Esas celdas necesitan otra lectura (suma del bus contra un bus gemelo, o nodo propio); elegir
  cuál es diseño siguiente, no veredicto de esta prueba.
- **K1 falsa:** las celdas ordinarias entran en el lector 2 y K5 pierde importancia.
- **Inválido** si falla K7 o su mutante, o si algún punto de operación no converge.

## Qué no dice esta prueba

La magnitud del túnel ni su forma con la tensión: I0 y n los pongo yo. Tampoco si d = 0 es unión o cable. Solo acota el lado
del circuito: qué polarización recibe la unión y qué parte del bus es fondo.
