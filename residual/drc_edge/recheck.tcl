# SPDX-License-Identifier: Apache-2.0
# Full-style DRC of existing .mag cells given in env CELLS (space separated paths without extension).
foreach c $env(CELLS) {
  load $c
  box -100um -100um 100um 100um
  drc style drc(full)
  drc on ; drc check ; drc catchup
  set rules {}
  foreach {msg boxes} [drc listall why] { lappend rules $msg }
  puts "RECHECK [file tail $c] violations=[llength $rules] [join $rules { | }]"
}
quit -noprompt
