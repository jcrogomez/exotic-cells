# d27 — Prerregistro del ataque a XC-27 (red de hoyos en reflexión)

Escrito el 2026-11-12 22:35 EST (misma marca de `date` que `d26_PREREG.md`), antes de correr grcwa y antes de buscar literatura.
Predicciones **DE MEMORIA** salvo cita.

Pila (PDK local, `DATOS_PROCESO.md`): 1,376 µm de dieléctrico entre silicio y met1; met1 0,36 µm (Al con barrera de Ti/TiN o
Ti/TiW por debajo, cuál no es público → se barre: Al desnudo, con TiN, con Ti). Índices: Si ≈ 3,55; óxido ≈ 1,45; Al ≈ 1,2 + 10i
a 1100 nm (de memoria; se sustituirán por valores de literatura leída).

## Qué voy a calcular y qué predigo

| # | Cosa | Cómo | Predicción |
|---|---|---|---|
| Q1 | Fracción de la emisión isótropa que sale del silicio al óxido | Cono de escape (ángulo crítico asin(1,45/3,55) ≈ 24°) × Fresnel | ≈ 3–4 % de todos los fotones (un hemisferio) |
| Q2 | Reflectancia de met1 liso visto desde el óxido a 1100 nm | Fresnel multicapa | Al desnudo 0,90–0,95; con Ti/TiN debajo 0,4–0,7 |
| Q3 | Red de hoyos cuadrados (lado ≥ 0,38 µm) en met1, paso 0,4–2 µm: reflexión total y reparto en órdenes, luz desde abajo | grcwa, incidencia normal y oblicua, dos polarizaciones | Reflexión total 0,6–0,9 (baja con la fracción abierta); órdenes difractados propagantes en el óxido solo si paso > λ/n ≈ 0,76 µm (incidencia normal). Con paso ≥ 1 µm, 5–30 % de la potencia reflejada va a órdenes ≠ 0 |
| Q4 | Qué fracción de la fotocorriente ÓPTICA del fotodiodo viene de la tapa, y cuánto cambia entre tapas | Monte Carlo de rayos con el resultado de Q3 + recogida de `d26` | Tapa lisa frente a sin metal: 1–30 % de la señal óptica. Red frente a lisa: 0,1–10 % de la señal óptica |
| Q5 | Eso frente al piso | Q4 × señal de `d26` | Con señal óptica ≈ 3 fA (centro de `d26`): diferencia entre tapas ≲ 0,3 fA, ≥ 500 veces bajo el piso de 150 fA. En el escenario optimista (100 fA), ≲ 10 fA |
| Q6 | Capas de bloqueo de relleno en SKY130 y si Tiny Tapeout las admite | grep del PDK local y de `tt-support-tools` local (solo lectura) + búsqueda | Existen capas de bloqueo de relleno por metal en el PDK (de memoria: `fillblock`/`obsm`); Tiny Tapeout `[?]` — predigo que el precheck no las tiene en la lista de capas admitidas o que no garantizan nada porque el relleno lo pone el integrador |

## Qué mataría la idea

- Que la diferencia entre la red y la tapa lisa sea < 1 % de una señal óptica que ya está bajo el piso en todos los escenarios de
  `d26` (entonces no puede leerse en este par), **y** que no aparezca otra geometría donde el metal mande.
- No la mata que la red se comporte como espejo liso a paso mínimo: eso ya está en el plan.

## Qué la dejaría viva

- Una geometría enviable en la que la vía por la tapa sea ≥ 30 % de la señal detectada y la red cambie esa vía ≥ 2×, con señal
  total ≥ piso; o la variante de transmisión con luz externa (no se ataca aquí).

## Tautologías

- T1. La luz que entra en el silicio desde el óxido se refracta a ≤ 24° de la vertical: lo que devuelve la tapa baja casi recto.
  El alcance lateral de la tapa se gana en el óxido (2 × 1,376 µm × tan θ), no en el silicio.
- T2. Portadores y luz directa por el silicio son iguales bajo las cinco tapas solo si las tapas no cambian la unión ni la
  capacidad; la diferencia entre tapas es como mucho la fracción de luz que pasa por el óxido (Q1 ≈ 3–4 % de la emisión).
- T3. Con paso < λ/n no hay órdenes propagantes a incidencia normal: la red es un espejo de reflectancia efectiva menor.

## Criterio de abandono

Si grcwa no converge (la reflexión total cambia > 10 % al doblar el número de armónicos) doy el intervalo entre resoluciones y no
un número.
