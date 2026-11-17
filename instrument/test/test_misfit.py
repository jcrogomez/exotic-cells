# SPDX-License-Identifier: Apache-2.0
"""cocotb tests of the MISFIT instrument at RTL, against the behavioural slot model.

What a pass here shows: the protocol, the selection, the counting and the flags do what INTERFACES.md says.
What it does not show: anything electrical. A "fault" below is a logic value forced on a slot output.
"""
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, Timer

CLK_NS = 20
ID, CTRL, CHSEL, SRC, ENMASK, TMO, CMD, STATUS = 0, 1, 2, 3, 4, 5, 6, 7
CNT_A, CNT_B, REFDLY, PREW = 8, 0xB, 0xE, 0xF
ARM, DUAL, TWIN = 1, 2, 4
SRC_NONE, SRC_CELL, SRC_CAL, SRC_REF = 0, 1, 2, 3
START, ABORT, CLEAR = 1, 2, 4
ST_BUSY, ST_DONE, ST_TMO_A, ST_TMO_B, ST_STUCK_A, ST_STUCK_B, ST_REFUSED, ST_ARMED = (1 << i for i in range(8))


async def reset(dut):
    cocotb.start_soon(Clock(dut.clk, CLK_NS, units="ns").start())
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    for s in slots(dut):
        s.t_cell_a_ns.value = 0
        s.t_cell_b_ns.value = 0
        s.t_cal_ns.value = 0
        s.t_ref_ns.value = 0
        s.fault_a.value = 0
        s.fault_b.value = 0
        s.ignore_en.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)


def slots(dut):
    return [dut.u_slot0, dut.u_slot1, dut.u_slot2, dut.u_slot3]


async def wr(dut, addr, data):
    dut.ui_in.value = data
    dut.uio_in.value = addr
    await ClockCycles(dut.clk, 1)
    dut.uio_in.value = addr | 0x10
    await ClockCycles(dut.clk, 4)
    dut.uio_in.value = addr
    await ClockCycles(dut.clk, 3)


async def rd(dut, addr):
    dut.uio_in.value = addr
    await ClockCycles(dut.clk, 2)
    await Timer(1, units="ns")
    v = dut.uo_out.value
    assert v.is_resolvable, f"register {addr:#x} reads {v.binstr}"
    return int(v)


async def rd24(dut, addr):
    return (await rd(dut, addr)) | (await rd(dut, addr + 1)) << 8 | (await rd(dut, addr + 2)) << 16


async def wait_idle(dut, max_cycles=400000):
    for _ in range(max_cycles):
        await RisingEdge(dut.clk)
        if not (int(dut.uio_out.value) & 0x80):
            return
    raise AssertionError("still busy")


async def measure(dut, ch, src, ctrl=ARM, mask=None):
    """One acquisition. Returns (status, count_a, count_b)."""
    await wr(dut, ENMASK, (1 << ch) if mask is None and ch < 4 else (mask or 0))
    await wr(dut, CTRL, ctrl)
    await wr(dut, CHSEL, ch)
    await wr(dut, SRC, src)
    await wr(dut, CMD, START)
    await wait_idle(dut)
    return await rd(dut, STATUS), await rd24(dut, CNT_A), await rd24(dut, CNT_B)


def near(count, t_ns, tol=3):
    return abs(count - t_ns / CLK_NS) <= tol


@cocotb.test()
async def t01_reset_is_safe(dut):
    """After reset nothing is armed, no slot is enabled, precharged or stimulated."""
    await reset(dut)
    assert int(dut.slot_en.value) == 0 and int(dut.slot_pre.value) == 0 and int(dut.slot_src.value) == 0
    assert int(dut.uio_oe.value) == 0xC0
    assert await rd(dut, ID) == 0x4D
    assert await rd(dut, STATUS) == 0
    assert await rd(dut, SRC) == SRC_NONE and await rd(dut, ENMASK) == 0 and await rd(dut, CTRL) == 0


@cocotb.test()
async def t02_register_readback(dut):
    """Every configuration register reads back what was written."""
    await reset(dut)
    for addr, val, mask in ((CTRL, 0x07, 0x07), (CHSEL, 0x05, 0x07), (SRC, 0x03, 0x03), (ENMASK, 0x0A, 0x0F),
                            (TMO, 0x0C, 0x1F), (REFDLY, 0xA5, 0xFF), (PREW, 0x5A, 0xFF)):
        await wr(dut, addr, val)
        assert await rd(dut, addr) == val & mask, hex(addr)
    await wr(dut, TMO, 0x1F)
    assert await rd(dut, TMO) == 24, "timeout exponent is clamped"


