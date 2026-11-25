* MISFIT-03 etapa a · MISFIT-09 lector pequeno frente a v_hm · esquina ff 85 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 85
.subckt coreB XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
.subckt trapB XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
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
.subckt coreS XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
X3 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=19.482 ps=131.88 w=0.42 l=0.3
X6 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X13 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X24 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X28 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X40 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X45 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X53 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X59 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X0 XB PREB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X1 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X4 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X5 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X7 XA PREA VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X8 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X9 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X12 GND REFB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X14 a_7650_n924# VDD XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X15 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X16 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X17 XB_OUT XB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X18 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X19 XB_OUT XB GND GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X20 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 XA SA2B a_n2233_n890# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 a_7370_n924# SB1B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X23 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X25 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X26 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X27 XA VB a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X29 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X30 XB VB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X31 XA SA1B a_n2270_n1236# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X32 a_7090_n924# SB0B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X34 a_n2000_n1632# REFA GND GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X35 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X36 XA SA0B a_n950_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X37 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X39 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 VDD XA XA_OUT VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X42 GND XA XA_OUT GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X43 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 a_n48_382# a_n48_382# VB GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X46 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X47 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X48 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X49 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X50 GND DUTB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X51 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X54 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X55 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X57 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X58 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 GND DUTA a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X61 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X62 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X63 C1 C1 a_n48_382# GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X64 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X65 VBIAS VBIAS C1 GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X66 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X67 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X68 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 SA2B SA1B 0.01827f
C1 CALA a_3900_n392# 0
C2 VDD a_n2270_n1236# 0.02958f
C3 DUTA a_3900_n392# 0.00298f
C4 PREA VB 0.00674f
C5 DUTB XB 0.01922f
C6 VDD DUTB 0
C7 VDD a_n2090_n1632# 0.03533f
C8 VB REFA 0.00473f
C9 a_n2270_n1236# XA_OUT 0
C10 VB a_7370_n924# 0.05164f
C11 VB SB0B 0.00204f
C12 XA XB 0.02337f
C13 a_7370_n924# a_7040_n2004# 0.00505f
C14 a_7040_n2004# SB0B 0
C15 VDD XA 0.42521f
C16 XB a_4500_n392# 0.05778f
C17 SA1B SA0B 0.01827f
C18 VB a_n2270_n1236# 0.04724f
C19 VDD C1 0.04849f
C20 VDD a_4500_n392# 0.00496f
C21 XA XA_OUT 0.02816f
C22 VB a_n2090_n1632# 0.41783f
C23 DUTB VB 0.01701f
C24 a_7370_n924# SB1B 0.0076f
C25 VB XA 0.84518f
C26 SB1B SB0B 0.01827f
C27 VB C1 0.00902f
C28 VB a_4500_n392# 0.0654f
C29 SA2B a_n2270_n1236# 0.00382f
C30 VDD XB 0.47777f
C31 SA2B a_n2090_n1632# 0.00149f
C32 PREA PREB 0.00413f
C33 XA a_n48_382# 0.0082f
C34 VDD XA_OUT 0.11304f
C35 XA SA2B 0.01399f
C36 C1 a_n48_382# 0.05143f
C37 a_7650_n924# XB_OUT 0
C38 a_n2270_n1236# SA0B 0.00126f
C39 VB XB 0.97094f
C40 VDD VB 0.35118f
C41 a_7040_n2004# XB 0.00524f
C42 VDD a_7040_n2004# 0
C43 a_n2233_n890# SA1B 0
C44 VB XA_OUT 0
C45 XA SA0B 0.01894f
C46 XA PREB 0
C47 VDD a_n48_382# 0.04849f
C48 XB SB1B 0.01535f
C49 VB a_7040_n2004# 0.14965f
C50 VDD SB1B 0.06992f
C51 VDD SA2B 0.05775f
C52 VBIAS XA 0.00599f
C53 VBIAS C1 0.05143f
C54 XA a_3900_n392# 0.05981f
C55 VB a_n48_382# 0.06216f
C56 VB SB1B 0.00327f
C57 VB SA2B 0
C58 CALB CALA 0.00657f
C59 VDD SA0B 0.04538f
C60 PREB XB 0.0233f
C61 VDD PREB 0.17673f
C62 a_n2270_n1236# a_n2233_n890# 0.39422f
C63 a_7370_n924# a_7090_n924# 0.00251f
C64 a_7090_n924# SB0B 0.00164f
C65 a_n2090_n1632# a_n2233_n890# 0.03226f
C66 VBIAS VDD 0.03241f
C67 VB SA0B 0
C68 VDD a_3900_n392# 0.00496f
C69 XA a_n2233_n890# 0.07515f
C70 VB PREB 0.00674f
C71 a_7130_n1632# REFB 0
C72 VBIAS VB 0.00565f
C73 VB a_3900_n392# 0.07228f
C74 VDD a_n2233_n890# 0.17403f
C75 a_7130_n1632# a_7370_n924# 0.12211f
C76 a_7650_n924# a_7370_n924# 0.39422f
C77 a_7650_n924# SB0B 0
C78 a_n2233_n890# XA_OUT 0
C79 a_7090_n924# XB 0.05363f
C80 VDD a_7090_n924# 0.00372f
C81 a_n2000_n1632# REFA 0.00982f
C82 VB a_n2233_n890# 0.0538f
C83 a_n2270_n1236# a_n2000_n1632# 0.00505f
C84 VB a_7090_n924# 0
C85 a_n2090_n1632# a_n2000_n1632# 0.44072f
C86 a_n950_n924# SA1B 0
C87 XA a_n2000_n1632# 0.00524f
C88 DUTB CALB 0
C89 SA2B a_n2233_n890# 0.00793f
C90 XA CALB 0
C91 a_7090_n924# SB1B 0
C92 a_7130_n1632# XB 0.4496f
C93 a_7650_n924# XB 0.07509f
C94 VDD a_7130_n1632# 0.03763f
C95 a_7650_n924# VDD 0.20852f
C96 a_n2233_n890# SA0B 0
C97 VB a_7130_n1632# 0.42699f
C98 a_7650_n924# VB 0.05379f
C99 a_n950_n924# a_n2270_n1236# 0.00251f
C100 CALB XB 0.60923f
C101 a_7130_n1632# a_7040_n2004# 0.44072f
C102 a_7650_n924# a_7040_n2004# 0
C103 VDD CALB 0
C104 a_n950_n924# a_n2090_n1632# 0
C105 VB a_n2000_n1632# 0.14597f
C106 XA a_n950_n924# 0.05363f
C107 a_7130_n1632# SB1B 0.00131f
C108 a_7650_n924# SB1B 0
C109 VB CALB 0.01176f
C110 SA2B a_n2000_n1632# 0
C111 VDD a_n950_n924# 0.00372f
C112 DUTB DUTA 0.00465f
C113 a_n2000_n1632# SA0B 0
C114 XA CALA 0.59636f
C115 XB_OUT XB 0.02746f
C116 XA DUTA 0.00921f
C117 XB_OUT VDD 0.1139f
C118 VB a_n950_n924# 0
C119 DUTA a_4500_n392# 0
C120 PREB CALB 0
C121 XB_OUT VB 0
C122 a_n2270_n1236# SA1B 0.0076f
C123 CALA XB 0
C124 DUTA XB 0
C125 a_n2090_n1632# SA1B 0.00131f
C126 VDD DUTA 0
C127 XA SA1B 0.01535f
C128 a_n950_n924# SA0B 0.00164f
C129 a_7130_n1632# a_7090_n924# 0
C130 a_7650_n924# a_7090_n924# 0
C131 VB CALA 0.01075f
C132 a_n2233_n890# a_n2000_n1632# 0
C133 VB DUTA 0.01701f
C134 a_7370_n924# SB0B 0.00126f
C135 a_n2090_n1632# REFA 0
C136 PREA XA 0.02146f
C137 VDD SA1B 0.05165f
C138 a_n2270_n1236# a_n2090_n1632# 0.12211f
C139 XA a_n2270_n1236# 0.16867f
C140 VB SA1B 0.00283f
C141 a_7650_n924# a_7130_n1632# 0.03226f
C142 XA a_n2090_n1632# 0.4496f
C143 VB REFB 0.00642f
C144 DUTB a_4500_n392# 0.00298f
C145 REFB a_7040_n2004# 0.00982f
C146 PREA VDD 0.17043f
C147 a_n950_n924# a_n2233_n890# 0
C148 XA C1 0.00739f
C149 a_7370_n924# XB 0.16864f
C150 XB SB0B 0.01894f
C151 VDD a_7370_n924# 0.03521f
C152 VDD SB0B 0.04538f
C153 CALB GND 0.28251f
C154 CALA GND 0.29501f
C155 REFB GND 0.2066f
C156 REFA GND 0.20702f
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
C167 VB GND 28.4807f
C168 XA_OUT GND 0.13768f
C169 XB GND 6.59756f
C170 VBIAS GND 0.5422f
C171 C1 GND 0.59586f
C172 XA GND 6.78509f
C173 VDD GND 10.6227f
C174 a_7040_n2004# GND 0.72419f
C175 a_7130_n1632# GND 0.82893f
C176 a_7370_n924# GND 0.61536f
C177 a_7090_n924# GND 0.01561f
C178 a_7650_n924# GND 0.48433f
C179 a_n2000_n1632# GND 0.72762f
C180 a_n2090_n1632# GND 0.83958f
C181 a_n950_n924# GND 0.01596f
C182 a_n2270_n1236# GND 0.61977f
C183 a_n2233_n890# GND 0.49496f
C184 a_4500_n392# GND 0.20468f
C185 a_3900_n392# GND 0.19922f
C186 a_n48_382# GND 0.59697f
.ends
.subckt trapS XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
X3 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=19.482 ps=131.88 w=0.42 l=0.3
X6 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X13 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X24 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X28 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X40 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X45 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X53 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X59 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X0 XB PREB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X1 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X4 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X5 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X7 XA PREA VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X8 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X9 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X12 GND REFB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X14 a_7650_n924# VDD XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X15 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X16 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X17 XB_OUT XB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X18 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X19 XB_OUT XB GND GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X20 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 XA SA2B a_n2233_n890# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 a_7370_n924# SB1B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X23 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X25 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X26 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X27 XA GT a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X29 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X30 XB VB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X31 XA SA1B a_n2270_n1236# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X32 a_7090_n924# SB0B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X34 a_n2000_n1632# REFA GND GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X35 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X36 XA SA0B a_n950_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X37 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X39 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 VDD XA XA_OUT VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X42 GND XA XA_OUT GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X43 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 a_n48_382# a_n48_382# VB GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X46 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X47 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X48 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X49 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X50 GND DUTB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X51 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X54 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X55 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X57 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X58 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 GND DUTA a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X61 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X62 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X63 C1 C1 a_n48_382# GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X64 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X65 VBIAS VBIAS C1 GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X66 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X67 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X68 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 SA2B SA1B 0.01827f
C1 CALA a_3900_n392# 0
C2 VDD a_n2270_n1236# 0.02958f
C3 DUTA a_3900_n392# 0.00298f
C4 PREA VB 0.00674f
C5 DUTB XB 0.01922f
C6 VDD DUTB 0
C7 VDD a_n2090_n1632# 0.03533f
C8 VB REFA 0.00473f
C9 a_n2270_n1236# XA_OUT 0
C10 VB a_7370_n924# 0.05164f
C11 VB SB0B 0.00204f
C12 XA XB 0.02337f
C13 a_7370_n924# a_7040_n2004# 0.00505f
C14 a_7040_n2004# SB0B 0
C15 VDD XA 0.42521f
C16 XB a_4500_n392# 0.05778f
C17 SA1B SA0B 0.01827f
C18 VB a_n2270_n1236# 0.04724f
C19 VDD C1 0.04849f
C20 VDD a_4500_n392# 0.00496f
C21 XA XA_OUT 0.02816f
C22 VB a_n2090_n1632# 0.41783f
C23 DUTB VB 0.01701f
C24 a_7370_n924# SB1B 0.0076f
C25 VB XA 0.84518f
C26 SB1B SB0B 0.01827f
C27 VB C1 0.00902f
C28 VB a_4500_n392# 0.0654f
C29 SA2B a_n2270_n1236# 0.00382f
C30 VDD XB 0.47777f
C31 SA2B a_n2090_n1632# 0.00149f
C32 PREA PREB 0.00413f
C33 XA a_n48_382# 0.0082f
C34 VDD XA_OUT 0.11304f
C35 XA SA2B 0.01399f
C36 C1 a_n48_382# 0.05143f
C37 a_7650_n924# XB_OUT 0
C38 a_n2270_n1236# SA0B 0.00126f
C39 VB XB 0.97094f
C40 VDD VB 0.35118f
C41 a_7040_n2004# XB 0.00524f
C42 VDD a_7040_n2004# 0
C43 a_n2233_n890# SA1B 0
C44 VB XA_OUT 0
C45 XA SA0B 0.01894f
C46 XA PREB 0
C47 VDD a_n48_382# 0.04849f
C48 XB SB1B 0.01535f
C49 VB a_7040_n2004# 0.14965f
C50 VDD SB1B 0.06992f
C51 VDD SA2B 0.05775f
C52 VBIAS XA 0.00599f
C53 VBIAS C1 0.05143f
C54 XA a_3900_n392# 0.05981f
C55 VB a_n48_382# 0.06216f
C56 VB SB1B 0.00327f
C57 VB SA2B 0
C58 CALB CALA 0.00657f
C59 VDD SA0B 0.04538f
C60 PREB XB 0.0233f
C61 VDD PREB 0.17673f
C62 a_n2270_n1236# a_n2233_n890# 0.39422f
C63 a_7370_n924# a_7090_n924# 0.00251f
C64 a_7090_n924# SB0B 0.00164f
C65 a_n2090_n1632# a_n2233_n890# 0.03226f
C66 VBIAS VDD 0.03241f
C67 VB SA0B 0
C68 VDD a_3900_n392# 0.00496f
C69 XA a_n2233_n890# 0.07515f
C70 VB PREB 0.00674f
C71 a_7130_n1632# REFB 0
C72 VBIAS VB 0.00565f
C73 VB a_3900_n392# 0.07228f
C74 VDD a_n2233_n890# 0.17403f
C75 a_7130_n1632# a_7370_n924# 0.12211f
C76 a_7650_n924# a_7370_n924# 0.39422f
C77 a_7650_n924# SB0B 0
C78 a_n2233_n890# XA_OUT 0
C79 a_7090_n924# XB 0.05363f
C80 VDD a_7090_n924# 0.00372f
C81 a_n2000_n1632# REFA 0.00982f
C82 VB a_n2233_n890# 0.0538f
C83 a_n2270_n1236# a_n2000_n1632# 0.00505f
C84 VB a_7090_n924# 0
C85 a_n2090_n1632# a_n2000_n1632# 0.44072f
C86 a_n950_n924# SA1B 0
C87 XA a_n2000_n1632# 0.00524f
C88 DUTB CALB 0
C89 SA2B a_n2233_n890# 0.00793f
C90 XA CALB 0
C91 a_7090_n924# SB1B 0
C92 a_7130_n1632# XB 0.4496f
C93 a_7650_n924# XB 0.07509f
C94 VDD a_7130_n1632# 0.03763f
C95 a_7650_n924# VDD 0.20852f
C96 a_n2233_n890# SA0B 0
C97 VB a_7130_n1632# 0.42699f
C98 a_7650_n924# VB 0.05379f
C99 a_n950_n924# a_n2270_n1236# 0.00251f
C100 CALB XB 0.60923f
C101 a_7130_n1632# a_7040_n2004# 0.44072f
C102 a_7650_n924# a_7040_n2004# 0
C103 VDD CALB 0
C104 a_n950_n924# a_n2090_n1632# 0
C105 VB a_n2000_n1632# 0.14597f
C106 XA a_n950_n924# 0.05363f
C107 a_7130_n1632# SB1B 0.00131f
C108 a_7650_n924# SB1B 0
C109 VB CALB 0.01176f
C110 SA2B a_n2000_n1632# 0
C111 VDD a_n950_n924# 0.00372f
C112 DUTB DUTA 0.00465f
C113 a_n2000_n1632# SA0B 0
C114 XA CALA 0.59636f
C115 XB_OUT XB 0.02746f
C116 XA DUTA 0.00921f
C117 XB_OUT VDD 0.1139f
C118 VB a_n950_n924# 0
C119 DUTA a_4500_n392# 0
C120 PREB CALB 0
C121 XB_OUT VB 0
C122 a_n2270_n1236# SA1B 0.0076f
C123 CALA XB 0
C124 DUTA XB 0
C125 a_n2090_n1632# SA1B 0.00131f
C126 VDD DUTA 0
C127 XA SA1B 0.01535f
C128 a_n950_n924# SA0B 0.00164f
C129 a_7130_n1632# a_7090_n924# 0
C130 a_7650_n924# a_7090_n924# 0
C131 VB CALA 0.01075f
C132 a_n2233_n890# a_n2000_n1632# 0
C133 VB DUTA 0.01701f
C134 a_7370_n924# SB0B 0.00126f
C135 a_n2090_n1632# REFA 0
C136 PREA XA 0.02146f
C137 VDD SA1B 0.05165f
C138 a_n2270_n1236# a_n2090_n1632# 0.12211f
C139 XA a_n2270_n1236# 0.16867f
C140 VB SA1B 0.00283f
C141 a_7650_n924# a_7130_n1632# 0.03226f
C142 XA a_n2090_n1632# 0.4496f
C143 VB REFB 0.00642f
C144 DUTB a_4500_n392# 0.00298f
C145 REFB a_7040_n2004# 0.00982f
C146 PREA VDD 0.17043f
C147 a_n950_n924# a_n2233_n890# 0
C148 XA C1 0.00739f
C149 a_7370_n924# XB 0.16864f
C150 XB SB0B 0.01894f
C151 VDD a_7370_n924# 0.03521f
C152 VDD SB0B 0.04538f
C153 CALB GND 0.28251f
C154 CALA GND 0.29501f
C155 REFB GND 0.2066f
C156 REFA GND 0.20702f
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
C167 VB GND 28.4807f
C168 XA_OUT GND 0.13768f
C169 XB GND 6.59756f
C170 VBIAS GND 0.5422f
C171 C1 GND 0.59586f
C172 XA GND 6.78509f
C173 VDD GND 10.6227f
C174 a_7040_n2004# GND 0.72419f
C175 a_7130_n1632# GND 0.82893f
C176 a_7370_n924# GND 0.61536f
C177 a_7090_n924# GND 0.01561f
C178 a_7650_n924# GND 0.48433f
C179 a_n2000_n1632# GND 0.72762f
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
* --- hB: core
XhB_ienn hi 0 0 vdd vdd hB_enn sky130_fd_sc_hd__inv_1
XhB_is1n 0 0 0 vdd vdd hB_s1n sky130_fd_sc_hd__inv_1
XhB_is0n hi 0 0 vdd vdd hB_s0n sky130_fd_sc_hd__inv_1
XhB_PREA pre hB_enn 0 0 vdd vdd hB_PREA sky130_fd_sc_hd__nor2_1
XhB_PREB pre hB_enn 0 0 vdd vdd hB_PREB sky130_fd_sc_hd__nor2_1
XhB_VBIAS hi 0 0 vdd vdd hB_VBIAS sky130_fd_sc_hd__buf_2
XhB_C1 hi 0 0 vdd vdd hB_C1 sky130_fd_sc_hd__buf_2
XhB_DUTA hi hB_s1n hi 0 0 vdd vdd hB_DUTA sky130_fd_sc_hd__and3_1
XhB_DUTB hi hB_s1n hi 0 0 vdd vdd hB_DUTB sky130_fd_sc_hd__and3_1
XhB_REFA hi 0 0 0 vdd vdd hB_REFA sky130_fd_sc_hd__and2_1
XhB_REFB hi 0 0 0 vdd vdd hB_REFB sky130_fd_sc_hd__and2_1
XhB_SA0B hi 0 hi 0 0 vdd vdd hB_SA0B sky130_fd_sc_hd__nand3_1
XhB_SA1B hi 0 0 0 vdd vdd hB_SA1B sky130_fd_sc_hd__nand2_1
XhB_SA2B hi 0 hB_s0n 0 0 vdd vdd hB_SA2B sky130_fd_sc_hd__nand3_1
XhB_SB0B hi 0 0 0 vdd vdd hB_SB0B sky130_fd_sc_hd__nand2_1
XhB_SB1B hi 0 0 0 vdd vdd hB_SB1B sky130_fd_sc_hd__nand2_1
XhB_M hB_ob hB_SB0B hB_SB1B hB_REFB hB_oa hB_SA0B hB_SA1B hB_SA2B hB_REFA vdd 0 hB_VBIAS hB_C1 hB_PREA hB_XA hB_DUTA hB_PREB hB_XB hB_DUTB hB_VB 0 0 coreB

