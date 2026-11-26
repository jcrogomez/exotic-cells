# MISFIT-12 · tres pruebas rápidas sobre lo que ya existe

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit12/PREREG_SHA256.txt`), **antes** de generar los decks. Juan pidió
avanzar "de rápido a lento y de la prueba que dé más información a menos". Estas tres reutilizan el generador y los decks de
MISFIT-11 y tardan minutos. Todo es SPICE sobre extracciones (ngspice 44.2, PDK 8afc8346). Nada es silicio.

## A · dispositivos distintos en un mismo bus (prueba R4, y C2 para XC-12)

El lector pequeño lee la matriz `lod12` extraída (12 puestos: difusión de 0,30, 0,45, 0,75, 1,50, 3,00 y 6,00 µm a cada lado
del nfet 0,42/0,15, dos réplicas), una en cada lado, puesto k cerrado. 4 esquinas. Cada puesto lleva su sa/sb de la tabla.
Dato previo del repo: el modelo da 31,1 mV de umbral entre 0,30 y 3,0 µm, y una pareja leída por esta etapa dio un cociente de
1,64 (`cells/xc12_lod_stress/PLAN.md`, N4).

| # | Predicción |
|---|---|
| L1 | Las dos réplicas de cada nivel leen igual dentro de 0,05 %, en las 4 esquinas |
| L2 | El tiempo de lectura es monótono con la difusión en los 6 niveles, en las 4 esquinas |
| L3 | A tt 27, el cociente de tiempos entre 0,30 y 3,00 µm (mayor / menor) está entre 1,5 y 1,8 |
| L4 (testigo) | Con todos los puestos anotados a sa = sb = 0,30 (sin el efecto), los 12 leen igual dentro de 0,3 %: lo que queda es alambre y uniones |

Control: el lector solo repite su contrato dentro de 0,01 %. **Muere** XC-12 en esta forma si L4 falla por más que el efecto
(los parásitos del dibujo tapan lo que se mide). **Inválido** si falla el control.

## B · 128 puestos con cableado

Tabla `u128`, mismo método que la etapa 2 de MISFIT-11. Cuenta previa (lineal desde 64 puestos): tiempo ×1,43–1,46; el salto
de una carga pierde 4,7 % en ss 85.

| # | Predicción |
|---|---|
| E0 | `u128` sale limpia (Magic 0, KLayout 0 / 0, LVS match) sin tocar nada |
| E1 | Tiempo por puesto dentro de ±3 % del de 64 puestos, en las 4 esquinas |
| E2 | Tiempo con 128 puestos ≤ 1,5 veces el lector solo en las 4 esquinas (apuesto que pasa por poco: 1,43–1,47) |
| E3 | El salto cambia ≤ 5 % relativo en las 4 esquinas (apuesto que pasa por poco: entre −4,4 y −5,0 % en ss 85) |

**Decide:** si E2 y E3 se cumplen, 128 es el techo con cableado y 64 queda con margen de 2; si alguno falla, el techo está
entre 64 y 128 y se da por interpolación. La decisión de usar 64 no cambia en ningún caso.

## C · lector 2 en dos rangos, releyendo datos que ya existen (exploración declarada)

No es una prueba: los datos (`experiments/noche_1125/A`, `experiments/xc20_lector/r2`) ya los vi. Se fija aquí la regla antes
de calcular, y el resultado solo sirve para diseñar la prueba de verdad.
- Rango bajo, precarga L = 1,00: calibrar en 1 nA, 31,6 nA y 1 µA; juzgar en 100 pA, 316 pA, 10 nA y 100 nA.
- Rango alto, precarga L = 0,15: calibrar en 31,6 nA, 1 µA y 10 µA; juzgar en 10 nA, 100 nA y 3,16 µA.
- Se reporta el peor error por esquina. Apuesta: los dos rangos quedan dentro de ±3 % en las 4 esquinas.
