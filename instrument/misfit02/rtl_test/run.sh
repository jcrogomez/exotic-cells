#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Runs the MISFIT-02 cocotb module on the instrument's RTL (same sources and Makefile as instrument/test).
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
docker run --rm -v "$HERE/../..":/work hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/test && rm -rf sim_build && PYTHONPATH=/work/test:/work/misfit02/rtl_test make MODULE=test_misfit02 COCOTB_RESULTS_FILE=/work/misfit02/results/rtl_results.xml 2>&1 | tee /work/misfit02/results/rtl_make.txt | grep -E "PASS|FAIL|TESTS=|rror"' 2>&1 | grep -v "^\[INFO\]"
cat "$HERE/../results/counts.txt"
