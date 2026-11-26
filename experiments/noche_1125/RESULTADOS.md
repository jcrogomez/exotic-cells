# Plan nocturno del 2026-11-25 · resultados

Prerregistro: [`PLAN_2026-11-25_noche.md`](../../cells/preregistros/PLAN_2026-11-25_noche.md) (sellado 21:35 EST, antes de generar
los decks). Cola: `cola.sh`, de 21:37 a 03:08 EST (`cola.out`); los 159 decks terminaron con `salida 0`. Los cuatro programas
de análisis se escribieron el 26 por la mañana antes de abrir ningún log (hash y hora en `ANALISIS_SHA256.txt`); las formas que
el prerregistro no fijaba están en la cabecera de cada programa. Todo es SPICE (ngspice 44.2, PDK 8afc8346). Nada es silicio.

Salidas completas: [`D.txt`](D.txt), [`B.txt`](B.txt), [`A.txt`](A.txt), [`C.txt`](C.txt).

## Lo aburrido primero

- **Sin cableado.** El bloque D copia ramas (dispositivo, interruptor, capacidades del nodo intermedio) pero no el alambre que
  las une. Con alambre el tiempo por rama sube; cuánto, `[?]`.
- **Un solo tipo de dispositivo y una sola fuga.** El corte de fuga del bloque D usa la fuga por rama de MISFIT-05 (nominal, sin
  desajuste). Los dispositivos exóticos fugarán otra cosa.
- **El control del Monte Carlo no es idéntico al de MISFIT-09:** sale un 0,0055 % más corto (dentro del 0,01 % fijado). El mismo
  desplazamiento estaba en el Monte Carlo de v_hm, así que la comparación B2 es entre iguales. Causa `[?]` (probable: paso de
  integración distinto en ese deck).
- **Dos testigos del bloque A fallan** (−1,52 % y −1,24 %, banda −1,2 a −0,8). Esos dos casos son inválidos por la regla escrita.
  Causa `[?]`; lo más aburrido es ruido numérico de un deck, del orden de 0,5 %.
- **En el bloque A la carga por ciclo depende de la precarga:** Q ajustada ≈ 139 fC con L = 0,15 (R2), 99–106 con 0,50, 50–57
  con 1,00 y 18–24 con 2,00. La precarga larga no recarga el nodo del todo en el pulso. El modelo absorbe eso en Q, pero una Q
  que depende de la fuerza de un transistor es sensible al desajuste y a la alimentación. No está medido.

## Bloque D · puestos por lector (R6, sin cableado): válido

| # | Predicción | Veredicto | Medido |
|---|---|---|---|
| D1 | +0,20 a +0,28 % por rama, lineal ±10 % | **cumplida** | +0,230 a +0,253 %; a 128 ramas se desvía como mucho −2,7 % del valor a 32 (ss 85) |
| D2 | El salto cambia < 2 % relativo a 128 ramas | **falsa** | −0,90 % (tt 27), −1,19 % (ff −40), −1,63 % (ff 85), **−4,27 % (ss 85)** |
| D3 | ln(tA/tB) se mueve < 0,0807 puntos hasta 64 | **cumplida** | ≤ 0,067 a 64; a 128, de 0,078 a 0,118 (lo pasa en 3 de 4 esquinas) |
| D4 | Todo abierto 1,4 ms: 32 no cruza a ss 85, 128 cruza en las dos | **cumplida** | 128 cruza a 1,14 ms (ss 85) y 0,50 ms (ff 85); 32 no cruza en ninguna (a ff 85 el nodo baja a 0,93 V) |
| D5 | Testigos y mutante | **cumplida** | 1 fF: +0,65 a +0,70 %; 40 pA: baja; rama cerrada: 0,501–0,502 |

Tiempo de lectura frente a una rama: ×1,07–1,08 con 32, ×1,15–1,16 con 64, ×1,29–1,32 con 128.

