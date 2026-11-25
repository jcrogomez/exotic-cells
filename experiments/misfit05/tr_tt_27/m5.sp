* MISFIT-03 etapa a · MISFIT-05 transitorio · esquina tt 27 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
.subckt core XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
X40 XA VB a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
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
* --- n1: core
Xn1_ienn hi 0 0 vdd vdd n1_enn sky130_fd_sc_hd__inv_1
Xn1_is1n 0 0 0 vdd vdd n1_s1n sky130_fd_sc_hd__inv_1
Xn1_is0n hi 0 0 vdd vdd n1_s0n sky130_fd_sc_hd__inv_1
Xn1_PREA pre n1_enn 0 0 vdd vdd n1_PREA sky130_fd_sc_hd__nor2_1
Xn1_PREB pre n1_enn 0 0 vdd vdd n1_PREB sky130_fd_sc_hd__nor2_1
Xn1_VBIAS hi 0 0 vdd vdd n1_VBIAS sky130_fd_sc_hd__buf_2
Xn1_C1 hi 0 0 vdd vdd n1_C1 sky130_fd_sc_hd__buf_2
Xn1_DUTA hi n1_s1n hi 0 0 vdd vdd n1_DUTA sky130_fd_sc_hd__and3_1
Xn1_DUTB hi n1_s1n hi 0 0 vdd vdd n1_DUTB sky130_fd_sc_hd__and3_1
Xn1_REFA hi 0 0 0 vdd vdd n1_REFA sky130_fd_sc_hd__and2_1
Xn1_REFB hi 0 0 0 vdd vdd n1_REFB sky130_fd_sc_hd__and2_1
Xn1_SA0B hi 0 hi 0 0 vdd vdd n1_SA0B sky130_fd_sc_hd__nand3_1
Xn1_SA1B hi 0 0 0 vdd vdd n1_SA1B sky130_fd_sc_hd__nand2_1
Xn1_SA2B hi 0 n1_s0n 0 0 vdd vdd n1_SA2B sky130_fd_sc_hd__nand3_1
Xn1_SB0B hi 0 0 0 vdd vdd n1_SB0B sky130_fd_sc_hd__nand2_1
Xn1_SB1B hi 0 0 0 vdd vdd n1_SB1B sky130_fd_sc_hd__nand2_1
Xn1_M n1_ob n1_SB0B n1_SB1B n1_REFB n1_oa n1_SA0B n1_SA1B n1_SA2B n1_REFA vdd 0 n1_VBIAS n1_C1 n1_PREA n1_XA n1_DUTA n1_PREB n1_XB n1_DUTB n1_VB 0 0 core


* --- n2: core
Xn2_ienn hi 0 0 vdd vdd n2_enn sky130_fd_sc_hd__inv_1
Xn2_is1n 0 0 0 vdd vdd n2_s1n sky130_fd_sc_hd__inv_1
Xn2_is0n hi 0 0 vdd vdd n2_s0n sky130_fd_sc_hd__inv_1
Xn2_PREA pre n2_enn 0 0 vdd vdd n2_PREA sky130_fd_sc_hd__nor2_1
Xn2_PREB pre n2_enn 0 0 vdd vdd n2_PREB sky130_fd_sc_hd__nor2_1
Xn2_VBIAS hi 0 0 vdd vdd n2_VBIAS sky130_fd_sc_hd__buf_2
Xn2_C1 hi 0 0 vdd vdd n2_C1 sky130_fd_sc_hd__buf_2
Xn2_DUTA hi n2_s1n hi 0 0 vdd vdd n2_DUTA sky130_fd_sc_hd__and3_1
Xn2_DUTB hi n2_s1n hi 0 0 vdd vdd n2_DUTB sky130_fd_sc_hd__and3_1
Xn2_REFA hi 0 0 0 vdd vdd n2_REFA sky130_fd_sc_hd__and2_1
Xn2_REFB hi 0 0 0 vdd vdd n2_REFB sky130_fd_sc_hd__and2_1
Xn2_SA0B hi 0 hi 0 0 vdd vdd n2_SA0B sky130_fd_sc_hd__nand3_1
Xn2_SA1B hi 0 0 0 vdd vdd n2_SA1B sky130_fd_sc_hd__nand2_1
Xn2_SA2B hi 0 n2_s0n 0 0 vdd vdd n2_SA2B sky130_fd_sc_hd__nand3_1
Xn2_SB0B hi 0 0 0 vdd vdd n2_SB0B sky130_fd_sc_hd__nand2_1
Xn2_SB1B hi 0 0 0 vdd vdd n2_SB1B sky130_fd_sc_hd__nand2_1
Xn2_M n2_ob n2_SB0B n2_SB1B n2_REFB n2_oa n2_SA0B n2_SA1B n2_SA2B n2_REFA vdd 0 n2_VBIAS n2_C1 n2_PREA n2_XA n2_DUTA n2_PREB n2_XB n2_DUTB n2_VB 0 0 core
Xn2edA0 n2_XA n2_VB n2_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn2esA0 0 0 n2_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn2eA0_0 n2_mA0 n2_VB 0.07228f
Cn2eA0_1 n2_mA0 0 0.00298f
Cn2eA0_2 n2_mA0 vdd 0.00496f
Cn2eA0_3 n2_mA0 n2_XA 0.05981f
Cn2eA0_4 n2_mA0 0 0.19922f
Xn2edB0 n2_XB n2_VB n2_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn2esB0 0 0 n2_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn2eB0_0 n2_mB0 vdd 0.00496f
Cn2eB0_1 n2_mB0 0 0.00298f
Cn2eB0_2 n2_mB0 n2_XB 0.05778f
Cn2eB0_3 n2_mB0 n2_VB 0.0654f
Cn2eB0_4 n2_mB0 0 0.20468f

