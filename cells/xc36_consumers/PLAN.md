# XC-36 · Arquitecturas consumidoras

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-36 de [catálogo](../../README.md#catalogue) (Consumer architectures).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-36 · Arquitecturas consumidoras.** No son celdas. Se conservan para responder "qué circuito CMOS aprovecha esto".

## 2. Lectura y piso

No hay dispositivo que leer. El "piso" de un consumidor es un requisito: qué tiene que garantizar el contrato de una celda para
que la arquitectura funcione. Esta sección lo enuncia por consumidor; los números son los de las familias proveedoras.

| Consumidor (lista de `CARTERA.md` y `EQUIPO.md`, laboratorio) | Celda que consumiría | Parámetro del contrato que necesita | Estado del número |
|---|---|---|---|
| Bits probabilísticos | XC-19 (trampa), XC-33 (biestable), XC-37 (lenta) | Tasa gobernable y sesgo ajustable; bits independientes entre vecinos | Trampa: salto 0,83 %, 98 % de detección en modelo (**corrida**); ninguna trampa demostrada |
| Osciladores acoplados (Ising, reservorio) | XC-31 (calor), XC-32 (alimentación), XC-17 (electrodo) | Acoplo mayor que la dispersión de frecuencia entre osciladores | Acoplo `[?]`; dispersión de anillos `[?]`; etapas en inversión débil dispersas dos órdenes (**corrida**) |
| Lógica de carrera | XC-34 (retardos), XC-12 y XC-13 (retardo fijado por layout) | Retardos ordenados con margen mayor que el desajuste | Anillos 2,5 a 5,1 % por LOD (**corrida**); desajuste de retardo `[?]` |
| Memoria circulante | XC-34 (anillo con pulso), XC-37 o XC-11 (retención) | Tiempo de retención y regeneración sin perder el pulso | `[?]` |
| Autómata del sombrero sin reloj | XC-34 (celdas asíncronas), XC-17 (capacidad de referencia) | Vecindad aperiódica con retardos conocidos | `[?]`; hoy el sombrero solo entra como capacidad de referencia (`FILOSOFIA.md`, regla 13) |
| Identidad | XC-35, XC-14 | Bits estables | ver XC-35 |

Regla de observabilidad aplicada aquí: un consumidor no ocupa silicio hasta que su proveedora tenga el parámetro medido o, como
mínimo, simulado con su dispersión. Señal/piso es acoplo o margen dividido por dispersión: hoy `[?]` salvo en la trampa.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| La arquitectura funciona, pero igual con una celda estándar en lugar de la exótica | Gemelo arquitectónico: el mismo RTL con la primitiva sustituida por su equivalente convencional (LFSR, cable, retardo de biblioteca) |
| Los osciladores se sincronizan por la alimentación común, no por el acoplo diseñado | Canal XC-32; par con acoplo diseñado desconectado a la misma distancia |
| El resultado "probabilístico" es batido determinista | Reinicios repetidos y comparación de secuencias (control de XC-33) |
| La carrera la gana siempre el mismo por enrutado, no por la celda | Intercambiar caminos; pares con retardos iguales deben repartirse |
| Funciona en simulación porque el modelo no tiene desajuste ni ruido | Simulación de comportamiento alimentada con la dispersión medida o del Monte Carlo, no con valores nominales |

El control de un consumidor es siempre el mismo circuito con la primitiva convencional. Si no se puede construir ese gemelo, el
consumidor no prueba nada sobre la celda.

## 4. Referencia convencional (control científico, no filtro)

Cada consumidor se compara con su versión hecha solo de biblioteca: generador pseudoaleatorio más comparador para los bits
probabilísticos; osciladores acoplados por cable o por compuerta; lógica síncrona para la de carrera; registro de desplazamiento
para la memoria circulante; autómata síncrono con reloj para el sombrero. Ventaja que tendría que mostrar: menos área, menos energía
o una función que la versión convencional no da (entropía física, acoplo sin cable). Sin gemelo convencional no prueba nada.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: por cada consumidor, una línea con observable y qué lo mata (hoy solo existen las de vernier e identidad).
2. Pendiente: modelo de comportamiento de dos bits probabilísticos acoplados, alimentado con las cifras de `experiments/xc19_noise`
   (salto, ruido, residencias inyectadas): ¿qué tasa y qué independencia necesita?
3. Pendiente: modelo de dos anillos con acoplo paramétrico: acoplo mínimo que sincroniza frente a diferencia de frecuencia. Da el
   requisito que XC-31, XC-32 y XC-17 tienen que cumplir. Predicción escrita antes.
4. Pendiente: lógica de carrera en RTL con retardos de `experiments/stdcell_lod` (extraído frente a anotado): ¿el orden de llegada
   cambia al anotar? Es una consecuencia de XC-12 que se puede calcular hoy.
5. Pendiente: recuperar del repositorio de investigación (`01_hat87`) qué pide el autómata del sombrero a una celda física `[?]`;
   aquí no se duplica.
6. No se dibuja nada de esta familia hasta que su proveedora tenga un canal completo.

### 5.2 Configuraciones a dibujar

No se dibujan dispositivos. Lo que se barre es la geometría del **acoplo** entre celdas ya existentes. Todo es **propuesta**; los
bordes legales son los de la celda proveedora ([`residual/drc_edge`](../../residual/drc_edge/README.md)).

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Distancia entre dos osciladores | Contiguos, 5, 20, 50 µm | ¿Hay distancia a la que el acoplo no diseñado (calor, alimentación) deja de sincronizar? |
| Medio de acoplo | Ninguno, raíl compartido, calefactor cruzado, electrodo en met2–met4 | Qué canal físico acopla más por unidad de área |
| Área y solape del electrodo de acoplo | Tres tamaños; placa frente a peine (perímetro frente a área) | Acoplo capacitivo frente a geometría (lector ≈ 2 %/fF, `EQUIPO.md`, laboratorio, sin publicar) |
| Topología | Par, cadena de 4, anillo de 4, vecindad aperiódica mínima | ¿La red hace algo que el par no? Aquí cabe el tejido del sombrero frente a un control periódico |
| Orientación de los vecinos | Misma fila frente a filas distintas | Anisotropía del acoplo por raíl |
| Diferencia de retardo en la carrera | Pares con LOD igual, distinto y opuesto | ¿Un retardo fijado por layout decide la carrera con margen? |
| Fuente de bits | Trampa, biestable, LFSR en el mismo consumidor | Gemelo arquitectónico |

Primero un consumidor mínimo: dos elementos, una proveedora, un gemelo convencional. Nada de matrices.

### 5.3 En silicio

1. **Virgen** (solo cuando la proveedora haya pasado su propio 5.3): cada elemento por separado, sin acoplo.
2. **Calibrar:** el gemelo convencional da el resultado esperado por simulación.
3. **Caracterizar:** activar el acoplo; medir enganche, correlación u orden de llegada frente al caso desacoplado.
4. **Barrer:** fuerza de acoplo, temperatura, alimentación.
5. **Repetir:** reinicios y días distintos.
6. **Clasificar:** el consumidor funciona por la celda exótica; funciona igual con la convencional; no funciona por dispersión;
   inconcluso por acoplo no diseñado.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** el consumidor hace con la celda exótica algo que su gemelo convencional no hace, o lo hace con menos recursos, y
  el efecto desaparece al desconectar el acoplo diseñado.
- **Negativo informativo:** el gemelo convencional iguala o gana. Es el resultado que la regla 11 exige poder obtener.
- **Inconcluso:** funciona, pero también con el acoplo desconectado.
- **Fallo instrumental:** los elementos aislados no dan sus valores propios.
- **Muere para este chip** el consumidor cuya proveedora no tenga contrato. No se borra: queda como respuesta a "qué circuito CMOS
  aprovecha esto" para el siguiente vehículo.

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

- Depende de todas las proveedoras nombradas; ninguna tiene contrato hoy.
- No ocupa área en el primer chip salvo que sobre tras los canales completos y los controles (`docs/PROPOSAL.md`: una pregunta
  física y un instrumento caracterizado).
- El autómata del sombrero entra solo donde la física lo pida; su definición vive en `01_hat87` y no se copia aquí.
- Sin permisos. Flujo digital.

## 8. Abierto y fuentes

- Qué acoplo mínimo necesita cada arquitectura: `[?]` hasta los modelos de 5.1.
- Si algún consumidor decide entre dos proveedoras (trampa frente a biestable) mejor que la medida directa.
- Texto de origen: `CARTERA.md` y `EQUIPO.md` ("Retirado a biblioteca secundaria"), laboratorio, sin publicar. Proveedoras:
  [`xc19_single_trap`](../xc19_single_trap/PLAN.md), [`xc33_metastability`](../xc33_metastability/PLAN.md),
  [`xc34_offlabel_cells`](../xc34_offlabel_cells/PLAN.md), [`xc31_heat_channel`](../xc31_heat_channel/PLAN.md),
  [`xc32_supply_coupling`](../xc32_supply_coupling/PLAN.md), [`xc35_die_identity`](../xc35_die_identity/PLAN.md).
  Corridas: [`experiments/stdcell_lod`](../../experiments/stdcell_lod/README.md),
  [`experiments/xc19_noise`](../../experiments/xc19_noise/README.md).
