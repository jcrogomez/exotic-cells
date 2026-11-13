# Night sprint · Yunque · noche del 4 al 5 de noviembre de 2026

Encargo (revisión externa de la noche): no abrir v0.5; convertir EFLD-00 en una cartera fundamentada reduciendo incertidumbres
físicas en cuatro frentes. Reglas: nada de estrés real, ningún número sin fuente o corrida, estados separados. Repos: `05_exotic_lab`
(este) y `local_flow/efld_00`, `local_flow/efld_01` (flujo físico, git propio cada uno).

## Tabla de resultados

| Frente | Afirmación | Estado | Dónde |
|---|---|---|---|
| A · EFLD-00 | Macro pasivo integrado en LibreLane; DRC 0; LVS compara la resistencia real (extracción desde GDS, no LEF); cocotb 2/2 | **Verificado** | `local_flow/efld_00/LEEME.md`, `runs/wokwi/66-netgen-lvs` |
| A · EFLD-00 | Con extracción desde LEF el macro es una caja vacía y LVS "pasa" sin comparar | **Verificado** (error que habría pasado) | mismo |
| A · EFLD-00 | Las vías de un corte del enrutador llevaban hasta 14× su régimen (4,1 mA de 8 `ebufn_8`) | **Verificado** (DEF + ngspice) | `efld_00/LEEME.md`, `macros/constriccion/sim/efld00_lector_drivers.txt` |
| A · EFLD-01 | Cabezas en cadena de 18 pines (tramos `rm1`), un `ebufn_4` por pin: DRC 0, solapes 0, antena 0, LVS 17/17; cada vía de formación a 0,71×/0,89× de régimen; la línea a 5,3× con N = 8 | **Verificado** | `local_flow/efld_01/LEEME.md` |
| A · lector | Rango útil del anillo 1 kΩ–300 kΩ; +1,7 % a 1 kΩ, +32 % a 10 kΩ, 83 ps/kΩ en torno a 12,9 kΩ, satura a 1 MΩ, muere abierto; ciego a pocos ohmios | **Modelado** (ngspice esquemático) | `sim/efld00_lector_drivers.txt` |
| A · lector | Los drivers de formación añaden 26 % al período (su envejecimiento afecta a la lectura); parásitos nB 22 fF frente a rB 8 fF | **Modelado / verificado (SPEF)** | mismo |
| A · formación | Tiempo de transformación de met1 a 2 mA (4,2·10⁶ A/cm²) a temperatura ambiente | **Bloqueado** (sin modelo; pregunta experimental) | — |
| A · protección | El vigilante comparte reloj y alimentación: no es independiente | **Verificado por diseño; corrección pendiente** | `efld_01/LEEME.md` |
| A · li1 | Argumento térmico: a igual corriente, una línea de li1 (≈ 0,4–1 kΩ) disipa ~100× más que cualquier vía; `efld01c_L1` (0,29 µm, `rli`) dibujada y DRC 0, no integrada aún | **Hipótesis con geometría lista** | `macros/constriccion/cadena.tcl` |
| B · PHOTON | Fotodiodo de sky130 = DNWELL + areaid.po 3×3 µm (photo.1–11); seis celdas (fotodiodo, emisor a 5/10/20 µm + control a 40 µm, variante con guarda p+) con DRC Magic 0 y KLayout 0, prBoundary | **Verificado** | `macros/photon/LEEME.md` |
| B · PHOTON | Ni Magic ni KLayout comprueban photo.5–11 ni nwell.7 contra el photo; KLayout sí exige 6,3 µm entre photo y dnwell | **Verificado** (negativo instrumental) | mismo |
| B · PHOTON | Lectura "precarga y descarga": nodo de 12,4 fF; fuga del `ebufn_1` en Z 32 fA (27 °C) / 0,41 pA (85 °C); fotocorriente mínima ≈ 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; a 85 °C manda la deriva del fondo | **Modelado** (gmin = 1e-18; con el gmin por defecto el piso sería 50× peor y falso) | `macros/photon/sim/` |
| B · PHOTON | Corriente oscura, responsividad y capacidad medidas del fotodiodo; emisión del p+/nwell en directa | **Bloqueado** (no están en PDK ni docs) | `docs/pesca/PESCA_PHOTON_1105.md` |
| B · PHOTON | LED de filamento (Li et al. 2023): formado a 6 V sobre óxido < 3 nm; sky130 tiene 4,15 nm (1,8 V) y 11,6 nm (5 V); 1100 nm; EQE 1,4·10⁻⁸; detector externo | **Verificado (fuente) → bloqueado en flujo digital de 1,8 V** | mismo |
| C · TRAMPA | ΔVth de una trampa en MOS mínimo = 0,305 mV (C_ox 8,32 fF/µm² del PDK); un anillo de celdas estándar cambia 6·10⁻⁶: ciego | **Modelado** | `docs/EFLG00_TRAMPA.md`, `sim/rtn_presupuesto.sp` |
| C · TRAMPA | Etapa dominada por un MOS en inversión débil: ≈ 0,8 % por salto, leíble en digital diferencial | **Hipótesis** (etapa no existe en la biblioteca) | mismo |
| D · Fronteras | Nanogap túnel: Park 1999 da mediana ~10 GΩ; el lector digital lo ve como abierto; el estado kΩ del liner sí cae en rango | **Verificado (fuente) + cálculo** | `docs/FRONTERAS_FISICAS_1105.md` |
| D · Fronteras | SET: isla mínima de sky130 → 22–27 aF (E_C = 10 kT a 3,5–4,3 K); 3,1 aF exigiría ~22 nm | **Cálculo** → no en EFL01 ni EFL02 | mismo |
| D · Fronteras | Hall en nwell: sensor conocido, RSNW 950 Ω/□, µ_H del nwell `[?]` | **Fuente + `[?]`** → instrumento opcional, no Exotic Cell | mismo |
| D · Fronteras | Nanohoyos/EOT: paso mínimo 0,28 µm → pico a ~0,41 µm; requiere luz sobre el dado | **Cálculo** → EFL02 condicional | mismo |

