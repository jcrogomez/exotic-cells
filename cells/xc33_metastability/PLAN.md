# XC-33 · Metaestabilidad y entropía

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-33 de [catálogo](../../README.md#catalogue) (Metastability and entropy).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-33 · Metaestabilidad y entropía.** Resolución de un biestable → sincronizadores con dato y reloj coincidentes → ninguna → tasa
de fallos, entropía → generador aleatorio → — → mismo par con dato estable. **Mantener como referencia convencional:** es contra lo
que XC-19 debe ganar.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-33:** ruta de datos de retardo graduado hasta violar el tiempo de retención.

## 2. Lectura y piso

Es la referencia convencional de entropía: todo en celdas estándar. Se lee con contadores, sin instrumento analógico.

| Cantidad | Valor | De dónde |
|---|---|---|
| Observable | Fracción de unos, rachas, autocorrelación; tasa de fallos de un sincronizador frente a tiempo de resolución | cuentas digitales |
| Piso | Estadístico: el del número de muestras; no hay piso de lectura | — |
| Constante de resolución y ventana de metaestabilidad de `dfxtp_1`, `dfrbp_1`, `dlxtp_1` | `[?]`; no están en ninguna corrida | — |
| Jitter de un anillo de celdas | `[?]`; el periodo de un anillo de siete `inv_1` extraído es 397,7 ps | `experiments/stdcell_lod` (`rings.txt`), **corrida** |
| Desajuste que sesga el resultado | σ de umbral 17,3 mV (0,42/0,15) y 5,13 mV (5/0,15); los transistores de las celdas, `[?]` | `experiments/lod_audit`, **corrida** |
| Paso de retardo disponible para barrer dato contra reloj | `[?]` (vernier de XC-34) | — |

Señal/piso: sin las dos primeras incógnitas no se puede decir si la ventana metaestable se alcanza con el paso de retardo
disponible. Si la ventana es mucho más estrecha que el paso, el biestable decide siempre igual y la fuente es el jitter, no
la metaestabilidad: son dos mecanismos y se miden por separado.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Batido determinista entre anillo y reloj: parece azar y es periódico | Arrancar muchas veces desde reset y comparar secuencias: lo determinista se repite. Espectro de la secuencia |
| El desajuste decide siempre el mismo valor | Barrido fino de retardo: debe existir un tramo donde la fracción de unos pasa de 0 a 1; su anchura es la medida |
| La entropía viene del ruido de alimentación, no del dispositivo | Dos fuentes vecinas: si sus bits están correlacionados, la causa es común. Canal XC-32 |
| Deriva térmica mueve el punto de equilibrio | Canal XC-31; realimentación lenta del retardo y registrar su consigna |
| Fallo de temporización de la lógica que cuenta | El control de la ficha: mismo par con dato estable, debe dar cero fallos |
| Un generador pseudoaleatorio daría las mismas estadísticas | LFSR al lado, pasado por las mismas pruebas: lo que no lo distinga no cuenta como evidencia de entropía física |

Una simulación sin ruido decide siempre y una vez (criterio 5 abierto en `experiments/xc19_weak_inversion`): la simulación no
puede dar entropía, solo ventanas y constantes.

## 4. Referencia convencional (control científico, no filtro)

Esta familia **es** el componente convencional de XC-19 como fuente de bits. A su vez se compara con un LFSR de celdas estándar
(determinista, sin entropía) y con el generador del microcontrolador de la placa. Lo que hay que tabular para que XC-19 pueda
perder o ganar contra ella: bits por segundo, sesgo, área, sensibilidad a temperatura y alimentación, y si la tasa se gobierna.
La trampa solo gana en lo último; un biestable no ofrece una tasa gobernada por polarización.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: buscar en los `.lib` del PDK lo que haya de `dfxtp_1` y `dfrbp_1` (establecimiento, retención); la constante de
   resolución no suele figurar `[?]`.
2. Pendiente: simular en ngspice el biestable extraído y anotado con dato y reloj barridos en pasos finos: ventana y constante de
   resolución, con predicción escrita antes. Las celdas ya están extraídas y anotadas (`experiments/stdcell_lod`, 415 de 437).
3. Pendiente: Monte Carlo de desajuste del mismo banco: cuánto se desplaza la ventana entre réplicas.
4. Pendiente: jitter de anillo con ruido transitorio, como se hizo para el ruido de disparo (`experiments/xc19_noise`); cuesta
   minutos por milisegundo simulado.
5. Pendiente: RTL con `keep` y colocación fija. Lección de EFLD-00: los modelos funcionales tienen retardo cero y el anillo cuelga
   la simulación de compuertas; hace falta SDF o celdas con retardo.
6. Pendiente: definir la batería estadística y el número de bits antes de ver datos (prerregistro).

### 5.2 Configuraciones a dibujar

Son celdas de biblioteca: lo que se "dibuja" es selección de celda, colocación fija y longitudes. Todo es **propuesta**.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Retardo dato–reloj | Línea graduada (XC-34) en el paso más fino disponible, a ambos lados de cero | Anchura de la ventana; incluye la configuración añadida: violar la retención |
| Etapas de sincronizador tras el biestable | 1, 2, 3 | Tasa de fallos frente a tiempo de resolución: la pendiente da la constante del biestable |
| Tipo de biestable | `dfxtp_1`, `dfrbp_1`, `dlxtp_1`, par de `nand2` cruzadas | ¿Cuál tiene la ventana más ancha y cuál resuelve antes? |
| Carga en el nodo interno o en la salida | Abanico 1, 4, 16 | ¿Más capacidad alarga la resolución? |
| Colocación del par | Contiguo y espejado, contiguo sin espejar, separado 50 µm | Sesgo por gradiente y por orientación (liga con XC-16) |
| Entorno de difusión | Celda en medio de fila frente a extremo de fila | ¿El LOD de la vecindad sesga el par? (liga con XC-12) |
| Longitud del anillo de jitter | 3, 7, 13 etapas | Jitter acumulado frente a periodo; 13 es el anillo de EFLD |
| Réplicas | Tantas como quepan, N `[?]` | Dispersión del sesgo entre fuentes nominalmente iguales |

Primero un canal completo: un biestable, su línea de retardo, dos sincronizadores y los contadores.

### 5.3 En silicio

1. **Virgen:** fracción de unos de cada fuente con el retardo en su valor central.
2. **Calibrar:** el control de dato estable (cero fallos) y el LFSR por la misma cadena de conteo.
3. **Caracterizar:** barrido de retardo completo; curva de fracción de unos; tasa de fallos por etapa de sincronizador.
4. **Barrer:** alimentación, temperatura, frecuencia de reloj. Anotar cuánto se desplaza la ventana por mV y por K.
5. **Repetir:** reinicios repetidos (¿la secuencia diverge?); mismo punto otro día.
6. **Clasificar** cada fuente: entropía física (secuencias que divergen, sin correlación con la vecina ni con XC-32), determinista
   (se repite o bate), sesgada fija, fallo de conteo.

Sin transformación ni permisos.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** existe un tramo de retardo con fracción de unos intermedia, las secuencias divergen entre reinicios, dos fuentes
  vecinas no están correlacionadas y la tasa de fallos cae con cada etapa de sincronizador.
- **Negativo informativo:** el paso de retardo más fino salta de todo ceros a todo unos. La ventana es menor que el paso: se
  informa la cota y queda el jitter como única fuente.
- **Inconcluso:** bits que pasan las pruebas pero correlacionan con el canal de alimentación.
- **Fallo instrumental:** el control de dato estable da fallos, o el LFSR no sale idéntico a su simulación.
- No muere: es referencia. Si no da entropía utilizable, XC-19 se compara solo con el jitter de anillo y con el LFSR.

## 6. Documentación para graduarse

- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC limpio en Magic (reglas completas) y en KLayout (deck completo, comprobaciones de front-end activas)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Netlist anotado con Residual
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] Referencia convencional, donde ayude a identificar el mecanismo
- [ ] README en inglés

## 7. Compuertas y dependencias

- Es el punto de comparación de XC-19 y del consumidor de bits probabilísticos de XC-36.
- Depende de XC-34 (línea de retardo graduada) y de los canales XC-31 y XC-32.
- Sin permisos. Todo en flujo digital; pide colocación fija y celdas con `keep`.
- Un chip basta para la curva; la dispersión entre chips pide más de uno (pregunta abierta de la pesca).

## 8. Abierto y fuentes

- Constante de resolución y ventana de los biestables de `sky130_fd_sc_hd`: `[?]`.
- Si el paso de retardo alcanzable con celdas resuelve la ventana `[?]`.
- Casi nadie publica medidas de sus generadores en Tiny Tapeout ([pesca](../notas/PESCA_2026-11-12.md), lecciones): el banco de
  medida se planea antes del envío.
- Corridas: [`experiments/stdcell_lod`](../../experiments/stdcell_lod/README.md),
  [`experiments/xc19_noise`](../../experiments/xc19_noise/README.md). Contra: [`xc19_single_trap`](../xc19_single_trap/PLAN.md).
  Lección de simulación: `local_flow/efld_00/LEEME.md` (laboratorio, sin publicar).
