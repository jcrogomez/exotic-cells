* MISFIT-03 etapa a · noche 1125 bloque D, todo abierto · esquina ss 85 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ss
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 85
.subckt core XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB
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
Vd vdd 0 1.8
Vh hi 0 1.8
Vpre pre 0 pwl(0 1.8 1e-06 1.8 1.001e-06 0)
* --- h00: core
Xh00_ienn hi 0 0 vdd vdd h00_enn sky130_fd_sc_hd__inv_1
Xh00_is1n 0 0 0 vdd vdd h00_s1n sky130_fd_sc_hd__inv_1
Xh00_is0n 0 0 0 vdd vdd h00_s0n sky130_fd_sc_hd__inv_1
Xh00_PREA pre h00_enn 0 0 vdd vdd h00_PREA sky130_fd_sc_hd__nor2_1
Xh00_PREB pre h00_enn 0 0 vdd vdd h00_PREB sky130_fd_sc_hd__nor2_1
Xh00_VBIAS hi 0 0 vdd vdd h00_VBIAS sky130_fd_sc_hd__buf_2
Xh00_C1 hi 0 0 vdd vdd h00_C1 sky130_fd_sc_hd__buf_2
Xh00_DUTA hi h00_s1n 0 0 0 vdd vdd h00_DUTA sky130_fd_sc_hd__and3_1
Xh00_DUTB hi h00_s1n 0 0 0 vdd vdd h00_DUTB sky130_fd_sc_hd__and3_1
Xh00_REFA hi 0 0 0 vdd vdd h00_REFA sky130_fd_sc_hd__and2_1
Xh00_REFB hi 0 0 0 vdd vdd h00_REFB sky130_fd_sc_hd__and2_1
Xh00_SA0B hi 0 0 0 0 vdd vdd h00_SA0B sky130_fd_sc_hd__nand3_1
Xh00_SA1B hi 0 0 0 vdd vdd h00_SA1B sky130_fd_sc_hd__nand2_1
Xh00_SA2B hi 0 h00_s0n 0 0 vdd vdd h00_SA2B sky130_fd_sc_hd__nand3_1
Xh00_SB0B hi 0 0 0 vdd vdd h00_SB0B sky130_fd_sc_hd__nand2_1
Xh00_SB1B hi 0 0 0 vdd vdd h00_SB1B sky130_fd_sc_hd__nand2_1
Xh00_M h00_ob h00_SB0B h00_SB1B h00_REFB h00_oa h00_SA0B h00_SA1B h00_SA2B h00_REFA vdd 0 h00_VBIAS h00_C1 h00_PREA h00_XA h00_DUTA h00_PREB h00_XB h00_DUTB h00_VB 0 0 core

* --- a32: core
Xa32_ienn hi 0 0 vdd vdd a32_enn sky130_fd_sc_hd__inv_1
Xa32_is1n 0 0 0 vdd vdd a32_s1n sky130_fd_sc_hd__inv_1
Xa32_is0n 0 0 0 vdd vdd a32_s0n sky130_fd_sc_hd__inv_1
Xa32_PREA pre a32_enn 0 0 vdd vdd a32_PREA sky130_fd_sc_hd__nor2_1
Xa32_PREB pre a32_enn 0 0 vdd vdd a32_PREB sky130_fd_sc_hd__nor2_1
Xa32_VBIAS hi 0 0 vdd vdd a32_VBIAS sky130_fd_sc_hd__buf_2
Xa32_C1 hi 0 0 vdd vdd a32_C1 sky130_fd_sc_hd__buf_2
Xa32_DUTA hi a32_s1n 0 0 0 vdd vdd a32_DUTA sky130_fd_sc_hd__and3_1
Xa32_DUTB hi a32_s1n 0 0 0 vdd vdd a32_DUTB sky130_fd_sc_hd__and3_1
Xa32_REFA hi 0 0 0 vdd vdd a32_REFA sky130_fd_sc_hd__and2_1
Xa32_REFB hi 0 0 0 vdd vdd a32_REFB sky130_fd_sc_hd__and2_1
Xa32_SA0B hi 0 0 0 0 vdd vdd a32_SA0B sky130_fd_sc_hd__nand3_1
Xa32_SA1B hi 0 0 0 vdd vdd a32_SA1B sky130_fd_sc_hd__nand2_1
Xa32_SA2B hi 0 a32_s0n 0 0 vdd vdd a32_SA2B sky130_fd_sc_hd__nand3_1
Xa32_SB0B hi 0 0 0 vdd vdd a32_SB0B sky130_fd_sc_hd__nand2_1
Xa32_SB1B hi 0 0 0 vdd vdd a32_SB1B sky130_fd_sc_hd__nand2_1
Xa32_M a32_ob a32_SB0B a32_SB1B a32_REFB a32_oa a32_SA0B a32_SA1B a32_SA2B a32_REFA vdd 0 a32_VBIAS a32_C1 a32_PREA a32_XA a32_DUTA a32_PREB a32_XB a32_DUTB a32_VB 0 0 core
Xa32edA0 a32_XA a32_VB a32_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA0 0 0 a32_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA0_0 a32_mA0 0 0.00298f
Ca32eA0_1 a32_mA0 a32_XA 0.05981f
Ca32eA0_2 a32_mA0 vdd 0.00496f
Ca32eA0_3 a32_mA0 a32_VB 0.07228f
Ca32eA0_4 a32_mA0 0 0.19922f
Xa32edA1 a32_XA a32_VB a32_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA1 0 0 a32_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA1_0 a32_mA1 0 0.00298f
Ca32eA1_1 a32_mA1 a32_XA 0.05981f
Ca32eA1_2 a32_mA1 vdd 0.00496f
Ca32eA1_3 a32_mA1 a32_VB 0.07228f
Ca32eA1_4 a32_mA1 0 0.19922f
Xa32edA2 a32_XA a32_VB a32_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA2 0 0 a32_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA2_0 a32_mA2 0 0.00298f
Ca32eA2_1 a32_mA2 a32_XA 0.05981f
Ca32eA2_2 a32_mA2 vdd 0.00496f
Ca32eA2_3 a32_mA2 a32_VB 0.07228f
Ca32eA2_4 a32_mA2 0 0.19922f
Xa32edA3 a32_XA a32_VB a32_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA3 0 0 a32_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA3_0 a32_mA3 0 0.00298f
Ca32eA3_1 a32_mA3 a32_XA 0.05981f
Ca32eA3_2 a32_mA3 vdd 0.00496f
Ca32eA3_3 a32_mA3 a32_VB 0.07228f
Ca32eA3_4 a32_mA3 0 0.19922f
Xa32edA4 a32_XA a32_VB a32_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA4 0 0 a32_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA4_0 a32_mA4 0 0.00298f
Ca32eA4_1 a32_mA4 a32_XA 0.05981f
Ca32eA4_2 a32_mA4 vdd 0.00496f
Ca32eA4_3 a32_mA4 a32_VB 0.07228f
Ca32eA4_4 a32_mA4 0 0.19922f
Xa32edA5 a32_XA a32_VB a32_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA5 0 0 a32_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA5_0 a32_mA5 0 0.00298f
Ca32eA5_1 a32_mA5 a32_XA 0.05981f
Ca32eA5_2 a32_mA5 vdd 0.00496f
Ca32eA5_3 a32_mA5 a32_VB 0.07228f
Ca32eA5_4 a32_mA5 0 0.19922f
Xa32edA6 a32_XA a32_VB a32_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA6 0 0 a32_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA6_0 a32_mA6 0 0.00298f
Ca32eA6_1 a32_mA6 a32_XA 0.05981f
Ca32eA6_2 a32_mA6 vdd 0.00496f
Ca32eA6_3 a32_mA6 a32_VB 0.07228f
Ca32eA6_4 a32_mA6 0 0.19922f
Xa32edA7 a32_XA a32_VB a32_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA7 0 0 a32_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA7_0 a32_mA7 0 0.00298f
Ca32eA7_1 a32_mA7 a32_XA 0.05981f
Ca32eA7_2 a32_mA7 vdd 0.00496f
Ca32eA7_3 a32_mA7 a32_VB 0.07228f
Ca32eA7_4 a32_mA7 0 0.19922f
Xa32edA8 a32_XA a32_VB a32_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA8 0 0 a32_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA8_0 a32_mA8 0 0.00298f
Ca32eA8_1 a32_mA8 a32_XA 0.05981f
Ca32eA8_2 a32_mA8 vdd 0.00496f
Ca32eA8_3 a32_mA8 a32_VB 0.07228f
Ca32eA8_4 a32_mA8 0 0.19922f
Xa32edA9 a32_XA a32_VB a32_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA9 0 0 a32_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA9_0 a32_mA9 0 0.00298f
Ca32eA9_1 a32_mA9 a32_XA 0.05981f
Ca32eA9_2 a32_mA9 vdd 0.00496f
Ca32eA9_3 a32_mA9 a32_VB 0.07228f
Ca32eA9_4 a32_mA9 0 0.19922f
Xa32edA10 a32_XA a32_VB a32_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA10 0 0 a32_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA10_0 a32_mA10 0 0.00298f
Ca32eA10_1 a32_mA10 a32_XA 0.05981f
Ca32eA10_2 a32_mA10 vdd 0.00496f
Ca32eA10_3 a32_mA10 a32_VB 0.07228f
Ca32eA10_4 a32_mA10 0 0.19922f
Xa32edA11 a32_XA a32_VB a32_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA11 0 0 a32_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA11_0 a32_mA11 0 0.00298f
Ca32eA11_1 a32_mA11 a32_XA 0.05981f
Ca32eA11_2 a32_mA11 vdd 0.00496f
Ca32eA11_3 a32_mA11 a32_VB 0.07228f
Ca32eA11_4 a32_mA11 0 0.19922f
Xa32edA12 a32_XA a32_VB a32_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA12 0 0 a32_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA12_0 a32_mA12 0 0.00298f
Ca32eA12_1 a32_mA12 a32_XA 0.05981f
Ca32eA12_2 a32_mA12 vdd 0.00496f
Ca32eA12_3 a32_mA12 a32_VB 0.07228f
Ca32eA12_4 a32_mA12 0 0.19922f
Xa32edA13 a32_XA a32_VB a32_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA13 0 0 a32_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA13_0 a32_mA13 0 0.00298f
Ca32eA13_1 a32_mA13 a32_XA 0.05981f
Ca32eA13_2 a32_mA13 vdd 0.00496f
Ca32eA13_3 a32_mA13 a32_VB 0.07228f
Ca32eA13_4 a32_mA13 0 0.19922f
Xa32edA14 a32_XA a32_VB a32_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA14 0 0 a32_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA14_0 a32_mA14 0 0.00298f
Ca32eA14_1 a32_mA14 a32_XA 0.05981f
Ca32eA14_2 a32_mA14 vdd 0.00496f
Ca32eA14_3 a32_mA14 a32_VB 0.07228f
Ca32eA14_4 a32_mA14 0 0.19922f
Xa32edA15 a32_XA a32_VB a32_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA15 0 0 a32_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA15_0 a32_mA15 0 0.00298f
Ca32eA15_1 a32_mA15 a32_XA 0.05981f
Ca32eA15_2 a32_mA15 vdd 0.00496f
Ca32eA15_3 a32_mA15 a32_VB 0.07228f
Ca32eA15_4 a32_mA15 0 0.19922f
Xa32edA16 a32_XA a32_VB a32_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA16 0 0 a32_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA16_0 a32_mA16 0 0.00298f
Ca32eA16_1 a32_mA16 a32_XA 0.05981f
Ca32eA16_2 a32_mA16 vdd 0.00496f
Ca32eA16_3 a32_mA16 a32_VB 0.07228f
Ca32eA16_4 a32_mA16 0 0.19922f
Xa32edA17 a32_XA a32_VB a32_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA17 0 0 a32_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA17_0 a32_mA17 0 0.00298f
Ca32eA17_1 a32_mA17 a32_XA 0.05981f
Ca32eA17_2 a32_mA17 vdd 0.00496f
Ca32eA17_3 a32_mA17 a32_VB 0.07228f
Ca32eA17_4 a32_mA17 0 0.19922f
Xa32edA18 a32_XA a32_VB a32_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA18 0 0 a32_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA18_0 a32_mA18 0 0.00298f
Ca32eA18_1 a32_mA18 a32_XA 0.05981f
Ca32eA18_2 a32_mA18 vdd 0.00496f
Ca32eA18_3 a32_mA18 a32_VB 0.07228f
Ca32eA18_4 a32_mA18 0 0.19922f
Xa32edA19 a32_XA a32_VB a32_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA19 0 0 a32_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA19_0 a32_mA19 0 0.00298f
Ca32eA19_1 a32_mA19 a32_XA 0.05981f
Ca32eA19_2 a32_mA19 vdd 0.00496f
Ca32eA19_3 a32_mA19 a32_VB 0.07228f
Ca32eA19_4 a32_mA19 0 0.19922f
Xa32edA20 a32_XA a32_VB a32_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA20 0 0 a32_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA20_0 a32_mA20 0 0.00298f
Ca32eA20_1 a32_mA20 a32_XA 0.05981f
Ca32eA20_2 a32_mA20 vdd 0.00496f
Ca32eA20_3 a32_mA20 a32_VB 0.07228f
Ca32eA20_4 a32_mA20 0 0.19922f
Xa32edA21 a32_XA a32_VB a32_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA21 0 0 a32_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA21_0 a32_mA21 0 0.00298f
Ca32eA21_1 a32_mA21 a32_XA 0.05981f
Ca32eA21_2 a32_mA21 vdd 0.00496f
Ca32eA21_3 a32_mA21 a32_VB 0.07228f
Ca32eA21_4 a32_mA21 0 0.19922f
Xa32edA22 a32_XA a32_VB a32_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA22 0 0 a32_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA22_0 a32_mA22 0 0.00298f
Ca32eA22_1 a32_mA22 a32_XA 0.05981f
Ca32eA22_2 a32_mA22 vdd 0.00496f
Ca32eA22_3 a32_mA22 a32_VB 0.07228f
Ca32eA22_4 a32_mA22 0 0.19922f
Xa32edA23 a32_XA a32_VB a32_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA23 0 0 a32_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA23_0 a32_mA23 0 0.00298f
Ca32eA23_1 a32_mA23 a32_XA 0.05981f
Ca32eA23_2 a32_mA23 vdd 0.00496f
Ca32eA23_3 a32_mA23 a32_VB 0.07228f
Ca32eA23_4 a32_mA23 0 0.19922f
Xa32edA24 a32_XA a32_VB a32_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA24 0 0 a32_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA24_0 a32_mA24 0 0.00298f
Ca32eA24_1 a32_mA24 a32_XA 0.05981f
Ca32eA24_2 a32_mA24 vdd 0.00496f
Ca32eA24_3 a32_mA24 a32_VB 0.07228f
Ca32eA24_4 a32_mA24 0 0.19922f
Xa32edA25 a32_XA a32_VB a32_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA25 0 0 a32_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA25_0 a32_mA25 0 0.00298f
Ca32eA25_1 a32_mA25 a32_XA 0.05981f
Ca32eA25_2 a32_mA25 vdd 0.00496f
Ca32eA25_3 a32_mA25 a32_VB 0.07228f
Ca32eA25_4 a32_mA25 0 0.19922f
Xa32edA26 a32_XA a32_VB a32_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA26 0 0 a32_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA26_0 a32_mA26 0 0.00298f
Ca32eA26_1 a32_mA26 a32_XA 0.05981f
Ca32eA26_2 a32_mA26 vdd 0.00496f
Ca32eA26_3 a32_mA26 a32_VB 0.07228f
Ca32eA26_4 a32_mA26 0 0.19922f
Xa32edA27 a32_XA a32_VB a32_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA27 0 0 a32_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA27_0 a32_mA27 0 0.00298f
Ca32eA27_1 a32_mA27 a32_XA 0.05981f
Ca32eA27_2 a32_mA27 vdd 0.00496f
Ca32eA27_3 a32_mA27 a32_VB 0.07228f
Ca32eA27_4 a32_mA27 0 0.19922f
Xa32edA28 a32_XA a32_VB a32_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA28 0 0 a32_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA28_0 a32_mA28 0 0.00298f
Ca32eA28_1 a32_mA28 a32_XA 0.05981f
Ca32eA28_2 a32_mA28 vdd 0.00496f
Ca32eA28_3 a32_mA28 a32_VB 0.07228f
Ca32eA28_4 a32_mA28 0 0.19922f
Xa32edA29 a32_XA a32_VB a32_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA29 0 0 a32_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA29_0 a32_mA29 0 0.00298f
Ca32eA29_1 a32_mA29 a32_XA 0.05981f
Ca32eA29_2 a32_mA29 vdd 0.00496f
Ca32eA29_3 a32_mA29 a32_VB 0.07228f
Ca32eA29_4 a32_mA29 0 0.19922f
Xa32edA30 a32_XA a32_VB a32_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esA30 0 0 a32_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eA30_0 a32_mA30 0 0.00298f
Ca32eA30_1 a32_mA30 a32_XA 0.05981f
Ca32eA30_2 a32_mA30 vdd 0.00496f
Ca32eA30_3 a32_mA30 a32_VB 0.07228f
Ca32eA30_4 a32_mA30 0 0.19922f
Xa32edB0 a32_XB a32_VB a32_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB0 0 0 a32_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB0_0 a32_mB0 a32_XB 0.05778f
Ca32eB0_1 a32_mB0 vdd 0.00496f
Ca32eB0_2 a32_mB0 a32_VB 0.0654f
Ca32eB0_3 a32_mB0 0 0.00298f
Ca32eB0_4 a32_mB0 0 0.20468f
Xa32edB1 a32_XB a32_VB a32_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB1 0 0 a32_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB1_0 a32_mB1 a32_XB 0.05778f
Ca32eB1_1 a32_mB1 vdd 0.00496f
Ca32eB1_2 a32_mB1 a32_VB 0.0654f
Ca32eB1_3 a32_mB1 0 0.00298f
Ca32eB1_4 a32_mB1 0 0.20468f
Xa32edB2 a32_XB a32_VB a32_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB2 0 0 a32_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB2_0 a32_mB2 a32_XB 0.05778f
Ca32eB2_1 a32_mB2 vdd 0.00496f
Ca32eB2_2 a32_mB2 a32_VB 0.0654f
Ca32eB2_3 a32_mB2 0 0.00298f
Ca32eB2_4 a32_mB2 0 0.20468f
Xa32edB3 a32_XB a32_VB a32_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB3 0 0 a32_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB3_0 a32_mB3 a32_XB 0.05778f
Ca32eB3_1 a32_mB3 vdd 0.00496f
Ca32eB3_2 a32_mB3 a32_VB 0.0654f
Ca32eB3_3 a32_mB3 0 0.00298f
Ca32eB3_4 a32_mB3 0 0.20468f
Xa32edB4 a32_XB a32_VB a32_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB4 0 0 a32_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB4_0 a32_mB4 a32_XB 0.05778f
Ca32eB4_1 a32_mB4 vdd 0.00496f
Ca32eB4_2 a32_mB4 a32_VB 0.0654f
Ca32eB4_3 a32_mB4 0 0.00298f
Ca32eB4_4 a32_mB4 0 0.20468f
Xa32edB5 a32_XB a32_VB a32_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB5 0 0 a32_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB5_0 a32_mB5 a32_XB 0.05778f
Ca32eB5_1 a32_mB5 vdd 0.00496f
Ca32eB5_2 a32_mB5 a32_VB 0.0654f
Ca32eB5_3 a32_mB5 0 0.00298f
Ca32eB5_4 a32_mB5 0 0.20468f
Xa32edB6 a32_XB a32_VB a32_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB6 0 0 a32_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB6_0 a32_mB6 a32_XB 0.05778f
Ca32eB6_1 a32_mB6 vdd 0.00496f
Ca32eB6_2 a32_mB6 a32_VB 0.0654f
Ca32eB6_3 a32_mB6 0 0.00298f
Ca32eB6_4 a32_mB6 0 0.20468f
Xa32edB7 a32_XB a32_VB a32_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB7 0 0 a32_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB7_0 a32_mB7 a32_XB 0.05778f
Ca32eB7_1 a32_mB7 vdd 0.00496f
Ca32eB7_2 a32_mB7 a32_VB 0.0654f
Ca32eB7_3 a32_mB7 0 0.00298f
Ca32eB7_4 a32_mB7 0 0.20468f
Xa32edB8 a32_XB a32_VB a32_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB8 0 0 a32_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB8_0 a32_mB8 a32_XB 0.05778f
Ca32eB8_1 a32_mB8 vdd 0.00496f
Ca32eB8_2 a32_mB8 a32_VB 0.0654f
Ca32eB8_3 a32_mB8 0 0.00298f
Ca32eB8_4 a32_mB8 0 0.20468f
Xa32edB9 a32_XB a32_VB a32_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB9 0 0 a32_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB9_0 a32_mB9 a32_XB 0.05778f
Ca32eB9_1 a32_mB9 vdd 0.00496f
Ca32eB9_2 a32_mB9 a32_VB 0.0654f
Ca32eB9_3 a32_mB9 0 0.00298f
Ca32eB9_4 a32_mB9 0 0.20468f
Xa32edB10 a32_XB a32_VB a32_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB10 0 0 a32_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB10_0 a32_mB10 a32_XB 0.05778f
Ca32eB10_1 a32_mB10 vdd 0.00496f
Ca32eB10_2 a32_mB10 a32_VB 0.0654f
Ca32eB10_3 a32_mB10 0 0.00298f
Ca32eB10_4 a32_mB10 0 0.20468f
Xa32edB11 a32_XB a32_VB a32_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB11 0 0 a32_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB11_0 a32_mB11 a32_XB 0.05778f
Ca32eB11_1 a32_mB11 vdd 0.00496f
Ca32eB11_2 a32_mB11 a32_VB 0.0654f
Ca32eB11_3 a32_mB11 0 0.00298f
Ca32eB11_4 a32_mB11 0 0.20468f
Xa32edB12 a32_XB a32_VB a32_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB12 0 0 a32_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB12_0 a32_mB12 a32_XB 0.05778f
Ca32eB12_1 a32_mB12 vdd 0.00496f
Ca32eB12_2 a32_mB12 a32_VB 0.0654f
Ca32eB12_3 a32_mB12 0 0.00298f
Ca32eB12_4 a32_mB12 0 0.20468f
Xa32edB13 a32_XB a32_VB a32_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB13 0 0 a32_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB13_0 a32_mB13 a32_XB 0.05778f
Ca32eB13_1 a32_mB13 vdd 0.00496f
Ca32eB13_2 a32_mB13 a32_VB 0.0654f
Ca32eB13_3 a32_mB13 0 0.00298f
Ca32eB13_4 a32_mB13 0 0.20468f
Xa32edB14 a32_XB a32_VB a32_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB14 0 0 a32_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB14_0 a32_mB14 a32_XB 0.05778f
Ca32eB14_1 a32_mB14 vdd 0.00496f
Ca32eB14_2 a32_mB14 a32_VB 0.0654f
Ca32eB14_3 a32_mB14 0 0.00298f
Ca32eB14_4 a32_mB14 0 0.20468f
Xa32edB15 a32_XB a32_VB a32_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB15 0 0 a32_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB15_0 a32_mB15 a32_XB 0.05778f
Ca32eB15_1 a32_mB15 vdd 0.00496f
Ca32eB15_2 a32_mB15 a32_VB 0.0654f
Ca32eB15_3 a32_mB15 0 0.00298f
Ca32eB15_4 a32_mB15 0 0.20468f
Xa32edB16 a32_XB a32_VB a32_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB16 0 0 a32_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB16_0 a32_mB16 a32_XB 0.05778f
Ca32eB16_1 a32_mB16 vdd 0.00496f
Ca32eB16_2 a32_mB16 a32_VB 0.0654f
Ca32eB16_3 a32_mB16 0 0.00298f
Ca32eB16_4 a32_mB16 0 0.20468f
Xa32edB17 a32_XB a32_VB a32_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB17 0 0 a32_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB17_0 a32_mB17 a32_XB 0.05778f
Ca32eB17_1 a32_mB17 vdd 0.00496f
Ca32eB17_2 a32_mB17 a32_VB 0.0654f
Ca32eB17_3 a32_mB17 0 0.00298f
Ca32eB17_4 a32_mB17 0 0.20468f
Xa32edB18 a32_XB a32_VB a32_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB18 0 0 a32_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB18_0 a32_mB18 a32_XB 0.05778f
Ca32eB18_1 a32_mB18 vdd 0.00496f
Ca32eB18_2 a32_mB18 a32_VB 0.0654f
Ca32eB18_3 a32_mB18 0 0.00298f
Ca32eB18_4 a32_mB18 0 0.20468f
Xa32edB19 a32_XB a32_VB a32_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB19 0 0 a32_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB19_0 a32_mB19 a32_XB 0.05778f
Ca32eB19_1 a32_mB19 vdd 0.00496f
Ca32eB19_2 a32_mB19 a32_VB 0.0654f
Ca32eB19_3 a32_mB19 0 0.00298f
Ca32eB19_4 a32_mB19 0 0.20468f
Xa32edB20 a32_XB a32_VB a32_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB20 0 0 a32_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB20_0 a32_mB20 a32_XB 0.05778f
Ca32eB20_1 a32_mB20 vdd 0.00496f
Ca32eB20_2 a32_mB20 a32_VB 0.0654f
Ca32eB20_3 a32_mB20 0 0.00298f
Ca32eB20_4 a32_mB20 0 0.20468f
Xa32edB21 a32_XB a32_VB a32_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB21 0 0 a32_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB21_0 a32_mB21 a32_XB 0.05778f
Ca32eB21_1 a32_mB21 vdd 0.00496f
Ca32eB21_2 a32_mB21 a32_VB 0.0654f
Ca32eB21_3 a32_mB21 0 0.00298f
Ca32eB21_4 a32_mB21 0 0.20468f
Xa32edB22 a32_XB a32_VB a32_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB22 0 0 a32_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB22_0 a32_mB22 a32_XB 0.05778f
Ca32eB22_1 a32_mB22 vdd 0.00496f
Ca32eB22_2 a32_mB22 a32_VB 0.0654f
Ca32eB22_3 a32_mB22 0 0.00298f
Ca32eB22_4 a32_mB22 0 0.20468f
Xa32edB23 a32_XB a32_VB a32_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB23 0 0 a32_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB23_0 a32_mB23 a32_XB 0.05778f
Ca32eB23_1 a32_mB23 vdd 0.00496f
Ca32eB23_2 a32_mB23 a32_VB 0.0654f
Ca32eB23_3 a32_mB23 0 0.00298f
Ca32eB23_4 a32_mB23 0 0.20468f
Xa32edB24 a32_XB a32_VB a32_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB24 0 0 a32_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB24_0 a32_mB24 a32_XB 0.05778f
Ca32eB24_1 a32_mB24 vdd 0.00496f
Ca32eB24_2 a32_mB24 a32_VB 0.0654f
Ca32eB24_3 a32_mB24 0 0.00298f
Ca32eB24_4 a32_mB24 0 0.20468f
Xa32edB25 a32_XB a32_VB a32_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB25 0 0 a32_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB25_0 a32_mB25 a32_XB 0.05778f
Ca32eB25_1 a32_mB25 vdd 0.00496f
Ca32eB25_2 a32_mB25 a32_VB 0.0654f
Ca32eB25_3 a32_mB25 0 0.00298f
Ca32eB25_4 a32_mB25 0 0.20468f
Xa32edB26 a32_XB a32_VB a32_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB26 0 0 a32_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB26_0 a32_mB26 a32_XB 0.05778f
Ca32eB26_1 a32_mB26 vdd 0.00496f
Ca32eB26_2 a32_mB26 a32_VB 0.0654f
Ca32eB26_3 a32_mB26 0 0.00298f
Ca32eB26_4 a32_mB26 0 0.20468f
Xa32edB27 a32_XB a32_VB a32_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB27 0 0 a32_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB27_0 a32_mB27 a32_XB 0.05778f
Ca32eB27_1 a32_mB27 vdd 0.00496f
Ca32eB27_2 a32_mB27 a32_VB 0.0654f
Ca32eB27_3 a32_mB27 0 0.00298f
Ca32eB27_4 a32_mB27 0 0.20468f
Xa32edB28 a32_XB a32_VB a32_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB28 0 0 a32_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB28_0 a32_mB28 a32_XB 0.05778f
Ca32eB28_1 a32_mB28 vdd 0.00496f
Ca32eB28_2 a32_mB28 a32_VB 0.0654f
Ca32eB28_3 a32_mB28 0 0.00298f
Ca32eB28_4 a32_mB28 0 0.20468f
Xa32edB29 a32_XB a32_VB a32_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB29 0 0 a32_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB29_0 a32_mB29 a32_XB 0.05778f
Ca32eB29_1 a32_mB29 vdd 0.00496f
Ca32eB29_2 a32_mB29 a32_VB 0.0654f
Ca32eB29_3 a32_mB29 0 0.00298f
Ca32eB29_4 a32_mB29 0 0.20468f
Xa32edB30 a32_XB a32_VB a32_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa32esB30 0 0 a32_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca32eB30_0 a32_mB30 a32_XB 0.05778f
Ca32eB30_1 a32_mB30 vdd 0.00496f
Ca32eB30_2 a32_mB30 a32_VB 0.0654f
Ca32eB30_3 a32_mB30 0 0.00298f
Ca32eB30_4 a32_mB30 0 0.20468f

