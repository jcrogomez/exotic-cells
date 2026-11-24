# MISFIT-03 · enmienda 2 · macro v_hm (inversor hvt + unidad MOS), Monte Carlo y ruido de disparo

Cita el original [`MISFIT-03_2026-11-23_slot_xc19.md`](MISFIT-03_2026-11-23_slot_xc19.md) (SHA-256 `eb0917c4…e25d`) y la
[enmienda 1](MISFIT-03_2026-11-23_slot_xc19_enmienda1.md) (`f3255a6d…8cc`). Escrita el 2026-11-24 desde las 09:44:56 EST
(`date`), después del [informe de la etapa a](../../experiments/xc19_slot/INFORME_etapa_a.md). El original y la enmienda 1 no se
editan.

## 0. Lo que ya se vio antes de escribir esto (exploración, no evidencia)

Esta enmienda llega **tarde para una parte**. El macro nuevo ya está dibujado, y su contrato nominal ya corrió en tres esquinas
antes de escribirla. Esos números son **diseño**, como `diseno_ref3.txt` en la enmienda 1, y aquí no reciben veredicto: una
corrida nominal es determinista y volver a correrla daría el mismo número. Lo visto:

| Archivo | Qué | Hora |
|---|---|---|
| `experiments/xc19_slot_e2/calc/` (calc_hvt, diag_placa, diag_c, diag_s, diag_mos) | exploración del arreglo de P2 y P4 en esquemático + macro viejo | 2026-11-24, madrugada |
| `experiments/xc19_slot_e2/diseno/contrato_visto_0944.txt` | contrato del macro `v_hm` (decks `contrato_*` en 4 esquinas, `largo_*` en tt 27, ff −40 y ff 85) | hasta las 09:44 |
| `experiments/xc19_slot_e2/mc/humo_tt`, `humo_mm` | humo del Monte Carlo: control sin desajuste (1 chip) y `tt_mm` semilla 7 (2 chips) | 08:05–09:35 |

Lectura del contrato visto (tiempos desde T0, umbrales de la enmienda 1):

| Esquina | tA src=01 | P5′ | P4 (paso) | trampa | paso (cuentas) |
|---|---|---|---|---|---|
| tt 27 | 30,873 µs | 0,0117 % | 0,9625 % | −0,8085 % = 12,48 cuentas | 15,23 |
| ss 85 | 31,103 µs | 0,0121 % | 0,9531 % | −0,6845 % = 10,64 cuentas | 10,66 |
| ff 85 | 2,489 µs | 0,0091 % | 0,7787 % | −0,6328 % = 0,79 cuentas | **1,07** |
| ff −40 | 46,884 µs | sin cruce en 80 µs | sin cruce | −1,0029 % = 23,51 cuentas | — |

- **P4 a tt** queda **fuera** de la banda de la enmienda 1 (0,25–0,60 %), por arriba. No se pone una banda nueva después de ver el
  número.
- **P6′ a ff 85** predecía < 1 cuenta y da 1,07. Se reporta así.
- **P2 (`en = 0`, transitorio):** 2,39 pA a tt y 2,46 nA a ff 85, frente a 2,714 nA y 305,9 nA del macro viejo.
- **El humo del Monte Carlo:**
  - El control sin desajuste reproduce el contrato: 31,8717 µs frente a 31,8732 µs absolutos, un 0,005 %.
  - Con desajuste, la trampa da −0,78 % y −0,77 %, y el paso de P4 +0,95 % y +0,92 %. Son dos chips.
  - Entre `src = 01` y `src = 11`, tA cambia hasta ×2,2 en un mismo chip.

## 1. Cambios de diseño

| # | Qué | Por qué |
|---|---|---|
| D1 | Los pfet de los inversores de salida (X73, X95) pasan a `pfet_01v8_hvt` (`INVHVT=1` en `xc19_slot_core.tcl`) | P2: toda la corriente de `en = 0` salía de esos dos pfet (informe §2) |
| D2 | Las placas de metal de S1 y S2 se sustituyen por un condensador MOS nfet 0,42/0,30 por interruptor, con la puerta en el nodo de la placa y S/D/cuerpo a GND (`MOSU=1`). Está fuera del área de la referencia | P4: el paso era la diferencia entre dos interruptores de ~0,7 fF cada uno, no la placa (`calc/diag_s`). La placa sola (~0,38 fF efectivos) no alcanzaba |
| D3 | P3 se reancla al comparador propio del macro. Su valor de diseño, a tt, es 30,873 µs desde T0. **Sin veredicto**, porque ya se vio | informe §2: la banda vieja era la de un `inv_1` de la biblioteca |