* --- tB: trap
XtB_ienn hi 0 0 vdd vdd tB_enn sky130_fd_sc_hd__inv_1
XtB_is1n 0 0 0 vdd vdd tB_s1n sky130_fd_sc_hd__inv_1
XtB_is0n hi 0 0 vdd vdd tB_s0n sky130_fd_sc_hd__inv_1
XtB_PREA pre tB_enn 0 0 vdd vdd tB_PREA sky130_fd_sc_hd__nor2_1
XtB_PREB pre tB_enn 0 0 vdd vdd tB_PREB sky130_fd_sc_hd__nor2_1
XtB_VBIAS hi 0 0 vdd vdd tB_VBIAS sky130_fd_sc_hd__buf_2
XtB_C1 hi 0 0 vdd vdd tB_C1 sky130_fd_sc_hd__buf_2
XtB_DUTA hi tB_s1n hi 0 0 vdd vdd tB_DUTA sky130_fd_sc_hd__and3_1
XtB_DUTB hi tB_s1n hi 0 0 vdd vdd tB_DUTB sky130_fd_sc_hd__and3_1
XtB_REFA hi 0 0 0 vdd vdd tB_REFA sky130_fd_sc_hd__and2_1
XtB_REFB hi 0 0 0 vdd vdd tB_REFB sky130_fd_sc_hd__and2_1
XtB_SA0B hi 0 hi 0 0 vdd vdd tB_SA0B sky130_fd_sc_hd__nand3_1
XtB_SA1B hi 0 0 0 vdd vdd tB_SA1B sky130_fd_sc_hd__nand2_1
XtB_SA2B hi 0 tB_s0n 0 0 vdd vdd tB_SA2B sky130_fd_sc_hd__nand3_1
XtB_SB0B hi 0 0 0 vdd vdd tB_SB0B sky130_fd_sc_hd__nand2_1
XtB_SB1B hi 0 0 0 vdd vdd tB_SB1B sky130_fd_sc_hd__nand2_1
XtB_M tB_ob tB_SB0B tB_SB1B tB_REFB tB_oa tB_SA0B tB_SA1B tB_SA2B tB_REFA vdd 0 tB_VBIAS tB_C1 tB_PREA tB_XA tB_DUTA tB_PREB tB_XB tB_DUTB tB_VB 0 0 tB_GT trapB
BtB_gt tB_GT 0 V=v(tB_VB)+0.000305

