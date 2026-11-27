drc off
gds read reader2_slot.gds
load reader2_slot
select top cell
flatten r2flat
load r2flat
select top cell
extract all
ext2spice lvs
ext2spice -o r2flat.dev.spice
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o r2flat.pex.spice
quit -noprompt
