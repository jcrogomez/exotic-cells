* MISFIT-03 etapa a · MISFIT-12 prueba B · esquina ss 85 C. Generado por gen_contrato.py (no editar a mano).
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
.subckt trap XB_OUT SB0B SB1B REFB XA_OUT SA0B SA1B SA2B REFA VDD GND VBIAS C1 PREA XA DUTA PREB XB DUTB VB CALA CALB GT
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
.subckt u128 SEL0 SEL1 SEL2 SEL3 SEL4 SEL5 SEL6 SEL7 SEL8 SEL9 SEL10 SEL11 SEL12 SEL13 SEL14 SEL15 SEL16 SEL17 SEL18 SEL19 SEL20 SEL21 SEL22 SEL23 SEL24 SEL25 SEL26 SEL27 SEL28 SEL29 SEL30 SEL31 SEL32 SEL33 SEL34 SEL35 SEL36 SEL37 SEL38 SEL39 SEL40 SEL41 SEL42 SEL43 SEL44 SEL45 SEL46 SEL47 SEL48 SEL49 SEL50 SEL51 SEL52 SEL53 SEL54 SEL55 SEL56 SEL57 SEL58 SEL59 SEL60 SEL61 SEL62 SEL63 SEL64 SEL65 SEL66 SEL67 SEL68 SEL69 SEL70 SEL71 SEL72 SEL73 SEL74 SEL75 SEL76 SEL77 SEL78 SEL79 SEL80 SEL81 SEL82 SEL83 SEL84 SEL85 SEL86 SEL87 SEL88 SEL89 SEL90 SEL91 SEL92 SEL93 SEL94 SEL95 SEL96 SEL97 SEL98 SEL99 SEL100 SEL101 SEL102 SEL103 SEL104 SEL105 SEL106 SEL107 SEL108 SEL109 SEL110 SEL111 SEL112 SEL113 SEL114 SEL115 SEL116 SEL117 SEL118 SEL119 SEL120 SEL121 SEL122 SEL123 SEL124 SEL125 SEL126 SEL127 X VB GND
X0 X VB a_10758_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X1 X VB a_18654_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 GND SEL9 a_2112_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X3 GND SEL23 a_5106_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X4 GND SEL122 a_27096_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X5 GND SEL93 a_20628_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X6 GND SEL34 a_7626_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X7 X VB a_17292_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X8 GND SEL91 a_20220_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X9 X VB a_7830_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 X VB a_26892_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 GND SEL116 a_25734_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X12 GND SEL54 a_11982_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X13 X VB a_5652_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X14 GND SEL79 a_17496_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X15 GND SEL65 a_14502_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X16 X VB a_4290_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X17 X VB a_23352_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X18 X VB a_25530_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X19 GND SEL25 a_5652_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X20 X VB a_2928_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 X VB a_13752_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 GND SEL39 a_8646_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X23 X VB a_8646_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X24 X VB a_21990_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X25 GND SEL37 a_8238_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X26 X VB a_20628_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X27 X VB a_26346_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X28 GND SEL107 a_23760_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X29 GND SEL56 a_12528_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X30 GND SEL45 a_10008_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X31 X VB a_342_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X32 X VB a_14502_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 GND SEL104 a_23148_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X34 X VB a_9396_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X35 GND SEL5 a_1158_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X36 GND SEL16 a_3678_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X37 X VB a_18858_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 GND SEL68 a_15114_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X39 X VB a_8034_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X40 X VB a_10962_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 X VB a_27096_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X42 GND SEL28 a_6264_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X43 X VB a_17496_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 GND SEL98 a_21786_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X45 X VB a_19608_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X46 X VB a_13956_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X47 GND SEL3 a_750_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X48 GND SEL61 a_13548_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X49 X VB a_5856_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X50 GND SEL110 a_24372_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X51 X VB a_16068_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 GND SEL22 a_4902_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X53 GND SEL121 a_26892_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X54 GND SEL59 a_13140_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X55 X VB a_4494_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 X VB a_23556_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X57 X VB a_25734_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X58 GND SEL84 a_18654_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X59 X VB a_954_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 X VB a_3132_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X61 X VB a_22194_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X62 GND SEL101 a_22398_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X63 GND SEL42 a_9396_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X64 GND SEL13 a_2928_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X65 GND SEL112 a_24918_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X66 GND SEL50 a_11166_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X67 X VB a_546_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X68 X VB a_14706_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 GND SEL99 a_21990_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X70 X VB a_11166_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X71 GND SEL11 a_2520_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X72 GND SEL124 a_27504_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X73 X VB a_8238_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X74 X VB a_19062_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X75 GND SEL87 a_19266_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X76 GND SEL73 a_16272_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X77 X VB a_20832_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X78 X VB a_9600_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X79 GND SEL90 a_20016_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X80 GND SEL67 a_14910_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X81 X VB a_6060_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X82 X VB a_27300_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X83 GND SEL64 a_14298_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X84 X VB a_4698_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X85 X VB a_25938_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X86 GND SEL113 a_25122_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X87 GND SEL14 a_3132_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X88 GND SEL24 a_5448_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X89 GND SEL127 a_28116_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X90 X VB a_1158_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X91 X VB a_3336_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X92 X VB a_19812_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X93 X VB a_22398_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X94 GND SEL47 a_10416_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X95 X VB a_21036_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X96 GND SEL58 a_12936_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X97 X VB a_16272_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X98 GND SEL106 a_23556_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X99 X VB a_23760_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X100 GND SEL7 a_1566_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X101 GND SEL70 a_15522_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X102 GND SEL118 a_26142_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X103 X VB a_19266_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X104 GND SEL30 a_6672_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X105 X VB a_10008_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X106 X VB a_1908_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X107 X VB a_138_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X108 X VB a_750_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X109 X VB a_14910_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X110 X VB a_9804_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X111 GND SEL2 a_546_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X112 X VB a_11370_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X113 GND SEL0 a_138_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X114 GND SEL109 a_24168_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X115 X VB a_6264_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X116 X VB a_27504_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X117 GND SEL21 a_4698_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X118 GND SEL120 a_26688_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X119 X VB a_23964_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X120 GND SEL19 a_4290_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X121 GND SEL103 a_22806_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X122 GND SEL81 a_18042_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X123 GND SEL44 a_9804_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X124 X VB a_16476_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X125 GND SEL52 a_11574_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X126 X VB a_4902_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X127 GND SEL126 a_27912_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X128 X VB a_15114_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X129 X VB a_1362_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X130 X VB a_22602_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X131 GND SEL10 a_2316_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X132 GND SEL75 a_16680_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X133 GND SEL72 a_16068_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X134 GND SEL33 a_7422_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X135 X VB a_2112_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X136 GND SEL92 a_20424_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X137 GND SEL117 a_25938_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X138 GND SEL55 a_12186_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X139 X VB a_11574_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X140 X VB a_27708_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X141 GND SEL66 a_14706_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X142 X VB a_6468_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X143 GND SEL115 a_25530_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X144 X VB a_10212_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X145 GND SEL26 a_5856_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X146 X VB a_5106_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X147 X VB a_24168_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X148 GND SEL89 a_19812_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X149 GND SEL78 a_17292_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X150 X VB a_7218_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X151 X VB a_18042_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X152 GND SEL38 a_8442_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X153 GND SEL36 a_8034_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X154 GND SEL95 a_21036_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X155 X VB a_15318_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X156 GND SEL80 a_17838_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X157 GND SEL69 a_15318_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X158 X VB a_1566_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X159 X VB a_22806_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X160 GND SEL4 a_954_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X161 GND SEL29 a_6468_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X162 X VB a_3678_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X163 X VB a_24918_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X164 X VB a_16680_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X165 GND SEL27 a_6060_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X166 GND SEL48 a_10758_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X167 X VB a_2316_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X168 X VB a_21378_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X169 X VB a_13140_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X170 GND SEL111 a_24576_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X171 GND SEL97 a_21582_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X172 X VB a_11778_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X173 X VB a_20016_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X174 GND SEL60 a_13344_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X175 GND SEL85 a_18858_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X176 X VB a_10416_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X177 GND SEL83 a_18450_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X178 X VB a_12528_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X179 GND SEL18 a_4086_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X180 X VB a_18246_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X181 X VB a_27912_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X182 X VB a_6672_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X183 GND SEL41 a_9192_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X184 GND SEL125 a_27708_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X185 GND SEL100 a_22194_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X186 X VB a_24372_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X187 GND SEL12 a_2724_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X188 GND SEL63 a_13956_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X189 GND SEL49 a_10962_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X190 GND SEL74 a_16476_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X191 X VB a_7422_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X192 GND SEL123 a_27300_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X193 X VB a_16884_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X194 GND SEL94 a_20832_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X195 GND SEL86 a_19062_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X196 GND SEL35 a_7830_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X197 X VB a_25122_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X198 GND SEL32 a_7218_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X199 X VB a_15522_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X200 X VB a_13344_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X201 X VB a_11982_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X202 X VB a_28116_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X203 GND SEL114 a_25326_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X204 X VB a_3882_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X205 GND SEL15 a_3336_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X206 X VB a_8988_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X207 GND SEL88 a_19608_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X208 GND SEL77 a_17088_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X209 X VB a_2520_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X210 X VB a_21582_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X211 X VB a_6876_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X212 X VB a_20220_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X213 X VB a_17088_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X214 GND SEL57 a_12732_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X215 GND SEL46 a_10212_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X216 X VB a_24576_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X217 GND SEL105 a_23352_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X218 GND SEL71 a_15726_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X219 GND SEL6 a_1362_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X220 GND SEL17 a_3882_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X221 GND SEL119 a_26346_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X222 X VB a_5448_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X223 X VB a_7626_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X224 X VB a_12732_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X225 X VB a_26688_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X226 GND SEL31 a_6876_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X227 X VB a_18450_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X228 X VB a_25326_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X229 X VB a_4086_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X230 X VB a_23148_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X231 X VB a_13548_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X232 X VB a_15726_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X233 GND SEL96 a_21378_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X234 GND SEL62 a_13752_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X235 X VB a_12186_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X236 X VB a_17838_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X237 GND SEL1 a_342_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X238 GND SEL8 a_1908_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X239 GND SEL108 a_23964_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X240 X VB a_14298_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X241 GND SEL20 a_4494_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X242 GND SEL82 a_18246_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X243 X VB a_2724_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X244 X VB a_21786_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X245 X VB a_8442_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X246 GND SEL53 a_11778_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X247 X VB a_20424_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X248 GND SEL102 a_22602_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X249 GND SEL43 a_9600_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X250 X VB a_26142_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X251 GND SEL51 a_11370_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X252 GND SEL40 a_8988_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X253 GND SEL76 a_16884_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X254 X VB a_9192_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X255 X VB a_12936_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 a_18246_n392# VB 0.08024f
C1 SEL116 SEL117 0.09569f
C2 SEL116 SEL115 0.09569f
C3 SEL95 a_21036_n392# 0.0031f
C4 a_9804_n392# X 0.0562f
C5 a_17088_n392# X 0.0562f
C6 SEL114 SEL115 0.09569f
C7 SEL94 a_21036_n392# 0
C8 a_6672_n392# a_6468_n392# 0.01932f
C9 a_19062_n392# a_18858_n392# 0.01932f
C10 SEL113 SEL114 0.09569f
C11 a_9804_n392# VB 0.08024f
C12 SEL75 a_16884_n392# 0
C13 SEL112 SEL113 0.09569f
C14 SEL76 a_16884_n392# 0.0031f
C15 a_23556_n392# SEL105 0
C16 a_17088_n392# VB 0.08024f
C17 a_23556_n392# SEL106 0.0031f
C18 X a_12528_n392# 0.04207f
C19 SEL112 SEL111 0.05373f
C20 SEL110 SEL111 0.09569f
C21 X a_2316_n392# 0.0562f
C22 a_1566_n392# a_1908_n392# 0.01138f
C23 a_3882_n392# SEL17 0.0031f
C24 SEL16 a_3882_n392# 0
C25 a_23148_n392# a_23352_n392# 0.01932f
C26 a_8988_n392# a_9192_n392# 0.01932f
C27 a_12528_n392# VB 0.07335f
C28 a_2316_n392# VB 0.08024f
C29 a_16680_n392# a_16884_n392# 0.01932f
C30 SEL109 SEL110 0.09569f
C31 a_21990_n392# a_22194_n392# 0.01932f
C32 X a_22194_n392# 0.0562f
C33 a_16272_n392# a_16476_n392# 0.01932f
C34 a_7626_n392# X 0.0562f
C35 a_5856_n392# SEL26 0.0031f
C36 SEL109 SEL108 0.09569f
C37 a_22194_n392# VB 0.08024f
C38 a_5856_n392# SEL25 0
C39 a_24576_n392# SEL111 0.0031f
C40 X a_11982_n392# 0.0562f
C41 a_24576_n392# SEL110 0
C42 a_7626_n392# VB 0.08024f
C43 X a_14706_n392# 0.0562f
C44 SEL108 SEL107 0.09569f
C45 SEL83 a_18450_n392# 0.0031f
C46 a_19266_n392# SEL87 0.0031f
C47 X a_8988_n392# 0.04207f
C48 SEL82 a_18450_n392# 0
C49 SEL86 a_19266_n392# 0
C50 a_11982_n392# VB 0.08024f
C51 a_12732_n392# a_12528_n392# 0.01932f
C52 a_10416_n392# SEL47 0.0031f
C53 SEL46 a_10416_n392# 0
C54 a_14706_n392# VB 0.08024f
C55 a_11370_n392# X 0.0562f
C56 a_8988_n392# VB 0.07335f
C57 SEL21 a_4698_n392# 0.0031f
C58 SEL14 a_3336_n392# 0
C59 a_3336_n392# SEL15 0.0031f
C60 X a_7830_n392# 0.0562f
C61 SEL107 SEL106 0.09569f
C62 a_11370_n392# VB 0.08024f
C63 SEL20 a_4698_n392# 0
C64 X a_3882_n392# 0.0562f
C65 a_7830_n392# VB 0.08024f
C66 SEL48 a_10758_n392# 0.0031f
C67 a_17292_n392# SEL77 0
C68 SEL47 a_10758_n392# 0
C69 a_17292_n392# SEL78 0.0031f
C70 a_21582_n392# SEL97 0.0031f
C71 a_15114_n392# SEL68 0.0031f
C72 SEL105 SEL104 0.09569f
C73 a_10962_n392# a_10758_n392# 0.01932f
C74 a_3882_n392# VB 0.08024f
C75 SEL105 SEL106 0.09569f
C76 a_21582_n392# SEL96 0
C77 a_10008_n392# X 0.0562f
C78 SEL104 SEL103 0.05373f
C79 a_15114_n392# SEL67 0
C80 a_2520_n392# a_2724_n392# 0.01932f
C81 SEL102 SEL103 0.09569f
C82 a_23964_n392# SEL108 0.0031f
C83 a_750_n392# SEL3 0.0031f
C84 a_10008_n392# VB 0.08024f
C85 a_2928_n392# a_3132_n392# 0.01932f
C86 a_22602_n392# a_22398_n392# 0.01932f
C87 SEL101 SEL102 0.09569f
C88 SEL0 a_138_n392# 0.0031f
C89 a_23964_n392# SEL107 0
C90 X a_20424_n392# 0.0562f
C91 a_750_n392# SEL2 0
C92 a_8238_n392# a_8442_n392# 0.01932f
C93 SEL72 a_16068_n392# 0.0031f
C94 SEL42 a_9396_n392# 0.0031f
C95 X a_138_n392# 0.03199f
C96 SEL100 SEL101 0.09569f
C97 a_750_n392# X 0.0562f
C98 a_20424_n392# VB 0.08024f
C99 SEL71 a_16068_n392# 0
C100 a_9396_n392# SEL41 0
C101 SEL28 a_6264_n392# 0.0031f
C102 a_16476_n392# X 0.0562f
C103 VB a_138_n392# 0.06465f
C104 SEL27 a_6264_n392# 0
C105 a_19266_n392# a_19062_n392# 0.01932f
C106 a_6672_n392# SEL30 0.0031f
C107 a_750_n392# VB 0.08024f
C108 SEL100 SEL99 0.09569f
C109 a_21036_n392# a_21378_n392# 0.01138f
C110 a_11574_n392# SEL52 0.0031f
C111 SEL98 SEL99 0.09569f
C112 a_9600_n392# X 0.0562f
C113 a_6672_n392# SEL29 0
C114 X a_3336_n392# 0.0562f
C115 a_16476_n392# VB 0.08024f
C116 SEL97 SEL98 0.09569f
C117 SEL114 a_25326_n392# 0.0031f
C118 a_11778_n392# SEL53 0.0031f
C119 SEL5 a_1158_n392# 0.0031f
C120 a_11574_n392# SEL51 0
C121 SEL113 a_25326_n392# 0
C122 a_13548_n392# SEL61 0.0031f
C123 SEL4 a_1158_n392# 0
C124 a_5106_n392# a_4902_n392# 0.01932f
C125 SEL97 SEL96 0.09569f
C126 a_9600_n392# VB 0.08024f
C127 a_3336_n392# VB 0.08041f
C128 a_14502_n392# a_14706_n392# 0.01932f
C129 X a_5856_n392# 0.0562f
C130 a_13548_n392# SEL60 0
C131 a_11778_n392# SEL52 0
C132 a_22398_n392# X 0.0562f
C133 a_19608_n392# X 0.04207f
C134 SEL95 SEL96 0.05373f
C135 X a_4698_n392# 0.0562f
C136 SEL94 SEL95 0.09569f
C137 a_22398_n392# VB 0.08024f
C138 a_5856_n392# VB 0.08024f
C139 X a_12186_n392# 0.0562f
C140 a_19608_n392# VB 0.07335f
C141 SEL94 SEL93 0.09569f
C142 a_546_n392# SEL2 0.0031f
C143 a_546_n392# SEL1 0
C144 SEL16 a_3678_n392# 0.0031f
C145 SEL93 SEL92 0.09569f
C146 VB a_4698_n392# 0.08024f
C147 SEL15 a_3678_n392# 0
C148 a_8238_n392# a_8034_n392# 0.01932f
C149 X a_1158_n392# 0.0562f
C150 a_10212_n392# X 0.0562f
C151 SEL91 SEL92 0.09569f
C152 a_24168_n392# a_24372_n392# 0.01932f
C153 SEL7 a_1566_n392# 0.0031f
C154 SEL6 a_1566_n392# 0
C155 VB a_12186_n392# 0.08041f
C156 a_546_n392# X 0.0562f
C157 SEL91 SEL90 0.09569f
C158 a_1158_n392# VB 0.08024f
C159 a_10212_n392# VB 0.08024f
C160 a_546_n392# VB 0.08024f
C161 SEL89 SEL90 0.09569f
C162 a_342_n392# a_138_n392# 0.01932f
C163 SEL89 SEL88 0.09569f
C164 X a_1566_n392# 0.0562f
C165 a_13344_n392# a_13548_n392# 0.01932f
C166 SEL87 SEL88 0.05373f
C167 a_20016_n392# SEL90 0.0031f
C168 SEL86 SEL87 0.09569f
C169 SEL89 a_20016_n392# 0
C170 SEL85 SEL86 0.09569f
C171 a_1566_n392# VB 0.08041f
C172 SEL85 SEL84 0.09569f
C173 a_15114_n392# a_14910_n392# 0.01932f
C174 SEL84 SEL83 0.09569f
C175 a_8238_n392# SEL37 0.0031f
C176 SEL36 a_8238_n392# 0
C177 SEL14 a_3132_n392# 0.0031f
C178 a_3132_n392# SEL13 0
C179 SEL82 SEL83 0.09569f
C180 SEL82 SEL81 0.09569f
C181 a_5856_n392# a_5652_n392# 0.01932f
C182 SEL81 SEL80 0.09569f
C183 X a_3678_n392# 0.04207f
C184 a_21990_n392# a_21786_n392# 0.01932f
C185 a_9804_n392# a_10008_n392# 0.01932f
C186 a_21786_n392# X 0.0562f
C187 a_19608_n392# a_19812_n392# 0.01932f
C188 a_21582_n392# a_21378_n392# 0.01932f
C189 SEL79 SEL80 0.05373f
C190 a_23148_n392# SEL104 0.0031f
C191 SEL77 SEL78 0.09569f
C192 SEL75 SEL76 0.09569f
C193 SEL77 SEL76 0.09569f
C194 X a_23352_n392# 0.0562f
C195 SEL79 SEL78 0.09569f
C196 X a_6264_n392# 0.0562f
C197 a_23148_n392# SEL103 0
C198 X a_18858_n392# 0.0562f
C199 a_3678_n392# VB 0.07335f
C200 SEL75 SEL74 0.09569f
C201 a_21786_n392# VB 0.08024f
C202 SEL22 a_4902_n392# 0.0031f
C203 SEL21 a_4902_n392# 0
C204 a_9396_n392# a_9192_n392# 0.01932f
C205 a_23352_n392# VB 0.08024f
C206 SEL73 SEL74 0.09569f
C207 SEL73 SEL72 0.09569f
C208 a_6264_n392# VB 0.08024f
C209 a_546_n392# a_342_n392# 0.01932f
C210 a_18858_n392# VB 0.08024f
C211 a_14298_n392# SEL64 0.0031f
C212 a_14298_n392# SEL63 0
C213 a_10416_n392# X 0.0562f
C214 a_16680_n392# SEL75 0.0031f
C215 a_7626_n392# a_7830_n392# 0.01932f
C216 SEL72 SEL71 0.05373f
C217 a_6672_n392# X 0.0562f
C218 a_16680_n392# SEL74 0
C219 SEL70 SEL71 0.09569f
C220 SEL69 SEL70 0.09569f
C221 a_10416_n392# VB 0.08041f
C222 a_20628_n392# SEL93 0.0031f
C223 SEL69 SEL68 0.09569f
C224 a_7218_n392# a_7422_n392# 0.01932f
C225 a_20220_n392# SEL91 0.0031f
C226 a_20628_n392# SEL92 0
C227 a_23556_n392# a_23760_n392# 0.01932f
C228 a_6672_n392# VB 0.08024f
C229 a_9600_n392# a_9804_n392# 0.01932f
C230 a_15522_n392# SEL70 0.0031f
C231 a_15522_n392# SEL69 0
C232 a_20220_n392# SEL90 0
C233 SEL86 a_19062_n392# 0.0031f
C234 SEL67 SEL68 0.09569f
C235 SEL85 a_19062_n392# 0
C236 a_18654_n392# X 0.0562f
C237 a_24168_n392# X 0.0562f
C238 X a_3132_n392# 0.0562f
C239 a_9396_n392# X 0.0562f
C240 a_7422_n392# SEL33 0.0031f
C241 X a_10758_n392# 0.04207f
C242 a_7218_n392# a_6876_n392# 0.01138f
C243 SEL67 SEL66 0.09569f
C244 a_18654_n392# VB 0.08024f
C245 a_7422_n392# SEL32 0
C246 a_24168_n392# VB 0.08024f
C247 SEL96 a_21378_n392# 0.0031f
C248 a_2520_n392# SEL11 0.0031f
C249 SEL95 a_21378_n392# 0
C250 a_3132_n392# VB 0.08024f
C251 a_9396_n392# VB 0.08024f
C252 SEL27 a_6060_n392# 0.0031f
C253 VB a_10758_n392# 0.07335f
C254 a_20220_n392# a_20016_n392# 0.01932f
C255 X a_16884_n392# 0.0562f
C256 SEL66 SEL65 0.09569f
C257 a_15726_n392# a_16068_n392# 0.01138f
C258 a_6060_n392# SEL26 0
C259 a_2520_n392# SEL10 0
C260 SEL64 SEL65 0.09569f
C261 a_16272_n392# a_16068_n392# 0.01932f
C262 a_12936_n392# SEL58 0.0031f
C263 a_24372_n392# SEL110 0.0031f
C264 SEL31 a_6876_n392# 0.0031f
C265 a_16884_n392# VB 0.08024f
C266 a_6876_n392# SEL30 0
C267 SEL63 SEL64 0.05373f
C268 a_12528_n392# a_12186_n392# 0.01138f
C269 a_12936_n392# SEL57 0
C270 SEL62 SEL63 0.09569f
C271 SEL61 SEL62 0.09569f
C272 SEL61 SEL60 0.09569f
C273 SEL109 a_24372_n392# 0
C274 a_22398_n392# a_22194_n392# 0.01932f
C275 X a_21036_n392# 0.0562f
C276 SEL60 SEL59 0.09569f
C277 X a_4902_n392# 0.0562f
C278 a_23760_n392# SEL107 0.0031f
C279 a_21036_n392# VB 0.08041f
C280 SEL59 SEL58 0.09569f
C281 a_4902_n392# VB 0.08024f
C282 a_24576_n392# a_24372_n392# 0.01932f
C283 a_2520_n392# X 0.0562f
C284 a_11574_n392# X 0.0562f
C285 SEL127 X 0
C286 a_4290_n392# a_4494_n392# 0.01932f
C287 a_17292_n392# a_17496_n392# 0.01932f
C288 a_24918_n392# SEL111 0
C289 X SEL126 0
C290 SEL112 a_24918_n392# 0.0031f
C291 SEL125 X 0
C292 SEL124 X 0
C293 a_11982_n392# a_12186_n392# 0.01932f
C294 a_23760_n392# SEL106 0
C295 SEL113 a_25122_n392# 0.0031f
C296 a_2520_n392# VB 0.08024f
C297 SEL57 SEL58 0.09569f
C298 SEL112 a_25122_n392# 0
C299 a_11574_n392# VB 0.08024f
C300 a_18450_n392# X 0.0562f
C301 SEL127 VB 0.01474f
C302 SEL127 a_28116_n392# 0.0031f
C303 SEL123 X 0
C304 a_11778_n392# X 0.0562f
C305 SEL126 VB 0.01474f
C306 SEL126 a_28116_n392# 0
C307 SEL125 VB 0.01474f
C308 X SEL122 0
C309 SEL126 a_27912_n392# 0.0031f
C310 SEL124 VB 0.01474f
C311 SEL125 a_27912_n392# 0
C312 a_27708_n392# SEL125 0.0031f
C313 a_15114_n392# X 0.0562f
C314 X a_19266_n392# 0.0562f
C315 SEL55 SEL56 0.05373f
C316 SEL56 SEL57 0.09569f
C317 a_27708_n392# SEL124 0
C318 a_18450_n392# VB 0.08024f
C319 X a_8238_n392# 0.0562f
C320 SEL123 VB 0.01474f
C321 a_11778_n392# VB 0.08024f
C322 a_11166_n392# SEL50 0.0031f
C323 SEL124 a_27504_n392# 0.0031f
C324 SEL55 SEL54 0.09569f
C325 a_11166_n392# SEL49 0
C326 SEL122 VB 0.01474f
C327 SEL121 X 0
C328 a_23556_n392# X 0.0562f
C329 X SEL120 0
C330 a_15114_n392# VB 0.08024f
C331 a_19266_n392# VB 0.08041f
C332 X SEL119 0
C333 SEL123 a_27504_n392# 0
C334 a_11166_n392# a_10962_n392# 0.01932f
C335 a_21036_n392# a_20832_n392# 0.01932f
C336 SEL123 a_27300_n392# 0.0031f
C337 a_13344_n392# SEL60 0.0031f
C338 a_17292_n392# X 0.0562f
C339 a_8238_n392# VB 0.08024f
C340 X SEL118 0
C341 SEL122 a_27300_n392# 0
C342 SEL54 SEL53 0.09569f
C343 a_13344_n392# SEL59 0
C344 a_24576_n392# a_24918_n392# 0.01138f
C345 SEL121 VB 0.01474f
C346 VB SEL120 0.01474f
C347 a_23556_n392# VB 0.08024f
C348 SEL122 a_27096_n392# 0.0031f
C349 a_23964_n392# a_23760_n392# 0.01932f
C350 SEL119 VB 0.01474f
C351 a_17292_n392# VB 0.08024f
C352 SEL118 VB 0.01474f
C353 SEL53 SEL52 0.09569f
C354 a_13548_n392# X 0.0562f
C355 a_2724_n392# a_2928_n392# 0.01932f
C356 X a_16068_n392# 0.04207f
C357 SEL121 a_26892_n392# 0.0031f
C358 a_26892_n392# SEL120 0
C359 SEL121 a_27096_n392# 0
C360 SEL67 a_14910_n392# 0.0031f
C361 a_26688_n392# SEL120 0.0031f
C362 SEL6 a_1362_n392# 0.0031f
C363 SEL5 a_1362_n392# 0
C364 a_26688_n392# SEL119 0
C365 SEL117 X 0
C366 a_26346_n392# SEL119 0.0031f
C367 a_15114_n392# a_15318_n392# 0.01932f
C368 a_13548_n392# VB 0.08024f
C369 a_10212_n392# a_10008_n392# 0.01932f
C370 SEL116 X 0
C371 X SEL115 0
C372 SEL66 a_14910_n392# 0
C373 SEL118 a_26346_n392# 0
C374 SEL52 SEL51 0.09569f
C375 a_16068_n392# VB 0.07335f
C376 X a_6060_n392# 0.0562f
C377 X SEL114 0
C378 SEL118 a_26142_n392# 0.0031f
C379 SEL38 a_8442_n392# 0.0031f
C380 SEL113 X 0
C381 SEL112 X 0
C382 SEL117 VB 0.01474f
C383 a_8442_n392# SEL37 0
C384 a_5448_n392# a_5106_n392# 0.01138f
C385 X SEL111 0
C386 SEL50 SEL51 0.09569f
C387 SEL116 VB 0.01474f
C388 SEL115 VB 0.01474f
C389 X SEL110 0
C390 a_22602_n392# SEL102 0.0031f
C391 SEL20 a_4494_n392# 0.0031f
C392 SEL49 SEL50 0.09569f
C393 a_22602_n392# SEL101 0
C394 a_6060_n392# VB 0.08024f
C395 SEL114 VB 0.01474f
C396 SEL48 SEL49 0.09569f
C397 SEL113 VB 0.01474f
C398 SEL112 VB 0.01474f
C399 a_7422_n392# X 0.0562f
C400 VB SEL111 0.01474f
C401 SEL48 SEL47 0.05373f
C402 SEL19 a_4494_n392# 0
C403 SEL49 a_10962_n392# 0.0031f
C404 X a_1362_n392# 0.0562f
C405 a_21582_n392# X 0.0562f
C406 SEL110 VB 0.01474f
C407 SEL46 SEL47 0.09569f
C408 SEL48 a_10962_n392# 0
C409 SEL109 X 0
C410 SEL108 X 0
C411 a_13548_n392# a_13752_n392# 0.01932f
C412 SEL117 a_26142_n392# 0
C413 a_750_n392# a_546_n392# 0.01932f
C414 a_6468_n392# SEL29 0.0031f
C415 a_7422_n392# VB 0.08024f
C416 SEL4 a_954_n392# 0.0031f
C417 SEL46 SEL45 0.09569f
C418 SEL107 X 0
C419 a_1362_n392# VB 0.08024f
C420 a_21582_n392# VB 0.08024f
C421 a_25938_n392# SEL117 0.0031f
C422 a_17088_n392# a_16884_n392# 0.01932f
C423 SEL116 a_25734_n392# 0.0031f
C424 a_25734_n392# SEL115 0
C425 X a_6876_n392# 0.0562f
C426 a_25938_n392# SEL116 0
C427 SEL28 a_6468_n392# 0
C428 SEL108 VB 0.01474f
C429 SEL109 VB 0.01474f
C430 a_15726_n392# SEL71 0.0031f
C431 a_16272_n392# SEL73 0.0031f
C432 SEL3 a_954_n392# 0
C433 a_16272_n392# SEL72 0
C434 a_15726_n392# SEL70 0
C435 SEL107 VB 0.01474f
C436 a_25530_n392# SEL115 0.0031f
C437 a_24576_n392# X 0.0562f
C438 a_15522_n392# a_15726_n392# 0.01932f
C439 SEL44 SEL45 0.09569f
C440 a_6876_n392# VB 0.08041f
C441 X SEL104 0
C442 a_25530_n392# SEL114 0
C443 a_3882_n392# a_3678_n392# 0.01932f
C444 SEL106 X 0
C445 SEL105 X 0
C446 X SEL103 0
C447 SEL44 SEL43 0.09569f
C448 X a_954_n392# 0.0562f
C449 X SEL102 0
C450 a_24576_n392# VB 0.08041f
C451 a_8646_n392# a_8442_n392# 0.01932f
C452 X SEL101 0
C453 SEL104 VB 0.01474f
C454 a_18042_n392# SEL81 0.0031f
C455 SEL106 VB 0.01474f
C456 SEL105 VB 0.01474f
C457 a_4290_n392# a_4086_n392# 0.01932f
C458 SEL36 a_8034_n392# 0.0031f
C459 a_18042_n392# SEL80 0
C460 SEL103 VB 0.01474f
C461 SEL42 SEL43 0.09569f
C462 a_954_n392# VB 0.08024f
C463 SEL102 VB 0.01474f
C464 a_8034_n392# SEL35 0
C465 a_21990_n392# SEL99 0.0031f
C466 SEL101 VB 0.01474f
C467 X SEL100 0
C468 a_18450_n392# a_18246_n392# 0.01932f
C469 a_21990_n392# SEL98 0
C470 X SEL99 0
C471 SEL98 X 0
C472 a_22806_n392# SEL103 0.0031f
C473 SEL97 X 0
C474 a_22806_n392# SEL102 0
C475 X SEL96 0
C476 SEL100 VB 0.01474f
C477 SEL95 X 0
C478 SEL99 VB 0.01474f
C479 SEL42 SEL41 0.09569f
C480 SEL98 VB 0.01474f
C481 a_25122_n392# a_25326_n392# 0.01932f
C482 a_23964_n392# X 0.0562f
C483 SEL97 VB 0.01474f
C484 X SEL93 0
C485 SEL94 X 0
C486 X SEL92 0
C487 a_17496_n392# SEL78 0
C488 SEL79 a_17496_n392# 0.0031f
C489 SEL91 X 0
C490 SEL96 VB 0.01474f
C491 X a_4494_n392# 0.0562f
C492 SEL95 VB 0.01474f
C493 a_17838_n392# SEL80 0.0031f
C494 X SEL90 0
C495 a_2520_n392# a_2316_n392# 0.01932f
C496 a_23964_n392# VB 0.08024f
C497 SEL79 a_17838_n392# 0
C498 SEL40 SEL41 0.09569f
C499 SEL93 VB 0.01474f
C500 SEL94 VB 0.01474f
C501 SEL24 a_5448_n392# 0.0031f
C502 SEL89 X 0
C503 SEL92 VB 0.01474f
C504 a_5448_n392# SEL23 0
C505 SEL91 VB 0.01474f
C506 X a_14298_n392# 0.04207f
C507 a_4494_n392# VB 0.08024f
C508 a_3336_n392# a_3678_n392# 0.01138f
C509 X SEL88 0
C510 X SEL87 0
C511 SEL90 VB 0.01474f
C512 a_2724_n392# SEL12 0.0031f
C513 SEL40 SEL39 0.05373f
C514 SEL86 X 0
C515 SEL38 SEL39 0.09569f
C516 SEL85 X 0
C517 SEL89 VB 0.01474f
C518 SEL84 X 0
C519 SEL38 SEL37 0.09569f
C520 SEL83 X 0
C521 a_14298_n392# VB 0.07335f
C522 a_17088_n392# a_17292_n392# 0.01932f
C523 SEL36 SEL37 0.09569f
C524 SEL82 X 0
C525 SEL88 VB 0.01474f
C526 a_2724_n392# SEL11 0
C527 X SEL81 0
C528 SEL87 VB 0.01474f
C529 X a_20016_n392# 0.0562f
C530 SEL86 VB 0.01474f
C531 SEL85 VB 0.01474f
C532 X SEL80 0
C533 SEL36 SEL35 0.09569f
C534 a_7218_n392# SEL32 0.0031f
C535 X SEL77 0
C536 a_14298_n392# a_13956_n392# 0.01138f
C537 X SEL75 0
C538 SEL84 VB 0.01474f
C539 X SEL78 0
C540 SEL79 X 0
C541 X SEL76 0
C542 a_7218_n392# SEL31 0
C543 SEL83 VB 0.01474f
C544 SEL34 SEL35 0.09569f
C545 SEL82 VB 0.01474f
C546 SEL81 VB 0.01474f
C547 a_20016_n392# VB 0.08024f
C548 X SEL74 0
C549 X SEL73 0
C550 X SEL72 0
C551 SEL34 SEL33 0.09569f
C552 SEL23 a_5106_n392# 0.0031f
C553 SEL80 VB 0.01474f
C554 SEL77 VB 0.01474f
C555 SEL75 VB 0.01474f
C556 SEL79 VB 0.01474f
C557 SEL78 VB 0.01474f
C558 SEL76 VB 0.01474f
C559 X SEL71 0
C560 SEL93 a_20832_n392# 0
C561 SEL94 a_20832_n392# 0.0031f
C562 SEL69 X 0
C563 SEL33 SEL32 0.09569f
C564 SEL22 a_5106_n392# 0
C565 X SEL70 0
C566 a_12936_n392# X 0.0562f
C567 SEL74 VB 0.01474f
C568 SEL68 X 0
C569 SEL73 VB 0.01474f
C570 SEL72 VB 0.01474f
C571 a_11778_n392# a_11982_n392# 0.01932f
C572 a_16680_n392# X 0.0562f
C573 X a_25326_n392# 0.0562f
C574 SEL67 X 0
C575 a_15522_n392# X 0.0562f
C576 a_4086_n392# SEL18 0.0031f
C577 a_11370_n392# a_11574_n392# 0.01932f
C578 SEL31 SEL32 0.05373f
C579 SEL71 VB 0.01474f
C580 SEL69 VB 0.01474f
C581 SEL70 VB 0.01474f
C582 a_12936_n392# VB 0.08024f
C583 a_2112_n392# a_1908_n392# 0.01932f
C584 a_4086_n392# SEL17 0
C585 SEL31 SEL30 0.09569f
C586 SEL66 X 0
C587 SEL68 VB 0.01474f
C588 a_16680_n392# VB 0.08024f
C589 a_25326_n392# VB 0.08024f
C590 X a_6468_n392# 0.0562f
C591 SEL67 VB 0.01474f
C592 a_15522_n392# VB 0.08024f
C593 X SEL65 0
C594 a_9600_n392# a_9396_n392# 0.01932f
C595 SEL29 SEL30 0.09569f
C596 a_3336_n392# a_3132_n392# 0.01932f
C597 X a_8442_n392# 0.0562f
C598 X SEL64 0
C599 a_8646_n392# SEL39 0.0031f
C600 a_8646_n392# SEL38 0
C601 X SEL63 0
C602 a_10212_n392# a_10416_n392# 0.01932f
C603 SEL61 X 0
C604 SEL62 X 0
C605 SEL66 VB 0.01474f
C606 a_11166_n392# X 0.0562f
C607 SEL65 VB 0.01474f
C608 a_6468_n392# VB 0.08024f
C609 a_2724_n392# X 0.0562f
C610 X SEL60 0
C611 a_8442_n392# VB 0.08024f
C612 SEL64 VB 0.01474f
C613 X SEL59 0
C614 SEL28 SEL29 0.09569f
C615 a_2928_n392# SEL13 0.0031f
C616 SEL63 VB 0.01474f
C617 a_2928_n392# SEL12 0
C618 SEL62 VB 0.01474f
C619 SEL61 VB 0.01474f
C620 a_11166_n392# VB 0.08024f
C621 X a_19062_n392# 0.0562f
C622 SEL69 a_15318_n392# 0.0031f
C623 X SEL58 0
C624 SEL60 VB 0.01474f
C625 a_2724_n392# VB 0.08024f
C626 SEL63 a_13956_n392# 0.0031f
C627 SEL62 a_13956_n392# 0
C628 SEL68 a_15318_n392# 0
C629 SEL59 VB 0.01474f
C630 SEL27 SEL28 0.09569f
C631 SEL89 a_19812_n392# 0.0031f
C632 a_15522_n392# a_15318_n392# 0.01932f
C633 SEL55 X 0
C634 X SEL57 0
C635 a_25530_n392# a_25326_n392# 0.01932f
C636 a_12936_n392# a_12732_n392# 0.01932f
C637 a_19062_n392# VB 0.08024f
C638 a_20220_n392# X 0.0562f
C639 SEL56 X 0
C640 SEL88 a_19812_n392# 0
C641 SEL58 VB 0.01474f
C642 X a_20628_n392# 0.0562f
C643 SEL54 X 0
C644 SEL27 SEL26 0.09569f
C645 SEL19 a_4290_n392# 0.0031f
C646 a_13140_n392# a_12936_n392# 0.01932f
C647 a_4290_n392# SEL18 0
C648 a_23148_n392# X 0.04207f
C649 a_5448_n392# X 0.04207f
C650 SEL57 VB 0.01474f
C651 SEL55 VB 0.01474f
C652 X SEL53 0
C653 a_20220_n392# VB 0.08024f
C654 SEL8 a_1908_n392# 0.0031f
C655 SEL56 VB 0.01474f
C656 a_14298_n392# a_14502_n392# 0.01932f
C657 SEL7 a_1908_n392# 0
C658 SEL61 a_13752_n392# 0
C659 SEL62 a_13752_n392# 0.0031f
C660 a_20628_n392# VB 0.08024f
C661 a_20016_n392# a_19812_n392# 0.01932f
C662 SEL54 VB 0.01474f
C663 SEL26 SEL25 0.09569f
C664 X SEL52 0
C665 a_7422_n392# a_7626_n392# 0.01932f
C666 a_23148_n392# VB 0.07335f
C667 a_5448_n392# VB 0.07335f
C668 SEL53 VB 0.01474f
C669 X SEL51 0
C670 X a_8034_n392# 0.0562f
C671 X SEL50 0
C672 SEL24 SEL25 0.09569f
C673 X SEL49 0
C674 SEL52 VB 0.01474f
C675 X a_4086_n392# 0.0562f
C676 a_9192_n392# SEL41 0.0031f
C677 SEL48 X 0
C678 a_23148_n392# a_22806_n392# 0.01138f
C679 a_13344_n392# X 0.0562f
C680 X SEL47 0
C681 SEL46 X 0
C682 X a_21378_n392# 0.04207f
C683 SEL24 SEL23 0.05373f
C684 X a_10962_n392# 0.0562f
C685 SEL51 VB 0.01474f
C686 a_8034_n392# VB 0.08024f
C687 SEL50 VB 0.01474f
C688 SEL40 a_9192_n392# 0
C689 SEL49 VB 0.01474f
C690 a_4902_n392# a_4698_n392# 0.01932f
C691 a_4086_n392# VB 0.08024f
C692 X a_5106_n392# 0.0562f
C693 a_13140_n392# SEL59 0.0031f
C694 SEL45 X 0
C695 SEL48 VB 0.01474f
C696 X a_1908_n392# 0.04207f
C697 SEL23 SEL22 0.09569f
C698 a_13344_n392# VB 0.08024f
C699 SEL47 VB 0.01474f
C700 SEL46 VB 0.01474f
C701 a_21378_n392# VB 0.07335f
C702 a_13140_n392# SEL58 0
C703 SEL44 X 0
C704 a_10962_n392# VB 0.08024f
C705 a_12732_n392# SEL57 0.0031f
C706 a_2928_n392# X 0.0562f
C707 X SEL43 0
C708 SEL82 a_18246_n392# 0.0031f
C709 SEL56 a_12732_n392# 0
C710 SEL81 a_18246_n392# 0
C711 a_5106_n392# VB 0.08041f
C712 SEL45 VB 0.01474f
C713 a_1908_n392# VB 0.07335f
C714 a_20628_n392# a_20832_n392# 0.01932f
C715 SEL22 SEL21 0.09569f
C716 SEL42 X 0
C717 SEL44 VB 0.01474f
C718 a_2928_n392# VB 0.08024f
C719 SEL43 VB 0.01474f
C720 SEL100 a_22194_n392# 0.0031f
C721 SEL99 a_22194_n392# 0
C722 SEL20 SEL21 0.09569f
C723 X SEL41 0
C724 a_14502_n392# SEL65 0.0031f
C725 a_19608_n392# a_19266_n392# 0.01138f
C726 SEL42 VB 0.01474f
C727 a_14502_n392# SEL64 0
C728 a_7218_n392# X 0.04207f
C729 a_18654_n392# a_18858_n392# 0.01932f
C730 SEL40 X 0
C731 X SEL39 0
C732 X SEL38 0
C733 X a_4290_n392# 0.0562f
C734 SEL41 VB 0.01474f
C735 X a_14910_n392# 0.0562f
C736 a_17088_n392# SEL77 0.0031f
C737 a_17088_n392# SEL76 0
C738 SEL36 X 0
C739 X SEL37 0
C740 SEL20 SEL19 0.09569f
C741 a_7218_n392# VB 0.07335f
C742 X SEL35 0
C743 SEL40 VB 0.01474f
C744 SEL34 X 0
C745 SEL39 VB 0.01474f
C746 SEL33 X 0
C747 SEL38 VB 0.01474f
C748 a_4290_n392# VB 0.08024f
C749 a_5448_n392# a_5652_n392# 0.01932f
C750 a_13140_n392# a_13344_n392# 0.01932f
C751 a_14910_n392# VB 0.08024f
C752 VB SEL37 0.01474f
C753 SEL36 VB 0.01474f
C754 SEL19 SEL18 0.09569f
C755 X SEL32 0
C756 a_10416_n392# a_10758_n392# 0.01138f
C757 SEL17 SEL18 0.09569f
C758 SEL35 VB 0.01474f
C759 SEL31 X 0
C760 X SEL30 0
C761 SEL34 VB 0.01474f
C762 SEL33 VB 0.01474f
C763 SEL16 SEL17 0.09569f
C764 SEL16 SEL15 0.05373f
C765 SEL14 SEL15 0.09569f
C766 a_25122_n392# a_24918_n392# 0.01932f
C767 SEL14 SEL13 0.09569f
C768 X SEL29 0
C769 SEL13 SEL12 0.09569f
C770 SEL32 VB 0.01474f
C771 SEL31 VB 0.01474f
C772 VB SEL30 0.01474f
C773 a_5856_n392# a_6060_n392# 0.01932f
C774 X SEL28 0
C775 SEL29 VB 0.01474f
C776 SEL12 SEL11 0.09569f
C777 SEL27 X 0
C778 SEL9 a_2112_n392# 0.0031f
C779 SEL8 a_2112_n392# 0
C780 X a_24372_n392# 0.0562f
C781 X SEL26 0
C782 SEL28 VB 0.01474f
C783 X SEL25 0
C784 SEL27 VB 0.01474f
C785 a_23760_n392# X 0.0562f
C786 X a_8646_n392# 0.0562f
C787 SEL24 X 0
C788 X a_15726_n392# 0.0562f
C789 a_24372_n392# VB 0.08024f
C790 a_750_n392# a_954_n392# 0.01932f
C791 SEL26 VB 0.01474f
C792 SEL23 X 0
C793 SEL25 VB 0.01474f
C794 SEL10 SEL11 0.09569f
C795 a_23760_n392# VB 0.08024f
C796 a_16272_n392# X 0.0562f
C797 a_8646_n392# VB 0.08041f
C798 SEL22 X 0
C799 SEL24 VB 0.01474f
C800 a_15726_n392# VB 0.08041f
C801 X SEL21 0
C802 SEL23 VB 0.01474f
C803 a_17838_n392# a_18042_n392# 0.01932f
C804 a_1158_n392# a_1362_n392# 0.01932f
C805 a_2112_n392# X 0.0562f
C806 a_16272_n392# VB 0.08024f
C807 SEL20 X 0
C808 SEL22 VB 0.01474f
C809 SEL92 a_20424_n392# 0.0031f
C810 SEL55 a_12528_n392# 0
C811 SEL21 VB 0.01474f
C812 SEL91 a_20424_n392# 0
C813 SEL56 a_12528_n392# 0.0031f
C814 SEL9 SEL10 0.09569f
C815 SEL19 X 0
C816 a_2112_n392# VB 0.08024f
C817 X SEL18 0
C818 X a_24918_n392# 0.04207f
C819 SEL20 VB 0.01474f
C820 SEL66 a_14706_n392# 0.0031f
C821 SEL16 X 0
C822 a_23556_n392# a_23352_n392# 0.01932f
C823 X SEL17 0
C824 X SEL15 0
C825 a_22398_n392# SEL101 0.0031f
C826 SEL14 X 0
C827 X SEL13 0
C828 a_14706_n392# SEL65 0
C829 SEL9 SEL8 0.09569f
C830 X SEL12 0
C831 a_17496_n392# a_17838_n392# 0.01138f
C832 X a_25122_n392# 0.0562f
C833 SEL8 SEL7 0.05373f
C834 SEL19 VB 0.01474f
C835 SEL18 VB 0.01474f
C836 a_24918_n392# VB 0.07335f
C837 a_18042_n392# X 0.0562f
C838 SEL6 SEL7 0.09569f
C839 SEL16 VB 0.01474f
C840 SEL5 SEL6 0.09569f
C841 SEL17 VB 0.01474f
C842 X SEL11 0
C843 a_22398_n392# SEL100 0
C844 SEL14 VB 0.01474f
C845 SEL13 VB 0.01474f
C846 SEL15 VB 0.01474f
C847 SEL12 VB 0.01474f
C848 a_1362_n392# a_1566_n392# 0.01932f
C849 SEL4 SEL5 0.09569f
C850 a_25122_n392# VB 0.08024f
C851 a_1158_n392# a_954_n392# 0.01932f
C852 a_18042_n392# VB 0.08024f
C853 a_22602_n392# X 0.0562f
C854 a_9804_n392# SEL44 0.0031f
C855 a_11370_n392# a_11166_n392# 0.01932f
C856 a_18450_n392# a_18654_n392# 0.01932f
C857 a_9804_n392# SEL43 0
C858 SEL11 VB 0.01474f
C859 X SEL10 0
C860 SEL4 SEL3 0.09569f
C861 X a_9192_n392# 0.0562f
C862 a_17496_n392# X 0.0562f
C863 a_22602_n392# VB 0.08024f
C864 SEL54 a_11982_n392# 0.0031f
C865 SEL9 X 0
C866 SEL8 X 0
C867 X SEL7 0
C868 SEL10 VB 0.01474f
C869 X SEL6 0
C870 a_17838_n392# X 0.04207f
C871 a_5652_n392# SEL25 0.0031f
C872 a_6060_n392# a_6264_n392# 0.01932f
C873 SEL5 X 0
C874 a_11982_n392# SEL53 0
C875 a_9192_n392# VB 0.08024f
C876 a_4494_n392# a_4698_n392# 0.01932f
C877 SEL3 SEL2 0.09569f
C878 SEL4 X 0
C879 a_17496_n392# VB 0.08041f
C880 a_22602_n392# a_22806_n392# 0.01932f
C881 SEL24 a_5652_n392# 0
C882 SEL9 VB 0.01474f
C883 SEL8 VB 0.01474f
C884 SEL7 VB 0.01474f
C885 a_16476_n392# SEL74 0.0031f
C886 X SEL3 0
C887 a_17838_n392# VB 0.07335f
C888 SEL6 VB 0.01474f
C889 SEL1 SEL2 0.09569f
C890 a_16476_n392# SEL73 0
C891 a_19608_n392# SEL87 0
C892 a_19608_n392# SEL88 0.0031f
C893 SEL5 VB 0.01474f
C894 SEL0 SEL1 0.09569f
C895 a_21582_n392# a_21786_n392# 0.01932f
C896 SEL4 VB 0.01474f
C897 X SEL2 0
C898 X SEL1 0
C899 SEL0 X 0
C900 SEL3 VB 0.01474f
C901 a_21990_n392# X 0.0562f
C902 a_16680_n392# a_16476_n392# 0.01932f
C903 SEL2 VB 0.01474f
C904 SEL1 VB 0.01474f
C905 SEL0 VB 0.01474f
C906 a_11370_n392# SEL51 0.0031f
C907 a_11370_n392# SEL50 0
C908 a_21990_n392# VB 0.08024f
C909 X a_28116_n392# 0.0562f
C910 X VB 6.84006f
C911 X a_27912_n392# 0.0562f
C912 a_27708_n392# X 0.0562f
C913 SEL127 SEL126 0.09569f
C914 SEL104 a_23352_n392# 0
C915 a_7830_n392# a_8034_n392# 0.01932f
C916 SEL105 a_23352_n392# 0.0031f
C917 a_27504_n392# X 0.0562f
C918 X a_13956_n392# 0.0562f
C919 SEL125 SEL126 0.09569f
C920 X a_27300_n392# 0.0562f
C921 X a_22806_n392# 0.0562f
C922 a_28116_n392# VB 0.08036f
C923 SEL124 SEL125 0.09569f
C924 a_26892_n392# X 0.0562f
C925 a_27912_n392# VB 0.08024f
C926 X a_27096_n392# 0.0562f
C927 a_27708_n392# VB 0.08024f
C928 a_27912_n392# a_28116_n392# 0.01932f
C929 a_3882_n392# a_4086_n392# 0.01932f
C930 a_6672_n392# a_6876_n392# 0.01932f
C931 a_26688_n392# X 0.04207f
C932 a_20220_n392# a_20424_n392# 0.01932f
C933 X a_26346_n392# 0.0562f
C934 a_11574_n392# a_11778_n392# 0.01932f
C935 a_27708_n392# a_27912_n392# 0.01932f
C936 a_20628_n392# a_20424_n392# 0.01932f
C937 a_27504_n392# VB 0.08024f
C938 a_13956_n392# VB 0.08041f
C939 X a_26142_n392# 0.0562f
C940 a_27300_n392# VB 0.08024f
C941 SEL124 SEL123 0.09569f
C942 a_22806_n392# VB 0.08041f
C943 a_27708_n392# a_27504_n392# 0.01932f
C944 X a_25734_n392# 0.0562f
C945 SEL109 a_24168_n392# 0.0031f
C946 SEL98 a_21786_n392# 0.0031f
C947 a_24168_n392# SEL108 0
C948 a_25938_n392# X 0.0562f
C949 a_26892_n392# VB 0.08024f
C950 a_27096_n392# VB 0.08024f
C951 a_26688_n392# VB 0.07335f
C952 X a_13752_n392# 0.0562f
C953 a_26346_n392# VB 0.08041f
C954 SEL97 a_21786_n392# 0
C955 SEL34 a_7626_n392# 0.0031f
C956 X a_15318_n392# 0.0562f
C957 a_27504_n392# a_27300_n392# 0.01932f
C958 SEL123 SEL122 0.09569f
C959 a_7626_n392# SEL33 0
C960 a_25530_n392# X 0.0562f
C961 a_26142_n392# VB 0.08024f
C962 a_14910_n392# a_14706_n392# 0.01932f
C963 SEL40 a_8988_n392# 0.0031f
C964 a_25734_n392# VB 0.08024f
C965 a_8988_n392# SEL39 0
C966 a_25938_n392# VB 0.08024f
C967 a_27096_n392# a_27300_n392# 0.01932f
C968 X a_12732_n392# 0.0562f
C969 a_13752_n392# VB 0.08024f
C970 a_10008_n392# SEL45 0.0031f
C971 X a_20832_n392# 0.0562f
C972 a_15318_n392# VB 0.08024f
C973 a_26892_n392# a_27096_n392# 0.01932f
C974 a_26688_n392# a_26892_n392# 0.01932f
C975 a_26688_n392# a_26346_n392# 0.01138f
C976 a_25530_n392# VB 0.08024f
C977 a_13752_n392# a_13956_n392# 0.01932f
C978 SEL44 a_10008_n392# 0
C979 a_13140_n392# X 0.0562f
C980 SEL121 SEL122 0.09569f
C981 a_26142_n392# a_26346_n392# 0.01932f
C982 a_12732_n392# VB 0.08024f
C983 a_20832_n392# VB 0.08024f
C984 a_18042_n392# a_18246_n392# 0.01932f
C985 a_13140_n392# VB 0.08024f
C986 a_25938_n392# a_26142_n392# 0.01932f
C987 a_342_n392# SEL1 0.0031f
C988 a_25938_n392# a_25734_n392# 0.01932f
C989 SEL121 SEL120 0.09569f
C990 SEL0 a_342_n392# 0
C991 a_7830_n392# SEL35 0.0031f
C992 SEL119 SEL120 0.05373f
C993 SEL34 a_7830_n392# 0
C994 X a_5652_n392# 0.0562f
C995 SEL55 a_12186_n392# 0.0031f
C996 a_342_n392# X 0.0562f
C997 a_2112_n392# a_2316_n392# 0.01932f
C998 a_25530_n392# a_25734_n392# 0.01932f
C999 SEL85 a_18858_n392# 0.0031f
C1000 SEL118 SEL119 0.09569f
C1001 SEL54 a_12186_n392# 0
C1002 SEL84 a_18858_n392# 0
C1003 X a_19812_n392# 0.0562f
C1004 a_5652_n392# VB 0.08024f
C1005 a_342_n392# VB 0.08024f
C1006 a_23964_n392# a_24168_n392# 0.01932f
C1007 VB a_19812_n392# 0.08024f
C1008 X a_14502_n392# 0.0562f
C1009 a_9600_n392# SEL43 0.0031f
C1010 a_8646_n392# a_8988_n392# 0.01138f
C1011 a_14502_n392# VB 0.08024f
C1012 SEL117 SEL118 0.09569f
C1013 a_9600_n392# SEL42 0
C1014 SEL46 a_10212_n392# 0.0031f
C1015 SEL10 a_2316_n392# 0.0031f
C1016 SEL84 a_18654_n392# 0.0031f
C1017 X a_18246_n392# 0.0562f
C1018 SEL83 a_18654_n392# 0
C1019 a_10212_n392# SEL45 0
C1020 SEL9 a_2316_n392# 0
C1021 a_6264_n392# a_6468_n392# 0.01932f
C1022 SEL127 GND 0.31454f
C1023 SEL126 GND 0.24626f
C1024 SEL125 GND 0.24626f
C1025 SEL124 GND 0.24626f
C1026 SEL123 GND 0.24626f
C1027 SEL122 GND 0.24626f
C1028 SEL121 GND 0.24626f
C1029 SEL120 GND 0.26331f
C1030 SEL119 GND 0.26337f
C1031 SEL118 GND 0.24626f
C1032 SEL117 GND 0.24626f
C1033 SEL116 GND 0.24626f
C1034 SEL115 GND 0.24626f
C1035 SEL114 GND 0.24626f
C1036 SEL113 GND 0.24626f
C1037 SEL112 GND 0.26331f
C1038 SEL111 GND 0.26337f
C1039 SEL110 GND 0.24626f
C1040 SEL109 GND 0.24626f
C1041 SEL108 GND 0.24626f
C1042 SEL107 GND 0.24626f
C1043 SEL106 GND 0.24626f
C1044 SEL105 GND 0.24626f
C1045 SEL104 GND 0.26331f
C1046 SEL103 GND 0.26337f
C1047 SEL102 GND 0.24626f
C1048 SEL101 GND 0.24626f
C1049 SEL100 GND 0.24626f
C1050 SEL99 GND 0.24626f
C1051 SEL98 GND 0.24626f
C1052 SEL97 GND 0.24626f
C1053 SEL96 GND 0.26331f
C1054 SEL95 GND 0.26337f
C1055 SEL94 GND 0.24626f
C1056 SEL93 GND 0.24626f
C1057 SEL92 GND 0.24626f
C1058 SEL91 GND 0.24626f
C1059 SEL90 GND 0.24626f
C1060 SEL89 GND 0.24626f
C1061 SEL88 GND 0.26331f
C1062 SEL87 GND 0.26337f
C1063 SEL86 GND 0.24626f
C1064 SEL85 GND 0.24626f
C1065 SEL84 GND 0.24626f
C1066 SEL83 GND 0.24626f
C1067 SEL82 GND 0.24626f
C1068 SEL81 GND 0.24626f
C1069 SEL80 GND 0.26331f
C1070 SEL79 GND 0.26337f
C1071 SEL78 GND 0.24626f
C1072 SEL77 GND 0.24626f
C1073 SEL76 GND 0.24626f
C1074 SEL75 GND 0.24626f
C1075 SEL74 GND 0.24626f
C1076 SEL73 GND 0.24626f
C1077 SEL72 GND 0.26331f
C1078 SEL71 GND 0.26337f
C1079 SEL70 GND 0.24626f
C1080 SEL69 GND 0.24626f
C1081 SEL68 GND 0.24626f
C1082 SEL67 GND 0.24626f
C1083 SEL66 GND 0.24626f
C1084 SEL65 GND 0.24626f
C1085 SEL64 GND 0.26331f
C1086 SEL63 GND 0.26337f
C1087 SEL62 GND 0.24626f
C1088 SEL61 GND 0.24626f
C1089 SEL60 GND 0.24626f
C1090 SEL59 GND 0.24626f
C1091 SEL58 GND 0.24626f
C1092 SEL57 GND 0.24626f
C1093 SEL56 GND 0.26331f
C1094 SEL55 GND 0.26337f
C1095 SEL54 GND 0.24626f
C1096 SEL53 GND 0.24626f
C1097 SEL52 GND 0.24626f
C1098 SEL51 GND 0.24626f
C1099 SEL50 GND 0.24626f
C1100 SEL49 GND 0.24626f
C1101 SEL48 GND 0.26331f
C1102 SEL47 GND 0.26337f
C1103 SEL46 GND 0.24626f
C1104 SEL45 GND 0.24626f
C1105 SEL44 GND 0.24626f
C1106 SEL43 GND 0.24626f
C1107 SEL42 GND 0.24626f
C1108 SEL41 GND 0.24626f
C1109 SEL40 GND 0.26331f
C1110 SEL39 GND 0.26337f
C1111 SEL38 GND 0.24626f
C1112 SEL37 GND 0.24626f
C1113 SEL36 GND 0.24626f
C1114 SEL35 GND 0.24626f
C1115 SEL34 GND 0.24626f
C1116 SEL33 GND 0.24626f
C1117 SEL32 GND 0.26331f
C1118 SEL31 GND 0.26337f
C1119 SEL30 GND 0.24626f
C1120 SEL29 GND 0.24626f
C1121 SEL28 GND 0.24626f
C1122 SEL27 GND 0.24626f
C1123 SEL26 GND 0.24626f
C1124 SEL25 GND 0.24626f
C1125 SEL24 GND 0.26331f
C1126 SEL23 GND 0.26337f
C1127 SEL22 GND 0.24626f
C1128 SEL21 GND 0.24626f
C1129 SEL20 GND 0.24626f
C1130 SEL19 GND 0.24626f
C1131 SEL18 GND 0.24626f
C1132 SEL17 GND 0.24626f
C1133 SEL16 GND 0.26331f
C1134 SEL15 GND 0.26337f
C1135 SEL14 GND 0.24626f
C1136 SEL13 GND 0.24626f
C1137 SEL12 GND 0.24626f
C1138 SEL11 GND 0.24626f
C1139 SEL10 GND 0.24626f
C1140 SEL9 GND 0.24626f
C1141 SEL8 GND 0.26331f
C1142 SEL7 GND 0.26337f
C1143 SEL6 GND 0.24626f
C1144 SEL5 GND 0.24626f
C1145 SEL4 GND 0.24626f
C1146 SEL3 GND 0.24626f
C1147 SEL2 GND 0.24626f
C1148 SEL1 GND 0.24626f
C1149 SEL0 GND 0.31444f
C1150 X GND 12.9229f
C1151 VB GND 26.9404f
C1152 a_28116_n392# GND 0.19344f
C1153 a_27912_n392# GND 0.17382f
C1154 a_27708_n392# GND 0.17382f
C1155 a_27504_n392# GND 0.17382f
C1156 a_27300_n392# GND 0.17382f
C1157 a_27096_n392# GND 0.17382f
C1158 a_26892_n392# GND 0.17382f
C1159 a_26688_n392# GND 0.17671f
C1160 a_26346_n392# GND 0.17944f
C1161 a_26142_n392# GND 0.17382f
C1162 a_25938_n392# GND 0.17382f
C1163 a_25734_n392# GND 0.17382f
C1164 a_25530_n392# GND 0.17382f
C1165 a_25326_n392# GND 0.17382f
C1166 a_25122_n392# GND 0.17382f
C1167 a_24918_n392# GND 0.17671f
C1168 a_24576_n392# GND 0.17944f
C1169 a_24372_n392# GND 0.17382f
C1170 a_24168_n392# GND 0.17382f
C1171 a_23964_n392# GND 0.17382f
C1172 a_23760_n392# GND 0.17382f
C1173 a_23556_n392# GND 0.17382f
C1174 a_23352_n392# GND 0.17382f
C1175 a_23148_n392# GND 0.17671f
C1176 a_22806_n392# GND 0.17944f
C1177 a_22602_n392# GND 0.17382f
C1178 a_22398_n392# GND 0.17382f
C1179 a_22194_n392# GND 0.17382f
C1180 a_21990_n392# GND 0.17382f
C1181 a_21786_n392# GND 0.17382f
C1182 a_21582_n392# GND 0.17382f
C1183 a_21378_n392# GND 0.17671f
C1184 a_21036_n392# GND 0.17944f
C1185 a_20832_n392# GND 0.17382f
C1186 a_20628_n392# GND 0.17382f
C1187 a_20424_n392# GND 0.17382f
C1188 a_20220_n392# GND 0.17382f
C1189 a_20016_n392# GND 0.17382f
C1190 a_19812_n392# GND 0.17382f
C1191 a_19608_n392# GND 0.17671f
C1192 a_19266_n392# GND 0.17944f
C1193 a_19062_n392# GND 0.17382f
C1194 a_18858_n392# GND 0.17382f
C1195 a_18654_n392# GND 0.17382f
C1196 a_18450_n392# GND 0.17382f
C1197 a_18246_n392# GND 0.17382f
C1198 a_18042_n392# GND 0.17382f
C1199 a_17838_n392# GND 0.17671f
C1200 a_17496_n392# GND 0.17944f
C1201 a_17292_n392# GND 0.17382f
C1202 a_17088_n392# GND 0.17382f
C1203 a_16884_n392# GND 0.17382f
C1204 a_16680_n392# GND 0.17382f
C1205 a_16476_n392# GND 0.17382f
C1206 a_16272_n392# GND 0.17382f
C1207 a_16068_n392# GND 0.17671f
C1208 a_15726_n392# GND 0.17944f
C1209 a_15522_n392# GND 0.17382f
C1210 a_15318_n392# GND 0.17382f
C1211 a_15114_n392# GND 0.17382f
C1212 a_14910_n392# GND 0.17382f
C1213 a_14706_n392# GND 0.17382f
C1214 a_14502_n392# GND 0.17382f
C1215 a_14298_n392# GND 0.17671f
C1216 a_13956_n392# GND 0.17944f
C1217 a_13752_n392# GND 0.17382f
C1218 a_13548_n392# GND 0.17382f
C1219 a_13344_n392# GND 0.17382f
C1220 a_13140_n392# GND 0.17382f
C1221 a_12936_n392# GND 0.17382f
C1222 a_12732_n392# GND 0.17382f
C1223 a_12528_n392# GND 0.17671f
C1224 a_12186_n392# GND 0.17944f
C1225 a_11982_n392# GND 0.17382f
C1226 a_11778_n392# GND 0.17382f
C1227 a_11574_n392# GND 0.17382f
C1228 a_11370_n392# GND 0.17382f
C1229 a_11166_n392# GND 0.17382f
C1230 a_10962_n392# GND 0.17382f
C1231 a_10758_n392# GND 0.17671f
C1232 a_10416_n392# GND 0.17944f
C1233 a_10212_n392# GND 0.17382f
C1234 a_10008_n392# GND 0.17382f
C1235 a_9804_n392# GND 0.17382f
C1236 a_9600_n392# GND 0.17382f
C1237 a_9396_n392# GND 0.17382f
C1238 a_9192_n392# GND 0.17382f
C1239 a_8988_n392# GND 0.17671f
C1240 a_8646_n392# GND 0.17944f
C1241 a_8442_n392# GND 0.17382f
C1242 a_8238_n392# GND 0.17382f
C1243 a_8034_n392# GND 0.17382f
C1244 a_7830_n392# GND 0.17382f
C1245 a_7626_n392# GND 0.17382f
C1246 a_7422_n392# GND 0.17382f
C1247 a_7218_n392# GND 0.17671f
C1248 a_6876_n392# GND 0.17944f
C1249 a_6672_n392# GND 0.17382f
C1250 a_6468_n392# GND 0.17382f
C1251 a_6264_n392# GND 0.17382f
C1252 a_6060_n392# GND 0.17382f
C1253 a_5856_n392# GND 0.17382f
C1254 a_5652_n392# GND 0.17382f
C1255 a_5448_n392# GND 0.17671f
C1256 a_5106_n392# GND 0.17944f
C1257 a_4902_n392# GND 0.17382f
C1258 a_4698_n392# GND 0.17382f
C1259 a_4494_n392# GND 0.17382f
C1260 a_4290_n392# GND 0.17382f
C1261 a_4086_n392# GND 0.17382f
C1262 a_3882_n392# GND 0.17382f
C1263 a_3678_n392# GND 0.17671f
C1264 a_3336_n392# GND 0.17944f
C1265 a_3132_n392# GND 0.17382f
C1266 a_2928_n392# GND 0.17382f
C1267 a_2724_n392# GND 0.17382f
C1268 a_2520_n392# GND 0.17382f
C1269 a_2316_n392# GND 0.17382f
C1270 a_2112_n392# GND 0.17382f
C1271 a_1908_n392# GND 0.17671f
C1272 a_1566_n392# GND 0.17944f
C1273 a_1362_n392# GND 0.17382f
C1274 a_1158_n392# GND 0.17382f
C1275 a_954_n392# GND 0.17382f
C1276 a_750_n392# GND 0.17382f
C1277 a_546_n392# GND 0.17382f
C1278 a_342_n392# GND 0.17382f
C1279 a_138_n392# GND 0.21057f
.ends

