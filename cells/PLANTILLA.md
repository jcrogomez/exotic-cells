# Cómo se rellena el `PLAN.md` de una familia

Cada familia `XC-nn` tiene una carpeta `cells/xcNN_nombre/` con un `PLAN.md`: ficha, plan de pruebas y lista de documentación.
Los layouts, simulaciones y datos de esa familia se añaden a la misma carpeta cuando existan. Ejemplo rellenado:
[`xc19_single_trap/PLAN.md`](xc19_single_trap/PLAN.md).

Decisión de Juan (2026-11-12): primero se añade y se planea todo; el filtro se hace al final, cuando se acaben las pruebas, las
simulaciones y las ideas. Por eso un plan no descarta: dice qué haría falta para saber.

## Reglas

1. **Ningún número nace aquí.** Un número sale de una corrida de este repositorio, del PDK, o de una fuente, y lleva su grado:
   **corrida**, **PDK**, **leído por agente**, **sin leer**, **de memoria**, **cálculo** (con sus supuestos). Si no hay, `[?]`.
   Un `[?]` es mejor que una cifra plausible.
2. **Observabilidad antes que sorpresa.** La sección 2 dice con qué instrumento se lee, cuál es su piso y qué señal se espera. Si
   la señal esperada no supera el 1 % del observable, se dice.
3. **El control constituye el experimento.** Gemelo (misma geometría, sin el mecanismo activo), fantasma (vecino sin dispositivo),
   ficticio (disipa igual sin el mecanismo). La sección 3 nombra la explicación aburrida y el control que la descarta.
4. (Retirada el 2026-11-12 por Juan: MISFIT no se mide contra lo convencional.)
5. **La ruta de formación no es la de lectura.** Si la familia transforma algo, van separadas, con llave y límite en hardware.
6. **Un canal completo antes que una matriz.** La sección 5.2 lista barridos, pero el primero es un canal con su lectura.
7. **Cuatro estados de resultado:** positivo, negativo informativo, inconcluso, fallo instrumental. La sección 5.4 dice qué
   sería cada uno. Es un borrador: el criterio de muerte firme se escribe en el prerregistro, antes de correr.
8. **El vehículo clasifica, no descarta.** Si la familia pide 3,3 V, pines analógicos, luz o acceso al dado, 5.1 dice lo que se
   puede hacer hoy sin silicio y 5.3 dice qué vehículo espera.
9. **Un hecho vive en un solo lugar.** No se copia la tabla del catálogo ni las fuentes de la pesca: se enlazan.

## Instrumentos disponibles (para la sección 2)

| Instrumento | Qué convierte | Número | De dónde |
|---|---|---|---|
| Lector en inversión débil (XC-19) | Umbral → tiempo de descarga | 0,305 mV → 0,83 %; ruido de disparo 0,55 % por conversión a 81 pA y 2,3 fF | `experiments/xc19_weak_inversion`, `experiments/xc19_noise`, **corrida**, solo modelo |
| Precarga y descarga (XC-26) | Corriente pequeña → tiempo | Piso modelado 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF | laboratorio de trabajo, `macros/photon`, **sin publicar** |
| Anillo con resistencia en serie (EFLD-00/01) | Resistencia → frecuencia | +1,7 % con 1 kΩ, +32 % con 10 kΩ, ×2,2 con 100 kΩ | laboratorio de trabajo, `local_flow/efld_00`, **sin publicar** |
| Cociente de dos anillos | Retardo relativo → cuentas | `[?]` sin caracterizar | — |

Ninguno está medido en silicio. Los osciladores de otros proyectos salieron 25–40 % más lentos que en simulación
([pesca](notas/PESCA_2026-11-12.md)): se miden cocientes contra una referencia, no absolutos.

## Qué va en cada sección

- **0. Primeros principios** (desde el 2026-11-12; las carpetas anteriores lo llevan como «Replanteo» si lo tienen). Las
  escalas con números: energía frente a kT, longitud frente a lo que se puede dibujar o imprimir, tiempo frente a lo que sigue el
  lector, señal frente al piso. Y el mapa de tres regiones: qué parámetro lleva de lo convencional a la tercera región y de ahí
  al fallo, y dónde se sospechan las dos fronteras.

- **1. Ficha.** La cadena mecanismo → precursor → transformación → observable → función → circuito → experimento. Ya escrita.
- **2. Lectura y piso.** Instrumento, piso, señal esperada con grado, y la razón señal/piso.
- **3. Explicación aburrida y controles.** Qué imitaría el resultado y qué estructura lo separa.
- **4. Referencia convencional (control científico, no filtro).** Qué componente conocido sirve de referencia para identificar el
  mecanismo o cuantificar la función. No es requisito para existir: una celda no tiene que ganarle a nada.
- **5.1 Sin silicio.** Pasos numerados que se pueden hacer ya: leer la fuente pendiente, buscar el parámetro en el PDK, borde
  legal con `residual/drc_edge`, dibujar por script, DRC en los dos decks, extraer, anotar con Residual, simular con predicción
  escrita antes. Decir cuáles ya están hechos y dónde.
- **5.2 Configuraciones a dibujar.** Tabla de variantes: qué dimensión se barre, valores, y qué pregunta física responde cada
  barrido (largo, ancho, relación de aspecto, perímetro frente a área, distancia, orientación, capa, número de contactos).
- **5.3 En silicio.** La secuencia virgen → calibrar → caracterizar → transformar (si aplica y con permiso) → observar → retener
  y repetir → clasificar, adaptada. Qué se barre en la mesa: temperatura, alimentación, tiempo, frecuencia.
- **5.4 Criterio de muerte (borrador).** Qué resultado mataría la familia y cuál la dejaría inconclusa.
- **7. Compuertas y dependencias.** Permisos (estrés en mesa, antena, relleno), vehículo, otras familias de las que depende o
  a las que sirve de control, número de chips.
- **8. Abierto y fuentes.** Preguntas sin respuesta y enlaces a la pesca o a las corridas.
