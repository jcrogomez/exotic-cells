* MISFIT-03 etapa a · enmienda 2 ruido src=11 k=1.0 · esquina tt 27 C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
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

In0XA n0_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In0XB n0_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
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

In1XA n1_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In1XB n1_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
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

In2XA n2_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In2XB n2_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
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

In3XA n3_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In3XB n3_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
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

In4XA n4_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In4XB n4_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
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

In5XA n5_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In5XB n5_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
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

In6XA n6_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In6XB n6_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
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

In7XA n7_XA 0 dc 0 trnoise(2.6311e-10 1.0e-08 0 0)
In7XB n7_XB 0 dc 0 trnoise(2.6312e-10 1.0e-08 0 0)
.control
set noaskquit
setseed 42
save v(n0_oa) v(n0_ob) v(n1_oa) v(n1_ob) v(n2_oa) v(n2_ob) v(n3_oa) v(n3_ob) v(n4_oa) v(n4_ob) v(n5_oa) v(n5_ob) v(n6_oa) v(n6_ob) v(n7_oa) v(n7_ob)
let l = 0
while l < 8
  reset
  tran 10n 3.5818e-05 0 10n
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
