# d27 — Informe del ataque a XC-27 (red de hoyos metálica en reflexión sobre el par de XC-26)

Escrito el 2026-11-13 (hora de `date` al cerrar: ver pie). Prerregistro: `d27_PREREG.md` (2026-11-12 22:35). **Todo es cálculo y
simulación; nada medido.** Grado de todo lo de este informe: **un agente** (sin verificador independiente).

Scripts y salidas: `d27_rcwa.py` → `d27_rcwa.txt/.json` (grcwa); `d27_caps.py` → `d27_caps.txt` (combina con la recogida de
`d26_fd2.py` → `d26_fd2.txt/.json`).

## 1. Qué se hizo

- Pila: Si / óxido 1,376 µm / met1 0,36 µm / óxido (PDK local, `sky130A.tech` l. 5058). Índices: Si 3,54 (Green y Keevers 1995 vía
  PVEducation, **leída**); óxido 1,45, Al 1,2+10,5i y 1,0+8i, TiN 1,9+5,6i (**de memoria, barridos**).
- Tapas: sin metal; Al liso; Al+TiN 25 nm; redes cuadradas de hoyos con paso 0,52–2,0 µm y lado 0,38 µm (0,14 µm², mínimo del
  precheck) hasta paso − 0,14 µm. Ángulos en el Si de 0 a 23,5° (cono de escape: θc = 24,2°), s y p, azimut 0 y 45°.
- Convergencia: red 1,0/0,5 a 10°: R_total 0,815 / 0,831 / 0,818 con 61/121/201 armónicos → ±2 % (criterio del prerregistro: 10 %).
  Comprobación: sin metal, R = 0,1754 = Fresnel Si/óxido exacto.
- Peso de cada dirección del cono en la recogida del fotodiodo: con la u(r) de la geometría dibujada (`d26_fd2`).

## 2. Resultados contra predicción

| # | Predicción | Resultado | Estado |
|---|---|---|---|
| Q1 | 3–4 % de los fotones salen al óxido | Cono 1 − cos 24,2° = 8,8 % de los que suben (≈ 4,4 % del total), × T ≈ 0,82 | cumplida |
| Q2 | Al desnudo 0,90–0,95; con TiN 0,4–0,7 | Al liso **0,95–0,97** a incidencia normal (interferencia en 1,376 µm de óxido); con TiN **0,89–0,91** | cumplida en Al, **fallada en TiN** (pesa menos de lo que creía) |
| Q3 | R total 0,6–0,9; órdenes ≠ 0 con paso > 0,76 | R total **0,04–0,93** según paso y lado (hoyos grandes, R baja: transmiten al óxido de arriba); órdenes no especulares hasta ~20 % de R | cumplida en lo cualitativo; intervalo más ancho |
| Q4 | Lisa vs sin metal 1–30 % de la señal óptica; red vs lisa 0,1–10 % | **Lisa vs sin metal: +2,9 a +4,0 %. Red vs sin metal: +0,2 a +3,0 %. Red vs lisa: −1 a −3,4 %.** La redistribución angular (peor caso) no añade > 0,1 % | cumplida (en el extremo bajo) |
| Q5 | Diferencia ≥ 500× bajo el piso | Depende de la señal óptica, que `d26` sube mucho: con 0,4–8 pA ópticos (`d26_scen.txt`), la diferencia lisa/sin metal es **~15–300 fA** | **fallada**: no es ≥ 500× bajo el piso en todos los escenarios |
| Q6 | Bloqueo de relleno: existe en el PDK; TT `[?]` | Existen `cmm1.waffleDrop` 62/24 (y FOM 22/24, poly 33/24, met2–5); el precheck local de TT las **admite en su lista de capas válidas** (subagente, leído; ver §4) | cumplida en parte |

## 3. Por qué el efecto es tan pequeño (tautología que se confirmó)

La tapa solo puede tocar la luz que sale del silicio: la que sube dentro del cono de 24,2°. Todo lo demás vuelve por reflexión
total en la interfaz Si/óxido, con o sin metal (la luz que tunela más allá del cono es e^(−8,9) a 26°: nada). En la recogida del
fotodiodo, el cono pesa **4,9 %** a 5 µm (`d27_caps.txt`). Con R entre 0,04 y 0,97 el cambio máximo es ≈ 0,049 × 0,8 ≈ 4 %. Y lo
que la red devuelve vuelve casi vertical (dentro del cono) junto al emisor, así que redirigirlo no cambia la recogida.

