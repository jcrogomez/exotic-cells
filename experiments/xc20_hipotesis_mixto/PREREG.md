# Motor de hipótesis de XC-20, ronda 2: mecanismos que coexisten y un instrumento realizable · prerregistro

Escrito el **2026-11-15 17:03:37 EST** (`date`), antes de escribir el código y de correr nada. Encargo: punto 4 de la revisión
externa del 2026-11-15, aprobado por Juan el mismo día: túnel y conducción óhmica a la vez, resistencia no lineal, impedancia y
límite de corriente del excitador, calibración correlacionada entre medidas; contrastar con el modelo anterior y decir si cambia
la decisión experimental y bajo qué supuestos. Verificador independiente; los negativos se conservan.

Ronda 1: [`../xc20_hipotesis/`](../xc20_hipotesis/INFORME.md). Su motor (`motor.py`) y sus resultados no se tocan.

## Decisiones que se juzgan

Las tres que propuso la ronda 1 para XC-20, más la del lector:
- **D1. Segunda tensión antes que segunda temperatura.** Se juzga con Δ = I(D0 + −0,9 V) − I(D0 + 85 °C).
  - **Se mantiene** si Δ > 2 σΔ.
  - **Empate** si |Δ| ≤ 2 σΔ.
  - **Se invierte** si Δ < −2 σΔ.
  - σΔ es el error de Monte Carlo combinado de las dos estimaciones.
- **D2. El peine puede esperar.** Se mantiene si I(D0 + peine) − I(D0) < 0,05 bits.
- **D3. Hace falta un lector de rango ancho.** Se mantiene si I_ancho(D0 + −0,9 V) − I_XC26(D0 + −0,9 V) > 2 σ.
- **D4 (nueva). ¿Hay túnel o no?** Es la pregunta física de XC-20. Se informa I(túnel; Y) y el acierto, con túnel = {T, M} frente
  a sin túnel = {R, G}. No tiene umbral de decisión: se informa.

## Modelo (todo **supuesto** salvo lo marcado; intervalos de la ronda 1 donde no se dice otra cosa)

Corriente inversa de la estructura a tensión V sobre el dispositivo y temperatura t, por mecanismo:

| | Mecanismo | I(V) a 27 °C, por 1,4 µm de frontera | 85 °C | En d = 0,27 | Peine |
|---|---|---|---|---|---|
| T | Túnel | t0·(V/1,8)^a, con a = log2(tsh); t0 log-U 12 nA–0,5 mA; tsh log-U 15–57 (ronda 1) | × exp(tea/kB·(1/300,15 − 1/358,15)), tea U 0,010–0,034 eV | t0/K, K log-U 7·10³–10⁶ (b20 §5 da ≥ 7·10³; el techo es **supuesto**; la ronda 1 ponía 0) | ×4 |
| R | Puente | (1,8/Rb)·sinh(V/V0)/sinh(1,8/V0). Con probabilidad 1/2 es óhmico (V0 = ∞, I = V/Rb); si no, V0 log-U 0,3–2 V, de modo que la forma va de 2 a ~20 (**supuesto**: puente parcial o contacto con barrera). Rb log-U 10 Ω–100 kΩ (ronda 1) | ÷ (1 + tcr·58), tcr U 0,002–0,004 /K (ronda 1; el mismo para el no lineal, **supuesto** sin fuente) | 0 | ×4 |
| M | Túnel y puente a la vez | I_T + I_R, cada uno con sus parámetros sacados de su propio prior | cada parte la suya | t0/K | ×4 |
| G | Unión ordinaria | g0·(V/1,8)^b, con b = log2(gsh); g0 log-U 3·10⁻¹⁸–2·10⁻¹² A; gsh U 1,0–1,4 (ronda 1) | × exp(gea/kB·(…)), gea U 0,56–1,12 eV | igual que en d = 0 (escala con el área) | igual |

- **Fondo térmico.** Todas las hipótesis llevan la componente G sumada (como en la ronda 1).
- **Excitador.** La tensión aplicada Vap (1,8 o 0,9 V) llega al dispositivo a través de una resistencia serie Rs, log-U 100 Ω–5 kΩ.
  - La tensión V del dispositivo resuelve V + Rs·I(V) = Vap.
  - La corriente se limita a Imax, log-U 0,1–4 mA.
  - Las dos cosas son **supuesto**: no se ha leído el límite de los pines analógicos de TT `[?]`. Ninguna está en la ronda 1.
  - Rs e Imax son parámetros molestos del montaje, con un valor por chip, comunes a todas sus medidas.
- **Lectores.**
  - «ancho»: piso 1 nA, techo 1 mA (ronda 1).
  - «XC26»: piso 150 fA a 27 °C y 0,1 pA a 85 °C; techo 1,25 nA (ronda 1, **cálculo**).
  - La lectura es y = log10 I + g + ε. Se censura con el piso y el techo nominales: por debajo, «bajo piso»; por encima,
    «saturado».
- **Calibración.**
  - **C0:** solo ε, independiente por lectura, con σ = 0,05 o 0,5 décadas. Es el modelo de la ronda 1.
  - **C1:** g común a todas las lecturas del chip (un solo lector multiplexado), con σg = 0,5 décadas; más ε independiente con
    σe = 0,02 décadas (repetibilidad, **supuesto**).
  - **C2:** C1 más una deriva δ común a las lecturas a 85 °C (la ganancia del lector cambia con la temperatura), con σδ = 0,03
    décadas (**supuesto**).
