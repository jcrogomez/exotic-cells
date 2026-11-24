* MISFIT-03 etapa a · etapa b: tA frente a la puerta del DUT · esquina tt 27 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
.subckt trap XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
X0 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=118.482 ps=607.88 w=5.5 l=10
X3 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X6 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X8 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X9 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X11 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X15 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X16 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X19 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X23 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X24 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X25 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X28 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X33 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X34 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X42 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X43 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X51 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X53 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X55 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X57 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X60 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X61 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X64 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X66 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X68 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X69 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X73 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X75 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X76 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X81 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X85 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X88 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X94 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X95 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X99 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X1 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X4 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X5 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X7 XB PREB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X10 XA PREA VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X12 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X13 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X14 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X17 GND REFB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X18 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X20 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 a_7650_n924# VDD XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X26 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X27 XB_OUT XB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X29 XB_OUT XB GND GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X30 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X31 XA SA2B a_n2233_n890# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X32 a_7370_n924# SB1B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X35 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X36 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X40 XA GT a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 XA SA1B a_n2270_n1236# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X45 a_7090_n924# SB0B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X46 XB VB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X47 a_n2000_n1632# REFA GND GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X48 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X49 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X50 XA SA0B a_n950_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X54 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X58 VDD XA XA_OUT VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X59 GND XA XA_OUT GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X62 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X63 a_n48_382# a_n48_382# VB GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X65 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X70 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X71 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X72 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X74 GND DUTB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X77 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X78 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X79 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X80 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X82 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X83 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X84 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X86 GND DUTA a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X87 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X89 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X90 C1 C1 a_n48_382# GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X91 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X92 VBIAS VBIAS C1 GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X93 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X96 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X97 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X98 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 XB VDD 0.47777f
C1 SA0B VDD 0.04538f
C2 PREA VDD 0.17043f
C3 VB VDD 0.35118f
C4 VB REFB 0.00642f
C5 SA0B a_n2270_n1236# 0.00126f
C6 a_n2270_n1236# VB 0.04724f
C7 XB a_7040_n2004# 0.00524f
C8 VB a_7040_n2004# 0.14965f
C9 VB a_3900_n392# 0.07228f
C10 SA0B a_n2000_n1632# 0
C11 a_n2233_n890# VDD 0.17403f
C12 VDD SB0B 0.04538f
C13 a_7650_n924# XB 0.07509f
C14 VB a_n2000_n1632# 0.14597f
C15 a_n2233_n890# a_n2270_n1236# 0.39422f
C16 VB a_7650_n924# 0.05379f
C17 a_4500_n392# DUTA 0
C18 SB0B a_7040_n2004# 0
C19 a_7370_n924# a_7090_n924# 0.00251f
C20 SA2B VDD 0.05775f
C21 a_n2233_n890# a_n2000_n1632# 0
C22 SA1B VDD 0.05165f
C23 a_7650_n924# SB0B 0
C24 VB a_n2090_n1632# 0.41783f
C25 SA2B a_n2270_n1236# 0.00382f
C26 VBIAS VDD 0.03241f
C27 SA1B a_n2270_n1236# 0.0076f
C28 a_7090_n924# SB1B 0
C29 SA2B a_n2000_n1632# 0
C30 a_n2233_n890# a_n2090_n1632# 0.03226f
C31 a_7130_n1632# XB 0.4496f
C32 XA PREB 0
C33 a_n48_382# VDD 0.04849f
C34 CALA CALB 0.00657f
C35 C1 XA 0.00739f
C36 VB a_7130_n1632# 0.42699f
C37 a_7370_n924# SB1B 0.0076f
C38 a_n950_n924# VDD 0.00372f
C39 XB XA 0.02337f
C40 SA0B XA 0.01894f
C41 a_n2270_n1236# a_n950_n924# 0.00251f
C42 VB REFA 0.00473f
C43 PREA XA 0.02146f
C44 VB XA 0.84518f
C45 a_4500_n392# VDD 0.00496f
C46 a_7090_n924# VDD 0.00372f
C47 SA2B a_n2090_n1632# 0.00149f
C48 SA1B a_n2090_n1632# 0.00131f
C49 XB XB_OUT 0.02746f
C50 VB XB_OUT 0
C51 a_n2233_n890# XA 0.07515f
C52 XA_OUT VDD 0.11304f
C53 a_7370_n924# VDD 0.03521f
C54 XB DUTB 0.01922f
C55 VDD DUTA 0
C56 a_n2270_n1236# XA_OUT 0
C57 VB DUTB 0.01701f
C58 a_7650_n924# a_7090_n924# 0
C59 VDD CALB 0
C60 a_7370_n924# a_7040_n2004# 0.00505f
C61 a_3900_n392# DUTA 0.00298f
C62 a_n2090_n1632# a_n950_n924# 0
C63 VDD SB1B 0.06992f
C64 a_3900_n392# CALA 0
C65 SA2B XA 0.01399f
C66 SA1B XA 0.01535f
C67 a_7650_n924# a_7370_n924# 0.39422f
C68 VBIAS XA 0.00599f
C69 XB PREB 0.0233f
C70 PREA PREB 0.00413f
C71 VB PREB 0.00674f
C72 C1 VB 0.00902f
C73 VB XB 0.97094f
C74 a_7650_n924# SB1B 0
C75 SA0B VB 0
C76 a_n48_382# XA 0.0082f
C77 PREA VB 0.00674f
C78 a_n2270_n1236# VDD 0.02958f
C79 a_7130_n1632# a_7090_n924# 0
C80 XA a_n950_n924# 0.05363f
C81 XB SB0B 0.01894f
C82 VDD a_7040_n2004# 0
C83 SA0B a_n2233_n890# 0
C84 REFB a_7040_n2004# 0.00982f
C85 a_3900_n392# VDD 0.00496f
C86 a_n2233_n890# VB 0.0538f
C87 VB SB0B 0.00204f
C88 a_7130_n1632# a_7370_n924# 0.12211f
C89 a_7650_n924# VDD 0.20852f
C90 a_n2270_n1236# a_n2000_n1632# 0.00505f
C91 XA XA_OUT 0.02816f
C92 XA DUTA 0.00921f
C93 VBIAS C1 0.05143f
C94 XA CALA 0.59636f
C95 a_4500_n392# DUTB 0.00298f
C96 a_7130_n1632# SB1B 0.00131f
C97 a_7650_n924# a_7040_n2004# 0
C98 SA0B SA1B 0.01827f
C99 SA2B VB 0
C100 SA1B VB 0.00283f
C101 XA CALB 0
C102 a_n2090_n1632# VDD 0.03533f
C103 VBIAS VB 0.00565f
C104 a_n2270_n1236# a_n2090_n1632# 0.12211f
C105 C1 a_n48_382# 0.05143f
C106 DUTA DUTB 0.00465f
C107 a_n2233_n890# SA2B 0.00793f
C108 SA1B a_n2233_n890# 0
C109 VB a_n48_382# 0.06216f
C110 a_n2090_n1632# a_n2000_n1632# 0.44072f
C111 a_7130_n1632# VDD 0.03763f
C112 a_7130_n1632# REFB 0
C113 DUTB CALB 0
C114 SA0B a_n950_n924# 0.00164f
C115 VB a_n950_n924# 0
C116 XB a_4500_n392# 0.05778f
C117 XB a_7090_n924# 0.05363f
C118 XA VDD 0.42521f
C119 VB a_4500_n392# 0.0654f
C120 a_7130_n1632# a_7040_n2004# 0.44072f
C121 VB a_7090_n924# 0
C122 a_n2270_n1236# XA 0.16867f
C123 SA1B SA2B 0.01827f
C124 a_n2233_n890# a_n950_n924# 0
C125 a_7650_n924# a_7130_n1632# 0.03226f
C126 XB a_7370_n924# 0.16864f
C127 PREB CALB 0
C128 XB DUTA 0
C129 XA a_3900_n392# 0.05981f
C130 XB_OUT VDD 0.1139f
C131 XB CALA 0
C132 VB XA_OUT 0
C133 VB a_7370_n924# 0.05164f
C134 a_n2000_n1632# REFA 0.00982f
C135 VB DUTA 0.01701f
C136 a_n2000_n1632# XA 0.00524f
C137 VB CALA 0.01075f
C138 a_7090_n924# SB0B 0.00164f
C139 VDD DUTB 0
C140 XB CALB 0.60923f
C141 VB CALB 0.01176f
C142 XB SB1B 0.01535f
C143 SA1B a_n950_n924# 0
C144 VB SB1B 0.00327f
C145 a_n2233_n890# XA_OUT 0
C146 a_7370_n924# SB0B 0.00126f
C147 a_7650_n924# XB_OUT 0
C148 a_n2090_n1632# REFA 0
C149 a_n2090_n1632# XA 0.4496f
C150 PREB VDD 0.17673f
C151 C1 VDD 0.04849f
C152 SB1B SB0B 0.01827f
C153 CALB GND 0.28251f
C154 CALA GND 0.29501f
C155 REFB GND 0.2066f
C156 REFA GND 0.20807f
C157 SB1B GND 0.12444f
C158 SB0B GND 0.1517f
C159 SA0B GND 0.15374f
C160 SA1B GND 0.12484f
C161 SA2B GND 0.14094f
C162 DUTB GND 0.21831f
C163 DUTA GND 0.21794f
C164 XB_OUT GND 0.13753f
C165 PREB GND 0.10876f
C166 PREA GND 0.11529f
C167 VB GND 0.15572p
C168 XA_OUT GND 0.13768f
C169 XB GND 6.59752f
C170 VBIAS GND 0.5422f
C171 C1 GND 0.59586f
C172 XA GND 6.78506f
C173 VDD GND 10.6227f
C174 a_7040_n2004# GND 0.72419f
C175 a_7130_n1632# GND 0.82893f
C176 a_7370_n924# GND 0.61536f
C177 a_7090_n924# GND 0.01561f
C178 a_7650_n924# GND 0.48433f
C179 a_n2000_n1632# GND 0.72782f
C180 a_n2090_n1632# GND 0.83958f
C181 a_n950_n924# GND 0.01596f
C182 a_n2270_n1236# GND 0.61977f
C183 a_n2233_n890# GND 0.49496f
C184 a_4500_n392# GND 0.20468f
C185 a_3900_n392# GND 0.19922f
C186 a_n48_382# GND 0.59697f
.ends
Vd vdd 0 1.8
Vh hi 0 1.8
Vpre pre 0 pwl(0 1.8 1e-06 1.8 1.001e-06 0)
Vs1 s1 0 0
Vs0 s0 0 1.8
Vk k 0 0
* --- g0: trap
Xg0_ienn hi 0 0 vdd vdd g0_enn sky130_fd_sc_hd__inv_1
Xg0_is1n s1 0 0 vdd vdd g0_s1n sky130_fd_sc_hd__inv_1
Xg0_is0n s0 0 0 vdd vdd g0_s0n sky130_fd_sc_hd__inv_1
Xg0_PREA pre g0_enn 0 0 vdd vdd g0_PREA sky130_fd_sc_hd__nor2_1
Xg0_PREB pre g0_enn 0 0 vdd vdd g0_PREB sky130_fd_sc_hd__nor2_1
Xg0_VBIAS hi 0 0 vdd vdd g0_VBIAS sky130_fd_sc_hd__buf_2
Xg0_C1 hi 0 0 vdd vdd g0_C1 sky130_fd_sc_hd__buf_2
Xg0_DUTA hi g0_s1n s0 0 0 vdd vdd g0_DUTA sky130_fd_sc_hd__and3_1
Xg0_DUTB hi g0_s1n s0 0 0 vdd vdd g0_DUTB sky130_fd_sc_hd__and3_1
Xg0_REFA hi s1 0 0 vdd vdd g0_REFA sky130_fd_sc_hd__and2_1
Xg0_REFB hi s1 0 0 vdd vdd g0_REFB sky130_fd_sc_hd__and2_1
Xg0_SA0B hi s1 s0 0 0 vdd vdd g0_SA0B sky130_fd_sc_hd__nand3_1
Xg0_SA1B hi s1 0 0 vdd vdd g0_SA1B sky130_fd_sc_hd__nand2_1
Xg0_SA2B hi s1 g0_s0n 0 0 vdd vdd g0_SA2B sky130_fd_sc_hd__nand3_1
Xg0_SB0B hi s1 0 0 vdd vdd g0_SB0B sky130_fd_sc_hd__nand2_1
Xg0_SB1B hi s1 0 0 vdd vdd g0_SB1B sky130_fd_sc_hd__nand2_1
Xg0_M g0_ob g0_SB0B g0_SB1B g0_REFB g0_oa g0_SA0B g0_SA1B g0_SA2B g0_REFA vdd 0 g0_VBIAS g0_C1 g0_PREA g0_XA g0_DUTA g0_PREB g0_XB g0_DUTB g0_VB 0 0 g0_GT trap
Bg0_gt g0_GT 0 V=v(g0_VB)+(-0.2)+0.000305*v(k)

