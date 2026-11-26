# MISFIT-21 · XC-14: el puesto redibujado, con la placa apantallada y el acoplo en dos líneas · resultados

Prerregistro: [`MISFIT-21`](../../cells/preregistros/MISFIT-21_2026-11-26_xc14_puesto_apantallado.md), sellado y subido antes
de tocar el generador. Tabla: [`generator/tables/xc14fg.json`](../../generator/tables/xc14fg.json) (la de MISFIT-20; el
generador ahora pone pantalla y dos líneas por defecto). Salida: `xc14fg/`; testigo sin pantalla en `sin_pantalla/`;
acoplos en `acoplos.txt`. Dibujo, verificación y capacidades extraídas; ninguna simulación.

## Lo aburrido primero

- **Capacidades de la extracción de Magic,** no de un resolvedor de campos. La de puerta es aritmética (área × 3,1 fF/µm²).
- **Con la pantalla la placa también se aleja** 0,26 µm del bus X; pero el testigo sin pantalla (placa a la distancia de
  MISFIT-20, mismo peine) separa las dos cosas mejor de lo que prometí: la única diferencia entre las dos corridas es la
  pantalla y esos 0,26 µm.
- **La placa mínima solo ve una línea** (CP1 0,06; CP2 0,02), como se dijo. No entra en S3 ni S4.
- Sigue saliendo el mensaje de Magic sobre `MASKHINTS_HVI`; los dos decks de KLayout dan 0 (ver MISFIT-20).
- Nada de carga de plasma, ni de la puerta flotando en una simulación.

## Resultado (puestos de óxido grueso con placa de 20 µm²)

| # | Predicción | Veredicto |
|---|---|---|
| S1 | Limpia en las tres herramientas y LVS match | **cumplida a la primera**: 0 / 0 / 0, "Circuits match uniquely" |
| S2 | Acoplo del nodo X a la puerta < 0,03 | **cumplida**: 0,0079 y 0,0078 |
| S3 | Cada línea acopla entre 0,12 y 0,30 | **cumplida**: CP1 0,265 y 0,254; CP2 0,275 y 0,263 |
| S4 | Las dos líneas iguales dentro del 20 % | **cumplida**: cociente 0,96 y 0,97 |
| S5 (testigo) | Sin pantalla el acoplo del nodo es al menos el doble | **cumplida**: 0,061 y 0,060, **7,7 veces más** |

Caja: 49,76 × 9,85 µm = 490 µm² (11 puestos).

**Qué dice:**

- Con el nodo bajando 0,9 V, la puerta se mueve ahora 7 mV (antes 58 mV): un 18 % de corriente en vez de un factor 3,9
  (con 99 mV por década, MISFIT-19).
- Las dos líneas dan tres escalones de puerta: 0, +0,47 V y +0,96 V (k × 1,8 V). El escalón (0,47 V) es menor que la
  ventana más estrecha (0,685 V a ff −40), así que **no queda hueco**: se cubre desde unos −0,7 V hasta el techo de la
  ventana (aritmética con MISFIT-19).
- En las placas de 10 µm² las líneas difieren un 15 % (0,243 y 0,207): el peine reparte peor en placas bajas.

**XC-14 queda en papel al nivel de XC-20 y XC-19:** celda generada, limpia, con LVS, y su ventana de lectura conocida.
Falta la simulación con la puerta flotando (encendido y precarga) y llevar las antenas grandes sobre el núcleo.

## Qué explicación aburrida no descarté

- Que el acoplo real al nodo sea mayor que el extraído (Magic no resuelve el campo alrededor de la pantalla).
- Que las líneas de acoplo, al conmutar, inyecten carga por otra vía (a través del diodo del gemelo, por ejemplo).
- Que 0,96 V sumados a una puerta que ya está alta la lleven cerca de donde el óxido fino empieza a perder carga por
  túnel (~2–3 V, ronda 4): con el rango plausible de 0–1,3 V se queda en 2,3 V como mucho. Aritmética, sin simular.
