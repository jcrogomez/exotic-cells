# Emisor candidato (diodo p+/nwell en directa) a d = 5, 10 y 20 um del fotodiodo 3 x 3 (borde del photo a borde del nwell),
# más control: un diodo idéntico a 40 um al otro lado (CA/CK). Marco común: anillo de dnwell con interior x -48,5..31,5, y -6,3..9,3,
# idéntico en las cuatro celdas, para que solo cambie d. photon_e05g: igual que e05 con anillo p+ (GUARD) alrededor del emisor.
# d < 4,5 um violaría nwell.7 (4,5 um entre nwell y dnwell de redes distintas), que ni Magic ni KLayout comprueban contra `photo`.
# Correr: magic -dnull -noconsole -rcfile /foss/pdks/sky130A/libs.tech/magic/sky130A.magicrc emisor.tcl
source comun.tcl
proc celda_e {nombre d guarda} {
  cellname create $nombre ; load $nombre
  anillo_dnw -48.5 -6.3 31.5 9.3
  fotodiodo 0 0 3
  anillo_tap -0.5 -0.5 3.5 3.5 0.6 A
  set xe [expr {3.0 + $d}]
  emisor $xe 0 EA EK
  if {$guarda} { anillo_tap [expr {$xe-0.5}] -0.5 [expr {$xe+4.5}] 3.5 0.6 GUARD }
  emisor -44 0 CA CK
  cierra $nombre
}
celda_e photon_e05  5  0
celda_e photon_e10  10 0
celda_e photon_e20  20 0
celda_e photon_e05g 5  1
quit -noprompt