* --- rB: core
XrB_ienn hi 0 0 vdd vdd rB_enn sky130_fd_sc_hd__inv_1
XrB_is1n hi 0 0 vdd vdd rB_s1n sky130_fd_sc_hd__inv_1
XrB_is0n hi 0 0 vdd vdd rB_s0n sky130_fd_sc_hd__inv_1
XrB_PREA pre rB_enn 0 0 vdd vdd rB_PREA sky130_fd_sc_hd__nor2_1
XrB_PREB pre rB_enn 0 0 vdd vdd rB_PREB sky130_fd_sc_hd__nor2_1
XrB_VBIAS hi 0 0 vdd vdd rB_VBIAS sky130_fd_sc_hd__buf_2
XrB_C1 hi 0 0 vdd vdd rB_C1 sky130_fd_sc_hd__buf_2
XrB_DUTA hi rB_s1n hi 0 0 vdd vdd rB_DUTA sky130_fd_sc_hd__and3_1
XrB_DUTB hi rB_s1n hi 0 0 vdd vdd rB_DUTB sky130_fd_sc_hd__and3_1
XrB_REFA hi hi 0 0 vdd vdd rB_REFA sky130_fd_sc_hd__and2_1
XrB_REFB hi hi 0 0 vdd vdd rB_REFB sky130_fd_sc_hd__and2_1
XrB_SA0B hi hi hi 0 0 vdd vdd rB_SA0B sky130_fd_sc_hd__nand3_1
XrB_SA1B hi hi 0 0 vdd vdd rB_SA1B sky130_fd_sc_hd__nand2_1
XrB_SA2B hi hi rB_s0n 0 0 vdd vdd rB_SA2B sky130_fd_sc_hd__nand3_1
XrB_SB0B hi hi 0 0 vdd vdd rB_SB0B sky130_fd_sc_hd__nand2_1
XrB_SB1B hi hi 0 0 vdd vdd rB_SB1B sky130_fd_sc_hd__nand2_1
XrB_M rB_ob rB_SB0B rB_SB1B rB_REFB rB_oa rB_SA0B rB_SA1B rB_SA2B rB_REFA vdd 0 rB_VBIAS rB_C1 rB_PREA rB_XA rB_DUTA rB_PREB rB_XB rB_DUTB rB_VB 0 0 coreB

