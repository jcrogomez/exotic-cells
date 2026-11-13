# Procedimientos comunes de la macro PHOTON (sky130A, Magic en lote). Unidades en um.
# Fuentes de geometría: reglas photo.2/8/9/10/11, dnwell.2, nwell.5/6/7 de
# https://skywater-pdk.readthedocs.io/en/main/rules/periphery.html ; tipo Magic `photo` = DNWELL(64/18) AND PHOTO(81/81)
# (sky130A.tech líneas 723, 986, 2425-2426, 4009). Emisor: geometría de macros/chispa/legal.tcl (d = 0,50 um).
drc off
proc caja {x0 y0 x1 y1 capas} { box ${x0}um ${y0}um ${x1}um ${y1}um ; foreach c $capas { paint $c } }
# Etiqueta anclada a li1 explícitamente: sin la capa, Magic la pone en el primer plano uniforme (nwell) y cortocircuita puertos.
proc puerto {x0 y0 x1 y1 nombre} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $nombre center FreeSans 0.3um 0 0 li1 ; port make }

# Fotodiodo: photo de 3 x L (x0..x0+3, y0..y0+L). nwell interior 0,84 de ancho con 1,08 de enclosure (photo.8/9);
# tap n+ 0,41 con 0,215 de enclosure por nwell (photo.10/11); un licon de 0,17 centrado; li1 0,33. Cátodo K.
proc fotodiodo {x0 y0 L} {
  caja $x0 $y0 [expr {$x0+3}] [expr {$y0+$L}] photo
  caja [expr {$x0+1.08}]  [expr {$y0+1.08}]  [expr {$x0+1.92}]  [expr {$y0+$L-1.08}]  nwell
  caja [expr {$x0+1.295}] [expr {$y0+1.295}] [expr {$x0+1.705}] [expr {$y0+$L-1.295}] nsd
  caja [expr {$x0+1.415}] [expr {$y0+1.415}] [expr {$x0+1.585}] [expr {$y0+$L-1.415}] {nsc li1}
  caja [expr {$x0+1.335}] [expr {$y0+1.335}] [expr {$x0+1.665}] [expr {$y0+$L-1.335}] li1
  puerto [expr {$x0+1.335}] [expr {$y0+1.335}] [expr {$x0+1.665}] [expr {$y0+1.665}] K
}
# Anillo de tap p+ al sustrato (photo.7 / guarda). Caja interior (x0,y0)-(x1,y1); ancho w (>= 0,6); contacto 0,17 centrado.
# Pinta un anillo (interior x0..x1,y0..y1; exterior X0..X1,Y0..Y1) como cuatro rectángulos. Nunca pintar-y-borrar:
# pintar psd/nsd sobre el interior convierte el nsd/pdiode que ya está ahí y el borrado posterior lo elimina.
proc anillo {X0 Y0 X1 Y1 x0 y0 x1 y1 capa} {
  caja $X0 $Y0 $X1 $y0 $capa ; caja $X0 $y1 $X1 $Y1 $capa ; caja $X0 $y0 $x0 $y1 $capa ; caja $x1 $y0 $X1 $y1 $capa
}
proc anillo_tap {x0 y0 x1 y1 w nombre} {
  set X0 [expr {$x0-$w}] ; set Y0 [expr {$y0-$w}] ; set X1 [expr {$x1+$w}] ; set Y1 [expr {$y1+$w}]
  anillo $X0 $Y0 $X1 $Y1 $x0 $y0 $x1 $y1 psd
  set c [expr {$w/2.0}] ; set h 0.085 ; set m 0.165
  # tiras de contacto en los cuatro lados (li1 0,33 encima)
  caja [expr {$X0+$c-$m}] [expr {$Y0+$c-$h}] [expr {$X1-$c+$m}] [expr {$Y0+$c+$h}] {psc li1}
  caja [expr {$X0+$c-$m}] [expr {$Y1-$c-$h}] [expr {$X1-$c+$m}] [expr {$Y1-$c+$h}] {psc li1}
  caja [expr {$X0+$c-$h}] [expr {$Y0+$c-$m}] [expr {$X0+$c+$h}] [expr {$Y1-$c+$m}] {psc li1}
  caja [expr {$X1-$c-$h}] [expr {$Y0+$c-$m}] [expr {$X1-$c+$h}] [expr {$Y1-$c+$m}] {psc li1}
  caja [expr {$X0+$c-$m}] [expr {$Y0+$c-$m}] [expr {$X1-$c+$m}] [expr {$Y0+$c+$m}] li1
  caja [expr {$X0+$c-$m}] [expr {$Y1-$c-$m}] [expr {$X1-$c+$m}] [expr {$Y1-$c+$m}] li1
  caja [expr {$X0+$c-$m}] [expr {$Y0+$c-$m}] [expr {$X0+$c+$m}] [expr {$Y1-$c+$m}] li1
  caja [expr {$X1-$c-$m}] [expr {$Y0+$c-$m}] [expr {$X1-$c+$m}] [expr {$Y1-$c+$m}] li1
  puerto [expr {$X0+$c-$m}] [expr {$Y0+$c-$m}] [expr {$X0+$c+$m}] [expr {$Y0+$c+$m}] $nombre
}
# Anillo de dnwell (photo.6). de 3,0 de ancho (dnwell.2) con nwell que lo cubre 0,4 por fuera y por dentro (nwell.5/6)
# y tap n+ 0,6 centrado con licon 0,17 y li1. Caja interior (x0,y0)-(x1,y1). Puerto DNW.
proc anillo_dnw {x0 y0 x1 y1} {
  set w 3.0
  set X0 [expr {$x0-$w}] ; set Y0 [expr {$y0-$w}] ; set X1 [expr {$x1+$w}] ; set Y1 [expr {$y1+$w}]
  anillo $X0 $Y0 $X1 $Y1 $x0 $y0 $x1 $y1 dnwell
  anillo [expr {$X0-0.4}] [expr {$Y0-0.4}] [expr {$X1+0.4}] [expr {$Y1+0.4}] [expr {$x0+0.4}] [expr {$y0+0.4}] [expr {$x1-0.4}] [expr {$y1-0.4}] nwell
  set c 1.5 ; set t 0.3 ; set h 0.085 ; set m 0.165
  anillo [expr {$X0+$c-$t}] [expr {$Y0+$c-$t}] [expr {$X1-$c+$t}] [expr {$Y1-$c+$t}] [expr {$X0+$c+$t}] [expr {$Y0+$c+$t}] [expr {$X1-$c-$t}] [expr {$Y1-$c-$t}] nsd
  caja [expr {$X0+$c-$m}] [expr {$Y0+$c-$h}] [expr {$X1-$c+$m}] [expr {$Y0+$c+$h}] {nsc li1}
  caja [expr {$X0+$c-$m}] [expr {$Y1-$c-$h}] [expr {$X1-$c+$m}] [expr {$Y1-$c+$h}] {nsc li1}
  caja [expr {$X0+$c-$h}] [expr {$Y0+$c-$m}] [expr {$X0+$c+$h}] [expr {$Y1-$c+$m}] {nsc li1}
  caja [expr {$X1-$c-$h}] [expr {$Y0+$c-$m}] [expr {$X1-$c+$h}] [expr {$Y1-$c+$m}] {nsc li1}
  caja [expr {$X0+$c-$m}] [expr {$Y0+$c-$m}] [expr {$X1-$c+$m}] [expr {$Y0+$c+$m}] li1
  caja [expr {$X0+$c-$m}] [expr {$Y1-$c-$m}] [expr {$X1-$c+$m}] [expr {$Y1-$c+$m}] li1
  caja [expr {$X0+$c-$m}] [expr {$Y0+$c-$m}] [expr {$X0+$c+$m}] [expr {$Y1-$c+$m}] li1
  caja [expr {$X1-$c-$m}] [expr {$Y0+$c-$m}] [expr {$X1-$c+$m}] [expr {$Y1-$c+$m}] li1
  puerto [expr {$X0+$c-$m}] [expr {$Y0+$c-$m}] [expr {$X0+$c+$m}] [expr {$Y0+$c+$m}] DNW
}
# Emisor candidato: diodo p+/nwell con la geometría de macros/chispa/legal.tcl (d = 0,50 um), pero con los tipos `pdiode`/`pdiodec`
# (en vez de pdiff/pdiffc) para que Magic lo extraiga como sky130_fd_pr__diode_pd2nw_05v5 (añade el marcador areaid.diode 81/23).
# nwell 4 x 3 en (x0,y0). Puertos pa (ánodo p+), pk (cátodo nwell).
proc emisor {x0 y0 pa pk} {
  caja $x0 $y0 [expr {$x0+4}] [expr {$y0+3}] nwell
  caja [expr {$x0+0.6}] [expr {$y0+0.8}] [expr {$x0+1.6}] [expr {$y0+2.2}] pdiode
  caja [expr {$x0+2.1}] [expr {$y0+0.8}] [expr {$x0+3.1}] [expr {$y0+2.2}] nsd
  caja [expr {$x0+0.8}] [expr {$y0+1.0}] [expr {$x0+1.4}] [expr {$y0+2.0}] {pdiodec li1}
  caja [expr {$x0+0.7}] [expr {$y0+0.9}] [expr {$x0+1.5}] [expr {$y0+2.1}] li1
  caja [expr {$x0+2.3}] [expr {$y0+1.0}] [expr {$x0+2.9}] [expr {$y0+2.0}] {nsc li1}
  caja [expr {$x0+2.2}] [expr {$y0+0.9}] [expr {$x0+3.0}] [expr {$y0+2.1}] li1
  puerto [expr {$x0+0.7}] [expr {$y0+0.9}] [expr {$x0+1.5}] [expr {$y0+2.1}] $pa
  puerto [expr {$x0+2.2}] [expr {$y0+0.9}] [expr {$x0+3.0}] [expr {$y0+2.1}] $pk
}
proc cierra {nombre} {
  drc on ; drc check
  puts "== $nombre DRC Magic: [drc count total]" ; foreach e [drc listall why] { puts "   $e" } ; drc off
  save $nombre ; gds write $nombre.gds ; lef write $nombre.lef
  extract all ; ext2spice lvs ; ext2spice -o $nombre.spice
}
