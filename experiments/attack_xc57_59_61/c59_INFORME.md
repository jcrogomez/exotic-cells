# c59 — Informe del ataque a XC-59 (escritura eléctrica, borrado térmico)

Cierre: Thu Nov 12 19:16 EST 2026 (hora de `date`). Prerregistro: `c59_PREREG.md` (antes de leer y de correr).
**Nada es silicio: modelo, cálculo y lectura.** La literatura la abrió un agente de búsqueda, no yo: **LD** (abrió el PDF),
**LD-fig** (leído a ojo de una gráfica, ±20 %), **LR** (resumen), **NL** (fragmento). **PDK** = PDK local. **Corrida** = script
de esta carpeta. La cinética NO está calibrada en SKY130: todo son intervalos y escenarios.

## 0. Veredicto por escenarios

- **"Un calefactor de poly o de li al lado recuece un transistor en silicio masivo": MUERE en todo el barrido, y por un factor
  grande.** Al canal le llega el 3–8 % de la subida del calefactor (dos calefactores a 0,21–1 µm; li encima: 3–4 %). Para +200 K
  en el canal el calefactor tendría que estar a +2400…+6200 K. No depende de ningún dato de proceso sin publicar: lo decide que el
  silicio conduce cien veces mejor que el óxido. Con calefactor a +700 K (ya cerca de dañarse) el canal sube 20–60 K.
- **"El ciclo escritura eléctrica / borrado térmico existe": SOBREVIVE, con antecedente leído**, pero el calor tiene que venir de
  otro sitio: placa u horno sobre el dado entero (vehículo de mesa), o un calefactor de vatios (lo publicado: ~55 K/W, 4,2 W para
  +250 K, LR), que no cabe en Tiny Tapeout.
- **Escritura por polarización de puerta (pfet): TRANSFORMADA.** A 1,8 V da 0,5–4,5 mV en 10³ s (2–15 pasos del lector) y a 3,3 V
  4–34 mV, pero el 75 % se va en 1 s y el 90 % en 10³ s a temperatura ambiente. No necesita borrado térmico: se borra sola. Es
  una traza analógica volátil, no una memoria.
- **Escritura por portadores calientes (nfet): es la que da ventana y retención** (250–450 mV leídos; ~77 % queda al año en el
  modelo), y es justo la que NO se borra con poco calor: 90 % de borrado pide ~6 min a 400 °C, 0,24 s a 600 °C o 2,5 ms a 800 °C.
- **Lo que sí se calienta con un calefactor vecino es lo que está sobre el óxido de campo**: un elemento de poly entre dos
  calefactores a 0,21 µm recibe el 74 % (+200 K con 3,2–3,7 mA por calefactor, 5–6 µm de largo a 1,8 V). La familia se transforma
  en "escritura y borrado térmicos de un elemento de poly" (territorio de XC-39 y XC-51), o se queda con borrado en mesa.

## 1. Resultado contra cada predicción

| # | Predicción | Resultado | |
|---|---|---|---|
| P1 | pfet a 1,8 V, 25 °C: 0,3–3 mV en 10³ s | 1,5 mV central, intervalo 0,5–4,5 (extrapolación de 2,2 nm SiON, `c59_2_regimenes.txt`) | cumplida, pero es extrapolación, no dato de 4 nm |
| P2 | 3,3 V: 10–100 mV en 1–10³ s; ruptura en horas–años | 4,5 mV a 1 s, 11 mV a 10³ s (3,7–34). Ruptura: **sin fuente leída** | parcial (borde bajo); ruptura abierta |
| P3 | 5 V: > 100 mV en < 1 s y ruptura en 10⁻³–10³ s | por polarización 18–44 mV (15–132); por portadores calientes sí 250–450 mV (LD, de Jong 2018). Ruptura: sin fuente | **fallada** para la polarización sola |
| P4 | recuperable sola 30–70 % en 10³ s; portadores calientes < 10 % | polarización: queda 26 % a 1 s y 10 % a 10³ s (modelo con la distribución leída); "remanente muy pequeño" en 3,7 nm (LD). Portadores calientes: 9 % perdido en 1 h | **fallada** (mucho más volátil); cumplida en portadores calientes |
| P5 | 250–350 °C minutos borra > 80 %; Ea 1–1,6 eV | polarización: 10 s a 300 °C devuelve a virgen (LD). Portadores calientes: Ef 1,39 eV, σ 0,37 (LD); 60 s a 300 °C deja 38 %; hace falta 350–400 °C una hora | cumplida para polarización; **fallada** para portadores calientes |
| P6 | hay antecedente | Calefactor de poly junto al dispositivo, hasta 400 °C, retardo ~1 ms (LD, Pobegen y Grasser 2013). Flash con calefactor, > 800 °C en ms (NL). Recocido por puerta en 1 ms (NL) | cumplida |
| P7 | canal < 5 K por 10 mW; no llega a +200 K con ≤ 100 mW | +200 K pide 29–50 mW **por µm** y calefactor a +2400…+6200 K (`c59_1_termico.txt`) | cumplida |
| P8 | el calefactor solo llega a 600–1000 K | +400 K con 4,0–4,7 mA; +700 K con 5,3–6,2 mA (6–7 MA/cm²) | cumplida |
| P9 | elemento sobre óxido a 0,5 µm: +200 K con pocos mW, τ < 2 µs | a 0,5 µm: 46 %, 3,4–4,6 mW/µm; a 0,21 µm: 74 %, 1,9–2,7 mW/µm; difusión en el óxido 0,13 µs (cálculo) | cumplida a 0,21 µm; a 0,5 µm sale ~15–20 mW, no "pocos" |
| P10 | ventana 3–50 mV, 10–160 pasos | polarización a 3,3 V: 37 pasos al escribir, ~3 al día siguiente. Portadores calientes: 820–1475 pasos, con deriva de 39 mV el primer día | cumplida en el número; la retención lo cambia todo |