* --- cB: core
XcB_ienn hi 0 0 vdd vdd cB_enn sky130_fd_sc_hd__inv_1
XcB_is1n hi 0 0 vdd vdd cB_s1n sky130_fd_sc_hd__inv_1
XcB_is0n 0 0 0 vdd vdd cB_s0n sky130_fd_sc_hd__inv_1
XcB_PREA pre cB_enn 0 0 vdd vdd cB_PREA sky130_fd_sc_hd__nor2_1
XcB_PREB pre cB_enn 0 0 vdd vdd cB_PREB sky130_fd_sc_hd__nor2_1
XcB_VBIAS hi 0 0 vdd vdd cB_VBIAS sky130_fd_sc_hd__buf_2
XcB_C1 hi 0 0 vdd vdd cB_C1 sky130_fd_sc_hd__buf_2
XcB_DUTA hi cB_s1n 0 0 0 vdd vdd cB_DUTA sky130_fd_sc_hd__and3_1
XcB_DUTB hi cB_s1n 0 0 0 vdd vdd cB_DUTB sky130_fd_sc_hd__and3_1
XcB_REFA hi hi 0 0 vdd vdd cB_REFA sky130_fd_sc_hd__and2_1
XcB_REFB hi hi 0 0 vdd vdd cB_REFB sky130_fd_sc_hd__and2_1
XcB_SA0B hi hi 0 0 0 vdd vdd cB_SA0B sky130_fd_sc_hd__nand3_1
XcB_SA1B hi hi 0 0 vdd vdd cB_SA1B sky130_fd_sc_hd__nand2_1
XcB_SA2B hi hi cB_s0n 0 0 vdd vdd cB_SA2B sky130_fd_sc_hd__nand3_1
XcB_SB0B hi hi 0 0 vdd vdd cB_SB0B sky130_fd_sc_hd__nand2_1
XcB_SB1B hi hi 0 0 vdd vdd cB_SB1B sky130_fd_sc_hd__nand2_1
XcB_M cB_ob cB_SB0B cB_SB1B cB_REFB cB_oa cB_SA0B cB_SA1B cB_SA2B cB_REFA vdd 0 cB_VBIAS cB_C1 cB_PREA cB_XA cB_DUTA cB_PREB cB_XB cB_DUTB cB_VB 0 0 coreB

