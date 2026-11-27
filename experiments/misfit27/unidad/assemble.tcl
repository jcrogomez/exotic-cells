drc off
gds readonly true
gds rescale false
gds read reader2_slot.gds
gds readonly false
gds read reader2fe.gds
cellname create reader2_unit
load reader2_unit
box 0um 10.0um 0um 10.0um
getcell reader2_slot
box 19.720um 1.000um 19.720um 1.000um
getcell reader2fe child 0 0
box 27.630um 5.435um 28.030um 5.835um ; paint metal1
box 27.690um 5.405um 27.970um 10.280um ; paint metal2
box 27.700um 5.505um 27.960um 5.765um ; paint via1
box 27.650um 5.455um 28.010um 5.815um ; paint metal1
box 27.650um 5.405um 28.010um 5.865um ; paint metal2
box 24.845um 7.405um 25.250um 7.805um ; paint metal1
box 24.930um 7.375um 25.210um 10.280um ; paint metal2
box 24.940um 7.475um 25.200um 7.735um ; paint via1
box 24.890um 7.425um 25.250um 7.785um ; paint metal1
box 24.890um 7.375um 25.250um 7.835um ; paint metal2
box 20.750um 7.405um 21.305um 7.805um ; paint metal1
box 20.790um 7.375um 21.070um 10.280um ; paint metal2
box 20.800um 7.475um 21.060um 7.735um ; paint via1
box 20.750um 7.425um 21.110um 7.785um ; paint metal1
box 20.750um 7.375um 21.110um 7.835um ; paint metal2
box 27.690um 9.000um 27.970um 9.400um ; label {x} FreeSans 40 0 0 0 c metal2 ; port make ; port class input ; port use signal
box 27.070um 7.865um 27.600um 8.265um ; paint metal1
box 27.120um 7.935um 27.380um 8.195um ; paint via1
box 27.070um 7.885um 27.430um 8.245um ; paint metal1
box 27.070um 7.835um 27.430um 8.295um ; paint metal2
box 27.110um 7.925um 27.390um 8.205um ; paint via2
box 27.070um 7.715um 27.430um 8.415um ; paint metal3
box 27.090um 7.905um 27.410um 8.225um ; paint via3
box 27.000um 7.815um 27.500um 8.315um ; paint metal3
box 26.500um 7.715um 27.550um 12.980um ; paint metal4
box 26.500um 7.715um 27.550um 8.715um ; label {VPWR} FreeSans 40 0 0 0 c metal4 ; port make ; port class inout ; port use power
box 21.590um 0.355um 21.850um 0.615um ; paint via1
box 21.540um 0.305um 21.900um 0.665um ; paint metal1
box 21.540um 0.255um 21.900um 0.715um ; paint metal2
box 21.580um 0.345um 21.860um 0.625um ; paint via2
box 21.540um 0.135um 21.900um 0.835um ; paint metal3
box 21.540um 0.305um 30.850um 0.665um ; paint metal3
box 30.440um 0.325um 30.760um 0.645um ; paint via3
box 30.350um 0.235um 30.850um 0.735um ; paint metal3
box 29.800um 0.135um 31.400um 12.980um ; paint metal4
box 29.800um 0.135um 31.400um 1.135um ; label {VGND} FreeSans 40 0 0 0 c metal4 ; port make ; port class inout ; port use ground
box 9.290um 55.960um 9.570um 56.240um ; paint metal2
box 9.290um 55.960um 9.570um 56.240um ; label {en} FreeSans 40 0 0 0 c metal2 ; port make ; port class input ; port use signal
box 12.050um 55.960um 12.330um 56.240um ; paint metal2
box 12.050um 55.960um 12.330um 56.240um ; label {pre} FreeSans 40 0 0 0 c metal2 ; port make ; port class input ; port use signal
box 14.810um 55.960um 15.090um 56.240um ; paint metal2
box 14.810um 55.960um 15.090um 56.240um ; label {src[0]} FreeSans 40 0 0 0 c metal2 ; port make ; port class input ; port use signal
box 17.570um 55.960um 17.850um 56.240um ; paint metal2
box 17.570um 55.960um 17.850um 56.240um ; label {src[1]} FreeSans 40 0 0 0 c metal2 ; port make ; port class input ; port use signal
box 30.450um 55.960um 30.730um 56.240um ; paint metal2
box 30.450um 55.960um 30.730um 56.240um ; label {xa} FreeSans 40 0 0 0 c metal2 ; port make ; port class output ; port use signal
box 33.210um 55.960um 33.490um 56.240um ; paint metal2
box 33.210um 55.960um 33.490um 56.240um ; label {xb} FreeSans 40 0 0 0 c metal2 ; port make ; port class output ; port use signal
box 0um 0um 46.92um 56.24um
property FIXED_BBOX [box values]
save reader2_unit
gds write reader2_unit.gds
lef write reader2_unit.lef -pinonly
quit -noprompt
