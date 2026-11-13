# c58b · Análisis de las simulaciones terminadas de XC-58

Cerrado: Thu Nov 12 22:33:49 EST 2026 (hora de `date`). Todo es modelo; nada medido en silicio. Las cifras salen de `c58b_analisis.py` → `c58b_tablas.txt`,
que solo relee resultados. **Una corrida nueva**, imprescindible para el apartado 4 (traza y ciclos sucesivos): `c58b_ciclos.py`.
No se borró nada ni se hizo commit.

**Corrección que cambia un número del informe anterior.** La cifra «0,68 ± 0,04» de ngspice **no es una cota limpia**: la fuente de
ruido que añadí inyecta ruido espurio después del corte del interruptor (apartado 2.3). Corregida queda en ~0,50 en el nodo mínimo, y
el método tampoco contiene el ruido fuera del equilibrio. El factor en el nodo mínimo lo sostienen solo los dos Monte Carlo
(el mío y el del verificador), que son de la misma clase de modelo.

## 1. Trazabilidad

Común a todo ngspice: versión 44.2 (imagen `hpretl/iic-osic-tools:2025.07`); PDK local `sky130A` `8afc8346`,
`libs.tech/ngspice/sky130.lib.spice`, esquina **tt** (sin desajuste); lector = `cells/xc19_read/xc19_read.pex.spice` (extraído);
interruptor `nfet_01v8` 0,42/0,15 añadido en el deck (no extraído); condición inicial = punto de operación de ngspice (sin `.ic`);
`gmin = 1e-18`.

| Archivos | Script que genera / lee | Netlist | T | VDD | Ruido y semilla | Estado |
|---|---|---|---|---|---|---|
| `c58_det_*.sp/.log`, `c58_det.txt` | `c58_gen_det.py` | lector + cadena K=4 + interruptor | 27, 85 | 1,80; 1,81 | sin ruido | **abortado** en t = 2,001 µs; no se usa |
| `c58_d2_*_p1`, `c58_det2_pass1.txt` | `c58_det2.py` | ídem, ventana 2,5 µs, polarización nominal | 27, 85 | 1,80; 1,81 | sin ruido | usado: pedestales |
| `c58_d2_*_p2`, `c58_det2_pass2.txt` | `c58_det2.py` | ídem, polarización subida en el pedestal, 3 ms | 27, 85 | 1,80; 1,81 | sin ruido | usado: deriva larga |
| `c58_d3_*`, `c58_det3_pass1/2.txt` | `c58_det3.py` | ídem, 400 µs; canal B con +1 mV en la fuente | 27, 85 | 1,80; 1,81 | sin ruido | usado: tiempos, alimentación, variantes |
| `c58_d4_*`, `c58_det4.txt` | `c58_det4.py` | ídem; canal B con +1 aC sobre el nodo aislado | 27, 85 | 1,80 | sin ruido | usado: C efectiva y ganancia |
| `c58_swdc_27/85.sp/.log/.dat`, `_show.txt` | a mano (en el informe) | un nfet 0,42/0,15 | 27, 85 | — (fuente 0,317 V) | sin ruido | usado: g(Vg), fuga, `cgso` |
| `c58_trn_cx{0,2,9}_tf500p_nt1_T27_s{0..14}.sp/.out`, `c58_trn_resumen.txt` | `c58_trn.py` | 40 × (interruptor + lector), fuente ideal 0,3168 V, sin cadena, un ciclo | **27 solo** | 1,80 | blanco 4kT·g(t), paso 1 ps; `rndseed = 20261112 + k` | usado con reservas (2.3); 2 de 15 decks de Cx=9 abortaron |
| `c58_trn_resumen_intento*_abortado.txt`, `_prueba_20.txt` | `c58_trn.py` (versiones previas) | — | 27 | 1,80 | — | no se usan |
| `c58_mc.txt` | `c58_mc.py` | no hay netlist: Langevin propio, interruptor EKV ajustado a `c58_swdc_27.dat` | 300,15 y 358,15 K | reloj 1,8 → 0 | `default_rng(1)`, N = 40 000 | usado |
| `c58_mc2.txt` | `c58_mc2.py` | ídem, dos modelos de ruido | 300,15 K | ídem | `default_rng(2)`, N = 20 000 | usado |
| `c58_regimes.txt`, `c58_mapa.png` | `c58_regimes.py` | aritmética | — | — | — | usado; `_v1_*` es la versión con el error de 3 µs |
| `c58b_ciclos_n8_c80_s{101,102,103}.sp/.out` | `c58b_ciclos.py` (**nuevo**) | 8 × (interruptor + lector), 80 ciclos de 1,2 ns | 27 | 1,80 | como `c58_trn`; `rndseed` 101–103 | usado (apartado 4) |
| `c58b_ciclos_n2_c3_s77_traza.dat`, `c58b_traza.png` | `c58b_ciclos.py` / `c58b_analisis.py` | 2 nodos, 3 ciclos, traza completa | 27 | 1,80 | `rndseed` 77 | usado; el aborto del `.out` es en el último instante |