Dibujo `cells/xc19_slot_core_a2/v_hm`: Magic DRC 0, KLayout `mr` 0, KLayout full 0, LVS "Circuits match uniquely" contra
`ref_a2.spice`. LOD anotado: 39 condensadores reinsertados.

## 2. Predicciones sobre lo que no se ha visto

### C1. ff −40 nominal, con tstop de 160 µs (deck `contrato_ff_-40_t160`)

En el contrato visto, `src = 11` no cruzó antes de 80 µs. El deck es el mismo con `tran 10n 160u`.

- **C1a.** h11, tA desde T0, entre **80 y 86 µs**.
  - Macro viejo: 75,53 µs.
  - Factor de capacidad visto en las otras tres esquinas, nuevo/viejo en h11: 1,089 (tt), 1,100 (ss 85) y 1,079 (ff 85).
- **C1b.** P4 entre **0,85 y 1,10 %**.
  - `calc/diag_mos` (L = 0,30) da 0,8524 % a ff −40.
  - En las otras tres esquinas el macro dio un 11–17 % más que `diag_mos`, y esa corrección está declarada.
- **C1c.** P5′ ≤ 0,15 %. P6′: paso ≥ 5 cuentas.

### C2. ss 85, transitorio largo (deck `largo_ss_85`)

- **C2a.** Si el transitorio `e0` (`en = 0`) termina, la corriente del macro es < 1 nA. Si no termina, como en el macro viejo, se
  dice "no corrido" y vale el `.op` de `calc_hvt`, que ya se vio: 8,31 pA.
- **C2b.** F5 (VB > 0,1 V) y F6 (timeout) se detectan.

### C3. Monte Carlo de desajuste (`tt_mm`, 27 °C)

**Diseño.**
- `mc/gen_mc.py` con K = 6 chips por deck y N = 2 tiradas (`reset`), es decir, 12 chips por deck. Cuatro decks con semillas 2101,
  2102, 2103 y 2104: **48 chips**.
- `tran 10n 200u 0 50n`. Un cruce después de 200 µs se cuenta como "sin cruce" y se reporta; no se descarta en silencio.
- Estados del mismo chip, sin `reset` entre ellos:

  | Estado | Qué es |
  |---|---|
  | e01 | `src = 01` |
  | e01t | `src = 01` con la trampa de +0,305 mV en la puerta del DUT de A |
  | e11 | `src = 11` |
  | e10 | `src = 10` |

- Números de `prereg_calc/calc.py` → `calc.txt` y `prereg_calc/calc_mc.py` → `calc_mc.txt`. Modelo de subumbral con
  σVth = 17,3 mV por dispositivo y n entre 1,3 y 1,6 `[?]`.

**Medidas.**

| # | Cantidad | Predicción | Cómo decide |
|---|---|---|---|
| M1 | σ de ln(tA/tB) en e01 (DUT frente a gemelo) | n = 1,3 → 0,727; n = 1,6 → 0,591 | **Corte en 0,655:** debajo gana n = 1,6, encima n = 1,3. Si el IC bootstrap al 95 % (central, 10 000 remuestreos) contiene el corte, **sin decidir**. Además se predice que cae en [0,45, 0,90] |
| M2 | σ de ln(tA/tB) en e11 (referencias 2×6) | n = 1,3 → 0,222; n = 1,6 → 0,177 | corte en 0,199, misma regla; se predice [0,12, 0,30] |
| M3 | Salto de trampa en el mismo chip: Δ = tA(e01t)/tA(e01) − 1 | nominal −0,8085 %. Subumbral: 0,911 % (n = 1,3) y 0,739 % (n = 1,6) | mediana de abs(Δ) en [0,70, 0,91] %, y ≥ 90 % de los chips con abs(Δ) en [0,50, 1,00] % |
| M4 | Fracción de chips con trampa < 10 cuentas a 50 MHz (abs(Δ) · tA(e01) · 50 MHz) | 25,9 % (n = 1,3) y 38,2 % (n = 1,6), contando solo el desajuste del DUT | en [15, 50] % |
| M5 | Paso de P4 en el mismo chip: [tA/tB]e10 − [tA/tB]e11 | nominal 0,9625 % | mediana en ±15 % del nominal, y ≥ 90 % de los chips ≥ 0,50 %. **Apuesta razonada, sin cálculo:** es un cociente de capacidades, y el desajuste de Vth solo mueve el inicio de la inversión del MOS unos 17 mV, sobre ~0,9 V de excursión |

