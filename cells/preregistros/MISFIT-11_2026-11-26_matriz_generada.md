# MISFIT-11 · una matriz de puestos generada desde una tabla (pruebas G1, G2 y la mitad con cableado de R6)

Escrito el 2026-11-26 (hora de sellado, de `date`, en `experiments/misfit11/PREREG_SHA256.txt`), **antes** de escribir el
generador. Plan: [`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md). Pedido por Juan ("empieza por la matriz con el generador").

## Qué es

Un programa (`generator/matrix.py`) que lee una tabla (una fila por puesto: ancho W, largo L y difusión a cada lado sa, sb de
un nfet de 1,8 V) y escribe: el dibujo en Magic de la matriz (cada puesto = dispositivo + interruptor de fuente nfet 0,84/0,15,
los mismos del lector; buses de X, VB y GND en metal 1; una línea de selección por puesto en metal 2), el netlist de
referencia para LVS y la lista de puestos. Hoy el lector tiene **un** dispositivo por lado: no hay matriz dibujada. Lo que se
regenera en G1 es ese puesto.

**Límites declarados:** un solo tipo de dispositivo (nfet 1,8 V). La unión de XC-20, las antenas y los contactos son otros
tipos y quedan fuera; G2 del plan nombra la matriz de XC-20 y **aquí no se cierra**: la segunda tabla es la de XC-12 (difusión
variable). Una sola fila de puestos. Sin la lógica de selección (decodificador) ni la lectura predicha por puesto.

## Etapa 1 · dibujo y verificación

Tablas: `u1` (1 puesto, 0,42/0,15, sa = sb = 0,30), `u16` y `u64` (16 y 64 puestos iguales), `lod12` (12 puestos: sa = sb en
0,30, 0,45, 0,75, 1,50, 3,00 y 6,00 µm, dos réplicas, W = 0,42 y L = 0,15).

| # | Predicción |
|---|---|
| M1 (G1) | `u1`: los dos dispositivos extraídos tienen los mismos W, L, áreas y perímetros de difusión que el dispositivo y el interruptor del lector (`cells/xc19_slot_core_a2/v_f3/xc19_slot_core.lvs.spice`, lado A) |
| M2 | `u16`, `u64` y `lod12`: Magic `drc(full)` 0, KLayout `sky130A_mr` 0 y deck completo 0, LVS "match" contra la referencia generada. **Sin editar a mano** ni el dibujo ni la referencia |
| M3 (mutantes) | Con la referencia de `u16` alterada, el LVS **no** da match en dos casos: un puesto con W = 0,50, y un puesto de menos |
| M4 (testigo de DRC) | Con el paso entre puestos reducido 0,10 µm por debajo del que calcula el generador, Magic da errores |
| M5 | Área por puesto en `u64` (caja de la celda / 64): entre 4 y 7 µm² |

**Muere** el generador (G1/G2) si hace falta tocar a mano la salida para que alguna tabla pase. **Inválido** si falla M3 o M4
(el verificador no vería un error).

## Etapa 2 · R6 con el cableado extraído

Método del bloque D de la noche del 25 (`experiments/noche_1125/gen_D.py`), sustituyendo las ramas copiadas por la extracción
con capacidades de `u16` y `u64` colgada de XA y de XB del lector pequeño (un puesto cerrado, el resto abiertos; el puesto
propio del lector se queda abierto). 4 esquinas. Control por deck: el lector solo repite su contrato dentro de 0,01 %.
Testigo: 1 fF añadido en XA (+0,4 a +0,9 %). Referencia sin cableado: +0,230 a +0,253 % de tiempo por rama.

| # | Predicción |
|---|---|
| W1 | Tiempo por puesto con cableado: entre +0,26 y +0,40 % (el alambre añade entre 0,03 y 0,15 puntos por puesto) |
| W2 | Con 64 puestos el tiempo es ≤ 1,5 veces el del lector solo, en las 4 esquinas |
| W3 | El salto de una carga (trampa en el puesto leído) cambia ≤ 5 % relativo con 64 puestos, en las 4 esquinas |
| W4 | El puesto 0 y el puesto 63 leen lo mismo dentro de 0,05 % (la posición en el bus no importa) |

**Decide:** si W2 y W3 se cumplen, 64 puestos por lector queda confirmado con cableado (decisión 7 del plan). Si alguno
falla, se reporta el N que cumple por interpolación lineal y la decisión se revisa. **Inválido** si falla el control o el testigo.
Lo que no mide: desajuste, dispositivos distintos en el mismo bus (R4), las líneas de selección hasta el núcleo.
