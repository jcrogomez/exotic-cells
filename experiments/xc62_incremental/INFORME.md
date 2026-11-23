# xc62_incremental · informe

Prerregistro: [`PREREG.md`](PREREG.md), escrito a las 09:27:44 EST del 2026-11-22, antes del código. La corrida fue de 09:31:51 a
09:33:33 EST (`date`). Salida: `resultados.txt`, `resultados.json`, `t3b_geometrias.txt`. Para regenerarla:
`../../../.venv/bin/python xc62inc.py .` desde esta carpeta (~2 min, ~2 GB de RAM pico).

**Modelo, no silicio.** Todo lo que sigue es respecto al modelo de `c62_litho.py`: óptica supuesta, sin resina, sin grabado,
sin OPC. Los cuatro ajustes son escenarios de **iluminación**. Los escenarios A/B/C de OPC de `c62_INFORME.md` no están
implementados en ningún código.

## Resultado contra el prerregistro

| | Predicción | Observado | |
|---|---|---|---|
| T1 copia del modelo | idéntica a `c62_litho.txt` | 56/56 filas y 4/4 umbrales idénticos en texto; `image_cached` idéntica bit a bit a `image()` | cumplida |
| T2 300 píxeles × 2 ajustes | ≤ 1e-10 | máx abs(ΔI) = 2,7e-15 | cumplida |
| T3a 14 casos × 4 ajustes | L ≤ 1e-9 µm, dVeq ≤ 1e-6 mV | 1,7e-16 µm; 4,3e-14 mV | cumplida |
| T3b 60 geometrías encadenadas | igual | 59 evaluadas: 1,8e-15 en I, 3,9e-16 µm, 4,6e-13 mV. La que falta se marcó y no se evaluó (ver abajo) | cumplida |
| T4 velocidad | 30–300× | 59× desde cero, 61× al mover una vecina (528 ms con FFT y pupilas en caché frente a 9,0 y 8,6 ms); 64× frente a `c62` literal (581 ms) | cumplida |
| T5 memoria | ~0,5 GB por forma | 0,22 GB por forma, porque se guarda solo la ventana de desplazamientos necesaria; 7–8 formas por ajuste, 2,0 GB de RSS pico | **fallada** (por abajo): predije la rejilla completa, implementé el recorte |
| T6 escala | completa ∝ N² log N; incremental independiente de N | FFT 97–103 ms (N = 512) → 526 ms (N = 1024); incremental 2,4 ms (18 000 px) y 5,8 ms (44 800 px) para los dos N | cumplida |

**La recurrencia de T3b** (`xs = (−0,495, 0, 0,32)`, barra a 0,075 hasta x = 0,8, NA 0,60 σ 0,8). La barra une la puerta con la
vecina. El ancho impreso en el borde de la difusión llega a 0,511 µm y el cruce de umbral cae fuera de la ROI de ±0,4 µm. El
evaluador lo marcó, como estaba previsto. Con la FFT completa da L(+0,21) = 0,511 µm y dVeq = −19,7 mV. Es una puerta que deja
de ser una puerta, no un error del método.

## Respuesta a la primera mitad de la pregunta

Sí: **con exactamente el mismo modelo** se evalúan unas 60 geometrías por cada una que se evaluaba antes. El acuerdo es de
redondeo de máquina (≤ 5e-13 mV) y el coste no depende del tamaño de la caja. El precálculo es de ~0,5 s por forma y por
ajuste, y se amortiza a partir de la primera evaluación. No hizo falta PNGF ni Woodbury: en este modelo (máscara fina de
Kirchhoff) no hay dispersión múltiple, así que la respuesta de cada forma se suma sin más. Woodbury es para cuando el diseño
cambia el operador: calor, Laplace, EM real.

Lo que esto **no** dice: nada sobre la OPC de la fábrica, ni sobre si alguno de los cuatro ajustes ópticos es el de SkyWater.
Explorar más rápido un modelo sin calibrar no lo calibra.

## Límites del evaluador

- Solo formas rectangulares fijas que no se solapen (`c62` hace `clip`). Si dos se solapan, se recurre a la FFT completa. Los
  píxeles sueltos sí funcionan (T2).
- ROI de ±0,4 × ±0,7 µm; orígenes de forma en x ∈ [−1,3, 1,3], y ∈ [−1,8, 0,6]. Fuera de ahí, FFT completa, marcada.
- Se calcula un ajuste óptico por vez para no pasar de ~2 GB.

## Etapa 2 (sin correr; requiere su propio prerregistro)

Elegir un conjunto de geometrías cuyas lecturas separen hipótesis, con un control de selección al azar con el mismo
presupuesto. Antes de escribirlo hay que fijar tres cosas:
1. Qué hipótesis: hoy el modelo solo tiene cuatro iluminaciones y un umbral. La OPC (A/B/C) habría que modelarla, al menos
   como sesgo de borde parametrizado, y eso es un supuesto nuevo, no un dato.
2. Qué lectura de MISFIT: corriente en inversión débil convertida en tiempo por el contador, con el desajuste de 17,3 mV
   (`docs/CLAIMS.md`), réplicas por variante y ruido del lector.
3. Además del criterio de información, conservar los candidatos que maximizan la señal (dVeq) aunque no sean los más
   informativos.
