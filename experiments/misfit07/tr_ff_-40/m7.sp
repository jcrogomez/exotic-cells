* MISFIT-03 etapa a · MISFIT-07 filtro · esquina ff -40 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp -40
.subckt core33 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
.subckt trap33 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
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
.subckt core16 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt trap16 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
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
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt core8 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt trap8 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
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
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt core4 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
X0 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=118.482 ps=607.88 w=5.5 l=10
X3 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X6 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X8 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X9 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X11 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X23 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt trap4 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
X0 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=118.482 ps=607.88 w=5.5 l=10
X3 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X6 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X8 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X9 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X11 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X23 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt core2 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
X0 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=118.482 ps=607.88 w=5.5 l=10
X3 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X6 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X8 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt trap2 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
X0 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=118.482 ps=607.88 w=5.5 l=10
X3 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X6 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X8 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt core0 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
X6 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X8 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
.subckt trap0 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
X6 GND a_7370_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X8 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X37 GND a_n2233_n890# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X39 GND a_7650_n924# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
X67 GND a_n2270_n1236# GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0 ps=0 w=0.42 l=0.3
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
* --- h33: core
Xh33_ienn hi 0 0 vdd vdd h33_enn sky130_fd_sc_hd__inv_1
Xh33_is1n 0 0 0 vdd vdd h33_s1n sky130_fd_sc_hd__inv_1
Xh33_is0n hi 0 0 vdd vdd h33_s0n sky130_fd_sc_hd__inv_1
Xh33_PREA pre h33_enn 0 0 vdd vdd h33_PREA sky130_fd_sc_hd__nor2_1
Xh33_PREB pre h33_enn 0 0 vdd vdd h33_PREB sky130_fd_sc_hd__nor2_1
Xh33_VBIAS hi 0 0 vdd vdd h33_VBIAS sky130_fd_sc_hd__buf_2
Xh33_C1 hi 0 0 vdd vdd h33_C1 sky130_fd_sc_hd__buf_2
Xh33_DUTA hi h33_s1n hi 0 0 vdd vdd h33_DUTA sky130_fd_sc_hd__and3_1
Xh33_DUTB hi h33_s1n hi 0 0 vdd vdd h33_DUTB sky130_fd_sc_hd__and3_1
Xh33_REFA hi 0 0 0 vdd vdd h33_REFA sky130_fd_sc_hd__and2_1
Xh33_REFB hi 0 0 0 vdd vdd h33_REFB sky130_fd_sc_hd__and2_1
Xh33_SA0B hi 0 hi 0 0 vdd vdd h33_SA0B sky130_fd_sc_hd__nand3_1
Xh33_SA1B hi 0 0 0 vdd vdd h33_SA1B sky130_fd_sc_hd__nand2_1
Xh33_SA2B hi 0 h33_s0n 0 0 vdd vdd h33_SA2B sky130_fd_sc_hd__nand3_1
Xh33_SB0B hi 0 0 0 vdd vdd h33_SB0B sky130_fd_sc_hd__nand2_1
Xh33_SB1B hi 0 0 0 vdd vdd h33_SB1B sky130_fd_sc_hd__nand2_1
Xh33_M h33_ob h33_SB0B h33_SB1B h33_REFB h33_oa h33_SA0B h33_SA1B h33_SA2B h33_REFA vdd 0 h33_VBIAS h33_C1 h33_PREA h33_XA h33_DUTA h33_PREB h33_XB h33_DUTB h33_VB 0 0 core33

* --- t33: trap
Xt33_ienn hi 0 0 vdd vdd t33_enn sky130_fd_sc_hd__inv_1
Xt33_is1n 0 0 0 vdd vdd t33_s1n sky130_fd_sc_hd__inv_1
Xt33_is0n hi 0 0 vdd vdd t33_s0n sky130_fd_sc_hd__inv_1
Xt33_PREA pre t33_enn 0 0 vdd vdd t33_PREA sky130_fd_sc_hd__nor2_1
Xt33_PREB pre t33_enn 0 0 vdd vdd t33_PREB sky130_fd_sc_hd__nor2_1
Xt33_VBIAS hi 0 0 vdd vdd t33_VBIAS sky130_fd_sc_hd__buf_2
Xt33_C1 hi 0 0 vdd vdd t33_C1 sky130_fd_sc_hd__buf_2
Xt33_DUTA hi t33_s1n hi 0 0 vdd vdd t33_DUTA sky130_fd_sc_hd__and3_1
Xt33_DUTB hi t33_s1n hi 0 0 vdd vdd t33_DUTB sky130_fd_sc_hd__and3_1
Xt33_REFA hi 0 0 0 vdd vdd t33_REFA sky130_fd_sc_hd__and2_1
Xt33_REFB hi 0 0 0 vdd vdd t33_REFB sky130_fd_sc_hd__and2_1
Xt33_SA0B hi 0 hi 0 0 vdd vdd t33_SA0B sky130_fd_sc_hd__nand3_1
Xt33_SA1B hi 0 0 0 vdd vdd t33_SA1B sky130_fd_sc_hd__nand2_1
Xt33_SA2B hi 0 t33_s0n 0 0 vdd vdd t33_SA2B sky130_fd_sc_hd__nand3_1
Xt33_SB0B hi 0 0 0 vdd vdd t33_SB0B sky130_fd_sc_hd__nand2_1
Xt33_SB1B hi 0 0 0 vdd vdd t33_SB1B sky130_fd_sc_hd__nand2_1
Xt33_M t33_ob t33_SB0B t33_SB1B t33_REFB t33_oa t33_SA0B t33_SA1B t33_SA2B t33_REFA vdd 0 t33_VBIAS t33_C1 t33_PREA t33_XA t33_DUTA t33_PREB t33_XB t33_DUTB t33_VB 0 0 t33_GT trap33
Bt33_gt t33_GT 0 V=v(t33_VB)+0.000305

* --- r33: core
Xr33_ienn hi 0 0 vdd vdd r33_enn sky130_fd_sc_hd__inv_1
Xr33_is1n hi 0 0 vdd vdd r33_s1n sky130_fd_sc_hd__inv_1
Xr33_is0n hi 0 0 vdd vdd r33_s0n sky130_fd_sc_hd__inv_1
Xr33_PREA pre r33_enn 0 0 vdd vdd r33_PREA sky130_fd_sc_hd__nor2_1
Xr33_PREB pre r33_enn 0 0 vdd vdd r33_PREB sky130_fd_sc_hd__nor2_1
Xr33_VBIAS hi 0 0 vdd vdd r33_VBIAS sky130_fd_sc_hd__buf_2
Xr33_C1 hi 0 0 vdd vdd r33_C1 sky130_fd_sc_hd__buf_2
Xr33_DUTA hi r33_s1n hi 0 0 vdd vdd r33_DUTA sky130_fd_sc_hd__and3_1
Xr33_DUTB hi r33_s1n hi 0 0 vdd vdd r33_DUTB sky130_fd_sc_hd__and3_1
Xr33_REFA hi hi 0 0 vdd vdd r33_REFA sky130_fd_sc_hd__and2_1
Xr33_REFB hi hi 0 0 vdd vdd r33_REFB sky130_fd_sc_hd__and2_1
Xr33_SA0B hi hi hi 0 0 vdd vdd r33_SA0B sky130_fd_sc_hd__nand3_1
Xr33_SA1B hi hi 0 0 vdd vdd r33_SA1B sky130_fd_sc_hd__nand2_1
Xr33_SA2B hi hi r33_s0n 0 0 vdd vdd r33_SA2B sky130_fd_sc_hd__nand3_1
Xr33_SB0B hi hi 0 0 vdd vdd r33_SB0B sky130_fd_sc_hd__nand2_1
Xr33_SB1B hi hi 0 0 vdd vdd r33_SB1B sky130_fd_sc_hd__nand2_1
Xr33_M r33_ob r33_SB0B r33_SB1B r33_REFB r33_oa r33_SA0B r33_SA1B r33_SA2B r33_REFA vdd 0 r33_VBIAS r33_C1 r33_PREA r33_XA r33_DUTA r33_PREB r33_XB r33_DUTB r33_VB 0 0 core33