* --- hS: core
XhS_ienn hi 0 0 vdd vdd hS_enn sky130_fd_sc_hd__inv_1
XhS_is1n 0 0 0 vdd vdd hS_s1n sky130_fd_sc_hd__inv_1
XhS_is0n hi 0 0 vdd vdd hS_s0n sky130_fd_sc_hd__inv_1
XhS_PREA pre hS_enn 0 0 vdd vdd hS_PREA sky130_fd_sc_hd__nor2_1
XhS_PREB pre hS_enn 0 0 vdd vdd hS_PREB sky130_fd_sc_hd__nor2_1
XhS_VBIAS hi 0 0 vdd vdd hS_VBIAS sky130_fd_sc_hd__buf_2
XhS_C1 hi 0 0 vdd vdd hS_C1 sky130_fd_sc_hd__buf_2
XhS_DUTA hi hS_s1n hi 0 0 vdd vdd hS_DUTA sky130_fd_sc_hd__and3_1
XhS_DUTB hi hS_s1n hi 0 0 vdd vdd hS_DUTB sky130_fd_sc_hd__and3_1
XhS_REFA hi 0 0 0 vdd vdd hS_REFA sky130_fd_sc_hd__and2_1
XhS_REFB hi 0 0 0 vdd vdd hS_REFB sky130_fd_sc_hd__and2_1
XhS_SA0B hi 0 hi 0 0 vdd vdd hS_SA0B sky130_fd_sc_hd__nand3_1
XhS_SA1B hi 0 0 0 vdd vdd hS_SA1B sky130_fd_sc_hd__nand2_1
XhS_SA2B hi 0 hS_s0n 0 0 vdd vdd hS_SA2B sky130_fd_sc_hd__nand3_1
XhS_SB0B hi 0 0 0 vdd vdd hS_SB0B sky130_fd_sc_hd__nand2_1
XhS_SB1B hi 0 0 0 vdd vdd hS_SB1B sky130_fd_sc_hd__nand2_1
XhS_M hS_ob hS_SB0B hS_SB1B hS_REFB hS_oa hS_SA0B hS_SA1B hS_SA2B hS_REFA vdd 0 hS_VBIAS hS_C1 hS_PREA hS_XA hS_DUTA hS_PREB hS_XB hS_DUTB hS_VB 0 0 coreS

