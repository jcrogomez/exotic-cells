# Precheck map: which rule breaks the Tiny Tapeout precheck rejects, and which it lets through

Run on 2026-11-12 against the prediction in [`PREREG.md`](PREREG.md) (written first, no prior commit). `map.py` builds one loose
probe cell per kind of rule break and passes it through the DRC functions of the official precheck (`tt-support-tools` 01d5d28,
PDK `0536d02d`, Magic 8.3.568, KLayout 0.30.8): Magic `drc(full)` and the three passes of `sky130A_mr.drc`. Pin and boundary
checks are not run: a loose probe cannot meet them. Output: `out/map.txt`. Probes: `out/gds/`.

Run 1 (`out/map_run1_taps_sin_contacto.txt`) had flawed controls: a well tap without a contact does not count as a tap for
Magic. Fixed in run 2, which is the table below.

| Probe | Magic | KLayout | Verdict |
|---|---|---|---|
| Metal 1 neck at 0.14 (control) | 0 | 0 | passes |
| Metal 1 neck at 0.10, at 0.07, and 0.10 wide but only 0.14 long | met1.1 | MR_met1.WID.1 | rejected by both |
| Metal 1 facing ends at 0.14 (control) | 0 | 0 | passes |
| Metal 1 facing ends at 0.10 and at 0.05 | met1.2 | MR_met1.SP.1 | rejected by both |
| Local interconnect neck at 0.17 (control) | 0 | 0 | passes |
| Local interconnect neck at 0.10 | li.1, li.c1 | li.1 | rejected by both |
| p+ and n+ abutted in a well (control) | 0 | 0 | **passes** |
| p+ and n+ overlapping by 0.10 | nsd.5a, nsd.5b, psd.10b | nsdm_psdm_overlap | rejected by both |
| p+ and n+ 0.13 apart | 3 errors | difftap.3 | rejected by both |
| Well with a contacted tap (control) | 0 | 0 | passes |
| Well with no tap | LU.3, nwell.4 | 0 | rejected by Magic only |
| Transistor, small metal on the gate (control) | LU.2 | 0 | flawed control: no substrate tap nearby |
| Same transistor with a 60 x 60 um metal 1 plate on the gate | LU.2, same two errors | 0 | **the plate adds nothing: antenna is not checked** |
| Metal 1 plate with 0.14 um holes | met1.7 | MR_met1.AR.2 | rejected by both |
| Metal 1 plate with 0.40 um holes at a pitch of 1.0 | 0 | 0 | **passes** |

All six predictions held, apart from the two flawed controls.

What this means for the catalogue:

- Width and spacing breaks in metal are caught by both tools. The sub-minimum bridge and the facing ends at 0.05 um of
  [`litho_explore`](../litho_explore/README.md) cannot be submitted as drawn. What can be submitted are the legal shapes that
  print differently: the short legal neck, and facing ends at exactly 0.14.
- The abutted junction (XC-20) is submittable at zero separation; any overlap or intermediate gap is not.
- A deliberate antenna (XC-14) passes the precheck untouched.
- Hole arrays (XC-27) pass when each hole is at least 0.14 um2, which is also the pitch range where diffraction matters.
- A well without a tap (XC-42) is stopped by Magic alone.
