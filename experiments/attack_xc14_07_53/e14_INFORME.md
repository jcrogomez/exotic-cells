# e14 — Informe del ataque a XC-14 (nodo flotante: antena, túnel, escritura)

Abierto el 2026-11-13 07:30 EST (hora de `date`). Prerregistro: `e14_PREREG.md` (2026-11-12 22:33:58). El ataque se cortó el
12-nov hacia las 22:40 por falta de créditos y se reanudó el 13-nov a las 07:15; las corridas son todas del 13-nov. Los tres
subagentes de literatura del 12-nov murieron sin entregar; la literatura de este informe la leí yo (lista en §6). Un solo agente:
nada de esto está verificado por un segundo.

Grados: **PDK** (local, con ruta) · **LEÍDO** (abrí el texto) · **LEÍDO-FIG** (leído a ojo de una figura) · **NO LEÍDO**
(fragmento o resumen) · **DE MEMORIA** · **SUPUESTO** (parámetro barrido) · **CORRIDA** (script de esta carpeta) · `[?]`.

## 1. Lo que se hizo

1. `e14_tunnel.py` → `e14_tunnel.txt`, `e14_tunnel.png`. Modelo WKB propio (barrera trapezoidal integrada numéricamente,
   prefactor de Fowler–Nordheim con C0 libre) ajustado a curvas medidas J(V) de SiO2 de 36,5 / 45,5 / 57,0 Å
   (**LEÍDO-FIG**: Gupta et al., IEEE EDL dic. 1997, reproducida en K. Saraswat, EE311 «Gate Dielectric», Stanford, p. 10,
   https://web.stanford.edu/class/ee311/NOTES/Gate_Dielectric_Slides_Part1.pdf; polaridad y si el espesor es físico `[?]`).
   Validación fuera de muestra: (i) dejar un espesor fuera: error medio ≤ 0,17 déc, máximo 0,26 déc; (ii) la curva de túnel
   directo de 25,8 Å, que el ajuste no vio: entre 0,95 y 2,5 V el modelo con V0 = 0 queda 0,14 déc por encima a 0,8 déc por
   debajo del dato; a partir de 3 V se desvía (la flexión de bandas cambia V0). Ajuste: m_ox = 0,27–0,33 m0 para φ = 3,2–3,0 eV,
   V0 = 1,15 V en régimen FN.
2. `e14_retention.py` → `e14_retention.txt`, `e14_retention.png`. Descarga de la puerta flotante (4,148 nm, `toxe` de
   `nfet_01v8`, **PDK**) con escenarios φ ∈ {3,0; 3,1; 3,2} eV × V0 ∈ {0; 0,25; 0,5} V (**SUPUESTO**: parte de la tensión del
   nodo que no cae en el óxido) × r = C_total/C_óxido ∈ {1, 10, 100, 1000}.
3. `e14_toxsens.py` → `e14_toxsens.txt`. Sensibilidad de la tensión residual al espesor y su dispersión con el parámetro de
   Monte Carlo del PDK `sky130_fd_pr__nfet_01v8__toxe_slope = 0.003443` (**PDK**, `libs.tech/ngspice/parameters/invariant.spice`
   l. 2796; que l y w vayan en µm en esa fórmula es **SUPUESTO**).

## 2. Resultados contra predicciones

| Id | Predicción | Resultado | Veredicto |
|---|---|---|---|
| P-A1 | J(1 V; 4,15 nm) 1e-11–1e-9 A/cm²; ~1 déc por 0,2–0,25 nm | 6e-14–4e-11 A/cm² (método A con V0 0–0,5 V; método B, curva medida de 25,8 Å escalada, 8e-12–4e-11 a 0,95 V). 2κ ≈ 9,4 nm⁻¹ → 1 déc por 0,25 nm | **fallada** en valor (1–2 déc más baja en el centro); cumplida en pendiente |
| P-A2 | τ(1 V) 1e3–1e5 s; τ(0,3 V) días–meses | τ(1 V) = 5e4–1,3e7 s; τ(0,3 V) = 2e6 s a «infinito» (≥ 1e11 s si V0 ≥ 0,25 V) | **fallada** por arriba (retiene más) |
| P-A3 | Tras 6 meses quedan 0,2–0,6 V, sin memoria de la tensión inicial | r = 1: 0,06–0,74 V; r = 100: 0,52–1,39 V. Con Vi = 3,3, 5 o 7 V el resultado es idéntico a 4 decimales | **cumplida** |
| P-A4 | «10 s a 15 min» solo vale a ≥ 1,5 V | τ local: 0,3–30 s a 3,3 V; 1e2–4e3 s a 2,5 V; 1,5e3–1,5e5 s a 1,8 V | **cumplida** (vale para ≥ 2,5 V) |
| P-B1 | La puerta se autolimita a 4–5 V durante el grabado; no habrá medida de carga retenida tras el recocido | Medida directa de antena flotante (CHARM-2) en CVD de plasma: −4,5 a −7,5 V y también positiva (**LEÍDO**, Carrère, Oberlin, Bruyère, ST, ECS Meeting Abstracts 203, n.º 489, Fig. 1b y 2b). Carga retenida tras el recocido: no encontré medida `[?]` | cumplida en orden de magnitud; el resto `[?]` |
| P-C1 | FN en 11,6 nm: 9–10 V en el óxido; 4 nm inútil como memoria de años | Modelo: J(11,6 nm) = 2e-6–7e-5 A/cm² a 10 V; 6e-10–1e-7 a 8 V; < 1e-15 a 5 V. 4,15 nm: pierde más de la mitad de una carga de 1,8 V en 1 d–30 d (r = 1) | **cumplida** |
| P-C2 | Chen/Sonnadara/Shah usan el pfet de 5 V, inyección 5–6,5 V, túnel 10–12 V | No pude abrir el artículo (403 en Wiley, TechRxiv y DOAJ; es de acceso abierto según OpenAlex). Solo el resumen (**NO LEÍDO**): pFET en SKY130, inyección y FN, «preliminary analysis of the retention». Un README del grupo en el MPW-006 dice «FG synapses is built using the high voltage transistors» (**LEÍDO**, foss-eda-tools.googlesource.com/third_party/shuttle/sky130/mpw-006/slot-026) | sin resolver `[?]`; la parte «transistor de 5 V» tiene un indicio leído |

## 3. Respuestas a (a)–(d)

**(a) Retención por túnel directo.** Constante local τ(V) = C_ox·r·V/J(V) con C_ox = 8,32 fF/µm² (cálculo con `toxe`).
Para la puerta sola (r = 1): 0,3–30 s a 3,3 V; 1,5e3–1,5e5 s a 1,8 V; 5e4–1,3e7 s a 1 V; ≥ 2e6 s a 0,3 V (**CORRIDA**, intervalo
sobre φ y V0). La descarga es casi logarítmica en el tiempo: desde cualquier Vi ≥ 1,8 V, r = 1, el nodo está en 1,2–2,0 V a la
hora, 0,6–1,5 V al día, 0,06–0,74 V a los 6 meses. τ no depende del área de la puerta (tautología, prerregistrada); escala con r:
una placa o condensador añadido que no fuga multiplica τ por r. Para 1 fF → 1 pF sobre una puerta de 0,063 µm² (0,52 fF de
óxido) r va de ~2 a ~2000. Escala de tiempo, en resumen: **segundos a 3,3 V, horas a 1,8 V, días-meses a 1 V, años por debajo
de ~0,5 V**. Con interruptor: la fuga del nfet mínimo apagado (0,66 fA a 27 °C, `attack_xc58/c58_INFORME.md`, corrida de
modelo) solo pierde contra el túnel si el óxido mide más de 70–6500 µm² a 1,8 V, 4e3–1e6 µm² a 1 V y ≥ 1e5 µm² a 0,5 V
(**CORRIDA**). Por debajo de ~1,5 V una celda con interruptor mide el interruptor, no el óxido.

**(b) Carga de plasma.** Reglas de antena de SkyWater (**LEÍDO**, skywater-pdk.readthedocs.io/en/main/rules/antenna.html):
la razón es área expuesta (perímetro × espesor final para poly, li, met1–3; área de contacto para licon, mcon, vías) sobre área
de puerta; máximos sin diodo poly 50, li 75, met1–3 400; con diodo `EGAR = EA/A_gate − K·A_diodo − bonus` (K = 400 y bonus 2200
para met1). No dicen nada de una puerta sin camino a difusión; la regla x.22 de la periferia prohíbe interconexión flotante «sin
camino a poly, difftap o pin» (**LEÍDO** vía resumen de la página periphery.html): una placa unida a la poly de la puerta tiene
camino a poly, así que la letra no la prohíbe `[?]`. El precheck no comprueba antena (`precheck_map/README.md`).
Literatura: en CVD de plasma la antena flotante llega a −4,5…−7,5 V (CHARM-2, arriba); en óxidos delgados el daño baja porque
«the tunneling gate current ... allows a charge evacuation from the antenna to the substrate without degradation» (**LEÍDO**,
Carrère et al.); y «thinner oxides are less susceptible to charging stress» (**LEÍDO**, Bersuker, Werking, Chan, SEMATECH,
IRW 1997, «Charge-to-Breakdown and Trap Generation Process in Thin Oxides», resumen y p. 1). Si la carga sobrevive al recocido
final en gas de formación: no encontré fuente `[?]`.
**Lo que queda al salir de fábrica, 4,15 nm, sin diodo:** la corrida responde sin necesitar el recocido. Cualquier tensión de
plasma entre 3,3 y 7 V cae por túnel a 2,7–3,3 V en 1 s y a la misma curva universal después; a los 6 meses el nodo está en
0,06–0,74 V (r = 1) o 0,5–1,4 V (r = 100) **idéntico a 4 decimales para Vi = 3,3, 5 o 7 V**. El calor de los pasos posteriores
solo acelera la pérdida (todas las vías crecen con T), así que estas cifras son cotas superiores de lo que queda. Es legible:
deriva de 0,2–0,9 mV/día en el momento de medir = 0,7–3 pasos del lector de XC-19 por día. Pero **no es una escritura**: no
recuerda la antena ni la tensión de plasma; recuerda cuánto tiempo ha pasado desde la última carga, el espesor local y r.
Cómo separar carga atrapada en la puerta de trampas en el óxido: la carga de la puerta se mueve con r (un condensador añadido
cambia la tensión residual de forma calculable) y deriva logarítmicamente en el tiempo; la carga en trampas del óxido no depende
de r, desplaza el umbral sin deriva logarítmica universal y viene con cambio de pendiente subumbral y de ruido 1/f (**DE
MEMORIA**; el bombeo de carga, XC-43, mide las trampas de interfaz directamente).

**(c) Escritura deliberada.** 4,15 nm: se escribe por túnel directo/FN incipiente con el raíl de 3,3 V sin bomba (τ local
0,3–30 s a 3,3 V) y sin interruptor, desde un condensador de túnel (poly sobre pozo n). Retiene horas a días por encima de 1 V:
**como memoria de años es inútil; como reloj sin alimentación sirve** (ver XC-45 abajo). 11,6 nm (`g5v0d10v5`, **PDK**
`toxm = 1.16e-8`): túnel despreciable por debajo de 5 V (J < 1e-15 A/cm² a 5 V → τ > 1e9 s; < 2e-26 a 3,3 V), escritura FN con
8–12 V en el condensador de túnel (J 6e-10–5e-3 A/cm²; con un condensador de túnel de 10 % de C_total, 0,3 V/s a ~10 V,
**CORRIDA** + cálculo). Inyección de portadores calientes: en el pFET de óxido grueso de un 130 nm, |V_DS| = 5,0–5,5 V
(**LEÍDO**, Hasler, Kim, Adil, J. Low Power Electron. Appl. 6, 13 (2016), Fig. 4; en ese proceso el óxido delgado «~2 nm»
retiene «< 1 minute» y el FG usa el de «~8 nm»). El `pfet_g5v0d10v5` admite V_DS hasta 11 V (DATOS_PROCESO): la inyección cabe
sin bomba solo si V_DS ≥ ~5 V, es decir, con bomba o con el pin; el túnel de 11,6 nm pide bomba. Retención del 11,6 nm por túnel:
años sobrados; Hasler da 1–100 µV en 10 años para su proceso de 350 nm (**LEÍDO**, mismo artículo, p. 3). Chen 2024: `[?]`.

**(d) Mapa de regímenes** (27 °C, sin diodo; V = tensión del nodo respecto del pozo; t = tiempo de observación):

| Óxido | Sin efecto (convencional) | Carga almacenada legible y retenida (tercera región) | Fuga dominante | Ruptura |
|---|---|---|---|---|
| 4,15 nm (1,8 V) | V ≲ 0,3 V: τ ≥ 2e6 s, nada se mueve en una medida de mesa | 0,3 V ≲ V ≲ 1,8 V: deriva log-temporal de 0,1–1 V por década de tiempo, legible con 0,305 mV; es un reloj, no una memoria | V ≳ 2,5 V: se descarga en segundos-minutos; V ≳ 3,3 V: en < 30 s | ≳ 6–7 V en 1 h–1 s (e07) |
| 11,6 nm (5 V) | V ≲ 5 V: nada se mueve en años | Carga puesta a 8–12 V (FN) o por inyección (V_DS ≈ 5–6 V), retenida a < 5 V | — en el rango alcanzable | > 12 V (fuera del alcance de la bomba) |

Fronteras: la que separa «sin efecto» de «reloj» en el delgado la fija V0 (cuánta tensión del nodo no cae en el óxido;
**SUPUESTO** 0–0,5 V) y φ; la que separa «reloj» de «fuga» está a ~2–2,5 V. El parámetro de diseño que mueve todo es r: ×10 en
r desplaza la curva una década en el tiempo.

## 4. Lo nuevo que apareció

1. **La puerta flotante delgada es un medidor de espesor del óxido.** La tensión residual a 6 meses cambia 0,64 V/nm (r = 1) a
   1,53 V/nm (r = 100). Con el desajuste de espesor del propio PDK: σ(V) ≈ 36 mV en una puerta de 0,42 × 0,15 µm y 9 mV en
   1 × 1 µm (r = 1), 87 y 22 mV con r = 100 (**CORRIDA**). Es mayor que el desajuste de umbral de la misma puerta
   (σ = 17,3 mV, `experiments/lod_audit`). Si el `toxe_slope` del modelo refleja espesor físico real `[?]`, una matriz de puertas
   flotantes cargadas por el plasma es una huella de identidad por espesor de óxido, distinta de la de XC-35 (desajuste de
   umbral), legible con XC-19. Ojo: la huella es de espesor, no de antena; la antena solo pone la carga inicial, que el óxido
   olvida.
2. **Escritura sin bomba con el raíl de 3,3 V.** La celda de túnel en 4,15 nm se escribe en segundos con VAPWR y no necesita
   interruptor sobre el nodo. Esto convierte XC-45 en un reloj que sigue contando con el chip apagado.
3. **La cifra «10 s a 15 min» del plan de XC-45 solo es cierta por encima de ~2,5 V.**

## 5. Veredicto por sub-afirmación

| Sub-afirmación | Veredicto | Escenario en que cambia |
|---|---|---|
| XC-14 «la antena escribe la puerta y la celda nace escrita» (óxido de 1,8 V) | **MUERE** en todos los escenarios barridos: el óxido olvida la tensión inicial en segundos | Solo si V0 > ~1 V a baja tensión (el óxido casi no ve tensión) o φ más alta de lo barrido; dato que decide: J(V) medido de este óxido a 0,3–1,5 V |
| XC-14 sobre óxido de 5 V (puerta del `g5v0d10v5` colgada de la antena) | **TRANSFORMADA**: el túnel no borra; lo que quede lo deciden los recocidos y la luz `[?]`. Es la única versión en que «nace escrita» sigue viva | Muere si la carga no sobrevive al recocido final (`[?]`, sin fuente) |
| XC-14 como reloj y medidor de espesor (delgado) | **SOBREVIVE**, nueva: tensión residual legible, deriva legible, dispersión por espesor > desajuste de umbral | Muere si el túnel real a ≤ 1 V es mucho más bajo que el modelo (V0 ≳ 1 V): el nodo no se movería |
| XC-45 temporizador por túnel, «τ independiente del área» | **SOBREVIVE** la física; **TRANSFORMADA** la celda: sin interruptor (escritura por túnel a 3,3 V) | Con interruptor y V ≤ 1,5 V mide el interruptor salvo áreas de 1e3–1e6 µm² |
| XC-11/XC-09 memoria de puerta flotante | **SOBREVIVE** solo en el óxido de 11,6 nm, con bomba (FN 8–12 V) o inyección a V_DS ≈ 5–6 V; en 4,15 nm **MUERE** como memoria | Tensión de escritura del 11,6 nm real `[?]` (Chen 2024 la tendría) |

## 6. Cinco columnas

| Dato del PDK | Evidencia publicada leída | Parámetro supuesto | Resultado de simulación/cálculo | Conclusión física |
|---|---|---|---|---|
| `toxe` 4,148 nm / `toxm` 11,6 nm; `igcmod = 0`; `toxe_slope` 0,003443; reglas de antena (poly 50, li 75, met 400) | Gupta 1997 (fig., vía Saraswat); Carrère (CHARM −4,5…−7,5 V; óxido delgado evacúa carga); Bersuker 1997; Hasler 2016 (130 nm: ~2 nm < 1 min; FG en ~8 nm; inyección 5–5,5 V; 1–100 µV/10 años) | φ 3,0–3,2 eV; V0 0–0,5 V; r 1–1000; polaridad simétrica; unidades de `toxe_slope` | J(1 V) 6e-14–4e-11 A/cm²; τ(1,8 V) 1,5e3–1,5e5 s; V(6 m) 0,06–0,74 V (r = 1) sin memoria de Vi; σ(V) por espesor 9–87 mV | El óxido de 1,8 V borra lo que escribe el plasma y deja un reloj universal; el de 5 V retiene |

## 7. Configuraciones de layout que más información darían

1. **Matriz de puertas flotantes delgadas sin diodo, barrido de r** (placa de met1 de 0, 10×10, 30×30, 60×60 µm sobre la poly
   de una puerta de 1 × 1 µm; la placa de 60 × 60 pasa el precheck) con lector XC-19 por celda, y gemelas idénticas con diodo
   de antena. Predicción: sin diodo y con diodo convergen a la misma curva universal si el óxido olvida; la tensión residual
   crece ~log(r). Si las sin diodo difieren de las con diodo, hay carga que el modelo no explica (trampas o recocido).
2. **Puerta flotante de 5 V colgada de antena** (`g5v0d10v5`, misma placa), con y sin diodo, con placa de acoplamiento para
   llevar el lector a su rango. Es la única versión en que «nace escrita» sigue viva.
3. **Celda de túnel delgada sin interruptor** (poly sobre pozo n, escrita desde VAPWR 3,3 V con un excitador de 5 V; condensador
   de acoplamiento de metal de r = 10–100; lector XC-19), barrido de área del condensador de túnel a C_total fijo. Mide J(V) del
   óxido de 0,3 a 3,3 V con el chip apagado entre lecturas: el dato que el modelo del PDK no trae (`igcmod = 0`).

## 8. Fuentes

Leídas: Saraswat EE311 (Stanford) p. 10, figura de Gupta et al. 1997; Carrère et al., ECS MA 203 #489
(https://www.electrochem.org/dl/ma/203/pdfs/0489.pdf); Bersuker et al., IRW 1997 (thierry-lequeu.fr/data/IRPS/irw/97/ctf7-606.pdf,
p. 1); Hasler et al., JLPEA 2016 (https://hasler.ece.gatech.edu/SoCFPAA/FPAA_FG_scaling_paper.pdf); reglas de antena y de
periferia de SkyWater (readthedocs). No leídas: Chen, Sonnadara, Shah 2024 (DOI 10.1049/ell2.70036, solo resumen); Lo et al.
1997 (solo resumen); cualquier medida de carga de plasma tras el recocido final.
