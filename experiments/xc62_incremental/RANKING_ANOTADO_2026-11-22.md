# Ranking anotado tras los artículos de diseño inverso · 2026-11-22

Nota interna, sin commit. **No sustituye a [`docs/RANKING.md`](../../docs/RANKING.md)**: ese ranking no cambia aquí. El pedido
llegó por texto pegado; los cambios de ranking los decide Juan.

## 0. Tres cosas del pedido que no existen, dichas antes

- **"Score actual".** `RANKING.md` dice: *"The ranking is a judgement on these five, not a score."* No hay número que copiar.
  Uso las cinco preguntas del ranking (E evidencia, V vehículo, F la falla enseña, N nuevo si funciona, B bloqueador resoluble
  antes del tapeout), cada una ✓/~/✗/`[?]`. Es **mi lectura del texto de cada fila**, no un dato. No sumo las cinco: sumarlas
  sería inventar pesos.
- **"Varianza por réplica".** No hay réplicas: nada se ha fabricado y los números de ranking no salen de corridas repetidas.
  El análogo más cercano es el desacuerdo entre instrumentos sobre el mismo número; lo uso en §1.3.
- **"Los conservados por más señal".** No hay ninguno: la etapa 2 no se ha corrido. La columna queda vacía hasta entonces.

## 1. Diagnóstico del ranking actual

### 1.1 Top, con la hipótesis que separa y la debilidad conocida (de `RANKING.md`)

| # | Familia | E V F N B | Separa | Debilidad conocida |
|---|---|---|---|---|
| 1 | XC-20 unión p+/n+ | ✓ ~ ✓ ✓ ~ | túnel / puente óhmico / diodo ordinario | perfil de dopado no público; el lector satura cerca de 1,25 nA |
| 2 | XC-19 una trampa | ~ ✓ ✓ ✓ ~ | trampa visible / ruido continuo / instrumento ciego | ninguna trampa demostrada; solo el silicio dice si el lector ve su propia calibración |
| 3 | XC-14 antenas | ✓ `[?]` ✓ ~ ~ | carga escrita por plasma / nada / recocido que borra | ROM muerta en óxido fino; Q1 (¿antenas no se exigen o no importan?) abierta |
| 4 | XC-01→05 e-fuse | ✓ ✓ ✓ ✓ ~ | abre limpio / se reconecta / queda en pocos átomos | barrera de metal 1 puentea; sin datos de fiabilidad de pistas quemadas |
| 5 | XC-62 proximidad | ✓ ✓ ✓ ~ ✗ | residuo de OPC grande / pequeño / nulo | desajuste de 17,3 mV mayor que el efecto: "más chips (Q7)" |
| 6 | XC-58 kT/C | ~ ✓ ✓ ~ ~ | kT/C / ruido del lector | Monte Carlo 0,90 frente a ngspice ~0,50, sin explicar |
| 7 | XC-52/60/56 espín | ✓ ✓ ✗ ✓ ✗ | efecto de espín / términos clásicos pares en campo | un nulo no distingue "ausente" de "pocas trampas"; tamaño esperado de memoria |
| 8 | XC-57 Peltier | ✓ ✓ ✓ ~ ~ | Peltier impar / Joule par | al transistor le llega el 0,7–3,4 % del calor (`c57_INFORME.md`) |
| 9 | XC-26/27 luz | ✓ ✗ ✓ ✓ ✗ | emisión / sin emisión | 0,21–0,42 pA contra piso de 0,15 pA; solo con sustrato ≤ 10 Ω·cm (P4) |
| 10 | XC-63 Schottky | ✓ ✓ ✓ ~ ~ | rectifica / óhmico | material del contacto |
| 11 | XC-59 borrado térmico | ✓ ✗ ✓ ~ ✗ | defectos que se recuecen / no | muerto para transistor con calefactor en chip (+10…+60 K como mucho) |

### 1.2 Correlación: candidatos que están arriba por la misma razón