* --- c33: core
Xc33_ienn hi 0 0 vdd vdd c33_enn sky130_fd_sc_hd__inv_1
Xc33_is1n hi 0 0 vdd vdd c33_s1n sky130_fd_sc_hd__inv_1
Xc33_is0n 0 0 0 vdd vdd c33_s0n sky130_fd_sc_hd__inv_1
Xc33_PREA pre c33_enn 0 0 vdd vdd c33_PREA sky130_fd_sc_hd__nor2_1
Xc33_PREB pre c33_enn 0 0 vdd vdd c33_PREB sky130_fd_sc_hd__nor2_1
Xc33_VBIAS hi 0 0 vdd vdd c33_VBIAS sky130_fd_sc_hd__buf_2
Xc33_C1 hi 0 0 vdd vdd c33_C1 sky130_fd_sc_hd__buf_2
Xc33_DUTA hi c33_s1n 0 0 0 vdd vdd c33_DUTA sky130_fd_sc_hd__and3_1
Xc33_DUTB hi c33_s1n 0 0 0 vdd vdd c33_DUTB sky130_fd_sc_hd__and3_1
Xc33_REFA hi hi 0 0 vdd vdd c33_REFA sky130_fd_sc_hd__and2_1
Xc33_REFB hi hi 0 0 vdd vdd c33_REFB sky130_fd_sc_hd__and2_1
Xc33_SA0B hi hi 0 0 0 vdd vdd c33_SA0B sky130_fd_sc_hd__nand3_1
Xc33_SA1B hi hi 0 0 vdd vdd c33_SA1B sky130_fd_sc_hd__nand2_1
Xc33_SA2B hi hi c33_s0n 0 0 vdd vdd c33_SA2B sky130_fd_sc_hd__nand3_1
Xc33_SB0B hi hi 0 0 vdd vdd c33_SB0B sky130_fd_sc_hd__nand2_1
Xc33_SB1B hi hi 0 0 vdd vdd c33_SB1B sky130_fd_sc_hd__nand2_1
Xc33_M c33_ob c33_SB0B c33_SB1B c33_REFB c33_oa c33_SA0B c33_SA1B c33_SA2B c33_REFA vdd 0 c33_VBIAS c33_C1 c33_PREA c33_XA c33_DUTA c33_PREB c33_XB c33_DUTB c33_VB 0 0 core33

* --- h16: core
Xh16_ienn hi 0 0 vdd vdd h16_enn sky130_fd_sc_hd__inv_1
Xh16_is1n 0 0 0 vdd vdd h16_s1n sky130_fd_sc_hd__inv_1
Xh16_is0n hi 0 0 vdd vdd h16_s0n sky130_fd_sc_hd__inv_1
Xh16_PREA pre h16_enn 0 0 vdd vdd h16_PREA sky130_fd_sc_hd__nor2_1
Xh16_PREB pre h16_enn 0 0 vdd vdd h16_PREB sky130_fd_sc_hd__nor2_1
Xh16_VBIAS hi 0 0 vdd vdd h16_VBIAS sky130_fd_sc_hd__buf_2
Xh16_C1 hi 0 0 vdd vdd h16_C1 sky130_fd_sc_hd__buf_2
Xh16_DUTA hi h16_s1n hi 0 0 vdd vdd h16_DUTA sky130_fd_sc_hd__and3_1
Xh16_DUTB hi h16_s1n hi 0 0 vdd vdd h16_DUTB sky130_fd_sc_hd__and3_1
Xh16_REFA hi 0 0 0 vdd vdd h16_REFA sky130_fd_sc_hd__and2_1
Xh16_REFB hi 0 0 0 vdd vdd h16_REFB sky130_fd_sc_hd__and2_1
Xh16_SA0B hi 0 hi 0 0 vdd vdd h16_SA0B sky130_fd_sc_hd__nand3_1
Xh16_SA1B hi 0 0 0 vdd vdd h16_SA1B sky130_fd_sc_hd__nand2_1
Xh16_SA2B hi 0 h16_s0n 0 0 vdd vdd h16_SA2B sky130_fd_sc_hd__nand3_1
Xh16_SB0B hi 0 0 0 vdd vdd h16_SB0B sky130_fd_sc_hd__nand2_1
Xh16_SB1B hi 0 0 0 vdd vdd h16_SB1B sky130_fd_sc_hd__nand2_1
Xh16_M h16_ob h16_SB0B h16_SB1B h16_REFB h16_oa h16_SA0B h16_SA1B h16_SA2B h16_REFA vdd 0 h16_VBIAS h16_C1 h16_PREA h16_XA h16_DUTA h16_PREB h16_XB h16_DUTB h16_VB 0 0 core16

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
Xt16_M t16_ob t16_SB0B t16_SB1B t16_REFB t16_oa t16_SA0B t16_SA1B t16_SA2B t16_REFA vdd 0 t16_VBIAS t16_C1 t16_PREA t16_XA t16_DUTA t16_PREB t16_XB t16_DUTB t16_VB 0 0 t16_GT trap16
Bt16_gt t16_GT 0 V=v(t16_VB)+0.000305

* --- r16: core
Xr16_ienn hi 0 0 vdd vdd r16_enn sky130_fd_sc_hd__inv_1
Xr16_is1n hi 0 0 vdd vdd r16_s1n sky130_fd_sc_hd__inv_1
Xr16_is0n hi 0 0 vdd vdd r16_s0n sky130_fd_sc_hd__inv_1
Xr16_PREA pre r16_enn 0 0 vdd vdd r16_PREA sky130_fd_sc_hd__nor2_1
Xr16_PREB pre r16_enn 0 0 vdd vdd r16_PREB sky130_fd_sc_hd__nor2_1
Xr16_VBIAS hi 0 0 vdd vdd r16_VBIAS sky130_fd_sc_hd__buf_2
Xr16_C1 hi 0 0 vdd vdd r16_C1 sky130_fd_sc_hd__buf_2
Xr16_DUTA hi r16_s1n hi 0 0 vdd vdd r16_DUTA sky130_fd_sc_hd__and3_1
Xr16_DUTB hi r16_s1n hi 0 0 vdd vdd r16_DUTB sky130_fd_sc_hd__and3_1
Xr16_REFA hi hi 0 0 vdd vdd r16_REFA sky130_fd_sc_hd__and2_1
Xr16_REFB hi hi 0 0 vdd vdd r16_REFB sky130_fd_sc_hd__and2_1
Xr16_SA0B hi hi hi 0 0 vdd vdd r16_SA0B sky130_fd_sc_hd__nand3_1
Xr16_SA1B hi hi 0 0 vdd vdd r16_SA1B sky130_fd_sc_hd__nand2_1
Xr16_SA2B hi hi r16_s0n 0 0 vdd vdd r16_SA2B sky130_fd_sc_hd__nand3_1
Xr16_SB0B hi hi 0 0 vdd vdd r16_SB0B sky130_fd_sc_hd__nand2_1
Xr16_SB1B hi hi 0 0 vdd vdd r16_SB1B sky130_fd_sc_hd__nand2_1
Xr16_M r16_ob r16_SB0B r16_SB1B r16_REFB r16_oa r16_SA0B r16_SA1B r16_SA2B r16_REFA vdd 0 r16_VBIAS r16_C1 r16_PREA r16_XA r16_DUTA r16_PREB r16_XB r16_DUTB r16_VB 0 0 core16

