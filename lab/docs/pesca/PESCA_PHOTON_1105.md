# Pesca PHOTON — fotodiodo de sky130 y LED de silicio por filamento (Li et al., Nat. Commun. 2023)

Escrita la noche del 2026-11-04 (23:53 EST, hora de `date`) para el frente B del sprint EFLO-00. Complementa
`PESCA_OPTO_1104.md` (rupturas del PDK, pin analógico de TT, emisores en avalancha). Todo número lleva fuente: archivo del PDK
con línea, URL abierta, o corrida de `macros/photon/`. Lo que no se leyó, `[?]`. Nada de esto afirma emisión en sky130.

## 1. El fotodiodo de sky130: lo que dicen el PDK instalado y la documentación de SkyWater

### 1.1 En el PDK instalado (`hpretl/iic-osic-tools:2025.07`, `/foss/pdks/sky130A`)

- No existe celda `sky130_fd_pr__photodiode` en `libs.ref/sky130_fd_pr/gds` ni modelo propio en `libs.ref/sky130_fd_pr/spice`
  ni en `libs.tech/ngspice` (búsqueda por "photo": solo aparece en el tech de Magic y en el `.lyp` de KLayout).
- Magic (`libs.tech/magic/sky130A.tech`): l.84 `# sky130_fd_pr__photodiode photo Photodiode`; l.141 tipo `photodiode,photo` en el
  plano `dwell`; l.439 estilo `nwell nwell_field_implant`; l.669 `photo` conecta eléctricamente con `nwell`, `nsd`, `dnwell`;
  l.723 `layer DNWELL dnwell,npn,photo / calma 64 18`; l.986-987 `layer PHOTO photo / calma 81 81`; l.2425-2426 lectura
  `layer photo DNWELL and PHOTO`; l.4191-4194 reglas photo.2 (3,0 µm), photo.3 (5,0 µm), photo.4 (5,3 µm a dnwell);
  l.6033-6034 extracción `device ndiode sky130_fd_pr__model__parasitic__diode_ps2dn photo pwell,space/w error a=area`.
- KLayout (`libs.tech/klayout/tech/sky130A.lyp` l.6391: `areaid.photo - 81/81`; `libs.tech/klayout/drc/sky130A_mr.drc` l.252:
  `areaid_po = polygons(81, 81)`, sin ninguna regla que lo use). El deck trata 64/18 del fotodiodo como dnwell: dnwell.1 (3,0 µm)
  y dnwell.2 (6,3 µm) en l.289-296; nwell.6 (1,03 µm) en l.324. **No contiene nwell.7.**
- Modelo del único dispositivo que se extrae, `libs.tech/ngspice/parasitics/sky130_fd_pr__model__parasitic__diode_ps2dn.model.spice`:
  l.21 `cj = 7.8544e-005*1e-12*mult` (F por µm²), l.22 `mj = 0.49`, l.23 `pb = 0.5348`, l.24 `cjsw = 8.1664e-010*1e-6*mult`
  (F por µm), l.25 `mjsw = 0.20024`, l.32 `js = 6.1049e-017`, l.33 `jsw = 8.1115e-016`, l.34 `n = 1.0791`, l.38 `bv = 16.95`,
  l.41 `eg = 1.17`, l.42 `xti = 1.0`. Multiplicadores tt: `libs.tech/ngspice/corners/tt/nonfet.spice` l.27-28 (0,9858 área;
  1,0116 perímetro). Es el modelo del parásito psub/dnwell, no una caracterización del fotodiodo: corriente oscura,
  responsividad y capacidad medidas del fotodiodo `[?]`.
- Óxidos de puerta (para §3): `libs.ref/sky130_fd_pr/spice/sky130_fd_pr__nfet_01v8__tt.pm3.spice` l.63 `toxm = 4.148e-9`;
  `sky130_fd_pr__pfet_01v8__tt.pm3.spice` l.40 `toxm = 4.23e-9`; `sky130_fd_pr__nfet_g5v0d10v5__tt.pm3.spice` l.40
  `toxm = 1.16e-8`.

