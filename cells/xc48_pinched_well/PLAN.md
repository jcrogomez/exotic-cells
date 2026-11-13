# XC-48 · Resistor de pozo estrangulado por su unión

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-48 de [catálogo](../../README.md#catalogue) (Junction-pinched well resistor).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-48 · Resistor de pozo estrangulado por su unión.** La zona de vaciamiento estrecha un resistor de pozo según su polarización →
resistor de pozo n largo y estrecho (950 Ω/□, 550–1350, **PDK**) → polarización del sustrato o del propio resistor → retardo de un
anillo → resistencia controlada por tensión sin transistor → anillo → resistor ancho de igual valor. Dependencia `[?]`.

## 2. Lectura y piso

Anillo con el resistor de pozo en serie (el lector de EFLD-00), contra un anillo gemelo con un resistor ancho del mismo valor.

| Cantidad | Valor | De dónde |
|---|---|---|
| Resistencia de hoja del pozo n | 950 Ω/□, límites 550–1350 | **PDK local** (`sky130A.tech`), [pesca](../notas/PESCA_2026-11-12.md) |
| Dependencia con la polarización de la unión | `[?]`. Profundidad y dopado del pozo `[?]` | laboratorio, `docs/FRONTERAS_FISICAS_1105.md`, sin publicar |
| Lector | +1,7 % con 1 kΩ, +32 % con 10 kΩ, ×2,2 con 100 kΩ; lee de ~1 kΩ a 300 kΩ | laboratorio, `local_flow/efld_00` y `FRONTERAS_FISICAS_1105.md`, **corrida** sobre esquemático, sin publicar |
| Ancho y separación mínimos de pozo | 0,840 y 1,270 µm | laboratorio, mismo archivo, leído de la documentación |
| Coeficiente térmico del resistor de pozo | `[?]` | — |
| Piso del cociente de dos anillos | `[?]` sin caracterizar | [`../PLANTILLA.md`](../PLANTILLA.md) |

Señal/piso: desconocida. A 1,8 V la polarización inversa disponible sobre la unión pozo–sustrato va de 0 a 1,8 V. Si el
modelo del resistor en el PDK trae coeficiente de tensión, hay predicción; si no, la predicción es cero y la medida es dato
nuevo. Diez cuadros son unos 9,5 kΩ con la hoja nominal (**cálculo**), dentro del rango que el lector distingue.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Autocalentamiento y coeficiente térmico: el resistor cambia porque se calienta, no porque se estrangule | Gemelo ancho de igual valor y potencia; canal de temperatura XC-31; el estrangulamiento es instantáneo, el calor no |
| El excitador cambia de fuerza con el punto de trabajo, y eso se lee como resistencia | Ficticio: resistor de poly del mismo valor en la misma posición del anillo, sin unión que lo estrangule |
| Resistencia de los contactos al pozo, que no depende del vaciamiento | Dos largos con los mismos contactos: la diferencia es solo cuerpo |
| Fuga de la unión pozo–sustrato en paralelo | Fantasma: el pozo con un solo terminal conectado |
| Esfuerzo (XC-44) y tolerancia de hoja (550–1350) | Cociente dentro del mismo chip; resistores a la misma orientación |
| El modelo ya lo predice | Simular antes con el modelo de resistor del PDK; solo cuenta el residuo |

Gemelo: el resistor ancho de igual número de cuadros. El vaciamiento lateral quita la misma anchura a los dos, así que estrangula
más, en proporción, al estrecho.

## 4. Referencia convencional (control científico, no filtro)

Un nfet en zona lineal, que es una resistencia controlada por tensión con modelo, pequeña y de biblioteca; y la puerta de
transmisión. Como resistor fijo: los resistores de poly de alta resistividad del PDK (300 y 2000 Ω/□, **leído por agente**).
El pozo estrangulado solo gana si ofrece algo que el transistor no: una resistencia controlada sin óxido de puerta (sin trampas
de interfaz ni ruido de canal superficial), o una característica de saturación propia de un transistor de unión, que la
biblioteca no tiene. Si la modulación a 1,8 V es de unos pocos por ciento, gana el nfet y se dice.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: buscar en el PDK local el modelo del resistor de pozo y leer si trae coeficientes de tensión y de temperatura.
   Cuidado conocido: ngspice ignora tc1/tc2 cuando `r` es una ecuación (issue 169, **leído por agente**).
2. Pendiente: leer los datos crudos del test tile de SkyWater, que incluyen el resistor de pozo (**leído por agente**): ver si
   se midió a varias tensiones de sustrato o de cabeza.
3. Pendiente: bordes legales con `residual/drc_edge`: ancho de pozo, pozo a pozo, p+ dentro de pozo a su borde, contacto n+.
4. Pendiente: comprobar si un pozo con dos contactos a redes distintas pasa DRC y LVS en los dos decks o exige la capa de
   identificación de resistor, y qué extrae Magic.
5. Pendiente: cálculo de orden de magnitud de la anchura de vaciamiento, solo si se encuentra el dopado del pozo; hoy `[?]`.
6. Pendiente: simular el anillo con el resistor en el lado alto y en el lado bajo, con predicción escrita antes.
7. Pendiente: generador por script, extracción, y endurecer un canal como macro pasivo sobre la plataforma de EFLD-00.

### 5.2 Configuraciones a dibujar

Valores propuestos. Ancho mínimo de pozo 0,840 µm (laboratorio, **leído**); los demás bordes, por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Ancho a igual número de cuadros | 0,84 (mínimo); 1,68; 4,2; 8,4 µm, todos de 10 cuadros | El vaciamiento lateral pesa como 1/ancho: separa estrangulamiento lateral de vertical |
| Largo a ancho mínimo | 5, 10, 20, 50 cuadros | Linealidad; el corte en cero son los contactos. Rango útil del lector |
| Posición en el anillo | Entre la salida y VDD (pozo cerca de 1,8 V) frente a cerca de tierra | La misma pieza con dos polarizaciones inversas medias, sin pines extra: es el experimento de hoy |
| Tapa p+ sobre el pozo | Sin tapa; p+ cubriendo el 50 % y el 90 % del largo, atada a tierra o a un nodo digital | Estrangula también desde arriba: es un transistor de unión. Con el nodo digital, dos estados sin pin analógico |
| Vecino lateral | Tira de sustrato con contacto p+ pegada a los dos lados frente a lejos | ¿El contacto de sustrato cercano fija mejor el potencial y aumenta el efecto? |
| Dos pozos paralelos | Separación mínima (1,270 µm) frente a amplia | ¿Las zonas de vaciamiento de pozos vecinos se tocan? Aislamiento entre pozos |
| Bajo aislamiento o bajo difusión | Pozo bajo óxido de campo frente a pozo bajo área activa | La hoja y la profundidad efectiva cambian; relación perímetro/área del cuerpo |
| Orientación | 0° y 90° | Control de esfuerzo compartido con XC-44 |
| Forma | Recta frente a serpentina | Las esquinas no estrangulan igual; efecto de borde frente a cuerpo |

Primero un canal completo: una tira de ancho mínimo y diez cuadros, su gemelo ancho y su ficticio de poly, en tres anillos.

### 5.3 En silicio

1. **Virgen:** cuentas de los anillos con resistor estrecho, ancho y de poly.
2. **Calibrar:** pendiente del lector con el ficticio de poly de valor conocido por diseño; piso con dos anillos iguales.
3. **Caracterizar:** resistencia equivalente frente a alimentación dentro de su rango nominal (cambia la polarización inversa);
   frente al
   estado del nodo de la tapa p+; lado alto frente a lado bajo.
4. **Barrer:** temperatura (separa el coeficiente térmico); frecuencia de conmutación de la tapa (el vaciamiento responde de
   inmediato, el calor tarda).
5. **Retener y repetir:** no hay memoria esperada; una histéresis sería carga atrapada o calor.
6. **Clasificar:** modulación por tensión que escala con 1/ancho, sin modulación sobre el piso, térmica, fallo de lector.

No hay transformación. En el vehículo híbrido: curva corriente–tensión completa con el sustrato o la tapa barridos por pin.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** la resistencia del estrecho cambia con la polarización más que la del ancho, en la proporción de sus anchos, y
  el ficticio de poly no cambia.
- **Negativo informativo:** estrecho, ancho y poly se mueven igual con la alimentación (es el excitador), con piso conocido.
  Conclusión: a 1,8 V el pozo no se estrangula de forma medible.
- **Inconcluso:** el cambio sigue a la temperatura o no escala con el ancho.
- **Fallo instrumental:** el ficticio de poly no da la pendiente del lector.
- **Muere como función** si la modulación no supera la de un nfet de igual área usado como resistencia. Como dato del pozo
  (hoja, coeficientes) sobrevive, y sirve a XC-25 y XC-44.

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

- Macro pasivo: el más parecido a lo que EFLD-00 ya endureció. Sin transistores propios.
- El pozo con tapa p+ es un diodo que LVS verá: declararlo. Nunca en directa: la tapa solo a tierra o a un nodo que no supere al
  pozo.
- Riesgo de enclavamiento si el pozo queda lejos de un contacto de sustrato (LU.2: 15 µm, **corrida**).
- Sirve a XC-25 (misma lámina de pozo) y a XC-44 (galga de pozo); XC-44 es su control de esfuerzo y XC-31 el de temperatura.
- Sin permisos. Un chip basta; la tolerancia de hoja entre chips es conocida y amplia.

## 8. Abierto y fuentes

- Si el modelo del PDK trae coeficiente de tensión. Profundidad y dopado del pozo. Coeficiente térmico.
- Cómo declara el flujo un resistor de pozo dibujado a mano.
- Origen: alta del 2026-11-12 (`docs/CARTERA.md` del laboratorio, sin publicar). Datos de hoja y del test tile:
  [pesca](../notas/PESCA_2026-11-12.md). Lector: `local_flow/efld_00/LEEME.md`.
  Bordes: [`residual/drc_edge`](../../residual/drc_edge/README.md). Planes ligados: [XC-44](../xc44_package_stress/PLAN.md),
  [XC-25](../xc25_hall_plate/PLAN.md).
