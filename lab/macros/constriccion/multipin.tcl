# EFLD-01: cabezas con varios pines (uno por driver) para que cada driver llegue al precursor por su propia vía.
# Cabeza 1,2 (x) × 3,6 (y) µm de li1+met1 con 9 mcon en columna; 9 pines de 1,2 × 0,4 µm: A0..A8 / B0..B8.
drc off
proc cabeza {x0 pref} {
  box ${x0}um 0um [expr {$x0+1.2}]um 3.6um ; paint li1 ; paint met1
  for {set i 0} {$i < 9} {incr i} {
    set cy [expr {0.4*$i + 0.115}]
    box [expr {$x0+0.515}]um ${cy}um [expr {$x0+0.685}]um [expr {$cy+0.17}]um ; paint mcon
    box ${x0}um [expr {0.4*$i}]um [expr {$x0+1.2}]um [expr {0.4*$i+0.4}]um ; label $pref$i FreeSans 0.2um ; port make
  }
}
proc variante {nombre rcapa w} {
  cellname create $nombre ; load $nombre
  cabeza 0 A ; cabeza 11.2 B
  box 1.2um [expr {1.8-$w/2.0}]um 11.2um [expr {1.8+$w/2.0}]um ; paint $rcapa
  drc on ; drc check ; puts "== $nombre DRC: [drc count total]" ; foreach e [drc listall why] { puts "   $e" } ; drc off
  save $nombre ; gds write $nombre.gds ; lef write $nombre.lef -hide
  extract all ; ext2spice lvs ; ext2spice -o $nombre.spice
}
variante efld01m_M1 rm1 0.14
variante efld01m_L1 rli 0.29
quit -noprompt