**Control y testigo.**
- **Control:** un deck con la biblioteca `tt` (sin desajuste), K = 6, N = 1. Los 6 chips son idénticos entre sí y al contrato
  nominal dentro de 0,01 %.
- **Testigo:** en cada deck `tt_mm`, los K chips de una misma tirada dan cocientes distintos. Si son idénticos, el desajuste no es
  por instancia y el diseño de K por deck no vale.

### C4. Ruido de disparo en transitorio (sin desajuste)

**Diseño.**
- `ruido/gen_ruido.py`, a tt 27: M = 8 instancias por deck y L = 8 repeticiones con `reset`, es decir, 64 muestras por deck.
- En cada nodo, una fuente `trnoise` de corriente con densidad unilateral 2qI (NT = 10 ns), multiplicada por k.
- Decks:

  | Deck | `src` | k | Papel |
  |---|---|---|---|
  | R0 | 11 | 0 | control |
  | R1 | 11 | 1 | medida |
  | R3 | 11 | 3 | testigo |
  | R1′ | 01 | 1 | medida, `src = 01` |

- **No entra kT/C:** `trnoise` no lo modela. Según `calc.txt` es ~0,018 % por rama, pequeño frente al disparo.

**Predicciones.**
- **N1.** σ de ln(tA/tB) entre muestras, en R1, dentro de **[0,115, 0,195] %**.
  - El disparo solo da 0,1531 % (`calc.txt`).
  - La banda cubre el error de muestreo con 64 muestras (±17 % al 95 %) y la aproximación de corriente constante.
- **N2.** En R1′, igual: [0,115, 0,195] %.
- **N3, testigo.** σ(R3) / σ(R1) en [2,4, 3,6].
- **N4, control.** R0 da σ = 0: todas las muestras son iguales a 1e-6 relativo, e iguales al h11 nominal dentro de 0,01 %.
- **Qué se reporta:** la relación señal/ruido de la trampa en un solo disparo, abs(Δ trampa) / σ(una rama, R1′). Se reporta sin
  predicción binaria.

## 3. Sigue, muere, inválido

- **Sigue:** C1a, C1b, M3, M5 y N1 se cumplen. Es decir, el macro `v_hm` se calibra igual en el chip con desajuste, y su ruido es
  el previsto.
- **Muere (como lector calibrado; el slot puede seguir como experimento):**
  - la mediana de M5 cae < 0,50 %, o
  - más del 10 % de los chips tienen trampa < 0,30 %.
- **Benchmark inválido:**
  - falla el control de C3 o su testigo;
  - falla N4 o N3;
  - más del 25 % de los chips no cruzan en 200 µs en e01 (el diseño de la ventana no sirve).
- **El resultado negativo se publica igual.**

## 4. Orden y presupuestos

- **Orden:** C1 y C2, que ya están en cola; el humo de C4 (`humo_k*`, M = 4, L = 2) solo para ver que el deck corre; luego C4 y
  C3.
- **Del humo de C4:** antes de sellar no se lee ningún número salvo el de "corre o no corre".
- **Presupuesto de resolución:** las 4 corridas de C3 y las 4 de C4, de dos en dos o de tres en tres por la memoria. **Auditoría:**
  el control y el testigo de cada una.
- **Si C3 no cabe en tiempo:** se reporta lo que terminó, con N real, y no se cambian los cortes.

Estado: **congelado** al sellar su SHA-256 en `experiments/xc19_slot/PREREG_SHA256.txt`.

## Enmiendas

(ninguna)
