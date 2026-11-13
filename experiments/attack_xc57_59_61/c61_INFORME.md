# c61 — Informe del ataque a XC-61 (oscilador por congelación de portadores)

Cierre: Thu Nov 12 19:16 EST 2026 (hora de `date`). Prerregistro: `c61_PREREG.md` (antes de leer y de correr).
**Nada es silicio: cálculo y lectura.** La literatura la abrió un agente de búsqueda, no yo: **LD** (abrió el PDF), **LR**
(resumen), **NL** (fragmento). No hay simulación de dispositivo: sin perfil de dopado no decidiría nada (criterio de abandono del
prerregistro). Lo único corrido es la estadística de ionización (`c61_1_congelacion.py`).

## 0. Veredicto por escenarios

- **"Pocos V/cm": MUERE como cifra** (es de germanio). En silicio lo leído es 125–240 V/cm a 18–37 K con 5·10¹³ cm⁻³, y
  ~1,2·10⁴ V/cm a 4,2 K en el cuerpo de un transistor (este último sin leer). No mata la idea: con 1,8 V sobre 1–10 µm hay
  1800–18 000 V/cm. El campo sobra; decide la temperatura.
- **"Característica en S con oscilación espontánea por ruptura de impurezas en silicio masivo": ABIERTA.** No se encontró
  documentada con números (lo publicado es germanio p y GaAs n). Lo que sí está medido en silicio es otra estructura.
- **TRANSFORMADA en: diodo p+-n-n+ en directa a 4,2 K que dispara pulsos** (Coon y Perera, leído): pulsos de más de 3 V,
  conmutación en < 100 ns, frecuencia proporcional a la corriente sobre 7 décadas. El mecanismo es el de la ficha (ionización por
  impacto de los donadores congelados de la región n), con inyección desde el contacto. En SKY130 esa estructura es una difusión
  p+ en un pozo n con su toma n+: trivial.
- **Los pozos de SKY130 se congelan** en el cálculo: pico de 4–6·10¹⁷, bajo la transición de Mott (3,5–4·10¹⁸). Portadores libres
  bajo 10⁻³ a 21–47 K. A favor, leído en otro proceso de 0,18 µm: la resistencia del pozo n sube de golpe a 4,2 K. En contra: a
  4–6·10¹⁷ la conducción por saltos entre dopantes puede dejar el estado apagado con fugas; Coon y Perera no dan el dopado de su
  región n (no encontrado). **Ese es el dato que decide.**
- **A 77 K: MUERE el oscilador; queda un observable modesto.** Pozo ionizado al 4–32 %, sustrato al 58–66 %: congelación parcial,
  sin biestabilidad. Lo leído coincide: congelación "débil" a 77 K, visible sobre todo en las extensiones poco dopadas del
  drenaje, donde la resistencia se recupera con campo.
- **Vehículo: criostato de 4 K.** SKY130 ya se ha medido a 4 K (NIST: 118 transistores; contenido no obtenido), así que la lectura
  con lógica del propio chip es plausible.

## 1. Resultado contra cada predicción

