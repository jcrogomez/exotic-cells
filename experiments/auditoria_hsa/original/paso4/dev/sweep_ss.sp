* barrido
.lib "/pdk/libs.tech/ngspice/sky130.lib.spice" ss
.option scale=1e-6
.temp 27
VDD vdd 0 1.8
VL vl 0 0.5
VH vh 0 1.2
Vd0_0 vdd d0_0 0
Xd0_0 d0_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Vd0_1 vdd d0_1 0
Xd0_1 d0_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Vd0_2 vdd d0_2 0
Xd0_2 d0_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Vd1_0 vdd d1_0 0
Xd1_0 d1_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.18
Vd1_1 vdd d1_1 0
Xd1_1 d1_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.18
Vd1_2 vdd d1_2 0
Xd1_2 d1_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.18
Vd2_0 vdd d2_0 0
Xd2_0 d2_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5
Vd2_1 vdd d2_1 0
Xd2_1 d2_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5
Vd2_2 vdd d2_2 0
Xd2_2 d2_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5
Vd3_0 vdd d3_0 0
Xd3_0 d3_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.52 l=0.15
Vd3_1 vdd d3_1 0
Xd3_1 d3_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.52 l=0.15
Vd3_2 vdd d3_2 0
Xd3_2 d3_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.52 l=0.15
Vd4_0 vdd d4_0 0
Xd4_0 d4_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.54 l=0.15
Vd4_1 vdd d4_1 0
Xd4_1 d4_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.54 l=0.15
Vd4_2 vdd d4_2 0
Xd4_2 d4_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.54 l=0.15
Vd5_0 vdd d5_0 0
Xd5_0 d5_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=0.15
Vd5_1 vdd d5_1 0
Xd5_1 d5_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=0.15
Vd5_2 vdd d5_2 0
Xd5_2 d5_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=0.15
Vd6_0 vdd d6_0 0
Xd6_0 d6_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=0.59
Vd6_1 vdd d6_1 0
Xd6_1 d6_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=0.59
Vd6_2 vdd d6_2 0
Xd6_2 d6_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=0.59
Vd7_0 vdd d7_0 0
Xd7_0 d7_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=1.05
Vd7_1 vdd d7_1 0
Xd7_1 d7_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=1.05
Vd7_2 vdd d7_2 0
Xd7_2 d7_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=1.05
Vd8_0 vdd d8_0 0
Xd8_0 d8_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=1.97
Vd8_1 vdd d8_1 0
Xd8_1 d8_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=1.97
Vd8_2 vdd d8_2 0
Xd8_2 d8_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=1.97
Vd9_0 vdd d9_0 0
Xd9_0 d9_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=2.89
Vd9_1 vdd d9_1 0
Xd9_1 d9_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=2.89
Vd9_2 vdd d9_2 0
Xd9_2 d9_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=2.89
Vd10_0 vdd d10_0 0
Xd10_0 d10_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=4.73
Vd10_1 vdd d10_1 0
Xd10_1 d10_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=4.73
Vd10_2 vdd d10_2 0
Xd10_2 d10_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.55 l=4.73
Vd11_0 vdd d11_0 0
Xd11_0 d11_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.6 l=0.15
Vd11_1 vdd d11_1 0
Xd11_1 d11_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.6 l=0.15
Vd11_2 vdd d11_2 0
Xd11_2 d11_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.6 l=0.15
Vd12_0 vdd d12_0 0
Xd12_0 d12_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.64 l=0.15
Vd12_1 vdd d12_1 0
Xd12_1 d12_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.64 l=0.15
Vd12_2 vdd d12_2 0
Xd12_2 d12_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.64 l=0.15
Vd13_0 vdd d13_0 0
Xd13_0 d13_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15
Vd13_1 vdd d13_1 0
Xd13_1 d13_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15
Vd13_2 vdd d13_2 0
Xd13_2 d13_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15
Vd14_0 vdd d14_0 0
Xd14_0 d14_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.18
Vd14_1 vdd d14_1 0
Xd14_1 d14_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.18
Vd14_2 vdd d14_2 0
Xd14_2 d14_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.18
Vd15_0 vdd d15_0 0
Xd15_0 d15_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.25
Vd15_1 vdd d15_1 0
Xd15_1 d15_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.25
Vd15_2 vdd d15_2 0
Xd15_2 d15_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.25
Vd16_0 vdd d16_0 0
Xd16_0 d16_0 vdd 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.5
Vd16_1 vdd d16_1 0
Xd16_1 d16_1 vl 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.5
Vd16_2 vdd d16_2 0
Xd16_2 d16_2 vh 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.5
Vd17_0 d17_0 0 0
Xd17_0 d17_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.15
Vd17_1 d17_1 0 0
Xd17_1 d17_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.15
Vd17_2 d17_2 0 0
Xd17_2 d17_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.15
Vd18_0 d18_0 0 0
Xd18_0 d18_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18
Vd18_1 d18_1 0 0
Xd18_1 d18_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18
Vd18_2 d18_2 0 0
Xd18_2 d18_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18
Vd19_0 d19_0 0 0
Xd19_0 d19_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Vd19_1 d19_1 0 0
Xd19_1 d19_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Vd19_2 d19_2 0 0
Xd19_2 d19_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Vd20_0 d20_0 0 0
Xd20_0 d20_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.54 l=0.15
Vd20_1 d20_1 0 0
Xd20_1 d20_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.54 l=0.15
Vd20_2 d20_2 0 0
Xd20_2 d20_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.54 l=0.15
Vd21_0 d21_0 0 0
Xd21_0 d21_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.55 l=0.15
Vd21_1 d21_1 0 0
Xd21_1 d21_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.55 l=0.15
Vd21_2 d21_2 0 0
Xd21_2 d21_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.55 l=0.15
Vd22_0 d22_0 0 0
Xd22_0 d22_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.63 l=0.15
Vd22_1 d22_1 0 0
Xd22_1 d22_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.63 l=0.15
Vd22_2 d22_2 0 0
Xd22_2 d22_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.63 l=0.15
Vd23_0 d23_0 0 0
Xd23_0 d23_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.64 l=0.15
Vd23_1 d23_1 0 0
Xd23_1 d23_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.64 l=0.15
Vd23_2 d23_2 0 0
Xd23_2 d23_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.64 l=0.15
Vd24_0 d24_0 0 0
Xd24_0 d24_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.7 l=0.15
Vd24_1 d24_1 0 0
Xd24_1 d24_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.7 l=0.15
Vd24_2 d24_2 0 0
Xd24_2 d24_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.7 l=0.15
Vd25_0 d25_0 0 0
Xd25_0 d25_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.75 l=0.15
Vd25_1 d25_1 0 0
Xd25_1 d25_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.75 l=0.15
Vd25_2 d25_2 0 0
Xd25_2 d25_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.75 l=0.15
Vd26_0 d26_0 0 0
Xd26_0 d26_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.79 l=0.15
Vd26_1 d26_1 0 0
Xd26_1 d26_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.79 l=0.15
Vd26_2 d26_2 0 0
Xd26_2 d26_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.79 l=0.15
Vd27_0 d27_0 0 0
Xd27_0 d27_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.15
Vd27_1 d27_1 0 0
Xd27_1 d27_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.15
Vd27_2 d27_2 0 0
Xd27_2 d27_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.15
Vd28_0 d28_0 0 0
Xd28_0 d28_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.18
Vd28_1 d28_1 0 0
Xd28_1 d28_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.18
Vd28_2 d28_2 0 0
Xd28_2 d28_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.18
Vd29_0 d29_0 0 0
Xd29_0 d29_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.25
Vd29_1 d29_1 0 0
Xd29_1 d29_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.25
Vd29_2 d29_2 0 0
Xd29_2 d29_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.25
Vd30_0 d30_0 0 0
Xd30_0 d30_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.5
Vd30_1 d30_1 0 0
Xd30_1 d30_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.5
Vd30_2 d30_2 0 0
Xd30_2 d30_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.82 l=0.5
Vd31_0 d31_0 0 0
Xd31_0 d31_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.84 l=0.15
Vd31_1 d31_1 0 0
Xd31_1 d31_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.84 l=0.15
Vd31_2 d31_2 0 0
Xd31_2 d31_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.84 l=0.15
Vd32_0 d32_0 0 0
Xd32_0 d32_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=0.59
Vd32_1 d32_1 0 0
Xd32_1 d32_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=0.59
Vd32_2 d32_2 0 0
Xd32_2 d32_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=0.59
Vd33_0 d33_0 0 0
Xd33_0 d33_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=1.05
Vd33_1 d33_1 0 0
Xd33_1 d33_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=1.05
Vd33_2 d33_2 0 0
Xd33_2 d33_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=1.05
Vd34_0 d34_0 0 0
Xd34_0 d34_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=1.97
Vd34_1 d34_1 0 0
Xd34_1 d34_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=1.97
Vd34_2 d34_2 0 0
Xd34_2 d34_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=1.97
Vd35_0 d35_0 0 0
Xd35_0 d35_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=2.89
Vd35_1 d35_1 0 0
Xd35_1 d35_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=2.89
Vd35_2 d35_2 0 0
Xd35_2 d35_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=2.89
Vd36_0 d36_0 0 0
Xd36_0 d36_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=4.73
Vd36_1 d36_1 0 0
Xd36_1 d36_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=4.73
Vd36_2 d36_2 0 0
Xd36_2 d36_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.87 l=4.73
Vd37_0 d37_0 0 0
Xd37_0 d37_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.94 l=0.15
Vd37_1 d37_1 0 0
Xd37_1 d37_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.94 l=0.15
Vd37_2 d37_2 0 0
Xd37_2 d37_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.94 l=0.15
Vd38_0 d38_0 0 0
Xd38_0 d38_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15
Vd38_1 d38_1 0 0
Xd38_1 d38_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15
Vd38_2 d38_2 0 0
Xd38_2 d38_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15
Vd39_0 d39_0 0 0
Xd39_0 d39_0 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.25
Vd39_1 d39_1 0 0
Xd39_1 d39_1 gl vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.25
Vd39_2 d39_2 0 0
Xd39_2 d39_2 gh vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.25
VGL gl 0 1.3
VGH gh 0 0.6
.control
op
print i(vd0_0) i(vd0_1) i(vd0_2) i(vd1_0) i(vd1_1) i(vd1_2) i(vd2_0) i(vd2_1) i(vd2_2) i(vd3_0) i(vd3_1) i(vd3_2) i(vd4_0) i(vd4_1) i(vd4_2) i(vd5_0) i(vd5_1) i(vd5_2) i(vd6_0) i(vd6_1)
print i(vd6_2) i(vd7_0) i(vd7_1) i(vd7_2) i(vd8_0) i(vd8_1) i(vd8_2) i(vd9_0) i(vd9_1) i(vd9_2) i(vd10_0) i(vd10_1) i(vd10_2) i(vd11_0) i(vd11_1) i(vd11_2) i(vd12_0) i(vd12_1) i(vd12_2) i(vd13_0)
print i(vd13_1) i(vd13_2) i(vd14_0) i(vd14_1) i(vd14_2) i(vd15_0) i(vd15_1) i(vd15_2) i(vd16_0) i(vd16_1) i(vd16_2) i(vd17_0) i(vd17_1) i(vd17_2) i(vd18_0) i(vd18_1) i(vd18_2) i(vd19_0) i(vd19_1) i(vd19_2)
print i(vd20_0) i(vd20_1) i(vd20_2) i(vd21_0) i(vd21_1) i(vd21_2) i(vd22_0) i(vd22_1) i(vd22_2) i(vd23_0) i(vd23_1) i(vd23_2) i(vd24_0) i(vd24_1) i(vd24_2) i(vd25_0) i(vd25_1) i(vd25_2) i(vd26_0) i(vd26_1)
print i(vd26_2) i(vd27_0) i(vd27_1) i(vd27_2) i(vd28_0) i(vd28_1) i(vd28_2) i(vd29_0) i(vd29_1) i(vd29_2) i(vd30_0) i(vd30_1) i(vd30_2) i(vd31_0) i(vd31_1) i(vd31_2) i(vd32_0) i(vd32_1) i(vd32_2) i(vd33_0)
print i(vd33_1) i(vd33_2) i(vd34_0) i(vd34_1) i(vd34_2) i(vd35_0) i(vd35_1) i(vd35_2) i(vd36_0) i(vd36_1) i(vd36_2) i(vd37_0) i(vd37_1) i(vd37_2) i(vd38_0) i(vd38_1) i(vd38_2) i(vd39_0) i(vd39_1) i(vd39_2)
.endc
.end
