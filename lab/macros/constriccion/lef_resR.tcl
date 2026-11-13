# LEF del macro con capa de resistencia: ¿salen A y B como pines separados?
foreach n {efld_consR_M1 efld01_A} {
  load $n
  lef write $n.lef -hide
}
# Prueba de ida y vuelta: leer el GDS en un Magic limpio y extraer
cellname create vacio ; load vacio
gds readonly false
gds read efld_consR_M1.gds
load efld_consR_M1
extract all ; ext2spice lvs ; ext2spice -o roundtrip_M1.spice
quit -noprompt