**Rótulos.** Etiqueta de caso: `cx{fF añadidos}_tf{flanco}_v{VDD}_T{°C}_{variante}_p{pasada}`; variantes `n` (nfet), `pcomp`
(nfet + pfet), `dummy` (nfet 0,84 + ficticio 0,42), `ideal` (puerta atada, sin interruptor).

| Línea | Columnas (tras la etiqueta) |
|---|---|
| `DETA` | `vb0`: polarización a 0,9 µs (V) · `ga_on`: puerta del canal A con el interruptor cerrado, 0,9 µs (V) · `ga_off`: puerta A ya aislada, 1,9 µs (V) |
| `DETB` | `ga_rel`: puerta A a 3,2 µs, tras soltar la precarga (V) · `gc1`: puerta del canal C (nunca se suelta) a 1,9 µs (V) · `gc2`: ídem a 3,2 µs, tras el pulso de 1 aC (V) · `gc3`: a 200 µs (V) · `gc4`: a 2,99 ms en `det2`, a 390 µs en `det3`/`det4` (V) |
| `DETC` | `ta`: instante absoluto en que la salida del inversor A cruza 0,9 V (s; **incluye 3 µs** previos a soltar) · `tb`: ídem canal B (+1 mV en la fuente en `det2`/`det3`; +1 aC en `det4`) · `ga_end`: puerta A en ese instante (V) |
| `c58_trn_resumen.txt` | N · media y σ de v(puerta) 8 ps antes de que el reloj empiece a bajar · media y σ 0,3 ns después de terminar el flanco · error relativo de σ · asimetría · curtosis − 3 · correlación entre esas dos lecturas |
| `c58_mc.txt` | C total (fF) · flanco (s) · T (K) · **varianza**/(kT/C) · pedestal (mV, solo acoplo por Cov) · asimetría · curtosis − 3 |
| `c58_mc2.txt` | C, Cov, flanco, modelo de ruido (`completo` = 2kT(g_nodo + g_fuente); `replica` = 4kT·g_fuente) · **varianza**/(kT/C) · pedestal |

**No existe**: ruido en ngspice a 85 °C; ruido del lector con la puerta flotante; ruido con las variantes `pcomp` y `dummy`;
esquinas distintas de tt; desajuste; ruido 1/f o de trampas simulado.

## 2. Ruido

### 2.1 Por capacidad (27 °C, flanco de 500 ps, nfet mínimo)

