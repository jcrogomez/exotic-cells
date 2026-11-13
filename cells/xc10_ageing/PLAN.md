# XC-10 · Envejecimiento a 1,8 V

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-10 de [catálogo](../../README.md#catalogue) (Ageing at 1.8 V).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-10 · Envejecimiento a 1,8 V.** BTI y HCI → transistores de geometría propia en anillos gemelos → puertas retenidas horas,
conmutación máxima, placa caliente → Δf permanente y recuperación → sensor de uso, reloj de envejecimiento, versión suave de XC-09 →
par de anillos estresado/guardado → comparar antes, durante y después. **Mantener:** es la versión de XC-09 que cabe hoy en D. Si la
deriva no supera el piso del lector, es un límite y se registra.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-10:** par de anillos, uno siempre activo y otro casi nunca, y su recuperación. Hay un precedente en Tiny Tapeout sin medidas.

## 2. Lectura y piso

Dos lectores posibles: cociente de dos anillos, o el lector en inversión débil de XC-19 con el transistor estresado como
dispositivo.

| Cantidad | Valor | De dónde |
|---|---|---|
| Anillo: efecto de mover el umbral de una etapa | 0,3 mV → 6·10⁻⁶ del período; 3 mV → 1·10⁻⁴; 30 mV → 8,6·10⁻⁴ | `EFLG00_TRAMPA.md`, **corrida** de modelo, laboratorio, sin publicar |
| Resolución del contador | ~10⁻⁵ con ventana de 2²⁰ a 10 MHz; la deriva térmica es órdenes mayor | mismo |
| Cociente de dos anillos | `[?]`, sin caracterizar | [`PLANTILLA.md`](../PLANTILLA.md) |
| Lector en inversión débil | 0,83 a 0,84 % por 0,305 mV; el cociente con el gemelo se mueve 0,047 % (mediana) por 10 mV de alimentación | [`CLAIMS.md`](../../docs/CLAIMS.md), **corrida** de modelo |
| Deriva térmica del cociente del lector | 0,16 %/K | [`xc19_single_trap/PLAN.md`](../xc19_single_trap/PLAN.md), **corrida** |
| Anillos anotados con LOD | 2,5 a 5,1 % más rápidos que sin anotar | [`CLAIMS.md`](../../docs/CLAIMS.md), **corrida** |
| Desplazamiento de umbral por BTI o HCI a 1,8 V en SKY130 | `[?]`; el PDK no trae modelo de envejecimiento `[?]` | — |
| Precedente | Tiny Tapeout ttsky26b #486: 13 etapas, ÷4096, estrés con alimentación sobre 1,8 V; sin medidas | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |

Señal/piso: desconocida. En un anillo, si todas las etapas envejecen igual el efecto se suma, pero sin dato de partida no hay
razón señal/piso. El lector de XC-19 es mucho más sensible y es el instrumento preferido; el anillo queda como comparación con lo
convencional.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El anillo activo está más caliente | Leer los dos tras igualar temperatura; canal XC-31; anillo ficticio que conmuta igual pero no entra en el cociente |
| La alimentación cae con la actividad | Canal XC-32; lectura con todo lo demás parado |
| La referencia también envejece, porque oscila al ser leída | Referencia cortada salvo en la ventana de lectura; contar su tiempo de actividad acumulado |
| Lo medido es recuperación durante la lectura | Retardo fijo y registrado entre fin del estrés y lectura; barrerlo |
| Deriva del encapsulado o de la placa (XC-44) | Tercer anillo guardado lejos; repetición en días |
| Diferencia de fábrica entre los dos anillos | Cociente virgen registrado desde el primer encendido; dos parejas con papeles cruzados |
| Es el gradiente del dado | Parejas entrelazadas o con centro común |

## 4. Referencia convencional (control científico, no filtro)

El sensor de envejecimiento hecho con celdas estándar: dos anillos de `inv_1`, uno activo y otro guardado, que es justo el
precedente de Tiny Tapeout. Esa es la referencia y cabe sin macro.

Los transistores de geometría propia tendrían que envejecer más por hora de estrés, de forma más repetible, o separar BTI de HCI
mejor que un anillo de biblioteca. Si no, gana el anillo estándar, y la familia queda como medida del proceso.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: lector de XC-19 simulado y dibujado; presupuesto del anillo frente a desplazamiento de umbral (laboratorio).
2. Pendiente: no hay diseño. Escribir el RTL de la pareja de anillos con corte, contador y registro de tiempo de actividad.
3. Pendiente: simular la sensibilidad del anillo cuando todas las etapas se desplazan a la vez, por tipo (solo pfet, solo nfet).
   Predicción escrita antes.
4. Pendiente: confirmar en el PDK que no hay modelo de envejecimiento, y buscar una medida de BTI o HCI en 130 nm para tener orden
   de magnitud `[?]`.
5. Pendiente: abrir nosotros el proyecto #486 y ver su esquema (hoy **leído por agente**).
6. Pendiente: definir los modos de estrés: entrada retenida a 0, retenida a 1, conmutación máxima, apagado.
7. Pendiente: variantes de geometría propia con el generador de XC-19; bordes con [`drc_edge`](../../residual/drc_edge/README.md).
8. Pendiente: prerregistro con el retardo de lectura y el criterio de «no supera el piso».

### 5.2 Configuraciones a dibujar

Valores: **propuesta**. Mínimo 0,42/0,15; difusión junto a la puerta desde 0,250 µm.

| Barrido | Valores | Pregunta |
|---|---|---|
| Modo de estrés por anillo | retenido a 0; retenido a 1; conmutando; guardado | Separa BTI del pfet, BTI del nfet y HCI |
| Largo de canal | 0,15; 0,25; 0,50 µm | HCI cae al alargar; BTI casi no: los separa por geometría |
| Ancho | 0,42; 1,0; 5,0 µm | Promedio sobre más trampas: ¿la deriva se vuelve suave y la dispersión baja? |
| Etapa dominada por un tipo | inversores con pfet débil o con nfet débil | Atribuir la deriva a un solo transistor |
| Carga por etapa | abanico 1 frente a carga grande | Flancos lentos alargan el tiempo en saturación: ¿más HCI por ciclo? |
| Largo de difusión | 0,30 y 3,0 µm | ¿El esfuerzo mecánico cambia el envejecimiento? (XC-12) |
| Borde frente a área | un ancho frente a varios estrechos | ¿El daño vive en la esquina con el óxido de campo? (XC-46) |
| Vecindad de un calefactor | junto a XC-31 y lejos | Aceleración térmica local sin placa caliente |
| Lector | pareja de anillos frente a transistor único en inversión débil | Comparar el instrumento convencional con el propio |
| Orientación | 0° y 90° | Anisotropía de fabricación |

Primero un canal: una pareja de anillos estándar con corte y contador. La geometría propia después.

### 5.3 En silicio

1. **Virgen:** el primer encendido es dato. Registrar el cociente desde el primer segundo, antes de cualquier otra prueba.
2. **Calibrar:** cociente frente a alimentación y temperatura; fija el piso.
3. **Caracterizar:** estabilidad del cociente con los dos anillos guardados, horas.
4. **Transformar** (a 1,8 V nominal): estrés continuo con lecturas breves a intervalos en escala logarítmica, de minutos a semanas.
5. **Observar:** deriva frente a tiempo acumulado, por modo de estrés.
6. **Recuperar:** cortar el estrés y seguir el cociente desde ms hasta días. Repetir el ciclo: ¿la segunda vez es igual?
7. **Clasificar:** sin deriva sobre el piso; deriva que se recupera del todo; componente permanente; fallo de lector.

Se barre: temperatura de placa, tiempo, modo, y alimentación solo dentro de lo permitido (subirla estresa todo el chip y pide
permiso).

### 5.4 Criterio de muerte (borrador)

- **Positivo:** deriva del cociente por encima del piso calibrado, monótona con el tiempo de estrés, distinta por modo, con una
  parte que se recupera y otra que no, y ausente en la pareja guardada.
- **Negativo informativo:** tras un tiempo fijado antes `[?]` a 1,8 V y en placa caliente, deriva bajo el piso: límite del
  proceso, con su número. La ficha ya dice que eso se registra.
- **Inconcluso:** deriva que sigue a la temperatura o a la alimentación; la pareja guardada también deriva.
- **Fallo instrumental:** el cociente virgen no es estable.
- **Muere como celda** si la geometría propia no supera al anillo estándar; queda como medida.

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

- Vehículo: digital a 1,8 V. A tensión nominal no supera ninguna especificación; confirmar aun así con Tiny Tapeout si días de
  conmutación continua y placa caliente piden permiso `[?]`.
- Puede hacerse solo con celdas estándar: es de las pocas familias que no necesita macro para dar un primer resultado.
- Sirve a XC-19 (crear trampas) y es la versión suave de XC-09. Necesita XC-31 y XC-32.
- Un solo chip basta para la serie temporal; no para la dispersión entre chips.
- Ocupa tiempo de mesa largo: planear el registro automático antes del envío.

## 8. Abierto y fuentes

- Magnitud del envejecimiento a 1,8 V en SKY130 `[?]`. Constantes de tiempo de recuperación `[?]`.
- Cuántos días de mesa son razonables y qué temperatura de placa.
- Fuentes: precedente #486 y juicio de viabilidad (NBTI con recuperación, entre los probables) en la
  [pesca](../notas/PESCA_2026-11-12.md). Cifras: [`CLAIMS.md`](../../docs/CLAIMS.md). Laboratorio, sin publicar:
  `EFLG00_TRAMPA.md`, `EQUIPO.md` (La Trampa), `PROPUESTA_CHIP.md`.
