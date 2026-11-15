# Auditoría de reproducibilidad: modo de compatibilidad `hsa` de ngspice (2026-11-13/14)

Encargada el 2026-11-13. Corridas entre **2026-11-13 23:08:01 EST** (arranque de las tandas A y B, `date` en `start_all.txt`) y **2026-11-14 11:22 EST** (último `date`, al detener la última re-corrida); la
máquina se suspendió durante la noche (el reloj saltó a 08:59 del 14 sin que avanzaran las corridas; hora exacta de inicio
de la suspensión `[?]`), lo que alarga algunos tiempos de pared. Todo en copias del repo dentro del
scratchpad de la sesión (`.../scratchpad/hsa_audit/`); en el repo solo se creó este archivo. Commit del repo auditado:
`e7bd23c` (con `.github/workflows/science.yml` modificado sin commitear por otra sesión; no se tocó).

Herramientas: `hpretl/iic-osic-tools:2025.07` (ngspice-44.2), sky130A open_pdks `8afc8346` (local, montado en `/pdk`; el
`spinit` local y el de `/foss/pdks/sky130A` son idénticos byte a byte, comprobado con `diff`).

## 0. Punto de partida (no se repite aquí)

En la imagen, `SPICE_USERINIT_DIR=/foss/pdks/ihp-sg13g2/libs.tech/ngspice` hace que ngspice ignore el `.spiceinit` de la carpeta
de trabajo. Todas las corridas guardadas se hicieron **sin** `set ngbehavior=hsa`. Confirmación independiente en los propios
registros: **80 de 80** `.log` de ngspice guardados junto a un `.sp` dicen `Note: No compatibility mode selected!`. La única salida
guardada en modo `hs a` es `experiments/verify_r3/v3_f2_salida.txt`, cuyo deck (`v3_f2.spice`) no está en el repo `[?]`.

Además, `docker run -e SPICE_USERINIT_DIR=...` **no** basta: la imagen vuelve a imponer la variable al arrancar (probado: con ese `-e`, el log de `c62_dvth` en `gen/B/` sigue diciendo `No compatibility mode selected!`). Hay que exportarla dentro del comando (`bash -c
'export SPICE_USERINIT_DIR=...; ...'`) o usar `env -u` como aquí.

## 1. Montaje

| Condición | Qué es | Cómo |
|---|---|---|
| **S** | salida guardada en el repo | `.log`/`.txt`/`.dat` tal como están |
| **A** | como se corrió | entorno por defecto de la imagen (el `.spiceinit` local, si lo hubiera, se ignora) |
| **B** | como pide el PDK | `env -u SPICE_USERINIT_DIR` + `spinit` de sky130A copiado como `.spiceinit` en la carpeta del deck |
| **Bnk** | B sin `option klu` | solo para los decks de ruido: con KLU ngspice 44.2 aborta `.noise` (ver §4.3) |

Comandos exactos (desde la carpeta `hsa_audit/`, `P` = sky130A local):

```
P=.../local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A
rsync -a --exclude .git <repo>/ A/repo/ ; rsync -a --exclude .git <repo>/ B/repo/
find cells experiments lab -name '*.sp' | sort > decks.txt          # 102 decks
# runone.sh MODE deck (dentro del contenedor):
#   A: cd /work/<dir>; timeout 1500 ngspice -b <deck> > <deck>.hsa_A.log
#   B: cd /work/<dir>; cp /hsa/sky130A_spinit .spiceinit; env -u SPICE_USERINIT_DIR timeout 1500 ngspice -b <deck> > <deck>.hsa_B.log
docker run -v $PWD/A/repo:/work -v $P:/pdk:ro -v $PWD:/hsa hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cat /hsa/decks.txt | xargs -P 4 -I{} /hsa/runone.sh A {}'      # y lo mismo con B
python3 compare.py . <repo>            # extrae los números de cada línea de resultado y compara S/A/B
python3 derive.py                      # cantidades derivadas que citan README/INFORME/PREREG
```

Los decks que generan los scripts de `experiments/attack*` y `verify*` no están en disco (`.gitignore`). Para ellos se corrió el
script en una copia, tal cual (A), y con un envoltorio de `docker` en el `PATH` que antepone `export SPICE_USERINIT_DIR=/hsainit;`
al comando del contenedor y monta ahí el `spinit` de sky130A como `.spiceinit` (B). El envoltorio se validó en
`channel_sim.sp`: da 3,02733e-05, igual que B.

`compare.py` toma de cada log las líneas de resultado (las de `echo` con etiqueta y las de `meas`), quita la tabla de punto de
operación inicial (B la suprime con `option noinit`) y compara número a número con la misma clave (esqueleto de la línea +
ocurrencia).

## 2. Resultado global

- **102 decks `.sp`** en `cells/`, `experiments/` y `lab/` (incluye `plantilla.sp`, que es una plantilla y no corre en ninguna
  condición, y las carpetas `run1_*`/`run2_*` de corridas fallidas conservadas). 80 tienen `.log` guardado junto al deck; los 22 de `lab/` no
  tienen `.log` junto al deck (las tablas viven en `LEEME.md` y `sim/*.txt`).
- **A reproduce lo guardado** en todos los decks deterministas comparables: diferencia máxima 0 (mismos dígitos impresos).
  Además `lab/.../corriente_drivers.txt` sale idéntico de `p1..p8` en A, y los períodos de `efld00_lector_drivers.txt` coinciden.
  Excepciones, ninguna por `hsa`: los Monte Carlo (§4.4) y dos decks largos que no terminaron (§4.5).
- **Cambian más de 1 % entre A y B: 11 decks**, todos de la familia del canal XC-19 extraído y anotado:
  `cells/xc19_bias/channel.sp`, `cells/xc19_channel/channel_sim.sp`, `cells/xc19_channel/explore_moscap.sp` y los 8 decks de
  `experiments/xc19_caps/` (`moscap`, `post`, `filt`, `cal`, `sw`, `sw_current`, `async`, `vb_ac`). Cambio de +3,3 % en los
  tiempos de descarga absolutos (+4,3 % con cuatro en serie), −1,2 a −1,5 mV en VB, +3,4 % en la resistencia de salida de la
  cadena. **Los cocientes y diferencias relativas cambian ≤ 0,1 % relativo** (salvo la inyección de carga, −1,6 % relativo a 20 µs).
