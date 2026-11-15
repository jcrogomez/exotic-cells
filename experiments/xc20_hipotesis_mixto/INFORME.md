# Motor de hipótesis de XC-20, ronda 2: mecanismos que coexisten y un instrumento realizable · informe

**Prerregistro:** [`PREREG.md`](PREREG.md), escrito el 2026-11-15 a las 17:03:37 EST (`date`), antes del código.

**Corridas** (`date` en cada salida):

| Corrida | Hora (EST) | Resultados |
|---|---|---|
| Principal | 17:07:22–17:42:02 | `resultados2.txt` |
| Convergencia (4× chips internos) | hasta 18:00:17 | `convergencia2.txt` |
| Las que faltaban y sensibilidad a K | 18:00–18:08:40 | `extra2.txt` |
| Lector mixto (exploratorio) | 18:00–18:08:33 | `mixto2.txt` |


**Verificación independiente:** [`verificacion/ver2_INFORME.md`](verificacion/ver2_INFORME.md).
- Código propio y otra familia de estimador: una cota variacional con clasificador, más cuasi-Monte Carlo como control.
- Números fijados a las 17:40:42, antes de leer este código.

**Todo es modelo. Nada está medido.**

## 1. Qué cambió respecto a la ronda 1

| Cambio | En qué consiste |
|---|---|
| Cuarto mecanismo, M | Túnel y puente a la vez |
| Puente no lineal | La mitad de los chips R tienen forma 2–20 |
| Excitador | Resistencia serie 100 Ω–5 kΩ y límite 0,1–4 mA |
| Calibración | Independiente (C0); ganancia común a todas las lecturas (C1, σg 0,5, σe 0,02); más una deriva a 85 °C (C2, σδ 0,03) |
| Túnel en d = 0,27 | Ya no es 0: es t0/K con K entre 7·10³ y 10⁶ |

Variantes V0–V4 en el prerregistro.

**Desviación del prerregistro.** La ganancia común se integró analíticamente, no por Gauss-Hermite. Con σe = 0,02 frente a σg = 0,5,
el integrando en g tiene un pico unas 25 veces más estrecho que el prior y una cuadratura de nodos fijos no lo resuelve (docstring
de `motor2.py`). El verificador hizo lo mismo por su cuenta.

**Omisión mía.** La lista de corridas de `motor2.py` dejó fuera V4 con XC-26 en C0 0,5 y en C2, que el prerregistro pedía. Las corrí
después de leer al verificador, que las había hecho (`extra2.txt`).

## 2. Estimador: qué vale y qué no

- **Convergencia.** V4 C1 y C2 con 160 000 chips internos en vez de 40 000 cambian ≤ 0,005 bits (`convergencia2.txt`). El sesgo del
  Monte Carlo anidado es despreciable con el lector ancho.
- **Acuerdo con el verificador.** En todas las casillas comunes, la diferencia es ≤ 0,032 bits; la mayor, a 2,4σ.
  - Mis errores (±0,010–0,015) son unas diez veces los suyos, porque uso 600 lecturas externas por mecanismo.
  - Él usa 100 000 y diferencias pareadas. Con mis errores no se resuelven efectos de 0,01 bits; donde importa, cito los suyos.
- **Dónde falla mi estimador.** Con el lector mixto, el diseño de cinco lecturas (+85 °C + −0,9 V) viola la monotonía con
  errores 5–10 veces mayores. En V4 C1 da 1,584 ± 0,085 frente a 1,688 de D0 − 0,9 V. Es el anidado quedándose corto con muchas
  lecturas finas. Esas tres filas de `mixto2.txt` no valen; para ellas, el número es el del verificador.

## 3. Resultados (bits, prior uniforme; con M el máximo es 2)

**V4, el modelo completo, I(M;Y).** Mío / verificador:

| | D0 | +85 °C | −0,9 V | peine | ambos |
|---|---|---|---|---|---|
| ancho, C0 0,05 | 1,108 / 1,114 | 1,213 / 1,222 | 1,440 / 1,439 | 1,108 / 1,126 | 1,456 / 1,465 |
| ancho, C0 0,5 | 1,038 / 1,051 | 1,070 / 1,089 | 1,200 / 1,225 | 1,037 / 1,068 | 1,246 / 1,258 |
| ancho, C1 | 1,043 / 1,075 | 1,349 / 1,350 | 1,453 / 1,441 | 1,084 / 1,099 | 1,477 / 1,488 |
| ancho, C2 | 1,059 / 1,075 | 1,303 / 1,289 | 1,436 / 1,441 | 1,084 / 1,099 | 1,480 / 1,475 |
| XC26, C0 0,05 | 1,259 / 1,263 | 1,338 / 1,341 | 1,329 / 1,331 | 1,258 / 1,263 | 1,397 / 1,406 |
| XC26, C0 0,5 | 1,214 / 1,218 | 1,262 / 1,266 | 1,277 / 1,283 | 1,214 / 1,218 | 1,322 / 1,327 |
| XC26, C1 | 1,229 / 1,218 | 1,315 / 1,313 | 1,279 / 1,302 | 1,207 / 1,218 | 1,399 / 1,394 |

