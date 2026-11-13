# XC-16 · Entorno por colocación

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-16 de [catálogo](../../README.md#catalogue) (Placement environment).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-16 · Entorno por colocación.** Vecindad, orientación, densidad, distancia a taps → la misma celda estándar con entorno fijado
por placement → ninguna → Δf entre anillos intercalados → corrección de modelo por entorno → — → 8 variantes × 4 réplicas.
**Mantener:** es la versión de XC-12/13 que no necesita macro. Con el resultado de hoy tiene predicción: los `sa/sb` reales de cada
celda.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** "Tiene predicción" era excesivo: los `sa/sb` son internos a cada celda, así que el modelo anotado predice diferencia nula entre entornos. El experimento mide si el silicio se aparta de ese cero.

## 2. Lectura y piso

Cociente de dos anillos de la misma celda estándar, contados en la misma ventana. No necesita transistores propios.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal que predice el modelo anotado entre dos entornos | Cero. `sa`/`sb` se miden dentro de la celda y no cambian al moverla; la tarjeta no conoce pozo ni vecinos | deducción de `residual/README.md` y `experiments/stdcell_lod` |
| Escala de lo que el contexto mueve un anillo | 2,5 a 5,1 % (anotado frente a extraído, anillos de 7 etapas) | `experiments/stdcell_lod`, **corrida**, solo modelo |
| Diferencia entre celdas de la biblioteca por su difusión | Lado corto: mediana 0,68 µm, mínimo 0,25 µm; `inv_1` 0,26 µm | mismo, **corrida** |
| Piso del cociente de dos anillos | `[?]` sin caracterizar | [`../PLANTILLA.md`](../PLANTILLA.md) |
| Absolutos en silicio | Osciladores ajenos 25–40 % más lentos que en simulación | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Plataforma | Anillo de 13 inversiones con prescaler y contador de ventana, endurecido | `local_flow/efld_00/LEEME.md`, **corrida**, sin publicar |

Señal/piso: desconocida. La predicción del modelo es que no hay señal de entorno; cualquier diferencia reproducible es residuo.
Si el residuo queda bajo el 1 % del cociente, se dice y se cierra como límite.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El enrutado difiere entre réplicas: más hilo, más capacidad | Anillo endurecido como macro con hilos idénticos; lo único que cambia es lo que hay fuera. Extraer y comparar capacidades |
| Desajuste entre anillos | 4 réplicas por variante (ficha); cada etapa promedia varios transistores |
| Gradiente del dado y de temperatura | Variantes intercaladas, réplicas especulares, un anillo de referencia en cada esquina |
| Caída de alimentación distinta según la posición en la fila | Misma distancia a las bandas de alimentación; anillo de referencia en la misma fila; canal de XC-32 |
| Acoplamiento con vecinos que conmutan | Vecinos quietos durante la ventana; fantasma: un hueco con las mismas celdas vecinas y sin anillo |
| Relleno y metal superior que no controlamos | Comparar el GDS final, no el plan; registrar la densidad real sobre cada anillo |

Gemelo: el mismo macro de anillo en el entorno "neutro" (rodeado de sus propias copias inactivas).

## 4. Referencia convencional (control científico, no filtro)

La biblioteca de tiempos de `sky130_fd_sc_hd`, que da un retardo por celda sin saber dónde está colocada, y las esquinas del
proceso, que cubren con margen lo que no se modela. Lo convencional gana si ningún entorno mueve el anillo más que el margen
entre esquinas `[?]` o más que el desajuste: entonces el flujo no necesita corrección por colocación y se dice así. La familia
gana solo si aparece un residuo sistemático, repetible entre réplicas y atribuible a una variable de la tabla.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: `sa`/`sb` reales de las 415 celdas anotadas (`experiments/stdcell_lod/devices.csv`). Era el paso 4 de la cola del
   laboratorio.
2. Hecho: plataforma de anillo y contador endurecida dos veces (EFLD-00 y EFLD-01, sin publicar).
3. Pendiente: escribir la predicción nula: extraer el mismo macro de anillo colocado en los ocho entornos y simular. La diferencia
   debe ser la de la capacidad extraída y nada más. Si la simulación ya separa los entornos, eso es hilo, y se rediseña el control.
4. Pendiente: comprobar si las celdas colindantes de la biblioteca comparten difusión o pozo al abutir (el pozo n de la fila es
   continuo; la difusión `[?]`). Si comparten, `sa`/`sb` sí dependerían del vecino y el anotador tendría que leer la fila aplanada.
5. Pendiente: anotar con Residual un bloque colocado y aplanado, no solo celdas sueltas.
6. Pendiente: averiguar cómo se caracterizó la biblioteca (misma duda que XC-12).
7. Pendiente: generar las variantes por script de colocación (posiciones fijas en el DEF) y verificar que sobreviven al flujo.

### 5.2 Configuraciones a dibujar

Ocho variantes × cuatro réplicas, como en la ficha. Valores propuestos; las distancias, en múltiplos del paso de fila y de sitio.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Vecino lateral | Copias del anillo; celdas de relleno; celdas de desacoplo; hueco vacío | ¿Importa qué difusión y qué poly hay al lado? (LOD entre celdas, densidad de poly) |
| Distancia al contacto de pozo y sustrato | Junto a la celda de tap; a media distancia; cerca del máximo (LU.2: 15 µm, **corrida**) | ¿Cambia el umbral con la resistencia de cuerpo o con la proximidad del implante del tap? |
| Posición en la fila respecto al pozo | Fila normal y fila volteada (el pozo n queda arriba o abajo); fila del borde del bloque | Proximidad de pozo vista desde una celda estándar: la versión sin macro de XC-13 |
| Densidad local | Anillo en zona al 25 % de utilización (la de EFLD-00) frente a zona densa | Densidad de poly y de difusión: grabado y pulido |
| Orientación | Celdas espejadas en X; anillo dispuesto en horizontal frente a doblado en dos filas | Asimetría de litografía; la rotación a 90° no existe en filas estándar y pasa a XC-12 y XC-44 |
| Borde de macro | Pegado al halo de un macro (2 µm en EFLD-00) frente a lejos | ¿El borde de un bloque sin celdas altera a las vecinas? |
| Metal por encima | Sin pistas sobre el anillo frente a pistas de alimentación encima | Capacidad y, si lo hay, esfuerzo del metal; liga con XC-17 |
| Celda del anillo | `inv_1` (0,26 µm de difusión) frente a `inv_2` y `nand2_1` | Celdas con distinto `sa`/`sb`: ¿el efecto del entorno escala con lo corta que es la difusión? |
| Longitud del anillo | 7 y 13 etapas | Más etapas promedian desajuste; el cociente no debe depender de ellas |

Primero un canal completo: un anillo y su gemelo en entorno neutro, con el contador de EFLD-00, antes de las ocho variantes.

### 5.3 En silicio

1. **Virgen:** cuentas de todos los anillos en la misma ventana, en orden aleatorio y repetido.
2. **Calibrar:** piso del cociente con dos anillos idénticos en entorno idéntico. Es el número que falta en la plantilla.
3. **Caracterizar:** cociente de cada variante contra su gemelo; intervalo entre las cuatro réplicas.
4. **Barrer:** alimentación y temperatura. Un efecto de umbral cambia con la alimentación de forma distinta que uno de capacidad:
   el primero pesa más a tensión baja.
5. **Repetir:** otro día; si hay otro chip, comprobar que el orden de las variantes se conserva.
6. **Clasificar** cada variable: mueve el anillo de forma repetible, no lo mueve por encima del piso, inconcluso, fallo.

No hay transformación ni permiso que pedir.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** al menos una variable separa sus réplicas de las del gemelo por más que el piso medido, con el mismo signo en las
  cuatro, y la simulación extraída no lo explica.
- **Negativo informativo:** ninguna variable supera el piso, y el piso es conocido. Conclusión: a esta escala la colocación no
  importa y la biblioteca basta. Es el resultado que hoy predice el modelo.
- **Inconcluso:** diferencias del tamaño de la dispersión entre réplicas, o explicadas por el enrutado.
- **Fallo instrumental:** dos anillos idénticos difieren más que las variantes.
- **Muere** si la simulación extraída muestra que el hilo domina toda diferencia y no hay forma de igualarlo.

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

- Solo flujo digital: es la familia más barata del grupo. Necesita colocación fija y el anillo como macro endurecido.
- Usa la plataforma de EFLD-00/01 y el contador común. Su piso calibrado sirve a todas las familias que leen por cociente de
  anillos.
- Depende de Residual para la predicción; es la versión sin macro de XC-12 y XC-13 y comparte control con XC-44.
- El relleno lo pone la integración de Tiny Tapeout: si se puede bloquear sobre los anillos `[?]` (sin regla pública hallada).
- Un chip basta para lo sistemático dentro del dado.

## 8. Abierto y fuentes

- Piso real del cociente de dos anillos `[?]`. Margen entre esquinas del modelo para estos anillos `[?]`.
- Si las celdas vecinas comparten difusión. Cómo se caracterizó la biblioteca.
- Origen: "Los Gemelos" en el laboratorio (`docs/CARTERA.md`, sin publicar).
- Corridas: [`experiments/stdcell_lod`](../../experiments/stdcell_lod/README.md), [`residual`](../../residual/README.md).
  Lecciones de otros osciladores: [pesca](../notas/PESCA_2026-11-12.md). Planes ligados: [XC-12](../xc12_lod_stress/PLAN.md),
  [XC-13](../xc13_well_proximity/PLAN.md), [XC-44](../xc44_package_stress/PLAN.md).
