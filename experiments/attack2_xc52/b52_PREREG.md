# b52 · Prerregistro del ataque 2 a XC-52 (+ XC-56, XC-25): presupuesto magnético completo

Hora de `date`: Thu Nov 12 13:27:36 EST 2026. Escrito después de leer el encargo, los cuatro PLAN, el informe a52, el veredicto v1,
RONDA_1 y DATOS_PROCESO; **antes** de releer la literatura para la dinámica y antes de escribir o correr ningún script.
Todo lo que sigue es predicción: de memoria o por cuenta de servilleta sobre los números de la ronda 1.

## Qué voy a calcular, y qué predigo

### T1 · Dinámica (lectura + cálculo `b52_dinamica.py`)
- P1a. Los experimentos publicados modulan el campo a audiofrecuencia (0,1–10 kHz), por la bobina del electroimán, no por la física.
- P1b. En el diodo con puerta (dc-IV) la respuesta al campo la limita el tiempo de captura SRH, τ = 1/(σ·v·n) con
  n ≈ ni·exp(qVF/2kT). Predicción: a VF = 0,30–0,35 V, τ = 10 µs–1 ms (σ 1e-16–1e-15 cm²) → corte 0,2–15 kHz; a VF = 0,50 V,
  τ = 0,5–6 µs → corte 25–300 kHz. **Es decir: modular a ≥ 1 MHz (lo que la ronda 1 propuso para librarse del calor) mata la
  señal del dc-IV en todo el rango de VF donde ΔI/I es grande.** No hay ventana libre para el dc-IV con bobina de un devanado.
- P1c. En bombeo de carga cada ciclo es independiente: la señal sigue al campo hasta ~f_cp/2 (MHz). Ahí sí hay ventana (1–5 MHz),
  pero con la señal relativa pequeña (1e-7–1e-5).
- P1d. La vida del par de espines (lo que fija la anchura, no la banda) es de ns a decenas de ns: anchura 0,1–1 mT ↔ 1/(γ·ΔB) = 6–60 ns.
- Consecuencia predicha: la salida no es la frecuencia sino la bobina de dos devanados a potencia constante, que permite modular
  a 0,1–10 kHz.

### T2 · Identificación frente a magnetismo clásico (`b52_clasico.py`)
- P2a. Magnetorresistencia ordinaria (µB)²: con µ = 0,05–0,14 m²/V·s y B = 2 mT: 1e-8–8e-8. De 3 a 4 órdenes bajo la señal (3e-5–3e-4).
- P2b. Hall sobre la corriente del diodo: impar en B y sin terminal transversal → 0 a primer orden; desvío de la corriente ~µB = 1e-4–3e-4
  de ángulo, efecto en la corriente total de segundo orden (1e-8).
- P2c. La forma de la señal de espín satura (lorentziana de anchura 0,3–1,5 mT); todo lo clásico va como B o B² sin saturar entre −2 y +2 mT.
  Predicción: con 9 puntos de campo entre −2 y +2 mT, un ajuste distingue «lorentziana que satura» de «parábola» con razón de
  verosimilitud > 5σ en < 4× el tiempo de la detección simple.
- P2d. Con 2 mT de alcance solo se ve el 60–95 % de la amplitud (según anchura 0,5–1,5 mT).

### T3 · Dos devanados (`b52_bobinas.py`, Biot–Savart propio de segmentos finitos)
- P3a. Entrelazadas en el mismo plano (met3), 3+3 vueltas, pista 1,5, interior libre 10 µm: modo suma 0,15–0,22 mT/mA; modo cancelado
  residuo 0,5–3 % en el centro.
- P3b. Apiladas met3/met4 (misma huella): suma 0,18–0,24 mT/mA por par; residuo de cancelación 4–8 % por la diferencia de altura
  (2,88 frente a 4,12 µm), y sube < 1 punto porcentual con 0,2 µm de desalineación entre capas.
- P3c. Potencia: idéntica en los dos modos por construcción (mismas dos resistencias en serie); la diferencia la pone el puente:
  ΔP/P = 1e-3–1e-2 por desajuste de R_on. Residuo térmico: (70–440 mK)·(5,8 %/K)·ΔP/P = 4e-6–3e-4 → **puede igualar a la señal;
  es el artefacto que el esquema no cancela solo**.
- P3d. Acoplo eléctrico: al invertir un devanado su perfil de tensión se refleja; el potencial medio ponderado sobre el dispositivo cambia
  10–60 mV (caída I·R de ~0,1–0,2 V por devanado). Carga inyectada por transición sobre un nodo con 0,1–1 fF de acoplo: 6–400 e.
  Frente a la señal por semiperiodo (10 pA·0,5 ms·1e-4 = 3 e): **10–100× mayor si no se borra la transición**; con reinicio del
  integrador tras cada transición, cero a primer orden.
- P3e. Inductancia 0,3–3 nH por devanado; L/R < 1 ns. fem en un lazo de lectura de 10×10 µm al conmutar 2 mT en 1 ns: ~0,2 mV durante 1 ns
  (2e-13 V·s): despreciable y borrada.
