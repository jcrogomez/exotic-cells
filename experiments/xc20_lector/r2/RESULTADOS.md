# XC-20 · lector de rango ancho (R2) · resultados en esquemático: no sigue tal cual

Escrito el 2026-11-25 21:33 EST (`date`). Prerregistro: [`XC-20_2026-11-25_lector_rango_ancho.md`](../../../cells/preregistros/XC-20_2026-11-25_lector_rango_ancho.md);
sello en `PREREG_SHA256.txt`. 50 decks, ninguno abortó. `analiza_r2.py` → [`r2.txt`](r2.txt). Todo es modelo, en esquemático.

## Lo aburrido primero

- **Fallo mío en el análisis:** el testigo salía "sin dato" porque buscaba la corriente 1,01e-8 comparando decimales. Corregida
  la búsqueda; ningún criterio cambió.
- Fuente de corriente ideal; sin el divisor, sin ramas de selección, sin desajuste ni ruido.

## Veredictos, con las palabras del prerregistro

**Benchmark válido:** W0 (el control con 200 fF ideales repite la v4 dentro de 0,02 %) y W3 (el testigo de +1 % de corriente da
entre −0,94 % y −1,00 % de periodo en las 8 medidas).

| # | Resultado | Veredicto |
|---|---|---|
| W1 | de 1 nA a 10 µA dentro de ±3 %: tt 27 ≤ 0,91 %; ff −40 ≤ 0,57 %; ss 85 ≤ 2,67 %; **ff 85: +15,9 % a 1 nA** (≤ 0,31 % de 10 nA a 10 µA) | **FALSA** |
| W2 | 100 pA en frío y templado: +0,05 % y −0,00 % | cumplida |
| W4 | sin corriente, ningún flanco en 20 ms, 4 esquinas | cumplida |
| W5 | fuga ajustada: −0,03 pA (tt 27), −0,00 (ff −40), **−8,1 pA (ss 85)**, +28,8 pA (ff 85) | **FALSA** (a ss 85 predije entre +5 y +150) |
| W6 | tiempo muerto: 2,5 a 3,9 ns | cumplida |

Carga por ciclo ajustada: 131 a 153 fC según la esquina (frecuencias de ~0,5 kHz a 100 pA a ~58 MHz a 10 µA).

**No sigue: por la regla escrita, la precarga se rediseña antes de dibujar nada.**

## Dónde falla y dónde no

- Falla en una esquina y una década: ff 85, por debajo de 10 nA. Ahí la fuga de la precarga (decenas de pA) es comparable a la
  corriente y **no se comporta como una corriente constante**: el modelo de tres números no la describe.
- En las otras tres esquinas, y en ff 85 de 10 nA a 10 µA, el modelo acierta dentro de 2,7 % (dentro de 1 % a tt 27 y ff −40).
- A ss 85 el ajuste da una fuga negativa pequeña: el modelo está absorbiendo otra cosa `[?]`.

## Siguiente (prueba nueva, sin correr)

Precarga con menos fuga: canal más largo (L = 0,5 µm o más, como la precarga hvt del lector 1, que es 0,42/0,5) y la misma pila.
Predicción y criterios en un prerregistro aparte. Si el tiempo muerto crece, baja el techo de corriente; es el compromiso a medir.