* --- n4: core
Xn4_ienn hi 0 0 vdd vdd n4_enn sky130_fd_sc_hd__inv_1
Xn4_is1n 0 0 0 vdd vdd n4_s1n sky130_fd_sc_hd__inv_1
Xn4_is0n hi 0 0 vdd vdd n4_s0n sky130_fd_sc_hd__inv_1
Xn4_PREA pre n4_enn 0 0 vdd vdd n4_PREA sky130_fd_sc_hd__nor2_1
Xn4_PREB pre n4_enn 0 0 vdd vdd n4_PREB sky130_fd_sc_hd__nor2_1
Xn4_VBIAS hi 0 0 vdd vdd n4_VBIAS sky130_fd_sc_hd__buf_2
Xn4_C1 hi 0 0 vdd vdd n4_C1 sky130_fd_sc_hd__buf_2
Xn4_DUTA hi n4_s1n hi 0 0 vdd vdd n4_DUTA sky130_fd_sc_hd__and3_1
Xn4_DUTB hi n4_s1n hi 0 0 vdd vdd n4_DUTB sky130_fd_sc_hd__and3_1
Xn4_REFA hi 0 0 0 vdd vdd n4_REFA sky130_fd_sc_hd__and2_1
Xn4_REFB hi 0 0 0 vdd vdd n4_REFB sky130_fd_sc_hd__and2_1
Xn4_SA0B hi 0 hi 0 0 vdd vdd n4_SA0B sky130_fd_sc_hd__nand3_1
Xn4_SA1B hi 0 0 0 vdd vdd n4_SA1B sky130_fd_sc_hd__nand2_1
Xn4_SA2B hi 0 n4_s0n 0 0 vdd vdd n4_SA2B sky130_fd_sc_hd__nand3_1
Xn4_SB0B hi 0 0 0 vdd vdd n4_SB0B sky130_fd_sc_hd__nand2_1
Xn4_SB1B hi 0 0 0 vdd vdd n4_SB1B sky130_fd_sc_hd__nand2_1
Xn4_M n4_ob n4_SB0B n4_SB1B n4_REFB n4_oa n4_SA0B n4_SA1B n4_SA2B n4_REFA vdd 0 n4_VBIAS n4_C1 n4_PREA n4_XA n4_DUTA n4_PREB n4_XB n4_DUTB n4_VB 0 0 core
Xn4edA0 n4_XA n4_VB n4_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn4esA0 0 0 n4_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn4eA0_0 n4_mA0 n4_VB 0.07228f
Cn4eA0_1 n4_mA0 0 0.00298f
Cn4eA0_2 n4_mA0 vdd 0.00496f
Cn4eA0_3 n4_mA0 n4_XA 0.05981f
Cn4eA0_4 n4_mA0 0 0.19922f
Xn4edA1 n4_XA n4_VB n4_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn4esA1 0 0 n4_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn4eA1_0 n4_mA1 n4_VB 0.07228f
Cn4eA1_1 n4_mA1 0 0.00298f
Cn4eA1_2 n4_mA1 vdd 0.00496f
Cn4eA1_3 n4_mA1 n4_XA 0.05981f
Cn4eA1_4 n4_mA1 0 0.19922f
Xn4edA2 n4_XA n4_VB n4_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn4esA2 0 0 n4_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn4eA2_0 n4_mA2 n4_VB 0.07228f
Cn4eA2_1 n4_mA2 0 0.00298f
Cn4eA2_2 n4_mA2 vdd 0.00496f
Cn4eA2_3 n4_mA2 n4_XA 0.05981f
Cn4eA2_4 n4_mA2 0 0.19922f
Xn4edB0 n4_XB n4_VB n4_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn4esB0 0 0 n4_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn4eB0_0 n4_mB0 vdd 0.00496f
Cn4eB0_1 n4_mB0 0 0.00298f
Cn4eB0_2 n4_mB0 n4_XB 0.05778f
Cn4eB0_3 n4_mB0 n4_VB 0.0654f
Cn4eB0_4 n4_mB0 0 0.20468f
Xn4edB1 n4_XB n4_VB n4_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn4esB1 0 0 n4_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn4eB1_0 n4_mB1 vdd 0.00496f
Cn4eB1_1 n4_mB1 0 0.00298f
Cn4eB1_2 n4_mB1 n4_XB 0.05778f
Cn4eB1_3 n4_mB1 n4_VB 0.0654f
Cn4eB1_4 n4_mB1 0 0.20468f
Xn4edB2 n4_XB n4_VB n4_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn4esB2 0 0 n4_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn4eB2_0 n4_mB2 vdd 0.00496f
Cn4eB2_1 n4_mB2 0 0.00298f
Cn4eB2_2 n4_mB2 n4_XB 0.05778f
Cn4eB2_3 n4_mB2 n4_VB 0.0654f
Cn4eB2_4 n4_mB2 0 0.20468f

* --- n8: core
Xn8_ienn hi 0 0 vdd vdd n8_enn sky130_fd_sc_hd__inv_1
Xn8_is1n 0 0 0 vdd vdd n8_s1n sky130_fd_sc_hd__inv_1
Xn8_is0n hi 0 0 vdd vdd n8_s0n sky130_fd_sc_hd__inv_1
Xn8_PREA pre n8_enn 0 0 vdd vdd n8_PREA sky130_fd_sc_hd__nor2_1
Xn8_PREB pre n8_enn 0 0 vdd vdd n8_PREB sky130_fd_sc_hd__nor2_1
Xn8_VBIAS hi 0 0 vdd vdd n8_VBIAS sky130_fd_sc_hd__buf_2
Xn8_C1 hi 0 0 vdd vdd n8_C1 sky130_fd_sc_hd__buf_2
Xn8_DUTA hi n8_s1n hi 0 0 vdd vdd n8_DUTA sky130_fd_sc_hd__and3_1
Xn8_DUTB hi n8_s1n hi 0 0 vdd vdd n8_DUTB sky130_fd_sc_hd__and3_1
Xn8_REFA hi 0 0 0 vdd vdd n8_REFA sky130_fd_sc_hd__and2_1
Xn8_REFB hi 0 0 0 vdd vdd n8_REFB sky130_fd_sc_hd__and2_1
Xn8_SA0B hi 0 hi 0 0 vdd vdd n8_SA0B sky130_fd_sc_hd__nand3_1
Xn8_SA1B hi 0 0 0 vdd vdd n8_SA1B sky130_fd_sc_hd__nand2_1
Xn8_SA2B hi 0 n8_s0n 0 0 vdd vdd n8_SA2B sky130_fd_sc_hd__nand3_1
Xn8_SB0B hi 0 0 0 vdd vdd n8_SB0B sky130_fd_sc_hd__nand2_1
Xn8_SB1B hi 0 0 0 vdd vdd n8_SB1B sky130_fd_sc_hd__nand2_1
Xn8_M n8_ob n8_SB0B n8_SB1B n8_REFB n8_oa n8_SA0B n8_SA1B n8_SA2B n8_REFA vdd 0 n8_VBIAS n8_C1 n8_PREA n8_XA n8_DUTA n8_PREB n8_XB n8_DUTB n8_VB 0 0 core
Xn8edA0 n8_XA n8_VB n8_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esA0 0 0 n8_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eA0_0 n8_mA0 n8_VB 0.07228f
Cn8eA0_1 n8_mA0 0 0.00298f
Cn8eA0_2 n8_mA0 vdd 0.00496f
Cn8eA0_3 n8_mA0 n8_XA 0.05981f
Cn8eA0_4 n8_mA0 0 0.19922f
Xn8edA1 n8_XA n8_VB n8_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esA1 0 0 n8_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eA1_0 n8_mA1 n8_VB 0.07228f
Cn8eA1_1 n8_mA1 0 0.00298f
Cn8eA1_2 n8_mA1 vdd 0.00496f
Cn8eA1_3 n8_mA1 n8_XA 0.05981f
Cn8eA1_4 n8_mA1 0 0.19922f
Xn8edA2 n8_XA n8_VB n8_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esA2 0 0 n8_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eA2_0 n8_mA2 n8_VB 0.07228f
Cn8eA2_1 n8_mA2 0 0.00298f
Cn8eA2_2 n8_mA2 vdd 0.00496f
Cn8eA2_3 n8_mA2 n8_XA 0.05981f
Cn8eA2_4 n8_mA2 0 0.19922f
Xn8edA3 n8_XA n8_VB n8_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esA3 0 0 n8_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eA3_0 n8_mA3 n8_VB 0.07228f
Cn8eA3_1 n8_mA3 0 0.00298f
Cn8eA3_2 n8_mA3 vdd 0.00496f
Cn8eA3_3 n8_mA3 n8_XA 0.05981f
Cn8eA3_4 n8_mA3 0 0.19922f
Xn8edA4 n8_XA n8_VB n8_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esA4 0 0 n8_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eA4_0 n8_mA4 n8_VB 0.07228f
Cn8eA4_1 n8_mA4 0 0.00298f
Cn8eA4_2 n8_mA4 vdd 0.00496f
Cn8eA4_3 n8_mA4 n8_XA 0.05981f
Cn8eA4_4 n8_mA4 0 0.19922f
Xn8edA5 n8_XA n8_VB n8_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esA5 0 0 n8_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eA5_0 n8_mA5 n8_VB 0.07228f
Cn8eA5_1 n8_mA5 0 0.00298f
Cn8eA5_2 n8_mA5 vdd 0.00496f
Cn8eA5_3 n8_mA5 n8_XA 0.05981f
Cn8eA5_4 n8_mA5 0 0.19922f
Xn8edA6 n8_XA n8_VB n8_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esA6 0 0 n8_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eA6_0 n8_mA6 n8_VB 0.07228f
Cn8eA6_1 n8_mA6 0 0.00298f
Cn8eA6_2 n8_mA6 vdd 0.00496f
Cn8eA6_3 n8_mA6 n8_XA 0.05981f
Cn8eA6_4 n8_mA6 0 0.19922f
Xn8edB0 n8_XB n8_VB n8_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esB0 0 0 n8_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eB0_0 n8_mB0 vdd 0.00496f
Cn8eB0_1 n8_mB0 0 0.00298f
Cn8eB0_2 n8_mB0 n8_XB 0.05778f
Cn8eB0_3 n8_mB0 n8_VB 0.0654f
Cn8eB0_4 n8_mB0 0 0.20468f
Xn8edB1 n8_XB n8_VB n8_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esB1 0 0 n8_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eB1_0 n8_mB1 vdd 0.00496f
Cn8eB1_1 n8_mB1 0 0.00298f
Cn8eB1_2 n8_mB1 n8_XB 0.05778f
Cn8eB1_3 n8_mB1 n8_VB 0.0654f
Cn8eB1_4 n8_mB1 0 0.20468f
Xn8edB2 n8_XB n8_VB n8_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esB2 0 0 n8_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eB2_0 n8_mB2 vdd 0.00496f
Cn8eB2_1 n8_mB2 0 0.00298f
Cn8eB2_2 n8_mB2 n8_XB 0.05778f
Cn8eB2_3 n8_mB2 n8_VB 0.0654f
Cn8eB2_4 n8_mB2 0 0.20468f
Xn8edB3 n8_XB n8_VB n8_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esB3 0 0 n8_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eB3_0 n8_mB3 vdd 0.00496f
Cn8eB3_1 n8_mB3 0 0.00298f
Cn8eB3_2 n8_mB3 n8_XB 0.05778f
Cn8eB3_3 n8_mB3 n8_VB 0.0654f
Cn8eB3_4 n8_mB3 0 0.20468f
Xn8edB4 n8_XB n8_VB n8_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esB4 0 0 n8_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eB4_0 n8_mB4 vdd 0.00496f
Cn8eB4_1 n8_mB4 0 0.00298f
Cn8eB4_2 n8_mB4 n8_XB 0.05778f
Cn8eB4_3 n8_mB4 n8_VB 0.0654f
Cn8eB4_4 n8_mB4 0 0.20468f
Xn8edB5 n8_XB n8_VB n8_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esB5 0 0 n8_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eB5_0 n8_mB5 vdd 0.00496f
Cn8eB5_1 n8_mB5 0 0.00298f
Cn8eB5_2 n8_mB5 n8_XB 0.05778f
Cn8eB5_3 n8_mB5 n8_VB 0.0654f
Cn8eB5_4 n8_mB5 0 0.20468f
Xn8edB6 n8_XB n8_VB n8_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn8esB6 0 0 n8_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn8eB6_0 n8_mB6 vdd 0.00496f
Cn8eB6_1 n8_mB6 0 0.00298f
Cn8eB6_2 n8_mB6 n8_XB 0.05778f
Cn8eB6_3 n8_mB6 n8_VB 0.0654f
Cn8eB6_4 n8_mB6 0 0.20468f