* --- tS: trap
XtS_ienn hi 0 0 vdd vdd tS_enn sky130_fd_sc_hd__inv_1
XtS_is1n 0 0 0 vdd vdd tS_s1n sky130_fd_sc_hd__inv_1
XtS_is0n hi 0 0 vdd vdd tS_s0n sky130_fd_sc_hd__inv_1
XtS_PREA pre tS_enn 0 0 vdd vdd tS_PREA sky130_fd_sc_hd__nor2_1
XtS_PREB pre tS_enn 0 0 vdd vdd tS_PREB sky130_fd_sc_hd__nor2_1
XtS_VBIAS hi 0 0 vdd vdd tS_VBIAS sky130_fd_sc_hd__buf_2
XtS_C1 hi 0 0 vdd vdd tS_C1 sky130_fd_sc_hd__buf_2
XtS_DUTA hi tS_s1n hi 0 0 vdd vdd tS_DUTA sky130_fd_sc_hd__and3_1
XtS_DUTB hi tS_s1n hi 0 0 vdd vdd tS_DUTB sky130_fd_sc_hd__and3_1
XtS_REFA hi 0 0 0 vdd vdd tS_REFA sky130_fd_sc_hd__and2_1
XtS_REFB hi 0 0 0 vdd vdd tS_REFB sky130_fd_sc_hd__and2_1
XtS_SA0B hi 0 hi 0 0 vdd vdd tS_SA0B sky130_fd_sc_hd__nand3_1
XtS_SA1B hi 0 0 0 vdd vdd tS_SA1B sky130_fd_sc_hd__nand2_1
XtS_SA2B hi 0 tS_s0n 0 0 vdd vdd tS_SA2B sky130_fd_sc_hd__nand3_1
XtS_SB0B hi 0 0 0 vdd vdd tS_SB0B sky130_fd_sc_hd__nand2_1
XtS_SB1B hi 0 0 0 vdd vdd tS_SB1B sky130_fd_sc_hd__nand2_1
XtS_M tS_ob tS_SB0B tS_SB1B tS_REFB tS_oa tS_SA0B tS_SA1B tS_SA2B tS_REFA vdd 0 tS_VBIAS tS_C1 tS_PREA tS_XA tS_DUTA tS_PREB tS_XB tS_DUTB tS_VB 0 0 tS_GT trapS
BtS_gt tS_GT 0 V=v(tS_VB)+0.000305

