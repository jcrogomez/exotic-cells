# Motor de hipótesis de XC-20, ronda 3: la supresión K, la fuga convencional y la arquitectura del lector · prerregistro

Escrito el **2026-11-15 19:05:04 EST** (`date`), antes de escribir el código y de correr nada. Estado: **congelado** al
commitear; cambios después, solo en «Enmiendas», con hora.

Encargo: revisión externa del 2026-11-15 «XC-20: la ronda 2 cambió una decisión importante…», aprobada por Juan.
- La prioridad es la supresión K: separaciones legales 0,27; 0,54 y 1,08 µm y la celda sin unión (PLAN §5.2). Hay que estimar o
  acotar K y distinguir el túnel residual de la fuga convencional.
- Calibración parcialmente compartida: un error común g_c más errores propios de cada lector, g_s (sensible) y g_a (ancho).
- Comparar dos front-ends con una arquitectura de rangos seleccionables.
- No presentar el lector mixto como validado para K arbitrariamente grande.
- Conservar la comparación con la ronda 2 y la verificación independiente. Conservar la exploración abierta.

Ronda 1: [`../xc20_hipotesis/`](../xc20_hipotesis/INFORME.md). Ronda 2: [`../xc20_hipotesis_mixto/`](../xc20_hipotesis_mixto/INFORME.md).
Su código y sus resultados no se tocan.

## 1. Explicaciones aburridas, cada una con su chequeo

| Lo que podría fabricar un resultado | Chequeo |
|---|---|
| El estimador anidado se rompe con muchas lecturas finas: ya pasó en la ronda 2 con 5 lecturas (§2 de su informe), y aquí hay hasta 11 | Estimador nuevo (§5), corrida con 4× chips internos (cambio ≤ 0,02 bits), monotonía (añadir una lectura no baja I más de 2σ + 0,005) y el verificador. Una fila que falle cualquiera de las tres es **inválida** y no se usa |
| Código nuevo mal | Reducción a la ronda 2 (W0, §4): debe dar los números del verificador de la ronda 2 dentro de 0,03 bits |
| La ventaja de las separaciones la pone el prior de la ley de caída q, no los datos | Se informa por separado con q = 1 fijo (exponencial) y con q libre (§3) |
| La ventaja de los rangos seleccionables es de construcción (más rango, menos error) | Está deducido en §6, P7. Lo único que se informa como resultado es el tamaño y el punto de empate en f y σ_s |
| El fondo del lector y del pozo (B) se confunde con la fuga de la unión | Mecanismo B en todas las hipótesis, y diseños con y sin la celda sin unión |
| Una fuga convencional que también baja con d (campo del n+ cerca) imita al túnel residual | Mecanismo F (§3), que baja con d de forma suave y está activado térmicamente |
| «K estimado» por una definición complaciente | §5 fija la definición antes de correr |
| Omitir corridas obligatorias (pasó en la ronda 2: V4 XC26 C0 0,5 y C2) | La lista de §4 es exhaustiva. El script la recorre de un archivo y el informe dice cuáles faltan |

## 2. Preguntas, decisiones e hipótesis

Efecto mínimo de interés en todas las decisiones: **0,05 bits y más de 2σ** (σ, error de Monte Carlo pareado). La ronda 2 usó solo
2σ y el verificador pidió un umbral de tamaño: este es. Debajo de 0,05 bits no cambia qué se dibuja.

- **D5. ¿Se dibujan 0,54 y 1,08 µm?** Sí, si alguno de estos sube ≥ 0,05 bits en el diseño con 85 °C y la celda sin unión
  (E2 → E4), con la calibración C3b y con un front-end en A2 o S10:
  - I(túnel; Y);
  - I(Kbin; Y | túnel);
  - I(F frente a túnel residual; Y).
  - Nula: nada sube 0,05. Se dibujan entonces solo d = 0, 0,27 y la celda sin unión.
- **D6. ¿Hace falta la celda sin unión?** Sí, si E1 → E2 sube I(M; Y) o I(Kbin; Y | túnel) ≥ 0,05 bits.
- **D7. ¿Dos front-ends o rangos seleccionables?** El motor no decide: da el precio. Se informa:
  - la diferencia S_f − A2 para f = 1, 10, 100;
  - el f de empate (diferencia < 0,05);
  - el σ_s de empate.
  - La decisión depende del circuito: fuga de los interruptores y área `[?]`.
