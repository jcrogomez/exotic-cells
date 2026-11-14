"""Anota con Residual (lod_annotate.py) los transistores activos de xc19_channel_caps y deja los condensadores sin anotar.

lod_annotate.py no lee dispositivos cuya fuente y drenador son el mismo nodo (limitación declarada en residual/README.md):
Magic escribe uno de sus terminales sin área ni perímetro. Aquí todos los condensadores MOS (nodo y filtro) tienen fuente =
drenador = GND. Este script:
  1. copia el .ext y el .pex.spice sin esos dispositivos (a una carpeta temporal);
  2. corre lod_annotate.py sobre el .mag completo y esas copias (las puertas de los condensadores siguen en el .mag; cada
     dispositivo activo se empareja con una sola puerta, y la herramienta exige que todos los del .ext tengan instancia);
  3. vuelve a insertar los condensadores, tal como salieron de la extracción, sin sa/sb.
Consecuencia: los condensadores se simulan con el estrés de referencia del modelo. No cambia nada de los 23 activos.
Uso: python3 annotate.py   (desde esta carpeta). Escribe xc19_channel_caps.pex.lod.spice y xc19_channel_caps_lod.inc.
"""
import os, re, subprocess, sys, tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
TOOL = os.path.join(HERE, "..", "..", "residual", "lod_annotate.py")
N = "xc19_channel_caps"


def same_node_ext(line):
    q = re.findall(r'"([^"]*)" (\d+) (\S+)', line)
    return line.startswith("device msubckt") and len(q) >= 3 and q[1][0] == q[2][0]


def same_node_spice(t):
    return t and t[0][0] in "Xx" and len(t) > 5 and "fet" in t[5] and t[1] == t[3]


ext = open(os.path.join(HERE, N + ".ext")).read().splitlines(True)
spi = open(os.path.join(HERE, N + ".pex.spice")).read().splitlines(True)
caps = [l for l in spi if same_node_spice(l.split())]
ncap_ext = sum(same_node_ext(l) for l in ext)
if len(caps) != ncap_ext:
    sys.exit(f"{len(caps)} condensadores en el netlist y {ncap_ext} en el .ext")
with tempfile.TemporaryDirectory() as d:
    e2, s2, o2 = (os.path.join(d, x) for x in ("f.ext", "f.spice", "f.lod.spice"))
    open(e2, "w").writelines(l for l in ext if not same_node_ext(l))
    open(s2, "w").writelines(l for l in spi if not same_node_spice(l.split()))
    r = subprocess.run([sys.executable, TOOL, os.path.join(HERE, N + ".mag"), e2, s2, "-o", o2],
                       capture_output=True, text=True)
    if r.returncode:
        sys.exit(r.stdout + r.stderr)
    out = open(o2).read().splitlines(True)
# reinsert the capacitors right after the .subckt line
i = next(k for k, l in enumerate(out) if l.startswith(".subckt"))
out[i + 1:i + 1] = caps
open(os.path.join(HERE, N + ".pex.lod.spice"), "w").writelines(out)
inc = [l.replace(f".subckt {N} ", f".subckt {N}_lod ", 1) for l in out]
open(os.path.join(HERE, N + "_lod.inc"), "w").writelines(inc)
print(r.stdout, end="")
print(f"{len(caps)} condensadores reinsertados sin sa/sb")
