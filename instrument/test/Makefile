# SPDX-License-Identifier: Apache-2.0
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES = $(PWD)/../models/misfit_cell_slot.v $(PWD)/../rtl/misfit_core.v $(PWD)/../rtl/tt_um_misfit.v
TOPLEVEL = tt_um_misfit
MODULE = test_misfit
COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps
include $(shell cocotb-config --makefiles)/Makefile.sim
