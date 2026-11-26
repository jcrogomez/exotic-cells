# MISFIT-17 · XC-20 leída por el lector 2 en dos rangos, con la matriz extraída en el nodo · resultados

Prerregistro: [`MISFIT-17`](../../cells/preregistros/MISFIT-17_2026-11-26_xc20_leida_por_lector2.md), subido antes de
escribir los decks; [enmienda 1](../../cells/preregistros/MISFIT-17_2026-11-26_xc20_leida_por_lector2_enmienda1.md),
subida antes de la segunda tanda. Scripts sellados en `ANALISIS_SHA256.txt`. Tanda: 88 decks (`d/`, `corre.out`,
veredictos en `m17.txt`). Diagnóstico exploratorio: `diag/` (5 decks). Enmienda: `e1/` (12 decks), `e1.txt`.
Todo es modelo: ngspice 44.2, sky130A, fuentes ideales. Nada es silicio.

## Lo aburrido primero

- **Tres de seis predicciones falsas eran cuentas mías mal hechas,** no sorpresas del circuito. Dos de ellas (R2, R6)
  salen de un hecho que ya estaba escrito en [`noche_1125`](../noche_1125/RESULTADOS.md) ("la carga por ciclo depende de
  la precarga") y que no usé al predecir.
- **Los diez periodos de una misma corrida del rango bajo se dispersan 0,2–0,6 %** (0,04 % en el alto). No hay ruido en
  el deck. La enmienda 1 apostó a que venía del paso máximo: **falso**, con el paso diez veces menor sigue en 0,55 %.
  Causa `[?]`. Cada lectura del rango bajo (media de diez periodos) lleva por eso unos ±0,15–0,2 %.
- **El testigo del rango bajo no discrimina bien con esa dispersión:** +1 % de corriente contra ±0,24 % de incertidumbre
  en la diferencia de dos lecturas. Que fallara a ff −40 en la primera tanda (−1,38 %) y pasara en la segunda (−0,97 %)
  es compatible con el azar de esa dispersión. Lo mismo vale para los dos testigos fallados de `noche_1125`.
- Fuentes de calibración ideales; sin desajuste ni ruido; lazo en esquemático; una matriz de 7 puestos.
- Control del área del diodo: 84 valores entre 0,99 y 1,86 fF. Bien.

## Veredictos

| # | Predicción | Veredicto | Medido |
|---|---|---|---|
| R1 | 6 corrientes fuera de muestra dentro de ±3 % en 4 esquinas | **cumplida**, 24 de 24 | peor caso +1,26 % (316 pA, ss 85); en el rango alto, entre −0,74 y −0,15 %. Las tres del caso inválido, repetidas en la enmienda: −0,15, +0,04, −0,21 % |
| R2 | Periodo con matriz / sin matriz entre 1,12 y 1,30 | **falsa** | 1,001, 1,007, 1,008, 0,998 |
| R3 (testigo) | +1 % de corriente da −1,2 a −0,8 % de periodo, 8 de 8 | **falsa**, 7 de 8 | −1,383 % en rango bajo, ff −40; los otros siete entre −0,99 y −0,92 |
| R4 | Sin corriente, ningún flanco en 20 ms, 8 de 8 | **falsa**, 7 de 8 | el rango bajo a ff 85 oscila solo: segundo flanco a 7,6 ms |
| R5 | Puesto 6 frente a puesto 0 dentro de 0,5 % | **cumplida** | +0,11, −0,37, +0,12, −0,03 % |
| R6 | Óhmica 0,68–0,78; cúbica 0,25–0,42 | **falsa**, 4 de 16 | rango alto: 0,66–0,70 y 0,24–0,30. Rango bajo: 0,49–0,56 y 0,11–0,17 |

**Enmienda 1** (rango bajo, ff −40, paso diez veces menor): E1 **falsa** (dispersión 0,55 %, no bajó); E2 cumplida
(testigo −0,967 %); E3 cumplida; E4 cumplida (1,005). Por la regla escrita el caso deja de ser inválido y R1 vale 24 de
24. Lo digo con la reserva de arriba: el testigo de +1 % es débil en el rango bajo.

## Por qué fallaron R2, R4 y R6

**En el rango bajo la precarga entrega un paquete fijo de carga, no recarga el nodo** (diagnóstico, tt 27): el nodo
oscila entre 0,78 y 1,07 V con la matriz y entre 0,78 y 1,16 V sin ella; en el rango alto, entre 0,78 y 1,79 V. La
excursión se encoge justo lo que crece la capacidad, y la carga por ciclo (50–58 fC según la esquina) no cambia.

- **R2:** por eso el periodo no depende de la capacidad del nodo. La capacidad de la matriz sí está: la primera descarga
  desde 1,8 V tarda entre 1,27 y 1,35 veces más con ella (exploratorio, de los logs de la tanda).
- **R6:** mi cuenta suponía un barrido de 1,8 V al umbral. En el rango bajo el nodo vive cerca de 0,9 V: una forma óhmica
  da 0,9/1,8 ≈ 0,51 y una cúbica 0,13, que es lo medido (0,514 y 0,133 a tt 27).
- **R4:** a ff 85 la fuga de la matriz descarga el nodo con 32 pA (ajuste de la calibración) y el paquete es de 52 fC:
  oscila sola cada ~1,6 ms. Las lecturas de 316 pA a ff 85 aciertan (+0,01 %) porque el modelo de tres números lleva
  esa fuga.

## Qué se hace (reglas escritas antes)

- **R1 cumplida: XC-20 queda cerrada en papel con el lector 2 de dos rangos.** Lo siguiente del lector es su dibujo
  (hecho, [MISFIT-22](../misfit22/RESULTADOS.md)) y leer con la celda extraída (MISFIT-23).
- **R6 falsa:** la lectura de una unión que no es fuente constante no se interpreta con la cuenta simple. Cocientes
  medidos arriba.

## Lo que esto cambia en XC-20

1. **Los dos rangos miden la unión a tensiones distintas:** el bajo a unos 0,8–1,1 V, el alto barriendo de 1,8 a 0,8 V.
   Una unión túnel (casi óhmica o más empinada) dará corrientes distintas en los dos rangos por diseño, no por error. Hay
   que leerla sabiéndolo, y es una medida gratis de la forma de la curva.
2. **En el rango bajo colgar más puestos del nodo no alarga la lectura;** en el alto sí (no medido aquí).
3. **El suelo del rango bajo en caliente lo pone la fuga de la matriz** (32 pA a ff 85 con 7 puestos), no el lector.

## Qué explicación aburrida no descarté

- La causa de la dispersión entre periodos del rango bajo: tolerancias del simulador o dinámica real del lazo (el paquete
  depende de dónde queda el nodo al cerrar la precarga). No probé tolerancias más estrictas ni otro método de integración.
- Que la carga del paquete, que depende de la fuerza de un transistor y de un retardo, no sobreviva al desajuste ni a
  una alimentación movida. Sin medir.
- Que con 52 puestos (no 7) la fuga en caliente suba el suelo del rango bajo en proporción.