* --- n16: core
Xn16_ienn hi 0 0 vdd vdd n16_enn sky130_fd_sc_hd__inv_1
Xn16_is1n 0 0 0 vdd vdd n16_s1n sky130_fd_sc_hd__inv_1
Xn16_is0n hi 0 0 vdd vdd n16_s0n sky130_fd_sc_hd__inv_1
Xn16_PREA pre n16_enn 0 0 vdd vdd n16_PREA sky130_fd_sc_hd__nor2_1
Xn16_PREB pre n16_enn 0 0 vdd vdd n16_PREB sky130_fd_sc_hd__nor2_1
Xn16_VBIAS hi 0 0 vdd vdd n16_VBIAS sky130_fd_sc_hd__buf_2
Xn16_C1 hi 0 0 vdd vdd n16_C1 sky130_fd_sc_hd__buf_2
Xn16_DUTA hi n16_s1n hi 0 0 vdd vdd n16_DUTA sky130_fd_sc_hd__and3_1
Xn16_DUTB hi n16_s1n hi 0 0 vdd vdd n16_DUTB sky130_fd_sc_hd__and3_1
Xn16_REFA hi 0 0 0 vdd vdd n16_REFA sky130_fd_sc_hd__and2_1
Xn16_REFB hi 0 0 0 vdd vdd n16_REFB sky130_fd_sc_hd__and2_1
Xn16_SA0B hi 0 hi 0 0 vdd vdd n16_SA0B sky130_fd_sc_hd__nand3_1
Xn16_SA1B hi 0 0 0 vdd vdd n16_SA1B sky130_fd_sc_hd__nand2_1
Xn16_SA2B hi 0 n16_s0n 0 0 vdd vdd n16_SA2B sky130_fd_sc_hd__nand3_1
Xn16_SB0B hi 0 0 0 vdd vdd n16_SB0B sky130_fd_sc_hd__nand2_1
Xn16_SB1B hi 0 0 0 vdd vdd n16_SB1B sky130_fd_sc_hd__nand2_1
Xn16_M n16_ob n16_SB0B n16_SB1B n16_REFB n16_oa n16_SA0B n16_SA1B n16_SA2B n16_REFA vdd 0 n16_VBIAS n16_C1 n16_PREA n16_XA n16_DUTA n16_PREB n16_XB n16_DUTB n16_VB 0 0 core
Xn16edA0 n16_XA n16_VB n16_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA0 0 0 n16_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA0_0 n16_mA0 n16_VB 0.07228f
Cn16eA0_1 n16_mA0 0 0.00298f
Cn16eA0_2 n16_mA0 vdd 0.00496f
Cn16eA0_3 n16_mA0 n16_XA 0.05981f
Cn16eA0_4 n16_mA0 0 0.19922f
Xn16edA1 n16_XA n16_VB n16_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA1 0 0 n16_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA1_0 n16_mA1 n16_VB 0.07228f
Cn16eA1_1 n16_mA1 0 0.00298f
Cn16eA1_2 n16_mA1 vdd 0.00496f
Cn16eA1_3 n16_mA1 n16_XA 0.05981f
Cn16eA1_4 n16_mA1 0 0.19922f
Xn16edA2 n16_XA n16_VB n16_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA2 0 0 n16_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA2_0 n16_mA2 n16_VB 0.07228f
Cn16eA2_1 n16_mA2 0 0.00298f
Cn16eA2_2 n16_mA2 vdd 0.00496f
Cn16eA2_3 n16_mA2 n16_XA 0.05981f
Cn16eA2_4 n16_mA2 0 0.19922f
Xn16edA3 n16_XA n16_VB n16_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA3 0 0 n16_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA3_0 n16_mA3 n16_VB 0.07228f
Cn16eA3_1 n16_mA3 0 0.00298f
Cn16eA3_2 n16_mA3 vdd 0.00496f
Cn16eA3_3 n16_mA3 n16_XA 0.05981f
Cn16eA3_4 n16_mA3 0 0.19922f
Xn16edA4 n16_XA n16_VB n16_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA4 0 0 n16_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA4_0 n16_mA4 n16_VB 0.07228f
Cn16eA4_1 n16_mA4 0 0.00298f
Cn16eA4_2 n16_mA4 vdd 0.00496f
Cn16eA4_3 n16_mA4 n16_XA 0.05981f
Cn16eA4_4 n16_mA4 0 0.19922f
Xn16edA5 n16_XA n16_VB n16_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA5 0 0 n16_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA5_0 n16_mA5 n16_VB 0.07228f
Cn16eA5_1 n16_mA5 0 0.00298f
Cn16eA5_2 n16_mA5 vdd 0.00496f
Cn16eA5_3 n16_mA5 n16_XA 0.05981f
Cn16eA5_4 n16_mA5 0 0.19922f
Xn16edA6 n16_XA n16_VB n16_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA6 0 0 n16_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA6_0 n16_mA6 n16_VB 0.07228f
Cn16eA6_1 n16_mA6 0 0.00298f
Cn16eA6_2 n16_mA6 vdd 0.00496f
Cn16eA6_3 n16_mA6 n16_XA 0.05981f
Cn16eA6_4 n16_mA6 0 0.19922f
Xn16edA7 n16_XA n16_VB n16_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA7 0 0 n16_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA7_0 n16_mA7 n16_VB 0.07228f
Cn16eA7_1 n16_mA7 0 0.00298f
Cn16eA7_2 n16_mA7 vdd 0.00496f
Cn16eA7_3 n16_mA7 n16_XA 0.05981f
Cn16eA7_4 n16_mA7 0 0.19922f
Xn16edA8 n16_XA n16_VB n16_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA8 0 0 n16_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA8_0 n16_mA8 n16_VB 0.07228f
Cn16eA8_1 n16_mA8 0 0.00298f
Cn16eA8_2 n16_mA8 vdd 0.00496f
Cn16eA8_3 n16_mA8 n16_XA 0.05981f
Cn16eA8_4 n16_mA8 0 0.19922f
Xn16edA9 n16_XA n16_VB n16_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA9 0 0 n16_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA9_0 n16_mA9 n16_VB 0.07228f
Cn16eA9_1 n16_mA9 0 0.00298f
Cn16eA9_2 n16_mA9 vdd 0.00496f
Cn16eA9_3 n16_mA9 n16_XA 0.05981f
Cn16eA9_4 n16_mA9 0 0.19922f
Xn16edA10 n16_XA n16_VB n16_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA10 0 0 n16_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA10_0 n16_mA10 n16_VB 0.07228f
Cn16eA10_1 n16_mA10 0 0.00298f
Cn16eA10_2 n16_mA10 vdd 0.00496f
Cn16eA10_3 n16_mA10 n16_XA 0.05981f
Cn16eA10_4 n16_mA10 0 0.19922f
Xn16edA11 n16_XA n16_VB n16_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA11 0 0 n16_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA11_0 n16_mA11 n16_VB 0.07228f
Cn16eA11_1 n16_mA11 0 0.00298f
Cn16eA11_2 n16_mA11 vdd 0.00496f
Cn16eA11_3 n16_mA11 n16_XA 0.05981f
Cn16eA11_4 n16_mA11 0 0.19922f
Xn16edA12 n16_XA n16_VB n16_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA12 0 0 n16_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA12_0 n16_mA12 n16_VB 0.07228f
Cn16eA12_1 n16_mA12 0 0.00298f
Cn16eA12_2 n16_mA12 vdd 0.00496f
Cn16eA12_3 n16_mA12 n16_XA 0.05981f
Cn16eA12_4 n16_mA12 0 0.19922f
Xn16edA13 n16_XA n16_VB n16_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA13 0 0 n16_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA13_0 n16_mA13 n16_VB 0.07228f
Cn16eA13_1 n16_mA13 0 0.00298f
Cn16eA13_2 n16_mA13 vdd 0.00496f
Cn16eA13_3 n16_mA13 n16_XA 0.05981f
Cn16eA13_4 n16_mA13 0 0.19922f
Xn16edA14 n16_XA n16_VB n16_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esA14 0 0 n16_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eA14_0 n16_mA14 n16_VB 0.07228f
Cn16eA14_1 n16_mA14 0 0.00298f
Cn16eA14_2 n16_mA14 vdd 0.00496f
Cn16eA14_3 n16_mA14 n16_XA 0.05981f
Cn16eA14_4 n16_mA14 0 0.19922f
Xn16edB0 n16_XB n16_VB n16_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB0 0 0 n16_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB0_0 n16_mB0 vdd 0.00496f
Cn16eB0_1 n16_mB0 0 0.00298f
Cn16eB0_2 n16_mB0 n16_XB 0.05778f
Cn16eB0_3 n16_mB0 n16_VB 0.0654f
Cn16eB0_4 n16_mB0 0 0.20468f
Xn16edB1 n16_XB n16_VB n16_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB1 0 0 n16_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB1_0 n16_mB1 vdd 0.00496f
Cn16eB1_1 n16_mB1 0 0.00298f
Cn16eB1_2 n16_mB1 n16_XB 0.05778f
Cn16eB1_3 n16_mB1 n16_VB 0.0654f
Cn16eB1_4 n16_mB1 0 0.20468f
Xn16edB2 n16_XB n16_VB n16_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB2 0 0 n16_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB2_0 n16_mB2 vdd 0.00496f
Cn16eB2_1 n16_mB2 0 0.00298f
Cn16eB2_2 n16_mB2 n16_XB 0.05778f
Cn16eB2_3 n16_mB2 n16_VB 0.0654f
Cn16eB2_4 n16_mB2 0 0.20468f
Xn16edB3 n16_XB n16_VB n16_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB3 0 0 n16_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB3_0 n16_mB3 vdd 0.00496f
Cn16eB3_1 n16_mB3 0 0.00298f
Cn16eB3_2 n16_mB3 n16_XB 0.05778f
Cn16eB3_3 n16_mB3 n16_VB 0.0654f
Cn16eB3_4 n16_mB3 0 0.20468f
Xn16edB4 n16_XB n16_VB n16_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB4 0 0 n16_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB4_0 n16_mB4 vdd 0.00496f
Cn16eB4_1 n16_mB4 0 0.00298f
Cn16eB4_2 n16_mB4 n16_XB 0.05778f
Cn16eB4_3 n16_mB4 n16_VB 0.0654f
Cn16eB4_4 n16_mB4 0 0.20468f
Xn16edB5 n16_XB n16_VB n16_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB5 0 0 n16_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB5_0 n16_mB5 vdd 0.00496f
Cn16eB5_1 n16_mB5 0 0.00298f
Cn16eB5_2 n16_mB5 n16_XB 0.05778f
Cn16eB5_3 n16_mB5 n16_VB 0.0654f
Cn16eB5_4 n16_mB5 0 0.20468f
Xn16edB6 n16_XB n16_VB n16_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB6 0 0 n16_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB6_0 n16_mB6 vdd 0.00496f
Cn16eB6_1 n16_mB6 0 0.00298f
Cn16eB6_2 n16_mB6 n16_XB 0.05778f
Cn16eB6_3 n16_mB6 n16_VB 0.0654f
Cn16eB6_4 n16_mB6 0 0.20468f
Xn16edB7 n16_XB n16_VB n16_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB7 0 0 n16_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB7_0 n16_mB7 vdd 0.00496f
Cn16eB7_1 n16_mB7 0 0.00298f
Cn16eB7_2 n16_mB7 n16_XB 0.05778f
Cn16eB7_3 n16_mB7 n16_VB 0.0654f
Cn16eB7_4 n16_mB7 0 0.20468f
Xn16edB8 n16_XB n16_VB n16_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB8 0 0 n16_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB8_0 n16_mB8 vdd 0.00496f
Cn16eB8_1 n16_mB8 0 0.00298f
Cn16eB8_2 n16_mB8 n16_XB 0.05778f
Cn16eB8_3 n16_mB8 n16_VB 0.0654f
Cn16eB8_4 n16_mB8 0 0.20468f
Xn16edB9 n16_XB n16_VB n16_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB9 0 0 n16_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB9_0 n16_mB9 vdd 0.00496f
Cn16eB9_1 n16_mB9 0 0.00298f
Cn16eB9_2 n16_mB9 n16_XB 0.05778f
Cn16eB9_3 n16_mB9 n16_VB 0.0654f
Cn16eB9_4 n16_mB9 0 0.20468f
Xn16edB10 n16_XB n16_VB n16_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB10 0 0 n16_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB10_0 n16_mB10 vdd 0.00496f
Cn16eB10_1 n16_mB10 0 0.00298f
Cn16eB10_2 n16_mB10 n16_XB 0.05778f
Cn16eB10_3 n16_mB10 n16_VB 0.0654f
Cn16eB10_4 n16_mB10 0 0.20468f
Xn16edB11 n16_XB n16_VB n16_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB11 0 0 n16_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB11_0 n16_mB11 vdd 0.00496f
Cn16eB11_1 n16_mB11 0 0.00298f
Cn16eB11_2 n16_mB11 n16_XB 0.05778f
Cn16eB11_3 n16_mB11 n16_VB 0.0654f
Cn16eB11_4 n16_mB11 0 0.20468f
Xn16edB12 n16_XB n16_VB n16_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB12 0 0 n16_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB12_0 n16_mB12 vdd 0.00496f
Cn16eB12_1 n16_mB12 0 0.00298f
Cn16eB12_2 n16_mB12 n16_XB 0.05778f
Cn16eB12_3 n16_mB12 n16_VB 0.0654f
Cn16eB12_4 n16_mB12 0 0.20468f
Xn16edB13 n16_XB n16_VB n16_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB13 0 0 n16_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB13_0 n16_mB13 vdd 0.00496f
Cn16eB13_1 n16_mB13 0 0.00298f
Cn16eB13_2 n16_mB13 n16_XB 0.05778f
Cn16eB13_3 n16_mB13 n16_VB 0.0654f
Cn16eB13_4 n16_mB13 0 0.20468f
Xn16edB14 n16_XB n16_VB n16_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn16esB14 0 0 n16_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn16eB14_0 n16_mB14 vdd 0.00496f
Cn16eB14_1 n16_mB14 0 0.00298f
Cn16eB14_2 n16_mB14 n16_XB 0.05778f
Cn16eB14_3 n16_mB14 n16_VB 0.0654f
Cn16eB14_4 n16_mB14 0 0.20468f

