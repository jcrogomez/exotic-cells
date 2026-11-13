# XC-31 · Calor como canal

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-31 de [catálogo](../../README.md#catalogue) (Heat as a channel).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-31 · Calor como canal.** Autocalentamiento y difusión térmica → calefactor de conmutación y sensores a distancia → ninguna →
Δf en el tiempo (ms) → perilla de temperatura en chip, acoplamiento sin cable → calefactor + sensor → calefactor con salida
desconectada como control. **Mantener:** es también la perilla que XC-19 necesita para las residencias. Estimación previa sin
verificar.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-31:** retardo de fase entre calefactor y sensor, contado en ciclos; demostrado en 0,18 µm (**sin leer**).

## 2. Lectura y piso

Familia (¿el calor lleva señal entre dos estructuras?) y herramienta (canal de temperatura y perilla local para XC-19, XC-37 y
XC-38). Se lee con sensores que ya existen como modelo; ninguno está medido en silicio.

| Sensor | Sensibilidad a la temperatura | De dónde y grado |
|---|---|---|
| Etapa en inversión débil sin gemelo | Corriente 5,2 %/K a Vg 0,30 V; 3,7 %/K a 0,45 V | `experiments/xc19_weak_inversion` (`budget.txt`), **corrida**, modelo |
| Cociente dispositivo/gemelo | 0,15 a 0,17 %/K a un sigma de desajuste | misma corrida; es lo que queda tras el gemelo |
| Precarga con unión en inversa | A 27 °C el fondo no cruza; a 85 °C cruza en 1,296 ms | `macros/photon/LEEME.md`, laboratorio, **sin publicar**, modelo |
| Anillo con resistencia de poly en serie | tc1 = −4,3·10⁻⁴ /K (otra revisión −1,47·10⁻³) | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** / **sin leer** |
| Anillo de celdas estándar | `[?]` sin simular frente a temperatura | — |

- **Señal esperada:** centésimas de kelvin a 20 µm con 1 mW (estimación de un agente, **sin verificar**; laboratorio, sin
  publicar). Potencia: 0,51 mA por pareja de `ebufn_8` y 4,1 mA con ocho (`local_flow/efld_00`): 0,9 y 7,4 mW (**cálculo**, I·V).
- **Señal/piso:** 0,01 K sobre la etapa sin gemelo son 0,05 % (**cálculo**), contra 0,108 % de ruido de disparo por conversión
  (`experiments/xc19_noise`, **corrida**). **No supera el 1 % en una conversión.** Se gana con potencia, cercanía o detección
  síncrona (calefactor conmutado, cuentas en fase y en cuadratura). La elevación real es `[?]` hasta simularla o medirla.
- **Observable preferido:** retardo de fase entre calefactor y sensor (fuente **sin leer**): es un cociente de tiempos,
  independiente de la ganancia del sensor y de la potencia absoluta.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Caída de alimentación al encender el calefactor (XC-32) | Escala de tiempo: la caída aparece en la primera conversión, el calor crece en ms (ficha, sin verificar). Ficticio: el mismo calefactor colocado lejos y colgado del mismo raíl |
| Acoplo capacitivo o por sustrato de la conmutación del calefactor | Calefactor con salida desconectada (el control de la ficha): conmuta igual y no disipa en la línea |
| Portadores inyectados, no calor | Calefactor resistivo sobre óxido de campo, sin unión; anillo de tap entre calefactor y sensor: frena portadores, no calor |
| Calentamiento global del dado y del encapsulado | Fantasma: sensor idéntico lejos; solo cuenta la diferencia cercano − lejano |
| Deriva ambiente durante la medida | Tríos intercalados calefactor cercano / calefactor de control / nada, como en `macros/photon` |

## 4. Referencia convencional (control científico, no filtro)

- **Como termómetro:** el bipolar vertical del PDK (PNP, β ≈ 14,3, **leído por agente**) en un sensor de banda prohibida, que
  pide diseño analógico. En flujo digital, un anillo de celdas estándar leído por el contador.
- **Como perilla:** la placa caliente o la cámara térmica de la mesa. El calefactor en chip solo gana si es local (calienta una
  celda y no su gemela), rápido (ms frente a minutos) y calibrable contra la placa.
- **Como canal:** un cable. Aquí el calor no compite; interesa como acoplamiento no deseado que hay que acotar.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: leer a Makinwa (**sin leer**, [pesca](../notas/PESCA_2026-11-12.md)): difusividad, frecuencias y distancias.
2. Pendiente: coeficientes térmicos de poly, li1, met1 y pozo n en el PDK (el de poly tiene dos valores en la pesca) y simular
   frente a temperatura el anillo estándar y el anillo con resistencia. ngspice ignora tc1/tc2 si `r` es una ecuación.
3. Pendiente: modelo térmico de parámetros concentrados (red RC) con conductividades de fuente citada; predicción escrita de ΔT y
   de fase frente a distancia antes de dibujar. ngspice no modela autocalentamiento en estos modelos `[?]`.
4. Pendiente: elegir calefactor: línea de li1 o poly con drivers `ebufn` (EFLD-01: una vía por driver) o contienda (XC-34).
5. Pendiente: generador del par calefactor + sensor, DRC en los dos decks, extracción y LEF con obstrucciones (lección de EFLD-01).
6. Hecho en otra familia: la etapa sensora (`cells/xc19_read`, `xc19_bias`, `xc19_channel`), 0 violaciones.

### 5.2 Configuraciones a dibujar

Todas las dimensiones son **propuesta**. Bordes conocidos: li1 desde 0,170 µm, met1 desde 0,140 µm
([`residual/drc_edge`](../../residual/drc_edge/README.md)); ancho mínimo de poly y de resistor de poly: borde legal por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Distancia calefactor–sensor | 2, 5, 10, 20, 40 µm | ¿ΔT y fase caen como predice la difusión? Fija el alcance de la perilla y la separación que necesitan los gemelos |
| Forma del calefactor a igual potencia | Cuadrado compacto frente a línea larga (relación de aspecto 1, 10, 50) | Fuente puntual frente a lineal: la caída con la distancia debe cambiar de ley |
| Perímetro frente a área | Meandro frente a placa de igual resistencia | ¿El calor sale por el borde o hacia el sustrato por el área? |
| Capa del calefactor | poly sobre óxido de campo, li1, met1, difusión, pozo n | Camino vertical al sustrato: cuánto aísla el óxido bajo cada capa |
| Orientación | Sensor al N, S, E y O del calefactor | Isotropía; los raíles de met1 de las filas pueden conducir calor en un solo eje |
| Metal encima y tap intermedio | Con y sin placa de met2–met4; con y sin anillo de tap | ¿El metal reparte el calor? El tap separa portadores de calor |
| Potencia | 1, 2, 4, 8 drivers | Linealidad: ΔT ∝ potencia; lo que no escale así no es calor |
| Frecuencia de modulación | Décadas desde Hz hasta el límite del contador `[?]` | Fase frente a frecuencia: firma de difusión |
| Sensor | Etapa sin gemelo, etapa con gemelo, anillo estándar, anillo con resistencia | Cuál tiene mejor razón señal/piso; la pareja de XC-19 cancela lo común y debe dar cero |

Primero un canal completo: un calefactor de li1, un sensor a 5 µm, un fantasma a 40 µm y el calefactor de control.

### 5.3 En silicio

1. **Virgen:** todos los sensores con los calefactores apagados; línea base y gradiente del dado.
2. **Calibrar:** placa caliente a dos o más temperaturas; cada sensor da su %/K real. No depende del fenómeno.
3. **Caracterizar:** escalón de calefactor; serie temporal del sensor cercano, del fantasma y del canal de alimentación (XC-32):
   el salto de la primera conversión es alimentación; la subida lenta, calor.
4. **Barrer y repetir:** potencia, distancia, frecuencia, alimentación y temperatura de placa; otro día, ¿la misma ganancia?
5. **Clasificar** cada par: acoplamiento térmico (lento, lineal con potencia, cae con distancia), acoplamiento eléctrico
   (inmediato, presente con el calefactor de control), nada sobre el piso, fallo de sensor.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** respuesta lenta, lineal con la potencia, decreciente con la distancia, ausente con el calefactor de control, y de
  fase creciente con la distancia y la frecuencia.
- **Negativo informativo:** nada sobre el piso con la potencia máxima legal, y el sensor, calibrado en placa, habría visto la
  elevación predicha en 5.1. Entonces la perilla local no existe a esta potencia y XC-19 depende de la placa.
- **Inconcluso:** respuesta que no se separa de la de alimentación (misma escala de tiempo, presente en el control).
- **Fallo instrumental:** el sensor no sigue a la placa caliente.
- **Muere como perilla** si la elevación alcanzable es menor que la deriva ambiente entre medidas intercaladas. No muere como
  control: el canal de temperatura se queda aunque el calefactor no sirva.

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

- Sirve a XC-19 (residencias frente a temperatura), XC-37 (fuga en caliente), XC-38 y XC-20 (túnel frente a fuga térmica), XC-10
  (envejecimiento acelerado), XC-39 y XC-40. Si no hay calefactor útil, todas dependen de la placa caliente.
- Depende de XC-32 (mismo montaje), del lector de XC-19 como sensor y de EFLD-01 como calefactor.
- Permiso: ninguno bajo el régimen de vías y líneas (`mcon` 0,36 mA, `via` 0,29 mA, met1 mínimo 0,39 mA; `local_flow/efld_01`).
  Por encima es estrés: llave y permiso de XC-01/XC-02. Abierto: disipación continua admitida por tesela `[?]`. Un chip basta.

## 8. Abierto y fuentes

- `[?]`: elevación real por mW y su alcance; si el encapsulado fija una constante de tiempo lenta que se confunde con la local.
- "El decap no es barrera térmica" (error corregido en `FILOSOFIA.md` del laboratorio): la separación se decide con análisis.
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md),
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md),
  [`experiments/xc19_noise`](../../experiments/xc19_noise/README.md); sensor en [`xc19_single_trap`](../xc19_single_trap/PLAN.md).
  Laboratorio, sin publicar: `local_flow/efld_00`, `efld_01`, `macros/photon`.