| | Nodo mínimo | +2 fF | +9 fF |
|---|---|---|---|
| Capacidad efectiva (pulso de 1 aC sobre el nodo aislado, `c58_det4.txt`) | 0,963 fF | 2,956 fF | 9,991 fF |
| kT/C: varianza / eficaz | 4,305 mV² / 2,075 mV | 1,402 / 1,184 | 0,415 / 0,644 |
| ngspice, varianza medida / eficaz (N) | 2,922 mV² / 1,709 mV (600) | 1,389 / 1,179 (600) | 0,393 / 0,627 (520) |
| Cociente de **varianza**, ngspice bruto | 0,679 ± 0,039 | 0,991 ± 0,057 | 0,947 ± 0,059 |
| Ídem en valor eficaz | 0,824 ± 0,024 | 0,995 ± 0,029 | 0,973 ± 0,030 |
| Ruido espurio del método (2.3), en varianza | +0,176 | +0,057 | +0,017 |
| Cociente de varianza, ngspice corregido | **0,50** | 0,93 | 0,93 |
| Cociente de varianza, Monte Carlo (`c58_mc`, `c58_mc2`) | 0,88–0,92 | 0,96–0,98 | 0,98–1,00 |
| Pedestal (50 ps / 500 ps / 5 ns) | −223 / −154 / −113 mV | −94 / −59 / −47 | −33 / −23 / −16 |
| Tiempo de conversión (soltar → inversor) | 330,4 µs | 54,0 µs | 34,0 µs |
| Ganancia respecto de la tensión congelada | 2,730 %/mV | 2,725 | 2,731 |
| Ruido propio del lector | 0,57 % por conversión = 0,21 mV equivalentes. **No resimulado** con la puerta flotante: es el del presupuesto previo (0,55 % de disparo a 29 µs, más reinicio) | ídem | ídem |

Segundo conjunto independiente en el nodo mínimo (`c58b_ciclos`, 1920 muestras): 0,663 ± 0,021 bruto, coherente con 0,679.

### 2.2 Varianza o eficaz

**Los dos son cocientes de VARIANZA.** «0,88–0,92» es var/(kT/C) del Monte Carlo (0,94–0,96 en eficaz). «0,68 ± 0,04» es
(1,709 mV)²/(kT/0,963 fF) (0,82 ± 0,02 en eficaz).

Con el verificador (1 − 0,69·n·Cov/C, varianza; Cov = 0,103 fF, C = 0,963 fF): 0,903 con n = 1,31 y 0,896 con n = 1,41. Mi ajuste
(1 − 0,85·Cov/C) da 0,909; mi corrida directa, 0,902. Coinciden a ±0,01: 0,69·n = 0,91–0,97 frente a mi 0,85. Con el Cov efectivo
que reproduce el pedestal de ngspice (0,125 fF): 0,87–0,88 y 0,88–0,89.

### 2.3 Por qué la cifra de ngspice no es fiable

La conductancia g(t) sale de restar dos réplicas con ±1 mV. Tras el corte la resta no cancela la corriente capacitiva del flanco: g
aparente se hace negativa desde t = 527 ps (reloj a 0,98 V), hasta −1,1·10⁻⁶ S, y la fuente usa |g|. Eso inyecta ruido sin
amortiguación: ∫|g|dt = 8,5·10⁻¹⁷ S·s → 0,176 / 0,057 / 0,017 de kT/C. El mismo error resta conductancia real cerca del umbral.
Además el método no lleva ruido fuera del equilibrio; `c58_mc2` predecía 0,76 para ese método y lo corregido da 0,50: **la diferencia
no está explicada**. Conclusión: ngspice sirve aquí para pedestal, capacidad y la forma de la traza, no para el factor.

## 3. Temperatura (27 °C frente a 85 °C)

**Las corridas de ngspice a 85 °C son deterministas: no contienen ruido.** Permiten concluir sobre ganancia, capacidad, tiempos, pedestal
y fuga. El único ruido a 358 K es el del Monte Carlo propio, que tiene capacidad constante por construcción.

| | Nodo mínimo | +2 fF | +9 fF |
|---|---|---|---|
| Ganancia 27 → 85 °C (%/mV) | 2,730 → 2,484 (×0,910) | 2,725 → 2,291 (×0,841) | 2,731 → 2,256 (×0,826) |
| Capacidad efectiva (fF), corregida de deriva | 0,963 → 0,979 (×1,017) | 2,956 → 2,973 (×1,006) | 9,991 → 9,901 (×0,991) |
| Conversión | 330 → 25,0 µs | 54,0 → 6,70 µs | 34,0 → 4,75 µs |
| Pedestal (500 ps) | −153,6 → −150,6 mV | −59,1 → −58,9 | −22,8 → −23,0 |
| Fuga a 85 °C; deriva durante la conversión | 291 fA; −7,4 mV | 291 fA; −0,66 mV | 289 fA; −0,14 mV |
| Ruido de disparo de esa fuga (cálculo, peso 1/3) | 8,0 % de kT/C | 0,7 % | 0,15 % |

