# Exotic Foundry Lab — digital (EFL-D)

> **Lab notebook, archived 2026-11-13.** This folder is where the project started (EFL-D, 4–12 Nov 2026). It was a private
> repository and now lives here unchanged except for this note; generated GDS, extractions, DRC reports and logs were left out
> (regenerate them with the `.tcl` scripts in each macro). The living catalogue is the one in [`../README.md`](../README.md#catalogue);
> where this notebook disagrees with it, the catalogue wins. Paths such as `01_hat87/`, `local_flow/` or `02_ideas/` below refer
> to the author's workspace and are not part of this repository. Written in Spanish.

Creado el 2026-11-04 12:08 EST (hora de `date`). Repo git propio, privado, sin remoto todavía.

**Qué es.** Un chip de laboratorio para sky130 en Tiny Tapeout, hecho solo con el flujo digital (celdas estándar, OpenLane,
cocotb), cuyo propósito es medir física del proceso y transformarla en la mesa, no ejecutar una función. Hereda la idea de las
Exotic Cells (texto externo del 2026-11-04) y la "Fragua": la fundición fabrica lo normal; la mesa, el tiempo y la temperatura
terminan la fabricación. Lo que necesita pines analógicos, layout a mano o tensiones fuera de 1,8 V vive en la rama analógica
(`docs/EQUIPO.md`, sección "espera al analógico") y no se mezcla.

**Regla de este repo (2026-11-04).** Se versiona todo; **no se decide todavía qué se envía ni a qué shuttle.** Cada banco entra con
su contrato de falsabilidad (`docs/preregistros/`) antes de tener RTL que mida algo. Un número solo existe si sale de una corrida
reproducible o de una fuente leída; si no, `[?]`.

## Mapa

| Ruta | Qué |
|---|---|
| `docs/PROPUESTA_CHIP.md` | La propuesta de chip vigente: qué lleva, por qué, qué esperamos, compuertas antes de decidir |
| `docs/FILOSOFIA.md` | Las reglas de diseño "made in TaiJuan", cada una con su origen |
| `docs/CARTERA.md` | Cartera completa de familias candidatas con ID estable (`XC-nn`) y cadena mecanismo → experimento. Nada se borra de ahí |
| `macros/grabado_lod/` | XC-12: auditoría del esfuerzo STI (ngspice + extracción de Magic), brecha `sa/sb` confirmada |
| `docs/EQUIPO.md` | Los bancos ("personajes"), qué mide cada uno, por qué y con qué control. Digitales primero |
| `docs/DECISIONES.md` | Registro fechado de decisiones y de lo que las revertiría |
| `docs/pesca/` | Lecturas con fuente (PDK, TT, literatura). `PESCA_OPTO_1104.md` es la del 4-nov |
| `docs/preregistros/` | Un preregistro por banco, escrito antes de correr |
| `docs/NIGHT_SPRINT_2026-11-05.md` | Cierre del sprint del 4→5 nov: tabla verificado/modelado/hipótesis/bloqueado y decisión de área |
| `docs/FRONTERAS_FISICAS_1105.md`, `docs/EFLG00_TRAMPA.md`, `docs/pesca/PESCA_PHOTON_1105.md` | Fronteras físicas, defecto individual, fotodiodo de sky130 y LED de filamento |
| `macros/photon/` | EFLO-00: fotodiodo legal, emisores a distancia, guarda, presupuesto de lectura |
| `ideas/` | Lo que aún no tiene contrato |

## Relación con el resto de ZTASIC

- `01_hat87/` (project-hat): HatUno A, titular de SKY26d. **No se toca desde aquí.**
- `02_ideas/exotic_lab_01_pesca_1104.md`: copia de la pesca; la canónica es la de este repo.
- `local_flow/`: banco físico compartido; las corridas de EFL-D van a `local_flow/efld_*`. **`local_flow/efld_00`** (repo git propio) es la
  plataforma EFLD-00: macro + gemelo + drivers enclavados + lector; resultados en su `LEEME.md`.

## Cómo verificar (cuando exista RTL)

```
cd test && pip install -r requirements.txt && make
```
