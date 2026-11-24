* MISFIT-03 etapa a · enmienda 2 Monte Carlo tt_mm · esquina tt_mm 27 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt_mm
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
* --- m0: trap
Xm0_ienn hi 0 0 vdd vdd m0_enn sky130_fd_sc_hd__inv_1
Xm0_is1n s1 0 0 vdd vdd m0_s1n sky130_fd_sc_hd__inv_1
Xm0_is0n s0 0 0 vdd vdd m0_s0n sky130_fd_sc_hd__inv_1
Xm0_PREA pre m0_enn 0 0 vdd vdd m0_PREA sky130_fd_sc_hd__nor2_1
Xm0_PREB pre m0_enn 0 0 vdd vdd m0_PREB sky130_fd_sc_hd__nor2_1
Xm0_VBIAS hi 0 0 vdd vdd m0_VBIAS sky130_fd_sc_hd__buf_2
Xm0_C1 hi 0 0 vdd vdd m0_C1 sky130_fd_sc_hd__buf_2
Xm0_DUTA hi m0_s1n s0 0 0 vdd vdd m0_DUTA sky130_fd_sc_hd__and3_1
Xm0_DUTB hi m0_s1n s0 0 0 vdd vdd m0_DUTB sky130_fd_sc_hd__and3_1
Xm0_REFA hi s1 0 0 vdd vdd m0_REFA sky130_fd_sc_hd__and2_1
Xm0_REFB hi s1 0 0 vdd vdd m0_REFB sky130_fd_sc_hd__and2_1
Xm0_SA0B hi s1 s0 0 0 vdd vdd m0_SA0B sky130_fd_sc_hd__nand3_1
Xm0_SA1B hi s1 0 0 vdd vdd m0_SA1B sky130_fd_sc_hd__nand2_1
Xm0_SA2B hi s1 m0_s0n 0 0 vdd vdd m0_SA2B sky130_fd_sc_hd__nand3_1
Xm0_SB0B hi s1 0 0 vdd vdd m0_SB0B sky130_fd_sc_hd__nand2_1
Xm0_SB1B hi s1 0 0 vdd vdd m0_SB1B sky130_fd_sc_hd__nand2_1
Xm0_M m0_ob m0_SB0B m0_SB1B m0_REFB m0_oa m0_SA0B m0_SA1B m0_SA2B m0_REFA vdd 0 m0_VBIAS m0_C1 m0_PREA m0_XA m0_DUTA m0_PREB m0_XB m0_DUTB m0_VB 0 0 m0_GT trap
Bm0_gt m0_GT 0 V=v(m0_VB)+0.000305*v(k)

* --- m1: trap
Xm1_ienn hi 0 0 vdd vdd m1_enn sky130_fd_sc_hd__inv_1
Xm1_is1n s1 0 0 vdd vdd m1_s1n sky130_fd_sc_hd__inv_1
Xm1_is0n s0 0 0 vdd vdd m1_s0n sky130_fd_sc_hd__inv_1
Xm1_PREA pre m1_enn 0 0 vdd vdd m1_PREA sky130_fd_sc_hd__nor2_1
Xm1_PREB pre m1_enn 0 0 vdd vdd m1_PREB sky130_fd_sc_hd__nor2_1
Xm1_VBIAS hi 0 0 vdd vdd m1_VBIAS sky130_fd_sc_hd__buf_2
Xm1_C1 hi 0 0 vdd vdd m1_C1 sky130_fd_sc_hd__buf_2
Xm1_DUTA hi m1_s1n s0 0 0 vdd vdd m1_DUTA sky130_fd_sc_hd__and3_1
Xm1_DUTB hi m1_s1n s0 0 0 vdd vdd m1_DUTB sky130_fd_sc_hd__and3_1
Xm1_REFA hi s1 0 0 vdd vdd m1_REFA sky130_fd_sc_hd__and2_1
Xm1_REFB hi s1 0 0 vdd vdd m1_REFB sky130_fd_sc_hd__and2_1
Xm1_SA0B hi s1 s0 0 0 vdd vdd m1_SA0B sky130_fd_sc_hd__nand3_1
Xm1_SA1B hi s1 0 0 vdd vdd m1_SA1B sky130_fd_sc_hd__nand2_1
Xm1_SA2B hi s1 m1_s0n 0 0 vdd vdd m1_SA2B sky130_fd_sc_hd__nand3_1
Xm1_SB0B hi s1 0 0 vdd vdd m1_SB0B sky130_fd_sc_hd__nand2_1
Xm1_SB1B hi s1 0 0 vdd vdd m1_SB1B sky130_fd_sc_hd__nand2_1
Xm1_M m1_ob m1_SB0B m1_SB1B m1_REFB m1_oa m1_SA0B m1_SA1B m1_SA2B m1_REFA vdd 0 m1_VBIAS m1_C1 m1_PREA m1_XA m1_DUTA m1_PREB m1_XB m1_DUTB m1_VB 0 0 m1_GT trap
Bm1_gt m1_GT 0 V=v(m1_VB)+0.000305*v(k)

