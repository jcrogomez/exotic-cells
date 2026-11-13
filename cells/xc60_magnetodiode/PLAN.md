# XC-60 · Magnetodiodo

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-60 de [catálogo](../../README.md#catalogue) (Magnetodiode).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12, salida del mapa del espacio de diseño
([`../notas/MAPA_ESPACIO.md`](../notas/MAPA_ESPACIO.md)). Sin atacar todavía: ningún número de aquí está verificado.

## 0. Primeros principios

Celda vacía del mapa: magnético → eléctrico por recombinación de superficie. En un diodo largo en inyección alta, la fuerza de Lorentz desvía los portadores hacia una cara; si esa cara recombina más que la opuesta, la corriente cambia con el signo del campo. Aquí la cara de alta recombinación es gratis: la interfaz con el aislamiento. Sensibilidad publicada en otros procesos `[?]` (del orden de V/T, **de memoria**); con ~2 mT de la microbobina (**verificado**) serían milivoltios.

**Regiones.** Convencional: diodo corto, el campo no hace nada medible. Tercera: diodo largo junto a una interfaz, con respuesta impar en el campo mucho mayor que la Hall. Fallo: no aplica.

## 1. Ficha

**XC-60 · Magnetodiodo.** Deflexión magnética hacia una superficie recombinante → diodo p+/n/n+ largo en un pozo, con un lado pegado al borde del aislamiento y el otro lejos → campo en el plano, perpendicular a la corriente → tensión o corriente impar con el campo → sensor magnético sensible sin material magnético → lector de umbral → mismo diodo centrado (las dos caras iguales: sin respuesta).

**[corregido 2026-11-12 13:57]** Escala de primer orden: el ángulo de deflexión va como µ·B; con 0,1 m²/(V·s) y 2 mT son 2·10⁻⁴ (**cálculo**, movilidad supuesta). La geometría tiene que amplificar una perturbación pequeña: no se da por hecha una sensibilidad grande.

**[corregido 2026-11-12 19:54] Ronda de ataque 3** ([resumen](../../experiments/RONDA_3_2026-11-12.md)): mi geometría estaba mal orientada: con campo en el plano la deflexión es vertical y la cara que cuenta es la unión pozo–sustrato; el diodo debe ser corto (un agente). Campo de una tira de met1 de 5 µm con 14 mA: ~1,0–1,25 mT (verificado). Señal 0,05–3 pasos del lector; no se puede afirmar que gane a una placa Hall.

## 2. Lectura y piso

Lector de XC-19 sobre la tensión del diodo, o integrador de corriente. Señal `[?]`.

## 3. Explicación aburrida y controles

Efecto Hall del propio pozo (también impar): diodo centrado como control. Calor de la bobina (par): se va al invertir el campo.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer una fuente de magnetodiodos en CMOS o en silicio sobre aislante: sensibilidad y longitud necesaria frente a la longitud de difusión.
2. La bobina de XC-56 da campo vertical; hace falta campo en el plano: bobina desplazada o línea recta de corriente encima (campo de un hilo: µ₀I/2πd).
3. Simulación de dispositivo (S3) con recombinación de superficie barrida.

### 5.2 Configuraciones a dibujar

Propuesta: largo 5, 20 y 50 µm; distancia de la cara al aislamiento 0 y 2 µm; en pozo n y en sustrato; con línea de corriente en met1 a distintas alturas.

### 5.3 En silicio

Tensión frente a corriente de la línea en los dos sentidos; frente a la corriente del diodo; comparación con la placa Hall de XC-25 bajo el mismo campo.

### 5.4 Criterio de muerte (borrador)

Muere si la respuesta impar no supera la del diodo centrado.

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

Usa XC-56 o una línea de corriente. Emparentada con XC-52: las dos usan la interfaz, una por espín y otra por deflexión.

## 8. Abierto y fuentes

- Sensibilidad y recombinación de superficie de SKY130 `[?]`.
