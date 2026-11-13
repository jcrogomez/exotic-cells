# Exotic Foundry Lab 01 — pesca del 2026-11-04 (11:05 EST, hora de `date`)

Lectura para decidir si la familia "optoelectrónica monolítica" (emisor en avalancha + fotodiodo en el mismo dado) es viable en
sky130 dentro de Tiny Tapeout. Todo número lleva su fuente. Lo que no se leyó en fuente primaria va con `[?]`. Nada corrido, nada
dibujado. Origen: texto externo pegado por Juan (Exotic Cells / Exotic Foundry Lab 01) y su réplica "optoelectrónica interna".

## 1. Rupturas en el PDK (leídas en los modelos SPICE de la imagen `hpretl/iic-osic-tools:2025.07`, `libs.ref/sky130_fd_pr/spice/`)

| Modelo | `bv` (V) | Qué unión |
|---|---|---|
| `diode_pw2nd_05v5` | 11,7 | n+ en pwell (y variante `extended_drain`) |
| `diode_pw2nd_05v5_lvt` | 11,9 | idem, lvt |
| `diode_pw2nd_05v5_nvt` | 12,69 | idem, nativo |
| `diode_pd2nw_05v5` (y hvt/lvt) | 12,69–12,8 | p+ en nwell |
| `diode_pw2nd_11v0` | 12,636 | pwell a deep nwell |
| `pfet_g5v0d16v0__parasitic__diode_pw2dn` | 17,95 | parásito del pfet de 16 V |
| `nfet_20v0__vb` / `_iso` / `_zvt` / `pfet_20v0__vb` | 40 / 26 / 30 / 31 | dispositivos de 20 V (parámetro del modelo) |

Son parámetros de modelo (`bv`, `ibv = 1,06 mA`), no garantías de proceso ni medidas. El BSIM del `nfet_01v8` tiene ionización por
impacto (`alpha0 = 3e-8`, `beta0 = 13,86`) y GIDL (`agidl = 0`): **no modela la ruptura de la unión de drenador**; un emisor de baja
tensión tipo "diodo con compuerta" no se puede predecir con el PDK `[?]`.

## 2. Pin analógico de Tiny Tapeout (`TinyTapeout/tt-multiplexer`, `asw/sky130/tt_asw_3v3/xschem/tt_asw_3v3.sch`, leído por WebFetch)

- Es una puerta de transmisión: `pfet_g5v0d10v5` 180/0,5 µm (18 dedos) en paralelo con `nfet_g5v0d10v5` 60/0,5 µm (12 dedos), entre
  `bus` (pad) y `mod` (proyecto). Cuerpos de los pfet a **VAPWR (3,3 V)**, de los nfet a VGND. Sin diodos dibujados. Título del README:
  "3V3/5V tolerant".
- Consecuencia: el pad no puede subir de ~VAPWR + 0,6 V sin encender el diodo de cuerpo del pfet hacia el raíl de 3,3 V, y nunca de los
  ~5,5 V de óxido del dispositivo de 5 V. **Los 11,7 V de avalancha no entran por el pin `ua`.** Pendiente confirmar con Matt `[?]`.
- Especificación (tinytapeout.com/specs/analog): < 500 Ω, < 5 pF, 4 mA máx; met5 prohibido; proyectos con `ua` de dos tiles de alto;
  40 € los dos primeros pines, 100 € cada uno después; 20 mA de consumo ≈ 0,1 V de caída en la PDN; raíl de 3,3 V opcional con plantilla
  `tt_analog_*_3v3.def` y `uses_3v3: true`.
- Salida: la alta tensión se genera **dentro** (bomba de carga desde 1,8 o 3,3 V con dispositivos de 5 V o 20 V y `capm` met3/met4;
  `cap2m` usa met5 y está vedado). Área y corriente entregable: `[?]`, sin estimar.

## 3. Física medida en CMOS de volumen (Dutta, Wienk, Hueting, Schmitz, Annema, IEEE EDL 38(7), 2017, DOI 10.1109/LED.2017.2701505; PDF leído entero)

- Diodos laterales p+-n-n+ en **65 nm bulk CMOS estándar**, W = 47,6 µm; separación d entre p+ y n+ de 0 a 280 nm en pasos de 20 nm.
  **VBR se ajusta por geometría de layout, de 2 a 9 V**, sin tocar el proceso. d = 0 (p+-n+) rompe por túnel banda a banda y emite poco.
- Máximo de eficiencia de potencia óptica η = Popt/PLED ≈ **1,7 × 10⁻⁶** en VBR ≈ 6 V (D6, d = 100 nm). EQE ≈ **2,0 × 10⁻⁸** (medido
  verticalmente a través del BEOL), IQE ≈ 6,0 × 10⁻⁶, emisión isótropa supuesta. Intensidad media ≈ 28 nW/µm² a 10 mA. Popt lineal en I.
- Espectro 400–900 nm, pico ≈ 620 nm. Sobrevivieron 30 h a 10 mA y 100 °C.
- Nwell efectivo N ≈ 10¹⁷ cm⁻³ (ajuste TCAD). El de sky130: `[?]`.