* --- m2: trap
Xm2_ienn hi 0 0 vdd vdd m2_enn sky130_fd_sc_hd__inv_1
Xm2_is1n s1 0 0 vdd vdd m2_s1n sky130_fd_sc_hd__inv_1
Xm2_is0n s0 0 0 vdd vdd m2_s0n sky130_fd_sc_hd__inv_1
Xm2_PREA pre m2_enn 0 0 vdd vdd m2_PREA sky130_fd_sc_hd__nor2_1
Xm2_PREB pre m2_enn 0 0 vdd vdd m2_PREB sky130_fd_sc_hd__nor2_1
Xm2_VBIAS hi 0 0 vdd vdd m2_VBIAS sky130_fd_sc_hd__buf_2
Xm2_C1 hi 0 0 vdd vdd m2_C1 sky130_fd_sc_hd__buf_2
Xm2_DUTA hi m2_s1n s0 0 0 vdd vdd m2_DUTA sky130_fd_sc_hd__and3_1
Xm2_DUTB hi m2_s1n s0 0 0 vdd vdd m2_DUTB sky130_fd_sc_hd__and3_1
Xm2_REFA hi s1 0 0 vdd vdd m2_REFA sky130_fd_sc_hd__and2_1
Xm2_REFB hi s1 0 0 vdd vdd m2_REFB sky130_fd_sc_hd__and2_1
Xm2_SA0B hi s1 s0 0 0 vdd vdd m2_SA0B sky130_fd_sc_hd__nand3_1
Xm2_SA1B hi s1 0 0 vdd vdd m2_SA1B sky130_fd_sc_hd__nand2_1
Xm2_SA2B hi s1 m2_s0n 0 0 vdd vdd m2_SA2B sky130_fd_sc_hd__nand3_1
Xm2_SB0B hi s1 0 0 vdd vdd m2_SB0B sky130_fd_sc_hd__nand2_1
Xm2_SB1B hi s1 0 0 vdd vdd m2_SB1B sky130_fd_sc_hd__nand2_1
Xm2_M m2_ob m2_SB0B m2_SB1B m2_REFB m2_oa m2_SA0B m2_SA1B m2_SA2B m2_REFA vdd 0 m2_VBIAS m2_C1 m2_PREA m2_XA m2_DUTA m2_PREB m2_XB m2_DUTB m2_VB 0 0 m2_GT trap
Bm2_gt m2_GT 0 V=v(m2_VB)+0.000305*v(k)

