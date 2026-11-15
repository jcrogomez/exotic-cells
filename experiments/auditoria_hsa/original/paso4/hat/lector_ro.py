"""PHY-02, validación del lector: oscilador en anillo de 11 inversores sky130 (tamaños de inv_1) con capacidad añadida en un nodo; frecuencia
por esquina (tt/ss/ff con temperatura y tensión) y sensibilidad relativa. Ejecutar dentro de hpretl/iic-osic-tools:2025.07:
python3 lector_ro.py > lector_ro.json"""
import subprocess, os, re, json
PDK=os.environ['PDK_ROOT']+'/sky130A/libs.tech/ngspice/sky130.lib.spice'
ESQ={'tt':(27,1.8),'ss':(100,1.6),'ff':(-40,1.95)}; CS=[0,1,2,5,10]; N=11
def red(corner,C):
    T,V=ESQ[corner]
    L=['* anillo','.lib "%s" %s'%(PDK,corner),'.temp %g'%T,'.option scale=1e-6','Vdd vdd 0 %g'%V]
    for i in range(N):
        a='n%d'%i; b='n%d'%((i+1)%N)
        L.append('XP%d %s %s vdd vdd sky130_fd_pr__pfet_01v8 w=1.0 l=0.15'%(i,b,a))
        L.append('XN%d %s %s 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15'%(i,b,a))
    L.append('Cx n0 0 %gf'%C if C>0 else '* sin carga')
    L+=['.ic v(n0)=0','.tran 2p 40n uic','.meas tran t1 when v(n3)=%g rise=6'%(V/2),'.meas tran t2 when v(n3)=%g rise=16'%(V/2),'.end']
    return '\n'.join(L)
res={}
for c in ESQ:
    for C in CS:
        open('/tmp/ro.cir','w').write(red(c,C))
        out=subprocess.run(['ngspice','-b','/tmp/ro.cir'],capture_output=True,text=True).stdout
        t1=re.search(r't1\s*=\s*([-\d.eE+]+)',out); t2=re.search(r't2\s*=\s*([-\d.eE+]+)',out)
        f=10/(float(t2.group(1))-float(t1.group(1))) if (t1 and t2) else None
        res.setdefault(c,{})[C]=f
out={c:{'f_GHz':{C:(round(f/1e9,4) if f else None) for C,f in d.items()},
        'S_por_fF':{C:(round((d[0]-f)/d[0]/C,5) if (f and d[0] and C) else None) for C,f in d.items() if C}} for c,d in res.items()}
print(json.dumps(out,indent=1))
