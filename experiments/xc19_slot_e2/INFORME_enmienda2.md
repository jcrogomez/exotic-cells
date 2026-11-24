# MISFIT-03 · enmienda 2 · informe: macro v_hm, Monte Carlo y ruido

Enmienda sellada el 2026-11-24 a las 09:46:20 (SHA `1b8f7f2e…`, commit e47d6f3):
[`MISFIT-03_2026-11-24_slot_xc19_enmienda2.md`](../../cells/preregistros/MISFIT-03_2026-11-24_slot_xc19_enmienda2.md). Este
informe se escribe con `analiza_mc.py` → `mc.txt` y `analiza_ruido.py` → `ruido.txt`. C1 y C2 salen de los logs del contrato en
`diseno/corridas/`.

## 0. Lo aburrido primero: fallos del arnés, todos míos, corregidos antes del veredicto

| # | Fallo | Cómo se vio | Arreglo |
|---|---|---|---|
| A1 | **La semilla del Monte Carlo se ignoró.** `set rndseed` dentro de `.control` no surte efecto. La semilla sale del proceso, y en un contenedor nuevo es siempre la misma: las 4 semillas dieron **los mismos 12 chips**, no 48 | en la tirada 0, los 6 chips compartían ln(tA/tB) ≈ −0,86 en las 4 semillas; `cmp` de los logs dio idénticos | `setseed N` + `reset`, probado determinista y distinto por semilla. La v1 queda en `mc/v1_rndseed_ignorado/` como exploración. Auditoría del resto del repo en [`../AUDITORIA_SEMILLAS_2026-11-24.md`](../AUDITORIA_SEMILLAS_2026-11-24.md) |
| A2 | **La v2 del Monte Carlo usó el macro viejo:** regeneré los decks sin `XC19_INC` | M5 salió 0,16 %, frente a 1,10 % en la v1; `diff` de los decks | Regenerados con el v_hm; `diff` contra la v1 solo difiere en la semilla. La v2 queda en `mc/v2_macro_viejo/`, **sin veredicto**. `analiza_mc.py` ahora exige que cada deck `tt_mm` tenga el mismo circuito que el control C0 |
| A3 | **El ruido comparte secuencia.** R1, R3 y R1′ tienen la misma semilla efectiva (A1) | misma causa | Sin rehacer. N1 y N2 valen cada uno por separado; **N3 comprueba la escala con k, pero no con sorteos independientes** |
| A4 | **R0, R1 y R3 murieron por memoria** ("Killed") al correr 4 a la vez; la enmienda decía de dos en dos o de tres en tres | logs truncados | Vueltos a correr de dos en dos. R1 volvió a morir en la repetición 7: **N = 56, no 64**. Los logs truncados quedan como `ruido_killed_4par.log` |
| A5 | Las líneas `MC` sin cruce traen un solo número | `KeyError` en el análisis | El análisis lee qué medida faltó del aviso de ngspice que va justo antes |

## 1. Veredictos, con las palabras de la enmienda

### C1. ff −40, tstop 160 µs — cumplida

- **C1a:** h11, tA = **81,998 µs** desde T0, en [80, 86].
- **C1b:** P4 = **0,967 %**, en [0,85, 1,10].
- **C1c:** P5′ = 0,011 % (≤ 0,15) y P6′ = **39,7 cuentas** (≥ 5).

### C2. ss 85, transitorio largo — cumplida

- **C2a:** el transitorio `e0` terminó. Corriente del macro: **8,31 pA**, menor que 1 nA. Es igual al `.op` de `calc_hvt`.
- **C2b:** F5 se detecta (VB = 0,4955 V > 0,1 V). F6 también: sin cruce de xa en 1,4 ms, con XA mínimo de 1,739 V.

### C3. Monte Carlo (tt_mm, 48 chips, v3)

**Validez.**
- El control C0 pasa: los 6 chips son idénticos y quedan a ≤ 0,005 % del contrato.
- El testigo pasa, y los 48 chips son distintos entre sí.
- Los 4 decks tienen el mismo circuito que C0.
- Un chip no cruza en 200 µs en e01 (2,1 %, frente al límite de 25 %). **El benchmark es válido.**

