# XC-04 · Nanogap túnel

**Fusionada en XC-05 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-04 de [catálogo](../../README.md#catalogue) (Tunnelling nanogap).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-04 · Nanogap túnel.** Túnel directo entre electrodos a ~1 nm → línea rota por XC-01/02 → electromigración con realimentación →
I–V no lineal, dependencia térmica débil → unión túnel, sensor, base de XC-06 → lectura de pA → SMU por pin `ua` tras medir la fuga
del interruptor, o acceso al dado. **Mantener en H/E:** el lector digital (1–300 kΩ) lo ve abierto; la mediana publicada es ~10 GΩ
(`FRONTERAS_FISICAS_1105.md`, ficha 1). Hipótesis del repo: el liner deja un estado kΩ, no un hueco. Si XC-01 muestra salto directo
a abierto sin meseta kΩ, esta familia sube.

## 2. Lectura y piso

Ningún instrumento actual lo lee tal como está. «lab» = laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Resistencia publicada de un hueco de ~1 nm | mediana ~10 GΩ; algunos de pocos cientos de kΩ; ~15 % sobre 200 GΩ (Au, 140 pares) | `FRONTERAS_FISICAS_1105.md` ficha 1, Park 1999, **leído por agente**, lab |
| Control con realimentación | factor ~3 del objetivo entre 0,5 MΩ y 1 TΩ; sin control, huecos de más de 100 nm | misma ficha, Strachan 2005, **leído por agente**; en [`READING.md`](../../docs/READING.md) como no leído por nosotros |
| Corriente a 10 GΩ y 1 V | 100 pA | misma ficha, **cálculo** |
| Anillo con resistencia en serie | rango ~1 kΩ a ~300 kΩ; satura hacia 1 MΩ; muere abierto | `local_flow/efld_00/LEEME.md`, **corrida** de modelo, lab |
| Precarga y descarga (XC-26) | piso modelado 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF | [`PLANTILLA.md`](../PLANTILLA.md), lab |
| Fuga de un `ebufn_1` en alta impedancia | 32 fA a 27 °C; 0,41 pA a 85 °C | `NIGHT_SPRINT_2026-11-05.md`, modelo, lab |
| Fuga de los 16 `ebufn_4` de formación colgados del nodo | `[?]` | — |
| Fuga del interruptor del pin analógico | `[?]` | — |

Señal/piso: para el anillo, cero (abierto). Para la precarga y descarga, 100 pA estaría muy por encima de los 150 fA modelados,
pero ese piso es de otro nodo: aquí mandan las fugas de los drivers de formación, sin simular. Entre 300 kΩ y el GΩ no hay lector
caracterizado `[?]`.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| No hay hueco: conduce el liner (hipótesis del repo) | Lineal, sin dependencia del signo, coeficiente térmico de metal; y cae en el rango del anillo, no en GΩ |
| El hueco es de más de 100 nm y la corriente es fuga de drivers y uniones | Ficticio: hueco dibujado al espacio mínimo con los mismos drivers; debe leer lo mismo que un «abierto» formado |
| Fuga superficial o por el dieléctrico entre los extremos | Barrido del largo enfrentado en huecos dibujados: la fuga escala con el largo, un túnel puntual no |
| Conducción por óxido delgado (TiN oxidado, alúmina nativa) | No se separa por medios eléctricos: imita la no linealidad y la dependencia térmica débil. Pide microscopía |
| Temperatura | Dos temperaturas: la fuga de unión crece mucho (0,41 pA frente a 32 fA en el `ebufn_1`), el túnel poco |
| El gemelo también fuga | Gemelo virgen con los mismos drivers: su descarga es la línea de base |

## 4. Referencia convencional (control científico, no filtro)

La biblioteca no trae unión túnel. Como resistencia muy alta: un transistor cortado o el poly de alta resistividad
(`res_xhigh_po`, 2000 Ω/□, **leído por agente**). Como elemento túnel a 1,8 V, el propio óxido de puerta (XC-45), que sí tiene
modelo. Tendría que mostrar una conducción no lineal y poco dependiente de la temperatura que esos no den en la misma área; como
sensor, sensibilidad a lo que ocurre en el hueco, que hoy es conjetura.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): ficha con cálculo del decaimiento túnel y escala de resistencia anclada en dos datos de Park.
2. Pendiente: leer nosotros Strachan 2005 (está en la lista de lectura) y la fuente de uniones de aluminio, de la que solo se
   abrió el resumen.
3. Pendiente: simular la precarga y descarga sobre el nodo de una línea de EFLD-01 con sus 16 drivers en alta impedancia, con
   `gmin` = 1e-18 (con el valor por defecto el piso sale falso; lección de PHOTON). Predicción escrita antes.