### 1.2 En la documentación de SkyWater (leída por WebFetch)

- https://skywater-pdk.readthedocs.io/en/main/rules/periphery.html#id19 — tabla "(photo.-)", "Photo diode for sensing light":
  photo.1 "Rules dnwell.3 and nwell.5 are exempted for photoDiode"; photo.2 "Min/Max width of photoDiode" 3,000 µm;
  photo.3 "Min spacing between photoDiode" 5,000; photo.4 "Min spacing between photoDiode and deep nwell" 5,300;
  photo.5 "photoDiode edges must be coincident with areaid.po"; photo.6 "photoDiode must be enclosed by dnwell ring";
  photo.7 "photoDiode must be enclosed by p+ tap ring"; photo.8 "Min/Max width of nwell inside photoDiode" 0,840;
  photo.9 "Min/Max enclosure of nwell by photoDiode" 1,080; photo.10 "Min/Max width of tap inside photoDiode" 0,410;
  photo.11 "Min/Max enclosure of tap by nwell inside photoDiode" 0,215.
  Lectura: 1,08 + 0,84 + 1,08 = 3,00 y 0,215 + 0,41 + 0,215 = 0,84 → el dispositivo documentado es un cuadrado de 3 × 3 µm de
  dnwell con un tapón de nwell de 0,84 µm y un contacto en el centro, rodeado de tap p+ y de un anillo de dnwell a ≥ 5,3 µm.
  Si "width" permite un lado largo libre no lo dice `[?]`.
- Mismo documento, #id6 "(dnwell.-)": dnwell.2 ancho 3,000; dnwell.3 separación 6,300 (exenta dentro de UHVI); dnwell.4 no
  solapar pnp:dg; dnwell.5 "P+_diff can not straddle Dnwell". #id7 "(nwell.-)": nwell.5 dnwell encerrado por nwell 0,400;
  nwell.6 hueco de nwell encerrado por dnwell 1,030; nwell.7 "Min spacing between nwell and deep nwell on separate nets" 4,500.
- https://skywater-pdk.readthedocs.io/en/main/rules/layers.html — `areaid.po` 81:81 "Photodiode device identifier" ("The areaid
  id is to identify the dnwell photo diode"); `dnwell` 64:18; `areaid.de` 81:23 "Diode identifier"; `prBndry` 235:4.
- https://skywater-pdk.readthedocs.io/en/main/rules/device-details.html — **no tiene sección de fotodiodo**; en "Diodes" solo
  nombra `sky130_fd_pr__model__parasitic__diode_ps2dn`, `dnwdiode_psub_victim/aggressor` y tensiones de ruptura, sin
  capacidad ni corriente oscura.

### 1.3 Qué comprueban las herramientas y qué no (corridas en `macros/photon`, ver su `LEEME.md`)

- Magic: photo.2/3/4 sí; nwell.7 contra `photo` no (nwell ajeno a 2 µm: 0 errores); photo.5–11 no.
- KLayout: dnwell.1/2 y nwell.6 sobre el 64/18 del fotodiodo (exige 6,3 µm al anillo de dnwell, más que los 5,3 de photo.4);
  nwell.7 y photo.* no.
- Consecuencia: la legalidad fina del fotodiodo (photo.5–11) y la nwell.7 hay que cumplirlas a mano; así se hizo en
  `photon_fd` (3 × 3 exacto) y en las distancias emisor-fotodiodo (≥ 5 µm).

## 2. "A sub-wavelength Si LED integrated in a CMOS platform" — Li, Xue, de Cea, Kim, Nong, Chong, Lim, Quek, Ram; Nat. Commun. 14, 882 (2023), DOI 10.1038/s41467-023-36639-1

Fuente: PDF de acceso abierto (https://www.nature.com/articles/s41467-023-36639-1.pdf), páginas 1-8 leídas (texto principal,
figuras 1-3, Methods, referencias). La información suplementaria (secciones 1-10) **no se leyó**.