* --- g1: trap
Xg1_ienn hi 0 0 vdd vdd g1_enn sky130_fd_sc_hd__inv_1
Xg1_is1n s1 0 0 vdd vdd g1_s1n sky130_fd_sc_hd__inv_1
Xg1_is0n s0 0 0 vdd vdd g1_s0n sky130_fd_sc_hd__inv_1
Xg1_PREA pre g1_enn 0 0 vdd vdd g1_PREA sky130_fd_sc_hd__nor2_1
Xg1_PREB pre g1_enn 0 0 vdd vdd g1_PREB sky130_fd_sc_hd__nor2_1
Xg1_VBIAS hi 0 0 vdd vdd g1_VBIAS sky130_fd_sc_hd__buf_2
Xg1_C1 hi 0 0 vdd vdd g1_C1 sky130_fd_sc_hd__buf_2
Xg1_DUTA hi g1_s1n s0 0 0 vdd vdd g1_DUTA sky130_fd_sc_hd__and3_1
Xg1_DUTB hi g1_s1n s0 0 0 vdd vdd g1_DUTB sky130_fd_sc_hd__and3_1
Xg1_REFA hi s1 0 0 vdd vdd g1_REFA sky130_fd_sc_hd__and2_1
Xg1_REFB hi s1 0 0 vdd vdd g1_REFB sky130_fd_sc_hd__and2_1
Xg1_SA0B hi s1 s0 0 0 vdd vdd g1_SA0B sky130_fd_sc_hd__nand3_1
Xg1_SA1B hi s1 0 0 vdd vdd g1_SA1B sky130_fd_sc_hd__nand2_1
Xg1_SA2B hi s1 g1_s0n 0 0 vdd vdd g1_SA2B sky130_fd_sc_hd__nand3_1
Xg1_SB0B hi s1 0 0 vdd vdd g1_SB0B sky130_fd_sc_hd__nand2_1
Xg1_SB1B hi s1 0 0 vdd vdd g1_SB1B sky130_fd_sc_hd__nand2_1
Xg1_M g1_ob g1_SB0B g1_SB1B g1_REFB g1_oa g1_SA0B g1_SA1B g1_SA2B g1_REFA vdd 0 g1_VBIAS g1_C1 g1_PREA g1_XA g1_DUTA g1_PREB g1_XB g1_DUTB g1_VB 0 0 g1_GT trap
Bg1_gt g1_GT 0 V=v(g1_VB)+(-0.15)+0.000305*v(k)

