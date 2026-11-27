# MISFIT-27 · el lector 2 como unidad: bloque recolocado + `reader2fe` · resultados

Prerregistro: [`MISFIT-27`](../../cells/preregistros/MISFIT-27_2026-11-27_lector2_unidad_ensamblada.md), sellado y subido
antes de correr. LibreLane 3.0.14, Magic y netgen del contenedor `iic-osic-tools:2025.07`, PDK 8afc8346. Veredictos tal
como salen: [`m27_a.txt`](m27_a.txt) (bloque), [`unidad.txt`](unidad.txt) y [`mutantes.txt`](mutantes.txt). Bloque en
[`bloque/`](bloque/), unidad en [`unidad/`](unidad/). Fuentes: [`instrument/reader2/unit`](../../instrument/reader2/unit).

## Lo aburrido primero

- **Es cierre físico, no función.** La unidad no se ha simulado. El bloque es una colocación nueva: la etapa B de
  MISFIT-26 se corrió sobre el bloque anterior y hay que repetirla sobre este.
- **Una pasada de cada cosa**, sin enmiendas. Salió a la primera; no hay segunda corrida que diga cuánto margen tiene.
- **Sin DRC de KLayout** sobre la unidad (el bloque lo lleva apagado, como los anteriores; `reader2fe` sola sí pasó los
  dos mazos en MISFIT-22). Reglas de la unidad: solo Magic `drc(full)`.
- Las 6 violaciones de pendiente y 1 de abanico del flujo siguen ahí, sin reparar a propósito (MISFIT-25).
- La alimentación de la celda sube por una sola pila de vías por carril. Sin cuenta de caída ni de electromigración.

## Resultado

| # | Predicción | Resultado |
|---|---|---|
| H1 | El bloque recolocado cierra limpio a la primera | **cumplida**: reglas 0, LVS 0, antenas 0 |
| H2 | Lazo intacto y sin búferes | **cumplida**: 17 de 17 celdas, cada red con sus conexiones |
| H3 | Red `x` < 15 µm dentro del bloque | **cumplida**: 8,4 µm (7,3 de metal 2 y 1,1 de metal 1; antes 13,0) |
| H4 | Unidad limpia de reglas en ≤ 2 pasadas | **cumplida** a la primera: 0 violaciones |
| H5 | LVS de la unidad coincide | **cumplida**: "Circuits match uniquely" |
| H6 | Los tres mutantes dan LVS distinto | **cumplida**: sin vía de `x`, sin vía de `prenl` y sin pila de VDD, los tres "do not match" |

Medidas: bloque **46,92 × 46,24 µm = 2170 µm²** (antes 3426; mismas 93 celdas, 749 µm² en un núcleo de 1727 µm²).
Unidad **46,92 × 56,24 µm = 2639 µm²**, con 10 µm bajo el bloque para la celda (7,98 µm de alto) y las bajadas.

Cómo quedó unido: `reader2fe` con su pin X justo bajo el pin `x` del bloque; tres bajadas rectas de metal 2 con vía;
VDD por pila de vías a la tira VPWR de metal 4 que le pasa por encima (estrechada para no tapar la bajada de `x`); GND
por metal 3 hasta la tira VGND de la derecha. Los pines digitales salen por arriba en metal 2; `x` queda accesible
entre el bloque y la celda, para la matriz.

## Decisión, por la regla escrita

H1, H2, H4, H5 y H6 cumplidas: **se adopta esta unidad** como el lector 2 en layout. Sigue repetir la etapa B sobre
ella (extraída entera, con sus bajadas), con hoja propia, y después unirla a la matriz. Si MISFIT-26 obliga a rehacer
el bloque, la unidad se repite con el mismo guion.

## Qué explicación aburrida no descarté

- Que la unidad lea distinto del bloque de MISFIT-26 (colocación nueva, bajadas, tira de VDD cerca del nodo). Sin simular.
- Que el LVS no vea un cruce entre `prenh` y `prenl`: los mutantes quitan uniones, ninguno las intercambia.
- Que un DRC de KLayout sobre la unidad encuentre algo que Magic no.
- Que el sitio de los pines no sirva al colocar la unidad en el tile y junto a la matriz.
