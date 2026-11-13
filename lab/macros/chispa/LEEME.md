# Precursor "La Chispa fría" — ¿es legal una unión p+/n+ abutida dentro de un nwell? (2026-11-04)

Pregunta del revisor externo: "el agente todavía no ha demostrado que la geometría p+/n+ abutida sea válida en SKY130". Se comprueba con
`legal.tcl` (Magic, por script) y el deck `sky130A_mr.drc` de KLayout. Geometría: nwell de 4 × 3 µm; p+ (`pdiff`) de 1,0 × 1,4 µm con
contacto; n+ de pozo (`nsd`) de 1,0 × 1,4 µm con contacto, a separación d del p+; li1 sobre los contactos.

| d (µm) | Magic DRC | KLayout `sky130A_mr.drc` | Legal |
|---|---|---|---|
| 0 (abutida) | 0 | 0 ítems | **sí** |
| 0,13 | 1 (`diff/tap.3`: separación de difusión < 0,27 µm) | 1 ítem (`difftap.3`) | no |
| 0,27 | 0 | 0 ítems | sí |
| 0,50 | 0 | 0 ítems | sí |

Conclusión: en sky130 la unión p+/n+ puede ser **abutida (d = 0)** o estar a **≥ 0,27 µm**; no hay separaciones intermedias legales. Las
variantes del precursor son por tanto d ∈ {0; 0,27; 0,54; 1,08} µm, no las de Dutta (pasos de 20 nm). Que d = 0 pase DRC no dice nada
de cómo queda el perfil de dopado real (los implantes se solapan o se separan según el proceso): eso es exactamente lo que el silicio
tiene que responder, y la hipótesis de "fuga ≥ 100× el diodo del PDK a 1,8 V" sigue siendo hipótesis sin modelo (el PDK no modela esta
unión).

Pendiente: celda de lectura fuga-a-tiempo con su control sin unión; familia de curvas tensión/temperatura (no dos puntos); controles de
fuga superficial y de generación-recombinación, como pide el revisor.
