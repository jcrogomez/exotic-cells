# Draft for upstream — not filed

Status 2026-11-17: **draft, not sent.** No commit, no issue, until Juan says so.

## What changed on 2026-11-17: whose gap is it?

The first version of this draft was addressed to Magic. That was wrong, or at least incomplete. Three separate things:

| | Finding | Grade | Evidence |
|---|---|---|---|
| Absence | The stock flow writes no `sa`/`sb`, with Magic 8.3.530 and with upstream 8.3.703 | run (8.3.530 from this folder; 8.3.703 built from source at commit `2c6d97b` in a scratch container, not scripted here) | `run.sh` → `result.txt` |
| Impact | The PDK model separates the two layouts by 31.09 mV | run | `lod_min.sp` → `result.txt` |
| Responsibility | **The tech file, not the extractor.** Magic already has a terminal-length parameter (`l1`, `l2`: terminal area / width). Adding `l1=sa l2=sb` to the `nfet_01v8` device line of a copy of the SKY130 tech file makes Magic 8.3.530 write `sa=0.3 sb=0.3` and `sa=3 sb=3` for the two reproducers | run | `run_techmod.sh` → `result_techmod.txt` |
| Limit of that fix | `l<n>` is area / width of the terminal, not the BSIM4 distance. Two series gates sharing a 0.50 um diffusion get 0.5 on the shared side; the BSIM4 definition gives 0.95 (0.50 + 0.15 + 0.30, our arithmetic). Irregular diffusion is approximated the same way. No `sd` | run + arithmetic | `two_finger.tcl` → `result_techmod.txt` |

Source lines read in Magic at `2c6d97b` (by an agent, not re-read by a second reader): `extract/ExtBasic.c:1885-1894`
("output length of terminal, assuming a rectangular shape, as simplified terminal area / width"),
`ext2spice/ext2spice.c:2376-2403`. No stress, LOD or well-proximity code was found by grep in `extract/`, `extflat/`,
`ext2spice/`. In open_pdks at `0c1f823`, `sky130/magic/sky130-extract.tech` has no `sa=`, `sb=`, `l1=` or `l2=`.

So the report belongs to **open_pdks** (tech file), with a smaller note for Magic (an exact LOD measure for shared and
irregular diffusion does not exist). Searches on 2026-11-17 in the Magic and `google/skywater-pdk` trackers for "LOD",
"sa sb", "stress", "well proximity": no hits. The open_pdks tracker could not be searched from the command line.
Not finding is not absence; mailing lists and Slack were not searched.

**Not tested, and needed before filing:**
- Whether netgen LVS accepts instances that carry `sa`/`sb`.
- Whether a tech file with the change breaks anything else (other devices, the standard-cell extraction, timing).
- Whether the foundry meant these parameters to be supplied. `saref` differs per model bin (1.04 to 3.0 um in the tt file),
  so the models are binned for it; that suggests intent but does not prove it.
- KLayout's LVS deck: no `sa`/`sb` text found; what its built-in MOS extractor can emit was not established.

---

## Draft text (for open_pdks)

**Title:** sky130: extracted MOSFETs carry no `sa`/`sb`, although the models use them; a tech-file line makes Magic emit them

**Question first.** Is leaving `sa`/`sb` out of the extracted netlists deliberate? If it is, a line in the documentation would
help, and this can be closed.

**What I see.** Two `sky130_fd_pr__nfet_01v8`, W/L = 0.42/0.15 um, identical except for the diffusion on each side of the
gate (0.30 um vs 3.0 um), both DRC clean (`drc(full)`), extract to:

```
X0 D G S B sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15
X0 D G S B sky130_fd_pr__nfet_01v8 ad=1.26 pd=6.84 as=1.26 ps=6.84 w=0.42 l=0.15
```

Same result with Magic 8.3.530 and 8.3.703.

**Why it might matter.** The ngspice models have the BSIM4 stress effect switched on. With `sa = sb` given by hand
(tt, 27 C, Vgs = 0.9 V, Vds = 0.05 V):

| Instance | Vth (V) | Linear Id relative to the short one |
|---|---|---|
| as extracted (no `sa`/`sb`) | 0.774446 | |
| `sa = sb = 0.30` | 0.797944 | 1 |
| `sa = sb = 3.0` | 0.766855 | 1.296 |

The model separates the two layouts by 31.09 mV; post-layout simulation treats both as the reference geometry.

**A possible fix, and its limit.** Appending `l1=sa l2=sb` to the device line

```
 device msubcircuit sky130_fd_pr__nfet_01v8 nfet,scnfet \
	*ndiff,ndiffres *ndiff,ndiffres pwell,space/w error \
	w>=0.42 l=l w=w a1=as p1=ps a2=ad p2=pd l1=sa l2=sb
```

gives `sa=0.3 sb=0.3` and `sa=3 sb=3` for the two cells above. But `l<n>` is terminal area over width: two series gates
sharing a 0.50 um diffusion get 0.5 on the shared side where BSIM4 would use 0.95, so multi-finger devices would be
systematically off. I have not tested LVS with the extra parameters, nor other devices.

**What I do not know.**
- Whether silicon follows this part of the model. This is about model and netlist only; nothing was measured.
- Whether the standard cells were characterised with or without these parameters.

**Reproduce.** Files and scripts: `github.com/jcrogomez/exotic-cells`, `experiments/lod_audit/upstream/`
(`run.sh`, `run_techmod.sh`; Docker image `hpretl/iic-osic-tools:2025.07`; PDK sky130A at open_pdks `8afc8346`;
ngspice 44.2).

**If useful.** The same repository has a script that measures the BSIM4 distances from the `.mag`/`.ext` and annotates
the netlist, including shared diffusion (`residual/lod_annotate.py`, with tests). Happy to adapt it, or to be told this is
already known.