.subckt u128g SEL0 SEL1 SEL2 SEL3 SEL4 SEL5 SEL6 SEL7 SEL8 SEL9 SEL10 SEL11 SEL12 SEL13 SEL14 SEL15 SEL16 SEL17 SEL18 SEL19 SEL20 SEL21 SEL22 SEL23 SEL24 SEL25 SEL26 SEL27 SEL28 SEL29 SEL30 SEL31 SEL32 SEL33 SEL34 SEL35 SEL36 SEL37 SEL38 SEL39 SEL40 SEL41 SEL42 SEL43 SEL44 SEL45 SEL46 SEL47 SEL48 SEL49 SEL50 SEL51 SEL52 SEL53 SEL54 SEL55 SEL56 SEL57 SEL58 SEL59 SEL60 SEL61 SEL62 SEL63 SEL64 SEL65 SEL66 SEL67 SEL68 SEL69 SEL70 SEL71 SEL72 SEL73 SEL74 SEL75 SEL76 SEL77 SEL78 SEL79 SEL80 SEL81 SEL82 SEL83 SEL84 SEL85 SEL86 SEL87 SEL88 SEL89 SEL90 SEL91 SEL92 SEL93 SEL94 SEL95 SEL96 SEL97 SEL98 SEL99 SEL100 SEL101 SEL102 SEL103 SEL104 SEL105 SEL106 SEL107 SEL108 SEL109 SEL110 SEL111 SEL112 SEL113 SEL114 SEL115 SEL116 SEL117 SEL118 SEL119 SEL120 SEL121 SEL122 SEL123 SEL124 SEL125 SEL126 SEL127 X VB GND GT
X0 X VB a_10758_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X1 X VB a_18654_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X2 GND SEL9 a_2112_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X3 GND SEL23 a_5106_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X4 GND SEL122 a_27096_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X5 GND SEL93 a_20628_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X6 GND SEL34 a_7626_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X7 X VB a_17292_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X8 GND SEL91 a_20220_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X9 X VB a_7830_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X10 X VB a_26892_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X11 GND SEL116 a_25734_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X12 GND SEL54 a_11982_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X13 X VB a_5652_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X14 GND SEL79 a_17496_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X15 GND SEL65 a_14502_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X16 X VB a_4290_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X17 X VB a_23352_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X18 X VB a_25530_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X19 GND SEL25 a_5652_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X20 X VB a_2928_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X21 X VB a_13752_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X22 GND SEL39 a_8646_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X23 X VB a_8646_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X24 X VB a_21990_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X25 GND SEL37 a_8238_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X26 X VB a_20628_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X27 X VB a_26346_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X28 GND SEL107 a_23760_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X29 GND SEL56 a_12528_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X30 GND SEL45 a_10008_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X31 X VB a_342_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X32 X VB a_14502_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X33 GND SEL104 a_23148_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X34 X VB a_9396_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X35 GND SEL5 a_1158_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X36 GND SEL16 a_3678_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X37 X VB a_18858_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X38 GND SEL68 a_15114_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X39 X VB a_8034_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X40 X VB a_10962_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X41 X VB a_27096_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X42 GND SEL28 a_6264_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X43 X VB a_17496_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X44 GND SEL98 a_21786_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X45 X VB a_19608_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X46 X VB a_13956_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X47 GND SEL3 a_750_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X48 GND SEL61 a_13548_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X49 X VB a_5856_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X50 GND SEL110 a_24372_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X51 X VB a_16068_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X52 GND SEL22 a_4902_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X53 GND SEL121 a_26892_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X54 GND SEL59 a_13140_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X55 X VB a_4494_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X56 X VB a_23556_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X57 X VB a_25734_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X58 GND SEL84 a_18654_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X59 X VB a_954_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X60 X VB a_3132_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X61 X VB a_22194_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X62 GND SEL101 a_22398_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X63 GND SEL42 a_9396_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X64 GND SEL13 a_2928_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X65 GND SEL112 a_24918_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X66 GND SEL50 a_11166_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X67 X VB a_546_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X68 X VB a_14706_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X69 GND SEL99 a_21990_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X70 X VB a_11166_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X71 GND SEL11 a_2520_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X72 GND SEL124 a_27504_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X73 X VB a_8238_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X74 X VB a_19062_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X75 GND SEL87 a_19266_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X76 GND SEL73 a_16272_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X77 X VB a_20832_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X78 X VB a_9600_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X79 GND SEL90 a_20016_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X80 GND SEL67 a_14910_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X81 X VB a_6060_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X82 X VB a_27300_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X83 GND SEL64 a_14298_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X84 X VB a_4698_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X85 X VB a_25938_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X86 GND SEL113 a_25122_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X87 GND SEL14 a_3132_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X88 GND SEL24 a_5448_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X89 GND SEL127 a_28116_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X90 X VB a_1158_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X91 X VB a_3336_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X92 X VB a_19812_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X93 X VB a_22398_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X94 GND SEL47 a_10416_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X95 X VB a_21036_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X96 GND SEL58 a_12936_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X97 X VB a_16272_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X98 GND SEL106 a_23556_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X99 X VB a_23760_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X100 GND SEL7 a_1566_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X101 GND SEL70 a_15522_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X102 GND SEL118 a_26142_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X103 X VB a_19266_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X104 GND SEL30 a_6672_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X105 X VB a_10008_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X106 X VB a_1908_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X107 X GT a_138_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X108 X VB a_750_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X109 X VB a_14910_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X110 X VB a_9804_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X111 GND SEL2 a_546_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X112 X VB a_11370_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X113 GND SEL0 a_138_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X114 GND SEL109 a_24168_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X115 X VB a_6264_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X116 X VB a_27504_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X117 GND SEL21 a_4698_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X118 GND SEL120 a_26688_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X119 X VB a_23964_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X120 GND SEL19 a_4290_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X121 GND SEL103 a_22806_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X122 GND SEL81 a_18042_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X123 GND SEL44 a_9804_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X124 X VB a_16476_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X125 GND SEL52 a_11574_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X126 X VB a_4902_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X127 GND SEL126 a_27912_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X128 X VB a_15114_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X129 X VB a_1362_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X130 X VB a_22602_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X131 GND SEL10 a_2316_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X132 GND SEL75 a_16680_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X133 GND SEL72 a_16068_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X134 GND SEL33 a_7422_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X135 X VB a_2112_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X136 GND SEL92 a_20424_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X137 GND SEL117 a_25938_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X138 GND SEL55 a_12186_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X139 X VB a_11574_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X140 X VB a_27708_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X141 GND SEL66 a_14706_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X142 X VB a_6468_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X143 GND SEL115 a_25530_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X144 X VB a_10212_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X145 GND SEL26 a_5856_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X146 X VB a_5106_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X147 X VB a_24168_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X148 GND SEL89 a_19812_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X149 GND SEL78 a_17292_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X150 X VB a_7218_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X151 X VB a_18042_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X152 GND SEL38 a_8442_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X153 GND SEL36 a_8034_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X154 GND SEL95 a_21036_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X155 X VB a_15318_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X156 GND SEL80 a_17838_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X157 GND SEL69 a_15318_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X158 X VB a_1566_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X159 X VB a_22806_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X160 GND SEL4 a_954_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X161 GND SEL29 a_6468_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X162 X VB a_3678_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X163 X VB a_24918_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X164 X VB a_16680_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X165 GND SEL27 a_6060_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X166 GND SEL48 a_10758_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X167 X VB a_2316_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X168 X VB a_21378_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X169 X VB a_13140_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X170 GND SEL111 a_24576_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X171 GND SEL97 a_21582_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X172 X VB a_11778_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X173 X VB a_20016_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X174 GND SEL60 a_13344_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X175 GND SEL85 a_18858_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X176 X VB a_10416_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X177 GND SEL83 a_18450_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X178 X VB a_12528_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X179 GND SEL18 a_4086_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X180 X VB a_18246_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X181 X VB a_27912_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X182 X VB a_6672_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X183 GND SEL41 a_9192_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X184 GND SEL125 a_27708_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X185 GND SEL100 a_22194_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X186 X VB a_24372_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X187 GND SEL12 a_2724_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X188 GND SEL63 a_13956_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X189 GND SEL49 a_10962_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X190 GND SEL74 a_16476_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X191 X VB a_7422_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X192 GND SEL123 a_27300_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X193 X VB a_16884_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X194 GND SEL94 a_20832_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X195 GND SEL86 a_19062_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X196 GND SEL35 a_7830_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X197 X VB a_25122_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X198 GND SEL32 a_7218_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X199 X VB a_15522_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X200 X VB a_13344_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X201 X VB a_11982_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X202 X VB a_28116_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X203 GND SEL114 a_25326_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X204 X VB a_3882_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X205 GND SEL15 a_3336_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X206 X VB a_8988_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X207 GND SEL88 a_19608_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X208 GND SEL77 a_17088_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X209 X VB a_2520_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X210 X VB a_21582_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X211 X VB a_6876_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X212 X VB a_20220_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X213 X VB a_17088_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X214 GND SEL57 a_12732_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X215 GND SEL46 a_10212_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X216 X VB a_24576_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X217 GND SEL105 a_23352_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X218 GND SEL71 a_15726_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X219 GND SEL6 a_1362_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X220 GND SEL17 a_3882_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X221 GND SEL119 a_26346_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X222 X VB a_5448_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X223 X VB a_7626_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X224 X VB a_12732_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X225 X VB a_26688_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X226 GND SEL31 a_6876_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X227 X VB a_18450_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X228 X VB a_25326_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X229 X VB a_4086_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X230 X VB a_23148_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X231 X VB a_13548_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X232 X VB a_15726_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X233 GND SEL96 a_21378_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X234 GND SEL62 a_13752_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X235 X VB a_12186_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X236 X VB a_17838_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X237 GND SEL1 a_342_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X238 GND SEL8 a_1908_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X239 GND SEL108 a_23964_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X240 X VB a_14298_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X241 GND SEL20 a_4494_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X242 GND SEL82 a_18246_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X243 X VB a_2724_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X244 X VB a_21786_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X245 X VB a_8442_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X246 GND SEL53 a_11778_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X247 X VB a_20424_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X248 GND SEL102 a_22602_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X249 GND SEL43 a_9600_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X250 X VB a_26142_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X251 GND SEL51 a_11370_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X252 GND SEL40 a_8988_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X253 GND SEL76 a_16884_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
X254 X VB a_9192_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X255 X VB a_12936_n392# GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
C0 a_18246_n392# VB 0.08024f
C1 SEL116 SEL117 0.09569f
C2 SEL116 SEL115 0.09569f
C3 SEL95 a_21036_n392# 0.0031f
C4 a_9804_n392# X 0.0562f
C5 a_17088_n392# X 0.0562f
C6 SEL114 SEL115 0.09569f
C7 SEL94 a_21036_n392# 0
C8 a_6672_n392# a_6468_n392# 0.01932f
C9 a_19062_n392# a_18858_n392# 0.01932f
C10 SEL113 SEL114 0.09569f
C11 a_9804_n392# VB 0.08024f
C12 SEL75 a_16884_n392# 0
C13 SEL112 SEL113 0.09569f
C14 SEL76 a_16884_n392# 0.0031f
C15 a_23556_n392# SEL105 0
C16 a_17088_n392# VB 0.08024f
C17 a_23556_n392# SEL106 0.0031f
C18 X a_12528_n392# 0.04207f
C19 SEL112 SEL111 0.05373f
C20 SEL110 SEL111 0.09569f
C21 X a_2316_n392# 0.0562f
C22 a_1566_n392# a_1908_n392# 0.01138f
C23 a_3882_n392# SEL17 0.0031f
C24 SEL16 a_3882_n392# 0
C25 a_23148_n392# a_23352_n392# 0.01932f
C26 a_8988_n392# a_9192_n392# 0.01932f
C27 a_12528_n392# VB 0.07335f
C28 a_2316_n392# VB 0.08024f
C29 a_16680_n392# a_16884_n392# 0.01932f
C30 SEL109 SEL110 0.09569f
C31 a_21990_n392# a_22194_n392# 0.01932f
C32 X a_22194_n392# 0.0562f
C33 a_16272_n392# a_16476_n392# 0.01932f
C34 a_7626_n392# X 0.0562f
C35 a_5856_n392# SEL26 0.0031f
C36 SEL109 SEL108 0.09569f
C37 a_22194_n392# VB 0.08024f
C38 a_5856_n392# SEL25 0
C39 a_24576_n392# SEL111 0.0031f
C40 X a_11982_n392# 0.0562f
C41 a_24576_n392# SEL110 0
C42 a_7626_n392# VB 0.08024f
C43 X a_14706_n392# 0.0562f
C44 SEL108 SEL107 0.09569f
C45 SEL83 a_18450_n392# 0.0031f
C46 a_19266_n392# SEL87 0.0031f
C47 X a_8988_n392# 0.04207f
C48 SEL82 a_18450_n392# 0
C49 SEL86 a_19266_n392# 0
C50 a_11982_n392# VB 0.08024f
C51 a_12732_n392# a_12528_n392# 0.01932f
C52 a_10416_n392# SEL47 0.0031f
C53 SEL46 a_10416_n392# 0
C54 a_14706_n392# VB 0.08024f
C55 a_11370_n392# X 0.0562f
C56 a_8988_n392# VB 0.07335f
C57 SEL21 a_4698_n392# 0.0031f
C58 SEL14 a_3336_n392# 0
C59 a_3336_n392# SEL15 0.0031f
C60 X a_7830_n392# 0.0562f
C61 SEL107 SEL106 0.09569f
C62 a_11370_n392# VB 0.08024f
C63 SEL20 a_4698_n392# 0
C64 X a_3882_n392# 0.0562f
C65 a_7830_n392# VB 0.08024f
C66 SEL48 a_10758_n392# 0.0031f
C67 a_17292_n392# SEL77 0
C68 SEL47 a_10758_n392# 0
C69 a_17292_n392# SEL78 0.0031f
C70 a_21582_n392# SEL97 0.0031f
C71 a_15114_n392# SEL68 0.0031f
C72 SEL105 SEL104 0.09569f
C73 a_10962_n392# a_10758_n392# 0.01932f
C74 a_3882_n392# VB 0.08024f
C75 SEL105 SEL106 0.09569f
C76 a_21582_n392# SEL96 0
C77 a_10008_n392# X 0.0562f
C78 SEL104 SEL103 0.05373f
C79 a_15114_n392# SEL67 0
C80 a_2520_n392# a_2724_n392# 0.01932f
C81 SEL102 SEL103 0.09569f
C82 a_23964_n392# SEL108 0.0031f
C83 a_750_n392# SEL3 0.0031f
C84 a_10008_n392# VB 0.08024f
C85 a_2928_n392# a_3132_n392# 0.01932f
C86 a_22602_n392# a_22398_n392# 0.01932f
C87 SEL101 SEL102 0.09569f
C88 SEL0 a_138_n392# 0.0031f
C89 a_23964_n392# SEL107 0
C90 X a_20424_n392# 0.0562f
C91 a_750_n392# SEL2 0
C92 a_8238_n392# a_8442_n392# 0.01932f
C93 SEL72 a_16068_n392# 0.0031f
C94 SEL42 a_9396_n392# 0.0031f
C95 X a_138_n392# 0.03199f
C96 SEL100 SEL101 0.09569f
C97 a_750_n392# X 0.0562f
C98 a_20424_n392# VB 0.08024f
C99 SEL71 a_16068_n392# 0
C100 a_9396_n392# SEL41 0
C101 SEL28 a_6264_n392# 0.0031f
C102 a_16476_n392# X 0.0562f
C103 VB a_138_n392# 0.06465f
C104 SEL27 a_6264_n392# 0
C105 a_19266_n392# a_19062_n392# 0.01932f
C106 a_6672_n392# SEL30 0.0031f
C107 a_750_n392# VB 0.08024f
C108 SEL100 SEL99 0.09569f
C109 a_21036_n392# a_21378_n392# 0.01138f
C110 a_11574_n392# SEL52 0.0031f
C111 SEL98 SEL99 0.09569f
C112 a_9600_n392# X 0.0562f
C113 a_6672_n392# SEL29 0
C114 X a_3336_n392# 0.0562f
C115 a_16476_n392# VB 0.08024f
C116 SEL97 SEL98 0.09569f
C117 SEL114 a_25326_n392# 0.0031f
C118 a_11778_n392# SEL53 0.0031f
C119 SEL5 a_1158_n392# 0.0031f
C120 a_11574_n392# SEL51 0
C121 SEL113 a_25326_n392# 0
C122 a_13548_n392# SEL61 0.0031f
C123 SEL4 a_1158_n392# 0
C124 a_5106_n392# a_4902_n392# 0.01932f
C125 SEL97 SEL96 0.09569f
C126 a_9600_n392# VB 0.08024f
C127 a_3336_n392# VB 0.08041f
C128 a_14502_n392# a_14706_n392# 0.01932f
C129 X a_5856_n392# 0.0562f
C130 a_13548_n392# SEL60 0
C131 a_11778_n392# SEL52 0
C132 a_22398_n392# X 0.0562f
C133 a_19608_n392# X 0.04207f
C134 SEL95 SEL96 0.05373f
C135 X a_4698_n392# 0.0562f
C136 SEL94 SEL95 0.09569f
C137 a_22398_n392# VB 0.08024f
C138 a_5856_n392# VB 0.08024f
C139 X a_12186_n392# 0.0562f
C140 a_19608_n392# VB 0.07335f
C141 SEL94 SEL93 0.09569f
C142 a_546_n392# SEL2 0.0031f
C143 a_546_n392# SEL1 0
C144 SEL16 a_3678_n392# 0.0031f
C145 SEL93 SEL92 0.09569f
C146 VB a_4698_n392# 0.08024f
C147 SEL15 a_3678_n392# 0
C148 a_8238_n392# a_8034_n392# 0.01932f
C149 X a_1158_n392# 0.0562f
C150 a_10212_n392# X 0.0562f
C151 SEL91 SEL92 0.09569f
C152 a_24168_n392# a_24372_n392# 0.01932f
C153 SEL7 a_1566_n392# 0.0031f
C154 SEL6 a_1566_n392# 0
C155 VB a_12186_n392# 0.08041f
C156 a_546_n392# X 0.0562f
C157 SEL91 SEL90 0.09569f
C158 a_1158_n392# VB 0.08024f
C159 a_10212_n392# VB 0.08024f
C160 a_546_n392# VB 0.08024f
C161 SEL89 SEL90 0.09569f
C162 a_342_n392# a_138_n392# 0.01932f
C163 SEL89 SEL88 0.09569f
C164 X a_1566_n392# 0.0562f
C165 a_13344_n392# a_13548_n392# 0.01932f
C166 SEL87 SEL88 0.05373f
C167 a_20016_n392# SEL90 0.0031f
C168 SEL86 SEL87 0.09569f
C169 SEL89 a_20016_n392# 0
C170 SEL85 SEL86 0.09569f
C171 a_1566_n392# VB 0.08041f
C172 SEL85 SEL84 0.09569f
C173 a_15114_n392# a_14910_n392# 0.01932f
C174 SEL84 SEL83 0.09569f
C175 a_8238_n392# SEL37 0.0031f
C176 SEL36 a_8238_n392# 0
C177 SEL14 a_3132_n392# 0.0031f
C178 a_3132_n392# SEL13 0
C179 SEL82 SEL83 0.09569f
C180 SEL82 SEL81 0.09569f
C181 a_5856_n392# a_5652_n392# 0.01932f
C182 SEL81 SEL80 0.09569f
C183 X a_3678_n392# 0.04207f
C184 a_21990_n392# a_21786_n392# 0.01932f
C185 a_9804_n392# a_10008_n392# 0.01932f
C186 a_21786_n392# X 0.0562f
C187 a_19608_n392# a_19812_n392# 0.01932f
C188 a_21582_n392# a_21378_n392# 0.01932f
C189 SEL79 SEL80 0.05373f
C190 a_23148_n392# SEL104 0.0031f
C191 SEL77 SEL78 0.09569f
C192 SEL75 SEL76 0.09569f
C193 SEL77 SEL76 0.09569f
C194 X a_23352_n392# 0.0562f
C195 SEL79 SEL78 0.09569f
C196 X a_6264_n392# 0.0562f
C197 a_23148_n392# SEL103 0
C198 X a_18858_n392# 0.0562f
C199 a_3678_n392# VB 0.07335f
C200 SEL75 SEL74 0.09569f
C201 a_21786_n392# VB 0.08024f
C202 SEL22 a_4902_n392# 0.0031f
C203 SEL21 a_4902_n392# 0
C204 a_9396_n392# a_9192_n392# 0.01932f
C205 a_23352_n392# VB 0.08024f
C206 SEL73 SEL74 0.09569f
C207 SEL73 SEL72 0.09569f
C208 a_6264_n392# VB 0.08024f
C209 a_546_n392# a_342_n392# 0.01932f
C210 a_18858_n392# VB 0.08024f
C211 a_14298_n392# SEL64 0.0031f
C212 a_14298_n392# SEL63 0
C213 a_10416_n392# X 0.0562f
C214 a_16680_n392# SEL75 0.0031f
C215 a_7626_n392# a_7830_n392# 0.01932f
C216 SEL72 SEL71 0.05373f
C217 a_6672_n392# X 0.0562f
C218 a_16680_n392# SEL74 0
C219 SEL70 SEL71 0.09569f
C220 SEL69 SEL70 0.09569f
C221 a_10416_n392# VB 0.08041f
C222 a_20628_n392# SEL93 0.0031f
C223 SEL69 SEL68 0.09569f
C224 a_7218_n392# a_7422_n392# 0.01932f
C225 a_20220_n392# SEL91 0.0031f
C226 a_20628_n392# SEL92 0
C227 a_23556_n392# a_23760_n392# 0.01932f
C228 a_6672_n392# VB 0.08024f
C229 a_9600_n392# a_9804_n392# 0.01932f
C230 a_15522_n392# SEL70 0.0031f
C231 a_15522_n392# SEL69 0
C232 a_20220_n392# SEL90 0
C233 SEL86 a_19062_n392# 0.0031f
C234 SEL67 SEL68 0.09569f
C235 SEL85 a_19062_n392# 0
C236 a_18654_n392# X 0.0562f
C237 a_24168_n392# X 0.0562f
C238 X a_3132_n392# 0.0562f
C239 a_9396_n392# X 0.0562f
C240 a_7422_n392# SEL33 0.0031f
C241 X a_10758_n392# 0.04207f
C242 a_7218_n392# a_6876_n392# 0.01138f
C243 SEL67 SEL66 0.09569f
C244 a_18654_n392# VB 0.08024f
C245 a_7422_n392# SEL32 0
C246 a_24168_n392# VB 0.08024f
C247 SEL96 a_21378_n392# 0.0031f
C248 a_2520_n392# SEL11 0.0031f
C249 SEL95 a_21378_n392# 0
C250 a_3132_n392# VB 0.08024f
C251 a_9396_n392# VB 0.08024f
C252 SEL27 a_6060_n392# 0.0031f
C253 VB a_10758_n392# 0.07335f
C254 a_20220_n392# a_20016_n392# 0.01932f
C255 X a_16884_n392# 0.0562f
C256 SEL66 SEL65 0.09569f
C257 a_15726_n392# a_16068_n392# 0.01138f
C258 a_6060_n392# SEL26 0
C259 a_2520_n392# SEL10 0
C260 SEL64 SEL65 0.09569f
C261 a_16272_n392# a_16068_n392# 0.01932f
C262 a_12936_n392# SEL58 0.0031f
C263 a_24372_n392# SEL110 0.0031f
C264 SEL31 a_6876_n392# 0.0031f
C265 a_16884_n392# VB 0.08024f
C266 a_6876_n392# SEL30 0
C267 SEL63 SEL64 0.05373f
C268 a_12528_n392# a_12186_n392# 0.01138f
C269 a_12936_n392# SEL57 0
C270 SEL62 SEL63 0.09569f
C271 SEL61 SEL62 0.09569f
C272 SEL61 SEL60 0.09569f
C273 SEL109 a_24372_n392# 0
C274 a_22398_n392# a_22194_n392# 0.01932f
C275 X a_21036_n392# 0.0562f
C276 SEL60 SEL59 0.09569f
C277 X a_4902_n392# 0.0562f
C278 a_23760_n392# SEL107 0.0031f
C279 a_21036_n392# VB 0.08041f
C280 SEL59 SEL58 0.09569f
C281 a_4902_n392# VB 0.08024f
C282 a_24576_n392# a_24372_n392# 0.01932f
C283 a_2520_n392# X 0.0562f
C284 a_11574_n392# X 0.0562f
C285 SEL127 X 0
C286 a_4290_n392# a_4494_n392# 0.01932f
C287 a_17292_n392# a_17496_n392# 0.01932f
C288 a_24918_n392# SEL111 0
C289 X SEL126 0
C290 SEL112 a_24918_n392# 0.0031f
C291 SEL125 X 0
C292 SEL124 X 0
C293 a_11982_n392# a_12186_n392# 0.01932f
C294 a_23760_n392# SEL106 0
C295 SEL113 a_25122_n392# 0.0031f
C296 a_2520_n392# VB 0.08024f
C297 SEL57 SEL58 0.09569f
C298 SEL112 a_25122_n392# 0
C299 a_11574_n392# VB 0.08024f
C300 a_18450_n392# X 0.0562f
C301 SEL127 VB 0.01474f
C302 SEL127 a_28116_n392# 0.0031f
C303 SEL123 X 0
C304 a_11778_n392# X 0.0562f
C305 SEL126 VB 0.01474f
C306 SEL126 a_28116_n392# 0
C307 SEL125 VB 0.01474f
C308 X SEL122 0
C309 SEL126 a_27912_n392# 0.0031f
C310 SEL124 VB 0.01474f
C311 SEL125 a_27912_n392# 0
C312 a_27708_n392# SEL125 0.0031f
C313 a_15114_n392# X 0.0562f
C314 X a_19266_n392# 0.0562f
C315 SEL55 SEL56 0.05373f
C316 SEL56 SEL57 0.09569f
C317 a_27708_n392# SEL124 0
C318 a_18450_n392# VB 0.08024f
C319 X a_8238_n392# 0.0562f
C320 SEL123 VB 0.01474f
C321 a_11778_n392# VB 0.08024f
C322 a_11166_n392# SEL50 0.0031f
C323 SEL124 a_27504_n392# 0.0031f
C324 SEL55 SEL54 0.09569f
C325 a_11166_n392# SEL49 0
C326 SEL122 VB 0.01474f
C327 SEL121 X 0
C328 a_23556_n392# X 0.0562f
C329 X SEL120 0
C330 a_15114_n392# VB 0.08024f
C331 a_19266_n392# VB 0.08041f
C332 X SEL119 0
C333 SEL123 a_27504_n392# 0
C334 a_11166_n392# a_10962_n392# 0.01932f
C335 a_21036_n392# a_20832_n392# 0.01932f
C336 SEL123 a_27300_n392# 0.0031f
C337 a_13344_n392# SEL60 0.0031f
C338 a_17292_n392# X 0.0562f
C339 a_8238_n392# VB 0.08024f
C340 X SEL118 0
C341 SEL122 a_27300_n392# 0
C342 SEL54 SEL53 0.09569f
C343 a_13344_n392# SEL59 0
C344 a_24576_n392# a_24918_n392# 0.01138f
C345 SEL121 VB 0.01474f
C346 VB SEL120 0.01474f
C347 a_23556_n392# VB 0.08024f
C348 SEL122 a_27096_n392# 0.0031f
C349 a_23964_n392# a_23760_n392# 0.01932f
C350 SEL119 VB 0.01474f
C351 a_17292_n392# VB 0.08024f
C352 SEL118 VB 0.01474f
C353 SEL53 SEL52 0.09569f
C354 a_13548_n392# X 0.0562f
C355 a_2724_n392# a_2928_n392# 0.01932f
C356 X a_16068_n392# 0.04207f
C357 SEL121 a_26892_n392# 0.0031f
C358 a_26892_n392# SEL120 0
C359 SEL121 a_27096_n392# 0
C360 SEL67 a_14910_n392# 0.0031f
C361 a_26688_n392# SEL120 0.0031f
C362 SEL6 a_1362_n392# 0.0031f
C363 SEL5 a_1362_n392# 0
C364 a_26688_n392# SEL119 0
C365 SEL117 X 0
C366 a_26346_n392# SEL119 0.0031f
C367 a_15114_n392# a_15318_n392# 0.01932f
C368 a_13548_n392# VB 0.08024f
C369 a_10212_n392# a_10008_n392# 0.01932f
C370 SEL116 X 0
C371 X SEL115 0
C372 SEL66 a_14910_n392# 0
C373 SEL118 a_26346_n392# 0
C374 SEL52 SEL51 0.09569f
C375 a_16068_n392# VB 0.07335f
C376 X a_6060_n392# 0.0562f
C377 X SEL114 0
C378 SEL118 a_26142_n392# 0.0031f
C379 SEL38 a_8442_n392# 0.0031f
C380 SEL113 X 0
C381 SEL112 X 0
C382 SEL117 VB 0.01474f
C383 a_8442_n392# SEL37 0
C384 a_5448_n392# a_5106_n392# 0.01138f
C385 X SEL111 0
C386 SEL50 SEL51 0.09569f
C387 SEL116 VB 0.01474f
C388 SEL115 VB 0.01474f
C389 X SEL110 0
C390 a_22602_n392# SEL102 0.0031f
C391 SEL20 a_4494_n392# 0.0031f
C392 SEL49 SEL50 0.09569f
C393 a_22602_n392# SEL101 0
C394 a_6060_n392# VB 0.08024f
C395 SEL114 VB 0.01474f
C396 SEL48 SEL49 0.09569f
C397 SEL113 VB 0.01474f
C398 SEL112 VB 0.01474f
C399 a_7422_n392# X 0.0562f
C400 VB SEL111 0.01474f
C401 SEL48 SEL47 0.05373f
C402 SEL19 a_4494_n392# 0
C403 SEL49 a_10962_n392# 0.0031f
C404 X a_1362_n392# 0.0562f
C405 a_21582_n392# X 0.0562f
C406 SEL110 VB 0.01474f
C407 SEL46 SEL47 0.09569f
C408 SEL48 a_10962_n392# 0
C409 SEL109 X 0
C410 SEL108 X 0
C411 a_13548_n392# a_13752_n392# 0.01932f
C412 SEL117 a_26142_n392# 0
C413 a_750_n392# a_546_n392# 0.01932f
C414 a_6468_n392# SEL29 0.0031f
C415 a_7422_n392# VB 0.08024f
C416 SEL4 a_954_n392# 0.0031f
C417 SEL46 SEL45 0.09569f
C418 SEL107 X 0
C419 a_1362_n392# VB 0.08024f
C420 a_21582_n392# VB 0.08024f
C421 a_25938_n392# SEL117 0.0031f
C422 a_17088_n392# a_16884_n392# 0.01932f
C423 SEL116 a_25734_n392# 0.0031f
C424 a_25734_n392# SEL115 0
C425 X a_6876_n392# 0.0562f
C426 a_25938_n392# SEL116 0
C427 SEL28 a_6468_n392# 0
C428 SEL108 VB 0.01474f
C429 SEL109 VB 0.01474f
C430 a_15726_n392# SEL71 0.0031f
C431 a_16272_n392# SEL73 0.0031f
C432 SEL3 a_954_n392# 0
C433 a_16272_n392# SEL72 0
C434 a_15726_n392# SEL70 0
C435 SEL107 VB 0.01474f
C436 a_25530_n392# SEL115 0.0031f
C437 a_24576_n392# X 0.0562f
C438 a_15522_n392# a_15726_n392# 0.01932f
C439 SEL44 SEL45 0.09569f
C440 a_6876_n392# VB 0.08041f
C441 X SEL104 0
C442 a_25530_n392# SEL114 0
C443 a_3882_n392# a_3678_n392# 0.01932f
C444 SEL106 X 0
C445 SEL105 X 0
C446 X SEL103 0
C447 SEL44 SEL43 0.09569f
C448 X a_954_n392# 0.0562f
C449 X SEL102 0
C450 a_24576_n392# VB 0.08041f
C451 a_8646_n392# a_8442_n392# 0.01932f
C452 X SEL101 0
C453 SEL104 VB 0.01474f
C454 a_18042_n392# SEL81 0.0031f
C455 SEL106 VB 0.01474f
C456 SEL105 VB 0.01474f
C457 a_4290_n392# a_4086_n392# 0.01932f
C458 SEL36 a_8034_n392# 0.0031f
C459 a_18042_n392# SEL80 0
C460 SEL103 VB 0.01474f
C461 SEL42 SEL43 0.09569f
C462 a_954_n392# VB 0.08024f
C463 SEL102 VB 0.01474f
C464 a_8034_n392# SEL35 0
C465 a_21990_n392# SEL99 0.0031f
C466 SEL101 VB 0.01474f
C467 X SEL100 0
C468 a_18450_n392# a_18246_n392# 0.01932f
C469 a_21990_n392# SEL98 0
C470 X SEL99 0
C471 SEL98 X 0
C472 a_22806_n392# SEL103 0.0031f
C473 SEL97 X 0
C474 a_22806_n392# SEL102 0
C475 X SEL96 0
C476 SEL100 VB 0.01474f
C477 SEL95 X 0
C478 SEL99 VB 0.01474f
C479 SEL42 SEL41 0.09569f
C480 SEL98 VB 0.01474f
C481 a_25122_n392# a_25326_n392# 0.01932f
C482 a_23964_n392# X 0.0562f
C483 SEL97 VB 0.01474f
C484 X SEL93 0
C485 SEL94 X 0
C486 X SEL92 0
C487 a_17496_n392# SEL78 0
C488 SEL79 a_17496_n392# 0.0031f
C489 SEL91 X 0
C490 SEL96 VB 0.01474f
C491 X a_4494_n392# 0.0562f
C492 SEL95 VB 0.01474f
C493 a_17838_n392# SEL80 0.0031f
C494 X SEL90 0
C495 a_2520_n392# a_2316_n392# 0.01932f
C496 a_23964_n392# VB 0.08024f
C497 SEL79 a_17838_n392# 0
C498 SEL40 SEL41 0.09569f
C499 SEL93 VB 0.01474f
C500 SEL94 VB 0.01474f
C501 SEL24 a_5448_n392# 0.0031f
C502 SEL89 X 0
C503 SEL92 VB 0.01474f
C504 a_5448_n392# SEL23 0
C505 SEL91 VB 0.01474f
C506 X a_14298_n392# 0.04207f
C507 a_4494_n392# VB 0.08024f
C508 a_3336_n392# a_3678_n392# 0.01138f
C509 X SEL88 0
C510 X SEL87 0
C511 SEL90 VB 0.01474f
C512 a_2724_n392# SEL12 0.0031f
C513 SEL40 SEL39 0.05373f
C514 SEL86 X 0
C515 SEL38 SEL39 0.09569f
C516 SEL85 X 0
C517 SEL89 VB 0.01474f
C518 SEL84 X 0
C519 SEL38 SEL37 0.09569f
C520 SEL83 X 0
C521 a_14298_n392# VB 0.07335f
C522 a_17088_n392# a_17292_n392# 0.01932f
C523 SEL36 SEL37 0.09569f
C524 SEL82 X 0
C525 SEL88 VB 0.01474f
C526 a_2724_n392# SEL11 0
C527 X SEL81 0
C528 SEL87 VB 0.01474f
C529 X a_20016_n392# 0.0562f
C530 SEL86 VB 0.01474f
C531 SEL85 VB 0.01474f
C532 X SEL80 0
C533 SEL36 SEL35 0.09569f
C534 a_7218_n392# SEL32 0.0031f
C535 X SEL77 0
C536 a_14298_n392# a_13956_n392# 0.01138f
C537 X SEL75 0
C538 SEL84 VB 0.01474f
C539 X SEL78 0
C540 SEL79 X 0
C541 X SEL76 0
C542 a_7218_n392# SEL31 0
C543 SEL83 VB 0.01474f
C544 SEL34 SEL35 0.09569f
C545 SEL82 VB 0.01474f
C546 SEL81 VB 0.01474f
C547 a_20016_n392# VB 0.08024f
C548 X SEL74 0
C549 X SEL73 0
C550 X SEL72 0
C551 SEL34 SEL33 0.09569f
C552 SEL23 a_5106_n392# 0.0031f
C553 SEL80 VB 0.01474f
C554 SEL77 VB 0.01474f
C555 SEL75 VB 0.01474f
C556 SEL79 VB 0.01474f
C557 SEL78 VB 0.01474f
C558 SEL76 VB 0.01474f
C559 X SEL71 0
C560 SEL93 a_20832_n392# 0
C561 SEL94 a_20832_n392# 0.0031f
C562 SEL69 X 0
C563 SEL33 SEL32 0.09569f
C564 SEL22 a_5106_n392# 0
C565 X SEL70 0
C566 a_12936_n392# X 0.0562f
C567 SEL74 VB 0.01474f
C568 SEL68 X 0
C569 SEL73 VB 0.01474f
C570 SEL72 VB 0.01474f
C571 a_11778_n392# a_11982_n392# 0.01932f
C572 a_16680_n392# X 0.0562f
C573 X a_25326_n392# 0.0562f
C574 SEL67 X 0
C575 a_15522_n392# X 0.0562f
C576 a_4086_n392# SEL18 0.0031f
C577 a_11370_n392# a_11574_n392# 0.01932f
C578 SEL31 SEL32 0.05373f
C579 SEL71 VB 0.01474f
C580 SEL69 VB 0.01474f
C581 SEL70 VB 0.01474f
C582 a_12936_n392# VB 0.08024f
C583 a_2112_n392# a_1908_n392# 0.01932f
C584 a_4086_n392# SEL17 0
C585 SEL31 SEL30 0.09569f
C586 SEL66 X 0
C587 SEL68 VB 0.01474f
C588 a_16680_n392# VB 0.08024f
C589 a_25326_n392# VB 0.08024f
C590 X a_6468_n392# 0.0562f
C591 SEL67 VB 0.01474f
C592 a_15522_n392# VB 0.08024f
C593 X SEL65 0
C594 a_9600_n392# a_9396_n392# 0.01932f
C595 SEL29 SEL30 0.09569f
C596 a_3336_n392# a_3132_n392# 0.01932f
C597 X a_8442_n392# 0.0562f
C598 X SEL64 0
C599 a_8646_n392# SEL39 0.0031f
C600 a_8646_n392# SEL38 0
C601 X SEL63 0
C602 a_10212_n392# a_10416_n392# 0.01932f
C603 SEL61 X 0
C604 SEL62 X 0
C605 SEL66 VB 0.01474f
C606 a_11166_n392# X 0.0562f
C607 SEL65 VB 0.01474f
C608 a_6468_n392# VB 0.08024f
C609 a_2724_n392# X 0.0562f
C610 X SEL60 0
C611 a_8442_n392# VB 0.08024f
C612 SEL64 VB 0.01474f
C613 X SEL59 0
C614 SEL28 SEL29 0.09569f
C615 a_2928_n392# SEL13 0.0031f
C616 SEL63 VB 0.01474f
C617 a_2928_n392# SEL12 0
C618 SEL62 VB 0.01474f
C619 SEL61 VB 0.01474f
C620 a_11166_n392# VB 0.08024f
C621 X a_19062_n392# 0.0562f
C622 SEL69 a_15318_n392# 0.0031f
C623 X SEL58 0
C624 SEL60 VB 0.01474f
C625 a_2724_n392# VB 0.08024f
C626 SEL63 a_13956_n392# 0.0031f
C627 SEL62 a_13956_n392# 0
C628 SEL68 a_15318_n392# 0
C629 SEL59 VB 0.01474f
C630 SEL27 SEL28 0.09569f
C631 SEL89 a_19812_n392# 0.0031f
C632 a_15522_n392# a_15318_n392# 0.01932f
C633 SEL55 X 0
C634 X SEL57 0
C635 a_25530_n392# a_25326_n392# 0.01932f
C636 a_12936_n392# a_12732_n392# 0.01932f
C637 a_19062_n392# VB 0.08024f
C638 a_20220_n392# X 0.0562f
C639 SEL56 X 0
C640 SEL88 a_19812_n392# 0
C641 SEL58 VB 0.01474f
C642 X a_20628_n392# 0.0562f
C643 SEL54 X 0
C644 SEL27 SEL26 0.09569f
C645 SEL19 a_4290_n392# 0.0031f
C646 a_13140_n392# a_12936_n392# 0.01932f
C647 a_4290_n392# SEL18 0
C648 a_23148_n392# X 0.04207f
C649 a_5448_n392# X 0.04207f
C650 SEL57 VB 0.01474f
C651 SEL55 VB 0.01474f
C652 X SEL53 0
C653 a_20220_n392# VB 0.08024f
C654 SEL8 a_1908_n392# 0.0031f
C655 SEL56 VB 0.01474f
C656 a_14298_n392# a_14502_n392# 0.01932f
C657 SEL7 a_1908_n392# 0
C658 SEL61 a_13752_n392# 0
C659 SEL62 a_13752_n392# 0.0031f
C660 a_20628_n392# VB 0.08024f
C661 a_20016_n392# a_19812_n392# 0.01932f
C662 SEL54 VB 0.01474f
C663 SEL26 SEL25 0.09569f
C664 X SEL52 0
C665 a_7422_n392# a_7626_n392# 0.01932f
C666 a_23148_n392# VB 0.07335f
C667 a_5448_n392# VB 0.07335f
C668 SEL53 VB 0.01474f
C669 X SEL51 0
C670 X a_8034_n392# 0.0562f
C671 X SEL50 0
C672 SEL24 SEL25 0.09569f
C673 X SEL49 0
C674 SEL52 VB 0.01474f
C675 X a_4086_n392# 0.0562f
C676 a_9192_n392# SEL41 0.0031f
C677 SEL48 X 0
C678 a_23148_n392# a_22806_n392# 0.01138f
C679 a_13344_n392# X 0.0562f
C680 X SEL47 0
C681 SEL46 X 0
C682 X a_21378_n392# 0.04207f
C683 SEL24 SEL23 0.05373f
C684 X a_10962_n392# 0.0562f
C685 SEL51 VB 0.01474f
C686 a_8034_n392# VB 0.08024f
C687 SEL50 VB 0.01474f
C688 SEL40 a_9192_n392# 0
C689 SEL49 VB 0.01474f
C690 a_4902_n392# a_4698_n392# 0.01932f
C691 a_4086_n392# VB 0.08024f
C692 X a_5106_n392# 0.0562f
C693 a_13140_n392# SEL59 0.0031f
C694 SEL45 X 0
C695 SEL48 VB 0.01474f
C696 X a_1908_n392# 0.04207f
C697 SEL23 SEL22 0.09569f
C698 a_13344_n392# VB 0.08024f
C699 SEL47 VB 0.01474f
C700 SEL46 VB 0.01474f
C701 a_21378_n392# VB 0.07335f
C702 a_13140_n392# SEL58 0
C703 SEL44 X 0
C704 a_10962_n392# VB 0.08024f
C705 a_12732_n392# SEL57 0.0031f
C706 a_2928_n392# X 0.0562f
C707 X SEL43 0
C708 SEL82 a_18246_n392# 0.0031f
C709 SEL56 a_12732_n392# 0
C710 SEL81 a_18246_n392# 0
C711 a_5106_n392# VB 0.08041f
C712 SEL45 VB 0.01474f
C713 a_1908_n392# VB 0.07335f
C714 a_20628_n392# a_20832_n392# 0.01932f
C715 SEL22 SEL21 0.09569f
C716 SEL42 X 0
C717 SEL44 VB 0.01474f
C718 a_2928_n392# VB 0.08024f
C719 SEL43 VB 0.01474f
C720 SEL100 a_22194_n392# 0.0031f
C721 SEL99 a_22194_n392# 0
C722 SEL20 SEL21 0.09569f
C723 X SEL41 0
C724 a_14502_n392# SEL65 0.0031f
C725 a_19608_n392# a_19266_n392# 0.01138f
C726 SEL42 VB 0.01474f
C727 a_14502_n392# SEL64 0
C728 a_7218_n392# X 0.04207f
C729 a_18654_n392# a_18858_n392# 0.01932f
C730 SEL40 X 0
C731 X SEL39 0
C732 X SEL38 0
C733 X a_4290_n392# 0.0562f
C734 SEL41 VB 0.01474f
C735 X a_14910_n392# 0.0562f
C736 a_17088_n392# SEL77 0.0031f
C737 a_17088_n392# SEL76 0
C738 SEL36 X 0
C739 X SEL37 0
C740 SEL20 SEL19 0.09569f
C741 a_7218_n392# VB 0.07335f
C742 X SEL35 0
C743 SEL40 VB 0.01474f
C744 SEL34 X 0
C745 SEL39 VB 0.01474f
C746 SEL33 X 0
C747 SEL38 VB 0.01474f
C748 a_4290_n392# VB 0.08024f
C749 a_5448_n392# a_5652_n392# 0.01932f
C750 a_13140_n392# a_13344_n392# 0.01932f
C751 a_14910_n392# VB 0.08024f
C752 VB SEL37 0.01474f
C753 SEL36 VB 0.01474f
C754 SEL19 SEL18 0.09569f
C755 X SEL32 0
C756 a_10416_n392# a_10758_n392# 0.01138f
C757 SEL17 SEL18 0.09569f
C758 SEL35 VB 0.01474f
C759 SEL31 X 0
C760 X SEL30 0
C761 SEL34 VB 0.01474f
C762 SEL33 VB 0.01474f
C763 SEL16 SEL17 0.09569f
C764 SEL16 SEL15 0.05373f
C765 SEL14 SEL15 0.09569f
C766 a_25122_n392# a_24918_n392# 0.01932f
C767 SEL14 SEL13 0.09569f
C768 X SEL29 0
C769 SEL13 SEL12 0.09569f
C770 SEL32 VB 0.01474f
C771 SEL31 VB 0.01474f
C772 VB SEL30 0.01474f
C773 a_5856_n392# a_6060_n392# 0.01932f
C774 X SEL28 0
C775 SEL29 VB 0.01474f
C776 SEL12 SEL11 0.09569f
C777 SEL27 X 0
C778 SEL9 a_2112_n392# 0.0031f
C779 SEL8 a_2112_n392# 0
C780 X a_24372_n392# 0.0562f
C781 X SEL26 0
C782 SEL28 VB 0.01474f
C783 X SEL25 0
C784 SEL27 VB 0.01474f
C785 a_23760_n392# X 0.0562f
C786 X a_8646_n392# 0.0562f
C787 SEL24 X 0
C788 X a_15726_n392# 0.0562f
C789 a_24372_n392# VB 0.08024f
C790 a_750_n392# a_954_n392# 0.01932f
C791 SEL26 VB 0.01474f
C792 SEL23 X 0
C793 SEL25 VB 0.01474f
C794 SEL10 SEL11 0.09569f
C795 a_23760_n392# VB 0.08024f
C796 a_16272_n392# X 0.0562f
C797 a_8646_n392# VB 0.08041f
C798 SEL22 X 0
C799 SEL24 VB 0.01474f
C800 a_15726_n392# VB 0.08041f
C801 X SEL21 0
C802 SEL23 VB 0.01474f
C803 a_17838_n392# a_18042_n392# 0.01932f
C804 a_1158_n392# a_1362_n392# 0.01932f
C805 a_2112_n392# X 0.0562f
C806 a_16272_n392# VB 0.08024f
C807 SEL20 X 0
C808 SEL22 VB 0.01474f
C809 SEL92 a_20424_n392# 0.0031f
C810 SEL55 a_12528_n392# 0
C811 SEL21 VB 0.01474f
C812 SEL91 a_20424_n392# 0
C813 SEL56 a_12528_n392# 0.0031f
C814 SEL9 SEL10 0.09569f
C815 SEL19 X 0
C816 a_2112_n392# VB 0.08024f
C817 X SEL18 0
C818 X a_24918_n392# 0.04207f
C819 SEL20 VB 0.01474f
C820 SEL66 a_14706_n392# 0.0031f
C821 SEL16 X 0
C822 a_23556_n392# a_23352_n392# 0.01932f
C823 X SEL17 0
C824 X SEL15 0
C825 a_22398_n392# SEL101 0.0031f
C826 SEL14 X 0
C827 X SEL13 0
C828 a_14706_n392# SEL65 0
C829 SEL9 SEL8 0.09569f
C830 X SEL12 0
C831 a_17496_n392# a_17838_n392# 0.01138f
C832 X a_25122_n392# 0.0562f
C833 SEL8 SEL7 0.05373f
C834 SEL19 VB 0.01474f
C835 SEL18 VB 0.01474f
C836 a_24918_n392# VB 0.07335f
C837 a_18042_n392# X 0.0562f
C838 SEL6 SEL7 0.09569f
C839 SEL16 VB 0.01474f
C840 SEL5 SEL6 0.09569f
C841 SEL17 VB 0.01474f
C842 X SEL11 0
C843 a_22398_n392# SEL100 0
C844 SEL14 VB 0.01474f
C845 SEL13 VB 0.01474f
C846 SEL15 VB 0.01474f
C847 SEL12 VB 0.01474f
C848 a_1362_n392# a_1566_n392# 0.01932f
C849 SEL4 SEL5 0.09569f
C850 a_25122_n392# VB 0.08024f
C851 a_1158_n392# a_954_n392# 0.01932f
C852 a_18042_n392# VB 0.08024f
C853 a_22602_n392# X 0.0562f
C854 a_9804_n392# SEL44 0.0031f
C855 a_11370_n392# a_11166_n392# 0.01932f
C856 a_18450_n392# a_18654_n392# 0.01932f
C857 a_9804_n392# SEL43 0
C858 SEL11 VB 0.01474f
C859 X SEL10 0
C860 SEL4 SEL3 0.09569f
C861 X a_9192_n392# 0.0562f
C862 a_17496_n392# X 0.0562f
C863 a_22602_n392# VB 0.08024f
C864 SEL54 a_11982_n392# 0.0031f
C865 SEL9 X 0
C866 SEL8 X 0
C867 X SEL7 0
C868 SEL10 VB 0.01474f
C869 X SEL6 0
C870 a_17838_n392# X 0.04207f
C871 a_5652_n392# SEL25 0.0031f
C872 a_6060_n392# a_6264_n392# 0.01932f
C873 SEL5 X 0
C874 a_11982_n392# SEL53 0
C875 a_9192_n392# VB 0.08024f
C876 a_4494_n392# a_4698_n392# 0.01932f
C877 SEL3 SEL2 0.09569f
C878 SEL4 X 0
C879 a_17496_n392# VB 0.08041f
C880 a_22602_n392# a_22806_n392# 0.01932f
C881 SEL24 a_5652_n392# 0
C882 SEL9 VB 0.01474f
C883 SEL8 VB 0.01474f
C884 SEL7 VB 0.01474f
C885 a_16476_n392# SEL74 0.0031f
C886 X SEL3 0
C887 a_17838_n392# VB 0.07335f
C888 SEL6 VB 0.01474f
C889 SEL1 SEL2 0.09569f
C890 a_16476_n392# SEL73 0
C891 a_19608_n392# SEL87 0
C892 a_19608_n392# SEL88 0.0031f
C893 SEL5 VB 0.01474f
C894 SEL0 SEL1 0.09569f
C895 a_21582_n392# a_21786_n392# 0.01932f
C896 SEL4 VB 0.01474f
C897 X SEL2 0
C898 X SEL1 0
C899 SEL0 X 0
C900 SEL3 VB 0.01474f
C901 a_21990_n392# X 0.0562f
C902 a_16680_n392# a_16476_n392# 0.01932f
C903 SEL2 VB 0.01474f
C904 SEL1 VB 0.01474f
C905 SEL0 VB 0.01474f
C906 a_11370_n392# SEL51 0.0031f
C907 a_11370_n392# SEL50 0
C908 a_21990_n392# VB 0.08024f
C909 X a_28116_n392# 0.0562f
C910 X VB 6.84006f
C911 X a_27912_n392# 0.0562f
C912 a_27708_n392# X 0.0562f
C913 SEL127 SEL126 0.09569f
C914 SEL104 a_23352_n392# 0
C915 a_7830_n392# a_8034_n392# 0.01932f
C916 SEL105 a_23352_n392# 0.0031f
C917 a_27504_n392# X 0.0562f
C918 X a_13956_n392# 0.0562f
C919 SEL125 SEL126 0.09569f
C920 X a_27300_n392# 0.0562f
C921 X a_22806_n392# 0.0562f
C922 a_28116_n392# VB 0.08036f
C923 SEL124 SEL125 0.09569f
C924 a_26892_n392# X 0.0562f
C925 a_27912_n392# VB 0.08024f
C926 X a_27096_n392# 0.0562f
C927 a_27708_n392# VB 0.08024f
C928 a_27912_n392# a_28116_n392# 0.01932f
C929 a_3882_n392# a_4086_n392# 0.01932f
C930 a_6672_n392# a_6876_n392# 0.01932f
C931 a_26688_n392# X 0.04207f
C932 a_20220_n392# a_20424_n392# 0.01932f
C933 X a_26346_n392# 0.0562f
C934 a_11574_n392# a_11778_n392# 0.01932f
C935 a_27708_n392# a_27912_n392# 0.01932f
C936 a_20628_n392# a_20424_n392# 0.01932f
C937 a_27504_n392# VB 0.08024f
C938 a_13956_n392# VB 0.08041f
C939 X a_26142_n392# 0.0562f
C940 a_27300_n392# VB 0.08024f
C941 SEL124 SEL123 0.09569f
C942 a_22806_n392# VB 0.08041f
C943 a_27708_n392# a_27504_n392# 0.01932f
C944 X a_25734_n392# 0.0562f
C945 SEL109 a_24168_n392# 0.0031f
C946 SEL98 a_21786_n392# 0.0031f
C947 a_24168_n392# SEL108 0
C948 a_25938_n392# X 0.0562f
C949 a_26892_n392# VB 0.08024f
C950 a_27096_n392# VB 0.08024f
C951 a_26688_n392# VB 0.07335f
C952 X a_13752_n392# 0.0562f
C953 a_26346_n392# VB 0.08041f
C954 SEL97 a_21786_n392# 0
C955 SEL34 a_7626_n392# 0.0031f
C956 X a_15318_n392# 0.0562f
C957 a_27504_n392# a_27300_n392# 0.01932f
C958 SEL123 SEL122 0.09569f
C959 a_7626_n392# SEL33 0
C960 a_25530_n392# X 0.0562f
C961 a_26142_n392# VB 0.08024f
C962 a_14910_n392# a_14706_n392# 0.01932f
C963 SEL40 a_8988_n392# 0.0031f
C964 a_25734_n392# VB 0.08024f
C965 a_8988_n392# SEL39 0
C966 a_25938_n392# VB 0.08024f
C967 a_27096_n392# a_27300_n392# 0.01932f
C968 X a_12732_n392# 0.0562f
C969 a_13752_n392# VB 0.08024f
C970 a_10008_n392# SEL45 0.0031f
C971 X a_20832_n392# 0.0562f
C972 a_15318_n392# VB 0.08024f
C973 a_26892_n392# a_27096_n392# 0.01932f
C974 a_26688_n392# a_26892_n392# 0.01932f
C975 a_26688_n392# a_26346_n392# 0.01138f
C976 a_25530_n392# VB 0.08024f
C977 a_13752_n392# a_13956_n392# 0.01932f
C978 SEL44 a_10008_n392# 0
C979 a_13140_n392# X 0.0562f
C980 SEL121 SEL122 0.09569f
C981 a_26142_n392# a_26346_n392# 0.01932f
C982 a_12732_n392# VB 0.08024f
C983 a_20832_n392# VB 0.08024f
C984 a_18042_n392# a_18246_n392# 0.01932f
C985 a_13140_n392# VB 0.08024f
C986 a_25938_n392# a_26142_n392# 0.01932f
C987 a_342_n392# SEL1 0.0031f
C988 a_25938_n392# a_25734_n392# 0.01932f
C989 SEL121 SEL120 0.09569f
C990 SEL0 a_342_n392# 0
C991 a_7830_n392# SEL35 0.0031f
C992 SEL119 SEL120 0.05373f
C993 SEL34 a_7830_n392# 0
C994 X a_5652_n392# 0.0562f
C995 SEL55 a_12186_n392# 0.0031f
C996 a_342_n392# X 0.0562f
C997 a_2112_n392# a_2316_n392# 0.01932f
C998 a_25530_n392# a_25734_n392# 0.01932f
C999 SEL85 a_18858_n392# 0.0031f
C1000 SEL118 SEL119 0.09569f
C1001 SEL54 a_12186_n392# 0
C1002 SEL84 a_18858_n392# 0
C1003 X a_19812_n392# 0.0562f
C1004 a_5652_n392# VB 0.08024f
C1005 a_342_n392# VB 0.08024f
C1006 a_23964_n392# a_24168_n392# 0.01932f
C1007 VB a_19812_n392# 0.08024f
C1008 X a_14502_n392# 0.0562f
C1009 a_9600_n392# SEL43 0.0031f
C1010 a_8646_n392# a_8988_n392# 0.01138f
C1011 a_14502_n392# VB 0.08024f
C1012 SEL117 SEL118 0.09569f
C1013 a_9600_n392# SEL42 0
C1014 SEL46 a_10212_n392# 0.0031f
C1015 SEL10 a_2316_n392# 0.0031f
C1016 SEL84 a_18654_n392# 0.0031f
C1017 X a_18246_n392# 0.0562f
C1018 SEL83 a_18654_n392# 0
C1019 a_10212_n392# SEL45 0
C1020 SEL9 a_2316_n392# 0
C1021 a_6264_n392# a_6468_n392# 0.01932f
C1022 SEL127 GND 0.31454f
C1023 SEL126 GND 0.24626f
C1024 SEL125 GND 0.24626f
C1025 SEL124 GND 0.24626f
C1026 SEL123 GND 0.24626f
C1027 SEL122 GND 0.24626f
C1028 SEL121 GND 0.24626f
C1029 SEL120 GND 0.26331f
C1030 SEL119 GND 0.26337f
C1031 SEL118 GND 0.24626f
C1032 SEL117 GND 0.24626f
C1033 SEL116 GND 0.24626f
C1034 SEL115 GND 0.24626f
C1035 SEL114 GND 0.24626f
C1036 SEL113 GND 0.24626f
C1037 SEL112 GND 0.26331f
C1038 SEL111 GND 0.26337f
C1039 SEL110 GND 0.24626f
C1040 SEL109 GND 0.24626f
C1041 SEL108 GND 0.24626f
C1042 SEL107 GND 0.24626f
C1043 SEL106 GND 0.24626f
C1044 SEL105 GND 0.24626f
C1045 SEL104 GND 0.26331f
C1046 SEL103 GND 0.26337f
C1047 SEL102 GND 0.24626f
C1048 SEL101 GND 0.24626f
C1049 SEL100 GND 0.24626f
C1050 SEL99 GND 0.24626f
C1051 SEL98 GND 0.24626f
C1052 SEL97 GND 0.24626f
C1053 SEL96 GND 0.26331f
C1054 SEL95 GND 0.26337f
C1055 SEL94 GND 0.24626f
C1056 SEL93 GND 0.24626f
C1057 SEL92 GND 0.24626f
C1058 SEL91 GND 0.24626f
C1059 SEL90 GND 0.24626f
C1060 SEL89 GND 0.24626f
C1061 SEL88 GND 0.26331f
C1062 SEL87 GND 0.26337f
C1063 SEL86 GND 0.24626f
C1064 SEL85 GND 0.24626f
C1065 SEL84 GND 0.24626f
C1066 SEL83 GND 0.24626f
C1067 SEL82 GND 0.24626f
C1068 SEL81 GND 0.24626f
C1069 SEL80 GND 0.26331f
C1070 SEL79 GND 0.26337f
C1071 SEL78 GND 0.24626f
C1072 SEL77 GND 0.24626f
C1073 SEL76 GND 0.24626f
C1074 SEL75 GND 0.24626f
C1075 SEL74 GND 0.24626f
C1076 SEL73 GND 0.24626f
C1077 SEL72 GND 0.26331f
C1078 SEL71 GND 0.26337f
C1079 SEL70 GND 0.24626f
C1080 SEL69 GND 0.24626f
C1081 SEL68 GND 0.24626f
C1082 SEL67 GND 0.24626f
C1083 SEL66 GND 0.24626f
C1084 SEL65 GND 0.24626f
C1085 SEL64 GND 0.26331f
C1086 SEL63 GND 0.26337f
C1087 SEL62 GND 0.24626f
C1088 SEL61 GND 0.24626f
C1089 SEL60 GND 0.24626f
C1090 SEL59 GND 0.24626f
C1091 SEL58 GND 0.24626f
C1092 SEL57 GND 0.24626f
C1093 SEL56 GND 0.26331f
C1094 SEL55 GND 0.26337f
C1095 SEL54 GND 0.24626f
C1096 SEL53 GND 0.24626f
C1097 SEL52 GND 0.24626f
C1098 SEL51 GND 0.24626f
C1099 SEL50 GND 0.24626f
C1100 SEL49 GND 0.24626f
C1101 SEL48 GND 0.26331f
C1102 SEL47 GND 0.26337f
C1103 SEL46 GND 0.24626f
C1104 SEL45 GND 0.24626f
C1105 SEL44 GND 0.24626f
C1106 SEL43 GND 0.24626f
C1107 SEL42 GND 0.24626f
C1108 SEL41 GND 0.24626f
C1109 SEL40 GND 0.26331f
C1110 SEL39 GND 0.26337f
C1111 SEL38 GND 0.24626f
C1112 SEL37 GND 0.24626f
C1113 SEL36 GND 0.24626f
C1114 SEL35 GND 0.24626f
C1115 SEL34 GND 0.24626f
C1116 SEL33 GND 0.24626f
C1117 SEL32 GND 0.26331f
C1118 SEL31 GND 0.26337f
C1119 SEL30 GND 0.24626f
C1120 SEL29 GND 0.24626f
C1121 SEL28 GND 0.24626f
C1122 SEL27 GND 0.24626f
C1123 SEL26 GND 0.24626f
C1124 SEL25 GND 0.24626f
C1125 SEL24 GND 0.26331f
C1126 SEL23 GND 0.26337f
C1127 SEL22 GND 0.24626f
C1128 SEL21 GND 0.24626f
C1129 SEL20 GND 0.24626f
C1130 SEL19 GND 0.24626f
C1131 SEL18 GND 0.24626f
C1132 SEL17 GND 0.24626f
C1133 SEL16 GND 0.26331f
C1134 SEL15 GND 0.26337f
C1135 SEL14 GND 0.24626f
C1136 SEL13 GND 0.24626f
C1137 SEL12 GND 0.24626f
C1138 SEL11 GND 0.24626f
C1139 SEL10 GND 0.24626f
C1140 SEL9 GND 0.24626f
C1141 SEL8 GND 0.26331f
C1142 SEL7 GND 0.26337f
C1143 SEL6 GND 0.24626f
C1144 SEL5 GND 0.24626f
C1145 SEL4 GND 0.24626f
C1146 SEL3 GND 0.24626f
C1147 SEL2 GND 0.24626f
C1148 SEL1 GND 0.24626f
C1149 SEL0 GND 0.31444f
C1150 X GND 12.9229f
C1151 VB GND 26.9404f
C1152 a_28116_n392# GND 0.19344f
C1153 a_27912_n392# GND 0.17382f
C1154 a_27708_n392# GND 0.17382f
C1155 a_27504_n392# GND 0.17382f
C1156 a_27300_n392# GND 0.17382f
C1157 a_27096_n392# GND 0.17382f
C1158 a_26892_n392# GND 0.17382f
C1159 a_26688_n392# GND 0.17671f
C1160 a_26346_n392# GND 0.17944f
C1161 a_26142_n392# GND 0.17382f
C1162 a_25938_n392# GND 0.17382f
C1163 a_25734_n392# GND 0.17382f
C1164 a_25530_n392# GND 0.17382f
C1165 a_25326_n392# GND 0.17382f
C1166 a_25122_n392# GND 0.17382f
C1167 a_24918_n392# GND 0.17671f
C1168 a_24576_n392# GND 0.17944f
C1169 a_24372_n392# GND 0.17382f
C1170 a_24168_n392# GND 0.17382f
C1171 a_23964_n392# GND 0.17382f
C1172 a_23760_n392# GND 0.17382f
C1173 a_23556_n392# GND 0.17382f
C1174 a_23352_n392# GND 0.17382f
C1175 a_23148_n392# GND 0.17671f
C1176 a_22806_n392# GND 0.17944f
C1177 a_22602_n392# GND 0.17382f
C1178 a_22398_n392# GND 0.17382f
C1179 a_22194_n392# GND 0.17382f
C1180 a_21990_n392# GND 0.17382f
C1181 a_21786_n392# GND 0.17382f
C1182 a_21582_n392# GND 0.17382f
C1183 a_21378_n392# GND 0.17671f
C1184 a_21036_n392# GND 0.17944f
C1185 a_20832_n392# GND 0.17382f
C1186 a_20628_n392# GND 0.17382f
C1187 a_20424_n392# GND 0.17382f
C1188 a_20220_n392# GND 0.17382f
C1189 a_20016_n392# GND 0.17382f
C1190 a_19812_n392# GND 0.17382f
C1191 a_19608_n392# GND 0.17671f
C1192 a_19266_n392# GND 0.17944f
C1193 a_19062_n392# GND 0.17382f
C1194 a_18858_n392# GND 0.17382f
C1195 a_18654_n392# GND 0.17382f
C1196 a_18450_n392# GND 0.17382f
C1197 a_18246_n392# GND 0.17382f
C1198 a_18042_n392# GND 0.17382f
C1199 a_17838_n392# GND 0.17671f
C1200 a_17496_n392# GND 0.17944f
C1201 a_17292_n392# GND 0.17382f
C1202 a_17088_n392# GND 0.17382f
C1203 a_16884_n392# GND 0.17382f
C1204 a_16680_n392# GND 0.17382f
C1205 a_16476_n392# GND 0.17382f
C1206 a_16272_n392# GND 0.17382f
C1207 a_16068_n392# GND 0.17671f
C1208 a_15726_n392# GND 0.17944f
C1209 a_15522_n392# GND 0.17382f
C1210 a_15318_n392# GND 0.17382f
C1211 a_15114_n392# GND 0.17382f
C1212 a_14910_n392# GND 0.17382f
C1213 a_14706_n392# GND 0.17382f
C1214 a_14502_n392# GND 0.17382f
C1215 a_14298_n392# GND 0.17671f
C1216 a_13956_n392# GND 0.17944f
C1217 a_13752_n392# GND 0.17382f
C1218 a_13548_n392# GND 0.17382f
C1219 a_13344_n392# GND 0.17382f
C1220 a_13140_n392# GND 0.17382f
C1221 a_12936_n392# GND 0.17382f
C1222 a_12732_n392# GND 0.17382f
C1223 a_12528_n392# GND 0.17671f
C1224 a_12186_n392# GND 0.17944f
C1225 a_11982_n392# GND 0.17382f
C1226 a_11778_n392# GND 0.17382f
C1227 a_11574_n392# GND 0.17382f
C1228 a_11370_n392# GND 0.17382f
C1229 a_11166_n392# GND 0.17382f
C1230 a_10962_n392# GND 0.17382f
C1231 a_10758_n392# GND 0.17671f
C1232 a_10416_n392# GND 0.17944f
C1233 a_10212_n392# GND 0.17382f
C1234 a_10008_n392# GND 0.17382f
C1235 a_9804_n392# GND 0.17382f
C1236 a_9600_n392# GND 0.17382f
C1237 a_9396_n392# GND 0.17382f
C1238 a_9192_n392# GND 0.17382f
C1239 a_8988_n392# GND 0.17671f
C1240 a_8646_n392# GND 0.17944f
C1241 a_8442_n392# GND 0.17382f
C1242 a_8238_n392# GND 0.17382f
C1243 a_8034_n392# GND 0.17382f
C1244 a_7830_n392# GND 0.17382f
C1245 a_7626_n392# GND 0.17382f
C1246 a_7422_n392# GND 0.17382f
C1247 a_7218_n392# GND 0.17671f
C1248 a_6876_n392# GND 0.17944f
C1249 a_6672_n392# GND 0.17382f
C1250 a_6468_n392# GND 0.17382f
C1251 a_6264_n392# GND 0.17382f
C1252 a_6060_n392# GND 0.17382f
C1253 a_5856_n392# GND 0.17382f
C1254 a_5652_n392# GND 0.17382f
C1255 a_5448_n392# GND 0.17671f
C1256 a_5106_n392# GND 0.17944f
C1257 a_4902_n392# GND 0.17382f
C1258 a_4698_n392# GND 0.17382f
C1259 a_4494_n392# GND 0.17382f
C1260 a_4290_n392# GND 0.17382f
C1261 a_4086_n392# GND 0.17382f
C1262 a_3882_n392# GND 0.17382f
C1263 a_3678_n392# GND 0.17671f
C1264 a_3336_n392# GND 0.17944f
C1265 a_3132_n392# GND 0.17382f
C1266 a_2928_n392# GND 0.17382f
C1267 a_2724_n392# GND 0.17382f
C1268 a_2520_n392# GND 0.17382f
C1269 a_2316_n392# GND 0.17382f
C1270 a_2112_n392# GND 0.17382f
C1271 a_1908_n392# GND 0.17671f
C1272 a_1566_n392# GND 0.17944f
C1273 a_1362_n392# GND 0.17382f
C1274 a_1158_n392# GND 0.17382f
C1275 a_954_n392# GND 0.17382f
C1276 a_750_n392# GND 0.17382f
C1277 a_546_n392# GND 0.17382f
C1278 a_342_n392# GND 0.17382f
C1279 a_138_n392# GND 0.21057f
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