| Grupo | Razón compartida | Consecuencia |
|---|---|---|
| XC-20 y XC-01 | los dos necesitan un frontal de rango amplio (corriente por encima de lo que satura el lector) | un solo frontal sirve a ambos; no son redundantes en física, sí en la dependencia |
| XC-19 y casi todo | el lector compartido | ya reconocido en `RANKING.md`: XC-19 está arriba por el instrumento, no por la trampa |
| XC-62 y la matriz LOD (XC-12, línea base no exótica) | geometría → umbral, mismo lector, y **mismo confusor**: las vecinas a 0,21 tienen que ser puertas sobre la misma difusión (`c62_INFORME.md`), así que proximidad y LOD vienen juntas | uno sobra **si se diseñan por separado**. Juntos en una matriz factorial (vecina sí/no × posición en la difusión fija) se separan y se pagan una vez |
| XC-57, XC-59, XC-39 | camino del calor de un poly al silicio | el mismo límite físico (el silicio es sumidero, k_Si ~150 frente a k_ox 1,0–1,4) los castiga a los tres por la misma razón |
| XC-26 y XC-27 | P4 (resistividad del sustrato) | XC-27 no tiene valor propio en MISFIT mientras XC-26 no lo tenga |

### 1.3 Inestabilidad entre instrumentos (el análogo honesto de la varianza por réplica)

- **XC-20, ronda 3:** autor y verificador no coinciden dentro de 0,03 bits (`xc20_hipotesis_r3/INFORME.md`). Lo derivado de esa
  ronda no cuenta como top. XC-20 sigue arriba por la corriente verificada al orden y por la abutment que pasa el precheck, no
  por R3.
- **XC-58:** dos instrumentos dan 0,90 y ~0,50 del mismo kT/C. Hasta explicarlo, el número no sostiene el puesto.
- **XC-19:** el 98 % es un solo modelo de comportamiento con un escalón inyectado. Sin segundo instrumento.

## 2. Los artículos: qué delta aportan al ranking

Regla aplicada: si el supuesto central del artículo no sobrevive a nuestro desajuste (17,3 mV) y al ruido del lector, se
descarta como entrada del ranking.

| Artículo | Leído | Supuesto central | ¿Sobrevive a 17,3 mV y al lector? | Delta en el ranking |
|---|---|---|---|---|
| Karahan et al., Nat. Commun. 15, 10734 (2024): CNN + GA | completo (texto principal; suplementario no) | ~10⁵ simulaciones de un solver de confianza (Maxwell) y una respuesta que se mide con VNA | **No.** MISFIT no lee parámetros S. En XC-62 el modelo directo ya cuesta 9 ms: un sustituto no aporta. En XC-27 la respuesta llega como pA contra un piso de 0,15 pA | **Ninguno.** Queda como herramienta de diseño para las tapas de XC-27, sin peso en el ranking |
| Zhou et al., IEEE JSSC 61(11) 6091–6109 (2026): RL + diseño inverso | **solo metadatos** (Crossref). No he leído el texto | un simulador de extremo a extremo barato para que el RL lo recorra miles de veces | `[?]` sin leerlo. Nuestras decisiones (qué celda, qué lector, qué protocolo) son decenas: enumerarlas cuesta menos que entrenar un agente | **Ninguno por ahora** |
| Sun/Zheng et al., arXiv:2501.18054v4 (2026): PNGF | v2 completa; v4 solo resumen y cifras | física lineal con coeficientes fijos | **Sí** para calor estacionario, Laplace y EM lineal. No toca ni el desajuste ni el lector: es una herramienta, no un prior | **Ninguno directo.** El límite de XC-57/59 es material, no geométrico: c57 ya barrió distancias y "la cadena no mejora" |
| Nuestro evaluador (`xc62_incremental`, 60×) | — | el mismo modelo sin calibrar | — | **Ninguno**: la velocidad para explorar no es evidencia sobre el silicio (regla: una cantidad que decide recursos no se reutiliza como garantía) |