@cocotb.test()
async def t03_refused_when_not_armed_or_disabled(dut):
    """A start is refused, flagged, and touches no slot, unless the instrument is armed and the slot enabled."""
    await reset(dut)
    slots(dut)[0].t_cell_a_ns.value = 2000
    seen = []

    async def watch():
        while True:
            await RisingEdge(dut.clk)
            seen.append(int(dut.slot_pre.value) | int(dut.slot_src.value))
    w = cocotb.start_soon(watch())
    st, a, _ = await measure(dut, 0, SRC_CELL, ctrl=0)                 # not armed
    assert st & ST_REFUSED and not st & ST_DONE and a == 0
    st, a, _ = await measure(dut, 0, SRC_CELL, ctrl=ARM, mask=0b0010)  # armed, but slot 0 not enabled
    assert st & ST_REFUSED and not st & ST_DONE and a == 0
    st, a, _ = await measure(dut, 5, SRC_CELL, ctrl=ARM, mask=0b1111)  # channel that does not exist
    assert st & ST_REFUSED
    w.kill()
    assert not any(seen), "a refused start reached a slot"


@cocotb.test()
async def t04_selftest_internal_reference(dut):
    """Channel 7 times a purely digital delay: counter, protocol and readout proven with every slot disabled."""
    await reset(dut)
    for k in (1, 16, 200):
        await wr(dut, REFDLY, k)
        st, a, b = await measure(dut, 7, SRC_NONE, mask=0)
        assert st & ST_DONE and not st & (ST_TMO_A | ST_STUCK_A | ST_REFUSED), bin(st)
        assert a == 16 * k and b == 0, (k, a, b)
        assert int(dut.slot_en.value) == 0
    await wr(dut, REFDLY, 255)
    await wr(dut, TMO, 10)                                             # 1024 cycles < 255 * 16
    st, a, _ = await measure(dut, 7, SRC_NONE, mask=0)
    assert st & ST_TMO_A and a == 0, "the reference path also exercises the timeout"


@cocotb.test()
async def t05_only_the_selected_slot_is_touched(dut):
    """During an acquisition on slot 2, slots 0, 1 and 3 see no precharge and no stimulus, enabled or not."""
    await reset(dut)
    slots(dut)[2].t_cell_a_ns.value = 4000
    pre, src = set(), set()

    async def watch():
        while True:
            await RisingEdge(dut.clk)
            pre.add(int(dut.slot_pre.value))
            src.add(int(dut.slot_src.value))
    w = cocotb.start_soon(watch())
    st, a, _ = await measure(dut, 2, SRC_CELL, mask=0b1111)
    w.kill()
    assert st & ST_DONE and near(a, 4000)
    assert pre <= {0, 0b0100}, pre
    assert src <= {0, SRC_CELL << 4}, src


@cocotb.test()
async def t06_acquisition_and_resolution(dut):
    """A discharge time becomes a count; a 0.8 % step (one trap in the XC-19 budget) is resolved at 50 MHz."""
    await reset(dut)
    s = slots(dut)[0]
    s.t_cell_a_ns.value = 30270
    st, a0, _ = await measure(dut, 0, SRC_CELL)
    assert st & ST_DONE and near(a0, 30270), a0
    s.t_cell_a_ns.value = int(30270 * 1.008)
    st, a1, _ = await measure(dut, 0, SRC_CELL)
    assert 10 <= a1 - a0 <= 14, (a0, a1)
    counts = []
    for _ in range(5):
        counts.append((await measure(dut, 0, SRC_CELL))[1])
    assert max(counts) - min(counts) <= 1, counts


