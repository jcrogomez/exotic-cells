# XC-27 · Nanohoyos

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-27 de [catálogo](../../README.md#catalogue) (Metal hole arrays).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-27 · Nanohoyos.** Transmisión por aperturas subonda → red de hoyos en met1 (periódica, desordenada, aperiódica) sobre un
fotodiodo → luz externa → fotocorriente frente a placa sólida y sin metal → filtro óptico por layout → píxel con color → tres redes
y dos controles. **Mantener en E:** paso mínimo 0,28 µm → pico ~0,41 µm (cálculo, ficha 5); el encapsulado tapa la luz y el relleno
tapa la red. Familia de motor P por excelencia: se conserva aunque no haya función a la vista. Sin método de medida no ocupa silicio.
**Variante por reflexión (idea de Juan, 2026-11-12):** el emisor y el fotodiodo de XC-26 están en el silicio y la red queda encima;
la luz que escapa hacia arriba rebota en el metal y vuelve. Cinco tapas sobre el mismo par a la misma distancia: sin metal, metal
liso, periódica, desordenada y aperiódica (sombrero). Portadores y luz directa por el sustrato son iguales en las cinco: la
diferencia es del metal. El paso debe ser comparable a la longitud de onda en el óxido (~0,76 µm para 1100 nm, **cálculo**), no el
mínimo, o las tres redes se comportan como un espejo liso. Lectura: fotocorriente por precarga, piso modelado 150 fA. Explicación
aburrida: el metal solo apantalla o cambia el acoplamiento capacitivo. Depende de que XC-26 emita y de poder bloquear el relleno
`[?]`. Un revisor de la búsqueda la juzga improbable (domina el paso por el sustrato); queda sin filtrar. El sombrero entra aquí
solo con hipótesis electromagnética: espectro de difracción denso frente a órdenes discretos.

**[corregido 2026-11-13 08:17] Ronda de ataque 4 (optica)** Transformada, verificado al orden: la tapa solo toca el cono de escape (3,7-4,9 % de lo recogido); tapa lisa +1,2-4 %; redes <= 3-4 % (sin RCWA). Requiere senal >= 5 pA (XC-26 con rho ~1) y apareamiento < 1 % entre copias. Ver `experiments/RONDA_4_OPTICA_2026-11-13.md`.

## 2. Lectura y piso

Dos variantes, dos lecturas. **Reflexión (vehículo D):** el par emisor–fotodiodo de XC-26 con cinco tapas; se lee la
fotocorriente por precarga y descarga y se comparan tapas. **Transmisión (vehículo especializado):** luz externa sobre el dado.

| Cantidad | Valor | De dónde |
|---|---|---|
| Piso del lector | ≈ 150 fA a 27 °C, 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF (modelo) | `macros/photon/LEEME.md`, laboratorio, sin publicar |
| Señal de base (la de XC-26 sin tapa) | `[?]`: la emisión en directa a 1,8 V no está cuantificada | `PESCA_PHOTON_1105.md`, laboratorio |
| Diferencia entre tapas | `[?]`. Juicio de un revisor: improbable, domina el paso por el sustrato; sin fuente abierta | [pesca](../notas/PESCA_2026-11-12.md) |
| Longitud de onda en el óxido | ≈ 0,76 µm para 1100 nm (**cálculo** de la ficha) | sección 1 |
| Emisión de una unión de silicio | Pico ≈ 1100 nm, ancho 150–190 nm en el emisor de filamento de 55 nm; en nuestra unión `[?]` | Li 2023, leído en el laboratorio |
| Pila sobre el silicio | Óxido bajo li1 0,5 µm; li1 0,1 µm; met1 0,35 µm; altura de met1 sobre el silicio `[?]` | `FRONTERAS_FISICAS_1105.md`, tabla de proceso |
| Paso mínimo en met1 | 0,28 µm (0,14 + 0,14); pico de transmisión (1,0) ≈ 0,41 µm; con paso 0,40–0,45, 0,58–0,69 µm | idem, ficha 5, **cálculo**; m1 0,140 **corrida** |
| Índice del óxido de la pila | `[?]` (≈ 1,46 sin citar; cuarzo 1,544) | idem |

Señal/piso: `[?]` sobre `[?]`. La variante hereda la incógnita de XC-26 y añade la suya. Si XC-26 no ve luz, esta no se lee.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| La tapa añade capacidad al nodo de lectura: el tiempo cambia sin que cambie la corriente | Redes con igual fracción de metal y potencial; corriente de prueba por canal; lectura con el emisor apagado |
| La tapa apantalla el acoplo eléctrico del emisor al nodo | Emisor de control a 40 µm bajo la misma tapa; ficticio óhmico |
| El metal encima cambia la unión misma (carga de plasma, recocido): otra corriente oscura | Fondo de cada tapa con el emisor apagado: es un resultado de ruta A por sí mismo |
| Toda red se comporta como un espejo liso | Es la hipótesis nula, no un artefacto: la tapa lisa es su control; por eso el paso va cerca de 0,76 µm y no al mínimo |
| El relleno automático cae sobre la tapa «sin metal» y la convierte en un espejo al azar | Bloqueo de relleno `[?]`; si no se puede, la quinta tapa se define como «lo que el relleno ponga» y se lee del GDS final |
| Portadores y luz directa por el sustrato | Iguales en las cinco por construcción; se cancelan en la diferencia entre tapas, no en el valor absoluto |
| Calor: el metal encima cambia la disipación del emisor | Tapa lisa y redes tienen casi el mismo metal; el calefactor ficticio bajo cada tapa |

## 4. Referencia convencional (control científico, no filtro)

Como filtro o espejo: una placa continua de met1, que cualquiera dibuja. La red solo gana si devuelve al fotodiodo más luz
que la placa lisa (o menos, de forma controlada) y si eso depende del paso. Como acoplador, el convencional es acercar el
fotodiodo al emisor, y eso tiene un tope legal (5 µm por la regla nwell.7). La variante de transmisión se compara con un
filtro de color externo y con un fotodiodo desnudo. El sombrero se compara con la red periódica y con la desordenada de la
misma densidad: si no se distingue de la desordenada, no aporta.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): cálculo de pasos y picos para transmisión; lista de lo que la descarta (luz, relleno,
   resolución espectral, cavidad con el silicio).
