# ¿Es legal en sky130 una unión p+ / n+ abutida dentro de un nwell? Cuatro separaciones.
# pdiff = p+ en nwell (ánodo). nsd = n+ en nwell (contacto de pozo / cátodo).
drc off
proc union {nombre d} {
  cellname create $nombre
  load $nombre
  box 0um 0um 4um 3um ; paint nwell
  # p+ : x 0.6..1.6 ; n+ : empieza en 1.6+d
  box 0.6um 0.8um 1.6um 2.2um ; paint pdiff
  set x0 [expr {1.6 + $d}]
  box ${x0}um 0.8um [expr {$x0+1.0}]um 2.2um ; paint nsd
  # contactos
  box 0.8um 1.0um 1.4um 2.0um ; paint pdiffc ; paint li1
  box 0.7um 0.9um 1.5um 2.1um ; paint li1
  box [expr {$x0+0.2}]um 1.0um [expr {$x0+0.8}]um 2.0um ; paint nsc ; paint li1
  box [expr {$x0+0.1}]um 0.9um [expr {$x0+0.9}]um 2.1um ; paint li1
  drc on ; drc check
  puts "== $nombre d=$d um : [drc count total]"
  foreach e [drc listall why] { puts "   $e" }
  drc off
  save $nombre ; gds write $nombre.gds
}
union chispa_d000 0.0
union chispa_d013 0.13
union chispa_d027 0.27
union chispa_d050 0.50
quit -noprompt
