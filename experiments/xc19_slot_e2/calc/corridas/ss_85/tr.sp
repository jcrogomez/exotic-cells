* MISFIT-03 etapa a · enmienda 2 calculo hvt · esquina ss 85 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ss
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 85
.subckt core XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
X5 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=117.474 ps=596.35999 w=5.5 l=10
X6 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X7 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X12 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X13 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X16 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X17 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X19 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X24 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X25 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X27 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X32 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X34 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X42 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X43 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X50 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X53 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X54 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X55 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X58 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X59 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X62 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X63 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X64 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X68 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X72 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X73 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X74 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X80 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X81 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X85 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X90 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X92 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X95 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X0 XB PREB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X1 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X3 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X4 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X8 XA PREA VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X9 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X14 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X15 GND REFB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X18 XB_OUT XB VDD VDD sky130_fd_pr__pfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X20 a_7650_n924# VDD XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X26 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X28 XB_OUT XB GND GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X29 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X30 XA SA2B a_n1510_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X31 a_7370_n924# SB1B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X35 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X36 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X37 XA VB a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X39 XB VB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X40 XA SA1B a_n1230_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 a_7090_n924# SB0B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X45 a_n2000_n1632# REFA GND GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X46 VDD XA XA_OUT VDD sky130_fd_pr__pfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X47 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X48 XA SA0B a_n950_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X49 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X51 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 GND XA XA_OUT GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X57 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 a_n48_382# a_n48_382# VB GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X61 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X65 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X66 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X67 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 GND DUTB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X70 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X71 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X75 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X76 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X77 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X78 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X79 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X82 GND DUTA a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X83 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X84 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X86 C1 C1 a_n48_382# GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X87 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X88 VBIAS VBIAS C1 GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X89 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X91 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X93 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X94 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 a_n950_n924# SA0B 0.00164f
C1 a_n950_n924# a_n1230_n924# 0.00251f
C2 VB PREA 0.00674f
C3 SA1B VDD 0.05165f
C4 VB SA2B 0
C5 a_n950_n924# XA 0.05363f
C6 CALA XA 0.59636f
C7 XB DUTA 0
C8 VDD SA0B 0.04538f
C9 SA1B SA0B 0.01827f
C10 VDD a_n1230_n924# 0.02524f
C11 VB DUTA 0.01701f
C12 XB CALB 0.60923f
C13 VDD PREB 0.17673f
C14 SA1B a_n1230_n924# 0.00999f
C15 a_n2000_n1632# REFA 0.00982f
C16 a_3900_n392# DUTA 0.00298f
C17 VDD XA 0.42588f
C18 SA1B XA 0.01535f
C19 CALB VB 0.01176f
C20 DUTB DUTA 0.00465f
C21 XB SB0B 0.01894f
C22 SA0B a_n1230_n924# 0.00126f
C23 SB0B a_7090_n924# 0.00164f
C24 VB REFA 0.00473f
C25 VDD PREA 0.17043f
C26 SA0B XA 0.01894f
C27 VB SB0B 0.00204f
C28 CALB DUTB 0
C29 VDD SA2B 0.05775f
C30 XA a_n1230_n924# 0.14938f
C31 SB0B a_7370_n924# 0.00126f
C32 SA1B SA2B 0.01827f
C33 PREB XA 0
C34 CALB CALA 0.00657f
C35 a_7040_n2004# SB0B 0
C36 VDD DUTA 0
C37 PREB PREA 0.00413f
C38 a_n1230_n924# SA2B 0.00165f
C39 XA PREA 0.02146f
C40 VDD CALB 0
C41 XA SA2B 0.01399f
C42 XB SB1B 0.01535f
C43 SB1B a_7090_n924# 0
C44 SB1B VB 0.00327f
C45 C1 a_n48_382# 0.05143f
C46 VDD SB0B 0.04538f
C47 SB1B a_7370_n924# 0.00999f
C48 XA DUTA 0.00921f
C49 a_n48_382# VB 0.06216f
C50 PREB CALB 0
C51 SB1B a_7130_n1632# 0
C52 CALB XA 0
C53 XA_OUT VB 0
C54 a_n1510_n924# a_n2090_n1632# 0.04223f
C55 VB REFB 0.00642f
C56 a_7130_n1632# REFB 0
C57 a_7040_n2004# REFB 0.00982f
C58 VDD SB1B 0.06992f
C59 VDD a_n48_382# 0.04849f
C60 XB a_7650_n924# 0.08426f
C61 XB a_4500_n392# 0.05778f
C62 VDD XA_OUT 0.11304f
C63 a_7650_n924# VB 0.02473f
C64 XB_OUT XB 0.02746f
C65 VB a_4500_n392# 0.0654f
C66 a_7650_n924# a_7370_n924# 0.11048f
C67 a_n2090_n1632# a_n2000_n1632# 0.44072f
C68 XB_OUT VB 0
C69 a_7650_n924# a_7130_n1632# 0.04223f
C70 a_4500_n392# DUTB 0.00298f
C71 a_n48_382# XA 0.0082f
C72 a_7040_n2004# a_7650_n924# 0.00146f
C73 a_n1510_n924# a_n2000_n1632# 0.00146f
C74 a_n2090_n1632# VB 0.41781f
C75 XA_OUT XA 0.02816f
C76 a_n1510_n924# VB 0.0246f
C77 VDD a_7650_n924# 0.07321f
C78 a_n2090_n1632# a_n950_n924# 0
C79 VDD a_4500_n392# 0.00496f
C80 XB_OUT VDD 0.1139f
C81 a_n2090_n1632# VDD 0.02312f
C82 SB1B SB0B 0.01827f
C83 SA1B a_n2090_n1632# 0
C84 C1 VBIAS 0.05143f
C85 a_n1510_n924# VDD 0.04424f
C86 VB VBIAS 0.00565f
C87 VB a_n2000_n1632# 0.14597f
C88 XB a_7090_n924# 0.05363f
C89 a_n2090_n1632# a_n1230_n924# 0.04617f
C90 XB VB 0.97066f
C91 C1 VB 0.00902f
C92 a_n2090_n1632# XA 0.42116f
C93 VB a_7090_n924# 0
C94 XB a_7370_n924# 0.14938f
C95 a_n1510_n924# a_n1230_n924# 0.11048f
C96 a_7370_n924# a_7090_n924# 0.00251f
C97 XB a_7130_n1632# 0.42116f
C98 VB a_7370_n924# 0.01419f
C99 a_n1510_n924# XA 0.08427f
C100 VB a_3900_n392# 0.07228f
C101 XB DUTB 0.01922f
C102 a_7130_n1632# a_7090_n924# 0
C103 a_4500_n392# DUTA 0
C104 a_7040_n2004# XB 0.00524f
C105 VB a_7130_n1632# 0.42696f
C106 a_n2090_n1632# SA2B 0
C107 XB CALA 0
C108 VB DUTB 0.01701f
C109 a_7130_n1632# a_7370_n924# 0.04617f
C110 a_7040_n2004# VB 0.14965f
C111 a_n950_n924# VB 0
C112 a_7040_n2004# a_7370_n924# 0.00104f
C113 VB CALA 0.01075f
C114 a_n1510_n924# SA2B 0.00999f
C115 VDD VBIAS 0.03241f
C116 a_3900_n392# CALA 0
C117 VDD a_n2000_n1632# 0
C118 a_7040_n2004# a_7130_n1632# 0.44072f
C119 VDD XB 0.47837f
C120 C1 VDD 0.04849f
C121 VDD a_7090_n924# 0.00372f
C122 VDD VB 0.37803f
C123 SA0B a_n2000_n1632# 0
C124 SA1B VB 0.00283f
C125 VDD a_7370_n924# 0.0269f
C126 a_n2000_n1632# a_n1230_n924# 0.00104f
C127 VDD a_3900_n392# 0.00496f
C128 a_n2090_n1632# REFA 0
C129 XA VBIAS 0.00599f
C130 VDD a_7130_n1632# 0.02379f
C131 XA a_n2000_n1632# 0.00524f
C132 XB PREB 0.0233f
C133 VDD DUTB 0
C134 VB SA0B 0
C135 VDD a_7040_n2004# 0
C136 XB XA 0.02337f
C137 C1 XA 0.00739f
C138 VB a_n1230_n924# 0.00964f
C139 VDD a_n950_n924# 0.00372f
C140 PREB VB 0.00674f
C141 SA1B a_n950_n924# 0
C142 VB XA 0.8449f
C143 a_n2000_n1632# SA2B 0
C144 a_3900_n392# XA 0.05981f
C145 CALB GND 0.28251f
C146 CALA GND 0.29501f
C147 REFB GND 0.20655f
C148 REFA GND 0.20801f
C149 SB1B GND 0.12644f
C150 SB0B GND 0.15202f
C151 SA0B GND 0.15406f
C152 SA1B GND 0.12684f
C153 SA2B GND 0.14679f
C154 DUTB GND 0.21831f
C155 DUTA GND 0.21794f
C156 XB_OUT GND 0.13753f
C157 PREB GND 0.10876f
C158 PREA GND 0.11529f
C159 VB GND 0.15539p
C160 XA_OUT GND 0.13768f
C161 XB GND 6.78211f
C162 VBIAS GND 0.5422f
C163 C1 GND 0.59586f
C164 XA GND 6.96986f
C165 VDD GND 10.8423f
C166 a_7040_n2004# GND 0.72315f
C167 a_7130_n1632# GND 1.04447f
C168 a_7650_n924# GND 0.28817f
C169 a_7370_n924# GND 0.23703f
C170 a_7090_n924# GND 0.01563f
C171 a_n2000_n1632# GND 0.72677f
C172 a_n2090_n1632# GND 1.05417f
C173 a_n950_n924# GND 0.01598f
C174 a_n1230_n924# GND 0.24157f
C175 a_n1510_n924# GND 0.297f
C176 a_4500_n392# GND 0.20468f
C177 a_3900_n392# GND 0.19922f
C178 a_n48_382# GND 0.59697f
.ends
.subckt hvt XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
X5 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=117.474 ps=596.35999 w=5.5 l=10
X6 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X7 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X12 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X13 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X16 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X17 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X19 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X24 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X25 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X27 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X32 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X34 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X42 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X43 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X50 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X53 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X54 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X55 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X58 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X59 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X62 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X63 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X64 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X68 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X72 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X73 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X74 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X80 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X81 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X85 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X90 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X92 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X95 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X0 XB PREB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X1 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X3 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X4 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X8 XA PREA VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X9 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X14 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X15 GND REFB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X18 XB_OUT XB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X20 a_7650_n924# VDD XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X26 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X28 XB_OUT XB GND GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X29 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X30 XA SA2B a_n1510_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X31 a_7370_n924# SB1B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X35 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X36 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X37 XA VB a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X39 XB VB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X40 XA SA1B a_n1230_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 a_7090_n924# SB0B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X45 a_n2000_n1632# REFA GND GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X46 VDD XA XA_OUT VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X47 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X48 XA SA0B a_n950_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X49 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X51 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 GND XA XA_OUT GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X57 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 a_n48_382# a_n48_382# VB GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X61 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X65 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X66 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X67 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 GND DUTB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X70 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X71 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X75 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X76 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X77 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X78 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X79 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X82 GND DUTA a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X83 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X84 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X86 C1 C1 a_n48_382# GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X87 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X88 VBIAS VBIAS C1 GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X89 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X91 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X93 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X94 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 a_n950_n924# SA0B 0.00164f
C1 a_n950_n924# a_n1230_n924# 0.00251f
C2 VB PREA 0.00674f
C3 SA1B VDD 0.05165f
C4 VB SA2B 0
C5 a_n950_n924# XA 0.05363f
C6 CALA XA 0.59636f
C7 XB DUTA 0
C8 VDD SA0B 0.04538f
C9 SA1B SA0B 0.01827f
C10 VDD a_n1230_n924# 0.02524f
C11 VB DUTA 0.01701f
C12 XB CALB 0.60923f
C13 VDD PREB 0.17673f
C14 SA1B a_n1230_n924# 0.00999f
C15 a_n2000_n1632# REFA 0.00982f
C16 a_3900_n392# DUTA 0.00298f
C17 VDD XA 0.42588f
C18 SA1B XA 0.01535f
C19 CALB VB 0.01176f
C20 DUTB DUTA 0.00465f
C21 XB SB0B 0.01894f
C22 SA0B a_n1230_n924# 0.00126f
C23 SB0B a_7090_n924# 0.00164f
C24 VB REFA 0.00473f
C25 VDD PREA 0.17043f
C26 SA0B XA 0.01894f
C27 VB SB0B 0.00204f
C28 CALB DUTB 0
C29 VDD SA2B 0.05775f
C30 XA a_n1230_n924# 0.14938f
C31 SB0B a_7370_n924# 0.00126f
C32 SA1B SA2B 0.01827f
C33 PREB XA 0
C34 CALB CALA 0.00657f
C35 a_7040_n2004# SB0B 0
C36 VDD DUTA 0
C37 PREB PREA 0.00413f
C38 a_n1230_n924# SA2B 0.00165f
C39 XA PREA 0.02146f
C40 VDD CALB 0
C41 XA SA2B 0.01399f
C42 XB SB1B 0.01535f
C43 SB1B a_7090_n924# 0
C44 SB1B VB 0.00327f
C45 C1 a_n48_382# 0.05143f
C46 VDD SB0B 0.04538f
C47 SB1B a_7370_n924# 0.00999f
C48 XA DUTA 0.00921f
C49 a_n48_382# VB 0.06216f
C50 PREB CALB 0
C51 SB1B a_7130_n1632# 0
C52 CALB XA 0
C53 XA_OUT VB 0
C54 a_n1510_n924# a_n2090_n1632# 0.04223f
C55 VB REFB 0.00642f
C56 a_7130_n1632# REFB 0
C57 a_7040_n2004# REFB 0.00982f
C58 VDD SB1B 0.06992f
C59 VDD a_n48_382# 0.04849f
C60 XB a_7650_n924# 0.08426f
C61 XB a_4500_n392# 0.05778f
C62 VDD XA_OUT 0.11304f
C63 a_7650_n924# VB 0.02473f
C64 XB_OUT XB 0.02746f
C65 VB a_4500_n392# 0.0654f
C66 a_7650_n924# a_7370_n924# 0.11048f
C67 a_n2090_n1632# a_n2000_n1632# 0.44072f
C68 XB_OUT VB 0
C69 a_7650_n924# a_7130_n1632# 0.04223f
C70 a_4500_n392# DUTB 0.00298f
C71 a_n48_382# XA 0.0082f
C72 a_7040_n2004# a_7650_n924# 0.00146f
C73 a_n1510_n924# a_n2000_n1632# 0.00146f
C74 a_n2090_n1632# VB 0.41781f
C75 XA_OUT XA 0.02816f
C76 a_n1510_n924# VB 0.0246f
C77 VDD a_7650_n924# 0.07321f
C78 a_n2090_n1632# a_n950_n924# 0
C79 VDD a_4500_n392# 0.00496f
C80 XB_OUT VDD 0.1139f
C81 a_n2090_n1632# VDD 0.02312f
C82 SB1B SB0B 0.01827f
C83 SA1B a_n2090_n1632# 0
C84 C1 VBIAS 0.05143f
C85 a_n1510_n924# VDD 0.04424f
C86 VB VBIAS 0.00565f
C87 VB a_n2000_n1632# 0.14597f
C88 XB a_7090_n924# 0.05363f
C89 a_n2090_n1632# a_n1230_n924# 0.04617f
C90 XB VB 0.97066f
C91 C1 VB 0.00902f
C92 a_n2090_n1632# XA 0.42116f
C93 VB a_7090_n924# 0
C94 XB a_7370_n924# 0.14938f
C95 a_n1510_n924# a_n1230_n924# 0.11048f
C96 a_7370_n924# a_7090_n924# 0.00251f
C97 XB a_7130_n1632# 0.42116f
C98 VB a_7370_n924# 0.01419f
C99 a_n1510_n924# XA 0.08427f
C100 VB a_3900_n392# 0.07228f
C101 XB DUTB 0.01922f
C102 a_7130_n1632# a_7090_n924# 0
C103 a_4500_n392# DUTA 0
C104 a_7040_n2004# XB 0.00524f
C105 VB a_7130_n1632# 0.42696f
C106 a_n2090_n1632# SA2B 0
C107 XB CALA 0
C108 VB DUTB 0.01701f
C109 a_7130_n1632# a_7370_n924# 0.04617f
C110 a_7040_n2004# VB 0.14965f
C111 a_n950_n924# VB 0
C112 a_7040_n2004# a_7370_n924# 0.00104f
C113 VB CALA 0.01075f
C114 a_n1510_n924# SA2B 0.00999f
C115 VDD VBIAS 0.03241f
C116 a_3900_n392# CALA 0
C117 VDD a_n2000_n1632# 0
C118 a_7040_n2004# a_7130_n1632# 0.44072f
C119 VDD XB 0.47837f
C120 C1 VDD 0.04849f
C121 VDD a_7090_n924# 0.00372f
C122 VDD VB 0.37803f
C123 SA0B a_n2000_n1632# 0
C124 SA1B VB 0.00283f
C125 VDD a_7370_n924# 0.0269f
C126 a_n2000_n1632# a_n1230_n924# 0.00104f
C127 VDD a_3900_n392# 0.00496f
C128 a_n2090_n1632# REFA 0
C129 XA VBIAS 0.00599f
C130 VDD a_7130_n1632# 0.02379f
C131 XA a_n2000_n1632# 0.00524f
C132 XB PREB 0.0233f
C133 VDD DUTB 0
C134 VB SA0B 0
C135 VDD a_7040_n2004# 0
C136 XB XA 0.02337f
C137 C1 XA 0.00739f
C138 VB a_n1230_n924# 0.00964f
C139 VDD a_n950_n924# 0.00372f
C140 PREB VB 0.00674f
C141 SA1B a_n950_n924# 0
C142 VB XA 0.8449f
C143 a_n2000_n1632# SA2B 0
C144 a_3900_n392# XA 0.05981f
C145 CALB GND 0.28251f
C146 CALA GND 0.29501f
C147 REFB GND 0.20655f
C148 REFA GND 0.20801f
C149 SB1B GND 0.12644f
C150 SB0B GND 0.15202f
C151 SA0B GND 0.15406f
C152 SA1B GND 0.12684f
C153 SA2B GND 0.14679f
C154 DUTB GND 0.21831f
C155 DUTA GND 0.21794f
C156 XB_OUT GND 0.13753f
C157 PREB GND 0.10876f
C158 PREA GND 0.11529f
C159 VB GND 0.15539p
C160 XA_OUT GND 0.13768f
C161 XB GND 6.78211f
C162 VBIAS GND 0.5422f
C163 C1 GND 0.59586f
C164 XA GND 6.96986f
C165 VDD GND 10.8423f
C166 a_7040_n2004# GND 0.72315f
C167 a_7130_n1632# GND 1.04447f
C168 a_7650_n924# GND 0.28817f
C169 a_7370_n924# GND 0.23703f
C170 a_7090_n924# GND 0.01563f
C171 a_n2000_n1632# GND 0.72677f
C172 a_n2090_n1632# GND 1.05417f
C173 a_n950_n924# GND 0.01598f
C174 a_n1230_n924# GND 0.24157f
C175 a_n1510_n924# GND 0.297f
C176 a_4500_n392# GND 0.20468f
C177 a_3900_n392# GND 0.19922f
C178 a_n48_382# GND 0.59697f
.ends
.subckt trap XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
X5 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=117.474 ps=596.35999 w=5.5 l=10
X6 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X7 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X12 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X13 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X16 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X17 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X19 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X24 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X25 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X27 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X32 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X34 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X42 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X43 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X50 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X53 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X54 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X55 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X58 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X59 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X62 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X63 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X64 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X68 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X72 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X73 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X74 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X80 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X81 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X85 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X90 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X92 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X95 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X0 XB PREB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X1 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X3 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X4 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X8 XA PREA VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X9 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X14 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X15 GND REFB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X18 XB_OUT XB VDD VDD sky130_fd_pr__pfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X20 a_7650_n924# VDD XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X26 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X28 XB_OUT XB GND GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X29 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X30 XA SA2B a_n1510_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X31 a_7370_n924# SB1B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X35 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X36 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X37 XA GT a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X39 XB VB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X40 XA SA1B a_n1230_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 a_7090_n924# SB0B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X45 a_n2000_n1632# REFA GND GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X46 VDD XA XA_OUT VDD sky130_fd_pr__pfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X47 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X48 XA SA0B a_n950_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X49 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X51 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 GND XA XA_OUT GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X57 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 a_n48_382# a_n48_382# VB GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X61 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X65 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X66 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X67 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 GND DUTB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X70 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X71 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X75 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X76 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X77 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X78 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X79 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X82 GND DUTA a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X83 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X84 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X86 C1 C1 a_n48_382# GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X87 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X88 VBIAS VBIAS C1 GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X89 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X91 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X93 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X94 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 a_n950_n924# SA0B 0.00164f
C1 a_n950_n924# a_n1230_n924# 0.00251f
C2 VB PREA 0.00674f
C3 SA1B VDD 0.05165f
C4 VB SA2B 0
C5 a_n950_n924# XA 0.05363f
C6 CALA XA 0.59636f
C7 XB DUTA 0
C8 VDD SA0B 0.04538f
C9 SA1B SA0B 0.01827f
C10 VDD a_n1230_n924# 0.02524f
C11 VB DUTA 0.01701f
C12 XB CALB 0.60923f
C13 VDD PREB 0.17673f
C14 SA1B a_n1230_n924# 0.00999f
C15 a_n2000_n1632# REFA 0.00982f
C16 a_3900_n392# DUTA 0.00298f
C17 VDD XA 0.42588f
C18 SA1B XA 0.01535f
C19 CALB VB 0.01176f
C20 DUTB DUTA 0.00465f
C21 XB SB0B 0.01894f
C22 SA0B a_n1230_n924# 0.00126f
C23 SB0B a_7090_n924# 0.00164f
C24 VB REFA 0.00473f
C25 VDD PREA 0.17043f
C26 SA0B XA 0.01894f
C27 VB SB0B 0.00204f
C28 CALB DUTB 0
C29 VDD SA2B 0.05775f
C30 XA a_n1230_n924# 0.14938f
C31 SB0B a_7370_n924# 0.00126f
C32 SA1B SA2B 0.01827f
C33 PREB XA 0
C34 CALB CALA 0.00657f
C35 a_7040_n2004# SB0B 0
C36 VDD DUTA 0
C37 PREB PREA 0.00413f
C38 a_n1230_n924# SA2B 0.00165f
C39 XA PREA 0.02146f
C40 VDD CALB 0
C41 XA SA2B 0.01399f
C42 XB SB1B 0.01535f
C43 SB1B a_7090_n924# 0
C44 SB1B VB 0.00327f
C45 C1 a_n48_382# 0.05143f
C46 VDD SB0B 0.04538f
C47 SB1B a_7370_n924# 0.00999f
C48 XA DUTA 0.00921f
C49 a_n48_382# VB 0.06216f
C50 PREB CALB 0
C51 SB1B a_7130_n1632# 0
C52 CALB XA 0
C53 XA_OUT VB 0
C54 a_n1510_n924# a_n2090_n1632# 0.04223f
C55 VB REFB 0.00642f
C56 a_7130_n1632# REFB 0
C57 a_7040_n2004# REFB 0.00982f
C58 VDD SB1B 0.06992f
C59 VDD a_n48_382# 0.04849f
C60 XB a_7650_n924# 0.08426f
C61 XB a_4500_n392# 0.05778f
C62 VDD XA_OUT 0.11304f
C63 a_7650_n924# VB 0.02473f
C64 XB_OUT XB 0.02746f
C65 VB a_4500_n392# 0.0654f
C66 a_7650_n924# a_7370_n924# 0.11048f
C67 a_n2090_n1632# a_n2000_n1632# 0.44072f
C68 XB_OUT VB 0
C69 a_7650_n924# a_7130_n1632# 0.04223f
C70 a_4500_n392# DUTB 0.00298f
C71 a_n48_382# XA 0.0082f
C72 a_7040_n2004# a_7650_n924# 0.00146f
C73 a_n1510_n924# a_n2000_n1632# 0.00146f
C74 a_n2090_n1632# VB 0.41781f
C75 XA_OUT XA 0.02816f
C76 a_n1510_n924# VB 0.0246f
C77 VDD a_7650_n924# 0.07321f
C78 a_n2090_n1632# a_n950_n924# 0
C79 VDD a_4500_n392# 0.00496f
C80 XB_OUT VDD 0.1139f
C81 a_n2090_n1632# VDD 0.02312f
C82 SB1B SB0B 0.01827f
C83 SA1B a_n2090_n1632# 0
C84 C1 VBIAS 0.05143f
C85 a_n1510_n924# VDD 0.04424f
C86 VB VBIAS 0.00565f
C87 VB a_n2000_n1632# 0.14597f
C88 XB a_7090_n924# 0.05363f
C89 a_n2090_n1632# a_n1230_n924# 0.04617f
C90 XB VB 0.97066f
C91 C1 VB 0.00902f
C92 a_n2090_n1632# XA 0.42116f
C93 VB a_7090_n924# 0
C94 XB a_7370_n924# 0.14938f
C95 a_n1510_n924# a_n1230_n924# 0.11048f
C96 a_7370_n924# a_7090_n924# 0.00251f
C97 XB a_7130_n1632# 0.42116f
C98 VB a_7370_n924# 0.01419f
C99 a_n1510_n924# XA 0.08427f
C100 VB a_3900_n392# 0.07228f
C101 XB DUTB 0.01922f
C102 a_7130_n1632# a_7090_n924# 0
C103 a_4500_n392# DUTA 0
C104 a_7040_n2004# XB 0.00524f
C105 VB a_7130_n1632# 0.42696f
C106 a_n2090_n1632# SA2B 0
C107 XB CALA 0
C108 VB DUTB 0.01701f
C109 a_7130_n1632# a_7370_n924# 0.04617f
C110 a_7040_n2004# VB 0.14965f
C111 a_n950_n924# VB 0
C112 a_7040_n2004# a_7370_n924# 0.00104f
C113 VB CALA 0.01075f
C114 a_n1510_n924# SA2B 0.00999f
C115 VDD VBIAS 0.03241f
C116 a_3900_n392# CALA 0
C117 VDD a_n2000_n1632# 0
C118 a_7040_n2004# a_7130_n1632# 0.44072f
C119 VDD XB 0.47837f
C120 C1 VDD 0.04849f
C121 VDD a_7090_n924# 0.00372f
C122 VDD VB 0.37803f
C123 SA0B a_n2000_n1632# 0
C124 SA1B VB 0.00283f
C125 VDD a_7370_n924# 0.0269f
C126 a_n2000_n1632# a_n1230_n924# 0.00104f
C127 VDD a_3900_n392# 0.00496f
C128 a_n2090_n1632# REFA 0
C129 XA VBIAS 0.00599f
C130 VDD a_7130_n1632# 0.02379f
C131 XA a_n2000_n1632# 0.00524f
C132 XB PREB 0.0233f
C133 VDD DUTB 0
C134 VB SA0B 0
C135 VDD a_7040_n2004# 0
C136 XB XA 0.02337f
C137 C1 XA 0.00739f
C138 VB a_n1230_n924# 0.00964f
C139 VDD a_n950_n924# 0.00372f
C140 PREB VB 0.00674f
C141 SA1B a_n950_n924# 0
C142 VB XA 0.8449f
C143 a_n2000_n1632# SA2B 0
C144 a_3900_n392# XA 0.05981f
C145 CALB GND 0.28251f
C146 CALA GND 0.29501f
C147 REFB GND 0.20655f
C148 REFA GND 0.20801f
C149 SB1B GND 0.12644f
C150 SB0B GND 0.15202f
C151 SA0B GND 0.15406f
C152 SA1B GND 0.12684f
C153 SA2B GND 0.14679f
C154 DUTB GND 0.21831f
C155 DUTA GND 0.21794f
C156 XB_OUT GND 0.13753f
C157 PREB GND 0.10876f
C158 PREA GND 0.11529f
C159 VB GND 0.15539p
C160 XA_OUT GND 0.13768f
C161 XB GND 6.78211f
C162 VBIAS GND 0.5422f
C163 C1 GND 0.59586f
C164 XA GND 6.96986f
C165 VDD GND 10.8423f
C166 a_7040_n2004# GND 0.72315f
C167 a_7130_n1632# GND 1.04447f
C168 a_7650_n924# GND 0.28817f
C169 a_7370_n924# GND 0.23703f
C170 a_7090_n924# GND 0.01563f
C171 a_n2000_n1632# GND 0.72677f
C172 a_n2090_n1632# GND 1.05417f
C173 a_n950_n924# GND 0.01598f
C174 a_n1230_n924# GND 0.24157f
C175 a_n1510_n924# GND 0.297f
C176 a_4500_n392# GND 0.20468f
C177 a_3900_n392# GND 0.19922f
C178 a_n48_382# GND 0.59697f
.ends
.subckt thvt XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
X5 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=117.474 ps=596.35999 w=5.5 l=10
X6 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X7 GND XB GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X12 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X13 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X16 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X17 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X19 GND XA GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=0 ps=0 w=4.3 l=4
X23 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X24 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X25 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X27 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X32 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X34 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X42 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X43 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X50 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X53 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X54 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X55 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X58 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X59 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X62 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X63 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X64 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X68 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X72 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X73 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X74 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X80 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X81 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X85 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X90 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X92 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=6.1 as=0 ps=0 w=5.5 l=10
X95 GND VB GND GND sky130_fd_pr__nfet_01v8 ad=1.65 pd=11.6 as=0 ps=0 w=5.5 l=10
X0 XB PREB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X1 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X3 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X4 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X8 XA PREA VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
X9 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X14 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X15 GND REFB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X18 XB_OUT XB VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X20 a_7650_n924# VDD XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X26 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X28 XB_OUT XB GND GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X29 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X30 XA SA2B a_n1510_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X31 a_7370_n924# SB1B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X35 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X36 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X37 XA GT a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X39 XB VB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X40 XA SA1B a_n1230_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 a_7090_n924# SB0B XB VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X45 a_n2000_n1632# REFA GND GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X46 VDD XA XA_OUT VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=0.15 sa=0.3 sb=0.3
X47 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X48 XA SA0B a_n950_n924# VDD sky130_fd_pr__pfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X49 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X51 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 GND XA XA_OUT GND sky130_fd_pr__nfet_01v8 ad=0.195 pd=1.9 as=0.195 ps=1.9 w=0.65 l=0.15 sa=0.3 sb=0.3
X57 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 a_n48_382# a_n48_382# VB GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X61 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X65 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X66 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X67 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 GND DUTB a_4500_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X70 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X71 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X75 a_7130_n1632# VB a_7040_n2004# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X76 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X77 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X78 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X79 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X82 GND DUTA a_3900_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X83 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X84 a_7130_n1632# VB XB GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X86 C1 C1 a_n48_382# GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X87 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X88 VBIAS VBIAS C1 GND sky130_fd_pr__nfet_01v8 ad=0.3 pd=2.6 as=0.3 ps=2.6 w=1 l=1 sa=0.3 sb=0.3
X89 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X91 VB VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X93 XA VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X94 a_n2000_n1632# VB a_n2090_n1632# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 a_n950_n924# SA0B 0.00164f
C1 a_n950_n924# a_n1230_n924# 0.00251f
C2 VB PREA 0.00674f
C3 SA1B VDD 0.05165f
C4 VB SA2B 0
C5 a_n950_n924# XA 0.05363f
C6 CALA XA 0.59636f
C7 XB DUTA 0
C8 VDD SA0B 0.04538f
C9 SA1B SA0B 0.01827f
C10 VDD a_n1230_n924# 0.02524f
C11 VB DUTA 0.01701f
C12 XB CALB 0.60923f
C13 VDD PREB 0.17673f
C14 SA1B a_n1230_n924# 0.00999f
C15 a_n2000_n1632# REFA 0.00982f
C16 a_3900_n392# DUTA 0.00298f
C17 VDD XA 0.42588f
C18 SA1B XA 0.01535f
C19 CALB VB 0.01176f
C20 DUTB DUTA 0.00465f
C21 XB SB0B 0.01894f
C22 SA0B a_n1230_n924# 0.00126f
C23 SB0B a_7090_n924# 0.00164f
C24 VB REFA 0.00473f
C25 VDD PREA 0.17043f
C26 SA0B XA 0.01894f
C27 VB SB0B 0.00204f
C28 CALB DUTB 0
C29 VDD SA2B 0.05775f
C30 XA a_n1230_n924# 0.14938f
C31 SB0B a_7370_n924# 0.00126f
C32 SA1B SA2B 0.01827f
C33 PREB XA 0
C34 CALB CALA 0.00657f
C35 a_7040_n2004# SB0B 0
C36 VDD DUTA 0
C37 PREB PREA 0.00413f
C38 a_n1230_n924# SA2B 0.00165f
C39 XA PREA 0.02146f
C40 VDD CALB 0
C41 XA SA2B 0.01399f
C42 XB SB1B 0.01535f
C43 SB1B a_7090_n924# 0
C44 SB1B VB 0.00327f
C45 C1 a_n48_382# 0.05143f
C46 VDD SB0B 0.04538f
C47 SB1B a_7370_n924# 0.00999f
C48 XA DUTA 0.00921f
C49 a_n48_382# VB 0.06216f
C50 PREB CALB 0
C51 SB1B a_7130_n1632# 0
C52 CALB XA 0
C53 XA_OUT VB 0
C54 a_n1510_n924# a_n2090_n1632# 0.04223f
C55 VB REFB 0.00642f
C56 a_7130_n1632# REFB 0
C57 a_7040_n2004# REFB 0.00982f
C58 VDD SB1B 0.06992f
C59 VDD a_n48_382# 0.04849f
C60 XB a_7650_n924# 0.08426f
C61 XB a_4500_n392# 0.05778f
C62 VDD XA_OUT 0.11304f
C63 a_7650_n924# VB 0.02473f
C64 XB_OUT XB 0.02746f
C65 VB a_4500_n392# 0.0654f
C66 a_7650_n924# a_7370_n924# 0.11048f
C67 a_n2090_n1632# a_n2000_n1632# 0.44072f
C68 XB_OUT VB 0
C69 a_7650_n924# a_7130_n1632# 0.04223f
C70 a_4500_n392# DUTB 0.00298f
C71 a_n48_382# XA 0.0082f
C72 a_7040_n2004# a_7650_n924# 0.00146f
C73 a_n1510_n924# a_n2000_n1632# 0.00146f
C74 a_n2090_n1632# VB 0.41781f
C75 XA_OUT XA 0.02816f
C76 a_n1510_n924# VB 0.0246f
C77 VDD a_7650_n924# 0.07321f
C78 a_n2090_n1632# a_n950_n924# 0
C79 VDD a_4500_n392# 0.00496f
C80 XB_OUT VDD 0.1139f
C81 a_n2090_n1632# VDD 0.02312f
C82 SB1B SB0B 0.01827f
C83 SA1B a_n2090_n1632# 0
C84 C1 VBIAS 0.05143f
C85 a_n1510_n924# VDD 0.04424f
C86 VB VBIAS 0.00565f
C87 VB a_n2000_n1632# 0.14597f
C88 XB a_7090_n924# 0.05363f
C89 a_n2090_n1632# a_n1230_n924# 0.04617f
C90 XB VB 0.97066f
C91 C1 VB 0.00902f
C92 a_n2090_n1632# XA 0.42116f
C93 VB a_7090_n924# 0
C94 XB a_7370_n924# 0.14938f
C95 a_n1510_n924# a_n1230_n924# 0.11048f
C96 a_7370_n924# a_7090_n924# 0.00251f
C97 XB a_7130_n1632# 0.42116f
C98 VB a_7370_n924# 0.01419f
C99 a_n1510_n924# XA 0.08427f
C100 VB a_3900_n392# 0.07228f
C101 XB DUTB 0.01922f
C102 a_7130_n1632# a_7090_n924# 0
C103 a_4500_n392# DUTA 0
C104 a_7040_n2004# XB 0.00524f
C105 VB a_7130_n1632# 0.42696f
C106 a_n2090_n1632# SA2B 0
C107 XB CALA 0
C108 VB DUTB 0.01701f
C109 a_7130_n1632# a_7370_n924# 0.04617f
C110 a_7040_n2004# VB 0.14965f
C111 a_n950_n924# VB 0
C112 a_7040_n2004# a_7370_n924# 0.00104f
C113 VB CALA 0.01075f
C114 a_n1510_n924# SA2B 0.00999f
C115 VDD VBIAS 0.03241f
C116 a_3900_n392# CALA 0
C117 VDD a_n2000_n1632# 0
C118 a_7040_n2004# a_7130_n1632# 0.44072f
C119 VDD XB 0.47837f
C120 C1 VDD 0.04849f
C121 VDD a_7090_n924# 0.00372f
C122 VDD VB 0.37803f
C123 SA0B a_n2000_n1632# 0
C124 SA1B VB 0.00283f
C125 VDD a_7370_n924# 0.0269f
C126 a_n2000_n1632# a_n1230_n924# 0.00104f
C127 VDD a_3900_n392# 0.00496f
C128 a_n2090_n1632# REFA 0
C129 XA VBIAS 0.00599f
C130 VDD a_7130_n1632# 0.02379f
C131 XA a_n2000_n1632# 0.00524f
C132 XB PREB 0.0233f
C133 VDD DUTB 0
C134 VB SA0B 0
C135 VDD a_7040_n2004# 0
C136 XB XA 0.02337f
C137 C1 XA 0.00739f
C138 VB a_n1230_n924# 0.00964f
C139 VDD a_n950_n924# 0.00372f
C140 PREB VB 0.00674f
C141 SA1B a_n950_n924# 0
C142 VB XA 0.8449f
C143 a_n2000_n1632# SA2B 0
C144 a_3900_n392# XA 0.05981f
C145 CALB GND 0.28251f
C146 CALA GND 0.29501f
C147 REFB GND 0.20655f
C148 REFA GND 0.20801f
C149 SB1B GND 0.12644f
C150 SB0B GND 0.15202f
C151 SA0B GND 0.15406f
C152 SA1B GND 0.12684f
C153 SA2B GND 0.14679f
C154 DUTB GND 0.21831f
C155 DUTA GND 0.21794f
C156 XB_OUT GND 0.13753f
C157 PREB GND 0.10876f
C158 PREA GND 0.11529f
C159 VB GND 0.15539p
C160 XA_OUT GND 0.13768f
C161 XB GND 6.78211f
C162 VBIAS GND 0.5422f
C163 C1 GND 0.59586f
C164 XA GND 6.96986f
C165 VDD GND 10.8423f
C166 a_7040_n2004# GND 0.72315f
C167 a_7130_n1632# GND 1.04447f
C168 a_7650_n924# GND 0.28817f
C169 a_7370_n924# GND 0.23703f
C170 a_7090_n924# GND 0.01563f
C171 a_n2000_n1632# GND 0.72677f
C172 a_n2090_n1632# GND 1.05417f
C173 a_n950_n924# GND 0.01598f
C174 a_n1230_n924# GND 0.24157f
C175 a_n1510_n924# GND 0.297f
C176 a_4500_n392# GND 0.20468f
C177 a_3900_n392# GND 0.19922f
C178 a_n48_382# GND 0.59697f
.ends
Vd vdd 0 1.8
Vh hi 0 1.8
Vpre pre 0 pwl(0 1.8 1e-06 1.8 1.001e-06 0)
* --- core01: core
Xcore01_ienn hi 0 0 vdd vdd core01_enn sky130_fd_sc_hd__inv_1
Xcore01_is1n 0 0 0 vdd vdd core01_s1n sky130_fd_sc_hd__inv_1
Xcore01_is0n hi 0 0 vdd vdd core01_s0n sky130_fd_sc_hd__inv_1
Xcore01_PREA pre core01_enn 0 0 vdd vdd core01_PREA sky130_fd_sc_hd__nor2_1
Xcore01_PREB pre core01_enn 0 0 vdd vdd core01_PREB sky130_fd_sc_hd__nor2_1
Xcore01_VBIAS hi 0 0 vdd vdd core01_VBIAS sky130_fd_sc_hd__buf_2
Xcore01_C1 hi 0 0 vdd vdd core01_C1 sky130_fd_sc_hd__buf_2
Xcore01_DUTA hi core01_s1n hi 0 0 vdd vdd core01_DUTA sky130_fd_sc_hd__and3_1
Xcore01_DUTB hi core01_s1n hi 0 0 vdd vdd core01_DUTB sky130_fd_sc_hd__and3_1
Xcore01_REFA hi 0 0 0 vdd vdd core01_REFA sky130_fd_sc_hd__and2_1
Xcore01_REFB hi 0 0 0 vdd vdd core01_REFB sky130_fd_sc_hd__and2_1
Xcore01_SA0B hi 0 hi 0 0 vdd vdd core01_SA0B sky130_fd_sc_hd__nand3_1
Xcore01_SA1B hi 0 0 0 vdd vdd core01_SA1B sky130_fd_sc_hd__nand2_1
Xcore01_SA2B hi 0 core01_s0n 0 0 vdd vdd core01_SA2B sky130_fd_sc_hd__nand3_1
Xcore01_SB0B hi 0 0 0 vdd vdd core01_SB0B sky130_fd_sc_hd__nand2_1
Xcore01_SB1B hi 0 0 0 vdd vdd core01_SB1B sky130_fd_sc_hd__nand2_1
Xcore01_M core01_ob core01_SB0B core01_SB1B core01_REFB core01_oa core01_SA0B core01_SA1B core01_SA2B core01_REFA vdd 0 core01_VBIAS core01_C1 core01_PREA core01_XA core01_DUTA core01_PREB core01_XB core01_DUTB core01_VB 0 0 core

