# XC-41 · Relajación dieléctrica

**Fusionada en XC-14 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-41 de [catálogo](../../README.md#catalogue) (Dielectric relaxation).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-41 · Relajación dieléctrica.** El dieléctrico devuelve carga después de descargarlo → condensador MOS (o MiM met3/met4 si la
plantilla lo admite `[?]`) → carga larga, descarga corta → rebote leído como tiempo hasta un umbral → memoria de historia, reloj lento
→ interruptor + lector → mismo ciclo con carga corta. Señal ~1 mV `[?]` (**de memoria**), del orden de 3 pasos del lector. Aburrida:
inyección de carga del interruptor, fuga, trampas de interfaz.

## 2. Lectura y piso

Lector en inversión débil (XC-19): el condensador bajo prueba cuelga de la puerta del dispositivo; tras la descarga el nodo queda
flotando y se cuenta el tiempo de descarga del lector en conversiones sucesivas. Todo modelo; nada en silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Paso del lector | 0,83 % del tiempo por 0,305 mV | `experiments/xc19_weak_inversion/budget.txt`, **corrida** |
| Rebote esperado | ~1 mV `[?]` (**de memoria**), unos 3 pasos | ficha |
| Fuga del interruptor que aísla el nodo | 5,3 pA (pfet mínimo); 0,010 pA (umbral alto, canal largo) | `docs/CLAIMS.md`, **corrida**, exploratoria |
| Deriva del nodo por esa fuga, sobre 133 fF | 40 mV/s y 75 µV/s (**cálculo**: I/C; supone que toda la fuga va al nodo) | — |
| MiM | 2,00 fF/µm² de área y 0,19 fF/µm de perímetro, típico; tc1 = tc2 = 0; sin término de absorción | **PDK local**, `libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice` y `libs.ref/sky130_fd_pr/spice/sky130_fd_pr__cap_mim_m3_1.model.spice` |
| Constantes de tiempo del rebote | `[?]` | — |

Señal/piso: del orden de 3 si el milivoltio vale, y solo con el interruptor de umbral alto y canal largo: con el pfet mínimo la
fuga mueve el nodo un rebote entero en decenas de milisegundos (**cálculo** con las cifras de arriba). El modelo predice rebote
cero: cualquier rebote medido es física no modelada o un artefacto, y la sección 3 decide cuál.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Inyección de carga y acoplo del reloj al abrir el interruptor | Mismo ciclo con carga corta (control de la ficha): la inyección no depende de cuánto duró la carga; el rebote sí |
| Fuga del interruptor o de la unión | Tiene signo fijo; el rebote sigue al signo de la carga previa. Ciclo con polaridad invertida |
| Trampas de interfaz del condensador MOS (no es el dieléctrico) | Condensador de metal (MiM o dedos de metal) al lado: sin interfaz de silicio |
| Redistribución lenta de carga en el canal o en el pozo del condensador MOS | Condensador MOS en acumulación frente a inversión; y el de metal |
| Deriva térmica del lector tras conmutar | Lector gemelo con un condensador ficticio que hace el mismo ciclo sin tensión (ambas placas juntas) |
| El lector mismo tiene memoria (sus propias trampas) | Lector sin condensador añadido: mismo ciclo sobre la sola capacidad de puerta |

## 4. Referencia convencional (control científico, no filtro)

Como memoria de historia: un contador o un biestable guardan cuánto duró algo, con exactitud y sin deriva. Como reloj lento: anillo
con divisor, o la fuga de un nodo (XC-37). La relajación solo gana si entrega algo que esos no: una memoria analógica de la duración
que no consume mientras espera. Como medida, sí tiene valor propio: la absorción del dieléctrico es un parámetro que el PDK no da y
que limita cualquier circuito de muestreo; el componente convencional contra el que se mide es el propio `cap_mim_m3_1` ideal.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer: una fuente con absorción dieléctrica medida en condensadores integrados (MiM de nitruro, óxido térmico, dedos de metal en
   óxido depositado) `[?]`; no hay ninguna en la pesca. El milivoltio de la ficha es **de memoria**. Qué dieléctrico lleva el MiM de
   SKY130 `[?]`: buscarlo en la documentación del proceso.
2. Buscar en el PDK (hecho): el modelo del MiM no tiene coeficientes ni absorción (sección 2); ancho mínimo del MiM 1,0 µm
   (capm.1), separación 0,84 µm (capm.2a), debe ser rectangular (capm.7) (**PDK local**, `sky130A.tech`, líneas 4896–4902).
   `cap_mim_m3_2` contacta con metal 5 (línea 335), reservado: solo vale `cap_mim_m3_1`, entre metal 3 y metal 4.