* --- c16: core
Xc16_ienn hi 0 0 vdd vdd c16_enn sky130_fd_sc_hd__inv_1
Xc16_is1n hi 0 0 vdd vdd c16_s1n sky130_fd_sc_hd__inv_1
Xc16_is0n 0 0 0 vdd vdd c16_s0n sky130_fd_sc_hd__inv_1
Xc16_PREA pre c16_enn 0 0 vdd vdd c16_PREA sky130_fd_sc_hd__nor2_1
Xc16_PREB pre c16_enn 0 0 vdd vdd c16_PREB sky130_fd_sc_hd__nor2_1
Xc16_VBIAS hi 0 0 vdd vdd c16_VBIAS sky130_fd_sc_hd__buf_2
Xc16_C1 hi 0 0 vdd vdd c16_C1 sky130_fd_sc_hd__buf_2
Xc16_DUTA hi c16_s1n 0 0 0 vdd vdd c16_DUTA sky130_fd_sc_hd__and3_1
Xc16_DUTB hi c16_s1n 0 0 0 vdd vdd c16_DUTB sky130_fd_sc_hd__and3_1
Xc16_REFA hi hi 0 0 vdd vdd c16_REFA sky130_fd_sc_hd__and2_1
Xc16_REFB hi hi 0 0 vdd vdd c16_REFB sky130_fd_sc_hd__and2_1
Xc16_SA0B hi hi 0 0 0 vdd vdd c16_SA0B sky130_fd_sc_hd__nand3_1
Xc16_SA1B hi hi 0 0 vdd vdd c16_SA1B sky130_fd_sc_hd__nand2_1
Xc16_SA2B hi hi c16_s0n 0 0 vdd vdd c16_SA2B sky130_fd_sc_hd__nand3_1
Xc16_SB0B hi hi 0 0 vdd vdd c16_SB0B sky130_fd_sc_hd__nand2_1
Xc16_SB1B hi hi 0 0 vdd vdd c16_SB1B sky130_fd_sc_hd__nand2_1
Xc16_M c16_ob c16_SB0B c16_SB1B c16_REFB c16_oa c16_SA0B c16_SA1B c16_SA2B c16_REFA vdd 0 c16_VBIAS c16_C1 c16_PREA c16_XA c16_DUTA c16_PREB c16_XB c16_DUTB c16_VB 0 0 core16

* --- h8: core
Xh8_ienn hi 0 0 vdd vdd h8_enn sky130_fd_sc_hd__inv_1
Xh8_is1n 0 0 0 vdd vdd h8_s1n sky130_fd_sc_hd__inv_1
Xh8_is0n hi 0 0 vdd vdd h8_s0n sky130_fd_sc_hd__inv_1
Xh8_PREA pre h8_enn 0 0 vdd vdd h8_PREA sky130_fd_sc_hd__nor2_1
Xh8_PREB pre h8_enn 0 0 vdd vdd h8_PREB sky130_fd_sc_hd__nor2_1
Xh8_VBIAS hi 0 0 vdd vdd h8_VBIAS sky130_fd_sc_hd__buf_2
Xh8_C1 hi 0 0 vdd vdd h8_C1 sky130_fd_sc_hd__buf_2
Xh8_DUTA hi h8_s1n hi 0 0 vdd vdd h8_DUTA sky130_fd_sc_hd__and3_1
Xh8_DUTB hi h8_s1n hi 0 0 vdd vdd h8_DUTB sky130_fd_sc_hd__and3_1
Xh8_REFA hi 0 0 0 vdd vdd h8_REFA sky130_fd_sc_hd__and2_1
Xh8_REFB hi 0 0 0 vdd vdd h8_REFB sky130_fd_sc_hd__and2_1
Xh8_SA0B hi 0 hi 0 0 vdd vdd h8_SA0B sky130_fd_sc_hd__nand3_1
Xh8_SA1B hi 0 0 0 vdd vdd h8_SA1B sky130_fd_sc_hd__nand2_1
Xh8_SA2B hi 0 h8_s0n 0 0 vdd vdd h8_SA2B sky130_fd_sc_hd__nand3_1
Xh8_SB0B hi 0 0 0 vdd vdd h8_SB0B sky130_fd_sc_hd__nand2_1
Xh8_SB1B hi 0 0 0 vdd vdd h8_SB1B sky130_fd_sc_hd__nand2_1
Xh8_M h8_ob h8_SB0B h8_SB1B h8_REFB h8_oa h8_SA0B h8_SA1B h8_SA2B h8_REFA vdd 0 h8_VBIAS h8_C1 h8_PREA h8_XA h8_DUTA h8_PREB h8_XB h8_DUTB h8_VB 0 0 core8

* --- t8: trap
Xt8_ienn hi 0 0 vdd vdd t8_enn sky130_fd_sc_hd__inv_1
Xt8_is1n 0 0 0 vdd vdd t8_s1n sky130_fd_sc_hd__inv_1
Xt8_is0n hi 0 0 vdd vdd t8_s0n sky130_fd_sc_hd__inv_1
Xt8_PREA pre t8_enn 0 0 vdd vdd t8_PREA sky130_fd_sc_hd__nor2_1
Xt8_PREB pre t8_enn 0 0 vdd vdd t8_PREB sky130_fd_sc_hd__nor2_1
Xt8_VBIAS hi 0 0 vdd vdd t8_VBIAS sky130_fd_sc_hd__buf_2
Xt8_C1 hi 0 0 vdd vdd t8_C1 sky130_fd_sc_hd__buf_2
Xt8_DUTA hi t8_s1n hi 0 0 vdd vdd t8_DUTA sky130_fd_sc_hd__and3_1
Xt8_DUTB hi t8_s1n hi 0 0 vdd vdd t8_DUTB sky130_fd_sc_hd__and3_1
Xt8_REFA hi 0 0 0 vdd vdd t8_REFA sky130_fd_sc_hd__and2_1
Xt8_REFB hi 0 0 0 vdd vdd t8_REFB sky130_fd_sc_hd__and2_1
Xt8_SA0B hi 0 hi 0 0 vdd vdd t8_SA0B sky130_fd_sc_hd__nand3_1
Xt8_SA1B hi 0 0 0 vdd vdd t8_SA1B sky130_fd_sc_hd__nand2_1
Xt8_SA2B hi 0 t8_s0n 0 0 vdd vdd t8_SA2B sky130_fd_sc_hd__nand3_1
Xt8_SB0B hi 0 0 0 vdd vdd t8_SB0B sky130_fd_sc_hd__nand2_1
Xt8_SB1B hi 0 0 0 vdd vdd t8_SB1B sky130_fd_sc_hd__nand2_1
Xt8_M t8_ob t8_SB0B t8_SB1B t8_REFB t8_oa t8_SA0B t8_SA1B t8_SA2B t8_REFA vdd 0 t8_VBIAS t8_C1 t8_PREA t8_XA t8_DUTA t8_PREB t8_XB t8_DUTB t8_VB 0 0 t8_GT trap8
Bt8_gt t8_GT 0 V=v(t8_VB)+0.000305

* --- r8: core
Xr8_ienn hi 0 0 vdd vdd r8_enn sky130_fd_sc_hd__inv_1
Xr8_is1n hi 0 0 vdd vdd r8_s1n sky130_fd_sc_hd__inv_1
Xr8_is0n hi 0 0 vdd vdd r8_s0n sky130_fd_sc_hd__inv_1
Xr8_PREA pre r8_enn 0 0 vdd vdd r8_PREA sky130_fd_sc_hd__nor2_1
Xr8_PREB pre r8_enn 0 0 vdd vdd r8_PREB sky130_fd_sc_hd__nor2_1
Xr8_VBIAS hi 0 0 vdd vdd r8_VBIAS sky130_fd_sc_hd__buf_2
Xr8_C1 hi 0 0 vdd vdd r8_C1 sky130_fd_sc_hd__buf_2
Xr8_DUTA hi r8_s1n hi 0 0 vdd vdd r8_DUTA sky130_fd_sc_hd__and3_1
Xr8_DUTB hi r8_s1n hi 0 0 vdd vdd r8_DUTB sky130_fd_sc_hd__and3_1
Xr8_REFA hi hi 0 0 vdd vdd r8_REFA sky130_fd_sc_hd__and2_1
Xr8_REFB hi hi 0 0 vdd vdd r8_REFB sky130_fd_sc_hd__and2_1
Xr8_SA0B hi hi hi 0 0 vdd vdd r8_SA0B sky130_fd_sc_hd__nand3_1
Xr8_SA1B hi hi 0 0 vdd vdd r8_SA1B sky130_fd_sc_hd__nand2_1
Xr8_SA2B hi hi r8_s0n 0 0 vdd vdd r8_SA2B sky130_fd_sc_hd__nand3_1
Xr8_SB0B hi hi 0 0 vdd vdd r8_SB0B sky130_fd_sc_hd__nand2_1
Xr8_SB1B hi hi 0 0 vdd vdd r8_SB1B sky130_fd_sc_hd__nand2_1
Xr8_M r8_ob r8_SB0B r8_SB1B r8_REFB r8_oa r8_SA0B r8_SA1B r8_SA2B r8_REFA vdd 0 r8_VBIAS r8_C1 r8_PREA r8_XA r8_DUTA r8_PREB r8_XB r8_DUTB r8_VB 0 0 core8

