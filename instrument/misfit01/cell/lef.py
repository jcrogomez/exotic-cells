#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Writes the abstract of misfit_inv for a given channel length. Usage: lef.py <LEN> <out.lef>"""
import sys
L = float(sys.argv[1]); gx1 = 1.13 + L; y0, y1 = gx1 + 0.28, gx1 + 0.45; t0, t1 = gx1 + 0.97 + 0.125, gx1 + 0.97 + 0.295
open(sys.argv[2], "w").write(f"""VERSION 5.7 ;
  NOWIREEXTENSIONATPIN ON ;
  DIVIDERCHAR "/" ;
  BUSBITCHARS "[]" ;
MACRO misfit_inv
  CLASS CORE ;
  FOREIGN misfit_inv ;
  ORIGIN 0.000 0.000 ;
  SIZE 3.680 BY 2.720 ;
  SYMMETRY X Y R90 ;
  SITE unithd ;
  PIN A
    DIRECTION INPUT ;
    USE SIGNAL ;
    PORT
      LAYER li1 ;
        RECT 0.145 1.035 0.475 1.275 ;
    END
  END A
  PIN Y
    DIRECTION OUTPUT ;
    USE SIGNAL ;
    PORT
      LAYER li1 ;
        RECT {y0:.3f} 0.310 {y1:.3f} 2.450 ;
    END
  END Y
  PIN VGND
    DIRECTION INOUT ;
    USE GROUND ;
    SHAPE ABUTMENT ;
    PORT
      LAYER met1 ;
        RECT 0.000 -0.240 3.680 0.240 ;
    END
  END VGND
  PIN VPWR
    DIRECTION INOUT ;
    USE POWER ;
    SHAPE ABUTMENT ;
    PORT
      LAYER met1 ;
        RECT 0.000 2.480 3.680 2.960 ;
    END
  END VPWR
  OBS
    LAYER li1 ;
      RECT 0.000 -0.085 3.680 0.085 ;
      RECT 0.000 2.635 3.680 2.805 ;
      RECT 0.680 0.085 0.850 0.810 ;
      RECT 0.680 1.520 0.850 2.635 ;
      RECT {t0:.3f} 0.085 {t1:.3f} 0.800 ;
      RECT {t0:.3f} 1.620 {t1:.3f} 2.635 ;
  END
END misfit_inv
END LIBRARY
""")
