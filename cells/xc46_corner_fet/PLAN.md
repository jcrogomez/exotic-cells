# XC-46 · Transistor de esquina del aislamiento

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-46 de [catálogo](../../README.md#catalogue) (Isolation-corner transistor).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-46 · Transistor de esquina del aislamiento.** El campo se concentra en el borde del aislamiento y forma un segundo canal →
transistores de ancho mínimo frente a anchos, con y sin dedos → ninguna → corriente en inversión débil → segundo umbral fijado por
layout → lector de XC-19 → ancho barrido a largo fijo. Parte está ya en el modelo: más control de XC-12/13 que celda.

## 2. Lectura y piso

Lector en inversión débil de XC-19, que es donde un segundo canal de umbral más bajo pesa más. La firma no es un número sino
una forma: la corriente por unidad de ancho frente a la tensión de puerta deja de ser una sola exponencial.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal: corriente extra del canal de esquina en SKY130 | `[?]`, ninguna fuente leída | — |
| Lo que el modelo ya contiene de ancho estrecho | Umbral 0,774 V (W = 0,42) frente a 0,708 V (W = 5), por defecto | laboratorio, `macros/grabado_lod/LEEME.md`, **corrida**, sin publicar; la fila de W = 0,42 también en `experiments/lod_audit` |
| Pendiente de referencia | Factor de pendiente 1,41; n·kT/q = 36,5 mV | `experiments/xc19_weak_inversion`, **corrida**, solo modelo |
| Sensibilidad del lector | 0,83 % del tiempo por 0,305 mV | mismo |
| Piso: desajuste | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15) | `experiments/lod_audit`, **corrida** |
| Ventana de polarización del lector | 0,25 a 0,45 V de puerta | plan de [XC-19](../xc19_single_trap/PLAN.md) |

Señal/piso: desconocida. El modelo binado ya ajusta el umbral por ancho, así que una diferencia de umbral entre estrecho y ancho
no demuestra nada. Lo que el modelo no puede dar es una corriente que escale con el número de bordes y no con el ancho.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Efecto de ancho estrecho ya modelado (cada bin tiene su umbral) | Predicción de simulación por ancho, anotada; solo cuenta el residuo |
| LOD: el coeficiente depende de W (31,1 frente a 44,1 mV, **corrida**) | `sa`/`sb` idénticos en todos los anchos; anotar y descontar |
| Desajuste, mayor en el estrecho | Dedos: muchos estrechos en paralelo promedian el desajuste y conservan los bordes |
| La joroba no física del modelo (issue 381) se toma por esquina real, o al revés | Es de XC-47: comparar la forma medida con la simulada en el mismo barrido; la del modelo no escala con los bordes |
| Fuga de unión o del lector a corriente baja | Gemelo ancho de igual área de drenaje; fantasma del lector |
| Resistencia de acceso distinta entre un dedo ancho y muchos estrechos | En inversión débil la corriente es demasiado baja para que importe; comprobarlo a dos corrientes |

Gemelo que constituye el experimento: un transistor sin esquina. Puerta en anillo cerrado, con el drenaje dentro: el canal no
toca el aislamiento en ningún punto. Legalidad y extracción por comprobar; Residual aún no lee puertas dobladas.

## 4. Referencia convencional (control científico, no filtro)

Para tener un segundo umbral: las variantes lvt y hvt del PDK, y dos transistores en paralelo de distinto tipo, que dan
exactamente "dos umbrales fijados por diseño" con modelo. Para corriente de fuga baja: el transistor ancho o largo. El canal de
esquina no gana como función salvo que su umbral resulte gobernable por la geometría del borde con menos dispersión que el
desajuste, lo que es improbable. Su valor es de control: dice cuánto de lo que XC-12, XC-13 y XC-19 miden en transistores
estrechos viene del borde. Lo convencional gana por defecto y el plan lo acepta.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: simular la corriente por unidad de ancho frente a la tensión de puerta en inversión débil para los anchos del
   barrido, con el modelo tal cual. Predicción antes: curvas paralelas, desplazadas por el umbral de cada bin, sin segundo tramo.
2. Pendiente: leer el issue 381 nosotros (hoy **leído por agente**) y separar qué anchos y tipos afecta.
3. Pendiente: buscar en los datos crudos del test tile transistores estrechos medidos en subumbral; si la joroba de esquina
   existe en este proceso, puede estar ya en esos datos.
