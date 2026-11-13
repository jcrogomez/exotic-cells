# XC-55 · Fonones en la pila de metales

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-55 de [catálogo](../../README.md#catalogue) (Phonons in the metal stack).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12. Los números de este archivo son
**cálculo** con constantes de memoria salvo donde se cita otra cosa; ninguno está verificado contra fuente ni simulado.

## 0. Primeros principios

El sonido en silicio va a ~8400 m/s y en óxido a ~5900 m/s (**de memoria**). Una rejilla de metal y óxido de paso p refleja
ondas acústicas de longitud 2p: con p = 1 µm, del orden de 3 a 4 GHz. La pila de metales puede ser un espejo acústico dibujado,
y una cavidad entre dos espejos, un resonador sin liberar nada.

**Tres regiones.** Convencional: los metales son cables. Tercera: una resonancia mecánica a una frecuencia fijada por el layout.
Fallo: no aplica (pasa DRC como relleno ordenado).

## 1. Ficha

**XC-55 · Fonones en la pila de metales.** Reflexión de Bragg acústica en rejillas de metal → cavidad entre dos rejillas sobre un
condensador MOS que empuja y un transistor que siente → ninguna → pico en la respuesta frente a frecuencia → referencia de
frecuencia, filtro, sensor de masa o temperatura → oscilador + divisor → misma estructura con la rejilla desordenada.

## 2. Lectura y piso

Hay que leer gigahercios con pines de 50 MHz: oscilador en el chip con divisor, o mezcla. La transducción por un condensador
MOS es débil y el factor de calidad `[?]`. Sin número de señal todavía: es la entrada más especulativa del catálogo.

## 3. Explicación aburrida y controles

Resonancia eléctrica LC de la propia rejilla: cambia con el paso de otra manera que la acústica (la acústica va con 1/p; la LC
con la capacidad). Control: rejilla desordenada de igual densidad de metal.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer la fuente sobre resonadores sin liberar en CMOS estándar.
2. Bandas acústicas 1D de la rejilla metal/óxido por matriz de transferencia, con espesores supuestos y barridos.
3. Estimar la transducción y decidir si hay lectura posible.

### 5.2 Configuraciones a dibujar

Propuesta: paso de la rejilla 0,5; 1; 2 µm; cavidad de 1, 3 y 5 medias ondas; rejilla periódica frente a desordenada; met1
solo frente a met1–met3 apilados.

### 5.3 En silicio

Barrido de frecuencia del oscilador de excitación; buscar un pico que se mueva con el paso dibujado y con la temperatura.

### 5.4 Criterio de muerte (borrador)

Muere en papel si 5.1 da una transducción sin lectura posible con los medios del chip.

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

Ninguna. Es geometría legal de metal.

## 8. Abierto y fuentes

- Todo: espesores, velocidades en los metales, pérdidas. Lectura pendiente en `docs/READING.md`.
- **Comprobación de citas del 2026-11-12** ([`docs/READING.md`](../../docs/READING.md)): resonadores sin liberar con cristales fonónicos en la pila de metales: factor de calidad sobre 13 000 a 3,185 GHz en 32 nm SOI (**sin leer**). El precedente existe; en un proceso abierto de 130 nm no se encontró.
