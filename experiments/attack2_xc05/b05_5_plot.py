"""b05 (5): dibuja los transitorios de peor caso de V(A) desde b05_5_sp/t2_trazas.dat y t4_trazas.dat (wrdata de ngspice)."""
import numpy as np, matplotlib; matplotlib.use('Agg'); import matplotlib.pyplot as plt, os
W=os.path.join(os.path.dirname(os.path.abspath(__file__)),'b05_5_sp')
fig,ax=plt.subplots(1,3,figsize=(15,4))
for k,(f,t0,win) in enumerate((('t2_trazas.dat',2e-6,(-5e-9,60e-9)),('t4_trazas.dat',2e-6,(-5e-9,80e-9)),('t4_trazas.dat',12e-6,(-5e-9,80e-9)))):
    names=open(os.path.join(W,f)).readline().split(); d=np.loadtxt(os.path.join(W,f),skiprows=1)
    t=d[:,0]-t0; m=(t>win[0])&(t<win[1])
    for i,n in enumerate(names[1:],1): ax[k].plot(t[m]*1e9,d[m,i]*1e3,label=n)
    ax[k].axhline(50,color='k',ls=':'); ax[k].axhline(-50,color='k',ls=':'); ax[k].axhline(100,color='r',ls=':')
    ax[k].set_xlabel('t [ns]'); ax[k].set_ylabel('V(A) [mV]'); ax[k].legend(fontsize=6)
ax[0].set_title('Salto del dispositivo 100 Ohm <-> abierto en 1 ns'); ax[1].set_title('Cambio de rango: se conecta el camino BAJO'); ax[2].set_title('Cambio de rango: se desconecta')
plt.tight_layout(); plt.savefig(os.path.join(os.path.dirname(W),'b05_5_transitorios.png'),dpi=110)