**¿Hay túnel o no? (D4), V4 C1, I(túnel;Y), máximo 1 bit:**

| | D0 | +85 °C | −0,9 V | ambos |
|---|---|---|---|---|
| ancho | 0,41 | 0,56 | 0,57 | 0,60 |
| XC26 | 0,73 | 0,82 | 0,75 | 0,86 |
| mixto | 0,80 | 0,86 | 0,80 | 0,88 (verificador) |

**Sensibilidad al techo de K**, el supuesto que decide la lectura de d = 0,27. No estaba prerregistrada: la añadí tras ver el
resultado. D0 − 0,9 V, I(M;Y):

| K hasta | ancho C0 0,05 | XC26 C0 0,05 | mixto C0 0,05 | ancho C0 0,5 | XC26 C0 0,5 | mixto C0 0,5 | ancho C1 | XC26 C1 | mixto C1 |
|---|---|---|---|---|---|---|---|---|---|
| 10⁶ (prerregistro) | 1,440 | 1,329 | **1,705** | 1,200 | 1,277 | **1,552** | 1,453 | 1,279 | **1,688** |
| 10⁹ | 1,421 | 1,049 | **1,520** | 1,159 | 1,038 | **1,310** | 1,435 | 1,033 | **1,514** |
| 10¹² | 1,417 | 0,960 | — | 1,148 | 0,949 | — | 1,426 | 0,941 | — |

El lector mixto (d = 0,27 con XC-26, d = 0 con el ancho) lo propuso el verificador y no está prerregistrado. Es exploratorio.

## 4. Predicciones

| # | Predicción | Resultado (mío; verificador) | |
|---|---|---|---|
| 0 | V0 con K = ∞ reproduce la ronda 1 (3σ + 0,02) | D0 1,353 frente a 1,362; σ 0,5: 1,266 frente a 1,280; la mayor, +85 °C con σ 0,5, 0,025 (tolerancia 0,06) | **Cumplida** |
| 1 | V1: −0,9 V entre 1,5 y 1,85; I(túnel) ≥ 0,75; D1 se mantiene | 1,547; I(túnel) **0,555**; D1 sí | **Fallada** en I(túnel) |
| 2 | V2: −0,9 V baja ≥ 0,05 frente a V0 | Baja 0,016 (0,018) | **Fallada** |
| 3 | V3: cambio ≤ 0,1 | 0,000 | **Cumplida** |
| 4 | C1: 85 °C suma ≥ 0,15 sobre D0; \|Δ\| < 0,1 | V1 0,165 · V2 0,180 · V3 0,151 (0,124 en el verificador) · V4 0,306. \|Δ\|: V1 0,08 · V2 0,00 · V3 0,08 · V4 0,104 (0,092) | **Al borde**: falla en V3 según el verificador, y V4 queda en el límite |
| 5 | C2: 85 °C pierde ≥ 0,03; −0,9 V no cambia | Pierde 0,046 (0,061); −0,9 V igual con diferencias pareadas (verificador) | **Cumplida** |
| 6 | V4: D1 no se invierte; D3 en todas; D2 | D1 sí con el ancho; **D3 se invierte en C0 0,5** (ancho 1,200, XC26 1,277); D2 sí | **Fallada** en D3 |
| 7 | V4 con XC26: 0,81–1,0 bits; I(túnel) ≤ 0,3 | 1,21–1,40; I(túnel) 0,71–0,87 | **Fallada**, y por mucho |

**Por qué falla la 7, y con ella la 6.** No es el estimador: es el modelo.
- Con K finito, el túnel residual de d = 0,27 está sobre el piso de XC-26 en el 94 % del prior (verificador).
- El lector sensible lo ve; el ancho, con su piso de 1 nA, casi nunca.
- Mi predicción salió de los números de la ronda 1, que tenía K = ∞. No tuve en cuenta el cambio que yo mismo había introducido.

## 5. Decisiones