2. Hecho: el par emisor–fotodiodo sobre el que van las tapas existe y pasa DRC (XC-26).
3. Pendiente, lo primero: geometría de rayos, a mano. El silicio tiene un índice alto y solo un cono estrecho sale al óxido
   (ángulo `[?]`). Un espejo liso a la altura de met1 devuelve esa luz casi al punto de partida, lejos de un fotodiodo a 5 µm.
   Predicción a escribir antes de simular: el espejo liso no ayuda; la red solo ayuda si difracta hacia ángulos rasantes
   o hacia el modo guiado entre silicio y metal. Si la cuenta dice que ni así llega, se anota y se sigue: decide el silicio.
4. Pendiente: altura de met1 sobre el silicio y los índices, del PDK o de su documentación.
5. Pendiente: simulación electromagnética en dos dimensiones (herramienta abierta por elegir) de emisor puntual bajo la
   superficie, óxido y tapa, para las cinco tapas; con la predicción del paso 3 delante.
6. Pendiente: generador por script de las tres redes con fracción de metal idéntica; el generador del sombrero está en la
   investigación de Hat87, por localizar `[?]`. DRC en los dos decks: ancho y espacio de met1 0,140; área mínima de isla y de hueco, borde
   legal por buscar con `residual/drc_edge`.
7. Pendiente: averiguar si se puede bloquear relleno y trazado sobre la tapa en el flujo de Tiny Tapeout `[?]`.
8. Pendiente (transmisión): saber si existe algún modo de iluminar el dado; hoy no (chip encapsulado, sin dados desnudos).

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**. Todas las tapas van sobre copias del mismo par, a la misma distancia y orientación.

| Barrido | Valores | Pregunta |
|---|---|---|
| Tipo de tapa (el experimento base) | Sin metal; lisa; periódica; desordenada; aperiódica (sombrero) | ¿La estructura del metal cambia la luz que vuelve, a igual todo lo demás? |
| Paso de la red periódica | 0,28 (mínimo); 0,40; 0,76; 1,5 µm | Solo cerca de 0,76 µm debe haber difracción a 1100 nm; el mínimo debe igualar a la tapa lisa |
| Fracción de metal a paso fijo | 25 %; 50 %; 75 % | Separa «cuánto metal» de «cómo está ordenado»; fija también la capacidad |
| Orientación de la red periódica | Vector de red paralelo al eje emisor–fotodiodo; a 45°; perpendicular | Una red difracta en su dirección: girarla debe apagar el efecto. El desorden y el sombrero no deben notar el giro |
| Red de una dimensión (tiras) | Tiras perpendiculares y paralelas al eje | El caso más simple de calcular y el control más limpio de la orientación |
| Capa de la tapa | poly; li1; met1; met2 | Altura del espejo sobre el silicio: cambia la fase y el alcance lateral del rebote |
| Extensión de la tapa | Solo sobre el emisor; solo sobre el fotodiodo; sobre el camino; sobre todo | Dónde actúa: al extraer la luz, al guiarla o al meterla en el detector |
| Distancia del par | 5; 10; 20 µm | Luz guiada bajo la tapa decae distinto que la directa por el sustrato |
| Tapa doble | met1 con red y met2 liso encima | Cierra la fuga hacia arriba: ¿sube la señal en las redes y no en la lisa? |
| Transmisión (otro vehículo) | Red periódica de paso 0,28; 0,40; 0,45 µm; placa sólida; sin metal | Picos a 0,41 y 0,58–0,69 µm frente a fracción de área del 25 % |

