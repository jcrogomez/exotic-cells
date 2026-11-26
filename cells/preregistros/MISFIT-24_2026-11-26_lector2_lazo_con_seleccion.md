# MISFIT-24 · el lazo del lector 2 con selección de rango y habilitación en celdas de librería

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit24/PREREG_SHA256.txt`), **antes** de la tanda. Ya corrió un
humo (`experiments/misfit24/humo/h`, un deck dinámico, tt 27, rango alto): solo miré que acabara, que diera 12 flancos y
7 líneas `DY`; no leí ningún valor.

## Qué se simula

Lo mismo que [MISFIT-23](../../experiments/misfit23/RESULTADOS.md) (parte analógica extraída, matriz `xc20w` extraída,
mismas corrientes y esquinas), cambiando el inversor `inv_4` que movía la única línea de precarga por la lógica que el
chip necesita, con dos entradas del bloque digital, `EN` (habilita) y `RS` (1 = rango alto):

- `PRENL = a21oi_4(q, /RS, /EN)`: con `EN = 0` la precarga larga queda **encendida** y sujeta el nodo en VDD (el
  comparador no se queda a media tensión).
- `PRENH = nand3_4(q, RS, EN)`.
- dos `inv_1` para `/RS` y `/EN`. El resto del lazo, igual (comparador, dos inversores, cerrojo NOR, 8 retardos).

Tres grupos, 78 decks (`gen24.py`):
- **A** (`d/`, 64): por rango y esquina, 3 calibraciones, 3 fuera de muestra, testigo de +3 % y sin corriente; `EN` fijo.
- **B** (`dyn/`, 8): por rango y esquina, la corriente media (3,16 nA / 1 µA por el puesto 0); `EN` = 0 durante 3
  periodos, 1 durante 16, 0 durante 4.
- **C** (`f1/`, 6): tt 27, las 3 calibraciones de cada rango con las puertas en tamaño `_1` en vez de `_4`.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| Lee igual porque la línea de precarga casi no carga a la puerta | Grupo C: mismas puertas 4 veces más débiles; se informa cuánto cambia la carga |
| El banco no ve cambios | Testigo de +3 % (A2) |
| "No hay flancos con `EN` = 0" porque el deck no oscila nunca | El mismo deck da 12 flancos con `EN` = 1 (B2) |
| El diodo vuelve con el área mal | Control de capacidad de MISFIT-17 en cada deck (0,5–3 fF) |

## Predicciones

| # | Predicción |
|---|---|
| A1 | Las 6 corrientes fuera de muestra dentro de ±3 % en las 4 esquinas (24 de 24) |
| A2 (testigo) | +3 % de corriente da entre −3,5 y −2,3 % de periodo, 8 de 8 |
| A3 | Carga ajustada frente a MISFIT-23, misma esquina: rango alto dentro de ±3 %; rango bajo dentro de ±10 % |
| A4 | Sin corriente, ningún flanco en 20 ms, 8 de 8 (apuesta floja a ff 85: depende de una cancelación de fugas) |
| B1 | Con `EN` = 0 al principio: `q` no pasa de 0,2 V, el nodo no baja de 1,7 V y el primer flanco llega después de subir `EN`; 8 de 8 |
| B2 | Tras subir `EN`, el periodo (flancos 2 a 12) queda dentro de ±1 % del mismo caso con `EN` fijo del grupo A; 8 de 8 |
| B3 | Tras bajar `EN`, pasados 2 periodos, `q` no pasa de 0,2 V y el nodo no baja de 1,7 V; 8 de 8 |
| C1 | Con puertas `_1`, la carga cambia frente a `_4` menos de 3 % en el rango alto y menos de 10 % en el bajo (baja confianza) |

Se informa sin predicción: consumo en reposo (corriente de alimentación con `EN` = 0, menos la de la celda).

## Qué se hace con cada resultado

- **A1 y B1–B3 cumplidas:** esta es la lógica del lazo. Lo siguiente es escribirla como Verilog estructural junto al
  bloque digital, con el contador, y colocarla.
- **A1 falla:** se vuelve a mover la línea con un `inv_4` detrás de la puerta (la selección pasa a una etapa antes) y se
  repite.
- **B1 o B3 fallan:** el reposo no es seguro; se rediseña la sujeción antes de seguir.
- **B2 falla:** el arranque deja memoria; el contador descarta más periodos al empezar, y se dice cuántos.
- **C1 falsa en el rango bajo:** el paquete de carga depende de la fuerza de quien mueve la línea; la simulación con
  desajuste y alimentación movida pasa por delante de la colocación.
- **A3 falsa:** se anota; no bloquea (se calibra en el chip).
- **Inválido** un (rango, esquina) con el testigo fuera de banda o sin periodo en la calibración; inválida la tanda si
  falla el control de capacidad.

No se prueba: cambiar `RS` con `EN` = 1 (regla de uso: el bloque digital solo cambia de rango en reposo), el cable de X,
desajuste, ruido, alimentación movida. Tope 3600 s por deck.