* --- m3: trap
Xm3_ienn hi 0 0 vdd vdd m3_enn sky130_fd_sc_hd__inv_1
Xm3_is1n s1 0 0 vdd vdd m3_s1n sky130_fd_sc_hd__inv_1
Xm3_is0n s0 0 0 vdd vdd m3_s0n sky130_fd_sc_hd__inv_1
Xm3_PREA pre m3_enn 0 0 vdd vdd m3_PREA sky130_fd_sc_hd__nor2_1
Xm3_PREB pre m3_enn 0 0 vdd vdd m3_PREB sky130_fd_sc_hd__nor2_1
Xm3_VBIAS hi 0 0 vdd vdd m3_VBIAS sky130_fd_sc_hd__buf_2
Xm3_C1 hi 0 0 vdd vdd m3_C1 sky130_fd_sc_hd__buf_2
Xm3_DUTA hi m3_s1n s0 0 0 vdd vdd m3_DUTA sky130_fd_sc_hd__and3_1
Xm3_DUTB hi m3_s1n s0 0 0 vdd vdd m3_DUTB sky130_fd_sc_hd__and3_1
Xm3_REFA hi s1 0 0 vdd vdd m3_REFA sky130_fd_sc_hd__and2_1
Xm3_REFB hi s1 0 0 vdd vdd m3_REFB sky130_fd_sc_hd__and2_1
Xm3_SA0B hi s1 s0 0 0 vdd vdd m3_SA0B sky130_fd_sc_hd__nand3_1
Xm3_SA1B hi s1 0 0 vdd vdd m3_SA1B sky130_fd_sc_hd__nand2_1
Xm3_SA2B hi s1 m3_s0n 0 0 vdd vdd m3_SA2B sky130_fd_sc_hd__nand3_1
Xm3_SB0B hi s1 0 0 vdd vdd m3_SB0B sky130_fd_sc_hd__nand2_1
Xm3_SB1B hi s1 0 0 vdd vdd m3_SB1B sky130_fd_sc_hd__nand2_1
Xm3_M m3_ob m3_SB0B m3_SB1B m3_REFB m3_oa m3_SA0B m3_SA1B m3_SA2B m3_REFA vdd 0 m3_VBIAS m3_C1 m3_PREA m3_XA m3_DUTA m3_PREB m3_XB m3_DUTB m3_VB 0 0 m3_GT trap
Bm3_gt m3_GT 0 V=v(m3_VB)+0.000305*v(k)

* --- m4: trap
Xm4_ienn hi 0 0 vdd vdd m4_enn sky130_fd_sc_hd__inv_1
Xm4_is1n s1 0 0 vdd vdd m4_s1n sky130_fd_sc_hd__inv_1
Xm4_is0n s0 0 0 vdd vdd m4_s0n sky130_fd_sc_hd__inv_1
Xm4_PREA pre m4_enn 0 0 vdd vdd m4_PREA sky130_fd_sc_hd__nor2_1
Xm4_PREB pre m4_enn 0 0 vdd vdd m4_PREB sky130_fd_sc_hd__nor2_1
Xm4_VBIAS hi 0 0 vdd vdd m4_VBIAS sky130_fd_sc_hd__buf_2
Xm4_C1 hi 0 0 vdd vdd m4_C1 sky130_fd_sc_hd__buf_2
Xm4_DUTA hi m4_s1n s0 0 0 vdd vdd m4_DUTA sky130_fd_sc_hd__and3_1
Xm4_DUTB hi m4_s1n s0 0 0 vdd vdd m4_DUTB sky130_fd_sc_hd__and3_1
Xm4_REFA hi s1 0 0 vdd vdd m4_REFA sky130_fd_sc_hd__and2_1
Xm4_REFB hi s1 0 0 vdd vdd m4_REFB sky130_fd_sc_hd__and2_1
Xm4_SA0B hi s1 s0 0 0 vdd vdd m4_SA0B sky130_fd_sc_hd__nand3_1
Xm4_SA1B hi s1 0 0 vdd vdd m4_SA1B sky130_fd_sc_hd__nand2_1
Xm4_SA2B hi s1 m4_s0n 0 0 vdd vdd m4_SA2B sky130_fd_sc_hd__nand3_1
Xm4_SB0B hi s1 0 0 vdd vdd m4_SB0B sky130_fd_sc_hd__nand2_1
Xm4_SB1B hi s1 0 0 vdd vdd m4_SB1B sky130_fd_sc_hd__nand2_1
Xm4_M m4_ob m4_SB0B m4_SB1B m4_REFB m4_oa m4_SA0B m4_SA1B m4_SA2B m4_REFA vdd 0 m4_VBIAS m4_C1 m4_PREA m4_XA m4_DUTA m4_PREB m4_XB m4_DUTB m4_VB 0 0 m4_GT trap
Bm4_gt m4_GT 0 V=v(m4_VB)+0.000305*v(k)

