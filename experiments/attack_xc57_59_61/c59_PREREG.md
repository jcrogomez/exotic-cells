# c59 — Prerregistro del ataque a XC-59 (escritura eléctrica, borrado térmico)

Hora: Thu Nov 12 19:04:20 EST 2026 (de `date`). Escrito ANTES de literatura y corridas. Todo **de memoria** / cálculo a mano.

## Qué voy a hacer
(e) Leer cinética BTI/HCI en óxidos 3–5 nm y recocido. Modelo de regímenes: ley de potencias con aceleración por campo para ΔVt,
TDDB para la ruptura, Arrhenius (con dispersión de Ea) para el recocido. (f) Modelo térmico: calefactor de poly/li junto a un
transistor en silicio masivo (línea de calor sobre óxido + semiespacio de silicio) y variantes. (g) Mapa.

## Tautologías
- T1. El canal del transistor está EN el silicio (k ≈ 150 W/m·K). Una fuente lineal de P' W/m sobre un semiespacio da
  ΔT ≈ (P'/πk)·ln(L/r): con 1 mW/µm (¡1000 W/m!) son ~10 K. Para +200…+400 K harían falta > 20 mW/µm. El calefactor está sobre
  0,3–0,9 µm de óxido: él se calienta, el silicio no. **Esto se deduce sin correr**; la corrida solo pone el factor.
- T2. Arrhenius con ν = 1e13 /s: Ea 1,5 eV ⇒ τ ≈ 16 min a 200 °C, 1,6 s a 300 °C, 17 ms a 400 °C. Lo decide Ea (dato a leer).
- T3. Calentar el dado entero por fuera (horno, 250 °C) no necesita calefactor: el "borrado térmico" existe como operación de mesa.

## Predicciones
| # | Cosa | Predicción |
|---|---|---|
| P1 | NBTI pfet 4 nm a 1,8 V (4,3 MV/cm), 25 °C | 0,3–3 mV en 10³ s; 1–10 mV a 125 °C |
| P2 | A 3,3 V (8 MV/cm) | 10–100 mV en 1–10³ s; vida de TDDB horas–años |
| P3 | A 5 V (12 MV/cm) | > 100 mV en < 1 s y ruptura en 1e-3–1e3 s: región de fallo |
| P4 | Fracción recuperable sola a 25 °C | 30–70 % en 1e3 s (BTI); HCI < 10 % |
| P5 | Recocido de la parte "permanente" | 250–350 °C minutos la borra casi toda (> 80 %); Ea 1–1,6 eV con dispersión |
| P6 | Precedente | Existe: "polyheater" (Infineon/TU Wien) y flash con calefactor integrado (Macronix). La idea no es nueva como técnica |
| P7 | Transistor masivo con calefactor de poly a 0,5 µm, alimentado a 1,8 V | ΔT del canal < 5 K por cada 10 mW; **no llega** a +200 K con ≤ 100 mW |
| P8 | Calefactor mismo (poly/li, 5–6 mA) | Llega a 600–1000 K él solo (b05); el cuello de botella es el silicio, no el calefactor |
| P9 | Elemento sobre óxido de campo (no en el silicio) junto al calefactor a 0,5 µm | Sí llega a +200 K con pocos mW; τ < 2 µs |
| P10 | Niveles | Ventana reversible 3–50 mV ⇒ 10–160 pasos de 0,305 mV; limitados por la recuperación espontánea (deriva log t) |

## Qué la mata / qué la deja viva
- "Calefactor al lado borra un transistor masivo": muere si ΔT del canal < 100 K a la potencia máxima creíble (barrido 1–300 mW).
- "Ciclo escritura eléctrica/borrado térmico": muere solo si la literatura dice que el recocido no devuelve Vt (no lo espero);
  vive con borrado en horno/placa (vehículo de mesa) o con el elemento subido al óxido de campo.
- Escritura: muere a 1,8 V si ΔVt < 0,305 mV en 1e4 s en todo el intervalo leído; vive a 3,3 V si hay pin o bomba.
