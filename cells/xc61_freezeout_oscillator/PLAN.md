# XC-61 · Oscilador por congelación de portadores

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-61 de [catálogo](../../README.md#catalogue) (Freeze-out breakdown oscillator).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12, salida del mapa del espacio de diseño
([`../notas/MAPA_ESPACIO.md`](../notas/MAPA_ESPACIO.md)). Sin atacar todavía: ningún número de aquí está verificado.

## 0. Primeros principios

Dimensión de entorno del mapa. A pocos kelvin los portadores del silicio poco dopado se congelan en sus dopantes; un campo de pocos V/cm los vuelve a ionizar por impacto y la resistencia cae de golpe, con característica en S, filamentos de corriente y oscilaciones espontáneas (física clásica de semiconductores a baja temperatura, **de memoria**). El sustrato de SKY130 es de dopado bajo `[?]`.

**Regiones.** Convencional: resistencia que sube al enfriar. Tercera: ruptura reversible con resistencia negativa y oscilación. Fallo: no aplica.

## 1. Ficha

**XC-61 · Oscilador por congelación de portadores.** Ionización por impacto de dopantes congelados → resistor de sustrato entre dos tomas p+, o de pozo → enfriar bajo ~20 K → característica en S, oscilación → oscilador y elemento no lineal criogénico sin transistores → — → la misma estructura a 77 K (sin congelación completa).

**[corregido 2026-11-12 13:57]** Las regiones muy dopadas (difusiones, y quizá el pozo) no se congelan: la hipótesis vale para el silicio de dopado bajo. Barrer temperatura y dopado.

**[corregido 2026-11-12 19:54] Ronda de ataque 3** ([resumen](../../experiments/RONDA_3_2026-11-12.md)): «pocos V/cm» era de germanio; en silicio lo leído son ~125 V/cm con 5·10¹³ (pulso aplicado, no umbral). El pozo se congela hacia 18–37 K y a 77 K sigue ionizado al 6–37 % (verificado, con estadística dudosa a ese dopado): a 77 K no hay oscilador. Transformada: diodo p+/pozo n/toma n+ en directa a 4,2 K que dispara pulsos (un agente, fuente leída por subagente).

## 2. Lectura y piso

Lectura directa por pines o por un contador si los transistores siguen funcionando en frío. Sin número.

## 3. Explicación aburrida y controles

Calentamiento propio que descongela (térmico, lento) frente a ionización por impacto (eléctrico, rápido): escala de tiempo.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer una fuente sobre ruptura por ionización de impurezas en silicio y su campo umbral.
2. Dopado del sustrato de SKY130 `[?]`.

### 5.2 Configuraciones a dibujar

Dos tomas de sustrato a 2, 10 y 50 µm: ya existen en cualquier diseño. No pide área propia.

### 5.3 En silicio

Curva corriente–tensión de 300 K a la temperatura base; buscar el codo y oscilaciones.

### 5.4 Criterio de muerte (borrador)

Negativo informativo si no hay codo hasta la temperatura base del criostato disponible.

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

Vehículo especializado: criostato. Viaja con XC-54.

## 8. Abierto y fuentes

- Todo: dopado del sustrato, temperatura necesaria.
