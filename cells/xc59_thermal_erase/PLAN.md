# XC-59 · Escritura eléctrica, borrado térmico

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-59 de [catálogo](../../README.md#catalogue) (Electrical write, thermal erase).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12, salida del mapa del espacio de diseño
([`../notas/MAPA_ESPACIO.md`](../notas/MAPA_ESPACIO.md)). Sin atacar todavía: ningún número de aquí está verificado.

## 0. Primeros principios

Celda vacía del mapa: térmico → estado. El estrés eléctrico crea trampas y carga atrapada; parte se recupera sola y más deprisa en caliente (la recuperación de la inestabilidad por polarización y temperatura es conocida, **de memoria**). Un calefactor en el chip convierte esa recuperación en una operación.

**Regiones.** Convencional: el transistor envejece y es un defecto. Tercera: escribir con estrés y borrar con calor es un ciclo repetible con estados intermedios. Fallo: daño que ya no se recupera.

## 1. Ficha

**XC-59 · Escritura eléctrica, borrado térmico.** Creación y recocido de defectos → transistor de XC-19 junto a un calefactor (XC-31) → estrés de puerta o de portadores calientes, y luego pulso de calor → corrimiento de umbral que va y vuelve → memoria analógica de escritura eléctrica y borrado térmico; perilla del número de trampas para XC-19 y XC-52 → lector de XC-19 + calefactor → gemelo estresado sin calentar, y gemelo calentado sin estresar.

**[corregido 2026-11-12 19:54] Ronda de ataque 3** ([resumen](../../experiments/RONDA_3_2026-11-12.md)): **muere en su forma original:** un calefactor sobre óxido transmite al canal de un transistor en silicio el 1–16 % de su subida (verificado); no se puede recocer en chip. Sigue viva en un elemento de poly sobre óxido entre dos calefactores (70–77 %, verificado), o con el borrado en horno. La escritura a 1,8 V sería pequeña y volátil (un agente, extrapolado).

## 2. Lectura y piso

Lector de XC-19: 0,305 mV → 0,83 %. Corrimiento por estrés a 1,8 V: `[?]` (1–10 mV en horas a 85 °C, **de memoria**).

## 3. Explicación aburrida y controles

Deriva térmica del lector tras el pulso de calor: esperar a que vuelva a la temperatura de partida (constante térmica de µs, **verificado** para una línea). Recuperación espontánea sin calor: gemelo sin calentar.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer una fuente sobre recuperación de la inestabilidad por polarización en óxidos de ~4 nm y su energía de activación.
2. Electrotérmica (S4): temperatura alcanzable con un calefactor de poly junto al transistor.
3. Decidir el estrés: a 1,8 V, a 3,3 V o con la bomba XC-53.

### 5.2 Configuraciones a dibujar

Propuesta: calefactor a 0,5; 1 y 3 µm; nfet y pfet; tres tamaños de transistor; estrés de puerta frente a portadores calientes.

### 5.3 En silicio

Virgen → estresar → leer → calentar → leer; repetir N ciclos; ¿vuelve al mismo punto? ¿cuántos niveles intermedios se distinguen?

### 5.4 Criterio de muerte (borrador)

Muere si el corrimiento alcanzable a las tensiones disponibles queda bajo el paso del lector, o si no hay diferencia entre calentar y esperar.

## 6. Documentación para graduarse

- [ ] Hoja de primeros principios revisada por un ataque independiente
- [ ] Mapa de regiones por simulación física, con sus barridos
- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC en Magic y KLayout, y resultado del precheck (qué pasa y qué no)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] Referencia convencional, donde ayude a identificar el mecanismo
- [ ] README en inglés

## 7. Compuertas y dependencias

Depende de XC-10 (estrés) y XC-31 (calefactor). Sirve a XC-19 y XC-52 como perilla de trampas. El estrés real, según lo que permita el vehículo.

## 8. Abierto y fuentes

- Corrimiento y recuperación en SKY130 `[?]`.