**Predicción 1, tensión eficaz ×1,092.** Monte Carlo, seis casos: 1,089–1,093, cada uno ±0,0055. **Se cumple**, pero casi por
construcción (C constante; T entra por kT y kT/q). El cambio de capacidad medido en ngspice lo movería −0,8 %, −0,3 % y +0,5 %
(eficaz), dentro del error de la corrección de deriva. En ngspice con ruido: **no existe**.

**Predicción 2, dispersión relativa del tiempo ×0,915.** Producto de tensión (MC) × ganancia × capacidad × fuga:

| | Tensión | Ganancia | Capacidad | Fuga | Total | |
|---|---|---|---|---|---|---|
| +2 fF | 1,092 | 0,841 | 0,997 | 1,004 | **0,919** | se cumple |
| +9 fF | 1,092 | 0,826 | 1,005 | 1,001 | **0,907** | se cumple (−0,9 %) |
| Nodo mínimo | 1,092 | 0,910 | 0,992 | 1,039 | **1,024** | **no se cumple** |

Incertidumbre: ±0,5 % de la tensión (estadística); la ganancia a 10 fF lleva ~±1 % (escalón de 0,1 mV). En el nodo mínimo la
desviación es +12 %: +8,6 % de la ganancia (cae ×0,910 en vez de ×0,838), +3,9 % del disparo de la fuga, −0,8 % de capacidad. La
ganancia anómala coincide con la deriva de −7,4 mV de la puerta durante la conversión; que esa sea la causa es **conjetura**: no la aislé.
Control con la puerta atada: 2,719 → 2,265 %/mV (×0,833), es decir 1/T.

## 4. Correlación

**Qué compara «corr(antes, después)».** El mismo nodo y el **mismo ciclo**: v(puerta) 8 ps antes de que el reloj empiece a bajar y
v(puerta) 0,3 ns después de terminar el flanco. Entre ambas lecturas pasan ~0,8 ns.

**Por qué sale ≈ 0.** El interruptor no se abre cuando el reloj empieza a bajar: sigue conduciendo ~200 ps. Traza
(`c58b_traza.png`, tabla F de `c58b_tablas.txt`):

| t (ps) | Reloj (V) | g del interruptor (S) | τ = C/g | v(nodo 0) (mV) |
|---|---|---|---|---|
| 292 («antes») | 1,800 | 3,8·10⁻⁴ | 2,5 ps | 314,6 |
| 400 | 1,441 | 2,0·10⁻⁴ | 4,9 ps | 309,3 |
| 450 | 1,261 | 8,2·10⁻⁵ | 12 ps | 308,8 |
| 500 | 1,081 | 8,5·10⁻⁶ | 113 ps | 288,5 |
| 550 | 0,901 | cortado | — | 260,0 |
| 800 → 1090 («después») | 0 | cortado | — | 152,81 → 152,78 |

Con el interruptor cerrado la autocorrelación de v(nodo) cae a 1/e en 2,6 ps. Entre «antes» y el instante en que τ supera al tiempo
que queda (~480–500 ps) caben decenas de τ: el nodo se ha reequilibrado muchas veces y la muestra congelada es otra. El nodo sí
conserva su carga **después** del corte (152,81 → 152,78 mV en 290 ps); la lectura «antes» estaba mal elegida para probarlo. Medido:
−0,026 ± 0,041 (600) y −0,059 ± 0,023 (1920).

**Muestras sucesivas del mismo nodo** (`c58b_ciclos`, 24 nodos × 80 ciclos): autocorrelación +0,006 ± 0,023 (retardo 1), +0,040 ± 0,023
(retardo 2), −0,061 ± 0,024 (retardo 5; 2,5 σ, uno de tres retardos mirados); corr(después k, antes k+1) = −0,014 ± 0,023.
Alcance: solo prueba que el nodo no guarda memoria con fuente ideal y ruido blanco. La correlación por ruido lento del lector, por la
polarización y por la alimentación **no está simulada**: sigue siendo la estimación del informe anterior.

**Retener sin remuestrear frente a remuestrear: no existe.** En estos decks, con el interruptor abierto no actúa ninguna fuente de
ruido y el lector no tiene ruido: la varianza en retención sería cero por construcción. Es un control de silicio.

