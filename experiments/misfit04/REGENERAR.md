# MISFIT-04 · qué no está en git y cómo se regenera

No se versionan y no se borran sin preguntar. Se regeneran así:

| Salida | Comando |
|---|---|
| `instrument/misfit04/tile/build/` | `gen_assemble.py` y `lvs.sh build` (ver la cabecera de cada script) |
| `i5/build_*/` | `i5/campana.sh <variante...>` |
| `i3/i3.vcd`, `i5/medida_*/i3.vcd`, `*.vvp` | iverilog sobre `tb_i3.v` / `tb_i2.v` en cada carpeta |
| `i4/ext/**/*.spice`, `*.ext` | `magic` con `i4/ext/ext_c.tcl` |
| `i4/corridas/**/i4.log` | `gen_i4.py` y ngspice con `tools/ngspice_pdk.sh` por carpeta |
- `i4/ext/**/*.gds`: copia del GDS del tile (sano, S7, S8), de `gen_assemble.py`
| `e2/build_S7L*/`, `e2/ext_S7L*/` (enmienda 3, E2) | `gen_assemble.py` con la variante `S7L4.0` / `S7L8.0`, y la extracción plana de `i4/ext/ext_c.tcl`; `e2/caps_e2.py` lee de ahí los acoplos (`caps_e2.txt` sí está en git) |
| `e3/<variante>/` salvo `lvs.rpt` (enmienda 3, E3) | `e3/e3.sh` |
| `i4/corridas/p4_*`, `p5*/i4.log` (E1 y E2) | cada `i4.sp` está en git; ngspice con `tools/ngspice_pdk.sh` por carpeta (los `corre_p4.sh`, `corre_p5*.sh` dicen qué deck y con qué predicción). Los decks p5 salen de `gen_i4.py 5 p1.txt` con las variables `PREF`, `SOLO`, `SOLO_CONTROL`, `CHUNK`, `TMAX`, `ITL4` y `CARGA` |