| # | Resultado | Predicción | Veredicto |
|---|---|---|---|
| M1 | σ ln(tA/tB) e01 = **1,204** [0,987, 1,378], N = 47 | corte 0,655; banda [0,45, 0,90] | el corte decide n = 1,3, pero la banda es **FALSA**: el valor está por encima de los dos modelos |
| M2 | σ e11 = **0,559** [0,425, 0,672], N = 48 | corte 0,199; banda [0,12, 0,30] | igual: **FALSA**, ~2,5× el modelo de n = 1,3 |
| M3 | mediana abs(Δ) = **0,803 %**; 100 % de los chips en [0,50, 1,00] %; 47 de 47 con signo negativo | [0,70, 0,91] % y ≥ 90 % | **cumplida** |
| M4 | **40,4 %** de los chips con trampa < 10 cuentas (mediana 14,4, mínimo 2,5) | [15, 50] % | **cumplida** |
| M5 | mediana del paso = **0,985 %** (dentro de ±15 % de 0,9625); **87,5 %** de los chips ≥ 0,50 % | mediana en banda y ≥ 90 % | **FALSA** (6 de 48 chips por debajo de 0,50 %) |

**Por qué fallan M1, M2 y M5 (lo aburrido primero; exploración, no decide).**
- **M5:** el P4 registrado es una diferencia de cocientes, [tA/tB]e10 − [tA/tB]e11, y hereda el desajuste A/B de cada chip. Su
  correlación con [tA/tB]e11 es **0,999**. El paso relativo, P4 / [tA/tB]e11, da **0,93–1,00 %** en los 48 chips, con ninguno
  bajo 0,5 %. Es decir:
  - el condensador de calibración es tan estable como apostaba la enmienda;
  - la métrica escrita no lo separa del desajuste.

  No se redefine M5 después de ver. La métrica relativa iría en una enmienda nueva con chips nuevos.
- **M1 y M2:** el modelo de `calc_mc.py` solo ponía desajuste en los dispositivos que descargan, con σVth = 17,3 mV. El macro
  también tiene comparadores y espejos que desajustan. Que el exceso venga de ahí, de un σVth mayor en `tt_mm` para 0,42/0,15, o de
  la n de subumbral, es `[?]`: no se separó. Fuera de la predicción, la consecuencia de diseño es que **tA y tB de un chip pueden
  diferir ×3 o más**. La lectura de la trampa usa el mismo chip antes y después, así que el desajuste no la toca (M3); lo que sí
  mueve es cuántas cuentas da (M4).
- **La v1 (12 chips) dio lo mismo en M3 y M5:** mediana de 1,10 % y 100 % de los chips ≥ 0,50 %. Pero eran 12 chips, y la v1 no
  vale como evidencia (A1).

### C4. Ruido de disparo — cumplida, con la salvedad A3

| | Resultado | Banda | Veredicto |
|---|---|---|---|
| N4, control | R0: rango entre muestras 0, igual al h11 nominal | σ = 0 | cumplida |
| N1 | R1: σ ln(tA/tB) = **0,151 %**, N = 56 | [0,115, 0,195] | cumplida |
| N2 | R1′: **0,156 %**, N = 64 | [0,115, 0,195] | cumplida |
| N3, testigo | σ(R3)/σ(R1) = **2,94** | [2,4, 3,6] | cumplida (sin sorteos independientes, A3) |

**Relación señal/ruido de la trampa en un solo disparo** (R1′, una rama), sin predicción: 0,8085 % / 0,111 % = **7,3**.

## 2. Sigue / muere / inválido

- **Sigue** pedía C1a, C1b, M3, M5 y N1. **M5 es falsa**, así que **"sigue" no se cumple** tal como está escrito.
- **Muere:** no.
  - La mediana de M5 es 0,985 % (el límite es < 0,50 %).
  - Ningún chip tiene trampa < 0,30 % (el límite es > 10 %).
- **Inválido:** no. Control y testigo de C3 pasan, N3 y N4 pasan, y solo un 2,1 % de los chips no cruza.
- **Lectura:** el macro v_hm no muere y su calibración es estable en paso relativo. Pero la calibración registrada (paso absoluto)
  no pasó en el 12,5 % de los chips, y el desajuste es mayor que el modelado. **El resultado negativo se publica igual.**

## 3. Qué queda demostrado (en el modelo, no en silicio)

- La trampa de 0,305 mV da Δ = −0,74 a −0,83 % en todos los chips con desajuste.
- La relación señal/ruido en un disparo es ~7.
- El paso relativo de calibración es 0,93–1,00 %.
- `en = 0` deja 8,3 pA a ss 85.

## 4. Siguiente, sin correr

1. Una enmienda con M5 relativo (P4 / [tA/tB]e11), con semillas nuevas.
2. Separar de dónde sale el desajuste de M1 y M2: Monte Carlo con desajuste solo en los dispositivos que descargan, frente a todo.
3. Rehacer el ruido con `setseed` por deck, si N3 tiene que ser un testigo independiente.