* --- c8: core
Xc8_ienn hi 0 0 vdd vdd c8_enn sky130_fd_sc_hd__inv_1
Xc8_is1n hi 0 0 vdd vdd c8_s1n sky130_fd_sc_hd__inv_1
Xc8_is0n 0 0 0 vdd vdd c8_s0n sky130_fd_sc_hd__inv_1
Xc8_PREA pre c8_enn 0 0 vdd vdd c8_PREA sky130_fd_sc_hd__nor2_1
Xc8_PREB pre c8_enn 0 0 vdd vdd c8_PREB sky130_fd_sc_hd__nor2_1
Xc8_VBIAS hi 0 0 vdd vdd c8_VBIAS sky130_fd_sc_hd__buf_2
Xc8_C1 hi 0 0 vdd vdd c8_C1 sky130_fd_sc_hd__buf_2
Xc8_DUTA hi c8_s1n 0 0 0 vdd vdd c8_DUTA sky130_fd_sc_hd__and3_1
Xc8_DUTB hi c8_s1n 0 0 0 vdd vdd c8_DUTB sky130_fd_sc_hd__and3_1
Xc8_REFA hi hi 0 0 vdd vdd c8_REFA sky130_fd_sc_hd__and2_1
Xc8_REFB hi hi 0 0 vdd vdd c8_REFB sky130_fd_sc_hd__and2_1
Xc8_SA0B hi hi 0 0 0 vdd vdd c8_SA0B sky130_fd_sc_hd__nand3_1
Xc8_SA1B hi hi 0 0 vdd vdd c8_SA1B sky130_fd_sc_hd__nand2_1
Xc8_SA2B hi hi c8_s0n 0 0 vdd vdd c8_SA2B sky130_fd_sc_hd__nand3_1
Xc8_SB0B hi hi 0 0 vdd vdd c8_SB0B sky130_fd_sc_hd__nand2_1
Xc8_SB1B hi hi 0 0 vdd vdd c8_SB1B sky130_fd_sc_hd__nand2_1
Xc8_M c8_ob c8_SB0B c8_SB1B c8_REFB c8_oa c8_SA0B c8_SA1B c8_SA2B c8_REFA vdd 0 c8_VBIAS c8_C1 c8_PREA c8_XA c8_DUTA c8_PREB c8_XB c8_DUTB c8_VB 0 0 core8

* --- h4: core
Xh4_ienn hi 0 0 vdd vdd h4_enn sky130_fd_sc_hd__inv_1
Xh4_is1n 0 0 0 vdd vdd h4_s1n sky130_fd_sc_hd__inv_1
Xh4_is0n hi 0 0 vdd vdd h4_s0n sky130_fd_sc_hd__inv_1
Xh4_PREA pre h4_enn 0 0 vdd vdd h4_PREA sky130_fd_sc_hd__nor2_1
Xh4_PREB pre h4_enn 0 0 vdd vdd h4_PREB sky130_fd_sc_hd__nor2_1
Xh4_VBIAS hi 0 0 vdd vdd h4_VBIAS sky130_fd_sc_hd__buf_2
Xh4_C1 hi 0 0 vdd vdd h4_C1 sky130_fd_sc_hd__buf_2
Xh4_DUTA hi h4_s1n hi 0 0 vdd vdd h4_DUTA sky130_fd_sc_hd__and3_1
Xh4_DUTB hi h4_s1n hi 0 0 vdd vdd h4_DUTB sky130_fd_sc_hd__and3_1
Xh4_REFA hi 0 0 0 vdd vdd h4_REFA sky130_fd_sc_hd__and2_1
Xh4_REFB hi 0 0 0 vdd vdd h4_REFB sky130_fd_sc_hd__and2_1
Xh4_SA0B hi 0 hi 0 0 vdd vdd h4_SA0B sky130_fd_sc_hd__nand3_1
Xh4_SA1B hi 0 0 0 vdd vdd h4_SA1B sky130_fd_sc_hd__nand2_1
Xh4_SA2B hi 0 h4_s0n 0 0 vdd vdd h4_SA2B sky130_fd_sc_hd__nand3_1
Xh4_SB0B hi 0 0 0 vdd vdd h4_SB0B sky130_fd_sc_hd__nand2_1
Xh4_SB1B hi 0 0 0 vdd vdd h4_SB1B sky130_fd_sc_hd__nand2_1
Xh4_M h4_ob h4_SB0B h4_SB1B h4_REFB h4_oa h4_SA0B h4_SA1B h4_SA2B h4_REFA vdd 0 h4_VBIAS h4_C1 h4_PREA h4_XA h4_DUTA h4_PREB h4_XB h4_DUTB h4_VB 0 0 core4

* --- t4: trap
Xt4_ienn hi 0 0 vdd vdd t4_enn sky130_fd_sc_hd__inv_1
Xt4_is1n 0 0 0 vdd vdd t4_s1n sky130_fd_sc_hd__inv_1
Xt4_is0n hi 0 0 vdd vdd t4_s0n sky130_fd_sc_hd__inv_1
Xt4_PREA pre t4_enn 0 0 vdd vdd t4_PREA sky130_fd_sc_hd__nor2_1
Xt4_PREB pre t4_enn 0 0 vdd vdd t4_PREB sky130_fd_sc_hd__nor2_1
Xt4_VBIAS hi 0 0 vdd vdd t4_VBIAS sky130_fd_sc_hd__buf_2
Xt4_C1 hi 0 0 vdd vdd t4_C1 sky130_fd_sc_hd__buf_2
Xt4_DUTA hi t4_s1n hi 0 0 vdd vdd t4_DUTA sky130_fd_sc_hd__and3_1
Xt4_DUTB hi t4_s1n hi 0 0 vdd vdd t4_DUTB sky130_fd_sc_hd__and3_1
Xt4_REFA hi 0 0 0 vdd vdd t4_REFA sky130_fd_sc_hd__and2_1
Xt4_REFB hi 0 0 0 vdd vdd t4_REFB sky130_fd_sc_hd__and2_1
Xt4_SA0B hi 0 hi 0 0 vdd vdd t4_SA0B sky130_fd_sc_hd__nand3_1
Xt4_SA1B hi 0 0 0 vdd vdd t4_SA1B sky130_fd_sc_hd__nand2_1
Xt4_SA2B hi 0 t4_s0n 0 0 vdd vdd t4_SA2B sky130_fd_sc_hd__nand3_1
Xt4_SB0B hi 0 0 0 vdd vdd t4_SB0B sky130_fd_sc_hd__nand2_1
Xt4_SB1B hi 0 0 0 vdd vdd t4_SB1B sky130_fd_sc_hd__nand2_1
Xt4_M t4_ob t4_SB0B t4_SB1B t4_REFB t4_oa t4_SA0B t4_SA1B t4_SA2B t4_REFA vdd 0 t4_VBIAS t4_C1 t4_PREA t4_XA t4_DUTA t4_PREB t4_XB t4_DUTB t4_VB 0 0 t4_GT trap4
Bt4_gt t4_GT 0 V=v(t4_VB)+0.000305