* --- m128_0: core
Xm128_0_ienn hi 0 0 vdd vdd m128_0_enn sky130_fd_sc_hd__inv_1
Xm128_0_is1n 0 0 0 vdd vdd m128_0_s1n sky130_fd_sc_hd__inv_1
Xm128_0_is0n 0 0 0 vdd vdd m128_0_s0n sky130_fd_sc_hd__inv_1
Xm128_0_PREA pre m128_0_enn 0 0 vdd vdd m128_0_PREA sky130_fd_sc_hd__nor2_1
Xm128_0_PREB pre m128_0_enn 0 0 vdd vdd m128_0_PREB sky130_fd_sc_hd__nor2_1
Xm128_0_VBIAS hi 0 0 vdd vdd m128_0_VBIAS sky130_fd_sc_hd__buf_2
Xm128_0_C1 hi 0 0 vdd vdd m128_0_C1 sky130_fd_sc_hd__buf_2
Xm128_0_DUTA hi m128_0_s1n 0 0 0 vdd vdd m128_0_DUTA sky130_fd_sc_hd__and3_1
Xm128_0_DUTB hi m128_0_s1n 0 0 0 vdd vdd m128_0_DUTB sky130_fd_sc_hd__and3_1
Xm128_0_REFA hi 0 0 0 vdd vdd m128_0_REFA sky130_fd_sc_hd__and2_1
Xm128_0_REFB hi 0 0 0 vdd vdd m128_0_REFB sky130_fd_sc_hd__and2_1
Xm128_0_SA0B hi 0 0 0 0 vdd vdd m128_0_SA0B sky130_fd_sc_hd__nand3_1
Xm128_0_SA1B hi 0 0 0 vdd vdd m128_0_SA1B sky130_fd_sc_hd__nand2_1
Xm128_0_SA2B hi 0 m128_0_s0n 0 0 vdd vdd m128_0_SA2B sky130_fd_sc_hd__nand3_1
Xm128_0_SB0B hi 0 0 0 vdd vdd m128_0_SB0B sky130_fd_sc_hd__nand2_1
Xm128_0_SB1B hi 0 0 0 vdd vdd m128_0_SB1B sky130_fd_sc_hd__nand2_1
Xm128_0_M m128_0_ob m128_0_SB0B m128_0_SB1B m128_0_REFB m128_0_oa m128_0_SA0B m128_0_SA1B m128_0_SA2B m128_0_REFA vdd 0 m128_0_VBIAS m128_0_C1 m128_0_PREA m128_0_XA m128_0_DUTA m128_0_PREB m128_0_XB m128_0_DUTB m128_0_VB 0 0 core
Xm128_0matA hi 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 m128_0_XA m128_0_VB 0 u128
Xm128_0matB hi 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 m128_0_XB m128_0_VB 0 u128

