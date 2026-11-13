# XC-32 · Acoplamiento por alimentación

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-32 de [catálogo](../../README.md#catalogue) (Supply-network coupling).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-32 · Acoplamiento por alimentación.** Caída de la red → mismo montaje que XC-31 → ninguna → Δf instantáneo (ns) → canal
lateral, sincronización → — → separar por escala de tiempo de XC-31. **Mantener:** es la explicación aburrida que todo experimento
de acoplamiento debe descartar.

## 2. Lectura y piso

No es una celda: es el canal de control que mide cuánto mueve la alimentación a cada instrumento, y la explicación aburrida de
todas las demás familias. Su lector es una etapa de XC-19 **sin gemelo**, que es deliberadamente sensible a la alimentación.

| Instrumento | Sensibilidad a la alimentación | De dónde y grado |
|---|---|---|
| Etapa en inversión débil, sola | 0,53 %/mV; mediana −5,10 % por 10 mV en el Monte Carlo | `experiments/xc19_weak_inversion` (`stage.txt`, `n5.txt`), **corrida**, modelo |
| Cociente dispositivo/gemelo | Mediana 0,047 % por 10 mV; máximo 0,329 % (39 sorteos) | misma corrida |
| Nodo de polarización | dVb/dVDD = 0,20 con cuatro en serie | misma corrida (`bias.txt`) |
| Anillo de celdas estándar, anillo RC de EFLD | `[?]` sin simular frente a alimentación | — |
| Precarga y descarga | `[?]`; el umbral del `inv_1` (0,791 V a 27 °C) se mueve con VDD | `macros/photon`, laboratorio, **sin publicar** |

- **Señal esperada:** 20 mA de consumo son unos 0,1 V de caída en la red de Tiny Tapeout (`PESCA_OPTO_1104.md` §2, laboratorio,
  sin publicar; dato de la especificación, **leído por agente**). Un agresor de ocho `ebufn_8` lleva 4,1 mA (`local_flow/efld_00`):
  unos 20 mV (**cálculo**, lineal y en continua; la caída local de la malla del macro es `[?]`).
- **Señal/piso:** 20 mV sobre una etapa sola son alrededor del 10 % (**cálculo**, 0,53 %/mV); sobre la pareja, 0,1 % (**cálculo**
  con la mediana), por debajo del salto de 0,83 % de una carga. La etapa sola lo ve de sobra; la pareja debería no verlo. Esa
  diferencia es la medida.
- **Escala de tiempo:** ns según la ficha; una conversión dura 29,2 µs (`cells/xc19_channel`), así que el lector integra el rizado
  rápido y ve su media. Lo rápido solo se ve como dispersión entre conversiones.

## 3. Explicación aburrida y controles

Aquí los papeles se invierten: XC-32 es la explicación aburrida de los demás. Lo que podría pasar por acoplamiento de alimentación:

| Explicación alternativa | Control que la separa |
|---|---|
| Calor del agresor (XC-31) | Escala de tiempo: alimentación en la primera conversión, calor en ms. Agresor lejano en el mismo raíl: misma caída, menos calor |
| Diafonía capacitiva de los hilos del agresor | Agresor con salida desconectada: conmuta la lógica, no carga la red |
| Inyección al sustrato | Anillo de tap alrededor del agresor; víctima en pozo propio |
| Caída en la placa o en el regulador, no en el chip | Escalón de VDD desde la mesa: da la sensibilidad sin agresor; víctimas a distinta distancia del agresor separan red interna de externa |
| El agresor mueve el reloj o la ventana de conteo | Canal de referencia que solo cuenta el reloj; el cociente contra él debe quedar quieto |

Control positivo obligatorio: la mesa mueve VDD unos mV y cada instrumento del chip debe responder con su %/mV. Sin eso un
"no se ve acoplamiento" no informa.

## 4. Referencia convencional (control científico, no filtro)

Contra la práctica convencional de integridad de alimentación: celdas `decap_*`, raíles separados y un monitor de anillo. Un anillo
como sensor de alimentación ya es convencional, por eso esto es un control y no una celda. Como canal lateral o de sincronización
compite con un cable y pierde; solo interesaría si sincroniza osciladores sin hilo (consumidor, XC-36) con una fuerza medible.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: sensibilidad de la etapa sola, de la pareja y de la polarización (tabla de arriba), todo modelo.
2. Pendiente: terminar el Monte Carlo (39 de 100 sorteos) para tener la cola de la pareja.
3. Pendiente: simular anillo estándar, anillo RC de EFLD y lector de precarga con VDD ± 10 mV; predicción escrita antes.
4. Pendiente: extraer la red de alimentación de un endurecido real (`local_flow/efld_01`) y simular el agresor de 2,06 mA contra
   ella: caída local frente a distancia. Hoy la única cifra es la global de Tiny Tapeout.
5. Pendiente: cómo recibe alimentación un macro con transistores (abierto en XC-19): decide qué raíl comparte la víctima.
6. Pendiente: víctima sin gemelo como variante del generador de `cells/xc19_channel`; no pide celda nueva.

### 5.2 Configuraciones a dibujar

Todas las dimensiones son **propuesta**. No hay geometría exótica: se barre la posición en la red. Bordes de metal conocidos: met1
0,140 µm y li1 0,170 µm ([`residual/drc_edge`](../../residual/drc_edge/README.md)); ancho de raíl del macro: borde legal por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Distancia agresor–víctima en la misma fila | Contiguos, 10, 50 µm y extremo opuesto | ¿La caída es local (resistencia del raíl de met1) o global? |
| Misma fila frente a filas distintas | 0, 1, 4 filas de separación | Raíl compartido frente a acoplo solo por las bandas verticales |
| Orientación | Agresor a lo largo del raíl y en perpendicular | Anisotropía de la malla: raíles de met1 en las filas, bandas verticales en metal alto (capa por comprobar en el DEF; met5 reservado) |
| Ancho del raíl del macro | Mínimo legal, ×2, ×4 | ¿Cuánto del acoplo es resistencia propia del macro? |
| Desacoplo entre ambos | Sin celdas `decap`, con algunas, con muchas | ¿El decap filtra lo rápido y deja lo lento? (si el flujo deja fijar el relleno `[?]`) |
| Fuerza del agresor | 1, 2, 4, 8 drivers | Linealidad: caída ∝ corriente; lo no lineal no es la red |
| Tipo de agresor | Continua por una línea, conmutación de un anillo, contienda | Caída media frente a rizado |
| Víctima | Etapa sola, pareja, anillo estándar, anillo RC, precarga | %/mV de cada instrumento; la pareja debe ser inmune |

Primero un canal completo: una etapa sin gemelo, una pareja a su lado y un agresor de ocho drivers con salida conectable.

### 5.3 En silicio

1. **Virgen:** todos los instrumentos con los agresores apagados.
2. **Calibrar:** VDD desde la mesa en pasos de pocos mV alrededor de 1,8 V (valores en el prerregistro); %/mV de cada instrumento.
   Comparar con la corrida: 0,53 %/mV la etapa sola.
3. **Caracterizar:** agresor en escalón; serie temporal de la etapa sola, de la pareja y del canal de temperatura.
4. **Barrer y repetir:** fuerza, distancia, tipo de agresor, temperatura; otra placa u otro regulador para separar chip de placa.
5. **Clasificar** cada instrumento: sensible (y cuánto), inmune bajo el piso, o inconcluso. El resultado es una tabla de
   sensibilidades que entra en el contrato de cada familia.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** la etapa sola sigue al agresor en la primera conversión, lineal con su corriente, y con el %/mV del escalón de mesa.
- **Negativo informativo:** con el agresor máximo ningún instrumento se mueve y el escalón de mesa sí se vio. Buena noticia: libera
  a las demás familias de esta explicación a esa corriente.
- **Inconcluso:** respuesta que no se separa de la térmica, o presente también con el agresor desconectado.
- **Fallo instrumental:** el escalón de mesa no se ve en la etapa sola.
- No muere: es un control. **Mata a otras:** si la pareja de XC-19 se mueve más que medio salto con el agresor normal del chip,
  el lector diferencial no basta y XC-19, XC-37 y XC-12 necesitan otro esquema.

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

- Es control de todas las familias leídas por tiempo; obligatorio para XC-19, XC-31, XC-37, XC-38 y XC-26.
- Comparte montaje con XC-31 y se interpretan juntas; usa el lector de XC-19 y los drivers de EFLD-01 como agresor.
- Permiso: ninguno. La corriente del agresor queda bajo el régimen de vías (una vía por driver, EFLD-01).
- Un solo chip basta, pero el resultado depende de la placa: hay que anotar regulador y desacoplo.

## 8. Abierto y fuentes

- Impedancia real de la red de una tesela y cuánto ruido meten los proyectos vecinos del mismo shuttle `[?]`.
- Si el vigilante y el reloj comparten alimentación con el agresor (límite declarado en EFLD-01).
- Corridas: [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md),
  [`experiments/xc19_noise`](../../experiments/xc19_noise/README.md); cifras en [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
  Laboratorio, sin publicar: `local_flow/efld_00`, `efld_01`, `docs/pesca/PESCA_OPTO_1104.md`. Lecciones de otros chips (osciladores
  25–40 % más lentos; el multiplexor distorsiona) en la [pesca](../notas/PESCA_2026-11-12.md).
