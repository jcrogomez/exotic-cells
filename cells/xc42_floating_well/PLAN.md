# XC-42 · Transistor de pozo flotante

**Fusionada en XC-14 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-42 de [catálogo](../../README.md#catalogue) (Floating-well transistor).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-42 · Transistor de pozo flotante.** Un pozo n sin toma queda al potencial que fijan sus fugas → pfet en pozo propio sin
contacto → ninguna, o precarga del pozo por un interruptor → umbral por efecto cuerpo, con memoria lenta → celda dinámica, sensor de
fuga o de luz → anillo o lector → gemelo con toma. Señal: decenas de mV `[?]` (**de memoria**). Aburrida: es solo efecto cuerpo.
Riesgos: latch-up, LVS y precheck (pozo sin toma); comprobar antes de dibujar.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** Magic tiene una comprobación de pozo sin toma (`nwell_missing_tap`, `sky130A.tech` línea 1715): un pozo sin contacto no pasa DRC tal cual. La variante viable es una toma unida a un interruptor.

## 2. Lectura y piso

Dos lecturas posibles. Anillo cuyos pfet viven en el pozo bajo prueba (grueso, robusto), o lector en inversión débil con un pfet
como dispositivo (fino). En los dos casos, cociente contra el gemelo con el pozo unido a la alimentación. Todo modelo.

| Cantidad | Valor | De dónde |
|---|---|---|
| Paso del lector en inversión débil | 0,83 % por 0,305 mV de umbral (medido en modelo con nfet; con pfet `[?]`) | `experiments/xc19_weak_inversion/budget.txt`, **corrida** |
| Cambio de umbral esperado | decenas de mV `[?]` (**de memoria**) | ficha |
| Coeficiente de efecto cuerpo | k1 = 0,43 en `pfet_01v8`; 0,54 en `nfet_01v8` (valor global; los modelos binados lo corrigen) | **PDK local**, `libs.ref/sky130_fd_pr/spice/sky130_fd_pr__pfet_01v8__tt.pm3.spice` y `…__nfet_01v8__tt.pm3.spice` |
| Dispersión de umbral entre iguales | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15), nfet | `docs/CLAIMS.md`, **corrida** |
| Potencial de equilibrio del pozo | `[?]`: lo fija el balance entre las uniones p+/pozo y la unión pozo/sustrato | — |
| Tiempo de relajación del pozo | `[?]` | — |

Si las decenas de mV valen, la señal son decenas de pasos del lector: sobra. El problema no es el piso sino la dispersión: el
cambio esperado es del tamaño del desajuste entre dos transistores mínimos, así que se compara cada dispositivo consigo mismo (pozo
precargado frente a pozo relajado), no con el gemelo.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Es solo efecto cuerpo con una tensión de cuerpo desconocida | Gemelo con toma: se le impone la tensión de pozo con un interruptor y se obtiene la misma curva. Si coincide, el pozo flotante es un nodo dinámico, no un dispositivo nuevo |
| Desajuste entre dispositivo y gemelo | El mismo dispositivo, antes y después de precargar el pozo |
| El pozo no flota: lo sujeta la fuga del interruptor de precarga | Variante sin interruptor (pozo sin ningún camino) frente a variante con interruptor siempre abierto |
| Acoplo capacitivo de la fuente y el drenaje al pozo al conmutar | Lectura estática (lector) frente a dinámica (anillo); pozo grande frente a pequeño |
| Corriente al sustrato por el bipolar parásito, que altera a los vecinos | Fantasma: anillo vecino en pozo normal, a distancias barridas |
| Temperatura (las fugas la siguen) | Canal de temperatura (XC-31); la relajación debe acelerarse al calentar |

## 4. Referencia convencional (control científico, no filtro)

Un pfet en pozo propio con el pozo unido a un nodo controlado: práctica convencional, con el efecto cuerpo en el modelo. Como celda
dinámica: un condensador de puerta con un interruptor (XC-37). Como sensor de luz: el fotodiodo de pozo de XC-26. Como sensor de
fuga: la celda de precarga y descarga de XC-26. El pozo flotante solo gana si el equilibrio que fijan las fugas da algo que un nodo
controlado no da: una referencia que se ajusta sola, una memoria de segundos sin refresco, o más sensibilidad a la luz por área.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer: el texto de las reglas nwell.4 y LU.3 en la documentación de periferia y qué comprueba el precheck de Tiny Tapeout sobre
   pozos (la pesca dice que no corre LVS; **leído por agente**). Una fuente sobre cuerpo flotante en CMOS de sustrato
   (los efectos conocidos son de SOI) `[?]`: no hay ninguna en la pesca.
2. Buscar en el PDK (hecho en parte): Magic, con reglas completas, exige "All nwells must contain metal-connected N+ taps (nwell.4)"
   y "P-diff distance to N-tap must be < 15.0um (LU.3)"; ancho de pozo 0,84 µm (nwell.1), separación 1,27 µm (nwell.2a)
   (**PDK local**, `libs.tech/magic/sky130A.tech`, líneas 4200–4205 y 4330). Consecuencia: un pozo sin ninguna toma no pasa DRC. La
   versión legal a probar es un pozo **con toma unida por metal a un interruptor**, no a la alimentación: flota cuando el
   interruptor abre.
3. Sonda de `residual/drc_edge`: pozo con toma a un nodo que no es la alimentación, en Magic y en los dos decks de KLayout. ¿Pasa?
   ¿Qué dice LVS de un pozo cuyo terminal de cuerpo es una red interna?
