# XC-47 · Discontinuidades del modelo

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-47 de [catálogo](../../README.md#catalogue) (Model discontinuities).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-47 · Discontinuidades del modelo.** El modelo abierto salta en las fronteras de bin y tiene una joroba no física en gm/ID en
subumbral (issue 381 del PDK, **leído por agente**) → anillos con W a ambos lados de una frontera; anillo alimentado por un pfet en
inversión débil → ninguna → frecuencia frente a W, suave en silicio donde el modelo salta → corrección de modelo → — → la predicción
de la simulación es el control. No es celda: es el segundo trabajo de Residual.

## 2. Lectura y piso

No es una celda: es un barrido donde la predicción es el salto del modelo y la hipótesis es que el silicio no salta. Dos
lectores: cociente de anillos para las fronteras de bin, y la etapa en inversión débil de XC-19 para la joroba de gm/ID.

| Cantidad | Valor | De dónde |
|---|---|---|
| Tamaño del salto del modelo en una frontera de bin | `[?]`. No se ha corrido el barrido fino | — |
| Estructura de la tarjeta | `nfet_01v8__tt`: 180 bins; uno de ellos, L 0,15–0,18 µm y W 0,36–0,52 µm | laboratorio, `docs/AUDITORIA_LOD_1111_BORRADOR.md`, lectura del **PDK**, sin publicar |
| Joroba de gm/ID | Descrita para `pfet_01v8` 10/0,15; magnitud `[?]` | issue 381, [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Paso mínimo de W | 5 nm, la rejilla de fabricación | `residual/drc_edge`, **corrida** |
| Lector en inversión débil | 0,83 % por 0,305 mV; factor de pendiente 1,41 | `experiments/xc19_weak_inversion`, **corrida**, solo modelo |
| Piso: desajuste | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15) | `experiments/lod_audit`, **corrida** |
| Piso del cociente de dos anillos | `[?]` sin caracterizar | [`../PLANTILLA.md`](../PLANTILLA.md) |
| Error conocido del modelo en otra condición | ~20 % RMS a 77 K | pesca, **leído por agente** |

Señal/piso: se sabrá con la primera corrida, que es de simulación y se puede hacer hoy. Si el salto del modelo es menor que el
desajuste de una pareja, en silicio no se distingue "salta" de "no salta" sin muchas réplicas, y se dice.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El salto es del simulador o de la forma de medir (convergencia, definición de umbral), no de la tarjeta | Mismo barrido con otro simulador o con otra definición del observable; el salto debe caer justo en el límite del bin |
| El salto es real en el proceso (el ajuste por bins refleja silicio) | Lo decide el silicio: es el resultado negativo informativo |
| La diferencia medida entre W vecinos es desajuste | Réplicas; W en escalera fina: un salto es un escalón entre dos puntos, el desajuste no tiene posición |
| LOD y esquina cambian con W (XC-12, XC-46) | Mismos `sa`/`sb`; ambos efectos son suaves en W y no dan escalón |
| El ancho fabricado no es el dibujado: dos anchos a 5 nm pueden salir iguales | Escalera de varios pasos a cada lado, no solo dos puntos |
| Joroba: fuga, esquina real (XC-46) o ruido del lector a corriente baja | Transistor ancho y estrecho, nfet de control, puerta en anillo de XC-46 |

El control es la simulación misma, escrita antes. Gemelo: una frontera falsa, la misma escalera de anchos en mitad de un bin,
donde el modelo es suave.

## 4. Referencia convencional (control científico, no filtro)

El modelo del PDK tal como se distribuye, con sus esquinas de proceso: es lo que usa todo diseñador. Lo convencional gana si
los saltos y la joroba quedan dentro del margen entre esquinas, porque entonces nadie necesita corregirlos para que un circuito
funcione. Residual gana si señala geometrías concretas donde el modelo se equivoca en más que el desajuste, y propone un valor
medido. No hay componente de biblioteca en juego: se compara un modelo con su silicio.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente, primera corrida: listar las fronteras de bin en W y en L de `nfet_01v8` y `pfet_01v8` desde la tarjeta local.
2. Pendiente: barrer W de 5 en 5 nm a través de cada frontera en simulación (umbral, corriente en inversión débil y fuerte,
   periodo de un anillo). Predicción escrita antes: escalones solo en las fronteras. Resultado: tabla de saltos por frontera.
3. Pendiente: reproducir la joroba de gm/ID del issue 381 en nuestra instalación; anotar en qué corriente y qué anchos aparece.
4. Pendiente: comprobar qué ocurre con una W exactamente en la frontera y con anchos que caen fuera de todo bin.
5. Pendiente: cotejar con los datos crudos del test tile de SkyWater, que barren W y L (**leído por agente**): si esos datos son
   suaves donde el modelo salta, la pregunta está contestada sin fabricar.
6. Pendiente: módulo de Residual que avise cuando un dispositivo de un netlist cae a menos de un paso de una frontera, igual que
   el informe de borde de `drc_edge`.
7. Pendiente: simular un anillo cuya corriente fija un pfet en inversión débil y ver si la joroba se traduce en periodo.

### 5.2 Configuraciones a dibujar

Valores propuestos. Las fronteras exactas salen del paso 1; la única conocida hoy es W = 0,36 y 0,52 µm a L 0,15–0,18.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Escalera de W a través de una frontera | Frontera −20, −10, −5, +5, +10, +20 nm | ¿El silicio es suave donde el modelo da un escalón? |
| Escalera gemela en mitad de bin | Los mismos seis pasos centrados lejos de toda frontera | Control: aquí modelo y silicio deben ser suaves los dos |
| Frontera elegida | La de mayor salto simulado en nfet; la de mayor salto en pfet; la de 0,52 µm por ser la conocida | Empezar donde la señal predicha es mayor |
| Escalera de L | A través de la frontera de 0,18 µm a W fijo | Lo mismo en la otra dimensión; el largo fabricado es menos fiel que el ancho |
| Transistor de la joroba | `pfet_01v8` 10/0,15 (el del issue); 5/0,15; 1/0,15; nfet 10/0,15 | ¿La joroba existe en silicio? ¿Depende del ancho como en el modelo? |
| Punto de trabajo | Corriente del anillo limitado por pfet barrida por la polarización, en pasos finos | gm/ID frente a corriente: la joroba es un máximo local que una exponencial no tiene |
| Dedos | Un dedo en el bin A frente a dos dedos de W/2 que caen en el bin B, mismo ancho total | El modelo los trata distinto; el silicio casi igual: prueba directa del binado |
| Réplicas | Las que fije el desajuste para el salto simulado | Sin este número el barrido no concluye |

Primero un canal completo: una frontera, seis anchos, anillos del mismo macro contra un anillo de referencia.

### 5.3 En silicio

1. **Virgen:** todos los anillos y todas las etapas de la escalera, en orden aleatorio.
2. **Calibrar:** el piso del cociente con anillos idénticos; el escalón de puerta para el lector de inversión débil.
3. **Caracterizar:** observable frente a W dibujado; ajuste suave y residuo en la frontera. Para la joroba, pendiente local
   frente a corriente.
4. **Barrer:** alimentación y temperatura. Un salto del modelo cambia de tamaño con la esquina y la temperatura simuladas; se
   compara la familia entera de curvas, no un punto.
5. **Repetir** otro día.
6. **Clasificar** cada frontera: silicio suave (modelo corregible), silicio con escalón (modelo fiel), inconcluso, fallo.

No hay transformación. El resultado se entrega como tabla de residuos por geometría y, si procede, como informe al PDK.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** en la frontera el silicio es suave dentro de un intervalo menor que el salto simulado, y la escalera gemela se
  comporta igual que la de la frontera. O: la joroba simulada no aparece en la medida.
- **Negativo informativo:** el silicio reproduce el escalón o la joroba. El modelo era fiel y se retira la sospecha.
- **Inconcluso:** el salto simulado es menor que la dispersión entre réplicas.
- **Fallo instrumental:** la escalera gemela no sale suave.
- **Muere** antes de fabricar si el paso 2 de 5.1 muestra saltos por debajo del 1 % del observable en todas las fronteras:
  entonces no merece área, y queda como nota de simulación.

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

- Trabajo de Residual más que de layout: los cuatro primeros pasos no necesitan dibujar nada.
- Comparte el barrido de ancho con XC-46 y los `sa`/`sb` controlados de XC-12; los anillos, con XC-16.
- Necesita macro con transistores de ancho arbitrario (las celdas estándar tienen anchos fijos).
- Sin permisos. Un chip basta si las réplicas caben.

## 8. Abierto y fuentes

- Lista de fronteras y tamaño de cada salto. Magnitud de la joroba. Si la tarjeta se ajustó a silicio por bins independientes.
- Qué hace cada simulador en la frontera exacta.
- Fuentes: issue 381 y datos crudos en la [pesca](../notas/PESCA_2026-11-12.md); [`residual`](../../residual/README.md);
  [`residual/drc_edge`](../../residual/drc_edge/README.md). Planes ligados: [XC-46](../xc46_corner_fet/PLAN.md),
  [XC-12](../xc12_lod_stress/PLAN.md).
