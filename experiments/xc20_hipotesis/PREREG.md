# Motor de hipótesis, prototipo mínimo: XC-20 · prerregistro

Escrito el **2026-11-14 19:45:11 EST** (`date`), antes de escribir el código y de correr nada. Encargo: decisión de Juan del
2026-11-13 21:33 (`experiments/REVISION_EXTERNA_2026-11-13.md`): una familia, 2–3 mecanismos rivales, sus predicciones y la
configuración que mejor los separa, con incertidumbres explícitas; nada general hasta demostrar que mejora una decisión concreta.

## Pregunta y decisión que debe mejorar

XC-20 (unión p+/n+ pegada). La decisión pendiente es qué dibujar y cómo leerlo. Su plan (`cells/xc20_abutted_junction/PLAN.md`
§5.2) dice: «primero un canal completo con d = 0, d = 0,27 y la celda sin unión; la matriz después», leído con el lector de
precarga de XC-26, a 1,8 V y temperatura ambiente, y luego temperatura. El motor debe decir, con números, si ese primer canal
separa los mecanismos y qué añadir (o cambiar) para separarlos mejor.

## Mecanismos rivales (exclusivos en el prototipo)

| | Mecanismo | Qué predice, y de dónde sale |
|---|---|---|
| T | Túnel banda a banda en la frontera | I(−1,8 V, 27 °C) por 1,4 µm de frontera entre 12 nA y 0,5 mA (b20, tabla §3, escenario central; log-uniforme); proporcional al largo de frontera; I(85 °C)/I(27 °C) de 1,05 a 1,25 (de ×1,2–1,8 entre 233 y 358 K, b20 §6, como energía de activación 0,010–0,034 eV); forma I(−1,8)/I(−0,9) = 15–57 (b20 §6). En d = 0,27 desaparece (≥ 7·10³ menos, b20 §5) |
| R | Puente óhmico en d = 0 (siliciuro u otro conductor sobre la frontera; la compuerta `[?]` de la matriz de capacidades) | I = V/R con R log-uniforme entre 10 Ω y 100 kΩ por 1,4 µm (**supuesto**: no hay dato de siliciuro en SKY130); proporcional al largo de frontera; I(85)/I(27) = 0,81–0,89 (coeficiente de metal +0,2 a +0,4 %/K, **memoria**); forma = 2. En d = 0,27 no hay puente |
| G | Unión ordinaria: difusión y generación térmica, sin túnel ni puente | I(−1,8 V, 27 °C) entre 3·10⁻¹⁸ A (Js del PDK) y 2·10⁻¹² A (cota del modelo b20 §5) para la celda de 1,4 µm², log-uniforme; proporcional al área, no a la frontera; activación 0,56–1,12 eV (generación a difusión) → I(85)/I(27) ≈ 30–2000; forma 1,0–1,4 (**cálculo**: corriente casi saturada en inversa, crece con la zona de carga). Igual en d = 0 y d = 0,27 |

Fondo común: la celda sin unión mide el lector; se modela como 0 (la fuga del lector se resta con ella). Probabilidad previa:
1/3 cada uno; sensibilidad con (0,2; 0,2; 0,6) y (0,6; 0,2; 0,2).

## Instrumento (modelo de medida)

Cada medida es log10(I) con error de calibración σ = 0,05 décadas si hay corriente de calibración y 0,5 si no (**supuesto**). La
lectura se trunca: por debajo del piso sale «bajo piso», por encima del techo «saturado».
- **Lector de precarga de XC-26 tal cual** (`lab/macros/photon/LEEME.md`): piso 150 fA a 27 °C y 0,1 pA a 85 °C (hipótesis del
  laboratorio); techo **calculado** 1,25 nA (Q = 12,5 fC en 100 ciclos de 100 ns, para cuantizar al 1 %).
- **Lector de rango ancho** (propuesta, no dibujado): piso 1 nA, techo 1 mA (p. ej. espejo de corriente divisor, o pin analógico).
- Ambos a la vez (dos lectores por canal).

## Diseños candidatos

Dibujos: d = 0 con frontera 1,4 µm (base), d = 0 con frontera ×4 a igual área (peine), d = 0,27, celda sin unión. Condiciones:
−1,8 V; −0,9 V (alimentación baja, si el lector funciona: `[?]`); 27 y 85 °C. Diseños: D0 = plan actual (base, 0,27 y sin unión;
−1,8 V; 27 °C); D0 + 85 °C; D0 + −0,9 V; D0 + peine; D0 + 85 °C + −0,9 V; cada uno con los tres lectores.

## Medida del motor

Ganancia de información esperada sobre el mecanismo, EIG = I(M; Y) en bits (máximo log2 3 = 1,585), por Monte Carlo anidado, y
probabilidad de acierto del máximo a posteriori. Se informa con su error de Monte Carlo.

## Predicciones (antes de correr)

1. Con el lector de XC-26 tal cual, D0 da ≤ 0,95 bits: separa G de lo demás, pero T y R saturan los dos (T ≥ 12 nA y R ≥ 18 µA,
   ambos sobre el techo de 1,25 nA). Añadir 85 °C o −0,9 V suma < 0,1 bits.
2. Con el lector de rango ancho, D0 da entre 1,0 y 1,4 bits; la confusión que queda es T frente a R donde se solapan (18 µA a
   0,5 mA a −1,8 V).
3. La mejor medida extra es la segunda tensión (forma 15–57 frente a 2), no la temperatura: −0,9 V suma al menos 0,2 bits más que
   85 °C. La temperatura sola separa T de R peor (1,05–1,25 frente a 0,81–0,89 está a ~0,1 décadas: con σ = 0,05 sí se separa;
   con σ = 0,5, no). Es decir: con calibración, 85 °C también sirve; sin ella, solo la segunda tensión.
4. El peine (frontera ×4) suma < 0,05 bits: T y R escalan los dos con la frontera; solo separa G, que ya separa d = 0,27.
5. Sin calibración (σ = 0,5) todos los diseños pierden ≥ 0,3 bits frente a σ = 0,05.

## Qué mata el enfoque

Si el diseño que el motor pone primero es el que el plan ya proponía (D0 con temperatura después) y la diferencia con el segundo
es menor que el error de Monte Carlo, el motor no ha mejorado la decisión, y se escribe así. También si el resultado depende por
entero de los supuestos marcados (techo del lector, R del puente) de modo que cambiarlos dentro de su intervalo invierte el orden.

## Fuera del prototipo

Mecanismos simultáneos (túnel más puente parcial), túnel asistido por trampas como cuarto rival, desalineación, dispersión entre
dados, coste en área. Nada de esto entra en el código hasta que el prototipo haya cambiado una decisión.
