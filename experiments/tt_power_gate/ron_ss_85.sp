* On-resistance of the switch transistor of the Tiny Tapeout 1.8 V power gates, device alone.
* Schematic level: no metal, no contacts beyond the model, gate held at 0 V. Corner ss, 85 C.
* Sizes: TinyTapeout/tt-multiplexer commit 885086c, pg/sky130/tt_pg_1v8_*/xschem/*.sch (device M3).
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice ss
.option temp=85
.param mc_mm_switch=0
.param iload=8m
V1 vdd 0 1.8
XH1 h1 0 vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1769 nf=244 m=1
IH1 h1 0 {iload}
XH2 h2 0 vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=3683 nf=508 m=1
IH2 h2 0 {iload}
XH4 h4 0 vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=8424.5 nf=1162 m=1
IH4 h4 0 {iload}
XL1 l1 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt L=0.15 W=1769 nf=244 m=1
IL1 l1 0 {iload}
XL2 l2 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt L=0.15 W=3683 nf=508 m=1
IL2 l2 0 {iload}
XL4 l4 0 vdd vdd sky130_fd_pr__pfet_01v8_hvt L=0.15 W=8424.5 nf=1162 m=1
IL4 l4 0 {iload}
.control
foreach il 1m 8m 20m
  alterparam iload = $il
  reset
  op
  echo DROP_mV corner=ss temp=85 iload=$il
  let hp_1=1e3*(v(vdd)-v(h1))
  let hp_2=1e3*(v(vdd)-v(h2))
  let hp_4=1e3*(v(vdd)-v(h4))
  let ll_1=1e3*(v(vdd)-v(l1))
  let ll_2=1e3*(v(vdd)-v(l2))
  let ll_4=1e3*(v(vdd)-v(l4))
  print hp_1 hp_2 hp_4 ll_1 ll_2 ll_4
end
.endc
.end