* --- core11: core
Xcore11_ienn hi 0 0 vdd vdd core11_enn sky130_fd_sc_hd__inv_1
Xcore11_is1n hi 0 0 vdd vdd core11_s1n sky130_fd_sc_hd__inv_1
Xcore11_is0n hi 0 0 vdd vdd core11_s0n sky130_fd_sc_hd__inv_1
Xcore11_PREA pre core11_enn 0 0 vdd vdd core11_PREA sky130_fd_sc_hd__nor2_1
Xcore11_PREB pre core11_enn 0 0 vdd vdd core11_PREB sky130_fd_sc_hd__nor2_1
Xcore11_VBIAS hi 0 0 vdd vdd core11_VBIAS sky130_fd_sc_hd__buf_2
Xcore11_C1 hi 0 0 vdd vdd core11_C1 sky130_fd_sc_hd__buf_2
Xcore11_DUTA hi core11_s1n hi 0 0 vdd vdd core11_DUTA sky130_fd_sc_hd__and3_1
Xcore11_DUTB hi core11_s1n hi 0 0 vdd vdd core11_DUTB sky130_fd_sc_hd__and3_1
Xcore11_REFA hi hi 0 0 vdd vdd core11_REFA sky130_fd_sc_hd__and2_1
Xcore11_REFB hi hi 0 0 vdd vdd core11_REFB sky130_fd_sc_hd__and2_1
Xcore11_SA0B hi hi hi 0 0 vdd vdd core11_SA0B sky130_fd_sc_hd__nand3_1
Xcore11_SA1B hi hi 0 0 vdd vdd core11_SA1B sky130_fd_sc_hd__nand2_1
Xcore11_SA2B hi hi core11_s0n 0 0 vdd vdd core11_SA2B sky130_fd_sc_hd__nand3_1
Xcore11_SB0B hi hi 0 0 vdd vdd core11_SB0B sky130_fd_sc_hd__nand2_1
Xcore11_SB1B hi hi 0 0 vdd vdd core11_SB1B sky130_fd_sc_hd__nand2_1
Xcore11_M core11_ob core11_SB0B core11_SB1B core11_REFB core11_oa core11_SA0B core11_SA1B core11_SA2B core11_REFA vdd 0 core11_VBIAS core11_C1 core11_PREA core11_XA core11_DUTA core11_PREB core11_XB core11_DUTB core11_VB 0 0 core