- **D8. ¿Sobrevive el lector mixto?** Sobrevive si, con la calibración parcialmente compartida (C3b) y K hasta 10¹², A2 supera al
  mejor lector único (X o A) en ≥ 0,05 bits en E1 y en E4. Si solo sobrevive con K ≤ 10⁶, se escribe así.
- **Pregunta física, sin umbral:** con lo que se puede dibujar, ¿qué fracción de los chips con túnel permite **estimar** K, y cuál
  solo **acotarla** (§5)?

## 3. Modelo

Todo es **supuesto** salvo lo marcado. Lo que no se dice es como V4 de la ronda 2 (su PREREG, tabla del modelo).

| | Mecanismo | En d = 0 (base y peine) | En d > 0 | 85 °C |
|---|---|---|---|---|
| T | Túnel | Ronda 2 | I_T(d) = t0·K^(−(d/0,27)^q). K log-U 7·10³–10¹² (la ronda 2 tenía 10⁶ en el principal y 10⁹ y 10¹² en sensibilidad). q U 0,5–1,5: q = 1 es caída exponencial con d, q < 1 una cola más lenta (camino residual) | Ronda 2 |
| R | Puente | Ronda 2 (óhmico o no lineal; Rb hasta 10 MΩ) | 0 | Ronda 2 |
| M | T y R | Ronda 2 | Como T | Ronda 2 |
| G | Unión ordinaria, de área | Ronda 2 | Igual que en d = 0 (no depende de d) | Ronda 2 |
| F | **Nuevo.** Fuga convencional reforzada por el campo del n+ cercano: es una alternativa sin túnel | G + f0 | G + f0·exp(−d/λF), con f0 log-U 10⁻¹⁵–10⁻¹¹ A, λF U 0,2–1 µm, forma en V como G | × exp(fea/kB·(…)), fea U 0,3–0,7 eV: activada, a diferencia del túnel (0,010–0,034 eV) |

- **Fondo B**, en todas las hipótesis y en todas las lecturas, incluida la celda sin unión, que lee solo B.
  - B log-U 10⁻¹⁶–10⁻¹² A a 27 °C, ×U(1, 50) a 85 °C. Es la fuga del pozo, de los pads y del lector que entra por el nodo
    (PLAN §4: se lee por el lado p+).
- **Fondo térmico G**: sumado en T, R, M y F, como en las rondas 1 y 2.
- **Excitador**: Rs e Imax como en V4.
- **Priors**: uniformes sobre los mecanismos del modelo. Con T, R, M, G y F el máximo es log2 5 = 2,32 bits.

**Variantes del modelo:**
- **W0**: reducción a la ronda 2. Sin F, B = 0, q = 1, K ≤ 10⁶. Debe dar la ronda 2.
- **W1**: completo.
- **W1q1**: W1 con q = 1 fijo.
- **W1K6**: W1 con K ≤ 10⁶.

**Lectores:** piso y techo de la ronda 2; censura sobre la lectura.
- **X**: solo XC26.
- **A**: solo el ancho.
- **A2**: dos front-ends. El ancho lee d = 0 (base y peine); XC26 lee d ≥ 0,27 y la celda sin unión. Es el «mixto» de la ronda 2.
- **S_f**: un front-end con rangos seleccionables. El rango se elige por lectura y cubre de f·150 fA (f·0,1 pA a 85 °C) a 1 mA.
  - f = 1, 10 o 100 representa la fuga de los interruptores de rango, **supuesto**.

**Calibración:** y = log10 I + (errores de ganancia) + ε, con ε de σe = 0,02 décadas.
- **C1**: la de la ronda 2, g común con σg = 0,5.
- **C3**: g_c común, σc = 0,5, más g_s en las lecturas del lector sensible y g_a en las del ancho, independientes.
  - C3a: σs = σa = 0,05.
  - C3b: σs = σa = 0,2.
  - C3c: σs = σa = 0,5.
  - En X y A solo hay un lector, y C3 se reduce a un g de σ = √(σc² + σ²).
- **S_f** lleva g_c más un error por rango, σr = 0,05, independiente entre los rangos usados, **supuesto**.