* --- rS: core
XrS_ienn hi 0 0 vdd vdd rS_enn sky130_fd_sc_hd__inv_1
XrS_is1n hi 0 0 vdd vdd rS_s1n sky130_fd_sc_hd__inv_1
XrS_is0n hi 0 0 vdd vdd rS_s0n sky130_fd_sc_hd__inv_1
XrS_PREA pre rS_enn 0 0 vdd vdd rS_PREA sky130_fd_sc_hd__nor2_1
XrS_PREB pre rS_enn 0 0 vdd vdd rS_PREB sky130_fd_sc_hd__nor2_1
XrS_VBIAS hi 0 0 vdd vdd rS_VBIAS sky130_fd_sc_hd__buf_2
XrS_C1 hi 0 0 vdd vdd rS_C1 sky130_fd_sc_hd__buf_2
XrS_DUTA hi rS_s1n hi 0 0 vdd vdd rS_DUTA sky130_fd_sc_hd__and3_1
XrS_DUTB hi rS_s1n hi 0 0 vdd vdd rS_DUTB sky130_fd_sc_hd__and3_1
XrS_REFA hi hi 0 0 vdd vdd rS_REFA sky130_fd_sc_hd__and2_1
XrS_REFB hi hi 0 0 vdd vdd rS_REFB sky130_fd_sc_hd__and2_1
XrS_SA0B hi hi hi 0 0 vdd vdd rS_SA0B sky130_fd_sc_hd__nand3_1
XrS_SA1B hi hi 0 0 vdd vdd rS_SA1B sky130_fd_sc_hd__nand2_1
XrS_SA2B hi hi rS_s0n 0 0 vdd vdd rS_SA2B sky130_fd_sc_hd__nand3_1
XrS_SB0B hi hi 0 0 vdd vdd rS_SB0B sky130_fd_sc_hd__nand2_1
XrS_SB1B hi hi 0 0 vdd vdd rS_SB1B sky130_fd_sc_hd__nand2_1
XrS_M rS_ob rS_SB0B rS_SB1B rS_REFB rS_oa rS_SA0B rS_SA1B rS_SA2B rS_REFA vdd 0 rS_VBIAS rS_C1 rS_PREA rS_XA rS_DUTA rS_PREB rS_XB rS_DUTB rS_VB 0 0 coreS

* --- cS: core
XcS_ienn hi 0 0 vdd vdd cS_enn sky130_fd_sc_hd__inv_1
XcS_is1n hi 0 0 vdd vdd cS_s1n sky130_fd_sc_hd__inv_1
XcS_is0n 0 0 0 vdd vdd cS_s0n sky130_fd_sc_hd__inv_1
XcS_PREA pre cS_enn 0 0 vdd vdd cS_PREA sky130_fd_sc_hd__nor2_1
XcS_PREB pre cS_enn 0 0 vdd vdd cS_PREB sky130_fd_sc_hd__nor2_1
XcS_VBIAS hi 0 0 vdd vdd cS_VBIAS sky130_fd_sc_hd__buf_2
XcS_C1 hi 0 0 vdd vdd cS_C1 sky130_fd_sc_hd__buf_2
XcS_DUTA hi cS_s1n 0 0 0 vdd vdd cS_DUTA sky130_fd_sc_hd__and3_1
XcS_DUTB hi cS_s1n 0 0 0 vdd vdd cS_DUTB sky130_fd_sc_hd__and3_1
XcS_REFA hi hi 0 0 vdd vdd cS_REFA sky130_fd_sc_hd__and2_1
XcS_REFB hi hi 0 0 vdd vdd cS_REFB sky130_fd_sc_hd__and2_1
XcS_SA0B hi hi 0 0 0 vdd vdd cS_SA0B sky130_fd_sc_hd__nand3_1
XcS_SA1B hi hi 0 0 vdd vdd cS_SA1B sky130_fd_sc_hd__nand2_1
XcS_SA2B hi hi cS_s0n 0 0 vdd vdd cS_SA2B sky130_fd_sc_hd__nand3_1
XcS_SB0B hi hi 0 0 vdd vdd cS_SB0B sky130_fd_sc_hd__nand2_1
XcS_SB1B hi hi 0 0 vdd vdd cS_SB1B sky130_fd_sc_hd__nand2_1
XcS_M cS_ob cS_SB0B cS_SB1B cS_REFB cS_oa cS_SA0B cS_SA1B cS_SA2B cS_REFA vdd 0 cS_VBIAS cS_C1 cS_PREA cS_XA cS_DUTA cS_PREB cS_XB cS_DUTB cS_VB 0 0 coreS

