drc off
addpath ../xc19_slot_core
addpath ../xc19_bias
cellname create xc19_slot_w
load xc19_slot_w
box 0um 0um 0um 0um
getcell xc19_slot_core child 0 0
box -9.310um 1.865um -9.140um 4.635um ; paint locali
box -9.310um 4.385um -9.140um 4.715um ; paint locali
box -9.310um 4.465um -9.140um 4.635um ; paint viali
box -9.405um 4.370um -9.045um 4.730um ; paint metal1
box -9.355um 4.420um -9.095um 4.680um ; paint via1
box -9.405um 4.320um -9.045um 4.780um ; paint metal2
box -9.365um 4.410um -9.085um 4.690um ; paint via2
box -9.405um 4.370um -9.045um 4.730um ; paint metal3
box -9.375um 4.400um -9.075um 14.000um ; paint metal3
box -9.405um 13.550um -9.045um 14.200um ; paint metal3
box -9.365um 13.720um -9.085um 14.000um ; paint via2
box -9.405um 13.635um -9.045um 14.085um ; paint metal2
box -9.295um 13.680um -9.155um 15.400um ; paint metal2
box -9.295um 15.100um -9.155um 15.400um ; label XA_OUT FreeSans 20 0 0 0 c metal2 ; port make
box -7.260um -3.840um -7.090um -2.270um ; paint locali
box -7.260um -2.520um -7.090um -2.190um ; paint locali
box -7.260um -2.440um -7.090um -2.270um ; paint viali
box -7.355um -2.535um -6.995um -2.175um ; paint metal1
box -7.305um -2.485um -7.045um -2.225um ; paint via1
box -7.355um -2.585um -6.995um -2.125um ; paint metal2
box -7.315um -2.495um -7.035um -2.215um ; paint via2
box -7.355um -2.535um -6.995um -2.175um ; paint metal3
box -7.325um -2.505um -7.025um 14.000um ; paint metal3
box -7.355um 13.550um -6.995um 14.200um ; paint metal3
box -7.315um 13.720um -7.035um 14.000um ; paint via2
box -7.355um 13.635um -6.995um 14.085um ; paint metal2
box -7.245um 13.680um -7.105um 15.400um ; paint metal2
box -7.245um 15.100um -7.105um 15.400um ; label SA2B FreeSans 20 0 0 0 c metal2 ; port make
box -5.860um -3.840um -5.690um -2.270um ; paint locali
box -5.860um -2.520um -5.690um -2.190um ; paint locali
box -5.860um -2.440um -5.690um -2.270um ; paint viali
box -5.955um -2.535um -5.595um -2.175um ; paint metal1
box -5.905um -2.485um -5.645um -2.225um ; paint via1
box -5.955um -2.585um -5.595um -2.125um ; paint metal2
box -5.915um -2.495um -5.635um -2.215um ; paint via2
box -5.955um -2.535um -5.595um -2.175um ; paint metal3
box -5.925um -2.505um -5.625um 14.000um ; paint metal3
box -5.955um 13.550um -5.595um 14.200um ; paint metal3
box -5.915um 13.720um -5.635um 14.000um ; paint via2
box -5.955um 13.635um -5.595um 14.085um ; paint metal2
box -5.845um 13.680um -5.705um 15.400um ; paint metal2
box -5.845um 15.100um -5.705um 15.400um ; label SA1B FreeSans 20 0 0 0 c metal2 ; port make
box -4.760um -10.580um -4.590um -10.410um ; paint locali
box -4.760um -10.660um -4.590um -10.330um ; paint locali
box -4.760um -10.580um -4.590um -10.410um ; paint viali
box -4.855um -10.675um -4.495um -10.315um ; paint metal1
box -4.805um -10.625um -4.545um -10.365um ; paint via1
box -4.855um -10.725um -4.495um -10.265um ; paint metal2
box -4.815um -10.635um -4.535um -10.355um ; paint via2
box -4.855um -10.675um -4.495um -10.315um ; paint metal3
box -5.225um -10.675um -4.495um -10.315um ; paint metal3
box -5.225um -10.645um -4.925um 14.000um ; paint metal3
box -5.255um 13.550um -4.895um 14.200um ; paint metal3
box -5.215um 13.720um -4.935um 14.000um ; paint via2
box -5.255um 13.635um -4.895um 14.085um ; paint metal2
box -5.145um 13.680um -5.005um 15.400um ; paint metal2
box -5.145um 15.100um -5.005um 15.400um ; label REFA FreeSans 20 0 0 0 c metal2 ; port make
box -4.460um -3.840um -4.290um -2.270um ; paint locali
box -4.460um -2.520um -4.290um -2.190um ; paint locali
box -4.460um -2.440um -4.290um -2.270um ; paint viali
box -4.555um -2.535um -4.195um -2.175um ; paint metal1
box -4.505um -2.485um -4.245um -2.225um ; paint via1
box -4.555um -2.585um -4.195um -2.125um ; paint metal2
box -4.515um -2.495um -4.235um -2.215um ; paint via2
box -4.555um -2.535um -4.195um -2.175um ; paint metal3
box -4.525um -2.505um -4.225um 14.000um ; paint metal3
box -4.555um 13.550um -4.195um 14.200um ; paint metal3
box -4.515um 13.720um -4.235um 14.000um ; paint via2
box -4.555um 13.635um -4.195um 14.085um ; paint metal2
box -4.445um 13.680um -4.305um 15.400um ; paint metal2
box -4.445um 15.100um -4.305um 15.400um ; label SA0B FreeSans 20 0 0 0 c metal2 ; port make
box 3.250um 2.615um 3.420um 2.785um ; paint locali
box 3.250um 2.535um 3.420um 2.865um ; paint locali
box 3.250um 2.615um 3.420um 2.785um ; paint viali
box 3.155um 2.520um 3.515um 2.880um ; paint metal1
box 3.205um 2.570um 3.465um 2.830um ; paint via1
box 3.155um 2.470um 3.515um 2.930um ; paint metal2
box 3.195um 2.560um 3.475um 2.840um ; paint via2
box 3.155um 2.520um 3.515um 2.880um ; paint metal3
box 3.185um 2.550um 3.485um 14.000um ; paint metal3
box 3.155um 13.550um 3.515um 14.200um ; paint metal3
box 3.195um 13.720um 3.475um 14.000um ; paint via2
box 3.155um 13.635um 3.515um 14.085um ; paint metal2
box 3.265um 13.680um 3.405um 15.400um ; paint metal2
box 3.265um 15.100um 3.405um 15.400um ; label C1 FreeSans 20 0 0 0 c metal2 ; port make
box 5.650um 3.250um 5.820um 3.420um ; paint locali
box 5.650um 3.170um 5.820um 3.500um ; paint locali
box 5.650um 3.250um 5.820um 3.420um ; paint viali
box 5.555um 3.155um 5.915um 3.515um ; paint metal1
box 5.605um 3.205um 5.865um 3.465um ; paint via1
box 5.555um 3.105um 5.915um 3.565um ; paint metal2
box 5.595um 3.195um 5.875um 3.475um ; paint via2
box 5.555um 3.155um 5.915um 3.515um ; paint metal3
box 5.585um 3.185um 5.885um 14.000um ; paint metal3
box 5.555um 13.550um 5.915um 14.200um ; paint metal3
box 5.595um 13.720um 5.875um 14.000um ; paint via2
box 5.555um 13.635um 5.915um 14.085um ; paint metal2
box 5.665um 13.680um 5.805um 15.400um ; paint metal2
box 5.665um 15.100um 5.805um 15.400um ; label VBIAS FreeSans 20 0 0 0 c metal2 ; port make
box 19.890um -2.540um 20.360um -2.370um ; paint locali
box 20.190um -2.540um 20.360um -2.270um ; paint locali
box 20.190um -2.520um 20.360um -2.190um ; paint locali
box 20.060um -2.370um 20.190um -2.290um ; paint locali
box 20.190um -2.440um 20.360um -2.270um ; paint viali
box 20.095um -2.535um 20.455um -2.175um ; paint metal1
box 20.145um -2.485um 20.405um -2.225um ; paint via1
box 20.095um -2.585um 20.455um -2.125um ; paint metal2
box 20.135um -2.495um 20.415um -2.215um ; paint via2
box 20.095um -2.535um 20.455um -2.175um ; paint metal3
box 19.010um -2.535um 20.455um -2.175um ; paint metal3
box 19.010um -2.505um 19.310um 14.000um ; paint metal3
box 18.980um 13.550um 19.340um 14.200um ; paint metal3
box 19.020um 13.720um 19.300um 14.000um ; paint via2
box 18.980um 13.635um 19.340um 14.085um ; paint metal2
box 19.090um 13.680um 19.230um 15.400um ; paint metal2
box 19.090um 15.100um 19.230um 15.400um ; label DUTA FreeSans 20 0 0 0 c metal2 ; port make
box 19.965um 2.070um 20.135um 2.240um ; paint locali
box 19.965um 1.990um 20.135um 2.320um ; paint locali
box 19.965um 2.070um 20.135um 2.240um ; paint viali
box 19.870um 1.975um 20.230um 2.335um ; paint metal1
box 19.920um 2.025um 20.180um 2.285um ; paint via1
box 19.870um 1.925um 20.230um 2.385um ; paint metal2
box 19.910um 2.015um 20.190um 2.295um ; paint via2
box 19.870um 1.975um 20.230um 2.335um ; paint metal3
box 19.900um 2.005um 20.200um 14.000um ; paint metal3
box 19.870um 13.550um 20.230um 14.200um ; paint metal3
box 19.910um 13.720um 20.190um 14.000um ; paint via2
box 19.870um 13.635um 20.230um 14.085um ; paint metal2
box 19.980um 13.680um 20.120um 15.400um ; paint metal2
box 19.980um 15.100um 20.120um 15.400um ; label PREA FreeSans 20 0 0 0 c metal2 ; port make
box 22.190um -2.540um 23.060um -2.370um ; paint locali
box 22.190um -2.540um 22.360um -2.270um ; paint locali
box 22.190um -2.520um 22.360um -2.190um ; paint locali
box 22.360um -2.370um 22.890um -2.290um ; paint locali
box 22.190um -2.440um 22.360um -2.270um ; paint viali
box 22.095um -2.535um 22.455um -2.175um ; paint metal1
box 22.145um -2.485um 22.405um -2.225um ; paint via1
box 22.095um -2.585um 22.455um -2.125um ; paint metal2
box 22.135um -2.495um 22.415um -2.215um ; paint via2
box 22.095um -2.535um 22.455um -2.175um ; paint metal3
box 22.010um -2.535um 22.455um -2.175um ; paint metal3
box 22.010um -2.505um 22.310um 14.000um ; paint metal3
box 21.980um 13.550um 22.340um 14.200um ; paint metal3
box 22.020um 13.720um 22.300um 14.000um ; paint via2
box 21.980um 13.635um 22.340um 14.085um ; paint metal2
box 22.090um 13.680um 22.230um 15.400um ; paint metal2
box 22.090um 15.100um 22.230um 15.400um ; label DUTB FreeSans 20 0 0 0 c metal2 ; port make
box 22.965um 2.070um 23.135um 2.240um ; paint locali
box 22.965um 1.990um 23.135um 2.320um ; paint locali
box 22.965um 2.070um 23.135um 2.240um ; paint viali
box 22.870um 1.975um 23.230um 2.335um ; paint metal1
box 22.920um 2.025um 23.180um 2.285um ; paint via1
box 22.870um 1.925um 23.230um 2.385um ; paint metal2
box 22.910um 2.015um 23.190um 2.295um ; paint via2
box 22.870um 1.975um 23.230um 2.335um ; paint metal3
box 22.900um 2.005um 23.200um 14.000um ; paint metal3
box 22.870um 13.550um 23.230um 14.200um ; paint metal3
box 22.910um 13.720um 23.190um 14.000um ; paint via2
box 22.870um 13.635um 23.230um 14.085um ; paint metal2
box 22.980um 13.680um 23.120um 15.400um ; paint metal2
box 22.980um 15.100um 23.120um 15.400um ; label PREB FreeSans 20 0 0 0 c metal2 ; port make
box 35.290um -3.840um 35.460um -2.270um ; paint locali
box 35.290um -2.520um 35.460um -2.190um ; paint locali
box 35.290um -2.440um 35.460um -2.270um ; paint viali
box 35.195um -2.535um 35.555um -2.175um ; paint metal1
box 35.245um -2.485um 35.505um -2.225um ; paint via1
box 35.195um -2.585um 35.555um -2.125um ; paint metal2
box 35.235um -2.495um 35.515um -2.215um ; paint via2
box 35.195um -2.535um 35.555um -2.175um ; paint metal3
box 35.225um -2.505um 35.525um 14.000um ; paint metal3
box 35.195um 13.550um 35.555um 14.200um ; paint metal3
box 35.235um 13.720um 35.515um 14.000um ; paint via2
box 35.195um 13.635um 35.555um 14.085um ; paint metal2
box 35.305um 13.680um 35.445um 15.400um ; paint metal2
box 35.305um 15.100um 35.445um 15.400um ; label SB0B FreeSans 20 0 0 0 c metal2 ; port make
box 35.590um -10.580um 35.760um -10.410um ; paint locali
box 35.590um -10.660um 35.760um -10.330um ; paint locali
box 35.590um -10.580um 35.760um -10.410um ; paint viali
box 35.495um -10.675um 35.855um -10.315um ; paint metal1
box 35.545um -10.625um 35.805um -10.365um ; paint via1
box 35.495um -10.725um 35.855um -10.265um ; paint metal2
box 35.535um -10.635um 35.815um -10.355um ; paint via2
box 35.495um -10.675um 35.855um -10.315um ; paint metal3
box 35.495um -10.675um 36.225um -10.315um ; paint metal3
box 35.925um -10.645um 36.225um 14.000um ; paint metal3
box 35.895um 13.550um 36.255um 14.200um ; paint metal3
box 35.935um 13.720um 36.215um 14.000um ; paint via2
box 35.895um 13.635um 36.255um 14.085um ; paint metal2
box 36.005um 13.680um 36.145um 15.400um ; paint metal2
box 36.005um 15.100um 36.145um 15.400um ; label REFB FreeSans 20 0 0 0 c metal2 ; port make
box 36.690um -3.840um 36.860um -2.270um ; paint locali
box 36.690um -2.520um 36.860um -2.190um ; paint locali
box 36.690um -2.440um 36.860um -2.270um ; paint viali
box 36.595um -2.535um 36.955um -2.175um ; paint metal1
box 36.645um -2.485um 36.905um -2.225um ; paint via1
box 36.595um -2.585um 36.955um -2.125um ; paint metal2
box 36.635um -2.495um 36.915um -2.215um ; paint via2
box 36.595um -2.535um 36.955um -2.175um ; paint metal3
box 36.625um -2.505um 36.925um 14.000um ; paint metal3
box 36.595um 13.550um 36.955um 14.200um ; paint metal3
box 36.635um 13.720um 36.915um 14.000um ; paint via2
box 36.595um 13.635um 36.955um 14.085um ; paint metal2
box 36.705um 13.680um 36.845um 15.400um ; paint metal2
box 36.705um 15.100um 36.845um 15.400um ; label SB1B FreeSans 20 0 0 0 c metal2 ; port make
box 40.140um 1.865um 40.310um 4.635um ; paint locali
box 40.140um 4.385um 40.310um 4.715um ; paint locali
box 40.140um 4.465um 40.310um 4.635um ; paint viali
box 40.045um 4.370um 40.405um 4.730um ; paint metal1
box 40.095um 4.420um 40.355um 4.680um ; paint via1
box 40.045um 4.320um 40.405um 4.780um ; paint metal2
box 40.085um 4.410um 40.365um 4.690um ; paint via2
box 40.045um 4.370um 40.405um 4.730um ; paint metal3
box 40.075um 4.400um 40.375um 14.000um ; paint metal3
box 40.045um 13.550um 40.405um 14.200um ; paint metal3
box 40.085um 13.720um 40.365um 14.000um ; paint via2
box 40.045um 13.635um 40.405um 14.085um ; paint metal2
box 40.155um 13.680um 40.295um 15.400um ; paint metal2
box 40.155um 15.100um 40.295um 15.400um ; label XB_OUT FreeSans 20 0 0 0 c metal2 ; port make
box 14.400um -5.680um 14.900um -3.400um ; paint metal1
box 27.600um -5.680um 28.100um -3.400um ; paint metal1
box 37.995um -2.535um 38.355um -2.175um ; paint metal3
box 38.025um -2.355um 38.325um 14.000um ; paint metal3
box 37.995um 13.550um 38.355um 14.200um ; paint metal3
box 38.025um 13.700um 38.325um 14.000um ; label DUMMYB FreeSans 20 0 0 0 c metal3 ; port make
box 10.200um 3.810um 10.800um 4.750um ; paint metal1
box 10.370um 4.320um 10.630um 4.580um ; paint via1
box 10.300um 4.250um 10.700um 4.650um ; paint metal2
box 10.360um 4.310um 10.640um 4.590um ; paint via2
box 10.250um 4.200um 10.750um 4.700um ; paint metal3
box 10.340um 4.290um 10.660um 4.610um ; paint via3
box 10.200um 4.150um 10.800um 4.750um ; paint metal4
box 10.200um 4.150um 10.800um 4.750um ; label VDD FreeSans 20 0 0 0 c metal4 ; port make
box 8.300um 0.600um 8.700um 1.010um ; paint metal1
box 8.370um 0.675um 8.630um 0.935um ; paint via1
box 8.320um 0.620um 8.680um 4.650um ; paint metal2
box 8.360um 4.310um 8.640um 4.590um ; paint via2
box 8.250um 4.200um 8.750um 4.700um ; paint metal3
box 8.340um 4.290um 8.660um 4.610um ; paint via3
box 8.200um 4.150um 8.800um 4.750um ; paint metal4
box 8.200um 4.150um 8.800um 4.750um ; label GND FreeSans 20 0 0 0 c metal4 ; port make
select top cell
drc style drc(full)
drc on
drc check
drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ [lrange $boxes 0 3]" }
puts "DRC xc19_slot_w violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save xc19_slot_w
gds write xc19_slot_w.gds
extract all
ext2spice lvs
ext2spice -o xc19_slot_w.lvs.spice
select top cell ; puts "BBOX [box values]"
quit -noprompt
