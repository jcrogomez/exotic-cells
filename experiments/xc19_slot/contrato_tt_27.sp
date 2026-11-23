* MISFIT-03 etapa a · temporizacion · esquina tt 27 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
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
.subckt f1 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
C74 a_n2090_n1632# VB 0.41781f
C75 XA_OUT XA 0.02816f
C77 VDD a_7650_n924# 0.07321f
C78 a_n2090_n1632# a_n950_n924# 0
C79 VDD a_4500_n392# 0.00496f
C80 XB_OUT VDD 0.1139f
C81 a_n2090_n1632# VDD 0.02312f
C82 SB1B SB0B 0.01827f
C83 SA1B a_n2090_n1632# 0
C84 C1 VBIAS 0.05143f
C86 VB VBIAS 0.00565f
C87 VB a_n2000_n1632# 0.14597f
C88 XB a_7090_n924# 0.05363f
C89 a_n2090_n1632# a_n1230_n924# 0.04617f
C90 XB VB 0.97066f
C91 C1 VB 0.00902f
C92 a_n2090_n1632# XA 0.42116f
C93 VB a_7090_n924# 0
C94 XB a_7370_n924# 0.14938f
C96 a_7370_n924# a_7090_n924# 0.00251f
C97 XB a_7130_n1632# 0.42116f
C98 VB a_7370_n924# 0.01419f
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
C176 a_4500_n392# GND 0.20468f
C177 a_3900_n392# GND 0.19922f
C178 a_n48_382# GND 0.59697f
.ends
.subckt f4 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
.subckt f6 XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
Vd vdd 0 1.8
Vdl vdl 0 1.79
Vdh vdh 0 1.81
Vh hi 0 1.8
Vpre pre 0 pwl(0 1.8 1e-06 1.8 1.001e-06 0)
* --- h01: core
Xh01_ienn hi 0 0 vdd vdd h01_enn sky130_fd_sc_hd__inv_1
Xh01_is1n 0 0 0 vdd vdd h01_s1n sky130_fd_sc_hd__inv_1
Xh01_is0n hi 0 0 vdd vdd h01_s0n sky130_fd_sc_hd__inv_1
Xh01_PREA pre h01_enn 0 0 vdd vdd h01_PREA sky130_fd_sc_hd__nor2_1
Xh01_PREB pre h01_enn 0 0 vdd vdd h01_PREB sky130_fd_sc_hd__nor2_1
Xh01_VBIAS hi 0 0 vdd vdd h01_VBIAS sky130_fd_sc_hd__buf_2
Xh01_C1 hi 0 0 vdd vdd h01_C1 sky130_fd_sc_hd__buf_2
Xh01_DUTA hi h01_s1n hi 0 0 vdd vdd h01_DUTA sky130_fd_sc_hd__and3_1
Xh01_DUTB hi h01_s1n hi 0 0 vdd vdd h01_DUTB sky130_fd_sc_hd__and3_1
Xh01_REFA hi 0 0 0 vdd vdd h01_REFA sky130_fd_sc_hd__and2_1
Xh01_REFB hi 0 0 0 vdd vdd h01_REFB sky130_fd_sc_hd__and2_1
Xh01_SA0B hi 0 hi 0 0 vdd vdd h01_SA0B sky130_fd_sc_hd__nand3_1
Xh01_SA1B hi 0 0 0 vdd vdd h01_SA1B sky130_fd_sc_hd__nand2_1
Xh01_SA2B hi 0 h01_s0n 0 0 vdd vdd h01_SA2B sky130_fd_sc_hd__nand3_1
Xh01_SB0B hi 0 0 0 vdd vdd h01_SB0B sky130_fd_sc_hd__nand2_1
Xh01_SB1B hi 0 0 0 vdd vdd h01_SB1B sky130_fd_sc_hd__nand2_1
Xh01_M h01_ob h01_SB0B h01_SB1B h01_REFB h01_oa h01_SA0B h01_SA1B h01_SA2B h01_REFA vdd 0 h01_VBIAS h01_C1 h01_PREA h01_XA h01_DUTA h01_PREB h01_XB h01_DUTB h01_VB 0 0 core

