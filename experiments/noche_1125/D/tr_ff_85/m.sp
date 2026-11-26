* MISFIT-03 etapa a · noche 1125 bloque D · esquina ff 85 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
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


* --- n32: core
Xn32_ienn hi 0 0 vdd vdd n32_enn sky130_fd_sc_hd__inv_1
Xn32_is1n 0 0 0 vdd vdd n32_s1n sky130_fd_sc_hd__inv_1
Xn32_is0n hi 0 0 vdd vdd n32_s0n sky130_fd_sc_hd__inv_1
Xn32_PREA pre n32_enn 0 0 vdd vdd n32_PREA sky130_fd_sc_hd__nor2_1
Xn32_PREB pre n32_enn 0 0 vdd vdd n32_PREB sky130_fd_sc_hd__nor2_1
Xn32_VBIAS hi 0 0 vdd vdd n32_VBIAS sky130_fd_sc_hd__buf_2
Xn32_C1 hi 0 0 vdd vdd n32_C1 sky130_fd_sc_hd__buf_2
Xn32_DUTA hi n32_s1n hi 0 0 vdd vdd n32_DUTA sky130_fd_sc_hd__and3_1
Xn32_DUTB hi n32_s1n hi 0 0 vdd vdd n32_DUTB sky130_fd_sc_hd__and3_1
Xn32_REFA hi 0 0 0 vdd vdd n32_REFA sky130_fd_sc_hd__and2_1
Xn32_REFB hi 0 0 0 vdd vdd n32_REFB sky130_fd_sc_hd__and2_1
Xn32_SA0B hi 0 hi 0 0 vdd vdd n32_SA0B sky130_fd_sc_hd__nand3_1
Xn32_SA1B hi 0 0 0 vdd vdd n32_SA1B sky130_fd_sc_hd__nand2_1
Xn32_SA2B hi 0 n32_s0n 0 0 vdd vdd n32_SA2B sky130_fd_sc_hd__nand3_1
Xn32_SB0B hi 0 0 0 vdd vdd n32_SB0B sky130_fd_sc_hd__nand2_1
Xn32_SB1B hi 0 0 0 vdd vdd n32_SB1B sky130_fd_sc_hd__nand2_1
Xn32_M n32_ob n32_SB0B n32_SB1B n32_REFB n32_oa n32_SA0B n32_SA1B n32_SA2B n32_REFA vdd 0 n32_VBIAS n32_C1 n32_PREA n32_XA n32_DUTA n32_PREB n32_XB n32_DUTB n32_VB 0 0 core
Xn32edA0 n32_XA n32_VB n32_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA0 0 0 n32_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA0_0 n32_mA0 0 0.00298f
Cn32eA0_1 n32_mA0 n32_XA 0.05981f
Cn32eA0_2 n32_mA0 vdd 0.00496f
Cn32eA0_3 n32_mA0 n32_VB 0.07228f
Cn32eA0_4 n32_mA0 0 0.19922f
Xn32edA1 n32_XA n32_VB n32_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA1 0 0 n32_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA1_0 n32_mA1 0 0.00298f
Cn32eA1_1 n32_mA1 n32_XA 0.05981f
Cn32eA1_2 n32_mA1 vdd 0.00496f
Cn32eA1_3 n32_mA1 n32_VB 0.07228f
Cn32eA1_4 n32_mA1 0 0.19922f
Xn32edA2 n32_XA n32_VB n32_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA2 0 0 n32_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA2_0 n32_mA2 0 0.00298f
Cn32eA2_1 n32_mA2 n32_XA 0.05981f
Cn32eA2_2 n32_mA2 vdd 0.00496f
Cn32eA2_3 n32_mA2 n32_VB 0.07228f
Cn32eA2_4 n32_mA2 0 0.19922f
Xn32edA3 n32_XA n32_VB n32_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA3 0 0 n32_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA3_0 n32_mA3 0 0.00298f
Cn32eA3_1 n32_mA3 n32_XA 0.05981f
Cn32eA3_2 n32_mA3 vdd 0.00496f
Cn32eA3_3 n32_mA3 n32_VB 0.07228f
Cn32eA3_4 n32_mA3 0 0.19922f
Xn32edA4 n32_XA n32_VB n32_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA4 0 0 n32_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA4_0 n32_mA4 0 0.00298f
Cn32eA4_1 n32_mA4 n32_XA 0.05981f
Cn32eA4_2 n32_mA4 vdd 0.00496f
Cn32eA4_3 n32_mA4 n32_VB 0.07228f
Cn32eA4_4 n32_mA4 0 0.19922f
Xn32edA5 n32_XA n32_VB n32_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA5 0 0 n32_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA5_0 n32_mA5 0 0.00298f
Cn32eA5_1 n32_mA5 n32_XA 0.05981f
Cn32eA5_2 n32_mA5 vdd 0.00496f
Cn32eA5_3 n32_mA5 n32_VB 0.07228f
Cn32eA5_4 n32_mA5 0 0.19922f
Xn32edA6 n32_XA n32_VB n32_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA6 0 0 n32_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA6_0 n32_mA6 0 0.00298f
Cn32eA6_1 n32_mA6 n32_XA 0.05981f
Cn32eA6_2 n32_mA6 vdd 0.00496f
Cn32eA6_3 n32_mA6 n32_VB 0.07228f
Cn32eA6_4 n32_mA6 0 0.19922f
Xn32edA7 n32_XA n32_VB n32_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA7 0 0 n32_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA7_0 n32_mA7 0 0.00298f
Cn32eA7_1 n32_mA7 n32_XA 0.05981f
Cn32eA7_2 n32_mA7 vdd 0.00496f
Cn32eA7_3 n32_mA7 n32_VB 0.07228f
Cn32eA7_4 n32_mA7 0 0.19922f
Xn32edA8 n32_XA n32_VB n32_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA8 0 0 n32_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA8_0 n32_mA8 0 0.00298f
Cn32eA8_1 n32_mA8 n32_XA 0.05981f
Cn32eA8_2 n32_mA8 vdd 0.00496f
Cn32eA8_3 n32_mA8 n32_VB 0.07228f
Cn32eA8_4 n32_mA8 0 0.19922f
Xn32edA9 n32_XA n32_VB n32_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA9 0 0 n32_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA9_0 n32_mA9 0 0.00298f
Cn32eA9_1 n32_mA9 n32_XA 0.05981f
Cn32eA9_2 n32_mA9 vdd 0.00496f
Cn32eA9_3 n32_mA9 n32_VB 0.07228f
Cn32eA9_4 n32_mA9 0 0.19922f
Xn32edA10 n32_XA n32_VB n32_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA10 0 0 n32_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA10_0 n32_mA10 0 0.00298f
Cn32eA10_1 n32_mA10 n32_XA 0.05981f
Cn32eA10_2 n32_mA10 vdd 0.00496f
Cn32eA10_3 n32_mA10 n32_VB 0.07228f
Cn32eA10_4 n32_mA10 0 0.19922f
Xn32edA11 n32_XA n32_VB n32_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA11 0 0 n32_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA11_0 n32_mA11 0 0.00298f
Cn32eA11_1 n32_mA11 n32_XA 0.05981f
Cn32eA11_2 n32_mA11 vdd 0.00496f
Cn32eA11_3 n32_mA11 n32_VB 0.07228f
Cn32eA11_4 n32_mA11 0 0.19922f
Xn32edA12 n32_XA n32_VB n32_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA12 0 0 n32_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA12_0 n32_mA12 0 0.00298f
Cn32eA12_1 n32_mA12 n32_XA 0.05981f
Cn32eA12_2 n32_mA12 vdd 0.00496f
Cn32eA12_3 n32_mA12 n32_VB 0.07228f
Cn32eA12_4 n32_mA12 0 0.19922f
Xn32edA13 n32_XA n32_VB n32_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA13 0 0 n32_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA13_0 n32_mA13 0 0.00298f
Cn32eA13_1 n32_mA13 n32_XA 0.05981f
Cn32eA13_2 n32_mA13 vdd 0.00496f
Cn32eA13_3 n32_mA13 n32_VB 0.07228f
Cn32eA13_4 n32_mA13 0 0.19922f
Xn32edA14 n32_XA n32_VB n32_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA14 0 0 n32_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA14_0 n32_mA14 0 0.00298f
Cn32eA14_1 n32_mA14 n32_XA 0.05981f
Cn32eA14_2 n32_mA14 vdd 0.00496f
Cn32eA14_3 n32_mA14 n32_VB 0.07228f
Cn32eA14_4 n32_mA14 0 0.19922f
Xn32edA15 n32_XA n32_VB n32_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA15 0 0 n32_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA15_0 n32_mA15 0 0.00298f
Cn32eA15_1 n32_mA15 n32_XA 0.05981f
Cn32eA15_2 n32_mA15 vdd 0.00496f
Cn32eA15_3 n32_mA15 n32_VB 0.07228f
Cn32eA15_4 n32_mA15 0 0.19922f
Xn32edA16 n32_XA n32_VB n32_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA16 0 0 n32_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA16_0 n32_mA16 0 0.00298f
Cn32eA16_1 n32_mA16 n32_XA 0.05981f
Cn32eA16_2 n32_mA16 vdd 0.00496f
Cn32eA16_3 n32_mA16 n32_VB 0.07228f
Cn32eA16_4 n32_mA16 0 0.19922f
Xn32edA17 n32_XA n32_VB n32_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA17 0 0 n32_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA17_0 n32_mA17 0 0.00298f
Cn32eA17_1 n32_mA17 n32_XA 0.05981f
Cn32eA17_2 n32_mA17 vdd 0.00496f
Cn32eA17_3 n32_mA17 n32_VB 0.07228f
Cn32eA17_4 n32_mA17 0 0.19922f
Xn32edA18 n32_XA n32_VB n32_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA18 0 0 n32_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA18_0 n32_mA18 0 0.00298f
Cn32eA18_1 n32_mA18 n32_XA 0.05981f
Cn32eA18_2 n32_mA18 vdd 0.00496f
Cn32eA18_3 n32_mA18 n32_VB 0.07228f
Cn32eA18_4 n32_mA18 0 0.19922f
Xn32edA19 n32_XA n32_VB n32_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA19 0 0 n32_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA19_0 n32_mA19 0 0.00298f
Cn32eA19_1 n32_mA19 n32_XA 0.05981f
Cn32eA19_2 n32_mA19 vdd 0.00496f
Cn32eA19_3 n32_mA19 n32_VB 0.07228f
Cn32eA19_4 n32_mA19 0 0.19922f
Xn32edA20 n32_XA n32_VB n32_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA20 0 0 n32_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA20_0 n32_mA20 0 0.00298f
Cn32eA20_1 n32_mA20 n32_XA 0.05981f
Cn32eA20_2 n32_mA20 vdd 0.00496f
Cn32eA20_3 n32_mA20 n32_VB 0.07228f
Cn32eA20_4 n32_mA20 0 0.19922f
Xn32edA21 n32_XA n32_VB n32_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA21 0 0 n32_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA21_0 n32_mA21 0 0.00298f
Cn32eA21_1 n32_mA21 n32_XA 0.05981f
Cn32eA21_2 n32_mA21 vdd 0.00496f
Cn32eA21_3 n32_mA21 n32_VB 0.07228f
Cn32eA21_4 n32_mA21 0 0.19922f
Xn32edA22 n32_XA n32_VB n32_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA22 0 0 n32_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA22_0 n32_mA22 0 0.00298f
Cn32eA22_1 n32_mA22 n32_XA 0.05981f
Cn32eA22_2 n32_mA22 vdd 0.00496f
Cn32eA22_3 n32_mA22 n32_VB 0.07228f
Cn32eA22_4 n32_mA22 0 0.19922f
Xn32edA23 n32_XA n32_VB n32_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA23 0 0 n32_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA23_0 n32_mA23 0 0.00298f
Cn32eA23_1 n32_mA23 n32_XA 0.05981f
Cn32eA23_2 n32_mA23 vdd 0.00496f
Cn32eA23_3 n32_mA23 n32_VB 0.07228f
Cn32eA23_4 n32_mA23 0 0.19922f
Xn32edA24 n32_XA n32_VB n32_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA24 0 0 n32_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA24_0 n32_mA24 0 0.00298f
Cn32eA24_1 n32_mA24 n32_XA 0.05981f
Cn32eA24_2 n32_mA24 vdd 0.00496f
Cn32eA24_3 n32_mA24 n32_VB 0.07228f
Cn32eA24_4 n32_mA24 0 0.19922f
Xn32edA25 n32_XA n32_VB n32_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA25 0 0 n32_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA25_0 n32_mA25 0 0.00298f
Cn32eA25_1 n32_mA25 n32_XA 0.05981f
Cn32eA25_2 n32_mA25 vdd 0.00496f
Cn32eA25_3 n32_mA25 n32_VB 0.07228f
Cn32eA25_4 n32_mA25 0 0.19922f
Xn32edA26 n32_XA n32_VB n32_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA26 0 0 n32_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA26_0 n32_mA26 0 0.00298f
Cn32eA26_1 n32_mA26 n32_XA 0.05981f
Cn32eA26_2 n32_mA26 vdd 0.00496f
Cn32eA26_3 n32_mA26 n32_VB 0.07228f
Cn32eA26_4 n32_mA26 0 0.19922f
Xn32edA27 n32_XA n32_VB n32_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA27 0 0 n32_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA27_0 n32_mA27 0 0.00298f
Cn32eA27_1 n32_mA27 n32_XA 0.05981f
Cn32eA27_2 n32_mA27 vdd 0.00496f
Cn32eA27_3 n32_mA27 n32_VB 0.07228f
Cn32eA27_4 n32_mA27 0 0.19922f
Xn32edA28 n32_XA n32_VB n32_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA28 0 0 n32_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA28_0 n32_mA28 0 0.00298f
Cn32eA28_1 n32_mA28 n32_XA 0.05981f
Cn32eA28_2 n32_mA28 vdd 0.00496f
Cn32eA28_3 n32_mA28 n32_VB 0.07228f
Cn32eA28_4 n32_mA28 0 0.19922f
Xn32edA29 n32_XA n32_VB n32_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA29 0 0 n32_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA29_0 n32_mA29 0 0.00298f
Cn32eA29_1 n32_mA29 n32_XA 0.05981f
Cn32eA29_2 n32_mA29 vdd 0.00496f
Cn32eA29_3 n32_mA29 n32_VB 0.07228f
Cn32eA29_4 n32_mA29 0 0.19922f
Xn32edA30 n32_XA n32_VB n32_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esA30 0 0 n32_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eA30_0 n32_mA30 0 0.00298f
Cn32eA30_1 n32_mA30 n32_XA 0.05981f
Cn32eA30_2 n32_mA30 vdd 0.00496f
Cn32eA30_3 n32_mA30 n32_VB 0.07228f
Cn32eA30_4 n32_mA30 0 0.19922f
Xn32edB0 n32_XB n32_VB n32_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB0 0 0 n32_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB0_0 n32_mB0 n32_XB 0.05778f
Cn32eB0_1 n32_mB0 vdd 0.00496f
Cn32eB0_2 n32_mB0 n32_VB 0.0654f
Cn32eB0_3 n32_mB0 0 0.00298f
Cn32eB0_4 n32_mB0 0 0.20468f
Xn32edB1 n32_XB n32_VB n32_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB1 0 0 n32_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB1_0 n32_mB1 n32_XB 0.05778f
Cn32eB1_1 n32_mB1 vdd 0.00496f
Cn32eB1_2 n32_mB1 n32_VB 0.0654f
Cn32eB1_3 n32_mB1 0 0.00298f
Cn32eB1_4 n32_mB1 0 0.20468f
Xn32edB2 n32_XB n32_VB n32_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB2 0 0 n32_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB2_0 n32_mB2 n32_XB 0.05778f
Cn32eB2_1 n32_mB2 vdd 0.00496f
Cn32eB2_2 n32_mB2 n32_VB 0.0654f
Cn32eB2_3 n32_mB2 0 0.00298f
Cn32eB2_4 n32_mB2 0 0.20468f
Xn32edB3 n32_XB n32_VB n32_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB3 0 0 n32_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB3_0 n32_mB3 n32_XB 0.05778f
Cn32eB3_1 n32_mB3 vdd 0.00496f
Cn32eB3_2 n32_mB3 n32_VB 0.0654f
Cn32eB3_3 n32_mB3 0 0.00298f
Cn32eB3_4 n32_mB3 0 0.20468f
Xn32edB4 n32_XB n32_VB n32_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB4 0 0 n32_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB4_0 n32_mB4 n32_XB 0.05778f
Cn32eB4_1 n32_mB4 vdd 0.00496f
Cn32eB4_2 n32_mB4 n32_VB 0.0654f
Cn32eB4_3 n32_mB4 0 0.00298f
Cn32eB4_4 n32_mB4 0 0.20468f
Xn32edB5 n32_XB n32_VB n32_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB5 0 0 n32_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB5_0 n32_mB5 n32_XB 0.05778f
Cn32eB5_1 n32_mB5 vdd 0.00496f
Cn32eB5_2 n32_mB5 n32_VB 0.0654f
Cn32eB5_3 n32_mB5 0 0.00298f
Cn32eB5_4 n32_mB5 0 0.20468f
Xn32edB6 n32_XB n32_VB n32_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB6 0 0 n32_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB6_0 n32_mB6 n32_XB 0.05778f
Cn32eB6_1 n32_mB6 vdd 0.00496f
Cn32eB6_2 n32_mB6 n32_VB 0.0654f
Cn32eB6_3 n32_mB6 0 0.00298f
Cn32eB6_4 n32_mB6 0 0.20468f
Xn32edB7 n32_XB n32_VB n32_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB7 0 0 n32_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB7_0 n32_mB7 n32_XB 0.05778f
Cn32eB7_1 n32_mB7 vdd 0.00496f
Cn32eB7_2 n32_mB7 n32_VB 0.0654f
Cn32eB7_3 n32_mB7 0 0.00298f
Cn32eB7_4 n32_mB7 0 0.20468f
Xn32edB8 n32_XB n32_VB n32_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB8 0 0 n32_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB8_0 n32_mB8 n32_XB 0.05778f
Cn32eB8_1 n32_mB8 vdd 0.00496f
Cn32eB8_2 n32_mB8 n32_VB 0.0654f
Cn32eB8_3 n32_mB8 0 0.00298f
Cn32eB8_4 n32_mB8 0 0.20468f
Xn32edB9 n32_XB n32_VB n32_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB9 0 0 n32_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB9_0 n32_mB9 n32_XB 0.05778f
Cn32eB9_1 n32_mB9 vdd 0.00496f
Cn32eB9_2 n32_mB9 n32_VB 0.0654f
Cn32eB9_3 n32_mB9 0 0.00298f
Cn32eB9_4 n32_mB9 0 0.20468f
Xn32edB10 n32_XB n32_VB n32_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB10 0 0 n32_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB10_0 n32_mB10 n32_XB 0.05778f
Cn32eB10_1 n32_mB10 vdd 0.00496f
Cn32eB10_2 n32_mB10 n32_VB 0.0654f
Cn32eB10_3 n32_mB10 0 0.00298f
Cn32eB10_4 n32_mB10 0 0.20468f
Xn32edB11 n32_XB n32_VB n32_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB11 0 0 n32_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB11_0 n32_mB11 n32_XB 0.05778f
Cn32eB11_1 n32_mB11 vdd 0.00496f
Cn32eB11_2 n32_mB11 n32_VB 0.0654f
Cn32eB11_3 n32_mB11 0 0.00298f
Cn32eB11_4 n32_mB11 0 0.20468f
Xn32edB12 n32_XB n32_VB n32_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB12 0 0 n32_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB12_0 n32_mB12 n32_XB 0.05778f
Cn32eB12_1 n32_mB12 vdd 0.00496f
Cn32eB12_2 n32_mB12 n32_VB 0.0654f
Cn32eB12_3 n32_mB12 0 0.00298f
Cn32eB12_4 n32_mB12 0 0.20468f
Xn32edB13 n32_XB n32_VB n32_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB13 0 0 n32_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB13_0 n32_mB13 n32_XB 0.05778f
Cn32eB13_1 n32_mB13 vdd 0.00496f
Cn32eB13_2 n32_mB13 n32_VB 0.0654f
Cn32eB13_3 n32_mB13 0 0.00298f
Cn32eB13_4 n32_mB13 0 0.20468f
Xn32edB14 n32_XB n32_VB n32_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB14 0 0 n32_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB14_0 n32_mB14 n32_XB 0.05778f
Cn32eB14_1 n32_mB14 vdd 0.00496f
Cn32eB14_2 n32_mB14 n32_VB 0.0654f
Cn32eB14_3 n32_mB14 0 0.00298f
Cn32eB14_4 n32_mB14 0 0.20468f
Xn32edB15 n32_XB n32_VB n32_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB15 0 0 n32_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB15_0 n32_mB15 n32_XB 0.05778f
Cn32eB15_1 n32_mB15 vdd 0.00496f
Cn32eB15_2 n32_mB15 n32_VB 0.0654f
Cn32eB15_3 n32_mB15 0 0.00298f
Cn32eB15_4 n32_mB15 0 0.20468f
Xn32edB16 n32_XB n32_VB n32_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB16 0 0 n32_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB16_0 n32_mB16 n32_XB 0.05778f
Cn32eB16_1 n32_mB16 vdd 0.00496f
Cn32eB16_2 n32_mB16 n32_VB 0.0654f
Cn32eB16_3 n32_mB16 0 0.00298f
Cn32eB16_4 n32_mB16 0 0.20468f
Xn32edB17 n32_XB n32_VB n32_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB17 0 0 n32_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB17_0 n32_mB17 n32_XB 0.05778f
Cn32eB17_1 n32_mB17 vdd 0.00496f
Cn32eB17_2 n32_mB17 n32_VB 0.0654f
Cn32eB17_3 n32_mB17 0 0.00298f
Cn32eB17_4 n32_mB17 0 0.20468f
Xn32edB18 n32_XB n32_VB n32_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB18 0 0 n32_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB18_0 n32_mB18 n32_XB 0.05778f
Cn32eB18_1 n32_mB18 vdd 0.00496f
Cn32eB18_2 n32_mB18 n32_VB 0.0654f
Cn32eB18_3 n32_mB18 0 0.00298f
Cn32eB18_4 n32_mB18 0 0.20468f
Xn32edB19 n32_XB n32_VB n32_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB19 0 0 n32_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB19_0 n32_mB19 n32_XB 0.05778f
Cn32eB19_1 n32_mB19 vdd 0.00496f
Cn32eB19_2 n32_mB19 n32_VB 0.0654f
Cn32eB19_3 n32_mB19 0 0.00298f
Cn32eB19_4 n32_mB19 0 0.20468f
Xn32edB20 n32_XB n32_VB n32_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB20 0 0 n32_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB20_0 n32_mB20 n32_XB 0.05778f
Cn32eB20_1 n32_mB20 vdd 0.00496f
Cn32eB20_2 n32_mB20 n32_VB 0.0654f
Cn32eB20_3 n32_mB20 0 0.00298f
Cn32eB20_4 n32_mB20 0 0.20468f
Xn32edB21 n32_XB n32_VB n32_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB21 0 0 n32_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB21_0 n32_mB21 n32_XB 0.05778f
Cn32eB21_1 n32_mB21 vdd 0.00496f
Cn32eB21_2 n32_mB21 n32_VB 0.0654f
Cn32eB21_3 n32_mB21 0 0.00298f
Cn32eB21_4 n32_mB21 0 0.20468f
Xn32edB22 n32_XB n32_VB n32_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB22 0 0 n32_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB22_0 n32_mB22 n32_XB 0.05778f
Cn32eB22_1 n32_mB22 vdd 0.00496f
Cn32eB22_2 n32_mB22 n32_VB 0.0654f
Cn32eB22_3 n32_mB22 0 0.00298f
Cn32eB22_4 n32_mB22 0 0.20468f
Xn32edB23 n32_XB n32_VB n32_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB23 0 0 n32_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB23_0 n32_mB23 n32_XB 0.05778f
Cn32eB23_1 n32_mB23 vdd 0.00496f
Cn32eB23_2 n32_mB23 n32_VB 0.0654f
Cn32eB23_3 n32_mB23 0 0.00298f
Cn32eB23_4 n32_mB23 0 0.20468f
Xn32edB24 n32_XB n32_VB n32_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB24 0 0 n32_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB24_0 n32_mB24 n32_XB 0.05778f
Cn32eB24_1 n32_mB24 vdd 0.00496f
Cn32eB24_2 n32_mB24 n32_VB 0.0654f
Cn32eB24_3 n32_mB24 0 0.00298f
Cn32eB24_4 n32_mB24 0 0.20468f
Xn32edB25 n32_XB n32_VB n32_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB25 0 0 n32_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB25_0 n32_mB25 n32_XB 0.05778f
Cn32eB25_1 n32_mB25 vdd 0.00496f
Cn32eB25_2 n32_mB25 n32_VB 0.0654f
Cn32eB25_3 n32_mB25 0 0.00298f
Cn32eB25_4 n32_mB25 0 0.20468f
Xn32edB26 n32_XB n32_VB n32_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB26 0 0 n32_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB26_0 n32_mB26 n32_XB 0.05778f
Cn32eB26_1 n32_mB26 vdd 0.00496f
Cn32eB26_2 n32_mB26 n32_VB 0.0654f
Cn32eB26_3 n32_mB26 0 0.00298f
Cn32eB26_4 n32_mB26 0 0.20468f
Xn32edB27 n32_XB n32_VB n32_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB27 0 0 n32_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB27_0 n32_mB27 n32_XB 0.05778f
Cn32eB27_1 n32_mB27 vdd 0.00496f
Cn32eB27_2 n32_mB27 n32_VB 0.0654f
Cn32eB27_3 n32_mB27 0 0.00298f
Cn32eB27_4 n32_mB27 0 0.20468f
Xn32edB28 n32_XB n32_VB n32_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB28 0 0 n32_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB28_0 n32_mB28 n32_XB 0.05778f
Cn32eB28_1 n32_mB28 vdd 0.00496f
Cn32eB28_2 n32_mB28 n32_VB 0.0654f
Cn32eB28_3 n32_mB28 0 0.00298f
Cn32eB28_4 n32_mB28 0 0.20468f
Xn32edB29 n32_XB n32_VB n32_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB29 0 0 n32_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB29_0 n32_mB29 n32_XB 0.05778f
Cn32eB29_1 n32_mB29 vdd 0.00496f
Cn32eB29_2 n32_mB29 n32_VB 0.0654f
Cn32eB29_3 n32_mB29 0 0.00298f
Cn32eB29_4 n32_mB29 0 0.20468f
Xn32edB30 n32_XB n32_VB n32_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn32esB30 0 0 n32_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn32eB30_0 n32_mB30 n32_XB 0.05778f
Cn32eB30_1 n32_mB30 vdd 0.00496f
Cn32eB30_2 n32_mB30 n32_VB 0.0654f
Cn32eB30_3 n32_mB30 0 0.00298f
Cn32eB30_4 n32_mB30 0 0.20468f

* --- n64: core
Xn64_ienn hi 0 0 vdd vdd n64_enn sky130_fd_sc_hd__inv_1
Xn64_is1n 0 0 0 vdd vdd n64_s1n sky130_fd_sc_hd__inv_1
Xn64_is0n hi 0 0 vdd vdd n64_s0n sky130_fd_sc_hd__inv_1
Xn64_PREA pre n64_enn 0 0 vdd vdd n64_PREA sky130_fd_sc_hd__nor2_1
Xn64_PREB pre n64_enn 0 0 vdd vdd n64_PREB sky130_fd_sc_hd__nor2_1
Xn64_VBIAS hi 0 0 vdd vdd n64_VBIAS sky130_fd_sc_hd__buf_2
Xn64_C1 hi 0 0 vdd vdd n64_C1 sky130_fd_sc_hd__buf_2
Xn64_DUTA hi n64_s1n hi 0 0 vdd vdd n64_DUTA sky130_fd_sc_hd__and3_1
Xn64_DUTB hi n64_s1n hi 0 0 vdd vdd n64_DUTB sky130_fd_sc_hd__and3_1
Xn64_REFA hi 0 0 0 vdd vdd n64_REFA sky130_fd_sc_hd__and2_1
Xn64_REFB hi 0 0 0 vdd vdd n64_REFB sky130_fd_sc_hd__and2_1
Xn64_SA0B hi 0 hi 0 0 vdd vdd n64_SA0B sky130_fd_sc_hd__nand3_1
Xn64_SA1B hi 0 0 0 vdd vdd n64_SA1B sky130_fd_sc_hd__nand2_1
Xn64_SA2B hi 0 n64_s0n 0 0 vdd vdd n64_SA2B sky130_fd_sc_hd__nand3_1
Xn64_SB0B hi 0 0 0 vdd vdd n64_SB0B sky130_fd_sc_hd__nand2_1
Xn64_SB1B hi 0 0 0 vdd vdd n64_SB1B sky130_fd_sc_hd__nand2_1
Xn64_M n64_ob n64_SB0B n64_SB1B n64_REFB n64_oa n64_SA0B n64_SA1B n64_SA2B n64_REFA vdd 0 n64_VBIAS n64_C1 n64_PREA n64_XA n64_DUTA n64_PREB n64_XB n64_DUTB n64_VB 0 0 core
Xn64edA0 n64_XA n64_VB n64_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA0 0 0 n64_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA0_0 n64_mA0 0 0.00298f
Cn64eA0_1 n64_mA0 n64_XA 0.05981f
Cn64eA0_2 n64_mA0 vdd 0.00496f
Cn64eA0_3 n64_mA0 n64_VB 0.07228f
Cn64eA0_4 n64_mA0 0 0.19922f
Xn64edA1 n64_XA n64_VB n64_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA1 0 0 n64_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA1_0 n64_mA1 0 0.00298f
Cn64eA1_1 n64_mA1 n64_XA 0.05981f
Cn64eA1_2 n64_mA1 vdd 0.00496f
Cn64eA1_3 n64_mA1 n64_VB 0.07228f
Cn64eA1_4 n64_mA1 0 0.19922f
Xn64edA2 n64_XA n64_VB n64_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA2 0 0 n64_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA2_0 n64_mA2 0 0.00298f
Cn64eA2_1 n64_mA2 n64_XA 0.05981f
Cn64eA2_2 n64_mA2 vdd 0.00496f
Cn64eA2_3 n64_mA2 n64_VB 0.07228f
Cn64eA2_4 n64_mA2 0 0.19922f
Xn64edA3 n64_XA n64_VB n64_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA3 0 0 n64_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA3_0 n64_mA3 0 0.00298f
Cn64eA3_1 n64_mA3 n64_XA 0.05981f
Cn64eA3_2 n64_mA3 vdd 0.00496f
Cn64eA3_3 n64_mA3 n64_VB 0.07228f
Cn64eA3_4 n64_mA3 0 0.19922f
Xn64edA4 n64_XA n64_VB n64_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA4 0 0 n64_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA4_0 n64_mA4 0 0.00298f
Cn64eA4_1 n64_mA4 n64_XA 0.05981f
Cn64eA4_2 n64_mA4 vdd 0.00496f
Cn64eA4_3 n64_mA4 n64_VB 0.07228f
Cn64eA4_4 n64_mA4 0 0.19922f
Xn64edA5 n64_XA n64_VB n64_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA5 0 0 n64_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA5_0 n64_mA5 0 0.00298f
Cn64eA5_1 n64_mA5 n64_XA 0.05981f
Cn64eA5_2 n64_mA5 vdd 0.00496f
Cn64eA5_3 n64_mA5 n64_VB 0.07228f
Cn64eA5_4 n64_mA5 0 0.19922f
Xn64edA6 n64_XA n64_VB n64_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA6 0 0 n64_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA6_0 n64_mA6 0 0.00298f
Cn64eA6_1 n64_mA6 n64_XA 0.05981f
Cn64eA6_2 n64_mA6 vdd 0.00496f
Cn64eA6_3 n64_mA6 n64_VB 0.07228f
Cn64eA6_4 n64_mA6 0 0.19922f
Xn64edA7 n64_XA n64_VB n64_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA7 0 0 n64_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA7_0 n64_mA7 0 0.00298f
Cn64eA7_1 n64_mA7 n64_XA 0.05981f
Cn64eA7_2 n64_mA7 vdd 0.00496f
Cn64eA7_3 n64_mA7 n64_VB 0.07228f
Cn64eA7_4 n64_mA7 0 0.19922f
Xn64edA8 n64_XA n64_VB n64_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA8 0 0 n64_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA8_0 n64_mA8 0 0.00298f
Cn64eA8_1 n64_mA8 n64_XA 0.05981f
Cn64eA8_2 n64_mA8 vdd 0.00496f
Cn64eA8_3 n64_mA8 n64_VB 0.07228f
Cn64eA8_4 n64_mA8 0 0.19922f
Xn64edA9 n64_XA n64_VB n64_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA9 0 0 n64_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA9_0 n64_mA9 0 0.00298f
Cn64eA9_1 n64_mA9 n64_XA 0.05981f
Cn64eA9_2 n64_mA9 vdd 0.00496f
Cn64eA9_3 n64_mA9 n64_VB 0.07228f
Cn64eA9_4 n64_mA9 0 0.19922f
Xn64edA10 n64_XA n64_VB n64_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA10 0 0 n64_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA10_0 n64_mA10 0 0.00298f
Cn64eA10_1 n64_mA10 n64_XA 0.05981f
Cn64eA10_2 n64_mA10 vdd 0.00496f
Cn64eA10_3 n64_mA10 n64_VB 0.07228f
Cn64eA10_4 n64_mA10 0 0.19922f
Xn64edA11 n64_XA n64_VB n64_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA11 0 0 n64_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA11_0 n64_mA11 0 0.00298f
Cn64eA11_1 n64_mA11 n64_XA 0.05981f
Cn64eA11_2 n64_mA11 vdd 0.00496f
Cn64eA11_3 n64_mA11 n64_VB 0.07228f
Cn64eA11_4 n64_mA11 0 0.19922f
Xn64edA12 n64_XA n64_VB n64_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA12 0 0 n64_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA12_0 n64_mA12 0 0.00298f
Cn64eA12_1 n64_mA12 n64_XA 0.05981f
Cn64eA12_2 n64_mA12 vdd 0.00496f
Cn64eA12_3 n64_mA12 n64_VB 0.07228f
Cn64eA12_4 n64_mA12 0 0.19922f
Xn64edA13 n64_XA n64_VB n64_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA13 0 0 n64_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA13_0 n64_mA13 0 0.00298f
Cn64eA13_1 n64_mA13 n64_XA 0.05981f
Cn64eA13_2 n64_mA13 vdd 0.00496f
Cn64eA13_3 n64_mA13 n64_VB 0.07228f
Cn64eA13_4 n64_mA13 0 0.19922f
Xn64edA14 n64_XA n64_VB n64_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA14 0 0 n64_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA14_0 n64_mA14 0 0.00298f
Cn64eA14_1 n64_mA14 n64_XA 0.05981f
Cn64eA14_2 n64_mA14 vdd 0.00496f
Cn64eA14_3 n64_mA14 n64_VB 0.07228f
Cn64eA14_4 n64_mA14 0 0.19922f
Xn64edA15 n64_XA n64_VB n64_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA15 0 0 n64_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA15_0 n64_mA15 0 0.00298f
Cn64eA15_1 n64_mA15 n64_XA 0.05981f
Cn64eA15_2 n64_mA15 vdd 0.00496f
Cn64eA15_3 n64_mA15 n64_VB 0.07228f
Cn64eA15_4 n64_mA15 0 0.19922f
Xn64edA16 n64_XA n64_VB n64_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA16 0 0 n64_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA16_0 n64_mA16 0 0.00298f
Cn64eA16_1 n64_mA16 n64_XA 0.05981f
Cn64eA16_2 n64_mA16 vdd 0.00496f
Cn64eA16_3 n64_mA16 n64_VB 0.07228f
Cn64eA16_4 n64_mA16 0 0.19922f
Xn64edA17 n64_XA n64_VB n64_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA17 0 0 n64_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA17_0 n64_mA17 0 0.00298f
Cn64eA17_1 n64_mA17 n64_XA 0.05981f
Cn64eA17_2 n64_mA17 vdd 0.00496f
Cn64eA17_3 n64_mA17 n64_VB 0.07228f
Cn64eA17_4 n64_mA17 0 0.19922f
Xn64edA18 n64_XA n64_VB n64_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA18 0 0 n64_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA18_0 n64_mA18 0 0.00298f
Cn64eA18_1 n64_mA18 n64_XA 0.05981f
Cn64eA18_2 n64_mA18 vdd 0.00496f
Cn64eA18_3 n64_mA18 n64_VB 0.07228f
Cn64eA18_4 n64_mA18 0 0.19922f
Xn64edA19 n64_XA n64_VB n64_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA19 0 0 n64_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA19_0 n64_mA19 0 0.00298f
Cn64eA19_1 n64_mA19 n64_XA 0.05981f
Cn64eA19_2 n64_mA19 vdd 0.00496f
Cn64eA19_3 n64_mA19 n64_VB 0.07228f
Cn64eA19_4 n64_mA19 0 0.19922f
Xn64edA20 n64_XA n64_VB n64_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA20 0 0 n64_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA20_0 n64_mA20 0 0.00298f
Cn64eA20_1 n64_mA20 n64_XA 0.05981f
Cn64eA20_2 n64_mA20 vdd 0.00496f
Cn64eA20_3 n64_mA20 n64_VB 0.07228f
Cn64eA20_4 n64_mA20 0 0.19922f
Xn64edA21 n64_XA n64_VB n64_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA21 0 0 n64_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA21_0 n64_mA21 0 0.00298f
Cn64eA21_1 n64_mA21 n64_XA 0.05981f
Cn64eA21_2 n64_mA21 vdd 0.00496f
Cn64eA21_3 n64_mA21 n64_VB 0.07228f
Cn64eA21_4 n64_mA21 0 0.19922f
Xn64edA22 n64_XA n64_VB n64_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA22 0 0 n64_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA22_0 n64_mA22 0 0.00298f
Cn64eA22_1 n64_mA22 n64_XA 0.05981f
Cn64eA22_2 n64_mA22 vdd 0.00496f
Cn64eA22_3 n64_mA22 n64_VB 0.07228f
Cn64eA22_4 n64_mA22 0 0.19922f
Xn64edA23 n64_XA n64_VB n64_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA23 0 0 n64_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA23_0 n64_mA23 0 0.00298f
Cn64eA23_1 n64_mA23 n64_XA 0.05981f
Cn64eA23_2 n64_mA23 vdd 0.00496f
Cn64eA23_3 n64_mA23 n64_VB 0.07228f
Cn64eA23_4 n64_mA23 0 0.19922f
Xn64edA24 n64_XA n64_VB n64_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA24 0 0 n64_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA24_0 n64_mA24 0 0.00298f
Cn64eA24_1 n64_mA24 n64_XA 0.05981f
Cn64eA24_2 n64_mA24 vdd 0.00496f
Cn64eA24_3 n64_mA24 n64_VB 0.07228f
Cn64eA24_4 n64_mA24 0 0.19922f
Xn64edA25 n64_XA n64_VB n64_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA25 0 0 n64_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA25_0 n64_mA25 0 0.00298f
Cn64eA25_1 n64_mA25 n64_XA 0.05981f
Cn64eA25_2 n64_mA25 vdd 0.00496f
Cn64eA25_3 n64_mA25 n64_VB 0.07228f
Cn64eA25_4 n64_mA25 0 0.19922f
Xn64edA26 n64_XA n64_VB n64_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA26 0 0 n64_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA26_0 n64_mA26 0 0.00298f
Cn64eA26_1 n64_mA26 n64_XA 0.05981f
Cn64eA26_2 n64_mA26 vdd 0.00496f
Cn64eA26_3 n64_mA26 n64_VB 0.07228f
Cn64eA26_4 n64_mA26 0 0.19922f
Xn64edA27 n64_XA n64_VB n64_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA27 0 0 n64_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA27_0 n64_mA27 0 0.00298f
Cn64eA27_1 n64_mA27 n64_XA 0.05981f
Cn64eA27_2 n64_mA27 vdd 0.00496f
Cn64eA27_3 n64_mA27 n64_VB 0.07228f
Cn64eA27_4 n64_mA27 0 0.19922f
Xn64edA28 n64_XA n64_VB n64_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA28 0 0 n64_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA28_0 n64_mA28 0 0.00298f
Cn64eA28_1 n64_mA28 n64_XA 0.05981f
Cn64eA28_2 n64_mA28 vdd 0.00496f
Cn64eA28_3 n64_mA28 n64_VB 0.07228f
Cn64eA28_4 n64_mA28 0 0.19922f
Xn64edA29 n64_XA n64_VB n64_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA29 0 0 n64_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA29_0 n64_mA29 0 0.00298f
Cn64eA29_1 n64_mA29 n64_XA 0.05981f
Cn64eA29_2 n64_mA29 vdd 0.00496f
Cn64eA29_3 n64_mA29 n64_VB 0.07228f
Cn64eA29_4 n64_mA29 0 0.19922f
Xn64edA30 n64_XA n64_VB n64_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA30 0 0 n64_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA30_0 n64_mA30 0 0.00298f
Cn64eA30_1 n64_mA30 n64_XA 0.05981f
Cn64eA30_2 n64_mA30 vdd 0.00496f
Cn64eA30_3 n64_mA30 n64_VB 0.07228f
Cn64eA30_4 n64_mA30 0 0.19922f
Xn64edA31 n64_XA n64_VB n64_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA31 0 0 n64_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA31_0 n64_mA31 0 0.00298f
Cn64eA31_1 n64_mA31 n64_XA 0.05981f
Cn64eA31_2 n64_mA31 vdd 0.00496f
Cn64eA31_3 n64_mA31 n64_VB 0.07228f
Cn64eA31_4 n64_mA31 0 0.19922f
Xn64edA32 n64_XA n64_VB n64_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA32 0 0 n64_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA32_0 n64_mA32 0 0.00298f
Cn64eA32_1 n64_mA32 n64_XA 0.05981f
Cn64eA32_2 n64_mA32 vdd 0.00496f
Cn64eA32_3 n64_mA32 n64_VB 0.07228f
Cn64eA32_4 n64_mA32 0 0.19922f
Xn64edA33 n64_XA n64_VB n64_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA33 0 0 n64_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA33_0 n64_mA33 0 0.00298f
Cn64eA33_1 n64_mA33 n64_XA 0.05981f
Cn64eA33_2 n64_mA33 vdd 0.00496f
Cn64eA33_3 n64_mA33 n64_VB 0.07228f
Cn64eA33_4 n64_mA33 0 0.19922f
Xn64edA34 n64_XA n64_VB n64_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA34 0 0 n64_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA34_0 n64_mA34 0 0.00298f
Cn64eA34_1 n64_mA34 n64_XA 0.05981f
Cn64eA34_2 n64_mA34 vdd 0.00496f
Cn64eA34_3 n64_mA34 n64_VB 0.07228f
Cn64eA34_4 n64_mA34 0 0.19922f
Xn64edA35 n64_XA n64_VB n64_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA35 0 0 n64_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA35_0 n64_mA35 0 0.00298f
Cn64eA35_1 n64_mA35 n64_XA 0.05981f
Cn64eA35_2 n64_mA35 vdd 0.00496f
Cn64eA35_3 n64_mA35 n64_VB 0.07228f
Cn64eA35_4 n64_mA35 0 0.19922f
Xn64edA36 n64_XA n64_VB n64_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA36 0 0 n64_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA36_0 n64_mA36 0 0.00298f
Cn64eA36_1 n64_mA36 n64_XA 0.05981f
Cn64eA36_2 n64_mA36 vdd 0.00496f
Cn64eA36_3 n64_mA36 n64_VB 0.07228f
Cn64eA36_4 n64_mA36 0 0.19922f
Xn64edA37 n64_XA n64_VB n64_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA37 0 0 n64_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA37_0 n64_mA37 0 0.00298f
Cn64eA37_1 n64_mA37 n64_XA 0.05981f
Cn64eA37_2 n64_mA37 vdd 0.00496f
Cn64eA37_3 n64_mA37 n64_VB 0.07228f
Cn64eA37_4 n64_mA37 0 0.19922f
Xn64edA38 n64_XA n64_VB n64_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA38 0 0 n64_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA38_0 n64_mA38 0 0.00298f
Cn64eA38_1 n64_mA38 n64_XA 0.05981f
Cn64eA38_2 n64_mA38 vdd 0.00496f
Cn64eA38_3 n64_mA38 n64_VB 0.07228f
Cn64eA38_4 n64_mA38 0 0.19922f
Xn64edA39 n64_XA n64_VB n64_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA39 0 0 n64_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA39_0 n64_mA39 0 0.00298f
Cn64eA39_1 n64_mA39 n64_XA 0.05981f
Cn64eA39_2 n64_mA39 vdd 0.00496f
Cn64eA39_3 n64_mA39 n64_VB 0.07228f
Cn64eA39_4 n64_mA39 0 0.19922f
Xn64edA40 n64_XA n64_VB n64_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA40 0 0 n64_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA40_0 n64_mA40 0 0.00298f
Cn64eA40_1 n64_mA40 n64_XA 0.05981f
Cn64eA40_2 n64_mA40 vdd 0.00496f
Cn64eA40_3 n64_mA40 n64_VB 0.07228f
Cn64eA40_4 n64_mA40 0 0.19922f
Xn64edA41 n64_XA n64_VB n64_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA41 0 0 n64_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA41_0 n64_mA41 0 0.00298f
Cn64eA41_1 n64_mA41 n64_XA 0.05981f
Cn64eA41_2 n64_mA41 vdd 0.00496f
Cn64eA41_3 n64_mA41 n64_VB 0.07228f
Cn64eA41_4 n64_mA41 0 0.19922f
Xn64edA42 n64_XA n64_VB n64_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA42 0 0 n64_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA42_0 n64_mA42 0 0.00298f
Cn64eA42_1 n64_mA42 n64_XA 0.05981f
Cn64eA42_2 n64_mA42 vdd 0.00496f
Cn64eA42_3 n64_mA42 n64_VB 0.07228f
Cn64eA42_4 n64_mA42 0 0.19922f
Xn64edA43 n64_XA n64_VB n64_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA43 0 0 n64_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA43_0 n64_mA43 0 0.00298f
Cn64eA43_1 n64_mA43 n64_XA 0.05981f
Cn64eA43_2 n64_mA43 vdd 0.00496f
Cn64eA43_3 n64_mA43 n64_VB 0.07228f
Cn64eA43_4 n64_mA43 0 0.19922f
Xn64edA44 n64_XA n64_VB n64_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA44 0 0 n64_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA44_0 n64_mA44 0 0.00298f
Cn64eA44_1 n64_mA44 n64_XA 0.05981f
Cn64eA44_2 n64_mA44 vdd 0.00496f
Cn64eA44_3 n64_mA44 n64_VB 0.07228f
Cn64eA44_4 n64_mA44 0 0.19922f
Xn64edA45 n64_XA n64_VB n64_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA45 0 0 n64_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA45_0 n64_mA45 0 0.00298f
Cn64eA45_1 n64_mA45 n64_XA 0.05981f
Cn64eA45_2 n64_mA45 vdd 0.00496f
Cn64eA45_3 n64_mA45 n64_VB 0.07228f
Cn64eA45_4 n64_mA45 0 0.19922f
Xn64edA46 n64_XA n64_VB n64_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA46 0 0 n64_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA46_0 n64_mA46 0 0.00298f
Cn64eA46_1 n64_mA46 n64_XA 0.05981f
Cn64eA46_2 n64_mA46 vdd 0.00496f
Cn64eA46_3 n64_mA46 n64_VB 0.07228f
Cn64eA46_4 n64_mA46 0 0.19922f
Xn64edA47 n64_XA n64_VB n64_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA47 0 0 n64_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA47_0 n64_mA47 0 0.00298f
Cn64eA47_1 n64_mA47 n64_XA 0.05981f
Cn64eA47_2 n64_mA47 vdd 0.00496f
Cn64eA47_3 n64_mA47 n64_VB 0.07228f
Cn64eA47_4 n64_mA47 0 0.19922f
Xn64edA48 n64_XA n64_VB n64_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA48 0 0 n64_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA48_0 n64_mA48 0 0.00298f
Cn64eA48_1 n64_mA48 n64_XA 0.05981f
Cn64eA48_2 n64_mA48 vdd 0.00496f
Cn64eA48_3 n64_mA48 n64_VB 0.07228f
Cn64eA48_4 n64_mA48 0 0.19922f
Xn64edA49 n64_XA n64_VB n64_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA49 0 0 n64_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA49_0 n64_mA49 0 0.00298f
Cn64eA49_1 n64_mA49 n64_XA 0.05981f
Cn64eA49_2 n64_mA49 vdd 0.00496f
Cn64eA49_3 n64_mA49 n64_VB 0.07228f
Cn64eA49_4 n64_mA49 0 0.19922f
Xn64edA50 n64_XA n64_VB n64_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA50 0 0 n64_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA50_0 n64_mA50 0 0.00298f
Cn64eA50_1 n64_mA50 n64_XA 0.05981f
Cn64eA50_2 n64_mA50 vdd 0.00496f
Cn64eA50_3 n64_mA50 n64_VB 0.07228f
Cn64eA50_4 n64_mA50 0 0.19922f
Xn64edA51 n64_XA n64_VB n64_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA51 0 0 n64_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA51_0 n64_mA51 0 0.00298f
Cn64eA51_1 n64_mA51 n64_XA 0.05981f
Cn64eA51_2 n64_mA51 vdd 0.00496f
Cn64eA51_3 n64_mA51 n64_VB 0.07228f
Cn64eA51_4 n64_mA51 0 0.19922f
Xn64edA52 n64_XA n64_VB n64_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA52 0 0 n64_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA52_0 n64_mA52 0 0.00298f
Cn64eA52_1 n64_mA52 n64_XA 0.05981f
Cn64eA52_2 n64_mA52 vdd 0.00496f
Cn64eA52_3 n64_mA52 n64_VB 0.07228f
Cn64eA52_4 n64_mA52 0 0.19922f
Xn64edA53 n64_XA n64_VB n64_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA53 0 0 n64_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA53_0 n64_mA53 0 0.00298f
Cn64eA53_1 n64_mA53 n64_XA 0.05981f
Cn64eA53_2 n64_mA53 vdd 0.00496f
Cn64eA53_3 n64_mA53 n64_VB 0.07228f
Cn64eA53_4 n64_mA53 0 0.19922f
Xn64edA54 n64_XA n64_VB n64_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA54 0 0 n64_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA54_0 n64_mA54 0 0.00298f
Cn64eA54_1 n64_mA54 n64_XA 0.05981f
Cn64eA54_2 n64_mA54 vdd 0.00496f
Cn64eA54_3 n64_mA54 n64_VB 0.07228f
Cn64eA54_4 n64_mA54 0 0.19922f
Xn64edA55 n64_XA n64_VB n64_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA55 0 0 n64_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA55_0 n64_mA55 0 0.00298f
Cn64eA55_1 n64_mA55 n64_XA 0.05981f
Cn64eA55_2 n64_mA55 vdd 0.00496f
Cn64eA55_3 n64_mA55 n64_VB 0.07228f
Cn64eA55_4 n64_mA55 0 0.19922f
Xn64edA56 n64_XA n64_VB n64_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA56 0 0 n64_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA56_0 n64_mA56 0 0.00298f
Cn64eA56_1 n64_mA56 n64_XA 0.05981f
Cn64eA56_2 n64_mA56 vdd 0.00496f
Cn64eA56_3 n64_mA56 n64_VB 0.07228f
Cn64eA56_4 n64_mA56 0 0.19922f
Xn64edA57 n64_XA n64_VB n64_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA57 0 0 n64_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA57_0 n64_mA57 0 0.00298f
Cn64eA57_1 n64_mA57 n64_XA 0.05981f
Cn64eA57_2 n64_mA57 vdd 0.00496f
Cn64eA57_3 n64_mA57 n64_VB 0.07228f
Cn64eA57_4 n64_mA57 0 0.19922f
Xn64edA58 n64_XA n64_VB n64_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA58 0 0 n64_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA58_0 n64_mA58 0 0.00298f
Cn64eA58_1 n64_mA58 n64_XA 0.05981f
Cn64eA58_2 n64_mA58 vdd 0.00496f
Cn64eA58_3 n64_mA58 n64_VB 0.07228f
Cn64eA58_4 n64_mA58 0 0.19922f
Xn64edA59 n64_XA n64_VB n64_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA59 0 0 n64_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA59_0 n64_mA59 0 0.00298f
Cn64eA59_1 n64_mA59 n64_XA 0.05981f
Cn64eA59_2 n64_mA59 vdd 0.00496f
Cn64eA59_3 n64_mA59 n64_VB 0.07228f
Cn64eA59_4 n64_mA59 0 0.19922f
Xn64edA60 n64_XA n64_VB n64_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA60 0 0 n64_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA60_0 n64_mA60 0 0.00298f
Cn64eA60_1 n64_mA60 n64_XA 0.05981f
Cn64eA60_2 n64_mA60 vdd 0.00496f
Cn64eA60_3 n64_mA60 n64_VB 0.07228f
Cn64eA60_4 n64_mA60 0 0.19922f
Xn64edA61 n64_XA n64_VB n64_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA61 0 0 n64_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA61_0 n64_mA61 0 0.00298f
Cn64eA61_1 n64_mA61 n64_XA 0.05981f
Cn64eA61_2 n64_mA61 vdd 0.00496f
Cn64eA61_3 n64_mA61 n64_VB 0.07228f
Cn64eA61_4 n64_mA61 0 0.19922f
Xn64edA62 n64_XA n64_VB n64_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esA62 0 0 n64_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eA62_0 n64_mA62 0 0.00298f
Cn64eA62_1 n64_mA62 n64_XA 0.05981f
Cn64eA62_2 n64_mA62 vdd 0.00496f
Cn64eA62_3 n64_mA62 n64_VB 0.07228f
Cn64eA62_4 n64_mA62 0 0.19922f
Xn64edB0 n64_XB n64_VB n64_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB0 0 0 n64_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB0_0 n64_mB0 n64_XB 0.05778f
Cn64eB0_1 n64_mB0 vdd 0.00496f
Cn64eB0_2 n64_mB0 n64_VB 0.0654f
Cn64eB0_3 n64_mB0 0 0.00298f
Cn64eB0_4 n64_mB0 0 0.20468f
Xn64edB1 n64_XB n64_VB n64_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB1 0 0 n64_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB1_0 n64_mB1 n64_XB 0.05778f
Cn64eB1_1 n64_mB1 vdd 0.00496f
Cn64eB1_2 n64_mB1 n64_VB 0.0654f
Cn64eB1_3 n64_mB1 0 0.00298f
Cn64eB1_4 n64_mB1 0 0.20468f
Xn64edB2 n64_XB n64_VB n64_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB2 0 0 n64_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB2_0 n64_mB2 n64_XB 0.05778f
Cn64eB2_1 n64_mB2 vdd 0.00496f
Cn64eB2_2 n64_mB2 n64_VB 0.0654f
Cn64eB2_3 n64_mB2 0 0.00298f
Cn64eB2_4 n64_mB2 0 0.20468f
Xn64edB3 n64_XB n64_VB n64_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB3 0 0 n64_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB3_0 n64_mB3 n64_XB 0.05778f
Cn64eB3_1 n64_mB3 vdd 0.00496f
Cn64eB3_2 n64_mB3 n64_VB 0.0654f
Cn64eB3_3 n64_mB3 0 0.00298f
Cn64eB3_4 n64_mB3 0 0.20468f
Xn64edB4 n64_XB n64_VB n64_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB4 0 0 n64_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB4_0 n64_mB4 n64_XB 0.05778f
Cn64eB4_1 n64_mB4 vdd 0.00496f
Cn64eB4_2 n64_mB4 n64_VB 0.0654f
Cn64eB4_3 n64_mB4 0 0.00298f
Cn64eB4_4 n64_mB4 0 0.20468f
Xn64edB5 n64_XB n64_VB n64_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB5 0 0 n64_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB5_0 n64_mB5 n64_XB 0.05778f
Cn64eB5_1 n64_mB5 vdd 0.00496f
Cn64eB5_2 n64_mB5 n64_VB 0.0654f
Cn64eB5_3 n64_mB5 0 0.00298f
Cn64eB5_4 n64_mB5 0 0.20468f
Xn64edB6 n64_XB n64_VB n64_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB6 0 0 n64_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB6_0 n64_mB6 n64_XB 0.05778f
Cn64eB6_1 n64_mB6 vdd 0.00496f
Cn64eB6_2 n64_mB6 n64_VB 0.0654f
Cn64eB6_3 n64_mB6 0 0.00298f
Cn64eB6_4 n64_mB6 0 0.20468f
Xn64edB7 n64_XB n64_VB n64_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB7 0 0 n64_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB7_0 n64_mB7 n64_XB 0.05778f
Cn64eB7_1 n64_mB7 vdd 0.00496f
Cn64eB7_2 n64_mB7 n64_VB 0.0654f
Cn64eB7_3 n64_mB7 0 0.00298f
Cn64eB7_4 n64_mB7 0 0.20468f
Xn64edB8 n64_XB n64_VB n64_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB8 0 0 n64_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB8_0 n64_mB8 n64_XB 0.05778f
Cn64eB8_1 n64_mB8 vdd 0.00496f
Cn64eB8_2 n64_mB8 n64_VB 0.0654f
Cn64eB8_3 n64_mB8 0 0.00298f
Cn64eB8_4 n64_mB8 0 0.20468f
Xn64edB9 n64_XB n64_VB n64_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB9 0 0 n64_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB9_0 n64_mB9 n64_XB 0.05778f
Cn64eB9_1 n64_mB9 vdd 0.00496f
Cn64eB9_2 n64_mB9 n64_VB 0.0654f
Cn64eB9_3 n64_mB9 0 0.00298f
Cn64eB9_4 n64_mB9 0 0.20468f
Xn64edB10 n64_XB n64_VB n64_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB10 0 0 n64_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB10_0 n64_mB10 n64_XB 0.05778f
Cn64eB10_1 n64_mB10 vdd 0.00496f
Cn64eB10_2 n64_mB10 n64_VB 0.0654f
Cn64eB10_3 n64_mB10 0 0.00298f
Cn64eB10_4 n64_mB10 0 0.20468f
Xn64edB11 n64_XB n64_VB n64_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB11 0 0 n64_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB11_0 n64_mB11 n64_XB 0.05778f
Cn64eB11_1 n64_mB11 vdd 0.00496f
Cn64eB11_2 n64_mB11 n64_VB 0.0654f
Cn64eB11_3 n64_mB11 0 0.00298f
Cn64eB11_4 n64_mB11 0 0.20468f
Xn64edB12 n64_XB n64_VB n64_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB12 0 0 n64_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB12_0 n64_mB12 n64_XB 0.05778f
Cn64eB12_1 n64_mB12 vdd 0.00496f
Cn64eB12_2 n64_mB12 n64_VB 0.0654f
Cn64eB12_3 n64_mB12 0 0.00298f
Cn64eB12_4 n64_mB12 0 0.20468f
Xn64edB13 n64_XB n64_VB n64_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB13 0 0 n64_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB13_0 n64_mB13 n64_XB 0.05778f
Cn64eB13_1 n64_mB13 vdd 0.00496f
Cn64eB13_2 n64_mB13 n64_VB 0.0654f
Cn64eB13_3 n64_mB13 0 0.00298f
Cn64eB13_4 n64_mB13 0 0.20468f
Xn64edB14 n64_XB n64_VB n64_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB14 0 0 n64_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB14_0 n64_mB14 n64_XB 0.05778f
Cn64eB14_1 n64_mB14 vdd 0.00496f
Cn64eB14_2 n64_mB14 n64_VB 0.0654f
Cn64eB14_3 n64_mB14 0 0.00298f
Cn64eB14_4 n64_mB14 0 0.20468f
Xn64edB15 n64_XB n64_VB n64_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB15 0 0 n64_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB15_0 n64_mB15 n64_XB 0.05778f
Cn64eB15_1 n64_mB15 vdd 0.00496f
Cn64eB15_2 n64_mB15 n64_VB 0.0654f
Cn64eB15_3 n64_mB15 0 0.00298f
Cn64eB15_4 n64_mB15 0 0.20468f
Xn64edB16 n64_XB n64_VB n64_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB16 0 0 n64_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB16_0 n64_mB16 n64_XB 0.05778f
Cn64eB16_1 n64_mB16 vdd 0.00496f
Cn64eB16_2 n64_mB16 n64_VB 0.0654f
Cn64eB16_3 n64_mB16 0 0.00298f
Cn64eB16_4 n64_mB16 0 0.20468f
Xn64edB17 n64_XB n64_VB n64_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB17 0 0 n64_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB17_0 n64_mB17 n64_XB 0.05778f
Cn64eB17_1 n64_mB17 vdd 0.00496f
Cn64eB17_2 n64_mB17 n64_VB 0.0654f
Cn64eB17_3 n64_mB17 0 0.00298f
Cn64eB17_4 n64_mB17 0 0.20468f
Xn64edB18 n64_XB n64_VB n64_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB18 0 0 n64_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB18_0 n64_mB18 n64_XB 0.05778f
Cn64eB18_1 n64_mB18 vdd 0.00496f
Cn64eB18_2 n64_mB18 n64_VB 0.0654f
Cn64eB18_3 n64_mB18 0 0.00298f
Cn64eB18_4 n64_mB18 0 0.20468f
Xn64edB19 n64_XB n64_VB n64_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB19 0 0 n64_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB19_0 n64_mB19 n64_XB 0.05778f
Cn64eB19_1 n64_mB19 vdd 0.00496f
Cn64eB19_2 n64_mB19 n64_VB 0.0654f
Cn64eB19_3 n64_mB19 0 0.00298f
Cn64eB19_4 n64_mB19 0 0.20468f
Xn64edB20 n64_XB n64_VB n64_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB20 0 0 n64_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB20_0 n64_mB20 n64_XB 0.05778f
Cn64eB20_1 n64_mB20 vdd 0.00496f
Cn64eB20_2 n64_mB20 n64_VB 0.0654f
Cn64eB20_3 n64_mB20 0 0.00298f
Cn64eB20_4 n64_mB20 0 0.20468f
Xn64edB21 n64_XB n64_VB n64_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB21 0 0 n64_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB21_0 n64_mB21 n64_XB 0.05778f
Cn64eB21_1 n64_mB21 vdd 0.00496f
Cn64eB21_2 n64_mB21 n64_VB 0.0654f
Cn64eB21_3 n64_mB21 0 0.00298f
Cn64eB21_4 n64_mB21 0 0.20468f
Xn64edB22 n64_XB n64_VB n64_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB22 0 0 n64_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB22_0 n64_mB22 n64_XB 0.05778f
Cn64eB22_1 n64_mB22 vdd 0.00496f
Cn64eB22_2 n64_mB22 n64_VB 0.0654f
Cn64eB22_3 n64_mB22 0 0.00298f
Cn64eB22_4 n64_mB22 0 0.20468f
Xn64edB23 n64_XB n64_VB n64_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB23 0 0 n64_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB23_0 n64_mB23 n64_XB 0.05778f
Cn64eB23_1 n64_mB23 vdd 0.00496f
Cn64eB23_2 n64_mB23 n64_VB 0.0654f
Cn64eB23_3 n64_mB23 0 0.00298f
Cn64eB23_4 n64_mB23 0 0.20468f
Xn64edB24 n64_XB n64_VB n64_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB24 0 0 n64_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB24_0 n64_mB24 n64_XB 0.05778f
Cn64eB24_1 n64_mB24 vdd 0.00496f
Cn64eB24_2 n64_mB24 n64_VB 0.0654f
Cn64eB24_3 n64_mB24 0 0.00298f
Cn64eB24_4 n64_mB24 0 0.20468f
Xn64edB25 n64_XB n64_VB n64_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB25 0 0 n64_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB25_0 n64_mB25 n64_XB 0.05778f
Cn64eB25_1 n64_mB25 vdd 0.00496f
Cn64eB25_2 n64_mB25 n64_VB 0.0654f
Cn64eB25_3 n64_mB25 0 0.00298f
Cn64eB25_4 n64_mB25 0 0.20468f
Xn64edB26 n64_XB n64_VB n64_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB26 0 0 n64_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB26_0 n64_mB26 n64_XB 0.05778f
Cn64eB26_1 n64_mB26 vdd 0.00496f
Cn64eB26_2 n64_mB26 n64_VB 0.0654f
Cn64eB26_3 n64_mB26 0 0.00298f
Cn64eB26_4 n64_mB26 0 0.20468f
Xn64edB27 n64_XB n64_VB n64_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB27 0 0 n64_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB27_0 n64_mB27 n64_XB 0.05778f
Cn64eB27_1 n64_mB27 vdd 0.00496f
Cn64eB27_2 n64_mB27 n64_VB 0.0654f
Cn64eB27_3 n64_mB27 0 0.00298f
Cn64eB27_4 n64_mB27 0 0.20468f
Xn64edB28 n64_XB n64_VB n64_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB28 0 0 n64_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB28_0 n64_mB28 n64_XB 0.05778f
Cn64eB28_1 n64_mB28 vdd 0.00496f
Cn64eB28_2 n64_mB28 n64_VB 0.0654f
Cn64eB28_3 n64_mB28 0 0.00298f
Cn64eB28_4 n64_mB28 0 0.20468f
Xn64edB29 n64_XB n64_VB n64_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB29 0 0 n64_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB29_0 n64_mB29 n64_XB 0.05778f
Cn64eB29_1 n64_mB29 vdd 0.00496f
Cn64eB29_2 n64_mB29 n64_VB 0.0654f
Cn64eB29_3 n64_mB29 0 0.00298f
Cn64eB29_4 n64_mB29 0 0.20468f
Xn64edB30 n64_XB n64_VB n64_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB30 0 0 n64_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB30_0 n64_mB30 n64_XB 0.05778f
Cn64eB30_1 n64_mB30 vdd 0.00496f
Cn64eB30_2 n64_mB30 n64_VB 0.0654f
Cn64eB30_3 n64_mB30 0 0.00298f
Cn64eB30_4 n64_mB30 0 0.20468f
Xn64edB31 n64_XB n64_VB n64_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB31 0 0 n64_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB31_0 n64_mB31 n64_XB 0.05778f
Cn64eB31_1 n64_mB31 vdd 0.00496f
Cn64eB31_2 n64_mB31 n64_VB 0.0654f
Cn64eB31_3 n64_mB31 0 0.00298f
Cn64eB31_4 n64_mB31 0 0.20468f
Xn64edB32 n64_XB n64_VB n64_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB32 0 0 n64_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB32_0 n64_mB32 n64_XB 0.05778f
Cn64eB32_1 n64_mB32 vdd 0.00496f
Cn64eB32_2 n64_mB32 n64_VB 0.0654f
Cn64eB32_3 n64_mB32 0 0.00298f
Cn64eB32_4 n64_mB32 0 0.20468f
Xn64edB33 n64_XB n64_VB n64_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB33 0 0 n64_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB33_0 n64_mB33 n64_XB 0.05778f
Cn64eB33_1 n64_mB33 vdd 0.00496f
Cn64eB33_2 n64_mB33 n64_VB 0.0654f
Cn64eB33_3 n64_mB33 0 0.00298f
Cn64eB33_4 n64_mB33 0 0.20468f
Xn64edB34 n64_XB n64_VB n64_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB34 0 0 n64_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB34_0 n64_mB34 n64_XB 0.05778f
Cn64eB34_1 n64_mB34 vdd 0.00496f
Cn64eB34_2 n64_mB34 n64_VB 0.0654f
Cn64eB34_3 n64_mB34 0 0.00298f
Cn64eB34_4 n64_mB34 0 0.20468f
Xn64edB35 n64_XB n64_VB n64_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB35 0 0 n64_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB35_0 n64_mB35 n64_XB 0.05778f
Cn64eB35_1 n64_mB35 vdd 0.00496f
Cn64eB35_2 n64_mB35 n64_VB 0.0654f
Cn64eB35_3 n64_mB35 0 0.00298f
Cn64eB35_4 n64_mB35 0 0.20468f
Xn64edB36 n64_XB n64_VB n64_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB36 0 0 n64_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB36_0 n64_mB36 n64_XB 0.05778f
Cn64eB36_1 n64_mB36 vdd 0.00496f
Cn64eB36_2 n64_mB36 n64_VB 0.0654f
Cn64eB36_3 n64_mB36 0 0.00298f
Cn64eB36_4 n64_mB36 0 0.20468f
Xn64edB37 n64_XB n64_VB n64_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB37 0 0 n64_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB37_0 n64_mB37 n64_XB 0.05778f
Cn64eB37_1 n64_mB37 vdd 0.00496f
Cn64eB37_2 n64_mB37 n64_VB 0.0654f
Cn64eB37_3 n64_mB37 0 0.00298f
Cn64eB37_4 n64_mB37 0 0.20468f
Xn64edB38 n64_XB n64_VB n64_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB38 0 0 n64_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB38_0 n64_mB38 n64_XB 0.05778f
Cn64eB38_1 n64_mB38 vdd 0.00496f
Cn64eB38_2 n64_mB38 n64_VB 0.0654f
Cn64eB38_3 n64_mB38 0 0.00298f
Cn64eB38_4 n64_mB38 0 0.20468f
Xn64edB39 n64_XB n64_VB n64_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB39 0 0 n64_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB39_0 n64_mB39 n64_XB 0.05778f
Cn64eB39_1 n64_mB39 vdd 0.00496f
Cn64eB39_2 n64_mB39 n64_VB 0.0654f
Cn64eB39_3 n64_mB39 0 0.00298f
Cn64eB39_4 n64_mB39 0 0.20468f
Xn64edB40 n64_XB n64_VB n64_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB40 0 0 n64_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB40_0 n64_mB40 n64_XB 0.05778f
Cn64eB40_1 n64_mB40 vdd 0.00496f
Cn64eB40_2 n64_mB40 n64_VB 0.0654f
Cn64eB40_3 n64_mB40 0 0.00298f
Cn64eB40_4 n64_mB40 0 0.20468f
Xn64edB41 n64_XB n64_VB n64_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB41 0 0 n64_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB41_0 n64_mB41 n64_XB 0.05778f
Cn64eB41_1 n64_mB41 vdd 0.00496f
Cn64eB41_2 n64_mB41 n64_VB 0.0654f
Cn64eB41_3 n64_mB41 0 0.00298f
Cn64eB41_4 n64_mB41 0 0.20468f
Xn64edB42 n64_XB n64_VB n64_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB42 0 0 n64_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB42_0 n64_mB42 n64_XB 0.05778f
Cn64eB42_1 n64_mB42 vdd 0.00496f
Cn64eB42_2 n64_mB42 n64_VB 0.0654f
Cn64eB42_3 n64_mB42 0 0.00298f
Cn64eB42_4 n64_mB42 0 0.20468f
Xn64edB43 n64_XB n64_VB n64_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB43 0 0 n64_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB43_0 n64_mB43 n64_XB 0.05778f
Cn64eB43_1 n64_mB43 vdd 0.00496f
Cn64eB43_2 n64_mB43 n64_VB 0.0654f
Cn64eB43_3 n64_mB43 0 0.00298f
Cn64eB43_4 n64_mB43 0 0.20468f
Xn64edB44 n64_XB n64_VB n64_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB44 0 0 n64_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB44_0 n64_mB44 n64_XB 0.05778f
Cn64eB44_1 n64_mB44 vdd 0.00496f
Cn64eB44_2 n64_mB44 n64_VB 0.0654f
Cn64eB44_3 n64_mB44 0 0.00298f
Cn64eB44_4 n64_mB44 0 0.20468f
Xn64edB45 n64_XB n64_VB n64_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB45 0 0 n64_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB45_0 n64_mB45 n64_XB 0.05778f
Cn64eB45_1 n64_mB45 vdd 0.00496f
Cn64eB45_2 n64_mB45 n64_VB 0.0654f
Cn64eB45_3 n64_mB45 0 0.00298f
Cn64eB45_4 n64_mB45 0 0.20468f
Xn64edB46 n64_XB n64_VB n64_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB46 0 0 n64_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB46_0 n64_mB46 n64_XB 0.05778f
Cn64eB46_1 n64_mB46 vdd 0.00496f
Cn64eB46_2 n64_mB46 n64_VB 0.0654f
Cn64eB46_3 n64_mB46 0 0.00298f
Cn64eB46_4 n64_mB46 0 0.20468f
Xn64edB47 n64_XB n64_VB n64_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB47 0 0 n64_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB47_0 n64_mB47 n64_XB 0.05778f
Cn64eB47_1 n64_mB47 vdd 0.00496f
Cn64eB47_2 n64_mB47 n64_VB 0.0654f
Cn64eB47_3 n64_mB47 0 0.00298f
Cn64eB47_4 n64_mB47 0 0.20468f
Xn64edB48 n64_XB n64_VB n64_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB48 0 0 n64_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB48_0 n64_mB48 n64_XB 0.05778f
Cn64eB48_1 n64_mB48 vdd 0.00496f
Cn64eB48_2 n64_mB48 n64_VB 0.0654f
Cn64eB48_3 n64_mB48 0 0.00298f
Cn64eB48_4 n64_mB48 0 0.20468f
Xn64edB49 n64_XB n64_VB n64_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB49 0 0 n64_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB49_0 n64_mB49 n64_XB 0.05778f
Cn64eB49_1 n64_mB49 vdd 0.00496f
Cn64eB49_2 n64_mB49 n64_VB 0.0654f
Cn64eB49_3 n64_mB49 0 0.00298f
Cn64eB49_4 n64_mB49 0 0.20468f
Xn64edB50 n64_XB n64_VB n64_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB50 0 0 n64_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB50_0 n64_mB50 n64_XB 0.05778f
Cn64eB50_1 n64_mB50 vdd 0.00496f
Cn64eB50_2 n64_mB50 n64_VB 0.0654f
Cn64eB50_3 n64_mB50 0 0.00298f
Cn64eB50_4 n64_mB50 0 0.20468f
Xn64edB51 n64_XB n64_VB n64_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB51 0 0 n64_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB51_0 n64_mB51 n64_XB 0.05778f
Cn64eB51_1 n64_mB51 vdd 0.00496f
Cn64eB51_2 n64_mB51 n64_VB 0.0654f
Cn64eB51_3 n64_mB51 0 0.00298f
Cn64eB51_4 n64_mB51 0 0.20468f
Xn64edB52 n64_XB n64_VB n64_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB52 0 0 n64_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB52_0 n64_mB52 n64_XB 0.05778f
Cn64eB52_1 n64_mB52 vdd 0.00496f
Cn64eB52_2 n64_mB52 n64_VB 0.0654f
Cn64eB52_3 n64_mB52 0 0.00298f
Cn64eB52_4 n64_mB52 0 0.20468f
Xn64edB53 n64_XB n64_VB n64_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB53 0 0 n64_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB53_0 n64_mB53 n64_XB 0.05778f
Cn64eB53_1 n64_mB53 vdd 0.00496f
Cn64eB53_2 n64_mB53 n64_VB 0.0654f
Cn64eB53_3 n64_mB53 0 0.00298f
Cn64eB53_4 n64_mB53 0 0.20468f
Xn64edB54 n64_XB n64_VB n64_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB54 0 0 n64_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB54_0 n64_mB54 n64_XB 0.05778f
Cn64eB54_1 n64_mB54 vdd 0.00496f
Cn64eB54_2 n64_mB54 n64_VB 0.0654f
Cn64eB54_3 n64_mB54 0 0.00298f
Cn64eB54_4 n64_mB54 0 0.20468f
Xn64edB55 n64_XB n64_VB n64_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB55 0 0 n64_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB55_0 n64_mB55 n64_XB 0.05778f
Cn64eB55_1 n64_mB55 vdd 0.00496f
Cn64eB55_2 n64_mB55 n64_VB 0.0654f
Cn64eB55_3 n64_mB55 0 0.00298f
Cn64eB55_4 n64_mB55 0 0.20468f
Xn64edB56 n64_XB n64_VB n64_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB56 0 0 n64_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB56_0 n64_mB56 n64_XB 0.05778f
Cn64eB56_1 n64_mB56 vdd 0.00496f
Cn64eB56_2 n64_mB56 n64_VB 0.0654f
Cn64eB56_3 n64_mB56 0 0.00298f
Cn64eB56_4 n64_mB56 0 0.20468f
Xn64edB57 n64_XB n64_VB n64_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB57 0 0 n64_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB57_0 n64_mB57 n64_XB 0.05778f
Cn64eB57_1 n64_mB57 vdd 0.00496f
Cn64eB57_2 n64_mB57 n64_VB 0.0654f
Cn64eB57_3 n64_mB57 0 0.00298f
Cn64eB57_4 n64_mB57 0 0.20468f
Xn64edB58 n64_XB n64_VB n64_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB58 0 0 n64_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB58_0 n64_mB58 n64_XB 0.05778f
Cn64eB58_1 n64_mB58 vdd 0.00496f
Cn64eB58_2 n64_mB58 n64_VB 0.0654f
Cn64eB58_3 n64_mB58 0 0.00298f
Cn64eB58_4 n64_mB58 0 0.20468f
Xn64edB59 n64_XB n64_VB n64_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB59 0 0 n64_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB59_0 n64_mB59 n64_XB 0.05778f
Cn64eB59_1 n64_mB59 vdd 0.00496f
Cn64eB59_2 n64_mB59 n64_VB 0.0654f
Cn64eB59_3 n64_mB59 0 0.00298f
Cn64eB59_4 n64_mB59 0 0.20468f
Xn64edB60 n64_XB n64_VB n64_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB60 0 0 n64_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB60_0 n64_mB60 n64_XB 0.05778f
Cn64eB60_1 n64_mB60 vdd 0.00496f
Cn64eB60_2 n64_mB60 n64_VB 0.0654f
Cn64eB60_3 n64_mB60 0 0.00298f
Cn64eB60_4 n64_mB60 0 0.20468f
Xn64edB61 n64_XB n64_VB n64_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB61 0 0 n64_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB61_0 n64_mB61 n64_XB 0.05778f
Cn64eB61_1 n64_mB61 vdd 0.00496f
Cn64eB61_2 n64_mB61 n64_VB 0.0654f
Cn64eB61_3 n64_mB61 0 0.00298f
Cn64eB61_4 n64_mB61 0 0.20468f
Xn64edB62 n64_XB n64_VB n64_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn64esB62 0 0 n64_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn64eB62_0 n64_mB62 n64_XB 0.05778f
Cn64eB62_1 n64_mB62 vdd 0.00496f
Cn64eB62_2 n64_mB62 n64_VB 0.0654f
Cn64eB62_3 n64_mB62 0 0.00298f
Cn64eB62_4 n64_mB62 0 0.20468f

* --- n128: core
Xn128_ienn hi 0 0 vdd vdd n128_enn sky130_fd_sc_hd__inv_1
Xn128_is1n 0 0 0 vdd vdd n128_s1n sky130_fd_sc_hd__inv_1
Xn128_is0n hi 0 0 vdd vdd n128_s0n sky130_fd_sc_hd__inv_1
Xn128_PREA pre n128_enn 0 0 vdd vdd n128_PREA sky130_fd_sc_hd__nor2_1
Xn128_PREB pre n128_enn 0 0 vdd vdd n128_PREB sky130_fd_sc_hd__nor2_1
Xn128_VBIAS hi 0 0 vdd vdd n128_VBIAS sky130_fd_sc_hd__buf_2
Xn128_C1 hi 0 0 vdd vdd n128_C1 sky130_fd_sc_hd__buf_2
Xn128_DUTA hi n128_s1n hi 0 0 vdd vdd n128_DUTA sky130_fd_sc_hd__and3_1
Xn128_DUTB hi n128_s1n hi 0 0 vdd vdd n128_DUTB sky130_fd_sc_hd__and3_1
Xn128_REFA hi 0 0 0 vdd vdd n128_REFA sky130_fd_sc_hd__and2_1
Xn128_REFB hi 0 0 0 vdd vdd n128_REFB sky130_fd_sc_hd__and2_1
Xn128_SA0B hi 0 hi 0 0 vdd vdd n128_SA0B sky130_fd_sc_hd__nand3_1
Xn128_SA1B hi 0 0 0 vdd vdd n128_SA1B sky130_fd_sc_hd__nand2_1
Xn128_SA2B hi 0 n128_s0n 0 0 vdd vdd n128_SA2B sky130_fd_sc_hd__nand3_1
Xn128_SB0B hi 0 0 0 vdd vdd n128_SB0B sky130_fd_sc_hd__nand2_1
Xn128_SB1B hi 0 0 0 vdd vdd n128_SB1B sky130_fd_sc_hd__nand2_1
Xn128_M n128_ob n128_SB0B n128_SB1B n128_REFB n128_oa n128_SA0B n128_SA1B n128_SA2B n128_REFA vdd 0 n128_VBIAS n128_C1 n128_PREA n128_XA n128_DUTA n128_PREB n128_XB n128_DUTB n128_VB 0 0 core
Xn128edA0 n128_XA n128_VB n128_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA0 0 0 n128_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA0_0 n128_mA0 0 0.00298f
Cn128eA0_1 n128_mA0 n128_XA 0.05981f
Cn128eA0_2 n128_mA0 vdd 0.00496f
Cn128eA0_3 n128_mA0 n128_VB 0.07228f
Cn128eA0_4 n128_mA0 0 0.19922f
Xn128edA1 n128_XA n128_VB n128_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA1 0 0 n128_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA1_0 n128_mA1 0 0.00298f
Cn128eA1_1 n128_mA1 n128_XA 0.05981f
Cn128eA1_2 n128_mA1 vdd 0.00496f
Cn128eA1_3 n128_mA1 n128_VB 0.07228f
Cn128eA1_4 n128_mA1 0 0.19922f
Xn128edA2 n128_XA n128_VB n128_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA2 0 0 n128_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA2_0 n128_mA2 0 0.00298f
Cn128eA2_1 n128_mA2 n128_XA 0.05981f
Cn128eA2_2 n128_mA2 vdd 0.00496f
Cn128eA2_3 n128_mA2 n128_VB 0.07228f
Cn128eA2_4 n128_mA2 0 0.19922f
Xn128edA3 n128_XA n128_VB n128_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA3 0 0 n128_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA3_0 n128_mA3 0 0.00298f
Cn128eA3_1 n128_mA3 n128_XA 0.05981f
Cn128eA3_2 n128_mA3 vdd 0.00496f
Cn128eA3_3 n128_mA3 n128_VB 0.07228f
Cn128eA3_4 n128_mA3 0 0.19922f
Xn128edA4 n128_XA n128_VB n128_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA4 0 0 n128_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA4_0 n128_mA4 0 0.00298f
Cn128eA4_1 n128_mA4 n128_XA 0.05981f
Cn128eA4_2 n128_mA4 vdd 0.00496f
Cn128eA4_3 n128_mA4 n128_VB 0.07228f
Cn128eA4_4 n128_mA4 0 0.19922f
Xn128edA5 n128_XA n128_VB n128_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA5 0 0 n128_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA5_0 n128_mA5 0 0.00298f
Cn128eA5_1 n128_mA5 n128_XA 0.05981f
Cn128eA5_2 n128_mA5 vdd 0.00496f
Cn128eA5_3 n128_mA5 n128_VB 0.07228f
Cn128eA5_4 n128_mA5 0 0.19922f
Xn128edA6 n128_XA n128_VB n128_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA6 0 0 n128_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA6_0 n128_mA6 0 0.00298f
Cn128eA6_1 n128_mA6 n128_XA 0.05981f
Cn128eA6_2 n128_mA6 vdd 0.00496f
Cn128eA6_3 n128_mA6 n128_VB 0.07228f
Cn128eA6_4 n128_mA6 0 0.19922f
Xn128edA7 n128_XA n128_VB n128_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA7 0 0 n128_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA7_0 n128_mA7 0 0.00298f
Cn128eA7_1 n128_mA7 n128_XA 0.05981f
Cn128eA7_2 n128_mA7 vdd 0.00496f
Cn128eA7_3 n128_mA7 n128_VB 0.07228f
Cn128eA7_4 n128_mA7 0 0.19922f
Xn128edA8 n128_XA n128_VB n128_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA8 0 0 n128_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA8_0 n128_mA8 0 0.00298f
Cn128eA8_1 n128_mA8 n128_XA 0.05981f
Cn128eA8_2 n128_mA8 vdd 0.00496f
Cn128eA8_3 n128_mA8 n128_VB 0.07228f
Cn128eA8_4 n128_mA8 0 0.19922f
Xn128edA9 n128_XA n128_VB n128_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA9 0 0 n128_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA9_0 n128_mA9 0 0.00298f
Cn128eA9_1 n128_mA9 n128_XA 0.05981f
Cn128eA9_2 n128_mA9 vdd 0.00496f
Cn128eA9_3 n128_mA9 n128_VB 0.07228f
Cn128eA9_4 n128_mA9 0 0.19922f
Xn128edA10 n128_XA n128_VB n128_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA10 0 0 n128_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA10_0 n128_mA10 0 0.00298f
Cn128eA10_1 n128_mA10 n128_XA 0.05981f
Cn128eA10_2 n128_mA10 vdd 0.00496f
Cn128eA10_3 n128_mA10 n128_VB 0.07228f
Cn128eA10_4 n128_mA10 0 0.19922f
Xn128edA11 n128_XA n128_VB n128_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA11 0 0 n128_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA11_0 n128_mA11 0 0.00298f
Cn128eA11_1 n128_mA11 n128_XA 0.05981f
Cn128eA11_2 n128_mA11 vdd 0.00496f
Cn128eA11_3 n128_mA11 n128_VB 0.07228f
Cn128eA11_4 n128_mA11 0 0.19922f
Xn128edA12 n128_XA n128_VB n128_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA12 0 0 n128_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA12_0 n128_mA12 0 0.00298f
Cn128eA12_1 n128_mA12 n128_XA 0.05981f
Cn128eA12_2 n128_mA12 vdd 0.00496f
Cn128eA12_3 n128_mA12 n128_VB 0.07228f
Cn128eA12_4 n128_mA12 0 0.19922f
Xn128edA13 n128_XA n128_VB n128_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA13 0 0 n128_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA13_0 n128_mA13 0 0.00298f
Cn128eA13_1 n128_mA13 n128_XA 0.05981f
Cn128eA13_2 n128_mA13 vdd 0.00496f
Cn128eA13_3 n128_mA13 n128_VB 0.07228f
Cn128eA13_4 n128_mA13 0 0.19922f
Xn128edA14 n128_XA n128_VB n128_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA14 0 0 n128_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA14_0 n128_mA14 0 0.00298f
Cn128eA14_1 n128_mA14 n128_XA 0.05981f
Cn128eA14_2 n128_mA14 vdd 0.00496f
Cn128eA14_3 n128_mA14 n128_VB 0.07228f
Cn128eA14_4 n128_mA14 0 0.19922f
Xn128edA15 n128_XA n128_VB n128_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA15 0 0 n128_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA15_0 n128_mA15 0 0.00298f
Cn128eA15_1 n128_mA15 n128_XA 0.05981f
Cn128eA15_2 n128_mA15 vdd 0.00496f
Cn128eA15_3 n128_mA15 n128_VB 0.07228f
Cn128eA15_4 n128_mA15 0 0.19922f
Xn128edA16 n128_XA n128_VB n128_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA16 0 0 n128_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA16_0 n128_mA16 0 0.00298f
Cn128eA16_1 n128_mA16 n128_XA 0.05981f
Cn128eA16_2 n128_mA16 vdd 0.00496f
Cn128eA16_3 n128_mA16 n128_VB 0.07228f
Cn128eA16_4 n128_mA16 0 0.19922f
Xn128edA17 n128_XA n128_VB n128_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA17 0 0 n128_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA17_0 n128_mA17 0 0.00298f
Cn128eA17_1 n128_mA17 n128_XA 0.05981f
Cn128eA17_2 n128_mA17 vdd 0.00496f
Cn128eA17_3 n128_mA17 n128_VB 0.07228f
Cn128eA17_4 n128_mA17 0 0.19922f
Xn128edA18 n128_XA n128_VB n128_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA18 0 0 n128_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA18_0 n128_mA18 0 0.00298f
Cn128eA18_1 n128_mA18 n128_XA 0.05981f
Cn128eA18_2 n128_mA18 vdd 0.00496f
Cn128eA18_3 n128_mA18 n128_VB 0.07228f
Cn128eA18_4 n128_mA18 0 0.19922f
Xn128edA19 n128_XA n128_VB n128_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA19 0 0 n128_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA19_0 n128_mA19 0 0.00298f
Cn128eA19_1 n128_mA19 n128_XA 0.05981f
Cn128eA19_2 n128_mA19 vdd 0.00496f
Cn128eA19_3 n128_mA19 n128_VB 0.07228f
Cn128eA19_4 n128_mA19 0 0.19922f
Xn128edA20 n128_XA n128_VB n128_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA20 0 0 n128_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA20_0 n128_mA20 0 0.00298f
Cn128eA20_1 n128_mA20 n128_XA 0.05981f
Cn128eA20_2 n128_mA20 vdd 0.00496f
Cn128eA20_3 n128_mA20 n128_VB 0.07228f
Cn128eA20_4 n128_mA20 0 0.19922f
Xn128edA21 n128_XA n128_VB n128_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA21 0 0 n128_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA21_0 n128_mA21 0 0.00298f
Cn128eA21_1 n128_mA21 n128_XA 0.05981f
Cn128eA21_2 n128_mA21 vdd 0.00496f
Cn128eA21_3 n128_mA21 n128_VB 0.07228f
Cn128eA21_4 n128_mA21 0 0.19922f
Xn128edA22 n128_XA n128_VB n128_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA22 0 0 n128_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA22_0 n128_mA22 0 0.00298f
Cn128eA22_1 n128_mA22 n128_XA 0.05981f
Cn128eA22_2 n128_mA22 vdd 0.00496f
Cn128eA22_3 n128_mA22 n128_VB 0.07228f
Cn128eA22_4 n128_mA22 0 0.19922f
Xn128edA23 n128_XA n128_VB n128_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA23 0 0 n128_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA23_0 n128_mA23 0 0.00298f
Cn128eA23_1 n128_mA23 n128_XA 0.05981f
Cn128eA23_2 n128_mA23 vdd 0.00496f
Cn128eA23_3 n128_mA23 n128_VB 0.07228f
Cn128eA23_4 n128_mA23 0 0.19922f
Xn128edA24 n128_XA n128_VB n128_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA24 0 0 n128_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA24_0 n128_mA24 0 0.00298f
Cn128eA24_1 n128_mA24 n128_XA 0.05981f
Cn128eA24_2 n128_mA24 vdd 0.00496f
Cn128eA24_3 n128_mA24 n128_VB 0.07228f
Cn128eA24_4 n128_mA24 0 0.19922f
Xn128edA25 n128_XA n128_VB n128_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA25 0 0 n128_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA25_0 n128_mA25 0 0.00298f
Cn128eA25_1 n128_mA25 n128_XA 0.05981f
Cn128eA25_2 n128_mA25 vdd 0.00496f
Cn128eA25_3 n128_mA25 n128_VB 0.07228f
Cn128eA25_4 n128_mA25 0 0.19922f
Xn128edA26 n128_XA n128_VB n128_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA26 0 0 n128_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA26_0 n128_mA26 0 0.00298f
Cn128eA26_1 n128_mA26 n128_XA 0.05981f
Cn128eA26_2 n128_mA26 vdd 0.00496f
Cn128eA26_3 n128_mA26 n128_VB 0.07228f
Cn128eA26_4 n128_mA26 0 0.19922f
Xn128edA27 n128_XA n128_VB n128_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA27 0 0 n128_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA27_0 n128_mA27 0 0.00298f
Cn128eA27_1 n128_mA27 n128_XA 0.05981f
Cn128eA27_2 n128_mA27 vdd 0.00496f
Cn128eA27_3 n128_mA27 n128_VB 0.07228f
Cn128eA27_4 n128_mA27 0 0.19922f
Xn128edA28 n128_XA n128_VB n128_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA28 0 0 n128_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA28_0 n128_mA28 0 0.00298f
Cn128eA28_1 n128_mA28 n128_XA 0.05981f
Cn128eA28_2 n128_mA28 vdd 0.00496f
Cn128eA28_3 n128_mA28 n128_VB 0.07228f
Cn128eA28_4 n128_mA28 0 0.19922f
Xn128edA29 n128_XA n128_VB n128_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA29 0 0 n128_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA29_0 n128_mA29 0 0.00298f
Cn128eA29_1 n128_mA29 n128_XA 0.05981f
Cn128eA29_2 n128_mA29 vdd 0.00496f
Cn128eA29_3 n128_mA29 n128_VB 0.07228f
Cn128eA29_4 n128_mA29 0 0.19922f
Xn128edA30 n128_XA n128_VB n128_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA30 0 0 n128_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA30_0 n128_mA30 0 0.00298f
Cn128eA30_1 n128_mA30 n128_XA 0.05981f
Cn128eA30_2 n128_mA30 vdd 0.00496f
Cn128eA30_3 n128_mA30 n128_VB 0.07228f
Cn128eA30_4 n128_mA30 0 0.19922f
Xn128edA31 n128_XA n128_VB n128_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA31 0 0 n128_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA31_0 n128_mA31 0 0.00298f
Cn128eA31_1 n128_mA31 n128_XA 0.05981f
Cn128eA31_2 n128_mA31 vdd 0.00496f
Cn128eA31_3 n128_mA31 n128_VB 0.07228f
Cn128eA31_4 n128_mA31 0 0.19922f
Xn128edA32 n128_XA n128_VB n128_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA32 0 0 n128_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA32_0 n128_mA32 0 0.00298f
Cn128eA32_1 n128_mA32 n128_XA 0.05981f
Cn128eA32_2 n128_mA32 vdd 0.00496f
Cn128eA32_3 n128_mA32 n128_VB 0.07228f
Cn128eA32_4 n128_mA32 0 0.19922f
Xn128edA33 n128_XA n128_VB n128_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA33 0 0 n128_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA33_0 n128_mA33 0 0.00298f
Cn128eA33_1 n128_mA33 n128_XA 0.05981f
Cn128eA33_2 n128_mA33 vdd 0.00496f
Cn128eA33_3 n128_mA33 n128_VB 0.07228f
Cn128eA33_4 n128_mA33 0 0.19922f
Xn128edA34 n128_XA n128_VB n128_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA34 0 0 n128_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA34_0 n128_mA34 0 0.00298f
Cn128eA34_1 n128_mA34 n128_XA 0.05981f
Cn128eA34_2 n128_mA34 vdd 0.00496f
Cn128eA34_3 n128_mA34 n128_VB 0.07228f
Cn128eA34_4 n128_mA34 0 0.19922f
Xn128edA35 n128_XA n128_VB n128_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA35 0 0 n128_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA35_0 n128_mA35 0 0.00298f
Cn128eA35_1 n128_mA35 n128_XA 0.05981f
Cn128eA35_2 n128_mA35 vdd 0.00496f
Cn128eA35_3 n128_mA35 n128_VB 0.07228f
Cn128eA35_4 n128_mA35 0 0.19922f
Xn128edA36 n128_XA n128_VB n128_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA36 0 0 n128_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA36_0 n128_mA36 0 0.00298f
Cn128eA36_1 n128_mA36 n128_XA 0.05981f
Cn128eA36_2 n128_mA36 vdd 0.00496f
Cn128eA36_3 n128_mA36 n128_VB 0.07228f
Cn128eA36_4 n128_mA36 0 0.19922f
Xn128edA37 n128_XA n128_VB n128_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA37 0 0 n128_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA37_0 n128_mA37 0 0.00298f
Cn128eA37_1 n128_mA37 n128_XA 0.05981f
Cn128eA37_2 n128_mA37 vdd 0.00496f
Cn128eA37_3 n128_mA37 n128_VB 0.07228f
Cn128eA37_4 n128_mA37 0 0.19922f
Xn128edA38 n128_XA n128_VB n128_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA38 0 0 n128_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA38_0 n128_mA38 0 0.00298f
Cn128eA38_1 n128_mA38 n128_XA 0.05981f
Cn128eA38_2 n128_mA38 vdd 0.00496f
Cn128eA38_3 n128_mA38 n128_VB 0.07228f
Cn128eA38_4 n128_mA38 0 0.19922f
Xn128edA39 n128_XA n128_VB n128_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA39 0 0 n128_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA39_0 n128_mA39 0 0.00298f
Cn128eA39_1 n128_mA39 n128_XA 0.05981f
Cn128eA39_2 n128_mA39 vdd 0.00496f
Cn128eA39_3 n128_mA39 n128_VB 0.07228f
Cn128eA39_4 n128_mA39 0 0.19922f
Xn128edA40 n128_XA n128_VB n128_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA40 0 0 n128_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA40_0 n128_mA40 0 0.00298f
Cn128eA40_1 n128_mA40 n128_XA 0.05981f
Cn128eA40_2 n128_mA40 vdd 0.00496f
Cn128eA40_3 n128_mA40 n128_VB 0.07228f
Cn128eA40_4 n128_mA40 0 0.19922f
Xn128edA41 n128_XA n128_VB n128_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA41 0 0 n128_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA41_0 n128_mA41 0 0.00298f
Cn128eA41_1 n128_mA41 n128_XA 0.05981f
Cn128eA41_2 n128_mA41 vdd 0.00496f
Cn128eA41_3 n128_mA41 n128_VB 0.07228f
Cn128eA41_4 n128_mA41 0 0.19922f
Xn128edA42 n128_XA n128_VB n128_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA42 0 0 n128_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA42_0 n128_mA42 0 0.00298f
Cn128eA42_1 n128_mA42 n128_XA 0.05981f
Cn128eA42_2 n128_mA42 vdd 0.00496f
Cn128eA42_3 n128_mA42 n128_VB 0.07228f
Cn128eA42_4 n128_mA42 0 0.19922f
Xn128edA43 n128_XA n128_VB n128_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA43 0 0 n128_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA43_0 n128_mA43 0 0.00298f
Cn128eA43_1 n128_mA43 n128_XA 0.05981f
Cn128eA43_2 n128_mA43 vdd 0.00496f
Cn128eA43_3 n128_mA43 n128_VB 0.07228f
Cn128eA43_4 n128_mA43 0 0.19922f
Xn128edA44 n128_XA n128_VB n128_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA44 0 0 n128_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA44_0 n128_mA44 0 0.00298f
Cn128eA44_1 n128_mA44 n128_XA 0.05981f
Cn128eA44_2 n128_mA44 vdd 0.00496f
Cn128eA44_3 n128_mA44 n128_VB 0.07228f
Cn128eA44_4 n128_mA44 0 0.19922f
Xn128edA45 n128_XA n128_VB n128_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA45 0 0 n128_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA45_0 n128_mA45 0 0.00298f
Cn128eA45_1 n128_mA45 n128_XA 0.05981f
Cn128eA45_2 n128_mA45 vdd 0.00496f
Cn128eA45_3 n128_mA45 n128_VB 0.07228f
Cn128eA45_4 n128_mA45 0 0.19922f
Xn128edA46 n128_XA n128_VB n128_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA46 0 0 n128_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA46_0 n128_mA46 0 0.00298f
Cn128eA46_1 n128_mA46 n128_XA 0.05981f
Cn128eA46_2 n128_mA46 vdd 0.00496f
Cn128eA46_3 n128_mA46 n128_VB 0.07228f
Cn128eA46_4 n128_mA46 0 0.19922f
Xn128edA47 n128_XA n128_VB n128_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA47 0 0 n128_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA47_0 n128_mA47 0 0.00298f
Cn128eA47_1 n128_mA47 n128_XA 0.05981f
Cn128eA47_2 n128_mA47 vdd 0.00496f
Cn128eA47_3 n128_mA47 n128_VB 0.07228f
Cn128eA47_4 n128_mA47 0 0.19922f
Xn128edA48 n128_XA n128_VB n128_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA48 0 0 n128_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA48_0 n128_mA48 0 0.00298f
Cn128eA48_1 n128_mA48 n128_XA 0.05981f
Cn128eA48_2 n128_mA48 vdd 0.00496f
Cn128eA48_3 n128_mA48 n128_VB 0.07228f
Cn128eA48_4 n128_mA48 0 0.19922f
Xn128edA49 n128_XA n128_VB n128_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA49 0 0 n128_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA49_0 n128_mA49 0 0.00298f
Cn128eA49_1 n128_mA49 n128_XA 0.05981f
Cn128eA49_2 n128_mA49 vdd 0.00496f
Cn128eA49_3 n128_mA49 n128_VB 0.07228f
Cn128eA49_4 n128_mA49 0 0.19922f
Xn128edA50 n128_XA n128_VB n128_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA50 0 0 n128_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA50_0 n128_mA50 0 0.00298f
Cn128eA50_1 n128_mA50 n128_XA 0.05981f
Cn128eA50_2 n128_mA50 vdd 0.00496f
Cn128eA50_3 n128_mA50 n128_VB 0.07228f
Cn128eA50_4 n128_mA50 0 0.19922f
Xn128edA51 n128_XA n128_VB n128_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA51 0 0 n128_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA51_0 n128_mA51 0 0.00298f
Cn128eA51_1 n128_mA51 n128_XA 0.05981f
Cn128eA51_2 n128_mA51 vdd 0.00496f
Cn128eA51_3 n128_mA51 n128_VB 0.07228f
Cn128eA51_4 n128_mA51 0 0.19922f
Xn128edA52 n128_XA n128_VB n128_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA52 0 0 n128_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA52_0 n128_mA52 0 0.00298f
Cn128eA52_1 n128_mA52 n128_XA 0.05981f
Cn128eA52_2 n128_mA52 vdd 0.00496f
Cn128eA52_3 n128_mA52 n128_VB 0.07228f
Cn128eA52_4 n128_mA52 0 0.19922f
Xn128edA53 n128_XA n128_VB n128_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA53 0 0 n128_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA53_0 n128_mA53 0 0.00298f
Cn128eA53_1 n128_mA53 n128_XA 0.05981f
Cn128eA53_2 n128_mA53 vdd 0.00496f
Cn128eA53_3 n128_mA53 n128_VB 0.07228f
Cn128eA53_4 n128_mA53 0 0.19922f
Xn128edA54 n128_XA n128_VB n128_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA54 0 0 n128_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA54_0 n128_mA54 0 0.00298f
Cn128eA54_1 n128_mA54 n128_XA 0.05981f
Cn128eA54_2 n128_mA54 vdd 0.00496f
Cn128eA54_3 n128_mA54 n128_VB 0.07228f
Cn128eA54_4 n128_mA54 0 0.19922f
Xn128edA55 n128_XA n128_VB n128_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA55 0 0 n128_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA55_0 n128_mA55 0 0.00298f
Cn128eA55_1 n128_mA55 n128_XA 0.05981f
Cn128eA55_2 n128_mA55 vdd 0.00496f
Cn128eA55_3 n128_mA55 n128_VB 0.07228f
Cn128eA55_4 n128_mA55 0 0.19922f
Xn128edA56 n128_XA n128_VB n128_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA56 0 0 n128_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA56_0 n128_mA56 0 0.00298f
Cn128eA56_1 n128_mA56 n128_XA 0.05981f
Cn128eA56_2 n128_mA56 vdd 0.00496f
Cn128eA56_3 n128_mA56 n128_VB 0.07228f
Cn128eA56_4 n128_mA56 0 0.19922f
Xn128edA57 n128_XA n128_VB n128_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA57 0 0 n128_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA57_0 n128_mA57 0 0.00298f
Cn128eA57_1 n128_mA57 n128_XA 0.05981f
Cn128eA57_2 n128_mA57 vdd 0.00496f
Cn128eA57_3 n128_mA57 n128_VB 0.07228f
Cn128eA57_4 n128_mA57 0 0.19922f
Xn128edA58 n128_XA n128_VB n128_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA58 0 0 n128_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA58_0 n128_mA58 0 0.00298f
Cn128eA58_1 n128_mA58 n128_XA 0.05981f
Cn128eA58_2 n128_mA58 vdd 0.00496f
Cn128eA58_3 n128_mA58 n128_VB 0.07228f
Cn128eA58_4 n128_mA58 0 0.19922f
Xn128edA59 n128_XA n128_VB n128_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA59 0 0 n128_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA59_0 n128_mA59 0 0.00298f
Cn128eA59_1 n128_mA59 n128_XA 0.05981f
Cn128eA59_2 n128_mA59 vdd 0.00496f
Cn128eA59_3 n128_mA59 n128_VB 0.07228f
Cn128eA59_4 n128_mA59 0 0.19922f
Xn128edA60 n128_XA n128_VB n128_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA60 0 0 n128_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA60_0 n128_mA60 0 0.00298f
Cn128eA60_1 n128_mA60 n128_XA 0.05981f
Cn128eA60_2 n128_mA60 vdd 0.00496f
Cn128eA60_3 n128_mA60 n128_VB 0.07228f
Cn128eA60_4 n128_mA60 0 0.19922f
Xn128edA61 n128_XA n128_VB n128_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA61 0 0 n128_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA61_0 n128_mA61 0 0.00298f
Cn128eA61_1 n128_mA61 n128_XA 0.05981f
Cn128eA61_2 n128_mA61 vdd 0.00496f
Cn128eA61_3 n128_mA61 n128_VB 0.07228f
Cn128eA61_4 n128_mA61 0 0.19922f
Xn128edA62 n128_XA n128_VB n128_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA62 0 0 n128_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA62_0 n128_mA62 0 0.00298f
Cn128eA62_1 n128_mA62 n128_XA 0.05981f
Cn128eA62_2 n128_mA62 vdd 0.00496f
Cn128eA62_3 n128_mA62 n128_VB 0.07228f
Cn128eA62_4 n128_mA62 0 0.19922f
Xn128edA63 n128_XA n128_VB n128_mA63 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA63 0 0 n128_mA63 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA63_0 n128_mA63 0 0.00298f
Cn128eA63_1 n128_mA63 n128_XA 0.05981f
Cn128eA63_2 n128_mA63 vdd 0.00496f
Cn128eA63_3 n128_mA63 n128_VB 0.07228f
Cn128eA63_4 n128_mA63 0 0.19922f
Xn128edA64 n128_XA n128_VB n128_mA64 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA64 0 0 n128_mA64 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA64_0 n128_mA64 0 0.00298f
Cn128eA64_1 n128_mA64 n128_XA 0.05981f
Cn128eA64_2 n128_mA64 vdd 0.00496f
Cn128eA64_3 n128_mA64 n128_VB 0.07228f
Cn128eA64_4 n128_mA64 0 0.19922f
Xn128edA65 n128_XA n128_VB n128_mA65 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA65 0 0 n128_mA65 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA65_0 n128_mA65 0 0.00298f
Cn128eA65_1 n128_mA65 n128_XA 0.05981f
Cn128eA65_2 n128_mA65 vdd 0.00496f
Cn128eA65_3 n128_mA65 n128_VB 0.07228f
Cn128eA65_4 n128_mA65 0 0.19922f
Xn128edA66 n128_XA n128_VB n128_mA66 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA66 0 0 n128_mA66 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA66_0 n128_mA66 0 0.00298f
Cn128eA66_1 n128_mA66 n128_XA 0.05981f
Cn128eA66_2 n128_mA66 vdd 0.00496f
Cn128eA66_3 n128_mA66 n128_VB 0.07228f
Cn128eA66_4 n128_mA66 0 0.19922f
Xn128edA67 n128_XA n128_VB n128_mA67 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA67 0 0 n128_mA67 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA67_0 n128_mA67 0 0.00298f
Cn128eA67_1 n128_mA67 n128_XA 0.05981f
Cn128eA67_2 n128_mA67 vdd 0.00496f
Cn128eA67_3 n128_mA67 n128_VB 0.07228f
Cn128eA67_4 n128_mA67 0 0.19922f
Xn128edA68 n128_XA n128_VB n128_mA68 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA68 0 0 n128_mA68 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA68_0 n128_mA68 0 0.00298f
Cn128eA68_1 n128_mA68 n128_XA 0.05981f
Cn128eA68_2 n128_mA68 vdd 0.00496f
Cn128eA68_3 n128_mA68 n128_VB 0.07228f
Cn128eA68_4 n128_mA68 0 0.19922f
Xn128edA69 n128_XA n128_VB n128_mA69 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA69 0 0 n128_mA69 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA69_0 n128_mA69 0 0.00298f
Cn128eA69_1 n128_mA69 n128_XA 0.05981f
Cn128eA69_2 n128_mA69 vdd 0.00496f
Cn128eA69_3 n128_mA69 n128_VB 0.07228f
Cn128eA69_4 n128_mA69 0 0.19922f
Xn128edA70 n128_XA n128_VB n128_mA70 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA70 0 0 n128_mA70 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA70_0 n128_mA70 0 0.00298f
Cn128eA70_1 n128_mA70 n128_XA 0.05981f
Cn128eA70_2 n128_mA70 vdd 0.00496f
Cn128eA70_3 n128_mA70 n128_VB 0.07228f
Cn128eA70_4 n128_mA70 0 0.19922f
Xn128edA71 n128_XA n128_VB n128_mA71 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA71 0 0 n128_mA71 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA71_0 n128_mA71 0 0.00298f
Cn128eA71_1 n128_mA71 n128_XA 0.05981f
Cn128eA71_2 n128_mA71 vdd 0.00496f
Cn128eA71_3 n128_mA71 n128_VB 0.07228f
Cn128eA71_4 n128_mA71 0 0.19922f
Xn128edA72 n128_XA n128_VB n128_mA72 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA72 0 0 n128_mA72 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA72_0 n128_mA72 0 0.00298f
Cn128eA72_1 n128_mA72 n128_XA 0.05981f
Cn128eA72_2 n128_mA72 vdd 0.00496f
Cn128eA72_3 n128_mA72 n128_VB 0.07228f
Cn128eA72_4 n128_mA72 0 0.19922f
Xn128edA73 n128_XA n128_VB n128_mA73 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA73 0 0 n128_mA73 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA73_0 n128_mA73 0 0.00298f
Cn128eA73_1 n128_mA73 n128_XA 0.05981f
Cn128eA73_2 n128_mA73 vdd 0.00496f
Cn128eA73_3 n128_mA73 n128_VB 0.07228f
Cn128eA73_4 n128_mA73 0 0.19922f
Xn128edA74 n128_XA n128_VB n128_mA74 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA74 0 0 n128_mA74 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA74_0 n128_mA74 0 0.00298f
Cn128eA74_1 n128_mA74 n128_XA 0.05981f
Cn128eA74_2 n128_mA74 vdd 0.00496f
Cn128eA74_3 n128_mA74 n128_VB 0.07228f
Cn128eA74_4 n128_mA74 0 0.19922f
Xn128edA75 n128_XA n128_VB n128_mA75 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA75 0 0 n128_mA75 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA75_0 n128_mA75 0 0.00298f
Cn128eA75_1 n128_mA75 n128_XA 0.05981f
Cn128eA75_2 n128_mA75 vdd 0.00496f
Cn128eA75_3 n128_mA75 n128_VB 0.07228f
Cn128eA75_4 n128_mA75 0 0.19922f
Xn128edA76 n128_XA n128_VB n128_mA76 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA76 0 0 n128_mA76 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA76_0 n128_mA76 0 0.00298f
Cn128eA76_1 n128_mA76 n128_XA 0.05981f
Cn128eA76_2 n128_mA76 vdd 0.00496f
Cn128eA76_3 n128_mA76 n128_VB 0.07228f
Cn128eA76_4 n128_mA76 0 0.19922f
Xn128edA77 n128_XA n128_VB n128_mA77 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA77 0 0 n128_mA77 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA77_0 n128_mA77 0 0.00298f
Cn128eA77_1 n128_mA77 n128_XA 0.05981f
Cn128eA77_2 n128_mA77 vdd 0.00496f
Cn128eA77_3 n128_mA77 n128_VB 0.07228f
Cn128eA77_4 n128_mA77 0 0.19922f
Xn128edA78 n128_XA n128_VB n128_mA78 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA78 0 0 n128_mA78 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA78_0 n128_mA78 0 0.00298f
Cn128eA78_1 n128_mA78 n128_XA 0.05981f
Cn128eA78_2 n128_mA78 vdd 0.00496f
Cn128eA78_3 n128_mA78 n128_VB 0.07228f
Cn128eA78_4 n128_mA78 0 0.19922f
Xn128edA79 n128_XA n128_VB n128_mA79 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA79 0 0 n128_mA79 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA79_0 n128_mA79 0 0.00298f
Cn128eA79_1 n128_mA79 n128_XA 0.05981f
Cn128eA79_2 n128_mA79 vdd 0.00496f
Cn128eA79_3 n128_mA79 n128_VB 0.07228f
Cn128eA79_4 n128_mA79 0 0.19922f
Xn128edA80 n128_XA n128_VB n128_mA80 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA80 0 0 n128_mA80 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA80_0 n128_mA80 0 0.00298f
Cn128eA80_1 n128_mA80 n128_XA 0.05981f
Cn128eA80_2 n128_mA80 vdd 0.00496f
Cn128eA80_3 n128_mA80 n128_VB 0.07228f
Cn128eA80_4 n128_mA80 0 0.19922f
Xn128edA81 n128_XA n128_VB n128_mA81 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA81 0 0 n128_mA81 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA81_0 n128_mA81 0 0.00298f
Cn128eA81_1 n128_mA81 n128_XA 0.05981f
Cn128eA81_2 n128_mA81 vdd 0.00496f
Cn128eA81_3 n128_mA81 n128_VB 0.07228f
Cn128eA81_4 n128_mA81 0 0.19922f
Xn128edA82 n128_XA n128_VB n128_mA82 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA82 0 0 n128_mA82 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA82_0 n128_mA82 0 0.00298f
Cn128eA82_1 n128_mA82 n128_XA 0.05981f
Cn128eA82_2 n128_mA82 vdd 0.00496f
Cn128eA82_3 n128_mA82 n128_VB 0.07228f
Cn128eA82_4 n128_mA82 0 0.19922f
Xn128edA83 n128_XA n128_VB n128_mA83 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA83 0 0 n128_mA83 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA83_0 n128_mA83 0 0.00298f
Cn128eA83_1 n128_mA83 n128_XA 0.05981f
Cn128eA83_2 n128_mA83 vdd 0.00496f
Cn128eA83_3 n128_mA83 n128_VB 0.07228f
Cn128eA83_4 n128_mA83 0 0.19922f
Xn128edA84 n128_XA n128_VB n128_mA84 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA84 0 0 n128_mA84 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA84_0 n128_mA84 0 0.00298f
Cn128eA84_1 n128_mA84 n128_XA 0.05981f
Cn128eA84_2 n128_mA84 vdd 0.00496f
Cn128eA84_3 n128_mA84 n128_VB 0.07228f
Cn128eA84_4 n128_mA84 0 0.19922f
Xn128edA85 n128_XA n128_VB n128_mA85 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA85 0 0 n128_mA85 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA85_0 n128_mA85 0 0.00298f
Cn128eA85_1 n128_mA85 n128_XA 0.05981f
Cn128eA85_2 n128_mA85 vdd 0.00496f
Cn128eA85_3 n128_mA85 n128_VB 0.07228f
Cn128eA85_4 n128_mA85 0 0.19922f
Xn128edA86 n128_XA n128_VB n128_mA86 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA86 0 0 n128_mA86 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA86_0 n128_mA86 0 0.00298f
Cn128eA86_1 n128_mA86 n128_XA 0.05981f
Cn128eA86_2 n128_mA86 vdd 0.00496f
Cn128eA86_3 n128_mA86 n128_VB 0.07228f
Cn128eA86_4 n128_mA86 0 0.19922f
Xn128edA87 n128_XA n128_VB n128_mA87 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA87 0 0 n128_mA87 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA87_0 n128_mA87 0 0.00298f
Cn128eA87_1 n128_mA87 n128_XA 0.05981f
Cn128eA87_2 n128_mA87 vdd 0.00496f
Cn128eA87_3 n128_mA87 n128_VB 0.07228f
Cn128eA87_4 n128_mA87 0 0.19922f
Xn128edA88 n128_XA n128_VB n128_mA88 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA88 0 0 n128_mA88 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA88_0 n128_mA88 0 0.00298f
Cn128eA88_1 n128_mA88 n128_XA 0.05981f
Cn128eA88_2 n128_mA88 vdd 0.00496f
Cn128eA88_3 n128_mA88 n128_VB 0.07228f
Cn128eA88_4 n128_mA88 0 0.19922f
Xn128edA89 n128_XA n128_VB n128_mA89 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA89 0 0 n128_mA89 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA89_0 n128_mA89 0 0.00298f
Cn128eA89_1 n128_mA89 n128_XA 0.05981f
Cn128eA89_2 n128_mA89 vdd 0.00496f
Cn128eA89_3 n128_mA89 n128_VB 0.07228f
Cn128eA89_4 n128_mA89 0 0.19922f
Xn128edA90 n128_XA n128_VB n128_mA90 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA90 0 0 n128_mA90 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA90_0 n128_mA90 0 0.00298f
Cn128eA90_1 n128_mA90 n128_XA 0.05981f
Cn128eA90_2 n128_mA90 vdd 0.00496f
Cn128eA90_3 n128_mA90 n128_VB 0.07228f
Cn128eA90_4 n128_mA90 0 0.19922f
Xn128edA91 n128_XA n128_VB n128_mA91 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA91 0 0 n128_mA91 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA91_0 n128_mA91 0 0.00298f
Cn128eA91_1 n128_mA91 n128_XA 0.05981f
Cn128eA91_2 n128_mA91 vdd 0.00496f
Cn128eA91_3 n128_mA91 n128_VB 0.07228f
Cn128eA91_4 n128_mA91 0 0.19922f
Xn128edA92 n128_XA n128_VB n128_mA92 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA92 0 0 n128_mA92 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA92_0 n128_mA92 0 0.00298f
Cn128eA92_1 n128_mA92 n128_XA 0.05981f
Cn128eA92_2 n128_mA92 vdd 0.00496f
Cn128eA92_3 n128_mA92 n128_VB 0.07228f
Cn128eA92_4 n128_mA92 0 0.19922f
Xn128edA93 n128_XA n128_VB n128_mA93 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA93 0 0 n128_mA93 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA93_0 n128_mA93 0 0.00298f
Cn128eA93_1 n128_mA93 n128_XA 0.05981f
Cn128eA93_2 n128_mA93 vdd 0.00496f
Cn128eA93_3 n128_mA93 n128_VB 0.07228f
Cn128eA93_4 n128_mA93 0 0.19922f
Xn128edA94 n128_XA n128_VB n128_mA94 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA94 0 0 n128_mA94 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA94_0 n128_mA94 0 0.00298f
Cn128eA94_1 n128_mA94 n128_XA 0.05981f
Cn128eA94_2 n128_mA94 vdd 0.00496f
Cn128eA94_3 n128_mA94 n128_VB 0.07228f
Cn128eA94_4 n128_mA94 0 0.19922f
Xn128edA95 n128_XA n128_VB n128_mA95 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA95 0 0 n128_mA95 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA95_0 n128_mA95 0 0.00298f
Cn128eA95_1 n128_mA95 n128_XA 0.05981f
Cn128eA95_2 n128_mA95 vdd 0.00496f
Cn128eA95_3 n128_mA95 n128_VB 0.07228f
Cn128eA95_4 n128_mA95 0 0.19922f
Xn128edA96 n128_XA n128_VB n128_mA96 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA96 0 0 n128_mA96 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA96_0 n128_mA96 0 0.00298f
Cn128eA96_1 n128_mA96 n128_XA 0.05981f
Cn128eA96_2 n128_mA96 vdd 0.00496f
Cn128eA96_3 n128_mA96 n128_VB 0.07228f
Cn128eA96_4 n128_mA96 0 0.19922f
Xn128edA97 n128_XA n128_VB n128_mA97 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA97 0 0 n128_mA97 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA97_0 n128_mA97 0 0.00298f
Cn128eA97_1 n128_mA97 n128_XA 0.05981f
Cn128eA97_2 n128_mA97 vdd 0.00496f
Cn128eA97_3 n128_mA97 n128_VB 0.07228f
Cn128eA97_4 n128_mA97 0 0.19922f
Xn128edA98 n128_XA n128_VB n128_mA98 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA98 0 0 n128_mA98 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA98_0 n128_mA98 0 0.00298f
Cn128eA98_1 n128_mA98 n128_XA 0.05981f
Cn128eA98_2 n128_mA98 vdd 0.00496f
Cn128eA98_3 n128_mA98 n128_VB 0.07228f
Cn128eA98_4 n128_mA98 0 0.19922f
Xn128edA99 n128_XA n128_VB n128_mA99 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA99 0 0 n128_mA99 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA99_0 n128_mA99 0 0.00298f
Cn128eA99_1 n128_mA99 n128_XA 0.05981f
Cn128eA99_2 n128_mA99 vdd 0.00496f
Cn128eA99_3 n128_mA99 n128_VB 0.07228f
Cn128eA99_4 n128_mA99 0 0.19922f
Xn128edA100 n128_XA n128_VB n128_mA100 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA100 0 0 n128_mA100 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA100_0 n128_mA100 0 0.00298f
Cn128eA100_1 n128_mA100 n128_XA 0.05981f
Cn128eA100_2 n128_mA100 vdd 0.00496f
Cn128eA100_3 n128_mA100 n128_VB 0.07228f
Cn128eA100_4 n128_mA100 0 0.19922f
Xn128edA101 n128_XA n128_VB n128_mA101 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA101 0 0 n128_mA101 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA101_0 n128_mA101 0 0.00298f
Cn128eA101_1 n128_mA101 n128_XA 0.05981f
Cn128eA101_2 n128_mA101 vdd 0.00496f
Cn128eA101_3 n128_mA101 n128_VB 0.07228f
Cn128eA101_4 n128_mA101 0 0.19922f
Xn128edA102 n128_XA n128_VB n128_mA102 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA102 0 0 n128_mA102 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA102_0 n128_mA102 0 0.00298f
Cn128eA102_1 n128_mA102 n128_XA 0.05981f
Cn128eA102_2 n128_mA102 vdd 0.00496f
Cn128eA102_3 n128_mA102 n128_VB 0.07228f
Cn128eA102_4 n128_mA102 0 0.19922f
Xn128edA103 n128_XA n128_VB n128_mA103 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA103 0 0 n128_mA103 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA103_0 n128_mA103 0 0.00298f
Cn128eA103_1 n128_mA103 n128_XA 0.05981f
Cn128eA103_2 n128_mA103 vdd 0.00496f
Cn128eA103_3 n128_mA103 n128_VB 0.07228f
Cn128eA103_4 n128_mA103 0 0.19922f
Xn128edA104 n128_XA n128_VB n128_mA104 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA104 0 0 n128_mA104 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA104_0 n128_mA104 0 0.00298f
Cn128eA104_1 n128_mA104 n128_XA 0.05981f
Cn128eA104_2 n128_mA104 vdd 0.00496f
Cn128eA104_3 n128_mA104 n128_VB 0.07228f
Cn128eA104_4 n128_mA104 0 0.19922f
Xn128edA105 n128_XA n128_VB n128_mA105 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA105 0 0 n128_mA105 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA105_0 n128_mA105 0 0.00298f
Cn128eA105_1 n128_mA105 n128_XA 0.05981f
Cn128eA105_2 n128_mA105 vdd 0.00496f
Cn128eA105_3 n128_mA105 n128_VB 0.07228f
Cn128eA105_4 n128_mA105 0 0.19922f
Xn128edA106 n128_XA n128_VB n128_mA106 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA106 0 0 n128_mA106 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA106_0 n128_mA106 0 0.00298f
Cn128eA106_1 n128_mA106 n128_XA 0.05981f
Cn128eA106_2 n128_mA106 vdd 0.00496f
Cn128eA106_3 n128_mA106 n128_VB 0.07228f
Cn128eA106_4 n128_mA106 0 0.19922f
Xn128edA107 n128_XA n128_VB n128_mA107 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA107 0 0 n128_mA107 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA107_0 n128_mA107 0 0.00298f
Cn128eA107_1 n128_mA107 n128_XA 0.05981f
Cn128eA107_2 n128_mA107 vdd 0.00496f
Cn128eA107_3 n128_mA107 n128_VB 0.07228f
Cn128eA107_4 n128_mA107 0 0.19922f
Xn128edA108 n128_XA n128_VB n128_mA108 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA108 0 0 n128_mA108 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA108_0 n128_mA108 0 0.00298f
Cn128eA108_1 n128_mA108 n128_XA 0.05981f
Cn128eA108_2 n128_mA108 vdd 0.00496f
Cn128eA108_3 n128_mA108 n128_VB 0.07228f
Cn128eA108_4 n128_mA108 0 0.19922f
Xn128edA109 n128_XA n128_VB n128_mA109 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA109 0 0 n128_mA109 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA109_0 n128_mA109 0 0.00298f
Cn128eA109_1 n128_mA109 n128_XA 0.05981f
Cn128eA109_2 n128_mA109 vdd 0.00496f
Cn128eA109_3 n128_mA109 n128_VB 0.07228f
Cn128eA109_4 n128_mA109 0 0.19922f
Xn128edA110 n128_XA n128_VB n128_mA110 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA110 0 0 n128_mA110 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA110_0 n128_mA110 0 0.00298f
Cn128eA110_1 n128_mA110 n128_XA 0.05981f
Cn128eA110_2 n128_mA110 vdd 0.00496f
Cn128eA110_3 n128_mA110 n128_VB 0.07228f
Cn128eA110_4 n128_mA110 0 0.19922f
Xn128edA111 n128_XA n128_VB n128_mA111 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA111 0 0 n128_mA111 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA111_0 n128_mA111 0 0.00298f
Cn128eA111_1 n128_mA111 n128_XA 0.05981f
Cn128eA111_2 n128_mA111 vdd 0.00496f
Cn128eA111_3 n128_mA111 n128_VB 0.07228f
Cn128eA111_4 n128_mA111 0 0.19922f
Xn128edA112 n128_XA n128_VB n128_mA112 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA112 0 0 n128_mA112 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA112_0 n128_mA112 0 0.00298f
Cn128eA112_1 n128_mA112 n128_XA 0.05981f
Cn128eA112_2 n128_mA112 vdd 0.00496f
Cn128eA112_3 n128_mA112 n128_VB 0.07228f
Cn128eA112_4 n128_mA112 0 0.19922f
Xn128edA113 n128_XA n128_VB n128_mA113 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA113 0 0 n128_mA113 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA113_0 n128_mA113 0 0.00298f
Cn128eA113_1 n128_mA113 n128_XA 0.05981f
Cn128eA113_2 n128_mA113 vdd 0.00496f
Cn128eA113_3 n128_mA113 n128_VB 0.07228f
Cn128eA113_4 n128_mA113 0 0.19922f
Xn128edA114 n128_XA n128_VB n128_mA114 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA114 0 0 n128_mA114 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA114_0 n128_mA114 0 0.00298f
Cn128eA114_1 n128_mA114 n128_XA 0.05981f
Cn128eA114_2 n128_mA114 vdd 0.00496f
Cn128eA114_3 n128_mA114 n128_VB 0.07228f
Cn128eA114_4 n128_mA114 0 0.19922f
Xn128edA115 n128_XA n128_VB n128_mA115 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA115 0 0 n128_mA115 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA115_0 n128_mA115 0 0.00298f
Cn128eA115_1 n128_mA115 n128_XA 0.05981f
Cn128eA115_2 n128_mA115 vdd 0.00496f
Cn128eA115_3 n128_mA115 n128_VB 0.07228f
Cn128eA115_4 n128_mA115 0 0.19922f
Xn128edA116 n128_XA n128_VB n128_mA116 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA116 0 0 n128_mA116 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA116_0 n128_mA116 0 0.00298f
Cn128eA116_1 n128_mA116 n128_XA 0.05981f
Cn128eA116_2 n128_mA116 vdd 0.00496f
Cn128eA116_3 n128_mA116 n128_VB 0.07228f
Cn128eA116_4 n128_mA116 0 0.19922f
Xn128edA117 n128_XA n128_VB n128_mA117 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA117 0 0 n128_mA117 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA117_0 n128_mA117 0 0.00298f
Cn128eA117_1 n128_mA117 n128_XA 0.05981f
Cn128eA117_2 n128_mA117 vdd 0.00496f
Cn128eA117_3 n128_mA117 n128_VB 0.07228f
Cn128eA117_4 n128_mA117 0 0.19922f
Xn128edA118 n128_XA n128_VB n128_mA118 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA118 0 0 n128_mA118 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA118_0 n128_mA118 0 0.00298f
Cn128eA118_1 n128_mA118 n128_XA 0.05981f
Cn128eA118_2 n128_mA118 vdd 0.00496f
Cn128eA118_3 n128_mA118 n128_VB 0.07228f
Cn128eA118_4 n128_mA118 0 0.19922f
Xn128edA119 n128_XA n128_VB n128_mA119 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA119 0 0 n128_mA119 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA119_0 n128_mA119 0 0.00298f
Cn128eA119_1 n128_mA119 n128_XA 0.05981f
Cn128eA119_2 n128_mA119 vdd 0.00496f
Cn128eA119_3 n128_mA119 n128_VB 0.07228f
Cn128eA119_4 n128_mA119 0 0.19922f
Xn128edA120 n128_XA n128_VB n128_mA120 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA120 0 0 n128_mA120 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA120_0 n128_mA120 0 0.00298f
Cn128eA120_1 n128_mA120 n128_XA 0.05981f
Cn128eA120_2 n128_mA120 vdd 0.00496f
Cn128eA120_3 n128_mA120 n128_VB 0.07228f
Cn128eA120_4 n128_mA120 0 0.19922f
Xn128edA121 n128_XA n128_VB n128_mA121 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA121 0 0 n128_mA121 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA121_0 n128_mA121 0 0.00298f
Cn128eA121_1 n128_mA121 n128_XA 0.05981f
Cn128eA121_2 n128_mA121 vdd 0.00496f
Cn128eA121_3 n128_mA121 n128_VB 0.07228f
Cn128eA121_4 n128_mA121 0 0.19922f
Xn128edA122 n128_XA n128_VB n128_mA122 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA122 0 0 n128_mA122 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA122_0 n128_mA122 0 0.00298f
Cn128eA122_1 n128_mA122 n128_XA 0.05981f
Cn128eA122_2 n128_mA122 vdd 0.00496f
Cn128eA122_3 n128_mA122 n128_VB 0.07228f
Cn128eA122_4 n128_mA122 0 0.19922f
Xn128edA123 n128_XA n128_VB n128_mA123 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA123 0 0 n128_mA123 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA123_0 n128_mA123 0 0.00298f
Cn128eA123_1 n128_mA123 n128_XA 0.05981f
Cn128eA123_2 n128_mA123 vdd 0.00496f
Cn128eA123_3 n128_mA123 n128_VB 0.07228f
Cn128eA123_4 n128_mA123 0 0.19922f
Xn128edA124 n128_XA n128_VB n128_mA124 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA124 0 0 n128_mA124 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA124_0 n128_mA124 0 0.00298f
Cn128eA124_1 n128_mA124 n128_XA 0.05981f
Cn128eA124_2 n128_mA124 vdd 0.00496f
Cn128eA124_3 n128_mA124 n128_VB 0.07228f
Cn128eA124_4 n128_mA124 0 0.19922f
Xn128edA125 n128_XA n128_VB n128_mA125 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA125 0 0 n128_mA125 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA125_0 n128_mA125 0 0.00298f
Cn128eA125_1 n128_mA125 n128_XA 0.05981f
Cn128eA125_2 n128_mA125 vdd 0.00496f
Cn128eA125_3 n128_mA125 n128_VB 0.07228f
Cn128eA125_4 n128_mA125 0 0.19922f
Xn128edA126 n128_XA n128_VB n128_mA126 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esA126 0 0 n128_mA126 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eA126_0 n128_mA126 0 0.00298f
Cn128eA126_1 n128_mA126 n128_XA 0.05981f
Cn128eA126_2 n128_mA126 vdd 0.00496f
Cn128eA126_3 n128_mA126 n128_VB 0.07228f
Cn128eA126_4 n128_mA126 0 0.19922f
Xn128edB0 n128_XB n128_VB n128_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB0 0 0 n128_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB0_0 n128_mB0 n128_XB 0.05778f
Cn128eB0_1 n128_mB0 vdd 0.00496f
Cn128eB0_2 n128_mB0 n128_VB 0.0654f
Cn128eB0_3 n128_mB0 0 0.00298f
Cn128eB0_4 n128_mB0 0 0.20468f
Xn128edB1 n128_XB n128_VB n128_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB1 0 0 n128_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB1_0 n128_mB1 n128_XB 0.05778f
Cn128eB1_1 n128_mB1 vdd 0.00496f
Cn128eB1_2 n128_mB1 n128_VB 0.0654f
Cn128eB1_3 n128_mB1 0 0.00298f
Cn128eB1_4 n128_mB1 0 0.20468f
Xn128edB2 n128_XB n128_VB n128_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB2 0 0 n128_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB2_0 n128_mB2 n128_XB 0.05778f
Cn128eB2_1 n128_mB2 vdd 0.00496f
Cn128eB2_2 n128_mB2 n128_VB 0.0654f
Cn128eB2_3 n128_mB2 0 0.00298f
Cn128eB2_4 n128_mB2 0 0.20468f
Xn128edB3 n128_XB n128_VB n128_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB3 0 0 n128_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB3_0 n128_mB3 n128_XB 0.05778f
Cn128eB3_1 n128_mB3 vdd 0.00496f
Cn128eB3_2 n128_mB3 n128_VB 0.0654f
Cn128eB3_3 n128_mB3 0 0.00298f
Cn128eB3_4 n128_mB3 0 0.20468f
Xn128edB4 n128_XB n128_VB n128_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB4 0 0 n128_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB4_0 n128_mB4 n128_XB 0.05778f
Cn128eB4_1 n128_mB4 vdd 0.00496f
Cn128eB4_2 n128_mB4 n128_VB 0.0654f
Cn128eB4_3 n128_mB4 0 0.00298f
Cn128eB4_4 n128_mB4 0 0.20468f
Xn128edB5 n128_XB n128_VB n128_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB5 0 0 n128_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB5_0 n128_mB5 n128_XB 0.05778f
Cn128eB5_1 n128_mB5 vdd 0.00496f
Cn128eB5_2 n128_mB5 n128_VB 0.0654f
Cn128eB5_3 n128_mB5 0 0.00298f
Cn128eB5_4 n128_mB5 0 0.20468f
Xn128edB6 n128_XB n128_VB n128_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB6 0 0 n128_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB6_0 n128_mB6 n128_XB 0.05778f
Cn128eB6_1 n128_mB6 vdd 0.00496f
Cn128eB6_2 n128_mB6 n128_VB 0.0654f
Cn128eB6_3 n128_mB6 0 0.00298f
Cn128eB6_4 n128_mB6 0 0.20468f
Xn128edB7 n128_XB n128_VB n128_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB7 0 0 n128_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB7_0 n128_mB7 n128_XB 0.05778f
Cn128eB7_1 n128_mB7 vdd 0.00496f
Cn128eB7_2 n128_mB7 n128_VB 0.0654f
Cn128eB7_3 n128_mB7 0 0.00298f
Cn128eB7_4 n128_mB7 0 0.20468f
Xn128edB8 n128_XB n128_VB n128_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB8 0 0 n128_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB8_0 n128_mB8 n128_XB 0.05778f
Cn128eB8_1 n128_mB8 vdd 0.00496f
Cn128eB8_2 n128_mB8 n128_VB 0.0654f
Cn128eB8_3 n128_mB8 0 0.00298f
Cn128eB8_4 n128_mB8 0 0.20468f
Xn128edB9 n128_XB n128_VB n128_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB9 0 0 n128_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB9_0 n128_mB9 n128_XB 0.05778f
Cn128eB9_1 n128_mB9 vdd 0.00496f
Cn128eB9_2 n128_mB9 n128_VB 0.0654f
Cn128eB9_3 n128_mB9 0 0.00298f
Cn128eB9_4 n128_mB9 0 0.20468f
Xn128edB10 n128_XB n128_VB n128_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB10 0 0 n128_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB10_0 n128_mB10 n128_XB 0.05778f
Cn128eB10_1 n128_mB10 vdd 0.00496f
Cn128eB10_2 n128_mB10 n128_VB 0.0654f
Cn128eB10_3 n128_mB10 0 0.00298f
Cn128eB10_4 n128_mB10 0 0.20468f
Xn128edB11 n128_XB n128_VB n128_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB11 0 0 n128_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB11_0 n128_mB11 n128_XB 0.05778f
Cn128eB11_1 n128_mB11 vdd 0.00496f
Cn128eB11_2 n128_mB11 n128_VB 0.0654f
Cn128eB11_3 n128_mB11 0 0.00298f
Cn128eB11_4 n128_mB11 0 0.20468f
Xn128edB12 n128_XB n128_VB n128_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB12 0 0 n128_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB12_0 n128_mB12 n128_XB 0.05778f
Cn128eB12_1 n128_mB12 vdd 0.00496f
Cn128eB12_2 n128_mB12 n128_VB 0.0654f
Cn128eB12_3 n128_mB12 0 0.00298f
Cn128eB12_4 n128_mB12 0 0.20468f
Xn128edB13 n128_XB n128_VB n128_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB13 0 0 n128_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB13_0 n128_mB13 n128_XB 0.05778f
Cn128eB13_1 n128_mB13 vdd 0.00496f
Cn128eB13_2 n128_mB13 n128_VB 0.0654f
Cn128eB13_3 n128_mB13 0 0.00298f
Cn128eB13_4 n128_mB13 0 0.20468f
Xn128edB14 n128_XB n128_VB n128_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB14 0 0 n128_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB14_0 n128_mB14 n128_XB 0.05778f
Cn128eB14_1 n128_mB14 vdd 0.00496f
Cn128eB14_2 n128_mB14 n128_VB 0.0654f
Cn128eB14_3 n128_mB14 0 0.00298f
Cn128eB14_4 n128_mB14 0 0.20468f
Xn128edB15 n128_XB n128_VB n128_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB15 0 0 n128_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB15_0 n128_mB15 n128_XB 0.05778f
Cn128eB15_1 n128_mB15 vdd 0.00496f
Cn128eB15_2 n128_mB15 n128_VB 0.0654f
Cn128eB15_3 n128_mB15 0 0.00298f
Cn128eB15_4 n128_mB15 0 0.20468f
Xn128edB16 n128_XB n128_VB n128_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB16 0 0 n128_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB16_0 n128_mB16 n128_XB 0.05778f
Cn128eB16_1 n128_mB16 vdd 0.00496f
Cn128eB16_2 n128_mB16 n128_VB 0.0654f
Cn128eB16_3 n128_mB16 0 0.00298f
Cn128eB16_4 n128_mB16 0 0.20468f
Xn128edB17 n128_XB n128_VB n128_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB17 0 0 n128_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB17_0 n128_mB17 n128_XB 0.05778f
Cn128eB17_1 n128_mB17 vdd 0.00496f
Cn128eB17_2 n128_mB17 n128_VB 0.0654f
Cn128eB17_3 n128_mB17 0 0.00298f
Cn128eB17_4 n128_mB17 0 0.20468f
Xn128edB18 n128_XB n128_VB n128_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB18 0 0 n128_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB18_0 n128_mB18 n128_XB 0.05778f
Cn128eB18_1 n128_mB18 vdd 0.00496f
Cn128eB18_2 n128_mB18 n128_VB 0.0654f
Cn128eB18_3 n128_mB18 0 0.00298f
Cn128eB18_4 n128_mB18 0 0.20468f
Xn128edB19 n128_XB n128_VB n128_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB19 0 0 n128_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB19_0 n128_mB19 n128_XB 0.05778f
Cn128eB19_1 n128_mB19 vdd 0.00496f
Cn128eB19_2 n128_mB19 n128_VB 0.0654f
Cn128eB19_3 n128_mB19 0 0.00298f
Cn128eB19_4 n128_mB19 0 0.20468f
Xn128edB20 n128_XB n128_VB n128_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB20 0 0 n128_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB20_0 n128_mB20 n128_XB 0.05778f
Cn128eB20_1 n128_mB20 vdd 0.00496f
Cn128eB20_2 n128_mB20 n128_VB 0.0654f
Cn128eB20_3 n128_mB20 0 0.00298f
Cn128eB20_4 n128_mB20 0 0.20468f
Xn128edB21 n128_XB n128_VB n128_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB21 0 0 n128_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB21_0 n128_mB21 n128_XB 0.05778f
Cn128eB21_1 n128_mB21 vdd 0.00496f
Cn128eB21_2 n128_mB21 n128_VB 0.0654f
Cn128eB21_3 n128_mB21 0 0.00298f
Cn128eB21_4 n128_mB21 0 0.20468f
Xn128edB22 n128_XB n128_VB n128_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB22 0 0 n128_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB22_0 n128_mB22 n128_XB 0.05778f
Cn128eB22_1 n128_mB22 vdd 0.00496f
Cn128eB22_2 n128_mB22 n128_VB 0.0654f
Cn128eB22_3 n128_mB22 0 0.00298f
Cn128eB22_4 n128_mB22 0 0.20468f
Xn128edB23 n128_XB n128_VB n128_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB23 0 0 n128_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB23_0 n128_mB23 n128_XB 0.05778f
Cn128eB23_1 n128_mB23 vdd 0.00496f
Cn128eB23_2 n128_mB23 n128_VB 0.0654f
Cn128eB23_3 n128_mB23 0 0.00298f
Cn128eB23_4 n128_mB23 0 0.20468f
Xn128edB24 n128_XB n128_VB n128_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB24 0 0 n128_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB24_0 n128_mB24 n128_XB 0.05778f
Cn128eB24_1 n128_mB24 vdd 0.00496f
Cn128eB24_2 n128_mB24 n128_VB 0.0654f
Cn128eB24_3 n128_mB24 0 0.00298f
Cn128eB24_4 n128_mB24 0 0.20468f
Xn128edB25 n128_XB n128_VB n128_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB25 0 0 n128_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB25_0 n128_mB25 n128_XB 0.05778f
Cn128eB25_1 n128_mB25 vdd 0.00496f
Cn128eB25_2 n128_mB25 n128_VB 0.0654f
Cn128eB25_3 n128_mB25 0 0.00298f
Cn128eB25_4 n128_mB25 0 0.20468f
Xn128edB26 n128_XB n128_VB n128_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB26 0 0 n128_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB26_0 n128_mB26 n128_XB 0.05778f
Cn128eB26_1 n128_mB26 vdd 0.00496f
Cn128eB26_2 n128_mB26 n128_VB 0.0654f
Cn128eB26_3 n128_mB26 0 0.00298f
Cn128eB26_4 n128_mB26 0 0.20468f
Xn128edB27 n128_XB n128_VB n128_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB27 0 0 n128_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB27_0 n128_mB27 n128_XB 0.05778f
Cn128eB27_1 n128_mB27 vdd 0.00496f
Cn128eB27_2 n128_mB27 n128_VB 0.0654f
Cn128eB27_3 n128_mB27 0 0.00298f
Cn128eB27_4 n128_mB27 0 0.20468f
Xn128edB28 n128_XB n128_VB n128_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB28 0 0 n128_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB28_0 n128_mB28 n128_XB 0.05778f
Cn128eB28_1 n128_mB28 vdd 0.00496f
Cn128eB28_2 n128_mB28 n128_VB 0.0654f
Cn128eB28_3 n128_mB28 0 0.00298f
Cn128eB28_4 n128_mB28 0 0.20468f
Xn128edB29 n128_XB n128_VB n128_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB29 0 0 n128_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB29_0 n128_mB29 n128_XB 0.05778f
Cn128eB29_1 n128_mB29 vdd 0.00496f
Cn128eB29_2 n128_mB29 n128_VB 0.0654f
Cn128eB29_3 n128_mB29 0 0.00298f
Cn128eB29_4 n128_mB29 0 0.20468f
Xn128edB30 n128_XB n128_VB n128_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB30 0 0 n128_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB30_0 n128_mB30 n128_XB 0.05778f
Cn128eB30_1 n128_mB30 vdd 0.00496f
Cn128eB30_2 n128_mB30 n128_VB 0.0654f
Cn128eB30_3 n128_mB30 0 0.00298f
Cn128eB30_4 n128_mB30 0 0.20468f
Xn128edB31 n128_XB n128_VB n128_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB31 0 0 n128_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB31_0 n128_mB31 n128_XB 0.05778f
Cn128eB31_1 n128_mB31 vdd 0.00496f
Cn128eB31_2 n128_mB31 n128_VB 0.0654f
Cn128eB31_3 n128_mB31 0 0.00298f
Cn128eB31_4 n128_mB31 0 0.20468f
Xn128edB32 n128_XB n128_VB n128_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB32 0 0 n128_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB32_0 n128_mB32 n128_XB 0.05778f
Cn128eB32_1 n128_mB32 vdd 0.00496f
Cn128eB32_2 n128_mB32 n128_VB 0.0654f
Cn128eB32_3 n128_mB32 0 0.00298f
Cn128eB32_4 n128_mB32 0 0.20468f
Xn128edB33 n128_XB n128_VB n128_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB33 0 0 n128_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB33_0 n128_mB33 n128_XB 0.05778f
Cn128eB33_1 n128_mB33 vdd 0.00496f
Cn128eB33_2 n128_mB33 n128_VB 0.0654f
Cn128eB33_3 n128_mB33 0 0.00298f
Cn128eB33_4 n128_mB33 0 0.20468f
Xn128edB34 n128_XB n128_VB n128_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB34 0 0 n128_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB34_0 n128_mB34 n128_XB 0.05778f
Cn128eB34_1 n128_mB34 vdd 0.00496f
Cn128eB34_2 n128_mB34 n128_VB 0.0654f
Cn128eB34_3 n128_mB34 0 0.00298f
Cn128eB34_4 n128_mB34 0 0.20468f
Xn128edB35 n128_XB n128_VB n128_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB35 0 0 n128_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB35_0 n128_mB35 n128_XB 0.05778f
Cn128eB35_1 n128_mB35 vdd 0.00496f
Cn128eB35_2 n128_mB35 n128_VB 0.0654f
Cn128eB35_3 n128_mB35 0 0.00298f
Cn128eB35_4 n128_mB35 0 0.20468f
Xn128edB36 n128_XB n128_VB n128_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB36 0 0 n128_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB36_0 n128_mB36 n128_XB 0.05778f
Cn128eB36_1 n128_mB36 vdd 0.00496f
Cn128eB36_2 n128_mB36 n128_VB 0.0654f
Cn128eB36_3 n128_mB36 0 0.00298f
Cn128eB36_4 n128_mB36 0 0.20468f
Xn128edB37 n128_XB n128_VB n128_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB37 0 0 n128_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB37_0 n128_mB37 n128_XB 0.05778f
Cn128eB37_1 n128_mB37 vdd 0.00496f
Cn128eB37_2 n128_mB37 n128_VB 0.0654f
Cn128eB37_3 n128_mB37 0 0.00298f
Cn128eB37_4 n128_mB37 0 0.20468f
Xn128edB38 n128_XB n128_VB n128_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB38 0 0 n128_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB38_0 n128_mB38 n128_XB 0.05778f
Cn128eB38_1 n128_mB38 vdd 0.00496f
Cn128eB38_2 n128_mB38 n128_VB 0.0654f
Cn128eB38_3 n128_mB38 0 0.00298f
Cn128eB38_4 n128_mB38 0 0.20468f
Xn128edB39 n128_XB n128_VB n128_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB39 0 0 n128_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB39_0 n128_mB39 n128_XB 0.05778f
Cn128eB39_1 n128_mB39 vdd 0.00496f
Cn128eB39_2 n128_mB39 n128_VB 0.0654f
Cn128eB39_3 n128_mB39 0 0.00298f
Cn128eB39_4 n128_mB39 0 0.20468f
Xn128edB40 n128_XB n128_VB n128_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB40 0 0 n128_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB40_0 n128_mB40 n128_XB 0.05778f
Cn128eB40_1 n128_mB40 vdd 0.00496f
Cn128eB40_2 n128_mB40 n128_VB 0.0654f
Cn128eB40_3 n128_mB40 0 0.00298f
Cn128eB40_4 n128_mB40 0 0.20468f
Xn128edB41 n128_XB n128_VB n128_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB41 0 0 n128_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB41_0 n128_mB41 n128_XB 0.05778f
Cn128eB41_1 n128_mB41 vdd 0.00496f
Cn128eB41_2 n128_mB41 n128_VB 0.0654f
Cn128eB41_3 n128_mB41 0 0.00298f
Cn128eB41_4 n128_mB41 0 0.20468f
Xn128edB42 n128_XB n128_VB n128_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB42 0 0 n128_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB42_0 n128_mB42 n128_XB 0.05778f
Cn128eB42_1 n128_mB42 vdd 0.00496f
Cn128eB42_2 n128_mB42 n128_VB 0.0654f
Cn128eB42_3 n128_mB42 0 0.00298f
Cn128eB42_4 n128_mB42 0 0.20468f
Xn128edB43 n128_XB n128_VB n128_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB43 0 0 n128_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB43_0 n128_mB43 n128_XB 0.05778f
Cn128eB43_1 n128_mB43 vdd 0.00496f
Cn128eB43_2 n128_mB43 n128_VB 0.0654f
Cn128eB43_3 n128_mB43 0 0.00298f
Cn128eB43_4 n128_mB43 0 0.20468f
Xn128edB44 n128_XB n128_VB n128_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB44 0 0 n128_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB44_0 n128_mB44 n128_XB 0.05778f
Cn128eB44_1 n128_mB44 vdd 0.00496f
Cn128eB44_2 n128_mB44 n128_VB 0.0654f
Cn128eB44_3 n128_mB44 0 0.00298f
Cn128eB44_4 n128_mB44 0 0.20468f
Xn128edB45 n128_XB n128_VB n128_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB45 0 0 n128_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB45_0 n128_mB45 n128_XB 0.05778f
Cn128eB45_1 n128_mB45 vdd 0.00496f
Cn128eB45_2 n128_mB45 n128_VB 0.0654f
Cn128eB45_3 n128_mB45 0 0.00298f
Cn128eB45_4 n128_mB45 0 0.20468f
Xn128edB46 n128_XB n128_VB n128_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB46 0 0 n128_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB46_0 n128_mB46 n128_XB 0.05778f
Cn128eB46_1 n128_mB46 vdd 0.00496f
Cn128eB46_2 n128_mB46 n128_VB 0.0654f
Cn128eB46_3 n128_mB46 0 0.00298f
Cn128eB46_4 n128_mB46 0 0.20468f
Xn128edB47 n128_XB n128_VB n128_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB47 0 0 n128_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB47_0 n128_mB47 n128_XB 0.05778f
Cn128eB47_1 n128_mB47 vdd 0.00496f
Cn128eB47_2 n128_mB47 n128_VB 0.0654f
Cn128eB47_3 n128_mB47 0 0.00298f
Cn128eB47_4 n128_mB47 0 0.20468f
Xn128edB48 n128_XB n128_VB n128_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB48 0 0 n128_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB48_0 n128_mB48 n128_XB 0.05778f
Cn128eB48_1 n128_mB48 vdd 0.00496f
Cn128eB48_2 n128_mB48 n128_VB 0.0654f
Cn128eB48_3 n128_mB48 0 0.00298f
Cn128eB48_4 n128_mB48 0 0.20468f
Xn128edB49 n128_XB n128_VB n128_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB49 0 0 n128_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB49_0 n128_mB49 n128_XB 0.05778f
Cn128eB49_1 n128_mB49 vdd 0.00496f
Cn128eB49_2 n128_mB49 n128_VB 0.0654f
Cn128eB49_3 n128_mB49 0 0.00298f
Cn128eB49_4 n128_mB49 0 0.20468f
Xn128edB50 n128_XB n128_VB n128_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB50 0 0 n128_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB50_0 n128_mB50 n128_XB 0.05778f
Cn128eB50_1 n128_mB50 vdd 0.00496f
Cn128eB50_2 n128_mB50 n128_VB 0.0654f
Cn128eB50_3 n128_mB50 0 0.00298f
Cn128eB50_4 n128_mB50 0 0.20468f
Xn128edB51 n128_XB n128_VB n128_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB51 0 0 n128_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB51_0 n128_mB51 n128_XB 0.05778f
Cn128eB51_1 n128_mB51 vdd 0.00496f
Cn128eB51_2 n128_mB51 n128_VB 0.0654f
Cn128eB51_3 n128_mB51 0 0.00298f
Cn128eB51_4 n128_mB51 0 0.20468f
Xn128edB52 n128_XB n128_VB n128_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB52 0 0 n128_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB52_0 n128_mB52 n128_XB 0.05778f
Cn128eB52_1 n128_mB52 vdd 0.00496f
Cn128eB52_2 n128_mB52 n128_VB 0.0654f
Cn128eB52_3 n128_mB52 0 0.00298f
Cn128eB52_4 n128_mB52 0 0.20468f
Xn128edB53 n128_XB n128_VB n128_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB53 0 0 n128_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB53_0 n128_mB53 n128_XB 0.05778f
Cn128eB53_1 n128_mB53 vdd 0.00496f
Cn128eB53_2 n128_mB53 n128_VB 0.0654f
Cn128eB53_3 n128_mB53 0 0.00298f
Cn128eB53_4 n128_mB53 0 0.20468f
Xn128edB54 n128_XB n128_VB n128_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB54 0 0 n128_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB54_0 n128_mB54 n128_XB 0.05778f
Cn128eB54_1 n128_mB54 vdd 0.00496f
Cn128eB54_2 n128_mB54 n128_VB 0.0654f
Cn128eB54_3 n128_mB54 0 0.00298f
Cn128eB54_4 n128_mB54 0 0.20468f
Xn128edB55 n128_XB n128_VB n128_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB55 0 0 n128_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB55_0 n128_mB55 n128_XB 0.05778f
Cn128eB55_1 n128_mB55 vdd 0.00496f
Cn128eB55_2 n128_mB55 n128_VB 0.0654f
Cn128eB55_3 n128_mB55 0 0.00298f
Cn128eB55_4 n128_mB55 0 0.20468f
Xn128edB56 n128_XB n128_VB n128_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB56 0 0 n128_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB56_0 n128_mB56 n128_XB 0.05778f
Cn128eB56_1 n128_mB56 vdd 0.00496f
Cn128eB56_2 n128_mB56 n128_VB 0.0654f
Cn128eB56_3 n128_mB56 0 0.00298f
Cn128eB56_4 n128_mB56 0 0.20468f
Xn128edB57 n128_XB n128_VB n128_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB57 0 0 n128_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB57_0 n128_mB57 n128_XB 0.05778f
Cn128eB57_1 n128_mB57 vdd 0.00496f
Cn128eB57_2 n128_mB57 n128_VB 0.0654f
Cn128eB57_3 n128_mB57 0 0.00298f
Cn128eB57_4 n128_mB57 0 0.20468f
Xn128edB58 n128_XB n128_VB n128_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB58 0 0 n128_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB58_0 n128_mB58 n128_XB 0.05778f
Cn128eB58_1 n128_mB58 vdd 0.00496f
Cn128eB58_2 n128_mB58 n128_VB 0.0654f
Cn128eB58_3 n128_mB58 0 0.00298f
Cn128eB58_4 n128_mB58 0 0.20468f
Xn128edB59 n128_XB n128_VB n128_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB59 0 0 n128_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB59_0 n128_mB59 n128_XB 0.05778f
Cn128eB59_1 n128_mB59 vdd 0.00496f
Cn128eB59_2 n128_mB59 n128_VB 0.0654f
Cn128eB59_3 n128_mB59 0 0.00298f
Cn128eB59_4 n128_mB59 0 0.20468f
Xn128edB60 n128_XB n128_VB n128_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB60 0 0 n128_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB60_0 n128_mB60 n128_XB 0.05778f
Cn128eB60_1 n128_mB60 vdd 0.00496f
Cn128eB60_2 n128_mB60 n128_VB 0.0654f
Cn128eB60_3 n128_mB60 0 0.00298f
Cn128eB60_4 n128_mB60 0 0.20468f
Xn128edB61 n128_XB n128_VB n128_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB61 0 0 n128_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB61_0 n128_mB61 n128_XB 0.05778f
Cn128eB61_1 n128_mB61 vdd 0.00496f
Cn128eB61_2 n128_mB61 n128_VB 0.0654f
Cn128eB61_3 n128_mB61 0 0.00298f
Cn128eB61_4 n128_mB61 0 0.20468f
Xn128edB62 n128_XB n128_VB n128_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB62 0 0 n128_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB62_0 n128_mB62 n128_XB 0.05778f
Cn128eB62_1 n128_mB62 vdd 0.00496f
Cn128eB62_2 n128_mB62 n128_VB 0.0654f
Cn128eB62_3 n128_mB62 0 0.00298f
Cn128eB62_4 n128_mB62 0 0.20468f
Xn128edB63 n128_XB n128_VB n128_mB63 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB63 0 0 n128_mB63 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB63_0 n128_mB63 n128_XB 0.05778f
Cn128eB63_1 n128_mB63 vdd 0.00496f
Cn128eB63_2 n128_mB63 n128_VB 0.0654f
Cn128eB63_3 n128_mB63 0 0.00298f
Cn128eB63_4 n128_mB63 0 0.20468f
Xn128edB64 n128_XB n128_VB n128_mB64 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB64 0 0 n128_mB64 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB64_0 n128_mB64 n128_XB 0.05778f
Cn128eB64_1 n128_mB64 vdd 0.00496f
Cn128eB64_2 n128_mB64 n128_VB 0.0654f
Cn128eB64_3 n128_mB64 0 0.00298f
Cn128eB64_4 n128_mB64 0 0.20468f
Xn128edB65 n128_XB n128_VB n128_mB65 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB65 0 0 n128_mB65 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB65_0 n128_mB65 n128_XB 0.05778f
Cn128eB65_1 n128_mB65 vdd 0.00496f
Cn128eB65_2 n128_mB65 n128_VB 0.0654f
Cn128eB65_3 n128_mB65 0 0.00298f
Cn128eB65_4 n128_mB65 0 0.20468f
Xn128edB66 n128_XB n128_VB n128_mB66 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB66 0 0 n128_mB66 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB66_0 n128_mB66 n128_XB 0.05778f
Cn128eB66_1 n128_mB66 vdd 0.00496f
Cn128eB66_2 n128_mB66 n128_VB 0.0654f
Cn128eB66_3 n128_mB66 0 0.00298f
Cn128eB66_4 n128_mB66 0 0.20468f
Xn128edB67 n128_XB n128_VB n128_mB67 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB67 0 0 n128_mB67 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB67_0 n128_mB67 n128_XB 0.05778f
Cn128eB67_1 n128_mB67 vdd 0.00496f
Cn128eB67_2 n128_mB67 n128_VB 0.0654f
Cn128eB67_3 n128_mB67 0 0.00298f
Cn128eB67_4 n128_mB67 0 0.20468f
Xn128edB68 n128_XB n128_VB n128_mB68 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB68 0 0 n128_mB68 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB68_0 n128_mB68 n128_XB 0.05778f
Cn128eB68_1 n128_mB68 vdd 0.00496f
Cn128eB68_2 n128_mB68 n128_VB 0.0654f
Cn128eB68_3 n128_mB68 0 0.00298f
Cn128eB68_4 n128_mB68 0 0.20468f
Xn128edB69 n128_XB n128_VB n128_mB69 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB69 0 0 n128_mB69 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB69_0 n128_mB69 n128_XB 0.05778f
Cn128eB69_1 n128_mB69 vdd 0.00496f
Cn128eB69_2 n128_mB69 n128_VB 0.0654f
Cn128eB69_3 n128_mB69 0 0.00298f
Cn128eB69_4 n128_mB69 0 0.20468f
Xn128edB70 n128_XB n128_VB n128_mB70 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB70 0 0 n128_mB70 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB70_0 n128_mB70 n128_XB 0.05778f
Cn128eB70_1 n128_mB70 vdd 0.00496f
Cn128eB70_2 n128_mB70 n128_VB 0.0654f
Cn128eB70_3 n128_mB70 0 0.00298f
Cn128eB70_4 n128_mB70 0 0.20468f
Xn128edB71 n128_XB n128_VB n128_mB71 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB71 0 0 n128_mB71 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB71_0 n128_mB71 n128_XB 0.05778f
Cn128eB71_1 n128_mB71 vdd 0.00496f
Cn128eB71_2 n128_mB71 n128_VB 0.0654f
Cn128eB71_3 n128_mB71 0 0.00298f
Cn128eB71_4 n128_mB71 0 0.20468f
Xn128edB72 n128_XB n128_VB n128_mB72 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB72 0 0 n128_mB72 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB72_0 n128_mB72 n128_XB 0.05778f
Cn128eB72_1 n128_mB72 vdd 0.00496f
Cn128eB72_2 n128_mB72 n128_VB 0.0654f
Cn128eB72_3 n128_mB72 0 0.00298f
Cn128eB72_4 n128_mB72 0 0.20468f
Xn128edB73 n128_XB n128_VB n128_mB73 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB73 0 0 n128_mB73 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB73_0 n128_mB73 n128_XB 0.05778f
Cn128eB73_1 n128_mB73 vdd 0.00496f
Cn128eB73_2 n128_mB73 n128_VB 0.0654f
Cn128eB73_3 n128_mB73 0 0.00298f
Cn128eB73_4 n128_mB73 0 0.20468f
Xn128edB74 n128_XB n128_VB n128_mB74 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB74 0 0 n128_mB74 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB74_0 n128_mB74 n128_XB 0.05778f
Cn128eB74_1 n128_mB74 vdd 0.00496f
Cn128eB74_2 n128_mB74 n128_VB 0.0654f
Cn128eB74_3 n128_mB74 0 0.00298f
Cn128eB74_4 n128_mB74 0 0.20468f
Xn128edB75 n128_XB n128_VB n128_mB75 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB75 0 0 n128_mB75 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB75_0 n128_mB75 n128_XB 0.05778f
Cn128eB75_1 n128_mB75 vdd 0.00496f
Cn128eB75_2 n128_mB75 n128_VB 0.0654f
Cn128eB75_3 n128_mB75 0 0.00298f
Cn128eB75_4 n128_mB75 0 0.20468f
Xn128edB76 n128_XB n128_VB n128_mB76 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB76 0 0 n128_mB76 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB76_0 n128_mB76 n128_XB 0.05778f
Cn128eB76_1 n128_mB76 vdd 0.00496f
Cn128eB76_2 n128_mB76 n128_VB 0.0654f
Cn128eB76_3 n128_mB76 0 0.00298f
Cn128eB76_4 n128_mB76 0 0.20468f
Xn128edB77 n128_XB n128_VB n128_mB77 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB77 0 0 n128_mB77 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB77_0 n128_mB77 n128_XB 0.05778f
Cn128eB77_1 n128_mB77 vdd 0.00496f
Cn128eB77_2 n128_mB77 n128_VB 0.0654f
Cn128eB77_3 n128_mB77 0 0.00298f
Cn128eB77_4 n128_mB77 0 0.20468f
Xn128edB78 n128_XB n128_VB n128_mB78 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB78 0 0 n128_mB78 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB78_0 n128_mB78 n128_XB 0.05778f
Cn128eB78_1 n128_mB78 vdd 0.00496f
Cn128eB78_2 n128_mB78 n128_VB 0.0654f
Cn128eB78_3 n128_mB78 0 0.00298f
Cn128eB78_4 n128_mB78 0 0.20468f
Xn128edB79 n128_XB n128_VB n128_mB79 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB79 0 0 n128_mB79 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB79_0 n128_mB79 n128_XB 0.05778f
Cn128eB79_1 n128_mB79 vdd 0.00496f
Cn128eB79_2 n128_mB79 n128_VB 0.0654f
Cn128eB79_3 n128_mB79 0 0.00298f
Cn128eB79_4 n128_mB79 0 0.20468f
Xn128edB80 n128_XB n128_VB n128_mB80 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB80 0 0 n128_mB80 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB80_0 n128_mB80 n128_XB 0.05778f
Cn128eB80_1 n128_mB80 vdd 0.00496f
Cn128eB80_2 n128_mB80 n128_VB 0.0654f
Cn128eB80_3 n128_mB80 0 0.00298f
Cn128eB80_4 n128_mB80 0 0.20468f
Xn128edB81 n128_XB n128_VB n128_mB81 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB81 0 0 n128_mB81 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB81_0 n128_mB81 n128_XB 0.05778f
Cn128eB81_1 n128_mB81 vdd 0.00496f
Cn128eB81_2 n128_mB81 n128_VB 0.0654f
Cn128eB81_3 n128_mB81 0 0.00298f
Cn128eB81_4 n128_mB81 0 0.20468f
Xn128edB82 n128_XB n128_VB n128_mB82 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB82 0 0 n128_mB82 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB82_0 n128_mB82 n128_XB 0.05778f
Cn128eB82_1 n128_mB82 vdd 0.00496f
Cn128eB82_2 n128_mB82 n128_VB 0.0654f
Cn128eB82_3 n128_mB82 0 0.00298f
Cn128eB82_4 n128_mB82 0 0.20468f
Xn128edB83 n128_XB n128_VB n128_mB83 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB83 0 0 n128_mB83 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB83_0 n128_mB83 n128_XB 0.05778f
Cn128eB83_1 n128_mB83 vdd 0.00496f
Cn128eB83_2 n128_mB83 n128_VB 0.0654f
Cn128eB83_3 n128_mB83 0 0.00298f
Cn128eB83_4 n128_mB83 0 0.20468f
Xn128edB84 n128_XB n128_VB n128_mB84 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB84 0 0 n128_mB84 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB84_0 n128_mB84 n128_XB 0.05778f
Cn128eB84_1 n128_mB84 vdd 0.00496f
Cn128eB84_2 n128_mB84 n128_VB 0.0654f
Cn128eB84_3 n128_mB84 0 0.00298f
Cn128eB84_4 n128_mB84 0 0.20468f
Xn128edB85 n128_XB n128_VB n128_mB85 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB85 0 0 n128_mB85 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB85_0 n128_mB85 n128_XB 0.05778f
Cn128eB85_1 n128_mB85 vdd 0.00496f
Cn128eB85_2 n128_mB85 n128_VB 0.0654f
Cn128eB85_3 n128_mB85 0 0.00298f
Cn128eB85_4 n128_mB85 0 0.20468f
Xn128edB86 n128_XB n128_VB n128_mB86 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB86 0 0 n128_mB86 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB86_0 n128_mB86 n128_XB 0.05778f
Cn128eB86_1 n128_mB86 vdd 0.00496f
Cn128eB86_2 n128_mB86 n128_VB 0.0654f
Cn128eB86_3 n128_mB86 0 0.00298f
Cn128eB86_4 n128_mB86 0 0.20468f
Xn128edB87 n128_XB n128_VB n128_mB87 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB87 0 0 n128_mB87 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB87_0 n128_mB87 n128_XB 0.05778f
Cn128eB87_1 n128_mB87 vdd 0.00496f
Cn128eB87_2 n128_mB87 n128_VB 0.0654f
Cn128eB87_3 n128_mB87 0 0.00298f
Cn128eB87_4 n128_mB87 0 0.20468f
Xn128edB88 n128_XB n128_VB n128_mB88 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB88 0 0 n128_mB88 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB88_0 n128_mB88 n128_XB 0.05778f
Cn128eB88_1 n128_mB88 vdd 0.00496f
Cn128eB88_2 n128_mB88 n128_VB 0.0654f
Cn128eB88_3 n128_mB88 0 0.00298f
Cn128eB88_4 n128_mB88 0 0.20468f
Xn128edB89 n128_XB n128_VB n128_mB89 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB89 0 0 n128_mB89 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB89_0 n128_mB89 n128_XB 0.05778f
Cn128eB89_1 n128_mB89 vdd 0.00496f
Cn128eB89_2 n128_mB89 n128_VB 0.0654f
Cn128eB89_3 n128_mB89 0 0.00298f
Cn128eB89_4 n128_mB89 0 0.20468f
Xn128edB90 n128_XB n128_VB n128_mB90 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB90 0 0 n128_mB90 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB90_0 n128_mB90 n128_XB 0.05778f
Cn128eB90_1 n128_mB90 vdd 0.00496f
Cn128eB90_2 n128_mB90 n128_VB 0.0654f
Cn128eB90_3 n128_mB90 0 0.00298f
Cn128eB90_4 n128_mB90 0 0.20468f
Xn128edB91 n128_XB n128_VB n128_mB91 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB91 0 0 n128_mB91 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB91_0 n128_mB91 n128_XB 0.05778f
Cn128eB91_1 n128_mB91 vdd 0.00496f
Cn128eB91_2 n128_mB91 n128_VB 0.0654f
Cn128eB91_3 n128_mB91 0 0.00298f
Cn128eB91_4 n128_mB91 0 0.20468f
Xn128edB92 n128_XB n128_VB n128_mB92 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB92 0 0 n128_mB92 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB92_0 n128_mB92 n128_XB 0.05778f
Cn128eB92_1 n128_mB92 vdd 0.00496f
Cn128eB92_2 n128_mB92 n128_VB 0.0654f
Cn128eB92_3 n128_mB92 0 0.00298f
Cn128eB92_4 n128_mB92 0 0.20468f
Xn128edB93 n128_XB n128_VB n128_mB93 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB93 0 0 n128_mB93 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB93_0 n128_mB93 n128_XB 0.05778f
Cn128eB93_1 n128_mB93 vdd 0.00496f
Cn128eB93_2 n128_mB93 n128_VB 0.0654f
Cn128eB93_3 n128_mB93 0 0.00298f
Cn128eB93_4 n128_mB93 0 0.20468f
Xn128edB94 n128_XB n128_VB n128_mB94 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB94 0 0 n128_mB94 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB94_0 n128_mB94 n128_XB 0.05778f
Cn128eB94_1 n128_mB94 vdd 0.00496f
Cn128eB94_2 n128_mB94 n128_VB 0.0654f
Cn128eB94_3 n128_mB94 0 0.00298f
Cn128eB94_4 n128_mB94 0 0.20468f
Xn128edB95 n128_XB n128_VB n128_mB95 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB95 0 0 n128_mB95 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB95_0 n128_mB95 n128_XB 0.05778f
Cn128eB95_1 n128_mB95 vdd 0.00496f
Cn128eB95_2 n128_mB95 n128_VB 0.0654f
Cn128eB95_3 n128_mB95 0 0.00298f
Cn128eB95_4 n128_mB95 0 0.20468f
Xn128edB96 n128_XB n128_VB n128_mB96 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB96 0 0 n128_mB96 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB96_0 n128_mB96 n128_XB 0.05778f
Cn128eB96_1 n128_mB96 vdd 0.00496f
Cn128eB96_2 n128_mB96 n128_VB 0.0654f
Cn128eB96_3 n128_mB96 0 0.00298f
Cn128eB96_4 n128_mB96 0 0.20468f
Xn128edB97 n128_XB n128_VB n128_mB97 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB97 0 0 n128_mB97 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB97_0 n128_mB97 n128_XB 0.05778f
Cn128eB97_1 n128_mB97 vdd 0.00496f
Cn128eB97_2 n128_mB97 n128_VB 0.0654f
Cn128eB97_3 n128_mB97 0 0.00298f
Cn128eB97_4 n128_mB97 0 0.20468f
Xn128edB98 n128_XB n128_VB n128_mB98 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB98 0 0 n128_mB98 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB98_0 n128_mB98 n128_XB 0.05778f
Cn128eB98_1 n128_mB98 vdd 0.00496f
Cn128eB98_2 n128_mB98 n128_VB 0.0654f
Cn128eB98_3 n128_mB98 0 0.00298f
Cn128eB98_4 n128_mB98 0 0.20468f
Xn128edB99 n128_XB n128_VB n128_mB99 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB99 0 0 n128_mB99 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB99_0 n128_mB99 n128_XB 0.05778f
Cn128eB99_1 n128_mB99 vdd 0.00496f
Cn128eB99_2 n128_mB99 n128_VB 0.0654f
Cn128eB99_3 n128_mB99 0 0.00298f
Cn128eB99_4 n128_mB99 0 0.20468f
Xn128edB100 n128_XB n128_VB n128_mB100 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB100 0 0 n128_mB100 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB100_0 n128_mB100 n128_XB 0.05778f
Cn128eB100_1 n128_mB100 vdd 0.00496f
Cn128eB100_2 n128_mB100 n128_VB 0.0654f
Cn128eB100_3 n128_mB100 0 0.00298f
Cn128eB100_4 n128_mB100 0 0.20468f
Xn128edB101 n128_XB n128_VB n128_mB101 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB101 0 0 n128_mB101 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB101_0 n128_mB101 n128_XB 0.05778f
Cn128eB101_1 n128_mB101 vdd 0.00496f
Cn128eB101_2 n128_mB101 n128_VB 0.0654f
Cn128eB101_3 n128_mB101 0 0.00298f
Cn128eB101_4 n128_mB101 0 0.20468f
Xn128edB102 n128_XB n128_VB n128_mB102 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB102 0 0 n128_mB102 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB102_0 n128_mB102 n128_XB 0.05778f
Cn128eB102_1 n128_mB102 vdd 0.00496f
Cn128eB102_2 n128_mB102 n128_VB 0.0654f
Cn128eB102_3 n128_mB102 0 0.00298f
Cn128eB102_4 n128_mB102 0 0.20468f
Xn128edB103 n128_XB n128_VB n128_mB103 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB103 0 0 n128_mB103 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB103_0 n128_mB103 n128_XB 0.05778f
Cn128eB103_1 n128_mB103 vdd 0.00496f
Cn128eB103_2 n128_mB103 n128_VB 0.0654f
Cn128eB103_3 n128_mB103 0 0.00298f
Cn128eB103_4 n128_mB103 0 0.20468f
Xn128edB104 n128_XB n128_VB n128_mB104 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB104 0 0 n128_mB104 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB104_0 n128_mB104 n128_XB 0.05778f
Cn128eB104_1 n128_mB104 vdd 0.00496f
Cn128eB104_2 n128_mB104 n128_VB 0.0654f
Cn128eB104_3 n128_mB104 0 0.00298f
Cn128eB104_4 n128_mB104 0 0.20468f
Xn128edB105 n128_XB n128_VB n128_mB105 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB105 0 0 n128_mB105 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB105_0 n128_mB105 n128_XB 0.05778f
Cn128eB105_1 n128_mB105 vdd 0.00496f
Cn128eB105_2 n128_mB105 n128_VB 0.0654f
Cn128eB105_3 n128_mB105 0 0.00298f
Cn128eB105_4 n128_mB105 0 0.20468f
Xn128edB106 n128_XB n128_VB n128_mB106 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB106 0 0 n128_mB106 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB106_0 n128_mB106 n128_XB 0.05778f
Cn128eB106_1 n128_mB106 vdd 0.00496f
Cn128eB106_2 n128_mB106 n128_VB 0.0654f
Cn128eB106_3 n128_mB106 0 0.00298f
Cn128eB106_4 n128_mB106 0 0.20468f
Xn128edB107 n128_XB n128_VB n128_mB107 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB107 0 0 n128_mB107 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB107_0 n128_mB107 n128_XB 0.05778f
Cn128eB107_1 n128_mB107 vdd 0.00496f
Cn128eB107_2 n128_mB107 n128_VB 0.0654f
Cn128eB107_3 n128_mB107 0 0.00298f
Cn128eB107_4 n128_mB107 0 0.20468f
Xn128edB108 n128_XB n128_VB n128_mB108 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB108 0 0 n128_mB108 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB108_0 n128_mB108 n128_XB 0.05778f
Cn128eB108_1 n128_mB108 vdd 0.00496f
Cn128eB108_2 n128_mB108 n128_VB 0.0654f
Cn128eB108_3 n128_mB108 0 0.00298f
Cn128eB108_4 n128_mB108 0 0.20468f
Xn128edB109 n128_XB n128_VB n128_mB109 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB109 0 0 n128_mB109 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB109_0 n128_mB109 n128_XB 0.05778f
Cn128eB109_1 n128_mB109 vdd 0.00496f
Cn128eB109_2 n128_mB109 n128_VB 0.0654f
Cn128eB109_3 n128_mB109 0 0.00298f
Cn128eB109_4 n128_mB109 0 0.20468f
Xn128edB110 n128_XB n128_VB n128_mB110 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB110 0 0 n128_mB110 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB110_0 n128_mB110 n128_XB 0.05778f
Cn128eB110_1 n128_mB110 vdd 0.00496f
Cn128eB110_2 n128_mB110 n128_VB 0.0654f
Cn128eB110_3 n128_mB110 0 0.00298f
Cn128eB110_4 n128_mB110 0 0.20468f
Xn128edB111 n128_XB n128_VB n128_mB111 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB111 0 0 n128_mB111 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB111_0 n128_mB111 n128_XB 0.05778f
Cn128eB111_1 n128_mB111 vdd 0.00496f
Cn128eB111_2 n128_mB111 n128_VB 0.0654f
Cn128eB111_3 n128_mB111 0 0.00298f
Cn128eB111_4 n128_mB111 0 0.20468f
Xn128edB112 n128_XB n128_VB n128_mB112 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB112 0 0 n128_mB112 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB112_0 n128_mB112 n128_XB 0.05778f
Cn128eB112_1 n128_mB112 vdd 0.00496f
Cn128eB112_2 n128_mB112 n128_VB 0.0654f
Cn128eB112_3 n128_mB112 0 0.00298f
Cn128eB112_4 n128_mB112 0 0.20468f
Xn128edB113 n128_XB n128_VB n128_mB113 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB113 0 0 n128_mB113 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB113_0 n128_mB113 n128_XB 0.05778f
Cn128eB113_1 n128_mB113 vdd 0.00496f
Cn128eB113_2 n128_mB113 n128_VB 0.0654f
Cn128eB113_3 n128_mB113 0 0.00298f
Cn128eB113_4 n128_mB113 0 0.20468f
Xn128edB114 n128_XB n128_VB n128_mB114 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB114 0 0 n128_mB114 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB114_0 n128_mB114 n128_XB 0.05778f
Cn128eB114_1 n128_mB114 vdd 0.00496f
Cn128eB114_2 n128_mB114 n128_VB 0.0654f
Cn128eB114_3 n128_mB114 0 0.00298f
Cn128eB114_4 n128_mB114 0 0.20468f
Xn128edB115 n128_XB n128_VB n128_mB115 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB115 0 0 n128_mB115 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB115_0 n128_mB115 n128_XB 0.05778f
Cn128eB115_1 n128_mB115 vdd 0.00496f
Cn128eB115_2 n128_mB115 n128_VB 0.0654f
Cn128eB115_3 n128_mB115 0 0.00298f
Cn128eB115_4 n128_mB115 0 0.20468f
Xn128edB116 n128_XB n128_VB n128_mB116 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB116 0 0 n128_mB116 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB116_0 n128_mB116 n128_XB 0.05778f
Cn128eB116_1 n128_mB116 vdd 0.00496f
Cn128eB116_2 n128_mB116 n128_VB 0.0654f
Cn128eB116_3 n128_mB116 0 0.00298f
Cn128eB116_4 n128_mB116 0 0.20468f
Xn128edB117 n128_XB n128_VB n128_mB117 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB117 0 0 n128_mB117 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB117_0 n128_mB117 n128_XB 0.05778f
Cn128eB117_1 n128_mB117 vdd 0.00496f
Cn128eB117_2 n128_mB117 n128_VB 0.0654f
Cn128eB117_3 n128_mB117 0 0.00298f
Cn128eB117_4 n128_mB117 0 0.20468f
Xn128edB118 n128_XB n128_VB n128_mB118 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB118 0 0 n128_mB118 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB118_0 n128_mB118 n128_XB 0.05778f
Cn128eB118_1 n128_mB118 vdd 0.00496f
Cn128eB118_2 n128_mB118 n128_VB 0.0654f
Cn128eB118_3 n128_mB118 0 0.00298f
Cn128eB118_4 n128_mB118 0 0.20468f
Xn128edB119 n128_XB n128_VB n128_mB119 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB119 0 0 n128_mB119 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB119_0 n128_mB119 n128_XB 0.05778f
Cn128eB119_1 n128_mB119 vdd 0.00496f
Cn128eB119_2 n128_mB119 n128_VB 0.0654f
Cn128eB119_3 n128_mB119 0 0.00298f
Cn128eB119_4 n128_mB119 0 0.20468f
Xn128edB120 n128_XB n128_VB n128_mB120 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB120 0 0 n128_mB120 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB120_0 n128_mB120 n128_XB 0.05778f
Cn128eB120_1 n128_mB120 vdd 0.00496f
Cn128eB120_2 n128_mB120 n128_VB 0.0654f
Cn128eB120_3 n128_mB120 0 0.00298f
Cn128eB120_4 n128_mB120 0 0.20468f
Xn128edB121 n128_XB n128_VB n128_mB121 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB121 0 0 n128_mB121 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB121_0 n128_mB121 n128_XB 0.05778f
Cn128eB121_1 n128_mB121 vdd 0.00496f
Cn128eB121_2 n128_mB121 n128_VB 0.0654f
Cn128eB121_3 n128_mB121 0 0.00298f
Cn128eB121_4 n128_mB121 0 0.20468f
Xn128edB122 n128_XB n128_VB n128_mB122 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB122 0 0 n128_mB122 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB122_0 n128_mB122 n128_XB 0.05778f
Cn128eB122_1 n128_mB122 vdd 0.00496f
Cn128eB122_2 n128_mB122 n128_VB 0.0654f
Cn128eB122_3 n128_mB122 0 0.00298f
Cn128eB122_4 n128_mB122 0 0.20468f
Xn128edB123 n128_XB n128_VB n128_mB123 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB123 0 0 n128_mB123 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB123_0 n128_mB123 n128_XB 0.05778f
Cn128eB123_1 n128_mB123 vdd 0.00496f
Cn128eB123_2 n128_mB123 n128_VB 0.0654f
Cn128eB123_3 n128_mB123 0 0.00298f
Cn128eB123_4 n128_mB123 0 0.20468f
Xn128edB124 n128_XB n128_VB n128_mB124 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB124 0 0 n128_mB124 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB124_0 n128_mB124 n128_XB 0.05778f
Cn128eB124_1 n128_mB124 vdd 0.00496f
Cn128eB124_2 n128_mB124 n128_VB 0.0654f
Cn128eB124_3 n128_mB124 0 0.00298f
Cn128eB124_4 n128_mB124 0 0.20468f
Xn128edB125 n128_XB n128_VB n128_mB125 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB125 0 0 n128_mB125 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB125_0 n128_mB125 n128_XB 0.05778f
Cn128eB125_1 n128_mB125 vdd 0.00496f
Cn128eB125_2 n128_mB125 n128_VB 0.0654f
Cn128eB125_3 n128_mB125 0 0.00298f
Cn128eB125_4 n128_mB125 0 0.20468f
Xn128edB126 n128_XB n128_VB n128_mB126 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn128esB126 0 0 n128_mB126 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Cn128eB126_0 n128_mB126 n128_XB 0.05778f
Cn128eB126_1 n128_mB126 vdd 0.00496f
Cn128eB126_2 n128_mB126 n128_VB 0.0654f
Cn128eB126_3 n128_mB126 0 0.00298f
Cn128eB126_4 n128_mB126 0 0.20468f

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


* --- t64: trap
Xt64_ienn hi 0 0 vdd vdd t64_enn sky130_fd_sc_hd__inv_1
Xt64_is1n 0 0 0 vdd vdd t64_s1n sky130_fd_sc_hd__inv_1
Xt64_is0n hi 0 0 vdd vdd t64_s0n sky130_fd_sc_hd__inv_1
Xt64_PREA pre t64_enn 0 0 vdd vdd t64_PREA sky130_fd_sc_hd__nor2_1
Xt64_PREB pre t64_enn 0 0 vdd vdd t64_PREB sky130_fd_sc_hd__nor2_1
Xt64_VBIAS hi 0 0 vdd vdd t64_VBIAS sky130_fd_sc_hd__buf_2
Xt64_C1 hi 0 0 vdd vdd t64_C1 sky130_fd_sc_hd__buf_2
Xt64_DUTA hi t64_s1n hi 0 0 vdd vdd t64_DUTA sky130_fd_sc_hd__and3_1
Xt64_DUTB hi t64_s1n hi 0 0 vdd vdd t64_DUTB sky130_fd_sc_hd__and3_1
Xt64_REFA hi 0 0 0 vdd vdd t64_REFA sky130_fd_sc_hd__and2_1
Xt64_REFB hi 0 0 0 vdd vdd t64_REFB sky130_fd_sc_hd__and2_1
Xt64_SA0B hi 0 hi 0 0 vdd vdd t64_SA0B sky130_fd_sc_hd__nand3_1
Xt64_SA1B hi 0 0 0 vdd vdd t64_SA1B sky130_fd_sc_hd__nand2_1
Xt64_SA2B hi 0 t64_s0n 0 0 vdd vdd t64_SA2B sky130_fd_sc_hd__nand3_1
Xt64_SB0B hi 0 0 0 vdd vdd t64_SB0B sky130_fd_sc_hd__nand2_1
Xt64_SB1B hi 0 0 0 vdd vdd t64_SB1B sky130_fd_sc_hd__nand2_1
Xt64_M t64_ob t64_SB0B t64_SB1B t64_REFB t64_oa t64_SA0B t64_SA1B t64_SA2B t64_REFA vdd 0 t64_VBIAS t64_C1 t64_PREA t64_XA t64_DUTA t64_PREB t64_XB t64_DUTB t64_VB 0 0 t64_GT trap
Bt64_gt t64_GT 0 V=v(t64_VB)+0.000305
Xt64edA0 t64_XA t64_VB t64_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA0 0 0 t64_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA0_0 t64_mA0 0 0.00298f
Ct64eA0_1 t64_mA0 t64_XA 0.05981f
Ct64eA0_2 t64_mA0 vdd 0.00496f
Ct64eA0_3 t64_mA0 t64_VB 0.07228f
Ct64eA0_4 t64_mA0 0 0.19922f
Xt64edA1 t64_XA t64_VB t64_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA1 0 0 t64_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA1_0 t64_mA1 0 0.00298f
Ct64eA1_1 t64_mA1 t64_XA 0.05981f
Ct64eA1_2 t64_mA1 vdd 0.00496f
Ct64eA1_3 t64_mA1 t64_VB 0.07228f
Ct64eA1_4 t64_mA1 0 0.19922f
Xt64edA2 t64_XA t64_VB t64_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA2 0 0 t64_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA2_0 t64_mA2 0 0.00298f
Ct64eA2_1 t64_mA2 t64_XA 0.05981f
Ct64eA2_2 t64_mA2 vdd 0.00496f
Ct64eA2_3 t64_mA2 t64_VB 0.07228f
Ct64eA2_4 t64_mA2 0 0.19922f
Xt64edA3 t64_XA t64_VB t64_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA3 0 0 t64_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA3_0 t64_mA3 0 0.00298f
Ct64eA3_1 t64_mA3 t64_XA 0.05981f
Ct64eA3_2 t64_mA3 vdd 0.00496f
Ct64eA3_3 t64_mA3 t64_VB 0.07228f
Ct64eA3_4 t64_mA3 0 0.19922f
Xt64edA4 t64_XA t64_VB t64_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA4 0 0 t64_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA4_0 t64_mA4 0 0.00298f
Ct64eA4_1 t64_mA4 t64_XA 0.05981f
Ct64eA4_2 t64_mA4 vdd 0.00496f
Ct64eA4_3 t64_mA4 t64_VB 0.07228f
Ct64eA4_4 t64_mA4 0 0.19922f
Xt64edA5 t64_XA t64_VB t64_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA5 0 0 t64_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA5_0 t64_mA5 0 0.00298f
Ct64eA5_1 t64_mA5 t64_XA 0.05981f
Ct64eA5_2 t64_mA5 vdd 0.00496f
Ct64eA5_3 t64_mA5 t64_VB 0.07228f
Ct64eA5_4 t64_mA5 0 0.19922f
Xt64edA6 t64_XA t64_VB t64_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA6 0 0 t64_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA6_0 t64_mA6 0 0.00298f
Ct64eA6_1 t64_mA6 t64_XA 0.05981f
Ct64eA6_2 t64_mA6 vdd 0.00496f
Ct64eA6_3 t64_mA6 t64_VB 0.07228f
Ct64eA6_4 t64_mA6 0 0.19922f
Xt64edA7 t64_XA t64_VB t64_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA7 0 0 t64_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA7_0 t64_mA7 0 0.00298f
Ct64eA7_1 t64_mA7 t64_XA 0.05981f
Ct64eA7_2 t64_mA7 vdd 0.00496f
Ct64eA7_3 t64_mA7 t64_VB 0.07228f
Ct64eA7_4 t64_mA7 0 0.19922f
Xt64edA8 t64_XA t64_VB t64_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA8 0 0 t64_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA8_0 t64_mA8 0 0.00298f
Ct64eA8_1 t64_mA8 t64_XA 0.05981f
Ct64eA8_2 t64_mA8 vdd 0.00496f
Ct64eA8_3 t64_mA8 t64_VB 0.07228f
Ct64eA8_4 t64_mA8 0 0.19922f
Xt64edA9 t64_XA t64_VB t64_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA9 0 0 t64_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA9_0 t64_mA9 0 0.00298f
Ct64eA9_1 t64_mA9 t64_XA 0.05981f
Ct64eA9_2 t64_mA9 vdd 0.00496f
Ct64eA9_3 t64_mA9 t64_VB 0.07228f
Ct64eA9_4 t64_mA9 0 0.19922f
Xt64edA10 t64_XA t64_VB t64_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA10 0 0 t64_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA10_0 t64_mA10 0 0.00298f
Ct64eA10_1 t64_mA10 t64_XA 0.05981f
Ct64eA10_2 t64_mA10 vdd 0.00496f
Ct64eA10_3 t64_mA10 t64_VB 0.07228f
Ct64eA10_4 t64_mA10 0 0.19922f
Xt64edA11 t64_XA t64_VB t64_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA11 0 0 t64_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA11_0 t64_mA11 0 0.00298f
Ct64eA11_1 t64_mA11 t64_XA 0.05981f
Ct64eA11_2 t64_mA11 vdd 0.00496f
Ct64eA11_3 t64_mA11 t64_VB 0.07228f
Ct64eA11_4 t64_mA11 0 0.19922f
Xt64edA12 t64_XA t64_VB t64_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA12 0 0 t64_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA12_0 t64_mA12 0 0.00298f
Ct64eA12_1 t64_mA12 t64_XA 0.05981f
Ct64eA12_2 t64_mA12 vdd 0.00496f
Ct64eA12_3 t64_mA12 t64_VB 0.07228f
Ct64eA12_4 t64_mA12 0 0.19922f
Xt64edA13 t64_XA t64_VB t64_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA13 0 0 t64_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA13_0 t64_mA13 0 0.00298f
Ct64eA13_1 t64_mA13 t64_XA 0.05981f
Ct64eA13_2 t64_mA13 vdd 0.00496f
Ct64eA13_3 t64_mA13 t64_VB 0.07228f
Ct64eA13_4 t64_mA13 0 0.19922f
Xt64edA14 t64_XA t64_VB t64_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA14 0 0 t64_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA14_0 t64_mA14 0 0.00298f
Ct64eA14_1 t64_mA14 t64_XA 0.05981f
Ct64eA14_2 t64_mA14 vdd 0.00496f
Ct64eA14_3 t64_mA14 t64_VB 0.07228f
Ct64eA14_4 t64_mA14 0 0.19922f
Xt64edA15 t64_XA t64_VB t64_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA15 0 0 t64_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA15_0 t64_mA15 0 0.00298f
Ct64eA15_1 t64_mA15 t64_XA 0.05981f
Ct64eA15_2 t64_mA15 vdd 0.00496f
Ct64eA15_3 t64_mA15 t64_VB 0.07228f
Ct64eA15_4 t64_mA15 0 0.19922f
Xt64edA16 t64_XA t64_VB t64_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA16 0 0 t64_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA16_0 t64_mA16 0 0.00298f
Ct64eA16_1 t64_mA16 t64_XA 0.05981f
Ct64eA16_2 t64_mA16 vdd 0.00496f
Ct64eA16_3 t64_mA16 t64_VB 0.07228f
Ct64eA16_4 t64_mA16 0 0.19922f
Xt64edA17 t64_XA t64_VB t64_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA17 0 0 t64_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA17_0 t64_mA17 0 0.00298f
Ct64eA17_1 t64_mA17 t64_XA 0.05981f
Ct64eA17_2 t64_mA17 vdd 0.00496f
Ct64eA17_3 t64_mA17 t64_VB 0.07228f
Ct64eA17_4 t64_mA17 0 0.19922f
Xt64edA18 t64_XA t64_VB t64_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA18 0 0 t64_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA18_0 t64_mA18 0 0.00298f
Ct64eA18_1 t64_mA18 t64_XA 0.05981f
Ct64eA18_2 t64_mA18 vdd 0.00496f
Ct64eA18_3 t64_mA18 t64_VB 0.07228f
Ct64eA18_4 t64_mA18 0 0.19922f
Xt64edA19 t64_XA t64_VB t64_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA19 0 0 t64_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA19_0 t64_mA19 0 0.00298f
Ct64eA19_1 t64_mA19 t64_XA 0.05981f
Ct64eA19_2 t64_mA19 vdd 0.00496f
Ct64eA19_3 t64_mA19 t64_VB 0.07228f
Ct64eA19_4 t64_mA19 0 0.19922f
Xt64edA20 t64_XA t64_VB t64_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA20 0 0 t64_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA20_0 t64_mA20 0 0.00298f
Ct64eA20_1 t64_mA20 t64_XA 0.05981f
Ct64eA20_2 t64_mA20 vdd 0.00496f
Ct64eA20_3 t64_mA20 t64_VB 0.07228f
Ct64eA20_4 t64_mA20 0 0.19922f
Xt64edA21 t64_XA t64_VB t64_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA21 0 0 t64_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA21_0 t64_mA21 0 0.00298f
Ct64eA21_1 t64_mA21 t64_XA 0.05981f
Ct64eA21_2 t64_mA21 vdd 0.00496f
Ct64eA21_3 t64_mA21 t64_VB 0.07228f
Ct64eA21_4 t64_mA21 0 0.19922f
Xt64edA22 t64_XA t64_VB t64_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA22 0 0 t64_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA22_0 t64_mA22 0 0.00298f
Ct64eA22_1 t64_mA22 t64_XA 0.05981f
Ct64eA22_2 t64_mA22 vdd 0.00496f
Ct64eA22_3 t64_mA22 t64_VB 0.07228f
Ct64eA22_4 t64_mA22 0 0.19922f
Xt64edA23 t64_XA t64_VB t64_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA23 0 0 t64_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA23_0 t64_mA23 0 0.00298f
Ct64eA23_1 t64_mA23 t64_XA 0.05981f
Ct64eA23_2 t64_mA23 vdd 0.00496f
Ct64eA23_3 t64_mA23 t64_VB 0.07228f
Ct64eA23_4 t64_mA23 0 0.19922f
Xt64edA24 t64_XA t64_VB t64_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA24 0 0 t64_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA24_0 t64_mA24 0 0.00298f
Ct64eA24_1 t64_mA24 t64_XA 0.05981f
Ct64eA24_2 t64_mA24 vdd 0.00496f
Ct64eA24_3 t64_mA24 t64_VB 0.07228f
Ct64eA24_4 t64_mA24 0 0.19922f
Xt64edA25 t64_XA t64_VB t64_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA25 0 0 t64_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA25_0 t64_mA25 0 0.00298f
Ct64eA25_1 t64_mA25 t64_XA 0.05981f
Ct64eA25_2 t64_mA25 vdd 0.00496f
Ct64eA25_3 t64_mA25 t64_VB 0.07228f
Ct64eA25_4 t64_mA25 0 0.19922f
Xt64edA26 t64_XA t64_VB t64_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA26 0 0 t64_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA26_0 t64_mA26 0 0.00298f
Ct64eA26_1 t64_mA26 t64_XA 0.05981f
Ct64eA26_2 t64_mA26 vdd 0.00496f
Ct64eA26_3 t64_mA26 t64_VB 0.07228f
Ct64eA26_4 t64_mA26 0 0.19922f
Xt64edA27 t64_XA t64_VB t64_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA27 0 0 t64_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA27_0 t64_mA27 0 0.00298f
Ct64eA27_1 t64_mA27 t64_XA 0.05981f
Ct64eA27_2 t64_mA27 vdd 0.00496f
Ct64eA27_3 t64_mA27 t64_VB 0.07228f
Ct64eA27_4 t64_mA27 0 0.19922f
Xt64edA28 t64_XA t64_VB t64_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA28 0 0 t64_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA28_0 t64_mA28 0 0.00298f
Ct64eA28_1 t64_mA28 t64_XA 0.05981f
Ct64eA28_2 t64_mA28 vdd 0.00496f
Ct64eA28_3 t64_mA28 t64_VB 0.07228f
Ct64eA28_4 t64_mA28 0 0.19922f
Xt64edA29 t64_XA t64_VB t64_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA29 0 0 t64_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA29_0 t64_mA29 0 0.00298f
Ct64eA29_1 t64_mA29 t64_XA 0.05981f
Ct64eA29_2 t64_mA29 vdd 0.00496f
Ct64eA29_3 t64_mA29 t64_VB 0.07228f
Ct64eA29_4 t64_mA29 0 0.19922f
Xt64edA30 t64_XA t64_VB t64_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA30 0 0 t64_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA30_0 t64_mA30 0 0.00298f
Ct64eA30_1 t64_mA30 t64_XA 0.05981f
Ct64eA30_2 t64_mA30 vdd 0.00496f
Ct64eA30_3 t64_mA30 t64_VB 0.07228f
Ct64eA30_4 t64_mA30 0 0.19922f
Xt64edA31 t64_XA t64_VB t64_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA31 0 0 t64_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA31_0 t64_mA31 0 0.00298f
Ct64eA31_1 t64_mA31 t64_XA 0.05981f
Ct64eA31_2 t64_mA31 vdd 0.00496f
Ct64eA31_3 t64_mA31 t64_VB 0.07228f
Ct64eA31_4 t64_mA31 0 0.19922f
Xt64edA32 t64_XA t64_VB t64_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA32 0 0 t64_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA32_0 t64_mA32 0 0.00298f
Ct64eA32_1 t64_mA32 t64_XA 0.05981f
Ct64eA32_2 t64_mA32 vdd 0.00496f
Ct64eA32_3 t64_mA32 t64_VB 0.07228f
Ct64eA32_4 t64_mA32 0 0.19922f
Xt64edA33 t64_XA t64_VB t64_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA33 0 0 t64_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA33_0 t64_mA33 0 0.00298f
Ct64eA33_1 t64_mA33 t64_XA 0.05981f
Ct64eA33_2 t64_mA33 vdd 0.00496f
Ct64eA33_3 t64_mA33 t64_VB 0.07228f
Ct64eA33_4 t64_mA33 0 0.19922f
Xt64edA34 t64_XA t64_VB t64_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA34 0 0 t64_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA34_0 t64_mA34 0 0.00298f
Ct64eA34_1 t64_mA34 t64_XA 0.05981f
Ct64eA34_2 t64_mA34 vdd 0.00496f
Ct64eA34_3 t64_mA34 t64_VB 0.07228f
Ct64eA34_4 t64_mA34 0 0.19922f
Xt64edA35 t64_XA t64_VB t64_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA35 0 0 t64_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA35_0 t64_mA35 0 0.00298f
Ct64eA35_1 t64_mA35 t64_XA 0.05981f
Ct64eA35_2 t64_mA35 vdd 0.00496f
Ct64eA35_3 t64_mA35 t64_VB 0.07228f
Ct64eA35_4 t64_mA35 0 0.19922f
Xt64edA36 t64_XA t64_VB t64_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA36 0 0 t64_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA36_0 t64_mA36 0 0.00298f
Ct64eA36_1 t64_mA36 t64_XA 0.05981f
Ct64eA36_2 t64_mA36 vdd 0.00496f
Ct64eA36_3 t64_mA36 t64_VB 0.07228f
Ct64eA36_4 t64_mA36 0 0.19922f
Xt64edA37 t64_XA t64_VB t64_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA37 0 0 t64_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA37_0 t64_mA37 0 0.00298f
Ct64eA37_1 t64_mA37 t64_XA 0.05981f
Ct64eA37_2 t64_mA37 vdd 0.00496f
Ct64eA37_3 t64_mA37 t64_VB 0.07228f
Ct64eA37_4 t64_mA37 0 0.19922f
Xt64edA38 t64_XA t64_VB t64_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA38 0 0 t64_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA38_0 t64_mA38 0 0.00298f
Ct64eA38_1 t64_mA38 t64_XA 0.05981f
Ct64eA38_2 t64_mA38 vdd 0.00496f
Ct64eA38_3 t64_mA38 t64_VB 0.07228f
Ct64eA38_4 t64_mA38 0 0.19922f
Xt64edA39 t64_XA t64_VB t64_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA39 0 0 t64_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA39_0 t64_mA39 0 0.00298f
Ct64eA39_1 t64_mA39 t64_XA 0.05981f
Ct64eA39_2 t64_mA39 vdd 0.00496f
Ct64eA39_3 t64_mA39 t64_VB 0.07228f
Ct64eA39_4 t64_mA39 0 0.19922f
Xt64edA40 t64_XA t64_VB t64_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA40 0 0 t64_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA40_0 t64_mA40 0 0.00298f
Ct64eA40_1 t64_mA40 t64_XA 0.05981f
Ct64eA40_2 t64_mA40 vdd 0.00496f
Ct64eA40_3 t64_mA40 t64_VB 0.07228f
Ct64eA40_4 t64_mA40 0 0.19922f
Xt64edA41 t64_XA t64_VB t64_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA41 0 0 t64_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA41_0 t64_mA41 0 0.00298f
Ct64eA41_1 t64_mA41 t64_XA 0.05981f
Ct64eA41_2 t64_mA41 vdd 0.00496f
Ct64eA41_3 t64_mA41 t64_VB 0.07228f
Ct64eA41_4 t64_mA41 0 0.19922f
Xt64edA42 t64_XA t64_VB t64_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA42 0 0 t64_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA42_0 t64_mA42 0 0.00298f
Ct64eA42_1 t64_mA42 t64_XA 0.05981f
Ct64eA42_2 t64_mA42 vdd 0.00496f
Ct64eA42_3 t64_mA42 t64_VB 0.07228f
Ct64eA42_4 t64_mA42 0 0.19922f
Xt64edA43 t64_XA t64_VB t64_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA43 0 0 t64_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA43_0 t64_mA43 0 0.00298f
Ct64eA43_1 t64_mA43 t64_XA 0.05981f
Ct64eA43_2 t64_mA43 vdd 0.00496f
Ct64eA43_3 t64_mA43 t64_VB 0.07228f
Ct64eA43_4 t64_mA43 0 0.19922f
Xt64edA44 t64_XA t64_VB t64_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA44 0 0 t64_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA44_0 t64_mA44 0 0.00298f
Ct64eA44_1 t64_mA44 t64_XA 0.05981f
Ct64eA44_2 t64_mA44 vdd 0.00496f
Ct64eA44_3 t64_mA44 t64_VB 0.07228f
Ct64eA44_4 t64_mA44 0 0.19922f
Xt64edA45 t64_XA t64_VB t64_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA45 0 0 t64_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA45_0 t64_mA45 0 0.00298f
Ct64eA45_1 t64_mA45 t64_XA 0.05981f
Ct64eA45_2 t64_mA45 vdd 0.00496f
Ct64eA45_3 t64_mA45 t64_VB 0.07228f
Ct64eA45_4 t64_mA45 0 0.19922f
Xt64edA46 t64_XA t64_VB t64_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA46 0 0 t64_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA46_0 t64_mA46 0 0.00298f
Ct64eA46_1 t64_mA46 t64_XA 0.05981f
Ct64eA46_2 t64_mA46 vdd 0.00496f
Ct64eA46_3 t64_mA46 t64_VB 0.07228f
Ct64eA46_4 t64_mA46 0 0.19922f
Xt64edA47 t64_XA t64_VB t64_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA47 0 0 t64_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA47_0 t64_mA47 0 0.00298f
Ct64eA47_1 t64_mA47 t64_XA 0.05981f
Ct64eA47_2 t64_mA47 vdd 0.00496f
Ct64eA47_3 t64_mA47 t64_VB 0.07228f
Ct64eA47_4 t64_mA47 0 0.19922f
Xt64edA48 t64_XA t64_VB t64_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA48 0 0 t64_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA48_0 t64_mA48 0 0.00298f
Ct64eA48_1 t64_mA48 t64_XA 0.05981f
Ct64eA48_2 t64_mA48 vdd 0.00496f
Ct64eA48_3 t64_mA48 t64_VB 0.07228f
Ct64eA48_4 t64_mA48 0 0.19922f
Xt64edA49 t64_XA t64_VB t64_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA49 0 0 t64_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA49_0 t64_mA49 0 0.00298f
Ct64eA49_1 t64_mA49 t64_XA 0.05981f
Ct64eA49_2 t64_mA49 vdd 0.00496f
Ct64eA49_3 t64_mA49 t64_VB 0.07228f
Ct64eA49_4 t64_mA49 0 0.19922f
Xt64edA50 t64_XA t64_VB t64_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA50 0 0 t64_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA50_0 t64_mA50 0 0.00298f
Ct64eA50_1 t64_mA50 t64_XA 0.05981f
Ct64eA50_2 t64_mA50 vdd 0.00496f
Ct64eA50_3 t64_mA50 t64_VB 0.07228f
Ct64eA50_4 t64_mA50 0 0.19922f
Xt64edA51 t64_XA t64_VB t64_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA51 0 0 t64_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA51_0 t64_mA51 0 0.00298f
Ct64eA51_1 t64_mA51 t64_XA 0.05981f
Ct64eA51_2 t64_mA51 vdd 0.00496f
Ct64eA51_3 t64_mA51 t64_VB 0.07228f
Ct64eA51_4 t64_mA51 0 0.19922f
Xt64edA52 t64_XA t64_VB t64_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA52 0 0 t64_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA52_0 t64_mA52 0 0.00298f
Ct64eA52_1 t64_mA52 t64_XA 0.05981f
Ct64eA52_2 t64_mA52 vdd 0.00496f
Ct64eA52_3 t64_mA52 t64_VB 0.07228f
Ct64eA52_4 t64_mA52 0 0.19922f
Xt64edA53 t64_XA t64_VB t64_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA53 0 0 t64_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA53_0 t64_mA53 0 0.00298f
Ct64eA53_1 t64_mA53 t64_XA 0.05981f
Ct64eA53_2 t64_mA53 vdd 0.00496f
Ct64eA53_3 t64_mA53 t64_VB 0.07228f
Ct64eA53_4 t64_mA53 0 0.19922f
Xt64edA54 t64_XA t64_VB t64_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA54 0 0 t64_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA54_0 t64_mA54 0 0.00298f
Ct64eA54_1 t64_mA54 t64_XA 0.05981f
Ct64eA54_2 t64_mA54 vdd 0.00496f
Ct64eA54_3 t64_mA54 t64_VB 0.07228f
Ct64eA54_4 t64_mA54 0 0.19922f
Xt64edA55 t64_XA t64_VB t64_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA55 0 0 t64_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA55_0 t64_mA55 0 0.00298f
Ct64eA55_1 t64_mA55 t64_XA 0.05981f
Ct64eA55_2 t64_mA55 vdd 0.00496f
Ct64eA55_3 t64_mA55 t64_VB 0.07228f
Ct64eA55_4 t64_mA55 0 0.19922f
Xt64edA56 t64_XA t64_VB t64_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA56 0 0 t64_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA56_0 t64_mA56 0 0.00298f
Ct64eA56_1 t64_mA56 t64_XA 0.05981f
Ct64eA56_2 t64_mA56 vdd 0.00496f
Ct64eA56_3 t64_mA56 t64_VB 0.07228f
Ct64eA56_4 t64_mA56 0 0.19922f
Xt64edA57 t64_XA t64_VB t64_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA57 0 0 t64_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA57_0 t64_mA57 0 0.00298f
Ct64eA57_1 t64_mA57 t64_XA 0.05981f
Ct64eA57_2 t64_mA57 vdd 0.00496f
Ct64eA57_3 t64_mA57 t64_VB 0.07228f
Ct64eA57_4 t64_mA57 0 0.19922f
Xt64edA58 t64_XA t64_VB t64_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA58 0 0 t64_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA58_0 t64_mA58 0 0.00298f
Ct64eA58_1 t64_mA58 t64_XA 0.05981f
Ct64eA58_2 t64_mA58 vdd 0.00496f
Ct64eA58_3 t64_mA58 t64_VB 0.07228f
Ct64eA58_4 t64_mA58 0 0.19922f
Xt64edA59 t64_XA t64_VB t64_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA59 0 0 t64_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA59_0 t64_mA59 0 0.00298f
Ct64eA59_1 t64_mA59 t64_XA 0.05981f
Ct64eA59_2 t64_mA59 vdd 0.00496f
Ct64eA59_3 t64_mA59 t64_VB 0.07228f
Ct64eA59_4 t64_mA59 0 0.19922f
Xt64edA60 t64_XA t64_VB t64_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA60 0 0 t64_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA60_0 t64_mA60 0 0.00298f
Ct64eA60_1 t64_mA60 t64_XA 0.05981f
Ct64eA60_2 t64_mA60 vdd 0.00496f
Ct64eA60_3 t64_mA60 t64_VB 0.07228f
Ct64eA60_4 t64_mA60 0 0.19922f
Xt64edA61 t64_XA t64_VB t64_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA61 0 0 t64_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA61_0 t64_mA61 0 0.00298f
Ct64eA61_1 t64_mA61 t64_XA 0.05981f
Ct64eA61_2 t64_mA61 vdd 0.00496f
Ct64eA61_3 t64_mA61 t64_VB 0.07228f
Ct64eA61_4 t64_mA61 0 0.19922f
Xt64edA62 t64_XA t64_VB t64_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esA62 0 0 t64_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eA62_0 t64_mA62 0 0.00298f
Ct64eA62_1 t64_mA62 t64_XA 0.05981f
Ct64eA62_2 t64_mA62 vdd 0.00496f
Ct64eA62_3 t64_mA62 t64_VB 0.07228f
Ct64eA62_4 t64_mA62 0 0.19922f
Xt64edB0 t64_XB t64_VB t64_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB0 0 0 t64_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB0_0 t64_mB0 t64_XB 0.05778f
Ct64eB0_1 t64_mB0 vdd 0.00496f
Ct64eB0_2 t64_mB0 t64_VB 0.0654f
Ct64eB0_3 t64_mB0 0 0.00298f
Ct64eB0_4 t64_mB0 0 0.20468f
Xt64edB1 t64_XB t64_VB t64_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB1 0 0 t64_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB1_0 t64_mB1 t64_XB 0.05778f
Ct64eB1_1 t64_mB1 vdd 0.00496f
Ct64eB1_2 t64_mB1 t64_VB 0.0654f
Ct64eB1_3 t64_mB1 0 0.00298f
Ct64eB1_4 t64_mB1 0 0.20468f
Xt64edB2 t64_XB t64_VB t64_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB2 0 0 t64_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB2_0 t64_mB2 t64_XB 0.05778f
Ct64eB2_1 t64_mB2 vdd 0.00496f
Ct64eB2_2 t64_mB2 t64_VB 0.0654f
Ct64eB2_3 t64_mB2 0 0.00298f
Ct64eB2_4 t64_mB2 0 0.20468f
Xt64edB3 t64_XB t64_VB t64_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB3 0 0 t64_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB3_0 t64_mB3 t64_XB 0.05778f
Ct64eB3_1 t64_mB3 vdd 0.00496f
Ct64eB3_2 t64_mB3 t64_VB 0.0654f
Ct64eB3_3 t64_mB3 0 0.00298f
Ct64eB3_4 t64_mB3 0 0.20468f
Xt64edB4 t64_XB t64_VB t64_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB4 0 0 t64_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB4_0 t64_mB4 t64_XB 0.05778f
Ct64eB4_1 t64_mB4 vdd 0.00496f
Ct64eB4_2 t64_mB4 t64_VB 0.0654f
Ct64eB4_3 t64_mB4 0 0.00298f
Ct64eB4_4 t64_mB4 0 0.20468f
Xt64edB5 t64_XB t64_VB t64_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB5 0 0 t64_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB5_0 t64_mB5 t64_XB 0.05778f
Ct64eB5_1 t64_mB5 vdd 0.00496f
Ct64eB5_2 t64_mB5 t64_VB 0.0654f
Ct64eB5_3 t64_mB5 0 0.00298f
Ct64eB5_4 t64_mB5 0 0.20468f
Xt64edB6 t64_XB t64_VB t64_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB6 0 0 t64_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB6_0 t64_mB6 t64_XB 0.05778f
Ct64eB6_1 t64_mB6 vdd 0.00496f
Ct64eB6_2 t64_mB6 t64_VB 0.0654f
Ct64eB6_3 t64_mB6 0 0.00298f
Ct64eB6_4 t64_mB6 0 0.20468f
Xt64edB7 t64_XB t64_VB t64_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB7 0 0 t64_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB7_0 t64_mB7 t64_XB 0.05778f
Ct64eB7_1 t64_mB7 vdd 0.00496f
Ct64eB7_2 t64_mB7 t64_VB 0.0654f
Ct64eB7_3 t64_mB7 0 0.00298f
Ct64eB7_4 t64_mB7 0 0.20468f
Xt64edB8 t64_XB t64_VB t64_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB8 0 0 t64_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB8_0 t64_mB8 t64_XB 0.05778f
Ct64eB8_1 t64_mB8 vdd 0.00496f
Ct64eB8_2 t64_mB8 t64_VB 0.0654f
Ct64eB8_3 t64_mB8 0 0.00298f
Ct64eB8_4 t64_mB8 0 0.20468f
Xt64edB9 t64_XB t64_VB t64_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB9 0 0 t64_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB9_0 t64_mB9 t64_XB 0.05778f
Ct64eB9_1 t64_mB9 vdd 0.00496f
Ct64eB9_2 t64_mB9 t64_VB 0.0654f
Ct64eB9_3 t64_mB9 0 0.00298f
Ct64eB9_4 t64_mB9 0 0.20468f
Xt64edB10 t64_XB t64_VB t64_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB10 0 0 t64_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB10_0 t64_mB10 t64_XB 0.05778f
Ct64eB10_1 t64_mB10 vdd 0.00496f
Ct64eB10_2 t64_mB10 t64_VB 0.0654f
Ct64eB10_3 t64_mB10 0 0.00298f
Ct64eB10_4 t64_mB10 0 0.20468f
Xt64edB11 t64_XB t64_VB t64_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB11 0 0 t64_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB11_0 t64_mB11 t64_XB 0.05778f
Ct64eB11_1 t64_mB11 vdd 0.00496f
Ct64eB11_2 t64_mB11 t64_VB 0.0654f
Ct64eB11_3 t64_mB11 0 0.00298f
Ct64eB11_4 t64_mB11 0 0.20468f
Xt64edB12 t64_XB t64_VB t64_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB12 0 0 t64_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB12_0 t64_mB12 t64_XB 0.05778f
Ct64eB12_1 t64_mB12 vdd 0.00496f
Ct64eB12_2 t64_mB12 t64_VB 0.0654f
Ct64eB12_3 t64_mB12 0 0.00298f
Ct64eB12_4 t64_mB12 0 0.20468f
Xt64edB13 t64_XB t64_VB t64_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB13 0 0 t64_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB13_0 t64_mB13 t64_XB 0.05778f
Ct64eB13_1 t64_mB13 vdd 0.00496f
Ct64eB13_2 t64_mB13 t64_VB 0.0654f
Ct64eB13_3 t64_mB13 0 0.00298f
Ct64eB13_4 t64_mB13 0 0.20468f
Xt64edB14 t64_XB t64_VB t64_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB14 0 0 t64_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB14_0 t64_mB14 t64_XB 0.05778f
Ct64eB14_1 t64_mB14 vdd 0.00496f
Ct64eB14_2 t64_mB14 t64_VB 0.0654f
Ct64eB14_3 t64_mB14 0 0.00298f
Ct64eB14_4 t64_mB14 0 0.20468f
Xt64edB15 t64_XB t64_VB t64_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB15 0 0 t64_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB15_0 t64_mB15 t64_XB 0.05778f
Ct64eB15_1 t64_mB15 vdd 0.00496f
Ct64eB15_2 t64_mB15 t64_VB 0.0654f
Ct64eB15_3 t64_mB15 0 0.00298f
Ct64eB15_4 t64_mB15 0 0.20468f
Xt64edB16 t64_XB t64_VB t64_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB16 0 0 t64_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB16_0 t64_mB16 t64_XB 0.05778f
Ct64eB16_1 t64_mB16 vdd 0.00496f
Ct64eB16_2 t64_mB16 t64_VB 0.0654f
Ct64eB16_3 t64_mB16 0 0.00298f
Ct64eB16_4 t64_mB16 0 0.20468f
Xt64edB17 t64_XB t64_VB t64_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB17 0 0 t64_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB17_0 t64_mB17 t64_XB 0.05778f
Ct64eB17_1 t64_mB17 vdd 0.00496f
Ct64eB17_2 t64_mB17 t64_VB 0.0654f
Ct64eB17_3 t64_mB17 0 0.00298f
Ct64eB17_4 t64_mB17 0 0.20468f
Xt64edB18 t64_XB t64_VB t64_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB18 0 0 t64_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB18_0 t64_mB18 t64_XB 0.05778f
Ct64eB18_1 t64_mB18 vdd 0.00496f
Ct64eB18_2 t64_mB18 t64_VB 0.0654f
Ct64eB18_3 t64_mB18 0 0.00298f
Ct64eB18_4 t64_mB18 0 0.20468f
Xt64edB19 t64_XB t64_VB t64_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB19 0 0 t64_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB19_0 t64_mB19 t64_XB 0.05778f
Ct64eB19_1 t64_mB19 vdd 0.00496f
Ct64eB19_2 t64_mB19 t64_VB 0.0654f
Ct64eB19_3 t64_mB19 0 0.00298f
Ct64eB19_4 t64_mB19 0 0.20468f
Xt64edB20 t64_XB t64_VB t64_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB20 0 0 t64_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB20_0 t64_mB20 t64_XB 0.05778f
Ct64eB20_1 t64_mB20 vdd 0.00496f
Ct64eB20_2 t64_mB20 t64_VB 0.0654f
Ct64eB20_3 t64_mB20 0 0.00298f
Ct64eB20_4 t64_mB20 0 0.20468f
Xt64edB21 t64_XB t64_VB t64_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB21 0 0 t64_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB21_0 t64_mB21 t64_XB 0.05778f
Ct64eB21_1 t64_mB21 vdd 0.00496f
Ct64eB21_2 t64_mB21 t64_VB 0.0654f
Ct64eB21_3 t64_mB21 0 0.00298f
Ct64eB21_4 t64_mB21 0 0.20468f
Xt64edB22 t64_XB t64_VB t64_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB22 0 0 t64_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB22_0 t64_mB22 t64_XB 0.05778f
Ct64eB22_1 t64_mB22 vdd 0.00496f
Ct64eB22_2 t64_mB22 t64_VB 0.0654f
Ct64eB22_3 t64_mB22 0 0.00298f
Ct64eB22_4 t64_mB22 0 0.20468f
Xt64edB23 t64_XB t64_VB t64_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB23 0 0 t64_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB23_0 t64_mB23 t64_XB 0.05778f
Ct64eB23_1 t64_mB23 vdd 0.00496f
Ct64eB23_2 t64_mB23 t64_VB 0.0654f
Ct64eB23_3 t64_mB23 0 0.00298f
Ct64eB23_4 t64_mB23 0 0.20468f
Xt64edB24 t64_XB t64_VB t64_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB24 0 0 t64_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB24_0 t64_mB24 t64_XB 0.05778f
Ct64eB24_1 t64_mB24 vdd 0.00496f
Ct64eB24_2 t64_mB24 t64_VB 0.0654f
Ct64eB24_3 t64_mB24 0 0.00298f
Ct64eB24_4 t64_mB24 0 0.20468f
Xt64edB25 t64_XB t64_VB t64_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB25 0 0 t64_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB25_0 t64_mB25 t64_XB 0.05778f
Ct64eB25_1 t64_mB25 vdd 0.00496f
Ct64eB25_2 t64_mB25 t64_VB 0.0654f
Ct64eB25_3 t64_mB25 0 0.00298f
Ct64eB25_4 t64_mB25 0 0.20468f
Xt64edB26 t64_XB t64_VB t64_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB26 0 0 t64_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB26_0 t64_mB26 t64_XB 0.05778f
Ct64eB26_1 t64_mB26 vdd 0.00496f
Ct64eB26_2 t64_mB26 t64_VB 0.0654f
Ct64eB26_3 t64_mB26 0 0.00298f
Ct64eB26_4 t64_mB26 0 0.20468f
Xt64edB27 t64_XB t64_VB t64_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB27 0 0 t64_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB27_0 t64_mB27 t64_XB 0.05778f
Ct64eB27_1 t64_mB27 vdd 0.00496f
Ct64eB27_2 t64_mB27 t64_VB 0.0654f
Ct64eB27_3 t64_mB27 0 0.00298f
Ct64eB27_4 t64_mB27 0 0.20468f
Xt64edB28 t64_XB t64_VB t64_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB28 0 0 t64_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB28_0 t64_mB28 t64_XB 0.05778f
Ct64eB28_1 t64_mB28 vdd 0.00496f
Ct64eB28_2 t64_mB28 t64_VB 0.0654f
Ct64eB28_3 t64_mB28 0 0.00298f
Ct64eB28_4 t64_mB28 0 0.20468f
Xt64edB29 t64_XB t64_VB t64_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB29 0 0 t64_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB29_0 t64_mB29 t64_XB 0.05778f
Ct64eB29_1 t64_mB29 vdd 0.00496f
Ct64eB29_2 t64_mB29 t64_VB 0.0654f
Ct64eB29_3 t64_mB29 0 0.00298f
Ct64eB29_4 t64_mB29 0 0.20468f
Xt64edB30 t64_XB t64_VB t64_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB30 0 0 t64_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB30_0 t64_mB30 t64_XB 0.05778f
Ct64eB30_1 t64_mB30 vdd 0.00496f
Ct64eB30_2 t64_mB30 t64_VB 0.0654f
Ct64eB30_3 t64_mB30 0 0.00298f
Ct64eB30_4 t64_mB30 0 0.20468f
Xt64edB31 t64_XB t64_VB t64_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB31 0 0 t64_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB31_0 t64_mB31 t64_XB 0.05778f
Ct64eB31_1 t64_mB31 vdd 0.00496f
Ct64eB31_2 t64_mB31 t64_VB 0.0654f
Ct64eB31_3 t64_mB31 0 0.00298f
Ct64eB31_4 t64_mB31 0 0.20468f
Xt64edB32 t64_XB t64_VB t64_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB32 0 0 t64_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB32_0 t64_mB32 t64_XB 0.05778f
Ct64eB32_1 t64_mB32 vdd 0.00496f
Ct64eB32_2 t64_mB32 t64_VB 0.0654f
Ct64eB32_3 t64_mB32 0 0.00298f
Ct64eB32_4 t64_mB32 0 0.20468f
Xt64edB33 t64_XB t64_VB t64_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB33 0 0 t64_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB33_0 t64_mB33 t64_XB 0.05778f
Ct64eB33_1 t64_mB33 vdd 0.00496f
Ct64eB33_2 t64_mB33 t64_VB 0.0654f
Ct64eB33_3 t64_mB33 0 0.00298f
Ct64eB33_4 t64_mB33 0 0.20468f
Xt64edB34 t64_XB t64_VB t64_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB34 0 0 t64_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB34_0 t64_mB34 t64_XB 0.05778f
Ct64eB34_1 t64_mB34 vdd 0.00496f
Ct64eB34_2 t64_mB34 t64_VB 0.0654f
Ct64eB34_3 t64_mB34 0 0.00298f
Ct64eB34_4 t64_mB34 0 0.20468f
Xt64edB35 t64_XB t64_VB t64_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB35 0 0 t64_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB35_0 t64_mB35 t64_XB 0.05778f
Ct64eB35_1 t64_mB35 vdd 0.00496f
Ct64eB35_2 t64_mB35 t64_VB 0.0654f
Ct64eB35_3 t64_mB35 0 0.00298f
Ct64eB35_4 t64_mB35 0 0.20468f
Xt64edB36 t64_XB t64_VB t64_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB36 0 0 t64_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB36_0 t64_mB36 t64_XB 0.05778f
Ct64eB36_1 t64_mB36 vdd 0.00496f
Ct64eB36_2 t64_mB36 t64_VB 0.0654f
Ct64eB36_3 t64_mB36 0 0.00298f
Ct64eB36_4 t64_mB36 0 0.20468f
Xt64edB37 t64_XB t64_VB t64_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB37 0 0 t64_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB37_0 t64_mB37 t64_XB 0.05778f
Ct64eB37_1 t64_mB37 vdd 0.00496f
Ct64eB37_2 t64_mB37 t64_VB 0.0654f
Ct64eB37_3 t64_mB37 0 0.00298f
Ct64eB37_4 t64_mB37 0 0.20468f
Xt64edB38 t64_XB t64_VB t64_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB38 0 0 t64_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB38_0 t64_mB38 t64_XB 0.05778f
Ct64eB38_1 t64_mB38 vdd 0.00496f
Ct64eB38_2 t64_mB38 t64_VB 0.0654f
Ct64eB38_3 t64_mB38 0 0.00298f
Ct64eB38_4 t64_mB38 0 0.20468f
Xt64edB39 t64_XB t64_VB t64_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB39 0 0 t64_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB39_0 t64_mB39 t64_XB 0.05778f
Ct64eB39_1 t64_mB39 vdd 0.00496f
Ct64eB39_2 t64_mB39 t64_VB 0.0654f
Ct64eB39_3 t64_mB39 0 0.00298f
Ct64eB39_4 t64_mB39 0 0.20468f
Xt64edB40 t64_XB t64_VB t64_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB40 0 0 t64_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB40_0 t64_mB40 t64_XB 0.05778f
Ct64eB40_1 t64_mB40 vdd 0.00496f
Ct64eB40_2 t64_mB40 t64_VB 0.0654f
Ct64eB40_3 t64_mB40 0 0.00298f
Ct64eB40_4 t64_mB40 0 0.20468f
Xt64edB41 t64_XB t64_VB t64_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB41 0 0 t64_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB41_0 t64_mB41 t64_XB 0.05778f
Ct64eB41_1 t64_mB41 vdd 0.00496f
Ct64eB41_2 t64_mB41 t64_VB 0.0654f
Ct64eB41_3 t64_mB41 0 0.00298f
Ct64eB41_4 t64_mB41 0 0.20468f
Xt64edB42 t64_XB t64_VB t64_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB42 0 0 t64_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB42_0 t64_mB42 t64_XB 0.05778f
Ct64eB42_1 t64_mB42 vdd 0.00496f
Ct64eB42_2 t64_mB42 t64_VB 0.0654f
Ct64eB42_3 t64_mB42 0 0.00298f
Ct64eB42_4 t64_mB42 0 0.20468f
Xt64edB43 t64_XB t64_VB t64_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB43 0 0 t64_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB43_0 t64_mB43 t64_XB 0.05778f
Ct64eB43_1 t64_mB43 vdd 0.00496f
Ct64eB43_2 t64_mB43 t64_VB 0.0654f
Ct64eB43_3 t64_mB43 0 0.00298f
Ct64eB43_4 t64_mB43 0 0.20468f
Xt64edB44 t64_XB t64_VB t64_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB44 0 0 t64_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB44_0 t64_mB44 t64_XB 0.05778f
Ct64eB44_1 t64_mB44 vdd 0.00496f
Ct64eB44_2 t64_mB44 t64_VB 0.0654f
Ct64eB44_3 t64_mB44 0 0.00298f
Ct64eB44_4 t64_mB44 0 0.20468f
Xt64edB45 t64_XB t64_VB t64_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB45 0 0 t64_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB45_0 t64_mB45 t64_XB 0.05778f
Ct64eB45_1 t64_mB45 vdd 0.00496f
Ct64eB45_2 t64_mB45 t64_VB 0.0654f
Ct64eB45_3 t64_mB45 0 0.00298f
Ct64eB45_4 t64_mB45 0 0.20468f
Xt64edB46 t64_XB t64_VB t64_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB46 0 0 t64_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB46_0 t64_mB46 t64_XB 0.05778f
Ct64eB46_1 t64_mB46 vdd 0.00496f
Ct64eB46_2 t64_mB46 t64_VB 0.0654f
Ct64eB46_3 t64_mB46 0 0.00298f
Ct64eB46_4 t64_mB46 0 0.20468f
Xt64edB47 t64_XB t64_VB t64_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB47 0 0 t64_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB47_0 t64_mB47 t64_XB 0.05778f
Ct64eB47_1 t64_mB47 vdd 0.00496f
Ct64eB47_2 t64_mB47 t64_VB 0.0654f
Ct64eB47_3 t64_mB47 0 0.00298f
Ct64eB47_4 t64_mB47 0 0.20468f
Xt64edB48 t64_XB t64_VB t64_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB48 0 0 t64_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB48_0 t64_mB48 t64_XB 0.05778f
Ct64eB48_1 t64_mB48 vdd 0.00496f
Ct64eB48_2 t64_mB48 t64_VB 0.0654f
Ct64eB48_3 t64_mB48 0 0.00298f
Ct64eB48_4 t64_mB48 0 0.20468f
Xt64edB49 t64_XB t64_VB t64_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB49 0 0 t64_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB49_0 t64_mB49 t64_XB 0.05778f
Ct64eB49_1 t64_mB49 vdd 0.00496f
Ct64eB49_2 t64_mB49 t64_VB 0.0654f
Ct64eB49_3 t64_mB49 0 0.00298f
Ct64eB49_4 t64_mB49 0 0.20468f
Xt64edB50 t64_XB t64_VB t64_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB50 0 0 t64_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB50_0 t64_mB50 t64_XB 0.05778f
Ct64eB50_1 t64_mB50 vdd 0.00496f
Ct64eB50_2 t64_mB50 t64_VB 0.0654f
Ct64eB50_3 t64_mB50 0 0.00298f
Ct64eB50_4 t64_mB50 0 0.20468f
Xt64edB51 t64_XB t64_VB t64_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB51 0 0 t64_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB51_0 t64_mB51 t64_XB 0.05778f
Ct64eB51_1 t64_mB51 vdd 0.00496f
Ct64eB51_2 t64_mB51 t64_VB 0.0654f
Ct64eB51_3 t64_mB51 0 0.00298f
Ct64eB51_4 t64_mB51 0 0.20468f
Xt64edB52 t64_XB t64_VB t64_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB52 0 0 t64_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB52_0 t64_mB52 t64_XB 0.05778f
Ct64eB52_1 t64_mB52 vdd 0.00496f
Ct64eB52_2 t64_mB52 t64_VB 0.0654f
Ct64eB52_3 t64_mB52 0 0.00298f
Ct64eB52_4 t64_mB52 0 0.20468f
Xt64edB53 t64_XB t64_VB t64_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB53 0 0 t64_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB53_0 t64_mB53 t64_XB 0.05778f
Ct64eB53_1 t64_mB53 vdd 0.00496f
Ct64eB53_2 t64_mB53 t64_VB 0.0654f
Ct64eB53_3 t64_mB53 0 0.00298f
Ct64eB53_4 t64_mB53 0 0.20468f
Xt64edB54 t64_XB t64_VB t64_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB54 0 0 t64_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB54_0 t64_mB54 t64_XB 0.05778f
Ct64eB54_1 t64_mB54 vdd 0.00496f
Ct64eB54_2 t64_mB54 t64_VB 0.0654f
Ct64eB54_3 t64_mB54 0 0.00298f
Ct64eB54_4 t64_mB54 0 0.20468f
Xt64edB55 t64_XB t64_VB t64_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB55 0 0 t64_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB55_0 t64_mB55 t64_XB 0.05778f
Ct64eB55_1 t64_mB55 vdd 0.00496f
Ct64eB55_2 t64_mB55 t64_VB 0.0654f
Ct64eB55_3 t64_mB55 0 0.00298f
Ct64eB55_4 t64_mB55 0 0.20468f
Xt64edB56 t64_XB t64_VB t64_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB56 0 0 t64_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB56_0 t64_mB56 t64_XB 0.05778f
Ct64eB56_1 t64_mB56 vdd 0.00496f
Ct64eB56_2 t64_mB56 t64_VB 0.0654f
Ct64eB56_3 t64_mB56 0 0.00298f
Ct64eB56_4 t64_mB56 0 0.20468f
Xt64edB57 t64_XB t64_VB t64_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB57 0 0 t64_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB57_0 t64_mB57 t64_XB 0.05778f
Ct64eB57_1 t64_mB57 vdd 0.00496f
Ct64eB57_2 t64_mB57 t64_VB 0.0654f
Ct64eB57_3 t64_mB57 0 0.00298f
Ct64eB57_4 t64_mB57 0 0.20468f
Xt64edB58 t64_XB t64_VB t64_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB58 0 0 t64_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB58_0 t64_mB58 t64_XB 0.05778f
Ct64eB58_1 t64_mB58 vdd 0.00496f
Ct64eB58_2 t64_mB58 t64_VB 0.0654f
Ct64eB58_3 t64_mB58 0 0.00298f
Ct64eB58_4 t64_mB58 0 0.20468f
Xt64edB59 t64_XB t64_VB t64_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB59 0 0 t64_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB59_0 t64_mB59 t64_XB 0.05778f
Ct64eB59_1 t64_mB59 vdd 0.00496f
Ct64eB59_2 t64_mB59 t64_VB 0.0654f
Ct64eB59_3 t64_mB59 0 0.00298f
Ct64eB59_4 t64_mB59 0 0.20468f
Xt64edB60 t64_XB t64_VB t64_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB60 0 0 t64_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB60_0 t64_mB60 t64_XB 0.05778f
Ct64eB60_1 t64_mB60 vdd 0.00496f
Ct64eB60_2 t64_mB60 t64_VB 0.0654f
Ct64eB60_3 t64_mB60 0 0.00298f
Ct64eB60_4 t64_mB60 0 0.20468f
Xt64edB61 t64_XB t64_VB t64_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB61 0 0 t64_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB61_0 t64_mB61 t64_XB 0.05778f
Ct64eB61_1 t64_mB61 vdd 0.00496f
Ct64eB61_2 t64_mB61 t64_VB 0.0654f
Ct64eB61_3 t64_mB61 0 0.00298f
Ct64eB61_4 t64_mB61 0 0.20468f
Xt64edB62 t64_XB t64_VB t64_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt64esB62 0 0 t64_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct64eB62_0 t64_mB62 t64_XB 0.05778f
Ct64eB62_1 t64_mB62 vdd 0.00496f
Ct64eB62_2 t64_mB62 t64_VB 0.0654f
Ct64eB62_3 t64_mB62 0 0.00298f
Ct64eB62_4 t64_mB62 0 0.20468f

* --- t128: trap
Xt128_ienn hi 0 0 vdd vdd t128_enn sky130_fd_sc_hd__inv_1
Xt128_is1n 0 0 0 vdd vdd t128_s1n sky130_fd_sc_hd__inv_1
Xt128_is0n hi 0 0 vdd vdd t128_s0n sky130_fd_sc_hd__inv_1
Xt128_PREA pre t128_enn 0 0 vdd vdd t128_PREA sky130_fd_sc_hd__nor2_1
Xt128_PREB pre t128_enn 0 0 vdd vdd t128_PREB sky130_fd_sc_hd__nor2_1
Xt128_VBIAS hi 0 0 vdd vdd t128_VBIAS sky130_fd_sc_hd__buf_2
Xt128_C1 hi 0 0 vdd vdd t128_C1 sky130_fd_sc_hd__buf_2
Xt128_DUTA hi t128_s1n hi 0 0 vdd vdd t128_DUTA sky130_fd_sc_hd__and3_1
Xt128_DUTB hi t128_s1n hi 0 0 vdd vdd t128_DUTB sky130_fd_sc_hd__and3_1
Xt128_REFA hi 0 0 0 vdd vdd t128_REFA sky130_fd_sc_hd__and2_1
Xt128_REFB hi 0 0 0 vdd vdd t128_REFB sky130_fd_sc_hd__and2_1
Xt128_SA0B hi 0 hi 0 0 vdd vdd t128_SA0B sky130_fd_sc_hd__nand3_1
Xt128_SA1B hi 0 0 0 vdd vdd t128_SA1B sky130_fd_sc_hd__nand2_1
Xt128_SA2B hi 0 t128_s0n 0 0 vdd vdd t128_SA2B sky130_fd_sc_hd__nand3_1
Xt128_SB0B hi 0 0 0 vdd vdd t128_SB0B sky130_fd_sc_hd__nand2_1
Xt128_SB1B hi 0 0 0 vdd vdd t128_SB1B sky130_fd_sc_hd__nand2_1
Xt128_M t128_ob t128_SB0B t128_SB1B t128_REFB t128_oa t128_SA0B t128_SA1B t128_SA2B t128_REFA vdd 0 t128_VBIAS t128_C1 t128_PREA t128_XA t128_DUTA t128_PREB t128_XB t128_DUTB t128_VB 0 0 t128_GT trap
Bt128_gt t128_GT 0 V=v(t128_VB)+0.000305
Xt128edA0 t128_XA t128_VB t128_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA0 0 0 t128_mA0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA0_0 t128_mA0 0 0.00298f
Ct128eA0_1 t128_mA0 t128_XA 0.05981f
Ct128eA0_2 t128_mA0 vdd 0.00496f
Ct128eA0_3 t128_mA0 t128_VB 0.07228f
Ct128eA0_4 t128_mA0 0 0.19922f
Xt128edA1 t128_XA t128_VB t128_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA1 0 0 t128_mA1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA1_0 t128_mA1 0 0.00298f
Ct128eA1_1 t128_mA1 t128_XA 0.05981f
Ct128eA1_2 t128_mA1 vdd 0.00496f
Ct128eA1_3 t128_mA1 t128_VB 0.07228f
Ct128eA1_4 t128_mA1 0 0.19922f
Xt128edA2 t128_XA t128_VB t128_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA2 0 0 t128_mA2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA2_0 t128_mA2 0 0.00298f
Ct128eA2_1 t128_mA2 t128_XA 0.05981f
Ct128eA2_2 t128_mA2 vdd 0.00496f
Ct128eA2_3 t128_mA2 t128_VB 0.07228f
Ct128eA2_4 t128_mA2 0 0.19922f
Xt128edA3 t128_XA t128_VB t128_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA3 0 0 t128_mA3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA3_0 t128_mA3 0 0.00298f
Ct128eA3_1 t128_mA3 t128_XA 0.05981f
Ct128eA3_2 t128_mA3 vdd 0.00496f
Ct128eA3_3 t128_mA3 t128_VB 0.07228f
Ct128eA3_4 t128_mA3 0 0.19922f
Xt128edA4 t128_XA t128_VB t128_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA4 0 0 t128_mA4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA4_0 t128_mA4 0 0.00298f
Ct128eA4_1 t128_mA4 t128_XA 0.05981f
Ct128eA4_2 t128_mA4 vdd 0.00496f
Ct128eA4_3 t128_mA4 t128_VB 0.07228f
Ct128eA4_4 t128_mA4 0 0.19922f
Xt128edA5 t128_XA t128_VB t128_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA5 0 0 t128_mA5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA5_0 t128_mA5 0 0.00298f
Ct128eA5_1 t128_mA5 t128_XA 0.05981f
Ct128eA5_2 t128_mA5 vdd 0.00496f
Ct128eA5_3 t128_mA5 t128_VB 0.07228f
Ct128eA5_4 t128_mA5 0 0.19922f
Xt128edA6 t128_XA t128_VB t128_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA6 0 0 t128_mA6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA6_0 t128_mA6 0 0.00298f
Ct128eA6_1 t128_mA6 t128_XA 0.05981f
Ct128eA6_2 t128_mA6 vdd 0.00496f
Ct128eA6_3 t128_mA6 t128_VB 0.07228f
Ct128eA6_4 t128_mA6 0 0.19922f
Xt128edA7 t128_XA t128_VB t128_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA7 0 0 t128_mA7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA7_0 t128_mA7 0 0.00298f
Ct128eA7_1 t128_mA7 t128_XA 0.05981f
Ct128eA7_2 t128_mA7 vdd 0.00496f
Ct128eA7_3 t128_mA7 t128_VB 0.07228f
Ct128eA7_4 t128_mA7 0 0.19922f
Xt128edA8 t128_XA t128_VB t128_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA8 0 0 t128_mA8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA8_0 t128_mA8 0 0.00298f
Ct128eA8_1 t128_mA8 t128_XA 0.05981f
Ct128eA8_2 t128_mA8 vdd 0.00496f
Ct128eA8_3 t128_mA8 t128_VB 0.07228f
Ct128eA8_4 t128_mA8 0 0.19922f
Xt128edA9 t128_XA t128_VB t128_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA9 0 0 t128_mA9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA9_0 t128_mA9 0 0.00298f
Ct128eA9_1 t128_mA9 t128_XA 0.05981f
Ct128eA9_2 t128_mA9 vdd 0.00496f
Ct128eA9_3 t128_mA9 t128_VB 0.07228f
Ct128eA9_4 t128_mA9 0 0.19922f
Xt128edA10 t128_XA t128_VB t128_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA10 0 0 t128_mA10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA10_0 t128_mA10 0 0.00298f
Ct128eA10_1 t128_mA10 t128_XA 0.05981f
Ct128eA10_2 t128_mA10 vdd 0.00496f
Ct128eA10_3 t128_mA10 t128_VB 0.07228f
Ct128eA10_4 t128_mA10 0 0.19922f
Xt128edA11 t128_XA t128_VB t128_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA11 0 0 t128_mA11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA11_0 t128_mA11 0 0.00298f
Ct128eA11_1 t128_mA11 t128_XA 0.05981f
Ct128eA11_2 t128_mA11 vdd 0.00496f
Ct128eA11_3 t128_mA11 t128_VB 0.07228f
Ct128eA11_4 t128_mA11 0 0.19922f
Xt128edA12 t128_XA t128_VB t128_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA12 0 0 t128_mA12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA12_0 t128_mA12 0 0.00298f
Ct128eA12_1 t128_mA12 t128_XA 0.05981f
Ct128eA12_2 t128_mA12 vdd 0.00496f
Ct128eA12_3 t128_mA12 t128_VB 0.07228f
Ct128eA12_4 t128_mA12 0 0.19922f
Xt128edA13 t128_XA t128_VB t128_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA13 0 0 t128_mA13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA13_0 t128_mA13 0 0.00298f
Ct128eA13_1 t128_mA13 t128_XA 0.05981f
Ct128eA13_2 t128_mA13 vdd 0.00496f
Ct128eA13_3 t128_mA13 t128_VB 0.07228f
Ct128eA13_4 t128_mA13 0 0.19922f
Xt128edA14 t128_XA t128_VB t128_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA14 0 0 t128_mA14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA14_0 t128_mA14 0 0.00298f
Ct128eA14_1 t128_mA14 t128_XA 0.05981f
Ct128eA14_2 t128_mA14 vdd 0.00496f
Ct128eA14_3 t128_mA14 t128_VB 0.07228f
Ct128eA14_4 t128_mA14 0 0.19922f
Xt128edA15 t128_XA t128_VB t128_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA15 0 0 t128_mA15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA15_0 t128_mA15 0 0.00298f
Ct128eA15_1 t128_mA15 t128_XA 0.05981f
Ct128eA15_2 t128_mA15 vdd 0.00496f
Ct128eA15_3 t128_mA15 t128_VB 0.07228f
Ct128eA15_4 t128_mA15 0 0.19922f
Xt128edA16 t128_XA t128_VB t128_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA16 0 0 t128_mA16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA16_0 t128_mA16 0 0.00298f
Ct128eA16_1 t128_mA16 t128_XA 0.05981f
Ct128eA16_2 t128_mA16 vdd 0.00496f
Ct128eA16_3 t128_mA16 t128_VB 0.07228f
Ct128eA16_4 t128_mA16 0 0.19922f
Xt128edA17 t128_XA t128_VB t128_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA17 0 0 t128_mA17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA17_0 t128_mA17 0 0.00298f
Ct128eA17_1 t128_mA17 t128_XA 0.05981f
Ct128eA17_2 t128_mA17 vdd 0.00496f
Ct128eA17_3 t128_mA17 t128_VB 0.07228f
Ct128eA17_4 t128_mA17 0 0.19922f
Xt128edA18 t128_XA t128_VB t128_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA18 0 0 t128_mA18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA18_0 t128_mA18 0 0.00298f
Ct128eA18_1 t128_mA18 t128_XA 0.05981f
Ct128eA18_2 t128_mA18 vdd 0.00496f
Ct128eA18_3 t128_mA18 t128_VB 0.07228f
Ct128eA18_4 t128_mA18 0 0.19922f
Xt128edA19 t128_XA t128_VB t128_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA19 0 0 t128_mA19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA19_0 t128_mA19 0 0.00298f
Ct128eA19_1 t128_mA19 t128_XA 0.05981f
Ct128eA19_2 t128_mA19 vdd 0.00496f
Ct128eA19_3 t128_mA19 t128_VB 0.07228f
Ct128eA19_4 t128_mA19 0 0.19922f
Xt128edA20 t128_XA t128_VB t128_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA20 0 0 t128_mA20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA20_0 t128_mA20 0 0.00298f
Ct128eA20_1 t128_mA20 t128_XA 0.05981f
Ct128eA20_2 t128_mA20 vdd 0.00496f
Ct128eA20_3 t128_mA20 t128_VB 0.07228f
Ct128eA20_4 t128_mA20 0 0.19922f
Xt128edA21 t128_XA t128_VB t128_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA21 0 0 t128_mA21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA21_0 t128_mA21 0 0.00298f
Ct128eA21_1 t128_mA21 t128_XA 0.05981f
Ct128eA21_2 t128_mA21 vdd 0.00496f
Ct128eA21_3 t128_mA21 t128_VB 0.07228f
Ct128eA21_4 t128_mA21 0 0.19922f
Xt128edA22 t128_XA t128_VB t128_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA22 0 0 t128_mA22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA22_0 t128_mA22 0 0.00298f
Ct128eA22_1 t128_mA22 t128_XA 0.05981f
Ct128eA22_2 t128_mA22 vdd 0.00496f
Ct128eA22_3 t128_mA22 t128_VB 0.07228f
Ct128eA22_4 t128_mA22 0 0.19922f
Xt128edA23 t128_XA t128_VB t128_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA23 0 0 t128_mA23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA23_0 t128_mA23 0 0.00298f
Ct128eA23_1 t128_mA23 t128_XA 0.05981f
Ct128eA23_2 t128_mA23 vdd 0.00496f
Ct128eA23_3 t128_mA23 t128_VB 0.07228f
Ct128eA23_4 t128_mA23 0 0.19922f
Xt128edA24 t128_XA t128_VB t128_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA24 0 0 t128_mA24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA24_0 t128_mA24 0 0.00298f
Ct128eA24_1 t128_mA24 t128_XA 0.05981f
Ct128eA24_2 t128_mA24 vdd 0.00496f
Ct128eA24_3 t128_mA24 t128_VB 0.07228f
Ct128eA24_4 t128_mA24 0 0.19922f
Xt128edA25 t128_XA t128_VB t128_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA25 0 0 t128_mA25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA25_0 t128_mA25 0 0.00298f
Ct128eA25_1 t128_mA25 t128_XA 0.05981f
Ct128eA25_2 t128_mA25 vdd 0.00496f
Ct128eA25_3 t128_mA25 t128_VB 0.07228f
Ct128eA25_4 t128_mA25 0 0.19922f
Xt128edA26 t128_XA t128_VB t128_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA26 0 0 t128_mA26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA26_0 t128_mA26 0 0.00298f
Ct128eA26_1 t128_mA26 t128_XA 0.05981f
Ct128eA26_2 t128_mA26 vdd 0.00496f
Ct128eA26_3 t128_mA26 t128_VB 0.07228f
Ct128eA26_4 t128_mA26 0 0.19922f
Xt128edA27 t128_XA t128_VB t128_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA27 0 0 t128_mA27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA27_0 t128_mA27 0 0.00298f
Ct128eA27_1 t128_mA27 t128_XA 0.05981f
Ct128eA27_2 t128_mA27 vdd 0.00496f
Ct128eA27_3 t128_mA27 t128_VB 0.07228f
Ct128eA27_4 t128_mA27 0 0.19922f
Xt128edA28 t128_XA t128_VB t128_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA28 0 0 t128_mA28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA28_0 t128_mA28 0 0.00298f
Ct128eA28_1 t128_mA28 t128_XA 0.05981f
Ct128eA28_2 t128_mA28 vdd 0.00496f
Ct128eA28_3 t128_mA28 t128_VB 0.07228f
Ct128eA28_4 t128_mA28 0 0.19922f
Xt128edA29 t128_XA t128_VB t128_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA29 0 0 t128_mA29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA29_0 t128_mA29 0 0.00298f
Ct128eA29_1 t128_mA29 t128_XA 0.05981f
Ct128eA29_2 t128_mA29 vdd 0.00496f
Ct128eA29_3 t128_mA29 t128_VB 0.07228f
Ct128eA29_4 t128_mA29 0 0.19922f
Xt128edA30 t128_XA t128_VB t128_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA30 0 0 t128_mA30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA30_0 t128_mA30 0 0.00298f
Ct128eA30_1 t128_mA30 t128_XA 0.05981f
Ct128eA30_2 t128_mA30 vdd 0.00496f
Ct128eA30_3 t128_mA30 t128_VB 0.07228f
Ct128eA30_4 t128_mA30 0 0.19922f
Xt128edA31 t128_XA t128_VB t128_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA31 0 0 t128_mA31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA31_0 t128_mA31 0 0.00298f
Ct128eA31_1 t128_mA31 t128_XA 0.05981f
Ct128eA31_2 t128_mA31 vdd 0.00496f
Ct128eA31_3 t128_mA31 t128_VB 0.07228f
Ct128eA31_4 t128_mA31 0 0.19922f
Xt128edA32 t128_XA t128_VB t128_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA32 0 0 t128_mA32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA32_0 t128_mA32 0 0.00298f
Ct128eA32_1 t128_mA32 t128_XA 0.05981f
Ct128eA32_2 t128_mA32 vdd 0.00496f
Ct128eA32_3 t128_mA32 t128_VB 0.07228f
Ct128eA32_4 t128_mA32 0 0.19922f
Xt128edA33 t128_XA t128_VB t128_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA33 0 0 t128_mA33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA33_0 t128_mA33 0 0.00298f
Ct128eA33_1 t128_mA33 t128_XA 0.05981f
Ct128eA33_2 t128_mA33 vdd 0.00496f
Ct128eA33_3 t128_mA33 t128_VB 0.07228f
Ct128eA33_4 t128_mA33 0 0.19922f
Xt128edA34 t128_XA t128_VB t128_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA34 0 0 t128_mA34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA34_0 t128_mA34 0 0.00298f
Ct128eA34_1 t128_mA34 t128_XA 0.05981f
Ct128eA34_2 t128_mA34 vdd 0.00496f
Ct128eA34_3 t128_mA34 t128_VB 0.07228f
Ct128eA34_4 t128_mA34 0 0.19922f
Xt128edA35 t128_XA t128_VB t128_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA35 0 0 t128_mA35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA35_0 t128_mA35 0 0.00298f
Ct128eA35_1 t128_mA35 t128_XA 0.05981f
Ct128eA35_2 t128_mA35 vdd 0.00496f
Ct128eA35_3 t128_mA35 t128_VB 0.07228f
Ct128eA35_4 t128_mA35 0 0.19922f
Xt128edA36 t128_XA t128_VB t128_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA36 0 0 t128_mA36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA36_0 t128_mA36 0 0.00298f
Ct128eA36_1 t128_mA36 t128_XA 0.05981f
Ct128eA36_2 t128_mA36 vdd 0.00496f
Ct128eA36_3 t128_mA36 t128_VB 0.07228f
Ct128eA36_4 t128_mA36 0 0.19922f
Xt128edA37 t128_XA t128_VB t128_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA37 0 0 t128_mA37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA37_0 t128_mA37 0 0.00298f
Ct128eA37_1 t128_mA37 t128_XA 0.05981f
Ct128eA37_2 t128_mA37 vdd 0.00496f
Ct128eA37_3 t128_mA37 t128_VB 0.07228f
Ct128eA37_4 t128_mA37 0 0.19922f
Xt128edA38 t128_XA t128_VB t128_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA38 0 0 t128_mA38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA38_0 t128_mA38 0 0.00298f
Ct128eA38_1 t128_mA38 t128_XA 0.05981f
Ct128eA38_2 t128_mA38 vdd 0.00496f
Ct128eA38_3 t128_mA38 t128_VB 0.07228f
Ct128eA38_4 t128_mA38 0 0.19922f
Xt128edA39 t128_XA t128_VB t128_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA39 0 0 t128_mA39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA39_0 t128_mA39 0 0.00298f
Ct128eA39_1 t128_mA39 t128_XA 0.05981f
Ct128eA39_2 t128_mA39 vdd 0.00496f
Ct128eA39_3 t128_mA39 t128_VB 0.07228f
Ct128eA39_4 t128_mA39 0 0.19922f
Xt128edA40 t128_XA t128_VB t128_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA40 0 0 t128_mA40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA40_0 t128_mA40 0 0.00298f
Ct128eA40_1 t128_mA40 t128_XA 0.05981f
Ct128eA40_2 t128_mA40 vdd 0.00496f
Ct128eA40_3 t128_mA40 t128_VB 0.07228f
Ct128eA40_4 t128_mA40 0 0.19922f
Xt128edA41 t128_XA t128_VB t128_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA41 0 0 t128_mA41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA41_0 t128_mA41 0 0.00298f
Ct128eA41_1 t128_mA41 t128_XA 0.05981f
Ct128eA41_2 t128_mA41 vdd 0.00496f
Ct128eA41_3 t128_mA41 t128_VB 0.07228f
Ct128eA41_4 t128_mA41 0 0.19922f
Xt128edA42 t128_XA t128_VB t128_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA42 0 0 t128_mA42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA42_0 t128_mA42 0 0.00298f
Ct128eA42_1 t128_mA42 t128_XA 0.05981f
Ct128eA42_2 t128_mA42 vdd 0.00496f
Ct128eA42_3 t128_mA42 t128_VB 0.07228f
Ct128eA42_4 t128_mA42 0 0.19922f
Xt128edA43 t128_XA t128_VB t128_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA43 0 0 t128_mA43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA43_0 t128_mA43 0 0.00298f
Ct128eA43_1 t128_mA43 t128_XA 0.05981f
Ct128eA43_2 t128_mA43 vdd 0.00496f
Ct128eA43_3 t128_mA43 t128_VB 0.07228f
Ct128eA43_4 t128_mA43 0 0.19922f
Xt128edA44 t128_XA t128_VB t128_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA44 0 0 t128_mA44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA44_0 t128_mA44 0 0.00298f
Ct128eA44_1 t128_mA44 t128_XA 0.05981f
Ct128eA44_2 t128_mA44 vdd 0.00496f
Ct128eA44_3 t128_mA44 t128_VB 0.07228f
Ct128eA44_4 t128_mA44 0 0.19922f
Xt128edA45 t128_XA t128_VB t128_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA45 0 0 t128_mA45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA45_0 t128_mA45 0 0.00298f
Ct128eA45_1 t128_mA45 t128_XA 0.05981f
Ct128eA45_2 t128_mA45 vdd 0.00496f
Ct128eA45_3 t128_mA45 t128_VB 0.07228f
Ct128eA45_4 t128_mA45 0 0.19922f
Xt128edA46 t128_XA t128_VB t128_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA46 0 0 t128_mA46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA46_0 t128_mA46 0 0.00298f
Ct128eA46_1 t128_mA46 t128_XA 0.05981f
Ct128eA46_2 t128_mA46 vdd 0.00496f
Ct128eA46_3 t128_mA46 t128_VB 0.07228f
Ct128eA46_4 t128_mA46 0 0.19922f
Xt128edA47 t128_XA t128_VB t128_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA47 0 0 t128_mA47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA47_0 t128_mA47 0 0.00298f
Ct128eA47_1 t128_mA47 t128_XA 0.05981f
Ct128eA47_2 t128_mA47 vdd 0.00496f
Ct128eA47_3 t128_mA47 t128_VB 0.07228f
Ct128eA47_4 t128_mA47 0 0.19922f
Xt128edA48 t128_XA t128_VB t128_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA48 0 0 t128_mA48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA48_0 t128_mA48 0 0.00298f
Ct128eA48_1 t128_mA48 t128_XA 0.05981f
Ct128eA48_2 t128_mA48 vdd 0.00496f
Ct128eA48_3 t128_mA48 t128_VB 0.07228f
Ct128eA48_4 t128_mA48 0 0.19922f
Xt128edA49 t128_XA t128_VB t128_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA49 0 0 t128_mA49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA49_0 t128_mA49 0 0.00298f
Ct128eA49_1 t128_mA49 t128_XA 0.05981f
Ct128eA49_2 t128_mA49 vdd 0.00496f
Ct128eA49_3 t128_mA49 t128_VB 0.07228f
Ct128eA49_4 t128_mA49 0 0.19922f
Xt128edA50 t128_XA t128_VB t128_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA50 0 0 t128_mA50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA50_0 t128_mA50 0 0.00298f
Ct128eA50_1 t128_mA50 t128_XA 0.05981f
Ct128eA50_2 t128_mA50 vdd 0.00496f
Ct128eA50_3 t128_mA50 t128_VB 0.07228f
Ct128eA50_4 t128_mA50 0 0.19922f
Xt128edA51 t128_XA t128_VB t128_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA51 0 0 t128_mA51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA51_0 t128_mA51 0 0.00298f
Ct128eA51_1 t128_mA51 t128_XA 0.05981f
Ct128eA51_2 t128_mA51 vdd 0.00496f
Ct128eA51_3 t128_mA51 t128_VB 0.07228f
Ct128eA51_4 t128_mA51 0 0.19922f
Xt128edA52 t128_XA t128_VB t128_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA52 0 0 t128_mA52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA52_0 t128_mA52 0 0.00298f
Ct128eA52_1 t128_mA52 t128_XA 0.05981f
Ct128eA52_2 t128_mA52 vdd 0.00496f
Ct128eA52_3 t128_mA52 t128_VB 0.07228f
Ct128eA52_4 t128_mA52 0 0.19922f
Xt128edA53 t128_XA t128_VB t128_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA53 0 0 t128_mA53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA53_0 t128_mA53 0 0.00298f
Ct128eA53_1 t128_mA53 t128_XA 0.05981f
Ct128eA53_2 t128_mA53 vdd 0.00496f
Ct128eA53_3 t128_mA53 t128_VB 0.07228f
Ct128eA53_4 t128_mA53 0 0.19922f
Xt128edA54 t128_XA t128_VB t128_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA54 0 0 t128_mA54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA54_0 t128_mA54 0 0.00298f
Ct128eA54_1 t128_mA54 t128_XA 0.05981f
Ct128eA54_2 t128_mA54 vdd 0.00496f
Ct128eA54_3 t128_mA54 t128_VB 0.07228f
Ct128eA54_4 t128_mA54 0 0.19922f
Xt128edA55 t128_XA t128_VB t128_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA55 0 0 t128_mA55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA55_0 t128_mA55 0 0.00298f
Ct128eA55_1 t128_mA55 t128_XA 0.05981f
Ct128eA55_2 t128_mA55 vdd 0.00496f
Ct128eA55_3 t128_mA55 t128_VB 0.07228f
Ct128eA55_4 t128_mA55 0 0.19922f
Xt128edA56 t128_XA t128_VB t128_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA56 0 0 t128_mA56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA56_0 t128_mA56 0 0.00298f
Ct128eA56_1 t128_mA56 t128_XA 0.05981f
Ct128eA56_2 t128_mA56 vdd 0.00496f
Ct128eA56_3 t128_mA56 t128_VB 0.07228f
Ct128eA56_4 t128_mA56 0 0.19922f
Xt128edA57 t128_XA t128_VB t128_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA57 0 0 t128_mA57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA57_0 t128_mA57 0 0.00298f
Ct128eA57_1 t128_mA57 t128_XA 0.05981f
Ct128eA57_2 t128_mA57 vdd 0.00496f
Ct128eA57_3 t128_mA57 t128_VB 0.07228f
Ct128eA57_4 t128_mA57 0 0.19922f
Xt128edA58 t128_XA t128_VB t128_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA58 0 0 t128_mA58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA58_0 t128_mA58 0 0.00298f
Ct128eA58_1 t128_mA58 t128_XA 0.05981f
Ct128eA58_2 t128_mA58 vdd 0.00496f
Ct128eA58_3 t128_mA58 t128_VB 0.07228f
Ct128eA58_4 t128_mA58 0 0.19922f
Xt128edA59 t128_XA t128_VB t128_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA59 0 0 t128_mA59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA59_0 t128_mA59 0 0.00298f
Ct128eA59_1 t128_mA59 t128_XA 0.05981f
Ct128eA59_2 t128_mA59 vdd 0.00496f
Ct128eA59_3 t128_mA59 t128_VB 0.07228f
Ct128eA59_4 t128_mA59 0 0.19922f
Xt128edA60 t128_XA t128_VB t128_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA60 0 0 t128_mA60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA60_0 t128_mA60 0 0.00298f
Ct128eA60_1 t128_mA60 t128_XA 0.05981f
Ct128eA60_2 t128_mA60 vdd 0.00496f
Ct128eA60_3 t128_mA60 t128_VB 0.07228f
Ct128eA60_4 t128_mA60 0 0.19922f
Xt128edA61 t128_XA t128_VB t128_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA61 0 0 t128_mA61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA61_0 t128_mA61 0 0.00298f
Ct128eA61_1 t128_mA61 t128_XA 0.05981f
Ct128eA61_2 t128_mA61 vdd 0.00496f
Ct128eA61_3 t128_mA61 t128_VB 0.07228f
Ct128eA61_4 t128_mA61 0 0.19922f
Xt128edA62 t128_XA t128_VB t128_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA62 0 0 t128_mA62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA62_0 t128_mA62 0 0.00298f
Ct128eA62_1 t128_mA62 t128_XA 0.05981f
Ct128eA62_2 t128_mA62 vdd 0.00496f
Ct128eA62_3 t128_mA62 t128_VB 0.07228f
Ct128eA62_4 t128_mA62 0 0.19922f
Xt128edA63 t128_XA t128_VB t128_mA63 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA63 0 0 t128_mA63 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA63_0 t128_mA63 0 0.00298f
Ct128eA63_1 t128_mA63 t128_XA 0.05981f
Ct128eA63_2 t128_mA63 vdd 0.00496f
Ct128eA63_3 t128_mA63 t128_VB 0.07228f
Ct128eA63_4 t128_mA63 0 0.19922f
Xt128edA64 t128_XA t128_VB t128_mA64 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA64 0 0 t128_mA64 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA64_0 t128_mA64 0 0.00298f
Ct128eA64_1 t128_mA64 t128_XA 0.05981f
Ct128eA64_2 t128_mA64 vdd 0.00496f
Ct128eA64_3 t128_mA64 t128_VB 0.07228f
Ct128eA64_4 t128_mA64 0 0.19922f
Xt128edA65 t128_XA t128_VB t128_mA65 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA65 0 0 t128_mA65 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA65_0 t128_mA65 0 0.00298f
Ct128eA65_1 t128_mA65 t128_XA 0.05981f
Ct128eA65_2 t128_mA65 vdd 0.00496f
Ct128eA65_3 t128_mA65 t128_VB 0.07228f
Ct128eA65_4 t128_mA65 0 0.19922f
Xt128edA66 t128_XA t128_VB t128_mA66 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA66 0 0 t128_mA66 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA66_0 t128_mA66 0 0.00298f
Ct128eA66_1 t128_mA66 t128_XA 0.05981f
Ct128eA66_2 t128_mA66 vdd 0.00496f
Ct128eA66_3 t128_mA66 t128_VB 0.07228f
Ct128eA66_4 t128_mA66 0 0.19922f
Xt128edA67 t128_XA t128_VB t128_mA67 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA67 0 0 t128_mA67 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA67_0 t128_mA67 0 0.00298f
Ct128eA67_1 t128_mA67 t128_XA 0.05981f
Ct128eA67_2 t128_mA67 vdd 0.00496f
Ct128eA67_3 t128_mA67 t128_VB 0.07228f
Ct128eA67_4 t128_mA67 0 0.19922f
Xt128edA68 t128_XA t128_VB t128_mA68 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA68 0 0 t128_mA68 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA68_0 t128_mA68 0 0.00298f
Ct128eA68_1 t128_mA68 t128_XA 0.05981f
Ct128eA68_2 t128_mA68 vdd 0.00496f
Ct128eA68_3 t128_mA68 t128_VB 0.07228f
Ct128eA68_4 t128_mA68 0 0.19922f
Xt128edA69 t128_XA t128_VB t128_mA69 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA69 0 0 t128_mA69 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA69_0 t128_mA69 0 0.00298f
Ct128eA69_1 t128_mA69 t128_XA 0.05981f
Ct128eA69_2 t128_mA69 vdd 0.00496f
Ct128eA69_3 t128_mA69 t128_VB 0.07228f
Ct128eA69_4 t128_mA69 0 0.19922f
Xt128edA70 t128_XA t128_VB t128_mA70 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA70 0 0 t128_mA70 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA70_0 t128_mA70 0 0.00298f
Ct128eA70_1 t128_mA70 t128_XA 0.05981f
Ct128eA70_2 t128_mA70 vdd 0.00496f
Ct128eA70_3 t128_mA70 t128_VB 0.07228f
Ct128eA70_4 t128_mA70 0 0.19922f
Xt128edA71 t128_XA t128_VB t128_mA71 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA71 0 0 t128_mA71 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA71_0 t128_mA71 0 0.00298f
Ct128eA71_1 t128_mA71 t128_XA 0.05981f
Ct128eA71_2 t128_mA71 vdd 0.00496f
Ct128eA71_3 t128_mA71 t128_VB 0.07228f
Ct128eA71_4 t128_mA71 0 0.19922f
Xt128edA72 t128_XA t128_VB t128_mA72 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA72 0 0 t128_mA72 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA72_0 t128_mA72 0 0.00298f
Ct128eA72_1 t128_mA72 t128_XA 0.05981f
Ct128eA72_2 t128_mA72 vdd 0.00496f
Ct128eA72_3 t128_mA72 t128_VB 0.07228f
Ct128eA72_4 t128_mA72 0 0.19922f
Xt128edA73 t128_XA t128_VB t128_mA73 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA73 0 0 t128_mA73 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA73_0 t128_mA73 0 0.00298f
Ct128eA73_1 t128_mA73 t128_XA 0.05981f
Ct128eA73_2 t128_mA73 vdd 0.00496f
Ct128eA73_3 t128_mA73 t128_VB 0.07228f
Ct128eA73_4 t128_mA73 0 0.19922f
Xt128edA74 t128_XA t128_VB t128_mA74 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA74 0 0 t128_mA74 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA74_0 t128_mA74 0 0.00298f
Ct128eA74_1 t128_mA74 t128_XA 0.05981f
Ct128eA74_2 t128_mA74 vdd 0.00496f
Ct128eA74_3 t128_mA74 t128_VB 0.07228f
Ct128eA74_4 t128_mA74 0 0.19922f
Xt128edA75 t128_XA t128_VB t128_mA75 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA75 0 0 t128_mA75 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA75_0 t128_mA75 0 0.00298f
Ct128eA75_1 t128_mA75 t128_XA 0.05981f
Ct128eA75_2 t128_mA75 vdd 0.00496f
Ct128eA75_3 t128_mA75 t128_VB 0.07228f
Ct128eA75_4 t128_mA75 0 0.19922f
Xt128edA76 t128_XA t128_VB t128_mA76 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA76 0 0 t128_mA76 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA76_0 t128_mA76 0 0.00298f
Ct128eA76_1 t128_mA76 t128_XA 0.05981f
Ct128eA76_2 t128_mA76 vdd 0.00496f
Ct128eA76_3 t128_mA76 t128_VB 0.07228f
Ct128eA76_4 t128_mA76 0 0.19922f
Xt128edA77 t128_XA t128_VB t128_mA77 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA77 0 0 t128_mA77 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA77_0 t128_mA77 0 0.00298f
Ct128eA77_1 t128_mA77 t128_XA 0.05981f
Ct128eA77_2 t128_mA77 vdd 0.00496f
Ct128eA77_3 t128_mA77 t128_VB 0.07228f
Ct128eA77_4 t128_mA77 0 0.19922f
Xt128edA78 t128_XA t128_VB t128_mA78 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA78 0 0 t128_mA78 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA78_0 t128_mA78 0 0.00298f
Ct128eA78_1 t128_mA78 t128_XA 0.05981f
Ct128eA78_2 t128_mA78 vdd 0.00496f
Ct128eA78_3 t128_mA78 t128_VB 0.07228f
Ct128eA78_4 t128_mA78 0 0.19922f
Xt128edA79 t128_XA t128_VB t128_mA79 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA79 0 0 t128_mA79 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA79_0 t128_mA79 0 0.00298f
Ct128eA79_1 t128_mA79 t128_XA 0.05981f
Ct128eA79_2 t128_mA79 vdd 0.00496f
Ct128eA79_3 t128_mA79 t128_VB 0.07228f
Ct128eA79_4 t128_mA79 0 0.19922f
Xt128edA80 t128_XA t128_VB t128_mA80 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA80 0 0 t128_mA80 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA80_0 t128_mA80 0 0.00298f
Ct128eA80_1 t128_mA80 t128_XA 0.05981f
Ct128eA80_2 t128_mA80 vdd 0.00496f
Ct128eA80_3 t128_mA80 t128_VB 0.07228f
Ct128eA80_4 t128_mA80 0 0.19922f
Xt128edA81 t128_XA t128_VB t128_mA81 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA81 0 0 t128_mA81 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA81_0 t128_mA81 0 0.00298f
Ct128eA81_1 t128_mA81 t128_XA 0.05981f
Ct128eA81_2 t128_mA81 vdd 0.00496f
Ct128eA81_3 t128_mA81 t128_VB 0.07228f
Ct128eA81_4 t128_mA81 0 0.19922f
Xt128edA82 t128_XA t128_VB t128_mA82 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA82 0 0 t128_mA82 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA82_0 t128_mA82 0 0.00298f
Ct128eA82_1 t128_mA82 t128_XA 0.05981f
Ct128eA82_2 t128_mA82 vdd 0.00496f
Ct128eA82_3 t128_mA82 t128_VB 0.07228f
Ct128eA82_4 t128_mA82 0 0.19922f
Xt128edA83 t128_XA t128_VB t128_mA83 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA83 0 0 t128_mA83 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA83_0 t128_mA83 0 0.00298f
Ct128eA83_1 t128_mA83 t128_XA 0.05981f
Ct128eA83_2 t128_mA83 vdd 0.00496f
Ct128eA83_3 t128_mA83 t128_VB 0.07228f
Ct128eA83_4 t128_mA83 0 0.19922f
Xt128edA84 t128_XA t128_VB t128_mA84 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA84 0 0 t128_mA84 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA84_0 t128_mA84 0 0.00298f
Ct128eA84_1 t128_mA84 t128_XA 0.05981f
Ct128eA84_2 t128_mA84 vdd 0.00496f
Ct128eA84_3 t128_mA84 t128_VB 0.07228f
Ct128eA84_4 t128_mA84 0 0.19922f
Xt128edA85 t128_XA t128_VB t128_mA85 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA85 0 0 t128_mA85 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA85_0 t128_mA85 0 0.00298f
Ct128eA85_1 t128_mA85 t128_XA 0.05981f
Ct128eA85_2 t128_mA85 vdd 0.00496f
Ct128eA85_3 t128_mA85 t128_VB 0.07228f
Ct128eA85_4 t128_mA85 0 0.19922f
Xt128edA86 t128_XA t128_VB t128_mA86 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA86 0 0 t128_mA86 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA86_0 t128_mA86 0 0.00298f
Ct128eA86_1 t128_mA86 t128_XA 0.05981f
Ct128eA86_2 t128_mA86 vdd 0.00496f
Ct128eA86_3 t128_mA86 t128_VB 0.07228f
Ct128eA86_4 t128_mA86 0 0.19922f
Xt128edA87 t128_XA t128_VB t128_mA87 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA87 0 0 t128_mA87 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA87_0 t128_mA87 0 0.00298f
Ct128eA87_1 t128_mA87 t128_XA 0.05981f
Ct128eA87_2 t128_mA87 vdd 0.00496f
Ct128eA87_3 t128_mA87 t128_VB 0.07228f
Ct128eA87_4 t128_mA87 0 0.19922f
Xt128edA88 t128_XA t128_VB t128_mA88 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA88 0 0 t128_mA88 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA88_0 t128_mA88 0 0.00298f
Ct128eA88_1 t128_mA88 t128_XA 0.05981f
Ct128eA88_2 t128_mA88 vdd 0.00496f
Ct128eA88_3 t128_mA88 t128_VB 0.07228f
Ct128eA88_4 t128_mA88 0 0.19922f
Xt128edA89 t128_XA t128_VB t128_mA89 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA89 0 0 t128_mA89 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA89_0 t128_mA89 0 0.00298f
Ct128eA89_1 t128_mA89 t128_XA 0.05981f
Ct128eA89_2 t128_mA89 vdd 0.00496f
Ct128eA89_3 t128_mA89 t128_VB 0.07228f
Ct128eA89_4 t128_mA89 0 0.19922f
Xt128edA90 t128_XA t128_VB t128_mA90 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA90 0 0 t128_mA90 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA90_0 t128_mA90 0 0.00298f
Ct128eA90_1 t128_mA90 t128_XA 0.05981f
Ct128eA90_2 t128_mA90 vdd 0.00496f
Ct128eA90_3 t128_mA90 t128_VB 0.07228f
Ct128eA90_4 t128_mA90 0 0.19922f
Xt128edA91 t128_XA t128_VB t128_mA91 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA91 0 0 t128_mA91 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA91_0 t128_mA91 0 0.00298f
Ct128eA91_1 t128_mA91 t128_XA 0.05981f
Ct128eA91_2 t128_mA91 vdd 0.00496f
Ct128eA91_3 t128_mA91 t128_VB 0.07228f
Ct128eA91_4 t128_mA91 0 0.19922f
Xt128edA92 t128_XA t128_VB t128_mA92 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA92 0 0 t128_mA92 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA92_0 t128_mA92 0 0.00298f
Ct128eA92_1 t128_mA92 t128_XA 0.05981f
Ct128eA92_2 t128_mA92 vdd 0.00496f
Ct128eA92_3 t128_mA92 t128_VB 0.07228f
Ct128eA92_4 t128_mA92 0 0.19922f
Xt128edA93 t128_XA t128_VB t128_mA93 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA93 0 0 t128_mA93 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA93_0 t128_mA93 0 0.00298f
Ct128eA93_1 t128_mA93 t128_XA 0.05981f
Ct128eA93_2 t128_mA93 vdd 0.00496f
Ct128eA93_3 t128_mA93 t128_VB 0.07228f
Ct128eA93_4 t128_mA93 0 0.19922f
Xt128edA94 t128_XA t128_VB t128_mA94 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA94 0 0 t128_mA94 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA94_0 t128_mA94 0 0.00298f
Ct128eA94_1 t128_mA94 t128_XA 0.05981f
Ct128eA94_2 t128_mA94 vdd 0.00496f
Ct128eA94_3 t128_mA94 t128_VB 0.07228f
Ct128eA94_4 t128_mA94 0 0.19922f
Xt128edA95 t128_XA t128_VB t128_mA95 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA95 0 0 t128_mA95 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA95_0 t128_mA95 0 0.00298f
Ct128eA95_1 t128_mA95 t128_XA 0.05981f
Ct128eA95_2 t128_mA95 vdd 0.00496f
Ct128eA95_3 t128_mA95 t128_VB 0.07228f
Ct128eA95_4 t128_mA95 0 0.19922f
Xt128edA96 t128_XA t128_VB t128_mA96 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA96 0 0 t128_mA96 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA96_0 t128_mA96 0 0.00298f
Ct128eA96_1 t128_mA96 t128_XA 0.05981f
Ct128eA96_2 t128_mA96 vdd 0.00496f
Ct128eA96_3 t128_mA96 t128_VB 0.07228f
Ct128eA96_4 t128_mA96 0 0.19922f
Xt128edA97 t128_XA t128_VB t128_mA97 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA97 0 0 t128_mA97 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA97_0 t128_mA97 0 0.00298f
Ct128eA97_1 t128_mA97 t128_XA 0.05981f
Ct128eA97_2 t128_mA97 vdd 0.00496f
Ct128eA97_3 t128_mA97 t128_VB 0.07228f
Ct128eA97_4 t128_mA97 0 0.19922f
Xt128edA98 t128_XA t128_VB t128_mA98 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA98 0 0 t128_mA98 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA98_0 t128_mA98 0 0.00298f
Ct128eA98_1 t128_mA98 t128_XA 0.05981f
Ct128eA98_2 t128_mA98 vdd 0.00496f
Ct128eA98_3 t128_mA98 t128_VB 0.07228f
Ct128eA98_4 t128_mA98 0 0.19922f
Xt128edA99 t128_XA t128_VB t128_mA99 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA99 0 0 t128_mA99 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA99_0 t128_mA99 0 0.00298f
Ct128eA99_1 t128_mA99 t128_XA 0.05981f
Ct128eA99_2 t128_mA99 vdd 0.00496f
Ct128eA99_3 t128_mA99 t128_VB 0.07228f
Ct128eA99_4 t128_mA99 0 0.19922f
Xt128edA100 t128_XA t128_VB t128_mA100 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA100 0 0 t128_mA100 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA100_0 t128_mA100 0 0.00298f
Ct128eA100_1 t128_mA100 t128_XA 0.05981f
Ct128eA100_2 t128_mA100 vdd 0.00496f
Ct128eA100_3 t128_mA100 t128_VB 0.07228f
Ct128eA100_4 t128_mA100 0 0.19922f
Xt128edA101 t128_XA t128_VB t128_mA101 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA101 0 0 t128_mA101 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA101_0 t128_mA101 0 0.00298f
Ct128eA101_1 t128_mA101 t128_XA 0.05981f
Ct128eA101_2 t128_mA101 vdd 0.00496f
Ct128eA101_3 t128_mA101 t128_VB 0.07228f
Ct128eA101_4 t128_mA101 0 0.19922f
Xt128edA102 t128_XA t128_VB t128_mA102 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA102 0 0 t128_mA102 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA102_0 t128_mA102 0 0.00298f
Ct128eA102_1 t128_mA102 t128_XA 0.05981f
Ct128eA102_2 t128_mA102 vdd 0.00496f
Ct128eA102_3 t128_mA102 t128_VB 0.07228f
Ct128eA102_4 t128_mA102 0 0.19922f
Xt128edA103 t128_XA t128_VB t128_mA103 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA103 0 0 t128_mA103 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA103_0 t128_mA103 0 0.00298f
Ct128eA103_1 t128_mA103 t128_XA 0.05981f
Ct128eA103_2 t128_mA103 vdd 0.00496f
Ct128eA103_3 t128_mA103 t128_VB 0.07228f
Ct128eA103_4 t128_mA103 0 0.19922f
Xt128edA104 t128_XA t128_VB t128_mA104 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA104 0 0 t128_mA104 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA104_0 t128_mA104 0 0.00298f
Ct128eA104_1 t128_mA104 t128_XA 0.05981f
Ct128eA104_2 t128_mA104 vdd 0.00496f
Ct128eA104_3 t128_mA104 t128_VB 0.07228f
Ct128eA104_4 t128_mA104 0 0.19922f
Xt128edA105 t128_XA t128_VB t128_mA105 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA105 0 0 t128_mA105 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA105_0 t128_mA105 0 0.00298f
Ct128eA105_1 t128_mA105 t128_XA 0.05981f
Ct128eA105_2 t128_mA105 vdd 0.00496f
Ct128eA105_3 t128_mA105 t128_VB 0.07228f
Ct128eA105_4 t128_mA105 0 0.19922f
Xt128edA106 t128_XA t128_VB t128_mA106 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA106 0 0 t128_mA106 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA106_0 t128_mA106 0 0.00298f
Ct128eA106_1 t128_mA106 t128_XA 0.05981f
Ct128eA106_2 t128_mA106 vdd 0.00496f
Ct128eA106_3 t128_mA106 t128_VB 0.07228f
Ct128eA106_4 t128_mA106 0 0.19922f
Xt128edA107 t128_XA t128_VB t128_mA107 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA107 0 0 t128_mA107 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA107_0 t128_mA107 0 0.00298f
Ct128eA107_1 t128_mA107 t128_XA 0.05981f
Ct128eA107_2 t128_mA107 vdd 0.00496f
Ct128eA107_3 t128_mA107 t128_VB 0.07228f
Ct128eA107_4 t128_mA107 0 0.19922f
Xt128edA108 t128_XA t128_VB t128_mA108 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA108 0 0 t128_mA108 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA108_0 t128_mA108 0 0.00298f
Ct128eA108_1 t128_mA108 t128_XA 0.05981f
Ct128eA108_2 t128_mA108 vdd 0.00496f
Ct128eA108_3 t128_mA108 t128_VB 0.07228f
Ct128eA108_4 t128_mA108 0 0.19922f
Xt128edA109 t128_XA t128_VB t128_mA109 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA109 0 0 t128_mA109 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA109_0 t128_mA109 0 0.00298f
Ct128eA109_1 t128_mA109 t128_XA 0.05981f
Ct128eA109_2 t128_mA109 vdd 0.00496f
Ct128eA109_3 t128_mA109 t128_VB 0.07228f
Ct128eA109_4 t128_mA109 0 0.19922f
Xt128edA110 t128_XA t128_VB t128_mA110 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA110 0 0 t128_mA110 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA110_0 t128_mA110 0 0.00298f
Ct128eA110_1 t128_mA110 t128_XA 0.05981f
Ct128eA110_2 t128_mA110 vdd 0.00496f
Ct128eA110_3 t128_mA110 t128_VB 0.07228f
Ct128eA110_4 t128_mA110 0 0.19922f
Xt128edA111 t128_XA t128_VB t128_mA111 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA111 0 0 t128_mA111 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA111_0 t128_mA111 0 0.00298f
Ct128eA111_1 t128_mA111 t128_XA 0.05981f
Ct128eA111_2 t128_mA111 vdd 0.00496f
Ct128eA111_3 t128_mA111 t128_VB 0.07228f
Ct128eA111_4 t128_mA111 0 0.19922f
Xt128edA112 t128_XA t128_VB t128_mA112 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA112 0 0 t128_mA112 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA112_0 t128_mA112 0 0.00298f
Ct128eA112_1 t128_mA112 t128_XA 0.05981f
Ct128eA112_2 t128_mA112 vdd 0.00496f
Ct128eA112_3 t128_mA112 t128_VB 0.07228f
Ct128eA112_4 t128_mA112 0 0.19922f
Xt128edA113 t128_XA t128_VB t128_mA113 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA113 0 0 t128_mA113 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA113_0 t128_mA113 0 0.00298f
Ct128eA113_1 t128_mA113 t128_XA 0.05981f
Ct128eA113_2 t128_mA113 vdd 0.00496f
Ct128eA113_3 t128_mA113 t128_VB 0.07228f
Ct128eA113_4 t128_mA113 0 0.19922f
Xt128edA114 t128_XA t128_VB t128_mA114 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA114 0 0 t128_mA114 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA114_0 t128_mA114 0 0.00298f
Ct128eA114_1 t128_mA114 t128_XA 0.05981f
Ct128eA114_2 t128_mA114 vdd 0.00496f
Ct128eA114_3 t128_mA114 t128_VB 0.07228f
Ct128eA114_4 t128_mA114 0 0.19922f
Xt128edA115 t128_XA t128_VB t128_mA115 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA115 0 0 t128_mA115 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA115_0 t128_mA115 0 0.00298f
Ct128eA115_1 t128_mA115 t128_XA 0.05981f
Ct128eA115_2 t128_mA115 vdd 0.00496f
Ct128eA115_3 t128_mA115 t128_VB 0.07228f
Ct128eA115_4 t128_mA115 0 0.19922f
Xt128edA116 t128_XA t128_VB t128_mA116 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA116 0 0 t128_mA116 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA116_0 t128_mA116 0 0.00298f
Ct128eA116_1 t128_mA116 t128_XA 0.05981f
Ct128eA116_2 t128_mA116 vdd 0.00496f
Ct128eA116_3 t128_mA116 t128_VB 0.07228f
Ct128eA116_4 t128_mA116 0 0.19922f
Xt128edA117 t128_XA t128_VB t128_mA117 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA117 0 0 t128_mA117 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA117_0 t128_mA117 0 0.00298f
Ct128eA117_1 t128_mA117 t128_XA 0.05981f
Ct128eA117_2 t128_mA117 vdd 0.00496f
Ct128eA117_3 t128_mA117 t128_VB 0.07228f
Ct128eA117_4 t128_mA117 0 0.19922f
Xt128edA118 t128_XA t128_VB t128_mA118 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA118 0 0 t128_mA118 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA118_0 t128_mA118 0 0.00298f
Ct128eA118_1 t128_mA118 t128_XA 0.05981f
Ct128eA118_2 t128_mA118 vdd 0.00496f
Ct128eA118_3 t128_mA118 t128_VB 0.07228f
Ct128eA118_4 t128_mA118 0 0.19922f
Xt128edA119 t128_XA t128_VB t128_mA119 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA119 0 0 t128_mA119 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA119_0 t128_mA119 0 0.00298f
Ct128eA119_1 t128_mA119 t128_XA 0.05981f
Ct128eA119_2 t128_mA119 vdd 0.00496f
Ct128eA119_3 t128_mA119 t128_VB 0.07228f
Ct128eA119_4 t128_mA119 0 0.19922f
Xt128edA120 t128_XA t128_VB t128_mA120 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA120 0 0 t128_mA120 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA120_0 t128_mA120 0 0.00298f
Ct128eA120_1 t128_mA120 t128_XA 0.05981f
Ct128eA120_2 t128_mA120 vdd 0.00496f
Ct128eA120_3 t128_mA120 t128_VB 0.07228f
Ct128eA120_4 t128_mA120 0 0.19922f
Xt128edA121 t128_XA t128_VB t128_mA121 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA121 0 0 t128_mA121 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA121_0 t128_mA121 0 0.00298f
Ct128eA121_1 t128_mA121 t128_XA 0.05981f
Ct128eA121_2 t128_mA121 vdd 0.00496f
Ct128eA121_3 t128_mA121 t128_VB 0.07228f
Ct128eA121_4 t128_mA121 0 0.19922f
Xt128edA122 t128_XA t128_VB t128_mA122 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA122 0 0 t128_mA122 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA122_0 t128_mA122 0 0.00298f
Ct128eA122_1 t128_mA122 t128_XA 0.05981f
Ct128eA122_2 t128_mA122 vdd 0.00496f
Ct128eA122_3 t128_mA122 t128_VB 0.07228f
Ct128eA122_4 t128_mA122 0 0.19922f
Xt128edA123 t128_XA t128_VB t128_mA123 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA123 0 0 t128_mA123 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA123_0 t128_mA123 0 0.00298f
Ct128eA123_1 t128_mA123 t128_XA 0.05981f
Ct128eA123_2 t128_mA123 vdd 0.00496f
Ct128eA123_3 t128_mA123 t128_VB 0.07228f
Ct128eA123_4 t128_mA123 0 0.19922f
Xt128edA124 t128_XA t128_VB t128_mA124 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA124 0 0 t128_mA124 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA124_0 t128_mA124 0 0.00298f
Ct128eA124_1 t128_mA124 t128_XA 0.05981f
Ct128eA124_2 t128_mA124 vdd 0.00496f
Ct128eA124_3 t128_mA124 t128_VB 0.07228f
Ct128eA124_4 t128_mA124 0 0.19922f
Xt128edA125 t128_XA t128_VB t128_mA125 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA125 0 0 t128_mA125 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA125_0 t128_mA125 0 0.00298f
Ct128eA125_1 t128_mA125 t128_XA 0.05981f
Ct128eA125_2 t128_mA125 vdd 0.00496f
Ct128eA125_3 t128_mA125 t128_VB 0.07228f
Ct128eA125_4 t128_mA125 0 0.19922f
Xt128edA126 t128_XA t128_VB t128_mA126 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esA126 0 0 t128_mA126 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eA126_0 t128_mA126 0 0.00298f
Ct128eA126_1 t128_mA126 t128_XA 0.05981f
Ct128eA126_2 t128_mA126 vdd 0.00496f
Ct128eA126_3 t128_mA126 t128_VB 0.07228f
Ct128eA126_4 t128_mA126 0 0.19922f
Xt128edB0 t128_XB t128_VB t128_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB0 0 0 t128_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB0_0 t128_mB0 t128_XB 0.05778f
Ct128eB0_1 t128_mB0 vdd 0.00496f
Ct128eB0_2 t128_mB0 t128_VB 0.0654f
Ct128eB0_3 t128_mB0 0 0.00298f
Ct128eB0_4 t128_mB0 0 0.20468f
Xt128edB1 t128_XB t128_VB t128_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB1 0 0 t128_mB1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB1_0 t128_mB1 t128_XB 0.05778f
Ct128eB1_1 t128_mB1 vdd 0.00496f
Ct128eB1_2 t128_mB1 t128_VB 0.0654f
Ct128eB1_3 t128_mB1 0 0.00298f
Ct128eB1_4 t128_mB1 0 0.20468f
Xt128edB2 t128_XB t128_VB t128_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB2 0 0 t128_mB2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB2_0 t128_mB2 t128_XB 0.05778f
Ct128eB2_1 t128_mB2 vdd 0.00496f
Ct128eB2_2 t128_mB2 t128_VB 0.0654f
Ct128eB2_3 t128_mB2 0 0.00298f
Ct128eB2_4 t128_mB2 0 0.20468f
Xt128edB3 t128_XB t128_VB t128_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB3 0 0 t128_mB3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB3_0 t128_mB3 t128_XB 0.05778f
Ct128eB3_1 t128_mB3 vdd 0.00496f
Ct128eB3_2 t128_mB3 t128_VB 0.0654f
Ct128eB3_3 t128_mB3 0 0.00298f
Ct128eB3_4 t128_mB3 0 0.20468f
Xt128edB4 t128_XB t128_VB t128_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB4 0 0 t128_mB4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB4_0 t128_mB4 t128_XB 0.05778f
Ct128eB4_1 t128_mB4 vdd 0.00496f
Ct128eB4_2 t128_mB4 t128_VB 0.0654f
Ct128eB4_3 t128_mB4 0 0.00298f
Ct128eB4_4 t128_mB4 0 0.20468f
Xt128edB5 t128_XB t128_VB t128_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB5 0 0 t128_mB5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB5_0 t128_mB5 t128_XB 0.05778f
Ct128eB5_1 t128_mB5 vdd 0.00496f
Ct128eB5_2 t128_mB5 t128_VB 0.0654f
Ct128eB5_3 t128_mB5 0 0.00298f
Ct128eB5_4 t128_mB5 0 0.20468f
Xt128edB6 t128_XB t128_VB t128_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB6 0 0 t128_mB6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB6_0 t128_mB6 t128_XB 0.05778f
Ct128eB6_1 t128_mB6 vdd 0.00496f
Ct128eB6_2 t128_mB6 t128_VB 0.0654f
Ct128eB6_3 t128_mB6 0 0.00298f
Ct128eB6_4 t128_mB6 0 0.20468f
Xt128edB7 t128_XB t128_VB t128_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB7 0 0 t128_mB7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB7_0 t128_mB7 t128_XB 0.05778f
Ct128eB7_1 t128_mB7 vdd 0.00496f
Ct128eB7_2 t128_mB7 t128_VB 0.0654f
Ct128eB7_3 t128_mB7 0 0.00298f
Ct128eB7_4 t128_mB7 0 0.20468f
Xt128edB8 t128_XB t128_VB t128_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB8 0 0 t128_mB8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB8_0 t128_mB8 t128_XB 0.05778f
Ct128eB8_1 t128_mB8 vdd 0.00496f
Ct128eB8_2 t128_mB8 t128_VB 0.0654f
Ct128eB8_3 t128_mB8 0 0.00298f
Ct128eB8_4 t128_mB8 0 0.20468f
Xt128edB9 t128_XB t128_VB t128_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB9 0 0 t128_mB9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB9_0 t128_mB9 t128_XB 0.05778f
Ct128eB9_1 t128_mB9 vdd 0.00496f
Ct128eB9_2 t128_mB9 t128_VB 0.0654f
Ct128eB9_3 t128_mB9 0 0.00298f
Ct128eB9_4 t128_mB9 0 0.20468f
Xt128edB10 t128_XB t128_VB t128_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB10 0 0 t128_mB10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB10_0 t128_mB10 t128_XB 0.05778f
Ct128eB10_1 t128_mB10 vdd 0.00496f
Ct128eB10_2 t128_mB10 t128_VB 0.0654f
Ct128eB10_3 t128_mB10 0 0.00298f
Ct128eB10_4 t128_mB10 0 0.20468f
Xt128edB11 t128_XB t128_VB t128_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB11 0 0 t128_mB11 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB11_0 t128_mB11 t128_XB 0.05778f
Ct128eB11_1 t128_mB11 vdd 0.00496f
Ct128eB11_2 t128_mB11 t128_VB 0.0654f
Ct128eB11_3 t128_mB11 0 0.00298f
Ct128eB11_4 t128_mB11 0 0.20468f
Xt128edB12 t128_XB t128_VB t128_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB12 0 0 t128_mB12 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB12_0 t128_mB12 t128_XB 0.05778f
Ct128eB12_1 t128_mB12 vdd 0.00496f
Ct128eB12_2 t128_mB12 t128_VB 0.0654f
Ct128eB12_3 t128_mB12 0 0.00298f
Ct128eB12_4 t128_mB12 0 0.20468f
Xt128edB13 t128_XB t128_VB t128_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB13 0 0 t128_mB13 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB13_0 t128_mB13 t128_XB 0.05778f
Ct128eB13_1 t128_mB13 vdd 0.00496f
Ct128eB13_2 t128_mB13 t128_VB 0.0654f
Ct128eB13_3 t128_mB13 0 0.00298f
Ct128eB13_4 t128_mB13 0 0.20468f
Xt128edB14 t128_XB t128_VB t128_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB14 0 0 t128_mB14 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB14_0 t128_mB14 t128_XB 0.05778f
Ct128eB14_1 t128_mB14 vdd 0.00496f
Ct128eB14_2 t128_mB14 t128_VB 0.0654f
Ct128eB14_3 t128_mB14 0 0.00298f
Ct128eB14_4 t128_mB14 0 0.20468f
Xt128edB15 t128_XB t128_VB t128_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB15 0 0 t128_mB15 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB15_0 t128_mB15 t128_XB 0.05778f
Ct128eB15_1 t128_mB15 vdd 0.00496f
Ct128eB15_2 t128_mB15 t128_VB 0.0654f
Ct128eB15_3 t128_mB15 0 0.00298f
Ct128eB15_4 t128_mB15 0 0.20468f
Xt128edB16 t128_XB t128_VB t128_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB16 0 0 t128_mB16 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB16_0 t128_mB16 t128_XB 0.05778f
Ct128eB16_1 t128_mB16 vdd 0.00496f
Ct128eB16_2 t128_mB16 t128_VB 0.0654f
Ct128eB16_3 t128_mB16 0 0.00298f
Ct128eB16_4 t128_mB16 0 0.20468f
Xt128edB17 t128_XB t128_VB t128_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB17 0 0 t128_mB17 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB17_0 t128_mB17 t128_XB 0.05778f
Ct128eB17_1 t128_mB17 vdd 0.00496f
Ct128eB17_2 t128_mB17 t128_VB 0.0654f
Ct128eB17_3 t128_mB17 0 0.00298f
Ct128eB17_4 t128_mB17 0 0.20468f
Xt128edB18 t128_XB t128_VB t128_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB18 0 0 t128_mB18 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB18_0 t128_mB18 t128_XB 0.05778f
Ct128eB18_1 t128_mB18 vdd 0.00496f
Ct128eB18_2 t128_mB18 t128_VB 0.0654f
Ct128eB18_3 t128_mB18 0 0.00298f
Ct128eB18_4 t128_mB18 0 0.20468f
Xt128edB19 t128_XB t128_VB t128_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB19 0 0 t128_mB19 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB19_0 t128_mB19 t128_XB 0.05778f
Ct128eB19_1 t128_mB19 vdd 0.00496f
Ct128eB19_2 t128_mB19 t128_VB 0.0654f
Ct128eB19_3 t128_mB19 0 0.00298f
Ct128eB19_4 t128_mB19 0 0.20468f
Xt128edB20 t128_XB t128_VB t128_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB20 0 0 t128_mB20 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB20_0 t128_mB20 t128_XB 0.05778f
Ct128eB20_1 t128_mB20 vdd 0.00496f
Ct128eB20_2 t128_mB20 t128_VB 0.0654f
Ct128eB20_3 t128_mB20 0 0.00298f
Ct128eB20_4 t128_mB20 0 0.20468f
Xt128edB21 t128_XB t128_VB t128_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB21 0 0 t128_mB21 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB21_0 t128_mB21 t128_XB 0.05778f
Ct128eB21_1 t128_mB21 vdd 0.00496f
Ct128eB21_2 t128_mB21 t128_VB 0.0654f
Ct128eB21_3 t128_mB21 0 0.00298f
Ct128eB21_4 t128_mB21 0 0.20468f
Xt128edB22 t128_XB t128_VB t128_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB22 0 0 t128_mB22 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB22_0 t128_mB22 t128_XB 0.05778f
Ct128eB22_1 t128_mB22 vdd 0.00496f
Ct128eB22_2 t128_mB22 t128_VB 0.0654f
Ct128eB22_3 t128_mB22 0 0.00298f
Ct128eB22_4 t128_mB22 0 0.20468f
Xt128edB23 t128_XB t128_VB t128_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB23 0 0 t128_mB23 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB23_0 t128_mB23 t128_XB 0.05778f
Ct128eB23_1 t128_mB23 vdd 0.00496f
Ct128eB23_2 t128_mB23 t128_VB 0.0654f
Ct128eB23_3 t128_mB23 0 0.00298f
Ct128eB23_4 t128_mB23 0 0.20468f
Xt128edB24 t128_XB t128_VB t128_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB24 0 0 t128_mB24 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB24_0 t128_mB24 t128_XB 0.05778f
Ct128eB24_1 t128_mB24 vdd 0.00496f
Ct128eB24_2 t128_mB24 t128_VB 0.0654f
Ct128eB24_3 t128_mB24 0 0.00298f
Ct128eB24_4 t128_mB24 0 0.20468f
Xt128edB25 t128_XB t128_VB t128_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB25 0 0 t128_mB25 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB25_0 t128_mB25 t128_XB 0.05778f
Ct128eB25_1 t128_mB25 vdd 0.00496f
Ct128eB25_2 t128_mB25 t128_VB 0.0654f
Ct128eB25_3 t128_mB25 0 0.00298f
Ct128eB25_4 t128_mB25 0 0.20468f
Xt128edB26 t128_XB t128_VB t128_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB26 0 0 t128_mB26 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB26_0 t128_mB26 t128_XB 0.05778f
Ct128eB26_1 t128_mB26 vdd 0.00496f
Ct128eB26_2 t128_mB26 t128_VB 0.0654f
Ct128eB26_3 t128_mB26 0 0.00298f
Ct128eB26_4 t128_mB26 0 0.20468f
Xt128edB27 t128_XB t128_VB t128_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB27 0 0 t128_mB27 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB27_0 t128_mB27 t128_XB 0.05778f
Ct128eB27_1 t128_mB27 vdd 0.00496f
Ct128eB27_2 t128_mB27 t128_VB 0.0654f
Ct128eB27_3 t128_mB27 0 0.00298f
Ct128eB27_4 t128_mB27 0 0.20468f
Xt128edB28 t128_XB t128_VB t128_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB28 0 0 t128_mB28 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB28_0 t128_mB28 t128_XB 0.05778f
Ct128eB28_1 t128_mB28 vdd 0.00496f
Ct128eB28_2 t128_mB28 t128_VB 0.0654f
Ct128eB28_3 t128_mB28 0 0.00298f
Ct128eB28_4 t128_mB28 0 0.20468f
Xt128edB29 t128_XB t128_VB t128_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB29 0 0 t128_mB29 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB29_0 t128_mB29 t128_XB 0.05778f
Ct128eB29_1 t128_mB29 vdd 0.00496f
Ct128eB29_2 t128_mB29 t128_VB 0.0654f
Ct128eB29_3 t128_mB29 0 0.00298f
Ct128eB29_4 t128_mB29 0 0.20468f
Xt128edB30 t128_XB t128_VB t128_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB30 0 0 t128_mB30 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB30_0 t128_mB30 t128_XB 0.05778f
Ct128eB30_1 t128_mB30 vdd 0.00496f
Ct128eB30_2 t128_mB30 t128_VB 0.0654f
Ct128eB30_3 t128_mB30 0 0.00298f
Ct128eB30_4 t128_mB30 0 0.20468f
Xt128edB31 t128_XB t128_VB t128_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB31 0 0 t128_mB31 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB31_0 t128_mB31 t128_XB 0.05778f
Ct128eB31_1 t128_mB31 vdd 0.00496f
Ct128eB31_2 t128_mB31 t128_VB 0.0654f
Ct128eB31_3 t128_mB31 0 0.00298f
Ct128eB31_4 t128_mB31 0 0.20468f
Xt128edB32 t128_XB t128_VB t128_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB32 0 0 t128_mB32 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB32_0 t128_mB32 t128_XB 0.05778f
Ct128eB32_1 t128_mB32 vdd 0.00496f
Ct128eB32_2 t128_mB32 t128_VB 0.0654f
Ct128eB32_3 t128_mB32 0 0.00298f
Ct128eB32_4 t128_mB32 0 0.20468f
Xt128edB33 t128_XB t128_VB t128_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB33 0 0 t128_mB33 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB33_0 t128_mB33 t128_XB 0.05778f
Ct128eB33_1 t128_mB33 vdd 0.00496f
Ct128eB33_2 t128_mB33 t128_VB 0.0654f
Ct128eB33_3 t128_mB33 0 0.00298f
Ct128eB33_4 t128_mB33 0 0.20468f
Xt128edB34 t128_XB t128_VB t128_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB34 0 0 t128_mB34 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB34_0 t128_mB34 t128_XB 0.05778f
Ct128eB34_1 t128_mB34 vdd 0.00496f
Ct128eB34_2 t128_mB34 t128_VB 0.0654f
Ct128eB34_3 t128_mB34 0 0.00298f
Ct128eB34_4 t128_mB34 0 0.20468f
Xt128edB35 t128_XB t128_VB t128_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB35 0 0 t128_mB35 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB35_0 t128_mB35 t128_XB 0.05778f
Ct128eB35_1 t128_mB35 vdd 0.00496f
Ct128eB35_2 t128_mB35 t128_VB 0.0654f
Ct128eB35_3 t128_mB35 0 0.00298f
Ct128eB35_4 t128_mB35 0 0.20468f
Xt128edB36 t128_XB t128_VB t128_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB36 0 0 t128_mB36 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB36_0 t128_mB36 t128_XB 0.05778f
Ct128eB36_1 t128_mB36 vdd 0.00496f
Ct128eB36_2 t128_mB36 t128_VB 0.0654f
Ct128eB36_3 t128_mB36 0 0.00298f
Ct128eB36_4 t128_mB36 0 0.20468f
Xt128edB37 t128_XB t128_VB t128_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB37 0 0 t128_mB37 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB37_0 t128_mB37 t128_XB 0.05778f
Ct128eB37_1 t128_mB37 vdd 0.00496f
Ct128eB37_2 t128_mB37 t128_VB 0.0654f
Ct128eB37_3 t128_mB37 0 0.00298f
Ct128eB37_4 t128_mB37 0 0.20468f
Xt128edB38 t128_XB t128_VB t128_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB38 0 0 t128_mB38 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB38_0 t128_mB38 t128_XB 0.05778f
Ct128eB38_1 t128_mB38 vdd 0.00496f
Ct128eB38_2 t128_mB38 t128_VB 0.0654f
Ct128eB38_3 t128_mB38 0 0.00298f
Ct128eB38_4 t128_mB38 0 0.20468f
Xt128edB39 t128_XB t128_VB t128_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB39 0 0 t128_mB39 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB39_0 t128_mB39 t128_XB 0.05778f
Ct128eB39_1 t128_mB39 vdd 0.00496f
Ct128eB39_2 t128_mB39 t128_VB 0.0654f
Ct128eB39_3 t128_mB39 0 0.00298f
Ct128eB39_4 t128_mB39 0 0.20468f
Xt128edB40 t128_XB t128_VB t128_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB40 0 0 t128_mB40 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB40_0 t128_mB40 t128_XB 0.05778f
Ct128eB40_1 t128_mB40 vdd 0.00496f
Ct128eB40_2 t128_mB40 t128_VB 0.0654f
Ct128eB40_3 t128_mB40 0 0.00298f
Ct128eB40_4 t128_mB40 0 0.20468f
Xt128edB41 t128_XB t128_VB t128_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB41 0 0 t128_mB41 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB41_0 t128_mB41 t128_XB 0.05778f
Ct128eB41_1 t128_mB41 vdd 0.00496f
Ct128eB41_2 t128_mB41 t128_VB 0.0654f
Ct128eB41_3 t128_mB41 0 0.00298f
Ct128eB41_4 t128_mB41 0 0.20468f
Xt128edB42 t128_XB t128_VB t128_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB42 0 0 t128_mB42 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB42_0 t128_mB42 t128_XB 0.05778f
Ct128eB42_1 t128_mB42 vdd 0.00496f
Ct128eB42_2 t128_mB42 t128_VB 0.0654f
Ct128eB42_3 t128_mB42 0 0.00298f
Ct128eB42_4 t128_mB42 0 0.20468f
Xt128edB43 t128_XB t128_VB t128_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB43 0 0 t128_mB43 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB43_0 t128_mB43 t128_XB 0.05778f
Ct128eB43_1 t128_mB43 vdd 0.00496f
Ct128eB43_2 t128_mB43 t128_VB 0.0654f
Ct128eB43_3 t128_mB43 0 0.00298f
Ct128eB43_4 t128_mB43 0 0.20468f
Xt128edB44 t128_XB t128_VB t128_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB44 0 0 t128_mB44 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB44_0 t128_mB44 t128_XB 0.05778f
Ct128eB44_1 t128_mB44 vdd 0.00496f
Ct128eB44_2 t128_mB44 t128_VB 0.0654f
Ct128eB44_3 t128_mB44 0 0.00298f
Ct128eB44_4 t128_mB44 0 0.20468f
Xt128edB45 t128_XB t128_VB t128_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB45 0 0 t128_mB45 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB45_0 t128_mB45 t128_XB 0.05778f
Ct128eB45_1 t128_mB45 vdd 0.00496f
Ct128eB45_2 t128_mB45 t128_VB 0.0654f
Ct128eB45_3 t128_mB45 0 0.00298f
Ct128eB45_4 t128_mB45 0 0.20468f
Xt128edB46 t128_XB t128_VB t128_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB46 0 0 t128_mB46 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB46_0 t128_mB46 t128_XB 0.05778f
Ct128eB46_1 t128_mB46 vdd 0.00496f
Ct128eB46_2 t128_mB46 t128_VB 0.0654f
Ct128eB46_3 t128_mB46 0 0.00298f
Ct128eB46_4 t128_mB46 0 0.20468f
Xt128edB47 t128_XB t128_VB t128_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB47 0 0 t128_mB47 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB47_0 t128_mB47 t128_XB 0.05778f
Ct128eB47_1 t128_mB47 vdd 0.00496f
Ct128eB47_2 t128_mB47 t128_VB 0.0654f
Ct128eB47_3 t128_mB47 0 0.00298f
Ct128eB47_4 t128_mB47 0 0.20468f
Xt128edB48 t128_XB t128_VB t128_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB48 0 0 t128_mB48 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB48_0 t128_mB48 t128_XB 0.05778f
Ct128eB48_1 t128_mB48 vdd 0.00496f
Ct128eB48_2 t128_mB48 t128_VB 0.0654f
Ct128eB48_3 t128_mB48 0 0.00298f
Ct128eB48_4 t128_mB48 0 0.20468f
Xt128edB49 t128_XB t128_VB t128_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB49 0 0 t128_mB49 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB49_0 t128_mB49 t128_XB 0.05778f
Ct128eB49_1 t128_mB49 vdd 0.00496f
Ct128eB49_2 t128_mB49 t128_VB 0.0654f
Ct128eB49_3 t128_mB49 0 0.00298f
Ct128eB49_4 t128_mB49 0 0.20468f
Xt128edB50 t128_XB t128_VB t128_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB50 0 0 t128_mB50 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB50_0 t128_mB50 t128_XB 0.05778f
Ct128eB50_1 t128_mB50 vdd 0.00496f
Ct128eB50_2 t128_mB50 t128_VB 0.0654f
Ct128eB50_3 t128_mB50 0 0.00298f
Ct128eB50_4 t128_mB50 0 0.20468f
Xt128edB51 t128_XB t128_VB t128_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB51 0 0 t128_mB51 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB51_0 t128_mB51 t128_XB 0.05778f
Ct128eB51_1 t128_mB51 vdd 0.00496f
Ct128eB51_2 t128_mB51 t128_VB 0.0654f
Ct128eB51_3 t128_mB51 0 0.00298f
Ct128eB51_4 t128_mB51 0 0.20468f
Xt128edB52 t128_XB t128_VB t128_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB52 0 0 t128_mB52 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB52_0 t128_mB52 t128_XB 0.05778f
Ct128eB52_1 t128_mB52 vdd 0.00496f
Ct128eB52_2 t128_mB52 t128_VB 0.0654f
Ct128eB52_3 t128_mB52 0 0.00298f
Ct128eB52_4 t128_mB52 0 0.20468f
Xt128edB53 t128_XB t128_VB t128_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB53 0 0 t128_mB53 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB53_0 t128_mB53 t128_XB 0.05778f
Ct128eB53_1 t128_mB53 vdd 0.00496f
Ct128eB53_2 t128_mB53 t128_VB 0.0654f
Ct128eB53_3 t128_mB53 0 0.00298f
Ct128eB53_4 t128_mB53 0 0.20468f
Xt128edB54 t128_XB t128_VB t128_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB54 0 0 t128_mB54 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB54_0 t128_mB54 t128_XB 0.05778f
Ct128eB54_1 t128_mB54 vdd 0.00496f
Ct128eB54_2 t128_mB54 t128_VB 0.0654f
Ct128eB54_3 t128_mB54 0 0.00298f
Ct128eB54_4 t128_mB54 0 0.20468f
Xt128edB55 t128_XB t128_VB t128_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB55 0 0 t128_mB55 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB55_0 t128_mB55 t128_XB 0.05778f
Ct128eB55_1 t128_mB55 vdd 0.00496f
Ct128eB55_2 t128_mB55 t128_VB 0.0654f
Ct128eB55_3 t128_mB55 0 0.00298f
Ct128eB55_4 t128_mB55 0 0.20468f
Xt128edB56 t128_XB t128_VB t128_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB56 0 0 t128_mB56 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB56_0 t128_mB56 t128_XB 0.05778f
Ct128eB56_1 t128_mB56 vdd 0.00496f
Ct128eB56_2 t128_mB56 t128_VB 0.0654f
Ct128eB56_3 t128_mB56 0 0.00298f
Ct128eB56_4 t128_mB56 0 0.20468f
Xt128edB57 t128_XB t128_VB t128_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB57 0 0 t128_mB57 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB57_0 t128_mB57 t128_XB 0.05778f
Ct128eB57_1 t128_mB57 vdd 0.00496f
Ct128eB57_2 t128_mB57 t128_VB 0.0654f
Ct128eB57_3 t128_mB57 0 0.00298f
Ct128eB57_4 t128_mB57 0 0.20468f
Xt128edB58 t128_XB t128_VB t128_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB58 0 0 t128_mB58 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB58_0 t128_mB58 t128_XB 0.05778f
Ct128eB58_1 t128_mB58 vdd 0.00496f
Ct128eB58_2 t128_mB58 t128_VB 0.0654f
Ct128eB58_3 t128_mB58 0 0.00298f
Ct128eB58_4 t128_mB58 0 0.20468f
Xt128edB59 t128_XB t128_VB t128_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB59 0 0 t128_mB59 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB59_0 t128_mB59 t128_XB 0.05778f
Ct128eB59_1 t128_mB59 vdd 0.00496f
Ct128eB59_2 t128_mB59 t128_VB 0.0654f
Ct128eB59_3 t128_mB59 0 0.00298f
Ct128eB59_4 t128_mB59 0 0.20468f
Xt128edB60 t128_XB t128_VB t128_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB60 0 0 t128_mB60 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB60_0 t128_mB60 t128_XB 0.05778f
Ct128eB60_1 t128_mB60 vdd 0.00496f
Ct128eB60_2 t128_mB60 t128_VB 0.0654f
Ct128eB60_3 t128_mB60 0 0.00298f
Ct128eB60_4 t128_mB60 0 0.20468f
Xt128edB61 t128_XB t128_VB t128_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB61 0 0 t128_mB61 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB61_0 t128_mB61 t128_XB 0.05778f
Ct128eB61_1 t128_mB61 vdd 0.00496f
Ct128eB61_2 t128_mB61 t128_VB 0.0654f
Ct128eB61_3 t128_mB61 0 0.00298f
Ct128eB61_4 t128_mB61 0 0.20468f
Xt128edB62 t128_XB t128_VB t128_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB62 0 0 t128_mB62 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB62_0 t128_mB62 t128_XB 0.05778f
Ct128eB62_1 t128_mB62 vdd 0.00496f
Ct128eB62_2 t128_mB62 t128_VB 0.0654f
Ct128eB62_3 t128_mB62 0 0.00298f
Ct128eB62_4 t128_mB62 0 0.20468f
Xt128edB63 t128_XB t128_VB t128_mB63 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB63 0 0 t128_mB63 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB63_0 t128_mB63 t128_XB 0.05778f
Ct128eB63_1 t128_mB63 vdd 0.00496f
Ct128eB63_2 t128_mB63 t128_VB 0.0654f
Ct128eB63_3 t128_mB63 0 0.00298f
Ct128eB63_4 t128_mB63 0 0.20468f
Xt128edB64 t128_XB t128_VB t128_mB64 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB64 0 0 t128_mB64 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB64_0 t128_mB64 t128_XB 0.05778f
Ct128eB64_1 t128_mB64 vdd 0.00496f
Ct128eB64_2 t128_mB64 t128_VB 0.0654f
Ct128eB64_3 t128_mB64 0 0.00298f
Ct128eB64_4 t128_mB64 0 0.20468f
Xt128edB65 t128_XB t128_VB t128_mB65 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB65 0 0 t128_mB65 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB65_0 t128_mB65 t128_XB 0.05778f
Ct128eB65_1 t128_mB65 vdd 0.00496f
Ct128eB65_2 t128_mB65 t128_VB 0.0654f
Ct128eB65_3 t128_mB65 0 0.00298f
Ct128eB65_4 t128_mB65 0 0.20468f
Xt128edB66 t128_XB t128_VB t128_mB66 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB66 0 0 t128_mB66 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB66_0 t128_mB66 t128_XB 0.05778f
Ct128eB66_1 t128_mB66 vdd 0.00496f
Ct128eB66_2 t128_mB66 t128_VB 0.0654f
Ct128eB66_3 t128_mB66 0 0.00298f
Ct128eB66_4 t128_mB66 0 0.20468f
Xt128edB67 t128_XB t128_VB t128_mB67 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB67 0 0 t128_mB67 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB67_0 t128_mB67 t128_XB 0.05778f
Ct128eB67_1 t128_mB67 vdd 0.00496f
Ct128eB67_2 t128_mB67 t128_VB 0.0654f
Ct128eB67_3 t128_mB67 0 0.00298f
Ct128eB67_4 t128_mB67 0 0.20468f
Xt128edB68 t128_XB t128_VB t128_mB68 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB68 0 0 t128_mB68 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB68_0 t128_mB68 t128_XB 0.05778f
Ct128eB68_1 t128_mB68 vdd 0.00496f
Ct128eB68_2 t128_mB68 t128_VB 0.0654f
Ct128eB68_3 t128_mB68 0 0.00298f
Ct128eB68_4 t128_mB68 0 0.20468f
Xt128edB69 t128_XB t128_VB t128_mB69 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB69 0 0 t128_mB69 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB69_0 t128_mB69 t128_XB 0.05778f
Ct128eB69_1 t128_mB69 vdd 0.00496f
Ct128eB69_2 t128_mB69 t128_VB 0.0654f
Ct128eB69_3 t128_mB69 0 0.00298f
Ct128eB69_4 t128_mB69 0 0.20468f
Xt128edB70 t128_XB t128_VB t128_mB70 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB70 0 0 t128_mB70 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB70_0 t128_mB70 t128_XB 0.05778f
Ct128eB70_1 t128_mB70 vdd 0.00496f
Ct128eB70_2 t128_mB70 t128_VB 0.0654f
Ct128eB70_3 t128_mB70 0 0.00298f
Ct128eB70_4 t128_mB70 0 0.20468f
Xt128edB71 t128_XB t128_VB t128_mB71 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB71 0 0 t128_mB71 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB71_0 t128_mB71 t128_XB 0.05778f
Ct128eB71_1 t128_mB71 vdd 0.00496f
Ct128eB71_2 t128_mB71 t128_VB 0.0654f
Ct128eB71_3 t128_mB71 0 0.00298f
Ct128eB71_4 t128_mB71 0 0.20468f
Xt128edB72 t128_XB t128_VB t128_mB72 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB72 0 0 t128_mB72 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB72_0 t128_mB72 t128_XB 0.05778f
Ct128eB72_1 t128_mB72 vdd 0.00496f
Ct128eB72_2 t128_mB72 t128_VB 0.0654f
Ct128eB72_3 t128_mB72 0 0.00298f
Ct128eB72_4 t128_mB72 0 0.20468f
Xt128edB73 t128_XB t128_VB t128_mB73 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB73 0 0 t128_mB73 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB73_0 t128_mB73 t128_XB 0.05778f
Ct128eB73_1 t128_mB73 vdd 0.00496f
Ct128eB73_2 t128_mB73 t128_VB 0.0654f
Ct128eB73_3 t128_mB73 0 0.00298f
Ct128eB73_4 t128_mB73 0 0.20468f
Xt128edB74 t128_XB t128_VB t128_mB74 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB74 0 0 t128_mB74 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB74_0 t128_mB74 t128_XB 0.05778f
Ct128eB74_1 t128_mB74 vdd 0.00496f
Ct128eB74_2 t128_mB74 t128_VB 0.0654f
Ct128eB74_3 t128_mB74 0 0.00298f
Ct128eB74_4 t128_mB74 0 0.20468f
Xt128edB75 t128_XB t128_VB t128_mB75 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB75 0 0 t128_mB75 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB75_0 t128_mB75 t128_XB 0.05778f
Ct128eB75_1 t128_mB75 vdd 0.00496f
Ct128eB75_2 t128_mB75 t128_VB 0.0654f
Ct128eB75_3 t128_mB75 0 0.00298f
Ct128eB75_4 t128_mB75 0 0.20468f
Xt128edB76 t128_XB t128_VB t128_mB76 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB76 0 0 t128_mB76 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB76_0 t128_mB76 t128_XB 0.05778f
Ct128eB76_1 t128_mB76 vdd 0.00496f
Ct128eB76_2 t128_mB76 t128_VB 0.0654f
Ct128eB76_3 t128_mB76 0 0.00298f
Ct128eB76_4 t128_mB76 0 0.20468f
Xt128edB77 t128_XB t128_VB t128_mB77 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB77 0 0 t128_mB77 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB77_0 t128_mB77 t128_XB 0.05778f
Ct128eB77_1 t128_mB77 vdd 0.00496f
Ct128eB77_2 t128_mB77 t128_VB 0.0654f
Ct128eB77_3 t128_mB77 0 0.00298f
Ct128eB77_4 t128_mB77 0 0.20468f
Xt128edB78 t128_XB t128_VB t128_mB78 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB78 0 0 t128_mB78 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB78_0 t128_mB78 t128_XB 0.05778f
Ct128eB78_1 t128_mB78 vdd 0.00496f
Ct128eB78_2 t128_mB78 t128_VB 0.0654f
Ct128eB78_3 t128_mB78 0 0.00298f
Ct128eB78_4 t128_mB78 0 0.20468f
Xt128edB79 t128_XB t128_VB t128_mB79 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB79 0 0 t128_mB79 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB79_0 t128_mB79 t128_XB 0.05778f
Ct128eB79_1 t128_mB79 vdd 0.00496f
Ct128eB79_2 t128_mB79 t128_VB 0.0654f
Ct128eB79_3 t128_mB79 0 0.00298f
Ct128eB79_4 t128_mB79 0 0.20468f
Xt128edB80 t128_XB t128_VB t128_mB80 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB80 0 0 t128_mB80 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB80_0 t128_mB80 t128_XB 0.05778f
Ct128eB80_1 t128_mB80 vdd 0.00496f
Ct128eB80_2 t128_mB80 t128_VB 0.0654f
Ct128eB80_3 t128_mB80 0 0.00298f
Ct128eB80_4 t128_mB80 0 0.20468f
Xt128edB81 t128_XB t128_VB t128_mB81 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB81 0 0 t128_mB81 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB81_0 t128_mB81 t128_XB 0.05778f
Ct128eB81_1 t128_mB81 vdd 0.00496f
Ct128eB81_2 t128_mB81 t128_VB 0.0654f
Ct128eB81_3 t128_mB81 0 0.00298f
Ct128eB81_4 t128_mB81 0 0.20468f
Xt128edB82 t128_XB t128_VB t128_mB82 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB82 0 0 t128_mB82 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB82_0 t128_mB82 t128_XB 0.05778f
Ct128eB82_1 t128_mB82 vdd 0.00496f
Ct128eB82_2 t128_mB82 t128_VB 0.0654f
Ct128eB82_3 t128_mB82 0 0.00298f
Ct128eB82_4 t128_mB82 0 0.20468f
Xt128edB83 t128_XB t128_VB t128_mB83 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB83 0 0 t128_mB83 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB83_0 t128_mB83 t128_XB 0.05778f
Ct128eB83_1 t128_mB83 vdd 0.00496f
Ct128eB83_2 t128_mB83 t128_VB 0.0654f
Ct128eB83_3 t128_mB83 0 0.00298f
Ct128eB83_4 t128_mB83 0 0.20468f
Xt128edB84 t128_XB t128_VB t128_mB84 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB84 0 0 t128_mB84 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB84_0 t128_mB84 t128_XB 0.05778f
Ct128eB84_1 t128_mB84 vdd 0.00496f
Ct128eB84_2 t128_mB84 t128_VB 0.0654f
Ct128eB84_3 t128_mB84 0 0.00298f
Ct128eB84_4 t128_mB84 0 0.20468f
Xt128edB85 t128_XB t128_VB t128_mB85 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB85 0 0 t128_mB85 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB85_0 t128_mB85 t128_XB 0.05778f
Ct128eB85_1 t128_mB85 vdd 0.00496f
Ct128eB85_2 t128_mB85 t128_VB 0.0654f
Ct128eB85_3 t128_mB85 0 0.00298f
Ct128eB85_4 t128_mB85 0 0.20468f
Xt128edB86 t128_XB t128_VB t128_mB86 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB86 0 0 t128_mB86 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB86_0 t128_mB86 t128_XB 0.05778f
Ct128eB86_1 t128_mB86 vdd 0.00496f
Ct128eB86_2 t128_mB86 t128_VB 0.0654f
Ct128eB86_3 t128_mB86 0 0.00298f
Ct128eB86_4 t128_mB86 0 0.20468f
Xt128edB87 t128_XB t128_VB t128_mB87 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB87 0 0 t128_mB87 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB87_0 t128_mB87 t128_XB 0.05778f
Ct128eB87_1 t128_mB87 vdd 0.00496f
Ct128eB87_2 t128_mB87 t128_VB 0.0654f
Ct128eB87_3 t128_mB87 0 0.00298f
Ct128eB87_4 t128_mB87 0 0.20468f
Xt128edB88 t128_XB t128_VB t128_mB88 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB88 0 0 t128_mB88 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB88_0 t128_mB88 t128_XB 0.05778f
Ct128eB88_1 t128_mB88 vdd 0.00496f
Ct128eB88_2 t128_mB88 t128_VB 0.0654f
Ct128eB88_3 t128_mB88 0 0.00298f
Ct128eB88_4 t128_mB88 0 0.20468f
Xt128edB89 t128_XB t128_VB t128_mB89 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB89 0 0 t128_mB89 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB89_0 t128_mB89 t128_XB 0.05778f
Ct128eB89_1 t128_mB89 vdd 0.00496f
Ct128eB89_2 t128_mB89 t128_VB 0.0654f
Ct128eB89_3 t128_mB89 0 0.00298f
Ct128eB89_4 t128_mB89 0 0.20468f
Xt128edB90 t128_XB t128_VB t128_mB90 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB90 0 0 t128_mB90 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB90_0 t128_mB90 t128_XB 0.05778f
Ct128eB90_1 t128_mB90 vdd 0.00496f
Ct128eB90_2 t128_mB90 t128_VB 0.0654f
Ct128eB90_3 t128_mB90 0 0.00298f
Ct128eB90_4 t128_mB90 0 0.20468f
Xt128edB91 t128_XB t128_VB t128_mB91 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB91 0 0 t128_mB91 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB91_0 t128_mB91 t128_XB 0.05778f
Ct128eB91_1 t128_mB91 vdd 0.00496f
Ct128eB91_2 t128_mB91 t128_VB 0.0654f
Ct128eB91_3 t128_mB91 0 0.00298f
Ct128eB91_4 t128_mB91 0 0.20468f
Xt128edB92 t128_XB t128_VB t128_mB92 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB92 0 0 t128_mB92 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB92_0 t128_mB92 t128_XB 0.05778f
Ct128eB92_1 t128_mB92 vdd 0.00496f
Ct128eB92_2 t128_mB92 t128_VB 0.0654f
Ct128eB92_3 t128_mB92 0 0.00298f
Ct128eB92_4 t128_mB92 0 0.20468f
Xt128edB93 t128_XB t128_VB t128_mB93 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB93 0 0 t128_mB93 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB93_0 t128_mB93 t128_XB 0.05778f
Ct128eB93_1 t128_mB93 vdd 0.00496f
Ct128eB93_2 t128_mB93 t128_VB 0.0654f
Ct128eB93_3 t128_mB93 0 0.00298f
Ct128eB93_4 t128_mB93 0 0.20468f
Xt128edB94 t128_XB t128_VB t128_mB94 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB94 0 0 t128_mB94 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB94_0 t128_mB94 t128_XB 0.05778f
Ct128eB94_1 t128_mB94 vdd 0.00496f
Ct128eB94_2 t128_mB94 t128_VB 0.0654f
Ct128eB94_3 t128_mB94 0 0.00298f
Ct128eB94_4 t128_mB94 0 0.20468f
Xt128edB95 t128_XB t128_VB t128_mB95 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB95 0 0 t128_mB95 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB95_0 t128_mB95 t128_XB 0.05778f
Ct128eB95_1 t128_mB95 vdd 0.00496f
Ct128eB95_2 t128_mB95 t128_VB 0.0654f
Ct128eB95_3 t128_mB95 0 0.00298f
Ct128eB95_4 t128_mB95 0 0.20468f
Xt128edB96 t128_XB t128_VB t128_mB96 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB96 0 0 t128_mB96 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB96_0 t128_mB96 t128_XB 0.05778f
Ct128eB96_1 t128_mB96 vdd 0.00496f
Ct128eB96_2 t128_mB96 t128_VB 0.0654f
Ct128eB96_3 t128_mB96 0 0.00298f
Ct128eB96_4 t128_mB96 0 0.20468f
Xt128edB97 t128_XB t128_VB t128_mB97 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB97 0 0 t128_mB97 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB97_0 t128_mB97 t128_XB 0.05778f
Ct128eB97_1 t128_mB97 vdd 0.00496f
Ct128eB97_2 t128_mB97 t128_VB 0.0654f
Ct128eB97_3 t128_mB97 0 0.00298f
Ct128eB97_4 t128_mB97 0 0.20468f
Xt128edB98 t128_XB t128_VB t128_mB98 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB98 0 0 t128_mB98 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB98_0 t128_mB98 t128_XB 0.05778f
Ct128eB98_1 t128_mB98 vdd 0.00496f
Ct128eB98_2 t128_mB98 t128_VB 0.0654f
Ct128eB98_3 t128_mB98 0 0.00298f
Ct128eB98_4 t128_mB98 0 0.20468f
Xt128edB99 t128_XB t128_VB t128_mB99 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB99 0 0 t128_mB99 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB99_0 t128_mB99 t128_XB 0.05778f
Ct128eB99_1 t128_mB99 vdd 0.00496f
Ct128eB99_2 t128_mB99 t128_VB 0.0654f
Ct128eB99_3 t128_mB99 0 0.00298f
Ct128eB99_4 t128_mB99 0 0.20468f
Xt128edB100 t128_XB t128_VB t128_mB100 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB100 0 0 t128_mB100 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB100_0 t128_mB100 t128_XB 0.05778f
Ct128eB100_1 t128_mB100 vdd 0.00496f
Ct128eB100_2 t128_mB100 t128_VB 0.0654f
Ct128eB100_3 t128_mB100 0 0.00298f
Ct128eB100_4 t128_mB100 0 0.20468f
Xt128edB101 t128_XB t128_VB t128_mB101 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB101 0 0 t128_mB101 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB101_0 t128_mB101 t128_XB 0.05778f
Ct128eB101_1 t128_mB101 vdd 0.00496f
Ct128eB101_2 t128_mB101 t128_VB 0.0654f
Ct128eB101_3 t128_mB101 0 0.00298f
Ct128eB101_4 t128_mB101 0 0.20468f
Xt128edB102 t128_XB t128_VB t128_mB102 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB102 0 0 t128_mB102 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB102_0 t128_mB102 t128_XB 0.05778f
Ct128eB102_1 t128_mB102 vdd 0.00496f
Ct128eB102_2 t128_mB102 t128_VB 0.0654f
Ct128eB102_3 t128_mB102 0 0.00298f
Ct128eB102_4 t128_mB102 0 0.20468f
Xt128edB103 t128_XB t128_VB t128_mB103 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB103 0 0 t128_mB103 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB103_0 t128_mB103 t128_XB 0.05778f
Ct128eB103_1 t128_mB103 vdd 0.00496f
Ct128eB103_2 t128_mB103 t128_VB 0.0654f
Ct128eB103_3 t128_mB103 0 0.00298f
Ct128eB103_4 t128_mB103 0 0.20468f
Xt128edB104 t128_XB t128_VB t128_mB104 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB104 0 0 t128_mB104 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB104_0 t128_mB104 t128_XB 0.05778f
Ct128eB104_1 t128_mB104 vdd 0.00496f
Ct128eB104_2 t128_mB104 t128_VB 0.0654f
Ct128eB104_3 t128_mB104 0 0.00298f
Ct128eB104_4 t128_mB104 0 0.20468f
Xt128edB105 t128_XB t128_VB t128_mB105 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB105 0 0 t128_mB105 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB105_0 t128_mB105 t128_XB 0.05778f
Ct128eB105_1 t128_mB105 vdd 0.00496f
Ct128eB105_2 t128_mB105 t128_VB 0.0654f
Ct128eB105_3 t128_mB105 0 0.00298f
Ct128eB105_4 t128_mB105 0 0.20468f
Xt128edB106 t128_XB t128_VB t128_mB106 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB106 0 0 t128_mB106 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB106_0 t128_mB106 t128_XB 0.05778f
Ct128eB106_1 t128_mB106 vdd 0.00496f
Ct128eB106_2 t128_mB106 t128_VB 0.0654f
Ct128eB106_3 t128_mB106 0 0.00298f
Ct128eB106_4 t128_mB106 0 0.20468f
Xt128edB107 t128_XB t128_VB t128_mB107 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB107 0 0 t128_mB107 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB107_0 t128_mB107 t128_XB 0.05778f
Ct128eB107_1 t128_mB107 vdd 0.00496f
Ct128eB107_2 t128_mB107 t128_VB 0.0654f
Ct128eB107_3 t128_mB107 0 0.00298f
Ct128eB107_4 t128_mB107 0 0.20468f
Xt128edB108 t128_XB t128_VB t128_mB108 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB108 0 0 t128_mB108 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB108_0 t128_mB108 t128_XB 0.05778f
Ct128eB108_1 t128_mB108 vdd 0.00496f
Ct128eB108_2 t128_mB108 t128_VB 0.0654f
Ct128eB108_3 t128_mB108 0 0.00298f
Ct128eB108_4 t128_mB108 0 0.20468f
Xt128edB109 t128_XB t128_VB t128_mB109 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB109 0 0 t128_mB109 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB109_0 t128_mB109 t128_XB 0.05778f
Ct128eB109_1 t128_mB109 vdd 0.00496f
Ct128eB109_2 t128_mB109 t128_VB 0.0654f
Ct128eB109_3 t128_mB109 0 0.00298f
Ct128eB109_4 t128_mB109 0 0.20468f
Xt128edB110 t128_XB t128_VB t128_mB110 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB110 0 0 t128_mB110 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB110_0 t128_mB110 t128_XB 0.05778f
Ct128eB110_1 t128_mB110 vdd 0.00496f
Ct128eB110_2 t128_mB110 t128_VB 0.0654f
Ct128eB110_3 t128_mB110 0 0.00298f
Ct128eB110_4 t128_mB110 0 0.20468f
Xt128edB111 t128_XB t128_VB t128_mB111 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB111 0 0 t128_mB111 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB111_0 t128_mB111 t128_XB 0.05778f
Ct128eB111_1 t128_mB111 vdd 0.00496f
Ct128eB111_2 t128_mB111 t128_VB 0.0654f
Ct128eB111_3 t128_mB111 0 0.00298f
Ct128eB111_4 t128_mB111 0 0.20468f
Xt128edB112 t128_XB t128_VB t128_mB112 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB112 0 0 t128_mB112 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB112_0 t128_mB112 t128_XB 0.05778f
Ct128eB112_1 t128_mB112 vdd 0.00496f
Ct128eB112_2 t128_mB112 t128_VB 0.0654f
Ct128eB112_3 t128_mB112 0 0.00298f
Ct128eB112_4 t128_mB112 0 0.20468f
Xt128edB113 t128_XB t128_VB t128_mB113 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB113 0 0 t128_mB113 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB113_0 t128_mB113 t128_XB 0.05778f
Ct128eB113_1 t128_mB113 vdd 0.00496f
Ct128eB113_2 t128_mB113 t128_VB 0.0654f
Ct128eB113_3 t128_mB113 0 0.00298f
Ct128eB113_4 t128_mB113 0 0.20468f
Xt128edB114 t128_XB t128_VB t128_mB114 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB114 0 0 t128_mB114 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB114_0 t128_mB114 t128_XB 0.05778f
Ct128eB114_1 t128_mB114 vdd 0.00496f
Ct128eB114_2 t128_mB114 t128_VB 0.0654f
Ct128eB114_3 t128_mB114 0 0.00298f
Ct128eB114_4 t128_mB114 0 0.20468f
Xt128edB115 t128_XB t128_VB t128_mB115 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB115 0 0 t128_mB115 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB115_0 t128_mB115 t128_XB 0.05778f
Ct128eB115_1 t128_mB115 vdd 0.00496f
Ct128eB115_2 t128_mB115 t128_VB 0.0654f
Ct128eB115_3 t128_mB115 0 0.00298f
Ct128eB115_4 t128_mB115 0 0.20468f
Xt128edB116 t128_XB t128_VB t128_mB116 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB116 0 0 t128_mB116 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB116_0 t128_mB116 t128_XB 0.05778f
Ct128eB116_1 t128_mB116 vdd 0.00496f
Ct128eB116_2 t128_mB116 t128_VB 0.0654f
Ct128eB116_3 t128_mB116 0 0.00298f
Ct128eB116_4 t128_mB116 0 0.20468f
Xt128edB117 t128_XB t128_VB t128_mB117 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB117 0 0 t128_mB117 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB117_0 t128_mB117 t128_XB 0.05778f
Ct128eB117_1 t128_mB117 vdd 0.00496f
Ct128eB117_2 t128_mB117 t128_VB 0.0654f
Ct128eB117_3 t128_mB117 0 0.00298f
Ct128eB117_4 t128_mB117 0 0.20468f
Xt128edB118 t128_XB t128_VB t128_mB118 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB118 0 0 t128_mB118 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB118_0 t128_mB118 t128_XB 0.05778f
Ct128eB118_1 t128_mB118 vdd 0.00496f
Ct128eB118_2 t128_mB118 t128_VB 0.0654f
Ct128eB118_3 t128_mB118 0 0.00298f
Ct128eB118_4 t128_mB118 0 0.20468f
Xt128edB119 t128_XB t128_VB t128_mB119 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB119 0 0 t128_mB119 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB119_0 t128_mB119 t128_XB 0.05778f
Ct128eB119_1 t128_mB119 vdd 0.00496f
Ct128eB119_2 t128_mB119 t128_VB 0.0654f
Ct128eB119_3 t128_mB119 0 0.00298f
Ct128eB119_4 t128_mB119 0 0.20468f
Xt128edB120 t128_XB t128_VB t128_mB120 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB120 0 0 t128_mB120 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB120_0 t128_mB120 t128_XB 0.05778f
Ct128eB120_1 t128_mB120 vdd 0.00496f
Ct128eB120_2 t128_mB120 t128_VB 0.0654f
Ct128eB120_3 t128_mB120 0 0.00298f
Ct128eB120_4 t128_mB120 0 0.20468f
Xt128edB121 t128_XB t128_VB t128_mB121 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB121 0 0 t128_mB121 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB121_0 t128_mB121 t128_XB 0.05778f
Ct128eB121_1 t128_mB121 vdd 0.00496f
Ct128eB121_2 t128_mB121 t128_VB 0.0654f
Ct128eB121_3 t128_mB121 0 0.00298f
Ct128eB121_4 t128_mB121 0 0.20468f
Xt128edB122 t128_XB t128_VB t128_mB122 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB122 0 0 t128_mB122 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB122_0 t128_mB122 t128_XB 0.05778f
Ct128eB122_1 t128_mB122 vdd 0.00496f
Ct128eB122_2 t128_mB122 t128_VB 0.0654f
Ct128eB122_3 t128_mB122 0 0.00298f
Ct128eB122_4 t128_mB122 0 0.20468f
Xt128edB123 t128_XB t128_VB t128_mB123 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB123 0 0 t128_mB123 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB123_0 t128_mB123 t128_XB 0.05778f
Ct128eB123_1 t128_mB123 vdd 0.00496f
Ct128eB123_2 t128_mB123 t128_VB 0.0654f
Ct128eB123_3 t128_mB123 0 0.00298f
Ct128eB123_4 t128_mB123 0 0.20468f
Xt128edB124 t128_XB t128_VB t128_mB124 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB124 0 0 t128_mB124 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB124_0 t128_mB124 t128_XB 0.05778f
Ct128eB124_1 t128_mB124 vdd 0.00496f
Ct128eB124_2 t128_mB124 t128_VB 0.0654f
Ct128eB124_3 t128_mB124 0 0.00298f
Ct128eB124_4 t128_mB124 0 0.20468f
Xt128edB125 t128_XB t128_VB t128_mB125 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB125 0 0 t128_mB125 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB125_0 t128_mB125 t128_XB 0.05778f
Ct128eB125_1 t128_mB125 vdd 0.00496f
Ct128eB125_2 t128_mB125 t128_VB 0.0654f
Ct128eB125_3 t128_mB125 0 0.00298f
Ct128eB125_4 t128_mB125 0 0.20468f
Xt128edB126 t128_XB t128_VB t128_mB126 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
Xt128esB126 0 0 t128_mB126 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
Ct128eB126_0 t128_mB126 t128_XB 0.05778f
Ct128eB126_1 t128_mB126 vdd 0.00496f
Ct128eB126_2 t128_mB126 t128_VB 0.0654f
Ct128eB126_3 t128_mB126 0 0.00298f
Ct128eB126_4 t128_mB126 0 0.20468f

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
CmceA0_0 mc_mA0 vdd 0.00298f
CmceA0_1 mc_mA0 mc_XA 0.05981f
CmceA0_2 mc_mA0 vdd 0.00496f
CmceA0_3 mc_mA0 mc_VB 0.07228f
CmceA0_4 mc_mA0 0 0.19922f
XmcedB0 mc_XB mc_VB mc_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
XmcesB0 0 0 mc_mB0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15 sa=0.3 sb=0.3
CmceB0_0 mc_mB0 mc_XB 0.05778f
CmceB0_1 mc_mB0 vdd 0.00496f
CmceB0_2 mc_mB0 mc_VB 0.0654f
CmceB0_3 mc_mB0 0 0.00298f
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
save v(n1_oa) v(n1_ob) v(n32_oa) v(n32_ob) v(n64_oa) v(n64_ob) v(n128_oa) v(n128_ob) v(t1_oa) v(t1_ob) v(t64_oa) v(t64_ob) v(t128_oa) v(t128_ob) v(mc_oa) v(mc_ob) v(wi_oa) v(wi_ob) v(wc_oa) v(wc_ob)
tran 10n 120u
meas tran n1_oa when v(n1_oa)=0.9 rise=1
echo MD ff 85 n1_oa $&n1_oa
meas tran n1_ob when v(n1_ob)=0.9 rise=1
echo MD ff 85 n1_ob $&n1_ob
meas tran n32_oa when v(n32_oa)=0.9 rise=1
echo MD ff 85 n32_oa $&n32_oa
meas tran n32_ob when v(n32_ob)=0.9 rise=1
echo MD ff 85 n32_ob $&n32_ob
meas tran n64_oa when v(n64_oa)=0.9 rise=1
echo MD ff 85 n64_oa $&n64_oa
meas tran n64_ob when v(n64_ob)=0.9 rise=1
echo MD ff 85 n64_ob $&n64_ob
meas tran n128_oa when v(n128_oa)=0.9 rise=1
echo MD ff 85 n128_oa $&n128_oa
meas tran n128_ob when v(n128_ob)=0.9 rise=1
echo MD ff 85 n128_ob $&n128_ob
meas tran t1_oa when v(t1_oa)=0.9 rise=1
echo MD ff 85 t1_oa $&t1_oa
meas tran t1_ob when v(t1_ob)=0.9 rise=1
echo MD ff 85 t1_ob $&t1_ob
meas tran t64_oa when v(t64_oa)=0.9 rise=1
echo MD ff 85 t64_oa $&t64_oa
meas tran t64_ob when v(t64_ob)=0.9 rise=1
echo MD ff 85 t64_ob $&t64_ob
meas tran t128_oa when v(t128_oa)=0.9 rise=1
echo MD ff 85 t128_oa $&t128_oa
meas tran t128_ob when v(t128_ob)=0.9 rise=1
echo MD ff 85 t128_ob $&t128_ob
meas tran mc_oa when v(mc_oa)=0.9 rise=1
echo MD ff 85 mc_oa $&mc_oa
meas tran mc_ob when v(mc_ob)=0.9 rise=1
echo MD ff 85 mc_ob $&mc_ob
meas tran wi_oa when v(wi_oa)=0.9 rise=1
echo MD ff 85 wi_oa $&wi_oa
meas tran wi_ob when v(wi_ob)=0.9 rise=1
echo MD ff 85 wi_ob $&wi_ob
meas tran wc_oa when v(wc_oa)=0.9 rise=1
echo MD ff 85 wc_oa $&wc_oa
meas tran wc_ob when v(wc_ob)=0.9 rise=1
echo MD ff 85 wc_ob $&wc_ob
quit
.endc
.end