- Otros tres aparecen > 1 % en la comparación automática y **no** son efecto de `hsa`: `lod_audit/sim/end_to_end.sp` (un cero
  numérico, 9,99e-12 frente a 9,55e-12 mV), y los dos `lod_paso4_mm.sp` y `n5_mc.sp` (Monte Carlo sin semilla efectiva, §4.4).
  En `stdcell_lod/rings.sp` los instantes de cruce intermedios (`meas`) se mueven hasta un 29 % (fase de arranque del anillo con
  `uic`), pero los **períodos** publicados cambian ≤ 5e-6.
- Todo lo demás (weak inversion, ruido, stdcell, LOD, lab) cambia ≤ 2,1e-4 relativo, la mayoría exactamente 0.

Tabla completa por deck en el anexo (§7).

## 3. Causa en el netlist (demostrada con decks mínimos)

**Predicción escrita antes de los decks mínimos:** algo de los dispositivos extraídos (ad/as/pd/ps, `sa/sb`, `m=`) reacciona a
`hs`. Resultado: no son ad/as/pd/ps ni `m=`; es **la elección de bin del modelo cuando W o L caen exactamente en el borde de un bin**,
y solo se nota si el parámetro que difiere entre bins se usa (casi siempre `saref/sbref`, que solo entran si la instancia trae
`sa/sb`).

Hechos (todos `tt`, 27 °C; carpetas `hsa_audit/hyp/`):

1. **Sin modo** frente a **`set ngbehavior=hs`** solo (o `hsa`, idéntico; `a` solo no cambia nada; el resto del `spinit` —KLU,
   `noinit`, `skywaterpdk`, `ng_nomodcheck`— no cambia nada): en 31 combinaciones de tipo × geometría **esquemáticas**
   (nfet/pfet 01v8, lvt, hvt; W 0,42–5; L 0,15–1) la diferencia es **0**. Con ad/as/pd/ps: 0. Con `m=2`: 0. (`types.sp`, `lod2.sp`.)
2. Con `sa = sb` (0,26; 0,3; 3 µm) la diferencia aparece **solo en ciertas L**: nfet 0,42/0,5 +3,18 mV; pfet_01v8_hvt 0,42/0,5
   −7,96 mV (+12 % de corriente); pfet_01v8 0,42/0,5 −7,52 mV; nfet 1/1 +1,8 a +2,2 mV; en L = 0,15 y L = 0,7: **0**. [corregido 2026-11-15 16:52: a Vg 0,9 V, Vd 0,05 V, `hyp/t0` y `t1/bin4.log` dan nfet 1/1 **+2,242 mV**, fuera del
   rango «+1,8 a +2,2»; de dónde salía +1,8 `[?]`. Reproducido en `experiments/auditoria_hsa/reproducir/`.] El
   corrimiento es el mismo para cualquier `sa` (−7,957 mV con 0,26, 0,3 y 3 µm): es el término de referencia, no el de `sa`.
3. `showmod` del modelo elegido (`bin3.sp`, `bin4.sp`): para L = 0,5 sin modo se usa el bin `lmin=0,25 lmax=0,5`
   (`saref=1,1e-6`); con `hs`, el bin `lmin=0,5 lmax=1,0` (`saref=1,75e-6 sbref=1,74e-6`). Para nfet W = 1, L = 1: sin modo
   `[0,5;1,0]×[0,84;1,0]`, `saref=1,75e-6`; con `hs` `[1;2]×[1;1,26]`, `saref=2,75e-6`. **Sin modo, un
   dispositivo en el borde va al bin de abajo; con `hs`, al de arriba.** La diferencia no se limita al valor exacto del borde:
   pfet_01v8_hvt 0,42/0,5001 y 0,42/0,501 con `sa=sb=0,3` siguen difiriendo (−7,95 y −7,92 mV, `hyp/t0/bin.log` frente a
   `hyp/t1/bin.log`), igual que 0,42/1,0001 y 0,42/0,1801. Hasta dónde llega esa ventana por encima del borde: `[?]` (no medido).
4. Los bins de sky130 son continuos en los parámetros de núcleo en casi todos los bordes (esquemático: 0), pero `saref/sbref`
   saltan entre bins (1,04 → 1,1 → 1,25/1,24 → 1,75/1,74 → 2,75/2,74 µm). Excepción encontrada: **pfet_01v8_hvt 0,42/0,18
   esquemático, −17,7 mV** entre modos (núcleo discontinuo en el borde L = 0,18). Ningún deck del repo usa esa geometría `[?]`
   para generadores no listados.
5. **Prueba decisiva en el deck afectado** (`hyp/chan/`): `channel_sim.sp` con `sa/sb` quitado **solo** de los 5 dispositivos con
   L en borde (3 de la cadena 1/1 y 2 precargas pfet_hvt 0,42/0,5): A = B en los 6 dígitos impresos
   (2,42147e-05 en ambos). Con `sa/sb` quitado solo de los 18 nfet 0,42/0,15: A 2,30012e-05, B 2,37548e-05 (+3,3 %).
   La diferencia de 3,3 % viene entera de esos 5 dispositivos. Por qué el nfet 0,42/0,15 (el DUT) no cambia: está en el bin más
   bajo de L y los dos bins de W en 0,42 tienen el mismo `saref` (1,04 µm) — comprobado (`bin4.sp`, vth idéntico).
6. **Esquemáticos de borde que usan los generadores** (b20: W 1–5, L 0,5–4; e53/v4n: g5v0d10v5 W 4–5 L 0,5; b05: 1/1, 5/0,15)
   con ad/as/pd/ps, en las cinco esquinas: 375 combinaciones, **diferencia 0 en vth y en corriente** (`hyp/dev2/dvth.txt`).

