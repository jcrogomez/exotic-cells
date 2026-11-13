# v2_PLAN — verificador independiente, ronda 2 (escrito Thu Nov 12 19:05:29 EST 2026)

Leído hasta ahora de las carpetas vetadas: SOLO `attack2_xc52/b52_bobinas.py`, líneas 1–30 (cabecera, constantes) y 66–92 (`build`, `resist`, `outer`),
más un `grep` de nombres de parámetros que mostró títulos de líneas `P(...)` sin resultados numéricos del agente
(salvo literales escritos en el código: "10,2 mA", "70 mK/1,25 mW", que no son los números a verificar). Hora: 19:03 EST (de `date`).
Geometría deducida para C1: G3 cruzada, N=4, w=1,5 µm, s=0,3 µm, borde interior a 7 µm (es la que usa la última sección del script; lo cruzo con
R = 0,60 mW / (5,4 mA)² = 20,6 Ω). Nada más abierto. Literatura (A2, A4, resistividades de B1): dos subagentes solo-web, sin acceso a las carpetas.

Código propio: `v2_calc.py` → `v2_salida.txt`. Reutilizo de v1 solo mi solver térmico 2D (`thermal`) y F_{1/2}.
Constantes de Si de memoria (no leídas hoy): eps_r 11,7; Eg 1,12; ni 1e10; Nc 2,8e19; Nv 1,04e19–3,1e19.

## Predicciones propias antes de correr (a mano)
- A1: perfil N_D = min(Npk, N0·10^(−x/L)), N_A espejo; N0/Npk ∈ {1; 0,3; 0,1} (no sé cuánto se solapan las colas en una unión "pegada"). Poisson en
  aproximación de vaciamiento resuelto numéricamente, V = Vbi + 1,8. BTBT local: G = A·E^P·exp(−B/E) con tres juegos de memoria
  (Hurkx/Kane indirecto A=4e14, P=2,5, B=1,9e7; Schenk-tipo A=3,5e21, P=2, B=2,25e7; Kane E1 A=1,1e27,P=1,B=2,13e7), área 1,4 µm × 0,1 µm.
  Predicción a mano: ~50 nA (5e19, 35 nm/déc) a ~40 µA (2e20, 10 nm/déc) con N0=Npk; más bajo con N0<Npk.
- A3: en equilibrio, dopado neto en los bordes de vaciamiento vs umbral de degeneración (Nc·F(0), Nv·F(0)); anchura de túnel Eg/(q·Emax) y W.
  Predicción: con 10 nm/déc y ≥1e20 (N0=Npk) los bordes SÍ son degenerados (W≈7 nm, neto en borde ≈5e19): la condición necesaria no mata; lo que
  decide es la densidad de corriente de pico frente a la corriente de exceso (no modelable aquí).
- B1: R' = 1/(w·Σ t_i/ρ_i); Ti 60–150, TiN 50–400, TiW 60–120 µΩ·cm (de memoria; lo coteja el subagente). Predicción: ~60–400 Ω/µm; central ~100–140.
- B2: R = 12,8·L/0,17 → 75 Ω (1 µm), 151 Ω (2 µm). 2D FD propio (óxido bajo li 0,61–0,94 µm, k 0,8–1,4) → R_th'; cota alta sin conducción por
  extremos; cota baja con aleta y extremos a T ambiente; 3D por función de Green con imagen. Predicción: cuello 1 µm, ΔT de 200 a 2000 K; línea
  5 µm a 1,8 V ΔT 500–950 K; 10 µm 130–240 K.
- B3: RC de primer orden: sin sobreimpulso, cota V_th. Acoplo: divisor capacitivo 1,8·Cov/(Cov+Cnodo) como cota, y R·Cov·dV/dt si el flanco es lento.
  Predicción: +7 mV con 50 fF; +70…300 mV con 1–5 fF de nodo.
- C1: Biot–Savart propio con 9 filamentos por pista, centro, z = 0 (Magic) y z = 0,3262. Predicción: 0,33–0,40 mT/mA; R ≈ 21 Ω; P ≈ 0,6 mW.
- C2: (µB)²: 4e-10 a 7,8e-8; con coeficiente de MR 0,03–1 baja hasta ~1e-11.
- C3: sqrt(2qI) = 69,3 fA/√Hz; σ = S·sqrt(1/(2T)) = 151 fA con T = 0,1049 s.
- C4: sympy. D1: aritmética.

Criterios: los del encargo. Abandono: si A1 depende >4 décadas de N0/Npk lo digo como límite del modelo, no lo afino.