* --- g2: trap
Xg2_ienn hi 0 0 vdd vdd g2_enn sky130_fd_sc_hd__inv_1
Xg2_is1n s1 0 0 vdd vdd g2_s1n sky130_fd_sc_hd__inv_1
Xg2_is0n s0 0 0 vdd vdd g2_s0n sky130_fd_sc_hd__inv_1
Xg2_PREA pre g2_enn 0 0 vdd vdd g2_PREA sky130_fd_sc_hd__nor2_1
Xg2_PREB pre g2_enn 0 0 vdd vdd g2_PREB sky130_fd_sc_hd__nor2_1
Xg2_VBIAS hi 0 0 vdd vdd g2_VBIAS sky130_fd_sc_hd__buf_2
Xg2_C1 hi 0 0 vdd vdd g2_C1 sky130_fd_sc_hd__buf_2
Xg2_DUTA hi g2_s1n s0 0 0 vdd vdd g2_DUTA sky130_fd_sc_hd__and3_1
Xg2_DUTB hi g2_s1n s0 0 0 vdd vdd g2_DUTB sky130_fd_sc_hd__and3_1
Xg2_REFA hi s1 0 0 vdd vdd g2_REFA sky130_fd_sc_hd__and2_1
Xg2_REFB hi s1 0 0 vdd vdd g2_REFB sky130_fd_sc_hd__and2_1
Xg2_SA0B hi s1 s0 0 0 vdd vdd g2_SA0B sky130_fd_sc_hd__nand3_1
Xg2_SA1B hi s1 0 0 vdd vdd g2_SA1B sky130_fd_sc_hd__nand2_1
Xg2_SA2B hi s1 g2_s0n 0 0 vdd vdd g2_SA2B sky130_fd_sc_hd__nand3_1
Xg2_SB0B hi s1 0 0 vdd vdd g2_SB0B sky130_fd_sc_hd__nand2_1
Xg2_SB1B hi s1 0 0 vdd vdd g2_SB1B sky130_fd_sc_hd__nand2_1
Xg2_M g2_ob g2_SB0B g2_SB1B g2_REFB g2_oa g2_SA0B g2_SA1B g2_SA2B g2_REFA vdd 0 g2_VBIAS g2_C1 g2_PREA g2_XA g2_DUTA g2_PREB g2_XB g2_DUTB g2_VB 0 0 g2_GT trap
Bg2_gt g2_GT 0 V=v(g2_VB)+(-0.1)+0.000305*v(k)

