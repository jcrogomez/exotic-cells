# Capacidades de SKY130 para MISFIT: qué está documentado, qué se puede dibujar, qué fabrica el shuttle y qué podemos ver

Inicio: `Fri Nov 13 21:32:01 EST 2026` (de `date`). Fin: ver al pie.

Pedido de Juan: cuatro niveles por capacidad, con fuente y grado. **Que algo esté en el PDK no significa que el shuttle lo
fabrique.** Ninguna celda de esta matriz deduce fabricación a partir del PDK.

## Cómo leer las tablas

Cuatro columnas:

1. **Documentado**: lo que dicen SkyWater, el PDK o terceros por escrito.
2. **Capas y reglas**: lo que existe como capa GDS, regla de DRC o dispositivo con modelo.
3. **Fabricable en el shuttle TT**: lo que Tiny Tapeout deja pasar en su precheck y, aparte, lo que consta que la fábrica hace.
   Pasar el precheck **no** prueba fabricación.
4. **Observable por nosotros**: lo que MISFIT podría medir con 1,8 V / 3,3 V y los pines de TT.

Grados: **leído en la fuente** (lo leí en el archivo o la página citada; una corrida de esta sesión cuenta como fuente);
**inferido** (deducción mía a partir de fuentes leídas, con la cadena escrita); **[?]** (no encontrado).

Abreviaturas de rutas:

- `PDK` = `local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A`.
- `MAG` = `PDK/libs.tech/magic/sky130A.tech`.
- `TT` = `local_flow/tt-support-tools` (commit 01d5d28, 2026-08-20). `TTDECK` = `TT/precheck/tech-files/sky130A_mr.drc`,
  copiado de `chipfoundry/mpw_precheck` f2264a8 (`TT/precheck/tech-files/README.txt`).
- `SWD` = documentación de SkyWater, `github.com/google/skywater-pdk`, commit 7198cf6 (2023-05-29), carpeta `docs/rules/`.
  Publicada en `skywater-pdk.readthedocs.io`. Clonada para esta sesión; no vive en el repo.

Corridas de esta sesión (scripts y salidas en el scratchpad, temporales; se describen aquí para repetirlas):

- **C1. Sondas por el deck de TT.** Tres GDS sueltos por `TTDECK` con `feol=true` y con `beol=true`, KLayout del contenedor
  `hpretl/iic-osic-tools:2025.07`. Resultado: `tunm` solo (80/20 dentro de `dnwell` y `areaid.core`) → 1 error,
  `MR_tunm.CON.1`. `capm` 10 × 10 µm sobre met3 con via3 y met4 → 0 errores. met3 solo (control) → 0.
- **C2. Uniones diff/tap a tope en las bibliotecas.** KLayout Python sobre los GDS de `sky130_fd_sc_hd`, `sky130_fd_sc_hvl` y
  `sky130_fd_pr`: cuenta las fronteras diff (65/20) / tap (65/44) coincidentes y si cada trozo a tope tiene licon propio.
  Resultado: hd 0 celdas con frontera a tope; hvl 0; fd_pr 84 celdas con frontera a tope, y solo 2 trozos de tap sin licon
  propio (en `sky130_fd_pr__rf_pfet_20v0_withptap`).
- **C3. `grep -i "silicid|salicid"` sobre todo `PDK/libs.tech` y `PDK/libs.ref`.** Un solo archivo: `MAG`. Dentro, solo como
  nombre de estilo de dibujo (ver S-2).

---

## 1. Siliciuro (primera compuerta de XC-20)

### 1.1 Lo hallado, en frases cortas

- **Ningún documento de SkyWater ni del PDK dice que SKY130 siliciure la difusión o el poly.** Tampoco dice lo contrario. La
  palabra no aparece en `SWD` (grep sin resultados) ni en el PDK salvo como estilo de pantalla de Magic.
- **No hay capa de bloqueo de siliciuro.** Ni en la lista de máscaras (`SWD/masks.csv`), ni en la de capas GDS
  (`SWD/gds_layers.csv`), ni en la salida GDS de Magic, ni en el deck de KLayout, ni en la lista de capas válidas de TT.
  Compárese con IHP (`SalBlock.drawing`) y GF180 (`SAB`), que sí la tienen en la misma lista de TT.
