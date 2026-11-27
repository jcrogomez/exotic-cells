# Plan nocturno del 2026-11-26: cinco bloques sobre el lector 2

Escrito el 2026-11-26 (hora de sellado, de `date`, en `experiments/noche_1126/PREREG_SHA256.txt`), **antes** de lanzar la
cola. Pedido por Juan ("haz el plan nocturno"). Todo es SPICE (ngspice 44.2, PDK 8afc8346), en `experiments/noche_1126/`.
Nada es silicio. Base de todos los decks: el lector 2 de [MISFIT-24](../../experiments/misfit24/RESULTADOS.md) (parte
analógica extraída, matriz `xc20w` extraída, lazo con selección y habilitación en celdas de librería sin colocar).

**Por qué estos bloques:** son las cosas que revertirían una decisión ya tomada sobre el lector 2 (decisiones 14 y 15 de
`docs/MISFIT_PLAN.md`) o que fijan cuántos puestos lee. Se hacen antes de sintetizarlo y colocarlo.

**Reglas de la noche**
- Cada deck corre con `timeout` dentro del contenedor (3600 s; 5400 s en el bloque M). Sin corridas de LibreLane.
- Generador, cola y análisis están escritos y sellados antes de lanzar (`ANALISIS_SHA256.txt`). El análisis corre solo al
  acabar la cola. Lo que no esté en esta página no decide nada.
- Humo ya corrido (`humo/`, un deck por bloque y el control de M): solo miré `salida 0`, el número de líneas de medida y
  que no hubiera errores en los logs. Ningún valor.
- Modelo de lectura, como en MISFIT-24: T = Q/(I − I_L) + t_d con tres corrientes de calibración; periodo = media de los
  diez intervalos entre los flancos 2 y 12.
- Lo que no llegue a correr queda como "no corrido".

## Bloque K · ¿el contador de rizado sigue al lazo a su frecuencia más alta? (4 decks)

Cuatro biestables `dfrbp_1` en cadena sobre `q`, rango alto, 10 µA, 4 esquinas. Es el criterio que revertiría la decisión
15 (el lector 2 como puesto, [`instrument/reader2`](../../instrument/reader2/README.md)).

| # | Predicción |
|---|---|
| K1 | El bit 3 sube entre 0 y 3 ns después del flanco 8 de `q` (y antes del 9), y otra vez entre 0 y 3 ns después del 24; 4 de 4 |

Se informa el periodo de `q` a 10 µA. **Si K1 falla:** la decisión 15 se revierte en esa parte y el divisor se rediseña.

## Bloque S · alimentación movida (32 decks)

VDD a 1,70 y 1,90 V (también las entradas lógicas), tt 27 y ss 85, los dos rangos: 3 calibraciones y la corriente media
fuera de muestra (3,16 nA / 1 µA).

| # | Predicción |
|---|---|
| S1 | Recalibrado a la alimentación movida, el punto fuera de muestra queda dentro de ±3 %; 8 de 8 |
| S2 | Leído con la calibración de 1,80 V (MISFIT-24), el error por 100 mV es de 3 a 8 % en valor absoluto en el rango alto (la carga es capacidad por excursión, y la excursión sigue a VDD) y de 2 a 20 % en el bajo (no sé ni el signo: el paquete depende de la fuerza de la precarga) |

**Qué se hace:** si algún error de S2 pasa de 10 % por 100 mV, queda escrito en `INTERFACES.md` que una lectura del lector
2 solo vale como cociente contra las corrientes de calibración medidas en la misma sesión. Si S1 falla, el modelo de tres
números no sirve fuera de 1,80 V y se dice.

## Bloque W · cable en el nodo (32 decks)

+20 y +50 fF del nodo a masa, tt 27 y ss 85, los dos rangos, mismos cuatro casos que S. Es el otro criterio de la decisión
14 (un cable que pese más del 10 % del nodo).