## 4. Diseños y corridas (lista exhaustiva)

Lecturas, todas a 1,8 V salvo `base 0,9`:

| | Lecturas | N |
|---|---|---|
| E1 | base, d027, base 85, d027 85, base 0,9 (el mejor de la ronda 2, D0+85C−0,9V) | 5 |
| E2 | E1 + sin unión a 27 y 85 °C | 7 |
| E3 | E2 + d054 | 8 |
| E4 | E2 + d054 + d108 | 9 |
| E5 | E4 + d054 85 + d108 85 | 11 |
| E6 | base, d027, d054, d108, sin unión, todo a 27 °C: sin temperatura ni segunda tensión | 5 |
| E6c | base, d027, sin unión, a 27 °C: control de E6 sin las separaciones nuevas (P4) | 3 |

Corridas:
1. **Reducción:** W0 × C1 × {A, X, A2} × E1. Contra el verificador de la ronda 2, V4 C1, D0+85C−0,9V.
   - Valores del verificador (`ver2_INFORME.md`): ancho 1,4876; XC26 1,3938; mixto 1,7707.
   - Mi propia fila mixta de la ronda 2 era inválida (1,584 ± 0,085).
2. **Principal:** W1 × C3b × {X, A, A2, S1, S10, S100} × E1–E6 y E6c. Son 42 filas.
3. **Calibración:** W1 × {C1, C3a, C3c} × {A2, S10} × {E1, E2, E4}. Son 18 filas.
4. **Ley de caída:** W1q1 × C3b × {A2, S10} × {E2, E4, E6}. Son 6 filas.
5. **K ≤ 10⁶:** W1K6 × C3b × {X, A, A2, S10} × {E1, E4}. Son 8 filas.

Cada fila informa:
- I(M; Y);
- I(túnel; Y), con túnel = {T, M};
- I(Kbin; Y | túnel);
- I(F frente a túnel residual; Y), con las mismas lecturas restringidas a la verdad en {T, M, F};
- la fracción de K estimada y la de K acotada (§5);
- el acierto del MAP;
- la matriz de confusión.

## 5. Medida y estimador

- **I(Kbin; Y | túnel)**: log10 K en bins de 1 década, sobre las lecturas cuyo mecanismo verdadero es T o M. El posterior de K sale
  de los pesos de los chips internos de T y M. Se normaliza por H(Kbin), el número de bins del prior.
- **Clases de K por chip** (verdad T o M), a partir del intervalo creíble del 90 % de log10 K:
  - **estimada**: el intervalo mide ≤ 2 décadas y no toca ningún borde del prior;
  - **acotada**: el intervalo toca un borde y excluye ≥ 2 décadas del otro lado;
  - **nada**: lo demás.
- **Estimador del autor.** Monte Carlo anidado con muestreo de importancia en los chips internos.
  - La propuesta mezcla 50/50 el prior y una normal en log-parámetros de 0,3 décadas centrada en los parámetros compartidos del
    chip que generó la lectura (los demás, del prior).
  - Los pesos son exactos: el estimador de p(y | m) sigue siendo insesgado para cada y.
  - Latentes de calibración: integración gaussiana analítica (ronda 2), extendida a C3 (matriz de cargas con g_c, g_s, g_a).
  - Tamaños por defecto: 600 lecturas por mecanismo, 40 000 chips internos.
- **Validez de cada fila** (si falla, la fila es inválida):
  - con 4× chips internos cambia ≤ 0,02 bits en I(M; Y);
  - monotonía E1 ⊂ E2 ⊂ E3 ⊂ E4 ⊂ E5, con tolerancia 2σ + 0,005;
  - la reducción del punto 1 de §4.
- **Pruebas del estimador antes de correr la lista:**
  - **mutante** de normalización de G (prueba E de la ronda 1, adaptada): debe fallar;
  - **mutante** que en la verosimilitud lee d027 con el lector ancho y en la simulación con XC26: I debe cambiar más de 4σ.
