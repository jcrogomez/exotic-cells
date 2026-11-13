# XC-14 · Antena como escritura

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-14 de [catálogo](../../README.md#catalogue) (Antenna as a fab-time write).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-14 · Antena como escritura.** Carga de plasma sobre una puerta flotante → puerta colgada de metal sin camino de descarga →
el grabado la carga → Vth al nacer → celda que nace escrita, identidad de fábrica → ROM sin máscara → pares con y sin diodo.
**Mantener, con compuerta:** falta leer las reglas de fabricación; que el precheck no revise antena no autoriza. Abierto: si los
pasos térmicos la borran `[?]`.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-14/15:** el precheck de Tiny Tapeout no corre la comprobación de antena para sky130A (**leído por agente** en
  `precheck.py`).

**Replanteo del 2026-11-12.** Familia de nodo flotante: una puerta aislada leída por su propio transistor, cuya carga la pone
el plasma (esta ficha y XC-15), el túnel a través del óxido (XC-45), la relajación del dieléctrico (XC-41), la fuga de un pozo
(XC-42) o la inyección con alta tensión (XC-09, XC-11, con la bomba XC-53). Un solo precursor y un solo lector para seis físicas;
el barrido es qué se cuelga del nodo y con qué área. Los planes de las absorbidas siguen en sus carpetas.

**[corregido 2026-11-13 10:42] Ronda de ataque 4 (nodo flotante y alta tensión)** En óxido de 4,15 nm muere como memoria de fábrica: la carga de plasma se descarga por túnel (verificado; en 1 s solo se pierde el exceso sobre ~3 V, a 2 V tarda 24 s–2 días). Nace otra lectura, verificada al orden: el residual (~0–1,3 V a 6 meses) deriva 0–1,2 mV/día y depende del espesor del óxido (hasta 2,6 V/nm) → reloj de vida y medidor de espesor local; medir diferencias entre copias y deriva, no el valor absoluto. En óxido de 11,6 nm la carga no escapa por túnel (verificado); si sobrevive al recocido final es `[?]`. Ver `experiments/RONDA_4_NODO_2026-11-13.md`.

## 2. Lectura y piso

Lo que se lee es el umbral con el que nace un transistor cuya puerta no tiene camino de descarga. Lector: etapa en inversión
débil de XC-19, con la puerta flotante en lugar de la polarización. Un anillo estándar no sirve: una puerta flotante no conmuta.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal: desplazamiento de umbral por carga de plasma retenida | `[?]`. Ninguna fuente leída; si sobrevive a los pasos térmicos `[?]` | ficha |
| Sensibilidad del lector | 0,83 % del tiempo por 0,305 mV (una carga en el transistor mínimo, **cálculo**) | `experiments/xc19_weak_inversion`, **corrida** |
| Piso: desajuste de umbral | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15) | `experiments/lod_audit`, **corrida** |
| Límites de antena del PDK | poly 50; li 75; met1 a met5 400; con diodo K = 400 | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Fuga de la puerta flotante y retención | `[?]` | — |

Señal/piso: desconocida. Hay un problema de lectura previo al de señal: con la puerta flotante, el punto de trabajo del lector
lo fija la propia carga. Si deja al transistor fuera de inversión débil, el lector satura; hace falta una placa de acoplamiento
para llevarlo a su rango, y entonces la celda es la de XC-11 con otra forma de escribir.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Desajuste: cada transistor nace con un umbral distinto sin antena alguna (eso es XC-35) | Gemelo de la misma geometría con la puerta conectada a un nodo conocido; la dispersión con antena debe superar la del gemelo |
| El potencial de una puerta flotante lo fija el divisor de sus capacidades parásitas, no la carga | Misma antena con placa de acoplamiento barrida: la carga desplaza la curva, el divisor cambia su pendiente |
| Fuga hacia la puerta que la lleva a un equilibrio igual en todas | Lectura repetida en el tiempo y a dos temperaturas: un equilibrio por fuga se alcanza otra vez tras perturbarlo |
| Acoplamiento de la antena a pistas vecinas que conmutan | Fantasma: la misma antena sin transistor junto a un lector; vecinos quietos durante la lectura |
| Daño del óxido en vez de carga (eso es XC-15) | Variante con la puerta unida a su excitador solo en el metal más alto permitido: la carga se va, el daño queda |
| Luz o radiación durante el encapsulado que descarga todo | Sin control posible en este vehículo; se registra como límite |

Ficticio: la misma superficie de metal dibujada al lado, sin conectar a ninguna puerta.

## 4. Referencia convencional (control científico, no filtro)

Como memoria de solo lectura: las celdas de la biblioteca atadas a alimentación o a tierra, que son una ROM por máscara sin
riesgo alguno. Como identidad de fábrica: los pares de anillos de XC-35, que usan el desajuste y caben en celdas estándar. Como
celda programable: el fusible metálico con regla propia del PDK ([pesca](../notas/PESCA_2026-11-12.md), **leído por agente**) y
la puerta flotante de XC-11. La antena solo gana si da una identidad con más separación entre niveles que el desajuste, estable
en el tiempo, y sin el circuito de programación que piden las otras. Lo más probable es que gane lo convencional.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: el precheck de Tiny Tapeout no comprueba antena en sky130A (**leído por agente**). No autoriza nada.
2. Pendiente, y es la compuerta: leer las reglas de antena de fabricación y la secuencia de capas en la documentación de SkyWater
   (qué acumula cada paso, si una puerta sin conexión a difusión es admisible, qué recocidos siguen al grabado).
