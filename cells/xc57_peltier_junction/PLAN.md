# XC-57 · Unión Peltier

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-57 de [catálogo](../../README.md#catalogue) (Peltier junction).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12, salida del mapa del espacio de diseño
([`../notas/MAPA_ESPACIO.md`](../notas/MAPA_ESPACIO.md)). Sin atacar todavía: ningún número de aquí está verificado.

## 0. Primeros principios

Celda vacía del mapa: eléctrico → térmico con signo. El calor Peltier es Π·I con Π = S·T; el Joule es I²R. El primero cambia de signo con la corriente, el segundo no. Con S ≈ 0,75 mV/K por par (cifra de la pesca, **sin leer**) y 300 K, Π ≈ 0,22 V: a 1 mA bombea ~0,2 mW, y domina sobre el Joule de la unión mientras I < Π/R (0,2 mA si R = 1 kΩ) (**cálculo**).

**Regiones.** Convencional: la unión solo calienta, igual en los dos sentidos. Tercera: una parte del calor cambia de signo con la corriente (enfría un extremo). Fallo: no aplica.

## 1. Ficha

**XC-57 · Unión Peltier.** Efecto Peltier en la unión de dos conductores de la pila (poly n / poly p, poly / difusión, metal / poly) → cadena de uniones con las de un signo agrupadas sobre un sensor → corriente en un sentido y en el otro → diferencia de temperatura entre los dos sentidos → refrigeración o estabilización térmica local de una celda sensible, bomba de calor sin partes → lector de XC-19 como termómetro → la misma cadena con las uniones intercaladas (el Peltier se cancela, el Joule no).

**[corregido 2026-11-12 19:54] Ronda de ataque 3** ([resumen](../../experiments/RONDA_3_2026-11-12.md)): la componente impar existe en el modelo (0,2–7 K en la unión a 100 µA, verificado en intervalo) y hay una ventana de enfriamiento neto (décimas de K a decenas de µA con una pata p+). El lector en el silicio recibe del orden del 1 %: la lectura es de segundos, no de milisegundos. Variante: resistor de difusión p+, que deja el calor de sus contactos en el silicio junto al lector.

## 2. Lectura y piso

Lector en inversión débil como termómetro: su corriente deriva ~5 %/K (**corrida**, `experiments/xc19_weak_inversion`). Una diferencia de 10 mK da 0,05 %: bajo el 1 %; se gana alternando el sentido de la corriente y contando en síncrono.

## 3. Explicación aburrida y controles

Calentamiento Joule (par con la corriente): se resta alternando el sentido. Asimetría del driver entre sentidos: medir la corriente en los dos. Control: cadena intercalada.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer una fuente con coeficientes Seebeck de las capas de un CMOS de 130–180 nm.
2. Electrotérmica (S4) de la cadena con el óxido real bajo ella: ΔT por mW y constante de tiempo.
3. Dibujar la cadena y su gemela intercalada; DRC.

### 5.2 Configuraciones a dibujar

Propuesta: 10, 30 y 100 uniones; poly n/poly p frente a poly/difusión; uniones a 1, 3 y 10 µm del sensor; ancho de las pistas (resistencia frente a conducción de calor de vuelta).

### 5.3 En silicio

Corriente alterna cuadrada en los dos sentidos; diferencia de temperatura síncrona; debe ser lineal en I y la suma, cuadrática.

### 5.4 Criterio de muerte (borrador)

Muere si la diferencia entre sentidos no supera la asimetría medida del driver con el promedio convergido.

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

Usa el lector de XC-19. Emparentada con XC-39 (calor como señal) y con la termopila XC-40, que es su inversa.

## 8. Abierto y fuentes

- Coeficientes Seebeck reales de SKY130 `[?]`.
