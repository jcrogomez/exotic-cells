#!/bin/sh
# Functional test of reader2_slot (Icarus Verilog). Writes test.txt (must end in FAILS 0) and mutant.txt (must not).
cd "$(dirname "$0")"; T=$(mktemp -d)
iverilog -g2012 -o $T/a.vvp tb_reader2_slot.v reader2_slot.v reader2_loop_model.v && vvp $T/a.vvp > test.txt
iverilog -g2012 -DMUT -o $T/m.vvp tb_reader2_slot.v reader2_slot.v reader2_loop_model.v && vvp $T/m.vvp > mutant.txt
grep -c PASS test.txt; tail -2 test.txt | head -1; grep FAIL mutant.txt
