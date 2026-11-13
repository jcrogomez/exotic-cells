# XC-37 · Retención variable

**Fusionada en XC-19 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-37 de [catálogo](../../README.md#catalogue) (Variable retention time).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-37 · Retención variable.** Un defecto en una unión conmuta su fuga entre dos niveles → nodo de difusión flotante precargado,
área y perímetro barridos → ninguna → tiempo de descarga, celda por celda y repetido → sensor de defecto, bit probabilístico lento →
el lector de XC-19 tal cual → arreglo de nodos frente a nodo con difusión mínima; en caliente. Piso: 150 fA; tamaño del salto `[?]`.
Aburrida: RTN del transistor de lectura, subumbral del interruptor. Conocido en DRAM (**fuente sin leer**). Juicio: posible; pide
arreglo grande.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** El piso de 150 fA no es del lector de XC-19 sino del lector de precarga de XC-26 (laboratorio, sin publicar). "El lector de XC-19 tal cual" era incorrecto: la lectura es por precarga y descarga.

## 2. Lectura y piso

Precarga y descarga: el nodo de difusión se carga a 1,8 V, se suelta, y se cuenta el tiempo hasta el umbral de un inversor. La
corriente que descarga es la fuga de la propia unión. Todo es modelo; nada de silicio.

| Cantidad | Valor | De dónde y grado |
|---|---|---|
| Piso de corriente del lector de precarga | 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF | `macros/photon/LEEME.md`, laboratorio, **sin publicar**, modelo |
| Fuga de una unión del modelo (9 µm², 12 µm de perímetro) | 6,5 fA a 27 °C; 11,5 pA a 85 °C. Término de saturación, no corriente oscura medida | mismo |
| Comportamiento del fondo | A 27 °C el nodo no cruza (se estanca en 1,36 V); a 85 °C cruza en 1,296 ms | mismo |
| Fuga del interruptor de precarga | `ebufn_1`: 32 fA / 0,41 pA (27 / 85 °C). pfet mínimo: 5,3 pA / 232 pA. pfet largo de umbral alto: 0,010 / 0,015 pA | `macros/photon`; `experiments/xc19_weak_inversion` (`explore.txt`), **corrida** exploratoria |
| Fuga del transistor de lectura apagado | 23 fA a Vg = 0, bajo los 32 fA de fuga que compite | `experiments/xc19_weak_inversion` (`budget.txt`), **corrida** |
| Tamaño del salto de una unión con defecto | `[?]`; conocido en DRAM, fuente **sin leer** | [pesca](../notas/PESCA_2026-11-12.md) |

- **Consecuencia:** a temperatura ambiente la unión fuga menos que el piso y menos que el interruptor; el experimento vive en
  caliente (la ficha ya lo dice), donde la fuga del modelo sube más de tres órdenes (**cálculo** sobre 6,5 fA y 11,5 pA).
- **Señal/piso:** `[?]`. Depende de qué fracción de la fuga total del nodo aporta un solo defecto: mayor cuanto menor la unión,
  pero menos probable que esa unión tenga defecto. Por eso el barrido de área y perímetro es el experimento, no un adorno.
- **Tiempo por lectura:** 100 fA tardan 164 ms en este nodo (laboratorio, modelo); las residencias visibles son de segundos o más.
- El lector de XC-19 con el dispositivo apagado es un lector de precarga, y su pfet largo de umbral alto es mejor interruptor.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| RTN del transistor de lectura o del inversor de umbral | Nodo ficticio: misma lectura e interruptor, difusión mínima y un condensador que iguala la capacidad |
| Subumbral del interruptor de precarga que cambia de nivel | El mismo ficticio; interruptor largo de umbral alto; variante con dos interruptores en serie |
| Deriva térmica: la fuga se multiplica con pocos kelvin | Las celdas vecinas se mueven juntas; un defecto mueve una sola celda, entre dos niveles discretos. Canal XC-31 |
| Alimentación mueve el umbral del inversor | Canal XC-32; lectura intercalada de la celda ficticia |
| Fuga de la unión del pozo, no de la unión dibujada | Variante n+ en pozo p (sin pozo n) frente a p+ en pozo n |
| Impacto de partícula (XC-49) | Un impacto es un suceso único; el defecto vuelve al mismo par de niveles |
| Artefacto de simulación tomado por predicción | `gmin` = 1e-18: con el valor por defecto ngspice inventa 1,8 pA por unión (laboratorio) |

## 4. Referencia convencional (control científico, no filtro)

No hay celda de biblioteca que sea "sensor de defecto de unión". Se compara en dos frentes:

- **Como bit probabilístico lento:** contra XC-19 (misma lectura, más rápida y con señal calculable) y contra XC-33.
- **Como unión:** contra los diodos del PDK (`diode_pw2nd_05v5`, `diode_pd2nw_05v5`), cuyo modelo da una fuga fija sin niveles.
  Un defecto que conmuta es justo lo que el modelo no tiene: residuo puro, de interés para XC-47.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: leer la fuente de DRAM (DOI en la [pesca](../notas/PESCA_2026-11-12.md), **sin leer**): amplitud del salto, fracción
   de celdas afectadas (de ella sale N, hoy `[?]`), dependencia con temperatura y campo.
2. Pendiente: sacar del PDK los parámetros de fuga de área, de perímetro y de borde de puerta de las uniones n+/pozo p y p+/pozo n,
   y calcular la fuga de cada variante de 5.2 a 27 y 85 °C. Predicción escrita antes de dibujar.
3. Hecho en el laboratorio: presupuesto del lector de precarga y fugas del interruptor (tabla).
4. Pendiente: simular el nodo con el interruptor largo de umbral alto de XC-19 en lugar del `ebufn_1`: nuevo piso.
5. Pendiente: bordes con `residual/drc_edge` (ancho mínimo de difusión: por buscar; medidos: p+ a n+ a 0 y desde 0,270 µm;
   difusión junto a puerta 0,250 y 0,275 µm). Toma de sustrato a menos de 15 µm (LU.2).
6. Pendiente: generador por script del nodo y del ficticio; DRC en los dos decks; extracción con área y perímetro (Magic extrae
   algunos diodos solo con área: comprobar, como pasó con el fotodiodo).

### 5.2 Configuraciones a dibujar

Todas las dimensiones son **propuesta**; el mínimo de cada una es el borde legal que dé `residual/drc_edge`.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Área a perímetro/área constante | Cuadrados de lado mínimo, ×3, ×10 | ¿El número de celdas con salto crece con el área? Defecto en el fondo de la unión |
| Perímetro a área constante | Cuadrado, tira de relación 1:10, peine | ¿Crece con el perímetro? Defecto en el borde del aislamiento |
| Tipo de borde | Rodeado de aislamiento frente a un lado acotado por puerta de poly | Defecto de borde de zanja frente a borde de puerta (liga con XC-38) |
| Polaridad | n+ en pozo p; p+ en pozo n | Trampas de electrones frente a huecos; separa la unión del pozo |
| Número de contactos | 1, 2, 4 sobre la misma difusión | ¿El contacto y su siliciuro crean el defecto? |
| Distancia al borde del pozo | Cerca del mínimo legal y lejos | Dopado no uniforme junto al pozo (liga con XC-13) |
| Orientación | 0° y 90° | Control: no debería importar; si importa es esfuerzo o litografía |
| Réplicas de la celda mínima | Tantas como quepan, N `[?]` | Es estadística: fracción de celdas con dos niveles |

Primero un canal completo: un nodo, su ficticio, su interruptor, su inversor y su contador. El arreglo, después.

### 5.3 En silicio

1. **Virgen:** tiempo de descarga de cada celda y de cada ficticio, a temperatura ambiente. Muchas no cruzarán: dato censurado.
2. **Calibrar:** corriente de prueba conocida y condensador de referencia conmutado sobre el nodo ficticio.
3. **Caracterizar en caliente** (placa o calefactor de XC-31): serie larga de tiempos de descarga por celda; histograma por celda.
4. **Barrer:** temperatura (la fuga térmica debe seguir su ley; anotar energía de activación por celda), tensión de precarga si
   el interruptor lo permite, tiempo entre precargas.
5. **Retener y repetir:** la misma celda otro día y tras ciclos térmicos; ¿los mismos dos niveles?
6. **Clasificar** cada celda: dos niveles discretos con residencias exponenciales, un nivel, no cruza, fallo de lector.
   Después: fracción con dos niveles frente a área y frente a perímetro.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** al menos una celda con dos niveles separados más de 5 σ del ruido de su ficticio, residencias exponenciales,
  vecinas en un solo nivel, y repetible otro día.
- **Negativo informativo:** ninguna celda de N conocidas muestra niveles, y el lector calibrado habría visto un cambio de fuga del
  tamaño prefijado en el prerregistro. Sin N y sin sensibilidad no informa.
- **Inconcluso:** niveles que aparecen también en el ficticio, o que siguen a la temperatura.
- **Fallo instrumental:** la corriente de prueba no se recupera, o las celdas no cruzan ni en caliente.
- **Muere** si en caliente la fuga del interruptor supera a la de la unión en todas las variantes: no hay forma de leer la unión.

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

- Es estadística y pide arreglo grande: choca con "un solo chip" y con el área de una tesela. Confirmar chips y celdas por tesela.
- Depende del lector de precarga (XC-26) o del de XC-19 con su interruptor largo; si fallan, cae.
- Necesita temperatura: XC-31 o placa caliente. Control de alimentación: XC-32.
- Comparte arreglo con XC-49 (los mismos nodos, otro análisis) y borde de puerta con XC-38.
- Sin permisos: no hay estrés ni reglas dudosas. La variante que crea defectos por estrés (XC-10) es otro plan, con permiso.

## 8. Abierto y fuentes

- Tamaño del salto y fracción de celdas afectadas en un proceso de 130 nm `[?]`.
- Corriente oscura real de las uniones de SKY130 `[?]` (ni el PDK ni la documentación leída la dan; `macros/photon`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md). Corridas:
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md). Laboratorio, sin publicar:
  `macros/photon/LEEME.md`. Lector: [`xc19_single_trap`](../xc19_single_trap/PLAN.md).
