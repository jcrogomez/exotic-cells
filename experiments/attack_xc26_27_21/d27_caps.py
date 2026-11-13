"""d27_caps.py — combina d27_rcwa.json (R(theta) de cada tapa) con d26_fd2.json (peso de cada banda del cono de escape en la
recogida del fotodiodo) y da el cambio de fotocorriente ÓPTICA entre tapas, para d = 5, 10, 20 um.

F(tapa) ∝ S_dir + S_tir + sum_k R_tapa(theta_k) * S_cone[k].
Cota de redistribución: los órdenes no especulares vuelven al Si dentro del mismo cono pero en otra dirección; el peor caso
manda toda la potencia no especular a la banda de mayor peso por estereorradián. Se da ese máximo.
Salida: d27_caps.txt
"""
import numpy as np, json
rc = json.load(open('d27_rcwa.json')); fd = json.load(open('d26_fd2.json'))
TH = np.array([0.5, 5, 10, 15, 20, 23.5]); THC = np.degrees(np.arcsin(1.45/3.54))
edges = np.linspace(0, THC, 13); cen = (edges[:-1]+edges[1:])/2
sr = 2*np.pi*(np.cos(np.radians(edges[:-1]))-np.cos(np.radians(edges[1:])))
L = []
def P(*a):
    s = ' '.join(str(x) for x in a); print(s); L.append(s)
def Rcurve(cap, al='(1.2+10.5j)', tin=0):
    rows = []
    for phi in (0, 45):
        k = '%s|al=%s|tin=%d|phi=%d' % (cap, al, tin, phi)
        arr = np.array(rc[k]); rows.append(arr)
    a = np.mean(rows, axis=0)
    return np.interp(cen, TH, a[:, 0]), np.interp(cen, TH, a[:, 1])
caps = [k.split('|')[0] for k in rc if k.endswith('|al=(1.2+10.5j)|tin=0|phi=0')]
P('# cociente F(tapa)/F(sin metal) de la fotocorriente óptica; entre paréntesis la cota con redistribución en peor caso')
P('# tapa | Al 1,2+10,5i | Al 1,0+8i | Al+TiN  ->  d=5 / d=10 / d=20 (central, sin guarda)')
for cap in caps:
    out = []
    for d in (5, 10, 20):
        o = fd['%d|central|none' % d]['near']
        base = o['Sdir']+o['Stir']; Sc = np.array(o['Scone'])
        best = (Sc/sr).max()
        R0, _ = Rcurve("('none',)")
        Fnone = base + np.sum(R0*Sc)
        vals = []
        for al, tin in (('(1.2+10.5j)', 0), ('(1+8j)', 0), ('(1.2+10.5j)', 1)):
            if cap == "('none',)" and (al != '(1.2+10.5j)' or tin): vals.append('  -  '); continue
            try:
                Rt, Re = Rcurve(cap, al, tin)
            except KeyError:
                vals.append('  -  '); continue
            Fc = base + np.sum(Rt*Sc)
            Fw = base + np.sum(Re*Sc) + np.sum((Rt-Re)*sr)*best    # no especular -> dirección de mayor recogida por sr
            vals.append('%.3f(%.3f)' % (Fc/Fnone, Fw/Fnone))
        out.append(' '.join(vals))
    P(cap, '|', ' || '.join(out))
o = fd['5|central|none']['near']
P('# peso del cono en la recogida (d=5): S_cone/(S_dir+S_tir+S_cone) = %.3f' % (sum(o['Scone'])/(o['Sdir']+o['Stir']+sum(o['Scone']))))
open('d27_caps.txt', 'w').write('\n'.join(L)+'\n')
