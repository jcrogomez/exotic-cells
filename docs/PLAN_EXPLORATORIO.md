# Plan exploratorio

Escrito el 2026-11-12 11:55 EST (hora de `date`). Nota de trabajo. Ordena lo que falta para saber qué familias caen en la tercera
región. No lleva fechas: ninguna está comprometida. Cada tarea que produce un número lleva su predicción escrita antes, y su
salida es un mapa de tres regiones. Códigos de prueba: [`../cells/PRUEBAS.md`](../cells/PRUEBAS.md).

## Frente 0 · Herramientas y datos (desbloquea todo lo demás)

| Tarea | Qué entrega |
|---|---|
| E0.1 Instalar DEVSIM, scikit-fem y grcwa; probar openEMS de la imagen | S3, S4, S6 disponibles |
| E0.2 Mapa del precheck (L2): una celda por tipo de ruptura (ancho, separación, pozo sin toma, antena, capas poco usadas, relleno bloqueado) | Tabla: qué rechaza y qué deja pasar el precheck local |
| E0.3 Hoja de datos del proceso: espesores, materiales, dopados y resistencias públicos, cada uno con su ruta en el PDK | Un solo archivo del que beben todas las simulaciones |
| E0.4 Deck completo sobre los macros dudosos del laboratorio (PHOTON, constricciones de li) | Saber si están limpios |
| E0.5 Leer las fuentes de `READING.md` marcadas como prioritarias | Magnitudes con fuente en vez de memoria |

## Frente 1 · Unión túnel (XC-20)

| Tarea | Prueba | Pregunta |
|---|---|---|
| E1.1 Dopados de fuente y drenaje en los modelos y en la documentación; ¿hay siliciuro sobre la difusión? | E0.3 | ¿La frontera p+/n+ es una unión o un cable? |
| E1.2 Perfil lateral en la frontera frente a separación, de solape negativo a +0,3 µm, barriendo dosis y difusión | S2 | ¿Dónde queda la unión más abrupta? |
| E1.3 I–V con túnel banda a banda sobre esos perfiles | S3 | Mapa: diodo ordinario, túnel, resistencia negativa, corto |
| E1.4 Par biestable y oscilador con el I–V simulado | S9 | ¿Qué relación pico/valle mínima da un biestable legible? |
| E1.5 Frontera definida por puerta (transistor túnel): borde legal | L1, L2 | ¿Se puede dibujar? |

## Frente 2 · Contacto de pocos canales (XC-05, forja XC-01)

| Tarea | Prueba | Pregunta |
|---|---|---|
| E2.1 Refinar la ventana del puente sublitográfico: largo de cuello de 0,14 a 0,30 en pasos de 0,02; separación de puntas de 0,03 a 0,07 | S1 | ¿Cómo de estrecha es la ventana y cuánto se mueve con la óptica? |
| E2.2 Temperatura y tiempo térmico del cuello y del puente | S4 | ¿Cuánto tiempo tiene el lazo para reaccionar? |
| E2.3 Tiempo a vacío frente a corriente y largo | S5 | ¿Qué largos quedan a cada lado del umbral de Blech? |
| E2.4 Lazo de parada: comparador y drivers con una resistencia que crece | S9 | ¿Se detiene en kΩ? ¿Con qué retardo máximo? |
| E2.5 Conducción en paralelo del recubrimiento frente al largo del vacío | cálculo con E0.3 | ¿Tapa los escalones? |

## Frente 3 · Espín y magnetismo (XC-52, XC-25, XC-56)

| Tarea | Prueba | Pregunta |
|---|---|---|
| E3.1 Campo de espirales dibujables en met3 y met4; calentamiento; bifilar | S7 | ¿Cuántos mT por mA, y a qué coste térmico? |
| E3.2 Acoplo inductivo y capacitivo de la bobina al nodo de lectura | S6, cálculo | ¿De qué tamaño es la explicación aburrida? |
| E3.3 Ruido del bombeo de carga con conteo síncrono | S10 | ¿En cuánto tiempo se ve 10⁻⁴? |
| E3.4 Placa Hall de pozo con datos del PDK, bajo la bobina | S9 | ¿Llega a un paso del lector? |

## Frente 4 · Carga única (XC-19, XC-14)

| Tarea | Prueba | Pregunta |
|---|---|---|
| E4.1 Terminar el macro del lector: condensadores, pines, LEF, alimentación, integración | L3, L4 | ¿Cuánta área real ocupa un canal? |
| E4.2 Corriente de túnel directo por fórmula con el espesor del PDK (el modelo la trae apagada) | cálculo, S3 | ¿Cuánto dura la carga de un nodo flotante? |
| E4.3 Bombeo de carga con toma de cuerpo propia | S9, L1 | ¿Un pulso de 1,8 V cruza acumulación e inversión? |
| E4.4 Carga de plasma frente a razón de antena | cálculo, lectura de reglas | ¿Qué corrimiento cabe esperar? |

## Frente 5 · Óptica interna (XC-26, XC-27)

| Tarea | Prueba | Pregunta |
|---|---|---|
| E5.1 Fotones frente a portadores con la geometría real del emisor en pozo | S3 | ¿Qué fracción de la corriente llega al fotodiodo por cada vía? |
| E5.2 Reflexión de la red frente al paso, con la pila barrida; aperiódica con openEMS | S6 | ¿A qué paso se distinguen las tapas? |
| E5.3 Corregir la guarda y dibujar la carga ficticia | L3 | — |

## Frente 6 · Frecuencias (XC-24, XC-39, XC-55)

| Tarea | Prueba | Pregunta |
|---|---|---|
| E6.1 Tiristor parásito con los bipolares del PDK | S9 | ¿La tensión de mantenimiento queda bajo 1,8 V? |
| E6.2 Resistor de poly de muy alta resistencia con su calor | S4 | ¿Hay realimentación suficiente para oscilar? |
| E6.3 Bandas acústicas de la rejilla metal/óxido | S8 | ¿A qué frecuencia cae el modo y hay cómo leerlo? |

## Frente 7 · Alta tensión y frío (XC-53, XC-07, XC-18, XC-21, XC-54)

| Tarea | Prueba | Pregunta |
|---|---|---|
| E7.1 Bomba de Dickson con los dispositivos de alta tensión | S9 | ¿Cuántos voltios bajo carga, y cabe en la tesela? |
| E7.2 Leer los datos criogénicos publicados de SKY130 | lectura | ¿Está ya medida la interconexión local en frío? |
| E7.3 Buscar quién tenga nitrógeno líquido y criostato | — | — |

## Frente 8 · Integración

| Tarea | Qué entrega |
|---|---|
| E8.1 Lector central con ranuras para todos los macros; endurecer en 1×2 | Área real, y la decisión entre 1×2 y 2×2 |
| E8.2 Preguntas a Tiny Tapeout: número de chips, macros propios, bloqueo de relleno, estrés en mesa, antena, 3,3 V | Lo que hoy es `[?]` |
| E8.3 Filtro final | Lo define Juan |

## Orden

1. Frente 0 entero.
2. Frentes 1, 2 y 3 en paralelo: son las tres ideas destiladas. Antes de dibujar, una ronda de ataque independiente a cada una.
3. Frentes 4 a 7.
4. Frente 8, con lo que haya sobrevivido y lo que quepa.
