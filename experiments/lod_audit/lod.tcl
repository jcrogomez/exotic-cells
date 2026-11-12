# Auditoria LOD paso 2: dos nfet_01v8 con la misma W/L (0,42/0,15) y distinta longitud de difusion (SA=SB=0,30 y 3,0 um).
# Contactos a la misma distancia del poly en los dos. Pregunta: ¿el netlist extraido los distingue en algo mas que as/ad/ps/pd?
drc off
proc lod {nombre sa} {
  cellname create $nombre
  load $nombre
  set L 0.15 ; set W 0.42
  set xg $sa ; set xe [expr {2*$sa + $L}]
  box 0um 0um ${xe}um ${W}um ; paint ndiff
  box ${xg}um -0.13um [expr {$xg+$L}]um [expr {$W+0.13}]um ; paint poly
  # contactos: a 0,09 um del poly en ambos lados
  set c1a [expr {$xg-0.09-0.17}] ; set c1b [expr {$xg-0.09}]
  set c2a [expr {$xg+$L+0.09}]   ; set c2b [expr {$xg+$L+0.09+0.17}]
  box ${c1a}um 0.06um ${c1b}um 0.36um ; paint ndiffc
  box ${c2a}um 0.06um ${c2b}um 0.36um ; paint ndiffc
  box ${c1a}um -0.02um ${c1b}um 0.44um ; paint li1
  box ${c2a}um -0.02um ${c2b}um 0.44um ; paint li1
  box ${c1a}um 0.06um ${c1b}um 0.36um ; label S FreeSans 20 0 0 0 c li1 ; port make
  box ${c2a}um 0.06um ${c2b}um 0.36um ; label D FreeSans 20 0 0 0 c li1 ; port make
  box ${xg}um [expr {$W+0.05}]um [expr {$xg+$L}]um [expr {$W+0.13}]um ; label G FreeSans 20 0 0 0 c poly ; port make
  select top cell
  drc on ; drc check ; drc catchup
  puts "== $nombre sa=sb=$sa um : DRC [drc count total]"
  foreach e [drc listall why] { puts "   $e" }
  drc off
  save $nombre ; gds write $nombre.gds
  extract all
  ext2spice lvs
  ext2spice -o $nombre.spice
}
lod lod_sa030 0.30
lod lod_sa300 3.0
quit -noprompt