| | Decisión | Resultado |
|---|---|---|
| D1 | Segunda tensión antes que segunda temperatura | Se mantiene con el lector ancho en todas las calibraciones y techos de K, pero el margen baja a ~0,1 bits con la ganancia común (C1). Con XC-26 se invierte por ~0,01–0,04 bits, de forma real pero pequeña (verificador, pareado). Con el lector mixto en C1 es un empate (1,688 frente a 1,660). |
| D2 | El peine puede esperar | Se mantiene: suma 0,00–0,04 bits (0,012–0,024 pareado). En C1 con K hasta 10⁹ y 10¹² el estimado sube a 0,058–0,064 ± ~0,018, no resuelto. |
| D3 | Hace falta el lector ancho | **Depende de K.** Con K hasta 10⁶ y sin calibración (C0 0,5), XC-26 solo gana al ancho. Con K hasta 10⁹ o más, el ancho gana en todo. **El lector mixto gana a los dos lectores únicos en todas las combinaciones fiables.** |
| D4 | ¿Hay túnel? | Con el ancho, 0,41–0,60 bits (acierto 0,76–0,83). Con el mixto, 0,80–0,88 con K hasta 10⁶ y 0,53–0,68 con K hasta 10⁹. El límite principal no es el instrumento: en M el túnel es < 10 % de la corriente de d = 0 en el 65 % de los chips (verificador). |

## 6. Juicio: ¿ganó el motor su sitio?

**Cláusula de muerte** del prerregistro: el motor muere si V4 da las mismas decisiones que V0 y lo que cambia se pudo prever de los
intervalos.

**No se cumple. Cambian dos cosas que no previ:**
1. **La estructura d = 0,27 cambia de papel.**
   - Era el control del fondo térmico.
   - Leída con el lector sensible, pasa a ser el mejor detector de túnel: el túnel residual a 0,27 µm (pA–nA) está en el rango
     de XC-26.
   - Eso hace que la mejor configuración no sea un lector, sino **un lector por estructura**.
   - Lo predije al revés (predicción 7). En retrospectiva se deduce del intervalo de K, pero yo no lo deduje, y fue el cálculo,
     mío y del verificador, lo que lo mostró.
2. **Con ganancia común, la temperatura casi alcanza a la segunda tensión.**
   - Con el lector mixto es un empate. La ronda 1 decía +0,14 a +0,17 a favor de la tensión.
   - Es lo que el verificador de la ronda 1 había previsto que pasaría al corregir el modelo de calibración.

**Qué no hay que sobrevender:**
- Las dos dependen de supuestos sin fuente: el techo de K, σe = 0,02 y σg = 0,5.
- La primera, en concreto, se debilita mucho si el túnel a 0,27 µm se suprime más de 10⁹ veces.
- Lo robusto no es «XC-26 gana», sino «leer d = 0,27 con un lector sensible no cuesta nada y puede ganar mucho»: el mixto queda
  primero con los dos techos de K.

**Recomendación sobre el motor:** sigue siendo un script por familia. Ha mostrado una decisión que no habría tomado a mano, que era
la condición para seguir. Antes de generalizarlo hay que resolver lo de §7.

## 7. Límites y pendientes

1. **K es la incógnita decisiva** y no tiene fuente más allá de «≥ 7·10³» (b20 §5).
   - Medirla pide separaciones intermedias, la matriz de §5.2 del plan.
   - El motor no las ha modelado: es una idea, no un resultado.
2. **Supuestos sin fuente:**
   - Rs, Imax y σδ son **supuestos** `[?]`.
   - El excitador fabrica firmas: el límite de corriente hace que el 21 % de los chips R de V4 lean igual a −1,8 y −0,9 V
     (verificador).
3. **Lo que dejó abierto el verificador:**
   - La regla de D1 (2σ de Monte Carlo) mide significación, no tamaño. Hay que fijar un umbral de efecto para la próxima ronda.
   - Censura sobre la lectura y no sobre la corriente: no se exploró la otra opción `[?]`.
4. **Mi estimador** necesita diferencias pareadas y más lecturas externas para resolver efectos ≤ 0,02 bits. Con más de cuatro
   lecturas finas, el anidado no basta (§2).
5. **Pendientes de la revisión externa del 2026-11-15**, anotados sin aplicar:
   - en `tools/science_ci.py`, exigir longitud y valores finitos antes de `zip(got, want)`;
   - añadir un modelo discreto con mecanismos solapados e información mutua exacta a `test_motor.py`. Haría visible la mutación
     equivalente (la normalización de G), que con mecanismos que se solapan sí pesa.

## Archivos

| Archivo | Qué es |
|---|---|
| `PREREG.md` | El prerregistro |
| `motor2.py` | El código; `--rapido`, `--convergencia`, `--extra`, `--mixto` |
| `resultados2.txt`, `convergencia2.txt`, `extra2.txt`, `mixto2.txt` | Las tablas |
| `*_salida.txt` | La salida de consola con la hora final |
| `verificacion/` | Código, tablas e informe del verificador; los volcados por muestra `ver2_lt_*.npz` (68 MB) se regeneran con sus scripts y no se versionan |