3. Pendiente: preguntar a Tiny Tapeout si la fábrica comprueba antena y si rechaza puertas flotantes.
4. Pendiente: comprobar qué dicen Magic, KLayout y LVS de una puerta sin excitador (advertencia, error o silencio), con
   `residual/drc_edge` y una sonda con respuesta conocida.
5. Pendiente: cuarto contexto de Residual: relación de antena por paso de fabricación y por puerta, anotada en el netlist.
6. Pendiente: simular el lector con la puerta flotante como nodo con carga inicial: rango de carga que deja al transistor dentro
   de la ventana útil. Predicción escrita antes.
7. Pendiente: leer una fuente sobre retención de carga de plasma tras el recocido final `[?]`. Sin ella la familia no tiene señal
   esperada.
8. Pendiente: dibujar por script un canal y sus controles, dentro de los límites de antena.

### 5.2 Configuraciones a dibujar

Todas dentro de las reglas de antena leídas; cruzar un límite es otra familia de permisos (sección 7). Valores propuestos.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Relación de antena | 0 (solo la puerta); un cuarto, la mitad y el total del límite de la capa | ¿El umbral al nacer crece con el área expuesta? Es la prueba de que escribe el plasma |
| Capa de la antena | poly; li; met1; met2; met3; met4 (met5 reservado) | Cada grabado es un paso distinto: ¿cuál carga más, y los posteriores borran a los anteriores? |
| Perímetro frente a área | Placa compacta frente a peine de la misma área (ancho mínimo de met1 0,140 µm, **corrida**) | ¿Recoge carga el flanco durante el grabado o la cara superior? |
| Área de puerta | 0,42/0,15; 1,0/0,15; 5,0/0,15; 5,0/0,50 | A igual antena, la relación cambia con la puerta; y el desajuste baja con el área |
| Camino de descarga | Ninguno; diodo; unión al excitador solo en met4 | Separa carga retenida, protección y daño (liga con XC-15) |
| Placa de acoplamiento | Sin placa; placa de met sobre la antena, de dos tamaños | Lleva al transistor a la ventana del lector y mide la carga por el desplazamiento de la curva |
| Vecindad | Antena aislada frente a antena rodeada de metal a tierra a la separación mínima | ¿El entorno apantalla o descarga durante el grabado? |
| Tipo y óxido | nfet y pfet de 1,8 V; transistor de óxido grueso si el macro lo admite (borde legal por buscar) | Signo de la carga; el óxido grueso retiene más y se daña menos |

Primero un canal: una antena de met1 a mitad del límite sobre un nfet ancho, con placa de acoplamiento, gemelo conectado,
fantasma y ficticio.

### 5.3 En silicio

1. **Virgen:** es el experimento. La primera lectura tras el primer encendido no se repite: se guarda entera, antes de cualquier
   otra prueba del chip y sin aplicar tensión a las placas de acoplamiento.
2. **Calibrar:** el lector con su gemelo conectado y el escalón de puerta de XC-19.
3. **Caracterizar:** umbral de cada celda por la curva frente a la placa de acoplamiento; histograma por nivel de antena.
4. **Retener:** releer a horas, días y semanas; a dos temperaturas. Una identidad que deriva no es identidad.
5. **Transformar (con permiso, al final):** intentar borrar o reescribir desde la placa a 1,8 V; lo esperable es que no se pueda.
6. **Clasificar** cada celda: escrita de fábrica y estable, escrita y derivando, indistinguible del gemelo, lector fuera de rango.

Se barre tiempo y temperatura. La alimentación solo dentro del rango nominal: no hay ruta de formación.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** el umbral al nacer depende de la relación de antena de forma monótona, la dispersión supera a la del gemelo y los
  valores se mantienen entre lecturas.
- **Negativo informativo:** las celdas con antena son indistinguibles de las que no la tienen, con N conocido y un lector que
  resolvió su calibración. Conclusión: dentro de las reglas el proceso no deja carga legible, o el recocido la borra.
- **Inconcluso:** todas las puertas flotantes fuera de la ventana del lector; o un solo chip y dispersión del tamaño del efecto.
- **Fallo instrumental:** el gemelo conectado no se lee bien.
- **Muere** si la fábrica rechaza puertas sin camino de descarga, o si la retención medida es menor que el tiempo entre fabricación
  y primera lectura. La prueba que lo demostraría es la de la fila "relación de antena" con resultado plano.

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

- Por leer: las reglas de antena de la fábrica. El precheck de Tiny Tapeout no comprueba antena en sky130A.
- Es estadística: un solo chip da una muestra de la dispersión dentro del dado, no del proceso. Confirmar cuántos chips hay.
- Depende del lector de XC-19 y de la placa de acoplamiento de XC-11. XC-15 es su mitad sobria; XC-35 es su control convencional.
- Riesgo propio: una puerta flotante puede dejar un transistor conduciendo entre raíles. El lector debe limitar esa corriente.
- Macro propio con transistores; el enrutador no debe añadir diodos ni saltos a la red de la antena.

## 8. Abierto y fuentes

- Si los pasos térmicos posteriores borran la carga `[?]`. Si la fábrica admite la estructura `[?]`.
- Signo y magnitud de la carga por capa `[?]`.
- La [pesca](../notas/PESCA_2026-11-12.md) la juzga improbable a 1,8 V, sin citar fuente abierta: es un juicio, no un dato.
- Origen: laboratorio, `docs/EQUIPO.md` ("El Grabado") y `docs/CARTERA.md`, sin publicar. Reglas de antena y precheck: pesca.
  Planes ligados: [XC-15](../xc15_antenna_factorial/PLAN.md), [XC-11](../xc11_floating_gate/PLAN.md),
  [XC-35](../xc35_die_identity/PLAN.md).