4. Buscar en el PDK: corriente de saturación de fondo y de periferia de las uniones p+/pozo (`jss`, `jsws` del `pfet_01v8`, o
   `diode_pd2nw_05v5`) y de la unión pozo/sustrato (modelo del diodo de pozo). Con eso y k1, el punto de equilibrio sale de una
   simulación, no de memoria.
5. Simular: pfet con el cuerpo en un nodo que solo tiene sus diodos y la fuga del interruptor. Predicción escrita antes: potencial
   de equilibrio y tiempo de relajación. Ojo: con el gmin por defecto la respuesta es falsa (lección de `macros/photon`,
   laboratorio: piso 50 veces peor).
6. Latch-up: simular la estructura pnpn con el pozo flotante y un vecino n+; decidir separación y anillo de guarda.
7. Dibujar por script; DRC en los dos decks; extraer; comprobar que el extractor no une el pozo a la alimentación por nombre.

### 5.2 Configuraciones a dibujar

Dimensiones propuestas, sin evaluar; pozo desde 0,84 µm de ancho y 1,27 µm de separación (**PDK local**).

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Área del pozo a dispositivo fijo | Mínima legal, 4×, 16× | La unión pozo/sustrato tira hacia abajo en proporción a su área: ¿se mueve el equilibrio? |
| Perímetro frente a área del pozo | Cuadrado frente a tira de igual área | ¿La fuga del pozo es de fondo o de pared? |
| Área de p+ dentro del pozo | Solo el pfet; pfet más difusión p+ extra unida a la alimentación | La unión p+/pozo tira hacia arriba: el cociente de áreas debe fijar el potencial |
| Camino de precarga | Ninguno; interruptor pfet mínimo; interruptor de umbral alto y canal largo | Cuánto flota de verdad el pozo |
| Distancia a un n+ vecino con su toma | Mínima legal, 5 µm, 15 µm | Ganancia del bipolar lateral y margen de latch-up |
| Distancia a un emisor de luz (XC-21) | Pegado, 10 µm, 50 µm | ¿Los portadores generados mueven el pozo? Sensor de luz frente a difusión de portadores |
| Tamaño del pfet | 0,42/0,15; 5/0,15 | Separar el efecto del desajuste (σ cae con el área) |
| Anillo de guarda | Con y sin anillo p+ alrededor | ¿Cambia el equilibrio o solo protege a los vecinos? |

Primero un canal: un pfet en pozo mínimo con toma a un interruptor, leído por el lector, y su gemelo con toma a la alimentación.

### 5.3 En silicio

1. **Virgen:** lectura con el interruptor de precarga cerrado (pozo a la alimentación): es el gemelo de sí mismo.
2. **Calibrar:** imponer por el interruptor dos tensiones de pozo conocidas (si hay una referencia en el chip) y leer: curva de
   efecto cuerpo del dispositivo real.
3. **Caracterizar:** abrir el interruptor y leer en el tiempo hasta que el pozo se asiente. Potencial final y constante de tiempo.
4. **Barrer:** temperatura (las fugas la siguen de forma característica), alimentación, actividad de los vecinos, emisor de luz.
5. **Memoria:** precargar, esperar un tiempo variable sin alimentar el lector, leer.
6. **Vigilar** el consumo del chip: un aumento es señal de latch-up; el apagado debe ser por hardware.
7. **Repetir** otro día y **clasificar** cada canal.

No hay transformación.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** el pozo se asienta en un potencial reproducible, gobernado por el cociente de áreas dibujado, con una constante de
  tiempo medible y sensible a temperatura o a luz más que el componente convencional de igual área.
- **Negativo informativo:** el pozo sigue a la alimentación dentro de un paso del lector: flotar no cambia nada a 1,8 V.
- **Inconcluso:** el potencial depende de la actividad de los vecinos de forma no reproducible.
- **Fallo instrumental:** la variante legal no flota (el interruptor fuga más que las uniones).
- **Muere** si no se puede dibujar de forma que pase DRC y LVS sin excepción, o si el gemelo con cuerpo impuesto reproduce todo.

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

- Compuerta previa a todo: que el pozo con toma a un interruptor pase DRC en los dos decks, LVS y el precheck. Sin eso no se dibuja.
- Latch-up: separación y guarda decididas por simulación; apagado por hardware en la mesa.
- Depende del lector de XC-19 (versión con pfet, no simulada) o de un anillo; de XC-31 para temperatura.
- Sirve a XC-43: el pozo propio y accesible es el cuerpo que el bombeo de carga necesita. Liga con XC-24 (bipolar parásito),
  XC-37 (retención) y XC-26 (luz).
- Vehículo: flujo digital a 1,8 V. Un solo chip basta para el efecto; la dispersión entre dados pediría más.

## 8. Abierto y fuentes

- ¿Acepta el flujo (LVS, precheck) un pozo cuyo cuerpo es una red interna? `[?]`
- Potencial de equilibrio y tiempo de relajación `[?]`: salen del paso 5 de 5.1, no hay fuente.
- Parámetros de la unión pozo/sustrato por leer en el modelo local; si el modelo de fuga inversa vale a pA es otra pregunta `[?]`.
- ¿Fuga real del interruptor frente a la de las uniones del pozo? Decide si la variante legal flota.
- PDK local: ciel, versión `8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, carpeta `sky130A/` (en `local_flow/pdk_host`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md), sección 3 (juicio de viabilidad, sin fuente abierta propia para esta familia).
