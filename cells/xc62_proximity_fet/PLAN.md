# XC-62 · Transistor impreso por proximidad

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-62 de [catálogo](../../README.md#catalogue) (Proximity-printed transistor).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12, salida del mapa del espacio de diseño
([`../notas/MAPA_ESPACIO.md`](../notas/MAPA_ESPACIO.md)). Sin atacar todavía: ningún número de aquí está verificado.

## 0. Primeros principios

Dimensión de historia de fabricación del mapa, y la respuesta enviable al resultado del precheck: las rupturas de ancho y separación se rechazan, pero las formas legales que se imprimen distinto pasan. La imagen aérea (`experiments/litho_explore`, **corrida**, óptica supuesta) da un cuello legal corto impreso al doble de ancho, y un cuello legal de 0,30 µm impreso entre 0,115 y 0,175 µm según el ajuste. En poly eso es la puerta: el largo real del canal depende de lo que haya alrededor.

**Regiones.** Convencional: puerta recta y aislada, el largo impreso es el dibujado. Tercera: el largo o el ancho efectivos los fija la vecindad dibujada, de forma repetible. Fallo: la puerta no cubre la difusión y el transistor queda en corto.

## 1. Ficha

**XC-62 · Transistor impreso por proximidad.** Redondeo y retroceso litográficos → puerta mínima con vecinos, codos, puntas y ensanches a distancias legales distintas → la fábrica → corriente del transistor frente a la vecindad dibujada → transistor cuyo umbral o corriente se elige por entorno, sin máscaras ni tamaños nuevos → lector de XC-19 → la misma puerta aislada.

**[corregido 2026-11-12 19:54] Ronda de ataque 3** ([resumen](../../experiments/RONDA_3_2026-11-12.md)): todas las variantes son legales (reglas verificadas en el tech). El umbral se mueve −1,2 a −1,8 mV por nm de largo en L = 0,15 (verificado): 10–14 nm igualan el desajuste. Que la fábrica corrija la proximidad en poly es inferencia de dos nombres de capa; si corrige, la celda mide el residuo.

## 2. Lectura y piso

Lector de XC-19 (0,305 mV → 0,83 %). Señal: `[?]`, depende de si la fábrica corrige la proximidad.

## 3. Explicación aburrida y controles

Esfuerzo mecánico por la vecindad (XC-12, XC-16) y desajuste: variantes con la misma difusión y distinta vecindad de poly, y réplicas.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Imagen aérea (S1) para poly sobre difusión: punta de puerta, codo junto a la difusión, vecinos a un paso y a dos.
2. Qué corrección de proximidad aplica la fábrica `[?]`: si corrige, el efecto es menor y esto mide su corrección.
3. Todas las variantes son legales: DRC y precheck.

### 5.2 Configuraciones a dibujar

Propuesta: extensión de la puerta sobre el borde de la difusión (mínima a holgada); vecinos de poly a 0,21; 0,42 y 1 µm por uno y por los dos lados; codo de poly a distancia mínima de la difusión; puerta en U.

### 5.3 En silicio

Corriente en inversión débil de cada variante contra su gemela aislada; varias réplicas en posiciones distintas.

### 5.4 Criterio de muerte (borrador)

Muere si ninguna variante se separa de la aislada por encima del desajuste entre réplicas.

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

Sin permisos: es geometría legal. Comparte matriz con XC-12/13/16.

## 8. Abierto y fuentes

- Óptica y corrección de la fábrica `[?]`.