Primero un canal: un par con tapa lisa y un par sin tapa. Si no se distinguen entre sí ni del fondo, las redes no se dibujan.

### 5.3 En silicio

Variante por reflexión, en el flujo digital:

1. **Virgen:** fondo de los fotodiodos bajo cada tapa, con todo apagado. Diferencias aquí son efecto del metal sobre la unión.
2. **Calibrar:** corriente de prueba y capacidad de cada nodo; cada tapa cambia la capacidad y hay que medirla, no suponerla.
3. **Caracterizar:** tríos intercalados (emisor, emisor de control, nada) bajo cada tapa; cociente de cada tapa con la lisa.
4. **Barrer:** corriente del emisor (el cociente entre tapas no debe depender de ella), temperatura (el borde de absorción
   del silicio se mueve y con él el color que se detecta: una red periódica debería notarlo y una lisa no).
5. **Repetir:** copias de la misma tapa en dos sitios del dado, para saber cuánto vale la diferencia entre copias iguales.
6. **Clasificar** cada tapa frente a la lisa: distinta, igual dentro del error de copias, bajo el piso, fallo.

Variante por transmisión: espera acceso óptico al dado y una fuente de banda estrecha entre 0,4 y 0,7 µm. La secuencia
sería fondo, placa sólida, sin metal y cada red, con la fuente barrida en color.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** al menos una red difiere de la tapa lisa más que dos copias iguales entre sí, la diferencia depende del paso
  y, en la periódica, de la orientación. Para el sombrero: difiere de la desordenada de igual densidad.
- **Negativo informativo:** XC-26 ve luz (la tapa lisa difiere de la sin metal) y las tres redes igualan a la lisa: a estos
  pasos y alturas, el metal es un espejo.
- **Inconcluso:** XC-26 no separa luz de portadores; entonces esta familia no ha sido probada, no refutada.
- **Fallo instrumental:** las copias de una misma tapa difieren tanto como las tapas entre sí.
- **Muere** la variante por reflexión si la tapa lisa y la sin metal son indistinguibles con el emisor al máximo. La de
  transmisión no puede morir en este vehículo: sin método de medida no ocupa silicio.

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

- Depende de XC-26 (que haya luz) y de XC-23 (curva de portadores). Es, a la vez, el mejor control óptico de XC-26, XC-21 y
  XC-50: una tapa cambia la luz y no los portadores.
- Bloqueo de relleno y de trazado sobre las tapas: sin regla pública hallada `[?]`. Metal 5 reservado: queda siempre encima.
- Cinco pares por barrido cuestan área: cada par con su anillo mide 86,8 × 22,4 µm en el laboratorio. Decidir cuántos caben.
- Vehículo: D para reflexión; especializado (luz sobre el dado) para transmisión.
- El sombrero entra con hipótesis electromagnética escrita antes: espectro de difracción denso frente a órdenes discretos.

## 8. Abierto y fuentes

- ¿Sale luz del silicio hacia arriba en cantidad útil, y vuelve a un fotodiodo a 5 µm? Sin cuenta hecha.
- Con emisión ancha (150–190 nm en la fuente de 55 nm) y un detector que integra, los órdenes discretos de la periódica pueden
  promediarse y parecerse al sombrero: la diferencia entre ambas puede no ser observable aunque exista.
- Idoneidad del aluminio y composición de li1 (¿nitruro de titanio?) como espejos a 1100 nm: `[?]`.
- Forma del índice de orden en la condición de los picos: la fuente leída escribe √(i+j); la habitual es √(i²+j²) `[?]`.
- Fuentes: `docs/FRONTERAS_FISICAS_1105.md`, ficha 5; `macros/photon/LEEME.md`; `docs/pesca/PESCA_PHOTON_1105.md`
  (laboratorio, sin publicar); [pesca del 12-nov](../notas/PESCA_2026-11-12.md); Ebbesen 1998 (solo resumen).
