# Auditoría HSA: material rescatado y reproducción mínima

Rescatado el **2026-11-15 16:45–16:55 EST** (`date`) desde el scratchpad de la sesión de la auditoría
(`/private/tmp/claude-501/.../scratchpad/hsa_audit/` y `.../scratchpad/paso4/`), que vive en `/private/tmp` y puede perderse.
Informe de la auditoría: [`../AUDITORIA_HSA_2026-11-13.md`](../AUDITORIA_HSA_2026-11-13.md). Aprobado por Juan el 2026-11-15
(punto 1 de la revisión externa). El directorio temporal **no se ha borrado**; se conserva hasta que el commit esté publicado y la
reproducción desde un clon remoto haya pasado. [corregido 2026-11-15 17:15] Borrado por decisión de Juan, después de publicar `1952257` y de
que la CI científica de GitHub pasara la reproducción mínima en un Ubuntu limpio (run 43767551694).

## Reproducir el fenómeno desde un clon limpio

Requisitos fijados: ngspice **44.2** y sky130A open_pdks **8afc8346a57fe1ab7934ba5a6056ea8b43078e71** (los mismos que la CI
científica, `.github/workflows/science.yml`). Con la imagen de la auditoría:

```
git clone https://github.com/jcrogomez/exotic-cells && cd exotic-cells
docker run --rm -v $PWD:/work -v <ruta a sky130A>:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip \
  sh /work/experiments/auditoria_hsa/reproducir/reproducir.sh
```

Sin Docker, en una máquina con ngspice 44.2 y el PDK (`PDK_ROOT_SKY130A` apunta al directorio `sky130A`; por defecto `/pdk`):
`sh experiments/auditoria_hsa/reproducir/reproducir.sh`. Escribe en `reproducir/corrida/` (ignorado por git) y termina con `ok`
o con la lista de fallos.

`reproducir/minimo.sp` corre cinco transistores en dos condiciones:
- **A, sin modo:** sin ningún archivo de inicio (`SPICE_USERINIT_DIR` y `HOME` a una carpeta vacía, sin `.spiceinit` local). Es lo
  que hacían las corridas guardadas antes del 2026-11-14.
- **B, modo del PDK:** `tools/ngspice_pdk.sh` (el `spinit` de sky130A como `.spiceinit`, `ngbehavior=hsa`).

`reproducir/comprobar.py` exige tres cosas: la línea de modo de cada log, el mecanismo con las cifras de la auditoría y la
regresión contra `reproducir/esperado.txt` (tolerancia relativa 1e-4; ngspice imprime seis cifras).

**Resultado esperado** (corrido 2026-11-15 16:47 EST en la imagen `hpretl/iic-osic-tools:2025.07`):

| Dispositivo (tt, 27 °C) | vth A (V) | vth B (V) | B − A | Corriente B/A | Dato de la auditoría |
|---|---|---|---|---|---|
| nfet_01v8 0,42/0,15, `sa=sb=0,3` (control: el DUT de XC-19) | 0,797944 | 0,797944 | 0 | 0 | 0 (§3.5) |
| nfet_01v8 1/1, `sa=sb=0,3` | 0,628368 | 0,63061 | +2,242 mV | −0,91 % | +2,242 en `t0`/`t1/bin4.log` (ver corrección abajo) |
| pfet_01v8_hvt 0,42/0,5, `sa=sb=0,3` | 0,934387 | 0,92643 | −7,957 mV | +12,0 % | −7,957 mV, +12 % (§3.2) |
| pfet_01v8_hvt 0,42/0,5 sin `sa/sb` (control) | 0,970184 | 0,970184 | 0 | 0 | 0 (§3.1) |
| pfet_01v8_hvt 0,42/0,18 sin `sa/sb` (núcleo discontinuo) | 0,849185 | 0,831452 | −17,733 mV | +29,0 % | −17,7 mV (§3.4) |

Los valores de A coinciden en los seis dígitos con los logs originales de la auditoría (`original/minimos/t0/bin.log`,
`t0/bin4.log`), que se escribieron con otro deck.

**Dos cosas que salieron al reproducir (2026-11-15):**
1. Quitar solo `SPICE_USERINIT_DIR` **no** deja ngspice sin modo: entonces lee `~/.spiceinit`, y el de la imagen
   (`/headless/.spiceinit`) trae `set ngbehavior=hsa`. Por eso A apunta `HOME` a una carpeta vacía. Para B no importa (los dos
   archivos piden `hsa`), pero en otra máquina un `~/.spiceinit` propio podría mezclarse con el del PDK `[?]`.
2. El informe decía «nfet 1/1 +1,8 a +2,2 mV» (§3.2). A la polarización de `bin4.sp` (Vg 0,9 V, Vd 0,05 V) los logs originales
   dan **+2,242 mV**, fuera de ese rango. Corregido en el informe con `[corregido 2026-11-15 16:52]`; de dónde salía el +1,8 `[?]`
   (probablemente otra polarización de `lod2.sp`, no comprobado).