* --- g3: trap
Xg3_ienn hi 0 0 vdd vdd g3_enn sky130_fd_sc_hd__inv_1
Xg3_is1n s1 0 0 vdd vdd g3_s1n sky130_fd_sc_hd__inv_1
Xg3_is0n s0 0 0 vdd vdd g3_s0n sky130_fd_sc_hd__inv_1
Xg3_PREA pre g3_enn 0 0 vdd vdd g3_PREA sky130_fd_sc_hd__nor2_1
Xg3_PREB pre g3_enn 0 0 vdd vdd g3_PREB sky130_fd_sc_hd__nor2_1
Xg3_VBIAS hi 0 0 vdd vdd g3_VBIAS sky130_fd_sc_hd__buf_2
Xg3_C1 hi 0 0 vdd vdd g3_C1 sky130_fd_sc_hd__buf_2
Xg3_DUTA hi g3_s1n s0 0 0 vdd vdd g3_DUTA sky130_fd_sc_hd__and3_1
Xg3_DUTB hi g3_s1n s0 0 0 vdd vdd g3_DUTB sky130_fd_sc_hd__and3_1
Xg3_REFA hi s1 0 0 vdd vdd g3_REFA sky130_fd_sc_hd__and2_1
Xg3_REFB hi s1 0 0 vdd vdd g3_REFB sky130_fd_sc_hd__and2_1
Xg3_SA0B hi s1 s0 0 0 vdd vdd g3_SA0B sky130_fd_sc_hd__nand3_1
Xg3_SA1B hi s1 0 0 vdd vdd g3_SA1B sky130_fd_sc_hd__nand2_1
Xg3_SA2B hi s1 g3_s0n 0 0 vdd vdd g3_SA2B sky130_fd_sc_hd__nand3_1
Xg3_SB0B hi s1 0 0 vdd vdd g3_SB0B sky130_fd_sc_hd__nand2_1
Xg3_SB1B hi s1 0 0 vdd vdd g3_SB1B sky130_fd_sc_hd__nand2_1
Xg3_M g3_ob g3_SB0B g3_SB1B g3_REFB g3_oa g3_SA0B g3_SA1B g3_SA2B g3_REFA vdd 0 g3_VBIAS g3_C1 g3_PREA g3_XA g3_DUTA g3_PREB g3_XB g3_DUTB g3_VB 0 0 g3_GT trap
Bg3_gt g3_GT 0 V=v(g3_VB)+(-0.05)+0.000305*v(k)