| Pregunta | Respuesta con cita | Dónde |
|---|---|---|
| Nodo / proceso | "Our LED is fabricated in a 55 nm CMOS node"; "fabricated by GlobalFoundries, Singapore using a standard open-foundry CMOS technology (55BCDLite). 55BCDLite is a 12-in. mature process"; "Our device design and layout utilized standard mask layer sets and complied with critical design rules" | Results p.2; Methods p.7 |
| Estructura | "a vertical n+/n/p junction. Here the n+, n and p refer to the gate poly-Si layer (degenerate n-doped), the n-well (intermediate n-doped) and the substrate (lightly p-doped)"; "The thin (~100 nm) gate poly-Si serves as a transparent top contact"; n-well ≈ 1,6 × 1,8 µm, < 2 µm de profundidad; "Only a small area (~0.3 µm²) of the n-well is in contact with the gate oxide (<3 nm thick). This opening is defined by shallow trench insulator (STI)" | Results p.2; Fig. 1b-c |
| Cómo se forma el filamento | Ruptura dura del óxido de puerta por tensión: "a Si filament is formed in the gate oxide by applying electrical stress. This process is usually referred to as hard breakdown"; "when high-voltage gate bias is applied, traps form in the gate oxide and a conduction path is created ... thermal runaway ... the Si in the conduction path melts to form a Si filament. The cross-section of the breakdown site is usually sub-100 nm and the Si filament is a resistor in series with the gate poly-Si and the n-well" | Results p.2 |
| Condición de formado | "the substrate was biased at 6.0 V with the poly-Si grounded to introduce gate oxide breakdown. We observed that the current rapidly increased from pA to mA and was stabilized within 1 min. After the breakdown, the IV characteristic was stable and showed no obvious hysteresis". Límite de corriente del formado: no se dice `[?]` | Results p.2 |
| Operación | Poly a masa, sustrato positivo (Fig. 1c); corrientes de 1 a 6 mA; tensión de polarización frente a corriente en el recuadro de Fig. 2e (eje 2–8 V; leído del gráfico ≈ 2,5 V a 1 mA y ≈ 6,5 V a 6 mA, aproximado); a 6 mA la desviación estándar relativa de la tensión entre cinco dados es "-5.3% (0.34 V)" → media ≈ 6,4 V a 6 mA. Densidad de corriente "above 2 MA/cm²" | Fig. 2e; p.5 |
| Mecanismo de emisión | "The LED spectrum peak is around 1100 nm, which is associated with the phonon-assisted band-to-band transition"; huecos acumulados bajo el óxido se recombinan con electrones inyectados desde el poly cerca del filamento; FWHM "from ~150 nm to ~190 nm" (1→6 mA), ensanchamiento por portadores calientes, sin corrimiento al rojo (la red no se calienta apreciablemente). El emisor de referencia p+/p/p emite por ionización por impacto y portadores calientes, espectro mucho más ancho | Results p.2-3; Fig. 1e |
| Eficiencia y potencia | "At 6 mA, the n+/n emission power and the associated EQE are ~94.0 pW and ~1.4 × 10⁻⁸"; "the SMF-coupled power is ~42 pW"; intensidad "102 ± 48 mW/cm²"; área de emisión "from 0.30 ± 0.12 µm² to 0.09 ± 0.04 µm²" (1→6 mA); EQE crece con la corriente (superlineal); IQE no se da `[?]` | p.5; Fig. 2e,h,i |
| Detectores | "an InGaAs short-wavelength infrared (SWIR) camera (Photonic Science)"; "an InGaAs photodiode (PD, HP)" tras fibra monomodo PM980; espectrómetro con la misma cámara; "a single photon avalanche diode (SPAD, PerkinElmer)" con TCSPC para el tiempo; ancho de banda de conmutación 77 MHz | Methods p.7; p.5 |
| ¿Detector en el chip / enlace? | No. Solo como perspectiva: "it is possible to integrate the LED with on-chip photodetectors" | Discussion p.7 |
| Fiabilidad | "turned on and off for ~10⁵ times ... the SMF-coupled power decreases by ~25% and no significant optical power decrease is observed after the test"; "reliable over time if operated below 7 mA"; a 7 mA "the optical power decreases by more than 50% within a minute"; la potencia acoplada **sube** de 10 a 70 °C | p.5 |
| Óxido de 1,8 V frente a 5 V | El artículo no habla de clases de tensión ni de óxidos gruesos `[?]`. Solo: óxido "<3 nm", formado a 6,0 V | — |