* --- core10: core
Xcore10_ienn hi 0 0 vdd vdd core10_enn sky130_fd_sc_hd__inv_1
Xcore10_is1n hi 0 0 vdd vdd core10_s1n sky130_fd_sc_hd__inv_1
Xcore10_is0n 0 0 0 vdd vdd core10_s0n sky130_fd_sc_hd__inv_1
Xcore10_PREA pre core10_enn 0 0 vdd vdd core10_PREA sky130_fd_sc_hd__nor2_1
Xcore10_PREB pre core10_enn 0 0 vdd vdd core10_PREB sky130_fd_sc_hd__nor2_1
Xcore10_VBIAS hi 0 0 vdd vdd core10_VBIAS sky130_fd_sc_hd__buf_2
Xcore10_C1 hi 0 0 vdd vdd core10_C1 sky130_fd_sc_hd__buf_2
Xcore10_DUTA hi core10_s1n 0 0 0 vdd vdd core10_DUTA sky130_fd_sc_hd__and3_1
Xcore10_DUTB hi core10_s1n 0 0 0 vdd vdd core10_DUTB sky130_fd_sc_hd__and3_1
Xcore10_REFA hi hi 0 0 vdd vdd core10_REFA sky130_fd_sc_hd__and2_1
Xcore10_REFB hi hi 0 0 vdd vdd core10_REFB sky130_fd_sc_hd__and2_1
Xcore10_SA0B hi hi 0 0 0 vdd vdd core10_SA0B sky130_fd_sc_hd__nand3_1
Xcore10_SA1B hi hi 0 0 vdd vdd core10_SA1B sky130_fd_sc_hd__nand2_1
Xcore10_SA2B hi hi core10_s0n 0 0 vdd vdd core10_SA2B sky130_fd_sc_hd__nand3_1
Xcore10_SB0B hi hi 0 0 vdd vdd core10_SB0B sky130_fd_sc_hd__nand2_1
Xcore10_SB1B hi hi 0 0 vdd vdd core10_SB1B sky130_fd_sc_hd__nand2_1
Xcore10_M core10_ob core10_SB0B core10_SB1B core10_REFB core10_oa core10_SA0B core10_SA1B core10_SA2B core10_REFA vdd 0 core10_VBIAS core10_C1 core10_PREA core10_XA core10_DUTA core10_PREB core10_XB core10_DUTB core10_VB 0 0 core