- **El `silicide_block` de `MAG` líneas 493–494 y 563 no es una capa.** Es un estilo de dibujo genérico de Magic
  (`/foss/tools/magic/lib/magic/sys/mos.7bit.dstyle` línea 257 del contenedor: `stipple 7 ... silicide_block`). `npolyres` es
  alias de `mrp1` (`MAG` l. 208) y sale a GDS como poly más la capa identificadora `poly.res` 66/13 (`MAG` l. 1153), sin
  ninguna máscara extra. Esto corrige el "indicio" de `cells/xc40_thermopile/PLAN.md` l. 61–62 y
  `cells/xc51_poly_constriction/PLAN.md` l. 61–62.
- **Las resistencias de capa documentadas son las de silicio sin siliciuro.** n+ 120 Ω/□, p+ 197 Ω/□, poly 48,2 Ω/□, li
  12,8 Ω/□ (`SWD/rcx/resistance-values.tsv` l. 2–3, 12–13; `SWD/device-details/res_generic/res_generic-table0.rst` l. 13, 34,
  76, 90; `MAG` l. 5106–5107, 5119, 5122). La difusión ordinaria y la resistencia `res_generic_nd` tienen el mismo valor, y la
  resistencia solo añade la capa identificadora `diff.res` 65/13 (`MAG` l. 1150), que no es máscara. **Inferido:** la
  difusión y el poly corrientes no llevan siliciuro, o lo llevan con un efecto nulo sobre la resistencia de capa; lo segundo
  contradice lo que hace un siliciuro (bajar la capa a unos pocos Ω/□; esta cifra típica es de memoria, sin fuente leída).
- **Tercero que opina lo contrario.** El README de `klayoutmatthias/sky130_xsection` dice: "Silicide is not indicated and so
  is silicide blocking for resistors" y "Many dimensions are guesswork". Supone que hay siliciuro, sin fuente. No es de
  SkyWater.
- **Lo único que se llama "protect".** `SWD/masks.csv` l. 14: máscara *Resistor Protect*, `RPM`, usada en SKY130. En otras
  fábricas "resistor protect" es el bloqueo de siliciuro. En SKY130 la capa dibujada `rpm` 86/20 se describe como "300
  ohms/square polysilicon resistor implant" (`SWD/gds_layers.csv` l. 18) y solo la usan las resistencias de poly de precisión
  (`SWD/periphery/p029-rpm_dotdash.csv`). Su función física: **[?]**.
- **li1 es TiN** según Tim Edwards (efabless), *Introduction to the SkyWater PDK*, 2021, lámina 47: "Titanium Nitride (TiN)
  aka 'Local interconnect'" (`isn.ucsd.edu/courses/beng207/lectures/Tim_Edwards_2021_slides.pdf`). Un proceso con
  interconexión local de TiN puede tener o no siliciuro: no decide.

### 1.2 Tabla

