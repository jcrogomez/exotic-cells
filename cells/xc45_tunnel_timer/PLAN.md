# XC-45 · Temporizador por túnel de puerta

**Fusionada en XC-14 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-45 de [catálogo](../../README.md#catalogue) (Gate-tunnelling timer).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-45 · Temporizador por túnel de puerta.** Túnel directo a través del óxido de 1,8 V descarga una puerta flotante → puerta aislada
cargada por un interruptor, áreas barridas → ninguna → tiempo hasta que el propio transistor cambia → reloj sin oscilador, medida del
óxido → — → barrido de área: el túnel da un tiempo independiente del área; la fuga del interruptor, proporcional. Tiempo `[?]`
(10 s a 15 min **extrapolado, sin leer**). Aburrida: fuga del interruptor.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** Los modelos de 1,8 V del PDK local traen `igcmod = igbmod = 0` en los 180 bins de `nfet_01v8` (tt): la simulación no puede predecir el túnel de puerta. Solo el silicio responde.

## 2. Lectura y piso

La puerta flotante es la puerta de un transistor cuyo estado se lee: como etapa de un anillo (grueso: conduce o no) o como
dispositivo del lector en inversión débil (fino: milivoltios por segundo). Se mide el tiempo hasta un umbral. Todo modelo.

| Cantidad | Valor | De dónde |
|---|---|---|
| Paso del lector | 0,83 % del tiempo por 0,305 mV | `experiments/xc19_weak_inversion/budget.txt`, **corrida** |
| Tiempo de descarga por túnel | `[?]`; 10 s a 15 min (**extrapolado, sin leer**) | ficha |
| Espesor eléctrico del óxido | 4,148 nm (`nfet_01v8`), 4,23 nm (`pfet_01v8`); 11,6 nm (`nfet_g5v0d10v5`) | **PDK local**, `libs.ref/sky130_fd_pr/spice/sky130_fd_pr__{nfet_01v8,pfet_01v8,nfet_g5v0d10v5}__tt.pm3.spice`, `toxe` |
| Corriente de puerta en el modelo | Apagada: `igcmod = 0`, `igbmod = 0` en nfet y pfet de 1,8 V | **PDK local**, mismos archivos |
| Fuga del interruptor de carga | 5,3 pA (pfet mínimo); 0,010 pA (umbral alto, canal largo) | `docs/CLAIMS.md`, **corrida**, exploratoria |
| Deriva por esa fuga sobre 133 fF | 40 mV/s y 75 µV/s (**cálculo**: I/C) | — |

Consecuencia: la simulación con el modelo del PDK no puede predecir esta familia; da retención infinita salvo fuga del interruptor.
Señal/piso `[?]`: es el cociente entre la corriente de túnel (sin dato) y la fuga del interruptor (dato de modelo). El lector
sobra; lo que falta es saber cuál de las dos corrientes manda, y eso lo decide el barrido de área.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Fuga del interruptor (unión y subumbral) | Barrido de área con el mismo interruptor: el túnel da un tiempo independiente del área; la fuga, proporcional a ella |
| Fuga de unión, activada térmicamente | Temperatura: la fuga modelada de un nodo sube de 32 fA a 0,41 pA entre 27 y 85 °C (laboratorio, sin publicar); el túnel directo casi no cambia (**de memoria**) |
| El tiempo es solo C/I con una C mal conocida | Capacidad de metal añadida al nodo: alarga el tiempo en la proporción de capacidades, sea cual sea la corriente |
| Fuga por el óxido en cualquier dispositivo, no túnel | Gemelo de óxido grueso (`nfet_g5v0d10v5`, 11,6 nm) con el mismo interruptor: sin túnel, debe retener mucho más |
| Acoplo de vecinos que mueve la puerta | Fantasma: nodo flotante de metal sin puerta, misma área y vecindad |
| El lector descarga la puerta al leer (retroceso) | Leer una sola vez al final frente a leer muchas veces durante la espera |

## 4. Referencia convencional (control científico, no filtro)

Un temporizador convencional es un anillo con un contador: exacto, pero consume y deja de contar sin alimentación. La puerta que se
descarga sola solo gana en lo que ese no hace: marcar tiempo transcurrido con el chip apagado, si la descarga sigue sin alimentar
(por comprobar). Como medida del óxido: el PDK no modela la corriente de puerta, así que no hay componente contra el que comparar;
el resultado, positivo o negativo, es un dato de XC-47. Contra XC-37 (retención por fuga de unión): es la misma celda con otra
corriente dominante; el barrido de área y el gemelo de óxido grueso dicen cuál es cuál.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer: la fuente de la que se extrapoló "10 s a 15 min" (**sin leer**, sin identificar en la pesca: rehacer la búsqueda) y una
   con densidad de corriente de túnel directo frente a espesor y tensión para óxidos de unos 4 nm `[?]`. Leer el artículo de
   puerta flotante en SKY130 (Chen, Sonnadara, Shah 2024, **sin leer**) por si da retención medida.
2. Buscar en el PDK (hecho): `toxe` e `igcmod`, sección 2. Pendiente: ver si alguna esquina o variante del modelo (`tt_leak`)
   enciende la corriente de puerta; grep de `igcmod` en todos los `.pm3.spice` y `.corner.spice`.
3. Estimar el túnel a mano con la fórmula de la fuente del paso 1 y el espesor local. Será **cálculo** con sus supuestos; hasta
   entonces el tiempo es `[?]`.
4. Simular la celda con el modelo tal cual: da el tiempo que impone la fuga del interruptor sola, para cada área. Es la línea de
   base aburrida y la predicción "proporcional al área". Cuidado con gmin (lección de `macros/photon`, laboratorio).
5. Repetir con `igcmod = 1` y los coeficientes que el modelo ya trae (`aigc` = 0,43 en `nfet_01v8`, **PDK local**; si están
   ajustados o son valores por defecto, `[?]`): no es predicción, es sensibilidad.
6. Antena: el nodo es poly unido a la difusión de un interruptor, que hace de diodo de descarga durante el grabado; comprobar el
   cociente contra las reglas (poly 50, **leído por agente**) aunque el precheck no las corra.
7. Dibujar por script; DRC en los dos decks; extraer la capacidad real del nodo.

### 5.2 Configuraciones a dibujar

Dimensiones propuestas, sin evaluar. Las reglas del dispositivo de óxido grueso son borde legal por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Área de puerta, mismo interruptor | 1×, 4×, 16×, 64× del mínimo | Prueba central: tiempo constante = túnel; tiempo proporcional al área = fuga del interruptor |
| Perímetro frente a área | Cuadrado frente a dedos estrechos de igual área | ¿El túnel va al canal o a los solapes de fuente y drenaje? |
| Largo a ancho fijo | 0,15; 0,5; 2; 8 µm | Peso del solape (fijo por ancho) frente al canal (crece con L) |
| Tipo | nfet y pfet como condensador de túnel | Túnel de electrones frente a huecos; espesores distintos en el modelo |
| Óxido | 1,8 V (4,1 nm) frente a óxido grueso (11,6 nm) | Gemelo sin túnel: aísla la fuga del interruptor |
| Interruptor | pfet mínimo; umbral alto y canal largo; dos en serie con el nodo intermedio guardado | Bajar la fuga hasta que mande el túnel |
| Capacidad de metal añadida | 0, 1× y 4× la de puerta | Si manda el túnel, el tiempo crece con la capacidad total: comprueba C/I |
| Tensión inicial | 1,8 V; 0,9 V; polaridad invertida | El túnel depende mucho de la tensión; la fuga de unión, poco |
| Vecindad | Junto a un calefactor (XC-31) y lejos | Discriminador térmico sin cámara |

Primero un canal: una puerta de 16× con interruptor de fuga baja, su gemelo de óxido grueso y el lector.

### 5.3 En silicio

1. **Virgen:** estado de cada puerta al encender, antes de cargarla: es la carga que dejó la fabricación (dato para XC-14).
2. **Calibrar:** escalón conocido en una puerta gemela con toma; tiempos a milivoltios.
3. **Caracterizar:** cargar, abrir el interruptor, leer la deriva. Primero ventanas de segundos; si no se mueve, de horas.
4. **Barrer:** temperatura (el discriminador principal en la mesa), tensión inicial, alimentación durante la espera.
5. **Comparar** áreas, óxidos e interruptores: de ahí sale qué corriente manda.
6. **Sin alimentación:** cargar, apagar el chip un tiempo conocido, encender y leer. Solo vale si el encendido no recarga el nodo.
7. **Repetir** otro día y **clasificar** cada canal.

No hay transformación a 1,8 V. Cualquier tensión mayor para acelerar el túnel es estrés de mesa, otro plan (XC-07, XC-11).

### 5.4 Criterio de muerte (borrador)

- **Positivo:** tiempo de descarga independiente del área de puerta, casi independiente de la temperatura, mucho más largo en el
  gemelo de óxido grueso, y que crece con la capacidad de metal añadida.
- **Negativo informativo:** el tiempo es proporcional al área y sigue a la temperatura como una unión: manda el interruptor; el
  túnel queda acotado por arriba para este óxido. La celda sigue valiendo como XC-37.
- **Inconcluso:** dependencia de área intermedia, o el gemelo de óxido grueso se descarga igual.
- **Fallo instrumental:** el lector descarga la puerta al leer.
- **Muere como reloj** si el tiempo queda fuera de lo que se puede esperar en la mesa o lo fija la temperatura; como medida del
  óxido solo muere si el interruptor no puede hacerse más estanco que el túnel.

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

- Depende del lector de XC-19 y del interruptor de fuga baja (corrida exploratoria).
- Comparte celda con XC-37 (retención) y XC-41 (relajación dieléctrica, que da una deriva inicial de signo propio y hay que restar).
- El gemelo de óxido grueso mete un dispositivo de 5 V en un macro de 1,8 V: reglas de implante y de pozo por buscar (el tech pide
  2,0 µm entre pozo de alta y de baja tensión, nwell.8, **PDK local**); si no cabe, el gemelo es un nodo de metal.
- Vehículo: flujo digital a 1,8 V. Sin permisos. La mesa necesita esperas largas y temperatura controlada.
- Un solo chip basta para el barrido de área; la dispersión del óxido entre dados pediría más.

## 8. Abierto y fuentes

- Densidad de corriente de túnel a 1,8 V en un óxido de 4,1 nm `[?]`: sin fuente leída. Es la incógnita de la familia.
- ¿Por qué el modelo trae `igcmod = 0`: despreciable o sin caracterizar? `[?]`
- ¿Fuga real del mejor interruptor dibujable? Hoy 0,010 pA de modelo, exploratoria.
- ¿Sigue la descarga con el chip sin alimentar, y sobrevive el estado al encendido? `[?]`
- PDK local: ciel, versión `8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, carpeta `sky130A/` (en `local_flow/pdk_host`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md), secciones 1 y 3. Cifras: [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