* --- g4: trap
Xg4_ienn hi 0 0 vdd vdd g4_enn sky130_fd_sc_hd__inv_1
Xg4_is1n s1 0 0 vdd vdd g4_s1n sky130_fd_sc_hd__inv_1
Xg4_is0n s0 0 0 vdd vdd g4_s0n sky130_fd_sc_hd__inv_1
Xg4_PREA pre g4_enn 0 0 vdd vdd g4_PREA sky130_fd_sc_hd__nor2_1
Xg4_PREB pre g4_enn 0 0 vdd vdd g4_PREB sky130_fd_sc_hd__nor2_1
Xg4_VBIAS hi 0 0 vdd vdd g4_VBIAS sky130_fd_sc_hd__buf_2
Xg4_C1 hi 0 0 vdd vdd g4_C1 sky130_fd_sc_hd__buf_2
Xg4_DUTA hi g4_s1n s0 0 0 vdd vdd g4_DUTA sky130_fd_sc_hd__and3_1
Xg4_DUTB hi g4_s1n s0 0 0 vdd vdd g4_DUTB sky130_fd_sc_hd__and3_1
Xg4_REFA hi s1 0 0 vdd vdd g4_REFA sky130_fd_sc_hd__and2_1
Xg4_REFB hi s1 0 0 vdd vdd g4_REFB sky130_fd_sc_hd__and2_1
Xg4_SA0B hi s1 s0 0 0 vdd vdd g4_SA0B sky130_fd_sc_hd__nand3_1
Xg4_SA1B hi s1 0 0 vdd vdd g4_SA1B sky130_fd_sc_hd__nand2_1
Xg4_SA2B hi s1 g4_s0n 0 0 vdd vdd g4_SA2B sky130_fd_sc_hd__nand3_1
Xg4_SB0B hi s1 0 0 vdd vdd g4_SB0B sky130_fd_sc_hd__nand2_1
Xg4_SB1B hi s1 0 0 vdd vdd g4_SB1B sky130_fd_sc_hd__nand2_1
Xg4_M g4_ob g4_SB0B g4_SB1B g4_REFB g4_oa g4_SA0B g4_SA1B g4_SA2B g4_REFA vdd 0 g4_VBIAS g4_C1 g4_PREA g4_XA g4_DUTA g4_PREB g4_XB g4_DUTB g4_VB 0 0 g4_GT trap
Bg4_gt g4_GT 0 V=v(g4_VB)+(0.0)+0.000305*v(k)

