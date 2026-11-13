# XC-49 · Impactos de partículas

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-49 de [catálogo](../../README.md#catalogue) (Particle strikes on dynamic nodes).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-49 · Impactos de partículas.** Una partícula deposita carga en un nodo → arreglo de nodos dinámicos de carga mínima → ninguna →
cuenta de volteos → detector de radiación → — → nodos de carga grande como control. Tasa ~10⁻⁹ eventos/h con 1 kbit (**sin leer**):
no observable con un chip. Se conserva por la regla de no borrar.

## 2. Lectura y piso

Se lee como cuenta de volteos: nodos dinámicos precargados que se comprueban y se recargan a intervalos fijos. Un impacto es un
nodo que cae de golpe, una vez. No pide lector nuevo: es otro análisis sobre el arreglo de XC-37.

| Cantidad | Valor | De dónde y grado |
|---|---|---|
| Tasa esperada | ~10⁻⁹ sucesos por hora con 1 kbit | ficha, fuente **sin leer** |
| Carga para voltear el nodo del lector de precarga | 12,5 fC (12,4 fF hasta el umbral del `inv_1`): unos 7,8·10⁴ electrones | `macros/photon/LEEME.md`, laboratorio, **sin publicar**; electrones por **cálculo** (Q/q) |
| Nodo más pequeño simulado | 2,0 fF en la etapa de XC-19 sin condensador | `experiments/xc19_weak_inversion` (`stage.txt`), **corrida** |
| Carga que deposita una partícula en la unión | `[?]` | — |
| Tasa de sucesos falsos del propio arreglo | `[?]`; es el piso real y solo se conoce midiendo | — |

- **Señal/piso:** con la tasa de la ficha, un chip no ve ningún suceso en ningún tiempo razonable. La razón señal/piso es
  nula por tiempo de exposición, no por sensibilidad. Se dice aquí como manda la regla 2.
- **Lo que sí da:** una cota superior de sucesos espontáneos por nodo y hora. Esa cota es útil para XC-19 y XC-37: acota cuántos
  saltos aislados pueden atribuirse a algo que no sea el dispositivo.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Transitorio de alimentación o de reloj | Voltea muchos nodos a la vez: criterio de multiplicidad. Canal XC-32 |
| Fuga: el nodo cae solo | Es gradual y se repite en la misma celda; un impacto es brusco y no se repite. Intervalo de comprobación mucho más corto que la descarga |
| Defecto que conmuta la fuga (XC-37) | Vuelve en la misma celda con los mismos niveles |
| Descarga electrostática o manipulación de la placa | Registro de hora y de actividad en la mesa; sucesos en nodos de control |
| Error del contador o de la lectura serie | Biestables estáticos `dfxtp_1` en el mismo arreglo y con la misma lectura: no deben voltear |
| Sensibilidad no demostrada | El control de la ficha: nodos de carga grande. Y un control positivo: inyección de carga conocida por un condensador pequeño conmutado |

Sin el control positivo de inyección, cero sucesos no informa de nada.

## 4. Referencia convencional (control científico, no filtro)

Como detector: un tubo o un diodo detector externo, fuera del chip. Dentro del flujo digital, el monitor habitual es un arreglo de
biestables o de memoria estática que se relee. El nodo dinámico solo gana si su carga crítica es mucho menor que la de un biestable
de biblioteca (la del biestable, `[?]`) y eso se traduce en más sucesos por área. Con la tasa de la ficha ninguno de los dos ve
nada en un chip encapsulado: lo convencional empata a cero.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: leer la fuente de la tasa (**sin leer**) y rehacer la cuenta con el área de unión y la carga crítica de aquí.
   Mientras tanto la cifra de la ficha es lo único que hay.
2. Pendiente: buscar la emisión alfa del encapsulado y del metal que usa Tiny Tapeout `[?]`; no se halló ninguna fuente.
3. Pendiente: calcular la carga crítica de cada nodo de 5.2 desde la extracción, y simular la inyección de un pulso de carga:
   qué carga voltea el nodo y cuál no. Predicción escrita antes.
4. Pendiente: definir el control positivo (condensador conmutado) y su carga mínima realizable con parásitos extraídos.
5. Coste de layout: ninguno propio si se reutiliza el generador del nodo de XC-37 y el lector de precarga.
6. Pendiente: qué demostraría que es inobservable: con N nodos y T horas sin sucesos, la cota superior es del orden de 1/(N·T)
   (**cálculo**, estadística de cero cuentas); se compara con la tasa de la fuente.

### 5.2 Configuraciones a dibujar

Todas las dimensiones son **propuesta**; bordes legales, los de XC-37 ([`residual/drc_edge`](../../residual/drc_edge/README.md)).

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Capacidad del nodo | Mínima alcanzable, ~2 fF, ~12 fF, ~133 fF (puntos ya simulados en otras familias) | La tasa debe caer al subir la carga crítica; el nodo grande es el control de la ficha |
| Área de la unión colectora a capacidad igual | Unión mínima más condensador, frente a unión grande | Separa volumen sensible de carga crítica |
| Perímetro frente a área de la unión | Cuadrado frente a tira | ¿Recoge por el fondo o por el borde? Compartido con XC-37 |
| Polaridad y pozo | n+ en pozo p; p+ en pozo n; n+ en pozo p aislado por pozo profundo | El pozo corta la recogida desde el sustrato; el pozo profundo tiene reglas propias (ancho 3,0 µm, laboratorio) |
| Distancia entre nodos vecinos | Mínima legal, ×3, ×10 | Sucesos dobles: una traza reparte carga entre vecinos; distingue partícula de ruido común |
| Metal encima | Nodo descubierto frente a nodo bajo placa de met1–met4 | Control: el metal no frena partículas energéticas, pero sí cambia el acoplo capacitivo |
| Biestables estáticos intercalados | Uno por grupo | Control de lectura |
| Tamaño del arreglo | Tantos nodos como deje XC-37, N `[?]` | Exposición: sucesos ∝ N·T |

Primero un canal completo: un nodo mínimo, uno grande, un biestable y el inyector de carga.

### 5.3 En silicio

1. **Virgen:** todos los nodos mantienen el dato durante un intervalo de comprobación; se fija ese intervalo frente a la fuga.
2. **Calibrar:** inyección de carga conocida; umbral de volteo de cada tamaño de nodo.
3. **Caracterizar:** exposición larga, sin tocar la placa, con registro de hora, temperatura y alimentación por suceso.
4. **Barrer:** nada que acelere dentro del vehículo. Una fuente alfa externa no atraviesa el encapsulado (**de memoria**) y Tiny
   Tapeout no entrega dados sin encapsular ([pesca](../notas/PESCA_2026-11-12.md), **leído por agente**).
5. **Repetir:** las exposiciones se suman; el arreglo puede quedar contando mientras se miden otras familias.
6. **Clasificar** cada suceso: único y brusco en nodo pequeño (candidato), múltiple (alimentación), repetido en la misma celda
   (fuga o XC-37), en biestable (lectura).

Vehículo que espera: dado accesible o haz de partículas en una instalación; ninguno está en la escalera actual.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** sucesos únicos en nodos pequeños, ausentes en los grandes y en los biestables, con tasa que escala con el área de
  unión. Con la tasa de la ficha sería una sorpresa y habría que desconfiar primero.
- **Negativo informativo:** cero sucesos en N·T conocido, con el control de inyección visto: cota superior publicada.
- **Inconcluso:** sucesos que no se separan de la alimentación o de la manipulación.
- **Fallo instrumental:** la inyección de control no voltea el nodo, o los biestables voltean.
- **Muere como detector** en este vehículo si la cota alcanzable en la vida del experimento queda órdenes por encima de la tasa
  esperada: es lo previsto. No muere como control ni como cota para XC-19 y XC-37.

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

- No pide área propia: vive en el arreglo de XC-37 y en su lector. Si XC-37 no entra, esta tampoco.
- Sirve a XC-19 y XC-37 como cota de sucesos espontáneos; usa XC-32 para el criterio de multiplicidad.
- Un chip, un encapsulado, sin fuente: el vehículo actual solo da la cota. Detector real: otro vehículo.
- Sin permisos. Se conserva por la regla de no borrar; el filtro final decidirá con la cota en la mano.

## 8. Abierto y fuentes

- Fuente de la tasa: **sin leer**. Juicio de un agente en la [pesca](../notas/PESCA_2026-11-12.md): improbable a 1,8 V y con
  un chip.
- Emisión alfa del encapsulado `[?]`; carga depositada por suceso `[?]`; carga crítica de un biestable de la biblioteca `[?]`.
- Si el intervalo de comprobación puede ser a la vez corto frente a la fuga y largo frente al coste de lectura.
- Corridas: [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md). Laboratorio, sin publicar:
  `macros/photon/LEEME.md`. Arreglo y lector: [`xc37_retention_time`](../xc37_retention_time/PLAN.md).