| Pregunta | Documentado | Capas y reglas | Fabricable en el shuttle TT | Observable por nosotros |
|---|---|---|---|---|
| ¿Se siliciura la difusión? | Nada escrito. Capa n+ 120 Ω/□, p+ 197 Ω/□ (`SWD/rcx/resistance-values.tsv` l. 12–13). **Leído en la fuente.** | Ninguna capa ni regla de siliciuro; la difusión-resistencia es difusión + ID 65/13 (`MAG` l. 1150; C3). **Leído en la fuente.** Conclusión "sin siliciuro sobre la difusión": **inferido**. | Lo que haga la fábrica para TT: **[?]**. TT no puede cambiarlo: no hay capa que lo controle. **Inferido.** | Sí, y barato: tira larga de n+ y de p+ con cuatro puntas (Kelvin). ~120 Ω/□ dice sin siliciuro; unos pocos Ω/□ dice con siliciuro. **Inferido** (método); el valor, **[?]** hasta medir. |
| ¿Se siliciura el poly? | Nada escrito. Poly 48,2 Ω/□ "with NGNIT" (`SWD/device-details/res_generic/res_generic-table0.rst` l. 76–81). **Leído en la fuente.** | `res_generic_po` = poly + ID 66/13 (`MAG` l. 1153); mismo 48,2 Ω/□ que el poly de puerta (`MAG` l. 5115, 5119). **Leído en la fuente.** Qué es "NGNIT": **[?]**. | **[?]**, igual que arriba. | Tira de poly con Kelvin. **Inferido.** |
| ¿Hay bloqueo de siliciuro en difusión? | No en la lista de máscaras (`SWD/masks.csv`) ni de capas (`SWD/gds_layers.csv`). **Leído en la fuente.** | No existe. **Leído en la fuente** (C3; listas de capas). | No dibujable: la lista de capas válidas de TT no tiene nada parecido (`TT/precheck/tech_data.py` l. 4–57). Sí lo tiene para IHP (`SalBlock.drawing`, l. 63) y GF180 (`SAB`, l. 87). **Leído en la fuente.** | — |
| ¿Hay bloqueo en poly (rpm, urpm, npc)? | `rpm` 86/20 "300 Ω/□ poly resistor implant"; `urpm` 79/20 "2000 Ω/□"; `npc` 95/20 "Nitride poly cut (under licon1 areas)" (`SWD/gds_layers.csv` l. 18–20). Máscara RPM = "Resistor Protect" (`SWD/masks.csv` l. 14). **Leído en la fuente.** | Reglas `rpm.1a`–`rpm.11` (`SWD/periphery/p029-rpm_dotdash.csv`); el cuerpo de la resistencia va dentro de `npc` (`rpm.5`) y de `psdm` (`rpm.4`). Magic genera NPC sobre `xhrpoly` (`MAG` l. 1139). **Leído en la fuente.** Si RPM bloquea siliciuro, implanta, o ambas: **[?]**. | `rpm.drawing`, `urpm` (79,20) y `npc.drawing` están en la lista válida de TT (`TT/precheck/tech_data.py` l. 36, 38, 51). TT añade una regla propia urpm–nwell ≥ 0,7 µm (`TT/precheck/tech-files/nwell_urpm.drc` l. 8–12). Fabricado: **[?]**. | Resistencia `res_high_po` frente a poly corriente: dos valores de capa distintos; no separa siliciuro de implante. **Inferido.** |
| ¿Qué dispositivos usan algo de esto? | Resistencias de precisión `res_high_po_*` (300 Ω/□) y `res_xhigh_po_*` (2 kΩ/□), anchos fijos (`SWD/device-details/res_high/index.rst` l. 18–26). **Leído en la fuente.** | Celdas en `PDK/libs.ref/sky130_fd_pr`. **Leído en la fuente.** | Proyectos TT con resistencias de poly: hay en páginas de chips (p. ej. `tinytapeout.com/chips/ttsky26c/490`, RZ de poly), sin resultado de silicio en la página. **Leído en la fuente.** | — |
| ¿Puede el precheck de TT rechazar una frontera p+/n+? | — | La unión a tope pasa Magic y el deck de KLayout; el solape o el hueco de 0,13 µm no (`experiments/precheck_map/README.md`). **Leído en la fuente** (corrida del 2026-11-12). | Pasa el precheck. Pasar no es fabricar. **Leído en la fuente.** | — |
| ¿Puentea algo dibujado la frontera de XC-20? | — | Un licon no puede cruzarla: licon sobre tap a ≥ 0,06 µm del borde a tope (`SWD/periphery/p034-licon_dotdash.csv` l. 12, `licon.5b`). li1 queda sobre ~0,94 µm de óxido (`PDK/libs.tech/klayout/tech/xsect/sky130.xs` l. 63, valor que su autor llama conjetura). **Leído en la fuente**; "nada dibujado la puentea": **inferido**. | — | — |
| ¿Puentea el siliciuro la unión a tope? | Nada escrito. La regla `difftap.12` ("ESD_nwell_tap is considered shorted to the abutting diff", NC = guía no verificada; `SWD/periphery/p026-difftap_dotdash.csv` l. 15) trata de n+ contra n+ (definición en `SWD/layers/table-c3-device-lvs-other.csv` l. 12): no aplica a p+/n+. **Leído en la fuente.** | No hay capa que lo cause ni lo impida. **Leído en la fuente.** | **[?]**. Si la difusión no lleva siliciuro (inferido arriba), d = 0 es una unión, no un cable. **Inferido.** | Sí: d = 0 frente a d = 0,27 µm y la temperatura (ya en el plan de XC-20), más la tira Kelvin de n+ y p+ en el mismo chip. **Inferido.** |
| ¿Se apoya la biblioteca en un corto por siliciuro? | — | hd y hvl: ninguna frontera diff/tap a tope. fd_pr: 84 celdas a tope; todas con licon a cada lado salvo 2 trozos de tap en `rf_pfet_20v0_withptap` (C2). **Leído en la fuente** (corrida). No discrimina: un diseño con siliciuro también contacta los dos lados. **Inferido.** | — | — |