**Qué no sé:** cuál de las dos elecciones de bin es la «correcta» para una L dibujada justo en el borde; el `spinit` del PDK pide
`hsa`, así que B es lo que el PDK espera, pero no he encontrado la regla escrita `[?]`. Por qué la ventana se extiende al menos a
L = 0,501 `[?]`.

**Consecuencia de diseño, no de simulación:** el efecto LOD de la cadena 1/1 y de la precarga 0,42/0,5 depende de una convención
de redondeo del simulador. Alejar L del borde podría hacer el resultado independiente del modo, pero con 0,501 todavía no lo es; cuánto hay que
alejarse `[?]`.

## 4. Por deck

### 4.1 Los 11 decks que cambian > 1 % (familia XC-19, canal extraído y anotado)

Cantidades que citan los documentos, A = guardado (A reproduce S exactamente) frente a B (`derive.py`):

| Cantidad (dónde se cita) | A | B | B/A − 1 |
|---|---|---|---|
| VB, cuatro en serie (`xc19_bias/README`) | 0,3229 V | 0,3214 V | −1,5 mV |
| Descarga, cuatro en serie, sin C (ídem) | 47,13 µs | 49,14 µs | +4,27 % |
| Salto por 0,305 mV, cuatro en serie (ídem) | 0,8254 % | 0,8253 % | −0,004 % rel. |
| VB, tres en serie (ídem; `xc19_channel_caps/README`) | 0,4796 V | 0,4783 V | −1,2 mV |
| Descarga, tres en serie, 133 fF (`channel_sim`; README de bias/channel; `docs/CLAIMS.md`; PLAN de xc19_single_trap, xc32, xc34) | 29,2975 µs | 30,2733 µs | +3,33 % |
| A/B sin desajuste (`xc19_channel/README`: «1 en 100 000») | 1,02e-5 | 1,32e-5 | sigue ~1e-5 |
| Una etapa, +10 mV de alimentación | −6,516 % | −6,530 % | −0,2 % rel. |
| Cociente A/B, +10 mV | 7,1e-7 | 2,6e-6 | sigue < 1e-5 |
| nfet 4×4 como C (`explore_moscap`): tiempo | 27,24 µs | 28,15 µs | +3,33 % |
| ídem, cociente frente a 133 fF ideal | 0,92990 | 0,92989 | 0,00 % |
| C1: MOS cap 4,3×4,0 frente al ideal | −0,251 % | −0,252 % | igual |
| **C2: post-layout (PREREG: 29,3 µs ± 3 %)** | 29,963 µs (+2,26 % sobre 29,3) | **30,961 µs (+5,67 % sobre 29,3)** | **sale de la banda** |
| C2 relativo al ideal del mismo deck | +2,271 % | +2,270 % | igual |
| C3: A/B post-layout | 0,0551 % | 0,0552 % | igual |
| C4: salto post-layout | 0,8013 % | 0,8017 % | igual |
| C6: MiM 8×8 frente al ideal | +0,191 % | +0,191 % | igual |
| C10: hundimiento de VB, 1 pF / 10 pF / sin filtro | 0,137 / 0,0100 / 6,60 mV | 0,134 / 0,0097 / 6,54 mV | −1 a −3 % |
| C11: interacción, 1 pF / 10 pF | 0,0058 / 0,0034 % | 0,0056 / 0,0036 % | igual (orden) |
| C12: hundimiento a 2 pF / 5 pF | 0,069 / 0,025 mV | 0,068 / 0,025 mV | igual |
| C13: inyección a 2 / 10 / 20 µs | 0,538 / 0,675 / 0,879 % | 0,537 / 0,669 / 0,865 % | −0,2 / −0,9 / −1,6 % rel. |
| C14: cambio entre 2 y 20 µs | 63,4 % | 61,1 % | igual (falla) |
| Conmutado pfet / puerta de transmisión | 1,117 / 1,324 % | 1,117 / 1,323 % | igual |
| Conmutado a −20/0/+20 mV de puerta | 1,109 / 1,117 / 1,124 % | 1,108 / 1,117 / 1,124 % | igual |
| t₀ a −20/0/+20 mV | 50,96 / 30,00 / 17,75 µs | 52,68 / 31,00 / 18,33 µs | +3,3 % |
| Interacción asíncrona (`async`) | −0,0018 % | −0,0017 % | igual |
| R de salida de la cadena (`vb_ac`) | 656 kΩ | 678 kΩ | +3,4 % |
| C del filtro dibujado a 1 MHz | 10,17 pF | 10,14 pF | −0,2 % |
| τ del filtro | 6,7 µs | 6,9 µs | +3,2 % |
| `xc19_read/post_layout.sp` (55,6 / 36,8 / 29,0 µs; factor 1,51) | — | ≤ 6e-5 relativo | no cambia |

### 4.2 Qué conclusión escrita cambia