* --- h11: core
Xh11_ienn hi 0 0 vdd vdd h11_enn sky130_fd_sc_hd__inv_1
Xh11_is1n hi 0 0 vdd vdd h11_s1n sky130_fd_sc_hd__inv_1
Xh11_is0n hi 0 0 vdd vdd h11_s0n sky130_fd_sc_hd__inv_1
Xh11_PREA pre h11_enn 0 0 vdd vdd h11_PREA sky130_fd_sc_hd__nor2_1
Xh11_PREB pre h11_enn 0 0 vdd vdd h11_PREB sky130_fd_sc_hd__nor2_1
Xh11_VBIAS hi 0 0 vdd vdd h11_VBIAS sky130_fd_sc_hd__buf_2
Xh11_C1 hi 0 0 vdd vdd h11_C1 sky130_fd_sc_hd__buf_2
Xh11_DUTA hi h11_s1n hi 0 0 vdd vdd h11_DUTA sky130_fd_sc_hd__and3_1
Xh11_DUTB hi h11_s1n hi 0 0 vdd vdd h11_DUTB sky130_fd_sc_hd__and3_1
Xh11_REFA hi hi 0 0 vdd vdd h11_REFA sky130_fd_sc_hd__and2_1
Xh11_REFB hi hi 0 0 vdd vdd h11_REFB sky130_fd_sc_hd__and2_1
Xh11_SA0B hi hi hi 0 0 vdd vdd h11_SA0B sky130_fd_sc_hd__nand3_1
Xh11_SA1B hi hi 0 0 vdd vdd h11_SA1B sky130_fd_sc_hd__nand2_1
Xh11_SA2B hi hi h11_s0n 0 0 vdd vdd h11_SA2B sky130_fd_sc_hd__nand3_1
Xh11_SB0B hi hi 0 0 vdd vdd h11_SB0B sky130_fd_sc_hd__nand2_1
Xh11_SB1B hi hi 0 0 vdd vdd h11_SB1B sky130_fd_sc_hd__nand2_1
Xh11_M h11_ob h11_SB0B h11_SB1B h11_REFB h11_oa h11_SA0B h11_SA1B h11_SA2B h11_REFA vdd 0 h11_VBIAS h11_C1 h11_PREA h11_XA h11_DUTA h11_PREB h11_XB h11_DUTB h11_VB 0 0 core

* --- h10: core
Xh10_ienn hi 0 0 vdd vdd h10_enn sky130_fd_sc_hd__inv_1
Xh10_is1n hi 0 0 vdd vdd h10_s1n sky130_fd_sc_hd__inv_1
Xh10_is0n 0 0 0 vdd vdd h10_s0n sky130_fd_sc_hd__inv_1
Xh10_PREA pre h10_enn 0 0 vdd vdd h10_PREA sky130_fd_sc_hd__nor2_1
Xh10_PREB pre h10_enn 0 0 vdd vdd h10_PREB sky130_fd_sc_hd__nor2_1
Xh10_VBIAS hi 0 0 vdd vdd h10_VBIAS sky130_fd_sc_hd__buf_2
Xh10_C1 hi 0 0 vdd vdd h10_C1 sky130_fd_sc_hd__buf_2
Xh10_DUTA hi h10_s1n 0 0 0 vdd vdd h10_DUTA sky130_fd_sc_hd__and3_1
Xh10_DUTB hi h10_s1n 0 0 0 vdd vdd h10_DUTB sky130_fd_sc_hd__and3_1
Xh10_REFA hi hi 0 0 vdd vdd h10_REFA sky130_fd_sc_hd__and2_1
Xh10_REFB hi hi 0 0 vdd vdd h10_REFB sky130_fd_sc_hd__and2_1
Xh10_SA0B hi hi 0 0 0 vdd vdd h10_SA0B sky130_fd_sc_hd__nand3_1
Xh10_SA1B hi hi 0 0 vdd vdd h10_SA1B sky130_fd_sc_hd__nand2_1
Xh10_SA2B hi hi h10_s0n 0 0 vdd vdd h10_SA2B sky130_fd_sc_hd__nand3_1
Xh10_SB0B hi hi 0 0 vdd vdd h10_SB0B sky130_fd_sc_hd__nand2_1
Xh10_SB1B hi hi 0 0 vdd vdd h10_SB1B sky130_fd_sc_hd__nand2_1
Xh10_M h10_ob h10_SB0B h10_SB1B h10_REFB h10_oa h10_SA0B h10_SA1B h10_SA2B h10_REFA vdd 0 h10_VBIAS h10_C1 h10_PREA h10_XA h10_DUTA h10_PREB h10_XB h10_DUTB h10_VB 0 0 core

