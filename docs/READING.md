# Reading list

Suggested by an external review on 2026-11-11. **None of these has been read by us yet.** They are listed as leads, with the
reason each was suggested, and no claim in this repository rests on them. An entry moves out of this list only when someone
has read the source and written down what it actually says.

| Source | Why it was suggested |
|---|---|
| Wang et al., 2009, "Modeling of layout-dependent stress effect in CMOS design" | Places Residual on an existing line of work on stress decomposition by geometry |
| Grasser et al., 2010, time-dependent defect spectroscopy (Phys. Rev. B) | Separating defects by capture and emission times and amplitudes |
| van der Wel et al., 2003, random telegraph signals under switched bias | The excitation changes the noise being measured: the reader is part of the experiment |
| Brown et al., 2020, random telegraph noise for random number generation | Experimental precedent, including multi-level signals |
| Zanotti et al., 2024, guidelines for RTN-based random number generators | Drift, dead time and reliability; a simulated design in 130 nm CMOS |
| Strachan et al., 2005, nanogaps by electromigration | Controlled formation with feedback. Already cited in our working notes for XC-04 |
| ngspice manual, `TRNOISE` | White, 1/f and telegraph noise sources in transient analysis. We used the white source in `experiments/xc19_noise` |
| NIST SP 800-90B | Entropy assessment and health tests, if XC-19 ever becomes an entropy source |

## Added on 2026-11-12 for the rebuilt catalogue

Recalled from memory, then checked by a search agent on the same day. **Exists** means the citation was confirmed; it does not
mean we have read it. "Abstract" means the agent opened the abstract or the record; everything else is a search snippet.
Priority entries (to be read first) are marked P.

| | Source | For | What the check found |
|---|---|---|---|
| P | Esaki, Phys. Rev. 109, 603 (1958), DOI 10.1103/PhysRev.109.603 | XC-20 | Exists |
| P | Kane, "Theory of tunneling", J. Appl. Phys. 32, 83 (1961), DOI 10.1063/1.1735965 | XC-20 | Exists |
| | Goto et al., IRE Trans. Electron. Comput. EC-9, 25 (1960), DOI 10.1109/TEC.1960.5221600 | XC-20, the bistable pair | Exists |
| P | An Esaki or backward diode measured in a standard bulk CMOS flow with source-drain implants | XC-20 | **Not found** in three searches. What exists uses epitaxy, delta doping or rapid thermal diffusion. Not finding it is not proof of absence |
| | Dutta et al., IEEE EDL 38(7), 898 (2017), DOI 10.1109/LED.2017.2701505 | XC-21, not XC-20 | It is about avalanche-mode silicon LEDs in 65 nm bulk CMOS, lateral p+-n-n+, breakdown varied from 2 to 9 V. Not a tunnel diode |
| P | Scheer et al., Nature 394, 154 (1998), DOI 10.1038/28112 | XC-05 | Exists (abstract). The figure of about three channels and 0.8 conductance quanta for aluminium was confirmed only in secondary sources |
| | Agraït, Levy Yeyati, van Ruitenbeek, Phys. Rep. 377, 81 (2003), arXiv cond-mat/0208239 | XC-05 | Exists (abstract) |
| | Strachan et al., APL 86, 043109 (2005), DOI 10.1063/1.1857095 | XC-05 | Exists. Already read in our working lab |
| P | Electromigration to an atomic contact with feedback integrated in CMOS, or in the aluminium of a CMOS chip | XC-05 | **Not found**: only gold, with external control |
| | Korhonen et al., J. Appl. Phys. 73, 3790 (1993) | XC-01, simulation S5 | Exists |
| P | Moxim et al., APL 120, 063502 (2022); Moxim et al., J. Appl. Phys. (2024), DOI 10.1063/5.0203331 | XC-52 | Near-zero-field magnetoresistance in Si/SiO2 transistors exists. Size of the effect in silicon at room temperature: `[?]`. Field scale: "a few mT" |
| | Cochrane and Lenahan, J. Appl. Phys. 112, 123714 (2012), DOI 10.1063/1.4770472 | XC-52 | About 1 % at zero field at room temperature, but in a **silicon carbide** diode, not silicon (abstract) |
| | Anders, Lenahan, Harmon, Flatté, J. Appl. Phys. (2020), DOI 10.1063/5.0027214 | XC-52 | Spin-dependent charge pumping near zero field; the results seen are in silicon carbide |
| | Groeseneken et al., IEEE TED 31, 42 (1984), DOI 10.1109/T-ED.1984.21472 | XC-19, charge pumping | Exists |
| | Demierre et al., Sens. Actuators A 97-98, 39 (2002) | XC-56, XC-25 | Integrated calibration coil over a Hall sensor: 0.392 mT per mA per coil |
| P | Bahr, Marathe, Weinstein, J. Microelectromech. Syst. 24, 1520 (2015) | XC-55 | Exists. Quality factor 252 near 2.8 GHz in that paper; above 13 000 at 3.185 GHz reported by the same group in 32 nm SOI |
| P | Leduc et al., APL 97, 102509 (2010), arXiv 1003.5584 | XC-54 | Critical temperature of titanium nitride between 0 and 5 K with composition (abstract) |
| | Gharib et al., arXiv 2609.35624 | XC-54 | Titanium nitride nanowires in the resistor layer of a commercial 22 nm process, measured between 0.15 and 1.19 K (abstract). Nothing found for local interconnect or barrier layers |