**Conclusión de §2:** ninguno de los tres artículos mueve el ranking. Lo que sí lo mueve (§3) sale de releer el repo con el
problema del desajuste en mente, no de los artículos. Lo digo para que no se les atribuya.

## 3. Subir la escala: candidatos de ruptura

### 3.1 Castigos injustos del ranking actual

| Candidato | Castigo actual | Por qué el castigo es un error aquí | Qué lo prueba |
|---|---|---|---|
| **XC-62** | B ✗: "más chips (Q7)", el desajuste de 17,3 mV es mayor que el efecto | 17,3 mV es el desajuste de **un** transistor de 0,42/0,15. El efecto de proximidad es igual en cada dedo interior de un peine, y el desajuste cae como 1/√n (Pelgrom, aritmética): n = 12 → 5,0 mV; n = 16 → 4,3 mV. El bloqueador asumió un dispositivo por variante. **[corregido 2026-11-22 12:52, `../xc62_etapa2/prereg_calc.txt`]** esos son los del peine solo; la diferencia peine − referencia (n de cada lado) es √2 mayor: baja de 5 mV con **n ≥ 24** (4,99 mV) | escalado de 1/√n con n en silicio; en el modelo es aritmética, no evidencia |
| **XC-59** (variante de poly) | V ✗ y B ✗: "muerto" | el veredicto es para **transistor** con calefactor. El mismo informe deja vivo el poly sobre óxido de campo (+200…+400 K en < 1 µs con 10–20 mW). El castigo de la fila mezcla las dos | defectos de poly que se recuecen a temperaturas alcanzables `[?]`: no hay dato |
| **XC-58** | E ~ por la discrepancia MC/ngspice | la discrepancia es un hallazgo sobre el modelo de ruido de ngspice (XC-47), no una debilidad de la celda. Solo es injusto a medias: hasta resolverla, la celda no tiene número | explicar el 0,50 con un tercer instrumento |

### 3.2 Candidatos nuevos o recombinados

| Id provisional | Qué es | Doble servicio | Sale del régimen | Plausible con el evaluador |
|---|---|---|---|---|
| **R1 · XC-62R, ancho impreso leído como resistencia** | líneas largas de poly de 0,15 µm, densas (vecinas a 0,21) frente a aisladas, leídas como el cociente R_densa / R_aislada. El cociente cancela la resistencia de hoja (48,2 Ω/□, `sky130A.tech`) y su coeficiente térmico, y vale w_aislada / w_densa. Lectura por el anillo con resistencia en serie de EFLD-00 (+1,7 % con 1 kΩ, +32 % con 10 kΩ, laboratorio sin publicar). Una línea de 30 µm son ~9,6 kΩ (cálculo); 10 nm de 150 son 6,7 % | **XC-62**: mide el mismo residuo de OPC sin pasar por el umbral. **Calor**: las mismas líneas son calefactor y termómetro de poly (XC-39, tc1 de `res_xhigh_po` −1,47·10⁻³ /K, PDK local), y poly a poly llega el 10–35 % del calor, frente al 0,7–3,4 % al transistor (`c57_INFORME.md`). Es el sensor que XC-57 y la variante de poly de XC-59 necesitan | **sí**: fuera de inversión débil (ni siquiera es un transistor) y sin desajuste de umbral. Queda el desajuste de resistores, `[?]` en SKY130 | **sí**: líneas rectangulares sin solape, el ancho se lee en el centro de la ROI |
| **R2 · peine con control de LOD** | XC-62 como n dedos interiores en una difusión, contra la misma difusión con la puerta central en la misma posición y sin vecinas. Así sa/sb (LOD) es igual en los dos y la única diferencia es la proximidad | XC-62 + la matriz LOD: rompe el confusor de §1.2 | desajuste < 5 mV con n ≥ 12 (aritmética de Pelgrom) | **sí**: cada dedo es un desplazamiento de la misma forma |
| **R3 · lectura por carrera (sin contador)** | dos nodos idénticos que descargan por la variante densa y la aislada. Un árbitro (XC-33, metastabilidad) da un bit. Cientos de carreras, intercambiando las entradas, cancelan el offset del árbitro; la fracción de bits es la señal | XC-62/R1 + XC-33: el árbitro también es una celda del catálogo | **sí**: sin contador | no le aplica: es circuito, no litografía |
| R4 · tapas de XC-27 por diseño inverso EM | Karahan/grcwa sobre la tapa, objetivo de extracción sobre el 1–4 % de hoy | XC-27 + XC-26 | no | no: es otro modelo (Maxwell) |

