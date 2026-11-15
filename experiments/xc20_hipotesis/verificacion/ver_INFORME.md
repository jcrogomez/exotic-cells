# Verificación independiente del motor de hipótesis XC-20 · informe

Verificador independiente (método ataque-verificado). Empezado 2026-11-14 19:49:32 EST (`date`). Leído antes de escribir
mis números: **solo** `../PREREG.md` y las definiciones del encargo. No leí `motor.py`, `motor.log` ni `resultados.txt`
hasta después de escribir la tabla (ver §5, con la hora).

## 1. Método

- Modelo exactamente el del encargo: T, R, G exclusivos (prior 1/3), térmica G en todas; T y R solo en d = 0; lectura
  y = log10 I + N(0, σ) independiente por medida, censurada a «bajo piso» / «saturado». kB = 8,617333262·10⁻⁵ eV/K,
  300,15 K y 358,15 K.
- `ver_xc20.py`: I(M;Y) = H(M) + Σ_m π_m E_{y|m}[log2 p(m|y)].
  - Exterior: Monte Carlo estratificado (N muestras por mecanismo), números aleatorios comunes entre diseños (mismo θ y
    mismo ruido en las medidas compartidas) ⇒ diferencias entre diseños **pareadas**, con su propio error.
  - Interior: p(y|m) integrada por cuasi-Monte Carlo (Sobol aleatorizado, M puntos, 8 dimensiones) sobre los parámetros
    molestos; los factores censurados se evalúan exactos por punto (log Φ) y los legibles con la densidad gaussiana exacta;
    el interior no muestrea ruido. No es Monte Carlo anidado ingenuo en el sentido de que el ruido está integrado
    analíticamente y la convergencia del interior se comprueba (M = 2¹⁴ frente a 2¹⁶, y dos aleatorizaciones).
  - Acierto MAP: proporción de aciertos con empates repartidos (T y R saturados dan posterior idéntico), y además
    E[max_m p(m|y)], que es el acierto esperado del MAP sin ruido de empate.
- `ver_cuadratura_a.py`: control determinista del diseño (a), sin Monte Carlo (cuadratura 1D en el espacio de la
  lectura, con las reducciones y cotas escritas en su cabecera).
- Error: ± es 1 error típico del Monte Carlo exterior. El interior aporta < 2·10⁻⁴ bits (diferencia M = 2¹⁴ frente a
  2¹⁶ y entre aleatorizaciones del Sobol, `ver_conv_N1500_M14.log`, `ver_conv_N1500_M16.log`).

## 2. Mis números (prior 1/3; H(M) = log2 3 = 1,5850 bits)

Corrida principal `ver_run_N6000_M16.log` (N = 6000 por mecanismo, M = 2¹⁶, semilla interior 1). Acierto = MAP con
empates repartidos; entre corchetes E[max p(m|y)].

| Diseño | Lector | σ = 0,05: I (bits) | acierto | σ = 0,5: I (bits) | acierto |
|---|---|---|---|---|---|
| (a) D0 | XC26 | 0,9183 ± 0,0000 | 0,667 ± 0,001 [0,667] | 0,9189 ± 0,0002 | 0,667 [0,667] |
| (a) D0 | ancho | 1,353 ± 0,003 | 0,897 ± 0,002 [0,895] | 1,264 ± 0,005 | 0,884 ± 0,002 [0,887] |
| (b) D0 + 85 °C | ancho | 1,443 ± 0,004 | 0,956 ± 0,002 [0,955] | 1,291 ± 0,004 | 0,884 ± 0,002 [0,887] |
| (c) D0 + −0,9 V | XC26 | 0,956 ± 0,001 | 0,703 ± 0,001 [0,702] | 0,960 ± 0,002 | 0,706 ± 0,001 [0,706] |
| (c) D0 + −0,9 V | ancho | 1,5850 ± 0,0000 | 1,000 [1,000] | 1,457 ± 0,004 | 0,962 ± 0,001 [0,961] |

Las dos aleatorizaciones del Sobol (semillas interiores 1 y 2) dan los mismos valores a 4 decimales.

Ganancia por la medida añadida (diferencias pareadas, mismo exterior, `ver_run_N6000_M16.log`):