* --- coret: trap
Xcoret_ienn hi 0 0 vdd vdd coret_enn sky130_fd_sc_hd__inv_1
Xcoret_is1n 0 0 0 vdd vdd coret_s1n sky130_fd_sc_hd__inv_1
Xcoret_is0n hi 0 0 vdd vdd coret_s0n sky130_fd_sc_hd__inv_1
Xcoret_PREA pre coret_enn 0 0 vdd vdd coret_PREA sky130_fd_sc_hd__nor2_1
Xcoret_PREB pre coret_enn 0 0 vdd vdd coret_PREB sky130_fd_sc_hd__nor2_1
Xcoret_VBIAS hi 0 0 vdd vdd coret_VBIAS sky130_fd_sc_hd__buf_2
Xcoret_C1 hi 0 0 vdd vdd coret_C1 sky130_fd_sc_hd__buf_2
Xcoret_DUTA hi coret_s1n hi 0 0 vdd vdd coret_DUTA sky130_fd_sc_hd__and3_1
Xcoret_DUTB hi coret_s1n hi 0 0 vdd vdd coret_DUTB sky130_fd_sc_hd__and3_1
Xcoret_REFA hi 0 0 0 vdd vdd coret_REFA sky130_fd_sc_hd__and2_1
Xcoret_REFB hi 0 0 0 vdd vdd coret_REFB sky130_fd_sc_hd__and2_1
Xcoret_SA0B hi 0 hi 0 0 vdd vdd coret_SA0B sky130_fd_sc_hd__nand3_1
Xcoret_SA1B hi 0 0 0 vdd vdd coret_SA1B sky130_fd_sc_hd__nand2_1
Xcoret_SA2B hi 0 coret_s0n 0 0 vdd vdd coret_SA2B sky130_fd_sc_hd__nand3_1
Xcoret_SB0B hi 0 0 0 vdd vdd coret_SB0B sky130_fd_sc_hd__nand2_1
Xcoret_SB1B hi 0 0 0 vdd vdd coret_SB1B sky130_fd_sc_hd__nand2_1
Xcoret_M coret_ob coret_SB0B coret_SB1B coret_REFB coret_oa coret_SA0B coret_SA1B coret_SA2B coret_REFA vdd 0 coret_VBIAS coret_C1 coret_PREA coret_XA coret_DUTA coret_PREB coret_XB coret_DUTB coret_VB 0 0 coret_GT trap
Bcoret_gt coret_GT 0 V=v(coret_VB)+0.000305