* --- m128_127: core
Xm128_127_ienn hi 0 0 vdd vdd m128_127_enn sky130_fd_sc_hd__inv_1
Xm128_127_is1n 0 0 0 vdd vdd m128_127_s1n sky130_fd_sc_hd__inv_1
Xm128_127_is0n 0 0 0 vdd vdd m128_127_s0n sky130_fd_sc_hd__inv_1
Xm128_127_PREA pre m128_127_enn 0 0 vdd vdd m128_127_PREA sky130_fd_sc_hd__nor2_1
Xm128_127_PREB pre m128_127_enn 0 0 vdd vdd m128_127_PREB sky130_fd_sc_hd__nor2_1
Xm128_127_VBIAS hi 0 0 vdd vdd m128_127_VBIAS sky130_fd_sc_hd__buf_2
Xm128_127_C1 hi 0 0 vdd vdd m128_127_C1 sky130_fd_sc_hd__buf_2
Xm128_127_DUTA hi m128_127_s1n 0 0 0 vdd vdd m128_127_DUTA sky130_fd_sc_hd__and3_1
Xm128_127_DUTB hi m128_127_s1n 0 0 0 vdd vdd m128_127_DUTB sky130_fd_sc_hd__and3_1
Xm128_127_REFA hi 0 0 0 vdd vdd m128_127_REFA sky130_fd_sc_hd__and2_1
Xm128_127_REFB hi 0 0 0 vdd vdd m128_127_REFB sky130_fd_sc_hd__and2_1
Xm128_127_SA0B hi 0 0 0 0 vdd vdd m128_127_SA0B sky130_fd_sc_hd__nand3_1
Xm128_127_SA1B hi 0 0 0 vdd vdd m128_127_SA1B sky130_fd_sc_hd__nand2_1
Xm128_127_SA2B hi 0 m128_127_s0n 0 0 vdd vdd m128_127_SA2B sky130_fd_sc_hd__nand3_1
Xm128_127_SB0B hi 0 0 0 vdd vdd m128_127_SB0B sky130_fd_sc_hd__nand2_1
Xm128_127_SB1B hi 0 0 0 vdd vdd m128_127_SB1B sky130_fd_sc_hd__nand2_1
Xm128_127_M m128_127_ob m128_127_SB0B m128_127_SB1B m128_127_REFB m128_127_oa m128_127_SA0B m128_127_SA1B m128_127_SA2B m128_127_REFA vdd 0 m128_127_VBIAS m128_127_C1 m128_127_PREA m128_127_XA m128_127_DUTA m128_127_PREB m128_127_XB m128_127_DUTB m128_127_VB 0 0 core
Xm128_127matA 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hi m128_127_XA m128_127_VB 0 u128
Xm128_127matB 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hi m128_127_XB m128_127_VB 0 u128