| Documento | Afirmación | Con B | Veredicto |
|---|---|---|---|
| `experiments/xc19_caps/PREREG.md` C2 / `INFORME.md` §2 | «29,3 µs ± 3 %: 29,963 µs, +2,27 %, se cumple por poco» | 30,961 µs: +5,67 % sobre 29,3 | **Cambia: falla como está escrita.** La banda se anclaba en 29,2975 µs, el ideal medido sin `hsa`; contra el ideal del mismo deck B da +2,27 %, igual que A. El criterio de muerte (± 5 % del ideal del mismo deck) **no** cambia. |
| `tools/science_ci.py`, regresión `channel_sim[i]` con tolerancia 1 % | — | +3,3 % | **Fallaría** en un ejecutor donde el `.spiceinit` sí se lee (el runner de GitHub no tiene `SPICE_USERINIT_DIR`). El comentario «compatibility mode, as the committed runs used» es falso: las corridas guardadas no lo usaron. `post_layout` y los controles positivos/negativos pasan en B. |
| `cells/xc19_bias/README.md` | 0,323 V / 47,0 µs ; 0,480 V / 29,2 µs | 0,321 V / 49,1 µs ; 0,478 V / 30,3 µs | Números absolutos cambian; el salto (0,83 / 0,80 %) no. |
| `cells/xc19_channel/README.md`, `docs/CLAIMS.md`, `cells/xc19_single_trap/PLAN.md` l.37 y l.52, `cells/xc32_supply_coupling/PLAN.md` l.34, `cells/xc34_offlabel_cells/PLAN.md` l.35, `xc19_noise/README.md` l.81 | 29,2 µs; 27,1 frente a 29,2 µs; 29,963 frente a 29,298 µs | 30,3 µs; 28,2 frente a 30,3; 30,96 frente a 30,27 | Cambia el absoluto (+3,3 %); los cocientes y las conclusiones (6,5 %/10 mV, A/B ~1e-5, salto 0,80 %, 230 ns por salto → 240 ns) se sostienen. |
| `cells/xc19_channel_caps/README.md`, `xc19_caps/INFORME.md` §3 y §4.3 | 656 kΩ, τ ≈ 6,7 µs; 0,47 nA para 0,305 mV | 678 kΩ, τ ≈ 6,9 µs; 0,45 nA | Cambio de 3 %; ninguna conclusión depende de él. |
| `xc19_caps/INFORME.md` C10 | «se cumple en el borde a 10 pF» (0,0100 mV frente a 0,002–0,01) | 0,0097 mV | Sigue «en el borde» (ahora por dentro). |
| `xc19_caps/INFORME.md` C13 | «solo a 20 µs» (0,879 % en 0,792–0,968) | 0,865 % | Igual. |
| Resto de C1, C3–C14, criterios de muerte de condensador, filtro y calibración | — | — | Ninguno cambia. |

### 4.3 Decks que no cambian (≤ 2,1e-4 relativo)

- `experiments/xc19_weak_inversion/` (todo, incluidas `run1_*` y `run2_*`): 0 salvo `bias_ss_27` (1,1e-6), `n3_cap_10` (4e-7),
  `stage_K3_1800_27` (2,1e-4), `stage_K3_1810_27` (2,3e-6). Esquemáticos sin `sa/sb`. `dc_27.dat`/`dc_28.dat` (base de
  `budget.txt`): 3e-8. Ninguna predicción P1–P7, B1–B4, S1–S5, N3, N4 ni criterio de abandono cambia.
- Ruido (`noise_K3/K4`, `noise_spectrum_K4/K5`, y los de `run1_*`): en B **abortan** (`Noise simulation is not (yet) supported
  with 'option KLU'`), así que con el `spinit` del PDK tal cual no hay número. En Bnk (`hsa` sin `option klu`): ≤ 4,4e-5 en las
  líneas y en los `.dat`.
- `experiments/xc19_noise/k3_cap.sp` (N8c, 19,0 µs): 0. `cells/xc19_read/post_layout.sp`: ≤ 6,3e-5 (la precarga 0,42/0,5 sí
  cambia de bin, pero apagada no pesa).
- `experiments/lod_audit/sim/lod_paso1.sp`, `end_to_end.sp`; `lab/macros/grabado_lod/sim/lod_paso1.sp`: 0 (los nfet son
  0,42/0,15 y 5/0,15: bin único en L). La auditoría LOD (+23,5 mV, 31,1 / 44,1 mV) no cambia.
- `experiments/stdcell_lod/devices_inv1.sp`: 0; `rings.sp`: períodos ≤ 5e-6 (5,1 / 3,2 / 2,5 / 4,1 % más rápidos, igual).
- `lab/`: 0 en `driver_linea`, `drivers_efld00`, `drivers_pequenos`, `n1..n8`, `p1..p8`, `anillo_sindrivers`, `cap_fd`,
  `fuga_ebufn`; `lectura.sp` ≤ 3,5e-6. Los tres `anillo_*` y `rtn_presupuesto` no terminaron (§4.5).
- Generadores: `attack_xc60_62_63/c62_dvth` (L de 0,150 a 0,250, con bordes 0,18 y 0,25): `.dat` ≤ 4,6e-8, `c62_dvth.txt`
  idéntico en A, B y guardado. `attack2_xc05/b05_5_gen.py`: `t0_dc`, `t0b_cal`, `t2_saltos`, `t4_rango`, `t8_fuente`
  idénticos en A y B (y A igual a `b05_5_lector.txt` en esas secciones); `t5_lector` A vs B ≤ 5,0e-5. `t1_arranque` solo terminó
  en A y `t7_anillo` solo en B (el resto murió por memoria o seguía corriendo al cerrar): sin comparación `[?]`.

### 4.4 Monte Carlo: A no reproduce lo guardado, con o sin `hsa`

- `lod_audit/sim/lod_paso4_mm.sp` (y su copia en `lab/macros/grabado_lod`) no fija semilla: cada corrida da otros sorteos. σ(Vth)
  0,42/0,15 · 5/0,15: guardado 17,34 · 5,13 mV; A 20,18 · 4,89; B 18,54 · 5,55; la copia de `lab/macros/grabado_lod`: A 18,38 · 5,16, B 18,06 · 4,83. Con `set rndseed=20261111` añadido en una copia:
  A 19,04 · 5,37; B 19,24 · 5,49 mV, pero los sorteos **no** coinciden uno a uno entre A y B (|ΔVth| hasta 0,078 V en un mismo
  índice). La diferencia A–B está dentro del error de σ con 300 sorteos (~4 %). Aparte de `hsa`: el 17,3 mV publicado no se
  reproduce mejor que ~±15 % entre corridas (de 17,3 a 20,2 mV en las siete corridas de 300 sorteos de arriba). Las «16 parejas
  por nivel» de `lod_audit/README` dependen de esa σ; no las recalculé `[?]`. No es objeto de esta auditoría; se anota.
- `xc19_weak_inversion/n5_mc.sp` fija `rndseed`, pero A **no** reproduce los sorteos guardados (primer `ta`: 7,57 µs guardado,
  79,4 µs en A, 27,9 µs en B). Probablemente la semilla se fija en `.control`, después de que el PDK ya evaluó sus `agauss`
  `[?]`. Se cortó a 25 min (3–5 sorteos): sin estadística. **Efecto de `hsa` sobre N5: no medido** `[?]`; por el mecanismo (§3)
  la cadena y las precargas de N5 son esquemáticas sin `sa/sb`, así que no se espera.