* --- hvt01: hvt
Xhvt01_ienn hi 0 0 vdd vdd hvt01_enn sky130_fd_sc_hd__inv_1
Xhvt01_is1n 0 0 0 vdd vdd hvt01_s1n sky130_fd_sc_hd__inv_1
Xhvt01_is0n hi 0 0 vdd vdd hvt01_s0n sky130_fd_sc_hd__inv_1
Xhvt01_PREA pre hvt01_enn 0 0 vdd vdd hvt01_PREA sky130_fd_sc_hd__nor2_1
Xhvt01_PREB pre hvt01_enn 0 0 vdd vdd hvt01_PREB sky130_fd_sc_hd__nor2_1
Xhvt01_VBIAS hi 0 0 vdd vdd hvt01_VBIAS sky130_fd_sc_hd__buf_2
Xhvt01_C1 hi 0 0 vdd vdd hvt01_C1 sky130_fd_sc_hd__buf_2
Xhvt01_DUTA hi hvt01_s1n hi 0 0 vdd vdd hvt01_DUTA sky130_fd_sc_hd__and3_1
Xhvt01_DUTB hi hvt01_s1n hi 0 0 vdd vdd hvt01_DUTB sky130_fd_sc_hd__and3_1
Xhvt01_REFA hi 0 0 0 vdd vdd hvt01_REFA sky130_fd_sc_hd__and2_1
Xhvt01_REFB hi 0 0 0 vdd vdd hvt01_REFB sky130_fd_sc_hd__and2_1
Xhvt01_SA0B hi 0 hi 0 0 vdd vdd hvt01_SA0B sky130_fd_sc_hd__nand3_1
Xhvt01_SA1B hi 0 0 0 vdd vdd hvt01_SA1B sky130_fd_sc_hd__nand2_1
Xhvt01_SA2B hi 0 hvt01_s0n 0 0 vdd vdd hvt01_SA2B sky130_fd_sc_hd__nand3_1
Xhvt01_SB0B hi 0 0 0 vdd vdd hvt01_SB0B sky130_fd_sc_hd__nand2_1
Xhvt01_SB1B hi 0 0 0 vdd vdd hvt01_SB1B sky130_fd_sc_hd__nand2_1
Xhvt01_M hvt01_ob hvt01_SB0B hvt01_SB1B hvt01_REFB hvt01_oa hvt01_SA0B hvt01_SA1B hvt01_SA2B hvt01_REFA vdd 0 hvt01_VBIAS hvt01_C1 hvt01_PREA hvt01_XA hvt01_DUTA hvt01_PREB hvt01_XB hvt01_DUTB hvt01_VB 0 0 hvt