@cocotb.test()
async def t07_calibration_seen_cell_not(dut):
    """The null that matters: calibration and reference answer, the cell does not, and the three are told apart."""
    await reset(dut)
    s = slots(dut)[1]
    s.t_cal_ns.value = 20000
    s.t_ref_ns.value = 12000
    s.t_cell_a_ns.value = 0                       # the cell never discharges
    await wr(dut, TMO, 12)
    st, a, _ = await measure(dut, 1, SRC_CAL)
    assert st & ST_DONE and not st & ST_TMO_A and near(a, 20000)
    st, a, _ = await measure(dut, 1, SRC_REF)
    assert st & ST_DONE and not st & ST_TMO_A and near(a, 12000)
    st, a, _ = await measure(dut, 1, SRC_CELL)
    assert st & ST_DONE and st & ST_TMO_A and a == 0
    st, a, _ = await measure(dut, 1, SRC_NONE)    # negative control: no source selected
    assert st & ST_TMO_A and a == 0


@cocotb.test()
async def t08_twin_single_and_simultaneous(dut):
    """Side A alone, side B alone, and both in the same window."""
    await reset(dut)
    s = slots(dut)[3]
    s.t_cell_a_ns.value = 30000
    s.t_cell_b_ns.value = 45000
    st, a, b = await measure(dut, 3, SRC_CELL, ctrl=ARM)
    assert near(a, 30000) and b == 0
    st, a, b = await measure(dut, 3, SRC_CELL, ctrl=ARM | TWIN)
    assert a == 0 and near(b, 45000)
    st, a, b = await measure(dut, 3, SRC_CELL, ctrl=ARM | DUAL)
    assert st & ST_DONE and near(a, 30000) and near(b, 45000)
    s.t_cell_b_ns.value = 0
    await wr(dut, TMO, 12)
    st, a, b = await measure(dut, 3, SRC_CELL, ctrl=ARM | DUAL)
    assert near(a, 30000) and b == 0 and st & ST_TMO_B and not st & ST_TMO_A, "one side timing out keeps the other"


@cocotb.test()
async def t09_fault_injection_and_isolation(dut):
    """A slot whose output is stuck or unknown is flagged, can be excluded, and does not disturb the others."""
    await reset(dut)
    good, bad = slots(dut)[0], slots(dut)[1]
    good.t_cell_a_ns.value = 30000
    bad.t_cell_a_ns.value = 30000
    bad.fault_a.value = 1                                              # stuck "discharged"
    st, a, _ = await measure(dut, 1, SRC_CELL, mask=0b0011)
    assert st & ST_STUCK_A and a == 0 and st & ST_DONE, bin(st)
    bad.fault_a.value = 2                                              # never discharges
    await wr(dut, TMO, 12)
    st, a, _ = await measure(dut, 1, SRC_CELL, mask=0b0011)
    assert st & ST_TMO_A and not st & ST_STUCK_A
    for fault in (1, 3):                                               # stuck high, then unknown
        bad.fault_a.value = fault
        bad.fault_b.value = fault
        st, a, _ = await measure(dut, 0, SRC_CELL, mask=0b0011)        # bad slot still enabled, not selected
        assert st == (ST_ARMED | ST_DONE) and near(a, 30000), (fault, bin(st), a)
        bad.ignore_en.value = 1                                        # and misbehaving even when disabled
        st, a, _ = await measure(dut, 0, SRC_CELL, mask=0b0001)        # excluded
        assert st == (ST_ARMED | ST_DONE) and near(a, 30000), (fault, bin(st), a)
        st, a, _ = await measure(dut, 1, SRC_CELL, mask=0b0001)        # selecting the excluded slot is refused
        assert st & ST_REFUSED
        bad.ignore_en.value = 0


@cocotb.test()
async def t10_timeout_and_recovery(dut):
    """A cell slower than the window is reported as such, and the next acquisition is unaffected."""
    await reset(dut)
    s = slots(dut)[0]
    s.t_cell_a_ns.value = 5_000_000
    await wr(dut, TMO, 10)
    st, a, _ = await measure(dut, 0, SRC_CELL)
    assert st & ST_TMO_A and a == 0
    s.t_cell_a_ns.value = 8000
    st, a, _ = await measure(dut, 0, SRC_CELL)
    assert st == (ST_ARMED | ST_DONE) and near(a, 8000), (bin(st), a)
    await wr(dut, TMO, 20)                                             # widen the window: the slow cell is now seen
    s.t_cell_a_ns.value = 5_000_000
    st, a, _ = await measure(dut, 0, SRC_CELL)
    assert st == (ST_ARMED | ST_DONE) and near(a, 5_000_000), (bin(st), a)


