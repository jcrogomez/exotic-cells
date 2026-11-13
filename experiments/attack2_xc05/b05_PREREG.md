# b05 — Prerregistro del ataque de materiales a XC-05 (ronda 2)

Escrito: Thu Nov 12 13:30:05 EST 2026 (hora de `date`), antes de buscar literatura de esta ronda y antes de correr nada.
Leído hasta aquí: encargo, DATOS_PROCESO, RONDA_1, a05_INFORME y a05_c_termica.py, v1_VEREDICTO, PLAN de XC-05, LEEME de EFLD-00/01,
PLANTILLA, precheck_map, y del PDK las alturas y resistencias de `sky130A.tech` (l. 5052–5137), el tlef y los coeficientes térmicos.
Grados: PDK / corrida / leído / no leído / memoria / cálculo. Todo lo de abajo que no diga otra cosa es **memoria + cálculo mental**.

## Qué voy a hacer
1. `b05_1_met1.py`: resistencia por largo de las barreras de los dos apilamientos (barrido de ρ de Ti, TiN, TiW con el rango que LEA),
   ΔR de un vacío de 10–1000 nm, potencia y temperatura del puente de barrera (aleta 1D con G' de sección 2D propia) a 0,26 / 2,06 / 18,5 mA.
2. `b05_2_li.py`: sección 2D de una línea de li (0,17 × 0,10 µm a 0,936 µm del sustrato) y aleta 1D con cuello; driver con cumplimiento de tensión.
3. `b05_3_contactos.py`: densidad de corriente, potencia y ΔT de mcon y licon (resistencia térmica de esparcimiento, barrida).
4. `b05_4_tunel.py`: resistencia de túnel de una grieta frente a su abertura (Simmons a baja tensión), y no linealidad a ≤ 50–100 mV.
5. `b05_5_lector`: ngspice con modelos del PDK (Docker), lector Thévenin de baja tensión; transitorios de peor caso.
6. Literatura (agentes de búsqueda; solo cuenta lo que abran): resistividades; electromigración en Al con capas de derivación; TiN bajo
   corriente; fallos de contacto; recorte de poly por pulsos.

## Tautologías (se deducen ya, no son resultados)
- j = I/A: 2,06 mA en li 0,17×0,10 → 1,2·10⁷ A/cm²; en un contacto de 0,17×0,17 → 7,1·10⁶ A/cm²; en met1 0,14×0,36 → 4,1·10⁶.
- Una fuente de corriente sin limitación deja toda la alimentación sobre un dispositivo que se abre: el lector tiene que ser un
  equivalente Thévenin de tensión en vacío ≤ 50–100 mV, o no cumple. Con eso el límite se cumple en continua por construcción; lo
  único que puede violarlo son acoplos capacitivos y desfases de arranque. Eso es lo que hay que simular.
- Con barrera en paralelo, un contacto de pocos canales en el aluminio es invisible (ronda 1). En met1 "pocos canales" exige que
  la barrera también esté interrumpida.
- A ≤ 50 mV la no linealidad de un túnel con barrera de eV es de orden (V/φ)² ≲ 10⁻³: será ilegible. (Lo calculo, pero ya lo espero.)

## Predicciones numéricas
| # | Cantidad | Predicción |
|---|---|---|
| P1a | R' de barreras en paralelo, línea 0,14 µm, apilamiento Ti/AlCu/TiW | 60–400 Ω/µm; nominal ~130 |
| P1b | Ídem, Ti/TiN/AlCu/Ti/TiN | 30–250 Ω/µm; nominal ~70 |
| P1c | ΔR de un vacío de 10 / 100 / 1000 nm (nominal) | ~1 / 10 / 100 Ω (factor 2 entre apilamientos) |
| P1d | ΔT del puente a 2,06 mA | < 20 K con vacío ≤ 100 nm; 100–400 K con 1 µm |
| P1e | ΔT del puente a 18,5 mA | > 1000 K para vacíos ≥ 100–200 nm; aguanta solo ≲ 30–50 nm |
| P1f | Literatura | Encontraré que en líneas con capa de derivación el fallo es subida gradual de R (estado (a) documentado). No encontraré transporte no óhmico por grieta de barrera en una línea enterrada |
| P2a | li 0,17 µm, línea larga: G' y τ63 | 2–3,5 W/m·K; 0,1–0,5 µs |
| P2b | ΔT de li largo a 2,06 mA | 80–200 K |
| P2c | Cuello li 0,17 × 1 µm entre tramos de 0,5 µm, 2,06 mA | 30–100 K |
| P2d | Corriente para ΔT = 1000 K en li largo | 5–8 mA (≥ 20–32 `ebufn_4`); con 8 no se rompe |
| P2e | Literatura TiN | Aguanta > 10⁷ A/cm² (calefactores de memorias de cambio de fase); falla por calor, no por electromigración; oxidación a 500–800 °C sube R. No encontraré contacto atómico ni nanohueco de TiN por electromigración |
| P3a | Potencia a 2,06 mA: mcon 9,3 Ω / licon-poly 152 Ω / licon-n+ 185 Ω | 0,04 / 0,65 / 0,79 mW |
| P3b | ΔT: mcon / licon sobre difusión / licon sobre poly | < 5 K / 5–30 K / 100–400 K |
| P3c | Literatura contactos | El tungsteno no migra; el vacío nace en el Al sobre el tapón; en difusión, fuga o corto de unión. Poly: recorte por pulsos documentado (R baja, decenas de %) |
| P4 | Abertura de grieta que cae en 100 Ω–1 MΩ (área 0,14 µm × espesor de barrera, φ 1–4,5 eV) | 0,3–1,0 nm; 1,3 nm ya es > 1 GΩ |
| P5a | Lector Thévenin (riel de ~50 mV por divisor de poly, R serie conmutable, lectura por fuente de un nfet en inversión débil) | V sobre el dispositivo ≤ 55 mV en continua; picos capacitivos < 10 mV con 100 fF en paralelo |
| P5b | Arranque | Sobretensión < 5 mV con rampa de VDD ≥ 1 µs; puede fallar (> 100 mV) con rampa ≤ 10 ns |
| P5c | Salto 100 Ω → abierto en 1 ns | Sube monótono hasta el riel; sin rebase |
| P5d | Anillo con resistencia serie | No cumple < 100 mV en todo el rango 100 Ω–1 MΩ |
| P5e | Resolución | ≤ 5 % en R con tres rangos y piso de 0,3 mV |
| P6 | Medidas posibles con ese lector | Valor, saltos discretos en el tiempo y temperatura: sí. No linealidad y ruido de disparo: no |

## Qué mataría y qué dejaría viva la idea (por sistema, como escenarios)
- **Muere en un sistema** si, en todo el barrido de sus parámetros no públicos, no hay ningún estado final entre 100 Ω y 1 MΩ que no sea
  una resistencia difusiva corriente (más cuadrados del mismo material), o si la energía para llegar a él no existe a 1,8 V.
- **Muere la lectura** si no logro un circuito que mantenga < 100 mV en los cinco transitorios.
- **Vive** si en algún sistema hay un escenario físico (qué dato del proceso lo decide) con un estrechamiento o grieta ≤ 1 nm estable a
  300 K y dentro de la ventana, y un control que lo separe de un resistor.
- **Transformada** si lo que queda es otra función (resistencia programable, memoria) sin pocos canales.

## Criterio de abandono
Una iteración por script tras ver la primera salida (guardando la v1). Si ngspice no arranca en Docker en 15 min: cálculo con supuestos.
