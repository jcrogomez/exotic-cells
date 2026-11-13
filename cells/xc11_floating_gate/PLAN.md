# XC-11 · Compuerta flotante de un poly

**Fusionada en XC-14 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-11 de [catálogo](../../README.md#catalogue) (Single-poly floating gate).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-11 · Compuerta flotante de un poly.** Inyección y túnel hacia un poly aislado → poly flotante con condensador de control →
inyección a 4,0 V, túnel a 8,0 V (fuente del catálogo) → ΔVth → memoria no volátil reprogramable → celda EEPROM → programar y
borrar. **Mantener en H:** necesita bomba de carga. Función conocida: valor por estar abierta, no por novedad.

## 2. Lectura y piso

El transistor de lectura bajo el poly flotante, leído con el lector en inversión débil de XC-19 mientras se barre la puerta de
control.

| Cantidad | Valor | De dónde |
|---|---|---|
| Tensiones de programación | inyección 4,0 V; túnel 8,0 V | ficha (catálogo del laboratorio, «Georgia Tech, sky130»); la fuente es Chen, Sonnadara, Shah 2024, **sin leer**, cifras `[?]` en la pesca |
| Sensibilidad del lector | 0,83 a 0,84 % por 0,305 mV en la puerta | [`CLAIMS.md`](../../docs/CLAIMS.md), **corrida** de modelo |
| Desajuste de umbral | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15) | mismo |
| Espesor de óxido | 4,148 nm (nfet), 4,23 nm (pfet), 11,6 nm (5 V) | modelos del PDK, `PESCA_PHOTON_1105.md`, laboratorio, sin publicar |
| Condensador MiM | 2 fF/µm² entre met3 y met4 | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Regla de antena para poly | 50 | misma pesca, **leído por agente** |
| Carga inicial de fábrica en el poly | `[?]` | — |
| Retención a través de 4,2 nm | `[?]` | — |

Señal/piso: el poly flotante es la puerta del transistor de lectura, así que su tensión entra entera en el lector. Un
desplazamiento de memoria útil estaría muy por encima del piso. A 1,8 V no se programa; sí se lee el estado con que nace cada
celda y cuánto dura.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El poly no guarda carga: su potencial lo fija el acoplo con los vecinos | Barrer la puerta de control y medir la relación de acoplo; plano de blindaje encima en una variante |
| La carga es de fábrica (plasma), no escrita | Lectura virgen de todas; variantes con distinta antena (XC-14) |
| El poly se descarga por el óxido o por el condensador de control | Retención del estado virgen en días, por tipo de condensador |
| Diferencia de umbral entre transistores | Gemelo de la misma geometría con el poly unido a la puerta de control |
| El pulso de programación movió el lector | Ruta de programación aparte; lector comprobado con el gemelo después |
| El cambio es atrapamiento en el óxido, no carga en el poly (XC-09) | El gemelo con poly conectado recibe el mismo pulso |

## 4. Referencia convencional (control científico, no filtro)

SONOS del propio proceso, con +6,7 y −3,8 V (**leído por agente**), y fuera de él una memoria externa. Dentro de la biblioteca
digital, un biestable (volátil) o un fusible (una escritura). La función es conocida; la ficha ya dice que su valor es que la
celda esté abierta, no que sea nueva.

Tendría que mostrar: retención y ciclos documentados en una celda de un solo poly con capas estándar, a tensión menor o área menor
que la bomba que SONOS necesita. Hay un diseño de bombas para SONOS en Tiny Tapeout (+7,4 y −4,5 V desde 3,3 V, solo simulación;
**leído por agente**).

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente y primero: leer la fuente (DOI 10.1049/ell2.70036). Sin ella no hay geometría, tensiones ni retención de referencia.
2. Pendiente: dibujar por script la celda mínima (transistor de lectura, poly flotante, condensador de control) y pasarla por los
   dos decks. Comprobar qué dice cada uno de un poly sin contacto.
3. Pendiente: bordes legales con [`drc_edge`](../../residual/drc_edge/README.md): extensión de poly sobre óxido de campo,
   separaciones poly–difusión. Hoy: borde legal por buscar.
4. Pendiente: extraer y ver cómo trata Magic una puerta flotante (LVS con un nodo sin conexión) y qué capacidad de acoplo da.
5. Pendiente: simular la lectura con el poly como nodo de carga fija, para varias relaciones de acoplo. Predicción escrita antes.
6. Pendiente: buscar en el modelo del PDK la corriente de puerta; sin ella no hay retención simulable `[?]`.
7. Pendiente: primer cálculo de una bomba hasta 8 V (área, corriente), compartido con XC-07.

