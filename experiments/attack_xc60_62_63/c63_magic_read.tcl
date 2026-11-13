# c63: qué tipos de Magic resultan de leer cada sonda (el DRC pasa, ¿pero qué cree Magic que hay?)
foreach n {c63_ntap_control c63_licon_bare_nwell c63_tap_noimpl_far c63_diff_noimpl_nwell c63_tap_half_licon_out_only c63_psub_tap_noimpl c63_psub_tap_half_licon_out c63_psub_diff_noimpl} {
  gds read c6x_drc_out/gds/$n.gds
  load $n
  save c63_magic_read/$n.mag
}
quit -noprompt
