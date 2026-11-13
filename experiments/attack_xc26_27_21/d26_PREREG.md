# d26 — Prerregistro del ataque a XC-26 (enlace óptico interno)

Escrito el 2026-11-12 22:35 EST (hora de `date`: `Thu Nov 12 22:35:22 EST 2026`), antes de buscar literatura y antes de correr
nada. Leído hasta ahora: encargo, protocolo, `DATOS_PROCESO.md`, planes XC-26/27/21, `macros/photon/LEEME.md` y `emisor.tcl` /
`comun.tcl`, las dos pescas, rondas 1 y 2. Las predicciones de abajo son **DE MEMORIA** salvo donde se cita.

Geometría que se ataca (de `emisor.tcl`/`comun.tcl`): fotodiodo `photo` 3 × 3 µm en x 0..3; emisor p+ 1,0 × 1,4 µm dentro de un
pozo n de 4 × 3 µm cuyo borde está a d = 5/10/20 µm del photo (centro p+ a centro photo: 7,6 / 12,6 / 22,6 µm; control 44,4 µm).
Anillo p+ al sustrato de 0,6 µm a 0,5 µm del photo. Piso del lector 150 fA (modelo, 27 °C, 2²⁰ ciclos).

## Qué voy a calcular y qué predigo

| # | Cosa | Cómo | Predicción (de memoria) |
|---|---|---|---|
| P1 | Eficiencia de emisión en directa de una unión p+/pozo n de CMOS (fotones por electrón, dentro del silicio) | Literatura leída + cálculo propio B·N·τ con el tiempo de tránsito de la base del PNP vertical | Literatura: 10⁻⁶–10⁻⁴ interna en uniones CMOS dopadas; externa (lo que sale por arriba) 10⁻⁷–10⁻⁵. Cálculo propio para ESTA celda: 10⁻⁷–10⁻⁵, porque β ≈ 14 significa que el hueco cruza el pozo en < 1 ns y casi no le da tiempo a recombinar radiativamente |
| P2 | Longitud de absorción del silicio en la banda de emisión (≈ 1100–1150 nm) | Tabla de Green 2008 (leerla) | α(1100 nm) ≈ 3,5 cm⁻¹ → ≈ 3 mm; ponderado por el espectro de emisión, 1–5 cm⁻¹ |
| P3 | Fracción de los fotones emitidos que acaba como electrón recogido por el fotodiodo, a d = 5, 10, 20, 40 µm | Integración/Monte Carlo propio: emisión isótropa, absorción α, reflexión interna total arriba, cara trasera reflectante o no, y probabilidad de recogida del electrón generado (difusión con sumideros) | 10⁻⁴–10⁻³ a 5 µm; cae como ~1/d a 1/d² (no exponencial); a 40 µm 5–20 veces menos que a 5 µm |
| P4 | Fotocorriente óptica a 1 mA de emisor | P1 × P3 × I | 0,1–100 fA a 5 µm; centro ≈ 3 fA. **Por debajo del piso de 150 fA en casi todos los escenarios.** Los "pA" del replanteo del plan son 1–3 órdenes optimistas |
| P5 | Fracción de la corriente del emisor que llega al sustrato como huecos | β del PNP vertical del PDK (buscar en el PDK local) | β/(β+1) ≈ 0,9–0,95 |
| P6 | Subida del potencial del sustrato junto al fotodiodo a 1 mA | Resistencia de dispersión ρ/(2πr), ρ barrida 1–50 Ω·cm, y solución numérica con los taps dibujados | 10 mV–1 V según ρ y taps; sin guarda, cientos de mV a 1 mA con 10 Ω·cm |
| P7 | ¿Inyección de electrones minoritarios al sustrato? | Balance: si el pozo n del emisor queda a ≈ 0 V (resistencia en el ánodo) y el sustrato local sube > 0,4–0,5 V, la unión pozo/sustrato entra en directa (PNP saturado) | Sí, en la configuración "cátodo a masa" por encima de ~0,3–1 mA; no si el cátodo se mantiene alto (limitador en el lado bajo). Si ocurre, la corriente de electrones recogida supera a la luz por ≥ 10³ |
| P8 | Efecto del rebote de sustrato sobre el lector (fuga del excitador, umbral del inversor) | Estimación con el efecto cuerpo del modelo | Cambio de fuga de ~1–30 fA por 10–100 mV de sustrato: comparable o mayor que la señal óptica |
| P9 | Calor | ΔT = P/(2πkr) | ≈ 0,1–0,3 K a 5 µm con 1 mW: < 3 % del fondo; despreciable si el fondo real es el del modelo |
| P10 | Discriminantes | Leyes de distancia y tiempos | La ley exponencial NO sirve entre 5 y 40 µm (L de difusión de electrones en sustrato ≫ 40 µm); el retardo tampoco con un lector de 10 MHz (tránsito por difusión de decenas de ns). Lo que separa: pozo n en inversa interpuesto, ficticios de inyección, y posición del limitador |

## Qué mataría la idea

- Que en TODOS los escenarios defendibles (eficiencia interna ≤ 10⁻³ por literatura leída; corriente ≤ 20 mA, límite de la red de
  Tiny Tapeout) la fotocorriente óptica quede < 10 fA (el piso con 2²⁴ ciclos), **y** que la vía eléctrica no eliminable quede por
  encima de la óptica. Entonces el enlace no puede leerse con este lector: muere por lectura, no por física.
- No la mata que gane la difusión en la celda dibujada: eso ya es la predicción del plan.

## Qué la dejaría viva

- Un escenario con dato publicado leído en el que la señal óptica ≥ 150 fA con una geometría enviable (más corriente, emisor mayor,
  más fotodiodos, ventana más larga) y una secuencia de controles que deje la vía eléctrica por debajo.

## Lo que se deduce sin correr (tautologías)

- T1. El hueco inyectado que llega al sustrato es mayoritario: no difunde hasta el fotodiodo ni lo recoge un cátodo n. Cierto por
  construcción; lo que no dice el replanteo es que esa corriente (≈ 93 % de la del emisor) tiene que salir por los taps y eso es
  una caída óhmica.
- T2. Luz ∝ corriente del emisor (régimen lineal); cualquier ganancia por subir la corriente la comparte la vía eléctrica.
- T3. Un fotón de 1100 nm absorbido en cualquier punto del sustrato crea un electrón minoritario que se recoge por difusión: la
  "luz" y los "portadores" comparten el último tramo. Solo los separa lo que ocurre entre el emisor y el punto de absorción.
- T4. Con longitud de absorción de milímetros y distancias de micras, la fracción absorbida por micra de camino es ~3·10⁻⁴: el
  presupuesto óptico es pequeño por aritmética antes de cualquier detalle.

## Criterio de abandono del cálculo

Si P3 calculado con dos métodos (analítico y numérico) difiere en más de 5×, no doy número: doy intervalo y digo qué supuesto lo abre.