4. Pendiente: ancho mínimo legal de difusión bajo puerta y legalidad de la puerta en anillo, con `residual/drc_edge`.
5. Pendiente: leer una fuente sobre el canal de esquina en aislamiento de zanja a 130 o 180 nm `[?]`.
6. Pendiente: ampliar el anotador a dedos (`sd`) para que los `sa`/`sb` del barrido queden controlados.
7. Pendiente: generador de la matriz, DRC en los dos decks, extracción, anotación y simulación con el lector de XC-19.

### 5.2 Configuraciones a dibujar

Valores propuestos, a largo fijo. Ancho mínimo usado hasta ahora: 0,42 µm; el borde legal exacto, por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Ancho W, un dedo, L = 0,15 | 0,42; 0,65; 1,0; 2,0; 5,0 µm | Corriente = a·W + b: el corte b es la corriente de los dos bordes |
| Dedos a ancho total constante (≈ 5 µm) | 1 × 5; 2 × 2,5; 5 × 1; 12 × 0,42 | Mismo ancho, de 2 a 24 bordes: perímetro frente a área. Es la prueba central |
| Largo L, W = 0,42 | 0,15; 0,50; 1,0; 4,0 µm | En canal largo no hay efectos de canal corto que enmascaren la joroba |
| Sin esquina | Puerta en anillo de ancho equivalente a 5 µm | Gemelo sin borde: la diferencia con 12 × 0,42 es todo borde |
| Extensión del poly sobre el aislamiento | Mínima legal (por buscar); ×2; ×4 | ¿El campo de la esquina depende de cuánto poly la envuelve? |
| Forma del borde de la difusión | Recto; con muesca bajo la puerta; en escalón | Esquinas convexas y cóncavas concentran el campo de forma distinta |
| Tipo | nfet; pfet; hvt | El dopado del borde difiere por tipo; la joroba del modelo es sobre todo de pfet |
| Cuerpo | pfet en pozo propio con el pozo a VDD y a una tensión menor | El canal de esquina tiene otro efecto de cuerpo: separa los dos canales sin cambiar el layout |

Primero un canal completo: 12 × 0,42 frente a 1 × 5 en el mismo lector, con `sa`/`sb` iguales.

### 5.3 En silicio

1. **Virgen:** tiempos de descarga de cada estructura en toda la ventana de puerta, en pasos finos.
2. **Calibrar:** escalón de puerta y corriente de prueba de XC-19.
3. **Caracterizar:** pendiente local frente a tensión de puerta para cada estructura; regresión de la corriente frente a ancho y
   frente a número de bordes.
4. **Barrer:** temperatura. Dos canales con umbrales distintos se separan mejor en frío; con calefactor (XC-31) solo se puede
   subir, y entonces la joroba debe atenuarse. Polarización de pozo en el pfet.
5. **Repetir** otro día.
6. **Clasificar:** segundo canal que escala con los bordes, una sola exponencial dentro del piso, inconcluso, fallo de lector.

No hay transformación.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** término de corriente proporcional al número de bordes, ausente en la puerta en anillo, con pendiente o umbral
  propios, y que la simulación anotada no reproduce.
- **Negativo informativo:** la corriente escala solo con el ancho dentro de un límite conocido. Conclusión: los transistores
  estrechos de las otras familias no llevan canal de esquina apreciable, y el modelo binado basta.
- **Inconcluso:** diferencias que la anotación de LOD explica, o del tamaño del desajuste.
- **Fallo instrumental:** el lector no resuelve el escalón de calibración.
- **Muere como celda** casi con seguridad; como control muere solo si el lector de XC-19 no llega al silicio.

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

- Comparte macro, lector y alimentación con XC-12, XC-13 y XC-19; no pide área propia más allá de sus estructuras.
- Depende de Residual (dedos) y se cruza con XC-47 en el mismo barrido de ancho: se dibujan una sola vez para las dos.
- Control de XC-12/13 (ancho) y de XC-18 (¿el canal de campo vive en la esquina?).
- Sin permisos. Un chip basta para la ley de escala con bordes.

## 8. Abierto y fuentes

- Si este proceso tiene joroba de esquina medible `[?]`. Legalidad de la puerta en anillo `[?]`.
- Qué parte del efecto de ancho del modelo es física de borde ajustada como umbral.
- La [pesca](../notas/PESCA_2026-11-12.md) la agrupa con XC-13 en los "umbrales fijados por layout" (juicio de un agente).
- Fuentes: [`experiments/lod_audit`](../../experiments/lod_audit/README.md),
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md), plan de [XC-47](../xc47_model_gaps/PLAN.md).