| # | Predicción | Resultado | |
|---|---|---|---|
| P1 | campo umbral 100–1000 V/cm a 4–10 K, 10¹⁵–10¹⁶ | 125–240 V/cm a 18–37 K con 5·10¹³ (LD, Lawaetz y Proctor 1980); 1,2·10⁴ V/cm a 4,2 K en transistores (NL) | cumplida en dopado bajo; **por debajo** de lo que parece hacer falta a 10¹⁷ |
| P2 | sustrato no público, p, 10¹⁴–10¹⁶; pozos 5·10¹⁶–5·10¹⁷ | sustrato: **no público** ("Bulk, EPI" en un fragmento). Pozo n pico 6,0·10¹⁷, fondo 8,0·10¹⁴, 1,1 µm; pozo p pico 4·10¹⁷ a 0,42 µm (LR, documentación de SkyWater) | cumplida; el pozo n queda un poco por encima de mi rango |
| P3 | 50 % de ionización: 10¹⁵ a 45–60 K; 10¹⁷ a 90–130 K | 8·10¹⁴: 69–73 K; 10¹⁷: 94–124 K (`c61_1_congelacion.txt`) | **fallada** en el sustrato (más caliente); cumplida en 10¹⁷ |
| P4 | n/N < 10⁻³: 10¹⁵ a 18–25 K; 10¹⁷ a 25–35 K | 8·10¹⁴: 29–31 K; 10¹⁷: 28–40 K; 6·10¹⁷: 21–45 K | **fallada** en el sustrato; cumplida en 10¹⁷ |
| P5 | a 77 K: pozo 10–40 %, sustrato > 60 %, sin S | pozo n 6·10¹⁷: 5–32 %; pozo p 4·10¹⁷: 4–20 %; 8·10¹⁴: 58–66 %. Literatura: congelación débil a 77 K (LD, Li 2019) | cumplida (el sustrato, en el borde) |
| P6 | hay antecedente de pulsos en Si a 4 K | Coon y Perera 1987 (LD); bloqueo de frecuencias en fracciones de Farey (LR). Kink a 4,2 K por congelación de sustrato y de extensiones (LD) | cumplida |
| P7 | estructura: p+/pozo n/toma n+; toma/sustrato/toma | Sí, y además el PDK trae un resistor de pozo p aislado en pozo n profundo, `res_iso_pw`, 3050 Ω/□ (`sky130A.tech` l. 81, 5105, 6065) | cumplida, con una estructura más |
| P8 | la lógica funciona a 4 K; SKY130 medido en frío | SKY130 a 77 K: 22 transistores, Vth y corriente suben (LR). A 4 K: existe modelo y medidas (NL) | cumplida en existencia; sin números |
| P9 | kHz–MHz | 1 kHz–100 MHz por cálculo de R·C; leído: periodo = R·C de carga, conmutación < 100 ns | cumplida (es cálculo) |

## 2. Cinco columnas

| Dato del PDK | Evidencia leída (por agente) | Parámetro supuesto | Cálculo | Conclusión física |
|---|---|---|---|---|
| `ndep` 1,7·10¹⁷ en nfet y pfet (modelos, l. 68 y 88): es parámetro de ajuste, no perfil | Pozo n 6,0·10¹⁷ pico, fondo 8,0·10¹⁴; pozo p 4·10¹⁷ (LR). Mott: 3,5·10¹⁸ (P), 4,0·10¹⁸ (B) (NL) | compensación 1 %; energía de ionización fija (45 meV) o reducida por dopado (fórmula de memoria): las dos | T de 50 %: 103–206 K (pozos), 69–73 K (8·10¹⁴). T de 10⁻³: 21–47 K y 29–31 K | Todo el silicio activo de SKY130 salvo difusiones y poly se congela por debajo de ~20–45 K |
| pozo p 4400 Ω/□, pozo n 950/1700, pozo p aislado 3050 (`sky130A.tech` l. 5102–5105) | 0,18 µm: pozo n "subida abrupta a 4,2 K"; pozo p baja hasta 77 K (LD, Li et al. 2019) | sin conducción por saltos | pozo p aislado: ×4 a 77 K, ×180 a 30 K, ×10¹⁰ a 10 K (cota superior) | La cota de 10 K no vale: los saltos entre dopantes la recortan. Cuánto: `[?]` |
| 1,8 V; distancia mínima p+ a toma n+ en pozo `[?]` (no medida aquí) | Si:P 5·10¹³: ruptura a 125–240 V/cm, retardo 0,5–1,5 ms, congelado "bajo 50 K" (LD). Cuerpo de transistor: 1,2·10⁴ V/cm a 4,2 K (NL) | — | 1,2·10⁴ V/cm son 1,2 V sobre 1 µm y 12 V sobre 10 µm; 125 V/cm son 0,125 V sobre 10 µm | Con 1,8 V el tramo congelado útil es de ~0,3 a ~1,5 µm si el pozo se comporta como 10¹⁷; de hasta 100 µm si se comporta como silicio poco dopado |
| diodo p+/pozo n (`diode_pd2nw_05v5`) | p+-n-n+ a 4,2 K: apagado ~100 fA/mm², encendido ~10 mA/mm², pulsos > 3 V, < 100 ns, umbral ~0,5 pA (LD) | que el pozo de 6·10¹⁷ haga de "región n" | con 10 fF–1 pF y 1 MΩ–1 GΩ: 1 kHz–100 MHz | A 1,8 V el diodo en directa a 4 K necesita ~1,1 V solo para inyectar: queda poco margen `[?]` |
| — | 77 K: congelación débil, sobre todo en extensiones de drenaje; su resistencia sube bajo ~100 K y se recupera con campo (NL/LR, Hafez 1995). SKY130 a 77 K: sin mención de kink ni histéresis (LR, Beall) | — | a 77 K, n/N del pozo 0,04–0,32 | A 77 K hay no linealidad con el campo, no biestabilidad |