### 4.5 No terminados o no corridos

| Deck / script | Qué pasó | Qué se sabe |
|---|---|---|
| `xc19_noise/shot_trnoise.sp` (48 conversiones, ~11 min por ms simulado) | cortado a 25 min en A y B | Recorte a 4 conversiones (0,16 ms, misma semilla): A reproduce los 4 `SHOT` guardados exactos; B da otra realización del ruido (±0,8 % por conversión, sin signo fijo), así que **no** es comparable conversión a conversión, y 4 muestras no dan dispersión. Celda `xc19_read.pex.spice` sin `sa/sb` y cadena esquemática: por §3 no se espera efecto sistemático. Dispersión 0,548 % en B: `[?]`. |
| `xc19_weak_inversion/n5_mc.sp` | cortado a 25 min | §4.4 |
| `verify_r4_nodo/v4n_dickson.py` (20 transitorios en paralelo por modo) | detenido por mí (saturaba la máquina) | pfet_g5v0d10v5 5/0,5 esquemático: 0 en las cinco esquinas (§3, punto 6). No corrido. |
| `attack_xc14_07_53/e53_gen.py` (64 transitorios) | no corrido | g5v0d10v5 4/0,5 esquemático: 0 (§3). |
| `attack2_xc20/b20_spice_gen.py` + `run.sh` | no corrido | todas sus geometrías esquemáticas con ad/as: 0 en cinco esquinas (§3). |
| `attack_xc58/c58_det2/3/4`, `c58_trn`, `c58b_ciclos` | no corridos | incluyen `xc19_read.pex.spice` (sin `sa/sb`): por §3 y por `post_layout.sp`, sin efecto esperado. |
| `lab/macros/constriccion/sim/anillo_12k9`, `anillo_efld00`, `anillo_efld00_altaR` | cortados a 25 min en A y B; re-corrida con 50 min: dos muertos por memoria (rc = 137, a los 27 y 32 min), el tercero detenido por mí a las 11:22 | lo impreso antes del corte coincide en A y B. Sin número final de estos tres decks `[?]`. |
| `lab/macros/constriccion/sim/rtn_presupuesto.sp` | cortado a 25 min en A y B | lo impreso antes: líneas de resultado ≤ 2,9e-6. Sin número final `[?]`. |
| `verify_r3` (`v3_f2.spice`) | deck ausente del repo | su salida guardada ya está en `hs a` |
| `lab/macros/constriccion/sim/plantilla.sp` | rc = 1 en A y B | es una plantilla |

## 5. Lo que se deduce

**Observado:** las corridas guardadas no usan `hsa`; con `hsa` cambian 11 decks, todos los que contienen la cadena 1/1 o la
precarga 0,42/0,5 **con `sa/sb` anotados** por Residual; en ellos los tiempos absolutos suben 3,3 % (4,3 % con cuatro en serie)
y los cocientes no se mueven.

**Demostrado (decks mínimos y prueba de quitar `sa/sb`):** el mecanismo es la elección de bin en los bordes W/L, que solo se nota a
través de `saref/sbref` (y en pfet_hvt L = 0,18 también en el núcleo).

**Conclusiones que cambian:** C2 de `xc19_caps` tal como está escrita (banda absoluta) y la regresión `channel_sim` de
`tools/science_ci.py` con tolerancia 1 %. Todas las conclusiones basadas en cocientes, saltos, diferencias A/B y criterios de
muerte relativos sobreviven.

**Conjetura:** ningún otro número del repo depende de `hsa` más que lo medido aquí; los no corridos (§4.5) se apoyan en el
mecanismo, no en una corrida.

## 6. Archivos de la auditoría (scratchpad, no versionados)

[corregido 2026-11-15 16:52] Rescatados al repo, sin las copias del repo ni los volcados pesados, en
[`auditoria_hsa/`](auditoria_hsa/README.md), con una reproducción mínima desde un clon limpio y la lista de lo que no se rescató.

`hsa_audit/{A,B}/repo/**/<deck>.hsa_{A,B}.log`, `times_{A,B}.txt`, `compare.py`, `compare.json`, `compare_final.txt`,
`derive.py`, `derive.md`, `hyp/` (decks mínimos: `dev.sp`, `types.sp`, `lod2.sp`, `bin.sp`, `bin2.sp`, `bin3.sp`, `bin4.sp`,
`chan/`, `dev2/`, `short/`), `gen/{A,B2,A3,B3}/` (generadores; `gen/B/` es una corrida con el primer envoltorio, que no funcionaba:
ver `gen/LEEME_B_invalido.txt`), `Bnk/`, `A2/`, `B2r/` (re-corridas), `shim/docker`.

## 6b. Aplicado (2026-11-14 16:26–16:33 EST, `date`; Juan aprobó los pasos 1–3)

- `tools/ngspice_pdk.sh`: corre ngspice con el `spinit` de sky130A como `.spiceinit` y `env -u SPICE_USERINIT_DIR`; sin `option klu`
  si el deck tiene `noise`. Una corrida por carpeta a la vez (el `.spiceinit` es de la carpeta; la primera tanda en paralelo chocó
  por eso y se repitió en serie). Lo usan `tools/science_ci.py` y `experiments/xc19_caps/run.sh`.
- Los 11 decks de §4.1 y `cells/xc19_read/post_layout.sp` se volvieron a correr así en la imagen. Todos los logs dicen
  `Compatibility modes selected: hs a` y los números coinciden con la condición B de esta auditoría (p. ej. `channel_sim`
  3,02733e-05, `post` 30,9606 µs, `vb_ac` 678 434 Ω). Los `.txt` anteriores se conservan como `*.sin_hsa.txt`; los `.log`
  anteriores, en el historial de git (`e7bd23c`). `summary.txt` sale ahora de `summary.py`, que reproduce exactamente el anterior
  desde los `*.sin_hsa.txt`.
- Correcciones `[corregido 2026-11-14 16:33]` en las líneas de §4.2, sin borrar las cifras viejas; enmienda fechada al final del
  PREREG de `xc19_caps` (C2 se juzga tal como estaba escrita: falla).