* --- t01: trap
Xt01_ienn hi 0 0 vdd vdd t01_enn sky130_fd_sc_hd__inv_1
Xt01_is1n 0 0 0 vdd vdd t01_s1n sky130_fd_sc_hd__inv_1
Xt01_is0n hi 0 0 vdd vdd t01_s0n sky130_fd_sc_hd__inv_1
Xt01_PREA pre t01_enn 0 0 vdd vdd t01_PREA sky130_fd_sc_hd__nor2_1
Xt01_PREB pre t01_enn 0 0 vdd vdd t01_PREB sky130_fd_sc_hd__nor2_1
Xt01_VBIAS hi 0 0 vdd vdd t01_VBIAS sky130_fd_sc_hd__buf_2
Xt01_C1 hi 0 0 vdd vdd t01_C1 sky130_fd_sc_hd__buf_2
Xt01_DUTA hi t01_s1n hi 0 0 vdd vdd t01_DUTA sky130_fd_sc_hd__and3_1
Xt01_DUTB hi t01_s1n hi 0 0 vdd vdd t01_DUTB sky130_fd_sc_hd__and3_1
Xt01_REFA hi 0 0 0 vdd vdd t01_REFA sky130_fd_sc_hd__and2_1
Xt01_REFB hi 0 0 0 vdd vdd t01_REFB sky130_fd_sc_hd__and2_1
Xt01_SA0B hi 0 hi 0 0 vdd vdd t01_SA0B sky130_fd_sc_hd__nand3_1
Xt01_SA1B hi 0 0 0 vdd vdd t01_SA1B sky130_fd_sc_hd__nand2_1
Xt01_SA2B hi 0 t01_s0n 0 0 vdd vdd t01_SA2B sky130_fd_sc_hd__nand3_1
Xt01_SB0B hi 0 0 0 vdd vdd t01_SB0B sky130_fd_sc_hd__nand2_1
Xt01_SB1B hi 0 0 0 vdd vdd t01_SB1B sky130_fd_sc_hd__nand2_1
Xt01_M t01_ob t01_SB0B t01_SB1B t01_REFB t01_oa t01_SA0B t01_SA1B t01_SA2B t01_REFA vdd 0 t01_VBIAS t01_C1 t01_PREA t01_XA t01_DUTA t01_PREB t01_XB t01_DUTB t01_VB 0 0 t01_GT trap
Bt01_gt t01_GT 0 V=v(t01_VB)+0.000305

* --- l01: core
Xl01_ienn hi 0 0 vdl vdl l01_enn sky130_fd_sc_hd__inv_1
Xl01_is1n 0 0 0 vdl vdl l01_s1n sky130_fd_sc_hd__inv_1
Xl01_is0n hi 0 0 vdl vdl l01_s0n sky130_fd_sc_hd__inv_1
Xl01_PREA pre l01_enn 0 0 vdl vdl l01_PREA sky130_fd_sc_hd__nor2_1
Xl01_PREB pre l01_enn 0 0 vdl vdl l01_PREB sky130_fd_sc_hd__nor2_1
Xl01_VBIAS hi 0 0 vdl vdl l01_VBIAS sky130_fd_sc_hd__buf_2
Xl01_C1 hi 0 0 vdl vdl l01_C1 sky130_fd_sc_hd__buf_2
Xl01_DUTA hi l01_s1n hi 0 0 vdl vdl l01_DUTA sky130_fd_sc_hd__and3_1
Xl01_DUTB hi l01_s1n hi 0 0 vdl vdl l01_DUTB sky130_fd_sc_hd__and3_1
Xl01_REFA hi 0 0 0 vdl vdl l01_REFA sky130_fd_sc_hd__and2_1
Xl01_REFB hi 0 0 0 vdl vdl l01_REFB sky130_fd_sc_hd__and2_1
Xl01_SA0B hi 0 hi 0 0 vdl vdl l01_SA0B sky130_fd_sc_hd__nand3_1
Xl01_SA1B hi 0 0 0 vdl vdl l01_SA1B sky130_fd_sc_hd__nand2_1
Xl01_SA2B hi 0 l01_s0n 0 0 vdl vdl l01_SA2B sky130_fd_sc_hd__nand3_1
Xl01_SB0B hi 0 0 0 vdl vdl l01_SB0B sky130_fd_sc_hd__nand2_1
Xl01_SB1B hi 0 0 0 vdl vdl l01_SB1B sky130_fd_sc_hd__nand2_1
Xl01_M l01_ob l01_SB0B l01_SB1B l01_REFB l01_oa l01_SA0B l01_SA1B l01_SA2B l01_REFA vdl 0 l01_VBIAS l01_C1 l01_PREA l01_XA l01_DUTA l01_PREB l01_XB l01_DUTB l01_VB 0 0 core