## Reconstruir las tablas de la auditoría con lo rescatado

Comprobado el 2026-11-15 16:48 EST en una carpeta nueva fuera del scratchpad original:

```
mkdir rescate && cd rescate
tar xzf <repo>/experiments/auditoria_hsa/original/logs_AB.tar.gz
cp <repo>/experiments/auditoria_hsa/original/scripts/{compare.py,derive.py,decks.txt} .
git -C <repo> archive e7bd23c | (mkdir repo_e7bd23c && tar x -C repo_e7bd23c)
python3 compare.py . repo_e7bd23c > compare_new.txt     # idéntico a original/tablas/compare_final.txt
python3 derive.py > derive_new.md                        # idéntico a original/tablas/derive.md
```

Los dos salen **idénticos byte a byte** (`diff` vacío). Esto reconstruye las comparaciones a partir de los logs. No vuelve a correr
las simulaciones; para eso están `original/scripts/runone.sh` y `runtwo.sh`, con las órdenes de §1 del informe.

## Qué hay

| Ruta | Qué |
|---|---|
| `reproducir/` | `minimo.sp`, `reproducir.sh`, `comprobar.py`, `esperado.txt`: reproducción mínima, nueva (2026-11-15) |
| `original/scripts/` | `compare.py`, `derive.py`, `runone.sh`, `runtwo.sh`, `decks.txt` (los 102 decks), `sky130A_spinit`, `sky130A_spinit_sin_klu`, `shim_docker.py` (envoltorio de `docker` para los generadores, modo B), `hsainit_spiceinit` (lo que montaba) |
| `original/tablas/` | `compare_final.txt`, `compare.json`, `derive.md`, `table_final.md`, `table_all.md`, tiempos (`times_*.txt`, `start_all.txt`, `done_*.txt`), listas de re-corridas (`rerun*.txt`), `lab_p_A.txt`, y dos notas de `gen/` |
| `original/minimos/` | Los decks mínimos de §3 con sus logs: `dev.sp`, `types.sp`, `lod.sp`, `lod2.sp`, `bin*.sp`, `t0/` (sin modo) y `t1/` (`hs`), `r_*/` (cada línea del `spinit` por separado), `chan/` (la prueba decisiva de §3.5), `dev2/` (375 combinaciones de §3.6), `short/`, `shimtest/`, `init_*` |
| `original/paso4/` | El barrido de las 40 geometrías de `sky130_fd_sc_hd` (`dev/`) y las re-corridas del lector de anillos de `01_hat87` (`hat/`), de §6c |
| `original/logs_AB.tar.gz` | Los 223 logs de las condiciones A, B, Bnk, A2 y B2r de los 102 decks, más los 12 `.dat` que lee `compare.py` (470 kB comprimido, unos 4,4 MB sin comprimir) |
| `original/gen_AB.tar.gz` | Lo que escribieron los generadores de `experiments/attack*` y `verify*` en las condiciones A, B2, A3 y B3 (160 archivos: decks generados, logs, tablas; sin los volcados `*_trazas.dat` ni `.raw`, regenerables; 340 kB) |
| `SHA256SUMS` | Hashes de todos los archivos de esta carpeta (`shasum -a 256 -c SHA256SUMS`) |

## Qué no se rescató, y qué no puede reconstruirse solo con esto

- **Las copias del repo de cada condición** (`A/repo`, `B/repo`, `A2`, `B2r`, `Bnk`: unos 140 MB cada una) y **las salidas de
  los generadores** (`gen/A`, `gen/B2`, `gen/A3`, `gen/B3`; unos 416 MB). Son el repo en `e7bd23c` más lo que escribió cada corrida.
  Se rescató lo que esas corridas escribieron (`logs_AB.tar.gz`, `gen_AB.tar.gz`), salvo los volcados `*_trazas.dat` y `.raw`.
  Para volver a correr los generadores en modo B hace falta `shim_docker.py`, que lleva escrita la ruta absoluta del scratchpad
  original (`/private/tmp/...`) y habría que editar; hoy es más simple pasarlos por `tools/ngspice_pdk.sh`. No se comprobó
  que las comparaciones de generadores de §4.3 (última viñeta) se reconstruyan desde `gen_AB.tar.gz`: no hay entre lo rescatado
  un script que las produzca `[?]`.
- **`gen/B/`** era una corrida con el primer envoltorio, que no funcionaba (`original/tablas/gen_LEEME_B_invalido.txt`). No se rescató.
- **Los tiempos de pared** (`times_*.txt`) se tomaron con la máquina cargada y suspendida durante la noche: no son reproducibles ni
  pretenden serlo.
- **Los Monte Carlo** (§4.4) no se reproducen ni con la misma semilla (`SPICE_RNDSEED` no fija los sorteos en ngspice 44.2): ningún
  rescate lo arregla.
- **Los dos decks largos que no terminaron** (§4.5) siguen sin número.
- **`experiments/verify_r3/v3_f2.spice`**, el único deck guardado en modo `hs a` antes de la auditoría, no está en el repo (§0): `[?]`.