### 1.3 XC-20, en concreto

- La compuerta "¿hay siliciuro sobre la frontera en d = 0?" no se cierra con fuentes: **[?]**.
- El peso de las fuentes leídas apunta a **sin siliciuro en la difusión** (resistencias de capa, ninguna máscara ni regla
  que lo controle). Grado: **inferido**, no leído.
- Si es así, d = 0 es una unión p+/n+ y la explicación aburrida "puente óhmico" pierde fuerza. La reemplaza otra: la
  resistencia en serie. Con 1,0 × 1,4 µm por lado son menos de un cuadrado de difusión por lado (120 y 197 Ω/□) más un licon de
  185 Ω (n) y 585 Ω (p) (`MAG` l. 5130, 5132). Orden total: ~1 kΩ (**inferido**, aritmética). A 20 µA son ~20 mV; cuenta en la
  ventana de 0,1–0,3 V de la resistencia negativa, no en la inversa.
- Medida decisiva y barata en el mismo chip: **tiras Kelvin de n+, p+, poly y li** junto a XC-20. Cuesta poca área y se lee a
  1,8 V por pines analógicos. Decide el siliciuro sin depender de que XC-20 funcione.
- **Dutta et al. 2017** (DOI 10.1109/LED.2017.2701505): **sin leer** el texto. Según su ficha indexada (resumen, leído por
  buscador): LED en avalancha lateral p+-n-n+ en **CMOS bulk de 65 nm**, no SKY130; ruptura de 2 a 9 V. No es una fuente sobre
  SKY130. La tesis (U. Twente, 2017) no se pudo descargar: `ris.utwente.nl/ws/portalfiles/portal/17337861` devolvió HTML el
  2026-11-13. Ya va con XC-21 (`cells/xc20_abutted_junction/PLAN.md` §8).

---

## 2. TiN (interconexión local li1)

| Pregunta | Documentado | Capas y reglas | Fabricable en el shuttle TT | Observable por nosotros |
|---|---|---|---|---|
| ¿li1 es TiN? | Sí: Edwards 2021, lámina 47 (URL arriba). SkyWater no nombra el material en `SWD` (grep). **Leído en la fuente** (un tercero con acceso al proceso, no SkyWater). | li 67/20, 0,1 µm de espesor (`SWD/assumptions`: "LI1 thickness for antenna ratio calculations 0.1"; diagrama `SWD/../_static/metal_stack.svg`), 12,8 Ω/□ (9,2–17,0) (`res_generic-table0.rst` l. 90). **Leído en la fuente.** Resistividad ~128 µΩ·cm = 12,8 Ω/□ × 0,1 µm: **inferido** (aritmética). Composición y estequiometría: **[?]**. | li1 es capa básica: la usan todas las celdas estándar; está en la lista válida (`TT/precheck/tech_data.py` l. 15–16). Que se fabrica: **inferido** (sin li no hay chip). | Resistencia y su coeficiente térmico a temperatura ambiente: sí, con tiras Kelvin. Superconductividad (XC-54): solo con criostato; fuera de TT. **Inferido.** |
| ¿El electrodo del MiM es TiN? | `SWD` no nombra el material. Capa superior 5,8 Ω/□ (`cap_mim-table0.rst` l. 27–32). **Leído en la fuente.** | Espesor 0,06 µm solo en el script de corte, que su autor declara "guesswork" (`xsect/sky130.xs` l. 75). Con ese espesor, ~35 µΩ·cm: **inferido**, frágil. Material: **[?]**. | Ver §4. | No por medida eléctrica simple. **[?]** |

---

## 3. SONOS