* --- t1: trap
Xt1_ienn hi 0 0 vdd vdd t1_enn sky130_fd_sc_hd__inv_1
Xt1_is1n 0 0 0 vdd vdd t1_s1n sky130_fd_sc_hd__inv_1
Xt1_is0n hi 0 0 vdd vdd t1_s0n sky130_fd_sc_hd__inv_1
Xt1_PREA pre t1_enn 0 0 vdd vdd t1_PREA sky130_fd_sc_hd__nor2_1
Xt1_PREB pre t1_enn 0 0 vdd vdd t1_PREB sky130_fd_sc_hd__nor2_1
Xt1_VBIAS hi 0 0 vdd vdd t1_VBIAS sky130_fd_sc_hd__buf_2
Xt1_C1 hi 0 0 vdd vdd t1_C1 sky130_fd_sc_hd__buf_2
Xt1_DUTA hi t1_s1n hi 0 0 vdd vdd t1_DUTA sky130_fd_sc_hd__and3_1
Xt1_DUTB hi t1_s1n hi 0 0 vdd vdd t1_DUTB sky130_fd_sc_hd__and3_1
Xt1_REFA hi 0 0 0 vdd vdd t1_REFA sky130_fd_sc_hd__and2_1
Xt1_REFB hi 0 0 0 vdd vdd t1_REFB sky130_fd_sc_hd__and2_1
Xt1_SA0B hi 0 hi 0 0 vdd vdd t1_SA0B sky130_fd_sc_hd__nand3_1
Xt1_SA1B hi 0 0 0 vdd vdd t1_SA1B sky130_fd_sc_hd__nand2_1
Xt1_SA2B hi 0 t1_s0n 0 0 vdd vdd t1_SA2B sky130_fd_sc_hd__nand3_1
Xt1_SB0B hi 0 0 0 vdd vdd t1_SB0B sky130_fd_sc_hd__nand2_1
Xt1_SB1B hi 0 0 0 vdd vdd t1_SB1B sky130_fd_sc_hd__nand2_1
Xt1_M t1_ob t1_SB0B t1_SB1B t1_REFB t1_oa t1_SA0B t1_SA1B t1_SA2B t1_REFA vdd 0 t1_VBIAS t1_C1 t1_PREA t1_XA t1_DUTA t1_PREB t1_XB t1_DUTB t1_VB 0 0 t1_GT trap
Bt1_gt t1_GT 0 V=v(t1_VB)+0.000305


