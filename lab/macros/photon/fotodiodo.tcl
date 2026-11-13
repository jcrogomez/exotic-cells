# Fotodiodo mínimo legal de sky130 (tipo Magic `photo`): photon_fd (3 x 3, dimensiones exactas de photo.2/8/9/10/11)
# y photon_fd_l10 (3 x 10: interpreta "width" como el lado corto; si photo.2 fija también el largo, esta celda NO es legal [?]).
# Cada una: tap p+ anular (photo.7, puerto A) y anillo de dnwell (photo.6, puerto DNW) a 6,3 um (KLayout aplica dnwell.2 al photo).
# Correr: magic -dnull -noconsole -rcfile /foss/pdks/sky130A/libs.tech/magic/sky130A.magicrc fotodiodo.tcl
source comun.tcl
proc celda_fd {nombre L} {
  cellname create $nombre ; load $nombre
  anillo_dnw -6.3 -6.3 9.3 [expr {$L+6.3}]
  fotodiodo 0 0 $L
  anillo_tap -0.5 -0.5 3.5 [expr {$L+0.5}] 0.6 A
  cierra $nombre
}
celda_fd photon_fd 3
celda_fd photon_fd_l10 10
quit -noprompt
