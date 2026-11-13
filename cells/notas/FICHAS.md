# Notas por familia (exploratorias)

Índice de las notas de trabajo en español de las 63 familias de [catálogo](../../README.md#catalogue), con el mismo `XC-nn`. Abiertas el
2026-11-11.

**Cómo leerlas.**

- Son **exploratorias**. Salvo donde se cita una corrida de este repositorio, nada aquí está medido ni simulado por nosotros.
- Cada ficha da la cadena: mecanismo físico → precursor fabricable → transformación o interacción → observable → función potencial
  → circuito CMOS que lo aprovecha → experimento que lo verifica. Después, la razón para mantenerla y lo que sigue abierto.
- Grados de una afirmación: **corrida** (reproducible en `experiments/`), **fuente** (publicación o PDK leídos), **cálculo**
  (a mano, con sus supuestos), **hipótesis**. Lo desconocido va como `[?]`.
- Las rutas entre comillas que no existen en este repositorio (por ejemplo `FRONTERAS_FISICAS_1105.md`, `macros/photon/`)
  son notas del laboratorio de trabajo, todavía no publicadas. Los números que dependen de ellas cuentan aquí como **cálculo** o
  **fuente sin adjuntar** hasta que se publiquen.
- Ninguna familia se borra. Se fusiona o se descarta con evidencia, y la línea queda.
- Un preregistro es otra cosa: vive en [`../preregistros/`](../preregistros/README.md), fechado antes de correr.

## Dónde está cada ficha

Desde el 2026-11-12 cada familia tiene su carpeta, con la ficha, el plan de pruebas y la lista de documentación en un solo
`PLAN.md`. El texto de las fichas se movió allí sin cambios; este archivo queda como índice.

| ID | Familia | Ficha y plan |
|---|---|---|
| XC-01 | Constricción de met1 | [`xc01_m1_constriction/PLAN.md`](../xc01_m1_constriction/PLAN.md) |
| XC-02 | Constricción de li1 | [`xc02_li_constriction/PLAN.md`](../xc02_li_constriction/PLAN.md) |
| XC-03 | Contacto o vía como sitio | [`xc03_contact_site/PLAN.md`](../xc03_contact_site/PLAN.md) |
| XC-04 | Nanogap túnel | [`xc04_tunnel_nanogap/PLAN.md`](../xc04_tunnel_nanogap/PLAN.md) |
| XC-05 | Contacto atómico | [`xc05_atomic_contact/PLAN.md`](../xc05_atomic_contact/PLAN.md) |
| XC-06 | Isla de Coulomb | [`xc06_coulomb_island/PLAN.md`](../xc06_coulomb_island/PLAN.md) |
| XC-07 | Ruptura de óxido | [`xc07_oxide_breakdown/PLAN.md`](../xc07_oxide_breakdown/PLAN.md) |
| XC-08 | LED de filamento | [`xc08_filament_emitter/PLAN.md`](../xc08_filament_emitter/PLAN.md) |
| XC-09 | Transistor de carga atrapada | [`xc09_charge_trap/PLAN.md`](../xc09_charge_trap/PLAN.md) |
| XC-10 | Envejecimiento a 1,8 V | [`xc10_ageing/PLAN.md`](../xc10_ageing/PLAN.md) |
| XC-11 | Compuerta flotante de un poly | [`xc11_floating_gate/PLAN.md`](../xc11_floating_gate/PLAN.md) |
| XC-12 | LOD | [`xc12_lod_stress/PLAN.md`](../xc12_lod_stress/PLAN.md) |
| XC-13 | WPE | [`xc13_well_proximity/PLAN.md`](../xc13_well_proximity/PLAN.md) |
| XC-14 | Antena como escritura | [`xc14_antenna_write/PLAN.md`](../xc14_antenna_write/PLAN.md) |
| XC-15 | Antena factorial | [`xc15_antenna_factorial/PLAN.md`](../xc15_antenna_factorial/PLAN.md) |
| XC-16 | Entorno por colocación | [`xc16_placement/PLAN.md`](../xc16_placement/PLAN.md) |
| XC-17 | Electrodo por diseño | [`xc17_electrode/PLAN.md`](../xc17_electrode/PLAN.md) |
| XC-18 | Transistor de óxido de campo | [`xc18_field_oxide_fet/PLAN.md`](../xc18_field_oxide_fet/PLAN.md) |
| XC-19 | Trampa (RTN) | [`xc19_single_trap/PLAN.md`](../xc19_single_trap/PLAN.md) |
| XC-20 | Chispa fría | [`xc20_abutted_junction/PLAN.md`](../xc20_abutted_junction/PLAN.md) |
| XC-21 | Avalancha como emisor | [`xc21_avalanche_emitter/PLAN.md`](../xc21_avalanche_emitter/PLAN.md) |
| XC-22 | SPAD | [`xc22_spad/PLAN.md`](../xc22_spad/PLAN.md) |
| XC-23 | Unión lateral multiterminal | [`xc23_lateral_junction/PLAN.md`](../xc23_lateral_junction/PLAN.md) |
| XC-24 | Bipolar parásito y PNPN | [`xc24_parasitic_bipolar/PLAN.md`](../xc24_parasitic_bipolar/PLAN.md) |
| XC-25 | Hall en pozo n | [`xc25_hall_plate/PLAN.md`](../xc25_hall_plate/PLAN.md) |
| XC-26 | Enlace óptico interno | [`xc26_optical_link/PLAN.md`](../xc26_optical_link/PLAN.md) |
| XC-27 | Nanohoyos | [`xc27_hole_arrays/PLAN.md`](../xc27_hole_arrays/PLAN.md) |
| XC-28 | Guías en el dieléctrico | [`xc28_waveguides/PLAN.md`](../xc28_waveguides/PLAN.md) |
| XC-29 | Nanoporos reales | [`xc29_nanopores/PLAN.md`](../xc29_nanopores/PLAN.md) |
| XC-30 | Coherencia mesoscópica | [`xc30_mesoscopic/PLAN.md`](../xc30_mesoscopic/PLAN.md) |
| XC-31 | Calor como canal | [`xc31_heat_channel/PLAN.md`](../xc31_heat_channel/PLAN.md) |
| XC-32 | Acoplamiento por alimentación | [`xc32_supply_coupling/PLAN.md`](../xc32_supply_coupling/PLAN.md) |
| XC-33 | Metaestabilidad y entropía | [`xc33_metastability/PLAN.md`](../xc33_metastability/PLAN.md) |
| XC-34 | Celdas fuera de su uso | [`xc34_offlabel_cells/PLAN.md`](../xc34_offlabel_cells/PLAN.md) |
| XC-35 | Identidad del dado | [`xc35_die_identity/PLAN.md`](../xc35_die_identity/PLAN.md) |
| XC-36 | Arquitecturas consumidoras | [`xc36_consumers/PLAN.md`](../xc36_consumers/PLAN.md) |
| XC-37 | Retención variable | [`xc37_retention_time/PLAN.md`](../xc37_retention_time/PLAN.md) |
| XC-38 | Fuga de drenaje inducida por puerta | [`xc38_gidl/PLAN.md`](../xc38_gidl/PLAN.md) |
| XC-39 | Resistor de poly electrotérmico | [`xc39_poly_electrothermal/PLAN.md`](../xc39_poly_electrothermal/PLAN.md) |
| XC-40 | Termopila | [`xc40_thermopile/PLAN.md`](../xc40_thermopile/PLAN.md) |
| XC-41 | Relajación dieléctrica | [`xc41_dielectric_relaxation/PLAN.md`](../xc41_dielectric_relaxation/PLAN.md) |
| XC-42 | Transistor de pozo flotante | [`xc42_floating_well/PLAN.md`](../xc42_floating_well/PLAN.md) |
| XC-43 | Bombeo de carga | [`xc43_charge_pumping/PLAN.md`](../xc43_charge_pumping/PLAN.md) |
| XC-44 | Estrés del encapsulado | [`xc44_package_stress/PLAN.md`](../xc44_package_stress/PLAN.md) |
| XC-45 | Temporizador por túnel de puerta | [`xc45_tunnel_timer/PLAN.md`](../xc45_tunnel_timer/PLAN.md) |
| XC-46 | Transistor de esquina del aislamiento | [`xc46_corner_fet/PLAN.md`](../xc46_corner_fet/PLAN.md) |
| XC-47 | Discontinuidades del modelo | [`xc47_model_gaps/PLAN.md`](../xc47_model_gaps/PLAN.md) |
| XC-48 | Resistor de pozo estrangulado por su unión | [`xc48_pinched_well/PLAN.md`](../xc48_pinched_well/PLAN.md) |
| XC-49 | Impactos de partículas | [`xc49_particle_strikes/PLAN.md`](../xc49_particle_strikes/PLAN.md) |
| XC-50 | Emisor por portadores calientes | [`xc50_hot_carrier_emitter/PLAN.md`](../xc50_hot_carrier_emitter/PLAN.md) |
| XC-51 | Constricción de poly | [`xc51_poly_constriction/PLAN.md`](../xc51_poly_constriction/PLAN.md) |
| XC-52 | Magnetorresistencia por pares de espín | [`xc52_spin_pair/PLAN.md`](../xc52_spin_pair/PLAN.md) |
| XC-53 | Bomba de alta tensión | [`xc53_hv_pump/PLAN.md`](../xc53_hv_pump/PLAN.md) |
| XC-54 | Interconexión local superconductora | [`xc54_tin_superconductor/PLAN.md`](../xc54_tin_superconductor/PLAN.md) |
| XC-55 | Fonones en la pila de metales | [`xc55_beol_phonons/PLAN.md`](../xc55_beol_phonons/PLAN.md) |
| XC-56 | Microbobina integrada | [`xc56_microcoil/PLAN.md`](../xc56_microcoil/PLAN.md) |
| XC-57 | Unión Peltier | [`xc57_peltier_junction/PLAN.md`](../xc57_peltier_junction/PLAN.md) |
| XC-58 | Celda kT/C | [`xc58_ktc_cell/PLAN.md`](../xc58_ktc_cell/PLAN.md) |
| XC-59 | Escritura eléctrica, borrado térmico | [`xc59_thermal_erase/PLAN.md`](../xc59_thermal_erase/PLAN.md) |
| XC-60 | Magnetodiodo | [`xc60_magnetodiode/PLAN.md`](../xc60_magnetodiode/PLAN.md) |
| XC-61 | Oscilador por congelación de portadores | [`xc61_freezeout_oscillator/PLAN.md`](../xc61_freezeout_oscillator/PLAN.md) |
| XC-62 | Transistor impreso por proximidad | [`xc62_proximity_fet/PLAN.md`](../xc62_proximity_fet/PLAN.md) |
| XC-63 | Contacto sin implante | [`xc63_schottky_contact/PLAN.md`](../xc63_schottky_contact/PLAN.md) |

## Clasificación por vehículo

- **Probables hoy en D (15):** XC-01, 02, 03, 10, 12, 13, 14, 15, 16, 17, 19 (con macro de inversión débil), 20, 26 (lectura por
  precarga), 31, 32. Más las digitales puras XC-33, 34, 35.
- **Piden H (11):** XC-04, 07, 08, 09, 11, 18, 21, 22, 23, 24, 25.
- **Piden E (6):** XC-05, 06, 27 (transmisión), 28, 29, 30.
- **Altas del 2026-11-12, todas propuestas en D y sin filtrar (16):** XC-27 por reflexión y XC-37 a XC-51.