| Diferencia | σ = 0,05 | σ = 0,5 |
|---|---|---|
| (b) − (a), ancho: añadir 85 °C | +0,089 ± 0,003 | +0,027 ± 0,003 |
| (c) − (a), ancho: añadir −0,9 V | +0,232 ± 0,003 | +0,193 ± 0,005 |
| (c) − (a), XC26: añadir −0,9 V | +0,038 ± 0,001 | +0,041 ± 0,002 |
| (c) − (b), ancho: −0,9 V frente a 85 °C | +0,142 ± 0,004 | +0,166 ± 0,004 |

Ninguna medida añadida resta información: todas las diferencias (b)−(a) y (c)−(a) son positivas y a ≥ 4 errores típicos
de cero. Única rareza: con XC26, σ = 0,5 da *más* que σ = 0,05 (0,9189 frente a 0,9183 en (a); la cuadratura da 0,91863
frente a 0,91830). No es un error: con ruido grande, un T cercano a 12 nA cae a veces bajo el techo de 1,25 nA y se lee, y
R (≥ 18 µA) no puede hacerlo; P(saturado | T) = 0,99899. Es real pero de 3·10⁻⁴ bits.

Sensibilidad al prior (mismo log; orden T, R, G; H = 1,371 bits en ambos), σ = 0,05 / 0,5:
- (0,2; 0,2; 0,6): (a) XC26 0,971 / 0,971 · (a) ancho 1,232 / 1,178 · (b) 1,286 / 1,194 · (c) XC26 0,994 / 0,996 ·
  (c) ancho 1,371 / 1,294.
- (0,6; 0,2; 0,2): (a) XC26 0,722 / 0,722 · (a) ancho 1,140 / 1,039 · (b) 1,227 / 1,073 · (c) XC26 0,750 / 0,753 ·
  (c) ancho 1,371 / 1,238.
El orden de los diseños no cambia con el prior.

## 3. Controles

- **Límite analítico, (a) XC26.** T ≥ 12 nA y R ≥ 1,8 V/100 kΩ = 18 µA están por encima del techo de 1,25 nA; G ≤ 2 pA no
  lo alcanza. G queda separado y T/R son indistinguibles: I = log2 3 − 2/3 = 0,91830 bits, acierto 2/3. El MC da 0,9183.
- **Cuadratura determinista, (a)** (`ver_cuadratura_a.py`, `ver_cuadratura_a.log`): XC26 0,91830 / 0,91863 bits
  (σ = 0,05 / 0,5); ancho 1,35338 / 1,26918 bits, acierto 0,8949 / 0,8862. El MC: 1,353 ± 0,003 / 1,264 ± 0,005. Coinciden
  dentro de 1 error típico.
- **Límite σ → 0, (a) ancho, a mano.** En décadas: T ∈ [−7,92; −3,30], V/R ∈ [−4,74; −0,74], techo −3. Solo hay confusión
  en el solape [−4,74; −3,30], donde la densidad de R (1/4 por década) gana a la de T (1/4,62): H(M|Y) = 0,224 · 0,996 =
  0,223 ⇒ I = 1,362 bits, acierto (1 + 0,688 + 1)/3 = 0,896. Con σ = 0,05 baja a 1,353 (los bordes se emborronan).
- **(c) ancho, σ = 0,05 = log2 3 exacto, deducible sin correr:** forma de T en décadas [1,18; 1,76] frente a 0,30 de R; la
  diferencia de dos lecturas tiene σ√2 = 0,07 y el hueco es 0,87 décadas (12 σ). G está bajo piso. Separación perfecta.
- **Convergencia del interior:** M = 2¹⁴ y M = 2¹⁶ dan lo mismo a < 2·10⁻⁴ bits en las diez configuraciones, y dos
  aleatorizaciones del Sobol también (`ver_conv_*.log`). La corrida M = 2¹⁸ la paré (redundante; su log quedó vacío).

## 4. Fallos de modelado o de razonamiento en el PREREG

Contraste de las predicciones del PREREG con mis números:

