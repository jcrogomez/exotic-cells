# Uso: klayout -b -r capas.py -rd input=X.gds  -> lista capas GDS con geometría
import pya
ly = pya.Layout(); ly.read(input)
out = []
for i in ly.layer_indexes():
    li = ly.get_info(i)
    if any(not c.shapes(i).is_empty() for c in ly.each_cell()):
        out.append((li.layer, li.datatype))
print(input, "capas:", sorted(out))