- **Diseños.** Los cinco de la ronda 1:
  - D0: base y d = 0,27, a −1,8 V y 27 °C.
  - D0 + 85 °C: añade base y d = 0,27 a 85 °C.
  - D0 + −0,9 V: añade base a −0,9 V.
  - D0 + peine.
  - D0 + 85 °C + −0,9 V.
- **Priors.** Uniformes sobre los mecanismos del modelo: 3 sin M, 4 con M.

**Variantes**, para aislar cada cambio:

| | Mecanismos | R | Excitador | Calibración | Lector |
|---|---|---|---|---|---|
| V0 | T, R, G | óhmico | ideal | C0 (0,05 y 0,5) | ancho |
| V1 | T, R, M, G | óhmico | ideal | C0 0,05; C1 | ancho |
| V2 | T, R, G | óhmico o no lineal | ideal | C0 0,05; C1 | ancho |
| V3 | T, R, G | óhmico | Rs e Imax | C0 0,05; C1 | ancho |
| V4 | T, R, M, G | óhmico o no lineal; Rb hasta 10 MΩ | Rs e Imax | C0 (0,05 y 0,5); C1; C2 | ancho y XC26 |

V0 es la ronda 1 con su ajuste de una diferencia: el túnel en d = 0,27 deja de ser 0. Por eso V0 con K → ∞ debe reproducir
`../xc20_hipotesis/resultados.txt`.

## Medida

- **I(M; Y)** en bits, por Monte Carlo anidado: lecturas simuladas por mecanismo y verosimilitud por promedio sobre chips internos.
  - g y δ se integran por cuadratura de Gauss-Hermite.
  - El fondo térmico se integra junto con lo demás, sin la resta de la ronda 1.
  - Máximo log2 3 = 1,585 o log2 4 = 2.
- **I(túnel; Y)**, con máximo 1 bit, y el acierto del máximo a posteriori de las dos preguntas.
- **Errores:** el de Monte Carlo (error estándar sobre las lecturas externas). El sesgo del anidado se acota corriendo una vez con 4
  veces más chips internos los casos con lecturas más finas (C1 y C2).

## Predicciones (antes de correr)

0. **V0 con K = ∞** reproduce las casillas de la ronda 1 con el lector ancho (σ 0,05 y 0,5) dentro de 3 errores estándar más
   0,02 bits. Si no, el código nuevo está mal y nada de lo demás cuenta.
1. **V1 (coexistencia), C0 0,05.**
   - D0 + −0,9 V da entre 1,5 y 1,85 bits (de 2).
   - I(túnel; Y) ≥ 0,75 bits.
   - La confusión nueva es M con puente dominante leído como R, y M con túnel dominante leído como T.
   - D1 se mantiene.
2. **V2 (R no lineal), C0 0,05.**
   - D0 + −0,9 V baja al menos 0,05 bits frente a V0 (1,585): las formas 2–20 del puente pisan las 15–57 del túnel.
   - D1 se mantiene.
3. **V3 (excitador).** El cambio en D0 + −0,9 V frente a V0 es ≤ 0,1 bits: el excitador solo linealiza el túnel en su décima
   superior de rango (t0 ≳ 0,1 mA).
4. **C1 (ganancia común), en V1–V4.**
   - 85 °C recupera valor: D0 + 85 °C suma ≥ 0,15 bits sobre D0, frente a +0,02 de la ronda 1 con σ 0,5.
   - |Δ| < 0,1 bits: empate o D1 se mantiene, pero no se invierte.
5. **C2 (deriva con la temperatura).** D0 + 85 °C pierde ≥ 0,03 bits frente a C1; D0 + −0,9 V no cambia (≤ 0,01).
6. **V4 completo, todas las calibraciones.**
   - D1 no se invierte en ninguna.
   - D3 se mantiene en todas.
   - D2 se mantiene: el peine suma < 0,05 bits.
7. **V4 con el lector de XC-26.**
   - Todos los diseños entre 0,81 y 1,0 bits. 0,811 = 2 − ¾·log2 3: G se separa, y T, R y M no se distinguen.
   - I(túnel; Y) ≤ 0,3 bits.

## Qué mata cada cosa

- **Muere la decisión D1** si se invierte en alguna variante de V4. Se escribe así, con la variante.
- **Muere el motor como herramienta** si V4 da el mismo orden y las mismas decisiones que V0 en todas las calibraciones, y lo que
  cambia (el tamaño) se pudo prever de los intervalos. Sería la segunda vez que el motor no aporta una decisión que no se dedujera
  a mano. Se escribe así, y la recomendación pasa a ser no seguir construyéndolo.
- **Vive el motor** si alguna decisión cambia, o pasa de mantenerse a empate, por un efecto que no se deduce de la tabla de
  intervalos (p. ej., que la ganancia común convierta la temperatura en la mejor medida, o que el excitador vuelva ambigua la
  forma).

## Verificación

Un verificador independiente escribe su propio código a partir de **este** prerregistro, sin leer el código del autor hasta
fijar sus números. Usa otra familia de estimador (no Monte Carlo anidado) y reproduce, como mínimo:
- V0 0,05: los cinco diseños.
- V4 en C0 0,05 y C1, con los cinco diseños.
- D1 y D4 en V4 C1.

## Fuera de esta ronda

- El túnel asistido por trampas como quinto mecanismo.
- La dispersión entre dados y la desalineación.
- El coste en área.
- Un lector concreto dibujado.
