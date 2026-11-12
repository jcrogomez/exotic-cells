* Ring oscillators of extracted standard cells, as extracted and after lod_annotate. tt, 27 C, 1.8 V. 7 stages.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vdd vdd 0 1.8
.include sky130_fd_sc_hd__inv_1.spice
.include sky130_fd_sc_hd__inv_2.spice
.include sky130_fd_sc_hd__nand2_1.spice
.include sky130_fd_sc_hd__nor2_1.spice
.include annotated.inc
Xinv10 inv1n0 0 0 vdd vdd inv1n1 sky130_fd_sc_hd__inv_1
Xinv11 inv1n1 0 0 vdd vdd inv1n2 sky130_fd_sc_hd__inv_1
Xinv12 inv1n2 0 0 vdd vdd inv1n3 sky130_fd_sc_hd__inv_1
Xinv13 inv1n3 0 0 vdd vdd inv1n4 sky130_fd_sc_hd__inv_1
Xinv14 inv1n4 0 0 vdd vdd inv1n5 sky130_fd_sc_hd__inv_1
Xinv15 inv1n5 0 0 vdd vdd inv1n6 sky130_fd_sc_hd__inv_1
Xinv16 inv1n6 0 0 vdd vdd inv1n0 sky130_fd_sc_hd__inv_1
.ic v(inv1n0)=0
Xinv1lod0 inv1lodn0 0 0 vdd vdd inv1lodn1 sky130_fd_sc_hd__inv_1_lod
Xinv1lod1 inv1lodn1 0 0 vdd vdd inv1lodn2 sky130_fd_sc_hd__inv_1_lod
Xinv1lod2 inv1lodn2 0 0 vdd vdd inv1lodn3 sky130_fd_sc_hd__inv_1_lod
Xinv1lod3 inv1lodn3 0 0 vdd vdd inv1lodn4 sky130_fd_sc_hd__inv_1_lod
Xinv1lod4 inv1lodn4 0 0 vdd vdd inv1lodn5 sky130_fd_sc_hd__inv_1_lod
Xinv1lod5 inv1lodn5 0 0 vdd vdd inv1lodn6 sky130_fd_sc_hd__inv_1_lod
Xinv1lod6 inv1lodn6 0 0 vdd vdd inv1lodn0 sky130_fd_sc_hd__inv_1_lod
.ic v(inv1lodn0)=0
Xinv20 inv2n0 0 0 vdd vdd inv2n1 sky130_fd_sc_hd__inv_2
Xinv21 inv2n1 0 0 vdd vdd inv2n2 sky130_fd_sc_hd__inv_2
Xinv22 inv2n2 0 0 vdd vdd inv2n3 sky130_fd_sc_hd__inv_2
Xinv23 inv2n3 0 0 vdd vdd inv2n4 sky130_fd_sc_hd__inv_2
Xinv24 inv2n4 0 0 vdd vdd inv2n5 sky130_fd_sc_hd__inv_2
Xinv25 inv2n5 0 0 vdd vdd inv2n6 sky130_fd_sc_hd__inv_2
Xinv26 inv2n6 0 0 vdd vdd inv2n0 sky130_fd_sc_hd__inv_2
.ic v(inv2n0)=0
Xinv2lod0 inv2lodn0 0 0 vdd vdd inv2lodn1 sky130_fd_sc_hd__inv_2_lod
Xinv2lod1 inv2lodn1 0 0 vdd vdd inv2lodn2 sky130_fd_sc_hd__inv_2_lod
Xinv2lod2 inv2lodn2 0 0 vdd vdd inv2lodn3 sky130_fd_sc_hd__inv_2_lod
Xinv2lod3 inv2lodn3 0 0 vdd vdd inv2lodn4 sky130_fd_sc_hd__inv_2_lod
Xinv2lod4 inv2lodn4 0 0 vdd vdd inv2lodn5 sky130_fd_sc_hd__inv_2_lod
Xinv2lod5 inv2lodn5 0 0 vdd vdd inv2lodn6 sky130_fd_sc_hd__inv_2_lod
Xinv2lod6 inv2lodn6 0 0 vdd vdd inv2lodn0 sky130_fd_sc_hd__inv_2_lod
.ic v(inv2lodn0)=0
Xnand210 nand21n0 vdd 0 0 vdd vdd nand21n1 sky130_fd_sc_hd__nand2_1
Xnand211 nand21n1 vdd 0 0 vdd vdd nand21n2 sky130_fd_sc_hd__nand2_1
Xnand212 nand21n2 vdd 0 0 vdd vdd nand21n3 sky130_fd_sc_hd__nand2_1
Xnand213 nand21n3 vdd 0 0 vdd vdd nand21n4 sky130_fd_sc_hd__nand2_1
Xnand214 nand21n4 vdd 0 0 vdd vdd nand21n5 sky130_fd_sc_hd__nand2_1
Xnand215 nand21n5 vdd 0 0 vdd vdd nand21n6 sky130_fd_sc_hd__nand2_1
Xnand216 nand21n6 vdd 0 0 vdd vdd nand21n0 sky130_fd_sc_hd__nand2_1
.ic v(nand21n0)=0
Xnand21lod0 nand21lodn0 vdd 0 0 vdd vdd nand21lodn1 sky130_fd_sc_hd__nand2_1_lod
Xnand21lod1 nand21lodn1 vdd 0 0 vdd vdd nand21lodn2 sky130_fd_sc_hd__nand2_1_lod
Xnand21lod2 nand21lodn2 vdd 0 0 vdd vdd nand21lodn3 sky130_fd_sc_hd__nand2_1_lod
Xnand21lod3 nand21lodn3 vdd 0 0 vdd vdd nand21lodn4 sky130_fd_sc_hd__nand2_1_lod
Xnand21lod4 nand21lodn4 vdd 0 0 vdd vdd nand21lodn5 sky130_fd_sc_hd__nand2_1_lod
Xnand21lod5 nand21lodn5 vdd 0 0 vdd vdd nand21lodn6 sky130_fd_sc_hd__nand2_1_lod
Xnand21lod6 nand21lodn6 vdd 0 0 vdd vdd nand21lodn0 sky130_fd_sc_hd__nand2_1_lod
.ic v(nand21lodn0)=0
Xnor210 nor21n0 0 0 0 vdd vdd nor21n1 sky130_fd_sc_hd__nor2_1
Xnor211 nor21n1 0 0 0 vdd vdd nor21n2 sky130_fd_sc_hd__nor2_1
Xnor212 nor21n2 0 0 0 vdd vdd nor21n3 sky130_fd_sc_hd__nor2_1
Xnor213 nor21n3 0 0 0 vdd vdd nor21n4 sky130_fd_sc_hd__nor2_1
Xnor214 nor21n4 0 0 0 vdd vdd nor21n5 sky130_fd_sc_hd__nor2_1
Xnor215 nor21n5 0 0 0 vdd vdd nor21n6 sky130_fd_sc_hd__nor2_1
Xnor216 nor21n6 0 0 0 vdd vdd nor21n0 sky130_fd_sc_hd__nor2_1
.ic v(nor21n0)=0
Xnor21lod0 nor21lodn0 0 0 0 vdd vdd nor21lodn1 sky130_fd_sc_hd__nor2_1_lod
Xnor21lod1 nor21lodn1 0 0 0 vdd vdd nor21lodn2 sky130_fd_sc_hd__nor2_1_lod
Xnor21lod2 nor21lodn2 0 0 0 vdd vdd nor21lodn3 sky130_fd_sc_hd__nor2_1_lod
Xnor21lod3 nor21lodn3 0 0 0 vdd vdd nor21lodn4 sky130_fd_sc_hd__nor2_1_lod
Xnor21lod4 nor21lodn4 0 0 0 vdd vdd nor21lodn5 sky130_fd_sc_hd__nor2_1_lod
Xnor21lod5 nor21lodn5 0 0 0 vdd vdd nor21lodn6 sky130_fd_sc_hd__nor2_1_lod
Xnor21lod6 nor21lodn6 0 0 0 vdd vdd nor21lodn0 sky130_fd_sc_hd__nor2_1_lod
.ic v(nor21lodn0)=0
.control
tran 1p 20n uic
meas tran ainv1 when v(inv1n0)=0.9 rise=3
meas tran binv1 when v(inv1n0)=0.9 rise=13
let pinv1 = (binv1-ainv1)/10*1e12
echo RING inv_1 extracted period_ps $&pinv1
meas tran ainv1lod when v(inv1lodn0)=0.9 rise=3
meas tran binv1lod when v(inv1lodn0)=0.9 rise=13
let pinv1lod = (binv1lod-ainv1lod)/10*1e12
echo RING inv_1 annotated period_ps $&pinv1lod
meas tran ainv2 when v(inv2n0)=0.9 rise=3
meas tran binv2 when v(inv2n0)=0.9 rise=13
let pinv2 = (binv2-ainv2)/10*1e12
echo RING inv_2 extracted period_ps $&pinv2
meas tran ainv2lod when v(inv2lodn0)=0.9 rise=3
meas tran binv2lod when v(inv2lodn0)=0.9 rise=13
let pinv2lod = (binv2lod-ainv2lod)/10*1e12
echo RING inv_2 annotated period_ps $&pinv2lod
meas tran anand21 when v(nand21n0)=0.9 rise=3
meas tran bnand21 when v(nand21n0)=0.9 rise=13
let pnand21 = (bnand21-anand21)/10*1e12
echo RING nand2_1 extracted period_ps $&pnand21
meas tran anand21lod when v(nand21lodn0)=0.9 rise=3
meas tran bnand21lod when v(nand21lodn0)=0.9 rise=13
let pnand21lod = (bnand21lod-anand21lod)/10*1e12
echo RING nand2_1 annotated period_ps $&pnand21lod
meas tran anor21 when v(nor21n0)=0.9 rise=3
meas tran bnor21 when v(nor21n0)=0.9 rise=13
let pnor21 = (bnor21-anor21)/10*1e12
echo RING nor2_1 extracted period_ps $&pnor21
meas tran anor21lod when v(nor21lodn0)=0.9 rise=3
meas tran bnor21lod when v(nor21lodn0)=0.9 rise=13
let pnor21lod = (bnor21lod-anor21lod)/10*1e12
echo RING nor2_1 annotated period_ps $&pnor21lod
quit
.endc
.end