* --- u01: core
Xu01_ienn hi 0 0 vdh vdh u01_enn sky130_fd_sc_hd__inv_1
Xu01_is1n 0 0 0 vdh vdh u01_s1n sky130_fd_sc_hd__inv_1
Xu01_is0n hi 0 0 vdh vdh u01_s0n sky130_fd_sc_hd__inv_1
Xu01_PREA pre u01_enn 0 0 vdh vdh u01_PREA sky130_fd_sc_hd__nor2_1
Xu01_PREB pre u01_enn 0 0 vdh vdh u01_PREB sky130_fd_sc_hd__nor2_1
Xu01_VBIAS hi 0 0 vdh vdh u01_VBIAS sky130_fd_sc_hd__buf_2
Xu01_C1 hi 0 0 vdh vdh u01_C1 sky130_fd_sc_hd__buf_2
Xu01_DUTA hi u01_s1n hi 0 0 vdh vdh u01_DUTA sky130_fd_sc_hd__and3_1
Xu01_DUTB hi u01_s1n hi 0 0 vdh vdh u01_DUTB sky130_fd_sc_hd__and3_1
Xu01_REFA hi 0 0 0 vdh vdh u01_REFA sky130_fd_sc_hd__and2_1
Xu01_REFB hi 0 0 0 vdh vdh u01_REFB sky130_fd_sc_hd__and2_1
Xu01_SA0B hi 0 hi 0 0 vdh vdh u01_SA0B sky130_fd_sc_hd__nand3_1
Xu01_SA1B hi 0 0 0 vdh vdh u01_SA1B sky130_fd_sc_hd__nand2_1
Xu01_SA2B hi 0 u01_s0n 0 0 vdh vdh u01_SA2B sky130_fd_sc_hd__nand3_1
Xu01_SB0B hi 0 0 0 vdh vdh u01_SB0B sky130_fd_sc_hd__nand2_1
Xu01_SB1B hi 0 0 0 vdh vdh u01_SB1B sky130_fd_sc_hd__nand2_1
Xu01_M u01_ob u01_SB0B u01_SB1B u01_REFB u01_oa u01_SA0B u01_SA1B u01_SA2B u01_REFA vdh 0 u01_VBIAS u01_C1 u01_PREA u01_XA u01_DUTA u01_PREB u01_XB u01_DUTB u01_VB 0 0 core

* --- f1a: f1
Xf1a_ienn hi 0 0 vdd vdd f1a_enn sky130_fd_sc_hd__inv_1
Xf1a_is1n hi 0 0 vdd vdd f1a_s1n sky130_fd_sc_hd__inv_1
Xf1a_is0n hi 0 0 vdd vdd f1a_s0n sky130_fd_sc_hd__inv_1
Xf1a_PREA pre f1a_enn 0 0 vdd vdd f1a_PREA sky130_fd_sc_hd__nor2_1
Xf1a_PREB pre f1a_enn 0 0 vdd vdd f1a_PREB sky130_fd_sc_hd__nor2_1
Xf1a_VBIAS hi 0 0 vdd vdd f1a_VBIAS sky130_fd_sc_hd__buf_2
Xf1a_C1 hi 0 0 vdd vdd f1a_C1 sky130_fd_sc_hd__buf_2
Xf1a_DUTA hi f1a_s1n hi 0 0 vdd vdd f1a_DUTA sky130_fd_sc_hd__and3_1
Xf1a_DUTB hi f1a_s1n hi 0 0 vdd vdd f1a_DUTB sky130_fd_sc_hd__and3_1
Xf1a_REFA hi hi 0 0 vdd vdd f1a_REFA sky130_fd_sc_hd__and2_1
Xf1a_REFB hi hi 0 0 vdd vdd f1a_REFB sky130_fd_sc_hd__and2_1
Xf1a_SA0B hi hi hi 0 0 vdd vdd f1a_SA0B sky130_fd_sc_hd__nand3_1
Xf1a_SA1B hi hi 0 0 vdd vdd f1a_SA1B sky130_fd_sc_hd__nand2_1
Xf1a_SA2B hi hi f1a_s0n 0 0 vdd vdd f1a_SA2B sky130_fd_sc_hd__nand3_1
Xf1a_SB0B hi hi 0 0 vdd vdd f1a_SB0B sky130_fd_sc_hd__nand2_1
Xf1a_SB1B hi hi 0 0 vdd vdd f1a_SB1B sky130_fd_sc_hd__nand2_1
Xf1a_M f1a_ob f1a_SB0B f1a_SB1B f1a_REFB f1a_oa f1a_SA0B f1a_SA1B f1a_SA2B f1a_REFA vdd 0 f1a_VBIAS f1a_C1 f1a_PREA f1a_XA f1a_DUTA f1a_PREB f1a_XB f1a_DUTB f1a_VB 0 0 f1