**Por qué falla D2 (cuenta, no medida aparte):** a ss 85 la fuga de 127 ramas abiertas es 127 × 3,58e-4 = 4,5 % de la
corriente (MISFIT-05). Esa corriente no pasa por la trampa y diluye el salto en la misma proporción: se mide −4,27 %.

**Cortes:** los tres (salto ≤ 5 % relativo, tiempo ≤ 1,5 veces, fuga ≤ 5 %) se cumplen hasta **128** en las 4 esquinas.
A ss 85 quedan justos: 4,27 % y 4,55 %.

**Decisión (por delegación): 64 puestos por lector, no 128.** La regla escrita da 128, pero sin cableado y con dos cortes al
85–91 % de su límite. A 64 quedan a menos de la mitad (salto −2,17 %, fuga 2,3 %) y el desplazamiento A/B sigue bajo 0,0807.
La revierte: una corrida con cableado extraído que deje 128 con margen, o que tumbe 64.

## Bloque B · desajuste del lector pequeño (48 chips): válido, el lector pequeño sigue

| # | Predicción | Veredicto | Medido |
|---|---|---|---|
| B0 | Control: 6 chips idénticos, tA = 30,8832 µs ± 0,01 % | **cumplida** | 30,8815 µs (−0,0055 %), rango entre chips 0 |
| B1 | Salto: mediana 0,70–0,91 %, ≥ 90 % de chips en 0,50–1,00 % | **cumplida** | mediana 0,805 %; 48 de 48 entre 0,714 y 0,821 %, todos negativos |
| B2 | Mediana a < 0,03 puntos de la de v_hm (0,803) | **cumplida** | 0,002 puntos |
| B3 | σ de ln(tA/tB) en e01 entre 0,90 y 1,51 | **cumplida** | 1,115 (IC 95 %: 0,89–1,30; N = 47). v_hm: 1,204 |
| B4 | Paso relativo entre 0,90 y 1,03 % en todos los chips | **falsa** | 47 de 48 dentro; uno a 0,886 %. Mediana 0,953 %, máximo 0,996 % |

Un chip de 48 no cruza en 200 µs en e01 (igual que en v_hm). Las 4 semillas dan 48 chips distintos.
El paso absoluto va de 0,50 a 2,04 %; dividido por el cociente del propio chip, de 0,886 a 0,996 %: la normalización que en
v_hm se vio como exploración se repite fuera de muestra, con un chip un 1,6 % por debajo de la banda apostada.

**Lectura:** con desajuste, el filtro de 3 dedos no cambia ni el salto de una carga ni la dispersión entre gemelos.

## Bloque C · ruido de disparo con semillas independientes: válido, todo cumplido

| # | Predicción | Veredicto | Medido |
|---|---|---|---|
| C0 | Sin ruido: dispersión nula, tA = h11 de v_f3 ± 0,01 % | **cumplida** | 64 muestras iguales, 0,0000 % |
| C1 | σ de ln(tA/tB) en R1 y R1b entre 0,115 y 0,195 % | **cumplida** | 0,1573 % y 0,1567 % |
| C2 | σ(R3)/σ(R1) entre 2,4 y 3,6 | **cumplida** | 2,89 |
| C3 | R1 y R1b distintas, σ dentro de ±35 % | **cumplida** | 0 parejas comunes de 64; cociente 0,996 |

`setseed` funciona: las 8 repeticiones de cada instancia difieren y dos semillas dan muestras distintas con la misma σ. El
ruido de disparo por lectura (0,157 %) es un quinto del salto de una carga (0,81 %), también con el filtro pequeño.

## Bloque A · lector de rango ancho con precarga más larga: criterio de muerte cumplido

Error del modelo de tres números, en % (se juzga de 1 nA a 10 µA, banda ±3 %). La fila de L = 0,15 es la de
[R2](../xc20_lector/r2/RESULTADOS.md).