| # | Predicción | Mis números | Veredicto |
|---|---|---|---|
| 1 | XC26 D0 ≤ 0,95 bits; −0,9 V suma < 0,1 | 0,918; +0,039 (σ 0,05), +0,042 (σ 0,5) | se cumple (85 °C con XC26 no lo calculé) |
| 2 | ancho D0 entre 1,0 y 1,4; confusión T–R en 18 µA–0,5 mA | 1,353 / 1,264; confusión exactamente en ese solape | se cumple |
| 3 | −0,9 V suma ≥ 0,2 bits más que 85 °C | (c)−(b) = +0,142 ± 0,004 (σ 0,05), +0,166 ± 0,004 (σ 0,5) | **falla** como está escrita (la dirección sí) |
| 3b | con σ = 0,05, 85 °C «sí separa» T de R | +0,089 de los 0,232 bits que faltan; acierto 0,897 → 0,956 | a medias |
| 5 | σ = 0,5 pierde ≥ 0,3 bits en todos los diseños | XC26: −0,0006 y −0,004 (gana); ancho: 0,09, 0,15, 0,13 | **falla** en todos |

Fallos o supuestos que deciden el resultado:

1. **Las predicciones 1 y la de (c)-ancho son tautologías de los intervalos, no hallazgos.** Con R ∈ [10 Ω; 100 kΩ] y
   T ≥ 12 nA, todo T y todo R satura el lector de XC26 a −1,8 V: T/R es inseparable por construcción y 0,918 bits sale sin
   correr. Igual, (c) con lector ancho y σ = 0,05 da log2 3 porque los intervalos de forma (15–57 frente a 2 exacto) no se
   tocan. El motor no «descubre» estas separaciones: las hereda de los priors. Lo que de verdad decide es la anchura del
   intervalo de R y que la forma de R sea exactamente 2 (un puente de siliciuro en serie con la unión, o un R no lineal, no
   la tendría).
2. **Error «de calibración» modelado como independiente por medida.** El PREREG llama al σ error de calibración; un error de
   calibración (ganancia u offset del lector) es común a las medidas del mismo canal y se **cancela en los cocientes**
   (85/27 °C, −1,8/−0,9 V). Con ese modelo, los cocientes de T (+0,027 a +0,092 décadas a 85 °C) y R (−0,090 a −0,048) no se
   solapan y 85 °C separaría T de R casi siempre incluso con σ = 0,5, lo contrario de la predicción 3. Con σ independiente
   (lo que se pidió medir), el cociente lleva σ√2 y la separación es parcial. La conclusión «sin calibración solo sirve la
   segunda tensión» depende de este supuesto, que no está marcado como tal. (Esto es razonamiento sobre el modelo; no lo
   corrí.)
3. **T en d = 0,27 modelado como 0, cuando el PREREG dice «≥ 7·10³ menos».** Con t0 hasta 0,5 mA, el resto en d = 0,27 puede
   llegar a 71 nA: sobre el piso del lector ancho (t0 > 7 µA) y sobre el techo de XC26 (t0 > 8,75 µA). Bajo R el canal
   d = 0,27 es solo térmica. Ese canal sería una firma de T que el modelo tira; con el supuesto actual se subestima lo que
   d = 0,27 aporta a la separación T/R. «≥» es una cota inferior de la supresión, no un cero.
4. **La térmica en el lector ancho no aporta nada a 27 °C** (g ≤ 2 pA frente a 1 nA de piso): en (a) y (c) ancho, d = 0,27
   es una medida muerta. A 85 °C sí sale del piso (g·e^(Ea·K) llega a 2,2 nA), pero su distribución es la misma bajo los
   tres mecanismos; solo informa sobre el molesto g. G se separa de T/R por d = 0, no por d = 0,27; el papel de d = 0,27 como
   discriminador que da el plan no se ve en este modelo (porque T se fija a 0 allí, punto 3, y R también).
5. **El «qué mata el enfoque» no se puede evaluar con estos tres diseños:** el plan es «D0 con temperatura después», y con
   el lector de XC26 tal cual T/R es inseparable a −1,8 V salga lo que salga; el cambio que más aporta es el lector, no la
   medida extra. Con lector ancho, la segunda tensión gana a 85 °C por 0,14–0,17 bits (≫ error de 0,004), así que el
   orden sí distingue diseños; pero se apoya en los supuestos de los puntos 1 y 2.
6. Menor: el prior de sensibilidad (0,2; 0,2; 0,6) no dice qué mecanismo lleva 0,6; usé el orden de la tabla (T, R, G).

## 5. Comparación con el autor

