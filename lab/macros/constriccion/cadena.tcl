# EFLD-01: cabezas "en cadena": 9 almohadillas de met1 (una por pin, con su mcon) unidas por tramos cortos de met1 dibujados como
# resistencia (rm1). Así Magic extrae cada pin como nodo distinto (una resistencia pequeña entre pines) en vez de fusionarlos, y LVS
# puede comparar 18 pines. A0..A7 / B0..B7: drivers; A8 / B8: lectura. La línea (precursor) une A8 con B8.
# Almohadilla 1,2 × 0,3 µm, tramo rm1 1,2 × 0,2 µm: paso 0,5 µm; cabeza 1,2 × 4,3 µm.
drc off
proc cabeza {x0 pref} {
  for {set i 0} {$i < 9} {incr i} {
    set y0 [expr {0.5*$i}]
    box ${x0}um ${y0}um [expr {$x0+1.2}]um [expr {$y0+0.3}]um ; paint li1 ; paint met1
    box [expr {$x0+0.515}]um [expr {$y0+0.065}]um [expr {$x0+0.685}]um [expr {$y0+0.235}]um ; paint mcon
    box ${x0}um ${y0}um [expr {$x0+1.2}]um [expr {$y0+0.3}]um ; label $pref$i FreeSans 0.2um ; port make
    if {$i < 8} { box ${x0}um [expr {$y0+0.3}]um [expr {$x0+1.2}]um [expr {$y0+0.5}]um ; paint rm1 }
  }
}
proc variante {nombre rcapa w} {
  cellname create $nombre ; load $nombre
  cabeza 0 A ; cabeza 11.2 B
  set yc 4.15
  box 1.2um [expr {$yc-$w/2.0}]um 11.2um [expr {$yc+$w/2.0}]um ; paint $rcapa
  drc on ; drc check ; puts "== $nombre DRC: [drc count total]" ; foreach e [drc listall why] { puts "   $e" } ; drc off
  save $nombre ; gds write $nombre.gds ; lef write $nombre.lef -hide
  extract all ; ext2spice lvs ; ext2spice -o $nombre.spice
}
variante efld01c_M1 rm1 0.14
variante efld01c_L1 rli 0.29
quit -noprompt
