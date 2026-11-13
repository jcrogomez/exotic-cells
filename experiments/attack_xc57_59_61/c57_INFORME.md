# c57 — Informe del ataque a XC-57 (unión Peltier)

Cierre: Thu Nov 12 19:15:58 EST 2026 (hora de `date`). Prerregistro: `c57_PREREG.md` (antes de leer y de correr).
**Nada es silicio: modelo, cálculo y lectura.** La literatura la abrió un agente de búsqueda, no yo: grados **LD** (abrió el PDF y vio
la cifra), **LR** (resumen), **NL** (fragmento). **PDK** = `local_flow/pdk_host/ciel/sky130/versions/8afc8346…/sky130A`.
**Corrida** = script de esta carpeta. Los números del modelo son intervalos sobre parámetros supuestos, no predicciones puntuales.

## 0. Veredicto por escenarios (una línea cada uno)

- **Componente impar (Peltier separable del Joule): SOBREVIVE** en todos los escenarios barridos: 70 mK a 3 K en la unión a la
  corriente óptima; 0,3–2,2 K a 100 µA. Con el Seebeck leído para poly n+/p+ (280–440 µV/K por par) el centro es ~0,6–1,2 K.
- **Enfriamiento neto bajo el sustrato: SOBREVIVE en el modelo**, estrecho: 0,3–0,5 K a 60–90 µA con S = 300 µV/K; 35–60 mK si
  S = 100; hasta 1,5 K si S = 500. Deja de enfriar sobre 45–290 µA. No es "refrigeración" útil: es una fracción de kelvin en ~1 µm.
- **Lectura con el termómetro en inversión débil: TRANSFORMADA.** El transistor vive en el silicio, que está térmicamente en corto
  con el sustrato: le llega el 0,7–3,4 % de la subida de la unión. La impar se ve, pero en 0,1–3 s, no en ms, y el acoplo eléctrico
  de la pista vecina puede ser mayor que la señal. Lectores mejores: termopila gemela sobre el mismo óxido (XC-40), o la variante
  de abajo.
- **Nuevo: Peltier en los contactos de una difusión p+.** El 750 µV/K es poly n / difusión p+ (no poly/poly). En ese par el calor
  se deposita en el silicio, justo donde está el termómetro: 8–31 mK impares a 0,5 µm con 30–110 µA (cálculo), comparable o mejor
  que la unión de poly vista desde el silicio, y sin capas especiales.
- **Unión directa poly p+/poly n+: no dibujable de forma legal** (rpm.8 y la regla de Magic de 0,4 µm); el poly p+ solo existe
  bajo RPM/URPM. Sería un diodo de poly, no un contacto. Queda como candidata para otro vehículo.

## 1. Resultado contra cada predicción

| # | Predicción | Resultado | |
|---|---|---|---|
| P1 | poly n+ −80…−200, p+ +100…+250; par 200–450 µV/K | n+ −110…−132; p+ +130…+330; par 279–440 (LD, Baltes y Paul 1996; Xie 2010) | cumplida |
| P2 | difusiones ±(50…200); pozo n −300…−1000 | p+ activa +430…+450 (NL/LR, Akin 1998, Olgun 1997); difusión n+ y pozo: no encontrado | **fallada** en p+ (el doble de lo que dije) |
| P3 | 750 µV/K no es poly n+/poly p+ | Es poly n (−320) / p+ activa en pozo n (+430), total 750 ± 35 (NL; la versión de congreso da −335/+450, LR) | cumplida; mi candidato ("pozo o poly poco dopado") **fallado** |
| P4 | longitud de curación 0,7–2 µm | 0,32–0,81 µm (`c57_2_fin.txt`): G' salió 3,7–5,7 W/m·K, no ~2 | **fallada** (por abajo) |
| P5 | impar a 100 µA: 0,1–2 K | 0,31–2,24 K (pata 0,5 µm, 2+2 contactos, S 100–500) | cumplida |
| P6 | neto máximo ideal 0,1–2 K a 50–300 µA | 0,06–2,8 K a 25–210 µA | cumplida en el centro; los extremos se salen |
| P7 | contactos reales reducen ≥ 3× | reducen 1,6–1,9× (0,31–0,53 K frente a 0,51–1,02 a S = 300) | **fallada** (a favor) |
| P8 | cadena no mejora ΔT; a 1 µm llega 5–30 % | cadena: no mejora, y con paso < 2 µm pierde (0,40 a 0,5 µm; 0,67 a 1 µm; 0,91 a 2 µm). A poly vecino: 10–35 %. **Al silicio: 0,7–3,4 %** | cumplida para poly; **fallada** para el transistor |
| P9 | 5σ en < 1 s, típico ms | 0,1–3 s con el transistor en silicio (solo ruido de disparo) | **fallada** |
| P10 | poly: 50/50 n+ único o dual | n+ en todo el poly normal (48,2 Ω/□ sin implante dibujado; pfet con vth0 = −1,06 V ⇒ puerta n+, inferencia). p+ solo en resistores bajo RPM+PSDM (320 Ω/□) o URPM (2000 Ω/□) | resuelta por el PDK |
| P11 | unión directa = diodo | No dibujable legalmente. Diodos laterales de poly leídos: n = 1,4, ruptura ~6 V (LD, Muro 2008), con un lado poco dopado. Degenerado en los dos lados: no encontrado | cumplida en lo leíble |