* --- t16: trap
Xt16_ienn hi 0 0 vdd vdd t16_enn sky130_fd_sc_hd__inv_1
Xt16_is1n 0 0 0 vdd vdd t16_s1n sky130_fd_sc_hd__inv_1
Xt16_is0n hi 0 0 vdd vdd t16_s0n sky130_fd_sc_hd__inv_1
Xt16_PREA pre t16_enn 0 0 vdd vdd t16_PREA sky130_fd_sc_hd__nor2_1
Xt16_PREB pre t16_enn 0 0 vdd vdd t16_PREB sky130_fd_sc_hd__nor2_1
Xt16_VBIAS hi 0 0 vdd vdd t16_VBIAS sky130_fd_sc_hd__buf_2
Xt16_C1 hi 0 0 vdd vdd t16_C1 sky130_fd_sc_hd__buf_2
Xt16_DUTA hi t16_s1n hi 0 0 vdd vdd t16_DUTA sky130_fd_sc_hd__and3_1
Xt16_DUTB hi t16_s1n hi 0 0 vdd vdd t16_DUTB sky130_fd_sc_hd__and3_1
Xt16_REFA hi 0 0 0 vdd vdd t16_REFA sky130_fd_sc_hd__and2_1
Xt16_REFB hi 0 0 0 vdd vdd t16_REFB sky130_fd_sc_hd__and2_1
Xt16_SA0B hi 0 hi 0 0 vdd vdd t16_SA0B sky130_fd_sc_hd__nand3_1
Xt16_SA1B hi 0 0 0 vdd vdd t16_SA1B sky130_fd_sc_hd__nand2_1
Xt16_SA2B hi 0 t16_s0n 0 0 vdd vdd t16_SA2B sky130_fd_sc_hd__nand3_1
Xt16_SB0B hi 0 0 0 vdd vdd t16_SB0B sky130_fd_sc_hd__nand2_1
Xt16_SB1B hi 0 0 0 vdd vdd t16_SB1B sky130_fd_sc_hd__nand2_1
Xt16_M t16_ob t16_SB0B t16_SB1B t16_REFB t16_oa t16_SA0B t16_SA1B t16_SA2B t16_REFA vdd 0 t16_VBIAS t16_C1 t16_PREA t16_XA t16_DUTA t16_PREB t16_XB t16_DUTB t16_VB 0 0 t16_GT trap
Bt16_gt t16_GT 0 V=v(t16_VB)+0.000305
Xt16edA0 t16_XA t16_VB t16_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA0 0 0 t16_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA0_0 t16_mA0 t16_VB 0.07228f
Ct16eA0_1 t16_mA0 0 0.00298f
Ct16eA0_2 t16_mA0 vdd 0.00496f
Ct16eA0_3 t16_mA0 t16_XA 0.05981f
Ct16eA0_4 t16_mA0 0 0.19922f
Xt16edA1 t16_XA t16_VB t16_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA1 0 0 t16_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA1_0 t16_mA1 t16_VB 0.07228f
Ct16eA1_1 t16_mA1 0 0.00298f
Ct16eA1_2 t16_mA1 vdd 0.00496f
Ct16eA1_3 t16_mA1 t16_XA 0.05981f
Ct16eA1_4 t16_mA1 0 0.19922f
Xt16edA2 t16_XA t16_VB t16_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA2 0 0 t16_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA2_0 t16_mA2 t16_VB 0.07228f
Ct16eA2_1 t16_mA2 0 0.00298f
Ct16eA2_2 t16_mA2 vdd 0.00496f
Ct16eA2_3 t16_mA2 t16_XA 0.05981f
Ct16eA2_4 t16_mA2 0 0.19922f
Xt16edA3 t16_XA t16_VB t16_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA3 0 0 t16_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA3_0 t16_mA3 t16_VB 0.07228f
Ct16eA3_1 t16_mA3 0 0.00298f
Ct16eA3_2 t16_mA3 vdd 0.00496f
Ct16eA3_3 t16_mA3 t16_XA 0.05981f
Ct16eA3_4 t16_mA3 0 0.19922f
Xt16edA4 t16_XA t16_VB t16_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA4 0 0 t16_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA4_0 t16_mA4 t16_VB 0.07228f
Ct16eA4_1 t16_mA4 0 0.00298f
Ct16eA4_2 t16_mA4 vdd 0.00496f
Ct16eA4_3 t16_mA4 t16_XA 0.05981f
Ct16eA4_4 t16_mA4 0 0.19922f
Xt16edA5 t16_XA t16_VB t16_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA5 0 0 t16_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA5_0 t16_mA5 t16_VB 0.07228f
Ct16eA5_1 t16_mA5 0 0.00298f
Ct16eA5_2 t16_mA5 vdd 0.00496f
Ct16eA5_3 t16_mA5 t16_XA 0.05981f
Ct16eA5_4 t16_mA5 0 0.19922f
Xt16edA6 t16_XA t16_VB t16_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA6 0 0 t16_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA6_0 t16_mA6 t16_VB 0.07228f
Ct16eA6_1 t16_mA6 0 0.00298f
Ct16eA6_2 t16_mA6 vdd 0.00496f
Ct16eA6_3 t16_mA6 t16_XA 0.05981f
Ct16eA6_4 t16_mA6 0 0.19922f
Xt16edA7 t16_XA t16_VB t16_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA7 0 0 t16_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA7_0 t16_mA7 t16_VB 0.07228f
Ct16eA7_1 t16_mA7 0 0.00298f
Ct16eA7_2 t16_mA7 vdd 0.00496f
Ct16eA7_3 t16_mA7 t16_XA 0.05981f
Ct16eA7_4 t16_mA7 0 0.19922f
Xt16edA8 t16_XA t16_VB t16_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA8 0 0 t16_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA8_0 t16_mA8 t16_VB 0.07228f
Ct16eA8_1 t16_mA8 0 0.00298f
Ct16eA8_2 t16_mA8 vdd 0.00496f
Ct16eA8_3 t16_mA8 t16_XA 0.05981f
Ct16eA8_4 t16_mA8 0 0.19922f
Xt16edA9 t16_XA t16_VB t16_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA9 0 0 t16_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA9_0 t16_mA9 t16_VB 0.07228f
Ct16eA9_1 t16_mA9 0 0.00298f
Ct16eA9_2 t16_mA9 vdd 0.00496f
Ct16eA9_3 t16_mA9 t16_XA 0.05981f
Ct16eA9_4 t16_mA9 0 0.19922f
Xt16edA10 t16_XA t16_VB t16_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA10 0 0 t16_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA10_0 t16_mA10 t16_VB 0.07228f
Ct16eA10_1 t16_mA10 0 0.00298f
Ct16eA10_2 t16_mA10 vdd 0.00496f
Ct16eA10_3 t16_mA10 t16_XA 0.05981f
Ct16eA10_4 t16_mA10 0 0.19922f
Xt16edA11 t16_XA t16_VB t16_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA11 0 0 t16_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA11_0 t16_mA11 t16_VB 0.07228f
Ct16eA11_1 t16_mA11 0 0.00298f
Ct16eA11_2 t16_mA11 vdd 0.00496f
Ct16eA11_3 t16_mA11 t16_XA 0.05981f
Ct16eA11_4 t16_mA11 0 0.19922f
Xt16edA12 t16_XA t16_VB t16_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA12 0 0 t16_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA12_0 t16_mA12 t16_VB 0.07228f
Ct16eA12_1 t16_mA12 0 0.00298f
Ct16eA12_2 t16_mA12 vdd 0.00496f
Ct16eA12_3 t16_mA12 t16_XA 0.05981f
Ct16eA12_4 t16_mA12 0 0.19922f
Xt16edA13 t16_XA t16_VB t16_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA13 0 0 t16_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA13_0 t16_mA13 t16_VB 0.07228f
Ct16eA13_1 t16_mA13 0 0.00298f
Ct16eA13_2 t16_mA13 vdd 0.00496f
Ct16eA13_3 t16_mA13 t16_XA 0.05981f
Ct16eA13_4 t16_mA13 0 0.19922f
Xt16edA14 t16_XA t16_VB t16_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esA14 0 0 t16_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eA14_0 t16_mA14 t16_VB 0.07228f
Ct16eA14_1 t16_mA14 0 0.00298f
Ct16eA14_2 t16_mA14 vdd 0.00496f
Ct16eA14_3 t16_mA14 t16_XA 0.05981f
Ct16eA14_4 t16_mA14 0 0.19922f
Xt16edB0 t16_XB t16_VB t16_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB0 0 0 t16_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB0_0 t16_mB0 vdd 0.00496f
Ct16eB0_1 t16_mB0 0 0.00298f
Ct16eB0_2 t16_mB0 t16_XB 0.05778f
Ct16eB0_3 t16_mB0 t16_VB 0.0654f
Ct16eB0_4 t16_mB0 0 0.20468f
Xt16edB1 t16_XB t16_VB t16_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB1 0 0 t16_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB1_0 t16_mB1 vdd 0.00496f
Ct16eB1_1 t16_mB1 0 0.00298f
Ct16eB1_2 t16_mB1 t16_XB 0.05778f
Ct16eB1_3 t16_mB1 t16_VB 0.0654f
Ct16eB1_4 t16_mB1 0 0.20468f
Xt16edB2 t16_XB t16_VB t16_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB2 0 0 t16_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB2_0 t16_mB2 vdd 0.00496f
Ct16eB2_1 t16_mB2 0 0.00298f
Ct16eB2_2 t16_mB2 t16_XB 0.05778f
Ct16eB2_3 t16_mB2 t16_VB 0.0654f
Ct16eB2_4 t16_mB2 0 0.20468f
Xt16edB3 t16_XB t16_VB t16_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB3 0 0 t16_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB3_0 t16_mB3 vdd 0.00496f
Ct16eB3_1 t16_mB3 0 0.00298f
Ct16eB3_2 t16_mB3 t16_XB 0.05778f
Ct16eB3_3 t16_mB3 t16_VB 0.0654f
Ct16eB3_4 t16_mB3 0 0.20468f
Xt16edB4 t16_XB t16_VB t16_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB4 0 0 t16_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB4_0 t16_mB4 vdd 0.00496f
Ct16eB4_1 t16_mB4 0 0.00298f
Ct16eB4_2 t16_mB4 t16_XB 0.05778f
Ct16eB4_3 t16_mB4 t16_VB 0.0654f
Ct16eB4_4 t16_mB4 0 0.20468f
Xt16edB5 t16_XB t16_VB t16_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB5 0 0 t16_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB5_0 t16_mB5 vdd 0.00496f
Ct16eB5_1 t16_mB5 0 0.00298f
Ct16eB5_2 t16_mB5 t16_XB 0.05778f
Ct16eB5_3 t16_mB5 t16_VB 0.0654f
Ct16eB5_4 t16_mB5 0 0.20468f
Xt16edB6 t16_XB t16_VB t16_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB6 0 0 t16_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB6_0 t16_mB6 vdd 0.00496f
Ct16eB6_1 t16_mB6 0 0.00298f
Ct16eB6_2 t16_mB6 t16_XB 0.05778f
Ct16eB6_3 t16_mB6 t16_VB 0.0654f
Ct16eB6_4 t16_mB6 0 0.20468f
Xt16edB7 t16_XB t16_VB t16_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB7 0 0 t16_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB7_0 t16_mB7 vdd 0.00496f
Ct16eB7_1 t16_mB7 0 0.00298f
Ct16eB7_2 t16_mB7 t16_XB 0.05778f
Ct16eB7_3 t16_mB7 t16_VB 0.0654f
Ct16eB7_4 t16_mB7 0 0.20468f
Xt16edB8 t16_XB t16_VB t16_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB8 0 0 t16_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB8_0 t16_mB8 vdd 0.00496f
Ct16eB8_1 t16_mB8 0 0.00298f
Ct16eB8_2 t16_mB8 t16_XB 0.05778f
Ct16eB8_3 t16_mB8 t16_VB 0.0654f
Ct16eB8_4 t16_mB8 0 0.20468f
Xt16edB9 t16_XB t16_VB t16_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB9 0 0 t16_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB9_0 t16_mB9 vdd 0.00496f
Ct16eB9_1 t16_mB9 0 0.00298f
Ct16eB9_2 t16_mB9 t16_XB 0.05778f
Ct16eB9_3 t16_mB9 t16_VB 0.0654f
Ct16eB9_4 t16_mB9 0 0.20468f
Xt16edB10 t16_XB t16_VB t16_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB10 0 0 t16_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB10_0 t16_mB10 vdd 0.00496f
Ct16eB10_1 t16_mB10 0 0.00298f
Ct16eB10_2 t16_mB10 t16_XB 0.05778f
Ct16eB10_3 t16_mB10 t16_VB 0.0654f
Ct16eB10_4 t16_mB10 0 0.20468f
Xt16edB11 t16_XB t16_VB t16_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB11 0 0 t16_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB11_0 t16_mB11 vdd 0.00496f
Ct16eB11_1 t16_mB11 0 0.00298f
Ct16eB11_2 t16_mB11 t16_XB 0.05778f
Ct16eB11_3 t16_mB11 t16_VB 0.0654f
Ct16eB11_4 t16_mB11 0 0.20468f
Xt16edB12 t16_XB t16_VB t16_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB12 0 0 t16_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB12_0 t16_mB12 vdd 0.00496f
Ct16eB12_1 t16_mB12 0 0.00298f
Ct16eB12_2 t16_mB12 t16_XB 0.05778f
Ct16eB12_3 t16_mB12 t16_VB 0.0654f
Ct16eB12_4 t16_mB12 0 0.20468f
Xt16edB13 t16_XB t16_VB t16_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB13 0 0 t16_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB13_0 t16_mB13 vdd 0.00496f
Ct16eB13_1 t16_mB13 0 0.00298f
Ct16eB13_2 t16_mB13 t16_XB 0.05778f
Ct16eB13_3 t16_mB13 t16_VB 0.0654f
Ct16eB13_4 t16_mB13 0 0.20468f
Xt16edB14 t16_XB t16_VB t16_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt16esB14 0 0 t16_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct16eB14_0 t16_mB14 vdd 0.00496f
Ct16eB14_1 t16_mB14 0 0.00298f
Ct16eB14_2 t16_mB14 t16_XB 0.05778f
Ct16eB14_3 t16_mB14 t16_VB 0.0654f
Ct16eB14_4 t16_mB14 0 0.20468f