- **Testigos (witness fixtures)**, cada uno con su caso en el que el fenómeno sí ocurre:
  - **K**: chips T con t0 = 10 µA, K = 10⁷ y q = 1, leídos con A2 en E2 (túnel en d027 = 1 pA, dentro de XC26). La clase debe ser
    «estimada» y el intervalo debe contener 10⁷. Mutante: quitar d027 de la verosimilitud. La clase debe pasar a «nada» o
    «acotada».
  - **B**: chips G con B = 5·10⁻¹³ y g0 = 10⁻¹⁵. Sin la celda sin unión el posterior de g0 debe estar sesgado más de 1 década;
    con ella, no.
  - **F**: chip F con f0 = 10⁻¹², λF = 0,5 µm, en E6. Debe leerse F, no T, con probabilidad posterior > 0,8.

## 6. Predicciones, escritas antes de correr

Lo que ya se deduce de los priors sin el motor (cuenta a mano, log-uniformes; no cuenta B, G ni la calibración):

- **P1.** Con q = 1, el túnel en d = 0,54 es t0/K².
  - Supera 1 pA solo en ~0,7 % de los chips con túnel; en d = 1,08 (t0/K⁴ < 2·10⁻¹⁹ A) nunca.
  - **Predicción:** en W1q1, E2 → E4 sube I(túnel; Y) e I(Kbin; Y | túnel) < 0,05 bits cada una.
  - Cualquier información de túnel en 0,54 y 1,08 bajo W1 viene de la cola q < 1 del prior: con q = 0,5, ~10 % de los chips
    pasan 1 pA en 0,54.
- **P2.** Ventana de XC26 en d027 (1 pA a 1,25 nA) con K hasta 10¹²: ~27 % de los chips con túnel caen dentro, ~4 % saturan y
  ~69 % quedan por debajo de 1 pA (cuenta comprobada con 10⁶ muestras de los priors; ver Enmiendas).
  - **Predicción:** con A2 en E2, fracción «estimada» entre 0,12 y 0,35. «Acotada» (solo K mínima) ≥ 0,4.
- **P3.** Con K ≤ 10⁶, el ~16 % de los chips con túnel **saturan** XC26 en d027.
  - **Predicción:** en W1K6, S10 − A2 en I(Kbin; Y | túnel) ≥ 0,05 bits. El buen resultado del mixto en la ronda 2 no venía de
    estimar K.
- **P4.** F frente a túnel residual: F cae con d por un factor 0,26–0,76 entre 0,27 y 0,54; el túnel con q = 1, por ≤ 1,4·10⁻⁴.
  F está activada (0,3–0,7 eV) y el túnel no.
  - **Predicción:** con 85 °C en el diseño, añadir 0,54 sube I(F frente a túnel residual) < 0,05 (E2 → E3).
  - Sin temperatura (E6 frente a su versión sin 0,54 y 1,08, que se corre como control: base, d027, sin unión), sube ≥ 0,1 bits.
- **P5.** D6: E1 → E2 sube I(M; Y) ≥ 0,05 bits. Con B hasta 10⁻¹² y G desde 3·10⁻¹⁸, sin la celda sin unión G y F quedan tapados
  por B en una parte del prior.
- **P6.** D8 sobrevive con C3b y K hasta 10¹² en E1 (A2 − mejor único ≥ 0,05), pero menos que en la ronda 2. En la ronda 2 el
  verificador dio mixto 1,77 frente al ancho en V4 C1; esa diferencia baja con g_s, g_a independientes porque el cociente entre
  lecturas de lectores distintos deja de estar calibrado.
- **P7 (de construcción).** Con f = 1, S1 ≥ A2: misma o más cobertura y error por rango (0,05) menor que σs (0,2). Solo se informa
  el tamaño.
  - **Predicción de tamaño:** S1 − A2 en I(M; Y) ≤ 0,1 bits en E4.
  - Empate (< 0,05) en f = 100.
- **D5, predicción global:** D5 se mantiene solo por I(Kbin; Y | túnel) bajo q libre, o por F sin temperatura. Bajo q = 1 con 85 °C,
  muere.

## 7. Criterios

- **Muere D5** (no se dibujan 0,54 y 1,08) si en E2 → E4, con C3b, en A2 y S10, ninguna de las tres cantidades de D5 sube ≥ 0,05.
  Se escribe así: «el chip solo acota K».