## 2. Cinco columnas

| Dato del PDK | Evidencia leída (por agente) | Parámetro supuesto | Simulación | Conclusión física |
|---|---|---|---|---|
| óxido 4,148 nm (nfet) y 4,23 nm (pfet) (`…nfet_01v8__tt.pm3.spice` l. 62; `…pfet…` l. 86) | 2,2 nm SiON a −2,7 V: ~10 mV a 1 s, 20–30 mV a 10³ s (LD-fig); degradación ∝ E^3,3; exponente de 1/6 a 0,03 (LD, Pobegen y Grasser 2013). ΔVth absoluto en 3–5 nm: **no encontrado** | escalado ∝ espesor; intervalo ×/÷3 | 1,8 V: 0,6 mV a 1 s, 1,5 a 10³ s. 3,3 V: 4,5 y 11 mV. 5 V: 18 y 44 mV | A 1,8 V la escritura por polarización roza el paso del lector (2–15 pasos): visible, no cómoda |
| — | Emisión: μ 0,71 eV, σ 0,29 eV, τ₀ 10⁻¹⁵ s (LD, en SiO₂ de 30 nm). Pendiente de recuperación 2,8–4,4 mV/década; meseta ~1 mV (LR) | que valga para 4 nm | queda 26 % a 1 s, 10 % a 10³ s, 5 % al día, 1,5 % al año (25 °C); a 125 °C, 4,6 % a 1 s | Volátil. El calor solo acelera lo que ocurre solo: 125 °C bastan |
| — | nMOS 4,5 nm, Vds 4,5 V, 3 ks: 250–450 mV; recocido de 7200 s por escalón: ~50 % queda a 175–200 °C, ~0 a 350–400 °C; ajuste Ef 1,39 eV, σ 0,369 (LD, de Jong 2018). Polarización positiva: sin corrimiento medible (LD) | frecuencia de intento efectiva 1,6·10¹¹ /s, calibrada al punto "50 % a 460 K" | 90 % borrado: 26 h a 300 °C; 6 min a 400 °C; 6 s a 500 °C; 0,24 s a 600 °C; 2,5 ms a 800 °C. Retención a 25 °C: 77 % al año | La ventana grande pide temperaturas que un transistor en silicio masivo no alcanza con un calefactor vecino |
| — | Sobre ~300 °C largo se crean defectos (2,4× a 350 °C, LD, Grasser 2016); sobre 450 °C Vt sube y ya no se repara (LD, de Jong) | — | — | Hay techo térmico: la región de fallo también existe por arriba en temperatura |
| poly a 0,326 µm del silicio; zona activa al nivel del fondo del poly (`sky130A.tech` l. 5048–5052); li a 0,936 µm | Calefactor de poly publicado: ~55 K/W, 4,2 W para +250 K, 6 W para +235 K (LR, tesis Aichinger); gradiente < 1 °C con +225 K (LD) | k_ox 1,0–1,4; k_si 150; sección 2D anclada a 6 µm (el silicio es orden de magnitud) | canal: 4,3–8,2 % (0,21–0,5 µm), 3,2–4,4 % (1 µm), 1,5–2,1 % (3 µm); li encima 3–4 %. Fuente 3D de radio 1–5 µm: 60–600 mW para +200 K | Coherente con lo publicado: para calentar silicio hacen falta vatios |
| n+ poly 48,2 Ω/□ ⇒ 96,4 Ω/µm a 0,5 µm | Corriente límite del poly: recorte por pulsos (antecedente en `attack2_xc05/b05_INFORME.md`) | — | calefactor +400 K: 1,5–2,1 mW/µm, 0,38–0,45 V/µm ⇒ 4–5 µm de largo con 1,8 V | El calefactor es fácil; lo difícil es que el calor llegue al silicio |
| — | Ruptura de 4 nm: **nada leído con cifras**. Solo: umbral ~5 V para liberar hidrógeno por electrones calientes (LD, Stathis) | tensión que rompe en 1 s entre 4,5 y 6,5 V; 1,0–2,5 décadas/V (**de memoria**) | 3,3 V: 16 s a 3 años; 5 V: 0,06 s a 1,6 h | No decide: es el dato que falta |

