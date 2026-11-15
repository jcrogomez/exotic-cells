* Caso mínimo del cambio de bin entre «sin modo» y ngbehavior=hsa (auditoría HSA, §3 de AUDITORIA_HSA_2026-11-13.md)
* Escrito 2026-11-15 a partir de original/minimos/{dev.sp,bin.sp,bin4.sp}. tt, 27 °C.
*   p5s  pfet_01v8_hvt 0,42/0,5 con sa=sb=0,3  -> cambia (auditoría: -7,957 mV, +12 % de corriente)
*   p5   la misma sin sa/sb (control)           -> no cambia
*   n15s nfet_01v8 0,42/0,15 con sa=sb=0,3 (DUT de XC-19, control) -> no cambia
*   n1s  nfet_01v8 1/1 con sa=sb=0,3            -> cambia (auditoría: +1,8 a +2,2 mV)
*   p18  pfet_01v8_hvt 0,42/0,18 sin sa/sb       -> cambia (núcleo discontinuo; auditoría: -17,7 mV)
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vgn gn 0 0.9
Vdn dn 0 0.05
Vdd dd 0 1.8
Vgp gp 0 0.9
Vdp dp 0 1.75
Xn15s dn gn 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
Xn1s  dn gn 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1 sa=0.3 sb=0.3
Xp5s  dp gp dd dd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5 sa=0.3 sb=0.3
Xp5   dp gp dd dd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xp18  dp gp dd dd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18
.control
op
echo MINVTH $&@m.xn15s.msky130_fd_pr__nfet_01v8[vth] $&@m.xn1s.msky130_fd_pr__nfet_01v8[vth] $&@m.xp5s.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xp5.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xp18.msky130_fd_pr__pfet_01v8_hvt[vth]
echo MINID $&@m.xn15s.msky130_fd_pr__nfet_01v8[id] $&@m.xn1s.msky130_fd_pr__nfet_01v8[id] $&@m.xp5s.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xp5.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xp18.msky130_fd_pr__pfet_01v8_hvt[id]
quit
.endc
.end