| # | Predicción |
|---|---|
| W1 | Rango bajo: la carga ajustada cambia menos de 2 % frente a MISFIT-24 (paquete fijo); 4 de 4 |
| W2 | Rango alto: +20 fF da entre +8 y +13 % de carga; +50 fF, entre +21 y +31 % (nodo de unos 190 fF); 4 de 4 |
| W3 | Fuera de muestra dentro de ±3 % en los 8 casos |

**Qué se hace:** si W3 se cumple, el cable solo cuesta tiempo de lectura en el rango alto y el criterio de la decisión 14
se reescribe como presupuesto de tiempo. Si falla, el cable tiene un tope y se fija con estos dos puntos.

## Bloque N · 63 puestos en el nodo (28 decks)

Nueve copias de la matriz extraída de 7 puestos sobre el mismo nodo (una con el puesto 0 seleccionable, ocho abiertas).
Rango bajo a tt 27, ss 85 y ff 85; rango alto a ff 85. Por caso: 3 calibraciones, 3 fuera de muestra y sin corriente.
Cuenta previa: la matriz de 7 puestos fugaba 32 pA a ff 85 (MISFIT-17) y las precargas apagadas meten 36 pA (MISFIT-23);
con nueve matrices, unos −250 pA netos, y el paquete del rango bajo son ~52 fC.

| # | Predicción |
|---|---|
| N1a | Rango bajo, ff 85, sin corriente: oscila sola, con periodo entre 0,1 y 0,5 ms |
| N1b | Rango bajo, ss 85, sin corriente: al menos 2 flancos en 20 ms |
| N1c | Rango bajo, tt 27, sin corriente: menos de 12 flancos en 20 ms |
| N2a | Rango bajo: 3,16 nA y 100 nA dentro de ±3 % en las 3 esquinas (6 de 6) |
| N2b | Rango bajo, 316 pA: dentro de ±3 % a tt 27 |
| N2c | Rango bajo, 316 pA: **fuera** de ±3 % a ff 85 (la fuga, del tamaño de la señal, cambia con la tensión del nodo). Sin apuesta a ss 85 |
| N3 | Rango alto, ff 85: las 3 fuera de muestra dentro de ±3 % |

**Qué se adopta:** el suelo del rango bajo con 64 puestos por lector es la menor corriente fuera de muestra que pasa en
las 3 esquinas. **Si 3,16 nA falla en alguna:** el lector 2 lleva 32 puestos, no 64. El cero del instrumento es la lectura
con todos los puestos abiertos (sale de N1). Sin cable entre copias: las ocho copias traen su propio cableado extraído,
no el que las une.

## Bloque M · desajuste (82 decks)

Esquina `tt_mm`, un chip por deck con `setseed` (semillas 2600–2639 rango bajo, 2700–2739 rango alto) y `reset`; dentro
del deck, con `alter`, las 3 calibraciones (fuente en el nodo) y la corriente media por el puesto 0. Más un control `tt`
por rango con el mismo deck.

| # | Predicción |
|---|---|
| M0 (control) | El deck `tt` repite el periodo fuera de muestra de MISFIT-24 dentro de 0,2 % |
| M1 | Los 40 chips de cada rango oscilan en las 4 corrientes |
| M2 | Calibrado chip a chip, el error fuera de muestra queda dentro de ±3 % en al menos 38 de 40 chips, en cada rango |
| M3 | Dispersión de la carga entre chips (σ/media): entre 2 y 10 % en el rango bajo, entre 0,3 y 3 % en el alto (baja confianza) |

**Sigue** si M1 y M2 se cumplen: el desajuste lo absorbe la calibración. **Muere** el modelo de tres números en un rango
si menos de 36 de 40 chips quedan dentro de ±3 %. **Inválido** el bloque en un rango si falla M0 o si más de la mitad de
los chips dan la misma carga (la semilla no se aplica). M3 falsa se anota y no bloquea.

## Lo que esta noche no decide

Síntesis y colocación del lector 2; ruido; desajuste junto con alimentación o temperatura; el cable real; cambiar de
rango en marcha; silicio. Tampoco avanza ningún candidato nuevo (fusible XC-01→05, XC-63, XC-58, XC-52, XC-14): van
después de que el lector que los lee esté cerrado, por la decisión 14.
