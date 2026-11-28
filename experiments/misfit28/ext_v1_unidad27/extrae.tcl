drc off
gds read reader2_unit.gds
load reader2_unit
select top cell
flatten r2uflat
load r2uflat
select top cell
extract all
ext2spice lvs
ext2spice -o r2uflat.dev.spice
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o r2uflat.pex.spice
quit -noprompt
