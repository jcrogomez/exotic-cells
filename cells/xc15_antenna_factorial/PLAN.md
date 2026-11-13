# XC-15 · Antena factorial

**Fusionada en XC-14 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-15 de [catálogo](../../README.md#catalogue) (Antenna factorial).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-15 · Antena factorial.** Daño de plasma en el óxido → factorial 2×2 (exposición × protección) dentro de las reglas → el
grabado → ΔVth, trampas creadas → parámetro fijado por geometría de fabricación → — → factorial con control del efecto eléctrico del
diodo. **Mantener:** contrato escrito en v0.4. Señal esperada del orden del desajuste, así que el presupuesto de XC-12 se aplica.
"Sin daño dentro de las reglas" es un resultado previsto.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-14/15:** el precheck de Tiny Tapeout no corre la comprobación de antena para sky130A (**leído por agente** en
  `precheck.py`).

## 2. Lectura y piso

Aquí la puerta sí tiene excitador: se lee un transistor normal y se pregunta si el grabado le dejó un umbral distinto o trampas.
Dos lectores: parejas en la etapa de inversión débil de XC-19, y anillos gemelos que solo difieren en la antena.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal: desplazamiento de umbral por daño dentro de las reglas | `[?]`; "del orden del desajuste" según la ficha, sin fuente leída | laboratorio, `docs/CARTERA.md`, sin publicar |
| Piso: desajuste de un dispositivo | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15) | `experiments/lod_audit`, **corrida** |
| Presupuesto de réplicas de XC-12, como escala | 44,1 mV se ven con una pareja ancha; 31,1 mV en el mínimo piden 16 parejas | mismo, **cálculo** |
| Sensibilidad del lector de parejas | 0,83 % por 0,305 mV | `experiments/xc19_weak_inversion`, **corrida** |
| Límites de antena | poly 50; li 75; met1 a met5 400; con diodo K = 400 | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Espesores que entran en el área lateral | li 0,1; met1 0,35; met2 0,35 µm | laboratorio, `docs/FRONTERAS_FISICAS_1105.md`, leído de la documentación, sin publicar |
| Piso del cociente de anillos | `[?]` sin caracterizar | [`../PLANTILLA.md`](../PLANTILLA.md) |

Señal/piso: probablemente menor que 1 con una pareja. El diseño es estadístico desde el principio: el número de réplicas por
casilla se fija en el prerregistro a partir del desajuste, y "sin daño dentro de las reglas" es un resultado previsto. Segundo
observable, más sensible que el umbral: las trampas creadas, por el ruido telegráfico (XC-19) o el bombeo de carga (XC-43).

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El diodo de protección carga el nodo (capacidad y fuga) y cambia el retardo sin que haya daño | Diodo conectado tarde: el mismo diodo unido a la red solo en el metal más alto, donde ya no protege los grabados de abajo |
| La antena es capacidad de hilo y frena el anillo | Ficticio: el mismo metal colgado de la salida del excitador por el lado de la difusión, donde no es antena; y la extracción lo predice |
| Desajuste y gradiente | Réplicas especulares e intercaladas; casillas del factorial repartidas, no agrupadas |
| LOD y entorno distintos entre casillas | El transistor y su celda son idénticos; solo cambia el metal por encima. Anotar con Residual y comprobar |
| El enrutador añade saltos o diodos y deshace el factorial | Macro endurecido con el metal dibujado a mano; revisar el DEF final |
| Envejecimiento durante la propia medida | Gemelo sin antena medido con la misma secuencia y duración |

El factorial 2×2 es exposición (antena pequeña o al límite) × protección (sin diodo o con diodo). La quinta casilla, diodo
tardío, es la que impide confundir protección con carga eléctrica.

## 4. Referencia convencional (control científico, no filtro)

La regla de antena y la celda de diodo de la biblioteca estándar: es lo que hace todo flujo digital, y aquí el enrutador lo aplica
solo. El experimento compara "respetar la regla basta" (lo convencional) con "dentro de la regla queda un efecto medible". Si no
hay diferencia entre casillas, lo convencional gana y el resultado es un margen medido de la regla, que tampoco está publicado
para este proceso. Como fuente de trampas para XC-19 compite con el estrés en mesa de XC-10, que es controlable y reversible.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: contrato del factorial escrito en la versión 0.4 del catálogo del laboratorio (sin publicar).
2. Hecho: límites de antena leídos por agente; el precheck no los comprueba en sky130A. EFLD-01 pasó el flujo con antena 0
   (`local_flow/efld_01/LEEME.md`, **corrida**, sin publicar): el flujo local sí la informa.
3. Pendiente: leer nosotros la página de reglas de antena y la de supuestos (cómo se calcula el área: lateral o superior, por
   capa o acumulada). Sin eso no se sabe qué es "al límite".