* --- mc: core
Xmc_ienn hi 0 0 vdd vdd mc_enn sky130_fd_sc_hd__inv_1
Xmc_is1n 0 0 0 vdd vdd mc_s1n sky130_fd_sc_hd__inv_1
Xmc_is0n hi 0 0 vdd vdd mc_s0n sky130_fd_sc_hd__inv_1
Xmc_PREA pre mc_enn 0 0 vdd vdd mc_PREA sky130_fd_sc_hd__nor2_1
Xmc_PREB pre mc_enn 0 0 vdd vdd mc_PREB sky130_fd_sc_hd__nor2_1
Xmc_VBIAS hi 0 0 vdd vdd mc_VBIAS sky130_fd_sc_hd__buf_2
Xmc_C1 hi 0 0 vdd vdd mc_C1 sky130_fd_sc_hd__buf_2
Xmc_DUTA hi mc_s1n hi 0 0 vdd vdd mc_DUTA sky130_fd_sc_hd__and3_1
Xmc_DUTB hi mc_s1n hi 0 0 vdd vdd mc_DUTB sky130_fd_sc_hd__and3_1
Xmc_REFA hi 0 0 0 vdd vdd mc_REFA sky130_fd_sc_hd__and2_1
Xmc_REFB hi 0 0 0 vdd vdd mc_REFB sky130_fd_sc_hd__and2_1
Xmc_SA0B hi 0 hi 0 0 vdd vdd mc_SA0B sky130_fd_sc_hd__nand3_1
Xmc_SA1B hi 0 0 0 vdd vdd mc_SA1B sky130_fd_sc_hd__nand2_1
Xmc_SA2B hi 0 mc_s0n 0 0 vdd vdd mc_SA2B sky130_fd_sc_hd__nand3_1
Xmc_SB0B hi 0 0 0 vdd vdd mc_SB0B sky130_fd_sc_hd__nand2_1
Xmc_SB1B hi 0 0 0 vdd vdd mc_SB1B sky130_fd_sc_hd__nand2_1
Xmc_M mc_ob mc_SB0B mc_SB1B mc_REFB mc_oa mc_SA0B mc_SA1B mc_SA2B mc_REFA vdd 0 mc_VBIAS mc_C1 mc_PREA mc_XA mc_DUTA mc_PREB mc_XB mc_DUTB mc_VB 0 0 core
XmcedA0 mc_XA mc_VB mc_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
XmcesA0 0 vdd mc_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
CmceA0_0 mc_mA0 mc_VB 0.07228f
CmceA0_1 mc_mA0 vdd 0.00298f
CmceA0_2 mc_mA0 vdd 0.00496f
CmceA0_3 mc_mA0 mc_XA 0.05981f
CmceA0_4 mc_mA0 0 0.19922f
XmcedB0 mc_XB mc_VB mc_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
XmcesB0 0 0 mc_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
CmceB0_0 mc_mB0 vdd 0.00496f
CmceB0_1 mc_mB0 0 0.00298f
CmceB0_2 mc_mB0 mc_XB 0.05778f
CmceB0_3 mc_mB0 mc_VB 0.0654f
CmceB0_4 mc_mB0 0 0.20468f