* --- m5: trap
Xm5_ienn hi 0 0 vdd vdd m5_enn sky130_fd_sc_hd__inv_1
Xm5_is1n s1 0 0 vdd vdd m5_s1n sky130_fd_sc_hd__inv_1
Xm5_is0n s0 0 0 vdd vdd m5_s0n sky130_fd_sc_hd__inv_1
Xm5_PREA pre m5_enn 0 0 vdd vdd m5_PREA sky130_fd_sc_hd__nor2_1
Xm5_PREB pre m5_enn 0 0 vdd vdd m5_PREB sky130_fd_sc_hd__nor2_1
Xm5_VBIAS hi 0 0 vdd vdd m5_VBIAS sky130_fd_sc_hd__buf_2
Xm5_C1 hi 0 0 vdd vdd m5_C1 sky130_fd_sc_hd__buf_2
Xm5_DUTA hi m5_s1n s0 0 0 vdd vdd m5_DUTA sky130_fd_sc_hd__and3_1
Xm5_DUTB hi m5_s1n s0 0 0 vdd vdd m5_DUTB sky130_fd_sc_hd__and3_1
Xm5_REFA hi s1 0 0 vdd vdd m5_REFA sky130_fd_sc_hd__and2_1
Xm5_REFB hi s1 0 0 vdd vdd m5_REFB sky130_fd_sc_hd__and2_1
Xm5_SA0B hi s1 s0 0 0 vdd vdd m5_SA0B sky130_fd_sc_hd__nand3_1
Xm5_SA1B hi s1 0 0 vdd vdd m5_SA1B sky130_fd_sc_hd__nand2_1
Xm5_SA2B hi s1 m5_s0n 0 0 vdd vdd m5_SA2B sky130_fd_sc_hd__nand3_1
Xm5_SB0B hi s1 0 0 vdd vdd m5_SB0B sky130_fd_sc_hd__nand2_1
Xm5_SB1B hi s1 0 0 vdd vdd m5_SB1B sky130_fd_sc_hd__nand2_1
Xm5_M m5_ob m5_SB0B m5_SB1B m5_REFB m5_oa m5_SA0B m5_SA1B m5_SA2B m5_REFA vdd 0 m5_VBIAS m5_C1 m5_PREA m5_XA m5_DUTA m5_PREB m5_XB m5_DUTB m5_VB 0 0 m5_GT trap
Bm5_gt m5_GT 0 V=v(m5_VB)+0.000305*v(k)

