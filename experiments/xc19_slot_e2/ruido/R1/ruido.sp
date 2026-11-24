* MISFIT-03 etapa a · enmienda 2 ruido src=11 k=1.0 · esquina tt 27 C. Generado por gen_contrato.py (no editar a mano).
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
Vd vdd 0 1.8
Vh hi 0 1.8
Vpre pre 0 pwl(0 1.8 1e-06 1.8 1.001e-06 0)
* --- n0: core
Xn0_ienn hi 0 0 vdd vdd n0_enn sky130_fd_sc_hd__inv_1
Xn0_is1n hi 0 0 vdd vdd n0_s1n sky130_fd_sc_hd__inv_1
Xn0_is0n hi 0 0 vdd vdd n0_s0n sky130_fd_sc_hd__inv_1
Xn0_PREA pre n0_enn 0 0 vdd vdd n0_PREA sky130_fd_sc_hd__nor2_1
Xn0_PREB pre n0_enn 0 0 vdd vdd n0_PREB sky130_fd_sc_hd__nor2_1
Xn0_VBIAS hi 0 0 vdd vdd n0_VBIAS sky130_fd_sc_hd__buf_2
Xn0_C1 hi 0 0 vdd vdd n0_C1 sky130_fd_sc_hd__buf_2
Xn0_DUTA hi n0_s1n hi 0 0 vdd vdd n0_DUTA sky130_fd_sc_hd__and3_1
Xn0_DUTB hi n0_s1n hi 0 0 vdd vdd n0_DUTB sky130_fd_sc_hd__and3_1
Xn0_REFA hi hi 0 0 vdd vdd n0_REFA sky130_fd_sc_hd__and2_1
Xn0_REFB hi hi 0 0 vdd vdd n0_REFB sky130_fd_sc_hd__and2_1
Xn0_SA0B hi hi hi 0 0 vdd vdd n0_SA0B sky130_fd_sc_hd__nand3_1
Xn0_SA1B hi hi 0 0 vdd vdd n0_SA1B sky130_fd_sc_hd__nand2_1
Xn0_SA2B hi hi n0_s0n 0 0 vdd vdd n0_SA2B sky130_fd_sc_hd__nand3_1
Xn0_SB0B hi hi 0 0 vdd vdd n0_SB0B sky130_fd_sc_hd__nand2_1
Xn0_SB1B hi hi 0 0 vdd vdd n0_SB1B sky130_fd_sc_hd__nand2_1
Xn0_M n0_ob n0_SB0B n0_SB1B n0_REFB n0_oa n0_SA0B n0_SA1B n0_SA2B n0_REFA vdd 0 n0_VBIAS n0_C1 n0_PREA n0_XA n0_DUTA n0_PREB n0_XB n0_DUTB n0_VB 0 0 core

In0XA n0_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In0XB n0_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
* --- n1: core
Xn1_ienn hi 0 0 vdd vdd n1_enn sky130_fd_sc_hd__inv_1
Xn1_is1n hi 0 0 vdd vdd n1_s1n sky130_fd_sc_hd__inv_1
Xn1_is0n hi 0 0 vdd vdd n1_s0n sky130_fd_sc_hd__inv_1
Xn1_PREA pre n1_enn 0 0 vdd vdd n1_PREA sky130_fd_sc_hd__nor2_1
Xn1_PREB pre n1_enn 0 0 vdd vdd n1_PREB sky130_fd_sc_hd__nor2_1
Xn1_VBIAS hi 0 0 vdd vdd n1_VBIAS sky130_fd_sc_hd__buf_2
Xn1_C1 hi 0 0 vdd vdd n1_C1 sky130_fd_sc_hd__buf_2
Xn1_DUTA hi n1_s1n hi 0 0 vdd vdd n1_DUTA sky130_fd_sc_hd__and3_1
Xn1_DUTB hi n1_s1n hi 0 0 vdd vdd n1_DUTB sky130_fd_sc_hd__and3_1
Xn1_REFA hi hi 0 0 vdd vdd n1_REFA sky130_fd_sc_hd__and2_1
Xn1_REFB hi hi 0 0 vdd vdd n1_REFB sky130_fd_sc_hd__and2_1
Xn1_SA0B hi hi hi 0 0 vdd vdd n1_SA0B sky130_fd_sc_hd__nand3_1
Xn1_SA1B hi hi 0 0 vdd vdd n1_SA1B sky130_fd_sc_hd__nand2_1
Xn1_SA2B hi hi n1_s0n 0 0 vdd vdd n1_SA2B sky130_fd_sc_hd__nand3_1
Xn1_SB0B hi hi 0 0 vdd vdd n1_SB0B sky130_fd_sc_hd__nand2_1
Xn1_SB1B hi hi 0 0 vdd vdd n1_SB1B sky130_fd_sc_hd__nand2_1
Xn1_M n1_ob n1_SB0B n1_SB1B n1_REFB n1_oa n1_SA0B n1_SA1B n1_SA2B n1_REFA vdd 0 n1_VBIAS n1_C1 n1_PREA n1_XA n1_DUTA n1_PREB n1_XB n1_DUTB n1_VB 0 0 core