* --- f1b: f1
Xf1b_ienn hi 0 0 vdd vdd f1b_enn sky130_fd_sc_hd__inv_1
Xf1b_is1n hi 0 0 vdd vdd f1b_s1n sky130_fd_sc_hd__inv_1
Xf1b_is0n 0 0 0 vdd vdd f1b_s0n sky130_fd_sc_hd__inv_1
Xf1b_PREA pre f1b_enn 0 0 vdd vdd f1b_PREA sky130_fd_sc_hd__nor2_1
Xf1b_PREB pre f1b_enn 0 0 vdd vdd f1b_PREB sky130_fd_sc_hd__nor2_1
Xf1b_VBIAS hi 0 0 vdd vdd f1b_VBIAS sky130_fd_sc_hd__buf_2
Xf1b_C1 hi 0 0 vdd vdd f1b_C1 sky130_fd_sc_hd__buf_2
Xf1b_DUTA hi f1b_s1n 0 0 0 vdd vdd f1b_DUTA sky130_fd_sc_hd__and3_1
Xf1b_DUTB hi f1b_s1n 0 0 0 vdd vdd f1b_DUTB sky130_fd_sc_hd__and3_1
Xf1b_REFA hi hi 0 0 vdd vdd f1b_REFA sky130_fd_sc_hd__and2_1
Xf1b_REFB hi hi 0 0 vdd vdd f1b_REFB sky130_fd_sc_hd__and2_1
Xf1b_SA0B hi hi 0 0 0 vdd vdd f1b_SA0B sky130_fd_sc_hd__nand3_1
Xf1b_SA1B hi hi 0 0 vdd vdd f1b_SA1B sky130_fd_sc_hd__nand2_1
Xf1b_SA2B hi hi f1b_s0n 0 0 vdd vdd f1b_SA2B sky130_fd_sc_hd__nand3_1
Xf1b_SB0B hi hi 0 0 vdd vdd f1b_SB0B sky130_fd_sc_hd__nand2_1
Xf1b_SB1B hi hi 0 0 vdd vdd f1b_SB1B sky130_fd_sc_hd__nand2_1
Xf1b_M f1b_ob f1b_SB0B f1b_SB1B f1b_REFB f1b_oa f1b_SA0B f1b_SA1B f1b_SA2B f1b_REFA vdd 0 f1b_VBIAS f1b_C1 f1b_PREA f1b_XA f1b_DUTA f1b_PREB f1b_XB f1b_DUTB f1b_VB 0 0 f1

* --- f2: core
Xf2_ienn hi 0 0 vdd vdd f2_enn sky130_fd_sc_hd__inv_1
Xf2_is1n 0 0 0 vdd vdd f2_s1n sky130_fd_sc_hd__inv_1
Xf2_is0n hi 0 0 vdd vdd f2_s0n sky130_fd_sc_hd__inv_1
Xf2_PREA pre f2_enn 0 0 vdd vdd f2_PREA sky130_fd_sc_hd__nor2_1
Xf2_PREB pre f2_enn 0 0 vdd vdd f2_PREB sky130_fd_sc_hd__nor2_1
Xf2_VBIAS hi 0 0 vdd vdd f2_VBIAS sky130_fd_sc_hd__buf_2
Xf2_C1 hi 0 0 vdd vdd f2_C1 sky130_fd_sc_hd__buf_2
Xf2_DUTA hi f2_s1n hi 0 0 vdd vdd f2_DUTA sky130_fd_sc_hd__and3_1
Xf2_DUTB hi f2_s1n hi 0 0 vdd vdd f2_DUTB sky130_fd_sc_hd__and3_1
Xf2_REFA hi 0 0 0 vdd vdd f2_REFA sky130_fd_sc_hd__and2_1
Xf2_REFB hi 0 0 0 vdd vdd f2_REFB sky130_fd_sc_hd__and2_1
Xf2_SA0B hi 0 hi 0 0 vdd vdd f2_SA0B sky130_fd_sc_hd__nand3_1
Xf2_SA1B hi 0 0 0 vdd vdd f2_SA1B_nc sky130_fd_sc_hd__nand2_1
Rf2_SA1Bnc f2_SA1B_nc 0 1G
Xf2_SA2B hi 0 f2_s0n 0 0 vdd vdd f2_SA2B sky130_fd_sc_hd__nand3_1
Xf2_SB0B hi 0 0 0 vdd vdd f2_SB0B sky130_fd_sc_hd__nand2_1
Xf2_SB1B hi 0 0 0 vdd vdd f2_SB1B sky130_fd_sc_hd__nand2_1
Xf2_M f2_ob f2_SB0B f2_SB1B f2_REFB f2_oa f2_SA0B 0 f2_SA2B f2_REFA vdd 0 f2_VBIAS f2_C1 f2_PREA f2_XA f2_DUTA f2_PREB f2_XB f2_DUTB f2_VB 0 0 core