## 3. Mapa de regímenes

Parámetro: **temperatura**, con el campo como segundo eje.

| Región | Dónde | Qué pasa |
|---|---|---|
| Convencional | > ~100–200 K (pozos), > ~70 K (sustrato) | Resistencias que bajan al enfriar por movilidad; transistores más rápidos, umbral más alto |
| Transición | 30–100 K (77 K incluido) | Congelación parcial: resistencia de pozo que sube y depende del campo. Legible, monótona, sin memoria |
| Tercera | < ~20–45 K (4 K con seguridad) y campo sobre el umbral (0,1–12 kV/cm según dopado) | Ruptura reversible: conmutación apagado/encendido de hasta 11 décadas, pulsos, histéresis. Con carga R·C, tren de pulsos |
| Imitación | misma zona | Autocalentamiento que descongela: es lento (ms o más) y depende de la potencia, no del campo. Lo leído ya trae retardos de ms: hay que barrer la anchura de pulso |
| Fallo | no aplica | No hay daño; el límite es que el estado apagado tenga fugas por saltos y no haya contraste |

## 4. Estructuras y lectura

| Estructura | Estado | Qué prueba |
|---|---|---|
| Difusión p+ en pozo n propio, con toma n+ a 0,3–10 µm (p+-n-n+ en directa) | trivial, enviable | La de Coon y Perera. Barrido de distancia = barrido de campo |
| Resistor de pozo n (`res_generic_nw`) entre dos tomas n+ | primitiva del PDK | Ruptura por impurezas "pura" (sin inyección de minoritarios) en n |
| Resistor de pozo p aislado (`res_iso_pw`) | primitiva del PDK | Lo mismo en p, con los dos terminales libres |
| Sustrato entre dos tomas p+ | ya presente | **No sirve en este vehículo**: el sustrato es la masa común y no se puede polarizar un extremo |
| Resistor de poly n+ como carga | primitiva | Referencia que no se congela (degenerado) |

Lectura a 4 K: pines analógicos para la curva corriente–tensión; en chip, resistencia de carga de poly más un inversor y un
contador (los pulsos leídos superan 3 V con su polarización; a 1,8 V la amplitud es `[?]`). Que el multiplexor y las celdas de
entrada/salida de Tiny Tapeout funcionen a 4 K: `[?]`.

**A 77 K (nitrógeno líquido, accesible):** las tres estructuras dan R(T) y R(campo). Predicción: R del pozo ×0,5 a ×4 respecto a
300 K (la movilidad sube y compite con la congelación) y una no linealidad con el campo de unos pocos por ciento `[?]`. Es un
negativo informativo barato para la oscilación y un dato de proceso gratis (dopado efectivo del pozo).

## 5. Configuraciones que más información darían

1. **Tres diodos p+-n-n+ con distancia p+ a toma n+ de 0,3; 2 y 10 µm**, cada uno en pozo propio, con terminales a pines.
2. **`res_iso_pw` y `res_generic_nw` de 2, 10 y 50 µm**, a pines, con un resistor de poly n+ al lado como referencia.
3. Uno de los diodos con carga de poly e inversor a contador, para ver si el pulso se lee sin instrumento externo.

## 6. Qué dato decide

Dopado del pozo en el camino de corriente (superficie frente a pico de 4–6·10¹⁷) y si a ese dopado el estado apagado aguanta; dopado
de la región n de Coon y Perera (no encontrado); resistividad de la oblea de SKY130 (no pública); acceso a un criostato.

Archivos: `c61_PREREG.md`, `c61_1_congelacion.py/.txt`.
