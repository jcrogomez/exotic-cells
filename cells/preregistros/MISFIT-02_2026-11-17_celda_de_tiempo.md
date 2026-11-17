# Prerregistro · MISFIT-02 · una celda física de tiempo conocido, leída por el contador

Escrito el 2026-11-17 14:03 EST (hora de `date`), antes de dibujar la celda. Parte de un paquete de referencia elaborado por un asistente externo
y traído por Juan (`misfit_phase2_reference_bundle.zip`: prerregistro, RC ideal, módulo de captura). Se adopta su pregunta, sus
controles negativos y su exigencia de separar niveles de extracción. Se cambian dos cosas, con su porqué:

- **Sus capacidades (30 y 60 pF con 10 kΩ) no caben.** 30 pF en compuerta de transistor son miles de µm²; la franja libre del
  tile en el brazo B es de 161 × 40,8 µm. Se mantiene la idea (dos tiempos en razón 2 fijados por una capacidad) con otra celda.
- **No se usa su módulo `pulse_width_capture`.** Sería una segunda arquitectura. El instrumento ya cronometra desde que suelta la
  precarga hasta el flanco de la celda ([`instrument/INTERFACES.md`](../../instrument/INTERFACES.md)).

## Pregunta

¿Puede el contador del instrumento recuperar un intervalo fijado por la geometría de una celda dibujada a mano, y se distingue
lo que pone la celda de lo que pone el instrumento (cuantización, captura, alimentación)?

## La celda

Nodo X precargado por un pfet (1,00/0,5) y descargado por un nfet débil (0,42/24); cargado por un condensador MOS (nfet 12 × 12
µm, compuerta en X): uno en el lado A, dos en el lado B. Un inversor (0,65/0,5 y 1,00/0,5, el de MISFIT-01) lee X. Un inversor
igual genera la precarga negada. Puertos: `PRE`, `XA`, `XB`, alimentación y tierra. **No implementa `en` ni `src` del contrato**:
es un control de la cadena de medida, no una ranura completa.

Los tamaños salen de una exploración en esquemático hecha antes de este texto (`instrument/misfit02/sch`, tres pasadas; la
primera daba 50 ns y se descartó por corta). No es predicción: es lo que fija los tamaños.

| Esquemático, tt, 27 °C | A | B | B/A |
|---|---|---|---|
| De `PRE` cayendo a la salida subiendo (0,9 V) | 535 ns | 1045 ns | 1,953 |
| Subida de la salida (10–90 %) | 14 ns | 22 ns | |

## Predicciones

| | Predicción | Falla si |
|---|---|---|
| P1 celda dibujada | DRC 0 en Magic **y** en el deck de fabricación de KLayout; LVS de la celda contra el esquemático coincide, 13 dispositivos (inversor de precarga 2; lado A 5: pfet, nfet débil, un condensador, inversor; lado B 6: lo mismo con dos condensadores) con sus W/L | no coincide o falta un dispositivo |
| P2 extraída, solo dispositivos | t_A y t_B a menos de 5 % del esquemático | fuera |
| P3 extraída con capacidades | t_A y t_B entre 2 % y 15 % **mayores** que en P2; B/A entre 1,90 y 2,00 | fuera |
| P4 conteo | Para cada tiempo extraído t y toda fase del reloj (T = 20 ns): la lectura N cumple \|N·T − t − 2T\| ≤ T. Con t de P3: A da entre 28 y 34 conteos, B entre 54 y 64 | alguna fase fuera |
| P5 cociente recuperado | (N_B − 2)/(N_A − 2) entre 1,88 y 2,04 en todas las fases | fuera |
| P6 unión flanco lento → captura | En SPICE de transistores (salida de la celda extraída → búfer de librería → dos biestables a 50 MHz), con el flanco barrido en 20 fases de un periodo: el segundo biestable da siempre un nivel lógico limpio y el flanco se captura con a lo más un ciclo de diferencia entre fases | un nivel intermedio que llegue al segundo biestable, o más de un ciclo |
| P7 alimentación y temperatura | Sensibilidad a la alimentación menor que 0,2 % por mV (frente a 0,65 %/mV del canal XC-19: aquí se descarga en inversión fuerte). De 27 a 85 °C, t cambia entre +5 % y +40 % | fuera |

P6 no mide metaestabilidad: SPICE determinista no da una tasa de fallos. Dice si la unión hace algo raro de forma sistemática.

## Cómo se prueba la cadena, y qué no se prueba

Simular el tile completo a nivel de transistores durante una adquisición entera no es viable (decenas de miles de dispositivos
por microsegundos). La cadena se prueba **en dos tramos que se componen**: (i) SPICE de la celda extraída del GDS da el instante
del flanco; (ii) el RTL del instrumento, con ese instante puesto en el modelo de ranura y barrido en fase, da el conteo. P6 cubre
la unión entre ambos con un circuito pequeño. **No es una cosimulación**, y así se reportará.

Etapa 2 (después, con su propio resultado): el núcleo del instrumento endurecido aparte y la celda en la franja libre, por la
ruta del brazo B de MISFIT-01, con DRC, LVS propio, precheck y controles negativos. Si no se corre hoy, se dice.

## Controles negativos

| | Qué se hace | Debe ocurrir |
|---|---|---|
| N1 | Celda sin unir a la alimentación (etapa 2) | LVS falla |
| N2 | Doble capacidad (lado B, en el propio layout) y, aparte, netlist de referencia con otra L del nfet débil | t se duplica (P3, P5); LVS marca la propiedad |
| N3 | Salida pegada a 0 y a 1 en el modelo de ranura con los tiempos de la celda | `timeout` y `stuck`, nunca un conteo válido |
| N4 | Ventana más corta que el tiempo de la celda | `timeout`, y al ensanchar la ventana, el conteo de P4 |
| N5 | Esquinas ss y ff, 85 °C, alimentación ±10 mV sobre la celda extraída con capacidades | Se reporta el desplazamiento; decide P7 |

El N4 del paquete (pulso más corto que un periodo de reloj) no aplica tal cual: aquí se cronometra un flanco, no un pulso.

## Niveles de extracción

Solo dispositivos; dispositivos + capacidades; resistencia de interconexión (no alcanzada en MISFIT-01; se intentará o se dirá
que no). Cada tiempo se da con su nivel.

## Criterio de abandono

Cuatro intentos de dibujo hasta DRC limpio en los dos decks. Si P2 falla por más de 20 %, se detiene: el layout no es el
circuito. No se cambian los umbrales después de ver un resultado. XC-19 no se toca.