* --- t128_0: core
Xt128_0_ienn hi 0 0 vdd vdd t128_0_enn sky130_fd_sc_hd__inv_1
Xt128_0_is1n 0 0 0 vdd vdd t128_0_s1n sky130_fd_sc_hd__inv_1
Xt128_0_is0n 0 0 0 vdd vdd t128_0_s0n sky130_fd_sc_hd__inv_1
Xt128_0_PREA pre t128_0_enn 0 0 vdd vdd t128_0_PREA sky130_fd_sc_hd__nor2_1
Xt128_0_PREB pre t128_0_enn 0 0 vdd vdd t128_0_PREB sky130_fd_sc_hd__nor2_1
Xt128_0_VBIAS hi 0 0 vdd vdd t128_0_VBIAS sky130_fd_sc_hd__buf_2
Xt128_0_C1 hi 0 0 vdd vdd t128_0_C1 sky130_fd_sc_hd__buf_2
Xt128_0_DUTA hi t128_0_s1n 0 0 0 vdd vdd t128_0_DUTA sky130_fd_sc_hd__and3_1
Xt128_0_DUTB hi t128_0_s1n 0 0 0 vdd vdd t128_0_DUTB sky130_fd_sc_hd__and3_1
Xt128_0_REFA hi 0 0 0 vdd vdd t128_0_REFA sky130_fd_sc_hd__and2_1
Xt128_0_REFB hi 0 0 0 vdd vdd t128_0_REFB sky130_fd_sc_hd__and2_1
Xt128_0_SA0B hi 0 0 0 0 vdd vdd t128_0_SA0B sky130_fd_sc_hd__nand3_1
Xt128_0_SA1B hi 0 0 0 vdd vdd t128_0_SA1B sky130_fd_sc_hd__nand2_1
Xt128_0_SA2B hi 0 t128_0_s0n 0 0 vdd vdd t128_0_SA2B sky130_fd_sc_hd__nand3_1
Xt128_0_SB0B hi 0 0 0 vdd vdd t128_0_SB0B sky130_fd_sc_hd__nand2_1
Xt128_0_SB1B hi 0 0 0 vdd vdd t128_0_SB1B sky130_fd_sc_hd__nand2_1
Xt128_0_M t128_0_ob t128_0_SB0B t128_0_SB1B t128_0_REFB t128_0_oa t128_0_SA0B t128_0_SA1B t128_0_SA2B t128_0_REFA vdd 0 t128_0_VBIAS t128_0_C1 t128_0_PREA t128_0_XA t128_0_DUTA t128_0_PREB t128_0_XB t128_0_DUTB t128_0_VB 0 0 core
Xt128_0matA hi 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 t128_0_XA t128_0_VB 0 t128_0_GTm u128g
Xt128_0matB hi 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 t128_0_XB t128_0_VB 0 u128
Bt128_0gtm t128_0_GTm 0 V=v(t128_0_VB)+0.000305