## Decisión sobre el área de Yunque EFL01 (propuesta; decide Juan)

**Merecen área en EFL01:**
1. **FORGE / nanojunction** con el camino de formación de EFLD-01 (un pin y una vía por driver), familia A/B/C/D en met1 **y** li1 a
   0,29 µm, referencias con los mismos drivers apagados. Pregunta: ¿se escribe y se lee un estado en la región kΩ? El túnel se
   registra como "abierto" y espera a EFL02.
2. **PHOTON** como plataforma de detección: fotodiodo 3×3 legal, emisor a tres distancias, control a 40 µm, guarda conmutable,
   lectura de precarga con piso modelado de 150 fA. Predicción escrita: ganará la difusión de portadores; el valor es el instrumento.
3. **TRAMPA / RTN** solo si se diseña la etapa en inversión débil (macro propio o polarización por pin `ua`); sin ella no entra.
4. **GRABADO** (factorial de antena) no se tocó esta noche; sigue en v0.4 con su contrato.

**Esperan a EFL02 o no entran:** nanogap túnel (medida), nanohoyos (luz sobre el dado), LED de filamento (6 V), SET (criogenia y
22 nm), Hall (instrumento, no celda; opcional si sobran pines).

## Respuestas a las tres preguntas de la noche

- ¿Región conductora que pueda transformarse en nanojunction aprovechable? **Sí como precursor con infraestructura que lo sobrevive**
  (EFLD-01); la transformación en sí no está demostrada ni modelada.
- ¿Circuito que distinga un defecto individual de la variación convencional? **No con celdas estándar** (6·10⁻⁶); sí en principio con
  una etapa en inversión débil que falta diseñar.
- ¿Emisor y detector internos con instrumentación para investigar transporte óptico? **Detector legal y lectura con piso modelado, sí**;
  emisión detectable, sin evidencia; la cadena de controles está dibujada.

## Reproducción

```
# A
cd ZTASIC/local_flow && ./harden_host.sh efld_00 && ./harden_host.sh efld_01
cd efld_01/test && PDK_ROOT=../../pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71 make
cd 05_exotic_lab/macros/constriccion && docker run --rm -v "$PWD":/work hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && magic -dnull -noconsole -rcfile /foss/pdks/sky130A/libs.tech/magic/sky130A.magicrc cadena.tcl'
cd sim && docker run ... 'ngspice -b anillo_efld00.sp; ngspice -b anillo_12k9.sp; ngspice -b drivers_pequenos.sp; ngspice -b rtn_presupuesto.sp'
# B
cd 05_exotic_lab/macros/photon && (ver LEEME.md: fotodiodo.tcl, emisor.tcl, drc_klayout.sh, sim/*.sp)
```

Logs: `local_flow/efld_00_harden.log`, `local_flow/efld_01_harden.log`, `local_flow/efld_0*/test/make_rtl.log`, `macros/*/*.lyrdb`.
Commits: `05_exotic_lab` 552b286 → este; `efld_00` 6bf7a77…b54d6d4; `efld_01` 6bf7a77…ea6a9f6 (ver `git log` de cada repo).

## Errores propios de la noche (para no repetirlos)

Salida del anillo en reposo a 1 que enmascaraba al otro anillo (lo halló cocotb); modelo `tran` que daba X durante la formación;
25 min de simulación colgada por modelos del PDK con retardo cero en puertas; un `assert` que dejó EFLD-01 a medias y lanzó un
endurecido inválido; LEF sin obstrucción sobre los tramos `rm1`; patrón de NDR que no casó con `nA[0]`; "LVS limpio" de EFLD-00 que
no comparaba nada hasta extraer desde GDS; y en PHOTON, el gmin por defecto de ngspice habría dado un piso falso.