### 2.1 ¿Es compatible con sky130 en el flujo digital de Tiny Tapeout? (análisis propio; hipótesis salvo donde se cita)

- **Geometría:** la estructura (poly n+ sobre óxido de puerta sobre nwell, en una apertura de STI, sustrato p) se puede dibujar en
  sky130 con capas estándar (poly, nwell, nsdm sobre el poly, tap); no se probó DRC `[?]`.
- **Formado:** necesita romper el óxido. En el paper, 6,0 V sobre < 3 nm. Los óxidos de sky130 son de 4,15 nm (nfet 1,8 V),
  4,23 nm (pfet 1,8 V) y 11,6 nm (fets de 5 V) (`toxm`, §1.1). Si la tensión de ruptura escala con el espesor (hipótesis), el
  óxido de 1,8 V pediría ≈ 6,0 × 4,15 / 3 ≈ 8 V y el de 5 V ≈ 23 V; en todo caso más que los 1,8 V del flujo digital y que los
  3,3 V del raíl analógico opcional (`PESCA_OPTO_1104.md` §2). **El de 5 V es el peor candidato, no el mejor:** óxido más
  grueso, más tensión de formado.
- **Operación:** 1–6 mA a ≈ 2,5–6,4 V (leído del gráfico): 1 mA a 2,5 V ya supera 1,8 V, y 6 mA × 6,4 V ≈ 38 mW frente a los
  20 mA ≈ 0,1 V de caída de la PDN de TT (`PESCA_OPTO_1104.md` §2). Un solo emisor a 1 mA sí cabría en corriente, no en tensión.
- **Detección:** 1100 nm está en el borde de absorción del silicio (coeficiente de absorción bajo, profundidad de absorción de
  cientos de µm); los autores detectan con InGaAs. Un fotodiodo dnwell/psub de 3 × 3 µm a 1100 nm tendría responsividad muy
  baja `[?]`; el 1,4 × 10⁻⁸ de EQE da ≈ 94 pW de fotones a 6 mA, y lo que llegaría a un detector a 5–20 µm no se puede estimar
  sin el acoplamiento `[?]`.
- **Conclusión para el sprint:** el mecanismo de Li et al. está **bloqueado en el flujo digital de 1,8 V por la tensión de formado**,
  no por la geometría. Única ruta: bomba de carga interna (misma compuerta que la avalancha en `PESCA_OPTO_1104.md` §6.1), con
  ≈ 8 V `[?]` en vez de 11,7 V. No se recomienda incluirlo en EFLO-00 sin esa bomba.

## 3. Qué cambia respecto a `PESCA_OPTO_1104.md`

- El fotodiodo de sky130 existe como dispositivo documentado (photo.1–11) y como tipo de Magic, aunque no como celda ni modelo:
  se puede dibujar legal y extraer como `ps2dn` (hecho en `macros/photon/`). Lo que sigue sin existir es su caracterización.
- El LED por filamento es un tercer mecanismo de emisión en CMOS estándar (además de avalancha y de inyección en directa),
  con 1100 nm y EQE 1,4 × 10⁻⁸, pero con un paso de formado a 6 V que la plataforma no da.
- Sigue sin aparecer ninguna medida en silicio de volumen de la separación fotones / difusión de portadores entre emisor y
  detector: el control a distancia y el anillo p+ de `macros/photon/` son la forma de medirlo nosotros.