| Pregunta | Documentado | Capas y reglas | Fabricable en el shuttle TT | Observable por nosotros |
|---|---|---|---|---|
| ¿Existe en SKY130? | "8th generation SONOS technology node"; dos celdas (original y "star") según la opción de tecnología (`SWD/background.rst` l. 6, 13; `SWD/device-details/special_sonosfet/index.rst` l. 4–7). Programar +6,7 / −3,8 V, 2 ms; borrar −3,8 / +6,7 V, 6 ms (`special_sonosfet-table1.rst` l. 22–37). **Leído en la fuente.** | Máscaras TUNM y ONOM marcadas como usadas (`SWD/masks.csv` l. 11–12). Capa dibujada `tunm` 80/20 (`SWD/gds_layers.csv` l. 12). Reglas: `tunm` dentro de `dnwell` (`tunm.6a`) y dentro de `areaid.ce` (`tunm.8`) (`SWD/periphery/p027-tunm_dotdash.csv`). Magic dibuja `nsonos` y lo saca como 80/20 (`MAG` l. 929 y salida `calma 80 20`). **Leído en la fuente.** | **No pasa el precheck de TT.** `TTDECK` l. 474–477: "MR_tunm.CON.1 : use of layer tunm is prohibited". Confirmado en C1. El deck del PDK tiene la misma regla (`PDK/libs.tech/klayout/drc/sky130A_mr.drc` l. 462). **Leído en la fuente** (y corrida). | Nada, mientras rija esa regla. |
| ¿Modelos y celdas en sky130A abierto? | "The flash build space is currently empty" (`SWD/../known_issues.rst` l. 87–90). **Leído en la fuente.** | Modelos ngspice sí (`PDK/libs.tech/ngspice/sonos_e`, `sonos_p`, inicio y fin de vida). Celdas de layout no: ninguna en `PDK/libs.ref/sky130_fd_pr/mag`; no hay `sky130_fd_bs_flash`. **Leído en la fuente.** | — | — |
| Contradicción abierta | El proyecto "SONOS Flash Party" (`tinytapeout.com/chips/ttcad25a/257`) dice usar SONOS en sky130A, con bombas a +7,4 y −4,5 V desde 3,3 V. Sin resultado de silicio. **Leído en la fuente.** | — | Cómo pasó el precheck con `MR_tunm.CON.1`: **[?]** (otra versión del deck, exención, o no usa `tunm`). | — |

---

## 4. MiM (capm, cap2m)

| Pregunta | Documentado | Capas y reglas | Fabricable en el shuttle TT | Observable por nosotros |
|---|---|---|---|---|
| ¿Qué es y cuánto da? | CAPM sobre met3 y CAP2M sobre met4, apilables. 2,0 fF/µm² (1,8–2,2), perímetro 0,19 fF/µm, modelo válido 0–5 V (`SWD/device-details/cap_mim/index.rst` l. 12–22; `cap_mim-table0.rst` l. 13–25). Modelo: `camimc` nominal 2,0e-15 F/µm², `cpmimc` 1,9e-16 F/µm (`PDK/libs.tech/ngspice/parameters/montecarlo.spice` l. 14, 247). **Leído en la fuente.** | Magic: ancho ≥ 1,0 µm, separación 0,84, met3 rodea por 0,14, solo rectángulos (`MAG` l. 4896–4909; cap2m l. 4919–4932). `TTDECK` l. 945–987 (capm) y siguientes (cap2m). Reglas `capm.*` de `SWD/periphery/p036-capm_dotdash.csv` publicadas como "N/A" sin valor; `capm.12` (área máxima) sin valor. **Leído en la fuente.** | `capm.drawing` y `capm2.drawing` en la lista válida (`TT/precheck/tech_data.py` l. 37, 39). Una placa capm 10 × 10 µm pasa `TTDECK` (C1). **Pero met5 está prohibido** (`tech_data.py` l. 173–178; `tinytapeout.com/specs/analog`). El contacto superior de cap2m une la placa con met5 y sale como via4 (`MAG` l. 335: `mim2cc mimcap2 metal5`; l. 1314–1315: VIA4 incluye `mim2cc`; `SWD/device-details/cap_mim/cross-section-cap_mim.svg`): **cap2m no se puede conectar en TT. Inferido.** Hay proyectos TT enviados con `cap_mim_m3_1` (`tinytapeout.com/chips/ttsky26c/490`, 22 en paralelo), sin silicio informado. Que la fábrica haga capm en el shuttle TT: **[?]** (la máscara CAPM figura sin la marca "Used in SKY130" en `SWD/masks.csv` l. 28; puede ser una errata de la tabla). | Capacidad por carga compartida o con el medidor kT/C de XC-58. **Inferido.** |
| ¿Cabe lo de XC-19? | — | Aritmética con 2,0 fF/µm² y 0,19 fF/µm, placa cuadrada: 133 fF → ~8,0 × 8,0 µm (~64 µm²); 2 × 133 fF → ~128 µm²; 10 pF → ~70,5 × 70,5 µm (~4 970 µm²). **Inferido** (aritmética; sin márgenes de regla ni bordes). Tesela 1 × 1 de TT: 161,00 × 111,52 µm = 17 955 µm² (`TT/tech/sky130A/def/tt_block_1x1_pg.def`, DIEAREA). El filtro de 10 pF solo en capm ocupa ~28 % de una tesela. **Inferido.** | Solo capm (una capa). | — |
| ¿Puede ir sobre lógica? | `capm.10`: no debe *atravesar el borde* de nwell, diff, tap, poly, li1, met1 (`p036-capm_dotdash.csv` l. 11). Un proyecto TT lo leyó como ambiguo (`tinytapeout.com/chips/ttsky25a/292`). **Leído en la fuente.** | — | **[?]** | — |