## 2. Cinco columnas

| Dato del PDK | Evidencia leída (por agente) | Parámetro supuesto | Simulación | Conclusión física |
|---|---|---|---|---|
| poly 0,18 µm a 0,326 µm del silicio (`sky130A.tech` l. 5052; 106,13 aF/µm², l. 5302) | SiO₂ 1,25 ± 0,1 y 1,1 W/m·K (LD, Baltes 1996; Xie 2009) | k_ox 1,0–1,4 | G' = 2,9–5,7 W/m·K para 0,15–0,5 µm; 8,8–12,1 para 2 µm (`c57_1_gprima.txt`) | La pata de poly está 2–3× mejor anclada al sustrato que una línea de li |
| n+ poly 48,2 Ω/□ (l. 5119); p+ 319,8 y 2000 Ω/□ (l. 5114–5115); contacto a poly 152 Ω (l. 5134) | poly n+ −111…−132 µV/K a 25–32 Ω/□; p+ +190 a 215 Ω/□ y +330 a 425 Ω/□ (LD). k del poly 17–31 W/m·K (LD); hasta 37–57 en capas gruesas (LD, McConnell 2001) | S del par 100/300/500 µV/K; k_poly 15/30; G_j del puente de li 1–3 µW/K | Tabla de `c57_2_fin.txt`: I_opt 13–300 µA; neto 35 mK–1,7 K; longitud de curación 0,3–1,1 µm | ΔT_max ∝ S²/(ρ·k), casi independiente de G' y del ancho (tautología T1, confirmada: k_ox no mueve el neto) |
| p- poly 2000 Ω/□ | S mayor a más resistividad (tendencia en los datos de Baltes) | mismo S | neto 7–350 mK: **peor** que el p+ de 320 Ω/□ | La resistividad gana a S: la pata p buena es `res_high_po`, ancha |
| li 12,8 Ω/□ | Peltier observado en contactos de TiW (LR); en TiN: no encontrado | S del li ≈ 0 `[?]` | n+ poly / li: neto 0,23–0,32 K a ~100 µA con S_n = 100 µV/K | Una sola pata de poly n+ contra li rinde casi como el par y no pide RPM |
| contacto a difusión p+ 585 Ω (l. 5131); difusión p+ 197 Ω/□ | p+ activa +430…+450 µV/K (NL/LR, en otro proceso) | S 200–440; fuente puntual en semiespacio, k_si 150 | 8–31 mK impares a 0,5 µm con 30–110 µA; enfriamiento neto hasta 103–226 µA (`c57_3_difusion.txt`) | El calor Peltier depositado EN el silicio se lee mejor con el MOS que el de una unión sobre óxido |
| lector: 5,2 %/K, 0,55 %/conversión, 0,18 ms (`xc19_weak_inversion`, `xc19_noise`) | Poly-SiGe lateral: 2,1 K bajo ambiente medidos (NL, Wijngaards 2005). Enfriamiento neto con poly puro: **no encontrado** | fracción al silicio 0,7–3,4 % (sección 2D, anclaje a 6 µm: orden de magnitud) | 5σ: 0,25 s (1 K, f = 0,02) a 25 s (100 mK); 2500 s con 10 mK | Legible, lento; 10 mK en la unión ya no es práctico con este lector |

## 3. Mapa de regímenes

Parámetro: **corriente** (y, detrás, S²/ρk del material).

| Región | Corriente (unión n+ poly 0,5 µm / p+ poly 0,5–2 µm) | Qué pasa |
|---|---|---|
| Convencional | > 45–290 µA (según S y geometría; 120–360 con S = 300) | El Joule domina: la unión solo calienta. La impar sigue ahí (2,7 K a 300 µA con S = 300) pero montada sobre 6 K pares |
| Tercera | 10–150 µA | Un sentido enfría bajo el sustrato (35 mK–1,5 K), el otro calienta el doble. Tensión total < 0,4 V con patas de 5 µm |
| Bajo el piso | unión < ~50 mK impares (≈ < 5 µA) | El termómetro MOS no la saca en < 100 s |
| Fallo | ~3–6 mA (3–7 MA/cm² en el poly, +200…+700 K: `c59_1_termico.txt`) | Recorte o daño del poly; muy lejos de la zona útil |

