* NGSPICE file created from sky130_fd_sc_hd__inv_1.ext - technology: sky130A

.subckt sky130_fd_sc_hd__inv_1_lod A VGND VNB VPB VPWR Y
X0 Y A VGND VNB sky130_fd_pr__nfet_01v8 ad=0.169 pd=1.82 as=0.169 ps=1.82 w=0.65 l=0.15 sa=0.26 sb=0.26
X1 Y A VPWR VPB sky130_fd_pr__pfet_01v8_hvt ad=0.26 pd=2.52 as=0.26 ps=2.52 w=1 l=0.15 sa=0.26 sb=0.26
.ends

* NGSPICE file created from sky130_fd_sc_hd__inv_2.ext - technology: sky130A

.subckt sky130_fd_sc_hd__inv_2_lod A VGND VNB VPB VPWR Y
X0 Y A VPWR VPB sky130_fd_pr__pfet_01v8_hvt ad=0.135 pd=1.27 as=0.26 ps=2.52 w=1 l=0.15 sa=0.68 sb=0.26
X1 VGND A Y VNB sky130_fd_pr__nfet_01v8 ad=0.169 pd=1.82 as=0.08775 ps=0.92 w=0.65 l=0.15 sa=0.68 sb=0.26
X2 Y A VGND VNB sky130_fd_pr__nfet_01v8 ad=0.08775 pd=0.92 as=0.169 ps=1.82 w=0.65 l=0.15 sa=0.26 sb=0.68
X3 VPWR A Y VPB sky130_fd_pr__pfet_01v8_hvt ad=0.26 pd=2.52 as=0.135 ps=1.27 w=1 l=0.15 sa=0.26 sb=0.68
.ends

* NGSPICE file created from sky130_fd_sc_hd__nand2_1.ext - technology: sky130A

.subckt sky130_fd_sc_hd__nand2_1_lod A B VGND VNB VPB VPWR Y
X0 VPWR A Y VPB sky130_fd_pr__pfet_01v8_hvt ad=0.26 pd=2.52 as=0.135 ps=1.27 w=1 l=0.15 sa=0.68 sb=0.26
X1 Y A a_113_47# VNB sky130_fd_pr__nfet_01v8 ad=0.169 pd=1.82 as=0.08775 ps=0.92 w=0.65 l=0.15 sa=0.68 sb=0.26
X2 a_113_47# B VGND VNB sky130_fd_pr__nfet_01v8 ad=0.08775 pd=0.92 as=0.169 ps=1.82 w=0.65 l=0.15 sa=0.26 sb=0.68
X3 Y B VPWR VPB sky130_fd_pr__pfet_01v8_hvt ad=0.135 pd=1.27 as=0.26 ps=2.52 w=1 l=0.15 sa=0.26 sb=0.68
.ends

* NGSPICE file created from sky130_fd_sc_hd__nor2_1.ext - technology: sky130A

.subckt sky130_fd_sc_hd__nor2_1_lod A B VGND VNB VPB VPWR Y
X0 VPWR A a_109_297# VPB sky130_fd_pr__pfet_01v8_hvt ad=0.26 pd=2.52 as=0.105 ps=1.21 w=1 l=0.15 sa=0.62 sb=0.26
X1 VGND A Y VNB sky130_fd_pr__nfet_01v8 ad=0.169 pd=1.82 as=0.08775 ps=0.92 w=0.65 l=0.15 sa=0.68 sb=0.26
X2 a_109_297# B Y VPB sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.26 ps=2.52 w=1 l=0.15 sa=0.26 sb=0.62
X3 Y B VGND VNB sky130_fd_pr__nfet_01v8 ad=0.08775 pd=0.92 as=0.169 ps=1.82 w=0.65 l=0.15 sa=0.26 sb=0.68
.ends

