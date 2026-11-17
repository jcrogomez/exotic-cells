#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Runs the cocotb suite (Icarus Verilog) and a synthesis sanity check (Yosys) in the hpretl/iic-osic-tools:2025.07 image.
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
docker run --rm -v "$HERE/..":/work hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/test && rm -rf sim_build results.xml && make 2>&1 | tee make.txt | grep -E "PASS|FAIL|TESTS=|rror" ;
  cd /work && yosys -q -p "read_verilog -lib test/slot_blackbox.v; read_verilog rtl/misfit_core.v rtl/tt_um_misfit.v; synth -top tt_um_misfit; tee -o test/synth_stat.txt stat" > test/yosys.txt 2>&1 || echo YOSYS FAILED
  grep -E "Number of cells|\\\$_.*DFF|Number of wire bits" test/synth_stat.txt | head -20' 2>&1 | grep -v "^\[INFO\]"