* --- hvt11: hvt
Xhvt11_ienn hi 0 0 vdd vdd hvt11_enn sky130_fd_sc_hd__inv_1
Xhvt11_is1n hi 0 0 vdd vdd hvt11_s1n sky130_fd_sc_hd__inv_1
Xhvt11_is0n hi 0 0 vdd vdd hvt11_s0n sky130_fd_sc_hd__inv_1
Xhvt11_PREA pre hvt11_enn 0 0 vdd vdd hvt11_PREA sky130_fd_sc_hd__nor2_1
Xhvt11_PREB pre hvt11_enn 0 0 vdd vdd hvt11_PREB sky130_fd_sc_hd__nor2_1
Xhvt11_VBIAS hi 0 0 vdd vdd hvt11_VBIAS sky130_fd_sc_hd__buf_2
Xhvt11_C1 hi 0 0 vdd vdd hvt11_C1 sky130_fd_sc_hd__buf_2
Xhvt11_DUTA hi hvt11_s1n hi 0 0 vdd vdd hvt11_DUTA sky130_fd_sc_hd__and3_1
Xhvt11_DUTB hi hvt11_s1n hi 0 0 vdd vdd hvt11_DUTB sky130_fd_sc_hd__and3_1
Xhvt11_REFA hi hi 0 0 vdd vdd hvt11_REFA sky130_fd_sc_hd__and2_1
Xhvt11_REFB hi hi 0 0 vdd vdd hvt11_REFB sky130_fd_sc_hd__and2_1
Xhvt11_SA0B hi hi hi 0 0 vdd vdd hvt11_SA0B sky130_fd_sc_hd__nand3_1
Xhvt11_SA1B hi hi 0 0 vdd vdd hvt11_SA1B sky130_fd_sc_hd__nand2_1
Xhvt11_SA2B hi hi hvt11_s0n 0 0 vdd vdd hvt11_SA2B sky130_fd_sc_hd__nand3_1
Xhvt11_SB0B hi hi 0 0 vdd vdd hvt11_SB0B sky130_fd_sc_hd__nand2_1
Xhvt11_SB1B hi hi 0 0 vdd vdd hvt11_SB1B sky130_fd_sc_hd__nand2_1
Xhvt11_M hvt11_ob hvt11_SB0B hvt11_SB1B hvt11_REFB hvt11_oa hvt11_SA0B hvt11_SA1B hvt11_SA2B hvt11_REFA vdd 0 hvt11_VBIAS hvt11_C1 hvt11_PREA hvt11_XA hvt11_DUTA hvt11_PREB hvt11_XB hvt11_DUTB hvt11_VB 0 0 hvt