* --- r4: core
Xr4_ienn hi 0 0 vdd vdd r4_enn sky130_fd_sc_hd__inv_1
Xr4_is1n hi 0 0 vdd vdd r4_s1n sky130_fd_sc_hd__inv_1
Xr4_is0n hi 0 0 vdd vdd r4_s0n sky130_fd_sc_hd__inv_1
Xr4_PREA pre r4_enn 0 0 vdd vdd r4_PREA sky130_fd_sc_hd__nor2_1
Xr4_PREB pre r4_enn 0 0 vdd vdd r4_PREB sky130_fd_sc_hd__nor2_1
Xr4_VBIAS hi 0 0 vdd vdd r4_VBIAS sky130_fd_sc_hd__buf_2
Xr4_C1 hi 0 0 vdd vdd r4_C1 sky130_fd_sc_hd__buf_2
Xr4_DUTA hi r4_s1n hi 0 0 vdd vdd r4_DUTA sky130_fd_sc_hd__and3_1
Xr4_DUTB hi r4_s1n hi 0 0 vdd vdd r4_DUTB sky130_fd_sc_hd__and3_1
Xr4_REFA hi hi 0 0 vdd vdd r4_REFA sky130_fd_sc_hd__and2_1
Xr4_REFB hi hi 0 0 vdd vdd r4_REFB sky130_fd_sc_hd__and2_1
Xr4_SA0B hi hi hi 0 0 vdd vdd r4_SA0B sky130_fd_sc_hd__nand3_1
Xr4_SA1B hi hi 0 0 vdd vdd r4_SA1B sky130_fd_sc_hd__nand2_1
Xr4_SA2B hi hi r4_s0n 0 0 vdd vdd r4_SA2B sky130_fd_sc_hd__nand3_1
Xr4_SB0B hi hi 0 0 vdd vdd r4_SB0B sky130_fd_sc_hd__nand2_1
Xr4_SB1B hi hi 0 0 vdd vdd r4_SB1B sky130_fd_sc_hd__nand2_1
Xr4_M r4_ob r4_SB0B r4_SB1B r4_REFB r4_oa r4_SA0B r4_SA1B r4_SA2B r4_REFA vdd 0 r4_VBIAS r4_C1 r4_PREA r4_XA r4_DUTA r4_PREB r4_XB r4_DUTB r4_VB 0 0 core4

* --- c4: core
Xc4_ienn hi 0 0 vdd vdd c4_enn sky130_fd_sc_hd__inv_1
Xc4_is1n hi 0 0 vdd vdd c4_s1n sky130_fd_sc_hd__inv_1
Xc4_is0n 0 0 0 vdd vdd c4_s0n sky130_fd_sc_hd__inv_1
Xc4_PREA pre c4_enn 0 0 vdd vdd c4_PREA sky130_fd_sc_hd__nor2_1
Xc4_PREB pre c4_enn 0 0 vdd vdd c4_PREB sky130_fd_sc_hd__nor2_1
Xc4_VBIAS hi 0 0 vdd vdd c4_VBIAS sky130_fd_sc_hd__buf_2
Xc4_C1 hi 0 0 vdd vdd c4_C1 sky130_fd_sc_hd__buf_2
Xc4_DUTA hi c4_s1n 0 0 0 vdd vdd c4_DUTA sky130_fd_sc_hd__and3_1
Xc4_DUTB hi c4_s1n 0 0 0 vdd vdd c4_DUTB sky130_fd_sc_hd__and3_1
Xc4_REFA hi hi 0 0 vdd vdd c4_REFA sky130_fd_sc_hd__and2_1
Xc4_REFB hi hi 0 0 vdd vdd c4_REFB sky130_fd_sc_hd__and2_1
Xc4_SA0B hi hi 0 0 0 vdd vdd c4_SA0B sky130_fd_sc_hd__nand3_1
Xc4_SA1B hi hi 0 0 vdd vdd c4_SA1B sky130_fd_sc_hd__nand2_1
Xc4_SA2B hi hi c4_s0n 0 0 vdd vdd c4_SA2B sky130_fd_sc_hd__nand3_1
Xc4_SB0B hi hi 0 0 vdd vdd c4_SB0B sky130_fd_sc_hd__nand2_1
Xc4_SB1B hi hi 0 0 vdd vdd c4_SB1B sky130_fd_sc_hd__nand2_1
Xc4_M c4_ob c4_SB0B c4_SB1B c4_REFB c4_oa c4_SA0B c4_SA1B c4_SA2B c4_REFA vdd 0 c4_VBIAS c4_C1 c4_PREA c4_XA c4_DUTA c4_PREB c4_XB c4_DUTB c4_VB 0 0 core4

* --- h2: core
Xh2_ienn hi 0 0 vdd vdd h2_enn sky130_fd_sc_hd__inv_1
Xh2_is1n 0 0 0 vdd vdd h2_s1n sky130_fd_sc_hd__inv_1
Xh2_is0n hi 0 0 vdd vdd h2_s0n sky130_fd_sc_hd__inv_1
Xh2_PREA pre h2_enn 0 0 vdd vdd h2_PREA sky130_fd_sc_hd__nor2_1
Xh2_PREB pre h2_enn 0 0 vdd vdd h2_PREB sky130_fd_sc_hd__nor2_1
Xh2_VBIAS hi 0 0 vdd vdd h2_VBIAS sky130_fd_sc_hd__buf_2
Xh2_C1 hi 0 0 vdd vdd h2_C1 sky130_fd_sc_hd__buf_2
Xh2_DUTA hi h2_s1n hi 0 0 vdd vdd h2_DUTA sky130_fd_sc_hd__and3_1
Xh2_DUTB hi h2_s1n hi 0 0 vdd vdd h2_DUTB sky130_fd_sc_hd__and3_1
Xh2_REFA hi 0 0 0 vdd vdd h2_REFA sky130_fd_sc_hd__and2_1
Xh2_REFB hi 0 0 0 vdd vdd h2_REFB sky130_fd_sc_hd__and2_1
Xh2_SA0B hi 0 hi 0 0 vdd vdd h2_SA0B sky130_fd_sc_hd__nand3_1
Xh2_SA1B hi 0 0 0 vdd vdd h2_SA1B sky130_fd_sc_hd__nand2_1
Xh2_SA2B hi 0 h2_s0n 0 0 vdd vdd h2_SA2B sky130_fd_sc_hd__nand3_1
Xh2_SB0B hi 0 0 0 vdd vdd h2_SB0B sky130_fd_sc_hd__nand2_1
Xh2_SB1B hi 0 0 0 vdd vdd h2_SB1B sky130_fd_sc_hd__nand2_1
Xh2_M h2_ob h2_SB0B h2_SB1B h2_REFB h2_oa h2_SA0B h2_SA1B h2_SA2B h2_REFA vdd 0 h2_VBIAS h2_C1 h2_PREA h2_XA h2_DUTA h2_PREB h2_XB h2_DUTB h2_VB 0 0 core2

* --- t2: trap
Xt2_ienn hi 0 0 vdd vdd t2_enn sky130_fd_sc_hd__inv_1
Xt2_is1n 0 0 0 vdd vdd t2_s1n sky130_fd_sc_hd__inv_1
Xt2_is0n hi 0 0 vdd vdd t2_s0n sky130_fd_sc_hd__inv_1
Xt2_PREA pre t2_enn 0 0 vdd vdd t2_PREA sky130_fd_sc_hd__nor2_1
Xt2_PREB pre t2_enn 0 0 vdd vdd t2_PREB sky130_fd_sc_hd__nor2_1
Xt2_VBIAS hi 0 0 vdd vdd t2_VBIAS sky130_fd_sc_hd__buf_2
Xt2_C1 hi 0 0 vdd vdd t2_C1 sky130_fd_sc_hd__buf_2
Xt2_DUTA hi t2_s1n hi 0 0 vdd vdd t2_DUTA sky130_fd_sc_hd__and3_1
Xt2_DUTB hi t2_s1n hi 0 0 vdd vdd t2_DUTB sky130_fd_sc_hd__and3_1
Xt2_REFA hi 0 0 0 vdd vdd t2_REFA sky130_fd_sc_hd__and2_1
Xt2_REFB hi 0 0 0 vdd vdd t2_REFB sky130_fd_sc_hd__and2_1
Xt2_SA0B hi 0 hi 0 0 vdd vdd t2_SA0B sky130_fd_sc_hd__nand3_1
Xt2_SA1B hi 0 0 0 vdd vdd t2_SA1B sky130_fd_sc_hd__nand2_1
Xt2_SA2B hi 0 t2_s0n 0 0 vdd vdd t2_SA2B sky130_fd_sc_hd__nand3_1
Xt2_SB0B hi 0 0 0 vdd vdd t2_SB0B sky130_fd_sc_hd__nand2_1
Xt2_SB1B hi 0 0 0 vdd vdd t2_SB1B sky130_fd_sc_hd__nand2_1
Xt2_M t2_ob t2_SB0B t2_SB1B t2_REFB t2_oa t2_SA0B t2_SA1B t2_SA2B t2_REFA vdd 0 t2_VBIAS t2_C1 t2_PREA t2_XA t2_DUTA t2_PREB t2_XB t2_DUTB t2_VB 0 0 t2_GT trap2
Bt2_gt t2_GT 0 V=v(t2_VB)+0.000305