* --- a128: core
Xa128_ienn hi 0 0 vdd vdd a128_enn sky130_fd_sc_hd__inv_1
Xa128_is1n 0 0 0 vdd vdd a128_s1n sky130_fd_sc_hd__inv_1
Xa128_is0n 0 0 0 vdd vdd a128_s0n sky130_fd_sc_hd__inv_1
Xa128_PREA pre a128_enn 0 0 vdd vdd a128_PREA sky130_fd_sc_hd__nor2_1
Xa128_PREB pre a128_enn 0 0 vdd vdd a128_PREB sky130_fd_sc_hd__nor2_1
Xa128_VBIAS hi 0 0 vdd vdd a128_VBIAS sky130_fd_sc_hd__buf_2
Xa128_C1 hi 0 0 vdd vdd a128_C1 sky130_fd_sc_hd__buf_2
Xa128_DUTA hi a128_s1n 0 0 0 vdd vdd a128_DUTA sky130_fd_sc_hd__and3_1
Xa128_DUTB hi a128_s1n 0 0 0 vdd vdd a128_DUTB sky130_fd_sc_hd__and3_1
Xa128_REFA hi 0 0 0 vdd vdd a128_REFA sky130_fd_sc_hd__and2_1
Xa128_REFB hi 0 0 0 vdd vdd a128_REFB sky130_fd_sc_hd__and2_1
Xa128_SA0B hi 0 0 0 0 vdd vdd a128_SA0B sky130_fd_sc_hd__nand3_1
Xa128_SA1B hi 0 0 0 vdd vdd a128_SA1B sky130_fd_sc_hd__nand2_1
Xa128_SA2B hi 0 a128_s0n 0 0 vdd vdd a128_SA2B sky130_fd_sc_hd__nand3_1
Xa128_SB0B hi 0 0 0 vdd vdd a128_SB0B sky130_fd_sc_hd__nand2_1
Xa128_SB1B hi 0 0 0 vdd vdd a128_SB1B sky130_fd_sc_hd__nand2_1
Xa128_M a128_ob a128_SB0B a128_SB1B a128_REFB a128_oa a128_SA0B a128_SA1B a128_SA2B a128_REFA vdd 0 a128_VBIAS a128_C1 a128_PREA a128_XA a128_DUTA a128_PREB a128_XB a128_DUTB a128_VB 0 0 core
Xa128edA0 a128_XA a128_VB a128_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA0 0 0 a128_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA0_0 a128_mA0 0 0.00298f
Ca128eA0_1 a128_mA0 a128_XA 0.05981f
Ca128eA0_2 a128_mA0 vdd 0.00496f
Ca128eA0_3 a128_mA0 a128_VB 0.07228f
Ca128eA0_4 a128_mA0 0 0.19922f
Xa128edA1 a128_XA a128_VB a128_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA1 0 0 a128_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA1_0 a128_mA1 0 0.00298f
Ca128eA1_1 a128_mA1 a128_XA 0.05981f
Ca128eA1_2 a128_mA1 vdd 0.00496f
Ca128eA1_3 a128_mA1 a128_VB 0.07228f
Ca128eA1_4 a128_mA1 0 0.19922f
Xa128edA2 a128_XA a128_VB a128_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA2 0 0 a128_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA2_0 a128_mA2 0 0.00298f
Ca128eA2_1 a128_mA2 a128_XA 0.05981f
Ca128eA2_2 a128_mA2 vdd 0.00496f
Ca128eA2_3 a128_mA2 a128_VB 0.07228f
Ca128eA2_4 a128_mA2 0 0.19922f
Xa128edA3 a128_XA a128_VB a128_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA3 0 0 a128_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA3_0 a128_mA3 0 0.00298f
Ca128eA3_1 a128_mA3 a128_XA 0.05981f
Ca128eA3_2 a128_mA3 vdd 0.00496f
Ca128eA3_3 a128_mA3 a128_VB 0.07228f
Ca128eA3_4 a128_mA3 0 0.19922f
Xa128edA4 a128_XA a128_VB a128_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA4 0 0 a128_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA4_0 a128_mA4 0 0.00298f
Ca128eA4_1 a128_mA4 a128_XA 0.05981f
Ca128eA4_2 a128_mA4 vdd 0.00496f
Ca128eA4_3 a128_mA4 a128_VB 0.07228f
Ca128eA4_4 a128_mA4 0 0.19922f
Xa128edA5 a128_XA a128_VB a128_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA5 0 0 a128_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA5_0 a128_mA5 0 0.00298f
Ca128eA5_1 a128_mA5 a128_XA 0.05981f
Ca128eA5_2 a128_mA5 vdd 0.00496f
Ca128eA5_3 a128_mA5 a128_VB 0.07228f
Ca128eA5_4 a128_mA5 0 0.19922f
Xa128edA6 a128_XA a128_VB a128_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA6 0 0 a128_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA6_0 a128_mA6 0 0.00298f
Ca128eA6_1 a128_mA6 a128_XA 0.05981f
Ca128eA6_2 a128_mA6 vdd 0.00496f
Ca128eA6_3 a128_mA6 a128_VB 0.07228f
Ca128eA6_4 a128_mA6 0 0.19922f
Xa128edA7 a128_XA a128_VB a128_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA7 0 0 a128_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA7_0 a128_mA7 0 0.00298f
Ca128eA7_1 a128_mA7 a128_XA 0.05981f
Ca128eA7_2 a128_mA7 vdd 0.00496f
Ca128eA7_3 a128_mA7 a128_VB 0.07228f
Ca128eA7_4 a128_mA7 0 0.19922f
Xa128edA8 a128_XA a128_VB a128_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA8 0 0 a128_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA8_0 a128_mA8 0 0.00298f
Ca128eA8_1 a128_mA8 a128_XA 0.05981f
Ca128eA8_2 a128_mA8 vdd 0.00496f
Ca128eA8_3 a128_mA8 a128_VB 0.07228f
Ca128eA8_4 a128_mA8 0 0.19922f
Xa128edA9 a128_XA a128_VB a128_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA9 0 0 a128_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA9_0 a128_mA9 0 0.00298f
Ca128eA9_1 a128_mA9 a128_XA 0.05981f
Ca128eA9_2 a128_mA9 vdd 0.00496f
Ca128eA9_3 a128_mA9 a128_VB 0.07228f
Ca128eA9_4 a128_mA9 0 0.19922f
Xa128edA10 a128_XA a128_VB a128_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA10 0 0 a128_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA10_0 a128_mA10 0 0.00298f
Ca128eA10_1 a128_mA10 a128_XA 0.05981f
Ca128eA10_2 a128_mA10 vdd 0.00496f
Ca128eA10_3 a128_mA10 a128_VB 0.07228f
Ca128eA10_4 a128_mA10 0 0.19922f
Xa128edA11 a128_XA a128_VB a128_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA11 0 0 a128_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA11_0 a128_mA11 0 0.00298f
Ca128eA11_1 a128_mA11 a128_XA 0.05981f
Ca128eA11_2 a128_mA11 vdd 0.00496f
Ca128eA11_3 a128_mA11 a128_VB 0.07228f
Ca128eA11_4 a128_mA11 0 0.19922f
Xa128edA12 a128_XA a128_VB a128_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA12 0 0 a128_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA12_0 a128_mA12 0 0.00298f
Ca128eA12_1 a128_mA12 a128_XA 0.05981f
Ca128eA12_2 a128_mA12 vdd 0.00496f
Ca128eA12_3 a128_mA12 a128_VB 0.07228f
Ca128eA12_4 a128_mA12 0 0.19922f
Xa128edA13 a128_XA a128_VB a128_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA13 0 0 a128_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA13_0 a128_mA13 0 0.00298f
Ca128eA13_1 a128_mA13 a128_XA 0.05981f
Ca128eA13_2 a128_mA13 vdd 0.00496f
Ca128eA13_3 a128_mA13 a128_VB 0.07228f
Ca128eA13_4 a128_mA13 0 0.19922f
Xa128edA14 a128_XA a128_VB a128_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA14 0 0 a128_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA14_0 a128_mA14 0 0.00298f
Ca128eA14_1 a128_mA14 a128_XA 0.05981f
Ca128eA14_2 a128_mA14 vdd 0.00496f
Ca128eA14_3 a128_mA14 a128_VB 0.07228f
Ca128eA14_4 a128_mA14 0 0.19922f
Xa128edA15 a128_XA a128_VB a128_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA15 0 0 a128_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA15_0 a128_mA15 0 0.00298f
Ca128eA15_1 a128_mA15 a128_XA 0.05981f
Ca128eA15_2 a128_mA15 vdd 0.00496f
Ca128eA15_3 a128_mA15 a128_VB 0.07228f
Ca128eA15_4 a128_mA15 0 0.19922f
Xa128edA16 a128_XA a128_VB a128_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA16 0 0 a128_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA16_0 a128_mA16 0 0.00298f
Ca128eA16_1 a128_mA16 a128_XA 0.05981f
Ca128eA16_2 a128_mA16 vdd 0.00496f
Ca128eA16_3 a128_mA16 a128_VB 0.07228f
Ca128eA16_4 a128_mA16 0 0.19922f
Xa128edA17 a128_XA a128_VB a128_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA17 0 0 a128_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA17_0 a128_mA17 0 0.00298f
Ca128eA17_1 a128_mA17 a128_XA 0.05981f
Ca128eA17_2 a128_mA17 vdd 0.00496f
Ca128eA17_3 a128_mA17 a128_VB 0.07228f
Ca128eA17_4 a128_mA17 0 0.19922f
Xa128edA18 a128_XA a128_VB a128_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA18 0 0 a128_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA18_0 a128_mA18 0 0.00298f
Ca128eA18_1 a128_mA18 a128_XA 0.05981f
Ca128eA18_2 a128_mA18 vdd 0.00496f
Ca128eA18_3 a128_mA18 a128_VB 0.07228f
Ca128eA18_4 a128_mA18 0 0.19922f
Xa128edA19 a128_XA a128_VB a128_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA19 0 0 a128_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA19_0 a128_mA19 0 0.00298f
Ca128eA19_1 a128_mA19 a128_XA 0.05981f
Ca128eA19_2 a128_mA19 vdd 0.00496f
Ca128eA19_3 a128_mA19 a128_VB 0.07228f
Ca128eA19_4 a128_mA19 0 0.19922f
Xa128edA20 a128_XA a128_VB a128_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA20 0 0 a128_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA20_0 a128_mA20 0 0.00298f
Ca128eA20_1 a128_mA20 a128_XA 0.05981f
Ca128eA20_2 a128_mA20 vdd 0.00496f
Ca128eA20_3 a128_mA20 a128_VB 0.07228f
Ca128eA20_4 a128_mA20 0 0.19922f
Xa128edA21 a128_XA a128_VB a128_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA21 0 0 a128_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA21_0 a128_mA21 0 0.00298f
Ca128eA21_1 a128_mA21 a128_XA 0.05981f
Ca128eA21_2 a128_mA21 vdd 0.00496f
Ca128eA21_3 a128_mA21 a128_VB 0.07228f
Ca128eA21_4 a128_mA21 0 0.19922f
Xa128edA22 a128_XA a128_VB a128_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA22 0 0 a128_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA22_0 a128_mA22 0 0.00298f
Ca128eA22_1 a128_mA22 a128_XA 0.05981f
Ca128eA22_2 a128_mA22 vdd 0.00496f
Ca128eA22_3 a128_mA22 a128_VB 0.07228f
Ca128eA22_4 a128_mA22 0 0.19922f
Xa128edA23 a128_XA a128_VB a128_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA23 0 0 a128_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA23_0 a128_mA23 0 0.00298f
Ca128eA23_1 a128_mA23 a128_XA 0.05981f
Ca128eA23_2 a128_mA23 vdd 0.00496f
Ca128eA23_3 a128_mA23 a128_VB 0.07228f
Ca128eA23_4 a128_mA23 0 0.19922f
Xa128edA24 a128_XA a128_VB a128_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA24 0 0 a128_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA24_0 a128_mA24 0 0.00298f
Ca128eA24_1 a128_mA24 a128_XA 0.05981f
Ca128eA24_2 a128_mA24 vdd 0.00496f
Ca128eA24_3 a128_mA24 a128_VB 0.07228f
Ca128eA24_4 a128_mA24 0 0.19922f
Xa128edA25 a128_XA a128_VB a128_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA25 0 0 a128_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA25_0 a128_mA25 0 0.00298f
Ca128eA25_1 a128_mA25 a128_XA 0.05981f
Ca128eA25_2 a128_mA25 vdd 0.00496f
Ca128eA25_3 a128_mA25 a128_VB 0.07228f
Ca128eA25_4 a128_mA25 0 0.19922f
Xa128edA26 a128_XA a128_VB a128_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA26 0 0 a128_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA26_0 a128_mA26 0 0.00298f
Ca128eA26_1 a128_mA26 a128_XA 0.05981f
Ca128eA26_2 a128_mA26 vdd 0.00496f
Ca128eA26_3 a128_mA26 a128_VB 0.07228f
Ca128eA26_4 a128_mA26 0 0.19922f
Xa128edA27 a128_XA a128_VB a128_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA27 0 0 a128_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA27_0 a128_mA27 0 0.00298f
Ca128eA27_1 a128_mA27 a128_XA 0.05981f
Ca128eA27_2 a128_mA27 vdd 0.00496f
Ca128eA27_3 a128_mA27 a128_VB 0.07228f
Ca128eA27_4 a128_mA27 0 0.19922f
Xa128edA28 a128_XA a128_VB a128_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA28 0 0 a128_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA28_0 a128_mA28 0 0.00298f
Ca128eA28_1 a128_mA28 a128_XA 0.05981f
Ca128eA28_2 a128_mA28 vdd 0.00496f
Ca128eA28_3 a128_mA28 a128_VB 0.07228f
Ca128eA28_4 a128_mA28 0 0.19922f
Xa128edA29 a128_XA a128_VB a128_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA29 0 0 a128_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA29_0 a128_mA29 0 0.00298f
Ca128eA29_1 a128_mA29 a128_XA 0.05981f
Ca128eA29_2 a128_mA29 vdd 0.00496f
Ca128eA29_3 a128_mA29 a128_VB 0.07228f
Ca128eA29_4 a128_mA29 0 0.19922f
Xa128edA30 a128_XA a128_VB a128_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA30 0 0 a128_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA30_0 a128_mA30 0 0.00298f
Ca128eA30_1 a128_mA30 a128_XA 0.05981f
Ca128eA30_2 a128_mA30 vdd 0.00496f
Ca128eA30_3 a128_mA30 a128_VB 0.07228f
Ca128eA30_4 a128_mA30 0 0.19922f
Xa128edA31 a128_XA a128_VB a128_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA31 0 0 a128_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA31_0 a128_mA31 0 0.00298f
Ca128eA31_1 a128_mA31 a128_XA 0.05981f
Ca128eA31_2 a128_mA31 vdd 0.00496f
Ca128eA31_3 a128_mA31 a128_VB 0.07228f
Ca128eA31_4 a128_mA31 0 0.19922f
Xa128edA32 a128_XA a128_VB a128_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA32 0 0 a128_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA32_0 a128_mA32 0 0.00298f
Ca128eA32_1 a128_mA32 a128_XA 0.05981f
Ca128eA32_2 a128_mA32 vdd 0.00496f
Ca128eA32_3 a128_mA32 a128_VB 0.07228f
Ca128eA32_4 a128_mA32 0 0.19922f
Xa128edA33 a128_XA a128_VB a128_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA33 0 0 a128_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA33_0 a128_mA33 0 0.00298f
Ca128eA33_1 a128_mA33 a128_XA 0.05981f
Ca128eA33_2 a128_mA33 vdd 0.00496f
Ca128eA33_3 a128_mA33 a128_VB 0.07228f
Ca128eA33_4 a128_mA33 0 0.19922f
Xa128edA34 a128_XA a128_VB a128_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA34 0 0 a128_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA34_0 a128_mA34 0 0.00298f
Ca128eA34_1 a128_mA34 a128_XA 0.05981f
Ca128eA34_2 a128_mA34 vdd 0.00496f
Ca128eA34_3 a128_mA34 a128_VB 0.07228f
Ca128eA34_4 a128_mA34 0 0.19922f
Xa128edA35 a128_XA a128_VB a128_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA35 0 0 a128_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA35_0 a128_mA35 0 0.00298f
Ca128eA35_1 a128_mA35 a128_XA 0.05981f
Ca128eA35_2 a128_mA35 vdd 0.00496f
Ca128eA35_3 a128_mA35 a128_VB 0.07228f
Ca128eA35_4 a128_mA35 0 0.19922f
Xa128edA36 a128_XA a128_VB a128_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA36 0 0 a128_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA36_0 a128_mA36 0 0.00298f
Ca128eA36_1 a128_mA36 a128_XA 0.05981f
Ca128eA36_2 a128_mA36 vdd 0.00496f
Ca128eA36_3 a128_mA36 a128_VB 0.07228f
Ca128eA36_4 a128_mA36 0 0.19922f
Xa128edA37 a128_XA a128_VB a128_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA37 0 0 a128_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA37_0 a128_mA37 0 0.00298f
Ca128eA37_1 a128_mA37 a128_XA 0.05981f
Ca128eA37_2 a128_mA37 vdd 0.00496f
Ca128eA37_3 a128_mA37 a128_VB 0.07228f
Ca128eA37_4 a128_mA37 0 0.19922f
Xa128edA38 a128_XA a128_VB a128_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA38 0 0 a128_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA38_0 a128_mA38 0 0.00298f
Ca128eA38_1 a128_mA38 a128_XA 0.05981f
Ca128eA38_2 a128_mA38 vdd 0.00496f
Ca128eA38_3 a128_mA38 a128_VB 0.07228f
Ca128eA38_4 a128_mA38 0 0.19922f
Xa128edA39 a128_XA a128_VB a128_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA39 0 0 a128_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA39_0 a128_mA39 0 0.00298f
Ca128eA39_1 a128_mA39 a128_XA 0.05981f
Ca128eA39_2 a128_mA39 vdd 0.00496f
Ca128eA39_3 a128_mA39 a128_VB 0.07228f
Ca128eA39_4 a128_mA39 0 0.19922f
Xa128edA40 a128_XA a128_VB a128_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA40 0 0 a128_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA40_0 a128_mA40 0 0.00298f
Ca128eA40_1 a128_mA40 a128_XA 0.05981f
Ca128eA40_2 a128_mA40 vdd 0.00496f
Ca128eA40_3 a128_mA40 a128_VB 0.07228f
Ca128eA40_4 a128_mA40 0 0.19922f
Xa128edA41 a128_XA a128_VB a128_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA41 0 0 a128_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA41_0 a128_mA41 0 0.00298f
Ca128eA41_1 a128_mA41 a128_XA 0.05981f
Ca128eA41_2 a128_mA41 vdd 0.00496f
Ca128eA41_3 a128_mA41 a128_VB 0.07228f
Ca128eA41_4 a128_mA41 0 0.19922f
Xa128edA42 a128_XA a128_VB a128_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA42 0 0 a128_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA42_0 a128_mA42 0 0.00298f
Ca128eA42_1 a128_mA42 a128_XA 0.05981f
Ca128eA42_2 a128_mA42 vdd 0.00496f
Ca128eA42_3 a128_mA42 a128_VB 0.07228f
Ca128eA42_4 a128_mA42 0 0.19922f
Xa128edA43 a128_XA a128_VB a128_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA43 0 0 a128_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA43_0 a128_mA43 0 0.00298f
Ca128eA43_1 a128_mA43 a128_XA 0.05981f
Ca128eA43_2 a128_mA43 vdd 0.00496f
Ca128eA43_3 a128_mA43 a128_VB 0.07228f
Ca128eA43_4 a128_mA43 0 0.19922f
Xa128edA44 a128_XA a128_VB a128_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA44 0 0 a128_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA44_0 a128_mA44 0 0.00298f
Ca128eA44_1 a128_mA44 a128_XA 0.05981f
Ca128eA44_2 a128_mA44 vdd 0.00496f
Ca128eA44_3 a128_mA44 a128_VB 0.07228f
Ca128eA44_4 a128_mA44 0 0.19922f
Xa128edA45 a128_XA a128_VB a128_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA45 0 0 a128_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA45_0 a128_mA45 0 0.00298f
Ca128eA45_1 a128_mA45 a128_XA 0.05981f
Ca128eA45_2 a128_mA45 vdd 0.00496f
Ca128eA45_3 a128_mA45 a128_VB 0.07228f
Ca128eA45_4 a128_mA45 0 0.19922f
Xa128edA46 a128_XA a128_VB a128_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA46 0 0 a128_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA46_0 a128_mA46 0 0.00298f
Ca128eA46_1 a128_mA46 a128_XA 0.05981f
Ca128eA46_2 a128_mA46 vdd 0.00496f
Ca128eA46_3 a128_mA46 a128_VB 0.07228f
Ca128eA46_4 a128_mA46 0 0.19922f
Xa128edA47 a128_XA a128_VB a128_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA47 0 0 a128_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA47_0 a128_mA47 0 0.00298f
Ca128eA47_1 a128_mA47 a128_XA 0.05981f
Ca128eA47_2 a128_mA47 vdd 0.00496f
Ca128eA47_3 a128_mA47 a128_VB 0.07228f
Ca128eA47_4 a128_mA47 0 0.19922f
Xa128edA48 a128_XA a128_VB a128_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA48 0 0 a128_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA48_0 a128_mA48 0 0.00298f
Ca128eA48_1 a128_mA48 a128_XA 0.05981f
Ca128eA48_2 a128_mA48 vdd 0.00496f
Ca128eA48_3 a128_mA48 a128_VB 0.07228f
Ca128eA48_4 a128_mA48 0 0.19922f
Xa128edA49 a128_XA a128_VB a128_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA49 0 0 a128_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA49_0 a128_mA49 0 0.00298f
Ca128eA49_1 a128_mA49 a128_XA 0.05981f
Ca128eA49_2 a128_mA49 vdd 0.00496f
Ca128eA49_3 a128_mA49 a128_VB 0.07228f
Ca128eA49_4 a128_mA49 0 0.19922f
Xa128edA50 a128_XA a128_VB a128_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA50 0 0 a128_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA50_0 a128_mA50 0 0.00298f
Ca128eA50_1 a128_mA50 a128_XA 0.05981f
Ca128eA50_2 a128_mA50 vdd 0.00496f
Ca128eA50_3 a128_mA50 a128_VB 0.07228f
Ca128eA50_4 a128_mA50 0 0.19922f
Xa128edA51 a128_XA a128_VB a128_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA51 0 0 a128_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA51_0 a128_mA51 0 0.00298f
Ca128eA51_1 a128_mA51 a128_XA 0.05981f
Ca128eA51_2 a128_mA51 vdd 0.00496f
Ca128eA51_3 a128_mA51 a128_VB 0.07228f
Ca128eA51_4 a128_mA51 0 0.19922f
Xa128edA52 a128_XA a128_VB a128_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA52 0 0 a128_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA52_0 a128_mA52 0 0.00298f
Ca128eA52_1 a128_mA52 a128_XA 0.05981f
Ca128eA52_2 a128_mA52 vdd 0.00496f
Ca128eA52_3 a128_mA52 a128_VB 0.07228f
Ca128eA52_4 a128_mA52 0 0.19922f
Xa128edA53 a128_XA a128_VB a128_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA53 0 0 a128_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA53_0 a128_mA53 0 0.00298f
Ca128eA53_1 a128_mA53 a128_XA 0.05981f
Ca128eA53_2 a128_mA53 vdd 0.00496f
Ca128eA53_3 a128_mA53 a128_VB 0.07228f
Ca128eA53_4 a128_mA53 0 0.19922f
Xa128edA54 a128_XA a128_VB a128_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA54 0 0 a128_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA54_0 a128_mA54 0 0.00298f
Ca128eA54_1 a128_mA54 a128_XA 0.05981f
Ca128eA54_2 a128_mA54 vdd 0.00496f
Ca128eA54_3 a128_mA54 a128_VB 0.07228f
Ca128eA54_4 a128_mA54 0 0.19922f
Xa128edA55 a128_XA a128_VB a128_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA55 0 0 a128_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA55_0 a128_mA55 0 0.00298f
Ca128eA55_1 a128_mA55 a128_XA 0.05981f
Ca128eA55_2 a128_mA55 vdd 0.00496f
Ca128eA55_3 a128_mA55 a128_VB 0.07228f
Ca128eA55_4 a128_mA55 0 0.19922f
Xa128edA56 a128_XA a128_VB a128_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA56 0 0 a128_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA56_0 a128_mA56 0 0.00298f
Ca128eA56_1 a128_mA56 a128_XA 0.05981f
Ca128eA56_2 a128_mA56 vdd 0.00496f
Ca128eA56_3 a128_mA56 a128_VB 0.07228f
Ca128eA56_4 a128_mA56 0 0.19922f
Xa128edA57 a128_XA a128_VB a128_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA57 0 0 a128_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA57_0 a128_mA57 0 0.00298f
Ca128eA57_1 a128_mA57 a128_XA 0.05981f
Ca128eA57_2 a128_mA57 vdd 0.00496f
Ca128eA57_3 a128_mA57 a128_VB 0.07228f
Ca128eA57_4 a128_mA57 0 0.19922f
Xa128edA58 a128_XA a128_VB a128_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA58 0 0 a128_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA58_0 a128_mA58 0 0.00298f
Ca128eA58_1 a128_mA58 a128_XA 0.05981f
Ca128eA58_2 a128_mA58 vdd 0.00496f
Ca128eA58_3 a128_mA58 a128_VB 0.07228f
Ca128eA58_4 a128_mA58 0 0.19922f
Xa128edA59 a128_XA a128_VB a128_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA59 0 0 a128_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA59_0 a128_mA59 0 0.00298f
Ca128eA59_1 a128_mA59 a128_XA 0.05981f
Ca128eA59_2 a128_mA59 vdd 0.00496f
Ca128eA59_3 a128_mA59 a128_VB 0.07228f
Ca128eA59_4 a128_mA59 0 0.19922f
Xa128edA60 a128_XA a128_VB a128_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA60 0 0 a128_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA60_0 a128_mA60 0 0.00298f
Ca128eA60_1 a128_mA60 a128_XA 0.05981f
Ca128eA60_2 a128_mA60 vdd 0.00496f
Ca128eA60_3 a128_mA60 a128_VB 0.07228f
Ca128eA60_4 a128_mA60 0 0.19922f
Xa128edA61 a128_XA a128_VB a128_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA61 0 0 a128_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA61_0 a128_mA61 0 0.00298f
Ca128eA61_1 a128_mA61 a128_XA 0.05981f
Ca128eA61_2 a128_mA61 vdd 0.00496f
Ca128eA61_3 a128_mA61 a128_VB 0.07228f
Ca128eA61_4 a128_mA61 0 0.19922f
Xa128edA62 a128_XA a128_VB a128_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA62 0 0 a128_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA62_0 a128_mA62 0 0.00298f
Ca128eA62_1 a128_mA62 a128_XA 0.05981f
Ca128eA62_2 a128_mA62 vdd 0.00496f
Ca128eA62_3 a128_mA62 a128_VB 0.07228f
Ca128eA62_4 a128_mA62 0 0.19922f
Xa128edA63 a128_XA a128_VB a128_mA63 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA63 0 0 a128_mA63 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA63_0 a128_mA63 0 0.00298f
Ca128eA63_1 a128_mA63 a128_XA 0.05981f
Ca128eA63_2 a128_mA63 vdd 0.00496f
Ca128eA63_3 a128_mA63 a128_VB 0.07228f
Ca128eA63_4 a128_mA63 0 0.19922f
Xa128edA64 a128_XA a128_VB a128_mA64 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA64 0 0 a128_mA64 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA64_0 a128_mA64 0 0.00298f
Ca128eA64_1 a128_mA64 a128_XA 0.05981f
Ca128eA64_2 a128_mA64 vdd 0.00496f
Ca128eA64_3 a128_mA64 a128_VB 0.07228f
Ca128eA64_4 a128_mA64 0 0.19922f
Xa128edA65 a128_XA a128_VB a128_mA65 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA65 0 0 a128_mA65 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA65_0 a128_mA65 0 0.00298f
Ca128eA65_1 a128_mA65 a128_XA 0.05981f
Ca128eA65_2 a128_mA65 vdd 0.00496f
Ca128eA65_3 a128_mA65 a128_VB 0.07228f
Ca128eA65_4 a128_mA65 0 0.19922f
Xa128edA66 a128_XA a128_VB a128_mA66 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA66 0 0 a128_mA66 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA66_0 a128_mA66 0 0.00298f
Ca128eA66_1 a128_mA66 a128_XA 0.05981f
Ca128eA66_2 a128_mA66 vdd 0.00496f
Ca128eA66_3 a128_mA66 a128_VB 0.07228f
Ca128eA66_4 a128_mA66 0 0.19922f
Xa128edA67 a128_XA a128_VB a128_mA67 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA67 0 0 a128_mA67 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA67_0 a128_mA67 0 0.00298f
Ca128eA67_1 a128_mA67 a128_XA 0.05981f
Ca128eA67_2 a128_mA67 vdd 0.00496f
Ca128eA67_3 a128_mA67 a128_VB 0.07228f
Ca128eA67_4 a128_mA67 0 0.19922f
Xa128edA68 a128_XA a128_VB a128_mA68 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA68 0 0 a128_mA68 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA68_0 a128_mA68 0 0.00298f
Ca128eA68_1 a128_mA68 a128_XA 0.05981f
Ca128eA68_2 a128_mA68 vdd 0.00496f
Ca128eA68_3 a128_mA68 a128_VB 0.07228f
Ca128eA68_4 a128_mA68 0 0.19922f
Xa128edA69 a128_XA a128_VB a128_mA69 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA69 0 0 a128_mA69 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA69_0 a128_mA69 0 0.00298f
Ca128eA69_1 a128_mA69 a128_XA 0.05981f
Ca128eA69_2 a128_mA69 vdd 0.00496f
Ca128eA69_3 a128_mA69 a128_VB 0.07228f
Ca128eA69_4 a128_mA69 0 0.19922f
Xa128edA70 a128_XA a128_VB a128_mA70 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA70 0 0 a128_mA70 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA70_0 a128_mA70 0 0.00298f
Ca128eA70_1 a128_mA70 a128_XA 0.05981f
Ca128eA70_2 a128_mA70 vdd 0.00496f
Ca128eA70_3 a128_mA70 a128_VB 0.07228f
Ca128eA70_4 a128_mA70 0 0.19922f
Xa128edA71 a128_XA a128_VB a128_mA71 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA71 0 0 a128_mA71 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA71_0 a128_mA71 0 0.00298f
Ca128eA71_1 a128_mA71 a128_XA 0.05981f
Ca128eA71_2 a128_mA71 vdd 0.00496f
Ca128eA71_3 a128_mA71 a128_VB 0.07228f
Ca128eA71_4 a128_mA71 0 0.19922f
Xa128edA72 a128_XA a128_VB a128_mA72 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA72 0 0 a128_mA72 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA72_0 a128_mA72 0 0.00298f
Ca128eA72_1 a128_mA72 a128_XA 0.05981f
Ca128eA72_2 a128_mA72 vdd 0.00496f
Ca128eA72_3 a128_mA72 a128_VB 0.07228f
Ca128eA72_4 a128_mA72 0 0.19922f
Xa128edA73 a128_XA a128_VB a128_mA73 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA73 0 0 a128_mA73 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA73_0 a128_mA73 0 0.00298f
Ca128eA73_1 a128_mA73 a128_XA 0.05981f
Ca128eA73_2 a128_mA73 vdd 0.00496f
Ca128eA73_3 a128_mA73 a128_VB 0.07228f
Ca128eA73_4 a128_mA73 0 0.19922f
Xa128edA74 a128_XA a128_VB a128_mA74 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA74 0 0 a128_mA74 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA74_0 a128_mA74 0 0.00298f
Ca128eA74_1 a128_mA74 a128_XA 0.05981f
Ca128eA74_2 a128_mA74 vdd 0.00496f
Ca128eA74_3 a128_mA74 a128_VB 0.07228f
Ca128eA74_4 a128_mA74 0 0.19922f
Xa128edA75 a128_XA a128_VB a128_mA75 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA75 0 0 a128_mA75 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA75_0 a128_mA75 0 0.00298f
Ca128eA75_1 a128_mA75 a128_XA 0.05981f
Ca128eA75_2 a128_mA75 vdd 0.00496f
Ca128eA75_3 a128_mA75 a128_VB 0.07228f
Ca128eA75_4 a128_mA75 0 0.19922f
Xa128edA76 a128_XA a128_VB a128_mA76 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA76 0 0 a128_mA76 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA76_0 a128_mA76 0 0.00298f
Ca128eA76_1 a128_mA76 a128_XA 0.05981f
Ca128eA76_2 a128_mA76 vdd 0.00496f
Ca128eA76_3 a128_mA76 a128_VB 0.07228f
Ca128eA76_4 a128_mA76 0 0.19922f
Xa128edA77 a128_XA a128_VB a128_mA77 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA77 0 0 a128_mA77 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA77_0 a128_mA77 0 0.00298f
Ca128eA77_1 a128_mA77 a128_XA 0.05981f
Ca128eA77_2 a128_mA77 vdd 0.00496f
Ca128eA77_3 a128_mA77 a128_VB 0.07228f
Ca128eA77_4 a128_mA77 0 0.19922f
Xa128edA78 a128_XA a128_VB a128_mA78 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA78 0 0 a128_mA78 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA78_0 a128_mA78 0 0.00298f
Ca128eA78_1 a128_mA78 a128_XA 0.05981f
Ca128eA78_2 a128_mA78 vdd 0.00496f
Ca128eA78_3 a128_mA78 a128_VB 0.07228f
Ca128eA78_4 a128_mA78 0 0.19922f
Xa128edA79 a128_XA a128_VB a128_mA79 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA79 0 0 a128_mA79 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA79_0 a128_mA79 0 0.00298f
Ca128eA79_1 a128_mA79 a128_XA 0.05981f
Ca128eA79_2 a128_mA79 vdd 0.00496f
Ca128eA79_3 a128_mA79 a128_VB 0.07228f
Ca128eA79_4 a128_mA79 0 0.19922f
Xa128edA80 a128_XA a128_VB a128_mA80 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA80 0 0 a128_mA80 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA80_0 a128_mA80 0 0.00298f
Ca128eA80_1 a128_mA80 a128_XA 0.05981f
Ca128eA80_2 a128_mA80 vdd 0.00496f
Ca128eA80_3 a128_mA80 a128_VB 0.07228f
Ca128eA80_4 a128_mA80 0 0.19922f
Xa128edA81 a128_XA a128_VB a128_mA81 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA81 0 0 a128_mA81 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA81_0 a128_mA81 0 0.00298f
Ca128eA81_1 a128_mA81 a128_XA 0.05981f
Ca128eA81_2 a128_mA81 vdd 0.00496f
Ca128eA81_3 a128_mA81 a128_VB 0.07228f
Ca128eA81_4 a128_mA81 0 0.19922f
Xa128edA82 a128_XA a128_VB a128_mA82 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA82 0 0 a128_mA82 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA82_0 a128_mA82 0 0.00298f
Ca128eA82_1 a128_mA82 a128_XA 0.05981f
Ca128eA82_2 a128_mA82 vdd 0.00496f
Ca128eA82_3 a128_mA82 a128_VB 0.07228f
Ca128eA82_4 a128_mA82 0 0.19922f
Xa128edA83 a128_XA a128_VB a128_mA83 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA83 0 0 a128_mA83 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA83_0 a128_mA83 0 0.00298f
Ca128eA83_1 a128_mA83 a128_XA 0.05981f
Ca128eA83_2 a128_mA83 vdd 0.00496f
Ca128eA83_3 a128_mA83 a128_VB 0.07228f
Ca128eA83_4 a128_mA83 0 0.19922f
Xa128edA84 a128_XA a128_VB a128_mA84 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA84 0 0 a128_mA84 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA84_0 a128_mA84 0 0.00298f
Ca128eA84_1 a128_mA84 a128_XA 0.05981f
Ca128eA84_2 a128_mA84 vdd 0.00496f
Ca128eA84_3 a128_mA84 a128_VB 0.07228f
Ca128eA84_4 a128_mA84 0 0.19922f
Xa128edA85 a128_XA a128_VB a128_mA85 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA85 0 0 a128_mA85 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA85_0 a128_mA85 0 0.00298f
Ca128eA85_1 a128_mA85 a128_XA 0.05981f
Ca128eA85_2 a128_mA85 vdd 0.00496f
Ca128eA85_3 a128_mA85 a128_VB 0.07228f
Ca128eA85_4 a128_mA85 0 0.19922f
Xa128edA86 a128_XA a128_VB a128_mA86 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA86 0 0 a128_mA86 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA86_0 a128_mA86 0 0.00298f
Ca128eA86_1 a128_mA86 a128_XA 0.05981f
Ca128eA86_2 a128_mA86 vdd 0.00496f
Ca128eA86_3 a128_mA86 a128_VB 0.07228f
Ca128eA86_4 a128_mA86 0 0.19922f
Xa128edA87 a128_XA a128_VB a128_mA87 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA87 0 0 a128_mA87 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA87_0 a128_mA87 0 0.00298f
Ca128eA87_1 a128_mA87 a128_XA 0.05981f
Ca128eA87_2 a128_mA87 vdd 0.00496f
Ca128eA87_3 a128_mA87 a128_VB 0.07228f
Ca128eA87_4 a128_mA87 0 0.19922f
Xa128edA88 a128_XA a128_VB a128_mA88 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA88 0 0 a128_mA88 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA88_0 a128_mA88 0 0.00298f
Ca128eA88_1 a128_mA88 a128_XA 0.05981f
Ca128eA88_2 a128_mA88 vdd 0.00496f
Ca128eA88_3 a128_mA88 a128_VB 0.07228f
Ca128eA88_4 a128_mA88 0 0.19922f
Xa128edA89 a128_XA a128_VB a128_mA89 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA89 0 0 a128_mA89 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA89_0 a128_mA89 0 0.00298f
Ca128eA89_1 a128_mA89 a128_XA 0.05981f
Ca128eA89_2 a128_mA89 vdd 0.00496f
Ca128eA89_3 a128_mA89 a128_VB 0.07228f
Ca128eA89_4 a128_mA89 0 0.19922f
Xa128edA90 a128_XA a128_VB a128_mA90 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA90 0 0 a128_mA90 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA90_0 a128_mA90 0 0.00298f
Ca128eA90_1 a128_mA90 a128_XA 0.05981f
Ca128eA90_2 a128_mA90 vdd 0.00496f
Ca128eA90_3 a128_mA90 a128_VB 0.07228f
Ca128eA90_4 a128_mA90 0 0.19922f
Xa128edA91 a128_XA a128_VB a128_mA91 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA91 0 0 a128_mA91 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA91_0 a128_mA91 0 0.00298f
Ca128eA91_1 a128_mA91 a128_XA 0.05981f
Ca128eA91_2 a128_mA91 vdd 0.00496f
Ca128eA91_3 a128_mA91 a128_VB 0.07228f
Ca128eA91_4 a128_mA91 0 0.19922f
Xa128edA92 a128_XA a128_VB a128_mA92 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA92 0 0 a128_mA92 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA92_0 a128_mA92 0 0.00298f
Ca128eA92_1 a128_mA92 a128_XA 0.05981f
Ca128eA92_2 a128_mA92 vdd 0.00496f
Ca128eA92_3 a128_mA92 a128_VB 0.07228f
Ca128eA92_4 a128_mA92 0 0.19922f
Xa128edA93 a128_XA a128_VB a128_mA93 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA93 0 0 a128_mA93 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA93_0 a128_mA93 0 0.00298f
Ca128eA93_1 a128_mA93 a128_XA 0.05981f
Ca128eA93_2 a128_mA93 vdd 0.00496f
Ca128eA93_3 a128_mA93 a128_VB 0.07228f
Ca128eA93_4 a128_mA93 0 0.19922f
Xa128edA94 a128_XA a128_VB a128_mA94 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA94 0 0 a128_mA94 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA94_0 a128_mA94 0 0.00298f
Ca128eA94_1 a128_mA94 a128_XA 0.05981f
Ca128eA94_2 a128_mA94 vdd 0.00496f
Ca128eA94_3 a128_mA94 a128_VB 0.07228f
Ca128eA94_4 a128_mA94 0 0.19922f
Xa128edA95 a128_XA a128_VB a128_mA95 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA95 0 0 a128_mA95 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA95_0 a128_mA95 0 0.00298f
Ca128eA95_1 a128_mA95 a128_XA 0.05981f
Ca128eA95_2 a128_mA95 vdd 0.00496f
Ca128eA95_3 a128_mA95 a128_VB 0.07228f
Ca128eA95_4 a128_mA95 0 0.19922f
Xa128edA96 a128_XA a128_VB a128_mA96 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA96 0 0 a128_mA96 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA96_0 a128_mA96 0 0.00298f
Ca128eA96_1 a128_mA96 a128_XA 0.05981f
Ca128eA96_2 a128_mA96 vdd 0.00496f
Ca128eA96_3 a128_mA96 a128_VB 0.07228f
Ca128eA96_4 a128_mA96 0 0.19922f
Xa128edA97 a128_XA a128_VB a128_mA97 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA97 0 0 a128_mA97 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA97_0 a128_mA97 0 0.00298f
Ca128eA97_1 a128_mA97 a128_XA 0.05981f
Ca128eA97_2 a128_mA97 vdd 0.00496f
Ca128eA97_3 a128_mA97 a128_VB 0.07228f
Ca128eA97_4 a128_mA97 0 0.19922f
Xa128edA98 a128_XA a128_VB a128_mA98 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA98 0 0 a128_mA98 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA98_0 a128_mA98 0 0.00298f
Ca128eA98_1 a128_mA98 a128_XA 0.05981f
Ca128eA98_2 a128_mA98 vdd 0.00496f
Ca128eA98_3 a128_mA98 a128_VB 0.07228f
Ca128eA98_4 a128_mA98 0 0.19922f
Xa128edA99 a128_XA a128_VB a128_mA99 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA99 0 0 a128_mA99 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA99_0 a128_mA99 0 0.00298f
Ca128eA99_1 a128_mA99 a128_XA 0.05981f
Ca128eA99_2 a128_mA99 vdd 0.00496f
Ca128eA99_3 a128_mA99 a128_VB 0.07228f
Ca128eA99_4 a128_mA99 0 0.19922f
Xa128edA100 a128_XA a128_VB a128_mA100 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA100 0 0 a128_mA100 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA100_0 a128_mA100 0 0.00298f
Ca128eA100_1 a128_mA100 a128_XA 0.05981f
Ca128eA100_2 a128_mA100 vdd 0.00496f
Ca128eA100_3 a128_mA100 a128_VB 0.07228f
Ca128eA100_4 a128_mA100 0 0.19922f
Xa128edA101 a128_XA a128_VB a128_mA101 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA101 0 0 a128_mA101 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA101_0 a128_mA101 0 0.00298f
Ca128eA101_1 a128_mA101 a128_XA 0.05981f
Ca128eA101_2 a128_mA101 vdd 0.00496f
Ca128eA101_3 a128_mA101 a128_VB 0.07228f
Ca128eA101_4 a128_mA101 0 0.19922f
Xa128edA102 a128_XA a128_VB a128_mA102 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA102 0 0 a128_mA102 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA102_0 a128_mA102 0 0.00298f
Ca128eA102_1 a128_mA102 a128_XA 0.05981f
Ca128eA102_2 a128_mA102 vdd 0.00496f
Ca128eA102_3 a128_mA102 a128_VB 0.07228f
Ca128eA102_4 a128_mA102 0 0.19922f
Xa128edA103 a128_XA a128_VB a128_mA103 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA103 0 0 a128_mA103 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA103_0 a128_mA103 0 0.00298f
Ca128eA103_1 a128_mA103 a128_XA 0.05981f
Ca128eA103_2 a128_mA103 vdd 0.00496f
Ca128eA103_3 a128_mA103 a128_VB 0.07228f
Ca128eA103_4 a128_mA103 0 0.19922f
Xa128edA104 a128_XA a128_VB a128_mA104 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA104 0 0 a128_mA104 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA104_0 a128_mA104 0 0.00298f
Ca128eA104_1 a128_mA104 a128_XA 0.05981f
Ca128eA104_2 a128_mA104 vdd 0.00496f
Ca128eA104_3 a128_mA104 a128_VB 0.07228f
Ca128eA104_4 a128_mA104 0 0.19922f
Xa128edA105 a128_XA a128_VB a128_mA105 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA105 0 0 a128_mA105 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA105_0 a128_mA105 0 0.00298f
Ca128eA105_1 a128_mA105 a128_XA 0.05981f
Ca128eA105_2 a128_mA105 vdd 0.00496f
Ca128eA105_3 a128_mA105 a128_VB 0.07228f
Ca128eA105_4 a128_mA105 0 0.19922f
Xa128edA106 a128_XA a128_VB a128_mA106 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA106 0 0 a128_mA106 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA106_0 a128_mA106 0 0.00298f
Ca128eA106_1 a128_mA106 a128_XA 0.05981f
Ca128eA106_2 a128_mA106 vdd 0.00496f
Ca128eA106_3 a128_mA106 a128_VB 0.07228f
Ca128eA106_4 a128_mA106 0 0.19922f
Xa128edA107 a128_XA a128_VB a128_mA107 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA107 0 0 a128_mA107 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA107_0 a128_mA107 0 0.00298f
Ca128eA107_1 a128_mA107 a128_XA 0.05981f
Ca128eA107_2 a128_mA107 vdd 0.00496f
Ca128eA107_3 a128_mA107 a128_VB 0.07228f
Ca128eA107_4 a128_mA107 0 0.19922f
Xa128edA108 a128_XA a128_VB a128_mA108 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA108 0 0 a128_mA108 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA108_0 a128_mA108 0 0.00298f
Ca128eA108_1 a128_mA108 a128_XA 0.05981f
Ca128eA108_2 a128_mA108 vdd 0.00496f
Ca128eA108_3 a128_mA108 a128_VB 0.07228f
Ca128eA108_4 a128_mA108 0 0.19922f
Xa128edA109 a128_XA a128_VB a128_mA109 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA109 0 0 a128_mA109 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA109_0 a128_mA109 0 0.00298f
Ca128eA109_1 a128_mA109 a128_XA 0.05981f
Ca128eA109_2 a128_mA109 vdd 0.00496f
Ca128eA109_3 a128_mA109 a128_VB 0.07228f
Ca128eA109_4 a128_mA109 0 0.19922f
Xa128edA110 a128_XA a128_VB a128_mA110 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA110 0 0 a128_mA110 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA110_0 a128_mA110 0 0.00298f
Ca128eA110_1 a128_mA110 a128_XA 0.05981f
Ca128eA110_2 a128_mA110 vdd 0.00496f
Ca128eA110_3 a128_mA110 a128_VB 0.07228f
Ca128eA110_4 a128_mA110 0 0.19922f
Xa128edA111 a128_XA a128_VB a128_mA111 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA111 0 0 a128_mA111 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA111_0 a128_mA111 0 0.00298f
Ca128eA111_1 a128_mA111 a128_XA 0.05981f
Ca128eA111_2 a128_mA111 vdd 0.00496f
Ca128eA111_3 a128_mA111 a128_VB 0.07228f
Ca128eA111_4 a128_mA111 0 0.19922f
Xa128edA112 a128_XA a128_VB a128_mA112 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA112 0 0 a128_mA112 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA112_0 a128_mA112 0 0.00298f
Ca128eA112_1 a128_mA112 a128_XA 0.05981f
Ca128eA112_2 a128_mA112 vdd 0.00496f
Ca128eA112_3 a128_mA112 a128_VB 0.07228f
Ca128eA112_4 a128_mA112 0 0.19922f
Xa128edA113 a128_XA a128_VB a128_mA113 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA113 0 0 a128_mA113 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA113_0 a128_mA113 0 0.00298f
Ca128eA113_1 a128_mA113 a128_XA 0.05981f
Ca128eA113_2 a128_mA113 vdd 0.00496f
Ca128eA113_3 a128_mA113 a128_VB 0.07228f
Ca128eA113_4 a128_mA113 0 0.19922f
Xa128edA114 a128_XA a128_VB a128_mA114 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA114 0 0 a128_mA114 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA114_0 a128_mA114 0 0.00298f
Ca128eA114_1 a128_mA114 a128_XA 0.05981f
Ca128eA114_2 a128_mA114 vdd 0.00496f
Ca128eA114_3 a128_mA114 a128_VB 0.07228f
Ca128eA114_4 a128_mA114 0 0.19922f
Xa128edA115 a128_XA a128_VB a128_mA115 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA115 0 0 a128_mA115 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA115_0 a128_mA115 0 0.00298f
Ca128eA115_1 a128_mA115 a128_XA 0.05981f
Ca128eA115_2 a128_mA115 vdd 0.00496f
Ca128eA115_3 a128_mA115 a128_VB 0.07228f
Ca128eA115_4 a128_mA115 0 0.19922f
Xa128edA116 a128_XA a128_VB a128_mA116 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA116 0 0 a128_mA116 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA116_0 a128_mA116 0 0.00298f
Ca128eA116_1 a128_mA116 a128_XA 0.05981f
Ca128eA116_2 a128_mA116 vdd 0.00496f
Ca128eA116_3 a128_mA116 a128_VB 0.07228f
Ca128eA116_4 a128_mA116 0 0.19922f
Xa128edA117 a128_XA a128_VB a128_mA117 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA117 0 0 a128_mA117 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA117_0 a128_mA117 0 0.00298f
Ca128eA117_1 a128_mA117 a128_XA 0.05981f
Ca128eA117_2 a128_mA117 vdd 0.00496f
Ca128eA117_3 a128_mA117 a128_VB 0.07228f
Ca128eA117_4 a128_mA117 0 0.19922f
Xa128edA118 a128_XA a128_VB a128_mA118 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA118 0 0 a128_mA118 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA118_0 a128_mA118 0 0.00298f
Ca128eA118_1 a128_mA118 a128_XA 0.05981f
Ca128eA118_2 a128_mA118 vdd 0.00496f
Ca128eA118_3 a128_mA118 a128_VB 0.07228f
Ca128eA118_4 a128_mA118 0 0.19922f
Xa128edA119 a128_XA a128_VB a128_mA119 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA119 0 0 a128_mA119 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA119_0 a128_mA119 0 0.00298f
Ca128eA119_1 a128_mA119 a128_XA 0.05981f
Ca128eA119_2 a128_mA119 vdd 0.00496f
Ca128eA119_3 a128_mA119 a128_VB 0.07228f
Ca128eA119_4 a128_mA119 0 0.19922f
Xa128edA120 a128_XA a128_VB a128_mA120 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA120 0 0 a128_mA120 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA120_0 a128_mA120 0 0.00298f
Ca128eA120_1 a128_mA120 a128_XA 0.05981f
Ca128eA120_2 a128_mA120 vdd 0.00496f
Ca128eA120_3 a128_mA120 a128_VB 0.07228f
Ca128eA120_4 a128_mA120 0 0.19922f
Xa128edA121 a128_XA a128_VB a128_mA121 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA121 0 0 a128_mA121 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA121_0 a128_mA121 0 0.00298f
Ca128eA121_1 a128_mA121 a128_XA 0.05981f
Ca128eA121_2 a128_mA121 vdd 0.00496f
Ca128eA121_3 a128_mA121 a128_VB 0.07228f
Ca128eA121_4 a128_mA121 0 0.19922f
Xa128edA122 a128_XA a128_VB a128_mA122 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA122 0 0 a128_mA122 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA122_0 a128_mA122 0 0.00298f
Ca128eA122_1 a128_mA122 a128_XA 0.05981f
Ca128eA122_2 a128_mA122 vdd 0.00496f
Ca128eA122_3 a128_mA122 a128_VB 0.07228f
Ca128eA122_4 a128_mA122 0 0.19922f
Xa128edA123 a128_XA a128_VB a128_mA123 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA123 0 0 a128_mA123 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA123_0 a128_mA123 0 0.00298f
Ca128eA123_1 a128_mA123 a128_XA 0.05981f
Ca128eA123_2 a128_mA123 vdd 0.00496f
Ca128eA123_3 a128_mA123 a128_VB 0.07228f
Ca128eA123_4 a128_mA123 0 0.19922f
Xa128edA124 a128_XA a128_VB a128_mA124 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA124 0 0 a128_mA124 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA124_0 a128_mA124 0 0.00298f
Ca128eA124_1 a128_mA124 a128_XA 0.05981f
Ca128eA124_2 a128_mA124 vdd 0.00496f
Ca128eA124_3 a128_mA124 a128_VB 0.07228f
Ca128eA124_4 a128_mA124 0 0.19922f
Xa128edA125 a128_XA a128_VB a128_mA125 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA125 0 0 a128_mA125 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA125_0 a128_mA125 0 0.00298f
Ca128eA125_1 a128_mA125 a128_XA 0.05981f
Ca128eA125_2 a128_mA125 vdd 0.00496f
Ca128eA125_3 a128_mA125 a128_VB 0.07228f
Ca128eA125_4 a128_mA125 0 0.19922f
Xa128edA126 a128_XA a128_VB a128_mA126 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esA126 0 0 a128_mA126 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eA126_0 a128_mA126 0 0.00298f
Ca128eA126_1 a128_mA126 a128_XA 0.05981f
Ca128eA126_2 a128_mA126 vdd 0.00496f
Ca128eA126_3 a128_mA126 a128_VB 0.07228f
Ca128eA126_4 a128_mA126 0 0.19922f
Xa128edB0 a128_XB a128_VB a128_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB0 0 0 a128_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB0_0 a128_mB0 a128_XB 0.05778f
Ca128eB0_1 a128_mB0 vdd 0.00496f
Ca128eB0_2 a128_mB0 a128_VB 0.0654f
Ca128eB0_3 a128_mB0 0 0.00298f
Ca128eB0_4 a128_mB0 0 0.20468f
Xa128edB1 a128_XB a128_VB a128_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB1 0 0 a128_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB1_0 a128_mB1 a128_XB 0.05778f
Ca128eB1_1 a128_mB1 vdd 0.00496f
Ca128eB1_2 a128_mB1 a128_VB 0.0654f
Ca128eB1_3 a128_mB1 0 0.00298f
Ca128eB1_4 a128_mB1 0 0.20468f
Xa128edB2 a128_XB a128_VB a128_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB2 0 0 a128_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB2_0 a128_mB2 a128_XB 0.05778f
Ca128eB2_1 a128_mB2 vdd 0.00496f
Ca128eB2_2 a128_mB2 a128_VB 0.0654f
Ca128eB2_3 a128_mB2 0 0.00298f
Ca128eB2_4 a128_mB2 0 0.20468f
Xa128edB3 a128_XB a128_VB a128_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB3 0 0 a128_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB3_0 a128_mB3 a128_XB 0.05778f
Ca128eB3_1 a128_mB3 vdd 0.00496f
Ca128eB3_2 a128_mB3 a128_VB 0.0654f
Ca128eB3_3 a128_mB3 0 0.00298f
Ca128eB3_4 a128_mB3 0 0.20468f
Xa128edB4 a128_XB a128_VB a128_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB4 0 0 a128_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB4_0 a128_mB4 a128_XB 0.05778f
Ca128eB4_1 a128_mB4 vdd 0.00496f
Ca128eB4_2 a128_mB4 a128_VB 0.0654f
Ca128eB4_3 a128_mB4 0 0.00298f
Ca128eB4_4 a128_mB4 0 0.20468f
Xa128edB5 a128_XB a128_VB a128_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB5 0 0 a128_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB5_0 a128_mB5 a128_XB 0.05778f
Ca128eB5_1 a128_mB5 vdd 0.00496f
Ca128eB5_2 a128_mB5 a128_VB 0.0654f
Ca128eB5_3 a128_mB5 0 0.00298f
Ca128eB5_4 a128_mB5 0 0.20468f
Xa128edB6 a128_XB a128_VB a128_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB6 0 0 a128_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB6_0 a128_mB6 a128_XB 0.05778f
Ca128eB6_1 a128_mB6 vdd 0.00496f
Ca128eB6_2 a128_mB6 a128_VB 0.0654f
Ca128eB6_3 a128_mB6 0 0.00298f
Ca128eB6_4 a128_mB6 0 0.20468f
Xa128edB7 a128_XB a128_VB a128_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB7 0 0 a128_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB7_0 a128_mB7 a128_XB 0.05778f
Ca128eB7_1 a128_mB7 vdd 0.00496f
Ca128eB7_2 a128_mB7 a128_VB 0.0654f
Ca128eB7_3 a128_mB7 0 0.00298f
Ca128eB7_4 a128_mB7 0 0.20468f
Xa128edB8 a128_XB a128_VB a128_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB8 0 0 a128_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB8_0 a128_mB8 a128_XB 0.05778f
Ca128eB8_1 a128_mB8 vdd 0.00496f
Ca128eB8_2 a128_mB8 a128_VB 0.0654f
Ca128eB8_3 a128_mB8 0 0.00298f
Ca128eB8_4 a128_mB8 0 0.20468f
Xa128edB9 a128_XB a128_VB a128_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB9 0 0 a128_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB9_0 a128_mB9 a128_XB 0.05778f
Ca128eB9_1 a128_mB9 vdd 0.00496f
Ca128eB9_2 a128_mB9 a128_VB 0.0654f
Ca128eB9_3 a128_mB9 0 0.00298f
Ca128eB9_4 a128_mB9 0 0.20468f
Xa128edB10 a128_XB a128_VB a128_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB10 0 0 a128_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB10_0 a128_mB10 a128_XB 0.05778f
Ca128eB10_1 a128_mB10 vdd 0.00496f
Ca128eB10_2 a128_mB10 a128_VB 0.0654f
Ca128eB10_3 a128_mB10 0 0.00298f
Ca128eB10_4 a128_mB10 0 0.20468f
Xa128edB11 a128_XB a128_VB a128_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB11 0 0 a128_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB11_0 a128_mB11 a128_XB 0.05778f
Ca128eB11_1 a128_mB11 vdd 0.00496f
Ca128eB11_2 a128_mB11 a128_VB 0.0654f
Ca128eB11_3 a128_mB11 0 0.00298f
Ca128eB11_4 a128_mB11 0 0.20468f
Xa128edB12 a128_XB a128_VB a128_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB12 0 0 a128_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB12_0 a128_mB12 a128_XB 0.05778f
Ca128eB12_1 a128_mB12 vdd 0.00496f
Ca128eB12_2 a128_mB12 a128_VB 0.0654f
Ca128eB12_3 a128_mB12 0 0.00298f
Ca128eB12_4 a128_mB12 0 0.20468f
Xa128edB13 a128_XB a128_VB a128_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB13 0 0 a128_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB13_0 a128_mB13 a128_XB 0.05778f
Ca128eB13_1 a128_mB13 vdd 0.00496f
Ca128eB13_2 a128_mB13 a128_VB 0.0654f
Ca128eB13_3 a128_mB13 0 0.00298f
Ca128eB13_4 a128_mB13 0 0.20468f
Xa128edB14 a128_XB a128_VB a128_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB14 0 0 a128_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB14_0 a128_mB14 a128_XB 0.05778f
Ca128eB14_1 a128_mB14 vdd 0.00496f
Ca128eB14_2 a128_mB14 a128_VB 0.0654f
Ca128eB14_3 a128_mB14 0 0.00298f
Ca128eB14_4 a128_mB14 0 0.20468f
Xa128edB15 a128_XB a128_VB a128_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB15 0 0 a128_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB15_0 a128_mB15 a128_XB 0.05778f
Ca128eB15_1 a128_mB15 vdd 0.00496f
Ca128eB15_2 a128_mB15 a128_VB 0.0654f
Ca128eB15_3 a128_mB15 0 0.00298f
Ca128eB15_4 a128_mB15 0 0.20468f
Xa128edB16 a128_XB a128_VB a128_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB16 0 0 a128_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB16_0 a128_mB16 a128_XB 0.05778f
Ca128eB16_1 a128_mB16 vdd 0.00496f
Ca128eB16_2 a128_mB16 a128_VB 0.0654f
Ca128eB16_3 a128_mB16 0 0.00298f
Ca128eB16_4 a128_mB16 0 0.20468f
Xa128edB17 a128_XB a128_VB a128_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB17 0 0 a128_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB17_0 a128_mB17 a128_XB 0.05778f
Ca128eB17_1 a128_mB17 vdd 0.00496f
Ca128eB17_2 a128_mB17 a128_VB 0.0654f
Ca128eB17_3 a128_mB17 0 0.00298f
Ca128eB17_4 a128_mB17 0 0.20468f
Xa128edB18 a128_XB a128_VB a128_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB18 0 0 a128_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB18_0 a128_mB18 a128_XB 0.05778f
Ca128eB18_1 a128_mB18 vdd 0.00496f
Ca128eB18_2 a128_mB18 a128_VB 0.0654f
Ca128eB18_3 a128_mB18 0 0.00298f
Ca128eB18_4 a128_mB18 0 0.20468f
Xa128edB19 a128_XB a128_VB a128_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB19 0 0 a128_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB19_0 a128_mB19 a128_XB 0.05778f
Ca128eB19_1 a128_mB19 vdd 0.00496f
Ca128eB19_2 a128_mB19 a128_VB 0.0654f
Ca128eB19_3 a128_mB19 0 0.00298f
Ca128eB19_4 a128_mB19 0 0.20468f
Xa128edB20 a128_XB a128_VB a128_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB20 0 0 a128_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB20_0 a128_mB20 a128_XB 0.05778f
Ca128eB20_1 a128_mB20 vdd 0.00496f
Ca128eB20_2 a128_mB20 a128_VB 0.0654f
Ca128eB20_3 a128_mB20 0 0.00298f
Ca128eB20_4 a128_mB20 0 0.20468f
Xa128edB21 a128_XB a128_VB a128_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB21 0 0 a128_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB21_0 a128_mB21 a128_XB 0.05778f
Ca128eB21_1 a128_mB21 vdd 0.00496f
Ca128eB21_2 a128_mB21 a128_VB 0.0654f
Ca128eB21_3 a128_mB21 0 0.00298f
Ca128eB21_4 a128_mB21 0 0.20468f
Xa128edB22 a128_XB a128_VB a128_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB22 0 0 a128_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB22_0 a128_mB22 a128_XB 0.05778f
Ca128eB22_1 a128_mB22 vdd 0.00496f
Ca128eB22_2 a128_mB22 a128_VB 0.0654f
Ca128eB22_3 a128_mB22 0 0.00298f
Ca128eB22_4 a128_mB22 0 0.20468f
Xa128edB23 a128_XB a128_VB a128_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB23 0 0 a128_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB23_0 a128_mB23 a128_XB 0.05778f
Ca128eB23_1 a128_mB23 vdd 0.00496f
Ca128eB23_2 a128_mB23 a128_VB 0.0654f
Ca128eB23_3 a128_mB23 0 0.00298f
Ca128eB23_4 a128_mB23 0 0.20468f
Xa128edB24 a128_XB a128_VB a128_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB24 0 0 a128_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB24_0 a128_mB24 a128_XB 0.05778f
Ca128eB24_1 a128_mB24 vdd 0.00496f
Ca128eB24_2 a128_mB24 a128_VB 0.0654f
Ca128eB24_3 a128_mB24 0 0.00298f
Ca128eB24_4 a128_mB24 0 0.20468f
Xa128edB25 a128_XB a128_VB a128_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB25 0 0 a128_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB25_0 a128_mB25 a128_XB 0.05778f
Ca128eB25_1 a128_mB25 vdd 0.00496f
Ca128eB25_2 a128_mB25 a128_VB 0.0654f
Ca128eB25_3 a128_mB25 0 0.00298f
Ca128eB25_4 a128_mB25 0 0.20468f
Xa128edB26 a128_XB a128_VB a128_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB26 0 0 a128_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB26_0 a128_mB26 a128_XB 0.05778f
Ca128eB26_1 a128_mB26 vdd 0.00496f
Ca128eB26_2 a128_mB26 a128_VB 0.0654f
Ca128eB26_3 a128_mB26 0 0.00298f
Ca128eB26_4 a128_mB26 0 0.20468f
Xa128edB27 a128_XB a128_VB a128_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB27 0 0 a128_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB27_0 a128_mB27 a128_XB 0.05778f
Ca128eB27_1 a128_mB27 vdd 0.00496f
Ca128eB27_2 a128_mB27 a128_VB 0.0654f
Ca128eB27_3 a128_mB27 0 0.00298f
Ca128eB27_4 a128_mB27 0 0.20468f
Xa128edB28 a128_XB a128_VB a128_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB28 0 0 a128_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB28_0 a128_mB28 a128_XB 0.05778f
Ca128eB28_1 a128_mB28 vdd 0.00496f
Ca128eB28_2 a128_mB28 a128_VB 0.0654f
Ca128eB28_3 a128_mB28 0 0.00298f
Ca128eB28_4 a128_mB28 0 0.20468f
Xa128edB29 a128_XB a128_VB a128_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB29 0 0 a128_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB29_0 a128_mB29 a128_XB 0.05778f
Ca128eB29_1 a128_mB29 vdd 0.00496f
Ca128eB29_2 a128_mB29 a128_VB 0.0654f
Ca128eB29_3 a128_mB29 0 0.00298f
Ca128eB29_4 a128_mB29 0 0.20468f
Xa128edB30 a128_XB a128_VB a128_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB30 0 0 a128_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB30_0 a128_mB30 a128_XB 0.05778f
Ca128eB30_1 a128_mB30 vdd 0.00496f
Ca128eB30_2 a128_mB30 a128_VB 0.0654f
Ca128eB30_3 a128_mB30 0 0.00298f
Ca128eB30_4 a128_mB30 0 0.20468f
Xa128edB31 a128_XB a128_VB a128_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB31 0 0 a128_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB31_0 a128_mB31 a128_XB 0.05778f
Ca128eB31_1 a128_mB31 vdd 0.00496f
Ca128eB31_2 a128_mB31 a128_VB 0.0654f
Ca128eB31_3 a128_mB31 0 0.00298f
Ca128eB31_4 a128_mB31 0 0.20468f
Xa128edB32 a128_XB a128_VB a128_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB32 0 0 a128_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB32_0 a128_mB32 a128_XB 0.05778f
Ca128eB32_1 a128_mB32 vdd 0.00496f
Ca128eB32_2 a128_mB32 a128_VB 0.0654f
Ca128eB32_3 a128_mB32 0 0.00298f
Ca128eB32_4 a128_mB32 0 0.20468f
Xa128edB33 a128_XB a128_VB a128_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB33 0 0 a128_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB33_0 a128_mB33 a128_XB 0.05778f
Ca128eB33_1 a128_mB33 vdd 0.00496f
Ca128eB33_2 a128_mB33 a128_VB 0.0654f
Ca128eB33_3 a128_mB33 0 0.00298f
Ca128eB33_4 a128_mB33 0 0.20468f
Xa128edB34 a128_XB a128_VB a128_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB34 0 0 a128_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB34_0 a128_mB34 a128_XB 0.05778f
Ca128eB34_1 a128_mB34 vdd 0.00496f
Ca128eB34_2 a128_mB34 a128_VB 0.0654f
Ca128eB34_3 a128_mB34 0 0.00298f
Ca128eB34_4 a128_mB34 0 0.20468f
Xa128edB35 a128_XB a128_VB a128_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB35 0 0 a128_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB35_0 a128_mB35 a128_XB 0.05778f
Ca128eB35_1 a128_mB35 vdd 0.00496f
Ca128eB35_2 a128_mB35 a128_VB 0.0654f
Ca128eB35_3 a128_mB35 0 0.00298f
Ca128eB35_4 a128_mB35 0 0.20468f
Xa128edB36 a128_XB a128_VB a128_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB36 0 0 a128_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB36_0 a128_mB36 a128_XB 0.05778f
Ca128eB36_1 a128_mB36 vdd 0.00496f
Ca128eB36_2 a128_mB36 a128_VB 0.0654f
Ca128eB36_3 a128_mB36 0 0.00298f
Ca128eB36_4 a128_mB36 0 0.20468f
Xa128edB37 a128_XB a128_VB a128_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB37 0 0 a128_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB37_0 a128_mB37 a128_XB 0.05778f
Ca128eB37_1 a128_mB37 vdd 0.00496f
Ca128eB37_2 a128_mB37 a128_VB 0.0654f
Ca128eB37_3 a128_mB37 0 0.00298f
Ca128eB37_4 a128_mB37 0 0.20468f
Xa128edB38 a128_XB a128_VB a128_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB38 0 0 a128_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB38_0 a128_mB38 a128_XB 0.05778f
Ca128eB38_1 a128_mB38 vdd 0.00496f
Ca128eB38_2 a128_mB38 a128_VB 0.0654f
Ca128eB38_3 a128_mB38 0 0.00298f
Ca128eB38_4 a128_mB38 0 0.20468f
Xa128edB39 a128_XB a128_VB a128_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB39 0 0 a128_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB39_0 a128_mB39 a128_XB 0.05778f
Ca128eB39_1 a128_mB39 vdd 0.00496f
Ca128eB39_2 a128_mB39 a128_VB 0.0654f
Ca128eB39_3 a128_mB39 0 0.00298f
Ca128eB39_4 a128_mB39 0 0.20468f
Xa128edB40 a128_XB a128_VB a128_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB40 0 0 a128_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB40_0 a128_mB40 a128_XB 0.05778f
Ca128eB40_1 a128_mB40 vdd 0.00496f
Ca128eB40_2 a128_mB40 a128_VB 0.0654f
Ca128eB40_3 a128_mB40 0 0.00298f
Ca128eB40_4 a128_mB40 0 0.20468f
Xa128edB41 a128_XB a128_VB a128_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB41 0 0 a128_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB41_0 a128_mB41 a128_XB 0.05778f
Ca128eB41_1 a128_mB41 vdd 0.00496f
Ca128eB41_2 a128_mB41 a128_VB 0.0654f
Ca128eB41_3 a128_mB41 0 0.00298f
Ca128eB41_4 a128_mB41 0 0.20468f
Xa128edB42 a128_XB a128_VB a128_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB42 0 0 a128_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB42_0 a128_mB42 a128_XB 0.05778f
Ca128eB42_1 a128_mB42 vdd 0.00496f
Ca128eB42_2 a128_mB42 a128_VB 0.0654f
Ca128eB42_3 a128_mB42 0 0.00298f
Ca128eB42_4 a128_mB42 0 0.20468f
Xa128edB43 a128_XB a128_VB a128_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB43 0 0 a128_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB43_0 a128_mB43 a128_XB 0.05778f
Ca128eB43_1 a128_mB43 vdd 0.00496f
Ca128eB43_2 a128_mB43 a128_VB 0.0654f
Ca128eB43_3 a128_mB43 0 0.00298f
Ca128eB43_4 a128_mB43 0 0.20468f
Xa128edB44 a128_XB a128_VB a128_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB44 0 0 a128_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB44_0 a128_mB44 a128_XB 0.05778f
Ca128eB44_1 a128_mB44 vdd 0.00496f
Ca128eB44_2 a128_mB44 a128_VB 0.0654f
Ca128eB44_3 a128_mB44 0 0.00298f
Ca128eB44_4 a128_mB44 0 0.20468f
Xa128edB45 a128_XB a128_VB a128_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB45 0 0 a128_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB45_0 a128_mB45 a128_XB 0.05778f
Ca128eB45_1 a128_mB45 vdd 0.00496f
Ca128eB45_2 a128_mB45 a128_VB 0.0654f
Ca128eB45_3 a128_mB45 0 0.00298f
Ca128eB45_4 a128_mB45 0 0.20468f
Xa128edB46 a128_XB a128_VB a128_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB46 0 0 a128_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB46_0 a128_mB46 a128_XB 0.05778f
Ca128eB46_1 a128_mB46 vdd 0.00496f
Ca128eB46_2 a128_mB46 a128_VB 0.0654f
Ca128eB46_3 a128_mB46 0 0.00298f
Ca128eB46_4 a128_mB46 0 0.20468f
Xa128edB47 a128_XB a128_VB a128_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB47 0 0 a128_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB47_0 a128_mB47 a128_XB 0.05778f
Ca128eB47_1 a128_mB47 vdd 0.00496f
Ca128eB47_2 a128_mB47 a128_VB 0.0654f
Ca128eB47_3 a128_mB47 0 0.00298f
Ca128eB47_4 a128_mB47 0 0.20468f
Xa128edB48 a128_XB a128_VB a128_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB48 0 0 a128_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB48_0 a128_mB48 a128_XB 0.05778f
Ca128eB48_1 a128_mB48 vdd 0.00496f
Ca128eB48_2 a128_mB48 a128_VB 0.0654f
Ca128eB48_3 a128_mB48 0 0.00298f
Ca128eB48_4 a128_mB48 0 0.20468f
Xa128edB49 a128_XB a128_VB a128_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB49 0 0 a128_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB49_0 a128_mB49 a128_XB 0.05778f
Ca128eB49_1 a128_mB49 vdd 0.00496f
Ca128eB49_2 a128_mB49 a128_VB 0.0654f
Ca128eB49_3 a128_mB49 0 0.00298f
Ca128eB49_4 a128_mB49 0 0.20468f
Xa128edB50 a128_XB a128_VB a128_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB50 0 0 a128_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB50_0 a128_mB50 a128_XB 0.05778f
Ca128eB50_1 a128_mB50 vdd 0.00496f
Ca128eB50_2 a128_mB50 a128_VB 0.0654f
Ca128eB50_3 a128_mB50 0 0.00298f
Ca128eB50_4 a128_mB50 0 0.20468f
Xa128edB51 a128_XB a128_VB a128_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB51 0 0 a128_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB51_0 a128_mB51 a128_XB 0.05778f
Ca128eB51_1 a128_mB51 vdd 0.00496f
Ca128eB51_2 a128_mB51 a128_VB 0.0654f
Ca128eB51_3 a128_mB51 0 0.00298f
Ca128eB51_4 a128_mB51 0 0.20468f
Xa128edB52 a128_XB a128_VB a128_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB52 0 0 a128_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB52_0 a128_mB52 a128_XB 0.05778f
Ca128eB52_1 a128_mB52 vdd 0.00496f
Ca128eB52_2 a128_mB52 a128_VB 0.0654f
Ca128eB52_3 a128_mB52 0 0.00298f
Ca128eB52_4 a128_mB52 0 0.20468f
Xa128edB53 a128_XB a128_VB a128_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB53 0 0 a128_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB53_0 a128_mB53 a128_XB 0.05778f
Ca128eB53_1 a128_mB53 vdd 0.00496f
Ca128eB53_2 a128_mB53 a128_VB 0.0654f
Ca128eB53_3 a128_mB53 0 0.00298f
Ca128eB53_4 a128_mB53 0 0.20468f
Xa128edB54 a128_XB a128_VB a128_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB54 0 0 a128_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB54_0 a128_mB54 a128_XB 0.05778f
Ca128eB54_1 a128_mB54 vdd 0.00496f
Ca128eB54_2 a128_mB54 a128_VB 0.0654f
Ca128eB54_3 a128_mB54 0 0.00298f
Ca128eB54_4 a128_mB54 0 0.20468f
Xa128edB55 a128_XB a128_VB a128_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB55 0 0 a128_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB55_0 a128_mB55 a128_XB 0.05778f
Ca128eB55_1 a128_mB55 vdd 0.00496f
Ca128eB55_2 a128_mB55 a128_VB 0.0654f
Ca128eB55_3 a128_mB55 0 0.00298f
Ca128eB55_4 a128_mB55 0 0.20468f
Xa128edB56 a128_XB a128_VB a128_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB56 0 0 a128_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB56_0 a128_mB56 a128_XB 0.05778f
Ca128eB56_1 a128_mB56 vdd 0.00496f
Ca128eB56_2 a128_mB56 a128_VB 0.0654f
Ca128eB56_3 a128_mB56 0 0.00298f
Ca128eB56_4 a128_mB56 0 0.20468f
Xa128edB57 a128_XB a128_VB a128_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB57 0 0 a128_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB57_0 a128_mB57 a128_XB 0.05778f
Ca128eB57_1 a128_mB57 vdd 0.00496f
Ca128eB57_2 a128_mB57 a128_VB 0.0654f
Ca128eB57_3 a128_mB57 0 0.00298f
Ca128eB57_4 a128_mB57 0 0.20468f
Xa128edB58 a128_XB a128_VB a128_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB58 0 0 a128_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB58_0 a128_mB58 a128_XB 0.05778f
Ca128eB58_1 a128_mB58 vdd 0.00496f
Ca128eB58_2 a128_mB58 a128_VB 0.0654f
Ca128eB58_3 a128_mB58 0 0.00298f
Ca128eB58_4 a128_mB58 0 0.20468f
Xa128edB59 a128_XB a128_VB a128_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB59 0 0 a128_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB59_0 a128_mB59 a128_XB 0.05778f
Ca128eB59_1 a128_mB59 vdd 0.00496f
Ca128eB59_2 a128_mB59 a128_VB 0.0654f
Ca128eB59_3 a128_mB59 0 0.00298f
Ca128eB59_4 a128_mB59 0 0.20468f
Xa128edB60 a128_XB a128_VB a128_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB60 0 0 a128_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB60_0 a128_mB60 a128_XB 0.05778f
Ca128eB60_1 a128_mB60 vdd 0.00496f
Ca128eB60_2 a128_mB60 a128_VB 0.0654f
Ca128eB60_3 a128_mB60 0 0.00298f
Ca128eB60_4 a128_mB60 0 0.20468f
Xa128edB61 a128_XB a128_VB a128_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB61 0 0 a128_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB61_0 a128_mB61 a128_XB 0.05778f
Ca128eB61_1 a128_mB61 vdd 0.00496f
Ca128eB61_2 a128_mB61 a128_VB 0.0654f
Ca128eB61_3 a128_mB61 0 0.00298f
Ca128eB61_4 a128_mB61 0 0.20468f
Xa128edB62 a128_XB a128_VB a128_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB62 0 0 a128_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB62_0 a128_mB62 a128_XB 0.05778f
Ca128eB62_1 a128_mB62 vdd 0.00496f
Ca128eB62_2 a128_mB62 a128_VB 0.0654f
Ca128eB62_3 a128_mB62 0 0.00298f
Ca128eB62_4 a128_mB62 0 0.20468f
Xa128edB63 a128_XB a128_VB a128_mB63 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB63 0 0 a128_mB63 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB63_0 a128_mB63 a128_XB 0.05778f
Ca128eB63_1 a128_mB63 vdd 0.00496f
Ca128eB63_2 a128_mB63 a128_VB 0.0654f
Ca128eB63_3 a128_mB63 0 0.00298f
Ca128eB63_4 a128_mB63 0 0.20468f
Xa128edB64 a128_XB a128_VB a128_mB64 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB64 0 0 a128_mB64 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB64_0 a128_mB64 a128_XB 0.05778f
Ca128eB64_1 a128_mB64 vdd 0.00496f
Ca128eB64_2 a128_mB64 a128_VB 0.0654f
Ca128eB64_3 a128_mB64 0 0.00298f
Ca128eB64_4 a128_mB64 0 0.20468f
Xa128edB65 a128_XB a128_VB a128_mB65 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB65 0 0 a128_mB65 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB65_0 a128_mB65 a128_XB 0.05778f
Ca128eB65_1 a128_mB65 vdd 0.00496f
Ca128eB65_2 a128_mB65 a128_VB 0.0654f
Ca128eB65_3 a128_mB65 0 0.00298f
Ca128eB65_4 a128_mB65 0 0.20468f
Xa128edB66 a128_XB a128_VB a128_mB66 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB66 0 0 a128_mB66 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB66_0 a128_mB66 a128_XB 0.05778f
Ca128eB66_1 a128_mB66 vdd 0.00496f
Ca128eB66_2 a128_mB66 a128_VB 0.0654f
Ca128eB66_3 a128_mB66 0 0.00298f
Ca128eB66_4 a128_mB66 0 0.20468f
Xa128edB67 a128_XB a128_VB a128_mB67 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB67 0 0 a128_mB67 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB67_0 a128_mB67 a128_XB 0.05778f
Ca128eB67_1 a128_mB67 vdd 0.00496f
Ca128eB67_2 a128_mB67 a128_VB 0.0654f
Ca128eB67_3 a128_mB67 0 0.00298f
Ca128eB67_4 a128_mB67 0 0.20468f
Xa128edB68 a128_XB a128_VB a128_mB68 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB68 0 0 a128_mB68 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB68_0 a128_mB68 a128_XB 0.05778f
Ca128eB68_1 a128_mB68 vdd 0.00496f
Ca128eB68_2 a128_mB68 a128_VB 0.0654f
Ca128eB68_3 a128_mB68 0 0.00298f
Ca128eB68_4 a128_mB68 0 0.20468f
Xa128edB69 a128_XB a128_VB a128_mB69 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB69 0 0 a128_mB69 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB69_0 a128_mB69 a128_XB 0.05778f
Ca128eB69_1 a128_mB69 vdd 0.00496f
Ca128eB69_2 a128_mB69 a128_VB 0.0654f
Ca128eB69_3 a128_mB69 0 0.00298f
Ca128eB69_4 a128_mB69 0 0.20468f
Xa128edB70 a128_XB a128_VB a128_mB70 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB70 0 0 a128_mB70 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB70_0 a128_mB70 a128_XB 0.05778f
Ca128eB70_1 a128_mB70 vdd 0.00496f
Ca128eB70_2 a128_mB70 a128_VB 0.0654f
Ca128eB70_3 a128_mB70 0 0.00298f
Ca128eB70_4 a128_mB70 0 0.20468f
Xa128edB71 a128_XB a128_VB a128_mB71 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB71 0 0 a128_mB71 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB71_0 a128_mB71 a128_XB 0.05778f
Ca128eB71_1 a128_mB71 vdd 0.00496f
Ca128eB71_2 a128_mB71 a128_VB 0.0654f
Ca128eB71_3 a128_mB71 0 0.00298f
Ca128eB71_4 a128_mB71 0 0.20468f
Xa128edB72 a128_XB a128_VB a128_mB72 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB72 0 0 a128_mB72 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB72_0 a128_mB72 a128_XB 0.05778f
Ca128eB72_1 a128_mB72 vdd 0.00496f
Ca128eB72_2 a128_mB72 a128_VB 0.0654f
Ca128eB72_3 a128_mB72 0 0.00298f
Ca128eB72_4 a128_mB72 0 0.20468f
Xa128edB73 a128_XB a128_VB a128_mB73 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB73 0 0 a128_mB73 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB73_0 a128_mB73 a128_XB 0.05778f
Ca128eB73_1 a128_mB73 vdd 0.00496f
Ca128eB73_2 a128_mB73 a128_VB 0.0654f
Ca128eB73_3 a128_mB73 0 0.00298f
Ca128eB73_4 a128_mB73 0 0.20468f
Xa128edB74 a128_XB a128_VB a128_mB74 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB74 0 0 a128_mB74 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB74_0 a128_mB74 a128_XB 0.05778f
Ca128eB74_1 a128_mB74 vdd 0.00496f
Ca128eB74_2 a128_mB74 a128_VB 0.0654f
Ca128eB74_3 a128_mB74 0 0.00298f
Ca128eB74_4 a128_mB74 0 0.20468f
Xa128edB75 a128_XB a128_VB a128_mB75 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB75 0 0 a128_mB75 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB75_0 a128_mB75 a128_XB 0.05778f
Ca128eB75_1 a128_mB75 vdd 0.00496f
Ca128eB75_2 a128_mB75 a128_VB 0.0654f
Ca128eB75_3 a128_mB75 0 0.00298f
Ca128eB75_4 a128_mB75 0 0.20468f
Xa128edB76 a128_XB a128_VB a128_mB76 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB76 0 0 a128_mB76 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB76_0 a128_mB76 a128_XB 0.05778f
Ca128eB76_1 a128_mB76 vdd 0.00496f
Ca128eB76_2 a128_mB76 a128_VB 0.0654f
Ca128eB76_3 a128_mB76 0 0.00298f
Ca128eB76_4 a128_mB76 0 0.20468f
Xa128edB77 a128_XB a128_VB a128_mB77 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB77 0 0 a128_mB77 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB77_0 a128_mB77 a128_XB 0.05778f
Ca128eB77_1 a128_mB77 vdd 0.00496f
Ca128eB77_2 a128_mB77 a128_VB 0.0654f
Ca128eB77_3 a128_mB77 0 0.00298f
Ca128eB77_4 a128_mB77 0 0.20468f
Xa128edB78 a128_XB a128_VB a128_mB78 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB78 0 0 a128_mB78 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB78_0 a128_mB78 a128_XB 0.05778f
Ca128eB78_1 a128_mB78 vdd 0.00496f
Ca128eB78_2 a128_mB78 a128_VB 0.0654f
Ca128eB78_3 a128_mB78 0 0.00298f
Ca128eB78_4 a128_mB78 0 0.20468f
Xa128edB79 a128_XB a128_VB a128_mB79 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB79 0 0 a128_mB79 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB79_0 a128_mB79 a128_XB 0.05778f
Ca128eB79_1 a128_mB79 vdd 0.00496f
Ca128eB79_2 a128_mB79 a128_VB 0.0654f
Ca128eB79_3 a128_mB79 0 0.00298f
Ca128eB79_4 a128_mB79 0 0.20468f
Xa128edB80 a128_XB a128_VB a128_mB80 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB80 0 0 a128_mB80 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB80_0 a128_mB80 a128_XB 0.05778f
Ca128eB80_1 a128_mB80 vdd 0.00496f
Ca128eB80_2 a128_mB80 a128_VB 0.0654f
Ca128eB80_3 a128_mB80 0 0.00298f
Ca128eB80_4 a128_mB80 0 0.20468f
Xa128edB81 a128_XB a128_VB a128_mB81 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB81 0 0 a128_mB81 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB81_0 a128_mB81 a128_XB 0.05778f
Ca128eB81_1 a128_mB81 vdd 0.00496f
Ca128eB81_2 a128_mB81 a128_VB 0.0654f
Ca128eB81_3 a128_mB81 0 0.00298f
Ca128eB81_4 a128_mB81 0 0.20468f
Xa128edB82 a128_XB a128_VB a128_mB82 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB82 0 0 a128_mB82 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB82_0 a128_mB82 a128_XB 0.05778f
Ca128eB82_1 a128_mB82 vdd 0.00496f
Ca128eB82_2 a128_mB82 a128_VB 0.0654f
Ca128eB82_3 a128_mB82 0 0.00298f
Ca128eB82_4 a128_mB82 0 0.20468f
Xa128edB83 a128_XB a128_VB a128_mB83 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB83 0 0 a128_mB83 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB83_0 a128_mB83 a128_XB 0.05778f
Ca128eB83_1 a128_mB83 vdd 0.00496f
Ca128eB83_2 a128_mB83 a128_VB 0.0654f
Ca128eB83_3 a128_mB83 0 0.00298f
Ca128eB83_4 a128_mB83 0 0.20468f
Xa128edB84 a128_XB a128_VB a128_mB84 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB84 0 0 a128_mB84 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB84_0 a128_mB84 a128_XB 0.05778f
Ca128eB84_1 a128_mB84 vdd 0.00496f
Ca128eB84_2 a128_mB84 a128_VB 0.0654f
Ca128eB84_3 a128_mB84 0 0.00298f
Ca128eB84_4 a128_mB84 0 0.20468f
Xa128edB85 a128_XB a128_VB a128_mB85 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB85 0 0 a128_mB85 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB85_0 a128_mB85 a128_XB 0.05778f
Ca128eB85_1 a128_mB85 vdd 0.00496f
Ca128eB85_2 a128_mB85 a128_VB 0.0654f
Ca128eB85_3 a128_mB85 0 0.00298f
Ca128eB85_4 a128_mB85 0 0.20468f
Xa128edB86 a128_XB a128_VB a128_mB86 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB86 0 0 a128_mB86 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB86_0 a128_mB86 a128_XB 0.05778f
Ca128eB86_1 a128_mB86 vdd 0.00496f
Ca128eB86_2 a128_mB86 a128_VB 0.0654f
Ca128eB86_3 a128_mB86 0 0.00298f
Ca128eB86_4 a128_mB86 0 0.20468f
Xa128edB87 a128_XB a128_VB a128_mB87 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB87 0 0 a128_mB87 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB87_0 a128_mB87 a128_XB 0.05778f
Ca128eB87_1 a128_mB87 vdd 0.00496f
Ca128eB87_2 a128_mB87 a128_VB 0.0654f
Ca128eB87_3 a128_mB87 0 0.00298f
Ca128eB87_4 a128_mB87 0 0.20468f
Xa128edB88 a128_XB a128_VB a128_mB88 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB88 0 0 a128_mB88 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB88_0 a128_mB88 a128_XB 0.05778f
Ca128eB88_1 a128_mB88 vdd 0.00496f
Ca128eB88_2 a128_mB88 a128_VB 0.0654f
Ca128eB88_3 a128_mB88 0 0.00298f
Ca128eB88_4 a128_mB88 0 0.20468f
Xa128edB89 a128_XB a128_VB a128_mB89 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB89 0 0 a128_mB89 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB89_0 a128_mB89 a128_XB 0.05778f
Ca128eB89_1 a128_mB89 vdd 0.00496f
Ca128eB89_2 a128_mB89 a128_VB 0.0654f
Ca128eB89_3 a128_mB89 0 0.00298f
Ca128eB89_4 a128_mB89 0 0.20468f
Xa128edB90 a128_XB a128_VB a128_mB90 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB90 0 0 a128_mB90 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB90_0 a128_mB90 a128_XB 0.05778f
Ca128eB90_1 a128_mB90 vdd 0.00496f
Ca128eB90_2 a128_mB90 a128_VB 0.0654f
Ca128eB90_3 a128_mB90 0 0.00298f
Ca128eB90_4 a128_mB90 0 0.20468f
Xa128edB91 a128_XB a128_VB a128_mB91 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB91 0 0 a128_mB91 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB91_0 a128_mB91 a128_XB 0.05778f
Ca128eB91_1 a128_mB91 vdd 0.00496f
Ca128eB91_2 a128_mB91 a128_VB 0.0654f
Ca128eB91_3 a128_mB91 0 0.00298f
Ca128eB91_4 a128_mB91 0 0.20468f
Xa128edB92 a128_XB a128_VB a128_mB92 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB92 0 0 a128_mB92 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB92_0 a128_mB92 a128_XB 0.05778f
Ca128eB92_1 a128_mB92 vdd 0.00496f
Ca128eB92_2 a128_mB92 a128_VB 0.0654f
Ca128eB92_3 a128_mB92 0 0.00298f
Ca128eB92_4 a128_mB92 0 0.20468f
Xa128edB93 a128_XB a128_VB a128_mB93 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB93 0 0 a128_mB93 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB93_0 a128_mB93 a128_XB 0.05778f
Ca128eB93_1 a128_mB93 vdd 0.00496f
Ca128eB93_2 a128_mB93 a128_VB 0.0654f
Ca128eB93_3 a128_mB93 0 0.00298f
Ca128eB93_4 a128_mB93 0 0.20468f
Xa128edB94 a128_XB a128_VB a128_mB94 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB94 0 0 a128_mB94 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB94_0 a128_mB94 a128_XB 0.05778f
Ca128eB94_1 a128_mB94 vdd 0.00496f
Ca128eB94_2 a128_mB94 a128_VB 0.0654f
Ca128eB94_3 a128_mB94 0 0.00298f
Ca128eB94_4 a128_mB94 0 0.20468f
Xa128edB95 a128_XB a128_VB a128_mB95 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB95 0 0 a128_mB95 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB95_0 a128_mB95 a128_XB 0.05778f
Ca128eB95_1 a128_mB95 vdd 0.00496f
Ca128eB95_2 a128_mB95 a128_VB 0.0654f
Ca128eB95_3 a128_mB95 0 0.00298f
Ca128eB95_4 a128_mB95 0 0.20468f
Xa128edB96 a128_XB a128_VB a128_mB96 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB96 0 0 a128_mB96 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB96_0 a128_mB96 a128_XB 0.05778f
Ca128eB96_1 a128_mB96 vdd 0.00496f
Ca128eB96_2 a128_mB96 a128_VB 0.0654f
Ca128eB96_3 a128_mB96 0 0.00298f
Ca128eB96_4 a128_mB96 0 0.20468f
Xa128edB97 a128_XB a128_VB a128_mB97 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB97 0 0 a128_mB97 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB97_0 a128_mB97 a128_XB 0.05778f
Ca128eB97_1 a128_mB97 vdd 0.00496f
Ca128eB97_2 a128_mB97 a128_VB 0.0654f
Ca128eB97_3 a128_mB97 0 0.00298f
Ca128eB97_4 a128_mB97 0 0.20468f
Xa128edB98 a128_XB a128_VB a128_mB98 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB98 0 0 a128_mB98 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB98_0 a128_mB98 a128_XB 0.05778f
Ca128eB98_1 a128_mB98 vdd 0.00496f
Ca128eB98_2 a128_mB98 a128_VB 0.0654f
Ca128eB98_3 a128_mB98 0 0.00298f
Ca128eB98_4 a128_mB98 0 0.20468f
Xa128edB99 a128_XB a128_VB a128_mB99 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB99 0 0 a128_mB99 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB99_0 a128_mB99 a128_XB 0.05778f
Ca128eB99_1 a128_mB99 vdd 0.00496f
Ca128eB99_2 a128_mB99 a128_VB 0.0654f
Ca128eB99_3 a128_mB99 0 0.00298f
Ca128eB99_4 a128_mB99 0 0.20468f
Xa128edB100 a128_XB a128_VB a128_mB100 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB100 0 0 a128_mB100 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB100_0 a128_mB100 a128_XB 0.05778f
Ca128eB100_1 a128_mB100 vdd 0.00496f
Ca128eB100_2 a128_mB100 a128_VB 0.0654f
Ca128eB100_3 a128_mB100 0 0.00298f
Ca128eB100_4 a128_mB100 0 0.20468f
Xa128edB101 a128_XB a128_VB a128_mB101 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB101 0 0 a128_mB101 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB101_0 a128_mB101 a128_XB 0.05778f
Ca128eB101_1 a128_mB101 vdd 0.00496f
Ca128eB101_2 a128_mB101 a128_VB 0.0654f
Ca128eB101_3 a128_mB101 0 0.00298f
Ca128eB101_4 a128_mB101 0 0.20468f
Xa128edB102 a128_XB a128_VB a128_mB102 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB102 0 0 a128_mB102 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB102_0 a128_mB102 a128_XB 0.05778f
Ca128eB102_1 a128_mB102 vdd 0.00496f
Ca128eB102_2 a128_mB102 a128_VB 0.0654f
Ca128eB102_3 a128_mB102 0 0.00298f
Ca128eB102_4 a128_mB102 0 0.20468f
Xa128edB103 a128_XB a128_VB a128_mB103 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB103 0 0 a128_mB103 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB103_0 a128_mB103 a128_XB 0.05778f
Ca128eB103_1 a128_mB103 vdd 0.00496f
Ca128eB103_2 a128_mB103 a128_VB 0.0654f
Ca128eB103_3 a128_mB103 0 0.00298f
Ca128eB103_4 a128_mB103 0 0.20468f
Xa128edB104 a128_XB a128_VB a128_mB104 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB104 0 0 a128_mB104 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB104_0 a128_mB104 a128_XB 0.05778f
Ca128eB104_1 a128_mB104 vdd 0.00496f
Ca128eB104_2 a128_mB104 a128_VB 0.0654f
Ca128eB104_3 a128_mB104 0 0.00298f
Ca128eB104_4 a128_mB104 0 0.20468f
Xa128edB105 a128_XB a128_VB a128_mB105 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB105 0 0 a128_mB105 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB105_0 a128_mB105 a128_XB 0.05778f
Ca128eB105_1 a128_mB105 vdd 0.00496f
Ca128eB105_2 a128_mB105 a128_VB 0.0654f
Ca128eB105_3 a128_mB105 0 0.00298f
Ca128eB105_4 a128_mB105 0 0.20468f
Xa128edB106 a128_XB a128_VB a128_mB106 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB106 0 0 a128_mB106 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB106_0 a128_mB106 a128_XB 0.05778f
Ca128eB106_1 a128_mB106 vdd 0.00496f
Ca128eB106_2 a128_mB106 a128_VB 0.0654f
Ca128eB106_3 a128_mB106 0 0.00298f
Ca128eB106_4 a128_mB106 0 0.20468f
Xa128edB107 a128_XB a128_VB a128_mB107 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB107 0 0 a128_mB107 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB107_0 a128_mB107 a128_XB 0.05778f
Ca128eB107_1 a128_mB107 vdd 0.00496f
Ca128eB107_2 a128_mB107 a128_VB 0.0654f
Ca128eB107_3 a128_mB107 0 0.00298f
Ca128eB107_4 a128_mB107 0 0.20468f
Xa128edB108 a128_XB a128_VB a128_mB108 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB108 0 0 a128_mB108 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB108_0 a128_mB108 a128_XB 0.05778f
Ca128eB108_1 a128_mB108 vdd 0.00496f
Ca128eB108_2 a128_mB108 a128_VB 0.0654f
Ca128eB108_3 a128_mB108 0 0.00298f
Ca128eB108_4 a128_mB108 0 0.20468f
Xa128edB109 a128_XB a128_VB a128_mB109 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB109 0 0 a128_mB109 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB109_0 a128_mB109 a128_XB 0.05778f
Ca128eB109_1 a128_mB109 vdd 0.00496f
Ca128eB109_2 a128_mB109 a128_VB 0.0654f
Ca128eB109_3 a128_mB109 0 0.00298f
Ca128eB109_4 a128_mB109 0 0.20468f
Xa128edB110 a128_XB a128_VB a128_mB110 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB110 0 0 a128_mB110 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB110_0 a128_mB110 a128_XB 0.05778f
Ca128eB110_1 a128_mB110 vdd 0.00496f
Ca128eB110_2 a128_mB110 a128_VB 0.0654f
Ca128eB110_3 a128_mB110 0 0.00298f
Ca128eB110_4 a128_mB110 0 0.20468f
Xa128edB111 a128_XB a128_VB a128_mB111 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB111 0 0 a128_mB111 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB111_0 a128_mB111 a128_XB 0.05778f
Ca128eB111_1 a128_mB111 vdd 0.00496f
Ca128eB111_2 a128_mB111 a128_VB 0.0654f
Ca128eB111_3 a128_mB111 0 0.00298f
Ca128eB111_4 a128_mB111 0 0.20468f
Xa128edB112 a128_XB a128_VB a128_mB112 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB112 0 0 a128_mB112 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB112_0 a128_mB112 a128_XB 0.05778f
Ca128eB112_1 a128_mB112 vdd 0.00496f
Ca128eB112_2 a128_mB112 a128_VB 0.0654f
Ca128eB112_3 a128_mB112 0 0.00298f
Ca128eB112_4 a128_mB112 0 0.20468f
Xa128edB113 a128_XB a128_VB a128_mB113 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB113 0 0 a128_mB113 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB113_0 a128_mB113 a128_XB 0.05778f
Ca128eB113_1 a128_mB113 vdd 0.00496f
Ca128eB113_2 a128_mB113 a128_VB 0.0654f
Ca128eB113_3 a128_mB113 0 0.00298f
Ca128eB113_4 a128_mB113 0 0.20468f
Xa128edB114 a128_XB a128_VB a128_mB114 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB114 0 0 a128_mB114 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB114_0 a128_mB114 a128_XB 0.05778f
Ca128eB114_1 a128_mB114 vdd 0.00496f
Ca128eB114_2 a128_mB114 a128_VB 0.0654f
Ca128eB114_3 a128_mB114 0 0.00298f
Ca128eB114_4 a128_mB114 0 0.20468f
Xa128edB115 a128_XB a128_VB a128_mB115 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB115 0 0 a128_mB115 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB115_0 a128_mB115 a128_XB 0.05778f
Ca128eB115_1 a128_mB115 vdd 0.00496f
Ca128eB115_2 a128_mB115 a128_VB 0.0654f
Ca128eB115_3 a128_mB115 0 0.00298f
Ca128eB115_4 a128_mB115 0 0.20468f
Xa128edB116 a128_XB a128_VB a128_mB116 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB116 0 0 a128_mB116 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB116_0 a128_mB116 a128_XB 0.05778f
Ca128eB116_1 a128_mB116 vdd 0.00496f
Ca128eB116_2 a128_mB116 a128_VB 0.0654f
Ca128eB116_3 a128_mB116 0 0.00298f
Ca128eB116_4 a128_mB116 0 0.20468f
Xa128edB117 a128_XB a128_VB a128_mB117 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB117 0 0 a128_mB117 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB117_0 a128_mB117 a128_XB 0.05778f
Ca128eB117_1 a128_mB117 vdd 0.00496f
Ca128eB117_2 a128_mB117 a128_VB 0.0654f
Ca128eB117_3 a128_mB117 0 0.00298f
Ca128eB117_4 a128_mB117 0 0.20468f
Xa128edB118 a128_XB a128_VB a128_mB118 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB118 0 0 a128_mB118 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB118_0 a128_mB118 a128_XB 0.05778f
Ca128eB118_1 a128_mB118 vdd 0.00496f
Ca128eB118_2 a128_mB118 a128_VB 0.0654f
Ca128eB118_3 a128_mB118 0 0.00298f
Ca128eB118_4 a128_mB118 0 0.20468f
Xa128edB119 a128_XB a128_VB a128_mB119 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB119 0 0 a128_mB119 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB119_0 a128_mB119 a128_XB 0.05778f
Ca128eB119_1 a128_mB119 vdd 0.00496f
Ca128eB119_2 a128_mB119 a128_VB 0.0654f
Ca128eB119_3 a128_mB119 0 0.00298f
Ca128eB119_4 a128_mB119 0 0.20468f
Xa128edB120 a128_XB a128_VB a128_mB120 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB120 0 0 a128_mB120 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB120_0 a128_mB120 a128_XB 0.05778f
Ca128eB120_1 a128_mB120 vdd 0.00496f
Ca128eB120_2 a128_mB120 a128_VB 0.0654f
Ca128eB120_3 a128_mB120 0 0.00298f
Ca128eB120_4 a128_mB120 0 0.20468f
Xa128edB121 a128_XB a128_VB a128_mB121 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB121 0 0 a128_mB121 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB121_0 a128_mB121 a128_XB 0.05778f
Ca128eB121_1 a128_mB121 vdd 0.00496f
Ca128eB121_2 a128_mB121 a128_VB 0.0654f
Ca128eB121_3 a128_mB121 0 0.00298f
Ca128eB121_4 a128_mB121 0 0.20468f
Xa128edB122 a128_XB a128_VB a128_mB122 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB122 0 0 a128_mB122 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB122_0 a128_mB122 a128_XB 0.05778f
Ca128eB122_1 a128_mB122 vdd 0.00496f
Ca128eB122_2 a128_mB122 a128_VB 0.0654f
Ca128eB122_3 a128_mB122 0 0.00298f
Ca128eB122_4 a128_mB122 0 0.20468f
Xa128edB123 a128_XB a128_VB a128_mB123 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB123 0 0 a128_mB123 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB123_0 a128_mB123 a128_XB 0.05778f
Ca128eB123_1 a128_mB123 vdd 0.00496f
Ca128eB123_2 a128_mB123 a128_VB 0.0654f
Ca128eB123_3 a128_mB123 0 0.00298f
Ca128eB123_4 a128_mB123 0 0.20468f
Xa128edB124 a128_XB a128_VB a128_mB124 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB124 0 0 a128_mB124 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB124_0 a128_mB124 a128_XB 0.05778f
Ca128eB124_1 a128_mB124 vdd 0.00496f
Ca128eB124_2 a128_mB124 a128_VB 0.0654f
Ca128eB124_3 a128_mB124 0 0.00298f
Ca128eB124_4 a128_mB124 0 0.20468f
Xa128edB125 a128_XB a128_VB a128_mB125 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB125 0 0 a128_mB125 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB125_0 a128_mB125 a128_XB 0.05778f
Ca128eB125_1 a128_mB125 vdd 0.00496f
Ca128eB125_2 a128_mB125 a128_VB 0.0654f
Ca128eB125_3 a128_mB125 0 0.00298f
Ca128eB125_4 a128_mB125 0 0.20468f
Xa128edB126 a128_XB a128_VB a128_mB126 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xa128esB126 0 0 a128_mB126 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ca128eB126_0 a128_mB126 a128_XB 0.05778f
Ca128eB126_1 a128_mB126 vdd 0.00496f
Ca128eB126_2 a128_mB126 a128_VB 0.0654f
Ca128eB126_3 a128_mB126 0 0.00298f
Ca128eB126_4 a128_mB126 0 0.20468f

.control
set noaskquit
save v(h00_XA) v(a32_XA) v(a128_XA) v(a32_oa) v(a128_oa)
tran 100n 1.4m 0 200n
meas tran h00_min min v(h00_XA) from=1e-06 to=1.4m
echo LD ss 85 h00_XA_min $&h00_min
meas tran a32_min min v(a32_XA) from=1e-06 to=1.4m
echo LD ss 85 a32_XA_min $&a32_min
meas tran a128_min min v(a128_XA) from=1e-06 to=1.4m
echo LD ss 85 a128_XA_min $&a128_min
meas tran a32_omax max v(a32_oa) from=1e-06 to=1.4m
echo LD ss 85 a32_oa_max $&a32_omax
meas tran a32_tx when v(a32_oa)=0.9 rise=1
echo LD ss 85 a32_cruce $&a32_tx
meas tran a128_omax max v(a128_oa) from=1e-06 to=1.4m
echo LD ss 85 a128_oa_max $&a128_omax
meas tran a128_tx when v(a128_oa)=0.9 rise=1
echo LD ss 85 a128_cruce $&a128_tx
quit
.endc
.end