Geometría: el paso entre uniones opuestas debe ser ≥ 2 µm (a 0,5 µm se pierde el 60 %); más allá de 5 µm no gana nada. Agrupar N
uniones no sube ΔT: solo agranda la zona fría. Todo es enviable (poly, resistores de poly del PDK, li).

## 4. Lectura y explicaciones aburridas

- **Acoplo eléctrico (la más seria).** Al invertir la corriente cambia el potencial del nudo de la unión, que está a 0,2–1 µm del
  canal del lector; un paso del lector son 0,305 mV en la puerta y la señal térmica es 0,03–0,18 % (un quinto de paso o menos).
  Remedio de diseño: igualar la resistencia de las dos patas para que la unión quede a V/2 en los dos sentidos, y la cadena
  intercalada como control (mismo potencial, Peltier cancelado). Sin eso el resultado no se interpreta.
- **Asimetría del driver:** con 1 % de diferencia entre sentidos, la impar falsa es 1,2 mK a 30 µA y 13 mK a 100 µA, frente a
  275 y 917 mK (0,4–1,5 %). No es el problema; crece como I².
- **Thomson:** impar solo a orden I³; 2·10⁻⁴ del Peltier a 30 µA y 2·10⁻³ a 100 µA (orden de magnitud). Se distingue por la ley
  de potencias: la impar debe ser lineal en I.
- **Tiempo a 5σ** (solo ruido de disparo): 0,1–3 s para 0,3–1 K en la unión y 2–3 % de acoplo.

## 5. Poly en SKY130 (pregunta d)

- Tipos: poly normal n+ 48,2 Ω/□; `res_high_po` p+ 319,8 Ω/□ = POLY ∩ POLYRES ∩ RPM ∩ PSDM ∩ NPC (`sky130A.tech` l. 3121–3127);
  `res_xhigh_po` 2000 Ω/□ bajo URPM (l. 3130–3134). El PSDM sobre poly normal (puertas de pfet) no lo vuelve p: vth0 del
  pfet = −1,06 V (`sky130_fd_pr__pfet_01v8__tt.pm3.spice` l. 94) es lo que da una puerta n+ sobre pozo de 1,7·10¹⁷ (cálculo
  mío: −1,26 V con n+, −0,14 V con p+). **Inferencia**, no dato.
- Unión directa: rpm.8 "poly must not straddle rpm" (`sky130A.lydrc` l. 314) y Magic "Distance from precision resistor to poly
  < 0,4 µm, touching_illegal" (`sky130A.tech` l. 4359). El deck reducido del precheck solo comprueba rpm.1a y rpm.2
  (`sky130A_mr.drc` l. 515–525), así que el rechazo lo daría Magic. **No lo corrí**: es lectura de reglas.
- Que la fundición prohíba cruzar el borde de RPM es coherente con que ahí se formaría un diodo p+/n+ de poly. En otro vehículo
  sería un XC nuevo (diodo/túnel de poly, pariente de XC-20): con los dos lados degenerados no hay nada leído.

## 6. Configuraciones que más información darían

1. **Par de cadenas gemelas sobre óxido de campo**, n+ poly 0,5 µm / `res_high_po` 2 µm unidas por li, paso 5 µm, patas de igual
   resistencia; una con las uniones frías agrupadas y otra intercalada. Sensor: una termopila de XC-40 tendida junto a las uniones
   (10–35 % de acoplo), no el transistor.
2. **Resistor de difusión p+ con un lector MOS a 0,3–0,5 µm de cada contacto** (y uno en el centro como control): la impar debe
   tener signo contrario en los dos extremos y ser nula en el centro. No necesita capas especiales.
3. **n+ poly contra li, sin pata p**: separa S del poly n+ de SKY130 (dato de proceso que falta) y sirve de control de material.

## 7. Qué dato de proceso decide

Seebeck y conductividad térmica del poly n+ y p+ de SKY130 (no hay ninguna medida publicada: buscado, no encontrado); Seebeck de la
difusión p+; Seebeck del li.

Archivos: `c57_PREREG.md`, `c_lib.py`, `c57_1_gprima.py/.txt`, `c57_2_fin.py/.txt`, `c57_3_difusion.py/.txt`.