* --- f3: core
Xf3_ienn hi 0 0 vdd vdd f3_enn sky130_fd_sc_hd__inv_1
Xf3_is1n 0 0 0 vdd vdd f3_s1n sky130_fd_sc_hd__inv_1
Xf3_is0n hi 0 0 vdd vdd f3_s0n sky130_fd_sc_hd__inv_1
Xf3_PREA pre f3_enn 0 0 vdd vdd f3_PREA sky130_fd_sc_hd__nor2_1
Xf3_PREB pre f3_enn 0 0 vdd vdd f3_PREB sky130_fd_sc_hd__nor2_1
Xf3_VBIAS hi 0 0 vdd vdd f3_VBIAS sky130_fd_sc_hd__buf_2
Xf3_C1 hi 0 0 vdd vdd f3_C1 sky130_fd_sc_hd__buf_2
Xf3_DUTA hi f3_s1n hi 0 0 vdd vdd f3_DUTA sky130_fd_sc_hd__and3_1
Xf3_DUTB hi f3_s1n hi 0 0 vdd vdd f3_DUTB sky130_fd_sc_hd__and3_1
Xf3_REFA hi 0 0 0 vdd vdd f3_REFA sky130_fd_sc_hd__and2_1
Xf3_REFB hi 0 0 0 vdd vdd f3_REFB sky130_fd_sc_hd__and2_1
Xf3_SA0B hi 0 hi 0 0 vdd vdd f3_SA0B sky130_fd_sc_hd__nand3_1
Xf3_SA1B hi 0 0 0 vdd vdd f3_SA1B sky130_fd_sc_hd__nand2_1
Xf3_SA2B hi 0 f3_s0n 0 0 vdd vdd f3_SA2B sky130_fd_sc_hd__nand3_1
Xf3_SB0B hi 0 0 0 vdd vdd f3_SB0B sky130_fd_sc_hd__nand2_1
Xf3_SB1B hi 0 0 0 vdd vdd f3_SB1B sky130_fd_sc_hd__nand2_1
Xf3_M f3_ob f3_SB0B f3_SB1B f3_REFB f3_oa f3_SA0B f3_SA1B f3_SA2B f3_REFA vdd 0 f3_VBIAS f3_C1 f3_PREA f3_XA f3_DUTA f3_PREB f3_XB f3_DUTB f3_VB 0 0 core
Rf3 f3_oa vdd 1
* --- f4: f4
Xf4_ienn hi 0 0 vdd vdd f4_enn sky130_fd_sc_hd__inv_1
Xf4_is1n 0 0 0 vdd vdd f4_s1n sky130_fd_sc_hd__inv_1
Xf4_is0n hi 0 0 vdd vdd f4_s0n sky130_fd_sc_hd__inv_1
Xf4_PREA pre f4_enn 0 0 vdd vdd f4_PREA sky130_fd_sc_hd__nor2_1
Xf4_PREB pre f4_enn 0 0 vdd vdd f4_PREB sky130_fd_sc_hd__nor2_1
Xf4_VBIAS hi 0 0 vdd vdd f4_VBIAS sky130_fd_sc_hd__buf_2
Xf4_C1 hi 0 0 vdd vdd f4_C1 sky130_fd_sc_hd__buf_2
Xf4_DUTA hi f4_s1n hi 0 0 vdd vdd f4_DUTA sky130_fd_sc_hd__and3_1
Xf4_DUTB hi f4_s1n hi 0 0 vdd vdd f4_DUTB sky130_fd_sc_hd__and3_1
Xf4_REFA hi 0 0 0 vdd vdd f4_REFA sky130_fd_sc_hd__and2_1
Xf4_REFB hi 0 0 0 vdd vdd f4_REFB sky130_fd_sc_hd__and2_1
Xf4_SA0B hi 0 hi 0 0 vdd vdd f4_SA0B sky130_fd_sc_hd__nand3_1
Xf4_SA1B hi 0 0 0 vdd vdd f4_SA1B sky130_fd_sc_hd__nand2_1
Xf4_SA2B hi 0 f4_s0n 0 0 vdd vdd f4_SA2B sky130_fd_sc_hd__nand3_1
Xf4_SB0B hi 0 0 0 vdd vdd f4_SB0B sky130_fd_sc_hd__nand2_1
Xf4_SB1B hi 0 0 0 vdd vdd f4_SB1B sky130_fd_sc_hd__nand2_1
Xf4_M f4_ob f4_SB0B f4_SB1B f4_REFB f4_oa f4_SA0B f4_SA1B f4_SA2B f4_REFA vdd 0 f4_VBIAS f4_C1 f4_PREA f4_XA f4_DUTA f4_PREB f4_XB f4_DUTB f4_VB 0 0 f4