In1XA n1_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In1XB n1_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
* --- n2: core
Xn2_ienn hi 0 0 vdd vdd n2_enn sky130_fd_sc_hd__inv_1
Xn2_is1n hi 0 0 vdd vdd n2_s1n sky130_fd_sc_hd__inv_1
Xn2_is0n hi 0 0 vdd vdd n2_s0n sky130_fd_sc_hd__inv_1
Xn2_PREA pre n2_enn 0 0 vdd vdd n2_PREA sky130_fd_sc_hd__nor2_1
Xn2_PREB pre n2_enn 0 0 vdd vdd n2_PREB sky130_fd_sc_hd__nor2_1
Xn2_VBIAS hi 0 0 vdd vdd n2_VBIAS sky130_fd_sc_hd__buf_2
Xn2_C1 hi 0 0 vdd vdd n2_C1 sky130_fd_sc_hd__buf_2
Xn2_DUTA hi n2_s1n hi 0 0 vdd vdd n2_DUTA sky130_fd_sc_hd__and3_1
Xn2_DUTB hi n2_s1n hi 0 0 vdd vdd n2_DUTB sky130_fd_sc_hd__and3_1
Xn2_REFA hi hi 0 0 vdd vdd n2_REFA sky130_fd_sc_hd__and2_1
Xn2_REFB hi hi 0 0 vdd vdd n2_REFB sky130_fd_sc_hd__and2_1
Xn2_SA0B hi hi hi 0 0 vdd vdd n2_SA0B sky130_fd_sc_hd__nand3_1
Xn2_SA1B hi hi 0 0 vdd vdd n2_SA1B sky130_fd_sc_hd__nand2_1
Xn2_SA2B hi hi n2_s0n 0 0 vdd vdd n2_SA2B sky130_fd_sc_hd__nand3_1
Xn2_SB0B hi hi 0 0 vdd vdd n2_SB0B sky130_fd_sc_hd__nand2_1
Xn2_SB1B hi hi 0 0 vdd vdd n2_SB1B sky130_fd_sc_hd__nand2_1
Xn2_M n2_ob n2_SB0B n2_SB1B n2_REFB n2_oa n2_SA0B n2_SA1B n2_SA2B n2_REFA vdd 0 n2_VBIAS n2_C1 n2_PREA n2_XA n2_DUTA n2_PREB n2_XB n2_DUTB n2_VB 0 0 core