## 5. Entropía

Variable cuantizada: la **cuenta de un contador** del tiempo de descarga. Reloj **supuesto** de 50 MHz `[?]` (20 ns); nadie lo ha fijado.
σ del tiempo = √((σ_V·G)² + 0,57 %²) × conversión.

| C | σ (cuentas) | Niveles en ±4σ | Shannon | Min-entropía | Con tope de 256 símbolos (SP 800-90B §3.1.3) |
|---|---|---|---|---|---|
| 0,963 fF | 888 | ~7100 | 11,84 bit | 11,12 bit | ≤ 8 |
| 2,956 fF | 87 | ~700 | 8,49 | 7,77 | 7,77 |
| 9,991 fF | 31 | ~250 | 7,02 | 6,29 | 6,29 |

- «6–11 bits» era **min-entropía ideal** de una gaussiana cuantizada (Shannon − 0,72). Los 11 del nodo mínimo vienen de que su
  conversión dura 330 µs, no de más ruido: en bits por segundo gana el nodo de 10 fF (~185 kbit/s ideales frente a ~34).
- Salida de comparador binario: **≤ 1 bit** por muestra, menos si hay sesgo (−log₂ máx(p, 1−p)).
- Correlación: una gaussiana con ρ entre vecinas pierde −½·log₂(1−ρ²): 0,0003 bit (ρ = 0,02), 0,014 (0,14), 0,16 (0,44). Pesa poco
  en la cifra; lo que cambia es la vía (no-IID).
- Es ruido clásico y la cifra supone que todo lo que se mueve es impredecible: una parte (alimentación, deriva) no lo es.

**Qué habría que medir en silicio para una evaluación según SP 800-90B** (nada de esto es una certificación): 1 000 000 de cuentas
crudas consecutivas; 1000 reinicios × 1000 cuentas; pruebas IID sobre ambos y, si fallan, los estimadores no-IID; el mínimo de fila,
columna e inicial; lo mismo en los extremos de temperatura y alimentación; pruebas de salud continuas; y un modelo del ruido que
justifique la estimación (aquí: ley 1/C y control de retención).

## Cuatro estados de XC-58

| Estado | Evidencia |
|---|---|
| **Fenómeno simulado** | Sí, con reservas. Monte Carlo propio y del verificador: 0,90 de kT/C en el nodo mínimo, → 1 al crecer C, sin dependencia del flanco. ngspice: ley 1/C en tres capacidades a ±6 %, pero con un artefacto conocido y sin ruido fuera del equilibrio |
| **Señal detectable** | En simulación: 5,4 % / 3,2 % / 1,75 % de dispersión del tiempo frente a 0,57 % del lector (no resimulado con puerta flotante). Sin silicio |
| **Función posible** | Fuente de azar: 6–8 bits ideales por muestra, sin memoria del nodo. Medidor de capacidad de 1–30 fF. Sensibilidad térmica secundaria |
| **Función demostrada** | Ninguna |

**Termometría.** *Termómetro primario*: **no demostrado**, y en contra: pide C absoluta (±10 % supuesto ≈ ±30 K) y el observable no es
proporcional a T. *Sensibilidad térmica secundaria, calibrada*: **por evaluar**. De las dos capacidades limpias, la dispersión
relativa cambia ×0,907–0,919 en 58 K: **−0,29 a −0,34 %/K en varianza** (−0,15 a −0,17 %/K en eficaz). Resolver 1 K pide ~2·10⁵
conversiones: ~10 s a 10 fF (incluido ×1,27 por restar el piso); 0,1 K, ~16 min. En el nodo mínimo la sensibilidad se invierte hacia
85 °C por la fuga: no sirve ahí.

## Sin hacer

Ruido en ngspice a 85 °C; ruido del lector con puerta flotante; ruido de `pcomp` y `dummy`; un modelo de ruido correcto dentro del
simulador (el actual tiene el artefacto de 2.3); aislar la causa de la ganancia ×0,910 del nodo mínimo a 85 °C; esquinas y desajuste.
`c58_INFORME.md` no se ha editado: sus «0,68 ± 0,04 como cota inferior» y «§3, discrepancia» quedan superados por 2.3 de este archivo.