* --- f7: core
Xf7_ienn hi 0 0 vdd vdd f7_enn sky130_fd_sc_hd__inv_1
Xf7_is1n hi 0 0 vdd vdd f7_s1n sky130_fd_sc_hd__inv_1
Xf7_is0n hi 0 0 vdd vdd f7_s0n sky130_fd_sc_hd__inv_1
Xf7_PREA pre f7_enn 0 0 vdd vdd f7_PREA sky130_fd_sc_hd__nor2_1
Xf7_PREB pre f7_enn 0 0 vdd vdd f7_PREB sky130_fd_sc_hd__nor2_1
Xf7_VBIAS hi 0 0 vdd vdd f7_VBIAS sky130_fd_sc_hd__buf_2
Xf7_C1 hi 0 0 vdd vdd f7_C1 sky130_fd_sc_hd__buf_2
Xf7_DUTA hi f7_s1n hi 0 0 vdd vdd f7_DUTA_nc sky130_fd_sc_hd__and3_1
Rf7_DUTAnc f7_DUTA_nc 0 1G
Xf7_DUTB hi f7_s1n hi 0 0 vdd vdd f7_DUTB sky130_fd_sc_hd__and3_1
Xf7_REFA hi hi 0 0 vdd vdd f7_REFA sky130_fd_sc_hd__and2_1
Xf7_REFB hi hi 0 0 vdd vdd f7_REFB sky130_fd_sc_hd__and2_1
Xf7_SA0B hi hi hi 0 0 vdd vdd f7_SA0B sky130_fd_sc_hd__nand3_1
Xf7_SA1B hi hi 0 0 vdd vdd f7_SA1B sky130_fd_sc_hd__nand2_1
Xf7_SA2B hi hi f7_s0n 0 0 vdd vdd f7_SA2B sky130_fd_sc_hd__nand3_1
Xf7_SB0B hi hi 0 0 vdd vdd f7_SB0B sky130_fd_sc_hd__nand2_1
Xf7_SB1B hi hi 0 0 vdd vdd f7_SB1B sky130_fd_sc_hd__nand2_1
Xf7_M f7_ob f7_SB0B f7_SB1B f7_REFB f7_oa f7_SA0B f7_SA1B f7_SA2B f7_REFA vdd 0 f7_VBIAS f7_C1 f7_PREA f7_XA vdd f7_PREB f7_XB f7_DUTB f7_VB 0 0 core