- `science_ci.py` en la imagen: 0 fallos con las referencias nuevas.
- Sin tocar: los demás generadores y `README` que corren `docker ... ngspice -b` directo (sus decks no cambian, §4.3, pero si se
  reutilizan con dispositivos en borde de bin y `sa/sb` hay que pasarlos por el wrapper `[?]` pendiente); el resto de ZTASIC (paso 4).

## 6c. Paso 4: el resto de ZTASIC (2026-11-14 18:40–19:05 EST, `date`)

Inventario: 175 archivos de netlist fuera de este repo (sin `99_archivo`, `.git`, PDK). Con `sa`/`sb`: solo los tests propios de la
imagen en `00_curso/IIC-OSIC-TOOLS/_tests` y `05_exotic_lab/macros/grabado_lod` (copia de `lab/`, ya cubierta). Lo que se simuló
con transistores sky130 es: `01_hat87/research/chip/phy02` (anillos), `03_metacal/spice/ro_rtn.py` (anillos con tamaños de celdas
hd), `local_flow/spice` (redes peores con celdas hd), `05_exotic_lab` (= `lab/`) y ejercicios de `00_curso`.

**Barrido de dispositivos** (scratchpad `paso4/dev/`): las 40 geometrías (modelo, W, L) de transistores de `sky130_fd_sc_hd`, cada
una a |Vgs| = 0,5, 1,2 y 1,8 V con |Vds| = 1,8 V, cinco esquinas, sin modo frente a `hsa` (600 comparaciones de corriente). Todas
≤ 1,1e-6 relativo **salvo `pfet_01v8_hvt` con L = 0,18** (W 0,42 y 0,82): +12,8 / +16,2 % de corriente a 1,8 V en tt, hasta 64 %
a |Vgs| = 0,5 V. Es la discontinuidad de núcleo de §3 punto 4. La usan solo tres celdas: `clkdlybuf4s18_1`, `clkdlybuf4s18_2` y
`dlygate4sd2_1`. Ninguna simulación de ZTASIC las instancia (solo aparecen en configuraciones de LibreLane, que usan liberty y
no ngspice). Cuál de los dos bins es el bueno para L = 0,18: `[?]`.

| Dónde | Modo de las corridas guardadas | Efecto de `hsa` | Veredicto |
|---|---|---|---|
| `local_flow/spice` (6 decks, red peor) | ya `hs a` (`.spiceinit` propio; los 4 `.log` lo dicen) | — | sin cambio |
| `01_hat87/.../phy02/lector_ro.py` | imagen por defecto (sin modo) | 0 en las 15 frecuencias (corrido en los dos modos) | sin cambio. Aparte: la re-corrida difiere de `lector_ro.json` en S(C) en el 4.º decimal (0,02955 → 0,02957), en ambos modos; causa `[?]`, no es `hsa` |
| `01_hat87/.../phy02/mc_*.py` (Monte Carlo) | sin modo | nominal 0 (mm = 0); con desapareamiento los sorteos cambian | `SPICE_RNDSEED` **no fija los sorteos**: dos corridas del mismo modo y semilla dan otras frecuencias (A y B). Lo publicado son σ sobre 30–60 semillas y el texto ya dice «distinto según la semilla»; ninguna afirmación depende de un sorteo concreto. Que σ no cambie con `hsa` se apoya en el mecanismo (geometrías 1,0/0,15 y 0,65/0,15, iguales en nominal), no en una corrida `[?]` |
| `03_metacal/spice/ro_rtn.py` | sin modo | todas sus geometrías (n 0,42/0,65, p_hvt 0,42/0,84/1,0, L = 0,15) dan ≤ 1,1e-6 en el barrido | sin cambio (por barrido, no re-corrido) |
| `00_curso` | ejercicios del curso | no auditado | fuera de alcance |

**Conclusión del paso 4:** fuera de XC-19 ninguna simulación guardada de ZTASIC cambia por `hsa`. Queda una trampa para el
futuro: cualquier simulación a nivel de transistor que incluya `clkdlybuf4s18_*` o `dlygate4sd2_1` (o un pfet_hvt de L = 0,18) da
resultados distintos según el modo; correrla con `tools/ngspice_pdk.sh`.

## 7. Anexo: todos los decks

«máx rel.» = mayor |x_B − x_A| / max(|x_A|, |x_B|) sobre los números de las líneas de resultado; «faltan» = líneas presentes en
una sola de las dos salidas. Tiempos de pared con la máquina compartida por hasta ~20 procesos (no son tiempos de referencia).

La columna «A vs B» normaliza por el mayor de los dos valores, por eso +3,3 % aparece como 3,2e-02. «faltan» en los decks de
ruido son las líneas de `.noise` que B no produce (KLU). Las re-corridas de `run1_mult_ignored/bias_*` que superaron 25 min en la
tanda principal terminaron en A2/B2r (rc = 0).

