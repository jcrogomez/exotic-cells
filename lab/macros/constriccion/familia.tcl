# EFLD-01, familia de precursores en met1 con capa de resistencia rm1. Línea 0.50 um, 10 um; cuellos de 1 um.
# A uniforme 0.14 (control) · B cuello central 0.14 · C doble cuello simétrico 0.14+0.14 (x=1/3, 2/3)
# D doble cuello asimétrico 0.14 + 0.17 (misma posición que C)
drc off
proc cabeza {x0 y0} {
  box ${x0}um ${y0}um [expr {$x0+1.2}]um [expr {$y0+1.2}]um ; paint li1 ; paint met1
  for {set i 0} {$i < 3} {incr i} { for {set j 0} {$j < 3} {incr j} {
    set cx [expr {$x0 + 0.2 + $i*0.36}] ; set cy [expr {$y0 + 0.2 + $j*0.36}]
    box ${cx}um ${cy}um [expr {$cx+0.17}]um [expr {$cy+0.17}]um ; paint mcon } }
}
# cuellos: lista de {x_centro ancho}
proc precursor {nombre wline cuellos} {
  cellname create $nombre ; load $nombre
  set yc 0.6 ; cabeza 0 0 ; cabeza 11.2 0
  set y0 [expr {$yc - $wline/2.0}] ; set y1 [expr {$yc + $wline/2.0}]
  set x 1.2
  foreach c $cuellos {
    lassign $c xc w
    set a [expr {$xc - 0.5}] ; set b [expr {$xc + 0.5}]
    box ${x}um ${y0}um ${a}um ${y1}um ; paint rm1
    set n0 [expr {$yc - $w/2.0}] ; set n1 [expr {$yc + $w/2.0}]
    box ${a}um ${n0}um ${b}um ${n1}um ; paint rm1
    set x $b
  }
  box ${x}um ${y0}um 11.2um ${y1}um ; paint rm1
  box 0um 0um 1.2um 1.2um ; label A FreeSans 0.3um ; port make
  box 11.2um 0um 12.4um 1.2um ; label B FreeSans 0.3um ; port make
  drc on ; drc check ; puts "== $nombre Magic DRC: [drc count total]" ; foreach e [drc listall why] { puts "   $e" } ; drc off
  save $nombre ; gds write $nombre.gds ; extract all ; ext2spice lvs ; ext2spice -o $nombre.spice
}
precursor efld01_A 0.14 {}
precursor efld01_B 0.50 {{6.2 0.14}}
precursor efld01_C 0.50 {{4.53 0.14} {7.87 0.14}}
precursor efld01_D 0.50 {{4.53 0.14} {7.87 0.17}}
quit -noprompt
