# Variante con capa de resistencia: la línea se pinta como rm1 (met1 resistor) o rli (li1 resistor)
# para que Magic extraiga un dispositivo res_generic entre A y B (dos terminales de verdad).
drc off
proc cabeza {x0 y0} {
  box ${x0}um ${y0}um [expr {$x0+1.2}]um [expr {$y0+1.2}]um
  paint li1 ; paint met1
  for {set i 0} {$i < 3} {incr i} { for {set j 0} {$j < 3} {incr j} {
    set cx [expr {$x0 + 0.2 + $i*0.36}] ; set cy [expr {$y0 + 0.2 + $j*0.36}]
    box ${cx}um ${cy}um [expr {$cx+0.17}]um [expr {$cy+0.17}]um ; paint mcon } }
}
proc variante {nombre capa rcapa wline wneck} {
  cellname create $nombre ; load $nombre
  set yc 0.6 ; cabeza 0 0 ; cabeza 11.2 0
  set y0 [expr {$yc - $wline/2.0}] ; set y1 [expr {$yc + $wline/2.0}]
  if {$wneck < $wline} {
    box 1.2um ${y0}um 5.7um ${y1}um ; paint $rcapa
    set n0 [expr {$yc - $wneck/2.0}] ; set n1 [expr {$yc + $wneck/2.0}]
    box 5.7um ${n0}um 6.7um ${n1}um ; paint $rcapa
    box 6.7um ${y0}um 11.2um ${y1}um ; paint $rcapa
  } else { box 1.2um ${y0}um 11.2um ${y1}um ; paint $rcapa }
  box 0um 0um 1.2um 1.2um ; label A FreeSans 0.3um ; port make
  box 11.2um 0um 12.4um 1.2um ; label B FreeSans 0.3um ; port make
  drc on ; drc check ; puts "== $nombre DRC: [drc count total]" ; foreach e [drc listall why] { puts "   $e" } ; drc off
  save $nombre ; gds write $nombre.gds
  extract all ; ext2spice lvs ; ext2spice -o $nombre.spice
}
variante efld_consR_M1 met1 rm1 0.14 0.14
variante efld_consR_M2 met1 rm1 0.50 0.14
variante efld_consR_L1 li1  rli 0.17 0.17
variante efld_consR_L2 li1  rli 0.50 0.17
quit -noprompt