In2XA n2_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In2XB n2_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
* --- n3: core
Xn3_ienn hi 0 0 vdd vdd n3_enn sky130_fd_sc_hd__inv_1
Xn3_is1n hi 0 0 vdd vdd n3_s1n sky130_fd_sc_hd__inv_1
Xn3_is0n hi 0 0 vdd vdd n3_s0n sky130_fd_sc_hd__inv_1
Xn3_PREA pre n3_enn 0 0 vdd vdd n3_PREA sky130_fd_sc_hd__nor2_1
Xn3_PREB pre n3_enn 0 0 vdd vdd n3_PREB sky130_fd_sc_hd__nor2_1
Xn3_VBIAS hi 0 0 vdd vdd n3_VBIAS sky130_fd_sc_hd__buf_2
Xn3_C1 hi 0 0 vdd vdd n3_C1 sky130_fd_sc_hd__buf_2
Xn3_DUTA hi n3_s1n hi 0 0 vdd vdd n3_DUTA sky130_fd_sc_hd__and3_1
Xn3_DUTB hi n3_s1n hi 0 0 vdd vdd n3_DUTB sky130_fd_sc_hd__and3_1
Xn3_REFA hi hi 0 0 vdd vdd n3_REFA sky130_fd_sc_hd__and2_1
Xn3_REFB hi hi 0 0 vdd vdd n3_REFB sky130_fd_sc_hd__and2_1
Xn3_SA0B hi hi hi 0 0 vdd vdd n3_SA0B sky130_fd_sc_hd__nand3_1
Xn3_SA1B hi hi 0 0 vdd vdd n3_SA1B sky130_fd_sc_hd__nand2_1
Xn3_SA2B hi hi n3_s0n 0 0 vdd vdd n3_SA2B sky130_fd_sc_hd__nand3_1
Xn3_SB0B hi hi 0 0 vdd vdd n3_SB0B sky130_fd_sc_hd__nand2_1
Xn3_SB1B hi hi 0 0 vdd vdd n3_SB1B sky130_fd_sc_hd__nand2_1
Xn3_M n3_ob n3_SB0B n3_SB1B n3_REFB n3_oa n3_SA0B n3_SA1B n3_SA2B n3_REFA vdd 0 n3_VBIAS n3_C1 n3_PREA n3_XA n3_DUTA n3_PREB n3_XB n3_DUTB n3_VB 0 0 core

In3XA n3_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In3XB n3_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
* --- n4: core
Xn4_ienn hi 0 0 vdd vdd n4_enn sky130_fd_sc_hd__inv_1
Xn4_is1n hi 0 0 vdd vdd n4_s1n sky130_fd_sc_hd__inv_1
Xn4_is0n hi 0 0 vdd vdd n4_s0n sky130_fd_sc_hd__inv_1
Xn4_PREA pre n4_enn 0 0 vdd vdd n4_PREA sky130_fd_sc_hd__nor2_1
Xn4_PREB pre n4_enn 0 0 vdd vdd n4_PREB sky130_fd_sc_hd__nor2_1
Xn4_VBIAS hi 0 0 vdd vdd n4_VBIAS sky130_fd_sc_hd__buf_2
Xn4_C1 hi 0 0 vdd vdd n4_C1 sky130_fd_sc_hd__buf_2
Xn4_DUTA hi n4_s1n hi 0 0 vdd vdd n4_DUTA sky130_fd_sc_hd__and3_1
Xn4_DUTB hi n4_s1n hi 0 0 vdd vdd n4_DUTB sky130_fd_sc_hd__and3_1
Xn4_REFA hi hi 0 0 vdd vdd n4_REFA sky130_fd_sc_hd__and2_1
Xn4_REFB hi hi 0 0 vdd vdd n4_REFB sky130_fd_sc_hd__and2_1
Xn4_SA0B hi hi hi 0 0 vdd vdd n4_SA0B sky130_fd_sc_hd__nand3_1
Xn4_SA1B hi hi 0 0 vdd vdd n4_SA1B sky130_fd_sc_hd__nand2_1
Xn4_SA2B hi hi n4_s0n 0 0 vdd vdd n4_SA2B sky130_fd_sc_hd__nand3_1
Xn4_SB0B hi hi 0 0 vdd vdd n4_SB0B sky130_fd_sc_hd__nand2_1
Xn4_SB1B hi hi 0 0 vdd vdd n4_SB1B sky130_fd_sc_hd__nand2_1
Xn4_M n4_ob n4_SB0B n4_SB1B n4_REFB n4_oa n4_SA0B n4_SA1B n4_SA2B n4_REFA vdd 0 n4_VBIAS n4_C1 n4_PREA n4_XA n4_DUTA n4_PREB n4_XB n4_DUTB n4_VB 0 0 core