Qué leí y cuándo: tabla de §2 completa a las 20:15:49 EST; a las **20:16:12 EST** (`date`) abrí `resultados.txt`
(existe, mtime 20:13) y `motor.py`. No leí `motor.log`, `sensibilidad.py` ni `sensibilidad.txt` (aparecieron mientras
trabajaba, 20:14–20:16).

Prior uniforme (autor: 1000 lecturas por mecanismo, 40 000 chips internos, una semilla común a todos los diseños):

| Diseño | Lector | σ | Autor | Yo | Diferencia / error combinado |
|---|---|---|---|---|---|
| (a) | XC26 | 0,05 | 0,918 ± 0,000 · 0,667 | 0,9183 · 0,667 | coincide (y = límite analítico) |
| (a) | ancho | 0,05 | 1,362 ± 0,007 · 0,897 | 1,353 ± 0,003 · 0,897 (cuadratura 1,3534) | +0,009; 1,2 σ |
| (b) | ancho | 0,05 | 1,443 ± 0,009 · 0,958 | 1,443 ± 0,004 · 0,956 | coincide |
| (c) | XC26 | 0,05 | 0,956 ± 0,004 · 0,703 | 0,956 ± 0,001 · 0,703 | coincide |
| (c) | ancho | 0,05 | 1,585 · 1,000 | 1,5850 · 1,000 | coincide (exacto) |
| (a) | XC26 | 0,5 | 0,918 · 0,667 | 0,9189 · 0,667 | coincide |
| (a) | ancho | 0,5 | 1,280 ± 0,010 · 0,891 | 1,264 ± 0,005 · 0,884 (cuadratura 1,2692) | +0,011 sobre la cuadratura; 1,1 σ |
| (b) | ancho | 0,5 | 1,303 ± 0,009 · 0,888 | 1,291 ± 0,004 · 0,884 | +0,012; 1,2 σ |
| (c) | XC26 | 0,5 | 0,958 ± 0,004 · 0,704 | 0,960 ± 0,002 · 0,706 | coincide |
| (c) | ancho | 0,5 | 1,468 ± 0,008 · 0,962 | 1,457 ± 0,004 · 0,962 | +0,011; 1,2 σ |

Priors de sensibilidad: coinciden todos dentro de 1–2 errores (p. ej. (0,2; 0,2; 0,6), σ 0,05: (a) ancho 1,237 frente a
1,232; (b) 1,286 frente a 1,286; (0,6; 0,2; 0,2), σ 0,05: (a) ancho 1,151 frente a 1,140, (b) 1,226 frente a 1,227). El
autor también usó el orden T, R, G para los priors.

**Ninguna discrepancia significativa.** Las cuatro casillas ancho con σ = 0,5 (y (a) con σ = 0,05) del autor salen
0,009–0,016 bits por encima de las mías, todas ~1,2 σ y del mismo signo. El mismo signo no es independiente: el autor usa la
misma semilla exterior en todos los diseños, así que sus errores están correlacionados entre filas; además el Monte Carlo
anidado con 40 000 internos tiene sesgo positivo pequeño. No cambia ninguna conclusión ni ningún orden.

Observaciones sobre `motor.py` (leído después):
- Bajo T y R el autor no marginaliza la térmica: toma como conocida la lectura de d = 0,27 (con su ruido) y la suma a la
  corriente de d = 0, con forma térmica fija 1,2 a −0,9 V en vez de integrar 1,0–1,4. Es un estimador de enchufe, no el
  modelo bayesiano completo. A 27 °C es inocuo (g ≤ 2 pA frente a T ≥ 12 nA); a 85 °C con lector ancho g·e^(Ea·K) llega a
  2,2 nA frente a ~13 nA de T mínimo, pero mi integración completa da el mismo (b) (1,443 los dos), así que no pesa.
- Las matrices de confusión de XC26 son artefacto de empate: con σ = 0,05, T y R tienen verosimilitud idéntica (ambos
  saturan) y `np.argmax` elige el primero (T), por eso «R→ 1,00/0,00/0,00»; con σ = 0,5, P(saturado | T) = 0,999 < 1 y
  pasa a elegir R siempre. El acierto (0,667) es correcto; las filas T→/R→ de XC26 no dicen nada físico.
- El autor implementa T = 0 en d = 0,27 (`fr = 0`), igual que el encargo: el punto 3 de §4 le aplica igual.
