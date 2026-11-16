# Motor de hipótesis de XC-20, ronda 3 · informe del autor

Escrito el 2026-11-15 a las 21:01 (`date`). El prerregistro es [`PREREG.md`](PREREG.md), congelado a las 19:05:04, con la
Enmienda 1 de las 19:27. La verificación independiente está en [`verificacion/ver3_INFORME.md`](verificacion/ver3_INFORME.md):
números fijados a las 20:24:50, cota de Barber-Agakov.

**Estado: no consolidado.** El prerregistro (§9) exige que autor y verificador coincidan dentro de 0,03 bits, y no coinciden
en todas las filas que deciden. Además, mi instrumento falla dos de sus propias pruebas (§2). Los números que siguen son del
verificador, salvo que se diga otra cosa. Su instrumento pasa sus controles, pero no hay una segunda medida que coincida con
él en todo.

## 1. La explicación aburrida primero: mi estimador

- **Estimador del autor** (`motor3.py`): Monte Carlo anidado con muestreo de importancia.
  - Hizo falta rediseñar la propuesta tres veces antes de que convergiera en la reducción: propuesta de Laplace con dos pasos
    de Gauss-Newton, colas t, el ancla en el chip que generó la lectura y las tres mejores muestras de la etapa 1.
  - La causa: con 5 lecturas finas (σe = 0,02), el posterior de M (unos 13 parámetros) es estrecho en ~4 direcciones y ancho
    en las demás. Una bola isótropa no lo cubre a ninguna escala.
- **Reducción W0** (C1, E1), mía frente a la ronda 2:
  - A: 1,4805 ± 0,015 frente a 1,4876;
  - X: 1,3977 ± 0,016 frente a 1,3938;
  - A2: 1,7503 ± 0,027 frente a 1,7707.
  - Pasa (≤ 0,03).
  - En A2, la regla del 4× (N2 de 2000 a 8000) cambia −0,010: pasa en esa fila. Es la única fila donde la corrí.
- **W1:** mi motor queda por debajo del verificador.
  - Diferencias: A2 E1 −0,036, A2 E2 −0,037, A2 E4 −0,028, X E4 −0,054. X E1 (−0,025), A E1 y A E4 (≤ 0,003) pasan.
  - El verificador da una **cota inferior**: un valor mío por debajo de ella es sesgo mío.
  - Fallan la regla de 0,03: A2 E1, A2 E2 y X E4. A2 E4 pasa por poco.
- **S_f.** Mi implementación no es la del prerregistro. Puse el error de rango como ruido independiente por lectura; el
  prerregistro dice «independiente entre los rangos usados», como lo hizo el verificador. Mi versión rompe los cocientes
  entre lecturas. Mis filas S no cuentan (S10 E2: 1,527 frente a 1,631).
- **W2:** roto en mi motor. I(s_F) sale negativa (−0,066) y I(clase) da 1,199 frente a 1,654. No cuenta.
- **Error pareado de mis diferencias:** ~0,02 bits, el doble del umbral de las decisiones dividido por 2,5. Mi motor no puede
  juzgar umbrales de 0,05; solo el signo.

## 2. Pruebas del §5 sobre mi instrumento (`test_motor3.py` → `test_motor3_salida.txt`)

- **Mutante «lector_d027»:** detectado.
- **Testigo K:** pasa.
  - Estimada en el 87 % de los chips; contiene 10⁷ en el 90 %.
  - Su mutante sin d027 deja de estimar: 0 %.
- **Testigo F:** pasa, con mediana de P(F | y) = 1,00.
- **Mutante «sin_norm» (pesos sin p/q):** sobrevive, con −0,019 ± 0,052.
  - Con 150 lecturas por clase la prueba no tiene potencia. Además, con propuestas buenas el sesgo se cancela en parte entre
    clases. `[?]` si es una mutación equivalente para I.