.control
set noaskquit
save v(n1_oa) v(n1_ob) v(wc_oa) v(wc_ob) v(t1_oa) v(t1_ob) v(m128_0_oa) v(m128_0_ob) v(m128_127_oa) v(m128_127_ob) v(t128_0_oa) v(t128_0_ob)
tran 10n 120u
meas tran n1_oa when v(n1_oa)=0.9 rise=1
echo MX ss 85 n1_oa $&n1_oa
meas tran n1_ob when v(n1_ob)=0.9 rise=1
echo MX ss 85 n1_ob $&n1_ob
meas tran wc_oa when v(wc_oa)=0.9 rise=1
echo MX ss 85 wc_oa $&wc_oa
meas tran wc_ob when v(wc_ob)=0.9 rise=1
echo MX ss 85 wc_ob $&wc_ob
meas tran t1_oa when v(t1_oa)=0.9 rise=1
echo MX ss 85 t1_oa $&t1_oa
meas tran t1_ob when v(t1_ob)=0.9 rise=1
echo MX ss 85 t1_ob $&t1_ob
meas tran m128_0_oa when v(m128_0_oa)=0.9 rise=1
echo MX ss 85 m128_0_oa $&m128_0_oa
meas tran m128_0_ob when v(m128_0_ob)=0.9 rise=1
echo MX ss 85 m128_0_ob $&m128_0_ob
meas tran m128_127_oa when v(m128_127_oa)=0.9 rise=1
echo MX ss 85 m128_127_oa $&m128_127_oa
meas tran m128_127_ob when v(m128_127_ob)=0.9 rise=1
echo MX ss 85 m128_127_ob $&m128_127_ob
meas tran t128_0_oa when v(t128_0_oa)=0.9 rise=1
echo MX ss 85 t128_0_oa $&t128_0_oa
meas tran t128_0_ob when v(t128_0_ob)=0.9 rise=1
echo MX ss 85 t128_0_ob $&t128_0_ob
quit
.endc
.end
