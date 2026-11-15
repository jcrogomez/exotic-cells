# Motor de hipótesis, prototipo mínimo: XC-20 · informe

Prerregistro: [`PREREG.md`](PREREG.md), escrito el 2026-11-14 a las 19:45:11 EST (`date`), antes del código. Corrida completa:
19:49:10–20:13:58 EST (`motor.log`). Verificación independiente: [`verificacion/ver_INFORME.md`](verificacion/ver_INFORME.md),
cerrada a las 20:16:56 EST; código propio (Sobol aleatorizado y cuadratura determinista), sin leer `motor.py` antes de escribir
sus números. **Todo es modelo**: intervalos tomados del ataque 2 (`experiments/attack2_xc20/b20_INFORME.md`) y supuestos
marcados. Nada medido.

## 1. Qué es

Un script (`motor.py`, ~200 líneas) para una sola familia, XC-20, con tres mecanismos rivales para la corriente de la unión p+/n+
pegada:

| Mecanismo | Corriente en d = 0 a −1,8 V | Escala con | Temperatura (27 → 85 °C) | Forma I(−1,8)/I(−0,9) |
|---|---|---|---|---|
| T, túnel | 12 nA–0,5 mA | frontera | ×1,07–1,24 | 15–57 |
| R, puente óhmico (supuesto) | 18 µA–180 mA | frontera | ×0,81–0,89 | 2 |
| G, unión ordinaria | 3e-18–2e-12 A | área | ×30–2000 | 1,0–1,4 |

Para cada diseño (qué estructuras, a qué tensión y temperatura, con qué lector), el script estima la información mutua entre el
mecanismo y las lecturas, la probabilidad de acierto y la matriz de confusión. No hay módulo general en `residual/`.

## 2. Resultado (prior uniforme; `resultados.txt`; máximo 1,585 bits)

| Diseño | Lector de XC-26 tal cual | Lector de rango ancho (σ = 0,05) | Lector ancho, σ = 0,5 |
|---|---|---|---|
| Plan actual: d = 0 y d = 0,27, −1,8 V, 27 °C | 0,918 bits, acierto 0,67 | 1,362 ± 0,007, acierto 0,90 | 1,280, acierto 0,89 |
| + 85 °C | 0,918 | 1,443, acierto 0,96 | 1,303 |
| + −0,9 V | 0,956 | **1,585, acierto 1,00** | **1,468, acierto 0,96** |
| + peine (frontera ×4) | 0,918 | 1,359 | 1,307 |
| + 85 °C + −0,9 V | 0,955 | 1,585 | 1,479 |
| Solo d = 0 a −1,8 y −0,9 V (sin d = 0,27) | 0,955 | 1,585 | 1,475 |

Verificador (bits): plan con lector ancho 1,353 (σ 0,05) y 1,264 (σ 0,5); + 85 °C 1,443 y 1,291; + −0,9 V 1,585 y 1,457; con
XC-26 0,9183 (exacto: log2 3 − 2/3) y 0,956. Las casillas del autor con lector ancho salen 0,01–0,016 bits más altas, a ~1,2 σ y
siempre del mismo signo (una sola semilla exterior y el sesgo del Monte Carlo anidado). Ningún orden cambia.

**Lo que dice:**
1. Con el lector de precarga de XC-26 el plan no distingue túnel de puente: los dos saturan su techo (1,25 nA, **cálculo**). Solo
   separa la unión ordinaria. Ninguna medida extra lo arregla (≤ +0,04 bits).
2. Con un lector de nA a mA, la medida que más separa es una segunda tensión inversa (−0,9 V), no la temperatura: +0,22 bits
   frente a +0,08 (σ = 0,05), y +0,19 frente a +0,02 (σ = 0,5). El verificador da la diferencia pareada 0,142 y 0,166 ± 0,004.
3. El peine (frontera ×4) no añade nada: T y R escalan los dos con la frontera.
4. d = 0,27 no aporta en este modelo, si ya está d = 0 (la fila sin d = 0,27 da lo mismo); ver el límite 3 de §5.

## 3. Predicciones

| | Predicción | Resultado |
|---|---|---|
| 1 | Plan con XC-26 ≤ 0,95 bits; 85 °C o −0,9 V suman < 0,1 | 0,918; +0,000 y +0,038. **Cumplida** |
| 2 | Plan con lector ancho entre 1,0 y 1,4; la confusión es T frente a R | 1,362 / 1,280; el 30 % de T se lee como R. **Cumplida** |
| 3 | −0,9 V suma ≥ 0,2 bits más que 85 °C | +0,14 (σ 0,05) y +0,17 (σ 0,5). **Fallada**: la dirección se cumple, el tamaño no |
| 4 | El peine suma < 0,05 bits | −0,003 y +0,027. **Cumplida** |
| 5 | Sin calibración (σ 0,5) todos los diseños pierden ≥ 0,3 bits | Pierden 0,08–0,12 con lector ancho y nada con XC-26. **Fallada** |

