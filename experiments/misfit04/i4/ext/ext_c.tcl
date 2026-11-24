drc off
gds read tt_um_misfit04.gds
load tt_um_misfit04
select top cell
extract do capacitance
extract do coupling
extract all
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o tile_hier.pex.spice
flatten tt_flat
load tt_flat
select top cell
extract do capacitance
extract do coupling
extract all
ext2spice hierarchy off
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o tile_flat.pex.spice
quit -noprompt
