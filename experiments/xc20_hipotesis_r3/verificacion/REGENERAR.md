# Cómo regenerar los volcados del verificador (ronda 3)

Los `ver3_lt_*.npz` y `ver3_mundo_*.npz` (3,4 GB) no se versionan (`.gitignore`). Se regeneran con estos comandos, desde esta
carpeta y con el Python del proyecto. Los parámetros salen de la cabecera de cada `ver3_log_*.txt` y de los valores por
defecto de `ver3_correr.py` (l. 96–101): entrenamiento con el mundo de semilla `1000 + V3_SEED`, prueba con el mundo de
semilla `V3_TESTSEED` = 2000, red H = 128, 8 épocas. Las filas se dan como `CALIB:LECTOR:DISEÑO`.

Escrito el 2026-11-16 a partir de las cabeceras de los logs, no de un historial de shell, y **sin volver a correrlo**: si una
corrida no reproduce su fila del `ver3_R_*.txt` dentro de su error, la lista está mal, no el log. Ojo: `ver3_correr.py` añade
líneas a `ver3_R_<VAR>_<ETIQUETA>.txt` en vez de sobrescribirlo; para comprobar, correr en una copia de la carpeta.

```sh
PY=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/.venv/bin/python3

# Base (log: ver3_log_W0_base.txt, ver3_log_W1_A2.txt, ver3_log_W1_S10.txt, ver3_log_W2.txt, ver3_log_W1K6.txt, W1q1, W1q1cut)
$PY ver3_correr.py W0 base C1:A:E1 C1:A2:E1 C1:X:E1
$PY ver3_correr.py W1 base C3b:A2:E1 C3b:A2:E2 C3b:A2:E2sin27 C3b:A2:E3 C3b:A2:E4 C3b:A2:E5 C3b:A2:E6 C3b:A2:E6c
$PY ver3_correr.py W1 base C3b:S10:E1 C3b:S10:E2 C3b:S10:E3 C3b:S10:E4 C3b:S10:E5 C3b:S10:E6 C3b:S10:E6c
$PY ver3_correr.py W2 base C3b:A2:E1 C3b:A2:E2 C3b:A2:E3 C3b:A2:E4 C3b:A2:E6 C3b:A2:E6c \
                          C3b:S10:E1 C3b:S10:E2 C3b:S10:E3 C3b:S10:E4 C3b:S10:E6 C3b:S10:E6c
$PY ver3_correr.py W1K6 base C3b:A:E1 C3b:A:E4 C3b:A2:E1 C3b:A2:E4 C3b:S10:E1 C3b:S10:E4 C3b:X:E1 C3b:X:E4
$PY ver3_correr.py W1q1 base C3b:A2:E2 C3b:A2:E3 C3b:A2:E4 C3b:A2:E6 C3b:S10:E2 C3b:S10:E4 C3b:S10:E6
$PY ver3_correr.py W1q1cut base C3b:A2:E2 C3b:A2:E4 C3b:S10:E4

# Lectores y calibraciones (ver3_log_W1_unicos.txt, ver3_log_W2_unicos.txt, ver3_log_W1_calib.txt, ver3_log_W1_calib2.txt)
$PY ver3_correr.py W1 unicos C3b:A:E1 C3b:A:E2 C3b:A:E4 C3b:S1:E1 C3b:S1:E2 C3b:S1:E4 \
                             C3b:S100:E1 C3b:S100:E2 C3b:S100:E4 C3b:X:E1 C3b:X:E2 C3b:X:E4
$PY ver3_correr.py W2 unicos C3b:A:E1 C3b:A:E4 C3b:S1:E4 C3b:S100:E4 C3b:X:E1 C3b:X:E4
$PY ver3_correr.py W1 calib C1:A2:E1 C1:A2:E2 C1:A2:E4 C1:S10:E1 C1:S10:E2 C1:S10:E4 \
                            C3a:A2:E1 C3a:A2:E2 C3a:A2:E4 C3a:S10:E1 C3a:S10:E2 C3a:S10:E4 \
                            C3c:A2:E1 C3c:A2:E2 C3c:A2:E4 C3c:S10:E1 C3c:S10:E2 C3c:S10:E4
$PY ver3_correr.py W1 calib C1:A:E1 C1:A:E4 C1:X:E1 C1:X:E4

# Controles de holgura (ver3_log_W1_h256.txt, _n2, _s2, _soloM, _soloK)
CTRL="C3b:A2:E2 C3b:A2:E4 C3b:S10:E2 C3b:S10:E4"
V3_H=256        $PY ver3_correr.py W1 h256  $CTRL
V3_NTR=600000   $PY ver3_correr.py W1 n2    $CTRL
V3_SEED=2       $PY ver3_correr.py W1 s2    $CTRL
V3_SOLO=M       $PY ver3_correr.py W1 soloM $CTRL
V3_SOLO=K       $PY ver3_correr.py W1 soloK $CTRL

# Tablas derivadas
$PY ver3_control.py > ver3_control.txt
$PY ver3_pares.py   > ver3_pares.txt
$PY ver3_tabla.py   > ver3_tabla.md
$PY ../incremento_separaciones.py > ../incremento_separaciones_salida.txt
```

«W2 unicos» usa los valores por defecto para 8 clases (150 000 / 40 000 por clase). Tiempo total aproximado según
los logs: unos 45 min de reloj en paralelo (de 19:35 a 20:24 del 2026-11-15).

Fuera de esta lista: `ver3_humo/` (humo, sí versionado).