In4XA n4_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In4XB n4_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
* --- n5: core
Xn5_ienn hi 0 0 vdd vdd n5_enn sky130_fd_sc_hd__inv_1
Xn5_is1n hi 0 0 vdd vdd n5_s1n sky130_fd_sc_hd__inv_1
Xn5_is0n hi 0 0 vdd vdd n5_s0n sky130_fd_sc_hd__inv_1
Xn5_PREA pre n5_enn 0 0 vdd vdd n5_PREA sky130_fd_sc_hd__nor2_1
Xn5_PREB pre n5_enn 0 0 vdd vdd n5_PREB sky130_fd_sc_hd__nor2_1
Xn5_VBIAS hi 0 0 vdd vdd n5_VBIAS sky130_fd_sc_hd__buf_2
Xn5_C1 hi 0 0 vdd vdd n5_C1 sky130_fd_sc_hd__buf_2
Xn5_DUTA hi n5_s1n hi 0 0 vdd vdd n5_DUTA sky130_fd_sc_hd__and3_1
Xn5_DUTB hi n5_s1n hi 0 0 vdd vdd n5_DUTB sky130_fd_sc_hd__and3_1
Xn5_REFA hi hi 0 0 vdd vdd n5_REFA sky130_fd_sc_hd__and2_1
Xn5_REFB hi hi 0 0 vdd vdd n5_REFB sky130_fd_sc_hd__and2_1
Xn5_SA0B hi hi hi 0 0 vdd vdd n5_SA0B sky130_fd_sc_hd__nand3_1
Xn5_SA1B hi hi 0 0 vdd vdd n5_SA1B sky130_fd_sc_hd__nand2_1
Xn5_SA2B hi hi n5_s0n 0 0 vdd vdd n5_SA2B sky130_fd_sc_hd__nand3_1
Xn5_SB0B hi hi 0 0 vdd vdd n5_SB0B sky130_fd_sc_hd__nand2_1
Xn5_SB1B hi hi 0 0 vdd vdd n5_SB1B sky130_fd_sc_hd__nand2_1
Xn5_M n5_ob n5_SB0B n5_SB1B n5_REFB n5_oa n5_SA0B n5_SA1B n5_SA2B n5_REFA vdd 0 n5_VBIAS n5_C1 n5_PREA n5_XA n5_DUTA n5_PREB n5_XB n5_DUTB n5_VB 0 0 core

In5XA n5_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In5XB n5_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
* --- n6: core
Xn6_ienn hi 0 0 vdd vdd n6_enn sky130_fd_sc_hd__inv_1
Xn6_is1n hi 0 0 vdd vdd n6_s1n sky130_fd_sc_hd__inv_1
Xn6_is0n hi 0 0 vdd vdd n6_s0n sky130_fd_sc_hd__inv_1
Xn6_PREA pre n6_enn 0 0 vdd vdd n6_PREA sky130_fd_sc_hd__nor2_1
Xn6_PREB pre n6_enn 0 0 vdd vdd n6_PREB sky130_fd_sc_hd__nor2_1
Xn6_VBIAS hi 0 0 vdd vdd n6_VBIAS sky130_fd_sc_hd__buf_2
Xn6_C1 hi 0 0 vdd vdd n6_C1 sky130_fd_sc_hd__buf_2
Xn6_DUTA hi n6_s1n hi 0 0 vdd vdd n6_DUTA sky130_fd_sc_hd__and3_1
Xn6_DUTB hi n6_s1n hi 0 0 vdd vdd n6_DUTB sky130_fd_sc_hd__and3_1
Xn6_REFA hi hi 0 0 vdd vdd n6_REFA sky130_fd_sc_hd__and2_1
Xn6_REFB hi hi 0 0 vdd vdd n6_REFB sky130_fd_sc_hd__and2_1
Xn6_SA0B hi hi hi 0 0 vdd vdd n6_SA0B sky130_fd_sc_hd__nand3_1
Xn6_SA1B hi hi 0 0 vdd vdd n6_SA1B sky130_fd_sc_hd__nand2_1
Xn6_SA2B hi hi n6_s0n 0 0 vdd vdd n6_SA2B sky130_fd_sc_hd__nand3_1
Xn6_SB0B hi hi 0 0 vdd vdd n6_SB0B sky130_fd_sc_hd__nand2_1
Xn6_SB1B hi hi 0 0 vdd vdd n6_SB1B sky130_fd_sc_hd__nand2_1
Xn6_M n6_ob n6_SB0B n6_SB1B n6_REFB n6_oa n6_SA0B n6_SA1B n6_SA2B n6_REFA vdd 0 n6_VBIAS n6_C1 n6_PREA n6_XA n6_DUTA n6_PREB n6_XB n6_DUTB n6_VB 0 0 core