- **Testigo B:** falla. El sesgo de log10 g0 es −0,86 décadas sin la celda sin unión y −0,92 con ella.
  - El testigo está mal planteado (error mío en el §5): con B = 5·10⁻¹³ y g0 = 10⁻¹⁵, g0 no se identifica con ninguna celda, y
    el posterior es el prior truncado en los dos casos.
  - Un testigo útil pondría G cerca de B (g0 ~ 10⁻¹³). No lo corrí.
- **Veredicto del §7, tal cual:** «instrumento inválido» para mi motor.

## 3. Cotejo de las decisiones: diferencias pareadas, autor frente a verificador (W1, C3b)

| | Autor (± error pareado) | Verificador | ¿≤ 0,03? |
|---|---|---|---|
| D6, A2, E1 → E2, I(M) | +0,054 ± 0,018 | +0,0557 ± 0,0005 | sí |
| D5, A2, E2 → E4, I(túnel) | +0,023 ± 0,011 | +0,0112 ± 0,0002 | sí |
| D5, A2, E2 → E4, I(Kbin \| túnel) | +0,216 ± 0,059 | +0,1002 ± 0,0010 | **no** |
| D8, A2 − A, E1 | +0,047 ± 0,016 | +0,0851 ± 0,0006 | **no** (0,038) |
| D8, A2 − A, E4 | +0,159 ± 0,023 | +0,1887 ± 0,0007 | sí |
| D8, A2 − X, E1 | +0,297 ± 0,026 | +0,3080 ± 0,0010 | sí |

- Coinciden en el **signo** de todas las decisiones.
- Mi I(Kbin) absoluta sale muy por debajo de la del verificador (A2 E4: 0,896 frente a 1,141). Un posterior hecho de muestras
  pondera mal los bins vacíos.

## 4. Lo que dicen los números del verificador (observado; sin consolidar)

| Pregunta | Resultado | Coste aproximado |
|---|---|---|
| **D6.** ¿Celda sin unión? | **Sí.** I(M) +0,056, I(Kbin) +0,097 con A2; W2 +0,061. **Es la que mejor coincide con mi motor** | 1 celda (pozo 4 × 3 µm), 2 lecturas, 1 entrada de mux |
| **D5.** ¿0,54 y 1,08 µm? | **Sí, si el umbral se aplica a los bits sin normalizar**: I(Kbin \| túnel) +0,100 (A2), +0,123 en W2; D5' por s_F +0,081 (W2). **No, si se aplica a la fracción de H(Kbin)**: +0,033 en W1 (ver §5). Casi todo lo aporta 0,54: 1,08 suma +0,007 | 2 celdas, 2–4 lecturas, 2 entradas de mux |
| **D7.** ¿Rangos seleccionables? | En I(M), S1 gana de +0,04 a +0,09, S10 empata y S100 pierde de 0,04 a 0,12. En K solo S1 gana; **S10 pierde 0,09–0,14 bits porque su piso no ve la celda sin unión** | Depende de la fuga real de los interruptores `[?]` |
| **D8.** ¿Lector mixto (A2)? | **Sobrevive con K hasta 10¹²**: +0,085 (E1) y +0,189 (E4) sobre el ancho; mi motor da +0,047 en E1, debajo del umbral | Un segundo front-end `[?]` |
| **K** | Estimada en 17–21 % de los chips con túnel (A2, E2–E5), acotada en ~48 %. **Con σs = 0,5 (C3c) la estimada cae a ≤ 0,2 %, mientras I(M) casi no cambia: la calibración entre lectores decide K, no el mecanismo** | Requisito de diseño, no área |

**Hallazgos que el prerregistro no previó** (del verificador; los reviso como lectura de papel, sin correr):
1. **Las separaciones valen como referencia, no como lector del túnel.**
   - Con q = 1, D5 vive (+0,112), y quitando el túnel en 0,54 y 1,08 sigue en +0,097.
   - 0,54 y 1,08 miden G + B sin túnel, y eso deja atribuir al túnel el exceso de d = 0,27.
   - Falla P1, y con ella mi predicción global de D5. Es la propiedad que señala la revisión: una estructura de control se
     vuelve observable cuando se interroga de otra forma.
