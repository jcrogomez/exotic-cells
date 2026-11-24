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