**Respuesta a (e): la tapa mueve la fotocorriente óptica un 1–4 %, no un 50 % ni un 0,01 %.** Red frente a lisa, 1–3 %; red
frente a red (periódica/desordenada/aperiódica de igual densidad), no calculado aquí pero acotado por debajo de esa cifra.

## 4. Relleno (g)

Del subagente de lectura (leyó archivos locales y páginas; sin ejecutar nada): capas `cmm1.waffleDrop` 62/24, `cfom.waffleDrop`
22/24, `cp1m.waffleDrop` 33/24, `cmm2–5` 105/52, 107/24, 112/4, 117/4 (`sky130A.lyp` l. 3722–5762; `sky130A.tech` l. 4106–4112);
62/24 bloquea también el relleno de li1 (`sky130A.tech` l. 2043–2052). `tt-support-tools/precheck/tech_data.py` l. 4–57 las lista
como válidas; prohibido solo met5. Ojo: Magic escribe por defecto la obstrucción de met1 como 68/98, que **no** está en la lista
(solo el estilo `origfill` escribe 62/24). Si ChipFoundry respeta el bloqueo en el relleno de nivel superior: `[?]`. Densidad
máxima de met1 0,77 en ventanas de 50 µm (m1.13): una tapa lisa de 20 × 90 µm la supera; habría que comprobarla `[?]`. Relleno sin
bloqueo: cuadrados de 2 µm a paso 2,8 µm y relleno fino hasta 0,3–0,5 µm del metal dibujado (estilo `wafflefill`, lectura del
subagente; sintaxis no contrastada).

## 5. Veredicto por sub-afirmación (escenarios)

| Sub-afirmación | Veredicto |
|---|---|
| "Cinco tapas cambian la fotocorriente" | **TRANSFORMADA:** cambian la componente óptica un 1–4 %. Medible solo si la señal óptica es ≥ ~5 pA (sustrato ≲ 1 Ω·cm o ánodo a 3,3 V en `d26_scen.txt`) **y** si dos copias iguales difieren < 1 %. Con la señal central de `d26` (0,4–2 pA) la diferencia queda en 5–80 fA: bajo el piso. Muere en los escenarios de sustrato ≥ 10 Ω·cm con 1,8 V |
| "El paso debe ser ~0,76 µm" | **SOBREVIVE como física, irrelevante como señal:** la R de la red sí depende del paso y del lado (0,04–0,93), pero el 95 % de la recogida no pasa por la tapa |
| "La red distingue periódica de desordenada (sombrero)" | **No observable en este par:** la diferencia entre redes de igual densidad está acotada por el 1–3 % anterior; el sombrero aquí no tiene palanca. Lo que queda del sombrero: la variante por transmisión (luz externa), sin atacar |
| (f) "otra geometría donde el metal mande" | **No hallada.** El óxido entre Si (3,54) y metal no guía (índice menor que el Si: modo con fugas). Un anillo de pozo que corte portadores no cambia el peso del cono. El metal mandaría solo con luz que entra desde arriba (transmisión) |
| Control de XC-26 | **SOBREVIVE, más útil de lo que parecía:** la tapa lisa sube la parte óptica un 3–4 % y no toca los portadores; es un discriminante de signo conocido, débil |

## 6. Configuraciones que más informan

1. Par `e05` con tapa lisa de met1 y el mismo par sin metal (con `cmm1.waffleDrop`), dos copias de cada: mide el 3–4 % si la
   señal óptica existe; si las copias difieren más, se sabe que esta familia no se puede leer en este vehículo.
2. Una sola red (paso 1,0, lado 0,38: R ≈ 0,8) frente a hoyos grandes (paso 2,0, lado 1,86: R ≈ 0,3): el mayor contraste entre
   redes de igual paso que da la simulación (≈ 2 %).
3. No dibujar las cinco tapas hasta que XC-26 vea luz.

Pie: cerrado tras `date` = ver `d26_INFORME.md` (mismo cierre).
