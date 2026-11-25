#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# MISFIT-08: cocotb suite on the lean core, then cycle-by-cycle equivalence (lean and mutant) against rtl/misfit_core.v.
# Limit from the pre-registration: 20 min per step, with the timeout inside the container.
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
docker run --rm -e CYC="${CYC:-2000000}" -v "$HERE/..":/work hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/misfit08 && rm -rf cocotb && mkdir cocotb && cp ../test/test_misfit.py cocotb/ &&
  printf "SIM ?= icarus\nTOPLEVEL_LANG ?= verilog\nVERILOG_SOURCES = /work/models/misfit_cell_slot.v /work/misfit08/misfit_core.v /work/rtl/tt_um_misfit.v\nTOPLEVEL = tt_um_misfit\nMODULE = test_misfit\nCOCOTB_HDL_TIMEUNIT = 1ns\nCOCOTB_HDL_TIMEPRECISION = 1ps\ninclude \$(shell cocotb-config --makefiles)/Makefile.sim\n" > cocotb/Makefile &&
  (cd cocotb && timeout 1200 make > ../cocotb.txt 2>&1; grep -E "TESTS=|FAIL" ../cocotb.txt | tail -3)
  for v in lean mut; do
    iverilog -g2012 -o eq_$v.vvp eq_tb.v ../rtl/misfit_core.v eq_$v.v || exit 1
    for s in 1 2 3 4 5; do echo "$v $(timeout 1200 vvp -n eq_$v.vvp +seed=$s +cycles=$CYC | grep -E "^EQ|MISMATCH" | tail -1)"; done
  done > eq.txt; cat eq.txt
  yosys -q -p "read_verilog misfit_core.v; synth -top misfit_core; tee -o synth_lean.txt stat" > /dev/null 2>&1
  yosys -q -p "read_verilog ../rtl/misfit_core.v; synth -top misfit_core; tee -o synth_ref.txt stat" > /dev/null 2>&1
  for f in synth_ref.txt synth_lean.txt; do echo "$f $(grep -E "Number of cells" $f | tail -1) dff: $(grep -E "DFF" $f | awk "{s+=\$2} END {print s}")"; done' 2>&1 | grep -v "^\[INFO\]"
