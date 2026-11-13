# v3_PLAN — verificador independiente, ronda 3

Abierto: Thu Nov 12 19:38:15 EST 2026. No he abierto nada de attack_xc58, attack_xc57_59_61 ni attack_xc60_62_63.

Fuentes permitidas: PDK local (sky130A.tech, modelos ngspice, .mag/.gds de sky130_fd_pr), DATOS_PROCESO.md, verify_r1/r2 (reutilizo la
idea de la malla de volúmenes finitos de v2_calc.py), precheck_map (map.py, README), documentos públicos (NIST, skywater-pdk docs, literatura).

Método por afirmación (predicción del agente principal en el encargo; criterio allí):
- A1: sumandos con toxe, cgdo/cgso, cgbo, cj/cjsw/cjswg del modelo nfet_01v8 (bin de W=0,42 L=0,15) + hilo corto de li (areacap/perim del tech o placa paralela).
- A2: analítico (ruido de canal filtrado por el ancho de banda que cae al apagar; divisor capacitivo Cov) y Monte Carlo/integración de la
  ODE de varianza con rampa de puerta. Honestamente: el coeficiente depende del modelo; digo cuál sale y por qué.
- A3: derivada logarítmica de sqrt(kT/C)/(n kT/q) respecto de T. A4: propagación con esa dependencia.
- A5: leer NIST SP 800-90B (sección 3.1.1 / 3.1.4.3 esperadas; lo compruebo en el documento).
- B1–B3, C1–C2: volúmenes finitos 2D (sección transversal; silicio 150, óxido 1,0–1,4, poly 15–30), alturas del tech (poly a 0,3262 µm,
  espesor 0,18; li a 0,9361). B1/B2: además modelo de aleta 1D (línea de poly con pérdida al sustrato a través del óxido de campo).
- D1: neutralidad n + ... = N_D^+ con g=2, E_D=45 meV, N_C(T)=2,8e19 (T/300)^1,5. Nota sobre Mott (3,7e18) y banda de impurezas.
- D2: literatura (búsqueda web).
- E1: Biot–Savart cinta finita espesor 0,36 µm, ancho 5 µm, base a 1,3761 µm.
- F1: lectura de sky130A.tech. F2: ngspice en hpretl/iic-osic-tools si arranca; si no, bins del modelo. F3: web.
- G1: gdstk + precheck en contenedor tt-precheck-local, REPORTS_PATH en mi carpeta. G2: Richardson A*=112 A/cm²K² (n-Si), con y sin
  fuerza imagen. G3: parseo de .mag/.gds. G4: web skywater-pdk.readthedocs.io.