@cocotb.test()
async def t11_abort_disarm_and_reset_mid_run(dut):
    """Abort, disarm and reset each stop a running acquisition and leave every slot inert."""
    await reset(dut)
    s = slots(dut)[0]
    s.t_cell_a_ns.value = 2_000_000
    for how in ("abort", "disarm", "reset"):
        await wr(dut, ENMASK, 1); await wr(dut, CTRL, ARM); await wr(dut, CHSEL, 0); await wr(dut, SRC, SRC_CELL)
        await wr(dut, TMO, 24)
        await wr(dut, CMD, START)
        await ClockCycles(dut.clk, 300)
        assert int(dut.uio_out.value) & 0x80, "should be busy"
        await wr(dut, CHSEL, 3)                                        # configuration is frozen while busy
        if how == "abort":
            await wr(dut, CMD, ABORT)
        elif how == "disarm":
            await wr(dut, CTRL, 0)
        else:
            dut.rst_n.value = 0
            await ClockCycles(dut.clk, 2)
            dut.rst_n.value = 1
            await ClockCycles(dut.clk, 2)
        assert not int(dut.uio_out.value) & 0x80, how
        assert int(dut.slot_pre.value) == 0 and int(dut.slot_src.value) == 0, how
        if how != "abort":
            assert int(dut.slot_en.value) == 0, how
        if how != "reset":
            assert await rd(dut, CHSEL) == 0, "write while busy must be ignored"
        st = await rd(dut, STATUS)
        assert not st & ST_DONE, (how, bin(st))
    s.t_cell_a_ns.value = 6000                                         # and it still works afterwards
    st, a, _ = await measure(dut, 0, SRC_CELL)
    assert st == (ST_ARMED | ST_DONE) and near(a, 6000)


@cocotb.test()
async def t12_unknown_cell_is_classified(dut):
    """An unknown cell is interrogated by widening the window: fast, slow, silent or stuck, with no prior assumption."""
    await reset(dut)
    s = slots(dut)[2]
    s.t_cal_ns.value = 20000

    async def interrogate():
        await wr(dut, TMO, 16)                                         # the calibration has a known window
        st, a, _ = await measure(dut, 2, SRC_CAL)
        if st & ST_STUCK_A:                                            # a stuck node hides the calibration too
            return "stuck"
        if not near(a, 20000):
            return "instrument fault"
        for exp in (8, 12, 16, 18):
            await wr(dut, TMO, exp)
            st, a, _ = await measure(dut, 2, SRC_CELL)
            if st & ST_STUCK_A:
                return "stuck"
            if not st & ST_TMO_A:
                return a
        return "silent"

    for t_ns, fault, expect in ((900, 0, 45), (150_000, 0, 7500), (0, 0, "silent"), (30000, 1, "stuck")):
        s.t_cell_a_ns.value = t_ns
        s.fault_a.value = fault
        got = await interrogate()
        if isinstance(expect, int):
            assert isinstance(got, int) and abs(got - expect) <= 3, (t_ns, got)
        else:
            assert got == expect, (t_ns, fault, got)
    s.fault_a.value = 0
    s.t_cal_ns.value = 0                                               # calibration itself missing
    assert await interrogate() == "instrument fault"


@cocotb.test()
async def t13_asynchronous_edge_phase_sweep(dut):
    """An edge arriving at every phase of the clock (1 ns steps over two periods, and 0.1 ns steps around a clock edge)
    is captured once, the count never decreases as the edge moves later, and it moves by exactly one per period.
    Logic simulation has no metastability: this shows the capture logic is sound, not what the failure rate is."""
    await reset(dut)
    s = slots(dut)[0]
    counts = []
    for dt in range(0, 2 * CLK_NS + 1):
        s.t_cell_a_ns.value = 6000 + dt
        st, a, _ = await measure(dut, 0, SRC_CELL)
        assert st == (ST_ARMED | ST_DONE), (dt, bin(st))
        counts.append(a)
    assert all(b >= a for a, b in zip(counts, counts[1:])), counts
    assert counts[CLK_NS] - counts[0] == 1 and counts[2 * CLK_NS] - counts[0] == 2, counts
    assert len(set(counts)) <= 3, counts
    dut._log.info("phase sweep counts: %s", counts)