---

## 5. Alta tensión (5 V, 10,5 V, 16–20 V)

| Pregunta | Documentado | Capas y reglas | Fabricable en el shuttle TT | Observable por nosotros |
|---|---|---|---|---|
| ¿Qué dispositivos hay? | Rotura (no operación) del óxido HV: 7,3 V nMOS, 8,1 V pMOS; unión fuente/drenaje–sustrato 11,0 V; óxido de 110 Å (`SWD/hv.rst` l. 16–32). **Leído en la fuente.** | Modelos `nfet/pfet_g5v0d10v5`, `g5v0d16v0`, `nfet/pfet_20v0` (discretos) en el corner tt (`PDK/libs.tech/ngspice/corners/tt.spice`). Capas `hvi` 75/20 (óxido grueso 5 V), `vhvi` 74/21 (12 V nominal, 16 V máx.), `uhvi` 74:22 (20 V nominal) (`SWD/gds_layers.csv` l. 11, 37–38). Biblioteca de celdas de 5 V `sky130_fd_sc_hvl` en `PDK/libs.ref`. **Leído en la fuente.** | Alimentación TT: 1,8 V (VDPWR) y 3,3 V opcional (VAPWR) con plantilla propia (`tinytapeout.com/specs/analog`). `hvi.drawing`, `vhvi.drawing`, `hvntm.drawing` y (74,22) en la lista válida (`TT/precheck/tech_data.py` l. 27–28, 41, 51). `TTDECK` no prohíbe `hvi` (sección `thkox` l. 481 y `hvi` l. 1613). Tensión máxima en pines analógicos: no la da la página (solo 4 mA, < 500 Ω, < 5 pF). **[?]** Que se pueda generar > 3,3 V dentro del proyecto: no lo prohíbe nada leído; permitido: **[?]**. | Con la bomba de XC-53 (8–10 V desde 1,8 V, según su fila del catálogo), sí; sin ella, solo hasta 3,3 V. **Inferido.** |

---

## 6. Fotodiodos (si queda tiempo)

| Pregunta | Documentado | Capas y reglas | Fabricable en el shuttle TT | Observable por nosotros |
|---|---|---|---|---|
| ¿Hay fotodiodo? | Reglas `photo.1`–`photo.11`: ancho fijo 3,0 µm, dentro de anillo de dnwell y de tap p+ (`SWD/periphery/p031-photo_dotdash.csv`). **Leído en la fuente.** | `sky130_fd_pr__photodiode` en Magic (`MAG` l. 84; reglas l. 4191–4194); ID `areaid.photo` 81/81. Símbolo xschem sí; modelo SPICE no encontrado en `PDK/libs.ref/sky130_fd_pr/spice`. **Leído en la fuente.** | `areaid.photo` y `dnwell.drawing` en la lista válida (`tech_data.py` l. 12, 34). Si el encapsulado de TT deja entrar luz: **[?]**. | Corriente oscura, sí (es un diodo). Luz externa: **[?]**. Luz interna (XC-26): ver su plan. |

---

## 7. Qué cambia para las familias del catálogo

**Siliciuro.**