* --- wi: core
Xwi_ienn hi 0 0 vdd vdd wi_enn sky130_fd_sc_hd__inv_1
Xwi_is1n 0 0 0 vdd vdd wi_s1n sky130_fd_sc_hd__inv_1
Xwi_is0n hi 0 0 vdd vdd wi_s0n sky130_fd_sc_hd__inv_1
Xwi_PREA pre wi_enn 0 0 vdd vdd wi_PREA sky130_fd_sc_hd__nor2_1
Xwi_PREB pre wi_enn 0 0 vdd vdd wi_PREB sky130_fd_sc_hd__nor2_1
Xwi_VBIAS hi 0 0 vdd vdd wi_VBIAS sky130_fd_sc_hd__buf_2
Xwi_C1 hi 0 0 vdd vdd wi_C1 sky130_fd_sc_hd__buf_2
Xwi_DUTA hi wi_s1n hi 0 0 vdd vdd wi_DUTA sky130_fd_sc_hd__and3_1
Xwi_DUTB hi wi_s1n hi 0 0 vdd vdd wi_DUTB sky130_fd_sc_hd__and3_1
Xwi_REFA hi 0 0 0 vdd vdd wi_REFA sky130_fd_sc_hd__and2_1
Xwi_REFB hi 0 0 0 vdd vdd wi_REFB sky130_fd_sc_hd__and2_1
Xwi_SA0B hi 0 hi 0 0 vdd vdd wi_SA0B sky130_fd_sc_hd__nand3_1
Xwi_SA1B hi 0 0 0 vdd vdd wi_SA1B sky130_fd_sc_hd__nand2_1
Xwi_SA2B hi 0 wi_s0n 0 0 vdd vdd wi_SA2B sky130_fd_sc_hd__nand3_1
Xwi_SB0B hi 0 0 0 vdd vdd wi_SB0B sky130_fd_sc_hd__nand2_1
Xwi_SB1B hi 0 0 0 vdd vdd wi_SB1B sky130_fd_sc_hd__nand2_1
Xwi_M wi_ob wi_SB0B wi_SB1B wi_REFB wi_oa wi_SA0B wi_SA1B wi_SA2B wi_REFA vdd 0 wi_VBIAS wi_C1 wi_PREA wi_XA wi_DUTA wi_PREB wi_XB wi_DUTB wi_VB 0 0 core

