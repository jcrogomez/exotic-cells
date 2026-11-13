# LEF a mano: pines A y B separados (Magic los fusiona porque son el mismo nodo eléctrico).
import sys
for nombre in ["efld_cons_M1","efld_cons_M2","efld_cons_L1","efld_cons_L2"]:
    lef = f"""VERSION 5.7 ;
  NOWIREEXTENSIONATPIN ON ;
  DIVIDERCHAR "/" ;
  BUSBITCHARS "[]" ;
MACRO {nombre}
  CLASS BLOCK ;
  FOREIGN {nombre} ;
  ORIGIN 0.000 0.000 ;
  SIZE 12.400 BY 1.200 ;
  PIN A
    DIRECTION INOUT ;
    USE SIGNAL ;
    PORT
      LAYER met1 ;
        RECT 0.000 0.000 1.200 1.200 ;
    END
  END A
  PIN B
    DIRECTION INOUT ;
    USE SIGNAL ;
    PORT
      LAYER met1 ;
        RECT 11.200 0.000 12.400 1.200 ;
    END
  END B
  OBS
    LAYER met1 ;
      RECT 1.200 0.000 11.200 1.200 ;
    LAYER li1 ;
      RECT 0.000 0.000 12.400 1.200 ;
  END
END {nombre}
END LIBRARY
"""
    open(f"{nombre}.lef","w").write(lef)
print("lef escritos")