## 4. Optoacoplador monolítico (Agarwal, Dutta, Annema, Hueting, Schmitz, Lee, Charbon, Nauta, IEDM 2018, DOI 10.1109/IEDM.2018.8614523; solo resumen)

- Primera comunicación de datos por optoacoplador monolítico: AMLED + **SPAD** (para compensar la IQE), pocos Mbps, pocos nJ/bit,
  < 0,01 mm². **En 140 nm CMOS SOI**, no bulk. El óxido enterrado y los dieléctricos guían la luz lateralmente (Optics Express 25(5),
  2017, "Monolithic optical link in SOI"). Acoplamiento ~10⁻⁹ (Laser Focus World, divulgación, `[?]` el detalle).
- **No encontrado:** ninguna medida publicada en bulk de la separación fotones / difusión de portadores entre emisor y detector. Lo más
  cercano: van Drieënhuizen y Wolffenbuttel, Sens. Actuators A 31 (1992), optoacoplador en silicio de volumen (texto completo no leído);
  Zhou, Holleman, Wallinga, Electron. Lett. 30(11) (1994): la diafonía optoelectrónica en OEIC de silicio es difusión de minoritarios y se
  corta con distancia o anillo de guarda polarizado en inversa (solo resumen).
- **No encontrado** ningún proyecto de Tiny Tapeout ni Efabless con emisor en avalancha o SPAD en sky130 (dos búsquedas; ausencia, no
  prueba).

## 4b. Fotónica en bulk CMOS sin modificar el proceso (añadido la noche del 4-nov; página de CHIC Caltech leída por WebFetch)

Sarkar, Baum, Hajimiri, "Monolithic Optical Clock Distribution in Bulk CMOS Using I-Beam Waveguides", VLSI 2025 (PDF `Sarkar_VLSI2025.pdf`).
Resumen leído: "Optical clock distribution is presented for the first time in an unmodified bulk CMOS chip" (180 nm); guías I-beam también
en 22 nm FDSOI "without process modifications or design rule violations"; "avalanche photodiodes and transimpedance amplifiers bring the
signal back to the electronic domain"; longitud de onda 780 nm. **No confirmado en la página:** que la fuente sea externa ni que haya
grabado posterior, como afirma el texto externo; "all components are monolithically integrated" sugiere lo contrario, pero a 780 nm no
hay fuente de silicio, así que la fuente externa es lo probable `[?]`. Lo que sí dice: dieléctricos del BEOL como guías y APD en bulk.
Para nosotros: ruta A óptica (precursor dieléctrico) en EFL02; no es un LED interno acoplado a un fotodiodo.

## 5. Test tile de SkyWater (`google/skywater-pdk-sky130-raw-data`, `docs/sky130-testtile-proprietary/sky130-testtile-pad-documentation.csv`, leído por WebFetch)

≈ 290 estructuras, datos `.mdm` tomados por CoolCAD; repo archivado. Hay: FETs con barridos de W/L **y de `sa`/`sb`** (distancia a STI,
es decir, LOD: la familia A "geometría MOS" ya está parcialmente medida por la fundición), pares de desapareamiento, resistencias de poly
con y sin dummies, 3 osciladores en anillo (fanout 1 y 3), cadenas de vías y contactos, diodos n+, p+, nwell/psub, dnw, nativo (área e
perímetro), MIM, VPP, CBCM. **No hay nada óptico ni de avalancha.** El tile abierto (Google/NIST/Michigan, OpenFASoC) solo está anunciado.

## 6. Lo que decide (orden de muerte)

1. **Tensión:** sin bomba de carga interna no hay avalancha. Primer cálculo: corriente entregable a 12 V desde 1,8 V con `capm` en el área
   de un tile, y consumo total frente a los 20 mA/0,1 V de la PDN.
2. **Presupuesto de fotones frente a difusión (estimación de orden de magnitud, no medida):** a 100 µA de emisor con IQE 6 × 10⁻⁶ salen
   ≈ 4 × 10⁹ fotones/s dentro del silicio; un fotodiodo a 10 µm que capte el 1–10 % daría ≈ 6–60 pA. Una fuga de portadores de 10⁻⁵ de
   la corriente del emisor ya es 1 nA. **El anillo de guarda no es un control: es la condición de existencia del experimento.**
3. **Controles que separan fotones de portadores:** anillo de guarda n+/nwell conectado y desconectado; distancia (10, 20, 40 µm);
   emisor en **directa a la misma corriente** (máxima inyección de minoritarios, mínima luz visible); modulación del emisor con el reloj
   de placa y respuesta del detector en frecuencia (difusión lenta, fotones instantáneos); fotodiodo somero (p+/nwell) frente a profundo
   (nwell/psub).
4. **Lectura:** integración de la fotocorriente en un condensador y conversión a tiempo con un comparador y el contador del lector común.
   Sin SPAD (no hay ruptura controlada ni modelo).
5. **Geometría del emisor como variable:** la separación p+/n+ dentro de nwell ajusta VBR (Dutta). En sky130 el mínimo de separación de
   difusiones lo fija DRC `[?]`; barrer d es la "celda exótica" literal: un dispositivo definido por layout que el PDK no modela.
