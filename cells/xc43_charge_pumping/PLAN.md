# XC-43 · Bombeo de carga

**Fusionada en XC-19 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-43 de [catálogo](../../README.md#catalogue) (Charge pumping).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-43 · Bombeo de carga.** Cada trampa de interfaz transporta hasta una carga por ciclo cuando la puerta pasa de acumulación a
inversión → transistor pequeño con fuente y drenaje unidos y cuerpo accesible (pfet en pozo propio) → pulsos digitales en la puerta →
corriente f·q por trampa: 0,16 pA a 1 MHz, 1,6 pA a 10 MHz (**cálculo**), sobre el piso de 150 fA → contador de trampas, mismo
dispositivo que XC-19 visto por otro lado → integrador de XC-26 → frecuencia a la mitad da corriente a la mitad; dispositivo grande
como control. Condición: cuerpo a media alimentación `[?]`. Aburrida: componente geométrica, rectificación del acoplo de la puerta.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** Magic tiene una comprobación de pozo sin toma (`nwell_missing_tap`, `sky130A.tech` línea 1715): el cuerpo accesible debe ser una toma llevada a una red propia, no un pozo sin contacto.

## 2. Lectura y piso

Integrador de precarga y descarga (XC-26): la corriente bombeada carga o descarga un nodo y se cuenta el tiempo o el número de
ciclos hasta un umbral. Todo modelo; nada en silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Piso del integrador | 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF; a 85 °C manda la deriva del fondo | `NIGHT_SPRINT_2026-11-05.md` y `macros/photon`, **corrida** de modelo, laboratorio, sin publicar |
| Fuga del búfer triestado que cuelga del nodo | 32 fA a 27 °C; 0,41 pA a 85 °C | mismo origen, laboratorio, sin publicar |
| Señal por trampa | 0,16 pA a 1 MHz; 1,6 pA a 10 MHz (**cálculo**: f · q, una carga por ciclo como máximo) | ficha |
| Trampas de interfaz por dispositivo | `[?]`: el PDK no da densidad de estados de interfaz | — |
| Trampas de óxido visibles como RTN (otra población) | ~0,66 por década de residencia y dispositivo mínimo (**estimación**) | `docs/CLAIMS.md` |
| Lo que predice el modelo | Corriente de bombeo nula: BSIM4 no la incluye (**de memoria**; comprobar en el manual, sección de parámetros) | — |

Señal/piso: del orden de 1 por trampa a 1 MHz y de 10 a 10 MHz, si el piso modelado vale en silicio. Con N trampas la señal es N
veces mayor; N es justo lo que se quiere medir. A 85 °C el piso sube y la razón cae: se mide en frío.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Componente geométrica: portadores del canal que no vuelven a fuente y drenaje a tiempo y se recombinan en el cuerpo | Crece con el largo y con flancos rápidos: barrido de L y de tiempo de flanco. El dispositivo grande y largo es el control de la ficha |
| Rectificación del acoplo de la puerta por las uniones | Pulso de la misma amplitud desplazado para que no cruce de acumulación a inversión: el acoplo sigue, el bombeo no |
| Fuga de unión o del interruptor | No depende de la frecuencia: la corriente a frecuencia cero debe extrapolar a la fuga medida con la puerta quieta |
| Inyección de carga del interruptor del integrador | Canal fantasma: integrador sin dispositivo, mismo reloj |
| Corriente de puerta | El modelo la tiene apagada (`igcmod = 0`, **PDK local**); se separa porque no depende de la frecuencia |
| Es un condensador conmutado: C · V · f también es lineal en f | Depende de la amplitud V; el bombeo satura en cuanto el pulso cruza los dos umbrales. Barrido de amplitud |

## 4. Referencia convencional (control científico, no filtro)

Como fuente de corriente de pA proporcional a la frecuencia: un condensador conmutado dibujado en metal, que da C · V · f con C
conocida y sin depender de defectos. Si solo se quiere esa corriente, gana el condensador. El bombeo ofrece otra cosa, que la
biblioteca no tiene: contar los estados de interfaz de un transistor concreto, antes y después de envejecerlo (XC-10), y cruzar esa
cuenta con el RTN del mismo dispositivo (XC-19). Como instrumento de medida no tiene equivalente en celdas estándar.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer: una fuente primaria del método (Groeseneken 1984, **de memoria**, sin leer) para la forma exacta de la corriente frente a
   amplitud, flancos y frecuencia, y una con bombeo de carga en dispositivos pequeños donde se cuenten trampas una a una `[?]`. No
   hay ninguna en la pesca: el juicio de viabilidad (segunda más probable) no cita fuente abierta propia.
2. Buscar en el PDK: densidad de estados de interfaz (no hay parámetro; `nfactor` = 2,63 en `nfet_01v8` es la pendiente de
   subumbral, no una densidad; **PDK local**, `libs.ref/sky130_fd_pr/spice/sky130_fd_pr__nfet_01v8__tt.pm3.spice`); tensión de
   banda plana y umbral del `pfet_01v8` para saber si un pulso de 0 a 1,8 V con el pozo a media alimentación cruza los dos `[?]`.
3. Decidir cómo se obtiene el pozo a media alimentación en flujo digital: divisor de transistores, cadena de diodos como la de
   `xc19_bias`, o el propio pozo flotante de XC-42 (que el bombeo cargaría: entonces se lee el pozo, no una corriente).
4. Comprobar la regla del pozo: pozo propio con toma unida a un nodo interno, no a la alimentación (nwell.4 pide toma "conectada
   por metal"; **PDK local**, `sky130A.tech`, línea 4205). Misma sonda de `residual/drc_edge` que XC-42.
5. Simular el canal completo sin bombeo (el modelo no lo tiene): da acoplo, fuga e inyección, es decir, la línea de base aburrida
   con su dependencia de frecuencia y amplitud. Predicción escrita: en simulación, pendiente nula frente a f salvo acoplo.
6. Inyectar a mano f · q · N como fuente de corriente y hallar el N mínimo detectable a cada frecuencia.
7. Dibujar por script; DRC en los dos decks; extraer; LVS con fuente y drenaje unidos.

### 5.2 Configuraciones a dibujar

Dimensiones propuestas, sin evaluar; el pozo propio desde 0,84 µm de ancho y 1,27 µm de separación (**PDK local**).

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Área de puerta W × L | 0,42/0,15; 0,42/0,50; 1,0/0,15; 5,0/0,15; 5,0/5,0 | La corriente debe escalar con el área (número de trampas); en el mínimo deberían verse escalones enteros de f · q |
| Largo a ancho fijo | 0,15; 0,5; 2; 8 µm | La componente geométrica crece con L: la separa de las trampas |
| Perímetro frente a área | Un transistor ancho frente a muchos dedos de igual área | ¿Las trampas están en el canal o en el borde con el aislamiento? (liga con XC-46) |
| Réplicas del mínimo | Tantas como quepan `[?]` | Distribución del número de trampas por dispositivo |
| Tipo | pfet en pozo propio; nfet (cuerpo = sustrato, sin lectura separada) | El nfet solo sirve si la corriente se lee por fuente y drenaje |
| Largo de difusión | 0,30 y 3,0 µm | ¿El esfuerzo cambia la densidad de interfaz? (matriz con XC-12) |
| Mismo dispositivo que XC-19 | Un transistor conmutable entre lector de RTN y bombeo | ¿Coinciden las trampas vistas por los dos métodos? |
| Nodo de lectura | Pozo (corriente de cuerpo) frente a fuente y drenaje | Debe ser la misma corriente con signo opuesto: control interno |

Primero un canal: un pfet de 5,0/0,15 (más trampas, señal mayor) en pozo propio, con integrador y fantasma.

### 5.3 En silicio

1. **Virgen:** corriente del nodo con la puerta quieta en alto y en bajo: fuga de base.
2. **Calibrar:** un condensador conmutado dibujado, de capacidad extraída, en un canal idéntico: da C · V · f conocida y con ella la
   escala del integrador.
3. **Caracterizar:** pulsos de 0 a 1,8 V en la puerta; corriente frente a frecuencia en décadas. Pendiente = q · N.
4. **Barrer:** frecuencia (lineal, y a la mitad debe dar la mitad), ciclo de trabajo, tiempo de flanco si el generador lo permite,
   tensión del pozo, alimentación, temperatura.
5. **Cruzar** con XC-19 en el dispositivo compartido y, con permiso, repetir tras envejecer (XC-10): N debe subir.
6. **Repetir** otro día y **clasificar** cada canal.

No hay transformación propia; la de XC-10 es otro plan y necesita permiso de estrés.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** corriente lineal en frecuencia con ordenada igual a la fuga, que desaparece al desplazar el pulso, escala con el
  área y, en los dispositivos mínimos, toma valores cercanos a múltiplos enteros de f · q.
- **Negativo informativo:** el canal de calibración por condensador conmutado se ve y el bombeo queda bajo el piso: cota superior
  de N por dispositivo.
- **Inconcluso:** corriente lineal en f que no desaparece al desplazar el pulso (acoplo rectificado) o que crece con L (geométrica).
- **Fallo instrumental:** el condensador conmutado de calibración no da la corriente calculada.
- **Muere** si el pulso de 0 a 1,8 V no cruza de acumulación a inversión con ninguna tensión de pozo alcanzable.

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

- Depende del integrador de XC-26 (piso modelado, sin silicio) y del pozo propio accesible de XC-42 (compuerta de DRC y LVS).
- Necesita una tensión de pozo intermedia generada en el chip; comparte la celda de polarización con XC-19.
- Sirve a XC-19 (misma población de defectos vista por otro lado), a XC-10 (monitor de envejecimiento) y a XC-46.
- Vehículo: flujo digital a 1,8 V. Todo son pulsos digitales; la corriente se integra dentro del macro.
- Sin permisos, salvo el cruce con XC-10. Es estadística por dispositivo, no por chip: un chip con réplicas informa.

## 8. Abierto y fuentes

- Densidad de estados de interfaz de SKY130 `[?]`. ¿Cuántas trampas tiene un dispositivo mínimo? `[?]`
- ¿Cruza un pulso de 1,8 V las dos condiciones? Depende de banda plana y umbral: por simular.
- ¿Vale en silicio el piso de 150 fA? Es de modelo, y con el gmin por defecto sale 50 veces peor (laboratorio, sin publicar).
- La ficha da "cuerpo a media alimentación `[?]`": sin fuente; sale del paso 2 de 5.1.
- PDK local: ciel, versión `8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, carpeta `sky130A/` (en `local_flow/pdk_host`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md), sección 3. Cifras: [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
