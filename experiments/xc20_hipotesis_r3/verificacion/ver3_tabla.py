#!/usr/bin/env python3
"""Tabla markdown de todas las filas a partir de ver3_log_*.txt (uno por proceso; los ver3_R_*.txt pueden llevar líneas
intercaladas de dos procesos con la misma etiqueta). La última aparición de cada fila gana.
Uso: ver3_tabla.py > ver3_tabla.md"""
import glob, re

rows = {}
order = []
for f in sorted(glob.glob('ver3_log_*.txt')):
    cur = None
    tag = ''
    for ln in open(f):
        h = re.match(r'^# \S+ \S+ \S+ (\S+) (\S+) ntr=', ln)
        if h:
            tag = h[2]
            continue
        m = re.match(r'^(W\S+) (C\S+) (\S+) (\S+)\s+I\(M\)>=([-\d.]+)±([\d.]+) acc=([\d.]+) \| I\(tun\)>=([-\d.]+)±([\d.]+)', ln)
        if m:
            key = (m[1], m[2], m[3], m[4], tag)
            cur = dict(IM=f"{float(m[5]):.4f}±{float(m[6]):.4f}", acc=m[7], IT=f"{float(m[8]):.4f}")
            mm = re.search(r'I\(F/tun(?:res| excl)\)>=([-\d.]+)', ln); cur['IF'] = mm[1] if mm else ''
            mm = re.search(r'I\(sF\)>=([-\d.]+)', ln); cur['IsF'] = mm[1] if mm else ''
            mm = re.search(r'I\(sR\)>=([-\d.]+)', ln); cur['IsR'] = mm[1] if mm else ''
            if key not in rows:
                order.append(key)
            rows[key] = cur
            continue
        if cur is None:
            continue
        m = re.search(r'I\(Kbin\|tun\)>=([-\d.]+)±([\d.]+).*?= ([\d.]+)/([\d.]+)/([\d.]+) \(cobertura ([\d.]+)\); central: ([\d.]+)/([\d.]+)/([\d.]+)', ln)
        if m:
            cur['IK'] = f"{float(m[1]):.4f}±{float(m[2]):.4f}"
            cur['fr'] = f"{m[3]}/{m[4]}/{m[5]}"; cur['cov'] = m[6]; cur['cfr'] = f"{m[7]}/{m[8]}/{m[9]}"
            mm = re.search(r'I\(qbin\|tun\)>=([-\d.]+)', ln); cur['Iq'] = mm[1] if mm else '—'
        m = re.search(r'd\.t\. posterior media ([\d.]+)', ln)
        if m:
            cur['sdB'] = m[1]

print("| variante | calib | lector | diseño | etiqueta | I(M;Y) | acierto | I(túnel;Y) | I(F/túnel) | I(s_F) | I(Kbin\\|túnel) | K est/acot/nada (HPD) | K central | cobertura | I(qbin\\|túnel) | d.t. log10 B |")
print("|" + "---|" * 16)
for k in order:
    r = rows[k]
    print(f"| {k[0]} | {k[1]} | {k[2]} | {k[3]} | {k[4]} | {r['IM']} | {r['acc']} | {r['IT']} | {r.get('IF','')} | {r.get('IsF','')} | "
          f"{r.get('IK','—')} | {r.get('fr','—')} | {r.get('cfr','—')} | {r.get('cov','—')} | {r.get('Iq','—')} | {r.get('sdB','—')} |")