* --- g5: trap
Xg5_ienn hi 0 0 vdd vdd g5_enn sky130_fd_sc_hd__inv_1
Xg5_is1n s1 0 0 vdd vdd g5_s1n sky130_fd_sc_hd__inv_1
Xg5_is0n s0 0 0 vdd vdd g5_s0n sky130_fd_sc_hd__inv_1
Xg5_PREA pre g5_enn 0 0 vdd vdd g5_PREA sky130_fd_sc_hd__nor2_1
Xg5_PREB pre g5_enn 0 0 vdd vdd g5_PREB sky130_fd_sc_hd__nor2_1
Xg5_VBIAS hi 0 0 vdd vdd g5_VBIAS sky130_fd_sc_hd__buf_2
Xg5_C1 hi 0 0 vdd vdd g5_C1 sky130_fd_sc_hd__buf_2
Xg5_DUTA hi g5_s1n s0 0 0 vdd vdd g5_DUTA sky130_fd_sc_hd__and3_1
Xg5_DUTB hi g5_s1n s0 0 0 vdd vdd g5_DUTB sky130_fd_sc_hd__and3_1
Xg5_REFA hi s1 0 0 vdd vdd g5_REFA sky130_fd_sc_hd__and2_1
Xg5_REFB hi s1 0 0 vdd vdd g5_REFB sky130_fd_sc_hd__and2_1
Xg5_SA0B hi s1 s0 0 0 vdd vdd g5_SA0B sky130_fd_sc_hd__nand3_1
Xg5_SA1B hi s1 0 0 vdd vdd g5_SA1B sky130_fd_sc_hd__nand2_1
Xg5_SA2B hi s1 g5_s0n 0 0 vdd vdd g5_SA2B sky130_fd_sc_hd__nand3_1
Xg5_SB0B hi s1 0 0 vdd vdd g5_SB0B sky130_fd_sc_hd__nand2_1
Xg5_SB1B hi s1 0 0 vdd vdd g5_SB1B sky130_fd_sc_hd__nand2_1
Xg5_M g5_ob g5_SB0B g5_SB1B g5_REFB g5_oa g5_SA0B g5_SA1B g5_SA2B g5_REFA vdd 0 g5_VBIAS g5_C1 g5_PREA g5_XA g5_DUTA g5_PREB g5_XB g5_DUTB g5_VB 0 0 g5_GT trap
Bg5_gt g5_GT 0 V=v(g5_VB)+(0.05)+0.000305*v(k)

