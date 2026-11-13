# XC-22 · SPAD

**Fusionada en XC-21 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-22 de [catálogo](../../README.md#catalogue) (SPAD).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-22 · SPAD.** Avalancha Geiger → unión con guarda → polarización sobre ruptura → cuentas oscuras, eficiencia → detector de un
fotón → extinción y contador → tasa oscura frente a tensión. **Mantener en H/E:** misma dependencia que XC-21.

**[corregido 2026-11-13 08:17] Ronda de ataque 4 (optica)** Necesita bomba de 9-18 V (un agente). El agente propone otro vehiculo; no se decide sin Juan. Ver `experiments/RONDA_4_OPTICA_2026-11-13.md`.

## 2. Lectura y piso

Un SPAD ya entrega pulsos: cada avalancha es un flanco digital y se cuenta. Es la única familia óptica cuya lectura no pasa por
el lector de corrientes pequeñas. Lo que falta no es el instrumento sino la tensión.

| Cantidad | Valor | De dónde |
|---|---|---|
| Tensión de ruptura de las uniones del PDK | `bv` 11,7 a 12,8 V según la unión; pozo p/pozo profundo 12,636 V; parámetro de modelo | `PESCA_OPTO_1104.md` §1, laboratorio, sin publicar, **PDK** |
| Exceso de tensión sobre la ruptura | `[?]` | — |
| Tasa de cuentas oscuras en SKY130 | `[?]`: ninguna fuente hallada | — |
| Eficiencia de detección | `[?]` | — |
| Precedente de enlace emisor en avalancha + SPAD | Pocos Mbps, pocos nJ/bit, en 140 nm SOI; acoplo ~10⁻⁹ (divulgación, detalle `[?]`) | Agarwal 2018, solo resumen, laboratorio |
| Alternativa sin avalancha: piso del fotodiodo integrador | ≈ 150 fA a 27 °C (modelo) | `macros/photon/LEEME.md`, laboratorio, sin publicar |

Señal/piso: `[?]`. El piso de un SPAD es su tasa oscura, que no se conoce; sin ella no se sabe si mejora al fotodiodo.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Las cuentas son oscuras (generación térmica, túnel), no fotones | Emisor apagado; tasa frente a temperatura; SPAD gemelo bajo metal continuo |
| Pospulsos: cada cuenta dispara otras por carga atrapada | Histograma de intervalos entre cuentas; barrido del tiempo muerto de la extinción |
| Portadores del emisor que llegan por el sustrato y disparan la avalancha | Guarda conmutable; distancia; emisor en directa a igual corriente |
| La bomba inyecta pulsos en el contador | Contador con el SPAD desconectado y la bomba en marcha |
| Ruptura de borde, no de la zona activa: el dispositivo no entra en Geiger, conduce | Variantes con anillo de guarda y sin él: sin guarda debe fallar de forma reconocible |
| Diafonía óptica entre SPAD vecinos (la avalancha emite) | Dos SPAD a distancias distintas y correlación de sus cuentas; es además una medida de XC-21 |

## 4. Referencia convencional (control científico, no filtro)

El fotodiodo de 3 × 3 µm del PDK leído por precarga y descarga (XC-26), que funciona a 1,8 V y no necesita bomba. El SPAD
solo gana si su tasa oscura equivale a menos corriente que el piso del integrador, o si su respuesta en tiempo (un flanco por
fotón) permite separar fotones de portadores por el retardo, cosa que el integrador no puede. Como generador de aleatoriedad
compite con XC-33 (metaestabilidad y jitter), que cabe en celdas estándar.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): tensiones de ruptura de modelo; límite del pin analógico; ausencia de proyectos con SPAD
   en SKY130 en Tiny Tapeout (dos búsquedas).
2. Pendiente: buscar y leer una fuente con un SPAD medido en SKY130 o en 130 nm de volumen: estructura, guarda, tasa oscura.
   Sin esa lectura, todo número de esta familia es `[?]`.
3. Pendiente: decidir la unión multiplicadora (p+/pozo n, pozo n/sustrato, pozo p/pozo profundo) y el anillo de guarda con
   las capas disponibles; reglas de pozo profundo y de pozo n a alta tensión (borde legal por buscar).
4. Pendiente: circuito de extinción pasiva (resistencia de poly alta) y acoplo capacitivo al contador de 1,8 V; simulación
   con el diodo del PDK en ruptura solo para tiempos y márgenes de tensión, no para tasas.
