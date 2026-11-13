# XC-07 · Ruptura de óxido

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-07 de [catálogo](../../README.md#catalogue) (Oxide breakdown: antifuse, filament).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-07 · Ruptura de óxido.** Ruptura dieléctrica → condensador MOS de óxido delgado → sobretensión con corriente limitada →
conductancia antes y después, estados intermedios → antifusible, memoria de una escritura, filamento → celda 1T con limitador →
formar con rampa y cumplimiento. **Mantener en H:** pide más de 3 V (óxido de 4,15 nm). Se puede dibujar y enviar virgen.

**Replanteo del 2026-11-12 (cálculo).** No espera otro chip: espera la bomba (XC-53). A 3,3 V el óxido de 4,1 nm ve ~8 MV/cm; a
5 V, ~12 MV/cm. Absorbe XC-08.

**[corregido 2026-11-13 10:42] Ronda de ataque 4 (nodo flotante y alta tensión)** A 3,3 V la ruptura no está al alcance (un agente; no verificable: los modelos de TDDB dan 7–14 décadas de incertidumbre). Con la bomba XC-53 (8–10 V verificados) la ruptura es plausible; el tiempo depende fuertemente del área: la celda debe barrer área y tensión y medir, no confiar en el modelo. Ver `experiments/RONDA_4_NODO_2026-11-13.md`.

## 2. Lectura y piso

Dos regímenes, dos instrumentos. «lab» = laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Espesor de óxido | 4,148 nm (nfet 1,8 V); 4,23 nm (pfet 1,8 V); 11,6 nm (5 V) | modelos del PDK (`toxm`), `PESCA_PHOTON_1105.md`, **PDK**, lab |
| Formación publicada | 6,0 V sobre óxido de menos de 3 nm, 55 nm; la corriente pasa de pA a mA y se estabiliza en menos de 1 min | misma pesca, Li 2023, **leído por agente** |
| Tensión de ruptura en SKY130 | ≈ 8 V (1,8 V) y ≈ 23 V (5 V) si escalara con el espesor: **hipótesis**, no dato | misma pesca, cálculo sobre hipótesis |
| Fuga virgen del condensador a 1,8 V | `[?]`; no sabemos si el modelo del PDK trae corriente de puerta | — |
| Instrumento antes de romper: precarga y descarga | piso modelado 150 fA a 27 °C; nodo de 12,4 fF | [`PLANTILLA.md`](../PLANTILLA.md), lab |
| Instrumento después de romper: anillo con resistencia en serie | rango ~1 kΩ a ~300 kΩ | `local_flow/efld_00/LEEME.md`, **corrida** de modelo, lab |
| Resistencia del filamento tras la ruptura | `[?]` (la fuente da ≈ 2,5 V a 1 mA, leído de un gráfico) | misma pesca |
| Tiempo hasta la ruptura a 1,8 V | `[?]`, sin modelo | — |

Señal/piso: el salto de pA a mA son muchas décadas, visible con cualquiera de los dos instrumentos si la ruptura ocurre. Lo que no
se sabe es si la fuga virgen supera los 150 fA ni si a 1,8 V pasa algo en un tiempo de mesa.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Rompió una unión, no el óxido (ruptura de diodos del PDK: 11,7 a 12,8 V; `PESCA_OPTO_1104.md`, lab) | Condensador sobre pozo sin unión polarizada; gemelo con la misma unión y sin óxido delgado |
| Rompió el transistor limitador o el interruptor del pin | Limitador de óxido grueso; lectura del limitador solo, antes y después |
| Fue un sobreimpulso, no la rampa (hasta 5 pF a 3,3 V en la ruta analógica, ~27 pJ; `DECISIONES.md`, lab) | Limitador dentro del chip, junto al condensador; ficticio que recibe el mismo pulso sin óxido delgado |
| La fuga creció por temperatura | Gemelo sin estrés al lado; canal XC-31 |
| El daño venía de fábrica (plasma) | Lectura virgen de todos; variantes con y sin antena (XC-14, XC-15) |
| Rompió el borde junto al óxido de campo, no el área | Barrido de perímetro frente a área |

## 4. Referencia convencional (control científico, no filtro)

El PDK abierto no ofrece antifusible. Lo que ofrece para guardar un bit sin alimentación: el fusible (met4 en la instalación del
laboratorio; regla de fusible metálico según la pesca, **leído por agente**) y SONOS, que pide +6,7 y −3,8 V (**leído por
agente**). ReRAM figura como «still under development» (**leído por agente**).

Tendría que mostrar: memoria de una escritura más pequeña que el fusible, sin máscara adicional, o estados intermedios de
conductancia que el fusible no tiene. Si solo hace lo que el fusible y pide una bomba de carga, gana el fusible.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): espesores de óxido leídos de los modelos; fuente del filamento leída (texto principal; la información
   suplementaria no).
2. Pendiente: buscar en el modelo del PDK los parámetros de corriente de puerta y, si existen, simular la fuga virgen de cada
   condensador a 1,8 V. Predicción escrita antes.
3. Pendiente: dibujar por script las variantes de 5.2 y pasarlas por Magic con reglas completas y por el deck completo de KLayout
   con FEOL encendido.
