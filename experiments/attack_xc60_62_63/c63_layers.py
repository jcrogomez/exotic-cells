import sys, gdstk, collections
lib = gdstk.read_gds(sys.argv[1])
for c in lib.cells:
    if c.name == sys.argv[2]:
        f = c.copy("f"); f.flatten(); cnt = collections.Counter((p.layer, p.datatype) for p in f.polygons)
        print(c.name, sorted(cnt.items())); print("refs:", sorted({r.cell.name for r in c.references}))
