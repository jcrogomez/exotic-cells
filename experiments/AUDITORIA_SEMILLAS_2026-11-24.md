# Auditoría de semillas de ngspice · 2026-11-24

Escrita el 2026-11-24 11:29 EST (`date`). La causa la encontró el Monte Carlo de MISFIT-03 enmienda 2: las semillas 2101–2104 dieron exactamente los
mismos chips. La auditoría del resto del repo la hizo un agente aparte, en solo lectura. El caso grave lo comprobé yo con md5.

## Hecho (probado en `scratchpad`, tt_mm, nfet 0,42/0,15)

- `set rndseed=N` dentro de `.control` **se ignora** en ngspice 44.2 con `tools/ngspice_pdk.sh` y la imagen iic-osic-tools 2025.07.
  - La semilla sale del proceso: en un contenedor nuevo es siempre la misma.
  - Varios decks en serie dentro de un mismo contenedor dan sorteos distintos, pero no reproducibles.
- `setseed N` seguido de `reset` sí es determinista y depende de N: dos corridas con 11 dan lo mismo, y 11 y 12 dan distinto.

## Afectados

| Experimento | Severidad |
|---|---|
| `attack_xc58/c58b_ciclos`, semillas 101/102/103 | **Muestras duplicadas.** Los tres `.out` (recuperados de `0b3fefe^`) tienen el mismo md5, b410bde7…. N efectivo = 640, no 1920. Las barras de `c58b_ANALISIS.md` (líneas 69, 139 y 141–142) están calculadas con N = 1920; sin recalcular, `[?]` |
| `attack_xc58/c58_trn`, Cx = 0 frente a Cx = 9 | Ruido compartido entre condiciones: r = 0,628 en la lectura «antes» del mismo k, según el agente. La comparación entre esas dos condiciones no es independiente |
| `xc19_slot_e2` C3 v1 | 12 chips distintos de 48: declarado y rehecho con `setseed` |
| `xc19_slot_e2` C4 (R1, R3, R1′) | Comparten la secuencia de `trnoise`. El testigo N3 no es independiente; se declara en sus resultados |
| `xc19_noise`, `xc19_weak_inversion` n5, `lod_audit` paso 4, `attack2_xc20` Cmm | Solo no reproducibles: una realización, o `reset` en bucle dentro de un proceso |

## Pendiente

- `tools/manifest.sh:21` dice que hay reproducibilidad con «rndseed». En este entorno es falso. Sin corregir todavía.
- `tools/check_runs.py:15` deja pasar sin aviso las líneas con `rndseed`.
- Recalcular las barras de c58b con N = 640: no hecho. Su lectura (el nodo no guarda memoria) puede seguir en pie con IC más anchos.