.control
set noaskquit
save v(g0_oa) v(g0_ob) v(g0_VB) v(g1_oa) v(g1_ob) v(g1_VB) v(g2_oa) v(g2_ob) v(g2_VB) v(g3_oa) v(g3_ob) v(g3_VB) v(g4_oa) v(g4_ob) v(g4_VB) v(g5_oa) v(g5_ob) v(g5_VB)
alter Vk dc = 0
tran 20n 1000u 0 50n
meas tran ta0 when v(g0_oa)=0.9 rise=1
meas tran tb0 when v(g0_ob)=0.9 rise=1
meas tran vb0 find v(g0_VB) at=0.9e-6
echo VB 0 -0.2 $&ta0 $&tb0 $&vb0
meas tran ta1 when v(g1_oa)=0.9 rise=1
meas tran tb1 when v(g1_ob)=0.9 rise=1
meas tran vb1 find v(g1_VB) at=0.9e-6
echo VB 0 -0.15 $&ta1 $&tb1 $&vb1
meas tran ta2 when v(g2_oa)=0.9 rise=1
meas tran tb2 when v(g2_ob)=0.9 rise=1
meas tran vb2 find v(g2_VB) at=0.9e-6
echo VB 0 -0.1 $&ta2 $&tb2 $&vb2
meas tran ta3 when v(g3_oa)=0.9 rise=1
meas tran tb3 when v(g3_ob)=0.9 rise=1
meas tran vb3 find v(g3_VB) at=0.9e-6
echo VB 0 -0.05 $&ta3 $&tb3 $&vb3
meas tran ta4 when v(g4_oa)=0.9 rise=1
meas tran tb4 when v(g4_ob)=0.9 rise=1
meas tran vb4 find v(g4_VB) at=0.9e-6
echo VB 0 0.0 $&ta4 $&tb4 $&vb4
meas tran ta5 when v(g5_oa)=0.9 rise=1
meas tran tb5 when v(g5_ob)=0.9 rise=1
meas tran vb5 find v(g5_VB) at=0.9e-6
echo VB 0 0.05 $&ta5 $&tb5 $&vb5
alter Vk dc = 1
tran 20n 1000u 0 50n
meas tran ta0 when v(g0_oa)=0.9 rise=1
meas tran tb0 when v(g0_ob)=0.9 rise=1
meas tran vb0 find v(g0_VB) at=0.9e-6
echo VB 1 -0.2 $&ta0 $&tb0 $&vb0
meas tran ta1 when v(g1_oa)=0.9 rise=1
meas tran tb1 when v(g1_ob)=0.9 rise=1
meas tran vb1 find v(g1_VB) at=0.9e-6
echo VB 1 -0.15 $&ta1 $&tb1 $&vb1
meas tran ta2 when v(g2_oa)=0.9 rise=1
meas tran tb2 when v(g2_ob)=0.9 rise=1
meas tran vb2 find v(g2_VB) at=0.9e-6
echo VB 1 -0.1 $&ta2 $&tb2 $&vb2
meas tran ta3 when v(g3_oa)=0.9 rise=1
meas tran tb3 when v(g3_ob)=0.9 rise=1
meas tran vb3 find v(g3_VB) at=0.9e-6
echo VB 1 -0.05 $&ta3 $&tb3 $&vb3
meas tran ta4 when v(g4_oa)=0.9 rise=1
meas tran tb4 when v(g4_ob)=0.9 rise=1
meas tran vb4 find v(g4_VB) at=0.9e-6
echo VB 1 0.0 $&ta4 $&tb4 $&vb4
meas tran ta5 when v(g5_oa)=0.9 rise=1
meas tran tb5 when v(g5_ob)=0.9 rise=1
meas tran vb5 find v(g5_VB) at=0.9e-6
echo VB 1 0.05 $&ta5 $&tb5 $&vb5
quit
.endc
.end
