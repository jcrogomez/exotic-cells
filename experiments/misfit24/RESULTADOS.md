# MISFIT-24 · el lazo del lector 2 con selección de rango y habilitación · resultados

Prerregistro: [`MISFIT-24`](../../cells/preregistros/MISFIT-24_2026-11-26_lector2_lazo_con_seleccion.md), sellado y subido
antes de la tanda; generador, lanzador y análisis sellados en `ANALISIS_SHA256.txt` (los cuatro sellos verifican después
de correr). 78 decks (`d/`, `dyn/`, `f1/`), todos en `salida 0` (`corre.out`); veredictos tal como salen en `m24.txt`.
Simulación ngspice: parte analógica y matriz extraídas, lógica del lazo en celdas de librería **sin colocar**.

## Lo aburrido primero

- **Ocho de ocho cumplidas dice que las predicciones eran anchas, no que el diseño tenga margen.** El cambio respecto de
  MISFIT-23 es una puerta en una línea que carga poco; lo raro habría sido otra cosa.
- **Sigue sin colocar nada:** ni retardo extraído ni cable del nodo al comparador. Las celdas son los modelos de la
  librería sin parásitos de ruta.
- **Que no oscile sola a ff 85 sigue siendo la cancelación de fugas** de MISFIT-23 (fuga neta ajustada +3,1 pA).
- La dispersión entre periodos del rango bajo sigue (0,05–0,54 %), sin causa `[?]`.
- En el humo solo miré `salida 0`, 12 flancos y 7 líneas `DY` (dicho en el prerregistro).

## Resultado

| # | Predicción | Veredicto |
|---|---|---|
| A1 | 24 corrientes fuera de muestra dentro de ±3 % | **cumplida**, 24 de 24; peor punto +1,28 % (rango bajo, ss 85, 316 pA) |
| A2 (testigo) | +3 % de corriente da −3,5 a −2,3 % de periodo | **cumplida**, 8 de 8: de −3,26 a −2,80 % |
| A3 | Carga frente a MISFIT-23: alto ±3 %, bajo ±10 % | **cumplida**: alto −0,0 % en las cuatro esquinas; bajo +0,7 a +1,4 % |
| A4 | Sin corriente, ningún flanco en 20 ms | **cumplida**, 8 de 8 |
| B1 | Reposo inicial quieto y primer flanco tras `EN` | **cumplida**, 8 de 8: `q` en 0,000 V; nodo en 1,800 V (rango bajo) y 1,775–1,786 V (rango alto, con 1 µA pasando) |
| B2 | Periodo tras `EN` dentro de ±1 % del de `EN` fijo | **cumplida**, 8 de 8: entre −0,07 y +0,02 % |
| B3 | Quieto tras bajar `EN` | **cumplida**, 8 de 8 |
| C1 | Puertas `_1`: carga cambia < 3 % (alto) y < 10 % (bajo) | **cumplida**: −0,39 % y −1,69 % |

Casos inválidos: ninguno. Control de capacidad: 72 valores entre 0,985 y 1,820 fF.

Sin predicción:
- **Primer flanco tras `EN`:** 58–66 µs en el rango bajo a 3,16 nA, unas cuatro veces el periodo (≈16 µs), y 179–207 ns
  en el alto a 1 µA. El nodo arranca en VDD y tiene que bajar hasta el umbral; el contador **descarta el primer
  intervalo**.
- **Consumo en reposo** menos la corriente de la celda: 0,02–0,03 nA, y 5,0–5,3 nA a ff 85.
- La fuerza de la puerta que mueve la línea pesa un 1,7 % en el paquete del rango bajo al pasar de `_4` a `_1`.

## Decisión, por la regla escrita

A1 y B1–B3 cumplidas: **esta es la lógica del lazo** (`a21oi_4` y `nand3_4` sobre las líneas de precarga, dos `inv_1`).
Lo siguiente es escribirla como Verilog estructural junto al bloque digital, con el contador, y colocarla. Reglas de uso
que salen de aquí: el rango solo se cambia en reposo; se descarta el primer intervalo; con una celda seleccionada en
reposo la precarga larga la alimenta (el bloque digital deselecciona los puestos antes de bajar `EN`).

## Qué explicación aburrida no descarté

- Que colocado lea distinto: retardo real, cable del nodo, acoplo de `q` a las líneas.
- Cambiar `RS` con `EN` = 1: no probado; queda prohibido por regla, no demostrado inocuo.
- Desajuste, alimentación movida y ruido: el 1,7 % de C1 dice que el paquete del rango bajo nota a quien mueve la línea,
  así que notará la alimentación. Sin simular.
- La cancelación de fugas a ff 85 en silicio.
