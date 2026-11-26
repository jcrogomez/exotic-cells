# MISFIT-20 · XC-14: el puesto de puerta flotante con antena, dibujado por el generador · resultados

Prerregistro: [`MISFIT-20`](../../cells/preregistros/MISFIT-20_2026-11-26_xc14_puesto_generado.md) y
[enmienda 1](../../cells/preregistros/MISFIT-20_2026-11-26_xc14_puesto_generado_enmienda1.md), sellados y subidos antes de
cada pasada. Tabla: [`generator/tables/xc14fg.json`](../../generator/tables/xc14fg.json). Salida: `xc14fg/`; primera pasada
en `pasada1/`; testigo en `testigo/`; acoplos en `h56.txt`. Dibujo, verificación y capacidades extraídas; ninguna simulación.

## Lo aburrido primero

- **Nada de esto dice si el plasma deja carga.** Es un puesto legal y extraíble con una puerta sin camino en continua.
- **H1 fue falsa a la primera** (tres reglas; enmienda 1). Usé una de las dos enmiendas que me había dado.
- **Ninguna herramienta dice nada de la puerta flotante:** Magic, los dos decks de KLayout y el LVS la aceptan en silencio.
  Que pase no la autoriza en fábrica; la regla de antena no se comprueba aquí ni en el precheck.
- **Una regla solo la ve una herramienta:** que el poly no puede salir de la zona de óxido grueso (`hvpoly.14`) lo marca
  el deck completo de KLayout y nadie más. Sin ese deck habría salido "limpia" con 11 errores de fabricación.
- **La capacidad de puerta de H5 y H6 es aritmética** (área × 3,1 o 8,3 fF/µm²), no extracción; el resto sí es extraído.
- **Las placas son pequeñas** frente al límite de antena del óxido grueso (84 µm²): la mayor es 40 µm². Solo el puesto de
  óxido fino (20 µm², relación 317) queda cerca del suyo (400).
- **Magic escribe "Error: Cannot parse MASKHINTS_HVI property value!"** tras el DRC, y aun así la indicación llega al GDS:
  comprobado aparte (`hvi_check.rb`, `hvi_check.txt`): el óxido grueso cubre el poly hasta la placa y ningún poly cruza su
  borde (10 lo cruzaban en la primera pasada). Qué paso de Magic no la entiende: `[?]`. Su propio DRC no usa esa regla.
- La extracción da 2 avisos sin texto, uno por diodo, como en MISFIT-14 y 16. Causa `[?]`.

## Resultado

Tabla `xc14fg`, 11 puestos: óxido grueso 0,42/0,5 con placa mínima (×2), 10 µm² (×2), 20 µm² (×2), 40 µm²; 20 µm² con
diodo (×2); 20 µm² conectada a VB; óxido fino 0,42/0,15 con 20 µm². Tira de metal 2 `CP` sobre todas las placas.

| # | Predicción | Veredicto |
|---|---|---|
| H1 | Limpia en Magic y en los dos decks de KLayout (hasta dos enmiendas) | **falsa a la primera; cumplida tras la enmienda 1**: 0 / 0 / 0 |
| H2 (testigo) | Placas vecinas a 0,10 µm dan error | **cumplida**: `met1.2` en Magic, 5 en cada deck de KLayout |
| H3 | LVS match: lectura + interruptor por puesto, y un diodo en los dos gemelos | **cumplida**: "Circuits match uniquely" (10 de óxido grueso, 1 fino, 11 interruptores, 2 diodos) |
| H4 (mutante) | Sin un diodo en la referencia no da match | **cumplida** |
| H5 | Acoplo de la placa común a la puerta, puestos de 20 µm²: 0,20 a 0,70 | **cumplida**: 0,52 y 0,49 |
| H6 | Acoplo del nodo X a la puerta, mismos puestos: 0,01 a 0,12 | **cumplida**: 0,065 y 0,064 |

Caja: 48,72 × 9,59 µm = 467 µm² para 11 puestos. **La antena manda en el área**: 42 µm² por puesto de media.

Acoplos por tamaño de placa (`h56.txt`): placa mínima 0,09 (CP) y 0,08 (X); 10 µm² 0,43 y 0,10; 20 µm² 0,51 y 0,065;
40 µm² 0,60 y 0,07.

## Qué se hace (reglas escritas, y dos decisiones por delegación)

- **H6 > 0,05 → hay que separar la placa del bus X o apantallarla.** Con 0,065, la puerta se mueve 58 mV cuando el nodo
  baja 0,9 V: más de media década de corriente (99 mV por década, MISFIT-19). **Pendiente de redibujar**; no lo hice en
  esta prueba.
- **H5:** la placa suma k × 1,8 V = 0,9 V con las placas de 20 µm². Sobra para los 0,3 V que faltaban por abajo, pero es
  **un solo salto y demasiado grande**: a ff −40 la ventana mide 0,685 V, así que entre "placa a 0" y "placa a 1,8 V"
  queda un hueco de unos 0,2 V (aritmética con MISFIT-19). **Decisión: la tira de acoplo se parte en dos mitades con su
  propia línea digital,** para tener tres escalones (0, la mitad y todo). *La revertiría* que no haya dos líneas libres.
- **El puesto mínimo (sin antena) no sirve de control de acoplo:** con k = 0,09 la placa casi no lo mueve. Es el control
  de "sin antena", no de lectura.

## Qué explicación aburrida no descarté

- Que la indicación de máscara de óxido grueso sobre el poly de campo cambie algo en fábrica (es legal en los tres decks).
- Que el acoplo real difiera del extraído (Magic, sin resolver campos; las placas son grandes frente a las separaciones).
- Que el diodo del gemelo, 0,2 µm², fugue lo bastante para fijar la puerta: es su función, pero no está simulado.
- La otra mitad de C3: qué le pasa a la puerta en el encendido y durante la precarga, con la puerta flotando de verdad.