| deck | A rc / s | B rc / s | guardado vs A | A vs B, resultados | A vs B, `meas` | nota |
|---|---|---|---|---|---|---|
| `cells/xc19_bias/channel.sp` | 0 / 126 | 0 / 132 | 0 | 4.1e-02 **>1 %** | 4.1e-02 |  |
| `cells/xc19_channel/channel_sim.sp` | 0 / 95 | 0 / 107 | 0 | 3.2e-02 **>1 %** | 3.2e-02 |  |
| `cells/xc19_channel/explore_moscap.sp` | 0 / 95 | 0 / 98 | 0 | 3.2e-02 **>1 %** | 3.2e-02 |  |
| `cells/xc19_read/post_layout.sp` | 0 / 124 | 0 / 125 | 0 | 6.3e-05 | 6.2e-05 |  |
| `experiments/lod_audit/sim/end_to_end.sp` | 0 / 48 | 0 / 47 | 0 | 4.4e-02 | 0 | cero numérico (~1e-11) |
| `experiments/lod_audit/sim/lod_paso1.sp` | 0 / 48 | 0 / 43 | 0 | 0 | 0 |  |
| `experiments/lod_audit/sim/lod_paso4_mm.sp` | 0 / 74 | 0 / 68 | 9.3e-02 | 1.0e-01 | 0 | MC sin semilla (§4.4) |
| `experiments/stdcell_lod/devices_inv1.sp` | 0 / 34 | 0 / 35 | 0 | 0 | 0 |  |
| `experiments/stdcell_lod/rings.sp` | 0 / 147 | 0 / 145 | 0 | 5.0e-06 | 2.9e-01 | `meas` = fase de arranque; períodos ≤ 5e-6 |
| `experiments/xc19_caps/async.sp` | 0 / 59 | 0 / 62 | 0 | 4.0e-02 **>1 %** | 3.2e-02 |  |
| `experiments/xc19_caps/cal.sp` | 0 / 107 | 0 / 101 | 0 | 3.2e-02 **>1 %** | 3.2e-02 |  |
| `experiments/xc19_caps/cv.sp` | 0 / 71 | 0 / 71 | 0 | 0 | 0 |  |
| `experiments/xc19_caps/filt.sp` | 0 / 400 | 0 / 350 | 0 | 3.4e-02 **>1 %** | 3.2e-02 |  |
| `experiments/xc19_caps/moscap.sp` | 0 / 128 | 0 / 125 | 0 | 3.2e-02 **>1 %** | 3.2e-02 |  |
| `experiments/xc19_caps/post.sp` | 0 / 86 | 0 / 80 | 0 | 3.2e-02 **>1 %** | 3.2e-02 |  |
| `experiments/xc19_caps/sw.sp` | 0 / 85 | 0 / 79 | 0 | 3.2e-02 **>1 %** | 3.2e-02 |  |
| `experiments/xc19_caps/sw_current.sp` | 0 / 247 | 0 / 213 | 0 | 3.3e-02 **>1 %** | 3.3e-02 |  |
| `experiments/xc19_caps/vb_ac.sp` | 0 / 59 | 0 / 57 | 0 | 3.3e-02 **>1 %** | 3.3e-02 |  |
| `experiments/xc19_noise/k3_cap.sp` | 0 / 136 | 0 / 141 | 0 | 0 | 0 |  |
| `experiments/xc19_noise/shot_trnoise.sp` | 124 / 35474 | 124 / 35474 | 0 (faltan 96) | 0 | 0 | cortado (§4.5) |
| `experiments/xc19_weak_inversion/bias_ff_27.sp` | 0 / 72 | 0 / 65 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_ff_85.sp` | 0 / 52 | 0 / 59 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_fs_27.sp` | 0 / 53 | 0 / 58 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_fs_85.sp` | 0 / 51 | 0 / 49 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_sf_27.sp` | 0 / 63 | 0 / 48 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_sf_85.sp` | 0 / 63 | 0 / 48 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_ss_27.sp` | 0 / 62 | 0 / 54 | 0 | 1.1e-06 | 0 |  |
| `experiments/xc19_weak_inversion/bias_ss_85.sp` | 0 / 80 | 0 / 57 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_tt_27.sp` | 0 / 82 | 0 / 58 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/bias_tt_85.sp` | 0 / 82 | 0 / 66 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/dc_27.sp` | 0 / 79 | 0 / 84 | 0 | 0 | 0 | `.dat` A vs B 3.2e-08 |
| `experiments/xc19_weak_inversion/dc_28.sp` | 0 / 81 | 0 / 83 | 0 | 0 | 0 | `.dat` A vs B 3.4e-08 |
| `experiments/xc19_weak_inversion/explore_leak_27.sp` | 0 / 79 | 0 / 85 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/explore_leak_85.sp` | 0 / 81 | 0 / 77 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/explore_lod_source_side.sp` | 0 / 79 | 0 / 78 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/explore_twin_1800.sp` | 0 / 246 | 0 / 221 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/explore_twin_1810.sp` | 0 / 274 | 0 / 244 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/leak_27.sp` | 0 / 139 | 0 / 85 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/leak_85.sp` | 0 / 120 | 0 / 147 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/n3_cap_1.sp` | 0 / 34284 | 0 / 254 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/n3_cap_10.sp` | 0 / 34302 | 0 / 241 | 0 | 0 | 4.2e-07 |  |
| `experiments/xc19_weak_inversion/n3_cap_30.sp` | 0 / 34304 | 0 / 34240 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/n3_cascode_1800.sp` | 0 / 387 | 0 / 34443 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/n3_cascode_1810.sp` | 0 / 329 | 0 / 34400 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/n4_cross.sp` | 0 / 467 | 0 / 434 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/n5_mc.sp` | 124 / 1502 | 124 / 1503 | 9.6e-01 (faltan 182) | 9.8e-01 (faltan 1) | 9.8e-01 | MC, cortado (§4.4) |
| `experiments/xc19_weak_inversion/noise_K3.sp` | 0 / 325 | 0 / 83 | 0 | 0 (faltan 4) | 0 | B aborta por KLU; Bnk ≤ 4,4e-5 (§4.3) |
| `experiments/xc19_weak_inversion/noise_K4.sp` | 0 / 366 | 0 / 351 | 0 | 0 (faltan 4) | 0 | B aborta por KLU; Bnk ≤ 4,4e-5 (§4.3) |
| `experiments/xc19_weak_inversion/noise_spectrum_K4.sp` | 0 / 302 | 0 / 309 | 0 | 0 | 0 | `.dat` A vs B 0 |
| `experiments/xc19_weak_inversion/noise_spectrum_K5.sp` | 0 / 148 | 0 / 338 | 0 | 0 | 0 | `.dat` A vs B 0 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_ff_27.sp` | 124 / 1503 | 0 / 175 | 0 (faltan 24) | 0 (faltan 24) | 0 | re-corrida (A2/B2r): A = guardado, A vs B ≤ 2,3e-6 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_ff_85.sp` | 124 / 1503 | 0 / 167 | 0 (faltan 24) | 0 (faltan 24) | 0 | re-corrida (A2/B2r): A = guardado, A vs B ≤ 2,3e-6 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_fs_27.sp` | 124 / 1505 | 0 / 859 | 0 (faltan 24) | 0 (faltan 24) | 0 | re-corrida (A2/B2r): A = guardado, A vs B ≤ 2,3e-6 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_fs_85.sp` | 0 / 1307 | 124 / 1506 | 0 | 0 (faltan 24) | 0 | re-corrida (A2/B2r): A = guardado, A vs B ≤ 2,3e-6 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_sf_27.sp` | 0 / 1021 | 124 / 1502 | 0 | 0 (faltan 24) | 0 | re-corrida (A2/B2r): A = guardado, A vs B ≤ 2,3e-6 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_sf_85.sp` | 0 / 967 | 0 / 1316 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_ss_27.sp` | 0 / 962 | 0 / 1092 | 0 | 1.1e-06 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_ss_85.sp` | 0 / 622 | 0 / 855 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_tt_27.sp` | 0 / 481 | 0 / 836 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/bias_tt_85.sp` | 0 / 461 | 0 / 531 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/explore_leak_27.sp` | 0 / 437 | 0 / 535 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/explore_leak_85.sp` | 0 / 158 | 0 / 522 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/explore_twin_1800.sp` | 0 / 312 | 0 / 611 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/explore_twin_1810.sp` | 0 / 309 | 0 / 511 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/leak_27.sp` | 0 / 174 | 0 / 315 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/leak_85.sp` | 0 / 209 | 0 / 240 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/noise_K4.sp` | 0 / 187 | 0 / 191 | 0 | 0 (faltan 4) | 0 | B aborta por KLU; Bnk ≤ 4,4e-5 (§4.3) |
| `experiments/xc19_weak_inversion/run1_mult_ignored/noise_K5.sp` | 0 / 158 | 0 / 177 | 0 | 0 (faltan 4) | 0 | B aborta por KLU; Bnk ≤ 4,4e-5 (§4.3) |
| `experiments/xc19_weak_inversion/run1_mult_ignored/noise_spectrum_K4.sp` | 0 / 141 | 0 / 137 | 0 | 0 | 0 | `.dat` A vs B 0 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/noise_spectrum_K5.sp` | 0 / 141 | 0 / 131 | 0 | 0 | 0 | `.dat` A vs B 0 |
| `experiments/xc19_weak_inversion/run1_mult_ignored/stage_K4_1800_27.sp` | 0 / 259 | 0 / 278 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/stage_K4_1810_27.sp` | 0 / 256 | 0 / 279 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/stage_K5_1800_27.sp` | 0 / 288 | 0 / 331 | 0 | 0 | 1.7e-07 |  |
| `experiments/xc19_weak_inversion/run1_mult_ignored/stage_K5_1810_27.sp` | 0 / 305 | 0 / 341 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run2_explore_min_pfet/explore_twin_1800.sp` | 0 / 278 | 0 / 268 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/run2_explore_min_pfet/explore_twin_1810.sp` | 0 / 257 | 0 / 271 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/stage_K3_1800_27.sp` | 0 / 289 | 0 / 291 | 0 | 2.1e-04 | 2.1e-04 |  |
| `experiments/xc19_weak_inversion/stage_K3_1810_27.sp` | 0 / 339 | 0 / 284 | 0 | 2.3e-06 | 2.3e-07 |  |
| `experiments/xc19_weak_inversion/stage_K4_1800_27.sp` | 0 / 287 | 0 / 275 | 0 | 0 | 0 |  |
| `experiments/xc19_weak_inversion/stage_K4_1810_27.sp` | 0 / 265 | 0 / 275 | 0 | 0 | 0 |  |
| `lab/macros/constriccion/sim/anillo_12k9.sp` | 124 / 1500 | 124 / 1501 | sin `.log` guardado | 0 (faltan 2) | 0 | no terminó (§4.5) |
| `lab/macros/constriccion/sim/anillo_efld00.sp` | 124 / 1501 | 124 / 1501 | sin `.log` guardado | 0 (faltan 2) | 0 | no terminó (§4.5) |
| `lab/macros/constriccion/sim/anillo_efld00_altaR.sp` | 124 / 1501 | 124 / 1500 | sin `.log` guardado | 0 | 0 | no terminó (§4.5) |
| `lab/macros/constriccion/sim/anillo_sindrivers.sp` | 0 / 853 | 0 / 1078 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/driver_linea.sp` | 0 / 113 | 0 / 72 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/drivers_efld00.sp` | 0 / 103 | 0 / 62 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/drivers_pequenos.sp` | 0 / 51 | 0 / 54 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/n1.sp` | 0 / 49 | 0 / 48 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/n2.sp` | 0 / 75 | 0 / 44 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/n4.sp` | 0 / 59 | 0 / 67 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/n8.sp` | 0 / 61 | 0 / 67 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/p1.sp` | 0 / 61 | 0 / 59 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/p2.sp` | 0 / 67 | 0 / 53 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/p4.sp` | 0 / 77 | 0 / 53 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/p8.sp` | 0 / 85 | 0 / 54 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/constriccion/sim/plantilla.sp` | 1 / 56 | 1 / 53 | sin `.log` guardado | 0 | 0 | plantilla |
| `lab/macros/constriccion/sim/rtn_presupuesto.sp` | 124 / 1501 | 124 / 1501 | sin `.log` guardado | 2.9e-06 | 2.8e-03 | cortado a 25 min en A y B; compara solo lo impreso antes |
| `lab/macros/grabado_lod/sim/lod_paso1.sp` | 0 / 57 | 0 / 83 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/grabado_lod/sim/lod_paso4_mm.sp` | 0 / 184 | 0 / 149 | sin `.log` guardado | 8.7e-02 | 0 | MC sin semilla (§4.4) |
| `lab/macros/photon/sim/cap_fd.sp` | 0 / 37 | 0 / 54 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/photon/sim/fuga_ebufn.sp` | 0 / 124 | 0 / 910 | sin `.log` guardado | 0 | 0 |  |
| `lab/macros/photon/sim/lectura.sp` | 0 / 455 | 0 / 590 | sin `.log` guardado | 2.7e-06 | 3.5e-06 |  |

