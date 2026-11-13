# XC-24 · Bipolar parásito y PNPN

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-24 de [catálogo](../../README.md#catalogue) (Parasitic bipolar and PNPN).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-24 · Bipolar parásito y PNPN.** Realimentación del tiristor parásito → p+/pozo n/sustrato/n+ con separación elegida → disparo →
histéresis, resistencia diferencial negativa → oscilador de relajación, neurona → un condensador → curva I–V con corriente limitada.
**Mantener en H:** riesgo para el shuttle; aislamiento obligatorio, y los bipolares del PDK solo valen en activa directa.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-24:** el PNP vertical funciona a 1,8 V (β ≈ 14, 7,5–21, **leído por agente**): variante en D como termómetro.

## 2. Lectura y piso

Dos lecturas, las dos como tiempo o cuenta. (a) Oscilador de relajación: un condensador se carga por una resistencia hasta
que el tiristor dispara y lo descarga; se cuenta la frecuencia. (b) Termómetro: un PNP vertical conectado como diodo descarga
un nodo; el tiempo depende de la temperatura.

| Cantidad | Valor | De dónde |
|---|---|---|
| Ganancia de los bipolares verticales | PNP β ≈ 14,3 (7,5–21); NPN β ≈ 37,5 | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Tensión de disparo y de mantenimiento del PNPN dibujado | `[?]`: el PDK no modela el tiristor parásito | — |
| ¿La tensión de mantenimiento queda bajo 1,8 V? | `[?]`. Si queda por encima, a 1,8 V no hay enganche sostenido y no hay familia en D | — |
| Resistencias para limitar | Pozo n 950 Ω/□; poly 48,2 Ω/□ | `sky130A.tech`, **PDK** local, en la pesca |
| Contador de frecuencia | Los anillos de EFLD-00 ya se cuentan en el flujo digital; resolución para este oscilador `[?]` | `local_flow/efld_00` |
| Deriva térmica de referencia | 0,16 %/K en el cociente del lector de XC-19 | `xc19_single_trap/PLAN.md`, **corrida** |

Señal/piso: el disparo es un suceso grande (un nodo que cae de golpe); no hay problema de piso, sino de saber si ocurre.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| La histéresis es del inversor que lee, no del tiristor | Gemelo: mismo condensador, resistencia e inversor, con un diodo del PDK en lugar del PNPN |
| El oscilador es un anillo o un acoplo parásito de la lógica vecina | Fantasma sin dispositivo; la frecuencia debe seguir a R y C como un oscilador de relajación |
| Se engancha la protección o una celda vecina, no la estructura dibujada | Corriente de cada rama por separado; estructura con separación tan grande que no deba disparar |
| Autocalentamiento: la conducción calienta y cambia el umbral | Frecuencia frente a ciclo de trabajo; ficticio de igual potencia |
| El disparo lo causa el ruido de alimentación (XC-32), no la corriente inyectada | Canal de alimentación; disparo repetido con la lógica vecina parada |
| En el termómetro: la deriva es del transistor de precarga | El mismo lector con un condensador en lugar del PNP |

## 4. Referencia convencional (control científico, no filtro)

Para el oscilador: un anillo de inversores o un oscilador de relajación con un disparador de Schmitt de la biblioteca, que
ya tienen histéresis y son seguros. Para el termómetro: el `pnp_05v5` del PDK en la configuración de referencia de banda
prohibida, y el retardo de un inversor, que ya depende de la temperatura. El PNPN solo gana si da una resistencia diferencial
negativa con menos área que el Schmitt, o un umbral gobernado por la distancia dibujada. La neurona pide además que el umbral
sea ajustable; el Schmitt no lo es.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: los bipolares del PDK tienen ganancia documentada (pesca) y la regla de contacto de sustrato a 15 µm (LU.2) se
   comprueba en Magic con reglas completas (`residual/drc_edge`, donde ya cazó dos transistores sin contacto).
2. Pendiente: leer las reglas de enganche del PDK completas (familia LU): cuáles limitan la estructura y cuáles no comprueba
   ninguna herramienta. Borde legal por buscar.
3. Pendiente: modelo de dos transistores (PNP y NPN del PDK realimentados, con las resistencias de pozo y de sustrato como
   parámetro) para acotar qué resistencias dan disparo a 1,8 V. Predicción escrita antes. Los modelos solo valen en activa
   directa: la simulación da condición de disparo, no la curva tras el disparo.
4. Pendiente: buscar una fuente con la tensión de mantenimiento de enganche medida en 130 nm `[?]`.
5. Pendiente: variante termómetro: simular el PNP como diodo en el lector de precarga a 27 y 85 °C.
6. Pendiente: dibujar por script con anillo de guarda doble alrededor, DRC en los dos decks, extraer.
7. Pendiente: preguntar al shuttle si admite una estructura que se engancha a propósito con corriente limitada.

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**. La estructura es p+ (ánodo) en pozo n, borde del pozo, n+ (cátodo) en el sustrato.

| Barrido | Valores | Pregunta |
|---|---|---|
| Distancia ánodo–cátodo (p+ al borde del pozo más borde al n+) | Mínima legal (por buscar); 2×; 4×; 8× | La ganancia del lazo cae con la base del NPN lateral: ¿a qué distancia deja de disparar? |
| Distancia del contacto de pozo al ánodo | 0,27; 2; 5; 10 µm | Resistencia de pozo que polariza la base del PNP: fija la corriente de disparo |
| Distancia del contacto de sustrato al cátodo | 0,27; 2; 5; 15 µm (límite LU.2) | Resistencia de sustrato: la otra mitad de la condición de disparo |
| Ancho del ánodo | 1; 5; 20 µm | Corriente de mantenimiento frente a perímetro enfrentado |
| Puerta de disparo | Sin ella; n+ auxiliar que inyecta; p+ auxiliar en el pozo | Disparo por tercera terminal: es lo que hace de la estructura una neurona |
| Orientación | 0° y 90° | Anisotropía de la resistencia de pozo y de sustrato |
| Pozo profundo bajo el cátodo | Con y sin | Aislar el sustrato local: ¿se puede confinar el enganche a la celda? |
| Termómetro: área del emisor del PNP | 1× y 8× | Par clásico de dos densidades de corriente; diferencia proporcional a la temperatura absoluta |

Primero un canal: una estructura que deba disparar, su gemelo con diodo, su resistencia limitadora y el contador.

### 5.3 En silicio

Clasificada en H por el riesgo y por la curva I–V. La variante termómetro y el oscilador con corriente limitada caben en D
si el shuttle lo permite:

1. **Virgen:** con el ánodo a masa, consumo del chip y frecuencia de los anillos de referencia.
2. **Calibrar:** el contador con un anillo conocido; el limitador, midiendo el consumo con el ánodo forzado.
3. **Caracterizar:** habilitar una estructura cada vez, con la resistencia limitadora mayor primero. ¿Oscila? ¿A qué frecuencia?
4. **Barrer:** alimentación desde el mínimo hasta 1,8 V (umbral de disparo y de mantenimiento), temperatura (el enganche es más
   fácil en caliente), resistencia limitadora.
5. **Retener y repetir:** misma estructura tras muchos ciclos de disparo; ¿cambia el umbral?
6. **Clasificar:** oscila con ley de relajación, se engancha y no suelta, no dispara, fallo de contador.

La habilitación de cada estructura es una llave en hardware con apagado independiente del firmware: si algo se engancha, se
corta el ánodo, no la alimentación del chip.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** oscilación cuya frecuencia sigue a R·C, que desaparece en el gemelo con diodo, y cuyo umbral se ordena con
  la distancia dibujada.
- **Negativo informativo:** ninguna variante dispara a 1,8 V con la inyección disponible: el proceso es robusto al enganche a
  esta tensión, dato útil para todas las familias que ponen uniones en directa.
- **Inconcluso:** dispara pero no suelta con el limitador previsto, o dispara de forma errática.
- **Fallo instrumental:** el consumo sube sin que ninguna estructura esté habilitada.
- **Muere** si el Schmitt de biblioteca hace el mismo oscilador con menos área y la estructura no aporta umbral ajustable; o
  si el shuttle no la admite.

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

- Permiso expreso del shuttle: es la única familia que busca a propósito un modo de fallo que puede afectar a vecinos.
- Aislamiento obligatorio: anillos de guarda dobles, limitador en serie en hardware, llave de habilitación por estructura.
- Vehículo: H para la curva I–V con corriente limitada; D solo para el termómetro y, con permiso, el oscilador.
- Informa a XC-23, XC-26 y XC-42, que ponen uniones en directa o pozos flotantes y necesitan saber cuánto margen hay.
- La variante termómetro compite con XC-31 y XC-40 como canal de temperatura.

## 8. Abierto y fuentes

- Tensión de mantenimiento a esta geometría: `[?]`. Decide si la familia existe a 1,8 V.
- Reglas de enganche que el precheck de Tiny Tapeout comprueba: `[?]` (no corre LVS ni antena para sky130A, según la pesca).
- Comportamiento de los bipolares del PDK fuera de activa directa: sin modelo.
- Fuentes: [pesca del 12-nov](../notas/PESCA_2026-11-12.md); [`residual/drc_edge`](../../residual/drc_edge/README.md);
  `docs/PROPUESTA_CHIP.md` del laboratorio (sin publicar), que ya pide «guardas contra latch-up; nada fuera de polarización autorizada».
