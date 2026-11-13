# Precursor "La Constricción": cuatro variantes, dibujadas por script (reproducible).
# Unidades: micras. Línea de 10 um; cuello de 1 um de largo en el centro.
# M1: met1 uniforme 0.14 (mínimo).  M2: met1 0.50 con cuello 0.14.
# L1: li1  uniforme 0.17 (mínimo).  L2: li1  0.50 con cuello 0.17.
# Cabezas de contacto en los extremos: li1 + mcon + met1 (3 x 3 contactos) para que
# la ruta no sea el eslabón débil (mcon 0.36 mA c/u en el LEF).
drc off
proc cabeza {x0 y0} {
  # bloque de 1.2 x 1.2 um con 3x3 mcon
  box ${x0}um ${y0}um [expr {$x0+1.2}]um [expr {$y0+1.2}]um
  paint li1
  paint met1
  for {set i 0} {$i < 3} {incr i} {
    for {set j 0} {$j < 3} {incr j} {
      set cx [expr {$x0 + 0.2 + $i*0.36}]
      set cy [expr {$y0 + 0.2 + $j*0.36}]
      box ${cx}um ${cy}um [expr {$cx+0.17}]um [expr {$cy+0.17}]um
      paint mcon
    }
  }
}
proc variante {nombre capa wline wneck} {
  cellname create $nombre
  load $nombre
  set yc 0.6
  # cabezas en x=0..1.2 y x=11.2..12.4 ; línea de x=1.2 a 11.2 (10 um)
  cabeza 0 0
  cabeza 11.2 0
  set y0 [expr {$yc - $wline/2.0}]
  set y1 [expr {$yc + $wline/2.0}]
  if {$wneck < $wline} {
    box 1.2um ${y0}um 5.7um ${y1}um ; paint $capa
    set n0 [expr {$yc - $wneck/2.0}]
    set n1 [expr {$yc + $wneck/2.0}]
    box 5.7um ${n0}um 6.7um ${n1}um ; paint $capa
    box 6.7um ${y0}um 11.2um ${y1}um ; paint $capa
  } else {
    box 1.2um ${y0}um 11.2um ${y1}um ; paint $capa
  }
  box 0um 0um 1.2um 1.2um ; label A FreeSans 0.3um
  port make ; port class inout ; port use signal
  box 11.2um 0um 12.4um 1.2um ; label B FreeSans 0.3um
  port make ; port class inout ; port use signal
  drc on
  drc check
  puts "== $nombre : DRC errores = [drc count total]"
  foreach e [drc listall why] { puts "   $e" }
  drc off
  save $nombre
  gds write $nombre.gds
  lef write $nombre.lef
}
variante efld_cons_M1 met1 0.14 0.14
variante efld_cons_M2 met1 0.50 0.14
variante efld_cons_L1 li1  0.17 0.17
variante efld_cons_L2 li1  0.50 0.17
quit -noprompt
