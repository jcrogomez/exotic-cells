# XC-35 · Identidad del dado

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-35 de [catálogo](../../README.md#catalogue) (Die identity).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-35 · Identidad del dado.** Desajuste → pares de anillos → ninguna → bits estables por chip → identidad → — → varios chips.
**Mantener:** XC-14 es su versión exótica.

## 2. Lectura y piso

Se lee como signo y magnitud de la diferencia entre dos estructuras nominalmente iguales, con los contadores que ya existen.

| Fuente de identidad | Dispersión entre iguales | De dónde y grado |
|---|---|---|
| Par de anillos de celdas estándar | `[?]`; sin Monte Carlo de anillos | — |
| Umbral de un transistor | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15) | `experiments/lod_audit`, **corrida**, modelo de desajuste del PDK |
| Etapa en inversión débil | Tiempos de 0,7 a 147,6 µs entre etapas iguales; cociente dispositivo/gemelo de 0,02 a 15,45 (39 sorteos) | `experiments/xc19_weak_inversion` (`n5.txt`), **corrida** |
| Estabilidad del cociente de la etapa | 0,15 a 0,17 %/K; mediana 0,047 % por 10 mV de alimentación | misma corrida |
| Resolución del contador | Del orden de 10⁻⁵ con 2²⁰ ciclos a 10 MHz | `EFLG00_TRAMPA.md`, laboratorio, **sin publicar** |

- **Señal esperada:** en anillos, `[?]`. En la etapa en inversión débil el modelo da cocientes que se apartan de 1 por factores,
  contra derivas de décimas de por ciento: margen de varios órdenes (**cálculo** sobre la tabla). Es una observación del modelo de
  desajuste, no de silicio, y sugiere que el lector de XC-19 es mejor fuente de identidad que el par de anillos.
- **Señal/piso:** un bit es estable si la diferencia del par supera el ruido de lectura más la deriva en temperatura y
  alimentación. Los pares cerca de cero son los bits inestables; su fracción es el observable de calidad.
- **Lo que un chip no da:** unicidad. Con un chip se mide estabilidad y sesgo, no distancia entre chips.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El bit lo fija el layout (asimetría del par o del enrutado), no el azar: saldría igual en todos los chips | Varios chips (el experimento de la ficha). Con uno solo: muchos pares de layout idéntico deben dar mitad y mitad |
| Gradiente del dado: bits correlacionados con la posición | Mapa de signos frente a posición; pares en centroide común frente a pares simples |
| Asimetría del multiplexor y del contador | Leer cada par por los dos caminos intercambiados |
| Bits que parecen estables porque se leyó poco | Lecturas repetidas, y barrido de temperatura y alimentación (canales XC-31 y XC-32) |
| Envejecimiento desplaza los bits (XC-10) | Releer tras semanas y tras uso |
| Acoplo entre anillos que oscilan a la vez | Un anillo activo cada vez frente a los dos a la vez |

## 4. Referencia convencional (control científico, no filtro)

- El propio par de anillos **es** lo convencional: hay uno en Tiny Tapeout con 8 × 32 anillos y sin datos publicados (TT07 #142,
  [pesca](../notas/PESCA_2026-11-12.md), **leído por agente**).
- Identidad por diseño: constante cableada (`conb_1`) o el fusible metálico del PDK (regla propia, 0,8 × 7,2 µm, **leído por
  agente**). Es estable y no es secreta.
- Esta familia es a su vez la referencia de XC-14 (antena como escritura): la versión exótica debe dar bits más estables o más
  baratos que el desajuste, y la versión con la etapa de XC-19 debe ganar al par de anillos en margen por bit.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: desajuste de umbral y Monte Carlo parcial de la etapa (tabla). Pendiente: completar los 100 sorteos.
2. Pendiente: Monte Carlo de pares de anillos de 3, 7 y 13 etapas, extraídos y anotados: distribución de la diferencia relativa.
   Predicción escrita antes, a partir de σ de umbral.
3. Pendiente: mismo Monte Carlo a dos temperaturas y dos alimentaciones: fracción de pares que cambian de signo.
4. Pendiente: leer cómo reporta TT07 #142 (o cualquier otro) y qué banco usó; hoy no hay medidas publicadas.
5. Pendiente: confirmar cuántos chips se pueden pedir (la pesca dice "un solo chip"; choca con esta familia).
6. Pendiente: RTL del banco de pares con multiplexor intercambiable; colocación fija de los pares.
7. Reutiliza: `cells/xc19_channel` como par de etapas; no pide celda nueva.