.control
set noaskquit
tran 10n 80u
meas tran h01_oa when v(h01_oa)=0.9 rise=1
meas tran h01_oa_pre avg v(h01_oa) from=9.7e-07 to=9.9e-07
meas tran h01_ob when v(h01_ob)=0.9 rise=1
meas tran h01_ob_pre avg v(h01_ob) from=9.7e-07 to=9.9e-07
meas tran h11_oa when v(h11_oa)=0.9 rise=1
meas tran h11_oa_pre avg v(h11_oa) from=9.7e-07 to=9.9e-07
meas tran h11_ob when v(h11_ob)=0.9 rise=1
meas tran h11_ob_pre avg v(h11_ob) from=9.7e-07 to=9.9e-07
meas tran h10_oa when v(h10_oa)=0.9 rise=1
meas tran h10_oa_pre avg v(h10_oa) from=9.7e-07 to=9.9e-07
meas tran h10_ob when v(h10_ob)=0.9 rise=1
meas tran h10_ob_pre avg v(h10_ob) from=9.7e-07 to=9.9e-07
meas tran t01_oa when v(t01_oa)=0.9 rise=1
meas tran t01_oa_pre avg v(t01_oa) from=9.7e-07 to=9.9e-07
meas tran t01_ob when v(t01_ob)=0.9 rise=1
meas tran t01_ob_pre avg v(t01_ob) from=9.7e-07 to=9.9e-07
meas tran l01_oa when v(l01_oa)=0.9 rise=1
meas tran l01_oa_pre avg v(l01_oa) from=9.7e-07 to=9.9e-07
meas tran l01_ob when v(l01_ob)=0.9 rise=1
meas tran l01_ob_pre avg v(l01_ob) from=9.7e-07 to=9.9e-07
meas tran u01_oa when v(u01_oa)=0.9 rise=1
meas tran u01_oa_pre avg v(u01_oa) from=9.7e-07 to=9.9e-07
meas tran u01_ob when v(u01_ob)=0.9 rise=1
meas tran u01_ob_pre avg v(u01_ob) from=9.7e-07 to=9.9e-07
meas tran f1a_oa when v(f1a_oa)=0.9 rise=1
meas tran f1a_oa_pre avg v(f1a_oa) from=9.7e-07 to=9.9e-07
meas tran f1a_ob when v(f1a_ob)=0.9 rise=1
meas tran f1a_ob_pre avg v(f1a_ob) from=9.7e-07 to=9.9e-07
meas tran f1b_oa when v(f1b_oa)=0.9 rise=1
meas tran f1b_oa_pre avg v(f1b_oa) from=9.7e-07 to=9.9e-07
meas tran f1b_ob when v(f1b_ob)=0.9 rise=1
meas tran f1b_ob_pre avg v(f1b_ob) from=9.7e-07 to=9.9e-07
meas tran f2_oa when v(f2_oa)=0.9 rise=1
meas tran f2_oa_pre avg v(f2_oa) from=9.7e-07 to=9.9e-07
meas tran f2_ob when v(f2_ob)=0.9 rise=1
meas tran f2_ob_pre avg v(f2_ob) from=9.7e-07 to=9.9e-07
meas tran f3_oa when v(f3_oa)=0.9 rise=1
meas tran f3_oa_pre avg v(f3_oa) from=9.7e-07 to=9.9e-07
meas tran f3_ob when v(f3_ob)=0.9 rise=1
meas tran f3_ob_pre avg v(f3_ob) from=9.7e-07 to=9.9e-07
meas tran f4_oa when v(f4_oa)=0.9 rise=1
meas tran f4_oa_pre avg v(f4_oa) from=9.7e-07 to=9.9e-07
meas tran f4_ob when v(f4_ob)=0.9 rise=1
meas tran f4_ob_pre avg v(f4_ob) from=9.7e-07 to=9.9e-07
meas tran f7_oa when v(f7_oa)=0.9 rise=1
meas tran f7_oa_pre avg v(f7_oa) from=9.7e-07 to=9.9e-07
meas tran f7_ob when v(f7_ob)=0.9 rise=1
meas tran f7_ob_pre avg v(f7_ob) from=9.7e-07 to=9.9e-07
meas tran vb find v(h01_VB) at=0.5u
echo RES tt 27 h01_oa=$&h01_oa h01_oa_pre=$&h01_oa_pre
echo RES tt 27 h01_ob=$&h01_ob h01_ob_pre=$&h01_ob_pre
echo RES tt 27 h11_oa=$&h11_oa h11_oa_pre=$&h11_oa_pre
echo RES tt 27 h11_ob=$&h11_ob h11_ob_pre=$&h11_ob_pre
echo RES tt 27 h10_oa=$&h10_oa h10_oa_pre=$&h10_oa_pre
echo RES tt 27 h10_ob=$&h10_ob h10_ob_pre=$&h10_ob_pre
echo RES tt 27 t01_oa=$&t01_oa t01_oa_pre=$&t01_oa_pre
echo RES tt 27 t01_ob=$&t01_ob t01_ob_pre=$&t01_ob_pre
echo RES tt 27 l01_oa=$&l01_oa l01_oa_pre=$&l01_oa_pre
echo RES tt 27 l01_ob=$&l01_ob l01_ob_pre=$&l01_ob_pre
echo RES tt 27 u01_oa=$&u01_oa u01_oa_pre=$&u01_oa_pre
echo RES tt 27 u01_ob=$&u01_ob u01_ob_pre=$&u01_ob_pre
echo RES tt 27 f1a_oa=$&f1a_oa f1a_oa_pre=$&f1a_oa_pre
echo RES tt 27 f1a_ob=$&f1a_ob f1a_ob_pre=$&f1a_ob_pre
echo RES tt 27 f1b_oa=$&f1b_oa f1b_oa_pre=$&f1b_oa_pre
echo RES tt 27 f1b_ob=$&f1b_ob f1b_ob_pre=$&f1b_ob_pre
echo RES tt 27 f2_oa=$&f2_oa f2_oa_pre=$&f2_oa_pre
echo RES tt 27 f2_ob=$&f2_ob f2_ob_pre=$&f2_ob_pre
echo RES tt 27 f3_oa=$&f3_oa f3_oa_pre=$&f3_oa_pre
echo RES tt 27 f3_ob=$&f3_ob f3_ob_pre=$&f3_ob_pre
echo RES tt 27 f4_oa=$&f4_oa f4_oa_pre=$&f4_oa_pre
echo RES tt 27 f4_ob=$&f4_ob f4_ob_pre=$&f4_ob_pre
echo RES tt 27 f7_oa=$&f7_oa f7_oa_pre=$&f7_oa_pre
echo RES tt 27 f7_ob=$&f7_ob f7_ob_pre=$&f7_ob_pre
echo RES tt 27 vb=$&vb
quit
.endc
.end