* --- hvt10: hvt
Xhvt10_ienn hi 0 0 vdd vdd hvt10_enn sky130_fd_sc_hd__inv_1
Xhvt10_is1n hi 0 0 vdd vdd hvt10_s1n sky130_fd_sc_hd__inv_1
Xhvt10_is0n 0 0 0 vdd vdd hvt10_s0n sky130_fd_sc_hd__inv_1
Xhvt10_PREA pre hvt10_enn 0 0 vdd vdd hvt10_PREA sky130_fd_sc_hd__nor2_1
Xhvt10_PREB pre hvt10_enn 0 0 vdd vdd hvt10_PREB sky130_fd_sc_hd__nor2_1
Xhvt10_VBIAS hi 0 0 vdd vdd hvt10_VBIAS sky130_fd_sc_hd__buf_2
Xhvt10_C1 hi 0 0 vdd vdd hvt10_C1 sky130_fd_sc_hd__buf_2
Xhvt10_DUTA hi hvt10_s1n 0 0 0 vdd vdd hvt10_DUTA sky130_fd_sc_hd__and3_1
Xhvt10_DUTB hi hvt10_s1n 0 0 0 vdd vdd hvt10_DUTB sky130_fd_sc_hd__and3_1
Xhvt10_REFA hi hi 0 0 vdd vdd hvt10_REFA sky130_fd_sc_hd__and2_1
Xhvt10_REFB hi hi 0 0 vdd vdd hvt10_REFB sky130_fd_sc_hd__and2_1
Xhvt10_SA0B hi hi 0 0 0 vdd vdd hvt10_SA0B sky130_fd_sc_hd__nand3_1
Xhvt10_SA1B hi hi 0 0 vdd vdd hvt10_SA1B sky130_fd_sc_hd__nand2_1
Xhvt10_SA2B hi hi hvt10_s0n 0 0 vdd vdd hvt10_SA2B sky130_fd_sc_hd__nand3_1
Xhvt10_SB0B hi hi 0 0 vdd vdd hvt10_SB0B sky130_fd_sc_hd__nand2_1
Xhvt10_SB1B hi hi 0 0 vdd vdd hvt10_SB1B sky130_fd_sc_hd__nand2_1
Xhvt10_M hvt10_ob hvt10_SB0B hvt10_SB1B hvt10_REFB hvt10_oa hvt10_SA0B hvt10_SA1B hvt10_SA2B hvt10_REFA vdd 0 hvt10_VBIAS hvt10_C1 hvt10_PREA hvt10_XA hvt10_DUTA hvt10_PREB hvt10_XB hvt10_DUTB hvt10_VB 0 0 hvt