### 5.2 Configuraciones a dibujar

Todas las dimensiones son **propuesta**. En anillos de celdas se barre selección y colocación; en la etapa de XC-19, geometría.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Longitud del anillo | 3, 7, 13 etapas | ¿La diferencia relativa cae al promediar más etapas? Margen por bit frente a área |
| Área de puerta de la etapa | 0,42/0,15; 1,0/0,15; 5,0/0,15; 0,42/0,50 | ¿La dispersión sigue la ley de área (17,3 → 5,13 mV en el modelo)? Compartido con XC-19 |
| Relación de aspecto a igual área | Ancho y corto frente a estrecho y largo | ¿El desajuste depende de la forma o solo del área? El modelo dice área; el silicio, `[?]` |
| Distancia entre los dos miembros | Contiguos, 10, 50, 200 µm | Separa desajuste local (identidad) de gradiente (sesgo) |
| Orientación | Iguales, espejados, girados 90° si la regla lo deja (borde legal por buscar) | Sesgo sistemático por orientación (liga con XC-16) |
| Entorno de difusión | Par con el mismo largo de difusión frente a par con largos distintos | Un LOD desigual fija el bit por diseño (31,09 mV, mayor que σ): control positivo de "bit de layout" (XC-12) |
| Colocación | A mano en macro frente a la que elija el flujo | ¿El enrutado automático mete más asimetría que el desajuste? |
| Régimen | Anillo en fuerte inversión frente a etapa en inversión débil | Cuál da más margen y cuál deriva menos |
| Réplicas | Tantas como quepan, N `[?]` | La estadística de un solo chip |

Primero un canal completo: un par de anillos con su multiplexor intercambiable, y un par de etapas que ya existe.

### 5.3 En silicio

1. **Virgen:** diferencia de cada par, leída muchas veces; histograma por par.
2. **Calibrar:** el par de LOD desigual debe dar siempre el mismo signo; un par leído contra sí mismo debe dar cero.
3. **Caracterizar:** fracción de unos entre pares; correlación con la posición; fracción de bits que alguna vez cambian.
4. **Barrer:** temperatura (placa o XC-31) y alimentación; bits que cambian de signo.
5. **Retener y repetir:** semanas después; tras el estrés de otras familias si se autoriza.
6. **Clasificar** cada par: estable, inestable (cerca de cero), sesgado por diseño. Con más chips: distancia entre chips.

Sin transformación. Si se pide más de un chip, el mismo protocolo en cada uno y los crudos juntos.

### 5.4 Criterio de muerte (borrador)

- **Positivo (un chip):** fracción de unos compatible con un medio, sin correlación espacial, y fracción de bits inestables
  pequeña y conocida en todo el rango de temperatura y alimentación. **Positivo completo** solo con varios chips distintos entre sí.
- **Negativo informativo:** los bits siguen la posición o la orientación: el layout domina al desajuste. Es dato para XC-16.
- **Inconcluso:** un solo chip y estabilidad buena: no se sabe si es identidad o diseño.
- **Fallo instrumental:** el par contra sí mismo no da cero, o los dos caminos del multiplexor discrepan.
- **Muere** (criterio de la idea original, `ideas/README.md`, laboratorio): no tener más de un chip. Sin eso queda como medida de
  desajuste, que sirve a XC-19 y XC-12 aunque no sea identidad.

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

- Compuerta principal: número de chips. La pesca recoge "un solo chip" de las preguntas frecuentes de Tiny Tapeout; sin resolver.
- Es referencia convencional de XC-14 y comparte dispositivos con XC-19 (réplicas del mínimo) y XC-12.
- Controles: XC-31 y XC-32. Envejecimiento: XC-10.
- Sin permisos. Flujo digital; la variante en inversión débil usa el macro de XC-19.

## 8. Abierto y fuentes

- Dispersión de frecuencia entre anillos iguales en SKY130 `[?]`; no hay medida publicada hallada.
- Si los dos órdenes de magnitud del Monte Carlo de la etapa se sostienen en silicio `[?]`; es la cola de un modelo.
- Cuántos chips `[?]`.
- Corridas: [`experiments/lod_audit`](../../experiments/lod_audit/README.md),
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md); cifras en
  [`docs/CLAIMS.md`](../../docs/CLAIMS.md). Fuentes: [pesca](../notas/PESCA_2026-11-12.md). Versión exótica:
  [`xc14_antenna_write`](../xc14_antenna_write/PLAN.md).