2. **En W1, «F frente a túnel residual» está saturada en 0,915–0,918 de 0,918 en todos los diseños.**
   - La lectura base separa F (≤ 10⁻¹¹ A) del túnel (≥ 12 nA), así que la cantidad no mide nada.
   - Solo W2 hace la pregunta con sentido. La Enmienda 1 preveía la inflación; no que llegara al techo.
3. **P6 se cumple en tamaño con el mecanismo equivocado.**
   - La caída de D8 frente a la ronda 2 (de +0,283 a +0,085) la pone K hasta 10¹² (con K ≤ 10⁶, +0,229), no la independencia
     de g_s y g_a (C1 frente a C3b: 0,002).
4. **El empate de S_f está en f = 10, no en f = 100** (P7 falla en el punto de empate).

**Predicciones (veredicto del verificador, con las palabras del PREREG):**
- **P1: falla.**
- **P2: se cumple.** Estimada / acotada / nada = 0,175 / 0,481 / 0,344.
- **P3: se cumple** (+0,118).
- **P4: falla en W1; en W2 se cumple con A2.**
- **P5: se cumple con A2.**
- **P6: tamaño sí, mecanismo no.**
- **P7: tamaño sí, empate no.**
- **«Muere el motor como herramienta»: no.** Varias predicciones fallan por más de 0,05 bits: vive.

## 5. Ambigüedad que decide un veredicto (para Juan)

- **El problema:** el §5 del prerregistro dice que I(Kbin; Y | túnel) «se normaliza por H(Kbin)», y D5 pide «≥ 0,05 bits».
  No dice si el umbral se aplica antes o después de normalizar.
- **Las dos lecturas:**
  - **Sin normalizar** (la del verificador): D5 vive, +0,100.
  - **Normalizada:** en W1 muere (+0,033). En W2 queda en el umbral por F/túnel (+0,050). D5' (s_F +0,081) no depende de esto.
- **Mi lectura, como autor, es la primera.** «Efecto mínimo de 0,05 bits» está escrito en bits en todo el documento, y la
  normalización iba para presentar la tabla. Pero la escribí yo y no lo dejé claro: no la resuelvo sola.
- **Las otras ambigüedades no cambian veredictos:**
  - el tipo de intervalo;
  - «estimada» en todos los chips o en la mayoría;
  - la selección de rango de S_f.

## 6. Qué haría falta para consolidar

1. Corregir S_f en `motor3.py`: error compartido por rango, el rango observado y L_sw solo en el rango bajo.
2. Arreglar W2.
3. Un testigo B útil.
4. Bajar el error pareado de mi motor por debajo de ~0,01. Con este estimador harían falta del orden de 4× las lecturas
   externas y 4× la etapa 2: unas 16 h de CPU por la lista de decisiones `[estimación]`.
5. Otra opción: un segundo verificador de otra familia que reproduzca las filas de §3.

## Archivos

| Archivo | Qué es |
|---|---|
| `PREREG.md` | Prerregistro y Enmienda 1 |
| `aritmetica_priors.py`, `aritmetica_priors_salida.txt` | Control de la aritmética de los priors (Enmienda 1, §3) |
| `motor3.py` | Motor del autor |
| `test_motor3.py`, `test_motor3_salida.txt` | Mutantes y testigos (§2) |
| `corre_cotejo.py`, `cotejo*.log`, `res3_cotejo*.jsonl`, `res3_cotejo*.npz` | Las filas del cotejo (§3); los `.npz` llevan los bits por lectura. La parte 3 (W0 y W2) la detuve a las 21:12 durante W2 A2 E4: sus filas están en el `.jsonl`, pero no tiene `.npz` |
| `res3_rapido.*` | Humo |
| `verificacion/` | Código, tablas e informe del verificador. Los volcados `ver3_*.npz` (3,4 GB) se regeneran con sus scripts y no se versionan |
