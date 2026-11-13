"""a20_butting_hd (variante rapida: solo hd, hvl y pr; la completa a20_butting.py tarda > 20 min en io y sram): busca en los .mag de las bibliotecas del PDK tomas (nsubdiff/psubdiff) que TOQUEN difusion del tipo
contrario (pdiff/ndiff) en la misma isla: uniones p+/n+ pegadas ya presentes en celdas de fundicion.
Uso: python a20_butting.py > a20_butting.txt"""
import glob, os, re, subprocess, collections
P = os.environ["SKY130A"] + "/libs.ref"
print(subprocess.check_output(["date"]).decode().strip())
PAIRS = [({"nsubdiff", "nsubdiffcont", "mvnsubdiff", "mvnsubdiffcont"}, {"pdiff", "pdiffc", "mvpdiff", "mvpdiffc", "pdiode", "pdiodec"}),
         ({"psubdiff", "psubdiffcont", "mvpsubdiff", "mvpsubdiffcont"}, {"ndiff", "ndiffc", "mvndiff", "mvndiffc", "ndiode", "ndiodec"})]
def rects(f):
    lay = None; R = collections.defaultdict(list)
    for line in open(f, errors="ignore"):
        if line.startswith("<<"):
            lay = line.strip("<> \n")
        elif line.startswith("rect ") and lay:
            R[lay].append(tuple(int(v) for v in line.split()[1:5]))
    return R
def touch(a, b):
    # comparten un tramo de borde (no solo esquina) o se solapan
    ox = min(a[2], b[2]) - max(a[0], b[0]); oy = min(a[3], b[3]) - max(a[1], b[1])
    return (ox == 0 and oy > 0) or (oy == 0 and ox > 0) or (ox > 0 and oy > 0)
for lib in ("sky130_fd_sc_hd", "sky130_fd_sc_hvl", "sky130_fd_pr"):
    files = sorted(glob.glob(os.path.join(P, lib, "mag", "*.mag")))
    hits = []
    for f in files:
        R = rects(f); n = 0
        for taps, diffs in PAIRS:
            tr = [r for l in taps for r in R.get(l, [])]; dr = [r for l in diffs for r in R.get(l, [])]
            n += sum(1 for a in tr for b in dr if touch(a, b))
        if n: hits.append((os.path.basename(f), n))
    print("%-22s celdas .mag: %5d ; con toma pegada a difusion contraria: %4d" % (lib, len(files), len(hits)))
    for h in hits[:12]: print("     %s  (%d contactos de borde)" % h)
