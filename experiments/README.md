# Experiments

Every folder is a run against a prediction written first. Nothing here is a silicon measurement. Reports are mostly in Spanish.
Generated outputs (ngspice decks and logs, DRC reports, GDS of probes) are not versioned: run the folder's scripts to
regenerate them. Scripts that read the PDK expect `SKY130A` (and a few `ZTASIC`) in the environment.

## Attack rounds

Each round: one or more attackers try to kill a family; an independent verifier reproduces the key numbers with their own code
before anything is consolidated. Rules: [`PROTOCOLO_ATAQUES.md`](PROTOCOLO_ATAQUES.md).

| Round | Families | Summary | Attack | Verification |
|---|---|---|---|---|
| 1 · 2026-11-12 | XC-20, XC-05, XC-52 | [`RONDA_1_2026-11-12.md`](RONDA_1_2026-11-12.md) | [`attack_xc20/`](attack_xc20/a20_INFORME.md), [`attack_xc05/`](attack_xc05/a05_INFORME.md), [`attack_xc52/`](attack_xc52/a52_INFORME.md) | [`verify_r1/`](verify_r1/) |
| 2 · 2026-11-12 | XC-20, XC-05, XC-52 | [`RONDA_2_2026-11-12.md`](RONDA_2_2026-11-12.md) | [`attack2_xc20/`](attack2_xc20/b20_INFORME.md), [`attack2_xc05/`](attack2_xc05/b05_INFORME.md), [`attack2_xc52/`](attack2_xc52/b52_INFORME.md) | [`verify_r2/`](verify_r2/) |
| 3 · 2026-11-12 | XC-57 to XC-63 | [`RONDA_3_2026-11-12.md`](RONDA_3_2026-11-12.md) | [`attack_xc58/`](attack_xc58/c58_INFORME.md), [`attack_xc57_59_61/`](attack_xc57_59_61/), [`attack_xc60_62_63/`](attack_xc60_62_63/) | [`verify_r3/`](verify_r3/) |
| 4 · 2026-11-13 | XC-26, XC-27, XC-21 (optics) | [`RONDA_4_OPTICA_2026-11-13.md`](RONDA_4_OPTICA_2026-11-13.md) | [`attack_xc26_27_21/`](attack_xc26_27_21/) | [`verify_r4_optica/`](verify_r4_optica/v4o_INFORME.md) |
| 4 · 2026-11-13 | XC-14, XC-07, XC-53 (floating node, high voltage) | [`RONDA_4_NODO_2026-11-13.md`](RONDA_4_NODO_2026-11-13.md) | [`attack_xc14_07_53/`](attack_xc14_07_53/) | [`verify_r4_nodo/`](verify_r4_nodo/v4n_INFORME.md) |

## Focused studies

| Folder | What |
|---|---|
| [`lod_audit/`](lod_audit/README.md) | The open extraction flow drops the layout parameters of the STI stress model (first reproducible result) |
| [`stdcell_lod/`](stdcell_lod/README.md) | Real diffusion lengths of every standard cell of the library |
| [`xc19_weak_inversion/`](xc19_weak_inversion/README.md), [`xc19_noise/`](xc19_noise/README.md) | The XC-19 single-trap reader: working point, noise and event detection |
| [`precheck_map/`](precheck_map/README.md) | Which deliberate rule breaks the Tiny Tapeout precheck accepts and which it rejects |
| [`litho_explore/`](litho_explore/README.md) | Aerial-image lithography model of drawn shapes near the resolution limit |
| [`xc52_demod_test/`](xc52_demod_test/) | Which terms survive the four-state field demodulation of XC-52 |
| [`xc58_ktc_budget/`](xc58_ktc_budget/) | Noise budget of the kT/C cell XC-58 |

External reviews and what was done with each point: [`REVISION_EXTERNA_2026-11-13.md`](REVISION_EXTERNA_2026-11-13.md).

`manifest_2026-11-11.json` records the tool versions of the first runs (`tools/manifest.sh`).
