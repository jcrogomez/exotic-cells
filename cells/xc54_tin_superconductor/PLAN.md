# XC-54 · Interconexión local superconductora

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-54 de [catálogo](../../README.md#catalogue) (Superconducting local interconnect).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12. Los números de este archivo son
**cálculo** con constantes de memoria salvo donde se cita otra cosa; ninguno está verificado contra fuente ni simulado.

## 0. Primeros principios

La interconexión local de SKY130 es nitruro de titanio (**leído por agente**). El TiN es superconductor con temperatura
crítica de décimas a pocos kelvin según su composición (**de memoria**, fuente por leer). Si el de SKY130 transita, el proceso
abierto tiene un superconductor gratis, y con una constricción (las de XC-02 ya están dibujadas) un eslabón débil.

**Tres regiones.** Convencional: resistencia que baja suavemente con la temperatura. Tercera: cae a cero bajo una temperatura
crítica y reaparece sobre una corriente crítica. Fallo: no aplica.

## 1. Ficha

**XC-54 · Interconexión local superconductora.** Superconductividad del TiN → serpentín de li y constricciones de li (XC-02) →
enfriar → resistencia frente a temperatura y corriente → interconexión sin pérdidas, eslabón débil, inductancia cinética → — →
la misma línea en met1 (aluminio, transita cerca de 1,2 K, **de memoria**) como referencia.

## 2. Lectura y piso

En frío no vale el lector de la tesela sin más: los transistores de SKY130 funcionan a 4 K (**sin leer**), pero el modelo no.
Lectura directa a cuatro hilos por pines analógicos, o por el anillo con resistencia en serie si sigue oscilando.

## 3. Explicación aburrida y controles

Caída de resistencia por contactos que cambian con la temperatura: medir a cuatro hilos y comprobar que hay corriente crítica.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer la fuente sobre TiN y el conjunto de datos criogénico de NIST sobre SKY130 (pesca): puede que la resistencia de li a
   baja temperatura ya esté medida.
2. Buscar un laboratorio con criostato dispuesto a medir un chip encapsulado.

### 5.2 Configuraciones a dibujar

Ya dibujadas en el laboratorio: líneas de li de 0,17 y 0,29 µm. Añadir: serpentín largo, y pines analógicos si la plantilla
los da.

### 5.3 En silicio

Resistencia de 300 K a la temperatura base; si hay transición, corriente crítica y campo crítico.

### 5.4 Criterio de muerte (borrador)

- **Negativo informativo:** sin transición hasta la temperatura base del criostato disponible.
- No ocupa área propia: no muere, espera.

## 6. Documentación para graduarse

- [ ] Hoja de primeros principios revisada por un ataque independiente
- [ ] Mapa de tres regiones por simulación física, con sus barridos
- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC en Magic y KLayout, y resultado del precheck (qué pasa y qué no)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] README en inglés

## 7. Compuertas y dependencias

Vehículo especializado: criostato. Absorbe XC-30 (coherencia mesoscópica), que nunca tuvo definición.

## 8. Abierto y fuentes

- Composición del TiN de SKY130 `[?]`. ¿Hay informes de superconductividad en capas de un proceso comercial? Por buscar.
- **Comprobación de citas del 2026-11-12** ([`docs/READING.md`](../../docs/READING.md)): temperatura crítica del TiN entre 0 y 5 K según composición (Leduc 2010, resumen leído por agente). Hay TiN superconductor en un proceso comercial de 22 nm, en la capa de resistencia, medido entre 0,15 y 1,19 K (resumen leído por agente); nada hallado para interconexión local.