- **Muere la pregunta K con estas estructuras** si la fracción «estimada» es < 0,1 en todos los diseños con K hasta 10¹². Es un
  resultado negativo publicable, y se escribe así.
- **Muere el motor como herramienta** si todas las predicciones P1–P7 se cumplen en signo y sus tamaños quedan dentro de 0,05 bits
  de lo deducido a mano. El motor no habría dicho nada que no diera la cuenta de §6: se recomienda dejar de construirlo y dibujar.
  - Sería la tercera ronda. La regla de la ronda 2 no se cumplió ahí: el lector cambió D3.
- **Vive el motor** si alguna decisión D5–D8 sale contra su predicción, o si una predicción falla por más de 0,05 bits.
- **Instrumento inválido** si:
  - la reducción W0 no da la ronda 2 dentro de 0,03 bits;
  - falla un testigo o un mutante sobrevive;
  - más de un cuarto de las filas del principal son inválidas por §5.

## 8. Incertidumbre

- **Epistémica** (falta información, y la pondrá el silicio o una fuente). Se informa como sensibilidad, no como error:
  - el techo de K;
  - q;
  - F (f0, λF, fea);
  - B;
  - σs, σa, σr y f;
  - Rs e Imax.
- **Computacional:** el error de Monte Carlo (error estándar sobre lecturas externas) y el sesgo del anidado, acotado con 4×.
- **Franja no atribuida:** la estructura del modelo. No entran:
  - la desalineación de implantes (d real ≠ d dibujado, con signo según el lado, PLAN §5.2). Con K grande, un error de 0,03 µm en
    d mueve el túnel en d027 un factor K^0,11, y el K estimado sería K al d real. Es lo primero que haría falso un K «estimado»;
  - la dispersión entre dados;
  - el túnel asistido por trampas como mecanismo propio: F y q < 1 lo imitan solo en parte;
  - un lector dibujado.
  - Ningún número de esta ronda acota esa franja.
- **Anti-invariante:** el error de Monte Carlo decide los tamaños de muestra y si una fila es válida. No se usa como garantía
  sobre K ni sobre el chip.

## 9. Presupuestos

- **Resolución:** el autor, hasta ~3 h de CPU local para la lista de §4.
- **Auditoría, separada:** el verificador, con código propio, a partir de **este** prerregistro y sin leer el código del autor
  hasta fijar sus números (declarando hora y qué leyó después). Usa otra familia de estimador (no anidado). Reproduce como mínimo:
  - la reducción (§4.1);
  - del principal, {A2, S10} × {E1, E2, E4, E6};
  - W1q1 × A2 × E4;
  - W1K6 × {A2, S10} × E4;
  - los deltas de D5–D8 y las fracciones de K de P2.
  - Si autor y verificador difieren en más de 0,03 bits, la fila queda inválida hasta resolverlo.
  - Antes de la verificación, el autor escribe en el prompt del verificador cualquier señal post hoc como predicción.

## 10. Exploración abierta (no se cierra con esta ronda)

- Medir K con otra estructura: el largo de la frontera a área constante (PLAN §5.2), que escala el túnel y no G.
- Si el túnel en d027 queda bajo el piso, ¿un lector integrador más largo (más ciclos) gana décadas de piso? Es circuito, no motor.
- La señal de compliance del excitador como lectura extra (ronda 2, §7.2).
- La polaridad n+/p+ en sustrato.
- Cualquier cosa que el verificador vea y no esté aquí se anota en el informe, con su fuente.

## Enmiendas

Antes de congelar, sin código del motor escrito ni corrido:
- **2026-11-15 19:06.** Comprobé con 10⁶ muestras de los priors las cuentas a mano de §6. Solo los priors, sin motor.
  - P1 se confirma: 0,68 % con q = 1, 10,0 % con q = 0,5 y 2,3 % con q libre.
  - En P2 y P3 había usado mal el techo de XC26: 1,25·10⁻¹⁰ en lugar de 1,25·10⁻⁹.
    - P2: decía 21 / 10 / 69 %; es 27 / 4 / 69 %.
    - P3: decía 36 %; es 16 %.
  - Con eso bajé el umbral de P3 de 0,1 a 0,05 bits. Las demás predicciones no cambian.
  - Añadí E6c a la lista de corridas: P4 lo nombraba y §4 no lo tenía.