| L (µm) | esquina | 100 pA | 1 nA | 10 nA | 100 nA | 1 µA | 10 µA |
|---|---|---|---|---|---|---|---|
| 0,15 | tt 27 | +0,05 | −0,01 | −0,02 | +0,01 | +0,13 | −0,91 |
| 0,15 | ff −40 | −0,00 | −0,00 | −0,00 | +0,01 | +0,07 | −0,57 |
| 0,15 | ss 85 | +5,39 | −1,73 | −2,44 | −2,37 | −1,48 | +2,67 |
| 0,15 | ff 85 | −0,41 | **+15,94** | −0,01 | +0,01 | +0,03 | −0,31 |
| 0,50 | tt 27 | −0,09 | +0,01 | −0,00 | +0,06 | +0,11 | −2,37 |
| 0,50 | ff −40 (inválido: testigo) | −0,09 | −0,11 | +0,44 | −0,02 | +0,22 | −1,49 |
| 0,50 | ss 85 | +0,26 | −0,03 | +0,05 | +0,16 | +0,38 | **−4,58** |
| 0,50 | ff 85 | +0,19 | **+3,07** | −0,06 | −0,07 | −0,02 | −0,72 |
| 1,00 | tt 27 | +0,29 | −0,16 | +0,03 | −0,06 | +0,20 | **+21,60** |
| 1,00 | ff −40 | −0,49 | +0,25 | +0,38 | +0,16 | +0,45 | −0,14 |
| 1,00 | ss 85 | +0,77 | −0,09 | −0,31 | −0,01 | +0,30 | **+45,53** |
| 1,00 | ff 85 | +0,38 | +0,86 | −0,03 | +0,12 | +0,05 | −1,42 |
| 2,00 | tt 27 (inválido: testigo) | +1,45 | −0,30 | −0,13 | +0,01 | −0,97 | **+179** |
| 2,00 | ff −40 | −0,48 | −0,30 | +0,02 | +0,27 | +0,44 | **+161** |
| 2,00 | ss 85 | +1,03 | −0,42 | −0,27 | +0,19 | −2,97 | **+138** |
| 2,00 | ff 85 | +4,04 | −0,88 | −0,61 | +0,71 | +1,48 | **+120** |

| # | Predicción | Veredicto |
|---|---|---|
| A1 | L = 0,50 cumple W1 en las 4 esquinas | **falsa**: +3,07 % a 1 nA en ff 85 y −4,58 % a 10 µA en ss 85 |
| A2 | L = 1,00 cumple de 1 nA a 1 µA y falla a 10 µA | **cumplida**: ≤ 0,86 % hasta 1 µA en las 4 esquinas; +21,6 y +45,5 % a 10 µA |
| A3 | L = 2,00 falla ya a 1 µA | **falsa**: a 1 µA queda dentro (peor −2,97 %); falla a 10 µA |
| A4 | Testigo +1 % entre −1,2 y −0,8 % | **falsa**: 22 de 24 |
| A5 | Sin corriente, ningún flanco en 20 ms | **cumplida**: 12 de 12 |

**Muere el lector de una sola precarga:** ninguna L cumple W1, W3 y W4. Por la regla escrita, **dos rangos con dos precargas**.

**Lo que los datos sugieren (exploración, no veredicto):** L = 1,00 cubre de 100 pA a 1 µA en las 4 esquinas dentro de 0,9 %,
y L = 0,15 cubre de 10 nA a 10 µA dentro de 2,7 %. Se solapan dos décadas. Queda por probar, con prerregistro propio y
corrientes que no sean las de calibración: los dos rangos, la Q del rango bajo con desajuste y con la alimentación movida, y
si un pulso de precarga más largo en el rango bajo devuelve la Q completa.

## Qué explicación aburrida no descarté

- Que la linealidad del bloque D se rompa con alambre real.
- Que la Q reducida del lector 2 con L = 1,00 haga la calibración inestable de chip a chip.
- Que los dos testigos fallados del bloque A sean algo más que ruido numérico (no repetí esos decks con otro paso).
- La causa del 0,0055 % del control del Monte Carlo.