4. Pendiente: anotador de relación de antena por puerta y por paso en Residual, cotejado contra el informe del flujo.
5. Pendiente: dibujar por script las cinco casillas con el mismo transistor, DRC en los dos decks, extraer y simular. Predicción
   escrita antes: la simulación da diferencia cero en umbral y una diferencia de retardo igual a la de la capacidad extraída.
6. Pendiente: presupuesto de réplicas con el Monte Carlo de desajuste del PDK para el transistor elegido.
7. Pendiente: leer una fuente con daño de plasma medido en óxidos de este espesor (`toxe` 4,148 nm, **PDK**, laboratorio) `[?]`.

### 5.2 Configuraciones a dibujar

Valores propuestos. Todo dentro de los límites leídos; "límite" es la relación máxima de cada capa.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Factorial base | Antena {10 % del límite, 90 %} × {sin diodo, diodo temprano}, más diodo tardío | ¿Hay efecto de la exposición que la protección anule? |
| Relación de antena | 10, 25, 50, 75, 90 % del límite, sin diodo | Dosis–respuesta: sin ley monótona no hay mecanismo |
| Capa | poly; li; met1; met2; met3; met4 | ¿Qué grabado daña más? Los límites difieren (50, 75, 400): ¿corresponden a un daño igual? |
| Perímetro frente a área | Placa cuadrada frente a peine de ancho mínimo, misma área superior | El grabado carga por el flanco: la regla, ¿cuenta lo que importa? |
| Acumulada frente a una sola capa | Toda la antena en met1 frente a repartida en met1 a met4 | ¿El daño es del peor paso o de la suma? |
| Área de puerta | 0,42/0,15; 1,0/0,15; 5,0/0,15 | Misma relación, distinta corriente por unidad de óxido; y el piso baja con el área |
| Posición del diodo | Junto a la puerta; al final de la antena; solo en el metal más alto | ¿Protege el diodo a distancia? Resistencia del camino |
| Tipo | nfet y pfet | Signo de la carga de plasma |
| Forma de leer | Pareja en inversión débil; anillo de la celda; canal de XC-19 buscando trampas | Umbral, retardo y trampas son tres observables del mismo daño |

Primero un canal completo: una casilla al 90 % en met1 sin diodo y su gemelo con diodo tardío, leídos por el mismo lector.

### 5.3 En silicio

1. **Virgen:** todas las casillas y sus gemelos, a temperatura ambiente, antes de cualquier estrés de otras familias.
2. **Calibrar:** escalón de puerta del lector; la pareja de XC-12 como comprobación de escala.
3. **Caracterizar:** diferencia por casilla con intervalo entre réplicas; análisis del factorial (efecto principal e interacción).
4. **Barrer:** temperatura. Opcional y con permiso: un estrés suave igual para todas (XC-10); un óxido dañado envejece antes, y
   esa diferencia puede verse aunque la inicial no.
5. **Repetir:** el daño es permanente; debe estar igual otro día. Si se recupera, no era daño.
6. **Clasificar:** efecto con dosis–respuesta, sin efecto bajo límite conocido, inconcluso, fallo de lector.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** efecto principal de la exposición mayor que su intervalo, que el diodo temprano anula y el tardío no, con ley
  monótona en la relación de antena.
- **Negativo informativo:** ninguna casilla se separa, con réplicas suficientes para un límite de detección escrito antes. Es el
  resultado previsto: mide el margen de la regla.
- **Inconcluso:** diferencia que aparece igual con diodo tardío y temprano (es carga eléctrica), o réplicas insuficientes.
- **Fallo instrumental:** la pareja de XC-12 no se resuelve.
- **Muere** si el presupuesto de réplicas para ver un efecto del tamaño del desajuste no cabe en el área disponible.

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

- Sin permiso especial mientras todo quede dentro de las reglas; aun así, avisar a Tiny Tapeout de que hay antenas deliberadas.
- Macro propio, o colocación y enrutado controlados: el reparador de antena del flujo debe quedar fuera de estas redes.
- Comparte presupuesto de réplicas y lector con XC-12 y XC-13. Sirve de control sobrio a XC-14 y de fuente de trampas a XC-19 y
  XC-43.
- Un chip informa del dado, no del lote: el daño de plasma varía con la posición en la oblea, que no se conoce.

## 8. Abierto y fuentes

- Cómo calcula la fábrica el área de antena y si la comprueba `[?]`.
- Magnitud del daño dentro de las reglas `[?]`. Posición del dado en la oblea `[?]`.
- Origen: laboratorio, `docs/EQUIPO.md` ("El Grabado") y catálogo v0.4, sin publicar. Reglas y precheck:
  [pesca](../notas/PESCA_2026-11-12.md). Presupuesto: [`experiments/lod_audit`](../../experiments/lod_audit/README.md).
  Planes ligados: [XC-14](../xc14_antenna_write/PLAN.md), [XC-12](../xc12_lod_stress/PLAN.md), [XC-10](../xc10_ageing/PLAN.md).
