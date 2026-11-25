# Control: metal-1 line, 2 um long, width v. Known answer: m1.1 = 0.140 um.
set lo 0.100 ; set hi 0.200 ; set step 0.005
proc draw {v} { box 0um 0um 2um ${v}um ; paint metal1 }
