# Control: local-interconnect line, 2 um long, width v. Known answer: li.1 = 0.170 um.
set lo 0.120 ; set hi 0.220 ; set step 0.005
proc draw {v} { box 0um 0um 2um ${v}um ; paint locali }
