#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""MISFIT-04: wrapper xc19_slot_w del macro xc19_slot_core, sin tocar el macro. Sube cada pin de señal con una pila
li -> m1 -> m2 -> m3 en el sitio que encontró plan.py, y una pista de m3 vertical hasta Y_TOP. Arriba deja un via2 y un tramo de m2
que entra en el pin del núcleo. VDD y GND llegan por pila hasta un pad de m4. CALA y CALB quedan atados a GND con m1, como en el
contrato. DUMMYB es la pista espejo de SA2B en el lado B (S2 de B no tiene línea); el tile la ata a VPWR, el reposo de SA2B.
Coordenadas: las del macro, en um. Uso: gen_wrap.py [variante] > xc19_slot_w.tcl
Variantes de sabotaje de MISFIT-04 (prerregistro §6), solo para la campaña I5; el wrapper sano es sin argumento:
  S3  falta el tramo de m2 que entra en el pin SA1B del núcleo (la pista de m3 sigue)
  S4  XA_OUT y XB_OUT cruzados: XA sube a y = 7 y cruza en m2 hasta la columna de XB; XB baja a m1 en y = 5,5, cruza y sube por
      una columna desplazada (x = -10,0) hasta y = 8,5, donde vuelve a la columna de XA"""
import json, sys
V = sys.argv[1] if len(sys.argv) > 1 else "ok"
P = json.load(open("plan.json"))
TRACK = {"XA_OUT": -9.225, "SA2B": -7.175, "SA1B": -5.775, "REFA": -5.075, "SA0B": -4.375, "C1": 3.335, "VBIAS": 5.735,
         "DUTA": 19.16, "PREA": 20.05, "DUTB": 22.16, "PREB": 23.05, "SB0B": 35.375, "REFB": 36.075, "SB1B": 36.775, "XB_OUT": 40.225}
Y_TOP, Y_PIN = 14.0, 15.4      # pista de m3 hasta Y_TOP; m2 hasta Y_PIN (dentro del pin del núcleo, 0,875-1,875 um sobre su borde)
L = []
r = lambda lay, x0, y0, x1, y1: L.append(f"box {min(x0,x1):.3f}um {min(y0,y1):.3f}um {max(x0,x1):.3f}um {max(y0,y1):.3f}um ; paint {lay}")
def sq(lay, cx, cy, h): r(lay, cx - h, cy - h, cx + h, cy + h)
def pin(name, lay, x0, y0, x1, y1):
    L.append(f"box {x0:.3f}um {y0:.3f}um {x1:.3f}um {y1:.3f}um ; label {name} FreeSans 20 0 0 0 c {lay} ; port make")
L += ["drc off", "addpath ../xc19_slot_core", "addpath ../xc19_bias", "cellname create xc19_slot_w", "load xc19_slot_w",
      "box 0um 0um 0um 0um", "getcell xc19_slot_core child 0 0"]
def stack_li_m3(cx, cy):
    sq("viali", cx, cy, 0.085); sq("metal1", cx, cy, 0.18); sq("via1", cx, cy, 0.13); r("metal2", cx - 0.18, cy - 0.23, cx + 0.18, cy + 0.23)
    sq("via2", cx, cy, 0.14); sq("metal3", cx, cy, 0.18)
def top(x, name):
    r("metal3", x - 0.18, Y_TOP - 0.45, x + 0.18, Y_TOP + 0.20)
    r("via2", x - 0.14, Y_TOP - 0.28, x + 0.14, Y_TOP)
    r("metal2", x - 0.18, Y_TOP - 0.365, x + 0.18, Y_TOP + 0.085)
    r("metal2", x - 0.07, Y_TOP - 0.32, x + 0.07, Y_PIN)
    if V == "S3" and name == "SA1B":
        L.pop(); return
    if name: pin(name, "metal2", x - 0.07, Y_PIN - 0.3, x + 0.07, Y_PIN)
for n, x in TRACK.items():
    p = P[n]; cx, cy = p["cx"], p["cy"]
    for s in p.get("strips", [p.get("strip")]):
        if s: r("locali", *s)
    r("locali", *p["pad_li"])
    if len(p.get("strips", [])) == 2:     # ruta en L: rellena la muesca entre el pin y el pad
        px0, py0, px1, py1 = p["pin"]; a, b = p["pad_li"], p["strips"][0]
        gx0, gx1 = (px1, a[0]) if a[0] >= px1 else (a[2], px0)          # hueco horizontal entre pin y pad
        if gx1 > gx0: r("locali", gx0, b[3], gx1, min(py1, a[3]))
    stack_li_m3(cx, cy)
    if abs(cx - x) > 1e-6: r("metal3", min(cx - 0.18, x - 0.15), cy - 0.18, max(cx + 0.18, x + 0.15), cy + 0.18)   # tramo horizontal, alto del pad (sin muescas)
    if V == "S4" and n in ("XA_OUT", "XB_OUT"):
        continue
    r("metal3", x - 0.15, cy - 0.15, x + 0.15, Y_TOP)
    top(x, n)
if V == "S4":
    xa, xb = TRACK["XA_OUT"], TRACK["XB_OUT"]; ya, yb = P["XA_OUT"]["cy"], P["XB_OUT"]["cy"]
    r("metal3", xa - 0.15, ya - 0.15, xa + 0.15, 7.0); sq("via2", xa, 7.0, 0.14); sq("metal3", xa, 7.0, 0.18)
    r("metal2", xa - 0.20, 6.82, xb + 0.20, 7.18); sq("via2", xb, 7.0, 0.14); sq("metal3", xb, 7.0, 0.18)
    r("metal3", xb - 0.15, 7.0, xb + 0.15, Y_TOP); top(xb, "XB_OUT")          # el pin XB_OUT del núcleo recibe XA
    r("metal3", xb - 0.15, yb - 0.15, xb + 0.15, 5.5); sq("via2", xb, 5.5, 0.14); sq("metal3", xb, 5.5, 0.18)
    r("metal2", xb - 0.18, 5.27, xb + 0.18, 5.73); sq("via1", xb, 5.5, 0.13); sq("metal1", xb, 5.5, 0.18)
    xo = -10.0
    r("metal1", xo - 0.18, 5.32, xb + 0.18, 5.68); sq("via1", xo, 5.5, 0.13); r("metal2", xo - 0.18, 5.27, xo + 0.18, 5.73)
    sq("via2", xo, 5.5, 0.14); sq("metal3", xo, 5.5, 0.18); r("metal3", xo - 0.15, 5.5, xo + 0.15, 8.5)
    r("metal3", xo - 0.15, 8.35, xa + 0.15, 8.65); r("metal3", xa - 0.15, 8.35, xa + 0.15, Y_TOP); top(xa, "XA_OUT")
# CALA y CALB a GND (bus de m1 inferior, y = -3,58 a -2,68): tira de m1 desde el pin
r("metal1", 14.40, -5.68, 14.90, -3.40); r("metal1", 27.60, -5.68, 28.10, -3.40)
# DUMMYB: espejo de SA2B (eje x = 15,5) en m3, sin contacto abajo
xd = 31.0 - TRACK["SA2B"]; yd = P["SA2B"]["cy"]
r("metal3", xd - 0.18, yd - 0.18, xd + 0.18, yd + 0.18); r("metal3", xd - 0.15, yd, xd + 0.15, Y_TOP)
r("metal3", xd - 0.18, Y_TOP - 0.45, xd + 0.18, Y_TOP + 0.20); pin("DUMMYB", "metal3", xd - 0.15, Y_TOP - 0.30, xd + 0.15, Y_TOP)
# VDD: extensión de m1 sobre su pin y pila hasta m4
r("metal1", 10.20, 3.81, 10.80, 4.75); sq("via1", 10.50, 4.45, 0.13); sq("metal2", 10.50, 4.45, 0.20); sq("via2", 10.50, 4.45, 0.14)
sq("metal3", 10.50, 4.45, 0.25); sq("via3", 10.50, 4.45, 0.16); sq("metal4", 10.50, 4.45, 0.30); pin("VDD", "metal4", 10.20, 4.15, 10.80, 4.75)
# GND: via1 sobre su pin de m1, m2 vertical hasta y = 4,45 y pila hasta m4
r("metal1", 8.30, 0.60, 8.70, 1.01); sq("via1", 8.50, 0.805, 0.13); r("metal2", 8.32, 0.62, 8.68, 4.65)
sq("via2", 8.50, 4.45, 0.14); sq("metal3", 8.50, 4.45, 0.25); sq("via3", 8.50, 4.45, 0.16); sq("metal4", 8.50, 4.45, 0.30)
pin("GND", "metal4", 8.20, 4.15, 8.80, 4.75)
L += ["select top cell", "drc style drc(full)", "drc on", "drc check", "drc catchup", "set rules {}",
      'foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ [lrange $boxes 0 3]" }',
      'puts "DRC xc19_slot_w violations=[llength $rules]"', 'foreach x $rules { puts "   $x" }', "drc off",
      "save xc19_slot_w", "gds write xc19_slot_w.gds", "extract all", "ext2spice lvs", "ext2spice -o xc19_slot_w.lvs.spice",
      'select top cell ; puts "BBOX [box values]"', "quit -noprompt"]
print("\n".join(L))
