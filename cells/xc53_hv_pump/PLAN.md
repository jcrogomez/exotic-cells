# XC-53 · Bomba de carga de alta tensión

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-53 de [catálogo](../../README.md#catalogue) (High-voltage charge pump).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12. Los números de este archivo son
**cálculo** con constantes de memoria salvo donde se cita otra cosa; ninguno está verificado contra fuente ni simulado.

## 0. Primeros principios

Las familias que archivé como "espera a más de 1,8 V" esperan un instrumento, no otro chip. El PDK trae transistores de
alta tensión (`g5v0d10v5`, **PDK**); una bomba de Dickson de N etapas da idealmente V ≈ (N+1)·VDD menos las caídas. Con 3,3 V
opcionales en la plantilla analógica (**leído por agente**) hacen falta pocas etapas para ~10 V.

Campo en el óxido de 1,8 V (4,1 nm, laboratorio sin publicar): a 3,3 V son ~8 MV/cm; a 5 V, ~12 MV/cm (**cálculo**). La ruptura
del óxido está al alcance de una bomba modesta.

## 1. Ficha

**XC-53 · Bomba de alta tensión.** Instrumento. Bomba de Dickson con dispositivos de alta tensión y condensadores MOS → isla de
alta tensión con llave y límite de corriente → alimenta la formación de XC-07, la inyección de XC-14, el umbral de XC-18 y la
avalancha de XC-21.

**[corregido 2026-11-13 10:42] Ronda de ataque 4 (nodo flotante y alta tensión)** Verificado por dos agentes con mazos propios: Dickson con pfet de 5 V y pozo a la salida, desde 1,8 V: 8,0–8,4 V (N=6), 10,1–10,6 V (N=8) en vacío; 6,7/8,6 V con 1 µA; Rout 1,0–1,5 MΩ; ningún dispositivo > 2,8 V; 15–18 % de una tesela 1×2 sin layout. No alimentar desde 3,3 V: el pozo del último pfet llega a 12,8–17,6 V, sobre la ruptura pozo–sustrato del PDK (bv 16,85 V, diode_ps2nw). Pendiente: modelar el PNP vertical p+/pozo/sustrato (fuentes 0,54–0,78 V en directa en cada impulso) y bajar gmin en medidas de fuga. Tensiones internas altas en Tiny Tapeout: `[?]`, preguntar. Ver `experiments/RONDA_4_NODO_2026-11-13.md`.

## 2. Lectura y piso

Su salida se lee con un divisor y el lector de umbral, o por la frecuencia de un anillo alimentado por ella. Corriente
disponible `[?]`: nA a µA, suficiente para óxidos y puertas flotantes, escasa para avalancha sostenida.

## 3. Explicación aburrida y controles

No es un experimento. Su riesgo es dañar a los vecinos: pozo propio, anillo de guarda, llave de un solo sentido.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer las reglas de alta tensión del PDK (separaciones, pozos) y qué admite una tesela digital o analógica.
2. Simular la bomba en ngspice con los modelos de alta tensión: tensión y corriente frente a etapas y frecuencia.
3. Dibujar una etapa, DRC, extraer.

### 5.2 Configuraciones a dibujar

Propuesta: 2, 4 y 8 etapas; desde 1,8 V y desde 3,3 V; condensadores MOS de dos tamaños.

### 5.3 En silicio

Tensión en vacío y bajo carga conocida; rizado; fuga con la bomba parada.

### 5.4 Criterio de muerte (borrador)

Muere como instrumento compartido si no supera 5 V bajo la carga de una celda, o si las reglas de alta tensión no caben.

## 6. Documentación para graduarse

- [ ] Hoja de primeros principios revisada por un ataque independiente
- [ ] Mapa de tres regiones por simulación física, con sus barridos
- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC en Magic y KLayout, y resultado del precheck (qué pasa y qué no)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] README en inglés

## 7. Compuertas y dependencias

Desbloquea XC-07, 14 (inyección), 18, 21. Depende de la plantilla (3,3 V) y de la respuesta de Tiny Tapeout.

## 8. Abierto y fuentes

- Precedente: un proyecto de Tiny Tapeout con bombas a +7,4 y −4,5 V, solo simulado (**leído por agente**, pesca).