4. Pendiente: dibujar el hueco ficticio al espacio mínimo (met1 0,140; li1 0,170) y pasarlo por los dos decks.
5. Pendiente: decidir cómo se aíslan los drivers de formación del nodo de lectura (interruptor de fuga baja, o drivers de umbral
   alto).
6. Pendiente: preguntar la fuga y la tensión máxima del interruptor analógico de Tiny Tapeout.
7. No se puede sin silicio: saber si el liner sobrevive. Lo decide la trayectoria R(t) de XC-01.

### 5.2 Configuraciones a dibujar

El precursor es el de XC-01 y XC-02; aquí van las variantes propias. Valores: **propuesta**.

| Barrido | Valores | Pregunta |
|---|---|---|
| Hueco ficticio dibujado | met1 a 0,140 µm; li1 a 0,170 µm | Piso de fuga de la estructura con sus drivers: lo que lee un abierto que no es túnel |
| Largo enfrentado del hueco dibujado | 0,14; 1; 10 µm | Si la corriente escala con el largo es fuga de superficie o de dieléctrico |
| Forma de los extremos | borde contra borde; punta contra punta (trapecio, borde legal por buscar) | ¿El campo en la punta cambia la fuga? Línea de base para un hueco formado |
| Largo del cuello a formar | 0,5; 1; 2 µm | Un cuello corto localiza la rotura; ¿deja huecos menores? |
| Capa | met1 (con liner) frente a li1 (sin metal encima) | Hipótesis del laboratorio: en met1 queda el liner; en li1 la rotura es térmica y el hueco no queda en 1 nm |
| Drivers colgados del nodo | 2; 8; 16 | La fuga de fondo escala con ellos: mide cuánto piso cuesta cada driver |
| Toma de lectura aislada | con y sin interruptor entre drivers y nodo | ¿Se puede separar la ruta de formación de la de lectura a nivel de fA? |

Primero un canal: una línea B de XC-01, su hueco ficticio y la precarga y descarga.

### 5.3 En silicio

1. **Virgen:** descarga del nodo con la línea entera (cortocircuito a la otra cabeza) y con el hueco ficticio: los dos extremos de
   la escala.
2. **Calibrar:** fuga conocida (un transistor cortado de tamaño conocido) en un canal gemelo.
3. **Caracterizar:** fuga del ficticio a dos temperaturas y frente a alimentación.
4. **Transformar:** es la formación de XC-01 llevada hasta que el anillo muere, con lectura entre pulsos y parada inmediata.
5. **Observar:** en los canales que quedaron «abiertos», tiempo de descarga frente al ficticio, a dos temperaturas.
6. **Retener y repetir:** el mismo canal otro día; un hueco inestable cambia.
7. **Clasificar:** liner (kΩ, lineal), abierto sin corriente sobre el ficticio, conducción sobre el ficticio de origen no
   identificado, fallo de lector.

Vehículo que espera: híbrido, para I–V con fuente de medida de pA por pin analógico, tras medir la fuga del interruptor; o acceso
al dado, para microscopía. En el digital solo se puede decir «conduce más que un abierto dibujado».

### 5.4 Criterio de muerte (borrador)

- **Positivo (en el digital, solo candidato):** canales formados que conducen de forma repetible por encima del ficticio, con
  dependencia térmica menor que la de la fuga de referencia.
- **Negativo informativo:** todos los abiertos formados leen igual que el ficticio, con el piso conocido: no hay hueco conductor
  por encima de ese piso.
- **Inconcluso:** conducción que deriva entre lecturas, o piso dominado por los drivers.
- **Fallo instrumental:** el ficticio y la línea entera no se distinguen.
- **Sube** si XC-01 salta a abierto sin meseta en kΩ. **No se llama túnel** sin I–V y microscopía: se registra como resistencia de
  mecanismo no identificado.

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

- Depende por completo de XC-01 y XC-02 (precursor, formación, permiso de estrés).
- Usa el instrumento de XC-26; el hueco ficticio sirve además de control de «abierto» para XC-01.
- Es la base de XC-06 (grano entre dos huecos) y frontera de XC-05.
- Vehículo: la formación cabe en el digital; la identificación pide híbrido o dado.
- Tiny Tapeout no entrega dados sin encapsular (**leído por agente**, pesca): la microscopía pide otro acuerdo.

## 8. Abierto y fuentes

- Espesor, composición y continuidad del liner tras vaciarse el aluminio `[?]`.
- Fuga real del nodo con los drivers de formación `[?]`; fuga y tensión máxima del interruptor analógico `[?]`.
- Si una rotura sin realimentación rápida puede dejar algo menor que 100 nm en esta pila `[?]`.
- Fuentes: Strachan en [`READING.md`](../../docs/READING.md). Laboratorio, sin publicar: `FRONTERAS_FISICAS_1105.md` ficha 1
  (Park, Strachan, Dubois, con sus enlaces), `NIGHT_SPRINT_2026-11-05.md`.