* --- r2: core
Xr2_ienn hi 0 0 vdd vdd r2_enn sky130_fd_sc_hd__inv_1
Xr2_is1n hi 0 0 vdd vdd r2_s1n sky130_fd_sc_hd__inv_1
Xr2_is0n hi 0 0 vdd vdd r2_s0n sky130_fd_sc_hd__inv_1
Xr2_PREA pre r2_enn 0 0 vdd vdd r2_PREA sky130_fd_sc_hd__nor2_1
Xr2_PREB pre r2_enn 0 0 vdd vdd r2_PREB sky130_fd_sc_hd__nor2_1
Xr2_VBIAS hi 0 0 vdd vdd r2_VBIAS sky130_fd_sc_hd__buf_2
Xr2_C1 hi 0 0 vdd vdd r2_C1 sky130_fd_sc_hd__buf_2
Xr2_DUTA hi r2_s1n hi 0 0 vdd vdd r2_DUTA sky130_fd_sc_hd__and3_1
Xr2_DUTB hi r2_s1n hi 0 0 vdd vdd r2_DUTB sky130_fd_sc_hd__and3_1
Xr2_REFA hi hi 0 0 vdd vdd r2_REFA sky130_fd_sc_hd__and2_1
Xr2_REFB hi hi 0 0 vdd vdd r2_REFB sky130_fd_sc_hd__and2_1
Xr2_SA0B hi hi hi 0 0 vdd vdd r2_SA0B sky130_fd_sc_hd__nand3_1
Xr2_SA1B hi hi 0 0 vdd vdd r2_SA1B sky130_fd_sc_hd__nand2_1
Xr2_SA2B hi hi r2_s0n 0 0 vdd vdd r2_SA2B sky130_fd_sc_hd__nand3_1
Xr2_SB0B hi hi 0 0 vdd vdd r2_SB0B sky130_fd_sc_hd__nand2_1
Xr2_SB1B hi hi 0 0 vdd vdd r2_SB1B sky130_fd_sc_hd__nand2_1
Xr2_M r2_ob r2_SB0B r2_SB1B r2_REFB r2_oa r2_SA0B r2_SA1B r2_SA2B r2_REFA vdd 0 r2_VBIAS r2_C1 r2_PREA r2_XA r2_DUTA r2_PREB r2_XB r2_DUTB r2_VB 0 0 core2

* --- c2: core
Xc2_ienn hi 0 0 vdd vdd c2_enn sky130_fd_sc_hd__inv_1
Xc2_is1n hi 0 0 vdd vdd c2_s1n sky130_fd_sc_hd__inv_1
Xc2_is0n 0 0 0 vdd vdd c2_s0n sky130_fd_sc_hd__inv_1
Xc2_PREA pre c2_enn 0 0 vdd vdd c2_PREA sky130_fd_sc_hd__nor2_1
Xc2_PREB pre c2_enn 0 0 vdd vdd c2_PREB sky130_fd_sc_hd__nor2_1
Xc2_VBIAS hi 0 0 vdd vdd c2_VBIAS sky130_fd_sc_hd__buf_2
Xc2_C1 hi 0 0 vdd vdd c2_C1 sky130_fd_sc_hd__buf_2
Xc2_DUTA hi c2_s1n 0 0 0 vdd vdd c2_DUTA sky130_fd_sc_hd__and3_1
Xc2_DUTB hi c2_s1n 0 0 0 vdd vdd c2_DUTB sky130_fd_sc_hd__and3_1
Xc2_REFA hi hi 0 0 vdd vdd c2_REFA sky130_fd_sc_hd__and2_1
Xc2_REFB hi hi 0 0 vdd vdd c2_REFB sky130_fd_sc_hd__and2_1
Xc2_SA0B hi hi 0 0 0 vdd vdd c2_SA0B sky130_fd_sc_hd__nand3_1
Xc2_SA1B hi hi 0 0 vdd vdd c2_SA1B sky130_fd_sc_hd__nand2_1
Xc2_SA2B hi hi c2_s0n 0 0 vdd vdd c2_SA2B sky130_fd_sc_hd__nand3_1
Xc2_SB0B hi hi 0 0 vdd vdd c2_SB0B sky130_fd_sc_hd__nand2_1
Xc2_SB1B hi hi 0 0 vdd vdd c2_SB1B sky130_fd_sc_hd__nand2_1
Xc2_M c2_ob c2_SB0B c2_SB1B c2_REFB c2_oa c2_SA0B c2_SA1B c2_SA2B c2_REFA vdd 0 c2_VBIAS c2_C1 c2_PREA c2_XA c2_DUTA c2_PREB c2_XB c2_DUTB c2_VB 0 0 core2

* --- h0: core
Xh0_ienn hi 0 0 vdd vdd h0_enn sky130_fd_sc_hd__inv_1
Xh0_is1n 0 0 0 vdd vdd h0_s1n sky130_fd_sc_hd__inv_1
Xh0_is0n hi 0 0 vdd vdd h0_s0n sky130_fd_sc_hd__inv_1
Xh0_PREA pre h0_enn 0 0 vdd vdd h0_PREA sky130_fd_sc_hd__nor2_1
Xh0_PREB pre h0_enn 0 0 vdd vdd h0_PREB sky130_fd_sc_hd__nor2_1
Xh0_VBIAS hi 0 0 vdd vdd h0_VBIAS sky130_fd_sc_hd__buf_2
Xh0_C1 hi 0 0 vdd vdd h0_C1 sky130_fd_sc_hd__buf_2
Xh0_DUTA hi h0_s1n hi 0 0 vdd vdd h0_DUTA sky130_fd_sc_hd__and3_1
Xh0_DUTB hi h0_s1n hi 0 0 vdd vdd h0_DUTB sky130_fd_sc_hd__and3_1
Xh0_REFA hi 0 0 0 vdd vdd h0_REFA sky130_fd_sc_hd__and2_1
Xh0_REFB hi 0 0 0 vdd vdd h0_REFB sky130_fd_sc_hd__and2_1
Xh0_SA0B hi 0 hi 0 0 vdd vdd h0_SA0B sky130_fd_sc_hd__nand3_1
Xh0_SA1B hi 0 0 0 vdd vdd h0_SA1B sky130_fd_sc_hd__nand2_1
Xh0_SA2B hi 0 h0_s0n 0 0 vdd vdd h0_SA2B sky130_fd_sc_hd__nand3_1
Xh0_SB0B hi 0 0 0 vdd vdd h0_SB0B sky130_fd_sc_hd__nand2_1
Xh0_SB1B hi 0 0 0 vdd vdd h0_SB1B sky130_fd_sc_hd__nand2_1
Xh0_M h0_ob h0_SB0B h0_SB1B h0_REFB h0_oa h0_SA0B h0_SA1B h0_SA2B h0_REFA vdd 0 h0_VBIAS h0_C1 h0_PREA h0_XA h0_DUTA h0_PREB h0_XB h0_DUTB h0_VB 0 0 core0

