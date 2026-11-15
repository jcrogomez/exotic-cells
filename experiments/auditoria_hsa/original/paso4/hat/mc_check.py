"""PHY-02: comprueba que el desapareamiento local de sky130 se activa en ngspice (dos osciladores idénticos en el mismo circuito: frecuencias
iguales con mc_mm_switch=0, distintas con 1, y distintas entre semillas). Ejecutar en hpretl/iic-osic-tools:2025.07."""
import subprocess, os, re, sys
L=os.environ['PDK_ROOT']+'/sky130A/libs.tech/ngspice'
def lib(corner,mm):
    return '\n'.join(['.param mc_mm_switch=%d'%mm,'.param mc_pr_switch=0','.include "%s/corners/%s.spice"'%(L,corner),
                      '.include "%s/r+c/res_typical__cap_typical.spice"'%L,'.include "%s/r+c/res_typical__cap_typical__lin.spice"'%L,
                      '.include "%s/corners/%s/specialized_cells.spice"'%(L,corner)])
def anillo(tag,N=11,C=0):
    out=[]
    for i in range(N):
        a='%s%d'%(tag,i); b='%s%d'%(tag,(i+1)%N)
        out.append('XP%s%d %s %s vdd vdd sky130_fd_pr__pfet_01v8 w=1.0 l=0.15'%(tag,i,b,a))
        out.append('XN%s%d %s %s 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15'%(tag,i,b,a))
    if C: out.append('C%s %s0 0 %gf'%(tag,tag,C))
    return out
def corre(corner,mm,seed,T=27,V=1.8,CA=0,CB=0):
    net=['* mc',lib(corner,mm),'.temp %g'%T,'.option scale=1e-6','Vdd vdd 0 %g'%V]+anillo('a',C=CA)+anillo('b',C=CB)
    net+=['.ic v(a0)=0 v(b0)=0','.tran 2p 40n uic',
          '.meas tran ta1 when v(a3)=%g rise=6'%(V/2),'.meas tran ta2 when v(a3)=%g rise=26'%(V/2),
          '.meas tran tb1 when v(b3)=%g rise=6'%(V/2),'.meas tran tb2 when v(b3)=%g rise=26'%(V/2),'.end']
    open('/tmp/mc.cir','w').write('\n'.join(net))
    o=subprocess.run(['ngspice','-b','/tmp/mc.cir'],capture_output=True,text=True,env=dict(os.environ,SPICE_RNDSEED=str(seed))).stdout
    v={k:float(re.search(r'%s\s*=\s*([-\d.eE+]+)'%k,o).group(1)) for k in ('ta1','ta2','tb1','tb2')}
    return 20/(v['ta2']-v['ta1']),20/(v['tb2']-v['tb1'])
if __name__=='__main__':
    for mm,seed in ((0,1),(1,1),(1,2),(1,3)):
        fa,fb=corre('tt',mm,seed); print('mc_mm_switch=%d semilla %d: fA %.5f GHz, fB %.5f GHz, diferencia relativa %.3e'%(mm,seed,fa/1e9,fb/1e9,(fa-fb)/fa))
