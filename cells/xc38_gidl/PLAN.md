# XC-38 · Fuga de drenaje inducida por puerta

**Fusionada en XC-20 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-38 de [catálogo](../../README.md#catalogue) (Gate-induced drain leakage).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-38 · Fuga de drenaje inducida por puerta.** Túnel banda a banda bajo el borde de la puerta → diodo con puerta, W grande → puerta
a 0 con drenaje a 1,8 V → descarga del nodo frente a la misma unión sin puerta → sensor de campo, fuente de corriente diminuta → — →
par con y sin puerta, temperatura. Señal `[?]` (≲pA/µm, **de memoria**). Aburrida: fuga de unión y subumbral. Juicio: bajo a 1,8 V.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** En el PDK local `agidl = 0` en los 180 bins de `nfet_01v8` (tt) y es distinto de cero en `pfet_01v8`: el modelo solo predice algo para el pfet.

## 2. Lectura y piso

Precarga y descarga, igual que XC-37: el drenaje del diodo con puerta es el nodo flotante; se compara el tiempo de descarga con la
puerta a 0 V (campo máximo en el borde) y con la puerta al potencial del drenaje (campo retirado). Todo es modelo.

| Cantidad | Valor | De dónde y grado |
|---|---|---|
| Piso del lector de precarga | 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF | `macros/photon/LEEME.md`, laboratorio, **sin publicar**, modelo |
| Señal: fuga inducida por puerta a 1,8 V | `[?]`; ≲ pA/µm de ancho, **de memoria** (ficha) | — |
| Lo que predice el modelo del nfet | Nada: `agidl = 0` en los 180 intervalos de `nfet_01v8` y en `nfet_01v8_lvt` | **PDK** local (`sky130_fd_pr__nfet_01v8__tt.pm3.spice`); ya anotado en `PESCA_OPTO_1104.md`, laboratorio |
| Lo que predice el modelo del pfet | `agidl` no nulo en los 108 intervalos de `pfet_01v8` y en 189 de 198 de `pfet_01v8_hvt`, con un valor distinto por intervalo y signo negativo en muchos | **PDK** local (`*__tt.pm3.spice`); corriente resultante `[?]` sin simular |
| Dispositivos de 5 V | `agidl` = 5,06e-11 en los 88 intervalos de `nfet_g5v0d10v5`; en `pfet_g5v0d10v5`, distinto por intervalo y a veces negativo | **PDK** local |
| Corriente de puerta en el modelo | Desactivada en `nfet_01v8` (`igcmod = 0`, `igbmod = 0`); resto sin comprobar | **PDK** local; coincide con "sin fuga de compuerta" de `macros/photon` |
| Fuga de unión que compite | 6,5 fA a 27 °C y 11,5 pA a 85 °C para 9 µm² y 12 µm | `macros/photon`, laboratorio, modelo |

- **Señal/piso:** con la cifra de memoria, un ancho de 100 µm daría del orden de 100 pA como techo, muy sobre el piso (**cálculo**
  sobre un dato sin fuente: vale como razón para dibujar ancho, no como predicción). La cota inferior es cero.
- **Firma:** el túnel casi no depende de la temperatura y la fuga de unión sí (`EQUIPO.md`, laboratorio). La señal es la
  diferencia entre los dos estados de puerta a 27 °C, donde la unión está bajo el piso, y su permanencia relativa al calentar.
- **Dos resultados legítimos:** en el nfet toda diferencia es residuo del modelo; en el pfet hay una predicción, de ajuste dudoso.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Fuga de unión (la de la ficha) | Control eléctrico en la misma estructura: puerta al potencial del drenaje. Control geométrico: la misma unión sin puerta |
| El borde de puerta fuga distinto del borde de aislamiento aunque no haya túnel | El control eléctrico anterior, que no cambia la geometría; variante de puerta anular, sin borde de aislamiento |
| Subumbral hacia la fuente (la de la ficha) | Estructura sin fuente, o fuente unida al drenaje |
| Túnel directo por el óxido de puerta hacia el drenaje | Polaridad invertida: nodo flotante en la puerta y difusiones a 0 V; ahí hay corriente de óxido y no de borde (liga con XC-45) |
| Con la puerta alta se forma canal y crece el área de unión | Barrer la puerta en pasos: la fuga inducida debe crecer de forma monótona al bajar la puerta, no saltar en el umbral |
| Fuga del interruptor de precarga | Nodo ficticio con la misma lectura; interruptor largo de umbral alto (0,010 pA, **corrida**) |

## 4. Referencia convencional (control científico, no filtro)

Como fuente de corriente diminuta: un MOS en inversión débil polarizado por la cadena de XC-19 (81 pA o 5,5 nA, **corrida**), que
deriva de 3,7 a 6,1 %/K (`experiments/xc19_weak_inversion`, **corrida**), o la fuga de una unión. La fuga por túnel tendría que
derivar claramente menos: sería una referencia de pA casi plana en temperatura, que la biblioteca no tiene. Como sensor de campo no
hay equivalente. Si no se distingue de la unión o deriva igual, gana lo convencional.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: `agidl` y modo de corriente de puerta comprobados en los modelos locales (tabla).
2. Pendiente: simular el pfet como diodo con puerta (fuente al drenaje, pozo a VDD, nodo a 0 V, puerta a 1,8 V): corriente frente a
   puerta y temperatura, `gmin` = 1e-18, predicción escrita antes. En el nfet la simulación da cero por construcción: se declara.
3. Pendiente: leer una fuente con esta fuga medida en 130 nm a 1,8 V; hoy la cifra es de memoria.
4. Pendiente: bordes legales con `residual/drc_edge`: difusión junto a puerta ya medida (0,250 µm sin contacto, 0,275 con
   contacto centrado); puerta anular y extensión de poly sobre aislamiento: por buscar.
5. Pendiente: generador por script del diodo con puerta y de su gemelo sin puerta; DRC en los dos decks; extracción (comprobar
   que Magic lo extrae como transistor y no funde fuente y drenaje); anotar con Residual, porque `sa`/`sb` cambian el dispositivo.
6. Pendiente: tensión de puerta intermedia desde las tomas de la cadena de XC-19 (0,157 a 0,472 V, 16 espejos, **corrida**).

### 5.2 Configuraciones a dibujar

Todas las dimensiones son **propuesta**. Bordes conocidos: difusión junto a puerta desde 0,250 µm (0,275 con contacto), p+ a n+
a 0 o desde 0,270 µm ([`residual/drc_edge`](../../residual/drc_edge/README.md)); el resto, por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Ancho de puerta (largo del borde) | 1, 10, 100 µm, en dedos | La corriente inducida debe escalar con el borde de puerta |
| Largo de puerta | 0,15; 0,50; 2,0 µm al mismo ancho | No debe depender del largo; si depende, es óxido o canal, no borde |
| Extensión de la difusión de drenaje | 0,250 (sin contacto), 0,275, 1,0, 3,0 µm | Separa el término de área de unión del término de borde de puerta; cambia además el esfuerzo (XC-12) |
| Perímetro de aislamiento | Puerta recta frente a puerta anular que rodea el drenaje | Quita el borde de aislamiento y la esquina (liga con XC-46) |
| Tipo de dispositivo | `nfet_01v8`, `nfet_01v8_lvt`, `pfet_01v8`, `pfet_01v8_hvt`, `nfet_g5v0d10v5` | Dopado de drenaje y espesor de óxido; el pfet tiene predicción y el nfet no |
| Orientación de la puerta | 0° y 90° | Control; una diferencia apuntaría a implantación inclinada o a esfuerzo |
| Gemelo sin puerta | Misma difusión y mismos contactos | Control geométrico de la ficha |
| Tensión de puerta (eléctrico, no layout) | 0 V, tomas de la cadena, VDD | Dependencia con el campo: firma de túnel |

Primero un canal completo: un diodo con puerta de ancho grande, su gemelo sin puerta, el ficticio y la puerta conmutable.

### 5.3 En silicio

1. **Virgen:** tiempos de descarga con la puerta en el estado sin campo; muchos nodos no cruzarán a 27 °C: dato censurado.
2. **Calibrar:** corriente de prueba y condensador de referencia sobre el ficticio.
3. **Caracterizar:** alternar puerta con campo y sin campo, lecturas intercaladas; diferencia por estructura.
4. **Barrer:** tensión de puerta (tomas), temperatura (placa o XC-31), alimentación (cambia el campo: la dependencia debe ser
   fuerte). Energía de activación de cada componente.
5. **Retener y repetir:** otro día; el estado con campo mantenido horas es estrés suave: vigilar deriva (XC-10).
6. **Clasificar** cada estructura: corriente inducida por puerta (depende de la puerta, escala con el ancho, plana en temperatura),
   solo unión, bajo el piso, fallo de lector.

Sin transformación ni permiso a 1,8 V. Más campo espera al vehículo híbrido con raíl de 3,3 V y dispositivos de 5 V.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** diferencia entre estados de puerta sobre el piso, proporcional al ancho, independiente del largo, y con deriva
  térmica menor que la del gemelo sin puerta.
- **Negativo informativo:** con el ancho mayor no hay diferencia sobre 150 fA y la corriente de prueba se vio: cota superior por
  micra de borde a 1,8 V. Para el pfet, además, se compara con la predicción del modelo.
- **Inconcluso:** diferencia que no escala con el ancho o que depende del largo.
- **Fallo instrumental:** el ficticio fuga más que las estructuras.
- **Muere a 1,8 V** si la cota superior queda por debajo de lo que haría falta para ser fuente útil; la familia pasa entonces al
  vehículo de 3,3 V, no se borra.

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

- Depende del lector de precarga (XC-26) o del de XC-19; de XC-31 para la firma térmica y de XC-32 como control.
- Comparte estructuras con XC-37 (borde acotado por puerta), XC-45 (corriente de óxido, control de polaridad invertida) y XC-46.
- Alimenta a XC-47 (`agidl = 0` en el nfet es una laguna declarada del modelo). Sin permisos a 1,8 V. Un chip basta.

## 8. Abierto y fuentes

- Magnitud real a 1,8 V `[?]`; el juicio "bajo a 1,8 V" de la ficha no tiene fuente leída.
- Por qué el modelo activa el término en el pfet y no en el nfet, y qué significan sus valores negativos: `[?]` (XC-47).
- Si la corriente de óxido de 4,148 nm (espesor usado en `FRONTERAS_FISICAS_1105.md`, laboratorio) compite a 1,8 V `[?]`.
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md). Corridas:
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md). Laboratorio, sin publicar:
  `macros/photon/LEEME.md`, `docs/pesca/PESCA_OPTO_1104.md`, `docs/EQUIPO.md`.