* --- t0: trap
Xt0_ienn hi 0 0 vdd vdd t0_enn sky130_fd_sc_hd__inv_1
Xt0_is1n 0 0 0 vdd vdd t0_s1n sky130_fd_sc_hd__inv_1
Xt0_is0n hi 0 0 vdd vdd t0_s0n sky130_fd_sc_hd__inv_1
Xt0_PREA pre t0_enn 0 0 vdd vdd t0_PREA sky130_fd_sc_hd__nor2_1
Xt0_PREB pre t0_enn 0 0 vdd vdd t0_PREB sky130_fd_sc_hd__nor2_1
Xt0_VBIAS hi 0 0 vdd vdd t0_VBIAS sky130_fd_sc_hd__buf_2
Xt0_C1 hi 0 0 vdd vdd t0_C1 sky130_fd_sc_hd__buf_2
Xt0_DUTA hi t0_s1n hi 0 0 vdd vdd t0_DUTA sky130_fd_sc_hd__and3_1
Xt0_DUTB hi t0_s1n hi 0 0 vdd vdd t0_DUTB sky130_fd_sc_hd__and3_1
Xt0_REFA hi 0 0 0 vdd vdd t0_REFA sky130_fd_sc_hd__and2_1
Xt0_REFB hi 0 0 0 vdd vdd t0_REFB sky130_fd_sc_hd__and2_1
Xt0_SA0B hi 0 hi 0 0 vdd vdd t0_SA0B sky130_fd_sc_hd__nand3_1
Xt0_SA1B hi 0 0 0 vdd vdd t0_SA1B sky130_fd_sc_hd__nand2_1
Xt0_SA2B hi 0 t0_s0n 0 0 vdd vdd t0_SA2B sky130_fd_sc_hd__nand3_1
Xt0_SB0B hi 0 0 0 vdd vdd t0_SB0B sky130_fd_sc_hd__nand2_1
Xt0_SB1B hi 0 0 0 vdd vdd t0_SB1B sky130_fd_sc_hd__nand2_1
Xt0_M t0_ob t0_SB0B t0_SB1B t0_REFB t0_oa t0_SA0B t0_SA1B t0_SA2B t0_REFA vdd 0 t0_VBIAS t0_C1 t0_PREA t0_XA t0_DUTA t0_PREB t0_XB t0_DUTB t0_VB 0 0 t0_GT trap0
Bt0_gt t0_GT 0 V=v(t0_VB)+0.000305

* --- r0: core
Xr0_ienn hi 0 0 vdd vdd r0_enn sky130_fd_sc_hd__inv_1
Xr0_is1n hi 0 0 vdd vdd r0_s1n sky130_fd_sc_hd__inv_1
Xr0_is0n hi 0 0 vdd vdd r0_s0n sky130_fd_sc_hd__inv_1
Xr0_PREA pre r0_enn 0 0 vdd vdd r0_PREA sky130_fd_sc_hd__nor2_1
Xr0_PREB pre r0_enn 0 0 vdd vdd r0_PREB sky130_fd_sc_hd__nor2_1
Xr0_VBIAS hi 0 0 vdd vdd r0_VBIAS sky130_fd_sc_hd__buf_2
Xr0_C1 hi 0 0 vdd vdd r0_C1 sky130_fd_sc_hd__buf_2
Xr0_DUTA hi r0_s1n hi 0 0 vdd vdd r0_DUTA sky130_fd_sc_hd__and3_1
Xr0_DUTB hi r0_s1n hi 0 0 vdd vdd r0_DUTB sky130_fd_sc_hd__and3_1
Xr0_REFA hi hi 0 0 vdd vdd r0_REFA sky130_fd_sc_hd__and2_1
Xr0_REFB hi hi 0 0 vdd vdd r0_REFB sky130_fd_sc_hd__and2_1
Xr0_SA0B hi hi hi 0 0 vdd vdd r0_SA0B sky130_fd_sc_hd__nand3_1
Xr0_SA1B hi hi 0 0 vdd vdd r0_SA1B sky130_fd_sc_hd__nand2_1
Xr0_SA2B hi hi r0_s0n 0 0 vdd vdd r0_SA2B sky130_fd_sc_hd__nand3_1
Xr0_SB0B hi hi 0 0 vdd vdd r0_SB0B sky130_fd_sc_hd__nand2_1
Xr0_SB1B hi hi 0 0 vdd vdd r0_SB1B sky130_fd_sc_hd__nand2_1
Xr0_M r0_ob r0_SB0B r0_SB1B r0_REFB r0_oa r0_SA0B r0_SA1B r0_SA2B r0_REFA vdd 0 r0_VBIAS r0_C1 r0_PREA r0_XA r0_DUTA r0_PREB r0_XB r0_DUTB r0_VB 0 0 core0

* --- c0: core
Xc0_ienn hi 0 0 vdd vdd c0_enn sky130_fd_sc_hd__inv_1
Xc0_is1n hi 0 0 vdd vdd c0_s1n sky130_fd_sc_hd__inv_1
Xc0_is0n 0 0 0 vdd vdd c0_s0n sky130_fd_sc_hd__inv_1
Xc0_PREA pre c0_enn 0 0 vdd vdd c0_PREA sky130_fd_sc_hd__nor2_1
Xc0_PREB pre c0_enn 0 0 vdd vdd c0_PREB sky130_fd_sc_hd__nor2_1
Xc0_VBIAS hi 0 0 vdd vdd c0_VBIAS sky130_fd_sc_hd__buf_2
Xc0_C1 hi 0 0 vdd vdd c0_C1 sky130_fd_sc_hd__buf_2
Xc0_DUTA hi c0_s1n 0 0 0 vdd vdd c0_DUTA sky130_fd_sc_hd__and3_1
Xc0_DUTB hi c0_s1n 0 0 0 vdd vdd c0_DUTB sky130_fd_sc_hd__and3_1
Xc0_REFA hi hi 0 0 vdd vdd c0_REFA sky130_fd_sc_hd__and2_1
Xc0_REFB hi hi 0 0 vdd vdd c0_REFB sky130_fd_sc_hd__and2_1
Xc0_SA0B hi hi 0 0 0 vdd vdd c0_SA0B sky130_fd_sc_hd__nand3_1
Xc0_SA1B hi hi 0 0 vdd vdd c0_SA1B sky130_fd_sc_hd__nand2_1
Xc0_SA2B hi hi c0_s0n 0 0 vdd vdd c0_SA2B sky130_fd_sc_hd__nand3_1
Xc0_SB0B hi hi 0 0 vdd vdd c0_SB0B sky130_fd_sc_hd__nand2_1
Xc0_SB1B hi hi 0 0 vdd vdd c0_SB1B sky130_fd_sc_hd__nand2_1
Xc0_M c0_ob c0_SB0B c0_SB1B c0_REFB c0_oa c0_SA0B c0_SA1B c0_SA2B c0_REFA vdd 0 c0_VBIAS c0_C1 c0_PREA c0_XA c0_DUTA c0_PREB c0_XB c0_DUTB c0_VB 0 0 core0