### 5.2 Configuraciones a dibujar

Valores: **propuesta**. Todas las dimensiones propias de la celda: borde legal por buscar.

| Barrido | Valores | Pregunta |
|---|---|---|
| Relación de acoplo (área de control / área de lectura) | 2; 5; 10; 20 | Cuánta de la tensión de control llega al poly; fija la tensión de programación necesaria |
| Tipo de condensador de control | poly sobre pozo n aparte; MiM met3/met4 unido al poly; metal en peine | Fuga y área. El que une metal al poly cambia la carga de plasma |
| Poly solo frente a poly con metal | flotante sin ningún contacto frente a con contacto y metal | Un poly que nunca toca metal recoge menos carga de fábrica: ¿nace neutro? |
| Antena del nodo flotante | varias, hasta el límite legal de poly | Estado inicial frente a geometría de fabricación (XC-14) |
| Perímetro de poly sobre óxido de campo | compacto frente a serpenteante de igual área | ¿La pérdida de carga es por el borde o por el área? |
| Tipo de transistor de lectura | pfet (el de la fuente) y nfet | Polaridad de inyección y de lectura |
| Óxido | 1,8 V (4,2 nm) frente a 5 V (11,6 nm) | Retención contra tensión de programación |
| Área de túnel | pequeña aparte frente a la del propio transistor | Separar la ruta de borrado de la de lectura |
| Blindaje | placa de metal encima a potencial fijo frente a nada | Quita el acoplo con el enrutado vecino |
| Distancia al borde del pozo | cerca y lejos | Efecto de proximidad sobre el transistor de lectura (XC-13) |

Primero un canal: una celda, su gemela con el poly conectado y el lector.

### 5.3 En silicio

1. **Virgen** (cabe hoy): umbral aparente de cada celda frente a su gemela; es el estado de carga de fábrica.
2. **Calibrar:** escalón conocido en la gemela; relación de acoplo medida barriendo la puerta de control entre 0 y 1,8 V.
3. **Caracterizar:** retención del estado virgen durante semanas, a temperatura ambiente y en placa caliente.
4. **Transformar** (otro vehículo): inyección y túnel con las tensiones de la fuente, por una ruta con llave, pulsos crecientes y
   lectura entre pulsos.
5. **Observar:** desplazamiento frente a pulsos; ventana entre programado y borrado.
6. **Retener y repetir:** horneado; ciclos de programación y borrado hasta que la ventana se cierre.
7. **Clasificar:** no flota (se descarga sola); flota y retiene el estado de fábrica; programable; programable y borrable; fallo
   de lector.

Vehículo que espera: híbrido con bomba de carga interna; el raíl de 3,3 V no llega a los 4,0 V de inyección de la ficha.

### 5.4 Criterio de muerte (borrador)

- **Positivo, parte digital:** celdas cuyo estado de fábrica difiere de la gemela por encima del desajuste y se retiene semanas.
- **Positivo, completo:** ventana de programación y borrado retenida tras horneado y repetible en ciclos.
- **Negativo informativo:** el poly flotante se iguala con la gemela en un tiempo medido: la fuga del óxido de 4,2 nm no deja
  memoria, con su constante de tiempo.
- **Inconcluso:** diferencias del orden del desajuste; acoplo con vecinos sin separar.
- **Fallo instrumental:** el lector no ve el escalón de la gemela.
- **Sigue en espera** mientras no haya bomba. Muere si la retención medida es de horas.

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

- Vehículo: híbrido con bomba. En el digital viaja virgen y da estado de fábrica y retención sin permiso especial.
- Comprobar antena, relleno y LVS con un nodo flotante; el precheck de Tiny Tapeout no corre antena para sky130A (**leído por
  agente**).
- Depende del lector de XC-19. Comparte la bomba con XC-07 y la carga de plasma con XC-14 y XC-15. XC-09 es su control de
  atrapamiento.
- Auditoría de alta tensión de todo lo que toque el nodo de programación.

## 8. Abierto y fuentes

- Todo lo que diga la fuente: geometría, tensiones, retención, ciclos `[?]` (**sin leer**).
- De dónde salen los 4,0 y 8,0 V de la ficha: el catálogo del laboratorio los da sin cita de página.
- Fuga del óxido de 1,8 V y carga inicial de fábrica `[?]`.
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md) (puerta flotante en SKY130, SONOS, antena, MiM). Cifras del lector:
  [`CLAIMS.md`](../../docs/CLAIMS.md).