### 3.3 Ranking anotado

Columna 1: lectura de `RANKING.md` (§1.1). Columna 2: qué cambia tras los artículos (§2). Columna 3: **juicio mío**, no un
dato.

| Candidato | Actual (E V F N B) | Post-artículos | Ruptura (1–5) |
|---|---|---|---|
| R1 · XC-62R resistencia | no está | aparece por §3, no por los artículos | **5**: saca a XC-62 del umbral y del desajuste, y es el sensor que le falta al calor. Riesgo: desajuste de resistores `[?]` y OPC tan buena que el cociente sea 1 (que también es un resultado) |
| R2 · peine con control de LOD | no está | igual | **4**: disuelve el bloqueador declarado de XC-62 y el confusor LOD en el mismo dibujo |
| XC-20 | ✓ ~ ✓ ✓ ~ | sin cambio | **4**: un diodo túnel en un PDK abierto. Ningún artículo lo toca |
| XC-19 | ~ ✓ ✓ ✓ ~ | sin cambio | **3**: el instrumento es lo que hace que todo lo demás sea legible; la trampa, en sí, es incremental |
| R3 · carrera con árbitro | no está | igual | **3**: lectura sin contador y XC-33 de paso. Riesgo: ruido de fase del árbitro `[?]` |
| XC-01→05 | ✓ ✓ ✓ ✓ ~ | sin cambio (PNGF solo cubre la parte lineal de la constricción) | **3** |
| XC-14 | ✓ `[?]` ✓ ~ ~ | sin cambio | **3** si Q1 es "no se exige"; si no, 1 |
| XC-62, como está (un transistor por variante) | ✓ ✓ ✓ ~ ✗ | sin cambio | **2**: superado por R1 y R2 |
| XC-57 | ✓ ✓ ✓ ~ ~ | sin cambio por los artículos; sube si se lee con el poly de R1 en vez del transistor | **2** |
| XC-59, variante de poly | ✓ ✗ ✓ ~ ✗ | sin cambio | **2**: comparte calefactor con R1; falta el dato de qué defectos de poly se recuecen |
| XC-58 | ~ ✓ ✓ ~ ~ | sin cambio | **2** |
| XC-26/27 (+ R4) | ✓ ✗ ✓ ✓ ✗ | Karahan descartado como entrada; R4 solo como herramienta | **2**: luz chip a chip sería grande, pero P4 manda |
| XC-52/60/56 | ✓ ✓ ✗ ✓ ✗ | sin cambio | **2** |
| XC-63 | ✓ ✓ ✓ ~ ~ | sin cambio | **1** |

## 4. Lo que haría con esto (sin correr nada todavía)

1. Prerregistrar la etapa 2 sobre **R1 y R2**, no sobre XC-62 en un solo transistor. Hipótesis: los cuatro ajustes ópticos y,
   como supuesto nuevo declarado, un sesgo de borde parametrizado para la OPC. Lectura: el cociente R1 y el ΔVeq de R2 con
   1/√n. Control: selección al azar con el mismo presupuesto. Conservar aparte los de más señal.
2. Buscar en el PDK o en la literatura el desajuste de resistores de poly en SKY130. Si no aparece, queda `[?]` y entra como
   prior ancho, con sensibilidad declarada.
3. Leer el texto de Zhou et al. 2026 antes de volver a descartarlo.