3. Pendiente: saber si la plantilla digital admite la capa del MiM dentro de un macro propio `[?]` (preguntar a Tiny Tapeout).
4. Pendiente: buscar en el modelo del condensador MOS (`cap_var`, o una puerta de `nfet_01v8`) si hay algo dependiente del
   tiempo; se espera que no.
5. Simular el ciclo carga, descarga, flotar y leer con el interruptor real: da la inyección y la fuga, es decir, lo aburrido. Es la
   línea de base contra la que se medirá, no una predicción del rebote.
6. Añadir a mano un modelo de absorción (ramas RC en paralelo) con amplitud como parámetro y ver qué amplitud mínima distingue el
   lector tras restar el ciclo corto. Predicción escrita antes.
7. Dibujar por script condensador, interruptor y lector; DRC en los dos decks; extraer.

### 5.2 Configuraciones a dibujar

Dimensiones propuestas, sin evaluar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Dieléctrico | Óxido de puerta (condensador MOS); MiM met3/met4; dedos de metal 1 y 2; poly sobre aislamiento de campo | ¿Qué dieléctrico del proceso relaja? Térmico frente a depositado |
| Área a forma fija | 1×, 4×, 16× | El rebote en tensión no debe depender del área si es del material; la inyección del interruptor cae con el área |
| Perímetro frente a área | Cuadrado frente a tira de igual área (MiM ≥ 1,0 µm de ancho) | ¿Relaja el volumen o el borde grabado del dieléctrico? |
| Régimen del condensador MOS | Acumulación, inversión | Separa dieléctrico de carga del silicio |
| Interruptor | pfet mínimo; umbral alto y canal largo; puerta de paso con ficticio de media anchura | Cuánto del rebote aparente es inyección y fuga |
| Capacidad parásita añadida | Nodo desnudo frente a nodo con capacidad fija de metal | Dilución: el rebote debe caer en la proporción de capacidades |
| Vecindad | Junto a un calefactor (XC-31) y lejos | La relajación es térmicamente activada (**de memoria**): ¿cambian sus tiempos? |

Primero un canal: condensador MOS de unos 133 fF (el tamaño ya previsto en XC-19), interruptor de fuga baja, lector y gemelo.

### 5.3 En silicio

1. **Virgen:** tiempo del lector con el nodo recién puesto a la referencia, sin historia. Deriva del nodo flotante (fuga).
2. **Calibrar:** escalón conocido en la puerta; con él, tiempos a milivoltios.
3. **Caracterizar:** cargar durante t_c, descargar durante t_d, soltar y leer en conversiones sucesivas. Restar el ciclo de carga
   corta.
4. **Barrer:** t_c en décadas (el rebote crece con el logaritmo de t_c, **de memoria**), t_d, tensión de carga, polaridad,
   temperatura.
5. **Historia:** dos cargas de duración distinta en orden inverso: ¿el nodo recuerda el orden?
6. **Repetir** otro día y **clasificar** cada canal.

No hay transformación; todo ocurre a 1,8 V o menos.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** rebote que crece con t_c, cambia de signo con la polaridad, no depende del área y difiere entre dieléctricos, por
  encima de la resta del ciclo corto.
- **Negativo informativo:** el lector resuelve el escalón de calibración y el rebote queda bajo un paso en todos los dieléctricos:
  cota superior de la absorción, útil para quien diseñe muestreo en este proceso.
- **Inconcluso:** la diferencia entre ciclo largo y corto existe pero no se separa de la fuga.
- **Fallo instrumental:** el nodo flotante deriva más de un rebote entre conversiones.
- **Muere como celda** si el efecto existe pero un contador hace lo mismo mejor; queda como parámetro medido del proceso.

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

- Depende del lector de XC-19 y del interruptor de fuga baja (umbral alto, canal largo), que hoy es una corrida exploratoria.
- Comparte nodo flotante y explicación aburrida con XC-37 (retención) y XC-45 (túnel de puerta): un mismo canal puede servir a las
  tres con distinta secuencia.
- Variante MiM: depende de que la plantilla lo admita `[?]`; sin MiM, la familia sigue con óxido de puerta y dedos de metal.
- Vehículo: flujo digital a 1,8 V. Sin permisos de estrés. Un solo chip basta.

## 8. Abierto y fuentes

- Amplitud y tiempos de la absorción en cada dieléctrico de SKY130 `[?]`. Dieléctrico del MiM `[?]`.
- ¿Admite la tesela digital la capa del MiM en un macro propio? `[?]`
- La fuga de 0,010 pA del interruptor largo es de modelo y exploratoria; la real decide si la familia es legible.
- PDK local: ciel, versión `8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, carpeta `sky130A/` (en `local_flow/pdk_host`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md) (solo el dato del MiM, que el PDK local confirma). Lector:
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md). Cifras: [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