5. Pendiente: la bomba (misma compuerta que XC-21) y el ajuste fino del exceso de tensión.
6. Pendiente: dibujar por script, DRC en los dos decks; anotar qué reglas de alta tensión no comprueba ninguno.

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**; las dimensiones de pozos a alta tensión, borde legal por buscar.

| Barrido | Valores | Pregunta |
|---|---|---|
| Diámetro de la zona activa | Tres tamaños, del mínimo que admita la guarda a ~10 µm | La tasa oscura escala con el área; la ruptura de borde, con el perímetro |
| Forma | Cuadrado, octógono, círculo aproximado en rejilla | Las esquinas adelantan la ruptura: ¿cuánta redondez hace falta? |
| Anillo de guarda | Sin anillo; pozo de dopado menor; separación virtual (hueco entre implantes) | Qué guarda, de las dibujables, evita la ruptura prematura del borde |
| Ancho del anillo de guarda | Tres valores | Compromiso entre factor de llenado y campo en el borde |
| Unión multiplicadora | p+/pozo n; pozo n/sustrato; pozo p/pozo profundo | Profundidad de la zona de multiplicación: decide a qué color responde |
| Resistencia de extinción | Tres valores de poly de alta resistencia | Tiempo muerto frente a pospulsos |
| Tapa | Sin metal; metal continuo; tapas de XC-27 | Gemelo ciego: separa cuentas ópticas de oscuras y de portadores |
| Distancia a un emisor (XC-21 o XC-26) | 5, 10, 20 µm y control a 40 µm | Enlace: caída con la distancia y retardo de llegada |

Primero un canal: un SPAD, su extinción, su gemelo ciego y un contador.

### 5.3 En silicio

Espera el mismo vehículo que XC-21: alta tensión interna. En él:

1. **Virgen:** con la bomba parada, fuga de cada unión a 1,8 V.
2. **Calibrar:** tensión de la bomba; el contador, con un generador de pulsos interno de tasa conocida.
3. **Caracterizar:** subir la tensión hasta que aparezcan cuentas: eso mide la ruptura. Tasa oscura frente a exceso de tensión.
4. **Barrer:** temperatura (la tasa oscura térmica crece mucho con ella; la de túnel, poco), tiempo muerto, alimentación.
5. **Observar:** con un emisor interno encendido, cuentas del SPAD abierto frente a su gemelo ciego; histograma de retardos
   respecto al flanco del emisor.
6. **Retener y repetir:** tasa oscura tras horas de operación; un SPAD puede degradarse.
7. **Clasificar:** Geiger con tasa oscura medida, ruptura de borde sin Geiger, sin ruptura alcanzable, fallo de bomba.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** cuentas discretas cuya tasa sube con el exceso de tensión, intervalos de Poisson fuera del tiempo muerto, y
  tasa oscura que equivale a menos corriente que el piso del fotodiodo integrador.
- **Negativo informativo:** la unión rompe pero conduce de forma continua en todas las guardas: en este proceso, con estas
  capas, no hay Geiger. O hay Geiger con tasa oscura tan alta que el fotodiodo integrador gana.
- **Inconcluso:** cuentas que no se separan de la conmutación de la bomba.
- **Fallo instrumental:** la bomba no llega a la ruptura.
- **Muere** si ninguna guarda dibujable evita la ruptura de borde, o si lo convencional (fotodiodo a 1,8 V) gana en piso.

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

- Vehículo H o especializado: bomba y dispositivos de alta tensión; misma auditoría que XC-21, XC-07 y XC-11.
- Permiso del shuttle para alta tensión interna `[?]`.
- Depende de XC-21 o XC-26 como emisor para la parte de enlace; la tasa oscura se mide sin ellos.
- El chip va encapsulado: sin emisor interno solo se mide en oscuridad, que para la tasa oscura es justo lo que hace falta.
- Estadística: la tasa oscura varía mucho entre dispositivos; con un solo chip, tantas réplicas como quepan.

## 8. Abierto y fuentes

- Tasa oscura, exceso de tensión útil y eficiencia en SKY130: `[?]`, sin fuente.
- Qué anillo de guarda se puede dibujar con las capas del PDK sin violar reglas: `[?]`.
- ¿Las partículas de XC-49 se verían como cuentas de un SPAD? Enlace posible entre familias, sin evaluar.
- Fuentes: `docs/pesca/PESCA_OPTO_1104.md` §1, §2, §4 (laboratorio, sin publicar); [pesca del 12-nov](../notas/PESCA_2026-11-12.md).