In6XA n6_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In6XB n6_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
* --- n7: core
Xn7_ienn hi 0 0 vdd vdd n7_enn sky130_fd_sc_hd__inv_1
Xn7_is1n hi 0 0 vdd vdd n7_s1n sky130_fd_sc_hd__inv_1
Xn7_is0n hi 0 0 vdd vdd n7_s0n sky130_fd_sc_hd__inv_1
Xn7_PREA pre n7_enn 0 0 vdd vdd n7_PREA sky130_fd_sc_hd__nor2_1
Xn7_PREB pre n7_enn 0 0 vdd vdd n7_PREB sky130_fd_sc_hd__nor2_1
Xn7_VBIAS hi 0 0 vdd vdd n7_VBIAS sky130_fd_sc_hd__buf_2
Xn7_C1 hi 0 0 vdd vdd n7_C1 sky130_fd_sc_hd__buf_2
Xn7_DUTA hi n7_s1n hi 0 0 vdd vdd n7_DUTA sky130_fd_sc_hd__and3_1
Xn7_DUTB hi n7_s1n hi 0 0 vdd vdd n7_DUTB sky130_fd_sc_hd__and3_1
Xn7_REFA hi hi 0 0 vdd vdd n7_REFA sky130_fd_sc_hd__and2_1
Xn7_REFB hi hi 0 0 vdd vdd n7_REFB sky130_fd_sc_hd__and2_1
Xn7_SA0B hi hi hi 0 0 vdd vdd n7_SA0B sky130_fd_sc_hd__nand3_1
Xn7_SA1B hi hi 0 0 vdd vdd n7_SA1B sky130_fd_sc_hd__nand2_1
Xn7_SA2B hi hi n7_s0n 0 0 vdd vdd n7_SA2B sky130_fd_sc_hd__nand3_1
Xn7_SB0B hi hi 0 0 vdd vdd n7_SB0B sky130_fd_sc_hd__nand2_1
Xn7_SB1B hi hi 0 0 vdd vdd n7_SB1B sky130_fd_sc_hd__nand2_1
Xn7_M n7_ob n7_SB0B n7_SB1B n7_REFB n7_oa n7_SA0B n7_SA1B n7_SA2B n7_REFA vdd 0 n7_VBIAS n7_C1 n7_PREA n7_XA n7_DUTA n7_PREB n7_XB n7_DUTB n7_VB 0 0 core

In7XA n7_XA 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
In7XB n7_XB 0 dc 0 trnoise(2.6316e-10 1.0e-08 0 0)
.control
set noaskquit
set rndseed=32
save v(n0_oa) v(n0_ob) v(n1_oa) v(n1_ob) v(n2_oa) v(n2_ob) v(n3_oa) v(n3_ob) v(n4_oa) v(n4_ob) v(n5_oa) v(n5_ob) v(n6_oa) v(n6_ob) v(n7_oa) v(n7_ob)
let l = 0
while l < 8
  reset
  tran 10n 3.5805e-05 0 10n
  meas tran a0 when v(n0_oa)=0.9 rise=1
  meas tran b0 when v(n0_ob)=0.9 rise=1
  echo RN $&l 0 $&a0 $&b0
  meas tran a1 when v(n1_oa)=0.9 rise=1
  meas tran b1 when v(n1_ob)=0.9 rise=1
  echo RN $&l 1 $&a1 $&b1
  meas tran a2 when v(n2_oa)=0.9 rise=1
  meas tran b2 when v(n2_ob)=0.9 rise=1
  echo RN $&l 2 $&a2 $&b2
  meas tran a3 when v(n3_oa)=0.9 rise=1
  meas tran b3 when v(n3_ob)=0.9 rise=1
  echo RN $&l 3 $&a3 $&b3
  meas tran a4 when v(n4_oa)=0.9 rise=1
  meas tran b4 when v(n4_ob)=0.9 rise=1
  echo RN $&l 4 $&a4 $&b4
  meas tran a5 when v(n5_oa)=0.9 rise=1
  meas tran b5 when v(n5_ob)=0.9 rise=1
  echo RN $&l 5 $&a5 $&b5
  meas tran a6 when v(n6_oa)=0.9 rise=1
  meas tran b6 when v(n6_ob)=0.9 rise=1
  echo RN $&l 6 $&a6 $&b6
  meas tran a7 when v(n7_oa)=0.9 rise=1
  meas tran b7 when v(n7_ob)=0.9 rise=1
  echo RN $&l 7 $&a7 $&b7
  let l = l + 1
end
quit
.endc
.end