* --- hvtt: thvt
Xhvtt_ienn hi 0 0 vdd vdd hvtt_enn sky130_fd_sc_hd__inv_1
Xhvtt_is1n 0 0 0 vdd vdd hvtt_s1n sky130_fd_sc_hd__inv_1
Xhvtt_is0n hi 0 0 vdd vdd hvtt_s0n sky130_fd_sc_hd__inv_1
Xhvtt_PREA pre hvtt_enn 0 0 vdd vdd hvtt_PREA sky130_fd_sc_hd__nor2_1
Xhvtt_PREB pre hvtt_enn 0 0 vdd vdd hvtt_PREB sky130_fd_sc_hd__nor2_1
Xhvtt_VBIAS hi 0 0 vdd vdd hvtt_VBIAS sky130_fd_sc_hd__buf_2
Xhvtt_C1 hi 0 0 vdd vdd hvtt_C1 sky130_fd_sc_hd__buf_2
Xhvtt_DUTA hi hvtt_s1n hi 0 0 vdd vdd hvtt_DUTA sky130_fd_sc_hd__and3_1
Xhvtt_DUTB hi hvtt_s1n hi 0 0 vdd vdd hvtt_DUTB sky130_fd_sc_hd__and3_1
Xhvtt_REFA hi 0 0 0 vdd vdd hvtt_REFA sky130_fd_sc_hd__and2_1
Xhvtt_REFB hi 0 0 0 vdd vdd hvtt_REFB sky130_fd_sc_hd__and2_1
Xhvtt_SA0B hi 0 hi 0 0 vdd vdd hvtt_SA0B sky130_fd_sc_hd__nand3_1
Xhvtt_SA1B hi 0 0 0 vdd vdd hvtt_SA1B sky130_fd_sc_hd__nand2_1
Xhvtt_SA2B hi 0 hvtt_s0n 0 0 vdd vdd hvtt_SA2B sky130_fd_sc_hd__nand3_1
Xhvtt_SB0B hi 0 0 0 vdd vdd hvtt_SB0B sky130_fd_sc_hd__nand2_1
Xhvtt_SB1B hi 0 0 0 vdd vdd hvtt_SB1B sky130_fd_sc_hd__nand2_1
Xhvtt_M hvtt_ob hvtt_SB0B hvtt_SB1B hvtt_REFB hvtt_oa hvtt_SA0B hvtt_SA1B hvtt_SA2B hvtt_REFA vdd 0 hvtt_VBIAS hvtt_C1 hvtt_PREA hvtt_XA hvtt_DUTA hvtt_PREB hvtt_XB hvtt_DUTB hvtt_VB 0 0 hvtt_GT thvt

Bhvtt_gt hvtt_GT 0 V=v(hvtt_VB)+0.000305
.control
set noaskquit
save v(core01_oa) v(core01_ob) v(core11_oa) v(core11_ob) v(core10_oa) v(core10_ob) v(coret_oa) v(coret_ob) v(hvt01_oa) v(hvt01_ob) v(hvt11_oa) v(hvt11_ob) v(hvt10_oa) v(hvt10_ob) v(hvtt_oa) v(hvtt_ob)
tran 10n 80u 0 10n
meas tran core01_oa when v(core01_oa)=0.9 rise=1
meas tran core01_ob when v(core01_ob)=0.9 rise=1
meas tran core11_oa when v(core11_oa)=0.9 rise=1
meas tran core11_ob when v(core11_ob)=0.9 rise=1
meas tran core10_oa when v(core10_oa)=0.9 rise=1
meas tran core10_ob when v(core10_ob)=0.9 rise=1
meas tran coret_oa when v(coret_oa)=0.9 rise=1
meas tran coret_ob when v(coret_ob)=0.9 rise=1
meas tran hvt01_oa when v(hvt01_oa)=0.9 rise=1
meas tran hvt01_ob when v(hvt01_ob)=0.9 rise=1
meas tran hvt11_oa when v(hvt11_oa)=0.9 rise=1
meas tran hvt11_ob when v(hvt11_ob)=0.9 rise=1
meas tran hvt10_oa when v(hvt10_oa)=0.9 rise=1
meas tran hvt10_ob when v(hvt10_ob)=0.9 rise=1
meas tran hvtt_oa when v(hvtt_oa)=0.9 rise=1
meas tran hvtt_ob when v(hvtt_ob)=0.9 rise=1
echo RES ss 85 core01_oa=$&core01_oa
echo RES ss 85 core01_ob=$&core01_ob
echo RES ss 85 core11_oa=$&core11_oa
echo RES ss 85 core11_ob=$&core11_ob
echo RES ss 85 core10_oa=$&core10_oa
echo RES ss 85 core10_ob=$&core10_ob
echo RES ss 85 coret_oa=$&coret_oa
echo RES ss 85 coret_ob=$&coret_ob
echo RES ss 85 hvt01_oa=$&hvt01_oa
echo RES ss 85 hvt01_ob=$&hvt01_ob
echo RES ss 85 hvt11_oa=$&hvt11_oa
echo RES ss 85 hvt11_ob=$&hvt11_ob
echo RES ss 85 hvt10_oa=$&hvt10_oa
echo RES ss 85 hvt10_ob=$&hvt10_ob
echo RES ss 85 hvtt_oa=$&hvtt_oa
echo RES ss 85 hvtt_ob=$&hvtt_ob
quit
.endc
.end