* --- wS: core
XwS_ienn hi 0 0 vdd vdd wS_enn sky130_fd_sc_hd__inv_1
XwS_is1n 0 0 0 vdd vdd wS_s1n sky130_fd_sc_hd__inv_1
XwS_is0n hi 0 0 vdd vdd wS_s0n sky130_fd_sc_hd__inv_1
XwS_PREA pre wS_enn 0 0 vdd vdd wS_PREA sky130_fd_sc_hd__nor2_1
XwS_PREB pre wS_enn 0 0 vdd vdd wS_PREB sky130_fd_sc_hd__nor2_1
XwS_VBIAS hi 0 0 vdd vdd wS_VBIAS sky130_fd_sc_hd__buf_2
XwS_C1 hi 0 0 vdd vdd wS_C1 sky130_fd_sc_hd__buf_2
XwS_DUTA hi wS_s1n hi 0 0 vdd vdd wS_DUTA sky130_fd_sc_hd__and3_1
XwS_DUTB hi wS_s1n hi 0 0 vdd vdd wS_DUTB sky130_fd_sc_hd__and3_1
XwS_REFA hi 0 0 0 vdd vdd wS_REFA sky130_fd_sc_hd__and2_1
XwS_REFB hi 0 0 0 vdd vdd wS_REFB sky130_fd_sc_hd__and2_1
XwS_SA0B hi 0 hi 0 0 vdd vdd wS_SA0B sky130_fd_sc_hd__nand3_1
XwS_SA1B hi 0 0 0 vdd vdd wS_SA1B sky130_fd_sc_hd__nand2_1
XwS_SA2B hi 0 wS_s0n 0 0 vdd vdd wS_SA2B sky130_fd_sc_hd__nand3_1
XwS_SB0B hi 0 0 0 vdd vdd wS_SB0B sky130_fd_sc_hd__nand2_1
XwS_SB1B hi 0 0 0 vdd vdd wS_SB1B sky130_fd_sc_hd__nand2_1
XwS_M wS_ob wS_SB0B wS_SB1B wS_REFB wS_oa wS_SA0B wS_SA1B wS_SA2B wS_REFA vdd 0 wS_VBIAS wS_C1 wS_PREA wS_XA wS_DUTA wS_PREB wS_XB wS_DUTB wS_VB 0 0 coreS
Cw wS_XA 0 1f

.control
set noaskquit
save v(hB_oa) v(hB_ob) v(tB_oa) v(tB_ob) v(rB_oa) v(rB_ob) v(cB_oa) v(cB_ob) v(hS_oa) v(hS_ob) v(tS_oa) v(tS_ob) v(rS_oa) v(rS_ob) v(cS_oa) v(cS_ob) v(wS_oa) v(wS_ob)
tran 10n 80u
meas tran hB_oa when v(hB_oa)=0.9 rise=1
echo M9 ff 85 hB_oa $&hB_oa
meas tran hB_ob when v(hB_ob)=0.9 rise=1
echo M9 ff 85 hB_ob $&hB_ob
meas tran tB_oa when v(tB_oa)=0.9 rise=1
echo M9 ff 85 tB_oa $&tB_oa
meas tran tB_ob when v(tB_ob)=0.9 rise=1
echo M9 ff 85 tB_ob $&tB_ob
meas tran rB_oa when v(rB_oa)=0.9 rise=1
echo M9 ff 85 rB_oa $&rB_oa
meas tran rB_ob when v(rB_ob)=0.9 rise=1
echo M9 ff 85 rB_ob $&rB_ob
meas tran cB_oa when v(cB_oa)=0.9 rise=1
echo M9 ff 85 cB_oa $&cB_oa
meas tran cB_ob when v(cB_ob)=0.9 rise=1
echo M9 ff 85 cB_ob $&cB_ob
meas tran hS_oa when v(hS_oa)=0.9 rise=1
echo M9 ff 85 hS_oa $&hS_oa
meas tran hS_ob when v(hS_ob)=0.9 rise=1
echo M9 ff 85 hS_ob $&hS_ob
meas tran tS_oa when v(tS_oa)=0.9 rise=1
echo M9 ff 85 tS_oa $&tS_oa
meas tran tS_ob when v(tS_ob)=0.9 rise=1
echo M9 ff 85 tS_ob $&tS_ob
meas tran rS_oa when v(rS_oa)=0.9 rise=1
echo M9 ff 85 rS_oa $&rS_oa
meas tran rS_ob when v(rS_ob)=0.9 rise=1
echo M9 ff 85 rS_ob $&rS_ob
meas tran cS_oa when v(cS_oa)=0.9 rise=1
echo M9 ff 85 cS_oa $&cS_oa
meas tran cS_ob when v(cS_ob)=0.9 rise=1
echo M9 ff 85 cS_ob $&cS_ob
meas tran wS_oa when v(wS_oa)=0.9 rise=1
echo M9 ff 85 wS_oa $&wS_oa
meas tran wS_ob when v(wS_ob)=0.9 rise=1
echo M9 ff 85 wS_ob $&wS_ob
quit
.endc
.end
