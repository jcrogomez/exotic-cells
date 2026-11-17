# SPDX-License-Identifier: Apache-2.0
"""MISFIT-02, second leg of the chain: the instrument's RTL reads the edge times that SPICE gave for the extracted time cell.

The slot model is told the SPICE times (results/cell/cell_times.txt); nothing here is co-simulated with the analog cell.
P4: for every time t and every clock phase, the count N satisfies |N*T - t - 2T| <= T.
P5: (N_B - 2)/(N_A - 2) stays between 1.88 and 2.04.
N3, N4: a stuck output and a window shorter than the cell never give a valid count."""
import os
import cocotb
from cocotb.triggers import ClockCycles
from test_misfit import (reset, slots, wr, measure, CLK_NS, ARM, DUAL, SRC_CELL, TMO, ST_DONE, ST_TMO_A, ST_TMO_B,
                         ST_STUCK_A, ST_STUCK_B, ST_ARMED)

HERE = os.path.dirname(os.path.abspath(__file__))
TIMES = os.path.join(HERE, "..", "results", "cell", "cell_times.txt")
OUT = os.path.join(HERE, "..", "results", "counts.txt")


def rows():
    for line in open(TIMES):
        f = line.split()
        if f and f[0] == "CELL":
            yield f[1], f[2], f[3], f[4], float(f[5]) * 1e9, float(f[6]) * 1e9


@cocotb.test()
async def p4_p5_counts_follow_the_extracted_times(dut):
    await reset(dut)
    s = slots(dut)[0]
    await wr(dut, TMO, 12)                                   # 4096 clocks = 81.9 us
    report = ["# level corner temp vdd | t_A t_B (ns, SPICE) | N_A N_B over 20 clock phases | worst |N*T - t - 2T| (ns) | (N_B-2)/(N_A-2) range | P5 (1.88 to 2.04)"]
    for lvl, corner, temp, vdd, ta, tb in rows():
        na, nb, worst, ratios = set(), set(), 0.0, []
        for ph in range(CLK_NS):                             # the edge moved through one clock period in 1 ns steps
            s.t_cell_a_ns.value = int(round(ta)) + ph
            s.t_cell_b_ns.value = int(round(tb)) + ph
            st, a, b = await measure(dut, 0, SRC_CELL, ctrl=ARM | DUAL)
            assert st == (ST_ARMED | ST_DONE), (lvl, corner, ph, bin(st))
            for n, t in ((a, round(ta) + ph), (b, round(tb) + ph)):
                err = abs(n * CLK_NS - t - 2 * CLK_NS)
                worst = max(worst, err)
                assert err <= CLK_NS, (lvl, corner, temp, ph, n, t)
            ratios.append((b - 2) / (a - 2))
            na.add(a); nb.add(b)
        p5 = "P5 held" if 1.88 <= min(ratios) and max(ratios) <= 2.04 else "P5 FAILED"   # recorded, not asserted: the table is the result
        report.append(f"{lvl} {corner} {temp} {vdd} | {ta:.1f} {tb:.1f} | {sorted(na)} {sorted(nb)} | {worst:.0f} | "
                      f"{min(ratios):.3f} to {max(ratios):.3f} | {p5}")
    open(OUT, "w").write("\n".join(report) + "\n")
    for line in report:
        dut._log.info(line)


@cocotb.test()
async def n3_n4_no_valid_count_from_a_stuck_or_truncated_cell(dut):
    await reset(dut)
    s = slots(dut)[0]
    lvl, corner, temp, vdd, ta, tb = next(r for r in rows() if r[0] == "c" and r[1] == "tt" and r[2] == "27" and r[3] == "1.8")
    s.t_cell_a_ns.value = int(round(ta)); s.t_cell_b_ns.value = int(round(tb))
    await wr(dut, TMO, 12)
    s.fault_a.value = 1; s.fault_b.value = 1                 # N3: stuck high
    st, a, b = await measure(dut, 0, SRC_CELL, ctrl=ARM | DUAL)
    assert st & ST_STUCK_A and st & ST_STUCK_B and a == 0 and b == 0, bin(st)
    s.fault_a.value = 2; s.fault_b.value = 2                 # N3: stuck low
    st, a, b = await measure(dut, 0, SRC_CELL, ctrl=ARM | DUAL)
    assert st & ST_TMO_A and st & ST_TMO_B and a == 0 and b == 0, bin(st)
    s.fault_a.value = 0; s.fault_b.value = 0
    await wr(dut, TMO, 5)                                    # N4: 32 clocks = 640 ns: A fits, B does not
    st, a, b = await measure(dut, 0, SRC_CELL, ctrl=ARM | DUAL)
    assert not st & ST_TMO_A and a > 0 and st & ST_TMO_B and b == 0, (bin(st), a, b)
    await wr(dut, TMO, 4)                                    # 16 clocks = 320 ns: neither
    st, a, b = await measure(dut, 0, SRC_CELL, ctrl=ARM | DUAL)
    assert st & ST_TMO_A and st & ST_TMO_B and a == 0 and b == 0
    await wr(dut, TMO, 12)                                   # widened again: the counts of P4 return
    st, a, b = await measure(dut, 0, SRC_CELL, ctrl=ARM | DUAL)
    assert st == (ST_ARMED | ST_DONE) and abs(a * CLK_NS - ta - 2 * CLK_NS) <= CLK_NS and abs(b * CLK_NS - tb - 2 * CLK_NS) <= CLK_NS