## 3. Mapa de regímenes (campo de estrés, temperatura de recocido, tiempo)

| | Sin efecto útil | Ciclo reversible (tercera región) | Daño permanente |
|---|---|---|---|
| **Estrés de puerta, pfet** | ≤ 1,8 V (4,3 MV/cm) con lectura tardía: 0,5–4,5 mV que se van en segundos–horas | 3,3 V (8 MV/cm), 1–10³ s: 4–34 mV (12–110 pasos al escribir); se borra sola (10 % a 10³ s) o con 125–200 °C en 1 s | 5 V (12 MV/cm): ruptura entre 0,06 s y 1,6 h según el escenario `[?]`; a 3,3 V no se puede excluir en horas |
| **Portadores calientes, nfet** | Vds 1,8 V nominal: `[?]`, sin número leído para L = 0,15 µm | Vds ~3,3–4,5 V durante 10³ s: 250–450 mV (en 4,5 nm, L 0,6–1 µm); retención de años | Subumbral degradado (80 → 133 mV/década leído) que no vuelve si se recuece sobre 450 °C |
| **Recocido** | < 125 °C: solo la parte de polarización | 300–400 °C, 10 s (polarización); 350–400 °C, 1 h o 600–800 °C, ms–s (portadores calientes; lo de ms es extrapolación del ajuste, no medida) | > 300 °C durante días, o > 450 °C una hora: defectos nuevos |
| **Calefactor en chip a 1,8 V** | transistor en silicio: +10…+60 K como mucho | elemento de poly sobre óxido de campo: +200…+400 K en < 1 µs con 10–20 mW | calefactor sobre ~+700 K (5–6 mA): se recorta él mismo |

Niveles distinguibles con paso de 0,305 mV: polarización a 3,3 V, 12–110 al escribir y 1–10 al día siguiente; portadores
calientes, 800–1500 nominales, pero la deriva del primer día (~13 % en el modelo) deja la resolución real en decenas de niveles
si se lee contra un gemelo sin escribir.

## 4. Lo nuevo

1. **El lector de XC-19 ve el corrimiento por polarización a 1,8 V si lee en el primer segundo** (0,6 mV = 2 pasos a 1 s). Eso
   es un experimento enviable hoy, sin calefactor ni sobretensión: escribir, leer la relajación durante décadas de tiempo. La
   recuperación es una distribución ancha de tiempos: sirve a XC-19 (trampas) más que a una memoria.
2. **El control "gemelo estresado sin calentar" del plan es el experimento principal**, no el control: en óxido delgado la
   recuperación sin calor domina.
3. **El calefactor vecino funciona para estructuras sobre óxido**, no para transistores: es un dato útil para XC-31, XC-39 y
   XC-51. Para XC-19 como "perilla de temperatura" da decenas de kelvin, no cientos.
4. Perilla de trampas para XC-52: los portadores calientes la dan (interfaz dañada de forma estable); el borrado es de mesa.

## 5. Configuraciones que más información darían

1. **pfet y nfet de XC-19 con estrés de puerta conmutable y lectura desde 10 µs hasta horas**, con gemelo sin estresar. Sin
   calefactor. Barrido: tres tamaños, tensión de estrés la que permita el vehículo.
2. **El mismo transistor entre dos calefactores de poly a 0,21, 0,5 y 1 µm** (y un calefactor de li encima): no para borrar, sino
   para medir cuánto sube el canal (el lector es el termómetro, 5 %/K) y cerrar el factor 3–8 % con silicio.
3. **nfet con drenaje accesible a tensión mayor** (si el vehículo lo permite) para escribir por portadores calientes; borrado en
   placa a 200–250 °C por etapas: el modelo dice que una hora a 200 °C borra la mitad.

## 6. Qué dato decide

Tiempo de ruptura del óxido de 4,15 nm a 3,3 V (no leído); corrimiento por portadores calientes del nfet de 0,15 µm a 1,8 V y a
3,3 V; qué tensión admite el vehículo sobre una puerta de 1,8 V; temperatura máxima del encapsulado para el borrado en mesa.

Archivos: `c59_PREREG.md`, `c_lib.py`, `c59_1_termico.py/.txt`, `c59_2_regimenes.py/.txt`.
