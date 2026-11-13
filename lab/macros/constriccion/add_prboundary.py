# Añade la capa prBoundary (GDS 235/4) al contorno de la celda superior. LibreLane la exige para medir el macro.
# Uso (KLayout en lote): klayout -b -r add_prboundary.py -rd input=X.gds -rd output=Y.gds
import pya
ly = pya.Layout(); ly.read(input)
top = ly.top_cell()
li = ly.layer(235, 4)
top.shapes(li).insert(top.bbox())
ly.write(output)
print("prBoundary", top.name, top.bbox().to_s())
