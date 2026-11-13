# XC-50 · Emisor por portadores calientes

**Fusionada en XC-26 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-50 de [catálogo](../../README.md#catalogue) (Hot-carrier transistor emitter).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-50 · Emisor por portadores calientes.** Un transistor en saturación emite luz débil a tensión nominal → nfet ancho junto al
fotodiodo de XC-26 → ninguna → fotocorriente por precarga → emisor a 1,8 V sin unión en directa → — → mismo transistor con la misma
potencia en triodo. Señal ≲10 fA (**de memoria**), bajo el piso de 150 fA: improbable sin mejorar el lector.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** El control "mismo transistor en triodo" no separa luz de corriente de sustrato; hace falta otro control (ver secciones 3 y 5).

## 2. Lectura y piso

Lector de precarga y descarga sobre el fotodiodo de XC-26, con el emisor sustituido por un nfet ancho en saturación.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal esperada | ≲ 10 fA (**de memoria**, sin fuente) | sección 1 |
| Piso del lector | ≈ 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz | `macros/photon/LEEME.md`, laboratorio, sin publicar, modelo |
| Piso con ventana larga | ≈ 10 fA con 2²⁴ ciclos (1,68 s), si la fuga del excitador se mantiene como en el modelo `[?]` | idem |
| Fuga del excitador de precarga | 32 fA a 27 °C (`ebufn_1` en Z); el fondo no cruza: el nodo se estanca en 1,36 V | idem |
| Precarga de fuga menor | 0,010 pA con canal largo y umbral alto | `docs/CLAIMS.md`, **corrida** exploratoria |
| Ionización por impacto en el modelo del `nfet_01v8` | Presente (`alpha0` = 3e-8, `beta0` = 13,86): la corriente de sustrato se puede simular | `PESCA_OPTO_1104.md` §1, laboratorio, **PDK** |
| Emisión de luz en el modelo | No existe | — |

Señal/piso (cociente de las cifras de arriba): por debajo de 0,1 con la ventana normal y del orden de 1 con la larga, y
eso con una cifra de memoria. El excitador
de precarga actual fuga más que la señal: sin cambiarlo, no se lee.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Corriente de sustrato: los mismos portadores calientes que emiten generan pares; los huecos van al sustrato | El triodo a igual potencia quita la luz **y** la corriente de sustrato: no las separa. Hacen falta la tapa de XC-27 y la guarda |
| Calor del transistor (disipa mucho más que lo que emite) | El control de la ficha sí sirve aquí: triodo a igual potencia |
| Acoplo de la conmutación del transistor al nodo | Emisor en continua durante la ventana; control a 40 µm |
| Electrones secundarios que llegan al fotodiodo por el sustrato | Guarda de pozo n en inversa entre ambos; distancia; lectura retardada |
| Fuga del lector, que es mayor que la señal | Canal fantasma; tríos intercalados; precarga de canal largo |
| Rebote de masa por la corriente del transistor ancho | El mismo transistor con el drenaje hacia otro lado y la misma corriente de raíl |

## 4. Referencia convencional (control científico, no filtro)

El emisor en directa de XC-26, que también funciona a 1,8 V y del que se espera más luz por miliamperio `[?]`. El transistor
solo gana en que emite sin inyectar minoritarios a propósito (no hay unión en directa) y en que se enciende y apaga con una
puerta lógica; si su fondo de portadores resulta menor que el de la unión en directa, es mejor emisor para XC-27 aunque sea
más débil. Como sensor de portadores calientes, lo convencional es medir la corriente de sustrato con un pin analógico.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente, lo primero: una fuente leída con la emisión de un nfet en saturación a tensión nominal en un nodo cercano a
   130 nm: fotones por electrón y espectro. Hoy la cifra es de memoria. Sin fuente, la predicción es `[?]`.
2. Pendiente: simular la corriente de sustrato del nfet ancho con el modelo del PDK frente a la tensión de puerta, a 1,8 V
   de drenaje, largo mínimo y largos mayores. Es la explicación aburrida y se puede cuantificar hoy. Predicción antes.
3. Pendiente: comparar esa corriente de sustrato con la inyección de la unión en directa de XC-26 a igual potencia.
4. Pendiente: lector con precarga de canal largo y ventana de 2²⁴ ciclos; presupuesto de fondo y de deriva en 1,68 s.
5. Pendiente: dibujar por script el nfet ancho con el drenaje hacia el fotodiodo, respetando la distancia de pozo a fotodiodo
   (4,5 µm, regla nwell.7, que ninguna herramienta comprueba); DRC en los dos decks; extraer y anotar con Residual.
6. Pendiente: comprobar el envejecimiento esperado: la polarización que más emite es la que más degrada (liga con XC-10).

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**. El largo mínimo es 0,15 µm (el del dispositivo de XC-19).

| Barrido | Valores | Pregunta |
|---|---|---|
| Largo de canal | 0,15; 0,25; 0,50 µm | El campo en el drenaje cae con el largo: la emisión debe caer mucho más deprisa que la potencia |
| Ancho total | 5; 20; 80 µm | Emisión proporcional al ancho: comprueba la linealidad y busca salir del piso |
| Dedos frente a un solo ancho | 1 × 20 µm; 4 × 5 µm | Más drenajes por área; la luz sale del borde del drenaje, no del área |
| Lado del drenaje | Drenaje hacia el fotodiodo; fuente hacia el fotodiodo | La emisión es local al drenaje: girar el transistor mueve la fuente de luz y no el calor |
| Polarización de puerta | Tres puntos entre el umbral y 1,8 V, con drenaje a 1,8 V | La corriente de sustrato tiene un máximo a puerta intermedia; la luz debería seguirla, el calor no |
| Tipo | nfet; pfet; nfet de 5 V trabajando a 1,8 V | El pfet y el de óxido grueso deben emitir mucho menos: controles negativos con igual corriente |
| Distancia al fotodiodo | 5; 10; 20 µm | Caída con la distancia, comparada con la de XC-26 |
| Tapa | Sin metal; lisa (XC-27) | Separa luz de corriente de sustrato, que el control de triodo no separa |
| Guarda | Sin; anillo p+ a masa; pozo n en inversa | Cuánto de la señal es sustrato |

Primero un canal: nfet de 20 µm de largo mínimo a 5 µm del fotodiodo, su control en triodo y el lector de ventana larga.

### 5.3 En silicio

1. **Virgen:** fondo de cada fotodiodo con ventana larga; estabilidad del fondo durante minutos.
2. **Calibrar:** corriente de prueba cerca del piso; corriente y potencia del transistor en saturación y en triodo.
3. **Caracterizar:** tríos intercalados (saturación, triodo a igual potencia, apagado) y resta.
4. **Barrer:** tensión de puerta, alimentación (la emisión por portadores calientes depende muy fuerte de la tensión de
   drenaje; entre el mínimo de funcionamiento y 1,8 V debe verse), temperatura.
5. **Retener y repetir:** el transistor envejece en esa polarización: repetir tras horas y anotar su corriente (dato para XC-10).
6. **Clasificar:** luz separada, solo sustrato, solo calor, bajo el piso, fallo de lector.

No hay transformación buscada; el envejecimiento es un efecto lateral que se registra.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** residuo que sigue a la saturación y no al triodo, tiene máximo a puerta intermedia, cae con el largo de canal,
  sobrevive a la guarda y cambia con la tapa.
- **Negativo informativo:** el lector de ventana larga, calibrado a 10 fA, no ve nada con el transistor más ancho.
- **Inconcluso:** residuo que la guarda elimina en parte y que no cambia con la tapa: es sustrato, no luz, o mezcla.
- **Fallo instrumental:** el fondo deriva más que la señal buscada durante la ventana.
- **Muere** si el lector en silicio no alcanza el piso que la fuente del paso 1 diga necesario, o si la corriente de sustrato
  simulada ya explica cualquier señal a todas las distancias.

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

- Depende de mejorar el lector de XC-26 (precarga de baja fuga, ventana larga). Si esa mejora se logra, sirve a todas.
- Depende de XC-27 (tapa) y XC-23 (portadores) como controles; el control de triodo solo no basta.
- Vehículo D. Sin permisos: tensión nominal. La corriente del transistor ancho cuenta frente a la red de alimentación.
- Envejece: avisar en el contrato; comparte medida con XC-10.
- Juzgada improbable a 1,8 V por la búsqueda del 12-nov; queda sin filtrar.

## 8. Abierto y fuentes

- Fotones por electrón y espectro a 1,8 V en este nodo: `[?]`. La única cifra es de memoria.
- Si la corriente de sustrato del modelo es fiable a 1,8 V en largo mínimo: `[?]` (los modelos binados tienen saltos, pesca).
- Si el fotodiodo profundo responde al color de esta emisión `[?]`.
- Fuentes: `macros/photon/LEEME.md`, `docs/pesca/PESCA_OPTO_1104.md` §1 (laboratorio, sin publicar);
  [pesca del 12-nov](../notas/PESCA_2026-11-12.md); [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