4. Pendiente: leer una fuente con tensión o campo de ruptura medidos en óxidos de unos 4 nm; hoy solo hay una extrapolación lineal.
5. Pendiente: preguntar la tensión máxima del pin analógico. El interruptor no deja subir el pad de unos 0,6 V sobre el raíl de
   3,3 V (`PESCA_OPTO_1104.md`, lab; pendiente de confirmar).
6. Pendiente: primer cálculo de una bomba de carga interna (área y corriente entregable `[?]`); met5 está reservado, así que los
   condensadores serían de met3/met4.
7. Pendiente: simular el limitador 1T con el condensador roto modelado como resistencia.

### 5.2 Configuraciones a dibujar

Valores: **propuesta**. Dimensiones de puerta bajo el mínimo de transistor y recubrimientos: borde legal por buscar.

| Barrido | Valores | Pregunta |
|---|---|---|
| Área de óxido | 0,42 × 0,15; 1 × 1; 5 × 5; 20 × 20 µm | La ruptura es de eslabón más débil: ¿tiempo y tensión escalan con el área? |
| Perímetro frente a área | cuadrado frente a dedos de igual área | ¿Rompe en el borde con el óxido de campo o en el interior? |
| Borde de puerta | poly que cruza el borde de difusión frente a poly contenido dentro (legalidad por buscar) | Aislar la esquina del óxido de campo como sitio |
| Tipo | nfet (4,148 nm), pfet (4,23 nm), poly n+ sobre pozo n (estructura de la fuente) | Polaridad de inyección y sustrato |
| Apertura del pozo bajo el poly | ~0,3 µm² en la fuente; aquí 0,1; 0,3; 1; 3 µm² | Localiza el filamento; enlaza con XC-08 |
| Óxido grueso | misma geometría con dispositivo de 5 V (11,6 nm) | Ficticio: a la misma tensión no debe romper |
| Antena | metal colgado de la puerta hasta cerca del límite legal (poly 50; metales 400; **leído por agente**) | ¿El plasma ya dejó el óxido debilitado? Formación de ruta A |
| Ancho del limitador | varios | La corriente de cumplimiento decide entre ruptura suave y dura |
| Orientación | 0° y 90° | Anisotropía de fabricación |

Primero un canal: un condensador, su limitador, su gemelo y la lectura de fuga.

### 5.3 En silicio

1. **Virgen** (cabe hoy, sin permiso): fuga de cada condensador a 1,8 V con la precarga y descarga, a varias temperaturas.
2. **Calibrar:** fuga conocida y resistencia conocida en canales gemelos.
3. **Caracterizar:** fuga frente a área y perímetro: ya es un resultado sobre el óxido de SKY130.
4. **Transformar, a 1,8 V** (con permiso): tensión constante durante horas con placa caliente, siguiendo la fuga. No se espera
   ruptura `[?]`; es un negativo con sensibilidad conocida.
5. **Transformar, sobre 1,8 V** (otro vehículo): rampa con cumplimiento por el limitador, parada al primer salto.
6. **Observar:** conductancia antes y después; estados intermedios; I–V del filamento.
7. **Retener y repetir:** horas, días, ciclo térmico. **Clasificar:** sin cambio, fuga aumentada, ruptura suave, ruptura dura,
   fallo del limitador.

Vehículo que espera: híbrido con raíl de 3,3 V si alcanza `[?]`, o bomba de carga interna. La ficha dice «más de 3 V»; la
extrapolación del laboratorio dice ≈ 8 V. No coinciden y no hay medida.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** salto de conductancia repetible, retenido, con el ficticio de óxido grueso y el gemelo intactos, y dependencia del
  área.
- **Negativo informativo:** a la tensión máxima disponible y con placa caliente la fuga no cambia en un tiempo fijado antes `[?]`,
  con el piso medido.
- **Inconcluso:** cambia también el limitador o el gemelo; fuga virgen bajo el piso.
- **Fallo instrumental:** la calibración de fuga no se ve.
- **Muere como celda** si no rompe por debajo de la tensión que una bomba razonable entrega, o si rota no mejora al fusible.

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

- En el digital solo viaja virgen: da la fuga del óxido frente a área y perímetro, y la prueba a 1,8 V si hay permiso de estrés.
- La transformación pide más de 1,8 V: híbrido o bomba; auditoría de alta tensión de todo lo que toque ese nodo.
- XC-08 depende de esta familia. XC-45 comparte el condensador y la lectura. XC-14 y XC-15 comparten la variante de antena.
- Irreversible: réplicas dentro del dado.
- El precheck de Tiny Tapeout no corre antena para sky130A (**leído por agente**, pesca): la variante de antena no la filtra él,
  pero eso no la autoriza.

## 8. Abierto y fuentes

- Tensión de ruptura real de los óxidos de SKY130 `[?]`. Fuga virgen `[?]`.
- Si el raíl de 3,3 V basta para algo (ruptura lenta) `[?]`.
- Contradicción por resolver entre «más de 3 V» de la ficha y los ≈ 8 V extrapolados.
- Laboratorio, sin publicar: `pesca/PESCA_PHOTON_1105.md` (Li 2023 y espesores), `pesca/PESCA_OPTO_1104.md` (pin analógico),
  `DECISIONES.md`. Reglas de antena y SONOS: [pesca](../notas/PESCA_2026-11-12.md).
