# Uso: klayout -b -r cuenta_lyrdb.py -rd input=X.lyrdb -> cuenta ítems por regla
import pya, collections
db = pya.ReportDatabase("r"); db.load(input)
c = collections.Counter()
for it in db.each_item():
    c[db.category_by_id(it.category_id()).name()] += 1
print(input, "total:", sum(c.values()), dict(c))
