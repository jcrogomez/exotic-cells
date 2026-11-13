# v1_PLAN — verificador independiente, ronda 1 (escrito Thu Nov 12 13:03:08 EST 2026)

No he abierto nada de attack_xc05 / attack_xc20 / attack_xc52. Fuentes: PDK local (tech de Magic, tlef hd, ngspice r+c),
`local_flow/efld_00/LEEME.md` y `05_exotic_lab/macros/constriccion/sim/efld00_lector_drivers.txt` (citado por el LEEME; fuera de las carpetas vetadas).
Código propio: `v1_calc.py` (numpy/scipy). Constantes de Si de memoria (no leídas hoy): eps_r=11,7; Eg=1,12 eV; ni=1e10; Nc=2,8e19 (alt. 3,2e19); Nv=1,04e19 (alt. 1,8e19 y 3,1e19).

## A
- A1: W = sqrt(4·eps·Vbi/(q·N)), Emax = 2·Vbi/W (unión abrupta simétrica, aprox. de vaciamiento). Vbi de dos formas: (a) Boltzmann, 2·kT·ln(N/ni); (b) Fermi–Dirac: Vbi = Eg + xi_n + xi_p, con xi = kT·F_{1/2}^{-1}(N/Nc,v) (inversión numérica de la integral de Fermi). Sin estrechamiento de banda en el valor central; lo barro (-0 a -0,1 eV) como sensibilidad.
- A2: umbral = N tal que EF = Ec (n) y EF = Ev (p): N = Nc·F_{1/2}(0) y Nv·F_{1/2}(0) (F normalizada, F(0)=0,765). Umbral simétrico = el mayor. Barro Nc, Nv. También el dopado para xi = 2kT por lado.
- A3: T ~ exp(-B/E). Décadas = B·(1/E(1e19) − 1/E(1e20))/ln10 con B = 2e7 y 4e7, E = Emax (mis valores a y b) y, como sensibilidad, E medio = Emax/2.
- A4: grep con número de línea en sky130A.tech. Siliciuro: valor de memoria, lo declaro como no leído.

## B
- B1: `height` de Magic (z base y espesor) y THICKNESS del tlef.
- B2/B3: diferencias finitas 2D propias de la sección (línea 0,14 × espesor PDK embebida en óxido, sustrato isotermo en z=0, óxido hasta ~11 µm con tapa adiabática, laterales lejanos adiabáticos). Estacionario → R térmica por longitud; transitorio implícito → tiempo al 63 % del escalón. k_ox barrida 0,8–1,4 W/m/K; rho·c óxido 1,6e6, Al 2,42e6 J/m³K. Contraste con 1D analítico (4h²/(pi²·alfa)) y cilindro sobre plano (acosh). B3 además con corrección de aleta por conducción a los extremos (k_Al 200, extremos a T sustrato) como cota inferior.
  Predicción propia antes de correr: tau 0,3–1 µs; ΔT 1–1,5 K sin extremos.
- B4: grep con línea en el tlef.
- B5: tres interpolaciones con solo los 3 puntos del LEEME (lineal en R, lineal en log R, ley de potencia del exceso f−1) y, aparte, interpolación sobre la tabla de simulación completa (5; 10; 12,9; 15 kΩ) del txt.

## C
- C1: Biot–Savart numérico, espiras cuadradas concéntricas (y circulares) con filamento en el eje de la pista; borde interior a 10 µm; w/s mínimos de met3 del PDK y w=1,5 µm; z = centro de met3 sobre z=0 de Magic. Predicción propia: 0,22–0,25 mT/mA compacta.
- C2: I/Jlím. C3: V_H = I·B/(q·n·t) en las cuatro esquinas; aparte, vía R de hoja (V_H = I·B·mu·Rs). C4: grep. C5: conteo de Poisson en dos semiperiodos, SNR = (delta/2)·sqrt(I·T/q).