.control
set noaskquit
save v(h33_oa) v(h33_ob) v(h33_VB) v(t33_oa) v(t33_ob) v(t33_VB) v(r33_oa) v(r33_ob) v(r33_VB) v(c33_oa) v(c33_ob) v(c33_VB) v(h16_oa) v(h16_ob) v(h16_VB) v(t16_oa) v(t16_ob) v(t16_VB) v(r16_oa) v(r16_ob) v(r16_VB) v(c16_oa) v(c16_ob) v(c16_VB) v(h8_oa) v(h8_ob) v(h8_VB) v(t8_oa) v(t8_ob) v(t8_VB) v(r8_oa) v(r8_ob) v(r8_VB) v(c8_oa) v(c8_ob) v(c8_VB) v(h4_oa) v(h4_ob) v(h4_VB) v(t4_oa) v(t4_ob) v(t4_VB) v(r4_oa) v(r4_ob) v(r4_VB) v(c4_oa) v(c4_ob) v(c4_VB) v(h2_oa) v(h2_ob) v(h2_VB) v(t2_oa) v(t2_ob) v(t2_VB) v(r2_oa) v(r2_ob) v(r2_VB) v(c2_oa) v(c2_ob) v(c2_VB) v(h0_oa) v(h0_ob) v(h0_VB) v(t0_oa) v(t0_ob) v(t0_VB) v(r0_oa) v(r0_ob) v(r0_VB) v(c0_oa) v(c0_ob) v(c0_VB)
tran 10n 160u
meas tran h33_oa when v(h33_oa)=0.9 rise=1
echo M7 ff -40 h33_oa $&h33_oa
meas tran h33_ob when v(h33_ob)=0.9 rise=1
echo M7 ff -40 h33_ob $&h33_ob
meas tran h33_vb find v(h33_VB) at=0.9e-6
echo M7 ff -40 h33_vb $&h33_vb
meas tran t33_oa when v(t33_oa)=0.9 rise=1
echo M7 ff -40 t33_oa $&t33_oa
meas tran t33_ob when v(t33_ob)=0.9 rise=1
echo M7 ff -40 t33_ob $&t33_ob
meas tran t33_vb find v(t33_VB) at=0.9e-6
echo M7 ff -40 t33_vb $&t33_vb
meas tran r33_oa when v(r33_oa)=0.9 rise=1
echo M7 ff -40 r33_oa $&r33_oa
meas tran r33_ob when v(r33_ob)=0.9 rise=1
echo M7 ff -40 r33_ob $&r33_ob
meas tran r33_vb find v(r33_VB) at=0.9e-6
echo M7 ff -40 r33_vb $&r33_vb
meas tran c33_oa when v(c33_oa)=0.9 rise=1
echo M7 ff -40 c33_oa $&c33_oa
meas tran c33_ob when v(c33_ob)=0.9 rise=1
echo M7 ff -40 c33_ob $&c33_ob
meas tran c33_vb find v(c33_VB) at=0.9e-6
echo M7 ff -40 c33_vb $&c33_vb
meas tran h16_oa when v(h16_oa)=0.9 rise=1
echo M7 ff -40 h16_oa $&h16_oa
meas tran h16_ob when v(h16_ob)=0.9 rise=1
echo M7 ff -40 h16_ob $&h16_ob
meas tran h16_vb find v(h16_VB) at=0.9e-6
echo M7 ff -40 h16_vb $&h16_vb
meas tran t16_oa when v(t16_oa)=0.9 rise=1
echo M7 ff -40 t16_oa $&t16_oa
meas tran t16_ob when v(t16_ob)=0.9 rise=1
echo M7 ff -40 t16_ob $&t16_ob
meas tran t16_vb find v(t16_VB) at=0.9e-6
echo M7 ff -40 t16_vb $&t16_vb
meas tran r16_oa when v(r16_oa)=0.9 rise=1
echo M7 ff -40 r16_oa $&r16_oa
meas tran r16_ob when v(r16_ob)=0.9 rise=1
echo M7 ff -40 r16_ob $&r16_ob
meas tran r16_vb find v(r16_VB) at=0.9e-6
echo M7 ff -40 r16_vb $&r16_vb
meas tran c16_oa when v(c16_oa)=0.9 rise=1
echo M7 ff -40 c16_oa $&c16_oa
meas tran c16_ob when v(c16_ob)=0.9 rise=1
echo M7 ff -40 c16_ob $&c16_ob
meas tran c16_vb find v(c16_VB) at=0.9e-6
echo M7 ff -40 c16_vb $&c16_vb
meas tran h8_oa when v(h8_oa)=0.9 rise=1
echo M7 ff -40 h8_oa $&h8_oa
meas tran h8_ob when v(h8_ob)=0.9 rise=1
echo M7 ff -40 h8_ob $&h8_ob
meas tran h8_vb find v(h8_VB) at=0.9e-6
echo M7 ff -40 h8_vb $&h8_vb
meas tran t8_oa when v(t8_oa)=0.9 rise=1
echo M7 ff -40 t8_oa $&t8_oa
meas tran t8_ob when v(t8_ob)=0.9 rise=1
echo M7 ff -40 t8_ob $&t8_ob
meas tran t8_vb find v(t8_VB) at=0.9e-6
echo M7 ff -40 t8_vb $&t8_vb
meas tran r8_oa when v(r8_oa)=0.9 rise=1
echo M7 ff -40 r8_oa $&r8_oa
meas tran r8_ob when v(r8_ob)=0.9 rise=1
echo M7 ff -40 r8_ob $&r8_ob
meas tran r8_vb find v(r8_VB) at=0.9e-6
echo M7 ff -40 r8_vb $&r8_vb
meas tran c8_oa when v(c8_oa)=0.9 rise=1
echo M7 ff -40 c8_oa $&c8_oa
meas tran c8_ob when v(c8_ob)=0.9 rise=1
echo M7 ff -40 c8_ob $&c8_ob
meas tran c8_vb find v(c8_VB) at=0.9e-6
echo M7 ff -40 c8_vb $&c8_vb
meas tran h4_oa when v(h4_oa)=0.9 rise=1
echo M7 ff -40 h4_oa $&h4_oa
meas tran h4_ob when v(h4_ob)=0.9 rise=1
echo M7 ff -40 h4_ob $&h4_ob
meas tran h4_vb find v(h4_VB) at=0.9e-6
echo M7 ff -40 h4_vb $&h4_vb
meas tran t4_oa when v(t4_oa)=0.9 rise=1
echo M7 ff -40 t4_oa $&t4_oa
meas tran t4_ob when v(t4_ob)=0.9 rise=1
echo M7 ff -40 t4_ob $&t4_ob
meas tran t4_vb find v(t4_VB) at=0.9e-6
echo M7 ff -40 t4_vb $&t4_vb
meas tran r4_oa when v(r4_oa)=0.9 rise=1
echo M7 ff -40 r4_oa $&r4_oa
meas tran r4_ob when v(r4_ob)=0.9 rise=1
echo M7 ff -40 r4_ob $&r4_ob
meas tran r4_vb find v(r4_VB) at=0.9e-6
echo M7 ff -40 r4_vb $&r4_vb
meas tran c4_oa when v(c4_oa)=0.9 rise=1
echo M7 ff -40 c4_oa $&c4_oa
meas tran c4_ob when v(c4_ob)=0.9 rise=1
echo M7 ff -40 c4_ob $&c4_ob
meas tran c4_vb find v(c4_VB) at=0.9e-6
echo M7 ff -40 c4_vb $&c4_vb
meas tran h2_oa when v(h2_oa)=0.9 rise=1
echo M7 ff -40 h2_oa $&h2_oa
meas tran h2_ob when v(h2_ob)=0.9 rise=1
echo M7 ff -40 h2_ob $&h2_ob
meas tran h2_vb find v(h2_VB) at=0.9e-6
echo M7 ff -40 h2_vb $&h2_vb
meas tran t2_oa when v(t2_oa)=0.9 rise=1
echo M7 ff -40 t2_oa $&t2_oa
meas tran t2_ob when v(t2_ob)=0.9 rise=1
echo M7 ff -40 t2_ob $&t2_ob
meas tran t2_vb find v(t2_VB) at=0.9e-6
echo M7 ff -40 t2_vb $&t2_vb
meas tran r2_oa when v(r2_oa)=0.9 rise=1
echo M7 ff -40 r2_oa $&r2_oa
meas tran r2_ob when v(r2_ob)=0.9 rise=1
echo M7 ff -40 r2_ob $&r2_ob
meas tran r2_vb find v(r2_VB) at=0.9e-6
echo M7 ff -40 r2_vb $&r2_vb
meas tran c2_oa when v(c2_oa)=0.9 rise=1
echo M7 ff -40 c2_oa $&c2_oa
meas tran c2_ob when v(c2_ob)=0.9 rise=1
echo M7 ff -40 c2_ob $&c2_ob
meas tran c2_vb find v(c2_VB) at=0.9e-6
echo M7 ff -40 c2_vb $&c2_vb
meas tran h0_oa when v(h0_oa)=0.9 rise=1
echo M7 ff -40 h0_oa $&h0_oa
meas tran h0_ob when v(h0_ob)=0.9 rise=1
echo M7 ff -40 h0_ob $&h0_ob
meas tran h0_vb find v(h0_VB) at=0.9e-6
echo M7 ff -40 h0_vb $&h0_vb
meas tran t0_oa when v(t0_oa)=0.9 rise=1
echo M7 ff -40 t0_oa $&t0_oa
meas tran t0_ob when v(t0_ob)=0.9 rise=1
echo M7 ff -40 t0_ob $&t0_ob
meas tran t0_vb find v(t0_VB) at=0.9e-6
echo M7 ff -40 t0_vb $&t0_vb
meas tran r0_oa when v(r0_oa)=0.9 rise=1
echo M7 ff -40 r0_oa $&r0_oa
meas tran r0_ob when v(r0_ob)=0.9 rise=1
echo M7 ff -40 r0_ob $&r0_ob
meas tran r0_vb find v(r0_VB) at=0.9e-6
echo M7 ff -40 r0_vb $&r0_vb
meas tran c0_oa when v(c0_oa)=0.9 rise=1
echo M7 ff -40 c0_oa $&c0_oa
meas tran c0_ob when v(c0_ob)=0.9 rise=1
echo M7 ff -40 c0_ob $&c0_ob
meas tran c0_vb find v(c0_VB) at=0.9e-6
echo M7 ff -40 c0_vb $&c0_vb
quit
.endc
.end