Iwi wi_XA 0 40p

* --- wc: core
Xwc_ienn hi 0 0 vdd vdd wc_enn sky130_fd_sc_hd__inv_1
Xwc_is1n 0 0 0 vdd vdd wc_s1n sky130_fd_sc_hd__inv_1
Xwc_is0n hi 0 0 vdd vdd wc_s0n sky130_fd_sc_hd__inv_1
Xwc_PREA pre wc_enn 0 0 vdd vdd wc_PREA sky130_fd_sc_hd__nor2_1
Xwc_PREB pre wc_enn 0 0 vdd vdd wc_PREB sky130_fd_sc_hd__nor2_1
Xwc_VBIAS hi 0 0 vdd vdd wc_VBIAS sky130_fd_sc_hd__buf_2
Xwc_C1 hi 0 0 vdd vdd wc_C1 sky130_fd_sc_hd__buf_2
Xwc_DUTA hi wc_s1n hi 0 0 vdd vdd wc_DUTA sky130_fd_sc_hd__and3_1
Xwc_DUTB hi wc_s1n hi 0 0 vdd vdd wc_DUTB sky130_fd_sc_hd__and3_1
Xwc_REFA hi 0 0 0 vdd vdd wc_REFA sky130_fd_sc_hd__and2_1
Xwc_REFB hi 0 0 0 vdd vdd wc_REFB sky130_fd_sc_hd__and2_1
Xwc_SA0B hi 0 hi 0 0 vdd vdd wc_SA0B sky130_fd_sc_hd__nand3_1
Xwc_SA1B hi 0 0 0 vdd vdd wc_SA1B sky130_fd_sc_hd__nand2_1
Xwc_SA2B hi 0 wc_s0n 0 0 vdd vdd wc_SA2B sky130_fd_sc_hd__nand3_1
Xwc_SB0B hi 0 0 0 vdd vdd wc_SB0B sky130_fd_sc_hd__nand2_1
Xwc_SB1B hi 0 0 0 vdd vdd wc_SB1B sky130_fd_sc_hd__nand2_1
Xwc_M wc_ob wc_SB0B wc_SB1B wc_REFB wc_oa wc_SA0B wc_SA1B wc_SA2B wc_REFA vdd 0 wc_VBIAS wc_C1 wc_PREA wc_XA wc_DUTA wc_PREB wc_XB wc_DUTB wc_VB 0 0 core

Cwc wc_XA 0 1f

.control
set noaskquit
save v(n1_oa) v(n1_ob) v(n2_oa) v(n2_ob) v(n4_oa) v(n4_ob) v(n8_oa) v(n8_ob) v(n16_oa) v(n16_ob) v(t1_oa) v(t1_ob) v(t16_oa) v(t16_ob) v(mc_oa) v(mc_ob) v(wi_oa) v(wi_ob) v(wc_oa) v(wc_ob)
tran 10n 80u
meas tran n1_oa when v(n1_oa)=0.9 rise=1
echo M5 tt 27 n1_oa $&n1_oa
meas tran n1_ob when v(n1_ob)=0.9 rise=1
echo M5 tt 27 n1_ob $&n1_ob
meas tran n2_oa when v(n2_oa)=0.9 rise=1
echo M5 tt 27 n2_oa $&n2_oa
meas tran n2_ob when v(n2_ob)=0.9 rise=1
echo M5 tt 27 n2_ob $&n2_ob
meas tran n4_oa when v(n4_oa)=0.9 rise=1
echo M5 tt 27 n4_oa $&n4_oa
meas tran n4_ob when v(n4_ob)=0.9 rise=1
echo M5 tt 27 n4_ob $&n4_ob
meas tran n8_oa when v(n8_oa)=0.9 rise=1
echo M5 tt 27 n8_oa $&n8_oa
meas tran n8_ob when v(n8_ob)=0.9 rise=1
echo M5 tt 27 n8_ob $&n8_ob
meas tran n16_oa when v(n16_oa)=0.9 rise=1
echo M5 tt 27 n16_oa $&n16_oa
meas tran n16_ob when v(n16_ob)=0.9 rise=1
echo M5 tt 27 n16_ob $&n16_ob
meas tran t1_oa when v(t1_oa)=0.9 rise=1
echo M5 tt 27 t1_oa $&t1_oa
meas tran t1_ob when v(t1_ob)=0.9 rise=1
echo M5 tt 27 t1_ob $&t1_ob
meas tran t16_oa when v(t16_oa)=0.9 rise=1
echo M5 tt 27 t16_oa $&t16_oa
meas tran t16_ob when v(t16_ob)=0.9 rise=1
echo M5 tt 27 t16_ob $&t16_ob
meas tran mc_oa when v(mc_oa)=0.9 rise=1
echo M5 tt 27 mc_oa $&mc_oa
meas tran mc_ob when v(mc_ob)=0.9 rise=1
echo M5 tt 27 mc_ob $&mc_ob
meas tran wi_oa when v(wi_oa)=0.9 rise=1
echo M5 tt 27 wi_oa $&wi_oa
meas tran wi_ob when v(wi_ob)=0.9 rise=1
echo M5 tt 27 wi_ob $&wi_ob
meas tran wc_oa when v(wc_oa)=0.9 rise=1
echo M5 tt 27 wc_oa $&wc_oa
meas tran wc_ob when v(wc_ob)=0.9 rise=1
echo M5 tt 27 wc_ob $&wc_ob
quit
.endc
.end