- P3f. No cancela: (i) desajuste del puente (potencia y camino de la corriente de alimentación), (ii) perfil de tensión del devanado
  invertido, (iii) cualquier efecto magnético clásico real (lo separa la forma, no el esquema), (iv) transitorios.

### T4 · Escenarios de trampas (`b52_escenarios.py`)
- P4a. Virgen: Dit 1e9–1e11 cm⁻² eV⁻¹ (lo que haya en lo leído). 10×10 µm: I_rec 1–100 pA; señal 0,03–30 fA; T(5σ, disparo) de 20 s a días.
- P4b. Estrés: portadores calientes con 3,3 V de drenaje sobre el transistor de 1,8 V pueden dar ΔDit 1e10–1e12 en horas (de memoria, `[?]`);
  a 1,8 V nominal, < 1e10 en horas. Con estrés de puerta (campo ≤ 8 MV/cm a 3,3 V sobre 4,15 nm) ΔDit 1e10–1e11 en horas `[?]`.
- P4c. Estructuras con más defectos de nacimiento: borde de aislamiento ×2–10 la densidad de la cara plana `[?]`.
- P4d. El ruido 1/f no manda si la modulación va a ≥ 100 Hz y la corriente es de recombinación (esquina 1/f < 100 Hz `[?]`): factor ≤ 2.

### T5 · Lector (`b52_lector.py`)
- P5a. El piso de 150 fA (2²⁰ ciclos a 10 MHz, 0,105 s) equivale a ~50 fA/√Hz: 30× peor que el disparo de 10 pA (1,8 fA/√Hz). Con ese lector
  tal cual, T(5σ) para 1 fA de señal: horas. Hace falta integrar más carga por conversión.
- P5b. Arquitectura predicha: integración en condensador de 0,1–1 pF hasta ΔV ~ 0,5 V, conteo, reinicio síncrono con la bobina
  (cada reinicio borra la transición). kTC por reinicio: 64–200 µV → 1e-4–4e-4 relativo por conversión: comparable al disparo por
  conversión (N = 3e5–3e6 e → 1,8e-3–6e-4). El disparo manda o empata.
- P5c. Resolución relativa necesaria: 1e-5 (5σ sobre 5e-5) → ≥ 2,5e11 electrones integrados = 40 nC: a 10 pA, 67 min; a 1 nA, 40 s.

### T6 · Geometría
- P6a. Canal completo (bobina doble ~35×35 µm, dispositivo 10×10, puente de 10 mA, gemelo de referencia, placa Hall bajo bobina gemela,
  integrador): 5e3–2e4 µm², es decir 30–125 % de... `[?]` no sé el área útil de la tesela de memoria; la busco.
- P6b. Caída en la alimentación: 10 mA × ~5 Ω = 50 mV, igual en los dos modos (potencia constante): deja de ser artefacto síncrono.

## Qué mataría la idea (por escenario, no en bloque)
1. Dinámica: si la banda de la señal queda por debajo de la frecuencia a la que el calor se filtra **y** el residuo de la bobina de potencia
   constante supera la señal sin forma de calibrarlo → muere el dc-IV con bobina integrada. (El bombeo quedaría.)
2. Si algún artefacto no cancelado tiene la misma forma en B (par, centrado en cero, satura a ~1 mT) y es mayor que la señal → muere.
   Si es par pero no satura, no muere: lo separa el barrido.
3. Si en todos los escenarios de trampas alcanzables sin irradiar T(5σ) > 1 día por punto de campo → muere como experimento de un chip.
4. Si el canal completo no cabe en una tesela → transformada (necesita más teselas), no muerta.

## Qué la dejaría viva
Existe una combinación (escenario de trampas alcanzable × modo de lectura × frecuencia) con T(5σ) ≤ 1 h por punto y artefactos pares
por debajo de 1/3 de la señal o separables por la forma.

## Tautologías (se deducen sin correr)
- La señal absoluta va con Dit·A; la relativa no. Ya en a52.
- A potencia constante el calor medio es igual en los dos modos: lo único que puede quedar es desajuste.
- T(5σ) de disparo = 100·q/(I·δ²): ya verificado (v1 C5). Solo cambia I y δ por escenario.
- (µB)² a 2 mT con µ ≤ 0,14 es ≤ 8e-8: es aritmética; lo que falta es comprobar que no hay un término lineal clásico par (no lo hay:
  un término lineal es impar).
- El bombeo saturado responde ciclo a ciclo: su banda es la frecuencia de bombeo.
- Con 2 mT de alcance y anchura Γ, la fracción vista de una lorentziana es B²/(B²+Γ²): 94 % (Γ 0,5), 64 % (Γ 1,5).

## Criterio de abandono de la exploración
Tres búsquedas sin texto abierto sobre un dato → `[?]` y se barre. No encadeno más de dos refinamientos de un modelo sin calibrar.