- XC-20: la compuerta sigue abierta, pero ya no al 50 %. Las fuentes inclinan a "sin siliciuro en difusión" (inferido). Añadir
  tiras Kelvin de n+, p+, poly y li al lado del canal; añadir "resistencia en serie de ~1 kΩ" como explicación aburrida del
  pico en directa.
- XC-40 y XC-51: retirar el "indicio" de `silicide_block`: es un estilo de pantalla, no una capa. La pregunta "¿lleva
  siliciuro el poly?" queda igual de abierta y se mide con la misma tira de poly.
- XC-30 (fila "poly silicidado"), XC-37 ("el contacto y su siliciuro"), XC-63 (barrera Schottky): todas suponen un material
  de interfaz no documentado. Marcar `[?]` hasta la tira Kelvin.

**TiN.** XC-02, XC-05, XC-54: el TiN pasa de "leído por agente" a fuente nombrada (Edwards 2021, lámina 47), sin
composición. XC-27 y XC-30: el material de li para espejos u óptica sigue `[?]`.

**SONOS.** XC-09 y XC-11 (fusionadas en XC-14), y cualquier variante con trampa ONO: imposibles en TT hoy por
`MR_tunm.CON.1`. Vehículo S u otro shuttle. XC-14 en óxido de puerta no depende de `tunm`.

**MiM.** XC-19: los dos 133 fF caben (~64 µm² cada uno) en capm; el filtro de 10 pF cuesta ~28 % de una tesela en capm o
pasa a condensador MOS (`cells/xc19_channel/README.md` ya explora uno de 16 µm²). cap2m no sirve en TT. XC-41 (variante MiM)
y XC-58 (medir capacidades): solo capm.

**Alta tensión.** XC-07, XC-14, XC-18, XC-21, XC-22 dependen de XC-53. Nada leído prohíbe la bomba ni `hvi`; nada leído la
autoriza. Es la pregunta a TT con más familias detrás.

**Fotodiodos.** XC-26 y XC-27 en transmisión dependen de que llegue luz al dado: `[?]`.

---

## 8. Preguntas concretas para Tiny Tapeout

1. **Siliciuro.** En el proceso que fabrica los shuttles SKY130 de TT, ¿la difusión n+/p+ y el poly llevan siliciuro? ¿Hay
   alguna capa que lo bloquee? ¿Qué hace físicamente la máscara RPM ("Resistor Protect")?
2. **Unión a tope.** Una difusión p+ dibujada a tope con un tap n+ dentro de un nwell (pasa su precheck): ¿la fábrica la
   puentea con algo (siliciuro, contacto) o queda como unión?
3. **SONOS.** El deck de su precheck prohíbe `tunm` (`MR_tunm.CON.1`). ¿Es definitivo? ¿Cómo entró "SONOS Flash Party"
   (ttcad25a, 257)? ¿Corre la fábrica el módulo ONO/túnel en sus lotes?
4. **MiM.** ¿Se fabrica capm (89/44) en los shuttles SKY130 de TT? ¿Hay medidas de silicio de algún proyecto con
   `cap_mim_m3_1`? ¿Confirman que cap2m no es usable al estar met5 prohibido? ¿Puede un capm cruzar sobre lógica (capm.10)?
5. **Alta tensión.** ¿Pueden un proyecto generar 8–10 V dentro de su tesela con una bomba y usar `hvi`, `g5v0d10v5` y deep
   nwell? ¿Qué tensión máxima admiten los pines analógicos y su ESD?
6. **Luz.** ¿El encapsulado o la placa dejan entrar luz al dado? ¿Se puede pedir un dado sin tapa?

---

## 9. Lo que no se hizo

- No se leyó Dutta 2017 ni su tesis (bloqueados).
- No se buscó en el Slack de open-source-silicon (sin acceso); el hilo indexado sobre "GDS > chip process"
  (`web.open-source-silicon.dev/t/423855`) ya no existe (dominio en venta, 2026-11-13).
- No se corrió Magic DRC sobre las sondas de C1 (solo KLayout). Las reglas MiM de Magic se leyeron, no se ejercitaron.
- No se comprobó la cadena de suministro (qué fábrica y qué opción de proceso usa TT para SKY130): **[?]**.

Fin: `Fri Nov 13 21:47:27 EST 2026` (de `date`).