## 4. Sensibilidad a los supuestos (`sensibilidad.py` → `sensibilidad.txt`, 400 × 8000 muestras)

Cláusula de muerte del prerregistro: ¿se invierte el orden al mover los supuestos dentro de lo razonable?

| Variante | Lector ancho, σ 0,05: plan / +85 °C / +−0,9 V | σ 0,5 | XC-26 con −0,9 V |
|---|---|---|---|
| Como el prerregistro | 1,349 / 1,446 / 1,585 | 1,250 / 1,284 / 1,462 | 0,952 |
| T solo en lo plausible por implantes (≤ 50 µA) | 1,499 / 1,528 / 1,585 | 1,418 / 1,429 / 1,539 | 0,959 |
| Puente parcial, R hasta 10 MΩ | 1,152 / 1,327 / 1,585 | 1,079 / 1,080 / 1,346 | 0,952 |
| R hasta 1 GΩ | 1,101 / 1,311 / 1,585 | 0,980 / 1,029 / 1,239 | 0,936 |
| Fuga térmica hasta 2e-10 A | 1,339 / 1,447 / 1,585 | 1,279 / 1,281 / 1,447 | 0,952 |
| Techo de XC-26 ×10 (cuantiza 10 %) | igual | igual | 1,039 |

En las doce filas, −0,9 V queda primero y la ventaja de la temperatura va de +0,00 a +0,21 bits. El orden no se invierte. Que el
lector de XC-26 no sirva tampoco cambia: subir su techo diez veces lo lleva de 0,95 a 1,04 bits.

## 5. Juicio honesto: ¿mejoró una decisión?

**Sí cambia la decisión del plan, pero el motor no la descubrió: la descubrió escribir las predicciones.** El verificador lo señala
y es correcto: que con el lector de XC-26 T y R saturen los dos, y que la forma (15–57 frente a 2) los separe del todo, se deduce de
los intervalos de la tabla de §1 sin correr nada (cf. la regla «tautología antes de correr»). El Monte Carlo añade tres cosas que
no se veían a mano:
- el tamaño: el plan con lector ancho ya acierta el 90 %, y lo que falla es concretamente el 30 % de T que cae donde R (18 µA–0,5 mA);
- cuánto vale la temperatura (0,02–0,21 bits según el error y el puente), que es poco y depende de supuestos;
- que el orden resiste los supuestos (§4).

Cambios que propone para XC-20, para decidir Juan:
1. El lector de XC-20 no puede ser el de precarga de XC-26 tal cual: necesita rango de nA a mA (espejo divisor, pin analógico o
   condensador mayor). Es una decisión de instrumentación compartida, no solo de esta familia.
2. Medir a dos tensiones inversas antes que a dos temperaturas. En un chip de Tiny Tapeout eso pide bajar la alimentación del
   lector o polarizar la unión desde un pin analógico `[?]`.
3. El peine puede esperar: no separa túnel de puente.

**Recomendación sobre el motor:** no generalizar todavía. La prueba de que vale la pena es un caso donde la respuesta no se deduzca
de la tabla de intervalos: mecanismos que coexisten (túnel más puente parcial), un error de calibración común a todo el canal, o un
presupuesto de canales y área que obligue a elegir. Ninguno está aquí.

## 6. Límites

1. **Error de calibración independiente por medida** (verificador): un error de ganancia real es común a todas las lecturas de un
   canal y se cancela en los cocientes. Con ese modelo, 85 °C separaría T de R también con σ = 0,5, y la predicción 3 («sin
   calibración solo sirve la segunda tensión») dependería de él. No corrido.
2. Bajo T y R la fuga térmica de d = 0 se toma de la lectura de d = 0,27 (misma área, forma 1,2 fija), no se integra. Es la resta
   del experimentador y el verificador, que sí integra, da los mismos números.
3. **T en d = 0,27 se modela como 0.** El prerregistro dice «≥ 7·10³ menos»: con t0 = 0,5 mA serían hasta 71 nA, por encima del
   piso del lector ancho. El modelo descarta esa firma y subestima lo que aporta d = 0,27 (verificador).
4. Las filas de confusión con el lector de XC-26 son un empate del `argmax` (T y R dan la misma verosimilitud): el acierto es
   correcto, la fila T→ no dice nada físico.
5. Mecanismos exclusivos; sin túnel asistido por trampas, desalineación ni dispersión entre dados (fuera del prototipo por diseño).
6. El techo de 1,25 nA del lector de XC-26 es un cálculo (12,5 fC en 100 ciclos), no una simulación del lector.

## Archivos

`PREREG.md` · `motor.py` (motor; `--rapido` para la CI) · `motor.log`, `resultados.txt` · `sensibilidad.py`, `sensibilidad.txt` ·
`verificacion/` (código y logs del verificador, `ver_INFORME.md`; `ver_conv_N1500_M18.log` vacío, corrida detenida por redundante).
Python con numpy y scipy (`.venv` de ZTASIC; scipy opcional).