.control
set noaskquit
set rndseed=2101
save v(m0_oa) v(m0_ob) v(m1_oa) v(m1_ob) v(m2_oa) v(m2_ob) v(m3_oa) v(m3_ob) v(m4_oa) v(m4_ob) v(m5_oa) v(m5_ob)
let i = 0
while i < 2
  reset
  alter Vs1 dc = 0
  alter Vs0 dc = 1.8
  alter Vk dc = 0
  tran 10n 200u 0 50n
  meas tran ta0 when v(m0_oa)=0.9 rise=1
  meas tran tb0 when v(m0_ob)=0.9 rise=1
  echo MC $&i e01 0 $&ta0 $&tb0
  meas tran ta1 when v(m1_oa)=0.9 rise=1
  meas tran tb1 when v(m1_ob)=0.9 rise=1
  echo MC $&i e01 1 $&ta1 $&tb1
  meas tran ta2 when v(m2_oa)=0.9 rise=1
  meas tran tb2 when v(m2_ob)=0.9 rise=1
  echo MC $&i e01 2 $&ta2 $&tb2
  meas tran ta3 when v(m3_oa)=0.9 rise=1
  meas tran tb3 when v(m3_ob)=0.9 rise=1
  echo MC $&i e01 3 $&ta3 $&tb3
  meas tran ta4 when v(m4_oa)=0.9 rise=1
  meas tran tb4 when v(m4_ob)=0.9 rise=1
  echo MC $&i e01 4 $&ta4 $&tb4
  meas tran ta5 when v(m5_oa)=0.9 rise=1
  meas tran tb5 when v(m5_ob)=0.9 rise=1
  echo MC $&i e01 5 $&ta5 $&tb5
  alter Vs1 dc = 0
  alter Vs0 dc = 1.8
  alter Vk dc = 1
  tran 10n 200u 0 50n
  meas tran ta0 when v(m0_oa)=0.9 rise=1
  meas tran tb0 when v(m0_ob)=0.9 rise=1
  echo MC $&i e01t 0 $&ta0 $&tb0
  meas tran ta1 when v(m1_oa)=0.9 rise=1
  meas tran tb1 when v(m1_ob)=0.9 rise=1
  echo MC $&i e01t 1 $&ta1 $&tb1
  meas tran ta2 when v(m2_oa)=0.9 rise=1
  meas tran tb2 when v(m2_ob)=0.9 rise=1
  echo MC $&i e01t 2 $&ta2 $&tb2
  meas tran ta3 when v(m3_oa)=0.9 rise=1
  meas tran tb3 when v(m3_ob)=0.9 rise=1
  echo MC $&i e01t 3 $&ta3 $&tb3
  meas tran ta4 when v(m4_oa)=0.9 rise=1
  meas tran tb4 when v(m4_ob)=0.9 rise=1
  echo MC $&i e01t 4 $&ta4 $&tb4
  meas tran ta5 when v(m5_oa)=0.9 rise=1
  meas tran tb5 when v(m5_ob)=0.9 rise=1
  echo MC $&i e01t 5 $&ta5 $&tb5
  alter Vs1 dc = 1.8
  alter Vs0 dc = 1.8
  alter Vk dc = 0
  tran 10n 200u 0 50n
  meas tran ta0 when v(m0_oa)=0.9 rise=1
  meas tran tb0 when v(m0_ob)=0.9 rise=1
  echo MC $&i e11 0 $&ta0 $&tb0
  meas tran ta1 when v(m1_oa)=0.9 rise=1
  meas tran tb1 when v(m1_ob)=0.9 rise=1
  echo MC $&i e11 1 $&ta1 $&tb1
  meas tran ta2 when v(m2_oa)=0.9 rise=1
  meas tran tb2 when v(m2_ob)=0.9 rise=1
  echo MC $&i e11 2 $&ta2 $&tb2
  meas tran ta3 when v(m3_oa)=0.9 rise=1
  meas tran tb3 when v(m3_ob)=0.9 rise=1
  echo MC $&i e11 3 $&ta3 $&tb3
  meas tran ta4 when v(m4_oa)=0.9 rise=1
  meas tran tb4 when v(m4_ob)=0.9 rise=1
  echo MC $&i e11 4 $&ta4 $&tb4
  meas tran ta5 when v(m5_oa)=0.9 rise=1
  meas tran tb5 when v(m5_ob)=0.9 rise=1
  echo MC $&i e11 5 $&ta5 $&tb5
  alter Vs1 dc = 1.8
  alter Vs0 dc = 0
  alter Vk dc = 0
  tran 10n 200u 0 50n
  meas tran ta0 when v(m0_oa)=0.9 rise=1
  meas tran tb0 when v(m0_ob)=0.9 rise=1
  echo MC $&i e10 0 $&ta0 $&tb0
  meas tran ta1 when v(m1_oa)=0.9 rise=1
  meas tran tb1 when v(m1_ob)=0.9 rise=1
  echo MC $&i e10 1 $&ta1 $&tb1
  meas tran ta2 when v(m2_oa)=0.9 rise=1
  meas tran tb2 when v(m2_ob)=0.9 rise=1
  echo MC $&i e10 2 $&ta2 $&tb2
  meas tran ta3 when v(m3_oa)=0.9 rise=1
  meas tran tb3 when v(m3_ob)=0.9 rise=1
  echo MC $&i e10 3 $&ta3 $&tb3
  meas tran ta4 when v(m4_oa)=0.9 rise=1
  meas tran tb4 when v(m4_ob)=0.9 rise=1
  echo MC $&i e10 4 $&ta4 $&tb4
  meas tran ta5 when v(m5_oa)=0.9 rise=1
  meas tran tb5 when v(m5_ob)=0.9 rise=1
  echo MC $&i e10 5 $&ta5 $&tb5
  let i = i + 1
end
quit
.endc
.end
